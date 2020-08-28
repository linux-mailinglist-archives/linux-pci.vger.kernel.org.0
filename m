Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5525590A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgH1K4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgH1Kx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2020 06:53:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7168C06121B
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2020 03:53:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so488563wmb.4
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2020 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e6iXM6C5sJ3FBz3LIMthXRBWXK9iTp3RhCVsBFe2ot4=;
        b=YrriV/ZpxSVeR1zNRjbVh0hZsksEyHhLgrOl31e0w2SDO/H8Bjh/dcb34Qq3dSVt8h
         uiOhYVGDo6GywbGQ453rFe6xo1Yo4hMj+KVM1hv/A6Wm1QY6rBkeJ7BrYrrj4p7aUjn1
         BO/Cn7KyMnoVy5Ka6E+TfXreZM2tII4pyNxLPM2QKyIQ8+xV541NqaHAPOYwePYBuTbX
         sD+tbJf0KJvFjKoikZg7/vVmIdZQctlcrnzpPzhWe0x0ApPVnwsSuTwYgFVJHE8MmpBy
         M12aXSVVQjbNuvEwKf2gUCy7mVf7wXrDAaKk7Tp/hz3zPA7ndKo2EXfLC3QcA+wayEfv
         utTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e6iXM6C5sJ3FBz3LIMthXRBWXK9iTp3RhCVsBFe2ot4=;
        b=LV8P8xEc7wL3hyNpn5dXbtIfEa7Uio4lA+McsjXz7TRHbbf0dNJtBKf+3oo7xsGpMw
         KHc+DB4ks7GYF3XMkQmXtCp3mPouONE6FG6gzOtnQYH5zKE3rejwtprwYmtp56GZ6/so
         C530JRmHvO7JUjikCZk/QGrkSHy10r0j3tiVw+Mpfug/WadK34jwVH+kg4mu4r++zbw+
         DBHMAVIQ4lp4+GsRILxFrs81kZAcI+9/U5BT5wQilLX3dZbLbjR8k/6QZfxmXFbbHrhd
         nmImPv0yXZKZdLcEfMSKFCMsot/LCTrrBcZwn8MTXIr7aLysmMiIsxdgnH9RaWYLDCIw
         zvoQ==
X-Gm-Message-State: AOAM530SzYZxxfHIzLLAAIQGMbYctg05rlwc4/91tepItEsZy349nC7A
        EufPOqRC44q4PoKgAegqu+raMQ==
X-Google-Smtp-Source: ABdhPJzQxd25rKg5eLhiITlNvNOcRWPIr5L602jIp3qY0aHNYmrx4NqgdS61UJZebGJa7RWwd6OJsA==
X-Received: by 2002:a1c:a506:: with SMTP id o6mr1019921wme.3.1598611987242;
        Fri, 28 Aug 2020 03:53:07 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id r129sm1531390wmr.40.2020.08.28.03.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:53:06 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:53:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V5 2/3] mfd: Intel Platform Monitoring Technology support
Message-ID: <20200828105304.GS1826686@dell>
References: <20200819180255.11770-1-david.e.box@linux.intel.com>
 <20200819180255.11770-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819180255.11770-3-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 Aug 2020, David E. Box wrote:

> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring facilities. PMT supports
> multiple types of monitoring capabilities. This driver creates platform
> devices for each type so that they may be managed by capability specific
> drivers (to be introduced). Capabilities are discovered using PCIe DVSEC
> ids. Support is included for the 3 current capability types, Telemetry,
> Watcher, and Crashlog. The features are available on new Intel platforms
> starting from Tiger Lake for which support is added.
> 
> Also add a quirk mechanism for several early hardware differences and bugs.
> For Tiger Lake, do not support Watcher and Crashlog capabilities since they
> will not be compatible with future product. Also, fix use a quirk to fix
> the discovery table offset.
> 
> Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  MAINTAINERS             |   5 +
>  drivers/mfd/Kconfig     |  10 ++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/intel_pmt.c | 220 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 drivers/mfd/intel_pmt.c

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
