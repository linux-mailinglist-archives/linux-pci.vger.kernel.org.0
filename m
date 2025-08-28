Return-Path: <linux-pci+bounces-35004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF3B39CF1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2C317AB2C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65162311946;
	Thu, 28 Aug 2025 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gyABa5UR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8C30F958;
	Thu, 28 Aug 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383416; cv=none; b=vCUUO3SPnnZkwwsvGK9lu2k+PN7rVTUd8OqOGMhaOe3+J4qWbFTG/g9P1NGptbr6lMkGczqprInYObL/8aVd8v0c8q5UfiBe0dD0S4wk3Wnr24LlbwGdomBtjgDUFK8XBrccZR7pAOEOJuFC/BNS6G2sS83PbS32bc0NGnRutYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383416; c=relaxed/simple;
	bh=aaV4x6280/CXvf8fKdJfOOVcKa+/PlLXRGgpk5EAZg0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=WmdKYjC3aMAubJ+0fIYe2i9K9RuZSMMiGOqyAu74nw89ofTBFRcFgKcjCB+h+Y6nt689b9XLw41Dq2tIklzHaGvlFUVL0ipoCqvDmUfINoVPxHXZC0XXuMYDXW+FVDeX0ksqNn98De8CMJwblDU0Ivp28leB6DFmp1CWy9/nJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gyABa5UR; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAJbT7003220;
	Thu, 28 Aug 2025 14:15:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	H2VjxPIys7d1tJoSW05HXWGO8B1PQC1RoUMeQHH1la8=; b=gyABa5URoIdL0qys
	8nCirTWeTflyOsuJyYXpsDDVA3hHboNWQpco+hkmcJZ4hpecA3kRy3o+RGR41538
	YlgI7saSguc+YAAM6UsqKjzRb6l582ilE/u6LaPff8muKBs9qp2hDkdvdObtHIb6
	Em6ELCC29h/Noubjyln1OLyPnAdp+HSOnO0de509FCkMiDJOkxL07lFkQ7nznvMy
	ydQWuw7sEn3myU8qdzK2+gQ/Lyq41sz8ocCROVnTgiZv4TyRCADCeSh2/9bMTu6B
	Wfv6BdSRNqc2ek/eZ9iJrCR1z9VRjVYabdE3vl9g3DLzWIDMGQV13qQd1y00iFFL
	sZ5Jbw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48q5tt5139-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 14:15:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EA37D40048;
	Thu, 28 Aug 2025 14:14:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A75372766C;
	Thu, 28 Aug 2025 14:13:02 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 14:13:00 +0200
Message-ID: <9133348a-f6a4-4425-98e2-a784a7620b3a@foss.st.com>
Date: Thu, 28 Aug 2025 14:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
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
References: <20250827185825.GA894342@bhelgaas>
Content-Language: en-US
In-Reply-To: <20250827185825.GA894342@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01



On 8/27/25 20:58, Bjorn Helgaas wrote:
> On Wed, Aug 20, 2025 at 09:54:06AM +0200, Christian Bruel wrote:
>> Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
>> controller based on the DesignWare PCIe core in endpoint mode.
> 
>> +static void stm32_pcie_perst_deassert(struct dw_pcie *pci)
>> +{
>> +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
>> +	struct device *dev = pci->dev;
>> +	struct dw_pcie_ep *ep = &pci->ep;
>> +	int ret;
>> +
>> +	dev_dbg(dev, "PERST de-asserted by host\n");
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
>> +		return;
>> +	}
>> +
>> +	ret = stm32_pcie_enable_resources(stm32_pcie);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable resources: %d\n", ret);
>> +		goto err_pm_put_sync;
>> +	}
>> +
>> +	/*
>> +	 * Need to reprogram the configuration space registers here because the
>> +	 * DBI registers were incorrectly reset by the PHY RCC during phy_init().
> 
> Is this incorrect reset of DBI registers a software issue or some kind
> of hardware erratum that might be fixed someday?  Or maybe it's just a
> characteristic of the hardware and thus not really "incorrect"?
> 
> I do see that qcom_pcie_perst_deassert() in pcie-qcom-ep.c also calls
> dw_pcie_ep_init_registers() in the qcom_pcie_ep_perst_irq_thread()
> path.
> 
> So does pex_ep_event_pex_rst_deassert() (pcie-tegra194.c) in the
> tegra_pcie_ep_pex_rst_irq() path.
> 
> But as far as I can tell, none of the other dwc drivers need this, so
> maybe it's something to do with the glue around the DWC core?

The RCC PHY reset is connected to the Synopsys cold reset logic, which 
explains why the registers need to be restored. This point has been 
addressed in the reference manual.

I am not sure if the tegra194 and qcom drivers restore the registers for 
the same reason. But refactoring this into the DWC core would require a 
runtime condition to test for persistent registers or support for warm 
reset.

Best Regards

Christian


> 
>> +	 */
>> +	ret = dw_pcie_ep_init_registers(ep);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to complete initialization: %d\n", ret);
>> +		goto err_disable_resources;
>> +	}


