Return-Path: <linux-pci+bounces-9245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABD916D98
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 17:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CADC21C209F9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481D169AE4;
	Tue, 25 Jun 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKkXy95T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB39152780;
	Tue, 25 Jun 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331115; cv=none; b=Qf69dgC8M1bS5s5p7OxzwgaFEb6EVTOhz8midYI9fP8N36vhCsc1bawW1gj08oZiaKHFNBrSFMbhzBKos0K+tTARi1HXb6S+xC80z5aHfvbkyR2k1CzTXpqxAUFWTCAibBFiwqa7nqcABFVVFHVV1gYgkQiHgLLxHKQU+Chq+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331115; c=relaxed/simple;
	bh=/Bfji0yHOA8njxxCTUdrMJ4uJI5atTxWVOiBNvZN/NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O1GrBx8E5m4ns9i1xlO5JrZdzkOgsIKDWG6g+KxtIHELm1Be5Wk99eK0Zel4VUVdL17oYGQ6Xgc9UQsOJp/pDC7YbwgiC/EEtiBOLnzD8PeSuqwmGqlcv5GFf3uOHOKot5C6QfgIxAhnrEVJj2uP8jZJZD6l5jPE7axei6a9fjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKkXy95T; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7066c799382so3133713b3a.3;
        Tue, 25 Jun 2024 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719331112; x=1719935912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yH1SDsCg1psfY+W0H6ncXncvNAWFOnKRkrHx7IAe3WE=;
        b=ZKkXy95TxD4F3tbE9jpulLS0VNPxOzrh18ixMZVmphv0YZ7fSA8YR89Ubnes2QFPqT
         QQVnX8ClEYYX6/F7jf0YYdTdEx0SdfmzBvVekpwAohcMcjGsEkzoNQDT+nZDHCyyhY35
         GIEexUCy51E1TVP4PTU3WWifWOIIFVOixTpWvW3Cx0bhchguFMcN1IF7Tssd43LRxiX1
         1cN5lSCPzQw1CX2ixyDXBeuS5G6Uxeu53wcl1YuRECLd8ehtS5DA+24xQePsygvnYfFd
         dxEtlJbIq4cXjDKo57ZARSNjk/JIMYeR2kf7g8xoXlIrejL86i+vgWKiAICQczIrAbO1
         NwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331112; x=1719935912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH1SDsCg1psfY+W0H6ncXncvNAWFOnKRkrHx7IAe3WE=;
        b=rIdJhhcB6uK40eyM4aA3Xjcot0p2uzdUxvCv5sqwCWmEO+NGnRP8yfPGv+FLgh1TsO
         zHKxzuqQBE9JhEbRkyy0BXt7Ansnm6uI1K1tv8Z+9znP7D35wQEUyMupI3z43iyS50lA
         kXUluOmPVw9By/6E7spu1ZSixmF3zNYiyBkd6rv+04w2PRr9PQvBCAZOW0nYd/eE4B2I
         ozu9DNIz9J0kMgORR/fOj//2F296K2Y+ephEpopdcpUbPrWOgBm2Oy4ynKxbpVH1982H
         voSgFMuGD+9bs4TZVN7wCn6h7RE5WJTjsqDN0hasLZ11rIy8kA5HBxV6ypOmD82GGgLb
         +Gaw==
X-Forwarded-Encrypted: i=1; AJvYcCUxACcXQGmODbS+qRc/I7E59P9JslrPLmgGO9I2gfG/TyEB+yhlB5VQz8HkckPgUYXfqOXi13et2FQ27PZj45LaHajjD1t2M3YVnuAylk+C6cfeWeVQxF3AoGK+UPetJZE+hkOwaREj
X-Gm-Message-State: AOJu0YzMYYXhmkvM2xW3+t2OVNI4+thCqghrv4ttnD6rEymUF7q3k8/C
	SxghYAYdMZKonGcgepqfL3wBsrrZnmrRMnVrVhjKQ6WRpAlRG8mU
X-Google-Smtp-Source: AGHT+IFY92BQm2/8LPYgNao0SuWV2SSZWQnXK45U4AdqDwkENeC0I4zcWtMLWiakpYKl/XZktO4vlw==
X-Received: by 2002:a05:6a21:2712:b0:1b4:6f79:e146 with SMTP id adf61e73a8af0-1bcf7e7ee7cmr7827640637.17.1719331112239;
        Tue, 25 Jun 2024 08:58:32 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dbb963sm8872368a91.41.2024.06.25.08.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 08:58:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linu-next v1] PCI: dw-rockchip: Enable async probe by default
Date: Tue, 25 Jun 2024 21:27:57 +0530
Message-ID: <20240625155759.132878-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip PCIe driver lets waits for the combo PHY link like PCIe 3.0,
PCIe 2.0 and SATA 3.0 controller to be up during the probe this
consumes several milliseconds during boot.

Establishing a PCIe link can take a while; allow asynchronous probing so
that link establishment can happen in the background while other devices
are being probed.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 61b1acba7182..74a3e9d172a0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -367,6 +367,7 @@ static struct platform_driver rockchip_pcie_driver = {
 		.name	= "rockchip-dw-pcie",
 		.of_match_table = rockchip_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = rockchip_pcie_probe,
 };
-- 
2.44.0


