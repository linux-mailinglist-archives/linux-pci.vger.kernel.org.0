Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D520D3B8967
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhF3UCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 16:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233798AbhF3UCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 16:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625083204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kpbCmymIfNMu/sLXKm+zPCIGsHXk+XoDrOjYWyu1pFU=;
        b=Tfth27cl0pH8w2G6bMZ4M17aXfqOr0B14cLvaSKk7j+cSG/MjIKWoBqDQQgN4BCojGDzgG
        LOJc8xe2e66vH7+ChclntKgy5M1SZ9NlUp/6Jm8jg/65Pd3ItNpUetIxrFvV25QPEX7iU7
        hByY9NbU4jD2fxvwr2SXIJyiHj+FW8g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-1HXYDRa4NuKrIsZFRd4w7g-1; Wed, 30 Jun 2021 16:00:03 -0400
X-MC-Unique: 1HXYDRa4NuKrIsZFRd4w7g-1
Received: by mail-wm1-f72.google.com with SMTP id 13-20020a1c010d0000b02901eca51685daso3405799wmb.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 13:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpbCmymIfNMu/sLXKm+zPCIGsHXk+XoDrOjYWyu1pFU=;
        b=IXu3s7cWwqsSHYYVm7es+En3Ks0BSeW5n2fgnBIop6w/ilhV4DZiu5aPI8s7mPjLhi
         UD0TJhfWnXYLYnoiLBm3EIyLI2YNv7rM48okH9bLpCmP/8phTNtDFQ582WCPU5UxWEih
         stmZsOF7e66F7+nkxV0kTJj+zO0YAHoP3DFmPLxn8r97UdLwnbyk0Sj6Yxp2acmQLPJo
         TWOGnmR5M9jPy0VgaE3DovoOUAFDdog6TbxAneI/Y8ZfppWvSC7a19DZqNkeS6vG3hqn
         kH4LTkkqyRY4/xx3UvbRiS2m+MkVGd1GliSZKIfe3F97xfT+qkFSDHD2Al0uPYWtkNuS
         8RvQ==
X-Gm-Message-State: AOAM531BB8hXisLk2a6yLWJYuhuJF0FjWVY0crXwfJtxFKBiDLTVvBwm
        rM/N4p68SnGDVdfnp/9IVpe9ZcFW+PhlUYbwmdLbQE8s2gllTLorc8bW6BKJRHbNvrTW1X80T1u
        SE+SVasn6T0ttL49VIo/N
X-Received: by 2002:adf:8061:: with SMTP id 88mr41122174wrk.233.1625083200869;
        Wed, 30 Jun 2021 13:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbZIKlGNykgS5LTjJzUuKd9t2lLDnL4kgF750pVyY2IVUV5P2R2ti+aPzbVcp/wpfbkYiwhA==
X-Received: by 2002:adf:8061:: with SMTP id 88mr41122158wrk.233.1625083200692;
        Wed, 30 Jun 2021 13:00:00 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id o14sm25399wmq.1.2021.06.30.12.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 13:00:00 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210630185922.GA4170992@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <e7f3bd28-8e5e-362d-11a9-43a60ff79dd2@redhat.com>
Date:   Wed, 30 Jun 2021 21:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630185922.GA4170992@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/30/21 8:59 PM, Bjorn Helgaas wrote:
> [+cc Michal, Jingoo, Thierry, Jonathan]

[snip]

> 
> I think the above commit log is perfectly accurate, but all the
> details might suggest that this is something specific to rockchip or
> CONFIG_DEBUG_SHIRQ, which it isn't, and they might obscure the
> fundamental problem, which is actually very simple: we registered IRQ
> handlers before we were ready for them to be called.
> 
> I propose the following commit log in the hope that it would help
> other driver authors to make similar fixes:
>
>     PCI: rockchip: Register IRQ handlers after device and data are ready
> 
>     An IRQ handler may be called at any time after it is registered, so
>     anything it relies on must be ready before registration.
> 
>     rockchip_pcie_subsys_irq_handler() and rockchip_pcie_client_irq_handler()
>     read registers in the PCIe controller, but we registered them before
>     turning on clocks to the controller.  If either is called before the clocks
>     are turned on, the register reads fail and the machine hangs.
> 
>     Similarly, rockchip_pcie_legacy_int_handler() uses rockchip->irq_domain,
>     but we installed it before initializing irq_domain.
> 
>     Register IRQ handlers after their data structures are initialized and
>     clocks are enabled.
> 
> If this is inaccurate or omits something important, let me know.  I
> can make any updates locally.
>

I think your description is accurate and agree that the commit message may
be misleading. As you said, this is a general problem and the fact that an
IRQ is shared and CONFIG_DEBUG_SHIRQ fires a spurious interrupt just make
the assumptions in the driver to fall apart.

But maybe you can also add a paragraph that mentions the CONFIG_DEBUG_SHIRQ
option and shared interrupts? That way, other driver authors could know that
by enabling this an underlying problem might be exposed for them to fix.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

