Return-Path: <linux-pci+bounces-21508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A38A364DB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD543A771A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039FF2686B6;
	Fri, 14 Feb 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MccvvWWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC002690C6
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554824; cv=none; b=LlNHYR7RhAmkHQ2gAY7GMNMf3jH4yimZJY9T1CVblxjJ/xRNTyqjMKk6DhXmielrsOfw2JWoXSCFMSFiJ/zXJ5SpQL6s1xaE5okZsUsovk4qlg65g0BEXl/j0TB78Z5Phl/JyQ2xO2wiQ+wjQCvfmMS1+NseiEc0A4lEva7//Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554824; c=relaxed/simple;
	bh=WBgjH17iGQ0M1wewIalhrW/3ZOyyZII+ENhL+eX1Ijw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0Uk4gIBrU1J2Zf55BayHGcSk1Mfw5LwX34mYLlbOd88C+BOTTc3argMmulUTC9SFOc4ZSJsTYZ/5RQjQCnElYfFjl1tt+Hw5t7bfVPrBA3F5QLhULTYxXIYcEviXar6ati5gLLODTWOqYTCRpsH7zVvkcfPLpzzPveNnI7SitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MccvvWWk; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fa22d0b88fso1487046eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554822; x=1740159622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAlxapwLw5ouznsWC8StdUePnEcSqjOB1MsFoZtsKuc=;
        b=MccvvWWkba1jaXhQjmFDjVTdwupoV43LxdUks5tnbAyN2fBm5ggrfW8ZlyHB+ybXgg
         MBu434jR97+ZJZqJUo0VWhy4BAbpE56yz0d/zmifrxm/p0Zznn0XHdRxO94iRwD8ahkU
         deXGp3Bg0xmOgt9DHvoqYMqvER4Bl8+zA1lc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554822; x=1740159622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAlxapwLw5ouznsWC8StdUePnEcSqjOB1MsFoZtsKuc=;
        b=i9u6UW9Ah7Jqw7781ho7iuh+n0zRRVv6Ww0A+tX8r6yb65c4th37qZM8hebvBWf6WJ
         7/yz4UfHS8s/knJii9UVPd8YzpVgAWP1CEo1D2RtvEVgstncVGfHPnW7SAPxSBg8mSxP
         QGKaCOyEi/AJePtDTJAGMjEm6hGdEwOnVdQjPg/P498d/BkFOQjVwSxXOMyB+acT95Uv
         +9sRh0BnARggDl4dGytSm5ACNO/8sg6GSUQeF3ydTsYLj1ZRKXZL8Fn8UrAkiwQvIxQB
         YZd+DnV9ERlbUdLmT1IZOiOHnsjnfp44gN85ktnA6ucycIPt7wNZ3aWvLPn20QjaZ2ob
         2faA==
X-Gm-Message-State: AOJu0Yzkl/Q8NA2MCPOHudJAP2pxQvRFcP7hLS/B2pv2zKuul6juKkJS
	tgpaNC+Q2VtWppQHYVbQr4Wgm05uo8oRyDOMwkBx85v7jH9RZpozO//+WyiwNGXPytuO1OxbomZ
	NhHnE2aGa0M/OZJvyFdaV7pUweN/1mNvElLguENhSnrgqE+QzVUB7gVCP/AT8tS1dveGLTAsqcL
	dXRcTJzNmvgDjIO42dbv46+uwSvb2zMxkmIV2M4bs4utb8qcfj
X-Gm-Gg: ASbGncuUoGFJhFMnG6Jao2soHPMfReuM71nvQq6xwOm4yM86KwqTJQRSUzIEc83+xM8
	TzaySxv3khyDPLCmdOHv33Zo1uKllMw5TJK94bFARr342659Gfc19sn41WtfYUYjn+Jl37iRvBq
	8LJJluxy6XFSXLDLQ+GjXyyNLUwo2naimBxivmWU/fsg2F7sVMoQFUGEfkLHg0Jxy2xsvGvkSal
	y7F1RdH1xXoeRkEbZ3tQwIVuBMuqcxOMpix40MozAocWj5qyYmHhgKZTyfba7ULtd3aSIOw8GVM
	YGBRh+iQgY830zCzrJbmTynnw+nFBqLa1Oq+EJeM/UqOzHiubrhb40wdR/l9jwmVnUmfaR8=
X-Google-Smtp-Source: AGHT+IF8Xjib64lmMqD097Fqb8iAnB8oVv8SuKUplvbq9RXROblxeeVuY5j8JISp/0552IXX4jSipA==
X-Received: by 2002:a4a:e68b:0:b0:5fc:a7d4:d788 with SMTP id 006d021491bc7-5fca7d4d8cdmr5224730eaf.7.1739554821727;
        Fri, 14 Feb 2025 09:40:21 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:20 -0800 (PST)
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
Subject: [PATCH v2 8/8] PCI: brcmstb: Clarify conversion of irq_domain_set_info() param
Date: Fri, 14 Feb 2025 12:39:36 -0500
Message-ID: <20250214173944.47506-9-james.quinlan@broadcom.com>
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

Just make it clear to the reader that there is a conversion happening, in
this case from an int type to an irq_hw_number_t, an unsigned long int.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index cb897d4b2579..f790d5252e9f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -559,7 +559,7 @@ static int brcm_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		return hwirq;
 
 	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, hwirq + i,
+		irq_domain_set_info(domain, virq + i, (irq_hw_number_t)hwirq + i,
 				    &brcm_msi_bottom_irq_chip, domain->host_data,
 				    handle_edge_irq, NULL, NULL);
 	return 0;
-- 
2.43.0


