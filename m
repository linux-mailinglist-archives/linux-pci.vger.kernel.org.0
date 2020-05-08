Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268331CAEE1
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 15:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgEHNLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730192AbgEHNLx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 09:11:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16E8C05BD43;
        Fri,  8 May 2020 06:11:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so1761245wre.13;
        Fri, 08 May 2020 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6PwKC0GGKuK1AQCcfQJuTFB4k9S8lgpVMeQgt9tC7M=;
        b=sqIriFNWfo+C01cQSiy2PlZsONvClgfMh/XyGoUm/jLV/eavxNsd/+2a5uGsdcB44r
         08CaTwxdgLKC2JffT68IPYyTue5HyS9eH7ikLBpla/57s3BTJ+4xsSdXN4lB3na5eevA
         CU52bAJODnMyBLF4UKg3SNbnLnbTZ5SKthIznITkqTJXinHtcLkbRNX8JReg1QaupdQV
         cDrc6R8rX2Vhblj5n5irkd+lIEr+EzDpTuCZr0XiosydNi7WpW6h0IwUd6FVtjb21Pio
         4DCv5Y4bL+ZpYojiw9dEDJSTyH/Fp/ehE9FQ9AlEMv3hxGbM+I53QvUWJ1w+FrKvEuyX
         0eaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6PwKC0GGKuK1AQCcfQJuTFB4k9S8lgpVMeQgt9tC7M=;
        b=mb/gXF7O61HCOv4YtEn3mhuGnkbDvQOs7KaPX0JineUjtEeer+ZLz6ejbAgVcSX8D6
         teDefBB4Hu1r7tAWxU4oXTjzsYIMYkTioOeA/S5RT7CD7I+89yssEblEW0X5lqi1mJhv
         FJlT7k7Z2c1yZQXl0JMCSu17fAtQ+fwsfvRm8DdiUNNuqh9LCrU8KS2DMmYAYLCxzJ+U
         nICeNwndIX9HK0/Kc/4dstNYTYioTZJb7c+5d6kxqUVol9VwJz/DW8xkGUYkly9w739Q
         TblMDIA5QnjAvhoVWAkAmjLyKHkS6Jx3Lg4qJHS3gakkgvA8ZOTcle4DHMmVwSWo84xS
         KZZQ==
X-Gm-Message-State: AGi0PuYebcIvlEKFcb082/srDUGTRoxTHokwnjUmvuD9Mdt8Rf0dGHR7
        BQ0aDVrL0WX86h7qjuMj1hE2dQ8OVMNUu0sM
X-Google-Smtp-Source: APiQypIDsTyVBV8sQuS/K/6cCNcKKifc+7wFf6IB98XX1bm8I0BIRm6w640Gs6sWGa5I5em0HqkaiA==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr2830699wrp.325.1588943511317;
        Fri, 08 May 2020 06:11:51 -0700 (PDT)
Received: from [10.8.0.6] ([5.2.67.190])
        by smtp.gmail.com with ESMTPSA id 88sm3139115wrq.77.2020.05.08.06.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 06:11:50 -0700 (PDT)
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200430080625.26070-1-pali@kernel.org>
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
Message-ID: <6ff6d161-adba-9e5c-5a4a-1bfa49de0fc4@gmail.com>
Date:   Fri, 8 May 2020 15:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W dniu 30.04.2020 o 10:06, Pali Rohár pisze:
> Hello,
> 
> this is the fourth version of the patch series for Armada 3720 PCIe
> controller (aardvark). It's main purpose is to fix some bugs regarding
> buggy ath10k cards, but we also found out some suspicious stuff about
> the driver and the SOC itself, which we try to address.
> 
> Patches are available also in my git branch pci-aardvark:
> https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
> 
> Changes since v3:
> - do not change return value of of_pci_get_max_link_speed() function
> - mark zero 'max-link-speed' as invalid
> - silently use gen3 speed when 'max-link-speed' as invalid
> 
> Changes since v2:
> - move PCIe max-link-speed property to armada-37xx.dtsi
> - replace custom macros by standard linux/pci_regs.h macros
> - increase PERST delay to 10ms (needed for initialized Compex WLE900VX)
> - disable link training before PERST (needed for Compex WLE900VX)
> - change of_pci_get_max_link_speed() function to signal -ENOENT
> - handle errors from of_pci_get_max_link_speed() function
> - updated comments, commit titles and messages
> 
> Changes since v1:
> - commit titles and messages were reviewed and some of them were rewritten
> - patches 1 and 5 from v1 which touch PCIe speed configuration were
>   reworked into one patch
> - patch 2 from v1 was removed, it is not needed anymore
> - patch 7 from v1 now touches the device tree of armada-3720-db
> - a patch was added that tries to enable PCIe PHY via generic-phy API
>   (if a phandle to the PHY is found in the device tree)
> - a patch describing the new PCIe node DT properties was added
> - a patch was added that moves the PHY phandle from board device trees
>   to armada-37xx.dtsi
> 
> Marek and Pali
> 
> Marek Behún (5):
>   PCI: aardvark: Improve link training
>   PCI: aardvark: Add PHY support
>   dt-bindings: PCI: aardvark: Describe new properties
>   arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio function
>   arm64: dts: marvell: armada-37xx: Move PCIe comphy handle property
> 
> Pali Rohár (7):
>   PCI: aardvark: Train link immediately after enabling training
>   PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
>     read-only register
>   PCI: of: Zero max-link-speed value is invalid
>   PCI: aardvark: Issue PERST via GPIO
>   PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG access
>   PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
>     macros
>   arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed property

Hi.
The PCI interface seems to work fine as in the first series, so

Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>

-- 
TMN
