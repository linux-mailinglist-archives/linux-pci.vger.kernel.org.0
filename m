Return-Path: <linux-pci+bounces-23304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB53FA59250
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 12:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DAA3A47D9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1109B22759B;
	Mon, 10 Mar 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSib/8/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA0227581
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605051; cv=none; b=dFV1WxhrlFur6847SAZbw83EzjSc15cE7ke9c/2XzcHeOFfIU3MmSi3rooy86rrbZo1J1MPzeZXrSA4yDM76jhBfHMhwGppPoJjemQpifwFtdZhwcUQom+MAztN7tPbX4JHLCuKt8/xEpXJFchUUOzZnnNrfh+T9EWMZrLmOwMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605051; c=relaxed/simple;
	bh=AjaeKhM3K33yE7fZtjjZ3dpJr3wO04Qyn0K5q1TNDyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDEtcy2F1veEgaxEigfTr3RV2QX+rcEuSYe9ZlFa8pK1IXMnEMyvUKcPedeZqQs++SYdRerpg//0bCW304wO6HKuiL/NETtG4L0luOdyfh6vyEQ5Zk/6bxGQhaiob8EN7agUBhBNGW4VYm2fXaBQijJJZMVuIgbcMfgHivOB8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSib/8/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7BEC4CEED;
	Mon, 10 Mar 2025 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741605050;
	bh=AjaeKhM3K33yE7fZtjjZ3dpJr3wO04Qyn0K5q1TNDyk=;
	h=From:To:Cc:Subject:Date:From;
	b=iSib/8/XJSftWQI9PA6W2gwd/RpvYMWoKKap7N1gJW//Sm57yfbRGkwMMkoDDWzcx
	 R1vCb/KZTuSVrJ+ouWRbJtjaU+PXInNJHMhWxCQINWKhcUAYUs9kcAfD2+0MlcJK6z
	 gkdnZSwdZwU30jib3ALNMjZQP31w1YW2p3FohPeUttUydVFDw3wqIwsK7d9VCPCdNV
	 xnU2PSPcDXxZKORqT3NKvBE89R7EGEApVpnzFIlt+3ifU7pYjXW+h6Jlv8A9T48wc6
	 Tu2/KzlNY6oOPisjb18oy/M0fM3+QJbiFObvtV2I0f2jm8IIUZEfBRIhJ9Md/o+SsA
	 cGEzxfnMTzIUA==
From: Niklas Cassel <cassel@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org
Cc: linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/7] pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO
Date: Mon, 10 Mar 2025 12:10:17 +0100
Message-ID: <20250310111016.859445-9-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=cassel@kernel.org; h=from:subject; bh=AjaeKhM3K33yE7fZtjjZ3dpJr3wO04Qyn0K5q1TNDyk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPnZjB9WX2hsiHLQ1HnZrqxTx2lVz7ct/r6Nq7S8s3+ O7qVuuW7ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEpIsY/tnUa4Zesu57XaWQ uidCvM2jwiOG+62uilV33qts4f8nrzD8ZpnBY5u+1qFA7c1lIyOlxSdiHQq4WPjqGGd77OuLFDf jBQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

For the PCITEST_WRITE, PCITEST_READ, and PCITEST_COPY test cases,
tools/testing/selftests/pci_endpoint/pci_endpoint_test.c unconditionally
uses MSIs, even for EPC drivers that do not support MSI.
(E.g. an EPC could support only INTx, or only MSI-X.)

Thus, improve tools/testing/selftests/pci_endpoint/pci_endpoint_test.c to
use any supported IRQ type (by introducing a new IRQ type
PCITEST_IRQ_TYPE_AUTO).

Note that it is only the PCITEST_WRITE, PCITEST_READ, and PCITEST_COPY test
cases that will use this new IRQ type. (PCITEST_MSI, PCITEST_MSIX, and
PCITEST_LEGACY_IRQ actually test a specific IRQ type, so these test cases
must still use a specific IRQ type.)


Kind regards,
Niklas


Niklas Cassel (7):
  PCI: endpoint: pcitest: Add IRQ_TYPE_* defines to UAPI header
  misc: pci_endpoint_test: Use IRQ_TYPE_* defines from UAPI header
  selftests: pci_endpoint: Use IRQ_TYPE_* defines from UAPI header
  PCI: endpoint: Add intx_capable to epc_features
  PCI: dw-rockchip: EP mode cannot raise INTx interrupts
  PCI: endpoint: pci-epf-test: Expose supported IRQ types in CAPS
    register
  misc: pci_endpoint_test: Add support for PCITEST_IRQ_TYPE_AUTO

 drivers/misc/pci_endpoint_test.c              | 69 +++++++++++--------
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  2 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 12 ++++
 include/linux/pci-epc.h                       |  1 +
 include/uapi/linux/pcitest.h                  |  6 ++
 .../pci_endpoint/pci_endpoint_test.c          | 24 +++----
 6 files changed, 75 insertions(+), 39 deletions(-)

-- 
2.48.1


