Return-Path: <linux-pci+bounces-33560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB429B1D9CC
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AE63BC863
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EEB81749;
	Thu,  7 Aug 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jcNwdx4n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795712B2DA;
	Thu,  7 Aug 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576280; cv=none; b=pq2nUWA6JMfrs4T0qiC1MqQ0oc1jseAjTpAAVkTckfNst4tl8yJi5oCvRZ6M1O1raF1EYCkafGEHZcaaut6S9+t8MTKUKnnv1rPb+xfcpYosAj+8RrRWIQCgUOKHcE9uVVsRmoyvREdV5nhz2W7fWNTBxeuZNquEOGhwiduwXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576280; c=relaxed/simple;
	bh=f7NEbGJwIqidNvMi1hJ+xhJqRZbVKqypzrXyMG7AQeY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JkPPU3MDFXDJXDjJfEImFGv+KZ2SLmH2hW6pxN3b0IbiGZZNpoejn3hHAA3gjQz7nDyw5/YDrmPjeGyh97pg4qSR3Rr9W3M9AtS8pip/4K3bPiNmnSVHX33NPJo4idTZpKAq6pBk9LC7dDwMi1d5SOwf1OrP1uixd0vQAiYgMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jcNwdx4n; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577DQaY4023128;
	Thu, 7 Aug 2025 16:17:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0rKaft9+XU83BazRufG1bMpf0DcHNm09LrzRYaslGhI=; b=jcNwdx4nFkb1smh5
	h5I16w88LgIWv9EFwVomPh41WuDDm3tU7puXrvrzQiVSR1tvJRm7DCk5cFWC7Eom
	Qwg1OwWGqvZUyjm07/BYReQSQo79lSF1dhIf9oKjstVoB9bWPfvACu2Oc8xw+84f
	Zlhh5p0bqDLXFK4VJlhOPKdkrUwW/7pfYQgC0sTAs4EcR8+RFeBT/dMkUzmzxZM+
	uFyOQ0dhCccbAYgg8w3+HpWrxjhMOq43zPfM/MXN8fF5kXMtitJph28y9NgOhd5d
	G6m1tRUZsRJ5bc4Nm4yfONACvLJTSu0R4A7uIAQ+f/XpTOuDer4E7FPtzm2ZfWkL
	L9UTIw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48bpx083p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 16:17:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0A04840046;
	Thu,  7 Aug 2025 16:16:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DA2371582F;
	Thu,  7 Aug 2025 16:15:42 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 16:15:41 +0200
Message-ID: <cb76e0da-f4c9-4aaf-8e0b-4666738d238e@foss.st.com>
Date: Thu, 7 Aug 2025 16:15:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/2] Add pinctrl_pm_select_init_state helper
 function
From: Christian Bruel <christian.bruel@foss.st.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <20250723210753.GA2911683@bhelgaas>
 <99737d4f-488d-4208-91aa-83ce52957147@foss.st.com>
Content-Language: en-US
In-Reply-To: <99737d4f-488d-4208-91aa-83ce52957147@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01

Gentle ping,

Maybe the best for Linus is to apply only 1/2 on his pinctrl tree.

I'll rebase 2/2 stm32 PCIe part after the merge to mainline and respin 
for the PCI tree

Best Regards

Christian

On 7/24/25 15:36, Christian Bruel wrote:
> 
> 
> On 7/23/25 23:07, Bjorn Helgaas wrote:
>> On Wed, Jul 23, 2025 at 01:32:52PM +0200, Linus Walleij wrote:
>>> On Thu, Jul 17, 2025 at 8:33 AM Christian Bruel
>>> <christian.bruel@foss.st.com> wrote:
>>>
>>>> We have the helper functions pinctrl_pm_select_default_state and
>>>> pinctrl_pm_select_sleep_state.
>>>> This patch adds the missing pinctrl_pm_select_init_state function.
>>>>
>>>> The STM32MP2 needs to set the pinctrl to an initial state during
>>>> pm_resume, just like in probe. To achieve this, the function
>>>> pinctrl_pm_select_init_state is added.
>>>>
>>>> This allows a driver to balance pinctrl_pm_select_sleep_state()
>>>> with pinctrl_pm_select_default_state() and
>>>> pinctrl_pm_select_init_state() in pm_runtime_suspend and 
>>>> pm_runtime_resume.
>>>>
>>>> Christian Bruel (2):
>>>>    pinctrl: Add pinctrl_pm_select_init_state helper function
>>>>    PCI: stm32: use pinctrl_pm_select_init_state() in
>>>>      stm32_pcie_resume_noirq()
>>>
>>> If Bjorn Helgaas is OK with it I can apply this to the pinctrl tree.
>>>
>>> Otherwise I can also just apply patch 1/2, but that doesn't solve
>>> any problem.
>>
>> The stm32 driver has been posted and is on this branch of the PCI
>> tree:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/? 
>> h=controller/dwc-stm32&id=5a972a01e24b
>>
>> but it's not in mainline (or even in pci/next) yet, so you would only
>> be able to apply patch 2/2 if you took the whole driver, which is
>> probably more than you would want to do.
>>
>> I haven't put it in pci/next yet because it doesn't build when
>> CONFIG_PINCTRL is not defined:
>>
>>    https://lore.kernel.org/r/20250716192418.GA2550861@bhelgaas
>>
>> I don't know enough about pinctrl to know why stm32 needs this when
>> nobody else seems to.  I doubt it's really unique, so maybe it's just
>> not doing the right thing here.
> 
> The STM32MP2 is unique because the core clock is gated on CLKREQ#. 
> Consequently, it is not possible to access the core registers from DBI 
> when no card is attached, causing the board to freeze. I don't know 
> another platform with this limitation
> 
> To fix this, we use a GPIO to de-assert CLKREQ# during probe and restore 
> the pin to its default AF mode afterward. This works perfectly for 
> probe, but we lack functionality for PM resume unless we explicitly 
> select the state with pinctrl_pm_select_XXX_state().
> 
> For reference, the init_state functionality was introduced in
> https://lkml.org/lkml/2015/10/21/1
> 
> If we prefer not to extend the pinctrl API in patch 1/2, I can fix the 
> case in patch 2/2 only with something like:
> 
> in stm32_pcie_probe()
>       pinctrl = devm_pinctrl_get(dev);
> 
>       if(pinctrl!= -ENODEV) // PINCTRL is defined
>            pinctrl_init = pinctrl_lookup_state(stm32_pcie>pinctrl, 
> PINCTRL_STATE_IN
> 
> in stm32_pcie_resume_noirq()
>     if (pinctrl) {
>            ret = pinctrl_select_state(stm32_pcie->pinctrl, stm32_pcie- 
>  >pinctrl_init);
> 
> What do you advise ?
> 
> thank you
> 
> Christian
> 
> 
> 
>>
>> Bjorn
> 


