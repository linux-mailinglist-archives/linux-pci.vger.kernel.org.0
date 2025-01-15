Return-Path: <linux-pci+bounces-19830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DABEBA11A6B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD597A4491
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572E22FDED;
	Wed, 15 Jan 2025 07:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ7r0sXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3071BEF9E;
	Wed, 15 Jan 2025 07:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924846; cv=none; b=dZEwswHr9JIoho79HL/GHXfgXsbvLrbD/dHDxzyO3yDhuTiYtmNCl1i9T0GYVUiTiOJNa+BsM2WkC9YrAlkcsnCDJd9XmVakmTTZP1rF+oxe+SEOHxAeZcW9CHxMCPGnIygqwRBo/Z0cnFzMKoWGA8xTjRIserlWMpu/Y5vWeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924846; c=relaxed/simple;
	bh=XTuQq9QFoztAZFck9lS8cUE2dpg3yJxM/NZEEUI5JPc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uq6+UnV8AqKrE+XH2hADLD47nUUP0Ub4b71U1/FVCeGiGCenbWashdRrVLXSGo8lyddyFMY2vYxL8PSLKF+lXwDLHpzzIHC+j/0YYpzdgn+dP5Aq9dAfLLdD7MT4a5ZBeG8nbJ4KU2U+mhe3X2lPafQhNgQolewGOJFt9gOmzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ7r0sXV; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71fbb0d035dso3544967a34.2;
        Tue, 14 Jan 2025 23:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924844; x=1737529644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlFqZHbRMZQIsl21pBG7gtzE+yobsjoVl3cax1/kql0=;
        b=gZ7r0sXV/lguvpWLk1rTTEw6yU+nLsfUTxdRmFwcr8XijnGVYLLfkRCf2eQoIEDnso
         Nbk+vmYZp7aiTDBvDyJwEH5WVs5y8+LDjs8QtL/X+YCBifcedZSHA1Aj1ICjOqEVjn7Z
         inKYom+idrBWaTkaHXT7LsXrxnO8kaqT8G+XnYNt4IChWq3ple8gAHBvT3MBp4WxuK29
         2TjBXWNfqTF+udA8cOILbIe/GCOaJ6EA51j13TV1sgCOLfMWjyw6gfuuwCo/TBy2IIvS
         hkPrNvLfcVVB8vZoZhlzX8l7sJp9sx4WXZxwV2JfArtYmlgX1P+GVT0a/hgC8wRWtxQo
         IeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924844; x=1737529644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlFqZHbRMZQIsl21pBG7gtzE+yobsjoVl3cax1/kql0=;
        b=BfeT4b7nRdiYhrlgRCPWXiI02iyvjiTEpYuQDzh1mGAX/kXmG701woRh0BPg0rOuYS
         2DJytYFyFU/Z7QaPV+J3wKq/lIG5bGitBTlK3udJiXfPJ4E2UNOx5JO90+2k6v6pd/m5
         Bgqcrhs/M6ET3RcIcv9b7TmowJRO4F+RdgVTwphmyXbk6bGtKkuzRz6gcTbpeUpIG1BF
         MziOW9MqsdQmRA8YijUxOX/OhogE44HOWsscUst5R49TLj0MKKh7jxahr2GUzcFFlnQ8
         V21oVt1/Iw+yO7eH9wqQ7iXi6ZDi5wLZx4cXGjdq3B3pKhoCIovRYwxg6qeDOGaCaT63
         60kg==
X-Forwarded-Encrypted: i=1; AJvYcCVMruDuTYr1xK9E/0ilP9SlZnu+VIm8R/rJd0mk1VJBVexLGFuRaXAdrHFUpaLjSn7rRsi9B8Z1MjIq@vger.kernel.org, AJvYcCWW/mbi1i2Mt+omJiWmFWeOpygatsl33BDvmE5XKhYDJ+3wvoWUCrgyB/JIMXGca8el2PX3QoqCRdcjxqf1@vger.kernel.org, AJvYcCXWKCoZJ3V64P/SYei0l9cAL0H47bwXmTwAAvBONuUkE+Fy5A6dH8IisfLj0O37gr5/KJFxNCF06zrm@vger.kernel.org
X-Gm-Message-State: AOJu0YwErOEtsbnWgr74XY1ABzYWXQgzfDuPc30KcfYSDKEeOXyEgndk
	7bP1ekX0phx9vEP2QLoMEhrIbM4KvxS0xqh3/huYdev+AJsGfpgV
X-Gm-Gg: ASbGncvW+8VYdx4vP8u2r36cRsLl+ViJjUBmvGmCKXsD1Kb8u5xRN/tzu9D/HiAiUOn
	NYz957jPb72UWVVdk/pfzbKbi5iCwQKIQoy5CCBVg7ULJbiUIjaC30vrllh/P7JqealOQcFDzpx
	MkTLPMqXI1+Q4d5ZnopEMw4PTwVrBSmd9wCPq2MFYNhVrZoeCVHWc5t/+qaL9/bxs5JB3RRnoyn
	3QJAbG9yq/urQVdR7v3bcIUTVneqb7sD0AdZcDXgTDxKMop2PmzhKSDMWgo1ac2zzo=
X-Google-Smtp-Source: AGHT+IH2zwPcOIBs8+fceXZ8ucN4/6KD5TvWigTV1j9AmgF5uoZNytOQGOluCGEdhsiy5ijULWUSuw==
X-Received: by 2002:a05:6871:6507:b0:29e:63b3:8e2b with SMTP id 586e51a60fabf-2aa069b19e7mr15263626fac.37.1736924844191;
        Tue, 14 Jan 2025 23:07:24 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad80599052sm5992749fac.24.2025.01.14.23.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:07:23 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: kw@linux.com,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	lee@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pbrobinson@gmail.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: [PATCH v3 3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
Date: Wed, 15 Jan 2025 15:07:14 +0800
Message-Id: <a9b213536c5bbc20de649afae69d2898a75924e4.1736923025.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736923025.git.unicorn_wang@outlook.com>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Document SOPHGO SG2042 compatible for PCIe control registers.
These registers are shared by PCIe controller nodes.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index b414de4fa779..afd89aa0ae8b 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -107,6 +107,7 @@ select:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,sg2042-pcie-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
@@ -205,6 +206,7 @@ properties:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,sg2042-pcie-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
-- 
2.34.1


