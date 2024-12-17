Return-Path: <linux-pci+bounces-18658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A439F5186
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 18:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9394C7A4BA4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FB1494A9;
	Tue, 17 Dec 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAepieqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB261F4735
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454989; cv=none; b=UST5qQ5HStn+5dkRl6DN0ctkuESYir7tFNb//XNVaZKtJsR+1iJkYMVO+OfO7LnUhSbXF9dXheXDEQQVxr+46z4dz3x6nxPCXeJ/p7N92agVFBjLZPYHuLq75YSUg8Qt9QeiHMvUcBviEjz2GJZQhvXbMaqW3onfngS6cQSe+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454989; c=relaxed/simple;
	bh=sSpqoEK8CNyCR1Nyjvil2/UizEqb+1z512pRABGm/q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIqc6ow8rvNQBtE2NRJRARNQz+EBbUC/9PrSAZCfZ35dvjqwAn9UOXi+F63R94r0zu+QpK2Is41IWN6j9gT3RXnieBo3i9CAWeXhC6/tOj/qBHg5ugDdOCWZzE6IrOkZG+a8+0EabnP22mrEqi6E3TtcY+RHwM9Mt+eJKgQbTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAepieqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D745C4CED3;
	Tue, 17 Dec 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454989;
	bh=sSpqoEK8CNyCR1Nyjvil2/UizEqb+1z512pRABGm/q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KAepieqIUtb0+e9bJ7xjMnIpJq53p6XBWEOMKHzNGfGwZmzX80VicOjFt7JpjFEJ+
	 aqVcFemBbj+LvlY5s3J3VYmMF4yEpZigXlnIWCQ8P57qQ8xl2OHIp2bLWujjzgphz2
	 lgdF/EjPYNukLrGfSKO9mXSdhXcqnFsMH7NlJPE6nQ+MTI1ZeW4VyNLWZXsfdHy4vx
	 d/VgWpzhSy11vjVhlSjxEuQmccYuXUrxlk87rvxVcb5YJ9dgH92ldu63Z1jNLbTfF9
	 IJM8lelLGWkOkLwGZeRGNweL4OyiRL/cpwwgPyVwkXyqG/yzmAX3ARxnTStHKWHu8l
	 MTun5qIMz07ng==
Message-ID: <cab48574-503b-48dd-9fe4-71e5c4c86d4e@kernel.org>
Date: Tue, 17 Dec 2024 09:03:08 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <20241217085355.y6bqqisqbr5kbxkl@thinkpad>
 <4015e54a-54a5-4ac7-ae1c-3d2fb935b20f@kernel.org>
 <20241217164149.vuqwtthlykn7bobj@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20241217164149.vuqwtthlykn7bobj@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/12/17 8:41, Manivannan Sadhasivam wrote:
>>>> +	/* Create the target controller. */
>>>> +	ret = nvmet_pciep_create_ctrl(nvme_epf, max_nr_queues);
>>>> +	if (ret) {
>>>> +		dev_err(&epf->dev,
>>>> +			"Create NVMe PCI target controller failed\n");
>>>
>>> Failed to create NVMe PCI target controller
>>
>> How is that better ?
>>
> 
> It is common for the error messages to start with 'Failed to...'. Also 'Create
> NVMe PCI target controller failed' doesn't sound correct to me. But I am not a
> native english speaker, so my views could be wrong.

I do not think this is true for all subsystems. But sure, I can change the message.

>>> Why these are coming from somewhere else and not configured within the EPF
>>> driver?
>>
>> They are set through the nvme target configfs. So there is no need to have these
>> again setup through the epf configfs. We just grab the values set for the NVME
>> target subsystem config.
>>
> 
> But in documentation you were configuring the vendor_id twice:
> 
> 	# echo "0x1b96" > nvmepf.0.nqn/attr_vendor_id
> 	...
>         # echo 0x1b96 > nvmepf.0/vendorid
> 
> And that's what confused me. You need to get rid of the second command and add a
> note that the vendor_id used in target configfs will be reused.

vendor_id != subsys_vendor_id :) These are 2 different fields. subsys_vendor_id
is reported by the identify controller command and is also present in the PCI
config space. vendor_id is not reported by the identify controller command and
present only in the PCI config space.

For the config example, I simply used the same values for both fields, but they
can be different. NVMe PCIe specs are a bit of a mess around these IDs...

>>>> +static int nvmet_pciep_epf_link_up(struct pci_epf *epf)
>>>> +{
>>>> +	struct nvmet_pciep_epf *nvme_epf = epf_get_drvdata(epf);
>>>> +	struct nvmet_pciep_ctrl *ctrl = &nvme_epf->ctrl;
>>>> +
>>>> +	dev_info(nvme_epf->ctrl.dev, "PCI link up\n");
>>>
>>> These prints are supposed to come from the controller drivers. So no need to
>>> have them here also.
>>
>> Nope, the controller driver does not print anything. At least the DWC driver
>> does not print anything.
>>
> 
> Which DWC driver? pcie-dw-rockchip? But other drivers like pcie-qcom-ep have
> these prints already. And this EPF driver is not tied to a single controller
> driver. As said earlier, these prints are supposed to be added to the controller
> drivers.

The DWC driver for the rk2588 (drivers/pci/controllers/dwc/*) is missing this
message.


-- 
Damien Le Moal
Western Digital Research

