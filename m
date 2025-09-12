Return-Path: <linux-pci+bounces-36029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F1EB550A7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 16:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944191D64668
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714A3101B9;
	Fri, 12 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aL6JFHwK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFC30F7E8
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686482; cv=none; b=l2h8T6F+QlaA7HTm6Q06SC5k8U6s2/llbmqoC1Gb5XYFD2cZJnDWoVw1S/tmrCYpK0DxCNBAdPZRObcNBzZsBNgQU3lI6xcIuh2mLQ0BXX0r8LfT7oZk7iLzUaebNcXaEw3oZhC4XHr0HsQqaShJxLT6cxGgoisI6pS9+NfpzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686482; c=relaxed/simple;
	bh=P/I0o3Ct3tb/qJdXM8/n0dAX0XqgE4/yICfEQ61ZAYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PHpqyfTl+wtDBbrlSpAchFc84xkS9KfBfcqHvZzOG9n1iSxHJZfrALyLZPxD1CI9LnDmKfLOm+o5TnXTkNETkccb2ouNZ50y1hikEXH1YtwMr0AFLu0bdaitHZ0uGTANhlrkm80afnlN7MEI4nCn3756Sx6g/xa4iiGLnvAdynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aL6JFHwK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de60d39b7so14573815e9.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757686478; x=1758291278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYPHqMTKCV/4SepZAwfa5rvCiamyWF/H10RFWd8DrNU=;
        b=aL6JFHwK23xkKMtouQob03v2a9zHWiaSdve+K6yEB+izJWMvTZnDB6Wtmt5NQuBaVi
         fW5mdSkWt/2m5woac6nszCxhQ7ZcLQjM/47Lcb8ky0UIJ6PjG6+hiaIlVvhmakchxrNn
         et/W3hmitlYpebfvtzEmlBwTwjAPIHMsCgkFrExmKUF3M9+wzSz7xORMbnoZ2ItENJx/
         1KrSM2SNwHFjDIaHAjhLQDjKE9u1WAsL90eEc+V9YpcSKAErN9vnxwziGKzvU5bE3RiN
         l5gv5HqHsCxLPZZK0cPZ7b+KZYlPX3nCs27Aap4HsSnENgPM7TcvUYIR7GIXb5+UFYw4
         bZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686478; x=1758291278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYPHqMTKCV/4SepZAwfa5rvCiamyWF/H10RFWd8DrNU=;
        b=blSXozMwLguaq2/q6/MG2Gu2qDQ6SVFeDm+sVZJeMCPlCft7DKrDtJ2sJCdDRawkta
         oS8tIfSNWZ0sBeLKj6jWiHXROHIZ9jbiuZXqMsEt1omxZUbE4BhaAVYU1MNibvftUZ00
         xHkGagD8+dqBTX7QQ2hd1D/LqyleZup1Ux1c2nTPA0rZH76vqlMRrkcgQFXeeQq9iYYG
         t0HsLB/yY6yI2x3T2XIoQuhbDeSWzMROzs67/Dm1sIkRwz1AvkA4QNl7BK3ES5n1RmsD
         BglFhXvEJvvxSpe97CxujNVyvvIR8RY7OVZGEfU7rKsamJYknqHIPNYItAZSal9XXUYA
         4MIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYqzh/CupcmoUMbXBwoBhHxBVuCeHoJ17URERiDqrg+SnEoDNr3X+xUwBySmSA/Yk4n0Tife0NW9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQcUN77mIkCkqf0IC3I4ZbHdwT2H1tkW5+zzos5WvMgN7/yP/
	169H9h5U1D+qPPLQFFBRYwrtVesVPKjiyG8ygKLI8FnH9gOr9+7gpj86zI59Hal6Xzg=
X-Gm-Gg: ASbGncvHaSmpxyiSR65o3AJH+5MUBUaV9Oh/P14WYNC1UDmLSC1Fjl/e3CFdzi6R2OU
	ajP3LOCqoUrE+HylVYBFgHrFFIbi5nJiCMltiNmLIwj+tqE8mWXDIcKa4jOw+oe3KAKoZ3fDHBM
	8PDf3EjFwpSJ4aKzrqeVDyKHk+hMAqcOjy/BpDYrRE2hqW8QAwN0HB6a2i2E003D8TSqhawKLnO
	qWweFTDfeHhVbQV74IJjNBRzuDHVLtMdB462jlAvmJizK30Alq86L7J/y7awWCXDJIBlBKQstZu
	haVRBOaHXfkYlSOmQjOm5ufETUKTNRPYCdebP2Z2aAzA6LMBLkAk1S9MyVLSigwhqRu45+Y5/pZ
	NSl/xdp0NMeapGv89OMu5d00B45g0+uSTjkbevqzqhw==
X-Google-Smtp-Source: AGHT+IHmuQ4etOmxfxR5erD34BAIdfgntlZi1sczMbDFjFRnIdZIcAxN0Jzl68sTWuowQwjuFwFKgQ==
X-Received: by 2002:a5d:5d05:0:b0:3e7:46bf:f8bd with SMTP id ffacd0b85a97d-3e765793224mr2876593f8f.23.1757686477682;
        Fri, 12 Sep 2025 07:14:37 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:40ce:250c:1a13:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6680739f8f.30.2025.09.12.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:14:36 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] pcie: s32g: Add support for PCIe controller
Date: Fri, 12 Sep 2025 16:14:32 +0200
Message-ID: <20250912141436.2347852-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G SoC family has 2 PCIe controllers based on Designware IP.

Add the support for Host mode.

Ciprian Costea (1):
  pcie: s32g: Add Phy clock definition

Vincent Guittot (3):
  dt-bindings: pcie: Add the NXP PCIe controller
  pcie: s32g: Add initial PCIe support (RC)
  MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver

 .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 169 +++++
 MAINTAINERS                                   |   3 +
 drivers/pci/controller/dwc/Kconfig            |  12 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pci-s32g-regs.h    | 105 +++
 drivers/pci/controller/dwc/pci-s32g.c         | 697 ++++++++++++++++++
 drivers/pci/controller/dwc/pci-s32g.h         |  45 ++
 .../linux/pcie/nxp-s32g-pcie-phy-submode.h    |  15 +
 8 files changed, 1047 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pci-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pci-s32g.c
 create mode 100644 drivers/pci/controller/dwc/pci-s32g.h
 create mode 100644 include/linux/pcie/nxp-s32g-pcie-phy-submode.h

-- 
2.43.0


