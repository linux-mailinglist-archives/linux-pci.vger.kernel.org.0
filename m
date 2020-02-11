Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB1158F6F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 14:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgBKNET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 08:04:19 -0500
Received: from foss.arm.com ([217.140.110.172]:45682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728521AbgBKNET (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 08:04:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D941130E;
        Tue, 11 Feb 2020 05:04:18 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 583D83F6CF;
        Tue, 11 Feb 2020 05:04:13 -0800 (PST)
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
 <da4dcdc7-c022-db67-cda2-f90f086b729e@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <aec47903-50e4-c61b-6aec-63e3e9bc9332@arm.com>
Date:   Tue, 11 Feb 2020 13:04:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <da4dcdc7-c022-db67-cda2-f90f086b729e@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-02-11 12:13 pm, Laurentiu Tudor wrote:
[...]
>> This is a known issue about DPAA2 MC bus not working well with SMMU
>> based IO mapping.  Adding Laurentiu to the chain who has been looking
>> into this issue.
> 
> Yes, I'm closely following the issue. I actually have a workaround 
> (attached) but haven't submitted as it will probably raise a lot of 
> eyebrows. In the mean time I'm following some discussions [1][2][3] on 
> the iommu list which seem to try to tackle what appears to be a similar 
> issue but with framebuffers. My hope is that we will be able to leverage 
> whatever turns out.

Indeed it's more general than framebuffers - in fact there was a 
specific requirement from the IORT side to accommodate network/storage 
controllers with in-memory firmware/configuration data/whatever set up 
by the bootloader that want to be handed off 'live' to Linux because the 
overhead of stopping and restarting them is impractical. Thus this DPAA2 
setup is very much within scope of the desired solution, so please feel 
free to join in (particularly on the DT parts) :)

As for right now, note that your patch would only be a partial 
mitigation to slightly reduce the fault window but not remove it 
entirely. To be robust the SMMU driver *has* to know about live streams 
before the first arm_smmu_reset() - hence the need for generic firmware 
bindings - so doing anything from the MC driver is already too late (and 
indeed the current iommu_request_dm_for_dev() mechanism is itself a 
microcosm of the same problem).

> In the mean time, can you try the workaround Leo suggested?

Agreed, I'd imagine the command-line option is probably the best choice 
for these platforms, since it's likely to be easier to set that by 
default in the bootloader than faff with rebuilding generic kernel configs.

Robin.

> [1] https://patchwork.kernel.org/patch/11327667/
> [2] https://patchwork.kernel.org/patch/10967729/
> [3] https://patchwork.kernel.org/cover/11279577/
> 
> ---
> Best Regards, Laurentiu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
