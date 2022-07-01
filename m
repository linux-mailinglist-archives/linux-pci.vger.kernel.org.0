Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA0563B75
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiGAU65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAU65 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 16:58:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CAE68A11;
        Fri,  1 Jul 2022 13:58:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n10so2677342qkn.10;
        Fri, 01 Jul 2022 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qjEIvhF5OlXSbXMbrdjH4oBXqjY7AyocItVAB4DWZ+g=;
        b=MLi1DwcFJ14LFBhvXTvuddrcClEKaODysYl/pU/hhXANX/v+cJmboUXA7iQMr64BoV
         rZxMl30TrgBpJZMuQKkmD2YOE3pyzZMSx35gaIB0+LrENO2bP7Uxfi8jL8w5oU+wr//h
         bZUTUHrfBkhRvVygGSyyX4IzWJz7TJpo7J+OxpMIkdH3Lq2ISDhR+0wdmNCOtbcBMB4D
         Wwp6oAslSj63wIhoXrdnnLzf0WMUWlWNgdUggJJ2dJ3zKvT9u1i0A/Bvp+x2brQ9kyoM
         cEJe3/TKcGAel0K3M4L26lPw6iMB4f8rKAX/7hjX4rs5cMsyqWJZHn4WF6wvRKRUPSHj
         czDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qjEIvhF5OlXSbXMbrdjH4oBXqjY7AyocItVAB4DWZ+g=;
        b=H5VsKzWi0h3GPU0i5Z3HF0DDIBaReiRuKsMviU8ywe3tlFUbKNEKm/GAoVAB7x8E3D
         JFPPKEXhHBzUHSlvb2U0WsnJhzrpTDR1qIJe79T0iAKm3p61AX1trqXW/GZDCFHVZqWN
         ieROpLLXs2nxP+1hbL9tNeG7lSiuIvNrj0xa/6MSEw2/oABvJg8PZuTeaU576BUxPIQl
         WVjd2efsZ43KVvWTOJc7SIbZHKHUkFBh2OwM/yLWl7Gw5wm2IvALvJwFSdgdMnPgzc4W
         +Fk5sBx3/xxuQD8Ff23MM55/UnxYUEGK4/cec7uh2bfPh9uXd7MxqFd94X9/3Y0iyb9A
         12eQ==
X-Gm-Message-State: AJIora+Rw5gnikoQM1RpBD3hiTB05zc5zb5D4pTHabPA26J/Oqr43sq8
        CE7rNiQnAqXficgQ5LZG250=
X-Google-Smtp-Source: AGRyM1tJd4PvpQ1x+MXRqgK6imhG1nM0mQQOAFtcueeW/mKH/Nk8DXjKTZ5n/YYG4ygrQP2hz1aH8w==
X-Received: by 2002:a37:48b:0:b0:6af:2c49:1598 with SMTP id 133-20020a37048b000000b006af2c491598mr11927612qke.121.1656709134767;
        Fri, 01 Jul 2022 13:58:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o4-20020ac87c44000000b003164efd0a5fsm3650966qtv.41.2022.07.01.13.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 13:58:54 -0700 (PDT)
Message-ID: <1a50e8b0-1453-4561-bc3d-c428bb65288a@gmail.com>
Date:   Fri, 1 Jul 2022 13:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20220701162726.31346-1-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220701162726.31346-1-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/1/22 09:27, Jim Quinlan wrote:
> A submission [1] was made to enable a PCIe root port to turn on regulators
> for downstream devices.  It was accepted.  Months later, a regression was
> discovered on an RPi CM4 [2].  The patchset was reverted [3] as the fix
> came too late in the release cycle.  The regression in question is
> triggered only when the PCIe RC DT node has no root port subnode, which is
> a perfectly reasonsable configuration.
> 
> The original commits are now being resubmitted with some modifications to
> fix the regression.  The modifcations on the original commits are
> described below (the SHA is that of the original commit):
> 
> [830aa6f29f07  PCI: brcmstb: Split brcm_pcie_setup() into two funcs]
>      NOTE: In the originally submitted patchset, this commit introduced a
>      regression that was corrected by a subsequent commit in the same
>      patchset.  Let's not do this again.
> 
>      @@ -1411,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
> 	    if (ret)
> 		    goto fail;
> 
>      +       ret = brcm_pcie_linkup(pcie);
>      +       if (ret)
>      +               goto fail;
> 
> 
> [67211aadcb4b  PCI: brcmstb: Add mechanism to turn on subdev regulators]
>      NOTE: Not related to the regression, the regulators must be freed whenever
>      the PCIe tree is dismantled:
> 
>      @@ -507,6 +507,7 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
> 
>      if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
> 		    dev_err(dev, "failed to disable regulators for downstream device\n");
>      +       regulator_bulk_free(sr->num_supplies, sr->supplies);
> 	    dev->driver_data = NULL;
> 
> 
> [93e41f3fca3d  PCI: brcmstb: Add control of subdevice voltage regulators]
>      NOTE: If the PCIe RC DT node was missing a Root Port subnode, the PCIe
>      link-up was skipped.  This is the regression.  Fix it by attempting
>      link-up even if the Root Port DT subnode is missing.
> 
>      @@ -503,11 +503,10 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
> 
>       static int brcm_pcie_add_bus(struct pci_bus *bus)
>       {
>      -       struct device *dev = &bus->dev;
> 	    struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
> 	    int ret;
> 
>      -       if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
>      +       if (!bus->parent || !pci_is_root_bus(bus->parent))
> 		    return 0;
> 
> 	    ret = pci_subdev_regulators_add_bus(bus);
> 
> [1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=215925
> [3] https://lore.kernel.org/linux-pci/20220511201856.808690-1-helgaas@kernel.org/

On a Raspberry Pi 4B:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
