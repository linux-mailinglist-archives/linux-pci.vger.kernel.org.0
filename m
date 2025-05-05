Return-Path: <linux-pci+bounces-27139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B393AA8F7C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334461897BCE
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030071F8723;
	Mon,  5 May 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvX+ZyN0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9491FC7F5;
	Mon,  5 May 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437180; cv=none; b=hdbj0fnku8iE4bUBfrGQhsetbYI5h6VC4f/v6oaTp3BtnKlNknuG9C9ofaaqln7MttaOfoCoSYJl/cDZacPxA3fPDmna08Nyz9zsZ1DmrJj5usGD+yC1pFOK/lcMtHE3QOT2TwjR5t0qtTuf0WYsUyB6cmNaIpZOLTHSfotGxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437180; c=relaxed/simple;
	bh=DN3ERg8zsCk+ghA8/wCrbbGaeNolgYO/AVElrgswuPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWG3v/b9pfyIG2Q4dqrJ1OPInBqfLOtvGllkEH8OsSju2MnqA4q2+wH9bE0+rly/xbXRL+sgETV4Q/s3mPEx1PEcGWoNP14WfF+IMxQsKFGoICQ0q7ZfP0oJWE9rtMU/4bd/cRzGf3WmThgI7q3NLDlrKAJbY8VE81EW2uPOy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvX+ZyN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB01C4CEE4;
	Mon,  5 May 2025 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746437180;
	bh=DN3ERg8zsCk+ghA8/wCrbbGaeNolgYO/AVElrgswuPE=;
	h=From:To:Cc:Subject:Date:From;
	b=VvX+ZyN0o0c8Rt/vlhx+eqQs7PTPAfcpzfaOC5POHtDY5EQLrSbqNxsM0ISNy/5kt
	 UpcZCXGg/+SZ1i2OBxDec47MDXsty/6EdmSMt75EskDWSH+T5i0VbDGDlq3Q6bSrgc
	 c8sH3aMWiO1AVrrZa4dxRHwvYPYWxvpigmh01BRmxtuLPeEqKc/lD4HYpZvjIskyMO
	 SZu8rXFUgqlVFP8Crq7oG3ykIwWM6VHFnk7NZxa/YjfHRbyx6XNMgtjU8bbwjDYPxw
	 z/tD+u/m/GdGsmJGz3E201GdNx2IXcBk4BynOmJhCzScLW76LOp+hSt2p0i1tWSB7W
	 QYbtsITDux3Nw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/4] PCI: dwc: Link Up IRQ fixes
Date: Mon,  5 May 2025 11:26:04 +0200
Message-ID: <20250505092603.286623-6-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=cassel@kernel.org; h=from:subject; bh=DN3ERg8zsCk+ghA8/wCrbbGaeNolgYO/AVElrgswuPE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIkWrRZjAVWLDy3O2UL1886j6ZLzj/Z04VClRySY/yqN 8U0BJp0lLIwiHExyIopsvj+cNlf3O0+5bjiHRuYOaxMIEMYuDgFYCJO0gz/Y74oSLR29a45kpQ/ re58xCPP95lhS2esK4vZcspS/mFEF8P/qqaA0p92906vXHWUzbF4y//g6bPfhlmsnHbY8fO9Fau mMQMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

Commit 8d3bf19f1b58 ("PCI: dwc: Don't wait for link up if driver can detect
Link Up event") added support for DWC to not wait for link up before
enumerating the bus. However, we cannot simply enumerate the bus after
receiving a Link Up IRQ, we still need to wait PCIE_T_RRS_READY_MS time
to allow a device to become ready after deasserting PERST. To avoid
bringing back an conditional delay during probe, perform the wait in the
threaded IRQ handler instead.

Please review.


Kind regards,
Niklas


Niklas Cassel (4):
  PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
    ready
  PCI: qcom: Do not enumerate bus before endpoint devices are ready
  PCI: dw-rockchip: Replace PERST sleep time with proper macro
  PCI: qcom: Replace PERST sleep time with proper macro

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 3 ++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.49.0


