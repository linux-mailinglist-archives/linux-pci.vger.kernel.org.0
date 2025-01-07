Return-Path: <linux-pci+bounces-19460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3029A0498C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E7B166C8E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FAD1F470E;
	Tue,  7 Jan 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NrcRcQ+0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C51F4289;
	Tue,  7 Jan 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275726; cv=none; b=FePfDapSgw8mZAq82QRvsK1PCP+8mAWPJVFxFKCoyr0KyLiuq6ZtymSNXujDtzZtnIQE7OGozNqeN4DDMBjpRQR0kNz+GY8vMPgbfXP/8v+DmM/o+glwr/OmhwOkPOmUJj596d9aq6qiCru9B6ATrmWguIlRELdHULgr2OddV34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275726; c=relaxed/simple;
	bh=i5Hv7txc6Lr+5oObuH/kjN+ySZcL3F3pqA2rrIPS8TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B6cgdY3eXXrRVH6FdWtb0zL1reVoe5XJ/NsCFnyrKHnqtJ6X38qNzHRA1F2sqiFNtbw+52nUpeckSN3KWDXaH73e1YRRkiCDggT/NRIgs72eraxraTxBrUy7xwyUXnbDFpIaq2SbpReSaxEnkg+xrGZmcexZc2H56WTGKlrjFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NrcRcQ+0; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id VEcutZ3aCnl6tVEcytQeMv; Tue, 07 Jan 2025 19:48:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736275713;
	bh=TEWIhvc/bu8r64juy8U6sdj5RTo643e4B/u7nfVDmCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NrcRcQ+0lqsje1mWOryeqaNNn72M2LmLtbv4oVes7YkmclBIPqZscrJc5RjYPSy/5
	 oH3HvMTv+nQs5h8UjB0nJeXgliXcJQUV9VByTDz5JUS2bNT7Oq2PkzG63TgC9pHVpr
	 P8ASttjhFYI1BYOxGgKbsupvfSXDOPgd7pp9BbUvVrRmdeHAkq947G4qM9KPy0OiGD
	 weLgWvEDFxqlORKwboi50HiQbqjOak085q8WBgPcxiHzK/qSXnuUxc36lKRxRd20a8
	 czVntIo0lMgpqL5QEWt3Qn3nVvn61nfsEDhJV3Mfo4VTlAaFH6PkiRTzdgwAO4XJTl
	 3nvEOftDAkAGg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 07 Jan 2025 19:48:33 +0100
X-ME-IP: 90.11.132.44
Message-ID: <73c1bc90-569a-4514-93d4-e6d5e0597607@wanadoo.fr>
Date: Tue, 7 Jan 2025 19:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: fix reference leak in pci_alloc_child_bus()
To: Ma Ke <make24@iscas.ac.cn>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250107110747.860952-1-make24@iscas.ac.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250107110747.860952-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/01/2025 à 12:07, Ma Ke a écrit :
> When device_register(&child->dev) failed, calling put_device() to
> explicitly release child->dev. Otherwise, it could cause double free
> problem.
> 
> Found by code review.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   drivers/pci/probe.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..a61070ce5f88 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1174,7 +1174,10 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>   add_dev:
>   	pci_set_bus_msi_domain(child);
>   	ret = device_register(&child->dev);
> -	WARN_ON(ret < 0);
> +	if (WARN_ON(ret < 0)) {
> +		put_device(&child->dev);
> +		return ERR_PTR(ret);

Previously, the code was continuing the execution. I don't know it is 
correct to return at this point.

Anyway, returning ERR_PTR(ret) just looks wrong, because 
pci_add_new_bus() expect NULL in case of error.
Should ERR_PTR(ret) be returned, it is likely basd thing would happen there.

CJ

> +	}
>   
>   	pcibios_add_bus(child);
>   


