Return-Path: <linux-pci+bounces-18209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A716E9EDD02
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 02:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18137283138
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49F38396;
	Thu, 12 Dec 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="A5Xsd5Qr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com [117.135.214.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5578225A8
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733966424; cv=none; b=eW0k16suXbSik37Zl+RtpHThRTKeajA/jfVTDWkBtkyQOk9urH/m3inZVyyIwvuxDfTCImxLAWb0+RRX8hY+Lfq+99QCRumDeXb5rYObWh84LSG9Rb3th5EcZmilhPYXWydJPoMoavMTT5y1o8zPPrAZ5GYiw0YNEPz/QuNlE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733966424; c=relaxed/simple;
	bh=fOjOD/IKXJvnMHZB1d4G4Wo2OpN5AZxkgTXxyOKQPTw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rpksBdeaRZSvXwctXqy7iU+ft2ZS3dKS/Fg0Bpf2Zaurh3JDoTywiYe+NxPfRvg5TU+oPNgPV2i4anIfS9BBj/ybpCobHcrSXS3JB19+hUikb6pXLFjqHWNFrHGW01pleuuAnl+2jgT43egIuDoB71+Wu2r8eVjh2EO2NE8NE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=A5Xsd5Qr; arc=none smtp.client-ip=117.135.214.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 57657c51;
	Thu, 12 Dec 2024 08:44:54 +0800 (GMT+08:00)
Message-ID: <6c050402-18af-41b2-890f-87ef1f62073f@rock-chips.com>
Date: Thu, 12 Dec 2024 08:44:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add Rockchip vendor ID
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20241211201822.GA3305340@bhelgaas>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20241211201822.GA3305340@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxCTFZDSx9LHRpOTx1DSkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	JVSktLVUpCS0tZBg++
X-HM-Tid: 0a93b85368ad09cckunm57657c51
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6FDo6CTIREDceGhkWAwpD
	OBAwCQpVSlVKTEhIQk1PSUJOSE5PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUpJSkg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=A5Xsd5QrU7P+L9SverP1V0dMJBDvYsTr9D4EZe5taDYDSolxEh2/ebaTrXESJa/3LqUIjSUH+Usluux+tu6F8dw9FfGYYd86Wl7GYEBplkNFT4Yx+L5auraa8sciw0vad3pMOYqFySkKxjvrXTD20c0J8TxlkKH9puqcbtOHBQQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3EoOeRnKT7mCblfjFt2q0SS8WR2hT+vivdMy0Xr6/LE=;
	h=date:mime-version:subject:message-id:from;

在 2024/12/12 4:18, Bjorn Helgaas 写道:
> On Wed, Dec 11, 2024 at 02:58:12PM +0800, Shawn Lin wrote:
> 
> Needs a commit log.  It's OK to repeat the subject line.
> 
> Also, per the note at the top of pci_ids.h, needs a list of multiple
> places this will be used.  This series only adds one place, which
> isn't enough to justify adding this to pci_ids.h.
> 
> But this *could* also be used in drivers/misc/pci_endpoint_test.c and
> drivers/pci/controller/pcie-rockchip-host.c, so if you want to update
> them as well, this would be fine.
> 

Sure, will replace them on the next version. Thanks.

>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2: None
>>
>>   include/linux/pci_ids.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index d2402bf..6f68267 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2604,6 +2604,8 @@
>>   
>>   #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
>>   
>> +#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
>> +
>>   #define PCI_VENDOR_ID_HYGON		0x1d94
>>   
>>   #define PCI_VENDOR_ID_META		0x1d9b
>> -- 
>> 2.7.4
>>
> 


