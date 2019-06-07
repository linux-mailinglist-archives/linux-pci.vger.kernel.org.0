Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEAB38BE3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfFGNpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 09:45:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2102 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbfFGNpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2019 09:45:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfa6a850000>; Fri, 07 Jun 2019 06:45:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 06:45:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 06:45:41 -0700
Received: from [10.25.74.159] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 13:45:35 +0000
Subject: Re: [PATCH V8 13/15] phy: tegra: Add PCIe PIPE2UPHY support
To:     Dmitry Osipenko <digetx@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190526043751.12729-1-vidyas@nvidia.com>
 <20190526043751.12729-14-vidyas@nvidia.com>
 <c81c5d42-4292-ba6d-b5ab-afe1a604115f@gmail.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <5a5545c8-9e4c-b459-c40e-9e1c4e5daf5b@nvidia.com>
Date:   Fri, 7 Jun 2019 19:15:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c81c5d42-4292-ba6d-b5ab-afe1a604115f@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559915141; bh=X7YbyMYnPU4o/uuTsDoXMzQCmQIN7PmhE/enZhHNCbs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=razz/z/YkMUuZJAs2q0s0SSZ/bUR5omne4pEFftfOU61dLcPqJXKCsGHE3NcpO35+
         8/F2iY2hVc46KAjY6gmEvqpg5fZ3KSxtuPhgOMOwYKMqeO9JIGY6v17MKg2Or+8u+H
         KlITvD4TlEvUpP4ZaERzjMOe/Uw/MNFgiZuqHAY4aQAOWJUJ1FuVnWa356Z1OJu5RL
         Y6R72p7/fJwuiWR/h3U5Eh8WMG0HEStRFp9Pr9OgZGW/VJAIAyZZoqfbqcIqzCExV0
         phKG+yMITM2HvqQyAOuTLfbzBgJQSbyydm6e2I9WMYP+4QQY+Fq8/03gsOCNAchoQG
         +1xx4qJ63FuHA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/6/2019 10:00 PM, Dmitry Osipenko wrote:
> 26.05.2019 7:37, Vidya Sagar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Synopsys DesignWare core based PCIe controllers in Tegra 194 SoC interfa=
ce
>> with Universal PHY (UPHY) module through a PIPE2UPHY (P2U) module.
>> For each PCIe lane of a controller, there is a P2U unit instantiated at
>> hardware level. This driver provides support for the programming require=
d
>> for each P2U that is going to be used for a PCIe controller.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v7]:
>> * Changed P2U driver file name from pcie-p2u-tegra194.c to phy-tegra194-=
p2u.c
>>
>> Changes since [v6]:
>> * None
>>
>> Changes since [v5]:
>> * Addressed review comments from Thierry
>>
>> Changes since [v4]:
>> * None
>>
>> Changes since [v3]:
>> * Rebased on top of linux-next top of the tree
>>
>> Changes since [v2]:
>> * Replaced spaces with tabs in Kconfig file
>> * Sorted header file inclusion alphabetically
>>
>> Changes since [v1]:
>> * Added COMPILE_TEST in Kconfig
>> * Removed empty phy_ops implementations
>> * Modified code according to DT documentation file modifications
>>
>>   drivers/phy/tegra/Kconfig            |   7 ++
>>   drivers/phy/tegra/Makefile           |   1 +
>>   drivers/phy/tegra/phy-tegra194-p2u.c | 109 +++++++++++++++++++++++++++
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 drivers/phy/tegra/phy-tegra194-p2u.c
>>
>> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
>> index a3b1de953fb7..c56fc8452e03 100644
>> --- a/drivers/phy/tegra/Kconfig
>> +++ b/drivers/phy/tegra/Kconfig
>> @@ -6,3 +6,10 @@ config PHY_TEGRA_XUSB
>>  =20
>>   	  To compile this driver as a module, choose M here: the module will
>>   	  be called phy-tegra-xusb.
>> +
>> +config PHY_TEGRA194_P2U
>> +	tristate "NVIDIA Tegra194 PIPE2UPHY PHY driver"
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>=20
> ARCH_TEGRA is a bit too much, ARCH_TEGRA_194_SOC should fit better here.
>=20
Ok. I'll take care of it in the next patch series.
