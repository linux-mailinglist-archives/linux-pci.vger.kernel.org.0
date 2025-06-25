Return-Path: <linux-pci+bounces-30604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1013AE7EFF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80196188F1E5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F127F170;
	Wed, 25 Jun 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tzkHB94w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0811EE7B7;
	Wed, 25 Jun 2025 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846898; cv=none; b=Q2E4ino0fjE5yuD6t6KCGrk2xUQo4cOkNSiQYGmEwfpgVIRk8XnYFPHb8kHSoqq49ozwb0uzSorGSlkvC+POqeKc/hYnMRcVyUuK9sHZw637X0z9gVOTQxVDXHAsUqGL2iXHaX3PO9iZFUFsEsZMwT36T8DPs8qWvZDL4RE5Qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846898; c=relaxed/simple;
	bh=MOhEYC1cKOgyHi8EznYqnXZzLpwz8XMCahZZ5D2On4U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=VIniTiDys0sQJA9zxabaqJHHx3iuD6UKXc5NM0vRaf5LveP5E16o59Bl7hnr+9VnStC1w8nkdHiYXXpD7qKn3i11CeJ6ujBjZQzOf/ud9uf9SdYy/mJqT6ZHU41mg7Y61+JAXfou1lg0Wwcu92p2koOR9zaIhDzUCXKn7EGQwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tzkHB94w; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P62V3v021991;
	Wed, 25 Jun 2025 12:21:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	C4yzJ1noedDWVQEaOZSM94W1Wxwn8zZ9kpiO6XR9LxU=; b=tzkHB94wRKqAwx4c
	0lvTUd/MYGBUx70suX7tiBjmz0UtKwRUjtVPIihur62TbMpXnmXpdcWmAcdp5xpW
	pJhiDVqchowhT7pV99S6j6SU6rDAOWYXhkkVwFxxMyC4wjjDYTsf0eHmDBFfiURV
	rU9kKk2Ce52GLRFVg3ZaOeyIaes040BDjPmJk81aWNwBTwCNso39GT/ejla9qTYW
	PqSVpiw4Ed0mzE2VIisvjpYOTdwxw3RJNg0AR5LWINIBu6zV9J+fp3aNyf5Y4M+D
	HRRQsYRdb9v8xpc3neYRQgJVZHr4su1XCjrpysVrcRguZdv2L4yM2cGfSe5ewNjS
	3LpBlw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dkmjryqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:21:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 04F1A40046;
	Wed, 25 Jun 2025 12:19:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 12132AE5D21;
	Wed, 25 Jun 2025 12:18:21 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 12:18:20 +0200
Message-ID: <01dbb6cf-3ab4-4922-b301-661464c9e56d@foss.st.com>
Date: Wed, 25 Jun 2025 12:18:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: Re: (subset) [PATCH v12 0/9] Add STM32MP25 PCIe drivers
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <johan+linaro@kernel.org>,
        <cassel@kernel.org>, <shradha.t@samsung.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <175068078778.15794.15418191733712827693.b4-ty@kernel.org>
 <20250624222206.GA1537968@bhelgaas>
 <3bmw76gzqjq2nmjvj7tb6gi5x233zzfrhv44uyjopl2lxyzbkh@zg5skeu62nbh>
Content-Language: en-US
In-Reply-To: <3bmw76gzqjq2nmjvj7tb6gi5x233zzfrhv44uyjopl2lxyzbkh@zg5skeu62nbh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01



On 6/25/25 06:00, Manivannan Sadhasivam wrote:
> On Tue, Jun 24, 2025 at 05:22:06PM -0500, Bjorn Helgaas wrote:
>> On Mon, Jun 23, 2025 at 06:13:07AM -0600, Manivannan Sadhasivam wrote:
>>> On Tue, 10 Jun 2025 11:07:05 +0200, Christian Bruel wrote:
>>>> Changes in v12;
>>>>     Fix warning reported by kernel test robot <lkp@intel.com>
>>>>
>>>> Changes in v11;
>>>>     Address comments from Manivanna:
>>>>     - RC driver: Do not call pm_runtime_get_noresume in probe
>>>>                  More uses of dev_err_probe
>>>>     - EP driver: Use level triggered PERST# irq
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/9] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
>>>        commit: 41d5cfbdda7a61c5d646a54035b697205cff1cf0
>>> [2/9] PCI: stm32: Add PCIe host support for STM32MP25
>>>        commit: f6111bc2d8fe6ffc741661126a2174523124dc11
>>> [3/9] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
>>>        commit: 203cfc4a23506ffb9c48d1300348c290dbf9368e
>>> [4/9] PCI: stm32: Add PCIe Endpoint support for STM32MP25
>>>        commit: 8869fb36a107a9ff18dab8c224de6afff1e81dec
>>> [5/9] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
>>>        commit: 003902ed7778d62083120253cd282a9112674986
>>
>> This doesn't build for me with the attached config:
>>
>>    $ make drivers/pci/controller/dwc/pcie-stm32.o
>>      CALL    scripts/checksyscalls.sh
>>      DESCEND objtool
>>      INSTALL libsubcmd_headers
>>      CC      drivers/pci/controller/dwc/pcie-stm32.o
>>    drivers/pci/controller/dwc/pcie-stm32.c: In function ‘stm32_pcie_suspend_noirq’:
>>    drivers/pci/controller/dwc/pcie-stm32.c:83:16: error: implicit declaration of function ‘pinctrl_pm_select_sleep_state’ [-Werror=implicit-function-declaration]
>>       83 |         return pinctrl_pm_select_sleep_state(dev);
>> 	|                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    drivers/pci/controller/dwc/pcie-stm32.c: In function ‘stm32_pcie_resume_noirq’:
>>    drivers/pci/controller/dwc/pcie-stm32.c:96:24: error: ‘structdevice’ has no member named ‘pins’
>>       96 |         if (!IS_ERR(dev->pins->init_state))
>> 	|                        ^~
>>    drivers/pci/controller/dwc/pcie-stm32.c:97:23: error: implicit declaration of function ‘pinctrl_select_state’ [-Werror=implicit-function-declaration]
>>       97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
>> 	|                       ^~~~~~~~~~~~~~~~~~~~
>>    drivers/pci/controller/dwc/pcie-stm32.c:97:47: error: ‘structdevice’ has no member named ‘pins’
>>       97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
>> 	|                                               ^~
>>    drivers/pci/controller/dwc/pcie-stm32.c:97:61: error: ‘structdevice’ has no member named ‘pins’
>>       97 |                 ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
>> 	|                                                             ^~
>>    drivers/pci/controller/dwc/pcie-stm32.c:99:23: error: implicit declaration of function ‘pinctrl_pm_select_default_state’ [-Werror=implicit-function-declaration]
>>       99 |                 ret = pinctrl_pm_select_default_state(dev);
>> 	|                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
> 
> Hmm... I see two issues here. First is, wrong pinctrl header used. The correct
> one is:
> 
> #include <linux/pinctrl/consumer.h>

ah yes, the missing pinctrl_pm_select_default_state() should indeed be 
fixed by using the correct header.

> 
> Second issue is the driver accessing "struct device::pins" directly. The "pins"
> member won't be available if CONFIG_PINCTRL is not set (which is what your
> .config has). So either the member should not be accessed directly or the
> driver has to depend on CONFIG_PINCTRL. The latter one is not acceptable.It
> also looks weird that only this driver is accessing the "pins" member directly
> apart from the pinctrl core. So I think this part needs a revisit.
> 
> Christian?
The pinctrl "init" and "default" configurations are managed effectively 
by the probing code. The same approach is required in 
stm32_pcie_resume_noirq().

In this case, would introducing a new helper function, 
pinctrl_pm_select_init_state(), be preferable, even if we are the only 
consumer?

Thank you


> 
> - Mani
> 

