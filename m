Return-Path: <linux-pci+bounces-27113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E9AA836F
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 02:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159BB189C774
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B187DDC1;
	Sun,  4 May 2025 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2n0MLYn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09DC2EF;
	Sun,  4 May 2025 00:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746319485; cv=none; b=oLpUUjiTryLrd3aRFremCS7T4ly82U01lMzdFGgTzr5RGwiKWV9anjpiUQFkU0/wGoMfqgC1xETlJ4Dd2pGweYSVW1zKTGSVdH37vvRd9gYGKjeaC59/gwZS/P/8c/YyWD3tlIe5MRg6EU8qmshx2NgeW4bmnfuy5m67JDJT66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746319485; c=relaxed/simple;
	bh=qEVm2sg8MGW9YD9CRvOyiYXTGUY5l70qN8vg4+ORMPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ou+B9GTkcGtRJ8ruw3KSwidu0PB7tmBdTQiaAorgP43fWdJj/nxIOY/5TPj1/j9g29uKM9CcMDajDDvLRMlbViKCJDlzVBAokD5/4167QFs0oFtGbTAaOR2ajkAOgB+XdyW/Set/l/z/M7awQ5KFjRK8s4hfxsk9dOTowtpsRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2n0MLYn; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so42213146d6.1;
        Sat, 03 May 2025 17:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746319483; x=1746924283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBTdU5/DczpzT7bxTMClec5iVTOpUIHz+Uhri46H47k=;
        b=h2n0MLYnOZtQjnQ+CtZ0fPVPmyWwmhgFPIU7G1k/UGGBeaJ+Xhood7MK2xlsHvoXFr
         cBNEPJfF7OgMk7s0GdNkOj93/VokmsJwn2Xpo8oVw+h8URoI6W/LOMMe/2ANXAxJgisz
         UQBmHs/CwmHGwTe5nALf9UUAC/dHmFLYuNXW0PIdHRHCtmT1ssfPoSnnNftNwjl3gLOk
         s8r98NnbafqZ/btOdZ97XdN0d4/yGtLPbd0DqhCj1Q3v8U5SyGRHxgkgXyUvtytlw0FM
         mNJIhd05rLosuSdjPbCTbhpEa3RHP6OwQSTFhfcXuqTzrJ9Y7Sg64GdiKaJjFUT8ZfvU
         TQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746319483; x=1746924283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBTdU5/DczpzT7bxTMClec5iVTOpUIHz+Uhri46H47k=;
        b=LV69KXxTe37e1S4QIbU1bVZqZqPYLfPsyAl85wPQIJ5P7i+R/K3xXZV3lk6/U2+2Rp
         +tyUXPng/cFGXjdy2pRl21e3g/BaiaKpIPQYugBY1FZMymmYUfHMI2qlRDmS5YhqVy7p
         q1sU/UDa1PFuRuqDBG8L7TyQms4qESPoua9w6+AdsMwXHYQjh/oqU33yjeyzKTEpRMbI
         foemGPpa5phvxxHQi5BsxhyRF44xuvcDyyYhBhqY4D6InzkGPo+7tccdr8C20euoIbad
         ThXLBKmv/zJHxUhB8MVWwfn4l0BsX07rcsMgri/LXQthaTsM31T9Ve9ycai+a6s8+oK0
         qGMg==
X-Forwarded-Encrypted: i=1; AJvYcCVU6nS8Ef/tJ+8YoW5wAQoFiso9HfYXhDs6MKAUha/zL+8F1tZe1B/QK2YFea86Mr/pu5Cj/sdW4qx+@vger.kernel.org, AJvYcCWAVud/V7KLso9whtA7xiBpfB0qrbZl4QoFrIPbGwN5R0p+/miYNSa0QIW5rMQavuWwEVhnG6ycKSgegRlY@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNy+fdTXqrpesbHDzGpJoqkyBd9BXTiaZqH6v+3f6uAIjPNTO
	sIaIu9q8FkeC251vOjqZDItt7B64Szk2trAChy3J9JFKyCvgQD/G
X-Gm-Gg: ASbGncvJ2xP42G3diR/zDma3tP6k9kYtdHeMleeo6brrvn0pAkT9/io5FcH37U1Gp7f
	g71Q2/yqn0DS8cYTqacewoudbrQZX4LHmkWK4F3nfPAYSO3qxBZdmDW7Y27qbuX7L5yBMiOHa/k
	Po5qlicgMTScYbAdAwHZ9bqbhIAUV+ENTTovhSAr+4PInu7E18ebm/Z7WCs4UZE/IFakQK1RuMv
	a/oJYUVlOgCuek/vVvWig8qeSvirGXU6xNFo9LA8LBcTNwysPRKlJwIYVE+TdFldzdLvu4upDBN
	27eDKQe9tH78faCL
X-Google-Smtp-Source: AGHT+IEDwbk2Ni1OGcnEfuTByVJGsVIbn0PVA4xwx3Q1aAWNwQLEX82DH4thMivs0ayFz/by16ai8Q==
X-Received: by 2002:a05:6214:20e6:b0:6f5:dad:5a60 with SMTP id 6a1803df08f44-6f515264f21mr128971706d6.3.1746319482732;
        Sat, 03 May 2025 17:44:42 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f50f3b05efsm38597456d6.23.2025.05.03.17.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 17:44:42 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Niklas Cassel <cassel@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Shradha Todi <shradha.t@samsung.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044 SoC
Date: Sun,  4 May 2025 08:44:17 +0800
Message-ID: <20250504004420.202685-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sophgo's SG2044 SoC uses Synopsys Designware PCIe core
to implement RC mode.

For legacy interrupt, the PCIe controller on SG2044 implement
its own legacy interrupt controller. For MSI/MSI-X, it use an
external interrupt controller to handle.

The external MSI interrupt controller patch can be found on [1].
As SG2044 needs a mirror change to support the way to send MSI
message and different irq number.

[1] https://lore.kernel.org/all/20250413224922.69719-1-inochiama@gmail.com

Changed from v2:
- https://lore.kernel.org/all/20250304071239.352486-1-inochiama@gmail.com
1. patch 1: remove "|+" for description
2. patch 1: apply Rob's tag
3. patch 2: remove empty irq_eoi and use handle_level_irq as the right
	    irq handle function.

Changed from v1:
- https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.com
1. patch 1: remove dma-coherent property
2. patch 2: remove unused reset
3. patch 2: fix Kconfig menu title and reorder the entry
4. patch 2: use FIELD_GET/FIELD_PREP to simplify the code.
5. patch 2: rename the irq handle function to match the irq_chip name

Inochi Amaoto (2):
  dt-bindings: pci: Add Sophgo SG2044 PCIe host
  PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver

 .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 +++++++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-dw-sophgo.c   | 258 ++++++++++++++++++
 4 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c

--
2.49.0


