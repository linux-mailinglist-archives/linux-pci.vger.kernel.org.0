Return-Path: <linux-pci+bounces-18084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943D09EC2C9
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D707280E16
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A4E1EE7A1;
	Wed, 11 Dec 2024 03:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f+ADA/CX"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF952451C5
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886400; cv=none; b=LnFgFXCrZMJw0fx0EMqk9UtLnsss0TDUYEcaJ9uZz+4X4mHWafFWi0IHlWO6E3jdN5u3u7M1skrrWXHSaBPmtI/mjl64J1TjMnS3HLGphpk3DDqMeOTluhKUstuJwiWOOHLak+cVGJ05exeSweNy5VgMZ3DPZklFttRmfkdp2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886400; c=relaxed/simple;
	bh=Wq44+D4jpywCOP6xpViDZsBxZPaPpHyg150p6rViGjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djK7AkH69ZrJw5FqcL6+AbV27tHkO4POF6OUgGItqRKz8BnQ7jDne3tys7mI0/e61vzWf/rxC12WcFKXmGSB4L4uBiCMOJfZmk/ikHcyc09Ql6Du/2NM7L4HUP8l36dyApCd4h3O9Lx6Vs8ivWd4XCKKqAFKzlgofJNbZRnT95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f+ADA/CX; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733886394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vyc15/S70zbPXouLqOX6Ty+rFq+FdWeJah+IsuLhbDM=;
	b=f+ADA/CXLBLmH0QKl80wZydgUpdLICAE5NVk9RF79Lm0YFpQeWhZKWxcxAg68fSeNt8ITq++V9L6Yu+2CfgqxRguVo9UEAAo8Uz4B+YAIjuUIqhLvUrFiuqV6/svj2wsBglvvT/lM04IQAe9Y7hK77nedvOvyRGUaQemb9oA9S4=
Received: from 30.166.1.177(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLGf11y_1733886393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 11:06:33 +0800
Message-ID: <0883f9ec-b984-4374-b54e-9a4c881e9be3@linux.alibaba.com>
Date: Wed, 11 Dec 2024 11:06:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/dwc_pcie: Add support for Rockchip SoCs
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org
References: <1733885598-107771-1-git-send-email-shawn.lin@rock-chips.com>
 <1733885598-107771-2-git-send-email-shawn.lin@rock-chips.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1733885598-107771-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 10:53, Shawn Lin 写道:
> Add support for Rockchip SoCs by adding vendor ID to the vendor list.
> And fix the lane-event based enable/disable/read process which is slightly
> different on Rockchip SoCs, by checking vendor ID.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>   drivers/perf/dwc_pcie_pmu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 9cbea96..b3276b8 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -108,6 +108,7 @@ static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
>   	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
>   	{.vendor_id = PCI_VENDOR_ID_AMPERE },
>   	{.vendor_id = PCI_VENDOR_ID_QCOM },
> +	{.vendor_id = PCI_VENDOR_ID_ROCKCHIP },

Hi, Shawn,

Bjorn is working on fixing the VSEC matching[1], could you rebase on his lastest patch?

[1] https://lore.kernel.org/r/20231012162512.GA1069387@bhelgaas

Best Regards,
Shuai

>   	{} /* terminator */
>   };
>   
> @@ -256,12 +257,27 @@ static const struct attribute_group *dwc_pcie_attr_groups[] = {
>   	NULL
>   };
>   
> +static void dwc_pcie_pmu_lane_event_enable_for_rk(struct pci_dev *pdev,
> +						  u16 ras_des_offset,
> +						  bool enable)
> +{
> +	if (enable)
> +		pci_write_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> +				       DWC_PCIE_CNT_ENABLE | DWC_PCIE_PER_EVENT_ON);
> +	else
> +		pci_clear_and_set_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_CTL,
> +				       DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
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
> @@ -287,9 +303,14 @@ static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
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
> +
>   	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
>   
>   	return val;


