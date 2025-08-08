Return-Path: <linux-pci+bounces-33636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B631B1EB11
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A515F16DE0F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA8281538;
	Fri,  8 Aug 2025 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WbnCVx14"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC827E7FD;
	Fri,  8 Aug 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665154; cv=none; b=oXlhsRdrdOpOvx3EuJoeejIxvh4R+CEZ2dL87OY+utaq9+0zOCGYBmqdsrJPhZmt70GKR2a5JY7ObSpJ8s155ysV5wE6e3kooEwASGBOcN3B36NXRG7bHG5F+qLI4tB2YBnWyCWbNV6iQ7soSKAhTz70ZN1Cs69ScCMtBGltGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665154; c=relaxed/simple;
	bh=JS5l0JTvxjfWhfOl7mWhGheL2sKK5NX/r1b9XGlPSYQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=S3rkz4XzuXljVCnb00OOF+VBlLuKPg1n7lLPtekzISZefGbDh/2qPnhZQyUwxOTJrwS2FkgRWJQTUDpyUcUwYtMkFaimqxLIA32+ucClQXOpN1DEznPXI1PBxe9h80NZY1HMZCJgj3oaaZYQQv6d9DHMKjq5udBOm+1HGHAQu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WbnCVx14; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DVG8N014777;
	Fri, 8 Aug 2025 16:58:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NKA5zhqFYGJHApG3LHZ1wsad9XAvKI/FIK3QKmiMCpI=; b=WbnCVx14jjeuJHN6
	GJIn+Fy7uBInALd0yOmv8xY1N92s1MboPmYDOVGOfKlyJ1dR9TdIdZfZZ4z7u230
	hOZgX2ZobRFpBIOy2vaW04NBtp7pze1/toMUiVE1RtWulxbwt1s/1hMJbrSvEsKM
	mv8O0GZCz25MOCQgGka/uT3VEShhKKugQsfHOZnGaYcy6pyoWjDb679PqL8ypGYf
	RLUCtOMzNsz/XeURNPf+0IqflqC3ZDk4Ifwp9S9Vi0zr9ltkc3dOgbgt3l/YYUuW
	ArazUWAES+HMyrjVVRVsnQhgUvAFXTm2W7oQM/aPTere3xJqK2sqyKGuQm7MwPo8
	C4I3tQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48cq00pdk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 16:58:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A8D2340046;
	Fri,  8 Aug 2025 16:57:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7F79727648;
	Fri,  8 Aug 2025 16:55:57 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 16:55:54 +0200
Message-ID: <e7cd764d-bc6d-4e39-aa03-0eee8e30d3e5@foss.st.com>
Date: Fri, 8 Aug 2025 16:55:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: [PATCH v12 2/9] PCI: stm32: Add PCIe host support for STM32MP25
To: Bjorn Helgaas <helgaas@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <p.zabel@pengutronix.de>,
        <johan+linaro@kernel.org>, <cassel@kernel.org>,
        <shradha.t@samsung.com>, <thippeswamy.havalige@amd.com>,
        <quic_schintav@quicinc.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250807180951.GA56737@bhelgaas>
Content-Language: en-US
In-Reply-To: <20250807180951.GA56737@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01



On 8/7/25 20:09, Bjorn Helgaas wrote:
> [+to Linus for pinctrl usage question below]
> 
> On Tue, Jun 10, 2025 at 11:07:07AM +0200, Christian Bruel wrote:
>> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
>> controller based on the DesignWare PCIe core.
>>

>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
> 
> Isn't there some setup required before we can use
> pinctrl_select_state(), pinctrl_pm_select_sleep_state(),
> pinctrl_pm_select_default_state(), etc?
> 
> I expected something like devm_pinctrl_get() in the .probe() path, but
> I don't see anything.  I don't know how pinctrl works, but I don't see
> how dev->pins gets set up.

Linus knows better, but the dev->pins states are attached to the dev 
struct before probe by the pinctrl driver

/**
  * pinctrl_bind_pins() - called by the device core before probe
  * @dev: the device that is just about to probe
  */
int pinctrl_bind_pins(struct device *dev)

Christian

