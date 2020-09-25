Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F78278256
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgIYINE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgIYINE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 04:13:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC8C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 01:13:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so2493656wrn.13
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H+3WzdqdQFTD9YVJPe0cUi1421BcNuytEOcD1N3pbAA=;
        b=iqNxY34qj1j0Vv2BeallVZbgpm04aSXY4oypqhqgW0QDLuR8mqpJNA1B9Y9UnjdMrl
         zVFiBENE+bjpgYfDjjt2EamF+PHd0FtpAIHypBr4RHDbRo5BFaSpq0F83RDxs+f4HHo5
         68k9OZcMaOtaIDhr0gqewkiOmoFGvJGS1P5b1jz8vHWmvN1aXRfa+DeuVoIK65vvlHJY
         GE8o9OaXY+isCDJSd5Q1GxaXlL3866/Xh8fTBY80W+1hwhaL4rlF/754RIxVkj7JaVXL
         F1eOfIjmFVKkuUgOLFVSWSCoOQkvlur6VP1qVSfjZ+XAsxHVtMU59+vuFJVGFACTiOnK
         Y8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H+3WzdqdQFTD9YVJPe0cUi1421BcNuytEOcD1N3pbAA=;
        b=ivw1ULQeQIud2b1cVo6jIok23m3q5Cc2EqDli3uZu2IkMhp69dCdFvIh2pv5dlAViu
         GAotvY2JQUtkCDSp2dH7Nw+b4A4IaCTJzqCMg0xvyeG1wK0HQ441scESV9raFrePFp1l
         oqveH7NU2vwhAwH40VpXy7s5b37CAbsi+zso8WjZiYikkRifXxGlZXXKz5w3CEHQA6aC
         h0pJdHRmP6XdYx1L2e8tgyUqbG52fAiwmfwSk6ZiybpaT75xoLIhKvqHuCM34sGqLQzT
         LB9AKaOdz7Nyh6ZhfdVTnxu4N2191mzGCAQ5yT/kBhLN5U6nUilZ1MEI7fJA3mUi6AeP
         oU4g==
X-Gm-Message-State: AOAM530PhB0BrL39bOyU2YjpCmfl1VmUfSIbCTzdvJ/E6oT6wc21siRE
        OF3Ap0EaHtfcyOFYN6mfkapftQ==
X-Google-Smtp-Source: ABdhPJzferA03aonshOz4wYiPb6ai1yoyCYdneu0wO9qrUHroSPM0f6AASiRX9eeyY81L6rbKyBxMQ==
X-Received: by 2002:adf:f382:: with SMTP id m2mr2925330wro.327.1601021582974;
        Fri, 25 Sep 2020 01:13:02 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id k15sm1982212wrv.90.2020.09.25.01.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:13:02 -0700 (PDT)
Date:   Fri, 25 Sep 2020 10:12:43 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Message-ID: <20200925081243.GA490533@myrica>
References: <20200821131540.2801801-6-jean-philippe@linaro.org>
 <20200924152203.GA2320481@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924152203.GA2320481@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:22:03AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 03:15:39PM +0200, Jean-Philippe Brucker wrote:
> > Platforms without device-tree nor ACPI can provide a topology
> > description embedded into the virtio config space. Parse it.
> > 
> > Use PCI FIXUP to probe the config space early, because we need to
> > discover the topology before any DMA configuration takes place, and the
> > virtio driver may be loaded much later. Since we discover the topology
> > description when probing the PCI hierarchy, the virtual IOMMU cannot
> > manage other platform devices discovered earlier.
> 
> > +struct viommu_cap_config {
> > +	u8 bar;
> > +	u32 length; /* structure size */
> > +	u32 offset; /* structure offset within the bar */
> 
> s/the bar/the BAR/ (to match comment below).
> 
> > +static void viommu_pci_parse_topology(struct pci_dev *dev)
> > +{
> > +	int ret;
> > +	u32 features;
> > +	void __iomem *regs, *common_regs;
> > +	struct viommu_cap_config cap = {0};
> > +	struct virtio_pci_common_cfg __iomem *common_cfg;
> > +
> > +	/*
> > +	 * The virtio infrastructure might not be loaded at this point. We need
> > +	 * to access the BARs ourselves.
> > +	 */
> > +	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &cap);
> > +	if (!ret) {
> > +		pci_warn(dev, "common capability not found\n");
> 
> Is the lack of this capability really an error, i.e., is this
> pci_warn() or pci_info()?  The "device doesn't have topology
> description" below is only pci_dbg(), which suggests that we can live
> without this.

At this point we know that this is a (modern) virtio-pci device which,
according to the virtio 1.0 specification, must have this capability. So
this is definitely an error, but the topology description is an optional
feature.

> 
> Maybe a hint about what "common capability" means?

Yes, "virtio-pci common configuration capability" would be more
appropriate

> 
> > +		return;
> > +	}
> > +
> > +	if (pci_enable_device_mem(dev))
> > +		return;
> > +
> > +	common_regs = pci_iomap(dev, cap.bar, 0);
> > +	if (!common_regs)
> > +		return;
> > +
> > +	common_cfg = common_regs + cap.offset;
> > +
> > +	/* Perform the init sequence before we can read the config */
> > +	ret = viommu_pci_reset(common_cfg);
> 
> I guess this is some special device-specific reset, not any kind of
> standard PCI reset?

Yes it's the virtio reset - writing 0 to the status register in the BAR.

Thanks,
Jean
