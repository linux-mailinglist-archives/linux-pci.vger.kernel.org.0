Return-Path: <linux-pci+bounces-44233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D74D00391
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 22:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9403630216B4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB21318ED7;
	Wed,  7 Jan 2026 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncaiadvN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F23318BBD;
	Wed,  7 Jan 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822433; cv=none; b=nt1crVQ5Gw8WyNx7vziRnWl9K17d5GG9Q5MZmGKZdp79V1Y6Fen1IABq8m5WXugw87EaVFEY18zXLlvLMbr54aZI10giajDQI6J8Wh3vA359XqIAQ0H8zoQNmWK1ZC0qRda5KLWZLXqLun35Aj+Vw6Bo+WwoRf7mRbvS/TIkUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822433; c=relaxed/simple;
	bh=SAlipT1fP7kIO0IvVZ5VIq5XK5ijLK54y/2EHpkDTik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI4GPmjgJnBjQeholVf6zylpuZlIGuejblZpQK/plPuzdCrMX4uAbH2iZVa0dkv2H/j6qMmKYbS0b2mPmsl3+9MsDhH949mOj+JURqgblfXeISehCUTvKUdZW+T8d9sXBuBzHrzltcNUTcLMeyV5Tm8F0WhSRHAF+uZFtPCX/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncaiadvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DB5C4CEF1;
	Wed,  7 Jan 2026 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767822432;
	bh=SAlipT1fP7kIO0IvVZ5VIq5XK5ijLK54y/2EHpkDTik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ncaiadvNMNgwCq2etZbPL7Yh/XkEH1LVA3IP5mGMwq3AYIYMqRkQ2VAnmo+a9NggV
	 ZQuugN1q6RcIXxfiq854uVFj54uovBoQwkShaQQrkdFWiBA+r9D7MSUIZ7dkexUVdz
	 lHi/I9c7voYq8KMMlp5fwyCcJ6EXsQA+S2CMF72DRfELZf86LyfvYdJjTVm0ASwd6Z
	 uy5DWOjSI0bbIyMvC/u/Ct+oantqBvX719NcjUZST+RvFhf8KwwIaW218jwv7+rclk
	 jk0MtBTLcKA6Jnmlj/TT5VEA8DHDD6KHU9COpEQJiY40AbAtNlB6Ogh37c3WkEchr4
	 EGnSTSxBB9qxA==
Message-ID: <fb7bdfeb-46a8-444a-b556-77266da3ff3c@kernel.org>
Date: Wed, 7 Jan 2026 15:47:11 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Revise some PCI _DSM method implement
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250605065814.41298-1-zhoushengqing@ttyinfo.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250605065814.41298-1-zhoushengqing@ttyinfo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 1:58 AM, Zhou Shengqing wrote:
> [1/2]PCI/ACPI: Add rev 2 check for PRESERVE_BOOT_CONFIG function
> [2/2]PCI/ACPI: Add acpi_check_dsm() for PCI _DSM definitions
> 
>   drivers/pci/pci-acpi.c | 58 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 44 insertions(+), 14 deletions(-)

Did this series get overlooked?  I was talking to someone about this 
_DSM and noticed it on lore.  It looks reasonable to me.

The only thing that jumped out to me that I would say is that the tag

Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to 
pci_re")

Shouldn't be below the cutlist, it should be above it.  If there are no 
other concerns maybe Bjorn can just fix that while committing though.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>


