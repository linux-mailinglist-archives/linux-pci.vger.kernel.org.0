Return-Path: <linux-pci+bounces-26546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD86A98CA7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3193B44CF
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019F1A2387;
	Wed, 23 Apr 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6CeChcg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8D15575C;
	Wed, 23 Apr 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417963; cv=none; b=Ff570s5tu9xmV/0Ucm63j833cnqGYdieD5gsn21C4/16e93GfoFc5qyD2wkImDqqXacC42wNnxV+t/Eoqsp7YsQp6IMiiCjM8dpSaB9/ekcJt8M9pMpgh72bBZYMs/uJKi+njVTzae6iT/CIBGWUubyeawhSNZY3AV/DAYVOk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417963; c=relaxed/simple;
	bh=a3QuU/5M1g+2fdWE9+BThS9HdAQLNNLFa8gLlgzAxpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XtBzrwn4bOZBzqGIKYwSFX02K3Kt0r9qsc7KsYBB4lO/uMrIAPm8FYAgF7mXb0qgFUltrpA63rRLvjS8Fp0/2b1iA8Qccr1YtGLJ51KoUV5efTPoYcqLY9tV53sFSlQe+PHq7Y2aH2xeKkGblwVeRdPQKAfKRME5MG+rRS06P80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6CeChcg; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso63799205e9.1;
        Wed, 23 Apr 2025 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745417960; x=1746022760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BC2k5eQglcx0fx1dsDzep368jwlMehiurszSSCQbWeE=;
        b=i6CeChcga3okk7XYQK6FSsK+zqu+5AQ1n4DxHyaWGpfcKoP7TMrCUk66vvq13FCtSi
         6LDXY1kf8pp5b+wc1e579iZzcyjlOsh1pKK8GZ5aYa9Zag39rgJIKrsnNx/hgfR7iwkc
         5b7UNma451OURsVjZgxiLmr/DEsXratgPNzWjuzM/xIkENBxdBmsRCREiBj0+bS2XPn7
         DvhVBNRXH93kSQ5RgsIzGu7ztqOsptbpcJ6c0E1fjGncVF2p8Qu1iIEaLT82V8onA82y
         DSieKMMvpDiI0kZRwXhmlZQdEPYSNkuJDRx9tpNZ2Vf15CZaYjI0lDR7Hf2m4iseGmje
         acyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745417960; x=1746022760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BC2k5eQglcx0fx1dsDzep368jwlMehiurszSSCQbWeE=;
        b=iQPLLND/dBaBp+tq/9wOg8X83FBmzGqMTFK7uS/h0gAvam6gowbuzdpr9LAoUa7kjW
         0ppzrWPQkYvdI8gPAeTednPF/QRBcNgFz1r1M0e2VIM4LCFNJ31il7ToH4I4IRz/C91t
         nd6Xf67C8A8H+7Oate4dbhfb2hjPntEiDgD579yezQN6kgKlvg5lyqoIkVQANObSKRPD
         Zr1zycutVF/M4/CYN43kqvfhkgtMty0exStXZiQeqlh6pCdVQJErLJ+idIUhzQ33OaWV
         0FrYDlWXP22xp+n6VaKKjlaibvEohXkUCHaLbieNnHHertfofhWj3M4jEp8Wu9ATN7a0
         zdLA==
X-Forwarded-Encrypted: i=1; AJvYcCVV+DS4tWFjzs2UVfs7ITOZ9l6GAcs2eetRtpOAqIo1YebIAS2kqUyG4h45A/9jDrnlx8ZYycc2vk3y@vger.kernel.org, AJvYcCWozwA8tMEctsrF43CQ+vDzoHanjmOomRIjy3QawXkDZjL4fSGv/S4ULKKMwibdlpSVCRZkJC2cfCML6Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6GomtO35gZymtubAAmNjhEd0VgNlSgDDtmqnOngswTZqGcKz
	FSECatfeYY/ldf3kySz2F+PHxNUdIqlodnnlF36L5abjxuoe+ydj
X-Gm-Gg: ASbGncudwfTpsuLY71tnh/wzdvgm2/ojia41mDLwcxn8/yWgjGWhrLy0C/KYQlBrrg5
	inkAX55tAS/PEUnysPL3ZODoccVCCqpWzd+PPsI9oJYLXwrwIdyIJdJH9P4VPxphkW5NZNZVyBi
	NoHtyGpwMYzYwRQ54pTO2/bSKyxCGv+TAWUGTbSWBavadECd0x754cvjzvuLFUwLIxBV7eigSAD
	dq9xULGtmbBzqaN5Db04udpXMDdxHBgC3K/Fb4uBOb3wpupcsj/Vjx4Kh8V99AnBgViQxU4JZFB
	UU8rW5FAAO9hJEKsx09yMlF7W/j+fi7UV6ssIR5QKOB5KE3RiAy34W2bUKaA7mIDzjiQNry4DUB
	wJxexd8FSw/lzSKs57qPy+w27g+raCMjb9U4f1yMAyyaSTqDi
X-Google-Smtp-Source: AGHT+IEQEla6uy7DVJVg+zOPOZf5zyoJStwY2Be9b+4OI0Pna2znCZx1xFa/uFU/v2hwQVxZh58K4Q==
X-Received: by 2002:a05:600c:1c8e:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-4406ab6c278mr187494845e9.2.1745417960075;
        Wed, 23 Apr 2025 07:19:20 -0700 (PDT)
Received: from [26.26.26.1] (ec2-3-64-116-27.eu-central-1.compute.amazonaws.com. [3.64.116.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d369f1sm27473715e9.29.2025.04.23.07.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:19:19 -0700 (PDT)
Message-ID: <72dc3881-2056-48b6-a710-f497d614dd53@gmail.com>
Date: Wed, 23 Apr 2025 22:19:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IRQ domain logging?
To: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250422210705.GA382841@bhelgaas>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250422210705.GA382841@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/23/2025 5:07 AM, Bjorn Helgaas wrote:
> Hi Thomas,
> 
> IRQ domains and IRQs are critical infrastructure, but we don't really
> log anything when we discover controllers or set them up.  Do you
> think there would be any value in exposing some of this structure in
> dmesg to help people (like me!) understand how these are connected to
> devices and drivers?
> 
> For example, in a simple qemu system:
> 
>    IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
>    ACPI: Using IOAPIC for interrupt routing
>    ACPI: PCI: Interrupt link LNKA configured for IRQ 10
>    ACPI: PCI: Interrupt link GSIA configured for IRQ 16
>    hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>    ACPI: \_SB_.GSIA: Enabled at IRQ 16
>    pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
>    00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>    ata1: SATA max UDMA/133 abar m4096@0xfeadb000 port 0xfeadb100 irq 28 lpm-pol 0
> 
> I think these are all wired interrupts, and maybe IRQ==GSI (?), and I
> think the ACPI link devices are configurable connections between an
> INTx and the IOAPIC, but it's kind of hard to connect them all
> together.
> 
> This from an arm64 system is even more obscure to me:
> 
>    NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>    GICv3: 256 SPIs implemented
>    Root IRQ handler: gic_handle_irq
>    GICv3: GICv3 features: 16 PPIs
>    kvm [1]: vgic interrupt IRQ18
>    xhci-hcd xhci-hcd.0.auto: irq 67, io mem 0xfe800000
> 
> I have no clue where irq 67 goes.
> 
> Maybe there's no useful way to log anything here, I dunno; it just
> occurred to me when looking at Jiri's series to reduce the number of
> irqdomain interfaces.  PCI controller drivers do a lot of interrupt
> domain setup, and if that were more visible/concrete in dmesg, I think
> I might understand it better. 
The current visibility into interrupt routing in systems is fragmented, 
making it challenging to observe the routing behavior of specific 
interrupts or interrupt types. For enthusiasts exploring system 
internals, having a ​traceroute-like tool to map interrupt handling 
paths would significantly enhance transparency and debugging capabilities.

e.g. How an MSI is routed and remapped between different domains on x86

MSI pci-dev-->ioapic-->iommu-->apic-->cpu

But so far it seems there is no enough info from KABI(/proc /sysfs 
syscall, dmesg etc) to compose a complete chain like that ?

Thanks,
Ethan
> 
> Bjorn
> 


