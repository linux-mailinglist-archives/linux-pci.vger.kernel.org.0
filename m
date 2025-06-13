Return-Path: <linux-pci+bounces-29729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E33CAD9005
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071DE189170B
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2F42AE68;
	Fri, 13 Jun 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG+0yCcc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564F433A5;
	Fri, 13 Jun 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826130; cv=none; b=YGbH3PVmXDtR9JlJtdlm2tO/ePPc3F7nW8oGePIufyW9+lCy9meG7Dv0CR5TPUqL/RHbPZ3PtnVL286Zsg1NS24mZc7UMkIjlT3z+m+L0sK2sSoDi6cRcuNyPx7c/G3k6UKge6L0BgEDOYHDeF1sNq3lyr5qtL2KAWFL++bTiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826130; c=relaxed/simple;
	bh=2czsTqDFs2LayaWE3o+qV4gJyCKv1km6UVStrH9AcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmD0YXW83EcXKJhh2BGebDazrsT9tC2JXn9qCTDJHvWBz8bId47pa4lLWw04DdzXYcWy5vFMbsSNm4WC9JfrKWQ/UsccMZ0MFayl70F316f+1zkNQtXrxaWEjSCZXQeAyxxC6xKzdVSMlF0+etjhzVT0DM6/XlQQ7OHDSiWGYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG+0yCcc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74865da80c4so1434348b3a.3;
        Fri, 13 Jun 2025 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826128; x=1750430928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/L0PwwkoPnRzlL6fmDLU+JBmZkHn+VWrN87UcWrxlw=;
        b=dG+0yCcc5oEIcYI6BLpnqgglCrXYDfXPtdgUO43MLDwBywFnjegjhW1+CJXHSrROfI
         fV7CF31GUplMhIvgwROPWMILgJvS1fu43Ylgz/jVT2j3+tqx0SMsSMRy6JA5XQUhw4X7
         YWbUaQ8rRGwlSoZjRMXKJdH3l4nRBrkdL96YTYRRVmtTJVgQkX7YeroI1B3ybaJd/ygQ
         zhds70Y4/XYr15aiHXJS0T0xY17APaeDJENcXjlbNjNic1AlcpgPWNYLjIUquKFNux4F
         JqW8LswcrG9pbHaQ/bPE4kOEmrOfYBrsb2yHnwMjvynBLDLWKMlNyRKykkt8LHIeIGWt
         zo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826128; x=1750430928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/L0PwwkoPnRzlL6fmDLU+JBmZkHn+VWrN87UcWrxlw=;
        b=Qdj5kCCwBppMkaYE6vl9f9oD38/ejLwUt4Pqp9zHFgvHu6EiNK5sHELtaPQ8Pom26o
         S/U6W60W1zBTEjly1Fj8F6xz08mxqaRkZ3YkIvSgjf4C5hB6xWX6ZjPFs3I3l+0lQwZc
         R+FGk2W+csu6VsSdbyt3GiznB5IvjIU/Gn98dyYpgjcd/FnZGaKj6jFGxmtT0pucYWIC
         wHlsfdAW8Za7rPu3v+SIxwRPb8m65QIbyz/VGkpF2BYwfzTbgOZ0lubZBMaxtugMrH42
         sbQzQ0mXVZajkD17gy+FyguUDzWV2mSI03cCtaoivdfYP2foiFtbyKnF9EYrzRi/wxie
         lnnA==
X-Forwarded-Encrypted: i=1; AJvYcCWFBd7fyqY7sR1n/fY1pcORT51c1XbqZ5+Cl1ijsK10jQ1aHqtz0KJhyFagCmALXDI5MajmfXRv5Gx/Lyk=@vger.kernel.org, AJvYcCWw/Iplo6bQm4VKZh5TmsaoMV/pzLUgrYcXpZQRiyUglzrScQRiIlN8/BrTOxDIXftXnxUaWDbSu6NK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/aWcI2T6QwSj8hE0Ha69q5b3eCHtV1m9Unxr+OEFqYrAmm4B
	XerTmzIHQXLpF30udrDg+iZuLIfLVXKKhqcwN1kCd7UJ3bjjoD8sff9G
X-Gm-Gg: ASbGncvwmPJnDFqOl1GUMAkxKJ7XNrvX6XFtpONUMbJxpotLTDI2R9ocV40uIJAZzdf
	n/2CqdzpnTCW1Ffa6ShTCqI+YXSvF4TL5hkRRaYG5B9fST1ZBRbfYZRWxonLuKoKeQeU62ik8Fc
	+ErB4r6kMrrecN6Z+TMJFgOyb4NaCT93IoAVSytok74qGJTyq251/FVt+EmyVPmWuCizBvwPoHY
	lVG47/SKqq/nrkZb/nLcKZJlfEOFZlk/RUq9DFQZy/55bOZtWA9k3PfMLaRYWZfo/U1QoSoCz7h
	XGGzrb7PZ3zAt/6ennkdQNYnXEAzrqvqdQg34VfqLY5YB6/ucw==
X-Google-Smtp-Source: AGHT+IFt4GR3YMTXjNMLs0lezTaz7ETEn/eRAqWAd2cNJwooWka4aI3k3Y5G9iM40lPJlQBBHOCxFg==
X-Received: by 2002:a05:6a00:2d8e:b0:736:ab49:d56 with SMTP id d2e1a72fcca58-7488f6e49f9mr4575274b3a.1.1749826128253;
        Fri, 13 Jun 2025 07:48:48 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083034sm1728624b3a.98.2025.06.13.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:48:47 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:48:42 -0300
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
Subject: [RFC PATCH v4 1/4] PCI: rockchip: Drop unused custom registers and
 bitfields
Message-ID: <ed25d30f2761e963164efffcfbe35502feb3adc2.1749825317.git.geraldogabriel@gmail.com>
References: <cover.1749825317.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749825317.git.geraldogabriel@gmail.com>

Since we are now using standard PCIe defines, drop
unused custom-defined ones, which are now referenced
from offset at added Capabilities Register.

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


