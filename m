Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1126992DF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 12:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjBPLMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 06:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBPLM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 06:12:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84656EFC
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:12:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n36so563808wmr.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 03:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=om86lkZfJsY4anvwokkpK35xQ29f8CqUJvo8NLWwWIc=;
        b=b7Di8OKegz1NYy+ugYqHyN5vi1A78FcTbBM2sZ11SQcIHppc3NYDsu2TCY0dOc+n6f
         7So+jsquf5asNx1ZUb5BiiEjHkduo0Kswx5zVG9Y2yz8He9MzEf5tAAP+au/s6F+OWzV
         WEgoO90M5DAQ6ta0zxMQIcZKU+JhfYuyzhF3DAZvhKaMFFZMPdQtv8s3q8ud3i/mFCQX
         2iKXFQ5VjeyRTFX1qZ8C1KQC/aB6FrxB2ghYOJB6y1y5RWDWefMiMi+gThQv17foHDBr
         p6RxHAenlih3jV///aQ+ojoFKixPfvcd6JFiCuEdqXCUeVbT304GtKP0HPQd3usA5mXT
         TG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om86lkZfJsY4anvwokkpK35xQ29f8CqUJvo8NLWwWIc=;
        b=tx2ipBc9eYeMZld3cR/+yWgrkqaaZWo0emcjHBvnwQnFJem2PRLFUWsCyNG3JTyI7K
         6yhjhkZgYUGFxmst+BUYLSGhYhnudZKQ+H1EYgIQQnhdB/pG/UYnUREAHJWwRakeAByA
         7zaN2vJNAUqjXfl/I+07yVutKZJYM1z4eZQ3OEksBaDd6Yk99D/pUVJHnYMZNuunf/J5
         TIwwU2dCNIU4ciwI09xdmIk0C0B3tSurTJ/bDfjB+yjIxTpUZGB2ck7iiPvZDcigsufh
         z4M+of4/Lv2y2ZPN0UWYdHmwGWX73CzpEiHgjOXTOq0Z5BX50ujEqaaE9vXz1LhLWpwm
         bjXQ==
X-Gm-Message-State: AO0yUKULlY6gwRcwgh5bKjgLsU3bN94izG5S//FEy5KUZSLmHvFN1+lt
        B4ihfVxv6Uan2p7oAjHpTWZ4OA==
X-Google-Smtp-Source: AK7set/uPweYVu6MAtPL+QX+e4WnluRTA8Ib+OTCn3hxd/IgE0ct5FP6T04lRolBRQ2LyvEUj7LOTg==
X-Received: by 2002:a05:600c:746:b0:3de:d52:2cd2 with SMTP id j6-20020a05600c074600b003de0d522cd2mr4376053wmn.4.1676545946170;
        Thu, 16 Feb 2023 03:12:26 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003dc4aae4739sm4841874wmc.27.2023.02.16.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 03:12:25 -0800 (PST)
Date:   Thu, 16 Feb 2023 11:12:24 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y+4PmJb2rBGMhS1y@myrica>
References: <Y+ksmNWJdWNkGAU9@unreal>
 <20230215205726.GA3213227@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215205726.GA3213227@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
> [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
> 
> On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
> > > As per PCIe specification(section 10.5), If a VF implements an
> > > ATS capability, its associated PF must implement an ATS capability.
> > > The ATS Capabilities in VFs and their associated PFs are permitted to
> > > be enabled independently.
> > > Also, it states that the Smallest Translation Unit (STU) for VFs must be
> > > hardwired to Zero and the associated PF's value applies to VFs STU.
> > > 
> > > The current code allows to enable ATS on VFs only if it is already
> > > enabled on associated PF, which is not necessary as per the specification.
> > > 
> > > It is only required to have valid STU programmed on PF to enable
> > > ATS on VFs. Adding code to write the first VFs STU to a PF's STU
> > > when PFs ATS is not enabled.
> >
> > Can you please add here quotes from the spec and its version? I don't see
> > anything like this in my version of PCIe specification.
> 
> See PCIe r6.0, sec 10.5.1.
> 
> > > Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> > > ---
> > >  drivers/pci/ats.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > > index f9cc2e10b676..a97ec67201d1 100644
> > > --- a/drivers/pci/ats.c
> > > +++ b/drivers/pci/ats.c
> > > @@ -67,13 +67,20 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
> > >  	if (ps < PCI_ATS_MIN_STU)
> > >  		return -EINVAL;
> > >  
> > > -	/*
> > > -	 * Note that enabling ATS on a VF fails unless it's already enabled
> > > -	 * with the same STU on the PF.
> > > -	 */
> > >  	ctrl = PCI_ATS_CTRL_ENABLE;
> > >  	if (dev->is_virtfn) {
> > >  		pdev = pci_physfn(dev);
> > > +
> > > +		if (!pdev->ats_enabled &&
> > > +				(pdev->ats_stu < PCI_ATS_MIN_STU)) {
> > > +			u16 ctrl2;
> > > +
> > > +			/* Associated PF's STU value applies to VFs. */
> > > +			pdev->ats_stu = ps;
> > > +			ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - PCI_ATS_MIN_STU);
> > > +			pci_write_config_word(pdev, pdev->ats_cap + PCI_ATS_CTRL, ctrl2);
> > > +		}
> 
> For reference, it is this way because of edc90fee916b ("PCI: Allocate
> ATS struct during enumeration").  The rationale was that since the PF
> STU applies to all VFs, we should require that the PF STU be
> programmed before enabling ATS on any of the VFs.
> 
> This patch relaxes that so the PF STU would be set either by (a)
> enabling ATS on the PF or (b) enabling ATS on the first VF.
> 
> This looks racy because theoretically drivers for VF A and VF B could
> independently call pci_enable_ats() with different IOMMU page sizes,
> and we don't know which will get there first.
> 
> Most callers supply a compile-time constant (PAGE_SHIFT or
> VTD_PAGE_SHIFT), so it won't matter.  arm_smmu_enable_ats() is
> fancier, but I *assume* it would still supply the same IOMMU page size
> for all VFs of a given PF.
> 
> But it's still kind of ugly to call pci_enable_ats(dev_A) and have it
> muck with the configuration of dev_B.  Maybe we should configure the
> PF STU (without enabling ATS) at enumeration-time in pci_ats_init()?
> Is there some way to get the IOMMU page size at that time?

Not really, on Arm the supported page sizes are discovered when probing
the SMMU registers, which may happen later than enumeration, during module
loading.

What this patch is trying to solve is:
* want the PF to bypass SMMU translation, and the VF to undergo SMMU
  translation (in order to assign it to a VM)
* SMMU forbids enabling ATS for a configuration that bypasses translation.
  So the PF ATS capability must be left disabled.

For this situation I wonder if we could do: the SMMU driver, seeing that
the PF is configured to bypass, calls a new function "pci_configure_ats()"
instead of pci_enable_ats(), which would only set the STU but leave the
cap disabled. Then when setting up translation for the VF, the SMMU driver
calls pci_enable_ats() as usual, which sees the PF's STU set appropriately
and succeeds.

Thanks,
Jean
