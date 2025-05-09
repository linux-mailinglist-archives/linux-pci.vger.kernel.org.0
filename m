Return-Path: <linux-pci+bounces-27530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF7DAB1FED
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 00:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02F91BC5E51
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16365263F2C;
	Fri,  9 May 2025 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bgib0VxV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721A263C6F
	for <linux-pci@vger.kernel.org>; Fri,  9 May 2025 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829712; cv=none; b=VNj05tCAaXPv5OVRRjSFn5hLIQIYJue2wX9SPmedlFK7RPVwSWmd62itU2Xy8LoFbFDu1Q+FG3lP2X/VjTtelqs23qwhlfgjbL4JisJ7oqZDAb0TiB73pqEujbuGw8Vy0LErOM6Up96el25NK8ZT69sUsKsdv4qOWGwKm2w0K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829712; c=relaxed/simple;
	bh=IspuMfhbuI0NskZWSzhFkzpIeIBkgsFFHVt3aA4o/AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNBsMj5QQ5nbzRdQUccVgdmdntIngmH/Q7tIe7bZvfXaJTa+6rZIdPvhbbQIJuYACOaC1SfAqrqoLQqTNeAQaAwGaJXL+oqItgdAhsyUPb81z/v5gEyYSSoWO4fY221NZxsnSeaoG4i5EgXNIacO9KEL2eAEoODF65/QE41sPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bgib0VxV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e4d235811so37565845ad.2
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1746829709; x=1747434509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p7ER/Q3/oiPZqhTroZ/8PyX/B+RWKmVdqYgvMtMSKg=;
        b=Bgib0VxV3AXetknfdkpckzMA4S5mMP7k1r/7Cdz8V1/pRaO9rTtj6jpY4LFkpjEqgp
         /jPByBoc0nWmBrOzclixKTfqiUBS+KIKgwFh7tr38kE4OIX1jVhv7IdVpkcJF9OvUuaX
         ByL6o7Uifmiy/A9SgJ3hivaUAvNe7HVeoJY7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746829709; x=1747434509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6p7ER/Q3/oiPZqhTroZ/8PyX/B+RWKmVdqYgvMtMSKg=;
        b=PY8WL093ESclFGi/F6Z6FRyZ5qBmLb5lw1SCpv99L3u+CP5hfoAf/8VfTiIboOcMBj
         v4suHVEY4IW/sch7GiQhut5/h1GEtwEgfsaqpFKDqARya9yaPpcen7PR/Dag6WYX4QE9
         uJkt/toSir4glrZZvRyWpvkiMNS8+SHZQN2QTE0h9sFUHqTVlPxaN2KT+VcaKCoTXv2Y
         A6ZRwX4I0KfqFU/wQrmxCed+gjnX4zOF7Sr+p1232m40jm7z/zRcZyP3VDr0Bvh+JFqU
         1ldwnUnJe+KoPeE2j5535CcxjXEf+Iz03s+wynrT4HHNsIQ/8NU8LDnup3wRDGcBXjBh
         2P2g==
X-Gm-Message-State: AOJu0YwqAIX70FX5DWQHQl0M0UjxrSGb8PRFCpt66migWfqsczhUwniM
	wRQIWKu6Csje0BlfIYa8GudSu2iLJnQyllv4POAaS9xsghtlJCD62OhYJdwipkMe3X5bh0885Z4
	itQ0SIPz7KBAkLJZbdore6TIMgI43PacH4l/EJRBAcflmItDdBNb08UdHDE7aY75N7zcgck2B+K
	TQA3co58rmOrTaQQtoykSG4BGHs7Bo/0/WOKvpPSdE/x6m9g==
X-Gm-Gg: ASbGnctF9uvn5fcgZ+Fv+KOCRID1e3bEDUEX41ni9VVWEAvxj0IpXFYey64f7QgQBlR
	UYZQ7Fg/DcI3gHuD10i6bda5W00Yl+7YgNC4Dvh6Pkmx2CqWanNv5ZHSI5etPGBY33MlTvsd5/t
	hpDV7vDlXxTAmuJOcRg98UhPzsdEFgq4qDsfzZwWFoaI1j2QxysQgfvzgJ2WCxxZRvZTdIGIPR9
	o6u7xVXPvJa1QDgDJwh5qXzOltpvKnd17IoXFEEtkeCXuiAGPB3P0CclgwEXLq6hpd0qNJfI/lJ
	SsNrxFpPS6y7lV3c1Uuqu3V0cG4gSMUCO6UTxla+Z+bgrvZW+JY4KrZq5/hYlkMG0ak2k6+JRWT
	WvmLxT4S+OWOIRH4QsynKpC6U2XUZo98=
X-Google-Smtp-Source: AGHT+IGfUwOQRvWOeCWpbpI7bjN2yUkoA+0vs2CH6hB56pZLb+zEdsUnC3KckTOyfdQuyia/7g01Hw==
X-Received: by 2002:a17:902:e747:b0:224:a96:e39 with SMTP id d9443c01a7336-22fc8b3e2efmr67480325ad.9.1746829708752;
        Fri, 09 May 2025 15:28:28 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7544fadsm22584465ad.24.2025.05.09.15.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 15:28:28 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: PCI: brcm,stb-pcie: Add num-lanes property
Date: Fri,  9 May 2025 18:28:12 -0400
Message-ID: <20250509222815.7082-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509222815.7082-1-james.quinlan@broadcom.com>
References: <20250509222815.7082-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional num-lanes property Broadcom STB PCIe host controllers.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 29f0e1eb5096..f31d654ac3a0 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -107,6 +107,8 @@ properties:
       - const: bridge
       - const: swinit
 
+  num-lanes: true
+
 required:
   - compatible
   - reg
-- 
2.43.0


