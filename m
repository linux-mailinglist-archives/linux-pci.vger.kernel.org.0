Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0699276BFA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgIXIbg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgIXIbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 04:31:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C653C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 01:31:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id r7so3240273ejs.11
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iQLky5ZWJdFZQTUOK1fAqSj9E9vn3fC5tbC/RCI+f5o=;
        b=JxmiTewQDn+DVnAHs5YSCKXGT9ubPK/YQGSoDm86k7pdu51akn98y0gMvSdQrAKLVN
         O8mfewLHNsyNzndlhjkcDqtCXCMrX0Ejgi/Dr/u3JJa0kY7fnmGkkhTC8zh6wtROgN3R
         QmGd1E7DNjOrhV3SaSSLohUmmndRJccit3YqqlHXuVhnYphUN0ssoPq9DxEXbgFKGz1p
         VfNeLjJbe3KBnXoYeLJHS5J0+RM77PeCKO5CzxXjhnzO1Lr7AAlm4e3uhH6dHZwyltoo
         VRSbtBnHCu9qkPNJipDLql43zuJgP4lnfr2q2bbMivywCcFILBEMwmOWCOdmuyJeC3LM
         N+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iQLky5ZWJdFZQTUOK1fAqSj9E9vn3fC5tbC/RCI+f5o=;
        b=DO13FFqL2P0F6/+U/6mMj6ueuX0MGmY0kvI73bPDJ7mrG7qNfvRjqAKA0FejNCQadT
         PM5ysEUNYLszQ3RS31Epyerfuan3mk0SY94GtXpUVm11TYh2AAB7G/ccoVwSPg2prk9c
         5U0pNc4AFFJw47Na08EFxTwFkdFJijS1VK6Cjar/J20bksU4kDoN25zradrj/dr2d67b
         uaEXwWKNaCtEttZVzMm+Mnhjqgd1Tl4D0qDDvFaU8+1rsdVtCONgizB8TtU21HB0TF6i
         xgKTqCT3azOwbpOzPCte7X/FLkiQ64EiyRyTv8e0PT+hhtCjmP+IATB/US/eNzJHahcN
         80pw==
X-Gm-Message-State: AOAM532WqQmbdLZGjrPsy+c8tamp9cGrFLQn0T4GwwpoFmOl649ovtNX
        sTdYrSPIsrhvA2H2OC/lLBYQ9g==
X-Google-Smtp-Source: ABdhPJwLzzXN+IyUsf3KGNT7aZtIbPoxS7jdNw92acn5PhSUI2Uv1RL6H8dlzn8f4ElxNCwc/0DyMA==
X-Received: by 2002:a17:906:2659:: with SMTP id i25mr3402228ejc.16.1600936294818;
        Thu, 24 Sep 2020 01:31:34 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id q23sm1988704edw.41.2020.09.24.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:31:34 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:31:16 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 2/6] iommu/virtio: Add topology helpers
Message-ID: <20200924083116.GA170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-3-jean-philippe@linaro.org>
 <21fce247-4c1c-b7a8-bcac-4d7b649eaeca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21fce247-4c1c-b7a8-bcac-4d7b649eaeca@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 06:22:12PM +0200, Auger Eric wrote:
> > +/**
> > + * virt_dma_configure - Configure DMA of virtualized devices
> > + * @dev: the endpoint
> > + *
> > + * Setup the DMA and IOMMU ops of a virtual device, for platforms without DT or
> > + * ACPI.
> > + *
> > + * Return: -EPROBE_DEFER if the device is managed by an IOMMU that hasn't been
> > + *   probed yet, 0 otherwise
> > + */
> > +int virt_dma_configure(struct device *dev)
> > +{
> > +	const struct iommu_ops *iommu_ops;
> > +
> > +	iommu_ops = virt_iommu_setup(dev);
> > +	if (IS_ERR_OR_NULL(iommu_ops)) {
> > +		int ret = PTR_ERR(iommu_ops);
> > +
> > +		if (ret == -EPROBE_DEFER || ret == 0)
> > +			return ret;
> > +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> > +		return 0;
> why do we return 0 here?

So we can fall back to another method (ACPI or DT) if available

> Besides
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
