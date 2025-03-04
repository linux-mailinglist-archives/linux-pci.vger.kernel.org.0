Return-Path: <linux-pci+bounces-22807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D9A4D498
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE317535F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE11F63FE;
	Tue,  4 Mar 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVM9GNoz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901BB156C40;
	Tue,  4 Mar 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072400; cv=none; b=rM87xUajsPI6uc/e5/yuldpdzC4rbNxBLA90SiSSvSiCxCWOhy6hCKqlnZrgqztjAwFP8J/IE+tbgg38Fe/HqmT7z1YSyu4s2TMICOyJTDZzvl+cvK1XbN/DD0xIxwEQBzuhmuxpYy34XZoNjcuAVFqo0HZ/4f9CorP5cP2l/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072400; c=relaxed/simple;
	bh=gpr/gu0uMIzZiWGXCBHbF3MX1vSus63CKXmYmCWxdq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Al8jgIrhKaU/mdSMQ1o0UaeBjd6TiqVEqfcAWlUJ5N+YG4WusMXrwQmhsZ0b551nr3m7qeCYmMbZvdHkautgr6Pw9RtpaSJe6G/yoL/ChyfT2rkHoG3pb0o2UK/wMwzWno1jJQxY4AxLKbeZteNEhgbWHYAWLNbNYSXMblfnSSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVM9GNoz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e6c082eac0so49858646d6.0;
        Mon, 03 Mar 2025 23:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741072397; x=1741677197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04t/KBfFwVvzecOXRhML0Qn2Gh7Rc4imVCzpNOWwyWQ=;
        b=eVM9GNozuhsP1SWu9W2qhe92EmfyTVfc5FVwrU9QIFwZb91ZMEfeDlsGq+zg2tYb6S
         wA+R00crRvbiaOrgPnM0e22dwmBAX9A8l/bs2myhDdjMm86BRg9hD6YUWPfLzZdbOPcU
         34qrW8yyaRdBu7jcmlmTCB7ACRz5tgvSnqXjuyEM0dBTtZujqooKekpkpqmKqSKGQe8X
         MfxpbIPoCnZzkqBGbyVQJV1Kvxq43K1jvF83FBjThiuO5zyr4vwPSqLxOVklZLlaIf/T
         aVjdA93qyTxMwwT5/MuarPSZqcfaNva3FbR1gpp+rEpov9zsAiKBuRykzPpcTBziNj74
         LKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741072397; x=1741677197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04t/KBfFwVvzecOXRhML0Qn2Gh7Rc4imVCzpNOWwyWQ=;
        b=mUsz4G+E+lRXEXEfxivEGiG5uklNkdVVNjM0FemMF4d6pv2r96ylFb7aKhV4oJx2sp
         FtkdQnOPWYda+h7LTo1oxKoZjwuqbywHyF/p8wijrQk/esvfxjv16PL8F1oeDmv3zGVY
         xhjIgXOXV5x2x7R/Zsl/ofobBBBW/o1gDPEEcJ0vh4HL2YSITGSDJ1yrBfjl1P8dnksm
         uVujI4TnCNPkKVb9n32nhHdPxQXONMv618AU13Fqe62+KBh63jR6Pcv2/wyRkJJB521S
         KtpmVVkm2DFkhIz+jus0zmU4xLzNqLCXcVrgBMB86OMi9ps4a83nzv7QScrVPh1HVKh2
         TgkA==
X-Forwarded-Encrypted: i=1; AJvYcCUWasEuR1etKD/QOunUMaCXyWs40LxB8xW57WhBB1Zvk98tLbDtlYOwarGqvKKkeCafxrY0zQ0yteBY@vger.kernel.org, AJvYcCUd6yM9IDQjNJRi6Os9IqCUQ3dzTSsAmvs6++Ws3IcbWehvlnGjhWQbJoYf/QLV/fSSoJYKoak4A+tYW6hP@vger.kernel.org
X-Gm-Message-State: AOJu0YwoeiD+NJig6a4tYuRnOSZ/7UahTgsrB+IxPYOSnDBJy++051TZ
	rkEQQ+a86nP2JAvDoxtJR96f/SKCdR7FSsWBygVsSR9txdsK4jt0
X-Gm-Gg: ASbGncvpAiLdl/7xrKjqy3drRewxV1KizVVyB0MIp0CoMNIuW2c2YPqGWj5UZBmer26
	ULtC9Xa2+5gDs1oCCyXVooQ6RadkuVdjEvC2ylCazG4PY1LNcatkPdFXHcCt6L8uetlCevcNQl3
	LVohqvSnCNcw+obxTEypWm1zlPeigpHrVnTh6MGvA12rnRmJ7J486s24C8v8aN7IvhhPBNvaCTW
	c4LVjCT1fB4f8AInfKjhVuP7mc0+LBevNyvBpFsFobIeM8e3dR/iC5E2HZELu+RH0QzCGevq44F
	xSbkjCe50ilhgZJv29NV
X-Google-Smtp-Source: AGHT+IEKObI0ybp4bSeJ6S2BRkKmZEZlFbaJV85NGpcqaQnfX+y+IKf1GVvL/+XToao/2dp4HCiEoQ==
X-Received: by 2002:a05:6214:2b0b:b0:6e6:5bec:13a0 with SMTP id 6a1803df08f44-6e8a0c9f140mr258457966d6.10.1741072397382;
        Mon, 03 Mar 2025 23:13:17 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a1f2csm69783811cf.13.2025.03.03.23.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:13:17 -0800 (PST)
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
	Johan Hovold <johan+linaro@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044 SoC
Date: Tue,  4 Mar 2025 15:12:36 +0800
Message-ID: <20250304071239.352486-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
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

[1] https://lore.kernel.org/all/20250303111648.1337543-1-inochiama@gmail.com

Changed from v1:
- https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.comq
1. patch 1: remove dma-coherent property
2. patch 2: remove unused reset
3. patch 2: fix Kconfig menu title and reorder the entry
4. patch 2: use FIELD_GET/FIELD_PREP to simplify the code.
5. patch 2: rename the irq handle function to match the irq_chip name

Inochi Amaoto (2):
  dt-bindings: pci: Add Sophgo SG2044 PCIe host
  PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver

 .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 ++++++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-dw-sophgo.c   | 270 ++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c

--
2.48.1


