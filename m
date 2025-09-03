Return-Path: <linux-pci+bounces-35397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C60FB427F0
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 114804E4F6D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85992C0283;
	Wed,  3 Sep 2025 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VywDLcgD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FFF1EBFFF;
	Wed,  3 Sep 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920384; cv=none; b=PAbLqwOgumZSulZ6CnOY3pHgwnWqQ0qgq5nD6/4pBspDm102zMBFI05FrQCJbA4Ic2hVLc2W0OCHFYascvdhiiwlEwGYwDzaGNk60ISbtiZGbRxqydAn30g2PAZINcN4OLKsV+VjTUgB48iSDMKp//84zLImtP7+HILe7r3nP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920384; c=relaxed/simple;
	bh=MMVLaoX+6VlfjNKjiqzYoloF5TmT2cECAamMPbJZnNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcA7znnv57HXa6kewIuAFqqEmkijyDQXiRl2T0FH5BtjDQSIkCNOc5YifRJGHqiWQBjbUWnT7Juo39k/UfprQMiUiCQg1TKZllxhRFPuN7iGsWCk9FXeuWBAaijXn2AQncNEv8Q8z4AbMKun7saB57O3F8MwpxoOO+vBt2zMF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VywDLcgD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=dCIqqthfYGahQeKtj9M6ZR9oMSs9qAHhqVEZZDd1nbo=;
	b=VywDLcgDbIUEsud4LeMk+VH/eG8HrypOEtnajBaxyLLbnflod6Pwaa7lgcGe+m
	FWfEGc7PjzAM4FKiLKqC9i/85Yr4jD9q55xr8uBgCfRgNqVIdwh1/pQG0L/YQg6l
	VCmn3Rfihi95x6Ax4RDOVTP+cGACL1XvfcscDZyKYS0qM=
Received: from [IPV6:240e:b8f:919b:3100:3980:6173:5059:2d2a] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD33zsnerho91e9Bg--.4893S2;
	Thu, 04 Sep 2025 01:25:59 +0800 (CST)
Message-ID: <80da951b-674b-4092-bc9b-e5b0bac1c35e@163.com>
Date: Thu, 4 Sep 2025 01:25:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] PCI: dwc: Refactor register access with
 dw_pcie_*_dword helper
To: Rob Herring <robh@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
 kwilczynski@kernel.org, jingoohan1@gmail.com, cassel@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hans Zhang <hans.zhang@cixtech.com>
References: <20250828135951.758100-1-18255117159@163.com>
 <CAL_JsqJ0cXB4bz+DAUq25V5suS0D-CHnujh0UyxA66UjajJO-g@mail.gmail.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <CAL_JsqJ0cXB4bz+DAUq25V5suS0D-CHnujh0UyxA66UjajJO-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD33zsnerho91e9Bg--.4893S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFy8GFWxWF4rXw1ktrWDJwb_yoW5WFW5pF
	WUCFWayF4UJanF9F1kXa18Zr10g3s5t3y3WFy7G395XF4UAFWqqFyakFy5A3ZxGrWkZF10
	vw47taykuw4DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Un_-PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxi9o2i4dZJvrQAAsw



On 2025/8/29 04:44, Rob Herring wrote:
> On Thu, Aug 28, 2025 at 9:00 AM Hans Zhang <18255117159@163.com> wrote:
>>
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> Register bit manipulation in DesignWare PCIe controllers currently
>> uses repetitive read-modify-write sequences across multiple drivers.
>> This pattern leads to code duplication and increases maintenance
>> complexity as each driver implements similar logic with minor variations.
>>
>> This series introduces dw_pcie_*_dword() to centralize atomic
>> register modification. The helper performs read-clear-set-write operations
>> in a single function, replacing open-coded implementations. Subsequent
>> patches refactor individual drivers to use this helper, eliminating
>> redundant code and ensuring consistent bit handling.
>>
>> The change reduces overall code size by ~350 lines while improving
>> maintainability. Each controller driver is updated in a separate
>> patch to preserve bisectability and simplify review.
> 
> If RMW functions are an improvement, then they should go in io.h. I
> don't think they are because they obfuscate the exact register
> modifications and the possible need for locking. With common API,
> anyone that understands kernel APIs will know what's going on. With a
> driver specific API, then you have to go lookup what the API does
> exactly. So I don't think this is an improvement.
> 
> Rob

Dear Rob,

Thank you very much for your reply.

My initial idea was to simplify the logic we wrote a lot of RMW under 
the DWC driver. Then I saw that there were similar well-handled codes in 
the linux kernel, so I came to do some cleaning work.


drivers/pci/access.c
int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
					u32 clear, u32 set)
{
	int ret;
	u32 val;

	ret = pcie_capability_read_dword(dev, pos, &val);
	if (ret)
		return ret;

	val &= ~clear;
	val |= set;
	return pcie_capability_write_dword(dev, pos, val);
}
EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);


include/linux/pci.h
static inline int pcie_capability_set_dword(struct pci_dev *dev, int pos,
					    u32 set)
{
	return pcie_capability_clear_and_set_dword(dev, pos, 0, set);
}

static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
					      u32 clear)
{
	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
}



And the subsequent introduced API: Personally, I think they are very 
valuable for reference. Of course, it depends on the final opinions of 
the maintainer and all of you.

drivers/pci/access.c
void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
				    u32 clear, u32 set)
{
	u32 val;

	pci_read_config_dword(dev, pos, &val);
	val &= ~clear;
	val |= set;
	pci_write_config_dword(dev, pos, val);
}
EXPORT_SYMBOL(pci_clear_and_set_config_dword);



Best regards,
Hans


