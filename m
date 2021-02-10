Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408E131729D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 22:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhBJVqC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 16:46:02 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:51685 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBJVp5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 16:45:57 -0500
Received: by mail-wm1-f46.google.com with SMTP id t142so3152970wmt.1;
        Wed, 10 Feb 2021 13:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K198DCJ4x+tkk5MzAOh2fgwgWRM7jXwp8acavChFK1k=;
        b=RL/0/o3ZmgHQbkDa8jNI6IHDnQAOUGD4j6FBV1yP9Tj7V5TxfBQQLi7caj09VZ/0np
         IBk6m8zFg1eoJRsEx2StHFDTZ1c+uAOiHx2AfsHlXw/ntBKRIbBSpG07n3leB7XUji8L
         sgiGs04HOAfDkuaVdRGbCXyXA4dAWL84HOWzlB8iGyviIv9gpn0r+VXS/hzvIKv1jL8P
         pNlW5yqThX7YezrVoPfy33mLEx5ZePZXNBUSqWSCKNmxSiWHFT+ZNeZCKtom4rGVko/s
         z212Uq2UtsAdSp1ygLXPpFrhx7aNwcyxMOtlhflVHsAHjJSIRIputXx4w9IVuQ6G+kcF
         IXBw==
X-Gm-Message-State: AOAM530vHb4nPE6kKxWuDpDttd+5ZXSvbL6FqwkBpPsiyChKntzZUWON
        D6LqQwe9wMaCc/Ww+YkHWNM3tp4azyXx0Xp+
X-Google-Smtp-Source: ABdhPJxFYXDq9ZbGNvtUOKX/OVL9l7xwHvw0DW9oXkNPslQVZS1s6OT5J3K5joZp2m+fVV5HgwJndw==
X-Received: by 2002:a1c:c308:: with SMTP id t8mr1101584wmf.7.1612993514947;
        Wed, 10 Feb 2021 13:45:14 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c9sm4466055wmb.33.2021.02.10.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:45:14 -0800 (PST)
Date:   Wed, 10 Feb 2021 22:45:13 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Message-ID: <YCRT6QVQai3oIvwf@rocinante>
References: <20210209101955.8836-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210209101955.8836-1-bharat.kumar.gogada@xilinx.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bharat,

Thank you for sending the patches over!

> Add support for routing PCIe DMA traffic coherently when
> Cache Coherent Interconnect (CCI) is enabled in the system.
> The "dma-coherent" property is used to determine if CCI is enabled
> or not.
> Refer https://developer.arm.com/documentation/ddi0470/k/preface
> for CCI specification.
[...]

A small nitpick, so feel free to ignore, of course.

Perhaps "Refer to" and "for the CCI", etc.

[...]
> +	/* This routes the PCIe DMA traffic to go through CCI path */
> +	if (of_dma_is_coherent(dev->of_node)) {
> +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
> +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> +	}
[...]

A suggestion.

You can drop the curly brackets here if you want to keep the style used
in the kernel, especially for when there is a single statement inside
the code block.

Krzysztof
