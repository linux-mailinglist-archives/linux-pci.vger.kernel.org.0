Return-Path: <linux-pci+bounces-28736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B2AC97CC
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E5E1BC5D72
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B128B7FD;
	Fri, 30 May 2025 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G7+a6VQU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE4C28B514
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 22:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644847; cv=none; b=jQbbensqyBSeEhUd8XGF2HDYJ092BWqm9GGAmWQWoqneNxJmzdJsOvUEVsuCddKXKsGrMM5hdr5hDiSm5ZO8j0sLp487D55b8lUmOv7I64G9WGwSQPMZYmVwtKT3sVamq/edYB/oeaQ47d1JnidzYOllC3Dp+oxbQ5e/NpbSqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644847; c=relaxed/simple;
	bh=Qf+Qmgh8tSH8l3tRCxJRHfcUpVw8PKgjOxu7KbxC3gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9QBzCbRLLvIUURJzxtiHD8+55mo+Y4e8umiQ6RxbZLHrL0/Z3fPN27ieK0NvecIIozdA1/uDhMSXKpoUm97ZvWsDDl3nckcFQNGDzxWxs8ZvFwUyGVExW7Qv7nLrAMC61s03TGqploeR0HlcFJvIHPEf6VQTiPYVOI8A7QsLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G7+a6VQU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso2031105a91.0
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748644845; x=1749249645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJg1iKEfpql7pmZdjoA3uh10wUEns6L8IYOErZtWpmM=;
        b=G7+a6VQUw8Ui5tJtGA43josfZ4zltPHZ7x1d8NIO8ynruhDEIX0oQaj6YLRu2Ap8LO
         IBJr19O5UQ8MP9Fsv3qRplMnze8ozkK+QRyLO4IkmlAqdkICfR21J9dWFOdjV2EqIx6+
         7+RaC12cPKORYxTC84VUKK4yOppN7CHhQwtyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748644845; x=1749249645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJg1iKEfpql7pmZdjoA3uh10wUEns6L8IYOErZtWpmM=;
        b=Em++6c3ZvwoMxC41A7iB7POqzt2SmOTkz3wTHc4VCjkuUQTE2asj8kQZLbAyL1E54c
         WpiwY3jYd+6u1spYOBbE81faotx02AWPA9hCHPIWTqpSSoN6Svob3Ymd/DTxnjgoq39N
         VL3I8VT9JpAiWmfRfkdifkkc2RJbZzeAOROjDfpNJtTYEAfSX466+1oheYJ09w4NY9FA
         boE0mU/2Q1mQbzLf4TWS6AdXsmtQlyGW835R4A+r7l9usM17sAizfYhaC9hJuu5zu1Kg
         F6szzYohJhN2RI5ubyOtg/+quNg4q0A6UbzX0z+i+PLzQ29nH3Z+2b79iv/R0QZU05XR
         174w==
X-Gm-Message-State: AOJu0Yw6BpALOFdhbd0GCEL7hfwXZUICZR4T2qw52uq/d1iP+Hlu6jmz
	0AqkzrDJ9jvX0e2dRe9aSw60S3c7fAUUS/iN1+qOJmTNONt+yObb6Kxqylxgm+gifr5uynZkbJe
	6W0iAjaO6nun+Koe5RdONNtopS2Y4qjEYPwB8kYG3Q54DNTzs0smAaciWFTmuEMQJ3lcPg86gcQ
	/LLnntimKo2rjMtHu8nVbT0urieG6BkW4vfW5H0sk41ADKQfuAMyDn
X-Gm-Gg: ASbGncuvDemmtaiP77+4rMEvgsuA10HMcmJnU8uodizVzFz+rpqHLXwU6P+ZA6hvDbJ
	lOLZ7C38A9Lb4XSRsq12CgEjANWyXVZh8Lqo4sWmF9XpdwvDdeUiqoRuCgdyOBFdH6LJEtek+Zs
	rRbktm870tVM2zGBGMiTmd0WQCQeV6PIiEpPa0Za/IldwXgQtFhG+z2NidYR/qT9JKt+zeaZv1E
	ddXQxiBosNB8M5+g7OgrjwHK7fZQutl+FKT2AahEnNnnLzt2Z4ti0Pt1nIfFIHmGNM0xk21IlTr
	vSWXylWdvSjbYQVL8nVurOPiihMOlfQJsHuL82iPxqtVhFYI/4xJeUgkuqzt5TREyGVMQdIKA5/
	DentNARg6Xvz7f3dmfGNgavCHhaCyfuw=
X-Google-Smtp-Source: AGHT+IElfUcYdQ8CoYjYpd7MA+ZJeD62ouTASylM9JxPUzOpYGTly9yflZmPOUZsxhdConGhlD1Qxg==
X-Received: by 2002:a17:90b:5344:b0:301:9f62:a944 with SMTP id 98e67ed59e1d1-31241e9846dmr7600834a91.33.1748644845052;
        Fri, 30 May 2025 15:40:45 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf523esm33109385ad.170.2025.05.30.15.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 15:40:44 -0700 (PDT)
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
Date: Fri, 30 May 2025 18:40:32 -0400
Message-ID: <20250530224035.41886-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530224035.41886-1-james.quinlan@broadcom.com>
References: <20250530224035.41886-1-james.quinlan@broadcom.com>
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
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 29f0e1eb5096..cba227b19a5f 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -107,6 +107,10 @@ properties:
       - const: bridge
       - const: swinit
 
+  num-lanes:
+    default: 1
+    maximum: 4
+
 required:
   - compatible
   - reg
-- 
2.43.0


