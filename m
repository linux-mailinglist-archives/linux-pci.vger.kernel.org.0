Return-Path: <linux-pci+bounces-43712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E4CDDA24
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15AF8301510A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A888F2F3612;
	Thu, 25 Dec 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfvahGCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE43016F7
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657214; cv=none; b=t4Ziwxf7tdIPy9AybtXagfjmBjABQeFRveD6A0kPdBoycFOEWV6mxVVicHztIvAX3HHe57iSim2L/aYimq9KBK4BjTGJAQcqsJIb6rMvX5ZOKC8g25rZZgMD5BtcuiKd8VxtMN/QHB1b3VxEzq/bzfE1UBd1Er88iuIUkEkLSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657214; c=relaxed/simple;
	bh=F5gFdjqBDJfxc1khYe9bw6O9PWkpea7DfEZG1oezFXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsxLwrSd/S1jbLFDBhmTYeg0UhtUQhK2agJqEzkZ1zv8MzUAiFLgpq13uptDjvGmA1cIkU2TwIawDUR+KTeffWEzclsWgk9L7Ul1UNY2AhlgcVE7HzynbTOA5h9PbBNEeOBmjW+oklrwiKxRcyDCNY7ba8oghy/lNc4mbAWcMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfvahGCa; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11beb0a7bd6so10305339c88.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 02:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657210; x=1767262010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoWlifoRrGIbrYwrkHpjiDlU/FrNuM+x7k7ugYZXtEw=;
        b=JfvahGCan2dX+gJvnLSRAQ5qo84UK4mNqISSJM0Ho+2yO8gYLhQ1QBN2Lpbcd5Unvs
         A5ka0I5qkx2xxXF0/sW5lOD01mpIDbeMP6cA6l7DtnLal5WVhg9qUs3DNTEi+wZvMOy1
         NDNnMy8gIz4KLsJ+YFdTu6Kbk4YQVwZwfi45mFBfYHFeuikABxpThqgWU6xunnNchrcT
         1+L3UllouRS0MNOUlOJXSYbgsszhwvzCRXqbLF1Kg0E/x705TEALXLHeC1FVDEc1UH63
         fsRdyQuDWXXTqmTjZTI9uphZ1uMDIW70Kbgf7cRJ7Mq49r6MVcnmB3FuyLeqvBLX1MrQ
         c07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657210; x=1767262010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoWlifoRrGIbrYwrkHpjiDlU/FrNuM+x7k7ugYZXtEw=;
        b=rUICOvvuRR8mmp86FQoQNryBwa3GGV3wjZYKJ0WKSQsBQFy6XBQFGYc7kfW9hJrXI/
         87rbCHkn8QONk3gx42Pd/i4u07GJs+gHaVt+SmyPePAK1kiVAEW7jzocgJW+V30yJqGy
         WXbztXMs2TJzOl0/gafviLb/4QT312uk9/EvhYo/tGYjBFUj1dhi3G7nGXvNyZQ0udyY
         hfdzd1ytQWAliED2nKTp6PnislTUQmGH0Xv+SuDfO/uC2BNh6lveKpbRvn2CntywXvvN
         i46xDdNfDq7wgfBoyZvQU8G1uVmPVmZLIyloX86Fesg4cyXK/tZyDX7ibhdLs86hLpiO
         V/TQ==
X-Gm-Message-State: AOJu0YzuxYfhnBY5HacboH+0N5rtUI3K1aXAhYaRbgeR5xTsB7TDxZGv
	LMwmdn55olFPDOwmQ9jUrOnX9aJItynmB1Y8IbIIdWCqzXHkvVmwI1Zd
X-Gm-Gg: AY/fxX4oLoV4qz/ExRPOA8jsekvO98nKHOImt5E/+kFCxRX7qU2nYE8n98VqbHSSiTi
	U7McQVVVJI53bbFDJixtr7aF78Xgicn29dT+jK/G2EaviSzZ5MqmFsscerPAU9N3/7FdPOFK8S6
	5FekP2ohSmR0h6MXBhsXo0N3WbxWb+AE/okC3wvw3RmpJUB6/+rPBAiiUL8o54kjxQ3HaoLvHc3
	QgYkC63+frT+KiabZkLD0ahgTHyLLh3x2CntY59q55am+smbweKoiYv16k2s5TG1OxL5YnQ1YGD
	5kFL3zClgeoU1m/ZD0vbzBTDaXcEOfvKycbnkKQ34Kn2ldTCK54Zy0pObmlvvbjpyC6H18Ui34C
	yKgodvocBFRElj0/ngHCFXYisxiuVd/2xSY1ktHCLsTieAAuT0U4/AKshlVZ9p108xRloFMmhmR
	D+TfyPbCyEWw==
X-Google-Smtp-Source: AGHT+IFbsnhzrU2HWPMRmMa4EdnUFdxSrSsBDm9mIfEbSkhwERlZyQXQcunmeehaesCNYJS3yHd1mw==
X-Received: by 2002:a05:7022:b90:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-12061975750mr21668587c88.14.1766657209946;
        Thu, 25 Dec 2025 02:06:49 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm55195962eec.2.2025.12.25.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:06:49 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe Root Ports
Date: Thu, 25 Dec 2025 18:05:27 +0800
Message-ID: <20251225100530.1301625-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enable ASPM on all device tree
platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
and L1 capabilities without supporting it.

Override the L0s and L1 Support advertised in Link Capabilities by the
SG2042/SG2044 Root Ports so we don't try to enable those states.

Inochi Amaoto (2):
  PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
  PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports

 drivers/pci/quirks.c    | 2 ++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 4 insertions(+)

--
2.52.0


