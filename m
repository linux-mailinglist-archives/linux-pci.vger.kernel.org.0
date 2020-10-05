Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7771282EF7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 04:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJECxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 22:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 22:53:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D6C0613CE
        for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2020 19:53:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so5034365pgm.11
        for <linux-pci@vger.kernel.org>; Sun, 04 Oct 2020 19:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HHMTKnBxL0N7bXcNK+GerHSHtiDck53Y2/0CunSw/j4=;
        b=psYh+c5OvwhMBJLg5EuPKeRmIBKGCwEgwqb40xvWojEXm8dpRAY47wVW+8BouFoi9b
         yTQToj8e3jTE5/68dGYGhvS5Ac7dIh6DlK/Qbo5z+SbfqYepDej8ua1vGsq9xVt5nXBp
         vaEqZZ/P2Lsj3Zb/7uxjTsGCn0wIR+n6kwjcYQ82RTmVTIOoDxaN8EzFwDMD5qaFWSVt
         jrsagswwg6WaIk7fS+GHbGEGpCMbOoxtm2yfwmSI4mU77YJwpMfJ+L85nIbuSWfzGWdR
         vzXwWwDLa/0xSfPswGgxi0VtwSJfeReA6V5szkE0CZgyA9CLOtby8HGN+p4Vn9UT55AP
         ZKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HHMTKnBxL0N7bXcNK+GerHSHtiDck53Y2/0CunSw/j4=;
        b=NGdtIowxY6gUbXomIab+sNQxeUcUavydpRBB/X6ZAKM4qsxbtda0C+lIuGGLPVkC6F
         qoau+wNl2Dag+dJNg3RDtFmu3rZiHILggk0tKqHXaET4W4SuEMPuls6L6Uy4Ej1dYy+Y
         vgLc9QXzKOBMj95trto7YMlt55PlQBBWMIxR99wRiUu0kwC+5rVK027T6p1qj5OaNfA3
         dT3ju29fLkMkwSOs1fweiBROliN+Gh9mm4oZnHJaSN31rZs3B4HTKYMN5Hz00/8MMRlr
         VXVZXJJ3k11f2jujs5xEczBZ2sF6wQWWto/pI3xGq3GT9zAHqlkrAKhsBeLmxOqpLbyP
         FqYQ==
X-Gm-Message-State: AOAM5310XCO2vV6I2en7DAwT6ZZb9bUTn4Qp1/Hat7fm/UCdZj1bXCde
        zaedq2o63Cqmfku7DxGRKMw=
X-Google-Smtp-Source: ABdhPJw3dGTnpgAGQ4msGFDJmgnKlpAKJK8vgVUn8Vr7RE+6KO5inwYtl/zAiU1GYZUbGZnYjoCD6A==
X-Received: by 2002:a63:4457:: with SMTP id t23mr12196361pgk.108.1601866389332;
        Sun, 04 Oct 2020 19:53:09 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id j1sm4317047pfj.202.2020.10.04.19.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 19:53:08 -0700 (PDT)
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201005003805.465057-1-kw@linux.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v4] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <429099a8-5186-40c3-f5c0-f219b3e79f01@gmail.com>
Date:   Sun, 4 Oct 2020 19:53:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201005003805.465057-1-kw@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/4/2020 5:38 PM, Krzysztof Wilczyński wrote:
> Unify ECAM-related constants into a single set of standard constants
> defining memory address shift values for the byte-level address that can
> be used when accessing the PCI Express Configuration Space, and then
> move native PCI Express controller drivers to use newly introduced
> definitions retiring any driver-specific ones.
> 
> The ECAM ("Enhanced Configuration Access Mechanism") is defined by the
> PCI Express specification (see PCI Express Base Specification, Revision
> 5.0, Version 1.0, Section 7.2.2, p. 676), thus most hardware should
> implement it the same way.  Most of the native PCI Express controller
> drivers define their ECAM-related constants, many of these could be
> shared, or use open-coded values when setting the .bus_shift field of
> the struct pci_ecam_ops.
> 
> All of the newly added constants should remove ambiguity and reduce the
> number of open-coded values, and also correlate more strongly with the
> descriptions in the aforementioned specification (see Table 7-1
> "Enhanced Configuration Address Mapping", p. 677).
> 
> There is no change to functionality.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---

[snip]

>   
> -/* Configuration space read/write support */
> -static inline int brcm_pcie_cfg_index(int busnr, int devfn, int reg)
> -{
> -	return ((PCI_SLOT(devfn) & 0x1f) << PCIE_EXT_SLOT_SHIFT)
> -		| ((PCI_FUNC(devfn) & 0x07) << PCIE_EXT_FUNC_SHIFT)
> -		| (busnr << PCIE_EXT_BUSNUM_SHIFT)
> -		| (reg & ~3);
> -}
> -
>   static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>   					int where)
>   {
> @@ -590,7 +578,7 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
>   		return PCI_SLOT(devfn) ? NULL : base + where;
>   
>   	/* For devices, write to the config space index register */
> -	idx = brcm_pcie_cfg_index(bus->number, devfn, 0);
> +	idx = PCIE_ECAM_BUS(bus->number) | PCIE_ECAM_DEVFN(devfn);

This appears to be correct, so:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

however, I would have defined a couple of additional helper macros and do:

	idx = PCIE_ECAM_BUS(bus->number) | PCIE_ECAM_DEV(devfn) | 
PCIE_ECAM_FUN(devfn);

for clarity.

[snip]

> +/*
> + * Memory address shift values for the byte-level address that
> + * can be used when accessing the PCI Express Configuration Space.
> + */
> +
> +/*
> + * Enhanced Configuration Access Mechanism (ECAM)
> + *
> + * See PCI Express Base Specification, Revision 5.0, Version 1.0,
> + * Section 7.2.2, Table 7-1, p. 677.
> + */
> +#define PCIE_ECAM_BUS_SHIFT	20 /* Bus Number */
> +#define PCIE_ECAM_DEV_SHIFT	15 /* Device Number */
> +#define PCIE_ECAM_FUN_SHIFT	12 /* Function Number */
> +
> +#define PCIE_ECAM_BUS(x)	(((x) & 0xff) << PCIE_ECAM_BUS_SHIFT)
> +#define PCIE_ECAM_DEVFN(x)	(((x) & 0xff) << PCIE_ECAM_FUN_SHIFT)

For instance, adding these two:

#define PCIE_ECAM_DEV(x)		(((x) & 0x1f) << PCIE_ECAM_DEV_SHIFT)
#define PCIE_ECAM_FUN(x)		(((x) & 0x7) << PCIE_ECAM_FUN_SHIFT)

may be clearer for use in drivers like pcie-brcmstb.c that used to treat 
the device function in terms of device and function (though it was 
called slot there).
-- 
Florian
