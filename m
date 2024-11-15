Return-Path: <linux-pci+bounces-16834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484999CDA79
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B04B24420
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEA18A6BC;
	Fri, 15 Nov 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="baiy+g4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490DC1E522;
	Fri, 15 Nov 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659427; cv=none; b=Rr6iaX58wkpjq2TzAQvlqXFCL+JjKBNJ2yddo/P5wAGEBhd/iWCmqnjPQlXm74KFyYVEALIl8Gw5V/pemL2Pn2XuyPdw0UAqsfVSwBzRIVkUnGpXQi0sEkq0rAWiZmaPcSTsR1Nf6td6geNuTAk7Q+a6l43nsygLFYUc6IJktVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659427; c=relaxed/simple;
	bh=AwNaowL+z3r5T3Dhk/DjATV1Gtv4vvKbU0QkuO3KiTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SqtYvrSDoTtqQXFPh5b5TukQXuU67fRJkbEetqUlVWOYd5IFwPMXPr9WpHpzc1VHm1puCxD4vBs4Ws4nCIGoqJHoHPUpu49f8J9S8uRdPCoBAJEnsy/s86RCzCzH3JDAWjewbKc7L/u+nCVuX5VYGW88LlofsX53g4obSfEjk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=baiy+g4p; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF80KYe008356;
	Fri, 15 Nov 2024 09:29:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	hV7BxhQ3eifJYS/TNyu+Lmhdj2uo69md9n/Ratf2lvI=; b=baiy+g4pS4xqJe22
	Z6PA5mWy2Cs7RSvM4GWc/IW5XjATX0WHk5aElMwUw/pwK9CpSSscsnc7jsM9CeyR
	QEq2GV4QxD8TyYOW181ziqZmw5yhaaKydrpjuzIVukdoM1LOLT0M00b6LSK7BYDs
	l0thJ4hekFeNA/SvfdvacMOkRUulYxED4boG5uqMuo4yk7hHl7HXMUpn0cIjjpwI
	+AeXVvV9dd+rpoicCf30pqcuLp99gFd68FH9DmP7HITTjjpB2UuzfThRd+DJ3TGQ
	/7eA1+kCT+AI7u9NVgv5359Vsk7melk4XVMB2WrFp7D29rfd+TjSf/eepa2oNHaZ
	DeVOwg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42whe9ukqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 09:29:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5632340053;
	Fri, 15 Nov 2024 09:28:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31155263566;
	Fri, 15 Nov 2024 09:27:14 +0100 (CET)
Received: from [10.129.178.212] (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 15 Nov
 2024 09:27:13 +0100
Message-ID: <2b52093a-103f-4dd4-bb6d-c04dc9f68e98@foss.st.com>
Date: Fri, 15 Nov 2024 09:27:05 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241112182809.GA1853254@bhelgaas>
Content-Language: en-US
From: Christian Bruel <christian.bruel@foss.st.com>
In-Reply-To: <20241112182809.GA1853254@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01



On 11/12/24 19:28, Bjorn Helgaas wrote:
> On Tue, Nov 12, 2024 at 05:19:21PM +0100, Christian Bruel wrote:
>> Document the bindings for STM32MP25 PCIe Controller configured in
>> root complex mode.
>> Supports 4 legacy interrupts and MSI interrupts from the ARM
>> GICv2m controller.
>>
>> Allow tuning to change payload (default 128B) thanks to the
>> st,max-payload-size entry.
>> Can also limit the Maximum Read Request Size on downstream devices to the
>> minimum possible value between 128B and 256B.
>>
>> STM32 PCIE may be in a power domain which is the case for the STM32MP25
>> based boards.
>> Supports wake# from wake-gpios
> 
>> +  st,limit-mrrs:
>> +    description: If present limit downstream MRRS to 256B
>> +    type: boolean
>> +
>> +  st,max-payload-size:
>> +    description: Maximum Payload size to use
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [128, 256]
>> +    default: 128
> 
> MRRS and MPS are not specific to this device.  Not sure why you need
> them, but if you do need them, I think they should be generic.

Agree. On a second thought, this was to fix an old errata and can be 
dropped now, as well as the associated quirks.

Will re-post as generic if needed later on

thanks,

Christian

