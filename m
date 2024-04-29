Return-Path: <linux-pci+bounces-6779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A508B56FC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F211F226F8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F747F41;
	Mon, 29 Apr 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTRlCFbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350E4501D
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390991; cv=none; b=QbJkHg9U0NxJQ7RV65QCDDL3xJ2BqGHfBsp97YQagO9X4k5yANnX+VF7yC+XfkYFODj7ZV7JGifSqRNnxjYQQDDsGaLbvCorO6rHuENYI+p/N46Xt54rCBsfycWImfyguuxDJAC0mA49gwQGTVMbXkbc41VFjBt0h8hN21Zqav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390991; c=relaxed/simple;
	bh=xP9omRynCEpRGFZBVMKXP4h+HilIKdIqSnqZkJEzSkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsdjYSvXCbNQY8qe91ZXa21DAboey4OtIEwwAK/VzwwHiUTTsPEgmWiDRvYGgBnAJ4izM/b4XemPzxulT0WpeeNvsaTMHmbj2T7hlMe9rVTkE7y1AB473oNVrCqIKBkPYChOUsYkTsiHzXFMwDsTIYDVl8XMcMdq7sdRVmYz/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kTRlCFbs; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2db17e8767cso50415661fa.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390988; x=1714995788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AHu2GrYMZd5nsIxhghrANJzfEVXRFCsK+/iWXt8RrI=;
        b=kTRlCFbsKExTySVZvFot2sqit9Ifvb89v4z79uammipb9HLmCDvNabwSYu+3GMrBUq
         5fml7vZFYA7TMp57D1iHNcYr7Npt/C4rUffttpy3GVi4Va+t5PaDtlvg9G/IUHPQCzPo
         72kqScSZaLCx3TpBuW6HlCtGHoEcFp4Raco2mdvduBCtuJqOIVJyhtZlzoh7OYeS2yk0
         Meidw7W29niYZNlWICcuwvDz87JB6xk06/NNzbgyJ0n9yUWtfGaQ6G51uvS2+QtYskcP
         93l7/5a6sp+Cnxy01n/RWW1FtDVx3unbmMnaYQHKZaeuPtxQvZOqiWmODT01tQkeTWw0
         hXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390988; x=1714995788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AHu2GrYMZd5nsIxhghrANJzfEVXRFCsK+/iWXt8RrI=;
        b=nyd7VGwTr9bosUK4NfTgsTbEAjUam1AbhlqoEP9PYFRkIDCx33fOjRItgU8CaISWFQ
         L0ZcKCi2bu9uiiR/8saibEW8cZ1tXuhEFK/WCBEgnu+kpxKwGWQSBj/BhNOl+sl8tbcE
         xMhMBwCRNmGqmOt/ompgH5pTOJcAWdZ3mmYE8/S/kQ8hvldulezO8v3cwKkV5rzhUenj
         da2MSg0Hq5AE+vybGo8jXWkmvIHr/MUYfm69w+xOuTSsM8k5izwf6bf/yfR10phGyzio
         8XJlLRDrxts8MJuuNG+5DmtXQxt/N8HMH1Hx1E6enurJsvEFxtDPc5MW3yYNafaVl7CW
         vDBg==
X-Forwarded-Encrypted: i=1; AJvYcCXObbVHZdUyPKEEWDDK0xISfArBaCcitOAi6iMxPh2Kh3B+GuD5wLMQjydZqzQtyqp2JLgPZN6f/jEmIc73hnb2ZWfQbEYgP2UB
X-Gm-Message-State: AOJu0Yy5Yf05pyTV/bu5V9s2V12FP+LgTHo3o2Rd/2bNL93ZBEUt5xl0
	24pxXCsm4q83HtwK2aouQzTjWkWO/tK4XyW7tre4VHfvsI3eJVMERa38+6tyOAg=
X-Google-Smtp-Source: AGHT+IEM/SX8JWy3onOefygk1LTTCZaAW7PQ3Tj7tXR9aiLyU2Z/2Z/HvLOTcE/H0E6Xb96t5e5h8A==
X-Received: by 2002:a2e:901a:0:b0:2d8:4169:3a58 with SMTP id h26-20020a2e901a000000b002d841693a58mr6273268ljg.41.1714390987975;
        Mon, 29 Apr 2024 04:43:07 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 1/3] dt-bindings: PCI: generic: Add ats-supported property
Date: Mon, 29 Apr 2024 12:39:37 +0100
Message-ID: <20240429113938.192706-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429113938.192706-2-jean-philippe@linaro.org>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a way for firmware to tell the OS that ATS is supported by the PCI
root complex. An endpoint with ATS enabled may send Translation Requests
and Translated Memory Requests, which look just like Normal Memory
Requests with a non-zero AT field. So a root controller that ignores the
AT field may simply forward the request to the IOMMU as a Normal Memory
Request, which could end badly. In any case, the endpoint will be
unusable.

The ats-supported property allows the OS to only enable ATS in endpoints
if the root controller can handle ATS requests. Only add the property to
pcie-host-ecam-generic for the moment. For non-generic root controllers,
availability of ATS can be inferred from the compatible string.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
From a while ago: https://lore.kernel.org/all/20200219222454.GA16221@bogus/
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index d25423aa71674..94d4a4914a483 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -110,6 +110,12 @@ properties:
   iommu-map-mask: true
   msi-parent: true
 
+  ats-supported:
+    description:
+      Indicates that a PCIe host controller supports ATS, and can handle Memory
+      Requests with Address Type (AT).
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.44.0


