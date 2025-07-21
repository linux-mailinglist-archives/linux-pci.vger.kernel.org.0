Return-Path: <linux-pci+bounces-32658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A95B0C77B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A254193E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227627CB02;
	Mon, 21 Jul 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMT6QNa2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49726F454
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111436; cv=none; b=R79UB9MkxBhT9jaTHnCZe/BJC0eQliXfZDIycCbLjBzeo+H2gX8TwG+eyerQuGJ/1LFBqiFefHRT9CrW5U+pc+xfqr9iTak/ys80CoKWz6q+ZcFO/EPBEMJCqz3gYb742XB+wIG0YroS/IKIWIY1Vgi+GMyn+xB1AUwLlISSwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111436; c=relaxed/simple;
	bh=zVUhb4QW/ioj1ZUC7Vxv3+Lozh6+5vRFn/SlUeuCmsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzKdSfetL1GJOotlnll47GlzCI3inB+OZsOEprfEqX7FbAHznaFdmfVxTgEyy7BBdFWgcnpHGP+7jPexES5R/2xiVwyO4cXBiXoe5IvCfQSZXrokLMUWBbjCzztGcE98B8oARKwrXolN24uT53hrS6KWqcUZRw+qvNLnFM79Vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMT6QNa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F10C4CEED;
	Mon, 21 Jul 2025 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111435;
	bh=zVUhb4QW/ioj1ZUC7Vxv3+Lozh6+5vRFn/SlUeuCmsM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MMT6QNa2Ffva3lNvSAkApySZskTaQ+Q2uZhTKaTJySfnEDGFgbNB0qNixr52juyCn
	 EQmZhs8wSrvFqZ7Q9N7aPUsawTLMUZQZxgTMGvMN+fdKnf+jF76Sb+EO73u2vacJox
	 fvE2C/vuUQJZ4TuNaYndQqMZqXound8EyouNzSzj2Eav3EXI0XI/CedvGqbAFiFmMs
	 vGVZPw3gNERf7hR3emrQe34c/AzdNAVwjLDXsz07EA7OL9meGf0hm6pMstey3MTID5
	 +kt1fAqsUN0jcLMjjeQYltjH5BxzO3vJCZXrGlOUd+hyoua6aLPuLosgNbvp7KjFZi
	 zYzHVEv0AX1OQ==
Message-ID: <045ebe5c-6c92-42f5-a126-6193a09fbaa8@kernel.org>
Date: Mon, 21 Jul 2025 10:23:54 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Adjust visibility of boot_display attribute
 instead of creation
To: Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-pci@vger.kernel.org
References: <20250720151551.735348-1-superm1@kernel.org>
 <aH0MlOshychrsvg9@wunner.de>
 <tvee57irw3xjdcpvikxu63sryxt3admlbtdwgd634in3woxhob@rvq3njadpmie>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <tvee57irw3xjdcpvikxu63sryxt3admlbtdwgd634in3woxhob@rvq3njadpmie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/25 2:15 AM, Manivannan Sadhasivam wrote:
> On Sun, Jul 20, 2025 at 05:34:44PM GMT, Lukas Wunner wrote:
>> On Sun, Jul 20, 2025 at 10:15:08AM -0500, Mario Limonciello wrote:
>>> There is a desire to avoid creating new sysfs files late, so instead
>>> of dynamically deciding to create the boot_display attribute, make
>>> it static and use sysfs_update_group() to adjust visibility on the
>>> applicable devices.
>> [...]
>>> @@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>>>   	if (!sysfs_initialized)
>>>   		return -EACCES;
>>>   
>>> -	retval = pci_create_boot_display_file(pdev);
>>> +	retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
>>>   	if (retval)
>>>   		return retval;
>>>
>>
>> pci_create_sysfs_dev_files() is called from two places, pci_bus_add_device()
>> and the late_initcall pci_sysfs_init().
>>
> 
> Separate question: Do we really need to call pci_create_sysfs_dev_files() from
> pci_sysfs_init()? It is already getting called from pci_bus_add_device() and it
> looks redundant to me. More importantly, it can also lead to a race (though
> won't happen practically) [1].
> 
> Same goes for pci_proc_attach_device(). I was tempted to submit a patch removing
> both these calls from pci_sysfs_init() and pci_proc_init(), but wanted to check
> first.
> 
> [1] https://lore.kernel.org/linux-pci/r7fgb5xrn6ocstq6ctq4q7r4o2esgh4rqr44c3u234kcep6thk@bge2vzl33ptb/
> 
> - Mani
> 

Thanks!  It's totally valid.
Lukas raised the same concern.  I have respun as a v3 with a fix.

https://lore.kernel.org/linux-pci/20250721023818.2410062-1-superm1@kernel.org/T/#u

Thanks,

