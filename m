Return-Path: <linux-pci+bounces-1203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08638197F9
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 06:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003691C2216D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D1AC2D0;
	Wed, 20 Dec 2023 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i42YU7w2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECF168A4
	for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 05:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D02C433C7;
	Wed, 20 Dec 2023 05:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703049297;
	bh=zQMhpzN2tqxtu2wVd66yplo5/YwiQL3YyX0RTK9LF5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i42YU7w2sv801CEN3c2PV2eU9+vjcL43wSIj4oKp0XcKDIPHvc1197rpSun5XBKF1
	 hAlsztDrUjpE9bPMJ9f27A+k7a9BI0ZqeBSz04hN1/Krtj2ejFJSZENlTi0XpNz4Pp
	 vPLsjDtZlPHJ8jTgB8Nhq2Kc7mq/nPGhofH4WtomtrtkweTh+VWmTuBG8HwFEiqOdr
	 kiOqSElxKeE9fjHGMZ12wLao2Vtf6gBONM1W7Nok7js+1q7VWe8cUg3Vz+k9+kQpXk
	 8Lvmsp1YE/MWv1Has7j+YplHVIwKfh7wNz4GKwHhpu+KcnI8bo6cdMzNNUODm3Sl6o
	 YmGmOrMdwXspg==
Message-ID: <c33b8830-5237-438f-9aae-6905e9e538b8@kernel.org>
Date: Wed, 20 Dec 2023 14:14:53 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar() update
 inbound map address
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Frank Li <Frank.li@nxp.com>, Vidya Sagar <vidyas@nvidia.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "kishon@ti.com" <kishon@ti.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "kw@linux.com" <kw@linux.com>, "jingoohan1@gmail.com"
 <jingoohan1@gmail.com>,
 "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jdmason@kudzu.us" <jdmason@kudzu.us>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "allenbh@gmail.com" <allenbh@gmail.com>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com> <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810> <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
 <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810> <ZX13xhBm3RmshqgD@x1-carbon>
 <20231219175900.GA24515@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231219175900.GA24515@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 02:59, Manivannan Sadhasivam wrote:
>>>>> from dw_pcie_ep_set_bar(), also needs to be dropped, so that the iATU
>>>>> settings will be re-written for platforms with core_init_notifiers.
>>>>>
>>>>> Right now, for a platform with a core_init_notifier, if you run
>>>>> pci_endpoint_test + reboot the RC (so that PERST is asserted + deasserted),
>>>>> and then run pci_endpoint_test again, then I'm quite sure that
>>>>> pci_endpoint_test will not pass the second time (because iATU settings
>>>>> were not rewritten after reset).
>>>>>
>>>>> It would be nice if Mani or Vidya could confirm this.
>>
>> So problem 2 out of 2 introduced by the patch in $subject is that
>> DWC drivers with a .core_init_notifier, will perform a reset_control_assert()
>> to reset the core (which will reset both sticky and non-sticky registers),
>> which means that the early return in dw_pcie_ep_set_bar():
>> https://github.com/torvalds/linux/blob/v6.7-rc5/drivers/pci/controller/dwc/pcie-designware-ep.c#L268-L269
>>
>> while returning after the iATU settings have been written,
>> it will return before:
>>
>> 	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
>> 	dw_pcie_writel_dbi(pci, reg, flags);
>>
>> Which means that, for drivers with a .core_init_notifier, BARx_REG and
>> BARx_MASK registers will not be written. This means that they will have
>> reset values for these registers, which means that e.g. the BAR_SIZE
>> (which is defined by BARx_MASK) might be incorrect for these platforms
>> because this function returns early.
>>
>> I will not send a fix for this problem, I will leave that to you, or Mani,
>> or Vidya, and hope that people are happy that I simply reported this issue.
>>
> 
> The fix for this issue shouldn't be in the DWC driver but rather in the EPF
> drivers. Because, EPF drivers are the ones calling pci_epc_set_bar() during
> bind(). So they have to properly cleanup the resources once the perst assertion
> happens. This issue also applies to other resources such as DMA channels.
> 
> The problem here is, there is a disconnect between DWC (EPC) and EPF drivers.
> When the perst assertion happens, the event is not passed to EPF drivers
> resulting in the EPF drivers having no knowledge that they need to give up the
> resources.
> 
> We need to fix this in a sane way and I'm looking into it.
> 
> But I really appreciate your finding here and in other thread where we discussed
> similar issue.

We have core_init and link_up notifiers for EPF drivers. Adding link_down and
core_exit notifiers would make a lot of sense :) A core_reset notifier could
also be a solution.

Adding that would also help EPF drivers to handle links going down temporarily
(which can happen). Right now, an EPF driver can only deal with such event by
tracking if it gets multiple link_up events.


-- 
Damien Le Moal
Western Digital Research


