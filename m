Return-Path: <linux-pci+bounces-29511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E35AD64E7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 03:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632B93ACBD0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 01:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BE441760;
	Thu, 12 Jun 2025 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TicbPZVT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D820328;
	Thu, 12 Jun 2025 01:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690485; cv=none; b=lWWVkRGtDPXLGe4/qT+EM5/YNJf7oom56rJ2C+r1cDuRZYSYQEjH3Hz5+iWbw/42owYRMIrq8LsXlCcVkZUQc6tmJHkFK8wUZfn1TigA+nprY7tYYQ9wt9FSpIGvAUAQXgvCLQAN4avawjaMLpHvsfmlK6hxTyrDDyl/AAkGFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690485; c=relaxed/simple;
	bh=lxh3OcU9lrQDFBUQh3Z5944IL2QKk2zIeSZRZ/Sb4qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nfe3DlU5nq+khy/TKOiPIdRRlohKW/JjE0KOwb8kWjrOwOX+sw5dntgodjFi1r2QcQDs17amqpazAzVi3DsSja9dY777qN6ikt0bkSskXcj0CzCYnyCTZyTpt/P0KbSyYzfUYpSIE1uEWM56PCh0qNv0/Zeg/rL3RQyTxv7NUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TicbPZVT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=G5kBzMKk/cML1HYhI3QXW6znFZfK6qdoKbkVSe5acSs=;
	b=TicbPZVThBQJbi8sp5BzztP4gdpPxoRTqqcixeGJ88cPQR8G3rlXSpy60mIPZW
	aSCic1E5cFwY0yS73lU6CxYvx4Lvmb/sGpcrYGK6cDXeh0q+6preuWWiVgef2pU8
	4Z6Hy5FoX66UrUn99mIK1FypJqkXBo4BA4XNYT5MMg/pg=
Received: from [192.168.18.52] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnKTFdKEpoSUQwBg--.32898S2;
	Thu, 12 Jun 2025 09:07:42 +0800 (CST)
Message-ID: <c31c3834-247d-4a28-bd2c-4a39ea719625@163.com>
Date: Thu, 12 Jun 2025 09:07:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] PCI: dwc: Refactor register access with
 dw_pcie_clear_and_set_dword helper
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250611204011.GA868320@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250611204011.GA868320@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgBnKTFdKEpoSUQwBg--.32898S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrW7uw1kJrWDCF4kKryrXrb_yoW3WFyfpF
	WjvF4rur4xtr1vg3yxXayYvr48Wr9YqrZ7W3WxG342vr4xJF97tFyftFWUKFy7KrWFv3WI
	9ryjv3WkW34YkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDWrXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxtqo2hKJLB-XgAAse



On 2025/6/12 04:40, Bjorn Helgaas wrote:
> On Thu, Jun 12, 2025 at 12:30:47AM +0800, Hans Zhang wrote:
>> Register bit manipulation in DesignWare PCIe controllers currently
>> uses repetitive read-modify-write sequences across multiple drivers.
>> This pattern leads to code duplication and increases maintenance
>> complexity as each driver implements similar logic with minor variations.
> 
> When you repost this, can you fix whatever is keeping this series from
> being threaded?  All the patches should be responses to the 00/13
> cover letter.  Don't repost until at least a couple of days have
> elapsed and you make non-trivial changes.
> 

Dear Bjorn,

Every time I send an email to the PCI main list, I will send it to 
myself first, but I have encountered the following problems:
Whether I send my personal 163 email, Outlook email, or my company's 
cixtech email, only 10 patches can be sent. So in the end, I sent each 
patch separately.

This is the first time I have sent an email with a series of more than 
10 patches. My configuration is as follows:
smtpserver = smtp.163.com
smtpserverport = 25
smtpenablestarttlsauto = true
smtpuser = 18255117159@163.com
smtppass = xxx

I suspect it's a problem with China's 163 email. Next, I will try to 
send it using the company's environment. Or when I send this series of 
patches next time, I will paste the web link address of each patch in by 
replying 0000-cover-letter.patch.


git send-email --no-chain-reply-to --quiet --to 
hanshuatuo.zhang@outlook.com patch_hans/dwc_set_dword/*
......
Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): a
Sent [PATCH 00/13] PCI: dwc: Refactor register access with 
dw_pcie_clear_and_set_dword helper
Sent [PATCH 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for 
register bit manipulation
Sent [PATCH 02/13] PCI: dwc: Refactor dwc to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 03/13] PCI: dwc: Refactor dra7xx to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 04/13] PCI: dwc: Refactor imx6 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 05/13] PCI: dwc: Refactor meson to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 06/13] PCI: dwc: Refactor armada8k to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 07/13] PCI: dwc: Refactor bt1 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 08/13] PCI: dwc: Refactor rockchip to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 09/13] PCI: dwc: Refactor fu740 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 10/13] PCI: dwc: Refactor qcom common to use 
dw_pcie_clear_and_set_dword()
MI:DMC 163 gzga-smtp-mtada-g0-3,_____wA3YOjZJEpouIVyHg--.2947S13 
1749689566 
http://mail.163.com/help/help_spam_16.htm?ip=222.71.101.198&hostid=gzga-smtp-mtada-g0-3&time=1749689566


or


git send-email --no-chain-reply-to --quiet --to 1053912923@qq.com 
patch_hans/dwc_set_dword/*
......
Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): a
Sent [PATCH 00/13] PCI: dwc: Refactor register access with 
dw_pcie_clear_and_set_dword helper
Sent [PATCH 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for 
register bit manipulation
Sent [PATCH 02/13] PCI: dwc: Refactor dwc to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 03/13] PCI: dwc: Refactor dra7xx to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 04/13] PCI: dwc: Refactor imx6 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 05/13] PCI: dwc: Refactor meson to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 06/13] PCI: dwc: Refactor armada8k to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 07/13] PCI: dwc: Refactor bt1 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 08/13] PCI: dwc: Refactor rockchip to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 09/13] PCI: dwc: Refactor fu740 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 10/13] PCI: dwc: Refactor qcom common to use 
dw_pcie_clear_and_set_dword()
MI:DMC 163 gzga-smtp-mtada-g0-1,_____wBnOhQ_JUpoES6WHw--.47108S13 
1749689667 
http://mail.163.com/help/help_spam_16.htm?ip=222.71.101.198&hostid=gzga-smtp-mtada-g0-1&time=1749689667

or

git send-email --no-chain-reply-to --quiet --to hans.zhang@cixtech.com 
patch_hans/dwc_set_dword/*
......
Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): a
Sent [PATCH 00/13] PCI: dwc: Refactor register access with 
dw_pcie_clear_and_set_dword helper
Sent [PATCH 01/13] PCI: dwc: Add dw_pcie_clear_and_set_dword() for 
register bit manipulation
Sent [PATCH 02/13] PCI: dwc: Refactor dwc to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 03/13] PCI: dwc: Refactor dra7xx to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 04/13] PCI: dwc: Refactor imx6 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 05/13] PCI: dwc: Refactor meson to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 06/13] PCI: dwc: Refactor armada8k to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 07/13] PCI: dwc: Refactor bt1 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 08/13] PCI: dwc: Refactor rockchip to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 09/13] PCI: dwc: Refactor fu740 to use 
dw_pcie_clear_and_set_dword()
Sent [PATCH 10/13] PCI: dwc: Refactor qcom common to use 
dw_pcie_clear_and_set_dword()
MI:DMC 163 gzsmtp2,PSgvCgAnBeWGJUpo7GLnCA--.28592S13 1749689739 
http://mail.163.com/help/help_spam_16.htm?ip=222.71.101.198&hostid=gzsmtp2&time=1749689739




I'm deeply sorry for the inconvenience caused to everyone's review. The 
following are the links of each patch.

0001:https://patchwork.kernel.org/project/linux-pci/patch/20250611163057.860353-1-18255117159@163.com/
0002:https://patchwork.kernel.org/project/linux-pci/patch/20250611163106.860438-1-18255117159@163.com/
0003:https://patchwork.kernel.org/project/linux-pci/patch/20250611163113.860528-1-18255117159@163.com/
0004:https://patchwork.kernel.org/project/linux-pci/patch/20250611163121.860619-1-18255117159@163.com/
0005:https://patchwork.kernel.org/project/linux-pci/patch/20250611163131.860729-1-18255117159@163.com/
0006:https://patchwork.kernel.org/project/linux-pci/patch/20250611163137.860795-1-18255117159@163.com/
0007:https://patchwork.kernel.org/project/linux-pci/patch/20250611163148.860884-1-18255117159@163.com/
0008:https://patchwork.kernel.org/project/linux-pci/patch/20250611163154.860976-1-18255117159@163.com/
0009:https://patchwork.kernel.org/project/linux-pci/patch/20250611163200.861064-1-18255117159@163.com/
0010:https://patchwork.kernel.org/project/linux-pci/patch/20250611163209.861171-1-18255117159@163.com/
0011:https://patchwork.kernel.org/project/linux-pci/patch/20250611163215.861242-1-18255117159@163.com/
0012:https://patchwork.kernel.org/project/linux-pci/patch/20250611163221.861314-1-18255117159@163.com/
0013:https://patchwork.kernel.org/project/linux-pci/patch/20250611163227.861403-1-18255117159@163.com/

> My preference is to make the subject lines like:
> 
>    PCI: dra7xx: Refactor ...
>    PCI: imx6: Refactor ...
> 

Will change.

> etc.  I think including both dwc and dra7xx is overkill.
> 
> You can find the prevailing style with:
> 
>    git log --no-merges --oneline --pretty=format:"%h (\"%s\")" drivers/pci/controller/dwc
> 
> Whoever applies this series can trivially squash patches together if
> that seems better.

Thank you very much for the hint you gave.

Best regards,
Hans


