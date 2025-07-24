Return-Path: <linux-pci+bounces-32884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A0B10BB5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 15:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F99AE847A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DD2D8767;
	Thu, 24 Jul 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8DuW1mVW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C913BC0C;
	Thu, 24 Jul 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364355; cv=none; b=trk88nXrqw0haUHofEFcHgOkqLevii2b3N64T6hbLOjz0B8ey/Y6116mgp1YjTBPmeW/He/v2y2cO/GcRLj8R6Jw1+Z9oa2GIM5uQqtHTTQbKZ1F2zQMQv8b0mBfEZRRtk3Su/9uetYMX4BUgJXx4nR/Xw5mTkvUZibplFLY0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364355; c=relaxed/simple;
	bh=GGKPx34LBUi+sDBe9RnkRVW9eRR9QWY4VywRj+xNMhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mSlrYnzcMWcPbbzuKmMDpI8pmyL8coS9BIM1tWG5CWHZKIJ8Al1XEU8OxAK9tFwM4kp6N6/RTynvLQH2BZUBNcmAAdSqYQMAbgCLelz6W3M49LfNMUcPqd4Qp3Jyms/AwOJ9YK7Kdpf60ie87xRp7wu7+z3GEgMq8BpbXOaJwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8DuW1mVW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODAgol018828;
	Thu, 24 Jul 2025 15:38:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	w9y6lMVKoGSGbAQ4r7YRTQAIypLEALnPa938lwZnu4s=; b=8DuW1mVWb5Zmz+q0
	7RKe020XQCaScSNVrCjpPnmByr2ryfDEsJqHwQPObJeuAtdyS46qENjf789qB2Gn
	Y9jkz0gnExfyBxnDdCXcKF/U1bvmXiPSL0WnENoFzkBrzJOHYylmsIvuGCerLywl
	ZaA9oZ7lKwFoF195X342XP1lYemLrGWn/qjVkHL6zChh+CpYuigHX7/+E62GiSba
	SVAHo4H6Hei4POCBjTIbbBtR678I3fMIdBg41DlglPcRw9/urX+wij9vSihPDcRp
	TxPHyIN2JW2TvS5/OuWkzhrAFqWa9uAwPyPD4tuvxnn6RfeIub6Uo+oLKBm8zZIJ
	H13+MA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800g91e0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 15:38:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4750C4005D;
	Thu, 24 Jul 2025 15:37:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 594A6763978;
	Thu, 24 Jul 2025 15:36:56 +0200 (CEST)
Received: from [10.130.77.120] (10.130.77.120) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 15:36:55 +0200
Message-ID: <99737d4f-488d-4208-91aa-83ce52957147@foss.st.com>
Date: Thu, 24 Jul 2025 15:36:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 0/2] Add pinctrl_pm_select_init_state helper
 function
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
From: Christian Bruel <christian.bruel@foss.st.com>
Content-Language: en-US
In-Reply-To: <20250723210753.GA2911683@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01



On 7/23/25 23:07, Bjorn Helgaas wrote:
> On Wed, Jul 23, 2025 at 01:32:52PM +0200, Linus Walleij wrote:
>> On Thu, Jul 17, 2025 at 8:33 AM Christian Bruel
>> <christian.bruel@foss.st.com> wrote:
>>
>>> We have the helper functions pinctrl_pm_select_default_state and
>>> pinctrl_pm_select_sleep_state.
>>> This patch adds the missing pinctrl_pm_select_init_state function.
>>>
>>> The STM32MP2 needs to set the pinctrl to an initial state during
>>> pm_resume, just like in probe. To achieve this, the function
>>> pinctrl_pm_select_init_state is added.
>>>
>>> This allows a driver to balance pinctrl_pm_select_sleep_state()
>>> with pinctrl_pm_select_default_state() and
>>> pinctrl_pm_select_init_state() in pm_runtime_suspend and pm_runtime_resume.
>>>
>>> Christian Bruel (2):
>>>    pinctrl: Add pinctrl_pm_select_init_state helper function
>>>    PCI: stm32: use pinctrl_pm_select_init_state() in
>>>      stm32_pcie_resume_noirq()
>>
>> If Bjorn Helgaas is OK with it I can apply this to the pinctrl tree.
>>
>> Otherwise I can also just apply patch 1/2, but that doesn't solve
>> any problem.
> 
> The stm32 driver has been posted and is on this branch of the PCI
> tree:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc-stm32&id=5a972a01e24b
> 
> but it's not in mainline (or even in pci/next) yet, so you would only
> be able to apply patch 2/2 if you took the whole driver, which is
> probably more than you would want to do.
> 
> I haven't put it in pci/next yet because it doesn't build when
> CONFIG_PINCTRL is not defined:
> 
>    https://lore.kernel.org/r/20250716192418.GA2550861@bhelgaas
> 
> I don't know enough about pinctrl to know why stm32 needs this when
> nobody else seems to.  I doubt it's really unique, so maybe it's just
> not doing the right thing here.

The STM32MP2 is unique because the core clock is gated on CLKREQ#. 
Consequently, it is not possible to access the core registers from DBI 
when no card is attached, causing the board to freeze. I don't know 
another platform with this limitation

To fix this, we use a GPIO to de-assert CLKREQ# during probe and restore 
the pin to its default AF mode afterward. This works perfectly for 
probe, but we lack functionality for PM resume unless we explicitly 
select the state with pinctrl_pm_select_XXX_state().

For reference, the init_state functionality was introduced in
https://lkml.org/lkml/2015/10/21/1

If we prefer not to extend the pinctrl API in patch 1/2, I can fix the 
case in patch 2/2 only with something like:

in stm32_pcie_probe()
      pinctrl = devm_pinctrl_get(dev);

      if(pinctrl!= -ENODEV) // PINCTRL is defined
           pinctrl_init = pinctrl_lookup_state(stm32_pcie>pinctrl, 
PINCTRL_STATE_IN

in stm32_pcie_resume_noirq()
    if (pinctrl) {
           ret = pinctrl_select_state(stm32_pcie->pinctrl, 
stm32_pcie->pinctrl_init);

What do you advise ?

thank you

Christian



> 
> Bjorn


