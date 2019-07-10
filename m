Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5A64B1C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfGJRCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 13:02:08 -0400
Received: from foss.arm.com ([217.140.110.172]:36850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJRCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 13:02:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917DA344;
        Wed, 10 Jul 2019 10:02:05 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB0793F246;
        Wed, 10 Jul 2019 10:02:02 -0700 (PDT)
Date:   Wed, 10 Jul 2019 18:02:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V13 12/12] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20190710170200.GC8781@e121166-lin.cambridge.arm.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
 <20190710062212.1745-13-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710062212.1745-13-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 10, 2019 at 11:52:12AM +0530, Vidya Sagar wrote:

[...]

> +#if defined(CONFIG_PCIEASPM)
> +static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
> +	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
> +	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
> +}
> +
> +static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
> +	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
> +	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
> +}
> +
> +static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid]);
> +	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
> +	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> +	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
> +	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> +	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid], val);
> +	val = dw_pcie_readl_dbi(&pcie->pci, event_cntr_data_offset[pcie->cid]);
> +	return val;
> +}
> +
> +static int aspm_state_cnt(struct seq_file *s, void *data)
> +{
> +	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)
> +				     dev_get_drvdata(s->private);
> +	u32 val;
> +
> +	seq_printf(s, "Tx L0s entry count : %u\n",
> +		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_Tx_L0S));
> +
> +	seq_printf(s, "Rx L0s entry count : %u\n",
> +		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_Rx_L0S));
> +
> +	seq_printf(s, "Link L1 entry count : %u\n",
> +		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1));
> +
> +	seq_printf(s, "Link L1.1 entry count : %u\n",
> +		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1_1));
> +
> +	seq_printf(s, "Link L1.2 entry count : %u\n",
> +		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1_2));
> +
> +	/* Clear all counters */
> +	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid],
> +			   EVENT_COUNTER_ALL_CLEAR);
> +
> +	/* Re-enable counting */
> +	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> +	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> +	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid], val);
> +
> +	return 0;
> +}
> +#endif
> +
> +static int init_debugfs(struct tegra_pcie_dw *pcie)
> +{
> +#if defined(CONFIG_PCIEASPM)
> +	struct dentry *d;
> +
> +	d = debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt",
> +					pcie->debugfs, aspm_state_cnt);
> +	if (IS_ERR_OR_NULL(d))
> +		dev_err(pcie->dev,
> +			"Failed to create debugfs file \"aspm_state_cnt\"\n");
> +#endif
> +	return 0;
> +}

I prefer writing it:

#if defined(CONFIG_PCIEASPM)
static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
{
...
}

static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
{
...
}

static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
{
...
}

static int aspm_state_cnt(struct seq_file *s, void *data)
{
...
}

static int init_debugfs(struct tegra_pcie_dw *pcie)
{
	struct dentry *d;

	d = debugfs_create_devm_seqfile(pcie->dev, "aspm_state_cnt",
					pcie->debugfs, aspm_state_cnt);
	if (IS_ERR_OR_NULL(d))
		dev_err(pcie->dev,
			"Failed to create debugfs file \"aspm_state_cnt\"\n");
	return 0;
}
#else
static inline int init_debugfs(struct tegra_pcie_dw *pcie) { return 0; }
#endif

> +
> +static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val;
> +	u16 val_w;
> +
> +	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
> +	val |= APPL_INTR_EN_L0_0_LINK_STATE_INT_EN;
> +	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
> +
> +	val = appl_readl(pcie, APPL_INTR_EN_L1_0_0);
> +	val |= APPL_INTR_EN_L1_0_0_LINK_REQ_RST_NOT_INT_EN;
> +	appl_writel(pcie, val, APPL_INTR_EN_L1_0_0);
> +
> +	if (pcie->enable_cdm_check) {
> +		val = appl_readl(pcie, APPL_INTR_EN_L0_0);
> +		val |= APPL_INTR_EN_L0_0_CDM_REG_CHK_INT_EN;
> +		appl_writel(pcie, val, APPL_INTR_EN_L0_0);
> +
> +		val = appl_readl(pcie, APPL_INTR_EN_L1_18);
> +		val |= APPL_INTR_EN_L1_18_CDM_REG_CHK_CMP_ERR;
> +		val |= APPL_INTR_EN_L1_18_CDM_REG_CHK_LOGIC_ERR;
> +		appl_writel(pcie, val, APPL_INTR_EN_L1_18);
> +	}
> +
> +	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
> +				  PCI_EXP_LNKSTA);
> +	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
> +				PCI_EXP_LNKSTA_NLW_SHIFT;
> +
> +	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
> +				  PCI_EXP_LNKCTL);
> +	val_w |= PCI_EXP_LNKCTL_LBMIE;
> +	dw_pcie_writew_dbi(&pcie->pci, pcie->pcie_cap_base + PCI_EXP_LNKCTL,
> +			   val_w);
> +}
> +
> +static void tegra_pcie_enable_legacy_interrupts(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val;
> +
> +	/* Enable legacy interrupt generation */
> +	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
> +	val |= APPL_INTR_EN_L0_0_SYS_INTR_EN;
> +	val |= APPL_INTR_EN_L0_0_INT_INT_EN;
> +	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
> +
> +	val = appl_readl(pcie, APPL_INTR_EN_L1_8_0);
> +	val |= APPL_INTR_EN_L1_8_INTX_EN;
> +	val |= APPL_INTR_EN_L1_8_AUTO_BW_INT_EN;
> +	val |= APPL_INTR_EN_L1_8_BW_MGT_INT_EN;
> +	if (IS_ENABLED(CONFIG_PCIEAER))
> +		val |= APPL_INTR_EN_L1_8_AER_INT_EN;
> +	appl_writel(pcie, val, APPL_INTR_EN_L1_8_0);
> +}
> +
> +static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val;
> +
> +	dw_pcie_msi_init(pp);
> +
> +	/* Enable MSI interrupt generation */
> +	val = appl_readl(pcie, APPL_INTR_EN_L0_0);
> +	val |= APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN;
> +	val |= APPL_INTR_EN_L0_0_MSI_RCV_INT_EN;
> +	appl_writel(pcie, val, APPL_INTR_EN_L0_0);
> +}
> +
> +static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +
> +	/* Clear interrupt statuses before enabling interrupts */
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_1);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_2);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_3);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_6);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_7);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_8_0);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_9);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_10);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_11);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_13);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_14);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_15);
> +	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_17);
> +
> +	tegra_pcie_enable_system_interrupts(pp);
> +	tegra_pcie_enable_legacy_interrupts(pp);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		tegra_pcie_enable_msi_interrupts(pp);
> +}
> +
> +static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	u32 val, offset, i;
> +
> +	/* Program init preset */
> +	for (i = 0; i < pcie->num_lanes; i++) {
> +		dw_pcie_read(pci->dbi_base + CAP_SPCIE_CAP_OFF
> +				 + (i * 2), 2, &val);
> +		val &= ~CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK;
> +		val |= GEN3_GEN4_EQ_PRESET_INIT;
> +		val &= ~CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK;
> +		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
> +			   CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT);
> +		dw_pcie_write(pci->dbi_base + CAP_SPCIE_CAP_OFF
> +				 + (i * 2), 2, val);
> +
> +		offset = dw_pcie_find_ext_capability(pci,
> +						     PCI_EXT_CAP_ID_PL_16GT) +
> +				PCI_PL_16GT_LE_CTRL;
> +		dw_pcie_read(pci->dbi_base + offset + i, 1, &val);
> +		val &= ~PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK;
> +		val |= GEN3_GEN4_EQ_PRESET_INIT;
> +		val &= ~PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK;
> +		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
> +			PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT);
> +		dw_pcie_write(pci->dbi_base + offset + i, 1, val);
> +	}
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
> +	val |= (0x3ff << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
> +	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	val |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
> +	val |= (0x360 << GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_SHIFT);
> +	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +}
> +
> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val, tmp, offset, speed;
> +	unsigned int count;
> +	u16 val_w;
> +
> +core_init:

Why should we restart from here ? What's the effect of the reset
on following registers set-up ?

> +	count = 200;
> +#if defined(CONFIG_PCIEASPM)
> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	pcie->cfg_link_cap_l1sub = offset + PCI_L1SS_CAP;
> +#endif

Can we group it in the #ifdef above ?

> +	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
> +	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
> +	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PCI_PREF_MEMORY_BASE);
> +	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE;
> +	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE;
> +	dw_pcie_writel_dbi(pci, PCI_PREF_MEMORY_BASE, val);
> +
> +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> +
> +	/* Configure FTS */
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
> +	val &= ~(N_FTS_MASK << N_FTS_SHIFT);
> +	val |= N_FTS_VAL << N_FTS_SHIFT;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
> +	val &= ~FTS_MASK;
> +	val |= FTS_VAL;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
> +
> +	/* Enable as 0xFFFF0001 response for CRS */
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
> +	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
> +	val |= (AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001 <<
> +		AMBA_ERROR_RESPONSE_CRS_SHIFT);
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
> +
> +	/* Configure Max Speed from DT */
> +	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
> +		val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base +
> +					PCI_EXP_LNKCAP);
> +		val &= ~PCI_EXP_LNKCAP_SLS;
> +		val |= pcie->max_speed;
> +		dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP,
> +				   val);
> +	}
> +
> +	/* Configure Max lane width from DT */
> +	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_MLW;
> +	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
> +	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
> +
> +	config_gen3_gen4_eq_presets(pcie);
> +
> +#if defined(CONFIG_PCIEASPM)
> +	/* Enable ASPM counters */
> +	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
> +	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
> +	dw_pcie_writel_dbi(pci, event_cntr_ctrl_offset[pcie->cid], val);
> +
> +	/* Program T_cmrt and T_pwr_on values */
> +	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
> +	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
> +	val |= (pcie->aspm_cmrt << 8);
> +	val |= (pcie->aspm_pwr_on_t << 19);
> +	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
> +
> +	/* Program L0s and L1 entrance latencies */
> +	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
> +	val &= ~L0S_ENTRANCE_LAT_MASK;
> +	val |= (pcie->aspm_l0s_enter_lat << L0S_ENTRANCE_LAT_SHIFT);
> +	val |= ENTER_ASPM;
> +	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
> +#endif

It would be good to group all init guarded in CONFIG_PCIEASPM in
one function and related ifdef guard.

> +	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +
> +	if (pcie->update_fc_fixup) {
> +		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
> +		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
> +		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
> +	}
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> +
> +	/* Assert RST */
> +	val = appl_readl(pcie, APPL_PINMUX);
> +	val &= ~APPL_PINMUX_PEX_RST;
> +	appl_writel(pcie, val, APPL_PINMUX);

What's the effect of this RST on the registers programmed above ?

> +	usleep_range(100, 200);
> +
> +	/* Enable LTSSM */
> +	val = appl_readl(pcie, APPL_CTRL);
> +	val |= APPL_CTRL_LTSSM_EN;
> +	appl_writel(pcie, val, APPL_CTRL);
> +
> +	/* De-assert RST */
> +	val = appl_readl(pcie, APPL_PINMUX);
> +	val |= APPL_PINMUX_PEX_RST;
> +	appl_writel(pcie, val, APPL_PINMUX);
> +
> +	msleep(100);
> +
> +	val_w = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> +	while (!(val_w & PCI_EXP_LNKSTA_DLLLA)) {
> +		if (count) {
> +			dev_dbg(pci->dev, "Waiting for link up\n");
> +			usleep_range(1000, 2000);
> +			val_w = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> +						  PCI_EXP_LNKSTA);
> +			count--;
> +			continue;
> +		}
> +
> +		val = appl_readl(pcie, APPL_DEBUG);
> +		val &= APPL_DEBUG_LTSSM_STATE_MASK;
> +		val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
> +		tmp = appl_readl(pcie, APPL_LINK_STATUS);
> +		tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
> +		if (!(val == 0x11 && !tmp)) {
> +			dev_info(pci->dev, "Link is down\n");
> +			return 0;
> +		}
> +
> +		dev_info(pci->dev, "Link is down in DLL");
> +		dev_info(pci->dev, "Trying again with DLFE disabled\n");
> +		/* Disable LTSSM */
> +		val = appl_readl(pcie, APPL_CTRL);
> +		val &= ~APPL_CTRL_LTSSM_EN;
> +		appl_writel(pcie, val, APPL_CTRL);
> +
> +		reset_control_assert(pcie->core_rst);
> +		reset_control_deassert(pcie->core_rst);
> +
> +		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
> +		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
> +		val &= ~PCI_DLF_EXCHANGE_ENABLE;
> +		dw_pcie_writel_dbi(pci, offset, val);
> +
> +		/* Retry now with DLF Exchange disabled */
> +		goto core_init;

See above.

> +	}
> +	dev_dbg(pci->dev, "Link is up\n");
> +
> +	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> +		PCI_EXP_LNKSTA_CLS;
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +
> +	tegra_pcie_enable_interrupts(pp);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_link_up(struct dw_pcie *pci)
> +{
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
> +
> +	return !!(val & PCI_EXP_LNKSTA_DLLLA);
> +}
> +
> +static void tegra_pcie_set_msi_vec_num(struct pcie_port *pp)
> +{
> +	pp->num_vectors = MAX_MSI_IRQS;
> +}
> +
> +static const struct dw_pcie_ops tegra_dw_pcie_ops = {
> +	.link_up = tegra_pcie_dw_link_up,
> +};
> +
> +static struct dw_pcie_host_ops tegra_pcie_dw_host_ops = {
> +	.rd_own_conf = tegra_pcie_dw_rd_own_conf,
> +	.wr_own_conf = tegra_pcie_dw_wr_own_conf,
> +	.host_init = tegra_pcie_dw_host_init,
> +	.set_num_vectors = tegra_pcie_set_msi_vec_num,
> +};
> +
> +static void tegra_pcie_disable_phy(struct tegra_pcie_dw *pcie)
> +{
> +	unsigned int phy_count = pcie->phy_count;
> +
> +	while (phy_count--) {
> +		phy_power_off(pcie->phys[phy_count]);
> +		phy_exit(pcie->phys[phy_count]);
> +	}
> +}
> +
> +static int tegra_pcie_enable_phy(struct tegra_pcie_dw *pcie)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		ret = phy_init(pcie->phys[i]);
> +		if (ret < 0)
> +			goto phy_power_off;
> +
> +		ret = phy_power_on(pcie->phys[i]);
> +		if (ret < 0)
> +			goto phy_exit;
> +	}
> +
> +	return 0;
> +
> +phy_power_off:
> +	while (i--) {
> +		phy_power_off(pcie->phys[i]);
> +phy_exit:
> +		phy_exit(pcie->phys[i]);
> +	}
> +
> +	return ret;
> +}
> +
> +static int tegra_pcie_dw_parse_dt(struct tegra_pcie_dw *pcie)
> +{
> +	struct device_node *np = pcie->dev->of_node;
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "nvidia,aspm-cmrt-us", &pcie->aspm_cmrt);
> +	if (ret < 0) {
> +		dev_info(pcie->dev, "Failed to read ASPM T_cmrt: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "nvidia,aspm-pwr-on-t-us",
> +				   &pcie->aspm_pwr_on_t);
> +	if (ret < 0)
> +		dev_info(pcie->dev, "Failed to read ASPM Power On time: %d\n",
> +			 ret);
> +
> +	ret = of_property_read_u32(np, "nvidia,aspm-l0s-entrance-latency-us",
> +				   &pcie->aspm_l0s_enter_lat);
> +	if (ret < 0)
> +		dev_info(pcie->dev,
> +			 "Failed to read ASPM L0s Entrance latency: %d\n", ret);
> +
> +	ret = of_property_read_u32(np, "num-lanes", &pcie->num_lanes);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Failed to read num-lanes: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pcie->max_speed = of_pci_get_max_link_speed(np);
> +
> +	ret = of_property_read_u32_index(np, "nvidia,bpmp", 1, &pcie->cid);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to read Controller-ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pcie->phy_count = of_property_count_strings(np, "phy-names");
> +	if (pcie->phy_count < 0) {
> +		dev_err(pcie->dev, "Failed to find PHY entries: %d\n",
> +			pcie->phy_count);
> +		return pcie->phy_count;
> +	}
> +
> +	if (of_property_read_bool(np, "nvidia,update-fc-fixup"))
> +		pcie->update_fc_fixup = true;
> +
> +	pcie->supports_clkreq =
> +		of_property_read_bool(pcie->dev->of_node, "supports-clkreq");
> +
> +	pcie->enable_cdm_check =
> +		of_property_read_bool(np, "snps,enable-cdm-check");
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
> +					  bool enable)
> +{
> +	struct mrq_uphy_response resp;
> +	struct tegra_bpmp_message msg;
> +	struct mrq_uphy_request req;
> +	int err;
> +
> +	if (pcie->cid == 5)
> +		return 0;
> +
> +	memset(&req, 0, sizeof(req));
> +	memset(&resp, 0, sizeof(resp));
> +
> +	req.cmd = CMD_UPHY_PCIE_CONTROLLER_STATE;
> +	req.controller_state.pcie_controller = pcie->cid;
> +	req.controller_state.enable = enable;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq = MRQ_UPHY;
> +	msg.tx.data = &req;
> +	msg.tx.size = sizeof(req);
> +	msg.rx.data = &resp;
> +	msg.rx.size = sizeof(resp);
> +
> +	if (irqs_disabled())
> +		err = tegra_bpmp_transfer_atomic(pcie->bpmp, &msg);
> +	else
> +		err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +
> +	return err;
> +}
> +
> +static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> +{
> +	struct pcie_port *pp = &pcie->pci.pp;
> +	struct pci_dev *pdev;
> +	struct pci_bus *child;
> +
> +	list_for_each_entry(child, &pp->root_bus->children, node) {
> +		/* Bring downstream devices to D0 if they are not already in */
> +		if (child->parent == pp->root_bus)
> +			break;
> +	}
> +	list_for_each_entry(pdev, &child->devices, bus_list) {
> +		if (PCI_SLOT(pdev->devfn) == 0) {
> +			if (pci_set_power_state(pdev, PCI_D0))
> +				dev_err(pcie->dev,
> +					"Failed to transition %s to D0 state\n",
> +					dev_name(&pdev->dev));
> +		}
> +	}
> +}
> +
> +static int tegra_pcie_config_controller(struct tegra_pcie_dw *pcie,
> +					bool en_hw_hot_rst)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, true);
> +	if (ret) {
> +		dev_err(pcie->dev,
> +			"Failed to enable controller %u: %d\n", pcie->cid, ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(pcie->pex_ctl_supply);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Failed to enable regulator: %d\n", ret);
> +		goto fail_reg_en;
> +	}
> +
> +	ret = clk_prepare_enable(pcie->core_clk);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to enable core clock: %d\n", ret);
> +		goto fail_core_clk;
> +	}
> +
> +	ret = reset_control_deassert(pcie->core_apb_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to deassert core APB reset: %d\n",
> +			ret);
> +		goto fail_core_apb_rst;
> +	}
> +
> +	if (en_hw_hot_rst) {
> +		/* Enable HW_HOT_RST mode */
> +		val = appl_readl(pcie, APPL_CTRL);
> +		val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
> +			 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
> +		val |= APPL_CTRL_HW_HOT_RST_EN;
> +		appl_writel(pcie, val, APPL_CTRL);
> +	}
> +
> +	ret = tegra_pcie_enable_phy(pcie);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to enable PHY: %d\n", ret);
> +		goto fail_phy;
> +	}
> +
> +	/* Update CFG base address */
> +	appl_writel(pcie, pcie->dbi_res->start & APPL_CFG_BASE_ADDR_MASK,
> +		    APPL_CFG_BASE_ADDR);
> +
> +	/* Configure this core for RP mode operation */
> +	appl_writel(pcie, APPL_DM_TYPE_RP, APPL_DM_TYPE);
> +
> +	appl_writel(pcie, 0x0, APPL_CFG_SLCG_OVERRIDE);
> +
> +	val = appl_readl(pcie, APPL_CTRL);
> +	appl_writel(pcie, val | APPL_CTRL_SYS_PRE_DET_STATE, APPL_CTRL);
> +
> +	val = appl_readl(pcie, APPL_CFG_MISC);
> +	val |= (APPL_CFG_MISC_ARCACHE_VAL << APPL_CFG_MISC_ARCACHE_SHIFT);
> +	appl_writel(pcie, val, APPL_CFG_MISC);
> +
> +	if (!pcie->supports_clkreq) {
> +		val = appl_readl(pcie, APPL_PINMUX);
> +		val |= APPL_PINMUX_CLKREQ_OUT_OVRD_EN;
> +		val |= APPL_PINMUX_CLKREQ_OUT_OVRD;
> +		appl_writel(pcie, val, APPL_PINMUX);
> +	}
> +
> +	/* Update iATU_DMA base address */
> +	appl_writel(pcie,
> +		    pcie->atu_dma_res->start & APPL_CFG_IATU_DMA_BASE_ADDR_MASK,
> +		    APPL_CFG_IATU_DMA_BASE_ADDR);
> +
> +	reset_control_deassert(pcie->core_rst);
> +
> +	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
> +						      PCI_CAP_ID_EXP);
> +
> +#if defined(CONFIG_PCIEASPM)
> +	/* Disable ASPM-L1SS advertisement as there is no CLKREQ routing */
> +	if (!pcie->supports_clkreq) {
> +		disable_aspm_l11(pcie);
> +		disable_aspm_l12(pcie);
> +	}
> +#endif
> +	return ret;
> +
> +fail_phy:
> +	reset_control_assert(pcie->core_apb_rst);
> +fail_core_apb_rst:
> +	clk_disable_unprepare(pcie->core_clk);
> +fail_core_clk:
> +	regulator_disable(pcie->pex_ctl_supply);
> +fail_reg_en:
> +	tegra_pcie_bpmp_set_ctrl_state(pcie, false);
> +
> +	return ret;
> +}
> +
> +static int __deinit_controller(struct tegra_pcie_dw *pcie)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(pcie->core_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to assert \"core\" reset: %d\n",
> +			ret);
> +		return ret;
> +	}
> +	tegra_pcie_disable_phy(pcie);
> +	ret = reset_control_assert(pcie->core_apb_rst);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to assert APB reset: %d\n", ret);
> +		return ret;
> +	}
> +	clk_disable_unprepare(pcie->core_clk);
> +	ret = regulator_disable(pcie->pex_ctl_supply);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to disable regulator: %d\n", ret);
> +		return ret;
> +	}
> +	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
> +	if (ret) {
> +		dev_err(pcie->dev, "Failed to disable controller %d: %d\n",
> +			pcie->cid, ret);
> +		return ret;
> +	}
> +	return ret;
> +}
> +
> +static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	int ret;
> +
> +	ret = tegra_pcie_config_controller(pcie, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	pp->root_bus_nr = -1;

Useless, drop it, it is initialized in dw_pcie_host_init().

> +	pp->ops = &tegra_pcie_dw_host_ops;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret < 0) {
> +		dev_err(pcie->dev, "Failed to add PCIe port: %d\n", ret);
> +		goto fail_host_init;
> +	}
> +
> +	return 0;
> +
> +fail_host_init:
> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
> +{
> +	u32 val;
> +
> +	if (!tegra_pcie_dw_link_up(&pcie->pci))
> +		return 0;
> +
> +	val = appl_readl(pcie, APPL_RADM_STATUS);
> +	val |= APPL_PM_XMT_TURNOFF_STATE;
> +	appl_writel(pcie, val, APPL_RADM_STATUS);
> +
> +	return readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG, val,
> +				 val & APPL_DEBUG_PM_LINKST_IN_L2_LAT,
> +				 1, PME_ACK_TIMEOUT);
> +}
> +
> +static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
> +{
> +	u32 data;
> +	int err;
> +
> +	if (!tegra_pcie_dw_link_up(&pcie->pci)) {
> +		dev_dbg(pcie->dev, "PCIe link is not up...!\n");
> +		return;
> +	}
> +
> +	if (tegra_pcie_try_link_l2(pcie)) {
> +		dev_info(pcie->dev, "Link didn't transition to L2 state\n");
> +		/*
> +		 * TX lane clock freq will reset to Gen1 only if link is in L2
> +		 * or detect state.
> +		 * So apply pex_rst to end point to force RP to go into detect
> +		 * state
> +		 */
> +		data = appl_readl(pcie, APPL_PINMUX);
> +		data &= ~APPL_PINMUX_PEX_RST;
> +		appl_writel(pcie, data, APPL_PINMUX);
> +
> +		err = readl_poll_timeout_atomic(pcie->appl_base + APPL_DEBUG,
> +						data,
> +						((data &
> +						APPL_DEBUG_LTSSM_STATE_MASK) >>
> +						APPL_DEBUG_LTSSM_STATE_SHIFT) ==
> +						LTSSM_STATE_PRE_DETECT,
> +						1, LTSSM_TIMEOUT);
> +		if (err) {
> +			dev_info(pcie->dev, "Link didn't go to detect state\n");
> +		} else {
> +			/* Disable LTSSM after link is in detect state */
> +			data = appl_readl(pcie, APPL_CTRL);
> +			data &= ~APPL_CTRL_LTSSM_EN;
> +			appl_writel(pcie, data, APPL_CTRL);
> +		}
> +	}
> +	/*
> +	 * DBI registers may not be accessible after this as PLL-E would be
> +	 * down depending on how CLKREQ is pulled by end point
> +	 */
> +	data = appl_readl(pcie, APPL_PINMUX);
> +	data |= (APPL_PINMUX_CLKREQ_OVERRIDE_EN | APPL_PINMUX_CLKREQ_OVERRIDE);
> +	/* Cut REFCLK to slot */
> +	data |= APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE_EN;
> +	data &= ~APPL_PINMUX_CLK_OUTPUT_IN_OVERRIDE;
> +	appl_writel(pcie, data, APPL_PINMUX);
> +}
> +
> +static int tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
> +{
> +	/*
> +	 * link doesn't go into L2 state with some of the endpoints with Tegra
> +	 * if they are not in D0 state. So, need to make sure that immediate
> +	 * downstream devices are in D0 state before sending PME_TurnOff to put
> +	 * link into L2 state
> +	 */
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +	dw_pcie_host_deinit(&pcie->pci.pp);
> +	tegra_pcie_dw_pme_turnoff(pcie);
> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
> +{
> +	struct pcie_port *pp = &pcie->pci.pp;
> +	struct device *dev = pcie->dev;
> +	char *name;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = of_irq_get_byname(dev->of_node, "msi");
> +		if (!pp->msi_irq) {
> +			dev_err(dev, "Failed to get MSI interrupt\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
> +			ret);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	tegra_pcie_init_controller(pcie);
> +
> +	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
> +
> +	if (!pcie->link_state) {
> +		ret = -ENOMEDIUM;
> +		goto fail_host_init;
> +	}
> +
> +	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto fail_host_init;
> +	}
> +
> +	pcie->debugfs = debugfs_create_dir(name, NULL);
> +	if (!pcie->debugfs)
> +		dev_err(dev, "Failed to create debugfs\n");
> +	else
> +		init_debugfs(pcie);
> +
> +	return ret;
> +
> +fail_host_init:
> +	tegra_pcie_deinit_controller(pcie);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return ret;
> +}
> +
> +static const struct tegra_pcie_soc tegra_pcie_rc_of_data = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct of_device_id tegra_pcie_dw_of_match[] = {
> +	{
> +		.compatible = "nvidia,tegra194-pcie",
> +		.data = &tegra_pcie_rc_of_data,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, tegra_pcie_dw_of_match);

Move it closer to end of file where MODULE_DESCRIPTION() et al are.

> +
> +static int tegra_pcie_dw_probe(struct platform_device *pdev)
> +{
> +	const struct tegra_pcie_soc *data;
> +	struct device *dev = &pdev->dev;
> +	struct resource *atu_dma_res;
> +	struct tegra_pcie_dw *pcie;
> +	struct resource *dbi_res;
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +	struct phy **phys;
> +	char *name;
> +	int ret;
> +	u32 i;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = &pdev->dev;
> +	pci->ops = &tegra_dw_pcie_ops;
> +	pp = &pci->pp;
> +	pcie->dev = &pdev->dev;
> +
> +	data = (struct tegra_pcie_soc *)of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +	pcie->mode = (enum dw_pcie_device_mode)data->mode;
> +
> +	ret = tegra_pcie_dw_parse_dt(pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to parse device tree: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pcie->pex_ctl_supply = devm_regulator_get(dev, "vddio-pex-ctl");
> +	if (IS_ERR(pcie->pex_ctl_supply)) {
> +		dev_err(dev, "Failed to get regulator: %ld\n",
> +			PTR_ERR(pcie->pex_ctl_supply));
> +		return PTR_ERR(pcie->pex_ctl_supply);
> +	}
> +
> +	pcie->core_clk = devm_clk_get(dev, "core");
> +	if (IS_ERR(pcie->core_clk)) {
> +		dev_err(dev, "Failed to get core clock: %ld\n",
> +			PTR_ERR(pcie->core_clk));
> +		return PTR_ERR(pcie->core_clk);
> +	}
> +
> +	pcie->appl_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						      "appl");
> +	if (!pcie->appl_res) {
> +		dev_err(dev, "Failed to find \"appl\" region\n");
> +		return PTR_ERR(pcie->appl_res);
> +	}

Add an empty line.

> +	pcie->appl_base = devm_ioremap_resource(dev, pcie->appl_res);
> +	if (IS_ERR(pcie->appl_base))
> +		return PTR_ERR(pcie->appl_base);
> +
> +	pcie->core_apb_rst = devm_reset_control_get(dev, "apb");
> +	if (IS_ERR(pcie->core_apb_rst)) {
> +		dev_err(dev, "Failed to get APB reset: %ld\n",
> +			PTR_ERR(pcie->core_apb_rst));
> +		return PTR_ERR(pcie->core_apb_rst);
> +	}
> +
> +	phys = devm_kcalloc(dev, pcie->phy_count, sizeof(*phys), GFP_KERNEL);
> +	if (!phys)
> +		return PTR_ERR(phys);
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		name = kasprintf(GFP_KERNEL, "p2u-%u", i);
> +		if (!name) {
> +			dev_err(dev, "Failed to create P2U string\n");
> +			return -ENOMEM;
> +		}
> +		phys[i] = devm_phy_get(dev, name);
> +		kfree(name);
> +		if (IS_ERR(phys[i])) {
> +			ret = PTR_ERR(phys[i]);
> +			dev_err(dev, "Failed to get PHY: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	pcie->phys = phys;
> +
> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (!dbi_res) {
> +		dev_err(dev, "Failed to find \"dbi\" region\n");
> +		return PTR_ERR(dbi_res);
> +	}
> +	pcie->dbi_res = dbi_res;
> +
> +	pci->dbi_base = devm_ioremap_resource(dev, dbi_res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	/* Tegra HW locates DBI2 at a fixed offset from DBI */
> +	pci->dbi_base2 = pci->dbi_base + 0x1000;
> +
> +	atu_dma_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "atu_dma");
> +	if (!atu_dma_res) {
> +		dev_err(dev, "Failed to find \"atu_dma\" region\n");
> +		return PTR_ERR(atu_dma_res);
> +	}
> +	pcie->atu_dma_res = atu_dma_res;

Add an empty line.

I have just skimmed over it, I need more time to review the driver more
thoroughly, I will try to go over it tomorrow and we can see if we can
hit v5.3 but I can't guarantee anything, sorry but there was a
significant backlog on the PCI patch queue.

The rest of the series is fine but it is useless to merge it
without this patch so let's see how it goes.

Lorenzo

> +	pci->atu_base = devm_ioremap_resource(dev, atu_dma_res);
> +	if (IS_ERR(pci->atu_base))
> +		return PTR_ERR(pci->atu_base);
> +
> +	pcie->core_rst = devm_reset_control_get(dev, "core");
> +	if (IS_ERR(pcie->core_rst)) {
> +		dev_err(dev, "Failed to get core reset: %ld\n",
> +			PTR_ERR(pcie->core_rst));
> +		return PTR_ERR(pcie->core_rst);
> +	}
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (!pp->irq) {
> +		dev_err(dev, "Failed to get \"intr\" interrupt\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(dev, pp->irq, tegra_pcie_irq_handler,
> +			       IRQF_SHARED, "tegra-pcie-intr", pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq, ret);
> +		return ret;
> +	}
> +
> +	pcie->bpmp = tegra_bpmp_get(dev);
> +	if (IS_ERR(pcie->bpmp))
> +		return PTR_ERR(pcie->bpmp);
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	if (pcie->mode == DW_PCIE_RC_TYPE) {
> +		ret = tegra_pcie_config_rp(pcie);
> +		if (ret && ret != -ENOMEDIUM)
> +			goto fail;
> +		else
> +			return 0;
> +	}
> +
> +fail:
> +	tegra_bpmp_put(pcie->bpmp);
> +	return ret;
> +}
> +
> +static int tegra_pcie_dw_remove(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +
> +	if (pcie->mode != DW_PCIE_RC_TYPE)
> +		return 0;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	debugfs_remove_recursive(pcie->debugfs);
> +	tegra_pcie_deinit_controller(pcie);
> +	pm_runtime_put_sync(pcie->dev);
> +	pm_runtime_disable(pcie->dev);
> +	tegra_bpmp_put(pcie->bpmp);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_suspend_late(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* Enable HW_HOT_RST mode */
> +	val = appl_readl(pcie, APPL_CTRL);
> +	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
> +		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
> +	val |= APPL_CTRL_HW_HOT_RST_EN;
> +	appl_writel(pcie, val, APPL_CTRL);
> +
> +	return 0;
> +}
> +
> +static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* Save MSI interrupt vector */
> +	pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
> +					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +	tegra_pcie_dw_pme_turnoff(pcie);
> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_dw_resume_noirq(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	ret = tegra_pcie_config_controller(pcie, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to init host: %d\n", ret);
> +		goto fail_host_init;
> +	}
> +
> +	/* Restore MSI interrupt vector */
> +	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
> +			   pcie->msi_ctrl_int);
> +
> +	return 0;
> +fail_host_init:
> +	return __deinit_controller(pcie);
> +}
> +
> +static int tegra_pcie_dw_resume_early(struct device *dev)
> +{
> +	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	if (!pcie->link_state)
> +		return 0;
> +
> +	/* Disable HW_HOT_RST mode */
> +	val = appl_readl(pcie, APPL_CTRL);
> +	val &= ~(APPL_CTRL_HW_HOT_RST_MODE_MASK <<
> +		 APPL_CTRL_HW_HOT_RST_MODE_SHIFT);
> +	val |= APPL_CTRL_HW_HOT_RST_MODE_IMDT_RST <<
> +	       APPL_CTRL_HW_HOT_RST_MODE_SHIFT;
> +	val &= ~APPL_CTRL_HW_HOT_RST_EN;
> +	appl_writel(pcie, val, APPL_CTRL);
> +
> +	return 0;
> +}
> +
> +static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
> +{
> +	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
> +
> +	if (pcie->mode != DW_PCIE_RC_TYPE)
> +		return;
> +
> +	if (!pcie->link_state)
> +		return;
> +
> +	debugfs_remove_recursive(pcie->debugfs);
> +	tegra_pcie_downstream_dev_to_D0(pcie);
> +
> +	disable_irq(pcie->pci.pp.irq);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		disable_irq(pcie->pci.pp.msi_irq);
> +
> +	tegra_pcie_dw_pme_turnoff(pcie);
> +	__deinit_controller(pcie);
> +}
> +
> +static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
> +	.suspend_late = tegra_pcie_dw_suspend_late,
> +	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
> +	.resume_noirq = tegra_pcie_dw_resume_noirq,
> +	.resume_early = tegra_pcie_dw_resume_early,
> +};
> +
> +static struct platform_driver tegra_pcie_dw_driver = {
> +	.probe = tegra_pcie_dw_probe,
> +	.remove = tegra_pcie_dw_remove,
> +	.shutdown = tegra_pcie_dw_shutdown,
> +	.driver = {
> +		.name	= "tegra194-pcie",
> +		.pm = &tegra_pcie_dw_pm_ops,
> +		.of_match_table = tegra_pcie_dw_of_match,
> +	},
> +};
> +module_platform_driver(tegra_pcie_dw_driver);
> +
> +MODULE_AUTHOR("Vidya Sagar <vidyas@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA PCIe host controller driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
