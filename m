Return-Path: <linux-pci+bounces-33449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885C7B1BE5F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 03:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B525B169790
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531486337;
	Wed,  6 Aug 2025 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coSnqoJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13B130A73;
	Wed,  6 Aug 2025 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444215; cv=none; b=G5o9jZJdQn53k9ZFZqHNYNBzdE3JHBPb9DF/LvbZANDNj38X+bNW7Fl2rsDkBH6HfeITYzuUNG/nStCUhegFI0rNoQwPy4TXi5yA1WlZpHcG7SCDIA6BFUM1dhEpMO1oYepJr12K0tMGFq/86VlUgD9psANvFqqgZ/dKaVmpiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444215; c=relaxed/simple;
	bh=MGkLWaQpOd3q2DxpRRdhxK7J7qagFAdm5a7Xo/V2bJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHHn6SyTml3IJtQcPVTEea5MMr11DNsVS7kllugH54PNq0mP7dJO88EC1RhiZhTsFGT1XfYqq9PA3W3PIKv4VEst3xY6F7O5gP9pxXwY4cglFMWg9MmwoekKXGyXy6kHPd2CcMiVrpUWQ9okzOar6vC7zBXHNhpC2zj7YBmJdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coSnqoJS; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-af95525bac4so731359766b.0;
        Tue, 05 Aug 2025 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754444212; x=1755049012; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltkTJhVSvPYgOW3R/Jy3oXTODTSaDGZhQTqQ4qWXz80=;
        b=coSnqoJSc0IO0IZzR3306LxtNy3xd4m0kU3mnhzrrcu+LFS4FsejGL13BosSwDRXM9
         r8bWcHMxOlm/24zQaE1OOTD1uWmH4HBNq+brrVujAAF1Ul6vNsrbAOk0pID2lto/hDAR
         cJMInsUfZiGuZ8EBJRC7tZ4KdtFRlKF3uhtMAd7KL0NyINtgQw3te+c4+75hfluFrQAx
         wLpY3bsQNOJj7TAIf2asdviiwI1zkMUBfZb9VXENYXE/d1PgirlRIIpG+Q+SHCbx8TCS
         t2+rXXxiWI7Q0vB3N2ZbeAet7OT18geOmKJK+m4XBW/TbWWEQ/pGj69KBzs2WIMo9Sm1
         p9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754444212; x=1755049012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltkTJhVSvPYgOW3R/Jy3oXTODTSaDGZhQTqQ4qWXz80=;
        b=r2hu4M6Xe+MnSMbaeOdAavti9dHOKiHntBhdNnCTF2YxYYQTwkb26jGuG9uAihrhEb
         MC3t9KQt0aP3OnT2bttAhMG8Q48EMpzieUvt3LKmhwdAuUVbJzZlJGEnWYbu4CuLuPK9
         t/3r7Qcc4ZR3mbvUaAJvijLmC1oSH80NT7G6njapk6Zpk/2lNA88TdyPsVYixpqnlE9L
         eiJkdCsWQ3PrP6N7orfzfcmOoxctFymLlEhWI0ws/nOxVRrlWWEhgVecLzTzoiuQgbgX
         1Xr6LR18QFOJhJypklp6XNEaUuidceqOSmOf21WkRUBVqwqPbx/tIamwa1oVOT3HWhxp
         oJGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhQA4pPUBFrOYVwCu/KaQKIl/3ZjjM8Gkm00/1a9o8t750t9xLFNnK1FF4pop1214RXcoY98e+Xi6V@vger.kernel.org, AJvYcCWi0Y89cATM/CmEKIUaSlpTY4LumQ8xxTf+Xo49NLawJo0/SI8NvLm7B/iTiAxoarsyBCIwXgp00vqLepk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTs7aYlzQC3SJNLynpiUzxh21wtWy07Wnlzsuf9Dj8xDcbchi8
	k2h7vcnZHpk2T5uukDWbh1dE4//b7PJI4xfPr4up3Nfg39ccDqPgfOJD
X-Gm-Gg: ASbGnctcByDAyr7zhDG3IFboBemA5b2ByEKRYs/LDtDsmiHfDezfh4pEx9+ixUcoueV
	Vrlye+F+f7M9Ldw7ek/C1WlW+6d3u0XIvAJCflK02VcCWOAZUyMKlu67jpU/Of1NaSWoerm1x2M
	TGbiqLYNCSWf780gh0UxbkihoQbIELWThsmR/JTnqtYxsp0PUKGwlGJdznCQqAMx5kK2n8pWuk4
	0xaiNZQyijnrxKt1SfAZTi2EM7kbCtkxcCimujduwE9MX1qglM74YzX5FNDB9zg/u9eCyLbe7lz
	DGYKpeXt2BYG/ygFfTt7bWgarY5psZuDSepCpzjrRQtwJWEmoNSF7dYq3R1G0NROtOHLcLc950h
	sebzKldAoRHxmI86biyXOSG9HgbhJpD1bPtWqimYCukYMJ+SDlPaIAjdtnn5xdixYuF5oWin2Xw
	rZ2EJimIpWmnkNDRzb/0lHVachDRaruw==
X-Google-Smtp-Source: AGHT+IFhWsSPQsq1gaew4kpXRNBKgFOVkQZZ2feJKAWyifD30L5W/2e+in5JWyeX4D+35oz8GqKBgA==
X-Received: by 2002:a17:907:3c91:b0:ade:316e:bfc with SMTP id a640c23a62f3a-af992aab4f2mr51539766b.21.1754444211712;
        Tue, 05 Aug 2025 18:36:51 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-72-134-22.eu-central-1.compute.amazonaws.com. [3.72.134.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a38aasm1003623266b.37.2025.08.05.18.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:36:51 -0700 (PDT)
Message-ID: <ae57a3eb-3914-4d44-a9dc-690a649d90fb@gmail.com>
Date: Wed, 6 Aug 2025 09:36:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
To: Breno Leitao <leitao@debian.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <1e332191-e1b0-49e9-afa9-09e76779f72f@gmail.com>
 <kvh4pn3bemmrrxeeaydclvhsr6tnudc3hayr6up6oeuzfwzijx@f5corx6x3h6s>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <kvh4pn3bemmrrxeeaydclvhsr6tnudc3hayr6up6oeuzfwzijx@f5corx6x3h6s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/5/2025 11:18 PM, Breno Leitao wrote:
> On Tue, Aug 05, 2025 at 10:25:11PM +0800, Ethan Zhao wrote:
>>
>> Seems you are using arm64 platform default config item
>> arch/arm64/configs/defconfig:CONFIG_ACPI_APEI_PCIEAER=y
>> So the issue wouldn't be triggered on X86_64 with default config.
> 
> Not really, I am running on x86 hosts. There are the AER part of my
> .config.
> 
> 	# cat .config | grep AER
> 	CONFIG_ACPI_APEI_PCIEAER=y
> 	CONFIG_PCIEAER=y
> 	# CONFIG_PCIEAER_INJECT is not set
> 	CONFIG_PCIEAER_CXL=y
Okay, If so, I would suggest to check and validate the
struct aer_capability_regs *aer_regs before/in enqueue function
aer_recover_queue().

e.g.

static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
{
...
memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));

//validate the aer_info here

aer_recover_queue(pcie_err->device_id.segment
}

or

void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
		       int severity, struct aer_capability_regs *aer_regs)
{
//check and validate aer_regs first here

}

Would be better than dequeue side aer_recover_work_func() ?
BTW, the cause seems you are using a buggy BIOS.


Thanks,
Ethan


