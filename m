Return-Path: <linux-pci+bounces-27260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C97CAABC59
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 10:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D618979CC
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D387719D898;
	Tue,  6 May 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhP+SbQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4972617;
	Tue,  6 May 2025 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517187; cv=none; b=buAn44phSgBnDiNdX5K+UNVzgrJD7qjO+vXX6tWhD2k0MQhmTCeUxAeszpd0IY9t7hFuqibAdAaF75IPZUu+XmywgpqA9QWCNyDS9fY6OxZCSVAw8nTcwUB1mrXC6Gc1xKO86igAOmehBCo7m4nwxc9gkxdFoj0oqN8UWhqpmM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517187; c=relaxed/simple;
	bh=6TO1Noew8Rmq68imwQlh7EbC0TUncfmpyl6I2bKeN58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKbNiwussYw/sJuNKm+PRdyYSCjABueFNyg20UVBTPhZK8DwSn1c4GPTJSzikr+GiiC3Cthqal2utC4GZQLTkS6rARpATDWlSrkEKXB+uT2tDZnR09glKREbsqTFpBll6ya5r9JG/mpbd76LWAS1oCfLbsFay4IyANL3sMkb43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhP+SbQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC72FC4CEE4;
	Tue,  6 May 2025 07:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746517187;
	bh=6TO1Noew8Rmq68imwQlh7EbC0TUncfmpyl6I2bKeN58=;
	h=From:To:Cc:Subject:Date:From;
	b=JhP+SbQS09oMuqBK/ge4+Dtfkcli4nE+FZi/DJzIVogt1qmZkjF48k/6ArdpNBpF7
	 fFpvn2BM8nxjsNuRjWn/Oy4ES9XfnzeRFmso7qlS6CuJ+wGDm7JcMBKQ+EFTj8nJ8Y
	 frQmn8JaoxioWRf0W4akI4K2ZfF18ktCkJClGOxDjmAa0isSVr3cddW+2WMRvnVTNm
	 MoJckLJLERjy1VU8e8RRb4bJekKkX/5kY/ZEjIrHuo3A08eeqpmT+42310hMt657GZ
	 ssitxgJA98PnbT92FxWQWdB9cq9QMUcl8i6mUWYCMrc62BkPbmHR2mYQ5kSYO8QTdG
	 BEq/LbIifYFQw==
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
Subject: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Date: Tue,  6 May 2025 09:39:35 +0200
Message-ID: <20250506073934.433176-6-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=cassel@kernel.org; h=from:subject; bh=6TO1Noew8Rmq68imwQlh7EbC0TUncfmpyl6I2bKeN58=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIk92wLWrd5lVmczqKAgpU7yzdY7pzss2OB3T/mIBs2t ajntpskO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRp6aMDLvfL2tZ6iK56ULL O7UPdmfNE3btEPNWlTzPel9f0u1N6gGGv9KrbBesdFxjtkX1+JnUjDN/rkreCJjvVMrdING/cyF bDisA
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


Changes since v1:
-Added missing include pci.h that was lost during rebase.


Niklas Cassel (4):
  PCI: dw-rockchip: Do not enumerate bus before endpoint devices are
    ready
  PCI: qcom: Do not enumerate bus before endpoint devices are ready
  PCI: dw-rockchip: Replace PERST sleep time with proper macro
  PCI: qcom: Replace PERST sleep time with proper macro

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.49.0


