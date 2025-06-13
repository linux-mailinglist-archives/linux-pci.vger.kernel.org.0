Return-Path: <linux-pci+bounces-29731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6671EAD9026
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932FC3A81DF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E81DE8B4;
	Fri, 13 Jun 2025 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDMu9Qkw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1A1B3939;
	Fri, 13 Jun 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826298; cv=none; b=pQfhS77M12PRGlF0VhW9P64d9f+Xz2bc9LL5vilg0kFxnJPJlJdtReqRX4d8BVnbTy1aN9092nzEZBl4Pa3h1RlvN86kyEv0wMl28tf089EmkZm2VpX5RS0vzIgAA9PEIt1zBCxwOOss01CnD80iSFBWGt/a0jW6SEPl678POqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826298; c=relaxed/simple;
	bh=2czsTqDFs2LayaWE3o+qV4gJyCKv1km6UVStrH9AcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAGEpGhcIZqYEsFZeYpO9Tf+97YxDBH2fQjmxlNGR1rkPyKmLdA8yqlz1GpVoksA9bKBgPr73lyQt7d90t64TtVocMkvJjOLwZrNAv7V29TkdLIgxes6vSPzpuSma1g8ZaywODk17YBqR+NAYLgEEk+/cmnbGCRCxZHngjusn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDMu9Qkw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2352400344aso21227275ad.2;
        Fri, 13 Jun 2025 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749826296; x=1750431096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/L0PwwkoPnRzlL6fmDLU+JBmZkHn+VWrN87UcWrxlw=;
        b=QDMu9QkwzjPVvKYGh/XX9CK945yHkPnF1fVNTKB+gDZJtZ8MQ4m4hGHgpIARoTsHlo
         gxGZUWFVlH7JnxlkgGXa24GiQF67prmlNwNgvAtQeto9gn5sTOUxKgMTSFp8wPADEe7D
         PnBYa+x2o3nYJL4hemYN1HRZ/Egl9mq47+K/NA0ub5u0n0gQkr+CDueFUTbIXnmaNkju
         2PUHaETqKKe3WRwPd6eHk1WSm6xmI55isnI7rkupOliZGN70MMNiuuFUEoMf489CihsU
         XMjaxQYoitMbM5374NFyQta88EYDhLaP/apSPJJcJBVWWM+dl8LdmVExumlDzuTt4k+h
         mt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749826296; x=1750431096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/L0PwwkoPnRzlL6fmDLU+JBmZkHn+VWrN87UcWrxlw=;
        b=IE3/bljXPvTFsSZJ2z0xdqxl6+s1pVaBQsGXKrFXqR7x3/nw880GWw0TNxDLRIhfH0
         QORShx08XlAqtRsGqoKWfuyiSVwoG49W/RfKoEltXoEuUXxOAblGnPn09MKlyd8my4b0
         Jo05M0UUu4ZjnoV49IncKa1bNpb65k8QhatEDMPQrSJFRMqz3JX0nLUjR/FGuJWMX3i/
         OGeL8dp1oYYW2Ek5eXZ9DhEFr0zBXmx8w+6onEjB7u87fenYumaNu6DvwQFbv800YJcS
         s64gwza49pULFMhOlzZvmMRFlfoH/NMk9Qg0oC51HaFaud7Qq1RC8Egrz0byKiu9PqTW
         yVHw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4wqOZfLj+UzKgN6oCYff8DOpqHurJre2rpzi6sJvxZIOnRjjkcZt7K5aMcIUwlS/ut12f4I+apTq@vger.kernel.org, AJvYcCXzDK/kAv3XjaCJGR3FR0EjXNPMQhLwZj53hpqvq4eqmCeHImJPvOUseLde6EMSpZZ+beBSiUokQJW2il4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrcZtg2Ts5E4jEqeJHE9NpLIzLAf1+0PeDmY8ijnSBZodDaFQ
	xkwpCCM2fQmu3qhdjQXfKo91zeNNkInR8US1qMI9cNLeaKrvAVAojJRI
X-Gm-Gg: ASbGncu4klzTC+RdSrvROqjwaNndf4rPUh/q13GgpRFZa5Ii05jC4RQB+wR3o4v4BZ/
	t9iaven4xk0+9rLWoK1fAkY/BRFm3UqxRPgu+K8gw81y3QKCFjMR95DEWf4s6LgYfVaYYNqSHnK
	TVumLTbYMpW72mv0d6Dy+5uaB0Wcr5N4ZmgBzKvfWElAVw/4HS54yz8bCVq0lShnMzYPfFIQSmi
	MNdWXLlwfm9hE0088CGV7CKuCcpvaKZ8AmlcJDZX0B88nnDaxMROlCohskbsoiFVtFLZyGpqCbN
	/vrO7taYT+LZHY8VEYaKYMRTMCIGr9TXFtITGsSd1h4twP+QCg==
X-Google-Smtp-Source: AGHT+IEIIUA/SqQ/LFR7HRB5k5zVKg219NACECTVDBepqqz/zObVh2DDinY6N9JMXMq66xyxr+KZvg==
X-Received: by 2002:a17:902:e5d1:b0:231:e331:b7df with SMTP id d9443c01a7336-2365db08f94mr46802515ad.29.1749826296073;
        Fri, 13 Jun 2025 07:51:36 -0700 (PDT)
Received: from geday ([2804:7f2:800b:838f::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5fef6sm3847533a91.40.2025.06.13.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 07:51:35 -0700 (PDT)
Date: Fri, 13 Jun 2025 11:51:29 -0300
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
Subject: [RFC PATCH v4 2/5] PCI: rockchip: Drop unused custom registers and
 bitfields
Message-ID: <ed25d30f2761e963164efffcfbe35502feb3adc2.1749826250.git.geraldogabriel@gmail.com>
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


