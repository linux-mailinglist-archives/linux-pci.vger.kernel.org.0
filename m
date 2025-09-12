Return-Path: <linux-pci+bounces-36031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E685BB550AD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4531B23D3A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F6B3126C0;
	Fri, 12 Sep 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCyUUw19"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDB31194E
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686485; cv=none; b=N77QYbt0+jSrlvagR9IvNMmOLP13oG9bnJROobX1ngFnaNOoc7/3tLbF3UT/EuGYjeyMCn3v3I4LFfb8lp/dA0zmuFY3DQx4cmAoZ8RbpU+sFYKECUSllae9YT8o7UuhIg+vwPLMU/TkTrmo70OFY+hjUZdOFUx6NACPHD2z+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686485; c=relaxed/simple;
	bh=QfTTg3lYzgE3ckVIJYbSn344G42n/OvAp/3LqxlyLEc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM6odGP2jWh/OTqMo8lTwpysOHhuhJeqbg5JwavG6mrfbgX+N+Bhr8sbx52PxsJ1B9IKRYNFPJhXHzkdh4MmB93SRu8mqkACdrtKZ/KjzldIQaLO6y6Oz0tjFVVGmk/hhIzRO5vEvd4Xo1Pl5tnzxJ0V5aUzT80ohAZDJ8AtgVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OCyUUw19; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so14327505e9.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 07:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686482; x=1758291282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/35+lplNa9c1ue8CwS2qpyGIoojlgVm98TES9qQ+QY=;
        b=OCyUUw19o29h0CcbQqzDlEPjszFVSKVT7JrFFv3rQP68lSBWQQcOuOur3j2NT29G/o
         BqpGjZk99wM2K+oiwkLy3E2tbVyVY3kf0CdkXWp08hpCNw2cCqMTt1Xv1VzZBmksc4t4
         EeFudqwurS/NAC/+R3HgpAd0XoDHXgY5oHbKZtWDbYxsCrw5xY5Nd4i6Vq79ZfXMMQl4
         ZL8zhMgfxKHDjQ1uffaYNm3BfuMnKFdjUqn6ZGIFK3n7ocOPkjX6IpYPOBo8ivOCk0E+
         UYQVORUsX2x74ydFisPFu5It2l/RgFBefk33J4X5ZT1AXqiu42wFumyNGG1m9ThVWTmm
         nweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686482; x=1758291282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/35+lplNa9c1ue8CwS2qpyGIoojlgVm98TES9qQ+QY=;
        b=ZUIsc5schtH7qidbP86QM2EpK4JoRrqWHirt9uquPsUySnsW3v4iZdYn1kSOjVuW0S
         T0j1yEi1hxzquTeK7GiV21ldCQkSf+qoY0kz5zKMypXConBZIjhqdzLUXBFDFdvSQ3F0
         YVw0S7grnmdU2a6ghDbmb4ByCRanPtPGiwNhaYhNERJBPbvuOEwUTa/6NDl7UJk4WVce
         mbwD7O3WZkLHdmQGZGytUsBng9cZmuEftImTcXMg60F3e2AL+wYs+2s4ZZb7L+tNOzuA
         dj22h/l62JQdmXzNd4D7uKB2v+51DfaI5UzGrfWIAbgsYUPp1GjNmd7uVS2l6H11Yg7s
         ww2A==
X-Forwarded-Encrypted: i=1; AJvYcCWcWk98mo1LrQo1OaR0V/d5A4goKmYkWYTuGjcop1njyZF7lD+CGWfrlD+1kOcAHhCzelBU8s2ixAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKglHrJnc+jFmnyK5OuqVsToPLhq/ybnOB3ehxH0iNxZSaWayw
	iU0AGehvO5gf1GvjJXsiGb345t7EDHKQJ9S+fHrtWkmCp8vNmQtfFggxxV0llBQxFs0=
X-Gm-Gg: ASbGncu/j1ZhXtQrAzlS3dPXi3dcxLIl+rKTdV7BNQg7/KPj1oVEPMtI8qTi2IkSbYo
	ID3qUr1pW8NyGm1FOg6sjhytVt4z5vW7bx7ytso0Cr7vsgX6eGth9Wl7GZjNDIbI/WnFCyL4/U3
	UCSzGR7xBBglonTA8QtUV1jN9MkwOLTj/tV51cXxsBD3xw1AgYEiQIcx2hbN86fIJtUylEu6Ky3
	zdQSuSkOe3o2VULUjT4JE1BMIvL6tdik+KaJ2Eh8vgyyCC0JwLAUs+Ik3jKqvJoSxqRpol2VMAm
	a4TdzvQwWTA6ydnF0ItonVWQvrmgPKry774e4gYypZfqML2cLBmILld8KhwDqQMfq4oyo8vyib+
	xDJlEXHMAd1gu/SA3W5kTYpCNKUAB9ME=
X-Google-Smtp-Source: AGHT+IG/qv8/NZ7DiR8l/8DhDwWeY9yHV3BseVNp2K73nhxvNF2iyswkFzMn3ukA0/vaEuJChx4aSQ==
X-Received: by 2002:a05:6000:2210:b0:3c7:308e:4dff with SMTP id ffacd0b85a97d-3e765a3e492mr2942700f8f.57.1757686481952;
        Fri, 12 Sep 2025 07:14:41 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:40ce:250c:1a13:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6680739f8f.30.2025.09.12.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:39 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pcie: s32g: Add Phy clock definition
Date: Fri, 12 Sep 2025 16:14:34 +0200
Message-ID: <20250912141436.2347852-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912141436.2347852-1-vincent.guittot@linaro.org>
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ciprian Costea <ciprianmarian.costea@nxp.com>

Define the list of Clock mode supported by PCIe

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/pcie/nxp-s32g-pcie-phy-submode.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 include/linux/pcie/nxp-s32g-pcie-phy-submode.h

diff --git a/include/linux/pcie/nxp-s32g-pcie-phy-submode.h b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
new file mode 100644
index 000000000000..2b96b5fd68c0
--- /dev/null
+++ b/include/linux/pcie/nxp-s32g-pcie-phy-submode.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * Copyright 2021, 2025 NXP
+ */
+#ifndef NXP_S32G_PCIE_PHY_SUBMODE_H
+#define NXP_S32G_PCIE_PHY_SUBMODE_H
+
+enum pcie_phy_mode {
+	CRNS = 0, /* Common Reference Clock, No Spread Spectrum */
+	CRSS = 1, /* Common Reference Clock, Spread Spectrum */
+	SRNS = 2, /* Separate Reference Clock, No Spread Spectrum */
+	SRIS = 3  /* Separate Reference Clock, Independent Spread Spectrum */
+};
+
+#endif
-- 
2.43.0


