Return-Path: <linux-pci+bounces-29204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3032AD1A6A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED273AA039
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E0024EF8B;
	Mon,  9 Jun 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WTM1v84d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3292.qiye.163.com (mail-m3292.qiye.163.com [220.197.32.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ABB4D8CE;
	Mon,  9 Jun 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460822; cv=none; b=YEhtIAohRhU8mjMw+FP+m+OsHy6uulKI/vstuxB/2hUlx/70p0kb7iBYU/+S045P2QkIvjsPST5qdHHAzEH+FmBAkVUdbcRANIzNSRO93NF8NSh6HwL0dZ3X5ApFRMy93zT4Ql8a8XjwCg0V5WHiz49gOt7J4PU3RpNqV8hg9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460822; c=relaxed/simple;
	bh=pt6VfAoaqmAdf/KA8EV21pPPqfzb0MEZE1F3BNeB6K8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aHNWo/zlCqDycsQ9sE/xPUV48PrM6hBN6vrFP0EMcU/9H9aqXKr9GD09tOdrMffUHA2pemx5hU3BFMAaQA2uXwSaJr2QEm4qtj2wR5J8hL7Amwq4sRd3UX9k5VSNV5WlN7WaHd4FtMrH+0moWlULBMrOEYnhkKOMFkuSp138Oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WTM1v84d; arc=none smtp.client-ip=220.197.32.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 18005320a;
	Mon, 9 Jun 2025 17:14:59 +0800 (GMT+08:00)
Message-ID: <639cd0b2-08d1-44dc-97a7-bd6bc9f84468@rock-chips.com>
Date: Mon, 9 Jun 2025 17:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Fix interrupt log message
To: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, mani@kernel.org
References: <20250607160201.807043-1-18255117159@163.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20250607160201.807043-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk9CSFYZTUofTEpKGk5JHRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9753f8bc1d09cckunmebd35233698387
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBw6MDo6KDE8MRFCMRgcSDMK
	Kk0aCkhVSlVKTE9CT01LTktKS0hDVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlPQ083Bg++
DKIM-Signature:a=rsa-sha256;
	b=WTM1v84dbg0ubPuSSxPDivYr6mVBmeHVSpkdFbu/okZs7hP7BWpOn+HCt+xcKr0AzeHeC26Kho6btD6y3NeR6/o66XR5LDK9o6Fny2PPOhAaO5ADmLfpRW4rlbTnJcUO5PF3hXCA7sCbIroNpIjZfu+1kgJ5fgKVtPXfHAymsy0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=UnImHBjEXBYKTlW6N7hHZOLrlwnq3Uv1RsZaYhtprg4=;
	h=date:mime-version:subject:message-id:from;

在 2025/06/08 星期日 0:01, Hans Zhang 写道:
> Dear Maintainers,
> 
> Detailed descriptions of interrupts can be seen from RK3399 TRM doc.
> I found two errors and cleaned up the driver by the way.
> 
> This patch series improves the logging accuracy and code cleanliness of
> the Rockchip PCIe host controller driver:
> 
> Log Message Clarifications
> 
> Patch 1 fixes a misleading debug message for the PCIE_CORE_INT_UCR
> interrupt, replacing a duplicated "malformed TLP" message with "Unexpected
> Completion" to reflect the actual error condition.
> 
> Patch 2 corrects the terminology for non-fatal errors, renaming "no fatal
> error" to "non fatal error interrupt received" to align with PCIe interrupt
> semantics.
> 
> Code Cleanup
> 
> Patch 3 removes redundant header includes (e.g., unused clock/reset
> headers) to streamline the driver and reduce build dependencies.
> 
> These changes enhance debug log reliability, eliminate ambiguity for
> developers.
> 

Thanks for your patches.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
> Changes for v3:
> - Add Reviewed-by: Manivannan Sadhasivam <mani@kernel.org> (Mani's new email address.)
> 
> Changes for v2:
> - Drop patch [v1 3/4].
> - The other patches have not been modified.
> ---
> 
> Hans Zhang (3):
>    PCI: rockchip-host: Fix "Unexpected Completion" log message
>    PCI: rockchip-host: Correct non-fatal error log message
>    PCI: rockchip-host: Remove unused header includes
> 
>   drivers/pci/controller/pcie-rockchip-host.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> 

