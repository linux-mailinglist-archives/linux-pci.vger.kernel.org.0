Return-Path: <linux-pci+bounces-38033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9C0BD9003
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 13:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C8374FE3BC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A42D2485;
	Tue, 14 Oct 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bta5ycB1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C042DC768
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441174; cv=none; b=YagCsMsCCBsM310j6O3TF9FL7ezkhowWL2Ee/lmh8t+4jbDLo7v06Ep0gKEAI4pQP0Y581lzGyP0H6nsxQibB2ftNg4IgomqWOxF4Do9/FKIC21qluLkhXZNYUbBsZFLuSFV7XYJUrC56kfzZYz+N6KYRbL0KySKpScaFYpJSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441174; c=relaxed/simple;
	bh=AxhzSl8w445Qz2/9QmnikOtBEtA4YSeYe89CVab5wLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fXOj9UWJE0OxO46Uuo/FlHSCIH8OqvpQZZiOn3VQATZtcHoHbIGAI8w58GZtAn2JN5rQ35MOuNr4zH2Nda6gwZwevHEEU+pxLJr7WHLt0McMNyWuoQi+wynNma4zHDo0WKl5/q1abStf3NllixRW5umoqf921OfkfjGEQk7C15A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bta5ycB1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so33650065e9.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441170; x=1761045970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkgjM/J9Iy/ZQpNJ94vlbj27WexN53OWj0CXa0A7G+Q=;
        b=bta5ycB1i5svdSaKk/wvRw/YwXazpJL8e7sRG02w5K0mVO+o+DIgR/a2JIoFbhtKuj
         SPS61tSYPLJGhvN1gBoCGyoiGuyiV5MkY/z13UUbYxEusP+Tp35f7OHa3u/uxqTj5TOs
         F2JS9+GcxUvPdtBJ/vN1uW+BoljztnVKxz36w2x9U/ngZ9BW+ipMdp6lsSK7KrnBkqk+
         IwYubRRB64hq+s2yQmDjdJQVz7aMHJKAKOCrQ/oWLqN7ZyZA9jWUBv1pOZ1K659ffKxc
         AzrikcPwd4pLWOM1WkAQjI8pXA0OTuE9T22B5/P53i8e3TRe21KOYJVLTNd+PYekmGUK
         POAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441170; x=1761045970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkgjM/J9Iy/ZQpNJ94vlbj27WexN53OWj0CXa0A7G+Q=;
        b=Enl9uzPyqL4w/ftZD8acjHCZ6Kr56KGFvw3TOytoxu0GnD9Uy8RQRLNNnPLbGGleDd
         zVmTwxJ0O27vYo9Vx9wM0wB+gjQlUD2aDFu7IKjiX3VhDI5IsR7Ntsih28hZ84+X5uJI
         29l9P9gTzsuH8zlahlGYUX6p6/AlbQNHNbtHuwMaUupyuhlYxmo7K9rW4EkZfB65U3AW
         ETba5m3FsIk3/EGieYjJx10pBWk1OuPMxwJX5nOFrGe1BBOX6OVSoml7fmcq0y67E/kM
         dasjxTnBjwfnP0RcyeayeQivn+BpIDAttCIzZPHyor7kQxmF0ZnoDnl4UkYeSi5S4IRo
         gldw==
X-Forwarded-Encrypted: i=1; AJvYcCV3ETqAtqMlp3p3hytdVn+COlo1UqSCAY/B6x/1sKACRLPrtfu82IiFZB3XRBexGCZASuic6YIH1/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuNna64jhsuGTDplgF1gZ/prv1ckUBoCmGeGXF9d3ZNheqZ85
	L9WWqwgiV9c7jz8bz7LwCXzLbYPOy5A94UY7f49gi/NdjubGvavWxaSC
X-Gm-Gg: ASbGncvcPL4G1Vq+a6df3H7DjbsVbXJ9CZptLFtEkwBmchrlvrblaVV9J3Bz9Yo2XO/
	BKmiU43rsLNK0QJWmyyltn8Xiz5jWOVEt3Zz3eqllxASW8HQit7pZWVQZUH8gjI/lXN8XA/k7ci
	3idbewb1xqv7sIg/XYM88yhA1RhSpBHFPRfsi84QBjaTid7zv6yienVtNYwiZL8i8+OZm2H+1IT
	WFYhvEdICTfpVIIvMxx16tGp4o9wz5po07ADXOLPOQIxALExlm2XP1+HzJw16G1xvzijMS6AO1H
	klWPmFwHIM0fhcAROIt74x0sJLbONbnSUThdsxH+i7c1mf3nLuASvBOZ0qvaF8bh/ouJNVOGM1s
	OP94+msfkN8IQhNzNfwqw44zlobmPgjr8DqnjzHGPLxh/veopIrsn5jsqevKsVsdzYm9W
X-Google-Smtp-Source: AGHT+IFMf6DIq4h/prpv03d57pehdiVcP3X28cHjsLA6mXHmxzjuKa4nBjbv0JtAImSeizIQEmRacg==
X-Received: by 2002:a05:600c:628e:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46fa9aa0b49mr152941585e9.9.1760441170197;
        Tue, 14 Oct 2025 04:26:10 -0700 (PDT)
Received: from vitor-nb (bl19-170-125.dsl.telepac.pt. [2.80.170.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb492e6ddsm265829845e9.0.2025.10.14.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:26:09 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ivitro@gmail.com
Subject: [PATCH v1 0/2] PCI: j721e: Add voltage regulator support
Date: Tue, 14 Oct 2025 12:25:47 +0100
Message-ID: <20251014112553.398845-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

Some PCIe endpoints or slots connected to the TI J721E PCIe root complex
may require external voltage regulators to provide 1.5V, 3.3V, or 12V
supplies. These regulators depend on the specific board design — for
example, M.2 or miniPCIe connectors often need 3.3V or 1.5V, while
full-size PCIe slots may also require 12V.

This series adds bindings and driver support for these optional regulators.
When present, the driver enables them automatically using
devm_regulator_get_enable_optional(), ensuring proper cleanup on removal.

Tested on a Toradex Aquila AM69 platform with a Wi-Fi PCIe endpoint
requiring 3.3V.

These changes are based on upstream discussion:
https://lore.kernel.org/linux-pci/20231105092908.3792-1-wsa+renesas@sang-engineering.com/

Vitor Soares (2):
  dt-bindings: PCI: ti,j721e-pci-host: Add optional regulator supplies
  PCI: j721e: Add support for optional regulator supplies

 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 ++++++++++++++
 drivers/pci/controller/cadence/pci-j721e.c         | 13 +++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.51.0


