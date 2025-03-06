Return-Path: <linux-pci+bounces-23068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482FA55212
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 18:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC0188C909
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105E25BAB5;
	Thu,  6 Mar 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="d6dnVDEZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F8274264;
	Thu,  6 Mar 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280209; cv=none; b=R+zsl3kUpoO+67fA5Mp4Tk0V4F9QJQpNXXKUz6bUVLlMq0fHwNuVaU3PPQecPCm9jHISuXE5veaIYbrfvBHmy0dt2VXYsldOxEIe691WegcL2XBugt1k4tF/+fo7KPEojwhTTGuMLHhd38KKsA3RxLiK5ELDdAgSD2li/XRqxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280209; c=relaxed/simple;
	bh=Z2ypabXvCGArSPxy33xEOYc3fcdzWS3UPjpoZPRI7dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1bggTM2jOKboYowjnYLneSF/fuxnqv2VhU8C5MdCN6zSafF1Jbmepf+MF+wIFlxV8W+n2ESa+3zxZCeIneIK7b+3Xt8AE2uVKGy9FJuhACMyljXzAnCbXk36Jv+ksq3hFWZLAJJGPl1svmcpof0Ki7hscRPfT8CRpMTvw+wtE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=d6dnVDEZ; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [192.168.126.122] (ip72-219-82-239.oc.oc.cox.net [72.219.82.239])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4Z7wYn1FPGz10Wf;
	Thu,  6 Mar 2025 11:56:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1741280206; bh=Z2ypabXvCGArSPxy33xEOYc3fcdzWS3UPjpoZPRI7dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d6dnVDEZh1crd2fx+MkvXufuOZmwIx2y7eztdYir7mgWyRSr67jDMdiVo5cbkdtl1
	 9GkkNLxLFnWNnQMO2WOD+tnr9XcU5X3W1V5MEqq6G7WfS18Y/ztU1cF6pvjCw+bEHG
	 Vz6PVEcI5yjWx4xZYWhfzrLXvS6tAWtDmXCtIgok=
Message-ID: <8d270603-4604-4c1c-b3a9-f596e2e8af6d@panix.com>
Date: Thu, 6 Mar 2025 08:56:44 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
To: Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Me <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, Jian-Hong Pan <jhp@endlessos.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com> <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com> <Z8YKXC1IXYXctQrZ@wunner.de>
 <20250304082314.GE3713119@black.fi.intel.com> <Z8nRI6xjGl3frMe5@wunner.de>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <Z8nRI6xjGl3frMe5@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Is this a separate commit on top of master, or along with your previous fix?

-Kenny

On 3/6/25 08:45, Lukas Wunner wrote:
> On Tue, Mar 04, 2025 at 10:23:14AM +0200, Mika Westerberg wrote:
>> Unfortunately I still see the same hang. I double checked, with revert the
>> problem goes a way and with this patch I still see it.
>>
>> Steps:
>>
>> 1. Boot the system, nothing connected.
>> 2. Connect TBT 4 dock to the host.
>> 3. Connect TBT 3 NVMe to the TBT4 doc.
>> 4. Authorize both PCIe tunnels, verify devices are there.
>> 5. Enter s2idle.
>> 6. Unplug the TBT 4 dock from the host.
>> 7. Exit s2idle.
> 
> Thanks for testing.  Would you mind giving the below a spin?
> 
> I've realized this can likely be solved in a much easier way:
> 
> The ->resume_noirq callback is invoked while traversing down
> the hierarchy and the topmost slot which detects device replacement
> already marks everything below as disconnected.  Hence any nested
> hotplug ports can just skip the replacement check because they're
> disconnected as well.
> 
> -- >8 --
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e6..997841c 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
>   
>   static bool pciehp_device_replaced(struct controller *ctrl)
>   {
> -	struct pci_dev *pdev __free(pci_dev_put);
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>   	u32 reg;
>   
> +	if (pci_dev_is_disconnected(ctrl->pcie->port))
> +		return false;
> +
>   	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
>   	if (!pdev)
>   		return true;
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


