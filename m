Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1E3B3D05
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYHMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 03:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229454AbhFYHMC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 03:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624604981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLtazXb3G6fRRX9xtmGZQwP57cBRAMVoE8LLTV4/QLo=;
        b=iXnT9CmgRRkvDdsgkj8ZUasrWgmBoN2MLWqTQGuRtSebE8Xu6Pmc3/jXJX1X1PbkQw6Kwg
        Z7GrS6fHBX2UDSEKFTRfprHEOCyae1FMazIJXXdQkSKB6+O+KVNS+6xw9JHCauUrXyD15w
        jon1XfdCdcN5NQHpdpYg9yScVxjBpIE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-8tkP-SWoOzy_pVKfUpdfUw-1; Fri, 25 Jun 2021 03:09:40 -0400
X-MC-Unique: 8tkP-SWoOzy_pVKfUpdfUw-1
Received: by mail-wm1-f70.google.com with SMTP id f22-20020a1c6a160000b029018f49a7efb7so3816544wmc.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 00:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLtazXb3G6fRRX9xtmGZQwP57cBRAMVoE8LLTV4/QLo=;
        b=m8si9TOHx7DuU0neryLaaTDMeIspA+WtVKcIndey9+vYZEHYHKrJ/o5+9STfoBf1dh
         iSmNgLXe7ylxPy1DjB5AcInruwL4K28TVimpja+Sq1LqA2SuTvZjBLCeDD/QLNqkr+J7
         hVNX+2XdI1FlKXFawCk6gERObuCvwRD6MTF7Tm1kmY2hRr7A+bMLFfcmQHgCNx485tT/
         gOhrCK/bia1mhGwgcNEwGNRb4CjSf9drYXxYfLBjKu2vamvDxbQciuE0DQ0t6ftYdQI1
         n+FjGi6Bkqjis9iIOpnv33VeRpSK6798sY8uVD6lstkmvvxaktFSHjXmBlcBNSLDa5qh
         USOA==
X-Gm-Message-State: AOAM531FFTldwqPmKyl0P1Mg+ZZQfoRmWg+SHZC3ySSAavO2rq3G0e8T
        ydCIXB5s1VZXc9g18kLuwde/rXcBhyn0+01WWFWjhIy3HmfJ4SockA3Sq1CYWPcmx8jdsYUOvLh
        ZY3EhP2+0DNUrqGKrkFvR
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr8928270wma.186.1624604979081;
        Fri, 25 Jun 2021 00:09:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEZC10pOGlNPzeVGtuSNOzeepcf5gnuWto136WmaedGGkMX3t/mR9Y/5SHRge1PZWfwCJHYw==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr8928243wma.186.1624604978853;
        Fri, 25 Jun 2021 00:09:38 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id i18sm1603468wrw.55.2021.06.25.00.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 00:09:38 -0700 (PDT)
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
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210624224040.GA3567297@bjorn-Precision-5520>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <5bee3702-595b-f57b-f962-28644b7e646f@redhat.com>
Date:   Fri, 25 Jun 2021 09:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624224040.GA3567297@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On 6/25/21 12:40 AM, Bjorn Helgaas wrote:
> [+cc Michal, Ley Foon, Jingoo, Thierry, Jonathan]
> 
> On Tue, Jun 08, 2021 at 10:04:09AM +0200, Javier Martinez Canillas wrote:
>> IRQ handlers that are registered for shared interrupts can be called at
>> any time after have been registered using the request_irq() function.
>>
>> It's up to drivers to ensure that's always safe for these to be called.
>>
>> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
>> their handlers are registered very early in the probe function, an error
>> later can lead to these handlers being executed before all the required
>> resources have been properly setup.
>>
>> For example, the rockchip_pcie_read() function used by these IRQ handlers
>> expects that some PCIe clocks will already be enabled, otherwise trying
>> to access the PCIe registers causes the read to hang and never return.
>>
>> The CONFIG_DEBUG_SHIRQ option tests if drivers are able to cope with their
>> shared interrupt handlers being called, by generating a spurious interrupt
>> just before a shared interrupt handler is unregistered.
>>
>> But this means that if the option is enabled, any error in the probe path
>> of this driver could lead to one of the IRQ handlers to be executed.
> 
> I'm not an IRQ expert, but I think this is an issue regardless of
> CONFIG_DEBUG_SHIRQ, isn't it?  Anything used by an IRQ handler should
> be initialized before the handler is registered.  CONFIG_DEBUG_SHIRQ
> is just a way to help find latent problems.
>

Yes, it's an issue regardless. It's just that this debug option tests if the
drivers aren't making the wrong assumption, exactly to find issues like this.

>> In a rockpro64 board, the following sequence of events happens:
>>
>>   1) "pcie-sys" IRQ is requested and its handler registered.
>>   2) "pcie-client" IRQ is requested and its handler registered.
>>   3) probe later fails due readl_poll_timeout() returning a timeout.
>>   4) the "pcie-sys" IRQ is unregistered.
>>   5) CONFIG_DEBUG_SHIRQ triggers a spurious interrupt.
>>   6) "pcie-client" IRQ handler is called for this spurious interrupt.
>>   7) IRQ handler tries to read PCIE_CLIENT_INT_STATUS with clocks gated.
>>   8) the machine hangs because rockchip_pcie_read() call never returns.
>>
>> To avoid cases like this, the handlers don't have to be registered until
>> very late in the probe function, once all the resources have been setup.
>>
>> So let's just move all the IRQ init before the pci_host_probe() call, that
>> will prevent issues like this and seems to be the correct thing to do too.
> 
> Previously we registered rockchip_pcie_subsys_irq_handler() and
> rockchip_pcie_client_irq_handler() before the PCIe clocks were
> enabled.  That's a problem because they depend on those clocks being
> enabled, and your patch fixes that.
>
> rockchip_pcie_legacy_int_handler() depends on rockchip->irq_domain,
> which isn't initialized until rockchip_pcie_init_irq_domain().
> Previously we registered rockchip_pcie_legacy_int_handler() as the
> handler for the "legacy" IRQ before rockchip_pcie_init_irq_domain().
> 
> I think you patch *also* fixes that problem, right?
>

Correct, that's why I moved the initialization and IRQ enable after that.
 
> I think this is also an issue with the following other drivers.  They all
> set the handler to something that uses an IRQ domain before they
> actually initialize the domain:

Yes, I agreed with your assessment and also noticed that others drivers have
similar issues. I just don't have any of those platforms to try to reproduce
the bugs and test a fix.

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

