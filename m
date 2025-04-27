Return-Path: <linux-pci+bounces-26868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4373EA9E329
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B20D3BC070
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5082AEE1;
	Sun, 27 Apr 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W+o3lnqk"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D1610C;
	Sun, 27 Apr 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758791; cv=none; b=Wade4wa4f0hme6/g2mOUMeY4hPOzvLyTgKZAJ5iF/CPsnBqseTvmSUlW+15aCIBxGH2Hfzn/kBqnfKzu2sve8xsgU7TZ4E/3ilkF7IUXNw/Xqw7zp/eA1uUlEeYIx4kef2ex99yw9EeUtr8FlbNfTKastoebOhfKOSxYIOw8Lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758791; c=relaxed/simple;
	bh=DYfyxH/ZFe6ArRfv/bzScnGtIGzfArNFDSQdJeA1yCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHqBFIcKGTAWQi0/DAdpz2ke/USIrifjBt8Dmc8zCo9TuLF97y41mZEwO1xQYZRA5fP6WsektxK6kbekkAWUO5aYKKnrnDikHHGR19KE5q9VlzDcFqtvP/rM8HN0SLmwlojJ2nJX/YXEuYJs40lYzGh4yomn2As2ZVCFVWDECAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W+o3lnqk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=DQSPcZTtwb3AyD/BZAXLpksdXqfkUHT2zq46CYmEdMo=;
	b=W+o3lnqkGrJokPTPdUKgRc8dwTJEGEBZXqXDzpzBAphAGv0S3ucsCC4ciSNyAw
	54nZPdtYvnX8mrIZkIeARrVv6XR6YPeuLTUchZ6CIOc/K3nrrY9ggild7Dg5fJ5o
	a+uwQyRZELgr/MsaeTeo5jAxITNQvaWR0fHQYNyhcuSbY=
Received: from [192.168.142.52] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3lQ4ZKg5onKoZBA--.22488S2;
	Sun, 27 Apr 2025 20:59:08 +0800 (CST)
Message-ID: <40658509-180d-435b-aa1c-663e7536eba2@163.com>
Date: Sun, 27 Apr 2025 20:59:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] PCI: dw-rockchip: Reorganize register and bitfield
 definitions
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, robh@kernel.org, jingoohan1@gmail.com,
 shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250423153214.16405-1-18255117159@163.com>
 <yhcnrmmmphqz2egrws5sxobysf6ntnd7xxl5vuzo34y5aunbj5@pe7i352kgdm7>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <yhcnrmmmphqz2egrws5sxobysf6ntnd7xxl5vuzo34y5aunbj5@pe7i352kgdm7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgC3lQ4ZKg5onKoZBA--.22488S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4fAFykAw45XrWfGF4Uurg_yoW5GFy8pa
	s5Ga93Cr47Jw4xAan2yr1xZFy0g3ZxAF98Zws8Kw1jyay5X3WfXFWS9F1Y9ry7Xr4fKr1I
	vw47Xw1I934Yva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UloGQUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwU8o2gOJqRbegAAsQ



On 2025/4/27 19:10, Manivannan Sadhasivam wrote:
> On Wed, Apr 23, 2025 at 11:32:11PM +0800, Hans Zhang wrote:
>> 1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
>> 2. PCI: dw-rockchip: Reorganize register and bitfield definitions
>> 3. PCI: dw-rockchip: Unify link status checks with FIELD_GET
>>
>> ---
>> Changes for v3:
>> - Delete the redundant Spaces in the comments of patch 2/3.
>>
>> Changes for v2:
>> - Add register annotations to enhance readability.
>> - Use macro definitions instead of magic numbers.
>>
>> https://patchwork.kernel.org/project/linux-pci/patch/20250416151926.140202-1-18255117159@163.com/
>>
>> Bjorn Helgaas:
>> These would be material for a separate patch:
>>
>> - The #defines for register offsets and bits are kind of a mess,
>>    e.g., PCIE_SMLH_LINKUP, PCIE_RDLH_LINKUP, PCIE_LINKUP,
>>    PCIE_L0S_ENTRY, and PCIE_LTSSM_STATUS_MASK are in
>>    PCIE_CLIENT_LTSSM_STATUS, but you couldn't tell that from the
>>    names, and they're not even defined together.
>>
>> - Same for PCIE_RDLH_LINK_UP_CHGED, PCIE_LINK_REQ_RST_NOT_INT,
>>    PCIE_RDLH_LINK_UP_CHGED, which are in PCIE_CLIENT_INTR_STATUS_MISC.
>>
>> - PCIE_LTSSM_ENABLE_ENHANCE is apparently in PCIE_CLIENT_HOT_RESET_CTRL?
>>    Sure wouldn't guess that from the names or the order of #defines.
>>
>> - PCIE_CLIENT_GENERAL_DEBUG isn't used at all.
>>
>> - Submissions based on the following v5 patches:
>> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com/
>> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-2-git-send-email-shawn.lin@rock-chips.com/
>> https://patchwork.kernel.org/project/linux-pci/patch/1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com/
> 
>> https://patchwork.kernel.org/project/linux-pci/patch/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
> 
> Because of *this* dependency, I couldn't apply this series. I'd suggest to
> respin this series avoiding the above mentioned patch and just rebase on top of
> controller/dw-rockchip branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip

Dear Mani,

Thank you very much for your reply and suggestions. I have submitted the 
V4 patch based on the controller/dw-rockchip branch. Please help merge 
it. :)

V4:
https://patchwork.kernel.org/project/linux-pci/cover/20250427125316.99627-1-18255117159@163.com/

Best regards,
Hans


