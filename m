Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214A53441AC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 13:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCVMfP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhCVMd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 08:33:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86F1C0613DB
        for <linux-pci@vger.kernel.org>; Mon, 22 Mar 2021 05:33:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bf3so19122913edb.6
        for <linux-pci@vger.kernel.org>; Mon, 22 Mar 2021 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bFXSCk7jXzi1oDqUKnupFbkdc1ED5SojZj7S5YlWylo=;
        b=Nb6vq2/ii4Uu5XEatx9s0w0vyMHBFNdJ9XkyhRXQRTYCa2DlOgNpuMLBtGI32mU4LR
         mM7dCOyOsSQiBYx78D9Tou6WPJCLVJK2++P19JKJpLnY6jpQoN++z2bIdKzEKPwiTfB8
         flKUIx/jPAbEh+WGHPcfHxffQaeLfuKX6yZiKFKqfDTbAz9SFCQqpEeOUdO2QyBtYKaB
         Oaywbong+u/EvIZ1Ewmyy2wctKFSPqSSpRnb2lmoQ1pHGjZFL4kuL558WSZeqj9KAhZv
         uvC/l92Hw9hGqb+CsWq5oYBUh8+QoyxagBJkBo5OWb8T+4+67ScVqWdqIvHbdZ1sM5Rt
         FeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFXSCk7jXzi1oDqUKnupFbkdc1ED5SojZj7S5YlWylo=;
        b=WZWFD3LTR9MY6Vdljv5HWdJYsQqfFxDHNphpBc8NzmC2aF84z6Sv9HSJm0Ucj03ht9
         BQKZwCO1EPUmOj+0skZY/9k7K3UoE+vjTrU2t7+IHFUlS8UZsn4G0OeJluZvWv5EaY/O
         8Wg81ntsvn+4i6P9A3Qxz3fEayE7OC4CxA/1y1sgiT/VSzpm/6AKsn5nM9lVyIrHk53t
         kdQPbaTqlt3CUKrJL3YCLv9tYanFgcbsKe60RnEek1sZTmDfUUr5d2HFaoAlE8qb9PAP
         rKSUsTKnKWtABSjw8zf6uOATUybpUS4uphrB1vNO/HJRBhjIHyXbgoQGlLBy+2ab6Oc5
         /61g==
X-Gm-Message-State: AOAM530NvdI3/1HHs47R0+saZiCQJ+EGfX3lweP94uGZqr6AezioFgPe
        qdlGG+79ofmBdgakeoBHqSHPHQ==
X-Google-Smtp-Source: ABdhPJxjAmo2ovKlm60IvoJxky+iKUF6BuDJdKXWp1pzrvgmxzgCNEarFOfUlp+DzNDRON+cPs/jug==
X-Received: by 2002:a50:fc94:: with SMTP id f20mr25432235edq.370.1616416409440;
        Mon, 22 Mar 2021 05:33:29 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id q10sm11247181eds.67.2021.03.22.05.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 05:33:29 -0700 (PDT)
Subject: Re: [PATCH 03/13] PCI: xilinx: Convert to MSI domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-4-maz@kernel.org>
 <20210322122315.GB11469@e121166-lin.cambridge.arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <a9fee2d4-5810-7a16-78bc-4b192e1123dc@monstr.eu>
Date:   Mon, 22 Mar 2021 13:33:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322122315.GB11469@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/22/21 1:23 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 25, 2021 at 03:10:13PM +0000, Marc Zyngier wrote:
>> In anticipation of the removal of the msi_controller structure, convert
>> the ancient xilinx host controller driver to MSI domains.
>>
>> We end-up with the usual two domain structure, the top one being a
>> generic PCI/MSI domain, the bottom one being xilinx-specific and handling
>> the actual HW interrupt allocation.
>>
>> This allows us to fix some of the most appaling MSI programming, where
>> the message programmed in the device is the virtual IRQ number instead
>> of the allocated vector number. The allocator is also made safe with
>> a mutex. This should allow support for MultiMSI, but I decided not to
>> even try, since I cannot test it.
>>
>> Also take the opportunity to get rid of the cargo-culted memory allocation
>> for the MSI capture address. *ANY* sufficiently aligned address should
>> be good enough, so use the physical address of the xilinx_pcie_host
>> structure instead.
> 
> I'd agree with Bjorn that the MSI doorbell change is better split into
> a separate patch, I can do it myself at merge if you agree.

Thank you for doing it.

Thanks,
Michal
