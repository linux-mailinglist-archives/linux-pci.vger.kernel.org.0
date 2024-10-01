Return-Path: <linux-pci+bounces-13682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8D98BB23
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1A428283A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B81C2DCF;
	Tue,  1 Oct 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="STgCD/Ll"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3D1C0DC5
	for <linux-pci@vger.kernel.org>; Tue,  1 Oct 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782285; cv=none; b=m23Ckv+DqioMDKHd0p5BpfSFq/dm6btuDHzZkIak08t6yasSJXZqBUuXlLB6DEhvOnggCNz+tVt8aDJZpbNkQIYW2HMiza6JG1KgHQIT/zDFVC5hH6MrowTnanJ7sB8dtyNS9RFsDV8EzJqHKPkpTom6lcwduOy3Dl37FzFvHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782285; c=relaxed/simple;
	bh=MCBPCSdf0r5zSImbTGJmv5u3+Yij9V9+fbe7lh4RBNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9F+kjRJFCNOKkFQNomrGC5GWXRQ18uyY45uAyfzVilIraYYh3MUpf0HyspYAqdc3qZQAbBtHFZi+Onj6yYCmYdZCb1mPQ/qEOgTZnGZIob9nu/LrQIIJD/PWyJQg0cxapgJlai1sOYGMnj5sLwE23AUYJfjrbt2b6tPjETKEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=STgCD/Ll; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71b070ff24dso4806942b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727782284; x=1728387084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HExE/eexnESQrLRIjvabM8eZD3ePYvWvDq6AbBnCJhI=;
        b=STgCD/LlSuC/vlEvwN8oN40yo6gWLblVY8oQ9uoYBUnozmdPMyn8FCgS/NXDXEya4v
         pmjfwOJ9XitYIaFW1tn1juCOyU2b2pdDEIdJ6I5napYB2LAj+fWC0kotWlUUZKQwG9in
         PfhevUdINp0cRcgx3Dd2feeAagKDYQeMCmMDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782284; x=1728387084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HExE/eexnESQrLRIjvabM8eZD3ePYvWvDq6AbBnCJhI=;
        b=Fd4sghx8B9EtU4hdDvE0lB7ZvFF6Rq63A1PO5oc64snKqQGOZcN0CsHv/8kzeNiuHJ
         YrqNkmOQedaVl+IvHwYX2q5PiDG/gdyu63yi6Nktp4cjW/dCQLokLNWYxGCGJIJSS74i
         UDKe5ofqFRPkVgun5N/0TCcvl3MvlK5a9954aqYNYCvSnqR6wzNQwdUvzObk1mGgFYSo
         t7njcdZbyNfos3tBJSmMpMpZGCCW2zrLvE7tmXrtT715fHJsDmTaGcryn8L/rjCmbt5C
         PvLn3Pf/4LyvAsrp6ANHas+kQCeTBOgdftBmYFKT3xPY6SeYbjpEyP8K/+nxioqaNZGn
         3z5w==
X-Forwarded-Encrypted: i=1; AJvYcCXz5orW00FvDtJWFfdYZz5R9iiZkDjpKwJe+HyJXHdCD/ovvyWXhQD9oEg25wh5ezVemhvj40qBWqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPyIsHiq9nsj30IvJTWzuowmyepKa0qmOleLcWOl+2y91HvSD
	QfraCS/QtfHN8MairjZcyIZuSiQBbr4pXAtjMy1mQ/NllLUdy3aMSg8DhNG+Nw==
X-Google-Smtp-Source: AGHT+IEKMhrohdkvwi4Udq7vmrZm1RN5zUB0skQ6nIN1r9c0R1TPgRRbL55DWTsl/CIJ8EZMUnlJMA==
X-Received: by 2002:a05:6a00:8c2:b0:710:bd4b:8b96 with SMTP id d2e1a72fcca58-71b26079af9mr22686021b3a.28.1727782283633;
        Tue, 01 Oct 2024 04:31:23 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:e044:f156:126b:d5c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b63d9sm7810646b3a.52.2024.10.01.04.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:31:23 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/8] dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only
Date: Tue,  1 Oct 2024 19:27:20 +0800
Message-ID: <20241001113052.3124869-3-fshao@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001113052.3124869-1-fshao@chromium.org>
References: <20241001113052.3124869-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In MediaTek PCIe gen3 bindings, "clocks" accepts a range of 1-6 clocks
across all SoCs. But in practice, each SoC requires a particular number
of clocks as defined in "clock-names", and the length of "clocks" and
"clock-names" can be inconsistent with current bindings.

For example:
- MT8188, MT8192 and MT8195 all require 6 clocks, while the bindings
  accept 4-6 clocks.
- MT7986 requires 4 clocks, while the bindings accept 4-6 clocks.

Update minItems and maxItems properties for individual SoCs as needed to
only accept the correct number of clocks.

Fixes: c6abd0eadec6 ("dt-bindings: PCI: mediatek-gen3: Add support for Airoha EN7581")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 898c1be2d6a4..f05aab2b1add 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -149,7 +149,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 6
 
         clock-names:
           items:
@@ -178,7 +178,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          minItems: 6
 
         clock-names:
           items:
@@ -207,6 +207,7 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
 
         clock-names:
           items:
-- 
2.46.1.824.gd892dcdcdd-goog


