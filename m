Return-Path: <linux-pci+bounces-18471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7D9F285B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 03:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE22B7A12DD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CC58BE8;
	Mon, 16 Dec 2024 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wrNdKFGw"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E745917C64
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734314672; cv=none; b=drWY0/pQy2QcDpOo9iwYGrSuUvNvI3RquD6tyZPpTYl9Nk7v5S7JUOOPHlRx+E4AwVfAagl0HF4Nqv8wTLK0gTqTpHsaEyI+/TyAWW+5U6Gw5vJXwjz6o0t1ejT8AVgXgGeSXqBpXPNmbEkWTx1bQtvvljMUyEyKE7gdNmBebk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734314672; c=relaxed/simple;
	bh=c8NhwMiQ10hVa8L2LJ1fhHQQi6EFQ8op/Qos4bspSSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8nRuRB6vK1dfZ5N+HcqGm7mUrngdIlXSoCeJZAZBWNoXnoGsoFkEz/aX+xlN+2/06W8xpZgmbAgZVeq1cwe0hIAxL3tdMFv2+8Mvt7n5DgjQhOHilqnH766IBLiVBviXZy0OIZwZPexUkk/5/nXg3pyqEOo9ZpzdOCplyBYPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wrNdKFGw; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734314662; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=24DfLfcLombAJYbHSYVsdhGBS3LkiqYZobdq0gmMRQM=;
	b=wrNdKFGwxJ0JSVNPsJ3UhjB8D+GJt1m+cdoUMyOPdLKdSE5C0A9/mV2tUpzX5vEJJ670MIWmY7dfUCldzvoybAnMDrfCiDWmrMBAoO1QTB2jfg5qsyaNOTFg72IvwIm6GbooWI0JfrkBvnigIS18Gt2oZPrk6n8v+am5cMp+OFg=
Received: from 30.246.161.240(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLVFj53_1734314660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 10:04:21 +0800
Message-ID: <4d1f22d2-2436-4cb8-8bb1-1e1d8edf92a6@linux.alibaba.com>
Date: Mon, 16 Dec 2024 10:04:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] perf/dwc_pcie: Add support for Rockchip SoCs
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org
References: <1734063843-188144-1-git-send-email-shawn.lin@rock-chips.com>
 <1734063843-188144-2-git-send-email-shawn.lin@rock-chips.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1734063843-188144-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/13 12:24, Shawn Lin 写道:
> Add support for Rockchip SoCs by adding vendor ID to the vendor list.
> And fix the lane-event based enable/disable/read process which is slightly
> different on Rockchip SoCs, by checking vendor ID.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v3: None
> Changes in v2:
> - rebase on Bejorn's new patch about Qualifing VSEC Capability by Vendor, Revision
> 
>   drivers/perf/dwc_pcie_pmu.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index d022f49..ba6d5116 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -116,6 +116,8 @@ static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
>   	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>   	{ .vendor_id = PCI_VENDOR_ID_QCOM,
>   	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_ROCKCHIP,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
>   	{} /* terminator */
>   };
>   
> @@ -264,12 +266,27 @@ static const struct attribute_group *dwc_pcie_attr_groups[] = {
>   	NULL
>   };
>   
> +static void dwc_pcie_pmu_lane_event_enable_for_rk(struct pci_dev *pdev,
> +						  u16 ras_des_offset,
> +						  bool enable)
> +{
> +	if (enable)
> +		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> +				DWC_PCIE_CNT_ENABLE | DWC_PCIE_PER_EVENT_ON);

DWC_PCIE_CNT_ENABLE is a bit mask,

     #define DWC_PCIE_CNT_ENABLE			GENMASK(4, 2)
     #define DWC_PCIE_PER_EVENT_ON			0x3

so, DWC_PCIE_CNT_ENABLE | DWC_PCIE_PER_EVENT_ON == DWC_PCIE_CNT_ENABLE.

what value do you really intend to set here?


> +	else
> +		pci_clear_and_set_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> +				DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);

It is really weird that DWC_PCIE_PER_EVENT_ON mean disable.
Does 0x3 in the register data book for ROCKCHIP means "per event off"?

The register data book from my hand:

     - 0x1 (PER_EVENT_OFF): per event off
     - 0x3 (PER_EVENT_ON): per event on

> +}
> +
>   static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu *pcie_pmu,
>   					   bool enable)
>   {
>   	struct pci_dev *pdev = pcie_pmu->pdev;
>   	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>   
> +	if (pdev->vendor == PCI_VENDOR_ID_ROCKCHIP)
> +		return dwc_pcie_pmu_lane_event_enable_for_rk(pdev, ras_des_offset, enable);
> +
>   	if (enable)
>   		pci_clear_and_set_config_dword(pdev,
>   					ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> @@ -295,9 +312,14 @@ static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
>   {
>   	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
>   	struct pci_dev *pdev = pcie_pmu->pdev;
> +	int event_id = DWC_PCIE_EVENT_ID(event);
>   	u16 ras_des_offset = pcie_pmu->ras_des_offset;
>   	u32 val;
>   
> +	if (pdev->vendor == PCI_VENDOR_ID_ROCKCHIP)
> +		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> +				       event_id << 16);

I think dwc_pcie_pmu_event_add() has done the same work to set the event id.

Best Regards,
Shuai


