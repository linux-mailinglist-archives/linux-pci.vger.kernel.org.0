Return-Path: <linux-pci+bounces-25329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654FA7CA4D
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 18:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3421893F88
	for <lists+linux-pci@lfdr.de>; Sat,  5 Apr 2025 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4CF176242;
	Sat,  5 Apr 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sf460MmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F065148FE6;
	Sat,  5 Apr 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871326; cv=none; b=bFYfMsNXFtEP5SDHncNL4mJPL0cngNrn2+nbU0noNL5pDaL+p8QBSpFX1tn5wKXYGDeRgot9rjIscOZKqailyugyfEORwwwJ5iKFZszHNxFK7d8dHmuiJqkvMBQFN0d9B52menToOaNQywS7iECkaSW2/a1D7+cWhwlYoWCbd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871326; c=relaxed/simple;
	bh=rggqmKNXZhyQJ5KpX5PEgXpbKcP7RLMtTrI/QHICR9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmbQ/Xd55yNrH033WKZodWWeSqiM6sBxhEeEOkjqNpMv1J5YyhFMCS4pqlxHn/qQujglE/SJlyHDfCwY/fHOuP9vlhXfAiCR8UU261Gj3mHgp1y79EPQA50vV7kgIMSxJG2G7WEexjS47SurX25MqwPA1uyvjp/5xRdSvJ/fhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sf460MmW; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=mSzTicsRwO2mhYeb8FycY5Zmlx7Ew5ttyDCHEALjYdw=;
	b=Sf460MmWtmzNyMTrHJCnmgnZ0jshLWXc2SMn9Dx7YVGiIIVXXk09nSjZ1UCOKv
	10tIKoufZC0pf5UBbecxkhRdWnBgJMt6e6vzkcq/4UgTAyJP1/lCaJJ0a2BnDtb4
	PGy6brDgqGBxDg+KOI+RLAaLQreeqoylz4cFV+k4omrO4=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnNtY7XfFnh4lxEQ--.27393S2;
	Sun, 06 Apr 2025 00:41:31 +0800 (CST)
Message-ID: <c696c21e-97c6-4bfa-bdb4-d519416f5c99@163.com>
Date: Sun, 6 Apr 2025 00:41:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: tegra194: Fix debugfs cleanup for !CONFIG_PCIEASPM
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: bhelgaas@google.com, jonathanh@nvidia.com, kw@linux.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-tegra@vger.kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, thierry.reding@gmail.com
References: <20250405145459.26800-1-18255117159@163.com>
 <727b55b6-ccba-4498-be95-027a9f67dfa9@wanadoo.fr>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <727b55b6-ccba-4498-be95-027a9f67dfa9@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnNtY7XfFnh4lxEQ--.27393S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF48tw43KF4Utr4fZw45GFg_yoW8Jw45pw
	s7Cr45KF4UA348tFyxCa1kuFyfJrZ3Z343XFy3u3yv93s5Ar98XF92qF4YqFy3Gw48Kr1U
	JFs5Zw15ur1YyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyWlPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh0mo2fxWvIyYQAAsP



On 2025/4/6 00:14, Christophe JAILLET wrote:
> Le 05/04/2025 à 16:54, Hans Zhang a écrit :
>> When CONFIG_PCIEASPM is disabled, debugfs entries are not created, but
>> tegra_pcie_dw_remove() and tegra_pcie_dw_shutdown() unconditionally call
>> debugfs_remove_recursive(), leading to potential NULL pointer operations.
>>
>> Introduce deinit_debugfs() to wrap debugfs_remove_recursive(), which is
>> stubbed for !CONFIG_PCIEASPM. Use this function during 
>> removal/shutdown to
>> ensure debugfs cleanup only occurs when entries were initialized.
>>
>> This prevents kernel warnings and instability when ASPM support is
>> disabled.
>>
> 
> Could you elaborate?
> 
> 
> debugfs_remove_recursive() ends either to:
> 
> static inline void debugfs_remove(struct dentry *dentry)
> { }
> if CONFIG_DEBUG_FS is not set,
> 
> or
> to a function which starts with:
>      if (IS_ERR_OR_NULL(dentry))
>          return;
> if it is set.
> 
> 
> So what does this new deinit_debugfs() add?
> 
> 
> Which NULL pointer are you seeing?
> Did you actually manage to trigger it?
> 


Hi Christophe,

You're right, and I'm sorry about that.

The following line of code only makes sense if the #if 
defined(CONFIG_PCIEASPM) condition holds. Do we need to optimize this?

pcie->debugfs = debugfs_create_dir(name, NULL);

Best regards,
Hans


