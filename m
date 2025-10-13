Return-Path: <linux-pci+bounces-37940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA8BD5C8B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D3618A498F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD65E2D7DE7;
	Mon, 13 Oct 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqlCNQ7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15931CA84;
	Mon, 13 Oct 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381491; cv=none; b=AwmQlLwTJnxZrMhnfiKXV8+rGVAS5S90QnE5IY+FzPqnCpbvsg8LuYO1zRoAZ6OKZocl8tn+0wu9q8L9CP1CqZO7cqi7caFJ3SL4NENUkiVfTvaVqYuQIsCosPjBjCSeOsLJAQFzM1DMhvP6Qtnq/RKFbtK7HqgDok964gKc/f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381491; c=relaxed/simple;
	bh=wKUpRryNaHwuge/VYu6cqa0dpbzt9KPcGiAg8S9Mfek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaQ4nCqb5JDM5PJE3+OjxkwyoETfLdgRmB1AOVnGtdSzqtHLVmq0jre7vAT3DMJ/yYapWG3fVAg1d3vMgQxhraAkJ1N+277AymFU6j/k0ao6nWa6BAYRYdPEdG4wxxOki8TapwVGhnetAuhNxtdpxGIgSK26whBNqfUY9u32bhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqlCNQ7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA8C4CEE7;
	Mon, 13 Oct 2025 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381491;
	bh=wKUpRryNaHwuge/VYu6cqa0dpbzt9KPcGiAg8S9Mfek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JqlCNQ7SR1xNZt066m+ygMiN6zSGwhiaUfNrW/dpJECGLWEU1ap7jTIjEz27UqYzD
	 +8XQSc1Y8Ch7lLberp3mV3bLpAAbWDdULjglqBdkOvQL0uRk6HW9sEf0RTDc/zXjod
	 PXyYQn9JhH9lQ9ZtsTHHc9wCyAEFicbKK7PQM8If5EwzKMzH3rcY2gCUVUZDZDM4UH
	 diJdk9erelVGu9IofA8Acwn4/a0PGdtbS7FczWpqwqFG9eljA3a+4qsAvAPHvBwVbL
	 KH1ScAQ7uDRBFPeC6nLoNyQ3Blomg18n9agWjAdvztNoFSRueicQmg/x72vL1PqEL0
	 2LtqdW5lYNXrw==
Message-ID: <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
Date: Mon, 13 Oct 2025 13:51:29 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20251006120944.7880-1-spasswolf@web.de>
 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 11:29 AM, Bert Karwatzki wrote:
> Am Dienstag, dem 07.10.2025 um 16:33 -0500 schrieb Mario Limonciello:
>>
>> Can you still reproduce with amd_iommu=off?
> 
> Reproducing this is at all is very difficult, so I'll try to find the exact spot
> where things break 
> (i.e. when the pci bus breaks and no more message are transmitted
> via netconsole) first. The current state of this search is that the crash occurs in
> pci_pm_runtime_resume(), before pci_fixup_device() is called:
> 

One other (unfortunate) possibility is that the timing of this crash 
occurring is not deterministic.

As an idea for debugging this issue, do you think maybe using kdumpst 
[1] might be helpful to get more information on the state during the crash?

Since NVME is missing you might need to boot off of USB or SD though so 
that kdumpst is able to save the vmcore out of RAM.

Link: 
https://blogs.igalia.com/gpiccoli/2024/07/presenting-kdumpst-or-how-to-collect-kernel-crash-logs-on-arch-linux/ 
[1]
> static int pci_pm_runtime_resume(struct device *dev)
> {
> 	struct pci_dev *pci_dev = to_pci_dev(dev);
> 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> 	pci_power_t prev_state = pci_dev->current_state;
> 	int error = 0;
> 	// dev_info(dev, "%s = %px\n", __func__, (void *) pci_pm_runtime_resume); // remove this so we don't get too much delay
> 										  // This was still printed in the case of a crash
> 										  // so the crash must happen below
> 
> 	/*
> 	 * Restoring config space is necessary even if the device is not bound
> 	 * to a driver because although we left it in D0, it may have gone to
> 	 * D3cold when the bridge above it runtime suspended.
> 	 */
> 	pci_pm_default_resume_early(pci_dev);
> 	if (!strcmp(dev_name(dev), "0000:00:01.1")) // This is the current test.
> 		dev_info(dev, "%s %d\n", __func__, __LINE__);
> 	pci_resume_ptm(pci_dev);
> 
> 	if (!pci_dev->driver)
> 		return 0;
> 
> 	//if (!strcmp(dev_name(dev), "0000:00:01.1"))         // This was not printed when 6.17.0-rc6-next-20250917-gpudebug-00036-g4f7b4067c9ce
> 	//	dev_info(dev, "%s %d\n", __func__, __LINE__); // crashed, so the crash must happen above
> 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> 	pci_pm_default_resume(pci_dev);
> 
> 	if (prev_state == PCI_D3cold)
> 		pci_pm_bridge_power_up_actions(pci_dev);
> 
> 	if (pm && pm->runtime_resume)
> 		error = pm->runtime_resume(dev);
> 
> 	return error;
> }
> 
> 
> Bert Karwatzki


