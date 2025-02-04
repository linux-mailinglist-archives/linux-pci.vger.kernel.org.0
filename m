Return-Path: <linux-pci+bounces-20696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE3A27000
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 12:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D654B162563
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1213E20C014;
	Tue,  4 Feb 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t0CDFcQN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE820C007;
	Tue,  4 Feb 2025 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738667487; cv=none; b=aaEEI/znMvTyC6xDiko1AOQrBXYLaTw1rJfL4W/39qwEWX5GD4x4ZgNLGAY2OCDgo8OAcakatxka1dYH0YhxLgvc2rQGhvQo6FyAvfGC8lFC+WAf1rEZdWp8QpwhQ4fish4il91rOC/fSUjUZ9unh3kPyao8kzQ336oyf30dzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738667487; c=relaxed/simple;
	bh=6BdCL7s1iOcMcXo6FMo76vx8Hg+CVwpDBhiRLj2EHew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c7nmlys2UaaZARgHiB22l1olHocTETZqpLAnDOqtHrrCHN9MU1oViPkpx9IBVGsHwJWvxrQjnA7G0PrQi3Xu9bM5AbMXd3UoD/HUNwBfTvmjv1qtjCgOI/pnTYy8GtAA+wb2st9+8fMXBlQkGRK4w8ZarYHOp/0uewT+YR+gpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t0CDFcQN; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514B5lTL024169;
	Tue, 4 Feb 2025 12:10:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0WdoHNg8xzFLJxEL4fv90uErYqTslBGCXG3a5iCB0zM=; b=t0CDFcQNm4sq4RLe
	P6QcQUvjxBtR+zTQdExTiv7FuDc7RvLNt/+W8EGtAt1qFm5873EFgc8OZl89rBvL
	J68jpJaul4J30+XlXHImIJu7M2yK/H2ZBBLgFWn5DrNxNH7RQZxMUwmjoXiCZ2D0
	qVLqXuY1pVFAmMslVEev4Pqt9iiOxZctFHgDd64Gp6hozOeCzX+HvIWfTph9s2Bo
	AQF4NZQ04/f2KCivFW9nq85GczPXDOrRDVFp9nHypemcXZU+r3eyjPIKMTOpopcl
	zDMG5kW0+v6/DRKcFINk4EchsCX7sDQk1VSLyWCRV3Q0upcQKPPTvOndDccL+pYK
	DhQXaw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44jwu3v5j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 12:10:50 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B0B314005A;
	Tue,  4 Feb 2025 12:09:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B78D92945D8;
	Tue,  4 Feb 2025 12:07:08 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 12:07:07 +0100
Message-ID: <3fa73c47-12af-46c3-8573-7d6800202e17@foss.st.com>
Date: Tue, 4 Feb 2025 12:07:06 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: PCI: Add STM32MP25 PCIe Root
 Complex bindings
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <jingoohan1@gmail.com>, <p.zabel@pengutronix.de>,
        <johan+linaro@kernel.org>, <quic_schintav@quicinc.com>,
        <cassel@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
 <20250128120745.334377-2-christian.bruel@foss.st.com>
 <20250202122527.ggy5ccz7o4umyhif@thinkpad>
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250202122527.ggy5ccz7o4umyhif@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01



On 2/2/25 13:25, Manivannan Sadhasivam wrote:
> On Tue, Jan 28, 2025 at 01:07:36PM +0100, Christian Bruel wrote:
> 
> [...]
> 
>> +    pcie@48400000 {
>> +        compatible = "st,stm32mp25-pcie-rc";
>> +        device_type = "pci";
>> +        reg = <0x48400000 0x400000>,
>> +              <0x10000000 0x10000>;
>> +        reg-names = "dbi", "config";
>> +        #interrupt-cells = <1>;
>> +        interrupt-map-mask = <0 0 0 7>;
>> +        interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
>> +                        <0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +        ranges = <0x01000000 0x0 0x00000000 0x10010000 0x0 0x10000>,
>> +                 <0x02000000 0x0 0x10020000 0x10020000 0x0 0x7fe0000>,
>> +                 <0x42000000 0x0 0x18000000 0x18000000 0x0 0x8000000>;
>> +        dma-ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x80000000>;
>> +        clocks = <&rcc CK_BUS_PCIE>;
>> +        resets = <&rcc PCIE_R>;
>> +        msi-parent = <&v2m0>;
>> +        wakeup-source;
> 
> Does this property really need to be present? If the WAKE# gpio is supported,
> isn't it implied that the RC is a wakeup source?
> 

the wakeup-source property is useless indeed with the wake_gpio, will 
remove,

thanks.

Christian

> - Mani
> 

