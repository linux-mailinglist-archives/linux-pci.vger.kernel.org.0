Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F500182A00
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 08:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbgCLHyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 03:54:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgCLHys (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 03:54:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id r15so6116198wrx.6
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2020 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pr04BKgViz7j88JBgxuUWEhe3OvdyJ6JSxyYo6mbxRM=;
        b=EpWXmU25L0YGiiRM8vJA3DFaYTd2tQHV/7f1WBTrWn3S4r9BSEwymIHqNVZSw4dMvj
         iyFMVzICUPU+kCGh2X+TFBzft2lxPcpMbo2NwY076sG0P7S8cnI2qb5nx+YdVFbTNEKI
         Z7BthyeuRMPKwkqWfD4mJzybiJp3XzMU1lUrJoyP65Uc00FpC6n2iQcNwChNa9vNvld+
         k7pTldNv6wbqW9jcOZyltSbxgDfSmSCexv+/zHWUc0V2kqkQvsQi0AAyblBeXyXYdrQm
         tiByVIzqJB4Lcq46F6IOlGlYJts4l+kW8g962H+cWT1VTDfEKGKKH9N9Zr/wVINNVYVX
         QiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pr04BKgViz7j88JBgxuUWEhe3OvdyJ6JSxyYo6mbxRM=;
        b=HCPKXbW1UO1MynYyQqe97rji5wcmAbf+4oPNjHu8h2vhdd3+DaSJoPGau0M5z6TxT1
         cCqyHNQ3DfyMIh/xjsVxsLtvt2GWCd2E5aP1tppu3tvW9p/xBeUtQ+Z1/XbGdi6kvIsQ
         3HyaVsw2eLKrksW4KJlbIh9wz48A+IVzldSb0GHzVd5Oi5OHFoLtdjbDKH+hRhi7VIUh
         4wZAOfV+DOxlmVyR84ITDdsMACEKj+pWt1s0LX8n8+wzD3a2KH9ex6xCS8oiIkhD4Xpl
         S7GrzT9P0rc6sKQlG1iaIR300Kx646EKHqHtTsQyz+i0UR5oBglO1nPMAqeveSAefyw/
         ih6A==
X-Gm-Message-State: ANhLgQ16mfdRxSKvEghk/mH8QcoQfpXoBeLcF0OPjQq1QCDy8tQAMndy
        j+/nijK4BZAgUeixFaF9oO4Tlg==
X-Google-Smtp-Source: ADFU+vtT5PIgJyJgbHd5navhTh3TzppWQ7now/ZfW46dAJfhZnjJPv9XMBdkmY0dc+S4uOHKFCAEpQ==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr9266723wrs.162.1583999684449;
        Thu, 12 Mar 2020 00:54:44 -0700 (PDT)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id f207sm12446498wme.9.2020.03.12.00.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 00:54:43 -0700 (PDT)
Date:   Thu, 12 Mar 2020 08:54:36 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        joro@8bytes.org, sudeep.holla@arm.com, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, lorenzo.pieralisi@arm.com,
        corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        guohanjun@huawei.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Use pci_ats_supported()
Message-ID: <20200312075436.GA568802@myrica>
References: <20200311124506.208376-1-jean-philippe@linaro.org>
 <20200311124506.208376-9-jean-philippe@linaro.org>
 <7019230c-3c56-e6db-6704-d73f23fa39b5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7019230c-3c56-e6db-6704-d73f23fa39b5@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Baolu,

On Thu, Mar 12, 2020 at 09:44:16AM +0800, Lu Baolu wrote:
> Hi Jean,
> 
> On 2020/3/11 20:45, Jean-Philippe Brucker wrote:
> > The pci_ats_supported() function checks if a device supports ATS and is
> > allowed to use it.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/intel-iommu.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 6fa6de2b6ad5..17208280ef5c 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1454,8 +1454,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
> >   	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32))
> >   		info->pri_enabled = 1;
> >   #endif
> > -	if (!pdev->untrusted && info->ats_supported &&
> > -	    pci_ats_page_aligned(pdev) &&
> > +	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
> >   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
> >   		info->ats_enabled = 1;
> >   		domain_update_iotlb(info->domain);
> > @@ -2611,10 +2610,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
> >   	if (dev && dev_is_pci(dev)) {
> >   		struct pci_dev *pdev = to_pci_dev(info->dev);
> > -		if (!pdev->untrusted &&
> > -		    !pci_ats_disabled() &&
> 
> The pci_ats_disabled() couldn't be replaced by pci_ats_supported(). Even
> pci_ats_supported() returns true, user still can disable it. Or move
> ats_disabled into pci_ats_supported()?

It is already there, but hidden behind the "if (!dev->ats_cap)":
pci_ats_init() only sets dev->ats_cap after checking that
pci_ats_disabled() returns false.

Thanks,
Jean

> 
> Best regards,
> baolu
> 
> > -		    ecap_dev_iotlb_support(iommu->ecap) &&
> > -		    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS) &&
> > +		if (ecap_dev_iotlb_support(iommu->ecap) &&
> > +		    pci_ats_supported(pdev) &&
> >   		    dmar_find_matched_atsr_unit(pdev))
> >   			info->ats_supported = 1;
