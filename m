Return-Path: <linux-pci+bounces-37810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 815CCBCD8E3
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 16:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17CA24E67E2
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B532F3C20;
	Fri, 10 Oct 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dJHq+3wS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2092F5327;
	Fri, 10 Oct 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107167; cv=none; b=BwcrYXcbV/r+p8Gt93L79ks6V5RcFDplWDBa/ElXWUAKG0PsadRNyf6+JSk+xd8WIkV85X8O1B5cjWfaGDfO4cZmSZxdOvT78sCghdgK4J6a2Zdy0qiOe7ypnwKv6bk+wVRZptkDzYdRBaUzZfS0idKdnkqXgFf/nvkztf6+Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107167; c=relaxed/simple;
	bh=j1UjxD9T0qU8vt9WxKID6o2pSh8TwfeUi6aAGYoe0ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7KgWgGLvjKmgZrxC6b8+aTedZYTHPSvsIvrEjfJaXi+fP41/b6ArbtKbQKxEbhcIT4RClFZtcpjFmsPKen80SZOaDQFREjxFzj7+I+WKvUyhvMUWpijSkwJA1e2I8sCGfSsN7Moh5dz4oTyqvs4bzrBWDwh/yf1NxO7s6Jmsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dJHq+3wS; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=y8ZqTsUONJu32l2l5Y1OrT+YZy8GAUoivYF1WI93dow=;
	b=dJHq+3wSmzNvw+dFobF+RFymaEn+q8e7ENUauUXouLgjxaFALmGVvRXvD04xep
	RgT7Xa8eVwS8mdkt6/CJNL6BlPMV7307hfk1Lbvqtfc7pt3JUhqYcYrhSqmj4PGC
	EGKsDTa4yjIwejZl0idDudoieGWoqagy5Y7LcP2lnZ7BI=
Received: from [IPV6:240e:b8f:927e:1000:9ebf:16a4:5cc0:819] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXH4iBGulo8K9UDQ--.46878S2;
	Fri, 10 Oct 2025 22:38:58 +0800 (CST)
Message-ID: <4d1389e7-5099-45da-962c-ac0446ad96c0@163.com>
Date: Fri, 10 Oct 2025 22:38:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: cadence-ep: Fix incorrect MSI capability ID
To: Lukas Wunner <lukas@wunner.de>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 helgaas@kernel.org, mani@kernel.org, robh@kernel.org, sashal@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009161011.11235-1-18255117159@163.com>
 <aOi48Vt_hfNvwA6t@wunner.de>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aOi48Vt_hfNvwA6t@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXH4iBGulo8K9UDQ--.46878S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr45Ww17ur4DtF43Jw1kZrb_yoWDCwbEv3
	y8Xrn7Zr4FgFs2k3Z7GF9xAF9Fg3y3XF1rur95Jry3tFy0v34xJan3C3saka48tFZ3Ary3
	u3Z0qwsxXw12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_L05UUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiDxvio2jpExLOlQAAsO



On 2025/10/10 15:42, Lukas Wunner wrote:
> On Fri, Oct 10, 2025 at 12:10:11AM +0800, Hans Zhang wrote:
>> In a previous change, the MSIX capability ID (PCI_CAP_ID_MSIX)
>> was mistakenly used when trying to locate the MSI capability in
>> cdns_pcie_ep_get_msi(). Thisis incorrect as the function handles
>> MSI functionality, not MSIX.
>>
>> Fix this by replacing PCI_CAP_ID_MSIX with the correct MSI capability
>> ID(PCI_CAP_ID_MSI) when calling cdns_pcie_find_capability(). This
>> ensures theMSI capability is properly located, allowing MSI functionality
>> to work asintended.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Fixes: 907912c1daa7 ("PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding offsets")
> Reported-by: Sasha Levin <sashal@kernel.org>
> Closes: https://lore.kernel.org/r/aOfMk9BW8BH2P30V@laps/
> 
> This is material for the "pci/for-linus" branch.

Dear Lukas,


Thank you very much, Lukas. I will send the next version and add it.

Best regards,
Hans


