Return-Path: <linux-pci+bounces-37846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4ABCFFC8
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA101891BFF
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663171F2C34;
	Sun, 12 Oct 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="OmU9rSPN"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3439D2BAF9;
	Sun, 12 Oct 2025 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760250596; cv=none; b=BQRG+pxIqZGWzxvBajLWmovMWA/gZaWopP8zYu5qSkqCFo/UtyOsUzXmoJCLYQlCYOOILV8cI4chY4fRR+ApMIGdo7d47kVJj19YUfAbh0M2Ul5aX9PnwiMTCtKNFYUEIb4lPiB5g6EOm7h/q/KGDX1NC4Glc3m2ajtcFQhfi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760250596; c=relaxed/simple;
	bh=hW45rv1z6b6gGbDanGygno6nzHJAc11izoBe9pQAMzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJQ0bdOFWQCVCMFrSFoqclHM0kIw9EQigCqSWgz10wR0W+gmLfsqV/kp+yechf5aFYjQSfUFVfUIVYa8/gDRsXNBPy7ZC8rAU0lAIh6a/MqjbubEVKos8lEHOqH15KDBKlwX64MNF00q+6eUpM2xhFDZPzdGleeNUei2lMGKV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=OmU9rSPN; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <310c8da6-6775-4c3c-b9b3-bad739cda46f@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1760250591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjTYa9DE27qDleF7pkqz/JnprhOjulqOYrM2/CjzCN8=;
	b=OmU9rSPNlKUThQPfF5AQPiTS854uRtl35zbOLoTsIvi7cSbrz8jBsl4bGGu8a8pLMEUsJo
	zcex8Z0imXhwZKHWm/p+ogQ/vFbntvMv5CLcm015dIHCV18EE2le7xRDriCdPFHBGvuvpL
	fsCHv7Q3Syg7xHI1I3d2GEsH4DPJShcAJhKSbOUcZqBzPJVK+lArPr8Ud0k8eQxOyiC7Pi
	pvWCr2QRStz8hoJWDCI0QT2qGje3/ozrOtqMNxl92zSAolVwxUjHVNwgHLM57HKIeNmqWo
	IJLK6ZZ2ZctcwvX3/UjcO96OsOflLfh7Ny32SENk1+pOpwZ3TXIYdnlwyhYJKQ==
Date: Sun, 12 Oct 2025 03:29:42 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>
 <20250924134228.1663-2-ilpo.jarvinen@linux.intel.com>
 <017ff8df-511c-4da8-b3cf-edf2cb7f1a67@packett.cool>
 <f5eb0360-55bd-723c-eca2-b0f7d8971848@linux.intel.com>
 <cd8a1d3c-1386-476b-a93d-1259b81c04e9@packett.cool>
 <8f9c9950-1612-6e2d-388a-ce69cf3aae1a@linux.intel.com>
 <2faffdc3-f956-4071-a6a4-de9b5889096d@packett.cool>
 <094618f2-947e-a66e-dc27-f4dedc8b5bb5@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <094618f2-947e-a66e-dc27-f4dedc8b5bb5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/10/25 2:01 PM, Ilpo Järvinen wrote:

> [..]
> Even if you were very likely joking here, I'm still sorry for breaking it,
> no matter which company's device.
>
> Perhaps I'll start Cc you in all upcoming resource changes as you seem to
> be so willing to volunteer to review them. ;-D

Perhaps Intel corporate could pay me for QAing the patches :D

> There seem to be cases where pci_assign_unassigned_root_bus_resources()
> executes for bus 0000:04 before 0004:01:00.0 is scanned as it is only
> recorded later.
>
> Hmm, qcom_pcie_global_irq_thread() seems to indicate the real enumeration
> can only occur after the link up event has arrived, and it starts another
> scan from there.

Right, I've even seen things about the link-up sequence in the commits 
for the PCIe driver, e.g. 4581403f6792 ("PCI: qcom: Enumerate endpoints 
based on Link up event in 'global_irq' interrupt").

Is this really that uncommon? Can we be sure that other drivers don't 
behave similarly?

> Perhaps this could be solved by inhibiting resource sizing and assignment
> per host bridge until the bus could be enumerated for real. Otherwise the
> resource assignment has no idea how the bridge windows should be sized
> which then can lead to this cornering itself if the initial assignment
> without knowledge of the necessary sizes.
>
> Could you please try if the patch below helps?
> [..]
> @@ -1825,6 +1826,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   		bridge->sysdata = cfg;
>   		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
>   		bridge->msi_domain = true;
> +		// FIXME: Should this be specific to just some host bridges?
> +		bridge->enumeration_pending = 1;
>   
>   		ret = pci_host_probe(bridge);
>   		if (ret)

..and nope, particularly that assignment did not run because at least on 
x1e, the bridges are not firmware_managed, so they are enumerated normally.

~val


