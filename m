Return-Path: <linux-pci+bounces-7608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8038C8568
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B453EB228B7
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550A3CF73;
	Fri, 17 May 2024 11:16:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F2200DD;
	Fri, 17 May 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944589; cv=none; b=DfpgwX2HImP0/8cxbkVyACAHnpZgQAvvH8r1scJlVHwN47Xzy8cwMQ7XyijHp3R/+RqrvGBKrac3TkwZ9Yvrk/zMHAQ87bY/1guNwRuhwrKetu+MMEy10OBKPB3u1DcCkZcwqGvR6I756tUXuTGeSRsTP9xTs2ydvdsXtrvK4fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944589; c=relaxed/simple;
	bh=Bwcvy+tZDpC7QhFTc5GwI0fG+TmjgI7aqkD9mKBpbIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIEmBMIcqkmZrYRX7kjzYamnYaikPC7YFaFvne3yntPExXhwhgm4lrVXw5E3qppd1nnf/2m+PA4QAvFeQvtrScfys5WQASYXPaQ9Wouxar2tYok269H5YVjC8u0dowc+Cbx0sJZKWxEdqJGFqQKwwdnlXIFfXfJW4v7xOtTZNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed0abbf706so4789205ad.2;
        Fri, 17 May 2024 04:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944588; x=1716549388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM5/EWorMlMeij6RhB6j/f4ZuioOE/OA53wAKnmrl34=;
        b=qIGg2wMpS14m2bOpEEifz4dCh/ZTX3OPHPqmM80vMguSjHAwxEBDwen4gRWiBTPNiV
         jewL4xWK3E/z6a1CfROqlx17Kgl6mmT2bYnU1MylhRHvI2cjRg8cVyFAc8vmH2USM6+R
         pQbXs1oaij9I2yZ53vfmrISubKVCzNNCnlt0U6uTpxYlVTemOHx0iTGP8Gn18MRZHm/P
         YQAXGzC4I/8PyaPBxFu/srsa8fR0g8LnXHToVmfFwbWF6N8qBXKlfiso+mo4QMfJjx5Q
         vpWyzN1hCO02swHkyE/d3tJxR26RL92aomotMSf23G3DjMYGm1xJNaBWourfAIwmyQNi
         53UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4dD0Reljb9wB4P509fklfWugo6pDmknzocjs3+xlkOLj7jQot3U1BBpeUg2fsFeDWiolIxehuLH1zc50ezbjXFcz6VXbHlb3wVdj4LLhNtjCkH6uLLTvhcxDQRpJG5nWDBPHRGK+7ZR6PeRYVuG2F7LRAsQSSEWx80kOlLrP/fsS5EQ==
X-Gm-Message-State: AOJu0Yw8AmKTZEbkZD6EiElP/QNv4rB0RyNMbgIsZ5YhXN/3A7olYyWT
	am6ySXqh1IZDDE/bBgJY6qUcbIPfugYaBTkihfDz7IZdyBLHZVTQ
X-Google-Smtp-Source: AGHT+IE/H8dabmSgLuU/yv52WzguCq/CXaLL9ZLastuGGvuASE6dILZc3r3z312dhBfjhGMP+ogM0g==
X-Received: by 2002:a05:6a00:4fcb:b0:6ed:4a97:5dec with SMTP id d2e1a72fcca58-6f4e02981demr26839016b3a.20.1715944588012;
        Fri, 17 May 2024 04:16:28 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm14463913b3a.169.2024.05.17.04.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:16:27 -0700 (PDT)
Date: Fri, 17 May 2024 20:16:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v16 00/22] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <20240517111626.GP202520@rocinante>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>

Hello,

> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.
> 
> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.

Applied to controller/microchip, thank you!

[01/21] dt-bindings: PCI: Add PLDA XpressRICH PCIe host common properties
        https://git.kernel.org/pci/pci/c/0ce827c82eea
[02/21] dt-bindings: PCI: Add StarFive JH7110 PCIe controller
        https://git.kernel.org/pci/pci/c/91b4524c9135
[03/21] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
        https://git.kernel.org/pci/pci/c/4b83a1379e8c
[04/21] PCI: microchip: Move pcie-microchip-host.c to PLDA directory
        https://git.kernel.org/pci/pci/c/ced442bf0124
[05/21] PCI: microchip: Move PLDA IP register macros to pcie-plda.h
        https://git.kernel.org/pci/pci/c/571f57cc281c
[06/21] PCI: microchip: Add bridge_addr field to struct mc_pcie
        https://git.kernel.org/pci/pci/c/73c9dcd35dd8
[07/21] PCI: microchip: Rename two PCIe data structures
        https://git.kernel.org/pci/pci/c/e92d66e0aa1e
[08/08] PCI: microchip: Move PCIe host data structures to plda-pcie.h
        https://git.kernel.org/pci/pci/c/79c0d7d53a51
[09/21] PCI: microchip: Rename two setup functions
        https://git.kernel.org/pci/pci/c/082bda75f7b0
[10/21] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
        https://git.kernel.org/pci/pci/c/9251a0b72188
[11/21] PCI: microchip: Move setup functions to pcie-plda-host.c
        https://git.kernel.org/pci/pci/c/047cc7da3a25
[12/21] PCI: microchip: Rename interrupt related functions
        https://git.kernel.org/pci/pci/c/ddac0618211f
[13/21] PCI: microchip: Add num_events field to struct plda_pcie_rp
        https://git.kernel.org/pci/pci/c/cb90f7f6145b
[14/21] PCI: microchip: Add request_event_irq() callback function
        https://git.kernel.org/pci/pci/c/0ffbe1c70551
[15/21] PCI: microchip: Add INTx and MSI event num to struct plda_event
        https://git.kernel.org/pci/pci/c/9932c5d45e5a
[16/21] PCI: microchip: Add get_events() callback and add PLDA get_event()
        https://git.kernel.org/pci/pci/c/170407afbcc4
[17/21] PCI: microchip: Add event irqchip field to host port and add PLDA irqchip
        https://git.kernel.org/pci/pci/c/5e33af45dbcb
[18/21] PCI: microchip: Move IRQ functions to pcie-plda-host.c
        https://git.kernel.org/pci/pci/c/4e47aaf7afed
[19/21] PCI: plda: Add event bitmap field to struct plda_pcie_rp
        https://git.kernel.org/pci/pci/c/008d2bc41e3c
[20/21] PCI: plda: Add host init/deinit and map bus functions
        https://git.kernel.org/pci/pci/c/d86b148a401c
[21/21] PCI: starfive: Add JH7110 PCIe controller
        https://git.kernel.org/pci/pci/c/e6e7b974e425

	Krzysztof

