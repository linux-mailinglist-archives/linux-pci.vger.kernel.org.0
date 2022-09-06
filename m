Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B9C5AF116
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiIFQuk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiIFQuW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 12:50:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E574281B30
        for <linux-pci@vger.kernel.org>; Tue,  6 Sep 2022 09:36:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e20so16266276wri.13
        for <linux-pci@vger.kernel.org>; Tue, 06 Sep 2022 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=u9aosksAPdNjDd0bmpKVWgEojLBbOI+Pi5HIfNyLBhA=;
        b=viV8ASe7i5je49B5m4Tc6eMD+h4fSi5v86IpkPQdT8vTn20Ob+X0CLIzxUxQRPbD0m
         znLDsEJmhmjPHYJuFrOlsvSBPhi9dX7dYWU2bfVvFkdlF63b/bYiP9aswCtWqTiyV2+I
         ghEt9I2FaI0YWWyi98dTvJ7iH5J31HH+sJn1Xl0A4GU1hHR7dPhClC0rbayb7j75aoEZ
         FTliPeRmqWowBGmc4o8F37OI2aXh5EQUkVpmWlVL9Gs7dvsPgsbm95GvFM6w4aENIJkR
         0B5+Yi5eqnBVKvSd63yQCaZx1dVLIkV2vaZ0eGqALNT7v41HgzW/LHyzjRoPmxEF+fyC
         73Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u9aosksAPdNjDd0bmpKVWgEojLBbOI+Pi5HIfNyLBhA=;
        b=eo1St5Oj34W0UtvlZmsSqqOrCcBwuTvO3QRV4fanqLnlevfVKmd00Bx1QkrIe/Tg8N
         +Z2rlLELsu0JRhR/9Zt9TOGUVyX+wovp/MVu2tIFOnx38qLt7fMlXzcXUY9nA6p6V2Q7
         zPb8hlG7Ek5BxMcrkfXeguwLOtEpand9/uwcoiLqj+kQi8gqeDB38W5Dofzj66+44zQ5
         P0tt1feErdK43bOif1WfJkfJhBqeKH2q7TZY9loaqtq35zuR2ceVvQaH4cpcOrGCFo5T
         UOM9loCR9bNq84iygQVEX57AltiN9GGg5FUK4ESnhY2Q1NxLJrFxZVEGIYrsP0V50MW9
         Gv2g==
X-Gm-Message-State: ACgBeo2T+L20foQ1pq5V4mPaNE/dc/j/b9vufYBmzTVjTe83H5k33wXX
        P8SB5n6Knj0V273uwIWxmw0oaw==
X-Google-Smtp-Source: AA6agR6rVNZtgyKoGht+YirSloUtiazD6tjUr777qQIeSXmbawEaMBEBIGDh8y7fMY4VMzSQgyschQ==
X-Received: by 2002:a05:6000:184d:b0:220:8235:132 with SMTP id c13-20020a056000184d00b0022082350132mr28396554wri.178.1662482174493;
        Tue, 06 Sep 2022 09:36:14 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q10-20020adff78a000000b0021e6277bc50sm16009172wrp.36.2022.09.06.09.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:36:13 -0700 (PDT)
Date:   Tue, 6 Sep 2022 17:36:09 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yxd2+d/VOjdOgrR2@myrica>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906124458.46461-10-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.

This isn't true anymore. How about storing handle in the domain?

(Maybe also drop my Reviewed-by tags since this has changed significantly,
I tend to ignore patches that have them)

Thanks,
Jean

> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_sva *handle;
> +	ioasid_t max_pasids;
> +	int ret;
> +
> +	max_pasids = dev->iommu->max_pasids;
> +	if (!max_pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid,
> +						IOMMU_DOMAIN_SVA);
> +	if (IS_ERR(domain)) {
> +		ret = PTR_ERR(domain);
> +		goto out_unlock;
> +	}
> +
> +	if (domain) {
> +		domain->users++;
> +		goto out;
> +	}
> +
> +	/* Allocate a new domain and set it on device pasid. */
> +	domain = iommu_sva_domain_alloc(dev, mm);
> +	if (!domain) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +	domain->users = 1;
> +out:
> +	mutex_unlock(&iommu_sva_lock);
> +	handle->dev = dev;
> +	handle->domain = domain;
> +
> +	return handle;
> +
> +out_free_domain:
> +	iommu_domain_free(domain);
> +out_unlock:
> +	mutex_unlock(&iommu_sva_lock);
> +	kfree(handle);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
