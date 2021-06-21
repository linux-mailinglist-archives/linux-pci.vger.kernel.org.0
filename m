Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA913AEB40
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 16:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUObN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 10:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUObM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 10:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF96600D4;
        Mon, 21 Jun 2021 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624285738;
        bh=Bbqc+TpZHyvo5eaZlnbMGe+NjFZlVQoc3pVkAaPrOO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6Mq0IONHEkDDn82qccbMSxzc96a77FYOeO+ZzpOvLxWbEPNuSLZzpvkzlBOq4NdK
         asyMqA7H3JJULrtSs2UFBHtPke+rFO+qEKkjG8EpyjEk76/iuNxNMCkz+6kMBuX1hE
         9glIpeRtrwE20uQuMFoE/7vcdigH1v1e5/no0M7ralZmz0LYUkrxgP1GeQpDzzhXfi
         s2kdMkONZNlSlw4TvOCau86V5tzgCr+K0oK97zOJ8Ttnxl/gEP5jMyEe2bhP22lMUg
         QyfYyMxuugZDVGz/RLzST0tsvDDukP56RN/PrfBBsLbtW3HTJWUvRKfNgX8Q9pFKSF
         2DTHWRrCNGoVw==
Received: by pali.im (Postfix)
        id 626A471B; Mon, 21 Jun 2021 16:28:55 +0200 (CEST)
Date:   Mon, 21 Jun 2021 16:28:55 +0200
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
Message-ID: <20210621142855.gnqtj3ofovx7xryr@pali>
References: <20210602190302.d3ibdtwti4yq57vi@pali>
 <20210616213819.GA3007589@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210616213819.GA3007589@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 16 June 2021 16:38:19 Bjorn Helgaas wrote:
> On Wed, Jun 02, 2021 at 09:03:02PM +0200, Pali Rohár wrote:
> > On Wednesday 02 June 2021 10:55:59 Bjorn Helgaas wrote:
> > > On Wed, Jun 02, 2021 at 02:08:16PM +0200, Pali Rohár wrote:
> > > > On Tuesday 01 June 2021 19:00:36 Bjorn Helgaas wrote:
> > > 
> > > > > I wonder if this could be restructured as a generic quirk in quirks.c
> > > > > that simply set the bridge's TLS to 2.5 GT/s during enumeration.  Or
> > > > > would the retrain fail even in that case?
> > > > 
> > > > If I understand it correctly then PCIe link is already up when kernel
> > > > starts enumeration. So setting Bridge TLS to 2.5 GT/s does not change
> > > > anything here.
> > > > 
> > > > Moreover it would have side effect that cards which are already set to
> > > > 5+ GT/s would be downgraded to 2.5 GT/s during enumeration and for
> > > > increasing speed would be needed another round of "enumeration" to set a
> > > > new TLS and retrain link again. As TLS affects link only after link goes
> > > > into Recovery state.
> > > > 
> > > > So this would just complicate card enumeration and settings.
> > > 
> > > The current quirk complicates the ASPM code.  I'm hoping that if we
> > > set the bridge's Target Link Speed during enumeration, the link
> > > retrain will "just work" without complicating the ASPM code.
> > > 
> > > An enumeration quirk wouldn't have to set the bridge's TLS to 2.5
> > > GT/s; the quirk would be attached to specific endpoint devices and
> > > could set the bridge's TLS to whatever the endpoint supports.
> > 
> > Now I see what you mean. Yes, I agree this is a good idea and can
> > simplify code. Quirk is not related to ASPM code and basically has
> > nothing with it, just I put it into aspm.c because this is the only
> > place where link retraining was activated.
> > 
> > But with this proposal there is one issue. Some kernel drivers already
> > overwrite PCI_EXP_LNKCTL2_TLS value. So if PCI enumeration code set some
> > value into PCI_EXP_LNKCTL2_TLS bits then drivers can change it and once
> > ASPM will try to retrain link this may cause this issue.
> 
> I guess you mean the amdgpu, radeon, and hfi1 drivers.  They really
> shouldn't be mucking with that stuff anyway.  But they do and are
> unlikely to change because we don't have any good alternative.

Yea, these are examples of such drivers... Maybe it is a good idea to
ask those people why changing PCI_EXP_LNKCTL2_TLS is needed. As these
drivers are often derived from codebase of shared multisystem drivers or
from common documentation, it is possible that original source has this
code as a workaround or common pattern used in other operating systems,
not related to linux...

> One way around that would be to add some quirk code to
> pcie_capability_write_word().  Ugly, but we do have something sort of
> similar in pcie_capability_read_word() already.

Bjorn, do you really want such ugly hack in pcie_capability_write_word?
It is common code used and called from lot of places so it may affect
whole system if in future somebody changes it again...

Or we can let it as is, say that those drivers which are doing it are
buggy and for future try to reduce code which touches registers
PCI_EXP_LNKCTL2_TLS. Good code review or some checkpatch.pl warnings may
prevent introduction of other code which will do it.

> 
> Bjorn
