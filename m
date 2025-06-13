Return-Path: <linux-pci+bounces-29742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE5AD90BF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2003B9181
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6461DF751;
	Fri, 13 Jun 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyTCATR1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0369444;
	Fri, 13 Jun 2025 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749827153; cv=none; b=YAt5xDsifBKXQqQJNrOOfdhnJMJexDvLBpDSNGoXHiWznCMCr41oG8b6aMQtaEkdEII9wRxD6QsE8LZGWL4m0rZ2Jwu2GbEdpV2IO4NSUWMyVzf/SXlHJcCXkZraHnycog9hQWSgYBYKKGEF5u/eW2k/mHRXpiojbP2qj+hmw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749827153; c=relaxed/simple;
	bh=2czsTqDFs2LayaWE3o+qV4gJyCKv1km6UVStrH9AcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVuXDV4HBGxqg8kEpvvlF5e4sKeuA7IBBVa4pCX0A1IWyl2nEQqFbJJ/B6mjwoU4tU4nanfdTTkWG/bk1PNBiIp4/A+Uknpd4CErqrRaecbvM8eJqwZX9ZY6LMXnIdFPGFJH0WgPA2PZ8Agi9mlqYht8qTAuhsaNN0RbFiZPg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyTCATR1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74264d1832eso2400933b3a.0;
        Fri, 13 Jun 2025 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749827152; x=1750431952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/L0PwwkoPnRzlL6fmDLU+JBmZkHn+VWrN87UcWrxlw=;
        b=fyTCATR1uAD/E/7RM+N7ukmxomyaXwuaMrnGSV981pv0zqGUFYO1W4FJlLIYhix19C
         ZNTTnyyg+w0KqNRUci7J/bF3ad66Wh9pbxKucOun8Vj1LpafB+KE1KYxIK8fdCpH4gB9
         Hsm2J4NfRDWrkw5mx+npt2FrRFtiRHWIuSiqMzeBcZiNfqtPjLAyspviaUZSJpYXUMGX
         cAn9HXUsz/5/JNlHTJ6cBcKp7fkYjiUNrLTqisbGmZwYZIK/iVH5Bfo5nsw0LNzZjJsb
         8pzNFSSHaIUZrsO5fuukrilGyAjiSZ4B8fC6j9+qv8zFkEYQHf610YDDOqvBkbM9UQTR
         jufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749827152; x=1750431952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/L0PwwkoPnRzlL6fmDLU+JBmZkHn+VWrN87UcWrxlw=;
        b=AFwftGcQd8nnqUQR8OunA2xvNObF9FP2rr+X0eeeOcTMqfXZC/gobVgNLF+RwnjVNd
         Q1BE8HwXv6DoBEJzE3d+C9tdaN7YUCxu6SDMLM9bqHFXbrFMPFW3uDdKVM1F8SXzwobB
         qvoC/rTczAN4t4JGAWn93TxyP2YAxv2ksrG91Jb//mZ98C+lOK2M7no40lr3ZIleJdTg
         daZRPq3VR9nEHbpzjA1tYEQwQkkfGrPxmQoDclpHHHqnoUBPhqbtNW7tNSd8soppNDNw
         lkzAITQBE/+rRObir5e4lgjiIwmIfe6Q7ksHKhhfAkN98XWSyKhnSD7WZ4Nt2Fcnxlcw
         9Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8osD0Phc6HdnN2LHTnTko4Vh6UARmTUUB8V6vFKZrG0emeMzxHSAAu/o1s4HAAs/4inbdMHVo3jtQqY=@vger.kernel.org, AJvYcCUqDgkrzWmzmEZDUeJCboyFCmgFxTYiDAsgcWRrz6rxitEXXnRFZyiTlRefzujQdAaOBo7raOA7SBj/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh8P94IykJnoaAO37650+G7MrsXT8h90j1YpC6+0upz34S9s8o
	N23UuXKsCx6CoteFKdiwWssOWA/jZ9fOdBuS1XmxLpqSQko3VDwLpxTW
X-Gm-Gg: ASbGncv2vdpW0l06A6obcGp+Q43LQsMAOdsVei/wKBLKsDzOPygdJzZkxmZp3nVKAXn
	EcZOutPceUwlmRkVLQ7IclKfdOiV9pVnxUATHt/MxBsGPuaN0bCElH2Ln10+TIp5gwGVfTH3XRI
	cLNBTFklvqR4HOzS5T6fBWANUhp7nElZwG98Tm5RaJDw928VWz3bUKrYWlRMh8NVsszXW/1ve/n
	8babVDS/Dv3VtIDDbCYKX3z9fUNH6OADWX4G9m6keQ8A8ShwXxGgp3q8lbzM/2/vD2beudKem3h
	9rFuorhduHXNaU2ss0qPSVihCEkWkIUfynawfu2rIE7StqFO9Q==
X-Google-Smtp-Source: AGHT+IG4B1Sr0UrOZfVg0WrH56Dwn4JeKH9TeQsHR+vKAhqTKWcWTRjwhT3U5qwgEodmsfG4i94Egg==
X-Received: by 2002:a05:6a00:4fc1:b0:746:3200:5f8 with SMTP id d2e1a72fcca58-7488f8044c1mr4455309b3a.22.1749827150000;
        Fri, 13 Jun 2025 08:05:50 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900ac001sm1725865b3a.108.2025.06.13.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:05:49 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:05:43 -0300
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
Subject: [RESEND RFC PATCH v4 2/5] PCI: rockchip: Drop unused custom
 registers and bitfields
Message-ID: <ed25d30f2761e963164efffcfbe35502feb3adc2.1749827015.git.geraldogabriel@gmail.com>
References: <cover.1749827015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749827015.git.geraldogabriel@gmail.com>

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


