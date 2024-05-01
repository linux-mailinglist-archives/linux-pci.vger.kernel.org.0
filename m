Return-Path: <linux-pci+bounces-6923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E08B84D7
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E061C22B7C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555563A1AB;
	Wed,  1 May 2024 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRDLXLm7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F62101CA;
	Wed,  1 May 2024 04:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537738; cv=none; b=eUaBbA9jZ88RC/rURk2C7oejw2lzxdkIiPL8tpT22otPbSa6yyGzXyjYpONkqMcRu/hyeuP9P0iImoXqAT0lK+ioewcsMQDCM45Nyn/wB2t4oM7Enc+1UNmEUg0uiTzmq2HSjNWjf/m9f7//JnDCwgG6oyvVUfAFH0VNJQAgX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537738; c=relaxed/simple;
	bh=Bi3k5o31EBEeTNOe1xS3t73E+sXYptAQJpj1YtXKJnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g111+CLoM7d2XhP9uDzlkuciPkAhMmsVBUDeae8TQhtMrx6AZZ1Y27dIg0clkSRi0ioCcRhYmGiTzEv+YvM41D5YaUoCp7FaOqJQKrh9BOVYRJ5ky+LnjTR6fbG2EpgcO3WToZ7hrMQWmcMnS+QfiNDB5trz3uIj/rbZg2WrzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRDLXLm7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23d16b9bca7so590304fac.2;
        Tue, 30 Apr 2024 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537736; x=1715142536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhu1nMHCA71GGBaV2+JMGbpRXlXwr5X37eEjfglD/n0=;
        b=KRDLXLm74k/POcCfZnWBqwmnFnTBUuG0e2elhPH8yLI2t9R28MF1eXkGQS53euT/6c
         fMUZwj/6PF7H3XDcIuFd0CrgW0Hl6k6JHAcDCOqoDL2Acc7NjsDc+0CnF6m4VMCrcWRK
         m3COqzGnXL75SMhMbkr5J4uX44ams/IN2RzdGWuyavU+r2PnyKlTGPXNBlBmW/c+Em9c
         dFJ0l8XQOzFdXfC2m8twc8OXMqAryqwm3QSb1tj5VZQSLdPnqsU7QRV5vkwxc2vlQQah
         2o9+Oc9BqsQDHRST9UtAkYgLFigWQY4f6H2h/QufByY9d2KJln94kyPqKCP9GWPgg4Ub
         o14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537736; x=1715142536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vhu1nMHCA71GGBaV2+JMGbpRXlXwr5X37eEjfglD/n0=;
        b=lmDMCt7w/U/kSIkr0P8HQqqWhcT8qnUDw41Nq/XLjuEe3KYfaUKUxy2FFCFYtYfhot
         ZQR2W8CJkrSt4VQTsySe90rvZHqU++nxvoAKo90AqEZnTdLyEf+SU0x1c4+l4crKHO24
         S2oXVKc9CjL0rVO4z2AY6d7m5yrHV3nVWjDrLWo1/7FqKD329qaqw66aeJIIax0Vul6s
         ZatyDpyhxbNF1m+aGqVEDRxmn7VtyeXgxWpISFuxQKC78HF4VzopbfafgBfoi1AGLQ4j
         Rs8eSJiiGpItBb8LIFIOwzC8f8dkxon3Nx43Z1v5vcfT+BpX+KFlleB+ZDUSd4v497io
         xKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvBKJUICSHfP90s8j+qlWGPS2sm2qU+QZtQjO9pxkEJhqOSRFWESh7RQrhaYGWh/b6o6tjLLTz339WjlCukrRqGVWoAi24JAF6c3iv/OnWzNxZ951McGcmRT4elGUrcAz9zPun1SZp35d3yPHLmYHt2podZ7xKGygEQ0R3ttHtF4VoN0fTXL3Vuu12frFhqAM8i170+tQmg6XNRAwV58Dx++jE38t3HTFXqOT+ti6Bv+TwSRK3WL7W+W8cIFU=
X-Gm-Message-State: AOJu0Yzp1Mn+ME3NQE7gj0ku3RfrgnS8yvAx/QpwZVQ5z0+bevrIRIl4
	TPqy3LWKmZbncLwgOKLGxTVGf5zBfcHy+WDt6zImka84BUWpkt2q
X-Google-Smtp-Source: AGHT+IHQCvg0uGeSX3GSy0SQxhNpekZqlZ25z6AvRqygjxrSbbyPzxWlt83zPr/iyWGd6O5MGRnAig==
X-Received: by 2002:a05:6870:23a7:b0:22e:d4da:f34a with SMTP id e39-20020a05687023a700b0022ed4daf34amr1459185oap.17.1714537735928;
        Tue, 30 Apr 2024 21:28:55 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:28:55 -0700 (PDT)
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
Subject: [PATCH v4 RESEND 0/8] ipq9574: Enable PCI-Express support
Date: Tue, 30 Apr 2024 23:28:39 -0500
Message-Id: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
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
pcie2, and that's the only one enabled in this series. pcie3 is added
as a special request, but is untested.

I believe this makes sense as a monolithic series, as the individual
pieces are not that useful by themselves.

In v2, I've had some issues regarding the dt schema checks. For
transparency, I used the following test invocations to test:

      make dt_binding_check     DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml
      make dtbs_check           DT_SCHEMA_FILES=qcom,pcie.yaml:qcom,ipq8074-qmp-pcie-phy.yaml

Changes since v3:
 - "const"ify .hw.init fields for the PCIE pipe clocks
 - Used pciephy_v5_regs_layout instead of v4 in phy-qcom-qmp-pcie.c
 - Included Manivannan's patch for qcom-pcie.c clocks
 - Dropped redundant comments in "ranges" and "interrupt-map" of pcie2.
 - Added pcie3 and pcie3_phy dts nodes
 - Moved snoc and anoc clocks to PCIe controller from PHY

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
  arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes

Manivannan Sadhasivam (1):
  PCI: qcom: Switch to devm_clk_bulk_get_all() API to get the clocks
    from Devicetree

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  37 ++++
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |   1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 178 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq9574.c                |  76 ++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 164 +++-------------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 136 ++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 ++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |   4 +
 8 files changed, 469 insertions(+), 141 deletions(-)

-- 
2.40.1


