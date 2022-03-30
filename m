Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04B4ECB1D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 19:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349496AbiC3R4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 13:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349567AbiC3R4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 13:56:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491741EAF7
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 10:54:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D280360B07
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 17:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C28C340EE;
        Wed, 30 Mar 2022 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648662896;
        bh=u+Vv8O+9e1PD5XljfwWsq8yYF8FGlHrHRMqRJFyiMAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=to09D3zUVjgkDjOIANAKggBiM2+CUTAopS6zCtKgfye6JWWkhcuUL9EE23BJC0dtl
         4bLizkdiVnLwXvcin0KwNiGaVI7caYgqXnlbwIfSIQ8Ucrtbp4f2Vy3iTF6LAlDvuv
         rOi3kOI7MkkWxk0TFXXi6A8SEJMLCsm0q6B9upwla3itecltlfVslEdjqcdgQbImiO
         5Z9K47ZdqYbCQepopvqovTj1/EunDNByJEq40/2TglveC952Pk8bhq116BQPS3wyNe
         zZZ3IjheZ/g2kZnqIVEWuJlslT5rnxzCZPHEhCtP3wGQNWPPuBpRN25/HqOCs659wK
         PT9VEjX48hYEA==
Date:   Wed, 30 Mar 2022 12:54:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@intel.com>
Subject: Re: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Message-ID: <20220330175453.GA1694874@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202db6b1-5b66-8f37-ba06-7456326f2cf6@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 30, 2022 at 08:54:15AM -0700, Patel, Nirmal wrote:
> On 3/29/2022 4:27 PM, Dan Williams wrote:
> > On Tue, Mar 29, 2022 at 3:48 PM Patel, Nirmal
> > <nirmal.patel@linux.intel.com> wrote:
> >> On 3/16/2022 8:51 AM, Nirmal Patel wrote:
> >>> From: Nirmal Patel <nirmal.patel@linux.intel.com>
> >>>
> >>> VMD creates and assigns a separate IRQ domain only when MSI remapping is
> >>> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
> >>> MSI remapping is disabled resulting child devices getting default
> >>> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
> >>> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
> >>> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
> >>> when VMD create a root bus and configures child devices.
> >>>
> >>> As a result DMAR errors were observed when interrupt remapping was
> >>> enabled on Intel Icelake CPUs. For instance:
> >>>
> >>>   DMAR: DRHD: handling fault status reg 2
> >>>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
> >>>
> >>> Acked-by: Dan Williams <dan.j.williams@intel.com>
> >>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> >>> ---
> >>>  drivers/pci/controller/vmd.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> >>> index cc166c683638..3a6570e5b765 100644
> >>> --- a/drivers/pci/controller/vmd.c
> >>> +++ b/drivers/pci/controller/vmd.c
> >>> @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> >>>       vmd_attach_resources(vmd);
> >>>       if (vmd->irq_domain)
> >>>               dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> >>> +     else
> >>> +             dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
> >>>
> >>>       vmd_acpi_begin();
> >>>
> >> Gentle ping!
> > It helps to be explicit when you send a patch and a follow-up ping.
> > Are you asking Lorenzo to take this? Is this urgent such that Bjorn
> > should consider taking it directly? The changelog notes what happens,
> > but not the severity of end user visible impact. The merge window is
> > presently open so the natural inclination is to just wait until that
> > closes to circle back to outstanding patches.
> 
> This patch removes a flag that bypasses MSI disable feature of VMD and
> improves the performance. So it would be nice if the patch gets accepted
> sooner. I tend to send follow-up ping after a week or so if I do not get any
> feedback and to allow it to get accepted in time.

There are only a few days left in the v5.18 merge window, so unless
it's an emergency, this would be v5.19 material.

This claims to be a v2, but I missed the v1, and the lore archives [1]
seem incomplete.  Maybe the v1 (and maybe the cover letter?) were HTML
or got lost for some other reason?

Bjorn

[1] https://lore.kernel.org/all/?q=f%3Anirmal.patel
