Return-Path: <linux-pci+bounces-21948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD0A3EA30
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27631176C1D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720BD38F9C;
	Fri, 21 Feb 2025 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSt6CKYg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0C1876;
	Fri, 21 Feb 2025 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101898; cv=none; b=ga8hPZDZ1HF+2B4XR0mpFOvO9QGwd7AlsiXC297Cmoz22vDNMF+SwiV7hTit9VE5h37TTGQZaOfkU73TkMafdH/2HMcQeNtiVZElXgOo6Fpxahrt8EcCHpy/vLH1hk+ZoeBegofLNIc4ueR/5ggRtk9TL6j/1gru6Va7PoM0vBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101898; c=relaxed/simple;
	bh=Zln9SAxKxXkgQiUdBxJ6k+hH4AwAQ92Yze1/59N65gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxGR/jXtmLLDEuOZxyf88cbwUZ8WN9wdVQN+8qXtLnbzpmZsWd+ClIp5hEM8VInKjPsTc4TUPeZ96yuII40oJZPPQ5U8YWiVftUMC4yMCtkfwiZ6Hyx0yn1A18Pd1KXIhDdfaAqKjKR8vUv/zOIyUDYwR6dfPVQX5N6ZZGrhDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSt6CKYg; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso16572246d6.3;
        Thu, 20 Feb 2025 17:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740101895; x=1740706695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTSidftreS4QFmmprzmQTP0Ok8hTg1K/MceCazw94nA=;
        b=SSt6CKYgOhtktFTITBOysPMU4nmGbXALl+f81VGmYFFJhFs0IetJFCVZKyHSze+lZR
         IAf9a9U/RENsuNDPv5IcZHdQCl8aqzB40wREHiTB6jgamLXduhA8lj+cZ6yO3Iv0iK1c
         t7gLiBb/0N8+o0lMqutoi9EZxH61vpocOEBbJDpRQ+cY0l6DlP1fcVEUdyQLMRg4uDan
         BDW0IJ6NL7+YXiXAefhZMmtrfdjufeS6GpRhaAocDeejjkpJeNeDn+4vW3VRBvDS421h
         WqNUme7VIJtvvjeHZ9wiu66gqaZsLKEeZC9X0vhZ8Mp6BKDqTZh4n4iqHyAY1WSbCxad
         p/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740101895; x=1740706695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTSidftreS4QFmmprzmQTP0Ok8hTg1K/MceCazw94nA=;
        b=E8yWIbbl79HGGEO5zWGeXO/WWB0Q6z0F8BgyziSEsVRDyZi5JhX/6U0LlLkKv5XWxw
         yh/xu1C+hqw3AtMSJLTBBNpKkUkqYMUfIiZHPwPl4mnElksWWhd9VbAHzF3nEjxVifRR
         GxQqQXHdmWcEvz6lBtpxGUhLIt5zkipQ4rXoJrTHL58RALrOb04G+MU9jYuiUIdgW1Cf
         rk6aD7Q1IFBz/rd9V2ymIYhw3/6m+A610LRaDvHpwIzoMwMOJE1fiPwlPdMWn/S/4ygV
         F2V4Ai7mwtoLiyQtI+UB9bMbYkaw67KIqwba5ss6J+ZkRrh7w3FZfGZIFfcKopTHQT7c
         9LGg==
X-Forwarded-Encrypted: i=1; AJvYcCVE3wi3vnUlpxlX5GQF6U8dUwvC3dWG7banX8JwIit1vFU6Ux3RbVGPUv1GIO7cBUwdbxkBJ5w78/sY@vger.kernel.org, AJvYcCWwPnAWtAeIzdJVqYaBkX906vQ9xT8C0m6+sk93gqGpFlSRtYP7I5gOkayUOpTJFJem4mFkL2OxUH74/HAT@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxDjOGUasuvf0OAbpm1J2282NbAu5UPJBJPKm/Fgvx7jJybKW
	ACx87Tk+zwYg5c6yuG4uw6IIQi8XnRmCekNgGFbFWQzAFGkE+DWA
X-Gm-Gg: ASbGncuBzNJAzywhfObrdP0rPz+oBx7EB3ItZ62PCNwvYq06DSZ7kkHvrC4sAqTT83U
	0JKd7eGLTUO4ooNY1ERC6EnLezAlijbROOQnyNR6HwtA5H22jKkUAyhdnVWvTpK8ONAl7eAPyAY
	IC57OMbXUUDnCzXrK5LaQ8/2Kmu2IaJ05rLZPjSIQ+lmPAl6JKeJGaXJqiwXh9+4yIiMPZHRuks
	G92td/ZHD6Ic34nLp1WXuVKoo6fDsqDyyZ/cVkgsPAXnVYKf2sVTsF7Er9wfV67DazhQknOvb9h
	iw==
X-Google-Smtp-Source: AGHT+IHhua4oxHyol2HKv9TAxs1TEtTYZXq5TSxXKdjQrvU4ioWpfZxfRhn7MqQPrbNidkwG52d/Mg==
X-Received: by 2002:a05:6214:f27:b0:6e6:5ede:7d83 with SMTP id 6a1803df08f44-6e6ae82dc98mr20922326d6.25.1740101895447;
        Thu, 20 Feb 2025 17:38:15 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e65d785d12sm91995966d6.37.2025.02.20.17.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:38:14 -0800 (PST)
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044 SoC
Date: Fri, 21 Feb 2025 09:37:54 +0800
Message-ID: <20250221013758.370936-1-inochiama@gmail.com>
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

[1] https://lore.kernel.org/all/cover.1736921549.git.unicorn_wang@outlook.com/

Inochi Amaoto (2):
  dt-bindings: pci: Add Sophgo SG2044 PCIe host
  PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver

 .../bindings/pci/sophgo,sg2044-pcie.yaml      | 125 ++++++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-dw-sophgo.c   | 282 ++++++++++++++++++
 4 files changed, 418 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c

--
2.48.1


