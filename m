Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B256790A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 23:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiGEVAL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGEVAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 17:00:10 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2AB70;
        Tue,  5 Jul 2022 14:00:09 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id i11so15594608qtr.4;
        Tue, 05 Jul 2022 14:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vcs2J2koXt5O4RSuShYBHdUW1jRgrQ5hJpRCB/pXcoE=;
        b=VJJoHuBykHZEAIU8sBqGBDpW2ZnicplMXNyikl1ZTuB0SMoT0ZfYx9UkWx+oL3sCOu
         +P6lpiOa7RqZ9ups99PwRTeZuoWTgbd6/+eUT3nC5IjcGkFGa39cfj+oAMt5a7mCPvp9
         GxnaMdNumrd4IBjDMbUJb1sXiBYYsrIY+0pmmhKDOxlppsvKQTUenJSy7CqBTtBLPBBE
         042Aw8KiXlAFydX47Rx6C812GUMUY2XgwwfI+pNCOgE+om8iSphXQraPSCigTGMZw+sm
         PhkzGuvtqfGjWlSVtjfi3S8XeNrgpg+yHwG6sgaqKkg8mTKf7H/GYYWi0Brut4s5FiTP
         oJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vcs2J2koXt5O4RSuShYBHdUW1jRgrQ5hJpRCB/pXcoE=;
        b=zJ/05kgIssSZKhehtvboFz0/EWbeAKJvsALaYfZ0tVanOWcxktNtK1WzTPnOraoABM
         4E0h09F+fC4fQjWSQvt5KlRYvLjabtpWch9ewB+xzS37FqMJ1bbz4gM7ogqzElxFQgWI
         Znq9PT5HmIDGC4cSTmE5ab/LIaUwXHlcdpgePaRB9gT3ns6hP9/JtBZlx0BYPLlDd46r
         nWln783T77CIQoKGjtW6dx7Pv+XIgQQUVhHLPpCeV8Lxm160IqOmtGjgvFu50GuYAvGi
         O91t+71B4gLbIGkl2wgMd8Y+fUY0NFeDb+3zFd/HCVQain0J7V7CN9gmDmNxTH6qgMBh
         0ICg==
X-Gm-Message-State: AJIora/3y9H3Otwpkf0XYZ2pi0azV+1eUMa+qZsfaEuPoTKv/2CoPCkV
        /PqnBKNV015pz5MKz27iQUE=
X-Google-Smtp-Source: AGRyM1u9Kk4QZdYtB4YjIMI1O9dGRQYc+tFz1eub9fVBSgeLb51G4s/E71mobbSRTPUQx/lxvpaAkw==
X-Received: by 2002:a05:622a:13d1:b0:317:c964:6b1d with SMTP id p17-20020a05622a13d100b00317c9646b1dmr29964520qtk.538.1657054808414;
        Tue, 05 Jul 2022 14:00:08 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id c4-20020a05620a268400b006aee03a95dfsm27649930qkp.124.2022.07.05.14.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 14:00:07 -0700 (PDT)
Message-ID: <68af8b36-76b7-23d2-c689-d05fd62086b1@gmail.com>
Date:   Tue, 5 Jul 2022 14:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 0/4] PCI: brcmstb: Re-submit reverted patchset
Content-Language: en-US
To:     Cyril Brulebois <kibi@debian.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20220701162726.31346-1-jim2101024@gmail.com>
 <1a50e8b0-1453-4561-bc3d-c428bb65288a@gmail.com>
 <20220705205551.phbaqqpgyg3pvtv7@mraw.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220705205551.phbaqqpgyg3pvtv7@mraw.org>
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

On 7/5/22 13:55, Cyril Brulebois wrote:
> Florian Fainelli <f.fainelli@gmail.com> (2022-07-01):
>> On 7/1/22 09:27, Jim Quinlan wrote:
>>> A submission [1] was made to enable a PCIe root port to turn on regulators
>>> for downstream devices.  It was accepted.  Months later, a regression was
>>> discovered on an RPi CM4 [2].  The patchset was reverted [3] as the fix
>>> came too late in the release cycle.  The regression in question is
>>> triggered only when the PCIe RC DT node has no root port subnode, which is
>>> a perfectly reasonsable configuration.
>>>
>>> The original commits are now being resubmitted with some modifications to
>>> fix the regression.  The modifcations on the original commits are
>>> described below (the SHA is that of the original commit):
>>>
>>> [830aa6f29f07  PCI: brcmstb: Split brcm_pcie_setup() into two funcs]
>>>       NOTE: In the originally submitted patchset, this commit introduced a
>>>       regression that was corrected by a subsequent commit in the same
>>>       patchset.  Let's not do this again.
>>>
>>>       @@ -1411,6 +1411,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>>> 	    if (ret)
>>> 		    goto fail;
>>>
>>>       +       ret = brcm_pcie_linkup(pcie);
>>>       +       if (ret)
>>>       +               goto fail;
>>>
>>>
>>> [67211aadcb4b  PCI: brcmstb: Add mechanism to turn on subdev regulators]
>>>       NOTE: Not related to the regression, the regulators must be freed whenever
>>>       the PCIe tree is dismantled:
>>>
>>>       @@ -507,6 +507,7 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
>>>
>>>       if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
>>> 		    dev_err(dev, "failed to disable regulators for downstream device\n");
>>>       +       regulator_bulk_free(sr->num_supplies, sr->supplies);
>>> 	    dev->driver_data = NULL;
>>>
>>>
>>> [93e41f3fca3d  PCI: brcmstb: Add control of subdevice voltage regulators]
>>>       NOTE: If the PCIe RC DT node was missing a Root Port subnode, the PCIe
>>>       link-up was skipped.  This is the regression.  Fix it by attempting
>>>       link-up even if the Root Port DT subnode is missing.
>>>
>>>       @@ -503,11 +503,10 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
>>>
>>>        static int brcm_pcie_add_bus(struct pci_bus *bus)
>>>        {
>>>       -       struct device *dev = &bus->dev;
>>> 	    struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
>>> 	    int ret;
>>>
>>>       -       if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
>>>       +       if (!bus->parent || !pci_is_root_bus(bus->parent))
>>> 		    return 0;
>>>
>>> 	    ret = pci_subdev_regulators_add_bus(bus);
>>>
>>> [1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
>>> [2] https://bugzilla.kernel.org/show_bug.cgi?id=215925
>>> [3] https://lore.kernel.org/linux-pci/20220511201856.808690-1-helgaas@kernel.org/
>>
>> On a Raspberry Pi 4B:
>>
>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> As it stands, CM4 support in master is less than ideal: the mmc issues
> I've mentioned in some earlier discussion are making it very hard to
> draw any definitive conclusions. Soft reboots or cold boots don't seem
> to make a difference: the storage might not show up at all, leading to
> getting dropped into an initramfs shell, or it might show up but further
> accesses can be delayed so much that the system proceeds to booting but
> very slowly, and it might even lead to getting dropped into some
> emergency/maintenance mode.
> 
> This affects both the CM4 Lite variant (no internal storage = SD card in
> the CM4 IO slot) and some CM4 non-Lite variant (with internal storage),
> with messages like this one getting repeated:
> 
>      [  310.105020] mmc0: Timeout waiting for hardware cmd interrupt.
>      [  310.110864] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>      [  310.117390] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00009902
>      [  310.123918] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
>      [  310.130445] mmc0: sdhci: Argument:  0x000001aa | Trn mode: 0x00000000
>      [  310.136971] mmc0: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
>      [  310.143496] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>      [  310.150021] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00007187
>      [  310.156548] mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00018000
>      [  310.163074] mmc0: sdhci: Int enab:  0x00ff0003 | Sig enab: 0x00ff0003
>      [  310.169600] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000001
>      [  310.176126] mmc0: sdhci: Caps:      0x00000000 | Caps_1:   0x00000000
>      [  310.182652] mmc0: sdhci: Cmd:       0x0000081a | Max curr: 0x00000001
>      [  310.189178] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>      [  310.195704] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>      [  310.202230] mmc0: sdhci: Host ctl2: 0x00000000
>      [  310.206728] mmc0: sdhci: ============================================
> 
> That happens with current master (v5.19-rc5-56-ge35e5b6f695d2), with or
> without this patchset.
> 
> That being said, I'm not able to reproduce the showstopper regression
> that I reported against the initial patchset (booting was breaking in
> the very first few seconds), so I suppose it's fine to propose the
> following even if that's somewhat tainted by those mmc issues.

Any chance you can bisect the eMMC issues so we can investigate those 
separately? Thanks!

> 
> 
> With Raspberry Pi CM4 (Lite and non-Lite), mounted on a CM4 IO Board:
>   - with a PCIe to quad-USB board, USB storage and USB keyboard;
>   - without anything in the PCIe slot.
> 
> Tested-by: Cyril Brulebois <cyril@debamax.com>

Thanks!
-- 
Florian
