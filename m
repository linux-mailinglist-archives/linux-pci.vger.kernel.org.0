Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D08276C08
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgIXId0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 04:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbgIXId0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 04:33:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13892C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 01:33:26 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so3304779ejb.4
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jyXmkIgY0LNWFTzPLGPT01v9MPN/PKXL0sjKcC6NB5g=;
        b=CULJWZFlgtyrSKeuahx3NPP/IQeQHLWNP8sKhd/TwHs5cpEaqDxw+LVFhTKOm0yEmY
         MfRKM2j7Sg36BSoSSwKL7rvZfAM062viSliCHU57QOQnzPQN2ktici8ihBklwEWk++eL
         Ot6kNZ7vfkYyYTjHlPPusxYSKQSiR1nVKwbVCNowjDAaKoOBhiq1xS2vENWcXMdlm3xL
         ydtMMXz79lVvlL0gZOQMYSdGv8H2GZCjOQgPAoYGjR8p3unq0JmlAR3GPxS5evLUuZKY
         m3Dk4vu1WmwzEl2x6DKPnhByC+J3HO4PdOvZbOOcVw5AT9p/dK+u5XqWvop1s1ra1hT3
         ZKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyXmkIgY0LNWFTzPLGPT01v9MPN/PKXL0sjKcC6NB5g=;
        b=dnwwR1bPPZ2BI1K1r+TUE+zHWmwUIcClIz7fix8rb/CfQ9GZRC06KICUcBlR4xeMvH
         L7N3xJydVvm625PdYlK5ZCEM/b/aPmG1HNgImGbaj78dZ6PtHjiniJZerM0ufzbeb99Y
         dVVNI2YFRs+QT9Z01sFAjtLa7UAcM4NtfgnQxfGpdzLbAx14OTHY4Ux+Du8Qu9YS8nhT
         u7+9DxV2kq7Uk+AJiN6q3gBbmwdJGaoY0ZA0CnPb5vL/8kOELa8vcYzseeCA4i1WjvxB
         IvPUv7PLlH9LQY5nB9Bx56HjXFC2EIE5Jt/GYz9XYBZq9T6P5r590WvGod3FRCot6Vys
         b30A==
X-Gm-Message-State: AOAM533/bXU86qYazWoES4aVNL/+R6AAKo8SCTFAFipf7UjNQ3bh5k9V
        9q8mrRkXf24er3ZPxePL9YQsyQ==
X-Google-Smtp-Source: ABdhPJxtcrA4yjr/ahtgkewCxLx0mpHJ/7gjeE+jRO7iJDqgqZNqa+39Vg+vRpg/TCfzV39dzZhP/Q==
X-Received: by 2002:a17:906:a1d4:: with SMTP id bx20mr3417412ejb.262.1600936404738;
        Thu, 24 Sep 2020 01:33:24 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a5sm2091593edb.9.2020.09.24.01.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:33:24 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:33:06 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Message-ID: <20200924083306.GB170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-6-jean-philippe@linaro.org>
 <a52f8a2e-3453-eadf-9761-fd92a20c20f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52f8a2e-3453-eadf-9761-fd92a20c20f5@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 06:05:35PM +0200, Auger Eric wrote:
> > +static inline int viommu_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
> > +					     struct viommu_cap_config *cap)
> not sure the inline is useful here

No, I'll drop it

Thanks,
Jean
