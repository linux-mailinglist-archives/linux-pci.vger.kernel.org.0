Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CA43AA63B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhFPVk1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 17:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234103AbhFPVk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 17:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D95F61375;
        Wed, 16 Jun 2021 21:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623879500;
        bh=evMqzR616GLnLsr8P8GpWdjtSWVoLRvCdUm2WZJD54s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tto7/p8ZlymavxK1rh5PP6PYqvb93c9TrLcsAhblFetn3rI0lf3L/pNSVRWfo+0et
         IzTUX/3YlXJJ/9ATwFkoUVTcqU7gCKj3s5B7zTQHWOYVYEEt6PB+mtX1Lkj6cp4WwX
         mh3hNlifq9BbZYJTvXAjMmQ2ZWoEHf7N8YcBws2W0ovozVJ8OO1sJZrP6NP2PZWsoM
         n4gH+rESnL4avuhAnE27AXqmMqNz22QOT56E7nl/7McVTwzXqQAyDGAsHV0qrUtgkl
         XGzijCKPLnBSRxI7K15Tp1ECKajqnHGtj6KTRg5ITRDr94YGSq6O0tyMDc1KOw0bWZ
         tAig0/S3bXWoA==
Date:   Wed, 16 Jun 2021 16:38:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        vtolkm@gmail.com, Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Disallow retraining link for Atheros chips on
 non-Gen1 PCIe bridges
Message-ID: <20210616213819.GA3007589@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602190302.d3ibdtwti4yq57vi@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 09:03:02PM +0200, Pali Rohár wrote:
> On Wednesday 02 June 2021 10:55:59 Bjorn Helgaas wrote:
> > On Wed, Jun 02, 2021 at 02:08:16PM +0200, Pali Rohár wrote:
> > > On Tuesday 01 June 2021 19:00:36 Bjorn Helgaas wrote:
> > 
> > > > I wonder if this could be restructured as a generic quirk in quirks.c
> > > > that simply set the bridge's TLS to 2.5 GT/s during enumeration.  Or
> > > > would the retrain fail even in that case?
> > > 
> > > If I understand it correctly then PCIe link is already up when kernel
> > > starts enumeration. So setting Bridge TLS to 2.5 GT/s does not change
> > > anything here.
> > > 
> > > Moreover it would have side effect that cards which are already set to
> > > 5+ GT/s would be downgraded to 2.5 GT/s during enumeration and for
> > > increasing speed would be needed another round of "enumeration" to set a
> > > new TLS and retrain link again. As TLS affects link only after link goes
> > > into Recovery state.
> > > 
> > > So this would just complicate card enumeration and settings.
> > 
> > The current quirk complicates the ASPM code.  I'm hoping that if we
> > set the bridge's Target Link Speed during enumeration, the link
> > retrain will "just work" without complicating the ASPM code.
> > 
> > An enumeration quirk wouldn't have to set the bridge's TLS to 2.5
> > GT/s; the quirk would be attached to specific endpoint devices and
> > could set the bridge's TLS to whatever the endpoint supports.
> 
> Now I see what you mean. Yes, I agree this is a good idea and can
> simplify code. Quirk is not related to ASPM code and basically has
> nothing with it, just I put it into aspm.c because this is the only
> place where link retraining was activated.
> 
> But with this proposal there is one issue. Some kernel drivers already
> overwrite PCI_EXP_LNKCTL2_TLS value. So if PCI enumeration code set some
> value into PCI_EXP_LNKCTL2_TLS bits then drivers can change it and once
> ASPM will try to retrain link this may cause this issue.

I guess you mean the amdgpu, radeon, and hfi1 drivers.  They really
shouldn't be mucking with that stuff anyway.  But they do and are
unlikely to change because we don't have any good alternative.

One way around that would be to add some quirk code to
pcie_capability_write_word().  Ugly, but we do have something sort of
similar in pcie_capability_read_word() already.

Bjorn
