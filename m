Return-Path: <linux-pci+bounces-9424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668B91C8E2
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 00:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B387628141C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 22:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D387F7F5;
	Fri, 28 Jun 2024 22:00:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8778C93;
	Fri, 28 Jun 2024 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612018; cv=none; b=PaSi1jshpn0reDls6A4rfk8oBPYhJZlWWVTwgsAqYgi4WrXKt0KBnn+b4TSq3jyI9KvMHyFNEpTUEvLS7aXmMHahJFqnsq3CdcBRy8+0Au+CaAnozdFFtNg9W7a5349JDi3+F9+mxyiT3xaJjhsWUxieV57SLiJDedwzJnxtJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612018; c=relaxed/simple;
	bh=kvDbU/XezxoBQjp8rwunXhYbw8UYN4B5gt0JlVvCgbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTtnU/0AQ/hmjaRa6FOQ2gOQ46wSIuRD0ig5rl7BlqxZjK/jQlXGrJsLzMUrrDmtQHqeAnHmccoM5iB/sogZfNOmsQ6k+TIKR4RILegkMf0SY8XQPBAHvssNu9Fsogy8R8Nh2HnHlXVzDLrhpnZNvbY74feQi787jJP7FoH2FQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3760121ad45so4829135ab.0;
        Fri, 28 Jun 2024 15:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719612016; x=1720216816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBbQvvIs93uOLOxrTo3qyREYhoURV2aSzjNHb1QtPU8=;
        b=HikfdgZT++oKmuDj4bszFL4UXHKjzE+mMAHi3Xw2I0vqAFp2bxEbse+6NQFfIKD/9/
         fzCMjs9PngE4mFQ50887V9miVhfNWlmlWlz6JIXPG73LEVTIKZPP0qtse7ccIG04SxrN
         G+IaNG7cO9yBYhW6bHbpPJe1FTfCxXACGjkfPhsQClIk2LN/tXv+TLA1o45Iifyzs5X5
         CUxAP5rYDhEftBvNZC6UEOA4B6LZPDxJ2wwm7yVT6721MPLyGnqHeSQlNShvSKxUrJmV
         LlzBq2wT17BZ+HSZKrl6W/Lpl/rpI71PQxzhV+wRbviP7eP8RSg4e3MPPHbSsX5LdMvu
         Ja2w==
X-Forwarded-Encrypted: i=1; AJvYcCX1zdFq16y1K9ZdK96ijxsiCxOqHuQg/K7JDilFVNdc2miVd5xFVb/URlYjzpm+DEMqXPDPsndeQ2vDUEDiljwUfQEpY09b4xdzUitap8ha9GjJih3mgnKOa3r/cCtDP2oJpOhd+3Pz
X-Gm-Message-State: AOJu0YynHBOjlehq761NEKQolWxjrZWyPHUKcnnFWmNIfmBycOQ/NtQb
	U/9W4Ard0GkeVeUsAbx1MSI/bjJsAgtMwtroGP8GGuoCNyG0gY5u
X-Google-Smtp-Source: AGHT+IGuVife5e0U+apbMMf5rMQPQs3djtc0+T9PHHfiJv1oUGeHcgAKL+hqfxGqYx2iJONVEzCpsQ==
X-Received: by 2002:a05:6e02:138e:b0:375:a0ba:c125 with SMTP id e9e14a558f8ab-3763e06699dmr222604175ab.31.1719612016455;
        Fri, 28 Jun 2024 15:00:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804989460sm2107199b3a.191.2024.06.28.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:00:15 -0700 (PDT)
Date: Sat, 29 Jun 2024 07:00:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5] PCI: keystone: Add workaround for Errata #i2037
 (AM65x SR 1.0)
Message-ID: <20240628220014.GB2213719@rocinante>
References: <16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16e1fcae-1ea7-46be-b157-096e05661b15@siemens.com>

Hello,

> Errata #i2037 in AM65x/DRA80xM Processors Silicon Revision 1.0
> (SPRZ452D_July 2018_Revised December 2019 [1]) mentions when an
> inbound PCIe TLP spans more than two internal AXI 128-byte bursts,
> the bus may corrupt the packet payload and the corrupt data may
> cause associated applications or the processor to hang.
> 
> The workaround for Errata #i2037 is to limit the maximum read
> request size and maximum payload size to 128 bytes. Add workaround
> for Errata #i2037 here. The errata and workaround is applicable
> only to AM65x SR 1.0 and later versions of the silicon will have
> this fixed.
> 
> [1] -> https://www.ti.com/lit/er/sprz452i/sprz452i.pdf

Applied to controller/keystone, thank you!

[1/1] PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
      https://git.kernel.org/pci/pci/c/86f271f22bbb

	Krzysztof

