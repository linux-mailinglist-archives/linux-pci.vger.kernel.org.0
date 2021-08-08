Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0773E3B07
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhHHPOS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 11:14:18 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:5601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229923AbhHHPOR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Aug 2021 11:14:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DizJXb7EOM3l+sKa4LWDjg0FnH0BxOldeQkHPIsYK1r7PjwmT0ADa9nNcHbLAvaaRmnOo0iE+micVrMMeOH/OE/1nYrQTtUlDN/ocWEk87Xl8w21/f2BeRk+f7TEc8wQSyAhcx9kFUUhW94UC2OibMjEhvfvdQdrBtusa4kEV+6lQQKzuj2dKmE33QP1RkBpuHPDtGbT4AtLnT+x3UT5qyHhD94trBdTKtiuExtKQ+SUU9vJZxyzDR21Xy03YON1/M/9WJ/YV/FkhPyX27OrfJ6GUUEpTpTnB5ZCoFsbPJL7z/NnzCvrtxrn2KDA3wDUwfS9a5cvZL3Qt5keHitGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruAid/TIzXD2J/qafvX1Xj8YycY1WeuRgcAQiQGlNkQ=;
 b=npiEa6BsuVXwKEIA+l/R+xI4iu8AbpnRmVSK0uen8onK4B4g98EXvrzmzv2/YAN4SmgrTAymdgjjsNfMDG+IQO5u0fCvo9PcjgLFis/nVCcPhej5S54xn6SDf/ctLZKWqG08KCGnse6kNm9+ThwK8TOXGwq2zGW/HkPcFUEM8zvy8XXtFaV0n5ssO1nyBz2wEAoRrepoxBaKUjj4Pf/x7XIrLZrqfFgRml0U3qIBO2mhdkGcQNP/d2zH0pWXuhwDqaA3Lxzcs54IFb8hG3/dIxEMXViNUF3DWaM+o/HhZILOpnh4LdpQapqdLEqMU1JmUPh0fEJD8a32hnr9UWb8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruAid/TIzXD2J/qafvX1Xj8YycY1WeuRgcAQiQGlNkQ=;
 b=sU9lY9JXTY794wyDYUkC1lxqmeFdWrAF3+ZpLuFpyzPeBgbiMookgauqT+pbWIeoy0gs87FelLY9uS+Jdes0QnmTU9fsxgnszBGGkDnbeOYMO9BFgpkr3mhVLk4PTVz8tAgwTPouFyjapY6wWA0+yKyt7VbrgYLAOOEVXTC0fyqLrSd+QtBDBnnl898UDpHadgiO9abcVYspqhu2w3oGCEEpSQxSsd0KdwSWElJCUsyy/2NgVLEqhOPvKf/EmrcTwfKNOzhrr3JaMlSUyiTUwyP/McX38wh7IvTUmWw/rIZ7Ki39xU7hAOjRoZIT8Y8Gu4sbE6/5s27DojOcgj9Dzg==
Received: from CO2PR04CA0140.namprd04.prod.outlook.com (2603:10b6:104::18) by
 BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Sun, 8 Aug
 2021 15:13:56 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::e6) by CO2PR04CA0140.outlook.office365.com
 (2603:10b6:104::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 15:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 15:13:56 +0000
Received: from [10.25.99.72] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 15:13:45 +0000
Subject: Re: [PATCH v2 03/40] PCI: dwc: Allow overriding bridge pci_ops
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        "Lucas Stach" <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-arm-kernel@axis.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
 <20200821035420.380495-4-robh@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <68e3adfb-a79d-3b70-87ed-2e5e1bf7fc93@nvidia.com>
Date:   Sun, 8 Aug 2021 20:43:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20200821035420.380495-4-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6bf1062-80fa-492d-644a-08d95a7f241e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5099CB820C4A3C1CACA85F1EB8F59@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFeRCVQMc//Dc795KC6pf1J4mXxd1qKM0xpCNvrM7kfvIeF5/mvISZctvubwflcOb3qM9+spm552QMgco5WWsUsZA33kt4hxnUaQQ6r9jkVeaPaq+K7RlkMJZ4L1CvTxms2KY5reChiDcMCbfJkLWiUSjWR3dIEKgAEJ1fTlHSOIovd1+raqOOo3on/mUvxhbB8Mp295klFZ8UZsctNHAMK7Afu7XWaWyVBvy0Px9O+MRqogooMYJ7kQQwAIDRyAEB0vHM2k1slHznBev7i59INA7cp7/qlZkxG7cL8RqX9wFwI22/rOGmYeQ0+5S5qDRHO2ccB2zjDKRIceGcvRvDpxvG5IKTkePmpFBilB8WZckwfmUzT+VrebZX9gj/DWN8pytnW+7zrbpJLmWsGSKXuHIy6gAk+uX3n3UQtT8j2PuOq7VGMAwAwK6A98XpeCg44XryOOB+eLOiMoTEVKWJT+j3dgqASR2fM6kNTfXqvb3pBS7br8U8aIhWcDxcbQME7HoXpAA5x0uQcF/0NN6cBdF0QXs/OAUy1h54prbkZg76FZgeRZ5n5yLd9a6Km6qeaUOxMaABmN4E3N3Dvkar9fv2m9WQxAnSko/4NStoOduiGOFJmQSbBylRXb84NoJFg02PD7Mt+F7Ds4awt+94Tkc48FkOuzZCmzgxmjBu0l4wAMafRDWo583unX7IkL3SVIRyK/UuC14ai5lX6FaSLdJqHjrt6aaB6A0lescJk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(356005)(83380400001)(86362001)(36860700001)(4326008)(36756003)(31696002)(82310400003)(82740400003)(8936002)(478600001)(47076005)(7636003)(36906005)(7416002)(7406005)(16576012)(336012)(54906003)(16526019)(316002)(2906002)(31686004)(26005)(53546011)(426003)(186003)(70586007)(70206006)(5660300002)(110136005)(2616005)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 15:13:56.1824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bf1062-80fa-492d-644a-08d95a7f241e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/21/2020 9:23 AM, Rob Herring wrote:
> In preparation to allow drivers to set their own root and child pci_ops
> instead of using the DWC specific config space ops, we need to make
> the pci_host_bridge pointer available and move setting the bridge->ops
> and bridge->child_ops pointer to before the .host_init() hook.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++++-----
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 1d98554db009..b626cc7cd43a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -344,6 +344,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   	if (!bridge)
>   		return -ENOMEM;
>   
> +	pp->bridge = bridge;
> +
>   	/* Get the I/O and memory ranges from DT */
>   	resource_list_for_each_entry(win, &bridge->windows) {
>   		switch (resource_type(win->res)) {
> @@ -445,6 +447,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   		}
>   	}
>   
> +	/* Set default bus ops */
> +	bridge->ops = &dw_pcie_ops;
> +	bridge->child_ops = &dw_pcie_ops;
> +
>   	if (pp->ops->host_init) {
>   		ret = pp->ops->host_init(pp);
>   		if (ret)
> @@ -452,7 +458,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   	}
>   
>   	bridge->sysdata = pp;
> -	bridge->ops = &dw_pcie_ops;
>   
>   	ret = pci_scan_root_bus_bridge(bridge);
>   	if (ret)
> @@ -654,11 +659,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>   	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>   
>   	/*
> -	 * If the platform provides ->rd_other_conf, it means the platform
> -	 * uses its own address translation component rather than ATU, so
> -	 * we should not program the ATU here.
> +	 * If the platform provides its own child bus config accesses, it means
> +	 * the platform uses its own address translation component rather than
> +	 * ATU, so we should not program the ATU here.
It is possible that a platform can have its own translation for 
configuration accesses and use DWC's ATU for memory/IO address 
translations. IMHO, ATU setup for memory/IO address translations 
shouldn't be skipped based on platform's '->rd_other_conf' 
implementation. Ex:- A platform can implement configuration space access 
through the ECAM mechanism yet choose to use ATU for memory/IO address 
translations.

Thanks,
Vidya Sagar
>   	 */
> -	if (!pp->ops->rd_other_conf) {
> +	if (pp->bridge->child_ops == &dw_pcie_ops && !pp->ops->rd_other_conf) {
>   		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
>   					  PCIE_ATU_TYPE_MEM, pp->mem_base,
>   					  pp->mem_bus_addr, pp->mem_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f911760dcc69..8b8ea5f3e7af 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -200,6 +200,7 @@ struct pcie_port {
>   	u32			num_vectors;
>   	u32			irq_mask[MAX_MSI_CTRLS];
>   	struct pci_bus		*root_bus;
> +	struct pci_host_bridge  *bridge;
>   	raw_spinlock_t		lock;
>   	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>   };
> 
