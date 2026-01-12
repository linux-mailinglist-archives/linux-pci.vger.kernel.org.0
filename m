Return-Path: <linux-pci+bounces-44510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AF9D13B05
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 16:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE65230F479E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D162E7186;
	Mon, 12 Jan 2026 15:16:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09842BD5BB;
	Mon, 12 Jan 2026 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231007; cv=none; b=jdbEJlqP99xOmwg+rNbe0aKOTkW7v3FbFDrpTkjSNyhQwWXjhnJEzcsV1eWsQrFMKXz7fpQ4Wv0Di3uy8ExiXsZXNENgIHjXO3A5EFNWEz1P2vgvMTG/AdAl8mN422ATWaQaGOf7TPclsN+gfAAZb7Pb0+gDPRc5fe/DTD6xyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231007; c=relaxed/simple;
	bh=wPgiadCiymx4SgYtzEsDOyDQF6+5TWtuEQapElgaS7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmqROHSJiov6wjuiw9BuhtUayWMCPV/Y4PIO7nxSKIqpu2pKgqH1nNUXpn9rCfRDMJUiRBfZ1ApZMkt3sFks36X6YrglZOp0GEjI3qsjdVtqSrBw7SosH77vQ0Q91/A2lkv/Jirvwk5xHlA6I1l3ebYQeerUJGYFWkV5+deZjL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F167F59162;
	Mon, 12 Jan 2026 15:16:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id EF4E42002B;
	Mon, 12 Jan 2026 15:16:41 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:16:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-rockchip@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dw-rockchip: Add
 pcie_ltssm_state_transition trace support
Message-ID: <20260112101644.5c1b772a@gandalf.local.home>
In-Reply-To: <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>
References: <1768180800-63364-1-git-send-email-shawn.lin@rock-chips.com>
	<1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: EF4E42002B
X-Stat-Signature: pkqtmyjz99xk34i7gczso7nyxz4r8ksh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18oHLU8bzt/wclyIb/7L7zxrvbI6h4Fzu4=
X-HE-Tag: 1768231001-775116
X-HE-Meta: U2FsdGVkX1+0ozTFidj5QYjHCytY6PnsZObGBoyUvQcbsME2aCgsV8Bqd+z+IQn22TVG6Z9v8kx5BcmsxhLQ03JfJ31/nTKUJdXObmPF2Px22LW4PizSVFOX2/RuPs+msd4DYCf0nlSKYNELv2zSL09/SIKtkfsV8dsMOq1e0qNaGjg/Mpdw2MX8D7eV0mI0nbxycs4HQgBOtWCpt02W9D/1M24aOTFqQT5cxO/zJnqgRfltvPmQ7qaXxU5BFuQZM2jLNV4ct33BvnmecUYgDZt6f+s9JMFu5bF/Bz7WT0mVxRdn8j622pKY1JKQPmYRwYI++4n3gkCiPcmgm/m+Nu07fmtKft/NgqqxYlC4Yp9ysE5mvNSK5Bvamus1PKygTFIILVUMsta+5MJvHzx2aWRwwYMiEd2F

On Mon, 12 Jan 2026 09:20:00 +0800
Shawn Lin <shawn.lin@rock-chips.com> wrote:

> Rockchip platforms provide a 64x4 bytes debug FIFO to trace the
> LTSSM history. Any LTSSM change will be recorded. It's userful
> for debug purpose, for example link failure, etc.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3:
> - reorder variables(Mani)
> - rename loop to i; rename en to enable(Mani)
> - use FIELD_GET(Mani)
> - add comment about how the FIFO works(Mani)
> 
> Changes in v2:
> - use tracepoint
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 104 ++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 352f513..344e0b9 100644
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
> @@ -73,6 +75,20 @@
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
> +#define  PCIE_DBG_FIFO_RATE_MASK	GENMASK(22, 20)
> +#define  PCIE_DBG_FIFO_L1SUB_MASK	GENMASK(10, 8)
> +#define PCIE_DBG_LTSSM_HISTORY_CNT	64
> +
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> @@ -96,6 +112,7 @@ struct rockchip_pcie {
>  	struct irq_domain *irq_domain;
>  	const struct rockchip_pcie_of_data *data;
>  	bool supports_clkreq;
> +	struct delayed_work trace_work;
>  };
>  
>  struct rockchip_pcie_of_data {
> @@ -206,6 +223,89 @@ static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
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
> +	u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
> +
> +	for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
> +		val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
> +		rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
> +		l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
> +		val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
> +
> +		/*
> +		 * Hardware Mechanism: The ring FIFO employs two tracking counters:
> +		 * - 'last-read-point': maintains the user's last read position
> +		 * - 'last-valid-point': tracks the hardware's last state update
> +		 *
> +		 * Software Handling: When two consecutive LTSSM states are identical,
> +		 * it indicates invalid subsequent data in the FIFO. In this case, we
> +		 * skip the remaining entries. The dual-counter design ensures that on
> +		 * the next state transition, reading can resume from the last user
> +		 * position.
> +		 */
> +		if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
> +			break;
> +
> +		state = prev_val = val;
> +		if (val == DW_PCIE_LTSSM_L1_IDLE) {
> +			if (l1ss == 2)
> +				state = DW_PCIE_LTSSM_L1_2;
> +			else if (l1ss == 1)
> +				state = DW_PCIE_LTSSM_L1_1;
> +		}
> +
> +		trace_pcie_ltssm_state_transition(dev_name(pci->dev),
> +					dw_pcie_ltssm_status_string(state),
> +					((rate + 1) > pci->max_link_speed) ?
> +					PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
> +	}

Does it make sense to call this work function every 5 seconds when the
tracepoint isn't enabled?

You can add a function callback to when the tracepoint is enabled by defining:

TRACE_EVENT_FN(<name>
 TP_PROTO(..)
 TP_ARGS(..)
 TP_STRUCT__entry(..)
 TP_fast_assign(..)
 TP_printk(..)

 reg,
 unreg)

reg() gets called when the tracepoint is first enabled. This could be where
you can start the work function. And unreg() would stop it.

You would likely need to also include state variables as I guess you don't
want to start it if the link is down. Also, if the tracepoint is enabled
when the link goes up you want to start the work queue.

I would recommend this so that you don't call this work function when it's
not doing anything useful.

-- Steve

 

> +
> +	schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
> +}
> +

