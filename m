Return-Path: <linux-pci+bounces-29640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DEAD8270
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 07:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496BA1788B8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 05:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6B248F6F;
	Fri, 13 Jun 2025 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOjFMEUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF450221DB9;
	Fri, 13 Jun 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792088; cv=none; b=StqGJKHQMIcs6/xBL0ky/F44msJitrnJybBMR6SDOsvf/MeHjp76BbB9ViFu7/NsM/iRjXIR4EhG/wpvDxKdZGqEsM1n45ujhqOMSRHYXnQuOJpHaUS3xgDa7OhdUMcjW5OMwgOhyT+lgPItJhwdKC6rmUCX8LYZieh0euE6Ayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792088; c=relaxed/simple;
	bh=4DsutjXKNanek1L2BjQ/Mv7W1Ve6LpFMz0UGGyAguLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiljGRu4LrIRAbqN9tfm6QgKcm3Vu84+n+vBrtgRmpccKHcCQZYvAM5TH746iAUL9sib2XGr2q3MMILYMrk7iXhqgU0zJD8hRPYIJTMr33vxqj3+FnPPsRbYBNh3+DKD3zo2E5a+wG7IEk9eHi/UU3faal9Cc1nvDZGISlMoA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOjFMEUr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23508d30142so20691735ad.0;
        Thu, 12 Jun 2025 22:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749792086; x=1750396886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghfIMyhHNTv4pVd6MkPzn/cUBxofhg4t0WQr6qoTSzk=;
        b=fOjFMEUrvlnmiB56tvshzrZolqyLX10SOAgNEMtMvesTYN6Sc1G3eKE9nh9RyFcF5n
         qtnb1khErqIGMpN/LM0sjw/VU7Kuh/OAsJJoz2r3lzMyEE2rJTSOBvINf7hchEKCEIpy
         ygie4luM5s2YyFmxuV7VJ0jewSu9kLdSsxVID/clmeAJvAmzv0y3JYd9ii1XaCuoO/nh
         OpL4b/BnPlQrqTDDH5/9djxeQRYLaYtXMjYOxUyk4O5EK+MOA54adq6vgk91+rOu9GS+
         DJY4oZ3NCzNPDWTJzznQdDale3oeBVfLAcPr8rgAUSUI+8RThEusDygg919kJlssxeuM
         DdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749792086; x=1750396886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghfIMyhHNTv4pVd6MkPzn/cUBxofhg4t0WQr6qoTSzk=;
        b=fDe68d2gTgaXDHZtazVKiRXv/AHShzA1t3pqChaljZyUNXBtDz1jcfQDyIkeALoHZn
         XaSz62Ig/wth3xZpwNbBqAgM3y/fFQ8vgARQwaMBIzGI5YVgB3elzAVtnWka/KX+3tSP
         j67ymZ02hGhgZ5rPIg+uZe5qv1OeKFpr0u8tX/j9PbQiOu5IFXP6IOYHp1Z7CxpTIh+x
         Mpiup93ba/jwmdh2J1+X2UmMVN+Jz7VuHu9a/NTFT8X1B6grI2q3tnhtcipDLMkBBBjY
         MM9mOiAs81Jk6vufpcANrHXrsKSVUXiQ6axM8I0HqEtj04n0kfI76cz6fyCm7Xo+12C4
         ngCw==
X-Forwarded-Encrypted: i=1; AJvYcCV51Bg5/AiZMh0sRrnwDrIAqkrYHIY/wGg4h/L8ZsKM+H8+xmjwnzFq3dYt91qxMpW862J8Yci1jiI6@vger.kernel.org, AJvYcCXG0338gXdvCkDE3hVkhcHxYsS3AeUjjeo2fN6f8SPeS8129sS8BrpzgZ4q+EU1p+b35pLhkQ4J1xbXdlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz04zI/rvxsywA26mA4uGAqz92YodHsFadCOBySTQSEc5bWJf2k
	bn7I62QELRiCaRCWygH6fzlx+7UOeUxHNkVOU7IO1R7QmfUO8WpTzfy9
X-Gm-Gg: ASbGnctsh7elxLvca/CpL5uCaNToI5W3zGZl3UldKZibuUhpMY4qxC7CYprPWJ3MJEZ
	43/9qLGwr84A5iczp1Z83nymEfTZtRLNHUeFymzZCctoBQNyKZlBrwBpcxbyP4vNlkJ2jBuQ1ZA
	smDRUZTCGivH/IsBx4Wnkiq2HCVcA6sZYgt3REfMvRqqBw31r4XH60kTDpUbnmXDKAKNYy9qcQh
	gN/Wu5pcOJnJFOqHeHu3XzndI2TtyMHZon/NEbj85AcPzPLYp+3LBYDcKpFK07W7cgD9ntXDG4W
	L2C2tm+QEey0HnB+CvYmzBBW1sFTduFOQASB5GLJf14tUxGpvQ==
X-Google-Smtp-Source: AGHT+IGAB/OwhhPFQFM3I9gr3ZwX7mrBBqSd5Qamv9Oz4tI/DHuOdn1auxIzxZx5T6regSbZXfV4jQ==
X-Received: by 2002:a17:902:d4ce:b0:235:e942:cb9c with SMTP id d9443c01a7336-2365d88a17fmr25921145ad.5.1749792085991;
        Thu, 12 Jun 2025 22:21:25 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7667::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1fafsm6391965ad.70.2025.06.12.22.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:21:25 -0700 (PDT)
Date: Fri, 13 Jun 2025 02:21:19 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/5] PCI: rockchip: Drop unused custom registers and
 bitfields
Message-ID: <0754ef2677ebcf2803f5e31301e617b3422895de.1749791474.git.geraldogabriel@gmail.com>
References: <cover.1749791474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749791474.git.geraldogabriel@gmail.com>

Since we are now using standard PCIe defines, drop
unused custom-defined ones and instead reference
them by offset from Capabilities Register.

Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 5864a20323f2..f611599988d7 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -155,16 +155,7 @@
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
-#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
-#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
-#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
-#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
-#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
-#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
-#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
-#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
-#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
 #define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
-- 
2.49.0


