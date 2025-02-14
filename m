Return-Path: <linux-pci+bounces-21505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A1A364D3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C331715E9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C8268FD1;
	Fri, 14 Feb 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LgAXDMVT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27E2690F7
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554813; cv=none; b=u7mouDYlqbj/Fl28uIz3YdxkE6g5wAxth6wrGLzu9Gy1xG+bRER2LIAJlgz9CM3/j5Pyl8xbLyLHCWij5k7Ogndg90E4HsL/IuyBcTszTCAi27kEyQJ8dDstKpq+jwlEKD3FzBf/aCS3tDjzur02UNmbNPcB44ZzclTfslhHesY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554813; c=relaxed/simple;
	bh=8sIVeXISLhuu8alyiP65k7wuvZYSU2e6JSJtcZ8AiwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBBnYeqRz6cOwNDfLO9Quu7t5TUbnjPHPsnwiRLTILV7jZMj0FKsAakRSdB3wUHqIFGqaAWjemZkGZ9GB1nurskNdRT3qOUsawoLCn5lR3r6873laDV65r0fMF7a+XrcXTRtKfVCUC5Pa8YfUSEP5SOSE4LAE4rgbORG2loJOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LgAXDMVT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fa8fa48ee5so730104eaf.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554811; x=1740159611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxVjaXboKEqmhgPS1SWexvRwQQsKkPF5XcZy4FqcIn4=;
        b=LgAXDMVTpw/WAdSLmznL0ewBKHivLZRXxMua3qNK2PEe+upzgXqoaOJ1u3weeuWD3b
         neNwWdKqL3Qis0dz5Sj8jhwEhP/vFajzUfSbm6nMgfk/iZojaEiL/saEA7syaFghbk/l
         aXoWX6OMnZCQqYwN5S1K5Z8ZMXwEwXN9wOy5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554811; x=1740159611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxVjaXboKEqmhgPS1SWexvRwQQsKkPF5XcZy4FqcIn4=;
        b=k1p2stv4SW0N3/VWWmKRF/dv3r53lFSXGpFrHHjRvUrq8Xo27VWPEsGmaCUItATeM8
         ofU6+0tuqs7DDrrDUjm5mL2ACURwaD/Qh1Aeuz5QciKWUsRW6vYDR+m2KMPDXoZzwqj4
         h/VXOxdxnwJx3u79USndCIeP1rhn4ZRjoMT1vqaQ+deZIiy0lEcZYR8cISR7Ix2vkJ6D
         uA+6av2SncRiKz7SA7fKhY6IB16jVl0Up2xvkR1u6HZPDXrnKJn+h7xJM6MM+U2D97Ye
         gWy3TQg97dZj43A7sYFtKtNrSg1U1kiV4SUMerZXBXi7e2S19QrqbbwBrTpZtI2PAum3
         yOKQ==
X-Gm-Message-State: AOJu0YwttqT3YWB9RKykWBUd798rkNj8QYTTe4jzAYZdpWXuNOCchpdY
	CRNDBhjCJPyTR9gf1i08tjIVMydMD3lKtd0LcDX0H6sqeVqffPmwVLJVLyJmOUVmIiPEUGb8brC
	CzlIfY1s3HfCKXxGfzkAexZ/3nOidaCQ4a2Sj+C3soo5vKVyfkS4LkHKsZnETZMWVfPI3txtkpM
	3v9bcB+/JF7VcGHJhuoc2o6gBm8uM5q3Mlnqx3gXjHjEOLB9M+
X-Gm-Gg: ASbGncsfdG0NKzPxCVsYyd7URqJiRzbDrmQ5fSefGbNo7G1swRvvzuj7aIxFDegvAfj
	FSVTC1JwOdzI+TcY9cslPYUTlxCLzg4pe9cU9sWno+MlL/c253/228G7NCgz0qnaWMxTPoQk0Su
	Sff70qOOFfNzKoja+yaHwQvtDPfg8zWvuHVAzJ7f1OkB51xVPnV8kEiCg+fm5lloLpBVh/EbS+z
	moymMzYC73waNZfBmtb5vtdEbDM67Vb1zjtc6+cYjul2G55ieUDFtIxpwjbnHubO/Tr8Qhils/r
	lydzsNWR2gedC+UuJHGF7G3kQCYXokfmxpQsqqpVNl9Fq7e8CeVBUHlCgLckUaNwmerc6jw=
X-Google-Smtp-Source: AGHT+IH+XOVc8NTHW3k+78X5WYAnuU8kXspEfNlGrsjwFcY/02Yv6CZB+J3SozAcYaszP+QsOrsaFA==
X-Received: by 2002:a05:6820:1c90:b0:5fc:abe1:98a6 with SMTP id 006d021491bc7-5fcc54f758emr37937eaf.0.1739554809423;
        Fri, 14 Feb 2025 09:40:09 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:09 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/8] PCI: brcmstb: Fix potential premature regulator disabling
Date: Fri, 14 Feb 2025 12:39:33 -0500
Message-ID: <20250214173944.47506-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our system for enabling and disabling regulators is designed to work only
on the port driver below the root complex.  The conditions to discriminate
for this case should be the same when we are adding or removing the bus.
Without this change the regulators may be disabled prematurely when a bus
further down the tree is removed.

Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 56b49d3cae19..e1059e3365bd 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1440,7 +1440,7 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
 	struct subdev_regulators *sr = pcie->sr;
 	struct device *dev = &bus->dev;
 
-	if (!sr)
+	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
 		return;
 
 	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
-- 
2.43.0


