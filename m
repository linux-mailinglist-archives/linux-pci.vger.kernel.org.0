Return-Path: <linux-pci+bounces-30794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16607AEA230
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544B81C64302
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4C2F2716;
	Thu, 26 Jun 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DTLB+yxP"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736D2F236A;
	Thu, 26 Jun 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949752; cv=none; b=HmW6F/RttrOx+rgnPCd/aTFMedacX6KM9WBv3wuWbxy3XZhb6Rhyq0BngXjcWWe0lkOS4Tr4w8Jq0SypQ4iqqz+rH8gDsh+wfxCDKFyaggBYshZfm5VoqUvEKKMDK8WzOc+9X+uLMFgJkT4UhC8H1RFoHD7n5JXXyohXvfGqc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949752; c=relaxed/simple;
	bh=6zs8z4UzswRXvs6L2gVkT4dmkgyIw3gyZlcjgzzcaHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNhO4IvYYQomcBoc9Ze75drT4cmWg3s1cgHR+hZw1XElk6/RXQDfyBJIq4yye/Uhz01lE9hjWJbCDdM9S914uEVCugXVPIuof4rxLRBYGeqB7hRNXuolYR/aGvY1edOrxOW35nVlsBT9vAn5OfTDR8z1896uUu7R4GgQGslzp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DTLB+yxP; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+HjpuvLGVFfxjZhN/yLlrtD9VO7tB8awe+TY9weMsgc=;
	b=DTLB+yxPo0OcNyrjGSfTfcBJ1oalIMsP9O6KdQMN8C+AIqPOtP/zj9IndKfp86
	fCuSH5JY/Dg73czTdPO/syWssp+EgEqiAy94McI8pseiwLhrSJergqf6Dc6bNea5
	VbIh4UBAE+KOYXskPYCeBl+gjzjf8E1qigXKtmwnoiyqU=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnKihkX11o0QkeAQ--.38555S2;
	Thu, 26 Jun 2025 22:55:34 +0800 (CST)
Message-ID: <35b5f50d-93a5-422d-b028-9f03c26dd209@163.com>
Date: Thu, 26 Jun 2025 22:55:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dwc: Refactor code by using
 dw_pcie_clear_and_set_dword()
To: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 kwilczynski@kernel.org
Cc: robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250626145040.14180-1-18255117159@163.com>
 <20250626145040.14180-3-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250626145040.14180-3-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgBnKihkX11o0QkeAQ--.38555S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3trWkuF4kGr18AFyDKr4fuFg_yoW8AF4Uto
	Z3XF1Uua12qF1jqFyUtFn3KFyUZr9FvFyFqFsFkw4ak3y3Ca45A393KF1avw1Y9w4fC34r
	Xa1DGwn8ZFW7Zr1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0NtIUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgx4o2hdWex6egAAst

Dear Mani,

Subject:  s/PATCH v3/PATCH v3 02/13/

I'm very sorry. Here, the patch was generated separately. I forgot which 
patch was modified. Please pay attention when you merge.


Best regards,
Hans


On 2025/6/26 22:50, Hans Zhang wrote:
> DesignWare core modules contain multiple instances of manual
> read-modify-write operations for register bit manipulation.
> These patterns duplicate functionality now provided by
> dw_pcie_clear_and_set_dword(), particularly in debugfs, endpoint,
> host, and core initialization paths.
> 
> Replace open-coded bit manipulation sequences with calls to
> dw_pcie_clear_and_set_dword(). Affected areas include debugfs register
> control, endpoint capability configuration, host setup routines, and
> core link initialization logic. The changes simplify power management
> handling, capability masking, and feature configuration.
> 
> Standardizing on the helper function reduces code duplication by ~140
> lines across core modules while improving readability. The refactoring
> also ensures consistent error handling for register operations and
> provides a single point of control for future bit manipulation logi
> updates.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>   .../controller/dwc/pcie-designware-debugfs.c  | 67 +++++++----------
>   .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++--
>   .../pci/controller/dwc/pcie-designware-host.c | 27 +++----
>   drivers/pci/controller/dwc/pcie-designware.c  | 74 +++++++------------
>   drivers/pci/controller/dwc/pcie-designware.h  | 18 +----
>   5 files changed, 76 insertions(+), 130 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index c67601096c48..c1ff6ade14b5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -213,10 +213,8 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
>   	if (val)
>   		return val;
>   
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> -	val &= ~(LANE_SELECT);
> -	val |= FIELD_PREP(LANE_SELECT, lane);
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG,
> +				    LANE_SELECT, FIELD_PREP(LANE_SELECT, lane));
>   
>   	return count;
>   }
> @@ -309,12 +307,11 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
>   {
>   	u32 val;
>   
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> -	val &= ~EVENT_COUNTER_ENABLE;
> -	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
> -	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
> +	val = FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
>   	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
> +				    EVENT_COUNTER_ENABLE | EVENT_COUNTER_GROUP_SELECT |
> +				    EVENT_COUNTER_EVENT_SELECT, val);
>   }
>   
>   static ssize_t counter_enable_read(struct file *file, char __user *buf,
> @@ -354,13 +351,9 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
>   
>   	mutex_lock(&rinfo->reg_event_lock);
>   	set_event_number(pdata, pci, rinfo);
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> -	if (enable)
> -		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
> -	else
> -		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
> -
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	val |= FIELD_PREP(EVENT_COUNTER_ENABLE, enable ? PER_EVENT_ON : PER_EVENT_OFF);
> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
> +				    0, val);
>   
>   	/*
>   	 * While enabling the counter, always read the status back to check if
> @@ -415,10 +408,9 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
>   
>   	mutex_lock(&rinfo->reg_event_lock);
>   	set_event_number(pdata, pci, rinfo);
> -	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> -	val &= ~(EVENT_COUNTER_LANE_SELECT);
> -	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
> -	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> +	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
> +				    EVENT_COUNTER_LANE_SELECT,
> +				    FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane));
>   	mutex_unlock(&rinfo->reg_event_lock);
>   
>   	return count;
> @@ -654,20 +646,15 @@ static int dw_pcie_ptm_check_capability(void *drvdata)
>   static int dw_pcie_ptm_context_update_write(void *drvdata, u8 mode)
>   {
>   	struct dw_pcie *pci = drvdata;
> -	u32 val;
>   
> -	if (mode == PCIE_PTM_CONTEXT_UPDATE_AUTO) {
> -		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
> -		val |= PTM_REQ_AUTO_UPDATE_ENABLED;
> -		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
> -	} else if (mode == PCIE_PTM_CONTEXT_UPDATE_MANUAL) {
> -		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
> -		val &= ~PTM_REQ_AUTO_UPDATE_ENABLED;
> -		val |= PTM_REQ_START_UPDATE;
> -		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
> -	} else {
> +	if (mode == PCIE_PTM_CONTEXT_UPDATE_AUTO)
> +		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
> +					    0, PTM_REQ_AUTO_UPDATE_ENABLED);
> +	else if (mode == PCIE_PTM_CONTEXT_UPDATE_MANUAL)
> +		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
> +					    PTM_REQ_AUTO_UPDATE_ENABLED, PTM_REQ_START_UPDATE);
> +	else
>   		return -EINVAL;
> -	}
>   
>   	return 0;
>   }
> @@ -694,17 +681,13 @@ static int dw_pcie_ptm_context_update_read(void *drvdata, u8 *mode)
>   static int dw_pcie_ptm_context_valid_write(void *drvdata, bool valid)
>   {
>   	struct dw_pcie *pci = drvdata;
> -	u32 val;
>   
> -	if (valid) {
> -		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
> -		val |= PTM_RES_CCONTEXT_VALID;
> -		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
> -	} else {
> -		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
> -		val &= ~PTM_RES_CCONTEXT_VALID;
> -		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
> -	}
> +	if (valid)
> +		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
> +					    0, PTM_RES_CCONTEXT_VALID);
> +	else
> +		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
> +					    PTM_RES_CCONTEXT_VALID, 0);
>   
>   	return 0;
>   }
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0ae54a94809b..7e52892f632b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -277,7 +277,7 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
>   	int flags = epf_bar->flags;
>   	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
>   	unsigned int rebar_offset;
> -	u32 rebar_cap, rebar_ctrl;
> +	u32 rebar_cap;
>   	int ret;
>   
>   	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
> @@ -310,9 +310,8 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
>   	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
>   	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
>   	 */
> -	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
> -	rebar_ctrl &= ~GENMASK(31, 16);
> -	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
> +	dw_pcie_clear_and_set_dword(pci, rebar_offset + PCI_REBAR_CTRL,
> +				    GENMASK(31, 16), 0);
>   
>   	/*
>   	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
> @@ -925,7 +924,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>   	struct dw_pcie_ep_func *ep_func;
>   	struct device *dev = pci->dev;
>   	struct pci_epc *epc = ep->epc;
> -	u32 ptm_cap_base, reg;
> +	u32 ptm_cap_base;
>   	u8 hdr_type;
>   	u8 func_no;
>   	void *addr;
> @@ -1001,13 +1000,12 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>   	 */
>   	if (ptm_cap_base) {
>   		dw_pcie_dbi_ro_wr_en(pci);
> -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> -		reg &= ~PCI_PTM_CAP_ROOT;
> -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +		dw_pcie_clear_and_set_dword(pci, ptm_cap_base + PCI_PTM_CAP,
> +					    PCI_PTM_CAP_ROOT, 0);
>   
> -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> -		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +		dw_pcie_clear_and_set_dword(pci, ptm_cap_base + PCI_PTM_CAP,
> +					    PCI_PTM_CAP_RES |
> +					    PCI_PTM_GRANULARITY_MASK, 0);
>   		dw_pcie_dbi_ro_wr_dis(pci);
>   	}
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 906277f9ffaf..e43d66d48439 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -909,7 +909,7 @@ static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
>   int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	u32 val, ctrl, num_ctrls;
> +	u32 ctrl, num_ctrls;
>   	int ret;
>   
>   	/*
> @@ -941,23 +941,17 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
>   
>   	/* Setup interrupt pins */
> -	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
> -	val &= 0xffff00ff;
> -	val |= 0x00000100;
> -	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
> +	dw_pcie_clear_and_set_dword(pci, PCI_INTERRUPT_LINE,
> +				    0x0000ff00, 0x00000100);
>   
>   	/* Setup bus numbers */
> -	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
> -	val &= 0xff000000;
> -	val |= 0x00ff0100;
> -	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
> +	dw_pcie_clear_and_set_dword(pci, PCI_PRIMARY_BUS,
> +				    0x00ffffff, 0x00ff0100);
>   
>   	/* Setup command register */
> -	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
> -	val &= 0xffff0000;
> -	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> -		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> -	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> +	dw_pcie_clear_and_set_dword(pci, PCI_COMMAND, 0x0000ffff,
> +				    PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> +				    PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
>   
>   	dw_pcie_config_presets(pp);
>   	/*
> @@ -976,9 +970,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   	/* Program correct class for RC */
>   	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>   
> -	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val |= PORT_LOGIC_SPEED_CHANGE;
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +	dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +				    0, PORT_LOGIC_SPEED_CHANGE);
>   
>   	dw_pcie_dbi_ro_wr_dis(pci);
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4d794964fa0f..d424e5e55c9f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -740,11 +740,8 @@ EXPORT_SYMBOL_GPL(dw_pcie_link_up);
>   
>   void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>   {
> -	u32 val;
> -
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> -	val |= PORT_MLTI_UPCFG_SUPPORT;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> +	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_MULTI_LANE_CTRL,
> +				    0, PORT_MLTI_UPCFG_SUPPORT);
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
>   
> @@ -805,21 +802,12 @@ int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
>   
>   static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>   {
> -	u32 lnkcap, lwsc, plc;
> +	u32 plc = 0;
>   	u8 cap;
>   
>   	if (!num_lanes)
>   		return;
>   
> -	/* Set the number of lanes */
> -	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -	plc &= ~PORT_LINK_FAST_LINK_MODE;
> -	plc &= ~PORT_LINK_MODE_MASK;
> -
> -	/* Set link width speed control register */
> -	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> -	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>   	switch (num_lanes) {
>   	case 1:
>   		plc |= PORT_LINK_MODE_1_LANES;
> @@ -837,14 +825,19 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>   		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
>   		return;
>   	}
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> +	/* Set the number of lanes */
> +	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_LINK_CONTROL,
> +				    PORT_LINK_FAST_LINK_MODE | PORT_LINK_MODE_MASK,
> +				    plc);
> +	/* Set link width speed control register */
> +	dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +				    PORT_LOGIC_LINK_WIDTH_MASK,
> +				    PORT_LOGIC_LINK_WIDTH_1_LANES);
>   
>   	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> -	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
> -	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
> -	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> +	dw_pcie_clear_and_set_dword(pci, cap + PCI_EXP_LNKCAP,
> +				    PCI_EXP_LNKCAP_MLW,
> +				    FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes));
>   }
>   
>   void dw_pcie_iatu_detect(struct dw_pcie *pci)
> @@ -1133,38 +1126,27 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
>   
>   void dw_pcie_setup(struct dw_pcie *pci)
>   {
> -	u32 val;
> -
>   	dw_pcie_link_set_max_speed(pci);
>   
>   	/* Configure Gen1 N_FTS */
> -	if (pci->n_fts[0]) {
> -		val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
> -		val &= ~(PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK);
> -		val |= PORT_AFR_N_FTS(pci->n_fts[0]);
> -		val |= PORT_AFR_CC_N_FTS(pci->n_fts[0]);
> -		dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
> -	}
> +	if (pci->n_fts[0])
> +		dw_pcie_clear_and_set_dword(pci, PCIE_PORT_AFR,
> +					    PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK,
> +					    PORT_AFR_N_FTS(pci->n_fts[0]) |
> +					    PORT_AFR_CC_N_FTS(pci->n_fts[0]));
>   
>   	/* Configure Gen2+ N_FTS */
> -	if (pci->n_fts[1]) {
> -		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -		val &= ~PORT_LOGIC_N_FTS_MASK;
> -		val |= pci->n_fts[1];
> -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> -	}
> +	if (pci->n_fts[1])
> +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +					    PORT_LOGIC_N_FTS_MASK, pci->n_fts[1]);
>   
> -	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
> -		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> -		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> -		       PCIE_PL_CHK_REG_CHK_REG_START;
> -		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> -	}
> +	if (dw_pcie_cap_is(pci, CDM_CHECK))
> +		dw_pcie_clear_and_set_dword(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, 0,
> +					    PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
> +					    PCIE_PL_CHK_REG_CHK_REG_START);
>   
> -	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> -	val &= ~PORT_LINK_FAST_LINK_MODE;
> -	val |= PORT_LINK_DLL_LINK_EN;
> -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> +	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_LINK_CONTROL,
> +				    PORT_LINK_FAST_LINK_MODE, PORT_LINK_DLL_LINK_EN);
>   
>   	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
>   }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f401c144df0f..5a0aa154eb2a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -720,24 +720,14 @@ static inline void dw_pcie_clear_and_set_dword(struct dw_pcie *pci, int pos,
>   
>   static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
>   {
> -	u32 reg;
> -	u32 val;
> -
> -	reg = PCIE_MISC_CONTROL_1_OFF;
> -	val = dw_pcie_readl_dbi(pci, reg);
> -	val |= PCIE_DBI_RO_WR_EN;
> -	dw_pcie_writel_dbi(pci, reg, val);
> +	dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
> +				    0, PCIE_DBI_RO_WR_EN);
>   }
>   
>   static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>   {
> -	u32 reg;
> -	u32 val;
> -
> -	reg = PCIE_MISC_CONTROL_1_OFF;
> -	val = dw_pcie_readl_dbi(pci, reg);
> -	val &= ~PCIE_DBI_RO_WR_EN;
> -	dw_pcie_writel_dbi(pci, reg, val);
> +	dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
> +				    PCIE_DBI_RO_WR_EN, 0);
>   }
>   
>   static inline int dw_pcie_start_link(struct dw_pcie *pci)


