Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587F2279FA5
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgI0I3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgI0I3b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Sep 2020 04:29:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3288C0613CE;
        Sun, 27 Sep 2020 01:29:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b12so7570130lfp.9;
        Sun, 27 Sep 2020 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V33RT38C7JywN/NCrjXz/c1rVEezgzzsKltw64VVgPU=;
        b=FLyvjJr+5MEtMLwH3/U2QHeU/vD6684ct7HfnfFb4wWf9wWyPDrI4GdBhEiPa2hmSI
         wLs8l5I4c1jkdhpc2CvAOdDBGsRIXmoLR71rMWMm9OborEIo34CW3e78DESaV7RJcslv
         IrsYI6ymqx21t5J32erPGdy2w+tZpOPfdMfdHnnqw2jDxc0hal/FwfEdsn1rxyLpuDl/
         6ObhsEtkm4iqwHV7YcyF8x5YvT8baU3Hl+3p6ETCNjKrClU0ks4JbhhM57N5Hgg5710X
         cvzWcJjl+H+LTOMNVjqMAEZd9yC4xkeVIFDHrzB11zjKqW3xGZxEqCKLFZRFESp3tQVE
         ngPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V33RT38C7JywN/NCrjXz/c1rVEezgzzsKltw64VVgPU=;
        b=VtDCvDQ+Y/KBWuBBWYm/v9EXh7jezRcKtWs5hCZyHpVl9OfbY+ozStkqezDh/PnuUE
         +KH32N54zmPfSrfhWpivQcJ0OpjdL04FqoJ9G+RWi29K8pl6m5Fnx9cdOl7pkyrDoXLu
         ZABiR7eE3qZeIcjZqj63RNlC5tsShtmRDIEQvjIyUkEtNpVnsQfbW876kNS7rIhFdh8S
         5fEc7S9z+KDmZaMvOOeR0fHc8r2h6ZULag9e2X6EITiAcxplTIqyAtIPACpKVrDxXN0o
         iu2fTXUbVMgPIGhDsG1ioTTd/F9+X8dPf0SrjoFzYefiV18Drh5madmwkJ9jUK3T7MC+
         f9tQ==
X-Gm-Message-State: AOAM533TAPCYKsVB4qCzhqVZA/QLt/xzqvqqWBi1uFHCSix36MtlQrht
        9DKm5yiv10d7onOQfjrxi9EMc3+iviatJw==
X-Google-Smtp-Source: ABdhPJyeOd4qoeERX8/hsjE+QCOWIQquXl3QZcT4YMFReCg6DyQVlTNv42Y06U7gRqQ7XagdJV0ieA==
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr2060649lfl.573.1601195368535;
        Sun, 27 Sep 2020 01:29:28 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:469c:53c3:78a2:dd7e:1a3c:8259? ([2a00:1fa0:469c:53c3:78a2:dd7e:1a3c:8259])
        by smtp.gmail.com with ESMTPSA id l29sm2359183lfp.11.2020.09.27.01.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 01:29:28 -0700 (PDT)
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     marek.vasut@gmail.com, linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20200926160934.136182-1-marek.vasut@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <7ce58972-2946-0107-2298-c5a6f6e12feb@gmail.com>
Date:   Sun, 27 Sep 2020 11:29:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926160934.136182-1-marek.vasut@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 26.09.2020 19:09, marek.vasut@gmail.com wrote:

> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> While the controller can enter and exit L0s link state, and exit L1
> link state, without any additional action from the driver, to enter
> L1 link state, the driver must complete the link state transition by
> issuing additional commands to the controller.
> 
> The problem is, this transition is not atomic. The controller sets
> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
> the PCIe card, but then the controller enters some sort of inbetween
> state. The driver must detect this condition and complete the link
> state transition, by setting L1IATN bit in PMCTLR and waiting for
> the link state transition to complete.
> 
> If a PCIe access happens inside of this window, where the controller

     s/of//.

> is inbetween L0 and L1 link states, the access generates a fault and

    My spellchecker trips on "inbetween"...

> the ARM 'imprecise external abort' handler is invoked.
> 
> Just like other PCI controller drivers, here we hook the fault handler,
> perform the fixup to help the controller enter L1 link state, and then
> restart the instruction which triggered the fault. Since the controller

    If this is imprecise or async external abort, how we can re-execute the 
instruction that triggered the fault? It's been probably executed already, no?

> is in L1 link state now, the link can exit from L1 link state to L0 and
> successfully complete the access.
> 
> Note that this fixup is applicable only to Aarch32 R-Car controllers,
> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
[...]
> +static int __init rcar_pcie_init(void)
> +{
> +#ifdef CONFIG_ARM_LPAE
> +	hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +			"asynchronous external abort");
> +#else
> +	hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +			"imprecise external abort");
> +#endif
> +	return platform_driver_register(&rcar_pcie_driver);
> +}
> +device_initcall(rcar_pcie_init);
> +#else
>   builtin_platform_driver(rcar_pcie_driver);
> +#endif
[...]

MBR, Sergei
