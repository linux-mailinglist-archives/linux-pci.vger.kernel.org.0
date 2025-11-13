Return-Path: <linux-pci+bounces-41033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A72C555D1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0488D3B6267
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B932F7AC9;
	Thu, 13 Nov 2025 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y49w2Lfr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3281.qiye.163.com (mail-m3281.qiye.163.com [220.197.32.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3782F6587
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998459; cv=none; b=Y3iR+ikV1A0/95+wxvx0ny33dpCdZb94mrLxDUOMhUtt+Iuc3P+oAhbI5hyK6slGSvzGP2XwZkpbjk8xnkTyB8CZypBeKs+5vfIxfzGGTX+M0PGE7CUhFcYhOgAv8eiphsdigTG8vDxbJTQaiaXvYGJYqm3iD+k1y1eNY9hopv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998459; c=relaxed/simple;
	bh=Xkl51+WH794OJD6xbMqiHKYl4u79rInpTAC9C5Xe/jA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NTLGVXpY3Nf89oKYSVv9ystMqfGQjZ6xAWBE8F2w2hF1nsYi4wwX82CL9fPGZ7Tra8FxHh324yhlnjZMMADjWdTKVymnSL2sZ8tXMK6tI3NaICj0jlK276qxMxy8kdC15DxLk2B/ObnJpa/dEiIYOqNamPOI001s1ajJKv7vgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Y49w2Lfr; arc=none smtp.client-ip=220.197.32.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29658c00e;
	Thu, 13 Nov 2025 09:47:31 +0800 (GMT+08:00)
Message-ID: <5d45ecfb-e566-4166-9bdd-4dcbd036e659@rock-chips.com>
Date: Thu, 13 Nov 2025 09:47:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add ASPM quirk for Hi1105 PCIe Wi-Fi
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20251113005920.GA2257273@bhelgaas>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251113005920.GA2257273@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7ae57b7c09cckunme93dcfe0229ca7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxITlZKT0gZGEkZS0lOHk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVU
	pLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Y49w2LfrmIfBQM0zNvqqinqXIrHUg/a6HVq9j0FT48oJpRTTN2DxXjoB9phwOmF0BH7wvG2qg7+HGeOLL42h4a6uFhk065AOfxBvhwvXdYJJWLngtW/oWIY6hTAxHsyhBcP8Xj6WtjIl8OeQbukCQUFwhsHeGA5g9ymg6bR2rj8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=vAAmi+i+EI/bZ83UZDhneSGdOd2x6v/xRoyw6d4I5Og=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/13 星期四 8:59, Bjorn Helgaas 写道:
> On Wed, Nov 12, 2025 at 10:58:39AM +0800, Shawn Lin wrote:
>> This Wi-Fi advertises the L0s and L1 capabilities but actually
>> it doesn't support them. This's comfirmed by Hisilicon team in
>> actual productization.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Applied to pci/for-linus, planning for v6.18.


Thanks Bjorn. By checking the for-linus branch, I found an error.

This patch is based on linux-next, but if it's for v6.18, I think we
need to use quirk_disable_aspm_l0s_l1 instead of 
quirk_disable_aspm_l0s_l1_cap.

> 
>> ---
>>
>> Changes in v2:
>> - rebase on linux-next
>> - use DECLARE_PCI_FIXUP_HEADER(Bjorn)
>>
>>   drivers/pci/quirks.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 44e7807..24c2788 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2536,6 +2536,7 @@ static void quirk_disable_aspm_l0s_l1_cap(struct pci_dev *dev)
>>   	pci_info(dev, "ASPM: L0s L1 removed from Link Capabilities to work around device defect\n");
>>   }
>>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1_cap);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1_cap);
>>   
>>   /*
>>    * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>> -- 
>> 2.7.4
>>
> 


