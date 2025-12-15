Return-Path: <linux-pci+bounces-43054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF451CBE4C4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C6CF30BB628
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41670314D2E;
	Mon, 15 Dec 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxJlDgRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B162F531F
	for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808177; cv=none; b=Lk/yAq2ZjQ18bQ3rlZhh8c5hTPhdVacPyPmlb6AMwKojHiXWTDX0B+prX6j9eVHdQirAaO3PT90ShKjRKCaJ28qCJsgXPAt+pgsiSg1OvVJqcJzPAh1ZNqHKdTzsenbDJRJXKB1woOcz8evT5CJstHhW79chzN1YJCKn5fzlwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808177; c=relaxed/simple;
	bh=i37Ne7uHL/y4kp6pZyX/ySd/DfSKUARKKWMR9IDTZkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLwW69HQS0zOlO1brAqR8k/7fkP/Za5Mqy1aArD/CI9KoUeKdLJlPa+Tx7UnKtFUV/MwzFv+HkXKtAWOByxiYrMC25PqDFXgOOOnVSZWXhUBH0GN7KFV2xAbKxXzIND9pcBQmXdJSTLScuuu/IG++kqpH/2dGd2yRmCtCTs3Qh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxJlDgRi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so3944829b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765808171; x=1766412971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqcyxQ6AG4Chn3aVf8oO4S4Fgo01WzKngrtkHDhk3Yw=;
        b=fxJlDgRiNAVqWADAbe3W8kbU5Qa68ZHGFh42sjC9ElCVd2IS9J151SPd1IUtfqEtIn
         S0Miw6eFBVJuHsH16Kfu5fAtrwotNBsXnMezqeciClOrR+c+3N7JL+0f0M+5idc209s6
         FNot2Q9Mq4JGeg8NrIHdkx/8RVV6tdFGHxct0A6d0dBXViaVnUB/Nn08eGTk5Og0qikZ
         Li5HTiRyf+ZoBT9oWytcy/iVuw+AA3xOq4/NJs7uJJaYO2x3WO49DZ31n5KliTFr1FE1
         P2jlTSiLLNPkBKMn8zma/GqXQfKrwHHiAxzA8ctVWKxG4vOyW+9oR7v3pEdiNm03TlUE
         cFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808171; x=1766412971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqcyxQ6AG4Chn3aVf8oO4S4Fgo01WzKngrtkHDhk3Yw=;
        b=gkchkjXBA/yioWTI8GiOhG5+yFRM4izXLtj0gbid/cWcCzSQSIHJK/ZmSuBItItdyI
         Eqq1B79xhCGicCscD8EAb7h/PU/lzJ/x7rKlkXhjChhzg30XtHU4yyLRLADJg7WBlkDL
         jlE3eCa3q34O+v2dM4ywrZki/Gwgl2pr8re8Km3ULr59H4vSWXm7yswJtt9zdYHszFRK
         vn06a3AZsQQgkvJAdllkcsz6YcqJOKRFoNk1hb21KivdznEEkQrnkMg30/e+Y7y8c1Yv
         BqeKRAwI04mbbCMgoU8TikWvF1qO2vPQEwGVamP6+koN4TPoWiJIzh6Qi0+olhJd9A5G
         H2hw==
X-Forwarded-Encrypted: i=1; AJvYcCVyhtqcC8GPo5Pp612OAhQ/NXTW+e7mFFUwEECia25VeoRW/H9ONQyV2FReTGgvvwSRsusSG9vTP/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8Ik0IyX/fzrwHOX79kq/Jwt1MX4i45yg+ttof6sOHvNAUxUP
	fMz6SM2H/qvx9tWvtR0GA4vnr5ypdKDDAX6Pz1hcuM2NgiauuQq8no3y
X-Gm-Gg: AY/fxX63RTZ/wUYKFnoRPe+BcxZlHTJezr4BXWzrOxWcrEYschlTEHQi70fpyeL7K/D
	D4OCJk9d1anAAM9rmw5GPQZSVerRXp6jK+JZ8oUewmaBwVFHauJyrdLcR6ZqiynJFLVMKKius91
	NvE+UUlHkxRqaAlwJWgIfBHbiZ+bButbmI0dPSOO5hbtYTeSRfOEMBQ69F22EtXAFzq6MJeEenV
	QBe3QcYCq+mcjRw2JIczpnS8n6QtZsQ8SuJJo9sI7H7yaZyXaJ3uoCAyy6mWKEERnQIeOsf/+nF
	UFQa6UWB4RT7cObzp648Yrav2RxJ4dMMSJAyCskSy+UiD1rfTX9eq5gXjk0THoK6/+iTbQprKX9
	yQ0sgge30qxJVNAgRG09rbDpRpNXVk3Bmf5X+WcpiPoiiLwV+ZCJyngUFqNad8szUhHCPw8xNTK
	ht0BXTYQ==
X-Google-Smtp-Source: AGHT+IHzU7O4bBwW+r0bzOaaR59QHp7R8Qe7T7RCV80z/qUtmi5w0XidJGu/xJXthigLDAzj67uUbA==
X-Received: by 2002:a05:6a21:3283:b0:341:5935:e212 with SMTP id adf61e73a8af0-369b4836e53mr11108196637.18.1765808171097;
        Mon, 15 Dec 2025 06:16:11 -0800 (PST)
Received: from rockpi-5b ([45.112.0.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2772a51sm12938189b3a.17.2025.12.15.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:16:10 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/4] PCI: tegra: A couple of cleanups
Date: Mon, 15 Dec 2025 19:45:33 +0530
Message-ID: <20251215141603.6749-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This small series provides two cleanup patches for the Tegra PCIe driver.
The overall goal is to replace custom, open-coded logic with standard
kernel helper functions.

These changes improve the driver's readability and maintainability by
everaging modern, well-tested APIs for clock management and register
polling.

v2: Fix the DT binding for nvidia,tegra-pcie.yaml
    switch back to devm_clk_bulk_get_all to get all the clocks
    improve the commit message.

v1 Added new devicetree binding nvidia,tegra-pcie.yaml file.
   Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() api.
   Fixed checkpatch warnings.

Tested on Jetson Nano 4 GB ram.

jetson-nano:~$ lspci -tvv
-[0000:00]-+-01.0-[01]----00.0  Intel Corporation Wireless 8265 / 8275
           \-02.0-[02]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller

v1:   https://lore.kernel.org/linux-tegra/20250926072905.126737-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/linux-tegra/20250831190055.7952-2-linux.amoon@gmail.com/

Thanks
-Anand

Anand Moon (4):
  dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
  PCI: tegra: Simplify clock handling by using clk_bulk*() functions
  PCI: tegra: Use readl_poll_timeout() for link status polling
  PCI: tegra: Use BIT() and GENMASK() macros for register definitions

 .../bindings/pci/nvidia,tegra-pcie.yaml       | 380 ++++++++++
 .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
 drivers/pci/controller/pci-tegra.c            | 237 +++----
 3 files changed, 471 insertions(+), 816 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.50.1


