Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F621E3DB3
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 11:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgE0JjF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgE0JjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2020 05:39:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709DC061A0F
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2020 02:39:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so2370991wmu.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2020 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ma4u4XMWVxhpm3lD4oFGEfaNlly6DyjC8Gxwotb9TKs=;
        b=WXjQEVV83bRPYCR6LgwSP7gKE0qWLHR4Mnqw7P8noGQQ24OMhB75T8jRtIYlWMpWHY
         MySHznY6zRSBwHKVYmHsysbE+174PlXCVINNqJQjYg/72BEdEN0K/YKDNyN2QBDIuFxt
         R0Oq37rjAYoXARsBmbhgrlZSfqvOCc9gdGAOg9wpUOynvLbCDDIhxm3cCxh1xAWM53Kj
         /qMG3/aahORuZGKeMGZO2hruY7t1qM0Ejp5rLqR+i+9f80Efp9dXuIIn0b0rnCOeFxCi
         Q4RCOaOgvO5K4/5OBdHDdj2Yo2pvfTSwcO3cdr45feco2zONM3j9uMw4Ntt8RCKXreoL
         IzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ma4u4XMWVxhpm3lD4oFGEfaNlly6DyjC8Gxwotb9TKs=;
        b=k69KVXtZQ805mOTaBAXPXZ5FhP0wVbfveygz7PAtlxw2AEIi83uBP+efQ/CySWhG6o
         yAJRthcxyGcdgvLpg8fY0qvi5FtYp5MeEdkvDgpnUEJLTwDRY9ybP/taC/9SgF7s02lX
         Kp5Pf1S5K8r4YGm3jFRji0Xn5lkzMQOfitnBDX5dsu0Bms5ZxxvVENZT8E+kTJ8rsITu
         9PwzAt4pEDmNJUmEjexEY9xNOxOgdWBOHi9Gr/jlNPHhvEncy7Lp4juTlk9lBB5DljnC
         nKiyCQYmJtoTDTPzIyTHn6eJwuYZZO0VgHV1CWgBQoYhqfByBDPIYUiF9ORBnZThpNMH
         T4qQ==
X-Gm-Message-State: AOAM531bkZoExLQ6yVO5wFEirwRnG6G6/x8Yi+uQl7wYRvj0o42onaUz
        Tt+gRGA8zWFSGJTPuBopYHdTPdo8+vU=
X-Google-Smtp-Source: ABdhPJwRHl1VsOw+wNkIidN7cnKb04trFlt4YsFqaYnPmLrEQw89lrhHnt4yDc5lSDmieVnQqqyCXA==
X-Received: by 2002:a1c:b354:: with SMTP id c81mr3432193wmf.136.1590572343528;
        Wed, 27 May 2020 02:39:03 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id h20sm2275362wma.6.2020.05.27.02.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 02:39:03 -0700 (PDT)
Date:   Wed, 27 May 2020 11:38:52 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com
Cc:     will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com, hch@infradead.org
Subject: Re: [PATCH v2 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200527093852.GC265288@myrica>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Joerg, Bjorn,

On Wed, May 20, 2020 at 05:21:59PM +0200, Jean-Philippe Brucker wrote:
> IOMMU drivers currently check themselves if a device is untrusted
> (plugged into an external-facing port) before enabling ATS. Move the
> check to drivers/pci. The only functional change should be to the AMD
> IOMMU driver. With this change all IOMMU drivers block 'Translated' PCIe
> transactions and Translation Requests from untrusted devices.

This seems ready for v5.8. I guess it could go through the IOMMU tree
since there are a little more IOMMU changes?

Thanks,
Jean
> 
> Since v1 [1] I added tags, addressed comments on patches 1 and 3, and
> fixed a regression in patch 3.
> 
> [1] https://lore.kernel.org/linux-iommu/20200515104359.1178606-1-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (4):
>   PCI/ATS: Only enable ATS for trusted devices
>   iommu/amd: Use pci_ats_supported()
>   iommu/arm-smmu-v3: Use pci_ats_supported()
>   iommu/vt-d: Use pci_ats_supported()
> 
>  include/linux/pci-ats.h     |  3 +++
>  drivers/iommu/amd_iommu.c   | 12 ++++--------
>  drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
>  drivers/iommu/intel-iommu.c |  9 +++------
>  drivers/pci/ats.c           | 18 +++++++++++++++++-
>  5 files changed, 34 insertions(+), 28 deletions(-)
> 
> -- 
> 2.26.2
> 
