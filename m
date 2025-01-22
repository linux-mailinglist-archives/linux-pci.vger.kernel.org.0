Return-Path: <linux-pci+bounces-20242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD8A194CE
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62A83A112E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA9A214203;
	Wed, 22 Jan 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvJFeLqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4A214216
	for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558728; cv=none; b=frFAKEB0uGjdO8tlVH6abGxlugi1FeWvpcVgANwp7SVw608cmqNjQgWe8JvtykXXdgmBSwyCxwmAauQTPhdoPzVEN8431JTmd80FXTW91Kk+6HjtXDs7keekGwAzaO3+8/cBba54jsOOSdZWzcvNewz3MbvVj1t+wcK2MgF6QX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558728; c=relaxed/simple;
	bh=G/uFZ/7IhpymiobRfW7eQhC/BaSoVk5Bw4SO1Bv76Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ro/J2vIXW5YgspXsJNu7wY/g4FPMDGRmEXCh8S9HV23J4kjzJazydw7tMwk80YBFaUu7UI5paLuzJBiDW4l2rop1xBDIR0T1ZBBEmMHaEJs/8GE0hmHgSZW3w2Et+GuHeg5gNBdppW6XkNrVDrimxNPftFjKyFQxJ1gLG50a5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvJFeLqi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2162c0f6a39so19770055ad.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Jan 2025 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737558726; x=1738163526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtA0t5iuyWhWUhlBSW0Px1ksemdF5NB4KHhbvorAHRQ=;
        b=lvJFeLqiksRRgjcQ5njeGdUHQ+Tkp4wWBr/Yjjh0P7U5EeNIQ6myjv92KSDlaRXG7B
         KjeKMRo7DlN/gpZnZpssw5Jzpv82sViBQlp65qKCx7EH8nOzE0xDiJM6EfmUy8wNGmHI
         use0FT0vdHmS6fm3QC7mvfogJJYpVQ3hySiXEz4d84DNfIGzEtsL+uun3rC9g8S54XVm
         zAiSNeLl6lVT8SCs2o0dot1f5EItGtECtcBHxIVhuL2JSsO0aadYip45hjn5s1UkAiAh
         p5XmYKCuy6ZwYRQz/uFHVWDT1uVJ4wNs3cx0Qc+V798NqdTR7YA0m51QxiwyAFVbFGiu
         UYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558726; x=1738163526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtA0t5iuyWhWUhlBSW0Px1ksemdF5NB4KHhbvorAHRQ=;
        b=t1XYlZtiJD0VvGSbkI4yywZT6PGnMQ6q5Z+gHAklojQJ10kINqPCWIRPzpeVItvs81
         LXO/m2MsMOJkK0myptcY1RaF3L2nIrJr2HQufpXyFC06yAQDIOlP3vYxkNLmdWEZGl+p
         DJeTBHvMiufGYNKBNN8p9NciDL+u0l+Qsc/jVHb4xEMXOKY/KAErRmsSGiQsE8uAsXT1
         niHgL3LZBe7VUFyQm+j/95rn/eme327LMUvHR2NRX8Rv1o0q+pyIrZZbMxwSHgZhtIhF
         PLxlaTjO7kPPmfn2yK+nNSQt1IKXOn9BI83lbTroUUQWSOkTQEo6SzXyJqMvQVdxqn6D
         ULJA==
X-Gm-Message-State: AOJu0Yxd2Eu+FE8pj/mnEDdcxPeOasPCwRzRBQrm5cLNKPnSJkoi+e6+
	Diw1IBkYyDQWeyCbfOPifx642ePqE6YqS1OjJ6ujZ0dC2IxX+9hJ
X-Gm-Gg: ASbGnctN+fqIbznLck2S5cBdkPbDdt5ODYPdYNokpsMl8KWXbJoPqpSwDOYjN3iMx0b
	nKZ6e+699za/Kv5peZbxCmQuAF8ojo7dAWjhfkEPkfjwKFs+hSeneinxE0WCcJimE8XlIVHljV/
	tjJjBcyiT1O/VBnZd7t0JdXmH15ObhfyrQ3tTMBJOkTSYcrUGKU7xfmIQdiD4ueEokgMsRvLmFB
	E9WQwyP5/ZhEc8OjlOYIv6KvRIwfbaO9OWTsVpDwvobEPnT5U6F6/rLKFRIp0yR6cfgCs6yr6E=
X-Google-Smtp-Source: AGHT+IEFarvmhcYVo3zkBINdXFJ7EvxB9j3nAf9SccDt0cP+UjoqPFfZxuIceRbrBhnrHX4XOpIUOQ==
X-Received: by 2002:a05:6a20:9145:b0:1e1:ad90:dda6 with SMTP id adf61e73a8af0-1eb2174da00mr36964419637.20.1737558726206;
        Wed, 22 Jan 2025 07:12:06 -0800 (PST)
Received: from [198.18.0.1] ([203.175.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48c2bsm11396109b3a.134.2025.01.22.07.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:12:05 -0800 (PST)
Message-ID: <78577c99-22b4-4598-8714-2a3884cc86c6@gmail.com>
Date: Wed, 22 Jan 2025 23:12:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
To: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
 Xuefeng Li <lixuefeng@loongson.cn>, Huacai Chen <chenhuacai@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250121114225.2727684-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Mingcong Bai <jeffbaichina@gmail.com>
In-Reply-To: <20250121114225.2727684-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Huacai,

在 2025/1/21 19:42, Huacai Chen 写道:
> The OHCI controller (rev 0x02) under LS7A PCI host has a hardware flaw.
> MMIO register with offset 0x60/0x64 is treated as legacy PS2-compatible
> keyboard/mouse interface, which confuse the OHCI controller. Since OHCI
> only use a 4KB BAR resource indeed, the LS7A OHCI controller's 32KB BAR
> is wrapped around (the second 4KB BAR space is the same as the first 4KB
> internally). So we can add an 4KB offset (0x1000) to the BAR resource as
> a workaround.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/pci/controller/pci-loongson.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> index bc630ab8a283..977f7b15f3a7 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -32,6 +32,7 @@
>   #define DEV_LS7A_CONF	0x7a10
>   #define DEV_LS7A_GNET	0x7a13
>   #define DEV_LS7A_EHCI	0x7a14
> +#define DEV_LS7A_OHCI	0x7a24
>   #define DEV_LS7A_DC2	0x7a36
>   #define DEV_LS7A_HDMI	0x7a37
>   
> @@ -144,6 +145,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>   			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
>   
> +static void loongson_ohci_quirk(struct pci_dev *dev)
> +{
> +	if (dev->revision == 0x2)
> +		dev->resource[0].start += 0x1000;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_OHCI, loongson_ohci_quirk);
> +
>   static void loongson_pci_pin_quirk(struct pci_dev *pdev)
>   {
>   	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);

I have tested this patch and can confirm that it fixes USB full-speed 
and low-speed devices (such as keyboards and mice) on ASUS XC-LS3A6M 
boards. The full-/low-speed devices only work consistently with this 
specific patch applied, or at least one of the two full-/low-speed 
devices would not work.

P.S., With more than one SuperSpeed devices plugged in, the issue 
reproduced more reliably, where at least one of the two full-/low-speed 
devices would not work. With three SuperSpeed devices plugged in, 
filling all five downstream facing ports at the back of the board along 
with the two full-/low-speed devices, the issue reproduced consistently.

Similar issues have also been reported by mini PC (NUC) users, but I do 
not own such a device.

Tested-by: Mingcong Bai <jeffbai@aosc.io>

Best Regards,
Mingcong Bai


