Return-Path: <linux-pci+bounces-26761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A8A9CB8E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9FA189C7FB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C22594B9;
	Fri, 25 Apr 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KzhEE2qm"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367F2594B4;
	Fri, 25 Apr 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590889; cv=none; b=j2uheEFXeHAvUofDymy+/mbPpt8ifMeKIHkcxlt0MbnTXyA2EQbMLztCkT7zw+o7fbQSHwL3mMmnS0vs2LEruN7JHruLBqNyjVdCYyf6dsXGHxSUweYvKzI1TQA0c330lpGFs+u6hHLwYahSDiR/F2SmTCn4tJbw61OtWP/jMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590889; c=relaxed/simple;
	bh=GQvWhApWb5wkib+UB0jlhNRWJNmTNt/ktUBASFkbyUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLhdgHlWIGr2rKZDq7sl2cwCEWMoIe6qKrNDxo41YUFsE4GZmXiJSR+mMuMMG8jf8iD7cHA82MZs0p+oALsxgRVJ0tZTiOT3k3pUMF+q/auvRtW/E7luj1cIts8IRz5IYFxkXf7IwnoWuRfMtMAh7/MXAumPRrhgmaP/XyJFYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KzhEE2qm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=XQYBdxu34VR0VSrWEORHz7bVPlHkrPo4i9PmBo0cNQk=;
	b=KzhEE2qm1q8ynq7e9nb+3UmJpHkBwLvvsVuNDVfC9TNpQr811xVeXyqrM3y6Xc
	YkpjliF9RF3VLsHI0ZKmn5iULR6+VIOGHXlKIeRZ94WGqpI5dzZg3GR8n1T62qD8
	3zhebkc3/wl2bWEkSCnn7tYDCiYQPeFPU7HTs33oCDcMk=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wA3mC0vmgto4FqxCQ--.32274S2;
	Fri, 25 Apr 2025 22:20:32 +0800 (CST)
Message-ID: <a6e097e4-6d57-4db2-a541-ebd9e4a9856b@163.com>
Date: Fri, 25 Apr 2025 22:20:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
To: neil.armstrong@linaro.org, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, thomas.petazzoni@bootlin.com,
 manivannan.sadhasivam@linaro.org, yue.wang@Amlogic.com
Cc: pali@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
 <e6752451-4492-4ae2-9bad-3865c4945dbe@linaro.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <e6752451-4492-4ae2-9bad-3865c4945dbe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3mC0vmgto4FqxCQ--.32274S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4kXF4UKrW7KrW3CryfWFg_yoW5XrWUpF
	W3uF4SyF48Jr4rWFsFyan5CFWftasIkr9rJr9xGr1xuF9FyFsrJFyayFWF9a4xZr42gFnY
	yr1Fg347C3Z8tF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGoGdUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxI6o2gLk-CiIQABsS



On 2025/4/25 19:59, neil.armstrong@linaro.org wrote:
> On 25/04/2025 11:57, Hans Zhang wrote:
>> With the PCI core now centrally configuring root port MPS to
>> hardware-supported maximums (via 128 << pcie_mpss) during host probing,
>> platform-specific MPS adjustments are redundant. This patch removes the
>> custom the configuration of the max payload logic to align with the
>> standardized initialization flow.
>>
>> By eliminating redundant code, this change prevents conflicts with global
>> PCIe hierarchy tuning policies and reduces maintenance overhead. The 
>> Meson
>> driver now fully relies on the core PCI framework for MPS configuration,
>> ensuring consistency across the PCIe topology while preserving
>> hardware-specific MRRS handling.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>>   drivers/pci/controller/pci-aardvark.c  |  2 --
>>   2 files changed, 19 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c 
>> b/drivers/pci/controller/dwc/pci-meson.c
>> index db9482a113e9..126f38ed453d 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -261,22 +261,6 @@ static int meson_size_to_payload(struct 
>> meson_pcie *mp, int size)
>>       return fls(size) - 8;
>>   }
>> -static void meson_set_max_payload(struct meson_pcie *mp, int size)
>> -{
>> -    struct dw_pcie *pci = &mp->pci;
>> -    u32 val;
>> -    u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> -    int max_payload_size = meson_size_to_payload(mp, size);
>> -
>> -    val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>> -    val &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -    dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>> -
>> -    val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
>> -    val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
>> -    dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
>> -}
>> -
>>   static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
>>   {
>>       struct dw_pcie *pci = &mp->pci;
>> @@ -381,7 +365,6 @@ static int meson_pcie_host_init(struct dw_pcie_rp 
>> *pp)
>>       pp->bridge->ops = &meson_pci_ops;
>> -    meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
>>       meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
> 
> Seems you can also remove meson_set_max_rd_req_size() since it's
> done by pcie_write_mrrs()


Dear neil,

Thank you very much for your reply and reminder.

I want to wait for the result of the first patch discussion, and then 
see if we need to remove meson_set_max_rd_req_size().

Best regards,
Hans


