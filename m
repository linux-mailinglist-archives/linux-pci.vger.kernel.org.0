Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1596986B5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 22:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBOVA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 16:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBOVAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 16:00:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB73D0A1;
        Wed, 15 Feb 2023 12:57:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 325C1B823B0;
        Wed, 15 Feb 2023 20:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC14FC433EF;
        Wed, 15 Feb 2023 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676494647;
        bh=L7iL02aPlYxbwnt1oXsjVxdLXXr3uFE8b+MsguWRWfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NFwJFk8a2PU4AbCXca0VIbTRRKa6Kq3ZwDubDgOFTLh9mxLpU8Ct0EfmjeWLca8x6
         obnGL5bIaMYp1+zQ/DfoFm1SGK4aNBuwkuYD8x0TPP3n5aWZQKFtioUceb5H1XUlk/
         jgkyTy6OgNlv/XUEj9PVpPW99QpgB7Arlw4HlFEGLZwrfDjhT3ZGZ/m6RBr5A92KfI
         Ek21aBhMrHRKJOzJQ2T2N4znNHEWXzFrCQr+HgpxLRsmAZxAhSa7dnG7thY6KeQ3OK
         kUXGVh9G6wq4ufrmPmGaYFqt8DFWbTKYwxyMHZVl6Cqe4Ce8v8STY0Wqvq4+XGlHfU
         tESLFGGLRIOZg==
Date:   Wed, 15 Feb 2023 14:57:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jean-philippe@linaro.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <20230215205726.GA3213227@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+ksmNWJdWNkGAU9@unreal>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Will, Robin, Joerg for arm-smmu-v3 page size question]

On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> > As per PCIe specification(section 10.5), If a VF implements an
> > ATS capability, its associated PF must implement an ATS capability.
> > The ATS Capabilities in VFs and their associated PFs are permitted to
> > be enabled independently.
> > Also, it states that the Smallest Translation Unit (STU) for VFs must be
> > hardwired to Zero and the associated PF's value applies to VFs STU.
> > 
> > The current code allows to enable ATS on VFs only if it is already
> > enabled on associated PF, which is not necessary as per the specification.
> > 
> > It is only required to have valid STU programmed on PF to enable
> > ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> > when PFs ATS is not enabled.
>
> Can you please add here quotes from the spec and its version? I don't see
> anything like this in my version of PCIe specification.

See PCIe r6.0, sec 10.5.1.

> > Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> > ---
> >  drivers/pci/ats.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index f9cc2e10b676..a97ec67201d1 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -67,13 +67,20 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
> >  	if (ps < PCI_ATS_MIN_STU)
> >  		return -EINVAL;
> >  
> > -	/*
> > -	 * Note that enabling ATS on a VF fails unless it's already enabled
> > -	 * with the same STU on the PF.
> > -	 */
> >  	ctrl = PCI_ATS_CTRL_ENABLE;
> >  	if (dev->is_virtfn) {
> >  		pdev = pci_physfn(dev);
> > +
> > +		if (!pdev->ats_enabled &&
> > +				(pdev->ats_stu < PCI_ATS_MIN_STU)) {
> > +			u16 ctrl2;
> > +
> > +			/* Associated PF's STU value applies to VFs. */
> > +			pdev->ats_stu = ps;
> > +			ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - PCI_ATS_MIN_STU);
> > +			pci_write_config_word(pdev, pdev->ats_cap + PCI_ATS_CTRL, ctrl2);
> > +		}

For reference, it is this way because of edc90fee916b ("PCI: Allocate
ATS struct during enumeration").  The rationale was that since the PF
STU applies to all VFs, we should require that the PF STU be
programmed before enabling ATS on any of the VFs.

This patch relaxes that so the PF STU would be set either by (a)
enabling ATS on the PF or (b) enabling ATS on the first VF.

This looks racy because theoretically drivers for VF A and VF B could
independently call pci_enable_ats() with different IOMMU page sizes,
and we don't know which will get there first.

Most callers supply a compile-time constant (PAGE_SHIFT or
VTD_PAGE_SHIFT), so it won't matter.  arm_smmu_enable_ats() is
fancier, but I *assume* it would still supply the same IOMMU page size
for all VFs of a given PF.

But it's still kind of ugly to call pci_enable_ats(dev_A) and have it
muck with the configuration of dev_B.  Maybe we should configure the
PF STU (without enabling ATS) at enumeration-time in pci_ats_init()?
Is there some way to get the IOMMU page size at that time?

> >  		if (pdev->ats_stu != ps)
> >  			return -EINVAL;
> >  	} else {
> > -- 
> > 2.39.1
> > 
