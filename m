Return-Path: <linux-pci+bounces-21504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF3A364D8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB0A1897A8A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3F0268C74;
	Fri, 14 Feb 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WHFxHSuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490F9268C68
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554809; cv=none; b=lHhxCOPZ9aNYFMTngykxqfZQJMjrOnprElaxJoelZsjCoLSMzAS7sTs3dwikcAwYoiaT09EAseo9Uiz9qDakTgO/65Ypi3uUbNWES0xvjLaVqjsuBepilSDjCUpSDSnizlBEHHOYsDVmaNLEYgSmi4p7XLYvnwIMvvZF6jQk23M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554809; c=relaxed/simple;
	bh=hpYFno3xFpTtIFF8NpBFjFKOov5U886g51Xm0GPpMkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kty48ukDqtdKzM11gaOCQhhRaEzRF64HEMgx3XKmm9bSUu02KeZLBVNC4J+AIjEfwxLDFYKWXvPqoVMuM6TLsIcyvxKQ+pCGgshpbbdchhpKGZsTeuz8au3H1jpKQuFdRbM33xgETLWBsxm4zbKGUuGKe6PTo/NE8MfbLjE623s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WHFxHSuS; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fc6cd89f85so1089867eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554806; x=1740159606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW9nWifCzwYZy8eQdCTo6EqgINRvFFYuVj87cGvTYVY=;
        b=WHFxHSuSMEUZc0NEZk60+QjWikrCDjNZrflG9iuLSfcSNseE8X6ZfGUbUrJwXW1ebC
         cL+jqmO1KKePcZifWYNYcGIWNMBa2MQIMSQNLWeF2oo6pGeIz1gXMsR6s3pKAP9BXK6M
         TO7zRNAvSX8E0msGMnLDFg5L8di4xPTEZUqgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554806; x=1740159606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW9nWifCzwYZy8eQdCTo6EqgINRvFFYuVj87cGvTYVY=;
        b=umeuet9YvNTsWnUWXLlmK5NDSQ7z9S9QHAD8/WIbhFwpTrD+MwH/5eRB81OGdyn3v+
         I/c56qnVB+CpGqlfaRsrqePkQrLLg44JSEPYgIs3DkVYBcmUze54Cr8VrptWhQ9f8rT+
         D7AH1I9xd1hEvuE62+/UkmzHNyDIN6ZVr4vbQb9QXkemNBsQpMsbZH9M+/Cb8oa9Vmuf
         QWiO+F0icoyzOUkqfyKX8CzjQI0WdTMFRPMeq7a9jdzfHXt2zpVTlCwxrxZMVET7TU4O
         D5BDF9w5nmpr1BU+F7qJ2iNzkyzCxksgMwDZ5ceZmPHKzd3C5vxs2fy3ne89Td/jX8dI
         MqRg==
X-Gm-Message-State: AOJu0Ywln04Tagna8xyrzmM97Ou6Vu0+JUS3IBkRlG6BVkmH0/s928NF
	Zx+IC+JwLU1n38a9XdlLscm9UkDQ6nGlt4jtn9MV/GtXy8WAFhoqBr+/wfXYtsvjp1wDItUclbd
	Uz+E0tchX4Xa0MiLFCStAsWkwIExcOc1utScUCud3w/k62FmkrCVgVwTfV/FL65IMlVJO6WDs2Q
	3yB24dPaU/lqmb9VDsu7bzoCaiSXSY+dVj0/G1ejfcnkzh7xyf
X-Gm-Gg: ASbGncv1REzimqoGE13b5rU7OzP0T8Zk5yq7//x4nlQKFaDBmMy/yRetUkiYuvYcucn
	FREPPNXJ7ZWX9UW76wGenNT5DFbCHvc8IZghwZv47qko2dgmQ5BuE4/PWb8DeZC0UCm85WzwuNP
	gDzHMjL0Fefxke5Hzx0TEdqEsQpNS2OKwRUGDT3J25L32NsLWLDnMgsMbCDWDLdFkwgF9uaRHd1
	VepsR9AaC3Nc5MZ8FPaKMCgttunc9U/8GJ1Rh/ibhtTykLqAipN/ZBp+U0DkQ7AHe/h1T1vXplY
	AjUCmRqf6kbCBPaFMRtc+0JrNYRiuGOGo5a9vlVp+neKei0j1ukdEABdfnqD1c+zkVa/cgI=
X-Google-Smtp-Source: AGHT+IHsRBlmYmWP6ec6QvQPHeSSiuic4NDtKAA7m7DLRipohduC9tXO6eBUjYvMvWROPLOlA/zw6g==
X-Received: by 2002:a05:6820:c85:b0:5fc:b1d9:9b68 with SMTP id 006d021491bc7-5fcb1d99d08mr4047840eaf.5.1739554806336;
        Fri, 14 Feb 2025 09:40:06 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:04 -0800 (PST)
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
Subject: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
Date: Fri, 14 Feb 2025 12:39:32 -0500
Message-ID: <20250214173944.47506-5-james.quinlan@broadcom.com>
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

If regulator_bulk_get() returns an error, no regulators are created and we
need to set their number to zero.  If we do not do this and the PCIe
link-up fails, regulator_bulk_free() will be invoked and effect a panic.

Also print out the error value, as we cannot return an error upwards as
Linux will WARN on an error from add_bus().

Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e0b20f58c604..56b49d3cae19 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
 
 		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
 		if (ret) {
-			dev_info(dev, "No regulators for downstream device\n");
+			dev_info(dev, "Did not get regulators; err=%d\n", ret);
+			pcie->sr = NULL;
 			goto no_regulators;
 		}
 
-- 
2.43.0


