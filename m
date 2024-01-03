Return-Path: <linux-pci+bounces-1637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A39823847
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 23:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846FBB214C3
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 22:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE531D684;
	Wed,  3 Jan 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uBh9XVvW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C91DA2A
	for <linux-pci@vger.kernel.org>; Wed,  3 Jan 2024 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ed1ca402so84046895ad.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Jan 2024 14:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704321638; x=1704926438; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0h7PgAKHLBBL550JFcFthbjqC6UsTh1CLzAgFeU19vM=;
        b=uBh9XVvWyWYQQ09JmpqVoNebkFNQVyb0SUYGJ9TnEaX1jjIOMkginNazGqL3lQ7flU
         9jjrclrMyBT3QPzgwLkdM6sw8wPvpOsN4A+PHp2rD0KXAROlsX6VPqmDR8fpD+RDju6L
         nxW687QdxgEaBWnmZ23bcaA7nmfHskBJ0TxDCJerRLgY/VzXLWWYQEy6lDPzjB2Q2aes
         aBGlPQTnUHjarPvf2IzbnLvAFl6PLwTlErs+KkKOCCZEKDbXURvAfB6jo2Bgf9DmwVR5
         0OXCNJ/9yoGUeVdZqn3iJnJPMrFq+REu8n+fBrt1yeUmeYeA0N3F2Me/KUEEPN+VyO5N
         Hf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321638; x=1704926438;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0h7PgAKHLBBL550JFcFthbjqC6UsTh1CLzAgFeU19vM=;
        b=QRYFBH5Lzapl6CtFLHkvpUhOvTi8sGFY2GDuoKEYe4T9b/clX3W9/xQbHoWkrmOzdN
         UyzPyCnnLNZ0vS/bjUaJqHQ+JXJmuCS9QOKMsbCkOJq4PA5enJ40CeLP5Wr6nX7i5vW6
         ZcRN2WiAeIcYt+2gMBfy5G0B0B15tBX16MYE7ylu+dR3bzAnKa7fv7vHIAveDw6G8PUt
         RhG9BIipVb0SmVOLfci44pQA/PnhpUQDbfaVmkKzrr0cyK7A5Mq5LcPFp8G7fA5aHxNB
         Cor5AE/X+icjwNWjZcp8RXrvPq1tqsWYjY30NZY+zH5G88tGngt7F+hSjOPUHNNpgtE7
         bKIQ==
X-Gm-Message-State: AOJu0Yyqkb0uGm9lkknqTV8J4XR3VFBUmsSatZQ7FHed6DEGwRfBdVbR
	/Wkm+8yZ72iJAcWkL6ZRiIZJmRGesIVghQ==
X-Google-Smtp-Source: AGHT+IGZCHN9Av1WNlNPUdB6KQ1jk2qnXWzZ7w5vQl8+w8WwvKce7rZQQlWFz/cP/YGLrakvB1D3SA==
X-Received: by 2002:a17:902:d50b:b0:1d4:32d8:ea78 with SMTP id b11-20020a170902d50b00b001d432d8ea78mr22084129plg.79.1704321638123;
        Wed, 03 Jan 2024 14:40:38 -0800 (PST)
Received: from localhost (75-172-121-199.tukw.qwest.net. [75.172.121.199])
        by smtp.gmail.com with ESMTPSA id u17-20020a170903125100b001cfa0c04553sm24071484plh.116.2024.01.03.14.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:40:37 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Minda Chen <minda.chen@starfivetech.com>, Conor Dooley
 <conor@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring
 <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Daire
 McNamara <daire.mcnamara@microchip.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
 <mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
 Kevin Xie <kevin.xie@starfivetech.com>, Minda Chen
 <minda.chen@starfivetech.com>
Subject: Re: [PATCH v13 0/21] Refactoring Microchip PCIe driver and add
 StarFive PCIe
In-Reply-To: <20231214072839.2367-1-minda.chen@starfivetech.com>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
Date: Wed, 03 Jan 2024 14:40:36 -0800
Message-ID: <7hfrzeavmj.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Minda Chen <minda.chen@starfivetech.com> writes:

> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.

Thank you for this series.

I tested this on a VisionFive v2 board, and it seems to probe and find my
M.2 NVMe SSD, but then gets timeouts when trying to use the NVMe
(e.g. 'blkid' command)

Kernel logs below.

Kevin

[   15.131094] pcie-starfive 9c0000000.pcie: host bridge /soc/pcie@9c0000000 ranges:
[   15.138637] pcie-starfive 9c0000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
[   15.147180] pcie-starfive 9c0000000.pcie:      MEM 0x0980000000..0x09bfffffff -> 0x0980000000
[   15.368040] pcie-starfive 9c0000000.pcie: port link up
[   15.374219] pcie-starfive 9c0000000.pcie: PCI host bridge to bus 0001:00
[   15.380944] pci_bus 0001:00: root bus resource [bus 00-ff]
[   15.386443] pci_bus 0001:00: root bus resource [mem 0x38000000-0x3fffffff]
[   15.393330] pci_bus 0001:00: root bus resource [mem 0x980000000-0x9bfffffff pref]
[   15.400882] pci 0001:00:00.0: [1556:1111] type 01 class 0x060400
[   15.407165] pci 0001:00:00.0: supports D1 D2
[   15.411447] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   15.419964] pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[   15.428245] pci 0001:01:00.0: [126f:2263] type 00 class 0x010802
[   15.434331] pci 0001:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[   15.441578] pci 0001:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0001:00:00.0 (capable of 31.504 Gb/s with 8
.0 GT/s PCIe x4 link)
[   15.456910] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[   15.463553] pci 0001:00:00.0: BAR 8: assigned [mem 0x38000000-0x380fffff]
[   15.470352] pci 0001:01:00.0: BAR 0: assigned [mem 0x38000000-0x38003fff 64bit]
[   15.477699] pci 0001:00:00.0: PCI bridge to [bus 01]
[   15.482686] pci 0001:00:00.0:   bridge window [mem 0x38000000-0x380fffff]
[   15.489632] pcieport 0001:00:00.0: enabling device (0000 -> 0002)
[   15.496038] pcieport 0001:00:00.0: PME: Signaling with IRQ 56
[   15.502472] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[   15.509755] usb usb2-port2: over-current condition
[   15.515883] nvme nvme0: pci function 0001:01:00.0
[   15.520615] nvme 0001:01:00.0: enabling device (0000 -> 0002)
[   15.532685] nvme nvme0: allocated 64 MiB host memory buffer.
[   15.550070] nvme nvme0: 4/0/0 default/read/poll queues
[   15.562992] nvme nvme0: Ignoring bogus Namespace Identifiers
[   15.663327] hub 1-1:1.0: USB hub found
[   15.667320] hub 1-1:1.0: 4 ports detected

[   46.064052] nvme nvme0: I/O 424 QID 3 timeout, completion polled

[   76.784046] nvme nvme0: I/O 425 (I/O Cmd) QID 3 timeout, aborting
[   76.790179] nvme nvme0: I/O 426 (I/O Cmd) QID 3 timeout, aborting
[   76.796294] nvme nvme0: I/O 427 (I/O Cmd) QID 3 timeout, aborting
[   76.802411] nvme nvme0: I/O 428 (I/O Cmd) QID 3 timeout, aborting
[   76.808525] nvme nvme0: I/O 429 (I/O Cmd) QID 3 timeout, aborting


