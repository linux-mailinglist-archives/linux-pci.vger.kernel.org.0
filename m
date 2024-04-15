Return-Path: <linux-pci+bounces-6279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792F8A59AF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9F71C21076
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58613AA3B;
	Mon, 15 Apr 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbgowMOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0513A89E;
	Mon, 15 Apr 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205276; cv=none; b=S2qD6IT+4AajuEUlBv2zjTvSjFwXcVka8VR3UpUWOCIq0Cu03SNgvSy+rpU1sU8Ow6KmBsK9O0h0kHPCUuildLRnD1GVU/mVNC+PSwUdxgZtPbA9SDgrtRgFtXwdW/mHrYPNViuvKA0UM8U1y9FLdJ1WdrZz587V4rEJ+lrL8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205276; c=relaxed/simple;
	bh=Rc2DdJhNtXYERFfFXn8Tdq364UiaG6apBSUQyU5ObYg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NDLQy4r0EWRk6fKLrVHW8rKHr3gLeIQG3CV1/39mOJej5RQ+JftbqPJ9ZisBVpdaPx9mzNBerFAXbjIkNni3SD6l3RJsDpSSS36cssHbHR2OyXV+PunZkFpaQVyiZx+ke27UCtkhPNpdIl2GDNuIY/rP8lGIBcgpzBpX/Iu/m9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbgowMOY; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa3f0fcd46so2264259eaf.1;
        Mon, 15 Apr 2024 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205274; x=1713810074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+sACIufw/w8GpGeE4sEiBMvaX1bCTXDGNvgc5Qvf6E=;
        b=YbgowMOYlH2+ByQv0nskCQJOTHDxqZQFSI7ie5lDkwpJsZ3wurWRYXkcdy6HjCA0PK
         0+vCGfOPZ7N2c7C5ytJv+zoIu/fBaz0GqDXDDg8Ja/Aa1jAduhu+y529zSVghkPkTrX/
         XxmxLcPG9lueEhkVpH7tOQtfO6rMohg18zpw5uIIDAfIql4TpOoFF9SKFnCUWPvfj5Gh
         DElByl3WYNH+xJQL5ccUC2lOuJglYvNdu1Psmrrt/8IyLHWJYt7fbmas/3yfEk65JlJj
         1PFrnvENxIuQ53AYUjnwu22HlK1Q3z3bvEedfohe/zsdTW9xpMCLknlFIgD9CyWbfENm
         RKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205274; x=1713810074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+sACIufw/w8GpGeE4sEiBMvaX1bCTXDGNvgc5Qvf6E=;
        b=RIkc0GruDy4Hns5qDDdS2gSgpcJVQlYBIKya8lX7VVusAsu2tm6pYzu1oDSQlPldBw
         459pMV9qAap2GyQQndHlQrqjg+HDyRGOqe9UI+vK7aKnrFNNv4ZVdkQNqhgyIisX+rz7
         pycP8MNA62vwq6LlGtTnQy+ytgEBshd7ECBC7Gt8bCjHpbBxDqtnuER2SbTw1q0712gR
         wdGhnsoU8rCGdgwDFiRQ2G343FEjI0doJAlV6S76RwIil8mQKWKsMMqwnhSUziABee6L
         3YBk2DMUCpcq2ZWEA3+NfpDl+Svyq5LrUXyjB0mAkX62u5C0GSw5vppPJjuaBJyky1H4
         Zpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVUY3xxwHZtl8eqLO+lrnCfnE4vuzOyEilCXlQ2k5AX5JiNgPqk4XR/if3JNy/btMZYHs70UQi0xb2W7x8a3wed1/Jbk6gIazQqAfBGAMwKRpjE83mcyU+1Oej/ybKOs0NyNeNJmI3mQvUGJojOH6gihEyoKih+a8KcyK2K6Kz7dS5o1Tm1Sk1mxxVHH44QeoIoq+8Y/g+5pxEQvnd4KBzIxLlfhPr3LUTcorOycZi7jZLi9+LrUy4px0nxYs8=
X-Gm-Message-State: AOJu0YynaRoFabp5vxmBI3MbRJRhkwcROJL/scfYncGIzJEhjZ7kQtCN
	VqJ0dx5EBk2HPeCvTSzI1GV6sJkI3tH2zV3oEEPw5VEcqCLIkXSZ
X-Google-Smtp-Source: AGHT+IHWr/WeRMTapkOGUUH5erF0VV7fugiYX43aosyHD6DomWr2AEc2K79AjdmI5lspzTuJFUOGtQ==
X-Received: by 2002:a05:6820:985:b0:5aa:67ac:856f with SMTP id cg5-20020a056820098500b005aa67ac856fmr10305071oob.4.1713205274176;
        Mon, 15 Apr 2024 11:21:14 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2177494oot.11.2024.04.15.11.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:21:13 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v3 0/7] ipq9574: Enable PCI-Express support
Date: Mon, 15 Apr 2024 13:20:45 -0500
Message-Id: <20240415182052.374494-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are four PCIe ports on IPQ9574, pcie0 thru pcie3. This series
addresses pcie2, which is a gen3x2 port. The board I have only uses
pcie2, and that's the only one enabled in this series.

I believe this makes sense as a monolithic series, as the individual
pieces are not that useful by themselves.

In v2, I've had some issues regarding the dt schema checks. For
transparency, I used the following test invocations to test v3:

      make dt_binding_check     DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
      make dtbs_check           DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml


Changes since v2:
 - reworked resets in qcom,pcie.yaml to resolve dt schema errors
 - constrained "reg" in qcom,pcie.yaml
 - reworked min/max intems in qcom,ipq8074-qmp-pcie-phy.yaml
 - dropped msi-parent for pcie node, as it is handled by "msi" IRQ

Changes since v1:
 - updated new tables in phy-qcom-qmp-pcie.c to use lowercase hex numbers
 - reorganized qcom,ipq8074-qmp-pcie-phy.yaml to use a single list of clocks
 - reorganized qcom,pcie.yaml to include clocks+resets per compatible
 - Renamed "pcie2_qmp_phy" label to "pcie2_phy"
 - moved "ranges" property of pcie@20000000 higher up

Alexandru Gagniuc (7):
  dt-bindings: clock: Add PCIe pipe related clocks for IPQ9574
  clk: qcom: gcc-ipq9574: Add PCIe pipe clocks
  dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
  PCI: qcom: Add support for IPQ9574
  dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
  phy: qcom-qmp-pcie: add support for ipq9574 gen3x2 PHY
  arm64: dts: qcom: ipq9574: add PCIe2 nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 +++++
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  36 ++++-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  93 +++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  13 +-
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 +++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 8 files changed, 400 insertions(+), 7 deletions(-)

-- 
2.40.1


