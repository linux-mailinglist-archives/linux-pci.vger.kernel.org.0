Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5857F3339FD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCJK3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 05:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCJK3H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 05:29:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E868BC06174A
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 02:29:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so7415554wmj.2
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 02:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YOMi9qCdcZCB9oPla4gQDzyKzBrwycjnCrCwEzZDplg=;
        b=eBLp9E2jY392I9LZ8uW/Vrw4FfREdyb7m45cauuv9AQRyWujq/0d1ZX9xkxHqDMJ9W
         ftvF8R/UffPwuP1qvhL9q2PkO2YvXztXqXvfLCGpJ5CnmIq2apWlsddpPnKU83Wsfv+c
         9U8Rvtg2DrfkG+RVlx4fVtSZ0c0Le4vtH2QoQ4s64Yf1lFtNQicloX3PaaLNKzKM1H4K
         sS9R1+PNP501ZuLWjSOWFSNmpEnX6RqSnYucCl3J/SLZ3F+uY7984fAVkHAtuNAgjvp4
         mjhTrvYqVAim6+wAMeeEeikRlUrxL9RL6BGyk9OxzcI7dQJR7nzRzsmzLFcDTS3lE8DM
         hGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YOMi9qCdcZCB9oPla4gQDzyKzBrwycjnCrCwEzZDplg=;
        b=rzaWyOvQh+OVLduZL0w/7ta2VNagc5josA8KpcOFjWRiRKRBEM4+A8rqqg1NidQP/j
         ckzZJMdXfniybMhkHTBtcgpcuixmzzvdbcUIPvn8lz0u5SxqTv51irpLuwdnAzsU/4cT
         Et5YHUa9oigGZoOY92+shcX2WYHkxYWqKGUfTlHsWPipygZnmHHuwKfygIMkoLteapLF
         1eXrJVsiGIkgg3xn9kubLWQwiwA+kFcNjMKp3EqmxHiwFoMqZZzBr1vsZ6I/Y3bpXNen
         JIhjU0x5FAEBtOR3C7/B2iec/5ljf5kOqpdr7ths7BY88v93SG5UvywD8Ngs8aJlMyYh
         Uz1Q==
X-Gm-Message-State: AOAM531vhQgG/uJwS1twrDsSQueMQyEU/y3IA4dsieL+2F/mYyR/bxka
        LuFoUez6R5nHXlkpUhHHDipa2A==
X-Google-Smtp-Source: ABdhPJzeMHKCOB/tzkQt5QdUqC55pSbAcZerIE0my7lc5jnvL/rAQbZpIooFDo3a9ytU9lOD6pboMA==
X-Received: by 2002:a7b:cc1a:: with SMTP id f26mr2630238wmh.19.1615372145614;
        Wed, 10 Mar 2021 02:29:05 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id 21sm8934740wme.6.2021.03.10.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 02:29:05 -0800 (PST)
Date:   Wed, 10 Mar 2021 10:29:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jean Delvare <jdelvare@suse.de>,
        Tan Jui Nee <jui.nee.tan@intel.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Peter Tyser <ptyser@xes-inc.com>, hdegoede@redhat.com,
        henning.schild@siemens.com
Subject: Re: [PATCH v1 4/7] mfd: lpc_ich: Factor out
 lpc_ich_enable_spi_write()
Message-ID: <20210310102903.GE701493@dell>
References: <20210308122020.57071-1-andriy.shevchenko@linux.intel.com>
 <20210308122020.57071-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308122020.57071-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 08 Mar 2021, Andy Shevchenko wrote:

> Factor out duplicate code to lpc_ich_enable_spi_write() helper function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/lpc_ich.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

You are adding way more lines than you're saving here.

It's not a horrible change, so:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
