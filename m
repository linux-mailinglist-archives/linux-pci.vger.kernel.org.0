Return-Path: <linux-pci+bounces-36511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18041B8A746
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 17:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DF81C82FE5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834AF31DD93;
	Fri, 19 Sep 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmhZBk7Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1231E0FE
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297506; cv=none; b=FC0wLBIaS5izB2c41wHVX6baQ82lWp6mOL2nh46ApMJ4XQmrwg103WMCBlbw/6Nv/P4+ZtZIlQsmxV9Ho4kyMVQHnNAMKLQeww79dgw5cPx816lcjmMvwcyusF0HpJvKqQhnvBfVsGzfu6fdaNOAHU62XnrWhDAgwEE7eNL8NJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297506; c=relaxed/simple;
	bh=N7YR47rPh9IYgAs1yBMwxo0aIg9W+HiNLeVlSehJYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dp1nV/W6Hc8yutByloMGL93TnqiZlRsYqeuCb0RMtU7uTAD8nl9lgvqtOUXCZzpgEOvTfj6g90bERhMeBfrnk1VDRns/hrs3x6NuZ4e+m2Fm0hgCrADWmElPMpnfTqXkpQ3DXnLpu65sX+c5y7+781UiJt9rwTJVwJzl5lvsKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CmhZBk7Y; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1776430f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297503; x=1758902303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtPW98rgBsi1AXsCtSgCobaGSpH9VMGiOKrsL1cwC2U=;
        b=CmhZBk7YvjaaQB1/Z8EKPyb7X76hrAYfY/BOhHSTKMMvJM4k8f8aEuMGJiCoevF5nb
         kXdBFDYOrS2JnpfqjeiB5BR2qdlyYsZv5KvNsMS0oT2d6ZPAgZWRCrD4J7dtoqmxqRXW
         +XtUc1gmBU2RnDlpArmgvUEMUGuoIWTqWuvlonNe8aTCgE2CBVXrqFHZolbZHEm1l5Y5
         JgiV+rRMBcn9Vmp+ofLgzWrNahe3fXsRYJqW+5Q3j8KdjVNYIxmRAkbqsGI9vr7VHRdn
         rwVOuEV1Hnd+T8vPuy5WDBq5i5CaFMRN/5bllbZesZVp/hie5OPnyBDNYNrNFJI+jMGs
         Mz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297503; x=1758902303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtPW98rgBsi1AXsCtSgCobaGSpH9VMGiOKrsL1cwC2U=;
        b=X2OM2oQLIeqzqPYKBeE5qP+QV5MZclP8ubf09rUhqOLCgVN4Dt03jcgIQnsuD79lBK
         8HraYRWrSiyYrfbNbrPN2FdsivGIUz3zLhTHe/XFdpL6QjPKA1+SCp6aROKYwuzyNc6C
         PUuOYns5bawjMQ+SVK2om34j67uJ8qOLQ+8EoTln+kwB+P5yvytuxgI0qGGlmzq16FVE
         DrqtDvk8F0raYsUyteuvOpHCqSpJ5V4fvkqhpB72v4XRkLebR0EyHDyupiQwSoqsZKJG
         AaW7wsySVQ80DLvziGOyogVfG3KV81/f+QyzBn7on1vuX2/+Twcc9/eLEJ0gozaZ6DoP
         ajcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkWHXwi6L2uqGfFXMsMrgERWcGz5e15JcwwFTVfDeU6lcPSG0SagETvz/wwYF+EyEAG15ZZ9/SzEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPc1Hu3vl7gCCNXtUtD6vdsNO/QOze6ajc+FJRQcTStpKXqg1
	oUIRKKiwLJbkunHUWDnmdDHO+ZeszEUz+3pb+CUHIqy0gATnD653H0pSrMkfuB9tQ88=
X-Gm-Gg: ASbGncvAm2q3dD9mzaq5GQ/gmYomATuOqNSaxnwLlgFzDaRADmIjgFxwqLKzNR0hS3u
	zPgaBOZf8K93HPq4XyIe2cCFW3UAgjJ6efTVgT1dCBWkR3Upx+FdFnUOD2x7AmI18p6/qfyu3zy
	4IHVDCA5EIJAXXDYLuEOphnrfLv5SkwWOw3smP1ykUcavsPApU7jc/ENY6uYg4CjfSAl1lZDZX9
	bGrr3CLKrPOK9V+02VIHmBHfgSIHBkJAoeWuudxIzacSXL54md2YD/f1i4e4oklvzGPnC2utKsx
	BRaC0elbeQ2qVVUmI8wGDvQi+qcnyZ3G9tNV8VUNXK5mNOH+CF7cxHcae63f0zAUelyFeVTaXlQ
	4V+nbTlHmZd2W71JfhO6F1yHCBBL+uuc=
X-Google-Smtp-Source: AGHT+IFYUaAn9i6Eqk0wNZqPapSoDfpti615G8HPJJeCq6Zt6cdqWx78zxKqOQok9+7kvdNqxLGyAw==
X-Received: by 2002:a05:6000:144b:b0:3ec:3d75:1310 with SMTP id ffacd0b85a97d-3ee205def16mr3262070f8f.30.1758297502881;
        Fri, 19 Sep 2025 08:58:22 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:9dd0:62bf:d369:14ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407fa3sm8367224f8f.21.2025.09.19.08.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 08:58:22 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
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
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 0/4 v2] PCI: s32g: Add support for PCIe controller
Date: Fri, 19 Sep 2025 17:58:18 +0200
Message-ID: <20250919155821.95334-1-vincent.guittot@linaro.org>
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

Change since v1:

- Cleanup DT binding
  - Removed useless description and fixed typo, naming and indentation.
  - Removed nxp,phy-mode binding until we agreed on a generic binding.
    Default (crnss) mode is used for now. Generic binding wil be discussed
    in a separate patch.
  - Removed max-link-speed and num-lanes which are coming from
    snps,dw-pcie-common.yaml. They are needed only if to restrict from the
    the default hw config.
  - Added unevaluatedProperties: false
  - Keep Phys in host node until dw support Root Port node.

- Removed nxp-s32g-pcie-phy-submode.h until there is a generic clock and
  spectrum binding.

- Rename files to start with pcie-s32g instead of pci-s32g

- Cleanup pcie-s32-reg.h and use dw_pcie_find_capability()

- cleanup and rename in s32g-pcie.c in addtion to remove useless check or
  duplicate code.

- dw_pcie_suspend/resume_noirq() doesn't woork, need to set child device
  to reach lowest state.

- Added L: imx@lists.linux.dev in MAINTAINERS

Vincent Guittot (3):
  dt-bindings: PCI: s32g: Add NXP PCIe controller
  PCI: s32g: Add initial PCIe support (RC)
  MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver

 .../devicetree/bindings/pci/nxp,s32-pcie.yaml | 131 ++++
 MAINTAINERS                                   |   4 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   1 +
 drivers/pci/controller/dwc/pcie-s32g-regs.h   |  61 ++
 drivers/pci/controller/dwc/pcie-s32g.c        | 578 ++++++++++++++++++
 7 files changed, 787 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-s32g.c

-- 
2.43.0


