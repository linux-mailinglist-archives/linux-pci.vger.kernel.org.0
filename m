Return-Path: <linux-pci+bounces-44323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C603D0743A
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 06:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 870AE301A72D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 05:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019927FB2A;
	Fri,  9 Jan 2026 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkPVPG6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF7F22423A;
	Fri,  9 Jan 2026 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938136; cv=none; b=dOYOg6cz1qHN2psTxb966MtYJWGKnr4viPccpSn0446YmeIhkBVdUtJCgfxxoKYO050GcM8LqX7dVmBXwpK4i6dsM55SEUD61Uw3Wz8jq+8GXCFFT39vgNjP2/iIBUEa4DqxdzGAdn00XTi+EhWOryML27CfVvzLvPqLsmz6bWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938136; c=relaxed/simple;
	bh=Xmah2fsBv6aaemUTf9tH7mTXFAvunSW/EeH/0G/8mBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqchvK8ZNPwTTacYSTsFp/EY2s9b19pTaZoLf7jo+dOvvHiF/qk8MMZPPa+pvCGrVCFnx8QHi0w+9yShsqC3kNveI7vb2h8ntkjrC3xL4OUQdmCByWCFF4DgES1+dtqA4zSkN5G5oKhcb80egDNGMU7MAie8T8oCWcq6Vr7tab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkPVPG6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E32DC4CEF1;
	Fri,  9 Jan 2026 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767938135;
	bh=Xmah2fsBv6aaemUTf9tH7mTXFAvunSW/EeH/0G/8mBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mkPVPG6/6Loqb8VtpL4nPEI9uLfUygfu6zGe66kKr3RRxraMlyyFYEuwhX15q/3vF
	 ONNH5+5dpD5E5R5NqvHrEbm+dNWVI05QS3V3wl88h+pyQMDnpwHuMGqFT6MP5NDB6H
	 TUgRl+Sy+hsdQyyr95jmjfzJqxTZiCMh5/frAijKg9+rITEs9uFW5Fulfk+EmEZfma
	 x2XT3rP83fpI1WTziuMAPFBLxOhf8avvr5Mi2YIalTheo0JAGTdBySimG/KDWIaOYh
	 NPW50NJwOPSv9EdZ+BWcODIDtILIh9MMowZ8MHgwru5oUck6OAl7GjTK9a0GCqEORx
	 DERmT6he0DPFQ==
Date: Fri, 9 Jan 2026 11:25:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
Message-ID: <uev63wla4msmmhww4j3t2jim7lhvxjikvujwpxiblg5mz7jwwa@2jucxkbtcsfm>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
 <1767929389-143957-4-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1767929389-143957-4-git-send-email-shawn.lin@rock-chips.com>

On Fri, Jan 09, 2026 at 11:29:49AM +0800, Shawn Lin wrote:
> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
> LTSSM history. Any LTSSM change will be recorded. It's userful
> for debug purpose, for example link failure, etc.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2:
> - use tracepoint
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 92 +++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 352f513..be9639aa 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -22,6 +22,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/workqueue.h>
> +#include <trace/events/pci_controller.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> @@ -73,6 +75,18 @@
>  #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
>  #define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
>  
> +/* Debug FIFO information */
> +#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
> +#define  PCIE_CLIENT_DBG_EN		0xffff0007
> +#define  PCIE_CLIENT_DBG_DIS		0xffff0000
> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0	0x320
> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1	0x324
> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0	0x328
> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1	0x32c
> +#define  PCIE_CLIENT_DBG_TRANSITION_DATA 0xffff0000
> +#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
> +#define PCIE_DBG_LTSSM_HISTORY_CNT	64
> +
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> @@ -96,6 +110,7 @@ struct rockchip_pcie {
>  	struct irq_domain *irq_domain;
>  	const struct rockchip_pcie_of_data *data;
>  	bool supports_clkreq;
> +	struct delayed_work trace_work;
>  };
>  
>  struct rockchip_pcie_of_data {
> @@ -206,6 +221,79 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
>  	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
>  }
>  
> +#ifdef CONFIG_TRACING
> +static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
> +{
> +	struct rockchip_pcie *rockchip = container_of(work, struct rockchip_pcie,
> +						trace_work.work);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	enum dw_pcie_ltssm state;
> +	u32 val, rate, l1ss, loop, prev_val = DW_PCIE_LTSSM_UNKNOWN;

Reverse Xmas order please.

> +
> +	for (loop = 0; loop < PCIE_DBG_LTSSM_HISTORY_CNT; loop++) {

s/loop/i?

> +		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
> +		rate = (val & GENMASK(22, 20)) >> 20;
> +		l1ss = (val & GENMASK(10, 8)) >> 8;
> +		val &= PCIE_LTSSM_STATUS_MASK;

Can you use FIELD_ macros here?

> +
> +		/* Two consecutive identical LTSSM means invalid subsequent data */

Interesting. Does the hardware maintain a counter to track the reads? So once
you break out of the loop and read it after 5s, you'll start from where you left
i.e., the duplicate entry or from the start of the counter again?

> +		if ((loop > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
> +			break;
> +
> +		state = prev_val = val;
> +		if (val == DW_PCIE_LTSSM_L1_IDLE) {
> +			if (l1ss == 2)
> +				state = DW_PCIE_LTSSM_L1_2;
> +			else if (l1ss == 1)
> +				state = DW_PCIE_LTSSM_L1_1;

I believe L1.0 is not supported.

> +		}
> +
> +		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
> +					dw_pcie_ltssm_status_string(state),
> +					((rate + 1) > pci->max_link_speed) ?
> +					PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
> +	}
> +
> +	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
> +}
> +
> +static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
> +				      bool en)

s/en/enable

- Mani

-- 
மணிவண்ணன் சதாசிவம்

