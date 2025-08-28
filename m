Return-Path: <linux-pci+bounces-35048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF8B3AA9E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DC956352B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD2322C9B;
	Thu, 28 Aug 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RhFTCNal"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE48270EDF;
	Thu, 28 Aug 2025 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408188; cv=none; b=Q1oQMe0FuT4Zn0bC2J153AO8m8ij0d3orGUlVjXoUW6JssQx1HmXJa2lsLTGy5zPU5wgyvAJOORUYKmkse0+jzhbakQ9qeiRAe/YWbqkBZCEMVLFkPgkPRd8Xy8/JC4P0kp2smjGHpjpA/aKvpwNTyS0YrARTG/xOZYg/7OvYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408188; c=relaxed/simple;
	bh=gavNgOkKhfNDiKl/9ak68KmaoC3d7rurjPpAvEBhBm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=owHZpbFILt6Qh0utJ0QflOE1ZNw/6qwxUNSQkzCpcbk8Tl3El64qqiiTQHkmF2FulVLi43+tf9zYmpDnmadyYX8qW3V1e/ZVVovnnipK0EJ5g7AxX52MXtTylrealI2LAusTuB86U97f2/u7efwDA8jEBQNI/M0RU/yDlkPCPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RhFTCNal; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SHMa4r004299;
	Thu, 28 Aug 2025 21:09:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	DLM5AUfns2hb2my8bJBgZg9LR+O4etaj8IVbPYQY7Rc=; b=RhFTCNalC7NV3IWu
	xQpiT6P0FVLKeJXQW9GiLN0GG7LUh43kdqmlK4HiSLD9Ae0g/UkOuYn4cJ1KfzjX
	tJKXsbZtvrENSZV839CiopyHlwa3oekKuRBQYKlN+u+Kjik9ozXO08L97ESHwP+N
	4Q81SSH3sn7Aksh95UvJhGhPY0TVjHiuf2nAuONNPigFPhasS1vMFR/0HSX5cLLp
	SIQkooY9sAOgWTHTkkct52TZ25OLklFDZauAL8wZ0+xrOEzCktEHHidqR5XSLkZd
	dTXpT/3vXdRw4wJNFWHGFvaxDYglybIxKSZT87+JNZQ2UBMV2LL8OEC2oa1M1OZa
	svWbAw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qrkmuggq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 21:09:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1ADA04002D;
	Thu, 28 Aug 2025 21:07:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9DE2276BE64;
	Thu, 28 Aug 2025 21:06:37 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 21:06:35 +0200
Message-ID: <0fbf4be0-af6e-4119-a838-e3fc9ab1fc9d@foss.st.com>
Date: Thu, 28 Aug 2025 21:06:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/11] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linus.walleij@linaro.org>,
        <corbet@lwn.net>, <p.zabel@pengutronix.de>, <shradha.t@samsung.com>,
        <mayank.rana@oss.qualcomm.com>, <namcao@linutronix.de>,
        <qiang.yu@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <inochiama@gmail.com>, <quic_schintav@quicinc.com>,
        <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20250828172253.GA949714@bhelgaas>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250828172253.GA949714@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01



On 8/28/25 19:22, Bjorn Helgaas wrote:
> On Wed, Aug 20, 2025 at 09:54:06AM +0200, Christian Bruel wrote:
>> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
>> controller based on the DesignWare PCIe core in endpoint mode.
>> ...
> 
>> +static int stm32_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	int ret;
>> +
>> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
>> +		dev_dbg(pci->dev, "Link is already enabled\n");
>> +		return 0;
>> +	}
> 
> While looking at the "incorrectly reset" comment, I noticed
> stm32_pcie->link_status and wondered why it exists.  It looks like
> it's only used in stm32_pcie_start_link() and stm32_pcie_stop_link(),
> and I don't see similar tracking in other drivers.
> 
> It feels a little racy because the link might go down for reasons
> other than calling stm32_pcie_stop_link().

I think that as an excess of paranoid that was meant to protect against 
a driver unbind when the link hasn’t started yet. In that case, 
stm32_pcie_remove() would disable a link that’s already disabled.

But that shouldn’t be a problem to disable twice the ltssm enable bit, 
as well as the perst irq. I’ll look into removing it. Is it okay if I do 
this with a fixup patch?

thank you
Christian


> 
>> +	dev_dbg(pci->dev, "Enable link\n");
>> +
>> +	ret = stm32_pcie_enable_link(pci);
>> +	if (ret) {
>> +		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	enable_irq(stm32_pcie->perst_irq);
>> +
>> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_ENABLED;
>> +
>> +	return 0;
>> +}
>> +
>> +static void stm32_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +
>> +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_DISABLED) {
>> +		dev_dbg(pci->dev, "Link is already disabled\n");
>> +		return;
>> +	}
>> +
>> +	dev_dbg(pci->dev, "Disable link\n");
>> +
>> +	disable_irq(stm32_pcie->perst_irq);
>> +
>> +	stm32_pcie_disable_link(pci);
>> +
>> +	stm32_pcie->link_status = STM32_PCIE_EP_LINK_DISABLED;
>> +}


