Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98E8323326
	for <lists+linux-pci@lfdr.de>; Tue, 23 Feb 2021 22:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhBWVTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 16:19:01 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:32998 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbhBWVSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2021 16:18:43 -0500
Received: by mail-lf1-f41.google.com with SMTP id u4so13536038lfs.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Feb 2021 13:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBZtjmStpqTy7ucgnrqwPLfWg2aREUsoiW3wJc+ZOZM=;
        b=KAN7IUqUmhtnpIDI8N+d+EdhfSKPGMcTLlNh8v9E1W6RAA6IrmNTjW2NpaMjvxQU29
         xh1k/SBXM0Cyj1tOxZuJIRY27ZxAI3JjuKZsmjfNwaXiGQoxgYWs96OLVxupB31FMQMI
         yrBgPG7bUPDoZsEFfqYgZYebqj+1HCzk8XLUfL/rIQd1AbA+Ps08q0GiTIGmauKDxZdv
         CK1YKGvMvyLkCCX1H/ARGEgbBv1ddbo0xxbne+SpcodM21h5NCeK7HtIDftTVQngOGR6
         GOE82XzOnRkAfitXEWtfBDSfpNzABm1NDaZqqRG9FyYcAT9nuwJFxqo7eWrKYon4COV9
         RHBg==
X-Gm-Message-State: AOAM5332SpjzdYa2X5MnU7avtNUWBoas4xd4yqfp7igsyOUTzxxKRvlX
        eQIMG221RLJWuSAqOmcLU0k=
X-Google-Smtp-Source: ABdhPJzU5wTM/0qiT8+jHfU9Nh+IWTRICwbIbgRHlve71Y3RPs4CjPbEV6X2SzaftU9w9QtfOg18Ew==
X-Received: by 2002:a05:6512:10c9:: with SMTP id k9mr18636993lfg.532.1614115081679;
        Tue, 23 Feb 2021 13:18:01 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b14sm3175147lji.120.2021.02.23.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 13:18:01 -0800 (PST)
Date:   Tue, 23 Feb 2021 22:17:59 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     helgaas@kernel.org, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: exynos: Check the phy_power_on() return value
Message-ID: <YDVxBzH/9ePDhy4v@rocinante>
References: <20210208174114.615811-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210208174114.615811-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Fabio,

Thank you for sending the patch over!

[...]
> This fixes the following Coverity error:
> 
> 	CID 1472841:  Error handling issues  (CHECKED_RETURN)
> 	Calling "phy_power_on" without checking return value (as is done elsewhere 40 out of 50 times).
> 	phy_power_on(ep->phy);
> 	phy_init(ep->phy);

This is good, however, you would need to wrap long lines, and that would
make the message from Coverity harder to read, etc.  Thus, it might be
better to use the "Addresses-Coverity-ID" which is becoming a de-facto
standard for referencing Coverity defects.  Check the following for some
examples:

   git log drivers/pci | grep 'Addresses-Coverity-ID:'

[...]         
> +	ret = phy_power_on(ep->phy);
> +	if (ret < 0)
> +		return ret;

I wonder if you would also have to call phy_exit() here, even though
eventually exynos_pcie_probe() would call it once the error propagates
all the way up the call stack.

Additionally, exynos_pcie_resume_noirq() does not do any error checking
after calling exynos_pcie_host_init() and does not call phy_exit()
either, and I am not sure if it should, though.

See some comments below.

> +
>  	phy_init(ep->phy);
[...]

A small nit here.  You can check for any non-zero return value, as
anything would indicate an error here.

I also have a suggestion.  Would you also be interested in addressing
two Coverity defects that were detected in exynos_pcie_host_init()?

These would be the one you addressed here (CID 1472841) in this patch
and the other would be:

  CID 1471267 (#1 of 1): Unchecked return value (CHECKED_RETURN)

Which is about checking return value from phy_init() that is called
immediately after phy_power_on() in exynos_pcie_host_init().

The error propagates from exynos_pcie_host_init() as follows:

  struct exynos_pcie_host_ops{}
    .host_init = exynos_pcie_host_init

  exynos_pcie_probe()              <-- phy_exit() called here if exynos_add_pcie_port() fails.
    exynos_add_pcie_port()
        dw_pcie_host_init()
          exynos_pcie_host_init()  <-- phy_power_on() and phy_init() called here.
            dw_pcie_host_init()
              struct pcie_port{}
                struct dw_pcie_host_ops{}
                  .host_init       <-- exynos_pcie_host_init() called via struct exynos_pcie_host_ops{}.

  struct exynos_pcie_pm_ops{}
    .suspend_noirq = exynos_pcie_suspend_noirq
    .resume_noirq = exynos_pcie_resume_noirq

  exynos_pcie_resume_noirq()
    exynos_pcie_host_init()        <-- called here, but without any error checking.

Thus, we could handle propagating error from both the phy_power_on() and
phy_init() in the same time, perhaps even in a single patch, or a small
series.

Also, since there is no error checking and/or handling that might be
returned from exynos_pcie_host_init() in the exynos_pcie_resume_noirq()
callback, then perhaps adding some error messages to be printed should
something bad happens regarding power management.  But this would
becompletely optional as there there is also no error checking and
handling in exynos_pcie_suspend_noirq() either.

Krzysztof
