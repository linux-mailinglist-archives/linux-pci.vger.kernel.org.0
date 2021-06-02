Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8339931C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFBTEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 15:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhFBTEs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Jun 2021 15:04:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06146613DE;
        Wed,  2 Jun 2021 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622660585;
        bh=UmpCat1vUqyqVee399R6xx/T2Sz4LjLr8R8Go7S3p1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IslsaRMEZqqFu3ZzSgqNdLrDRXTjEsWWBTdbepFtuZAlmqCW7jni6jsPwMosOCRva
         hVL4+t36l+lWWC9rTXUuGHZZNChuQuVPwsgAcgarySIPQWhv3ySLboMSW6JMAf2YId
         ToOOtiPdJHHzvzYjHqjjfZEO2eYA4AX3Aljp7kAmGXZVA7L2lL6g56NGyyXCmMhVl1
         sQBuEtFrWqF1K+sFvakhAFEVFj0EMbQqcXRB118BwCBgCvQ2560yN11nj7Z+69id6J
         JER6VIjNBqPeimx5Ez/tElO4wGeBBVyTueFWmNTpZMfSZeX2/qtGWJoWzcr8IJn95m
         meDf8kBhp6UbA==
Received: by pali.im (Postfix)
        id 81EBA1534; Wed,  2 Jun 2021 21:03:02 +0200 (CEST)
Date:   Wed, 2 Jun 2021 21:03:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210602190302.d3ibdtwti4yq57vi@pali>
References: <20210602120816.axi4dtnyg5gl2h2z@pali>
 <20210602155559.GA2028037@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602155559.GA2028037@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 02 June 2021 10:55:59 Bjorn Helgaas wrote:
> On Wed, Jun 02, 2021 at 02:08:16PM +0200, Pali Rohár wrote:
> > On Tuesday 01 June 2021 19:00:36 Bjorn Helgaas wrote:
> 
> > > I wonder if this could be restructured as a generic quirk in quirks.c
> > > that simply set the bridge's TLS to 2.5 GT/s during enumeration.  Or
> > > would the retrain fail even in that case?
> > 
> > If I understand it correctly then PCIe link is already up when kernel
> > starts enumeration. So setting Bridge TLS to 2.5 GT/s does not change
> > anything here.
> > 
> > Moreover it would have side effect that cards which are already set to
> > 5+ GT/s would be downgraded to 2.5 GT/s during enumeration and for
> > increasing speed would be needed another round of "enumeration" to set a
> > new TLS and retrain link again. As TLS affects link only after link goes
> > into Recovery state.
> > 
> > So this would just complicate card enumeration and settings.
> 
> The current quirk complicates the ASPM code.  I'm hoping that if we
> set the bridge's Target Link Speed during enumeration, the link
> retrain will "just work" without complicating the ASPM code.
> 
> An enumeration quirk wouldn't have to set the bridge's TLS to 2.5
> GT/s; the quirk would be attached to specific endpoint devices and
> could set the bridge's TLS to whatever the endpoint supports.

Now I see what you mean. Yes, I agree this is a good idea and can
simplify code. Quirk is not related to ASPM code and basically has
nothing with it, just I put it into aspm.c because this is the only
place where link retraining was activated.

But with this proposal there is one issue. Some kernel drivers already
overwrite PCI_EXP_LNKCTL2_TLS value. So if PCI enumeration code set some
value into PCI_EXP_LNKCTL2_TLS bits then drivers can change it and once
ASPM will try to retrain link this may cause this issue.

> > Moreover here we are dealing with specific OTP/EEPROM bug in Atheros
> > chips, which was confirmed that exists. As I wrote in previous email, I
> > was told that semi-official workaround is do Warm Reset or Cold Reset
> > with turning power off from card. Which on most platforms / boards is
> > not possible.
> 
> If there's a specific bug with a real root-cause analysis, please cite
> it.  The threads mentioned in the current commit log are basically
> informed speculation.

I had (private) discussion with Adrian Chadd about ABCD device id issue.
I hope that nobody is against if I put there summary and important parts
about secondary bus reset (=hot reset):


The reason for abcd is because:
* the MAC has hardware that upon cold reset, will read EEPROM/OTP
  values for things like PCIe and other register defaults, and squirt
  them into the MAC/PHY/etc registers
* the default values for the PCIe bus pre-AR9300 were 0x168c:0xff<id>,
  where <id> is the normal chip ID
* the default values for the PCIe bus POST-AR9300 were 0x168c:0xabcd,
  where they're always that regardless of the chip family
* so yeah, all you know with 0x168c:0xabcd is there's an atheros
  device there, but not WHICH it is.

* the bug is that the reset line isn't held low for long enough, or it's
  bounced twice in quick succession, before the MAC has time to program
  in the defaults from EEPROM/OTP and it doesn't do it a second time.

* the MAC has hardware that upon cold reset, will read EEPROM/OTP
  values for things like PCIe and other register defaults, and squirt
  them into the MAC/PHY/etc registers

* need to use the external reset line OR try using D3, not D3hot
  (I assume that "external reset line" means PERST# - PCIe Warm Reset
  and "D3, not D3hot" means D3cold)


And now my experiments: Disabling and Enabling link via root bridge has
exactly same syndromes as hot reset on all tested cards. See that
different chips (pre-AR9300 and post-AR9300) have slightly different
behavior and it matches all my experiments (I wrote test details in
commit message). And doing link retrain when root bridge has non-2.5GT/s
value in PCI_EXP_LNKCTL2_TLS has also same effect as hot reset.
So based on same results from my experiments all these actions
(disabling link, hot reset and link retrain) have common issue.
