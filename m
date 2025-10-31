Return-Path: <linux-pci+bounces-39948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D9AC267BB
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784F5425AF5
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510E27FB37;
	Fri, 31 Oct 2025 17:43:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C726ED55;
	Fri, 31 Oct 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932600; cv=none; b=OoU8MJJnq72RmKO+nTtjaR6FDlwZ2bbc7pzJhJsLP/jO/3nambx42aewwm785XTrkLCIql8emXiMRfmyQrt5+cZ691GLDR8S2F25GVv7aRXV6a1h+FOCs8BsOD97beMCJR0vkxAG1psBZIMH2c/kWHy6GSruPa2v5IqherlkFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932600; c=relaxed/simple;
	bh=vroR35+0m/WOqTCc3pHB+dq6wrRsNeMwH4SL+cTs0Zs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZiNQKPCFH7d3Kcwbrz7EAByJe9SuINBFSR3LHvi93tIPmoajLp2Ro6fQbKyBJyjESUt78eTlA9+H5lFggwT7QAWc4UvybjQCx29DuCzp0UlU6SQeY3UekUQHuTppra2LQhcKSbrZn/Zsk/pvFfa59OVbGaJE+yaNYNVN8fG75sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382B5C4CEE7;
	Fri, 31 Oct 2025 17:43:11 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/3] PCI: meson: Fix the parsing of DBI region
Date: Fri, 31 Oct 2025 23:12:58 +0530
Message-Id: <20251031-pci-meson-fix-v1-0-ed29ee5b54f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACL1BGkC/x2MQQqAIBAAvyJ7bkENJfpKdEjbag+pKEQg/j3pO
 AMzFQplpgKzqJDp4cIxdFCDAH9t4STkvTNoqY2So8LkGW8qMeDBL/rJWaOct9Zq6E3K1PX/W9b
 WPrPmlXNfAAAA
X-Change-ID: 20251031-pci-meson-fix-c8b651bc6662
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 stable+noautosel@kernel.org, stable@vger.kernel.org, 
 Linnaea Lavia <linnaea-von-lavia@live.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=vroR35+0m/WOqTCc3pHB+dq6wrRsNeMwH4SL+cTs0Zs=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpBPUv/ByYAMlVSnih7i/7vpgUV16Ct4fpIK8Kc
 YRDlbdh7viJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQT1LwAKCRBVnxHm/pHO
 9UKrB/4jcLEeWocGJwfF6C2jbmqDNLzp+AgmCielD3AzwWmZi1u/nuZk23uQrE/nUyALXisj1NV
 YTlJXdSp5Ua/KpwmqVwlEiRlT/2o7zQ1aZMjkBHuw3+RIjDM23ngzTsB3SfDidXqGoDD1vDwu6x
 VbvARVbvAhtStxViBSpXAgBNDBXkAVR95izzw989HAIQ1CFq2YhSSqgu8goOtWH5ZdF2rWdJnvm
 trXrsKghDytyE4UjlP/CztKgJYtzY3KnoWG/stR4IwIWGjQ0BXgPP9hx29yqFe55Y6PLSCVP+e5
 6AumRv0O79SN7H9dIMbI8Zklyo9bM0gWpgPE/Dkrp+1a/nn/
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hi,

This compile tested only series aims to fix the DBI parsing issue repored in
[1]. The issue stems from the fact that the DT and binding describing 'dbi'
region as 'elbi' from the start.

Now, both binding and DTs are fixed and the driver is reworked to work with both
old and new DTs.

Note: The driver patch is OK to be backported till 6.2 where the common resource
parsing code was introduced. But the DTS patch should not be backported. And I'm
not sure about the backporting of the binding.

Please test this series on the Meson board with old and new DTs.

- Mani

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (3):
      dt-bindings: PCI: amlogic: Fix the register name of the DBI region
      arm64: dts: amlogic: Fix the register name of the 'DBI' region
      PCI: meson: Fix parsing the DBI register region

 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml      |  6 +++---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi             |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi      |  2 +-
 drivers/pci/controller/dwc/pci-meson.c                 | 18 +++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c           | 12 +++++++-----
 5 files changed, 28 insertions(+), 14 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251031-pci-meson-fix-c8b651bc6662

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


