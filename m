Return-Path: <linux-pci+bounces-38711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB909BEF608
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D8AE4E0320
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 05:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD66240611;
	Mon, 20 Oct 2025 05:54:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521435950;
	Mon, 20 Oct 2025 05:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760939667; cv=none; b=RbjK/cmH9+N7ZaAXFZJM/CW85xHYstBzTNqeN2/38SRWrj/Txo3K8rfbjKrFoePKH5L9caytLZXHbsHIyatM7ZgTZr2ogho/jo1utqfWxnAq2AGURChAGwecGglBHSoGfuOvClJNrWJajI+l//Xr7GmFCfR7dHjEvmIM9gN31yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760939667; c=relaxed/simple;
	bh=ahEN120RiA5KJNgr2n7cvAZ7IHqpvOuOAHoh+KfP4DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixodrYmncnFatpcchoB8PodXoWGiqxGJoznbBY8Q+szCx2G8f+kN5pUInZ+6m71s7qTPrEWq9WYjv5BdvP2qbWIzWj5iPfbPVJu9NlaO5xgzUQKwBcCGQ8W6EOi1cFA/vr7aBVF9o4yzKypmh/hFrVNfhMSQ7QWrGs7Zk543+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1760939614t5c453bdf
X-QQ-Originating-IP: U5j3Bti5rsZtBzG/p7qq78o6KBS1qijssVWI0mMLFLs=
Received: from [IPV6:240f:10b:7440:1:9bef:b2b: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Oct 2025 13:53:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14762818756063502707
Message-ID: <6EF8998620B7739C+ae4bf629-2d0a-4adb-b724-1f0964283d5a@radxa.com>
Date: Mon, 20 Oct 2025 14:53:26 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20251017163252.598812-2-cassel@kernel.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20251017163252.598812-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NiJgP/70eYXdaODmlBzW5kTPZ9iWTkDJY5neno+RXgQ+7h5FMEX1nuev
	265XT+tWD//dfO3tLHO/IAiY0n4vKzrPVeDRp/ms5BJxI7TV+KaN76et/IkmFk+fDua0Sv8
	F9ilPgjTT+gDuWvAYC3FMYgFtfI1zQvEhpnWJDvqci05yXPUqQ9fzq19+IMYMFuTpWfbbc4
	WHjkkQ0yyaUihU9dxJZaTHrfAhpB36iUIhR+7opx+hyD7PQXa99wY427sMTPq4XzZIpWe9i
	wwHgTaL5oRVbxl5lBi7Z5f6xcoDaz2HzZaFu7uzRxNL7FJROjqJiVmRaSpbKr43a0bmmWFB
	0/izCxajvq+0PLPk2Ztse5M8CWYKn+PG/OP8B57YZvDfVvYP4edKqDxN0eHMJor1UlUeRjI
	2Casci4LGOtvqFvWiwNelWpWeAnJ+n3t7ncXq9D4YlHcaa/Jko7atieb6FS8C8wRJknlKqt
	cSe0mxF4sUWHQcFl6NzGuXicKCEV+9LuQYSnwK4NMpl0Ery85q0Meng8Afrggv8KHJIU7ot
	VZuNJW6g9i4jBgmtLEcBNzjijPyb7RURmN7L0iAwmcpycxtcGeFG4+LdXwKToslcjvG5g5W
	9niulh0ExzegavYaQyLc5LbLcnBCJF86GUY/luwcG0OYjwVyc8W4ni5Jq2FcUkdNHzhlpbu
	mMWsgU2Ley2JFI4hVS1cWYisuE5XT/m0ZIyQu8u7tT2Pguu9TP4gV78PHmDm07DG0m/lq0Y
	ECub2Dii0zXH3TgQ/cJZVOp2DMr8UIETS9+2dXyB6RS7IZ/WD7OTAi7wRR66tr2rtMPs41F
	Kvs940rZPU/Wry4maeOWEDn3y7MVO6b4ARBdD4EqkJ51pSIOYvXZv209K677IqqVP9kEE5q
	Dc8sWhA14BRPcKdR/CqT9pgFkuQyUYvja8vNrJy+mKCCIVZuqOpPaNPnVPqsCBDC0pAr/v6
	6tX7vi1mONVmXcw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi Niklas,

Thank you for your work.

On 10/18/25 01:32, Niklas Cassel wrote:
> The L1 substates support requires additional steps to work, namely:
> -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
>   hardware, but software still needs to set the clkreq fields in the
>   PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> -Program the frequency of the aux clock into the
>   DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
>   is turned off and the aux_clk is used instead.)
> 
> These steps are currently missing from the driver.
> 
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
> 
> While this has always been a problem when using e.g.
> CONFIG_PCIEASPM_POWER_SUPERSAVE=y, or when modifying
> /sys/bus/pci/devices/.../link/l1_2_aspm, the lacking driver support for L1
> substates became more apparent after commit f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms"), which
> enabled ASPM also for CONFIG_PCIEASPM_DEFAULT=y.
> 
> When using e.g. an NVMe drive connected to the PCIe controller, the
> problem will be seen as:
> nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> nvme nvme0: Does your device have a faulty power saving mode enabled?
> nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
> 
> Thus, prevent advertising L1 Substates support until proper driver support
> is added.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

I've confirmed this patch resolves the issue in v6.18-rc1 using the 
following configuration:

  ROCK 5A & M.2 RTL8852BE
  ROCK 5B & M.2 MT7921E, NVMe SSD
  ROCK 5T & on-board AX210, NVMe SSD x2
  ROCK 5 ITX+ & M.2 MT7922E, NVMe SSD x2

Therefore,

  Tested-by: FUKAUMI Naoki <naoki@radxa.com>

Best regards,

(P.S. I couldn't test on the ROCK 5B & M.2 RTL8852BE, ROCK 5B+ & 
on-board RTL8852BE, and ROCK 5C & ASM2806 due to separate issues.)

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
> Changes since v2:
> -Improve commit message (Bjorn)
> 
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..84f882abbca5 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -200,6 +200,25 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>   	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>   }
>   
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> + * needed to support L1 substates. Currently, not a single rockchip platform
> + * performs these steps, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> +{
> +	u32 cap, l1subcap;
> +
> +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (cap) {
> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> +			      PCI_L1SS_CAP_PCIPM_L1_2);
> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> +	}
> +}
> +
>   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>   {
>   	u32 cap, lnkcap;
> @@ -264,6 +283,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>   					 rockchip);
>   
> +	rockchip_pcie_disable_l1sub(pci);
>   	rockchip_pcie_enable_l0s(pci);
>   
>   	return 0;
> @@ -301,6 +321,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>   	enum pci_barno bar;
>   
> +	rockchip_pcie_disable_l1sub(pci);
>   	rockchip_pcie_enable_l0s(pci);
>   	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>   


