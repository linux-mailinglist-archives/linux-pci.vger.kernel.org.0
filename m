Return-Path: <linux-pci+bounces-11727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9A953DB7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA79289143
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75AA15B55E;
	Thu, 15 Aug 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B0HL3pu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAF156C6F
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762691; cv=none; b=ZBHw0IQhT8iVrMk9jF0fgk1+T1GwVxKZ5wXCnnuvZdx9iGp2+SH6El/RlnQAHdiYqPt+kJONReIxk4MEiEcERQT/r5dQkHKC7jkOzUvDY2RdFp2JWHOpVTxyDqJxsCci1uAD+M2cNvNumXy1OUTtWAI3VZmvhxh8oZWkIv7pO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762691; c=relaxed/simple;
	bh=iS7LFp2PVJ460iBbtPinjEkkAJPIwHTvNxrdmqa9g7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gx5YpRJJqvmOKAjRiIL27A5Mo6iuTOwqhSwx7btp5owQFvAxOqNygN3kVKkI78YoH9h73ke8cfng/XsfwNXL1N4NEovvAjP4rnrr+a4/kMvfAyso7ZstoHZnajQ9mb5X7u5RL5gDSke9KtwdRA4kLV3feDYPKlBI9ZKbUJ7KdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B0HL3pu6; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so1739044a12.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762689; x=1724367489; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KilTSS2hPoygKRd18QPDDGRiZt2QPvEb7dOr4l2nKe8=;
        b=B0HL3pu6CgbZDLdapzV0ySbmpT/u9qtSPIZM5F3sjNeINNTmotQvYXyE9U2WFjnLkV
         9TtgYPhPq637X31om0RUcjMfRT+NXDxCF9tqZ1tYEYdKL8MvXThuwemQC7gMJ+gIgjKZ
         AmSfDcK9w3GZ8x0+aAIvhTbDeA2C8JbghlRDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762689; x=1724367489;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KilTSS2hPoygKRd18QPDDGRiZt2QPvEb7dOr4l2nKe8=;
        b=cTcPsuyztx311+CUkjx5FiKJJBhXG1FfxusS48TlbM25RFwKpGzzpQynbQm6T4KWcU
         OBm632Dg+0XhnNe/f6p42Ey1PVJcES7i4/i7UkvN4kqwC6+pnmjLHCsLjxq5NvbxLA48
         VJBinrjU3jp/oZbk5sKVpgtwYq9zaZZcJyq4XSuJiLYX18ZbRFhGtawQ6OPCAvRcG5kI
         vkLcJFrI1a2J4w3WzZDgldhaF25h0/rD4ylfscflLjtmvZ18fgpwTkOWBCs1EJcnSdFw
         iYQeg2NuPLxwBTE8xCKCQbN7btoXcnYjIybP3oSxjeDlAyOElXe5YgX4UVBsYFxurhak
         OgLQ==
X-Gm-Message-State: AOJu0YynaDwwN1QzRh77HB/h8Z9Rus4lJwATd1JFlgo2PD5SO3pxzONO
	0affWdEQK9Rl1S41mdDbdED9ueVM/uXVMCWYhRsbuui29Gp9u2XJlWh67pThDjolu6m8QUwhJ5+
	spwpFqunCoz87H/Op4aY72O9ISA8vV/qLiKUhSeaIv23hBlZ/q9Y3PAZHItByjoC964sGG4sIRa
	KUNsj5pz0zYauOz4vPVhU2JJVZ+DVoVEu8aGV43ag2xTaodg==
X-Google-Smtp-Source: AGHT+IGVevgXwnN4XnwiiR+wYitz2w7Us7nSDwVB2LvLoMWElqIPNYYknYIqxswtfiLumTPBy/dykQ==
X-Received: by 2002:a17:90a:3ea5:b0:2c2:d590:808e with SMTP id 98e67ed59e1d1-2d3e4579733mr1068240a91.13.1723762689089;
        Thu, 15 Aug 2024 15:58:09 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b2d1sm373997a91.18.2024.08.15.15.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:58:08 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 08/13] PCI: brcmstb: Remove two unused constants from driver
Date: Thu, 15 Aug 2024 18:57:21 -0400
Message-Id: <20240815225731.40276-9-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240815225731.40276-1-james.quinlan@broadcom.com>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Remove two constants in the driver which are no longer
used: RGR1_SW_INIT_1_INIT_MASK and RGR1_SW_INIT_1_INIT_SHIFT.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1444f2a9c21e..51b715fbf3a9 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -210,11 +210,6 @@ enum {
 	PCIE_INTR2_CPU_BASE,
 };
 
-enum {
-	RGR1_SW_INIT_1_INIT_MASK,
-	RGR1_SW_INIT_1_INIT_SHIFT,
-};
-
 enum pcie_type {
 	GENERIC,
 	BCM7425,
-- 
2.17.1


