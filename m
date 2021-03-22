Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1234418A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 13:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCVMeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhCVMdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 08:33:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB20BC061763
        for <linux-pci@vger.kernel.org>; Mon, 22 Mar 2021 05:33:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x21so19094068eds.4
        for <linux-pci@vger.kernel.org>; Mon, 22 Mar 2021 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SVanQr0nOKD358IYkjRAx3PCoRE9oI5X2zMEqx499hk=;
        b=In/2zB5DflwheyajBKF2sx8W9MNDzsh1OSXWuUfKtL/FRN8c9FQQ2cj+JpRaMJ8aAU
         XCEdMl5E1nKXsJ7LPr/dtmRUfPx5+I1x5doeJjGnHJs2u9wPfhjKCteG52TK/mXsWmp0
         r9Anh7nKKI7VMsuXAdYXcsCGpZElkzpp47nt0czliuc/sgnYDu/CCcQloeUW02Hubge7
         sWrpe/oCUN6WhcZa9kKsbPAqAXLDiS1XaNnARw1txUwxLHGsZeVRD+wmAVt2sQW9eS55
         UyTJMvhgC22uRmJJA3ffzwFbfulqEQ+Y37qGJg3epzU8Qv8Y9P3aSJ9V5kCcRG0/y2iv
         oQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SVanQr0nOKD358IYkjRAx3PCoRE9oI5X2zMEqx499hk=;
        b=S0ULSSXiDx/F+RRD6m6ATy92xSeWamV/MRMs3PXAR7bQGQgon+RgDtKOanD8cg7NTx
         MmDb7JyB6n68JIpaLq1cYFF515RzJK4jwO5bbrIq9UTI0PxpWH4n88wK+Auxkj8W6myA
         1i/rbqbemaamHSnhEgQmYzYFuFdkfDCPJrGy8+lo/8o6nMQzclaKM+n1lEnopTuwV7E+
         2Si30Yw8lQI6csIqYqXCksWOtkk/FP+toqSWBlAQgRYrn43WCDY61s+YFeoCmL0TlQb2
         E7fc9mtApbQNvPQHGuLlHPrkUtcGw+bsSugMd2QYwEjxLhPY9Mp9GDdHwBISzZ1zun8y
         4Q5w==
X-Gm-Message-State: AOAM530z/ub1xohdPnoG4U9acyfi7s/LPZnoIhJ2fW0qHHDtSucK68oT
        jfCCCosoyOt7doc7aapZomnD0A==
X-Google-Smtp-Source: ABdhPJzU8lxBAEHdWAbezgHwbSa71swddR2DYb7EY4LfoVvJcbMJx1acYwfadWxsyNH4XNxBLRVo6A==
X-Received: by 2002:a50:f391:: with SMTP id g17mr25306211edm.26.1616416392520;
        Mon, 22 Mar 2021 05:33:12 -0700 (PDT)
Received: from ?IPv6:2a02:768:2307:40d6::e05? ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id t27sm9618783ejc.62.2021.03.22.05.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 05:33:12 -0700 (PDT)
Subject: Re: [PATCH 03/13] PCI: xilinx: Convert to MSI domains
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, michal.simek@xilinx.com
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
References: <20210225151023.3642391-1-maz@kernel.org>
 <20210225151023.3642391-4-maz@kernel.org>
 <20210322122100.GA11469@e121166-lin.cambridge.arm.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <74cffc38-df12-7d92-1bfe-20eed4b60e86@monstr.eu>
Date:   Mon, 22 Mar 2021 13:33:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322122100.GA11469@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/22/21 1:21 PM, Lorenzo Pieralisi wrote:
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
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/pci/controller/Kconfig       |   2 +-
>>  drivers/pci/controller/pcie-xilinx.c | 238 +++++++++++----------------
>>  2 files changed, 96 insertions(+), 144 deletions(-)
> 
> Michal,
> 
> can you please test these changes or make sure someone does and report
> back on the mailing list please ?
> 
> I would like to merge this series for v5.13.

I got just private response (not sure why) from Bharat March 5 that
changes are fine.
It means go ahead with it.

Thanks,
Michal

