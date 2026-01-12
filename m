Return-Path: <linux-pci+bounces-44470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4ED10DA7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 08:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D603D307C729
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57348330324;
	Mon, 12 Jan 2026 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Vwq6YcH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973180.qiye.163.com (mail-m1973180.qiye.163.com [220.197.31.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D632FA29;
	Mon, 12 Jan 2026 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768202698; cv=none; b=gwOkZ89bgm4BjjKGzx58YkIYXlhXMPNtU9pxHcJHJskcN0ldI6vwBQNUGKMnJCXuk4hAnYqxsgDnapcpGwFDJoeZTen9P0EnzlfgVXVhc0NF67f9sSbVT9gGlVeAY2y3ZXaLe1M4wzpSUs669zLtXSeJMmeURh/om+DsS7LrQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768202698; c=relaxed/simple;
	bh=TVl+0BDQtLEYkCDlB7dGp8yYMkNIpMMuVR4ynTqryGI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9wVQKtUsxLTcBm8a7iGD+PgRS+crqaulLBSlj/U6q60O17Ebf4uat+K46xLfoz7p0aOvhqHWOWaYgMaeRFZCB8WaiBbxQGvihqOgnW8nN1qFg51bDcdsL8VQ2T1N0wvvREtIWoyJGuFmSwQ0t+D+j1oUvVVRfF5o8n+fPr+TEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Vwq6YcH0; arc=none smtp.client-ip=220.197.31.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 304bd6f5e;
	Mon, 12 Jan 2026 15:19:37 +0800 (GMT+08:00)
Message-ID: <b6667d54-ebb7-4594-a65e-011f0bf0d3cd@rock-chips.com>
Date: Mon, 12 Jan 2026 15:19:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, oe-kbuild-all@lists.linux.dev,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition
 trace support
To: kernel test robot <lkp@intel.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <1768180800-63364-4-git-send-email-shawn.lin@rock-chips.com>
 <202601121428.WVvakywZ-lkp@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <202601121428.WVvakywZ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bb113183609cckunm1596f8d92bc8bf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1LS1ZLSUwZGhkfGB5MSEJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0
	pVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=Vwq6YcH02L/z2pSxGAI+djdeOneXnSlu4g4J0rkPgg1Vs3UCnWjVBxYaWuHuu0kScG34+K9P/gVm59huZBBaXAp9RqKIGc0oaPUCjzGtDzu0pvxDzgoJdDRPDTy597sGUFnf/hyIiBDDwWe6Item4gbwjjXbZk8/FcTEetG0iMc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=e3jKY3hTxixp5DahAQTFxXosmfx7lVCjtHXMKuxx6ks=;
	h=date:mime-version:subject:message-id:from;


在 2026/01/12 星期一 14:42, kernel test robot 写道:
> Hi Shawn,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on next-20260109]
> [cannot apply to pci/for-linus trace/for-next mani-mhi/mhi-next linus/master v6.19-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/PCI-trace-Add-PCI-controller-LTSSM-transition-tracepoint/20260112-100141
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> patch link:    https://lore.kernel.org/r/1768180800-63364-4-git-send-email-shawn.lin%40rock-chips.com
> patch subject: [PATCH v3 3/3] PCI: dw-rockchip: Add pcie_ltssm_state_transition trace support
> config: loongarch-randconfig-002-20260112 (https://download.01.org/0day-ci/archive/20260112/202601121428.WVvakywZ-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601121428.WVvakywZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601121428.WVvakywZ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/pci/controller/dwc/pcie-dw-rockchip.c: In function 'rockchip_pcie_ltssm_trace_work':
>>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:264:41: error: implicit declaration of function 'dw_pcie_ltssm_status_string' [-Wimplicit-function-declaration]
>       264 |                                         dw_pcie_ltssm_status_string(state),

Hi lkp,

It depends on another patch mentioned in the cover letter. So the
complie error is expected right now.


>           |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/pci/controller/dwc/pcie-dw-rockchip.c:264:41: error: passing argument 2 of 'trace_pcie_ltssm_state_transition' makes pointer from integer without a cast [-Wint-conversion]
>       264 |                                         dw_pcie_ltssm_status_string(state),
>           |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>           |                                         |
>           |                                         int
>     In file included from include/trace/events/pci_controller.h:9,
>                      from drivers/pci/controller/dwc/pcie-dw-rockchip.c:26:
>     include/trace/events/pci_controller.h:20:52: note: expected 'const char *' but argument is of type 'int'
>        20 |         TP_PROTO(const char *dev_name, const char *state, u32 rate),
>           |                                        ~~~~~~~~~~~~^~~~~
>     include/linux/tracepoint.h:288:41: note: in definition of macro '__DECLARE_TRACE'
>       288 |         static inline void trace_##name(proto)                          \
>           |                                         ^~~~~
>     include/linux/tracepoint.h:494:31: note: in expansion of macro 'PARAMS'
>       494 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
>           |                               ^~~~~~
>     include/linux/tracepoint.h:632:9: note: in expansion of macro 'DECLARE_TRACE_EVENT'
>       632 |         DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
>           |         ^~~~~~~~~~~~~~~~~~~
>     include/linux/tracepoint.h:632:35: note: in expansion of macro 'PARAMS'
>       632 |         DECLARE_TRACE_EVENT(name, PARAMS(proto), PARAMS(args))
>           |                                   ^~~~~~
>     include/trace/events/pci_controller.h:19:1: note: in expansion of macro 'TRACE_EVENT'
>        19 | TRACE_EVENT(pcie_ltssm_state_transition,
>           | ^~~~~~~~~~~
>     include/trace/events/pci_controller.h:20:9: note: in expansion of macro 'TP_PROTO'
>        20 |         TP_PROTO(const char *dev_name, const char *state, u32 rate),
>           |         ^~~~~~~~
> 
> 
> vim +/dw_pcie_ltssm_status_string +264 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> 
>     225	
>     226	#ifdef CONFIG_TRACING
>     227	static void rockchip_pcie_ltssm_trace_work(struct work_struct *work)
>     228	{
>     229		struct rockchip_pcie *rockchip = container_of(work, struct rockchip_pcie,
>     230							trace_work.work);
>     231		struct dw_pcie *pci = &rockchip->pci;
>     232		enum dw_pcie_ltssm state;
>     233		u32 i, l1ss, prev_val = DW_PCIE_LTSSM_UNKNOWN, rate, val;
>     234	
>     235		for (i = 0; i < PCIE_DBG_LTSSM_HISTORY_CNT; i++) {
>     236			val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_DBG_FIFO_STATUS);
>     237			rate = FIELD_GET(PCIE_DBG_FIFO_RATE_MASK, val);
>     238			l1ss = FIELD_GET(PCIE_DBG_FIFO_L1SUB_MASK, val);
>     239			val = FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
>     240	
>     241			/*
>     242			 * Hardware Mechanism: The ring FIFO employs two tracking counters:
>     243			 * - 'last-read-point': maintains the user's last read position
>     244			 * - 'last-valid-point': tracks the hardware's last state update
>     245			 *
>     246			 * Software Handling: When two consecutive LTSSM states are identical,
>     247			 * it indicates invalid subsequent data in the FIFO. In this case, we
>     248			 * skip the remaining entries. The dual-counter design ensures that on
>     249			 * the next state transition, reading can resume from the last user
>     250			 * position.
>     251			 */
>     252			if ((i > 0 && val == prev_val) || val > DW_PCIE_LTSSM_RCVRY_EQ3)
>     253				break;
>     254	
>     255			state = prev_val = val;
>     256			if (val == DW_PCIE_LTSSM_L1_IDLE) {
>     257				if (l1ss == 2)
>     258					state = DW_PCIE_LTSSM_L1_2;
>     259				else if (l1ss == 1)
>     260					state = DW_PCIE_LTSSM_L1_1;
>     261			}
>     262	
>     263			trace_pcie_ltssm_state_transition(dev_name(pci->dev),
>   > 264						dw_pcie_ltssm_status_string(state),
>     265						((rate + 1) > pci->max_link_speed) ?
>     266						PCI_SPEED_UNKNOWN : PCIE_SPEED_2_5GT + rate);
>     267		}
>     268	
>     269		schedule_delayed_work(&rockchip->trace_work, msecs_to_jiffies(5000));
>     270	}
>     271	
> 


