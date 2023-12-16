Return-Path: <linux-pci+bounces-1092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009A6815BE1
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 22:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF4D1F23442
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1335290;
	Sat, 16 Dec 2023 21:32:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FA3527D;
	Sat, 16 Dec 2023 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so1584704b6e.2;
        Sat, 16 Dec 2023 13:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702762356; x=1703367156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psEzIYkM3EG4tzTREhQS7ZnmwXwyHVyspLnxM8V7TYs=;
        b=hCAKXXNqu7gXFmzGSodovS0Req0Bik7a6KOhQ+YXDAWGxp3MHqHogh9QMaQfiheXrd
         ohZETnuF+AWN+gCa6QNm1redTbpLTUKyhiFNuR/Ns6r6ZBF8bM8MMiHR4s9YpufdxmAR
         RKCJ4EQ/fP1MegnMV2gXwUht8VoRo4xeIxgB9X+WXNMSHmOBy4Y//MGS38JSaWBY/Y9C
         9rjvtLbrXT9x6ptUN5uQSQVouhd35Ul5d8oalwlR0ynT4d1qJ7tvy5J8HZGLNvAoLuRJ
         7J+vJ9bFc+oIgeYOV9HlWGmFWdZxqP61XIMjYo0/UkMXMxGQ7HHiSw3IhoAq2tkxDK+p
         ah0g==
X-Gm-Message-State: AOJu0Yzgj17hR+E0UJVcEavKXoKdIxf58H+bIKSzc7RFRL0WytOWuH11
	Fe0xbeIgUxs/QAUEs3IIk29EHFABucP36LKF
X-Google-Smtp-Source: AGHT+IGnVXoTT8NdzT5TI4uq5qxxn85/v5R+WwtgIWXvww5WjUjzKiRIlN5HIfeM5Bkx0hQ5gg3W1g==
X-Received: by 2002:a05:6808:3993:b0:3b9:f0f5:93e7 with SMTP id gq19-20020a056808399300b003b9f0f593e7mr25734106oib.17.1702762356496;
        Sat, 16 Dec 2023 13:32:36 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id e25-20020aa79819000000b006ce691a1419sm948196pfl.186.2023.12.16.13.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 13:32:36 -0800 (PST)
Date: Sun, 17 Dec 2023 06:32:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v7 RESEND 0/3] Add support for Xilinx XDMA Soft IP as
 Root Port.
Message-ID: <20231216213234.GC3302836@rocinante>
References: <20231003173453.938190-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003173453.938190-1-thippeswamy.havalige@amd.com>

Hello,

> This series of patch add support for Xilinx XDMA Soft IP as Root Port.
> 
> The Xilinx XDMA Soft IP support's 32 bit and 64bit BAR's.
> As Root Port it supports MSI and legacy interrupts.
> 
> For code reusability existing CPM4 error interrupt bits are moved to
> common header.

Applied to controller/xilinx-xdma, thank you!

[01/03] PCI: xilinx-cpm: Move IRQ definitions to a common header
        https://git.kernel.org/pci/pci/c/a977ee945e94
[02/03] dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx XDMA PCIe Root Port Bridge
        https://git.kernel.org/pci/pci/c/4ae1cd7d4be2
[03/03] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
        https://git.kernel.org/pci/pci/c/8d786149d78c

	Krzysztof

