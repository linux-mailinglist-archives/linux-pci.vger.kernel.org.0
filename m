Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D433E3AF6
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhHHPBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 11:01:35 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:15169
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231414AbhHHPBf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 8 Aug 2021 11:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcncfVNzJ/9GgcRKXIm68LyDPxFXQyv8XuPVveA6eqGeTzk/76mYDN2oraw3Fz0bnKDeRnSSxR9RF1/GUwNeKBcFMK7VIrtTcncIwmFBdwts4905M4ygQPI3SjgyeOLtrX9vPN4Tuy8hJYg3KSC32kuEYVi2wlgk29vHhSzIMLhrkprFn2KWfkHVQ9vED7LXvwwTFG41JlPNQOWC7/sLBzKxk8wIsT5cOzb8vKaFtrEJDG/QQ4ZbVPOqtWpRPY7e7BbFNxitilNGGF+pmWMAk02/lyMGFyDDzRvzy1tgGxc9BL+vnVURKQ3f6rruLFAhSo1KuAqscOy3+VzHbKFbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhasFYYMko6r/yf2Bx0pW3+kS/oKcu3YuIws4gMaMLQ=;
 b=bENtK057hsfjxqo0+QpZ+6eWyyQpyknXhcBNzwPkzractINyLs4wbJjEiDc2HIVzwEtI8MK4ak2XH2VYK0I3Uca6RUSN0wdP4JbknVgq/ylZxZtSeRFb9QE7/Z+9XmLNr9KkJ5IwfefsffITaZ9luKM2cBzCdKE1QYbp1yHJ5OdIzgrpg4uCbzB0zxaMC7AIaI0iFzu4rRirxw6Sop1oxEE0HeoB3xSESrdiMtlxFh30nl1LfLQm84h5RL0gVWCS7+aY5G0C7oPxrwJxbxV47As33DIIjZ0naIHZzmpZ6+iV+xTS05LCZLT7zPgME0H77GihmG0Iu3xW1W1T645VUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=baylibre.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhasFYYMko6r/yf2Bx0pW3+kS/oKcu3YuIws4gMaMLQ=;
 b=C1x27y6oWgcOvdw/w8rvP90I768i+aNa25ATGt9CDFf2keu9Nc2M+6Fgcwy/2DcIWxeqHMXoLKz0W5YqcwuRAo1lFWV1+7KNoXI/sm6AzrZFZEBH4Zxj/5wrFWx4ZrYmcXbCUR3Dwv4iMB+mDQnOtnSApbQFwazAbb5so1NyW27a4zXcXDeWifZcIoSK+kNas/m+ifUG4r2LZsSdC+kgaS5YHRj+olFMn0MI2asFzaL1IUTO4Q9/sA02rw0mQwrlZwHm7deDHlsn348Niby6hCB2jr4sqRLHxTOesKGzC9i7+hNCw40KHhfWLjLk+seMLPr75omnLJeBQ6K96orKfg==
Received: from BN8PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:60::15)
 by MWHPR12MB1184.namprd12.prod.outlook.com (2603:10b6:300:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Sun, 8 Aug
 2021 15:01:14 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::6e) by BN8PR12CA0002.outlook.office365.com
 (2603:10b6:408:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Sun, 8 Aug 2021 15:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 15:01:13 +0000
Received: from [10.25.99.72] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 15:01:03 +0000
Subject: Re: [PATCH v2 39/40] PCI: dwc: Move N_FTS setup to common setup
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
 <20200821035420.380495-40-robh@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d7146c20-6992-44a0-c390-f801d352cf15@nvidia.com>
Date:   Sun, 8 Aug 2021 20:31:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20200821035420.380495-40-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f893728d-3cda-48d1-c507-08d95a7d5dd0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1184:
X-Microsoft-Antispam-PRVS: <MWHPR12MB118457E1D34DC7E2C5FBD411B8F59@MWHPR12MB1184.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IPaHuRTPKqq+G2IXr1UQ9oQ4pR6yildM9H9UVIK8j0FFe3cAOe4fqlfej7ok24+GlCDMzbBiMQNGZ05RRpuKxRFg79kXTK0zbGW2xxcgwdb72grq8xxIna5tuysqD71YLY8gcdjgLd50bUsRQpzyFVW7AhF8ByX6sQ3oNuNCUODpNmGwc48oi/qX1l51DlLF6LyU5JiZ+KMOzJf53CaNF0gSW+In/26tA5tKEv0FjF9AKhRgSt0foNeZ3y+/dQACXb80ru3JHV4sWv2WUgIHdDhzO2YTTcfjV/pRehXlsZw9OzVuXE9cP/5+CrzfI0WanQw4NBZg+rGbcxyldYYoYporuo+usPiDm55cYP+Fy7tOIuLt4Ldd8+zQmePWVjBSCDUX/XqXW0imeT+8ow4xERS1PKkppyoVgcMKm00TQrru7tXogaArV6TksMLorDV2iakgU9BxoRPzkJI4d3J/O0Ll2k96n41ss7BMS7LVXvgaRdjFMvrXJoKv0QfukOEuPn5KC21VUJqtoNxex4JvmjOh8IiFdjOajwGK/3hDILooqdHOkF6jjnHDhBd02LgjhkdbglpYprmZ2JFva6ZESh+8B/L/v1MNjIkvGdr1lhUPO2mJBiiFaSdiHzc359N7kg2pE+QvWL3FDBG1naiYLlX/Hod5+95B+/by4+491g8Gad+DTsLj1MToSA3+lNTNIVjsLBjxZfDveWComQSCm94mXNPWqOc/ToaJu6X3rc=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(54906003)(110136005)(16526019)(186003)(4326008)(2616005)(8676002)(70586007)(7416002)(53546011)(47076005)(5660300002)(16576012)(7406005)(478600001)(70206006)(356005)(30864003)(8936002)(426003)(336012)(316002)(7636003)(36906005)(31696002)(82310400003)(36860700001)(26005)(36756003)(83380400001)(82740400003)(86362001)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 15:01:13.8732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f893728d-3cda-48d1-c507-08d95a7d5dd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/21/2020 9:24 AM, Rob Herring wrote:
> The Designware controller has common registers to set number of fast
> training sequence ordered sets. The Artpec6, Intel, and Tegra driver
> initialize these register fields. Let's move the initialization to the
> common setup code and drivers just have to provide the value.
> 
> There's a slight change in that the common clock mode N_FTS field is
> now initialized. Previously only the Intel driver set this. It's not
> clear from the code if common clock mode is used in the Artpec6 or Tegra
> driver. It depends on the DWC configuration. Given the field is not
> initialized while the others are, it seems unlikely common clock mode
> is used.
> 
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-artpec6.c    | 37 +++-----------------
>   drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++++------
>   drivers/pci/controller/dwc/pcie-designware.h |  3 +-
>   drivers/pci/controller/dwc/pcie-intel-gw.c   | 27 +++++---------
>   drivers/pci/controller/dwc/pcie-tegra194.c   | 25 ++-----------
>   5 files changed, 35 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 86f4d66d8587..929448e9e0bc 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -44,13 +44,6 @@ struct artpec_pcie_of_data {
>   
>   static const struct of_device_id artpec6_pcie_of_match[];
>   
> -/* PCIe Port Logic registers (memory-mapped) */
> -#define PL_OFFSET			0x700
> -
> -#define ACK_F_ASPM_CTRL_OFF		(PL_OFFSET + 0xc)
> -#define ACK_N_FTS_MASK			GENMASK(15, 8)
> -#define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
> -
>   /* ARTPEC-6 specific registers */
>   #define PCIECFG				0x18
>   #define  PCIECFG_DBG_OEN		BIT(24)
> @@ -289,30 +282,6 @@ static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
>   	}
>   }
>   
> -static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
> -{
> -	struct dw_pcie *pci = artpec6_pcie->pci;
> -	u32 val;
> -
> -	if (artpec6_pcie->variant != ARTPEC7)
> -		return;
> -
> -	/*
> -	 * Increase the N_FTS (Number of Fast Training Sequences)
> -	 * to be transmitted when transitioning from L0s to L0.
> -	 */
> -	val = dw_pcie_readl_dbi(pci, ACK_F_ASPM_CTRL_OFF);
> -	val &= ~ACK_N_FTS_MASK;
> -	val |= ACK_N_FTS(180);
> -	dw_pcie_writel_dbi(pci, ACK_F_ASPM_CTRL_OFF, val);
> -
> -	/*
> -	 * Set the Number of Fast Training Sequences that the core
> -	 * advertises as its N_FTS during Gen2 or Gen3 link training.
> -	 */
> -	dw_pcie_link_set_n_fts(pci, 180);
> -}
> -
>   static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
>   {
>   	u32 val;
> @@ -351,11 +320,14 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>   	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
>   
> +	if (artpec6_pcie->variant == ARTPEC7) {
> +		pci->n_fts[0] = 180;
> +		pci->n_fts[1] = 180;
> +	}
>   	artpec6_pcie_assert_core_reset(artpec6_pcie);
>   	artpec6_pcie_init_phy(artpec6_pcie);
>   	artpec6_pcie_deassert_core_reset(artpec6_pcie);
>   	artpec6_pcie_wait_for_phy(artpec6_pcie);
> -	artpec6_pcie_set_nfts(artpec6_pcie);
>   	dw_pcie_setup_rc(pp);
>   	artpec6_pcie_establish_link(pci);
>   	dw_pcie_wait_for_link(pci);
> @@ -403,7 +375,6 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
>   	artpec6_pcie_init_phy(artpec6_pcie);
>   	artpec6_pcie_deassert_core_reset(artpec6_pcie);
>   	artpec6_pcie_wait_for_phy(artpec6_pcie);
> -	artpec6_pcie_set_nfts(artpec6_pcie);
>   
>   	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>   		dw_pcie_ep_reset_bar(pci, bar);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 61e1faba15bf..3cb21247619c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -510,17 +510,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
>   
> -void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> -{
> -	u32 val;
> -
> -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_N_FTS_MASK;
> -	val |= n_fts & PORT_LOGIC_N_FTS_MASK;
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -}
> -EXPORT_SYMBOL_GPL(dw_pcie_link_set_n_fts);
> -
>   static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>   {
>   	u32 val;
> @@ -551,6 +540,23 @@ void dw_pcie_setup(struct dw_pcie *pci)
>   	if (pci->link_gen > 0)
>   		dw_pcie_link_set_max_speed(pci, pci->link_gen);
>   
> +	/* Configure Gen1 N_FTS */
> +	if (pci->n_fts[0]) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
> +		val &= ~(PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK);
> +		val |= PORT_AFR_N_FTS(pci->n_fts[0]);
> +		val |= PORT_AFR_CC_N_FTS(pci->n_fts[0]);
> +		dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
> +	}
> +
> +	/* Configure Gen2+ N_FTS */
> +	if (pci->n_fts[1]) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +		val &= ~PORT_LOGIC_N_FTS_MASK;
> +		val |= pci->n_fts[pci->link_gen - 1];
Apologies for getting late to this change given that the change has 
already been merged.
I'm wondering why is it that link_gen has to be used in deriving the 
index instead of directly using '1' as the index?
Infact the for link speed greater than 2, accesses go beyond n_fts[] 
array boundaries.
Since the if() check is done based on a non-zero value of pci->n_fts[1], 
shouldn't the same be used for programming also?

- Vidya Sagar

> +		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +	}
> +
>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>   	val &= ~PORT_LINK_FAST_LINK_MODE;
>   	val |= PORT_LINK_DLL_LINK_EN;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0b48298362cd..d8771db247f4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -34,6 +34,7 @@
>   #define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
>   #define PORT_AFR_N_FTS(n)		FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
>   #define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
> +#define PORT_AFR_CC_N_FTS(n)		FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, n)
>   #define PORT_AFR_ENTER_ASPM		BIT(30)
>   #define PORT_AFR_L0S_ENTRANCE_LAT_SHIFT	24
>   #define PORT_AFR_L0S_ENTRANCE_LAT_MASK	GENMASK(26, 24)
> @@ -253,6 +254,7 @@ struct dw_pcie {
>   	unsigned int		version;
>   	int			num_lanes;
>   	int			link_gen;
> +	u8			n_fts[2];
>   };
>   
>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> @@ -271,7 +273,6 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>   void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>   int dw_pcie_link_up(struct dw_pcie *pci);
>   void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> -void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
>   int dw_pcie_wait_for_link(struct dw_pcie *pci);
>   void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>   			       int type, u64 cpu_addr, u64 pci_addr,
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 333f11561807..5650cb78acba 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -67,7 +67,6 @@ struct intel_pcie_port {
>   	void __iomem		*app_base;
>   	struct gpio_desc	*reset_gpio;
>   	u32			rst_intrvl;
> -	u32			n_fts;
>   	struct clk		*core_clk;
>   	struct reset_control	*core_rst;
>   	struct phy		*phy;
> @@ -138,37 +137,29 @@ static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
>   	pcie_rc_cfg_wr(lpp, offset + PCI_EXP_LNKCTL, val);
>   }
>   
> -static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
> +static void intel_pcie_init_n_fts(struct dw_pcie *pci)
>   {
> -	u32 val, mask;
> -	struct dw_pcie *pci = &lpp->pci;
> -
> -	switch (pcie_link_speed[pci->link_gen]) {
> -	case PCIE_SPEED_8_0GT:
> -		lpp->n_fts = PORT_AFR_N_FTS_GEN3;
> +	switch (pci->link_gen) {
> +	case 3:
> +		pci->n_fts[1] = PORT_AFR_N_FTS_GEN3;
>   		break;
> -	case PCIE_SPEED_16_0GT:
> -		lpp->n_fts = PORT_AFR_N_FTS_GEN4;
> +	case 4:
> +		pci->n_fts[1] = PORT_AFR_N_FTS_GEN4;
>   		break;
>   	default:
> -		lpp->n_fts = PORT_AFR_N_FTS_GEN12_DFT;
> +		pci->n_fts[1] = PORT_AFR_N_FTS_GEN12_DFT;
>   		break;
>   	}
> -
> -	mask = PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK;
> -	val = FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
> -	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
> -	pcie_rc_cfg_wr_mask(lpp, PCIE_PORT_AFR, mask, val);
> +	pci->n_fts[0] = PORT_AFR_N_FTS_GEN12_DFT;
>   }
>   
>   static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
>   {
>   	intel_pcie_ltssm_disable(lpp);
>   	intel_pcie_link_setup(lpp);
> +	intel_pcie_init_n_fts(&lpp->pci);
>   	dw_pcie_setup_rc(&lpp->pci.pp);
>   	dw_pcie_upconfig_setup(&lpp->pci);
> -	intel_pcie_port_logic_setup(lpp);
> -	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
>   }
>   
>   static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 91ef4b3e860d..1560c449757d 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -881,17 +881,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
>   
>   	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
>   
> -	/* Configure FTS */
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
> -	val &= ~PORT_AFR_N_FTS_MASK;
> -	val |= PORT_AFR_N_FTS(N_FTS_VAL);
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
> -
> -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_N_FTS_MASK;
> -	val |= FTS_VAL;
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -
>   	/* Enable as 0xFFFF0001 response for CRS */
>   	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
>   	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
> @@ -1794,17 +1783,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>   	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
>   	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
>   
> -	/* Configure N_FTS & FTS */
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
> -	val &= ~PORT_AFR_N_FTS_MASK;
> -	val |= PORT_AFR_N_FTS(FTS_VAL);
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
> -
> -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &= ~PORT_LOGIC_N_FTS_MASK;
> -	val |= FTS_VAL;
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -
>   	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>   						      PCI_CAP_ID_EXP);
>   	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> @@ -2033,6 +2011,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   	pci = &pcie->pci;
>   	pci->dev = &pdev->dev;
>   	pci->ops = &tegra_dw_pcie_ops;
> +	pci->n_fts[0] = N_FTS_VAL;
> +	pci->n_fts[1] = FTS_VAL;
> +
>   	pp = &pci->pp;
>   	pcie->dev = &pdev->dev;
>   	pcie->mode = (enum dw_pcie_device_mode)data->mode;
> 
