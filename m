Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0927831C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgIYIsb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYIs1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 04:48:27 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC548C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 01:48:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p9so2553158ejf.6
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=emoRYvFV1+wXfCW/+6p/GyQoadovw+Jiwhu8aTMgKU0=;
        b=RWh2LCU3swUTd56gEVNeEdyA1NuXcjnKwsJ6epb6yxfVwwlLyFft7qyoYDwb4nSD9F
         2ctMzK3OnYPpBhfB1hXaN3ZqkBStmtssR+A0F4tTkVNttmHkadGMPbB/84TaovHS7yYy
         U4Aqwxn8iCPadf5Ycj4Ne+YqdCs5T2uajhIfJfOejoTRQ6KgTMCRPlUPsLbq7RGFqd1V
         781yi0atyQkM34kDqmrYHg12hbrVcr/yEJY8uPJsgmj8qRRMxkn4sKzK7JwrC1sZ46Qg
         EDnQpsCCVANaMSxML5qXH1UgJ69a32feNN9dx7qoyw3WHcd5oGHewMx8FT1MBaO7IOVU
         p8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=emoRYvFV1+wXfCW/+6p/GyQoadovw+Jiwhu8aTMgKU0=;
        b=d4s7UGrGgqNbDCEMT8vZPxH1WVErMs8zncr5vozKnDexgjCc7D/QV8iZvD5ZRB3FI0
         eeCL+gFa/8T09wFWZPTdJtQgSVWPtPHIin5NHomN0e6MZd6njmkphko8syxaWUrxeHbc
         QkCr/iYUpiTtXkfvf8fiZIb7/xSd78Cq0C5O6KpgauXSv4iZJJzVwSmg8ZcvMQKt5mHH
         HjxdTuTupjjRh1S3ULIlBrt5NEAUTc83+h0yBbFaiCaS0HReALosjo1EBYloqLcghG0Y
         YEjek9c76+JafF2Zphx2f6o2c9hta2YjOT58YDnpRwRFrVsDopsOe3HS2qUIPjIgE5P3
         005g==
X-Gm-Message-State: AOAM533B56jqKpmh0lTMvh6mJcEiZBcBbZzu5CXAldI3DU4EScorW9XZ
        dJD8bCpnCNwHZd+8zzC3Lef8xw==
X-Google-Smtp-Source: ABdhPJwrEYir8FTp3IhJ0bHKhMyHKLPJqzcUuhw51auhBeqZ1mDOELPLruwZjAdXUK33OCq9RAsS4A==
X-Received: by 2002:a17:906:5611:: with SMTP id f17mr1721401ejq.427.1601023705423;
        Fri, 25 Sep 2020 01:48:25 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m6sm1425837ejb.85.2020.09.25.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:48:24 -0700 (PDT)
Date:   Fri, 25 Sep 2020 10:48:06 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org
Cc:     joro@8bytes.org, bhelgaas@google.com, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200925084806.GB490533@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> Add a topology description to the virtio-iommu driver and enable x86
> platforms.
> 
> Since [v2] we have made some progress on adding ACPI support for
> virtio-iommu, which is the preferred boot method on x86. It will be a
> new vendor-agnostic table describing para-virtual topologies in a
> minimal format. However some platforms don't use either ACPI or DT for
> booting (for example microvm), and will need the alternative topology
> description method proposed here. In addition, since the process to get
> a new ACPI table will take a long time, this provides a boot method even
> to ACPI-based platforms, if only temporarily for testing and
> development.
> 
> v3:
> * Add patch 1 that moves virtio-iommu to a subfolder.
> * Split the rest:
>   * Patch 2 adds topology-helper.c, which will be shared with the ACPI
>     support.
>   * Patch 4 adds definitions.
>   * Patch 5 adds parser in topology.c.
> * Address other comments.
> 
> Linux and QEMU patches available at:
> https://jpbrucker.net/git/linux virtio-iommu/devel
> https://jpbrucker.net/git/qemu virtio-iommu/devel

I'm parking this work again, until we make progress on the ACPI table, or
until a platform without ACPI and DT needs it. Until then, I've pushed v4
to my virtio-iommu/topo branch and will keep it rebased on master.

Thanks,
Jean

