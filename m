Return-Path: <linux-pci+bounces-29734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C45AD9032
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A76C1890BFA
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DDF7261F;
	Fri, 13 Jun 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6cVRsUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6D1917D6;
	Fri, 13 Jun 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826346; cv=none; b=X119OmNG+rV6noJVROHNFQ7JiU5425zqokScxyJfKIkSRiwbnglfRlLlEIsRVChLvKYKU+uO1jLXTPr03y82F44g2TqMneQrvR4eELQA3TwTrS3UfTNbdg6NaPyKRJVMRF/JT9t7Js9e9yHhPX/JEUks3YgJZgQCpjDMVIMWSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826346; c=relaxed/simple;
	bh=DzWuE22vL1YP8zSHbfP7Qpjs9nzrUqlrq34nmlb01RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re1UROrcOQqP9l2bnFoXZvnTiWdXJi6as4LF9+/hui/7A+ekWHm5809HuJENj84xGHFdxYSv6+2WKKH/1l3yXz5bCi9ZiS5nLEedKl4DtPPLJQIOgxy3nS9EOiQUnjttmi4+cj6c6Abjsd6Lb9+vRhf5kmRk9PdFMtu87mYRPVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6cVRsUb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2352e3db62cso20586305ad.2;
        Fri, 13 Jun 2025 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826344; x=1750431144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=U6cVRsUb3T27zROyiUpHtAwqBS7GzZ6hYP2i3QLbYvH0rrchcgMdUqQ9BsjcPDmRWq
         qyC+nzJyB6KAxY6y9oTCWYv0cclx6aK/zXHDrxIMWwureRxMWYK1VjK8xfuVxi9vFn/g
         1cXYtW8VlRPPO9eaoK+OuGf2Gubla4W1ANBPJoIhhJQcVGIT+orcOGqNTeT74Tv3w/zx
         cqiVISqpNQwgYGEyeVchQAEEj4U+mup0qtI8AofeLX8gt2GX21G8ChNavFBWZgN3ra2c
         +tppSqCJAcJij9FXImr5s4JA/I2HdDK56kKfoFnyRL8Qa/Gx23ptnP9fjLaVDxrvYENs
         QAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826344; x=1750431144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uBBexglmDg860eeLxvF6Ft+pxKPH1DbiU+A4sUq4Hk=;
        b=lBWDE4f0w+76LPFAOdb5puf+11IKgEccHnrpQ6fPo4I6pgD4vpIRQ0Ri5GPbvBKb1X
         dRGNhgxCLiMa9uNlS5QsVkbz4B6B4AvlalMMaHKIFz2S7v0qA4DPMedcrF0BN8Uqa2kU
         V/j9lCqofw++0UyVtOTePhFl7MOZnAT5zypfJ2JSiZfET+3ElmytIo3WAv21UmN4m7hL
         84JYFfblwJGgOZM6rOCpipXj521a5irezNQ3UuDHHhvLDdtFCTU6ylxsLsmWbBZAX+WS
         CPD7N0AN7P5nRfcZlWYK8YOMkgrH4u2QTzz1hfxYgpHcvIs/hm45n1YxnaLHrVAKqakY
         uSSg==
X-Forwarded-Encrypted: i=1; AJvYcCVGyvqEsKvkIhdeRBv9h0qNio90nZH4VYj5CNCiih3GpZWyeIXqTYaHXXKlfIFkRrQQMy37d/pM43fy@vger.kernel.org, AJvYcCWiMImPElUWgT5sHSt5q19MMPYV9IUi6z0eho4pa5MMHs8ge6kjyiGI6lz62l+g6TOKfjOKQZTA9SWRF2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2Na1nQ+NX7hSE2+93WHJYLSgY+WVrcVEkBVgsPvYipbjnfHx
	I4eAXhK1+qczKKXL2WXFXg5w7+bKuw3Hgcpgp34MIflz6f6cTo6/f36D
X-Gm-Gg: ASbGncutJxIaa1ICbbeqMcndBZLHrsHr4MEaxggdPI+ykz88fPrrfmO72ELfGsD0FjS
	TIJHazfbavfO/AsSjNROXhVV98dq51fSLJkIyfDZyedQwRdTrZ7QKjUriKnlJ2Bzj93hY+VlEOj
	eATDvmisrxnPOAJFhtPcnbZdKLVgt2LRV8FLeNtQM8VsSpeZGsxp24kJx/MW+iyg7hn+vT7trQM
	skXiVKTTpSaw4D2p5OA07fskO227/XsbnP1obQJ4QNs2tIpBtcibkZxIQ+noxn98zWpmR11XnKR
	CiPW2TbNCgdWric+S6YQhf1XNRSzLTtQbPCE7nnYIFP2a4zNUg==
X-Google-Smtp-Source: AGHT+IFQeye4Ii3UTFFbxfeoPbcctur87XD4ln6xuqpdoBOQEc7zFFMytQsOpO1QCns9uvG3EBfxYg==
X-Received: by 2002:a17:903:320b:b0:235:779:ede5 with SMTP id d9443c01a7336-2365dc2fc73mr52226365ad.40.1749826343841;
        Fri, 13 Jun 2025 07:52:23 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7827bsm15095945ad.108.2025.06.13.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:52:23 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:52:17 -0300
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
Subject: [RFC PATCH v4 5/5] phy: rockchip-pcie: Adjust read mask and write
Message-ID: <b32c8e4e0e36c03ae72bff13926d8bdd9131c838.1749826250.git.geraldogabriel@gmail.com>
References: <cover.1749826250.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749826250.git.geraldogabriel@gmail.com>

Section 17.6.10 of the RK3399 TRM "PCIe PIPE PHY registers Description"
defines asynchronous strobe TEST_WRITE which should be enabled then
disabled and seems to have been copy-pasted as of current. Adjust it.
While at it, adjust read mask which should be the same as write mask.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 48bcc7d2b33b..35d2523ee776 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -30,9 +30,9 @@
 #define PHY_CFG_ADDR_SHIFT    1
 #define PHY_CFG_DATA_MASK     0xf
 #define PHY_CFG_ADDR_MASK     0x3f
-#define PHY_CFG_RD_MASK       0x3ff
+#define PHY_CFG_RD_MASK       0x3f
 #define PHY_CFG_WR_ENABLE     1
-#define PHY_CFG_WR_DISABLE    1
+#define PHY_CFG_WR_DISABLE    0
 #define PHY_CFG_WR_SHIFT      0
 #define PHY_CFG_WR_MASK       1
 #define PHY_CFG_PLL_LOCK      0x10
-- 
2.49.0


