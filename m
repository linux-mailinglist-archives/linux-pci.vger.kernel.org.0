Return-Path: <linux-pci+bounces-23112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65091A56812
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549C13AE643
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A41192B77;
	Fri,  7 Mar 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7ViVJrD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A391214A4C6
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351665; cv=none; b=G6UD7AFugMR3b1vrqDV+b5Atab/3LHu2yf5bYLY6ZPl4dyX01qQqrr9PymYZUBnZ+QG6mzxJTUQhrtYO2CY3GbMLqUxFcj/+L9N81rszIHbxQco/EuCC6ScvgBv5cxKIcOc4kXLvRC6DBN3xHPMbsWu0h8+UKeKh2MnFw5qnIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351665; c=relaxed/simple;
	bh=eebdH19nLfGoKUJNH34HZZaZP6NaKX6DEIiCpB3f6Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8IwXHJYI0VK7Q3AUTyilxP57e9y3/lPdc/CgM6XOdSMDBzLFE+fhZ9fUkKnQu/F/iMQGKI+vnVFCjADuUw6ld4M4GtPqVyPTTeoPU/i//X+tPgQMcxA/s/tPuoCwj+Ebwj14IbY9DwvW+n5dr+yPeVF1I2ia+d5Ij1Z4FDUUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7ViVJrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161CDC4CED1;
	Fri,  7 Mar 2025 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741351665;
	bh=eebdH19nLfGoKUJNH34HZZaZP6NaKX6DEIiCpB3f6Lo=;
	h=From:To:Cc:Subject:Date:From;
	b=u7ViVJrDpqN+mT4mZT+xSYO2ClkyDG9Rl99wfsKlhmViodfOMLWWUHJKtOp67z7nT
	 oaydjmQqP0KikpvOZaSWE0JTQ9S95T+hV8DvWUvEdITFnCe2cucrUxRCzEuVFyvDQY
	 V8rLg8FzZBFUeoKXmJqHvnzjvSHpo7BMXHebAETsmLH4P7Nb0Oo+fTEcz4cv5syV3G
	 mGWqlvXg7ep2XHJr6MqLmpzieiVm8MMCmMfTfmQmVpDCAjiKWDzVuhShSYiQJS+xIt
	 eAEkg5QsmDm5gu5cmJje6w97zEGAL59WjM+eXgx2Ak2W8CGMAOt2krjPR2rWi52U03
	 80BvM/yyeOf1g==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 0/2] PCI: dw-rockchip: hide broken ATS cap in EP-mode
Date: Fri,  7 Mar 2025 13:47:33 +0100
Message-ID: <20250307124732.704375-4-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=cassel@kernel.org; h=from:subject; bh=eebdH19nLfGoKUJNH34HZZaZP6NaKX6DEIiCpB3f6Lo=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJPvXpafsFIIHRO3LyM0/ZJLn79s6V+hJ5c/mP+0eq0x OS7z0/f7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEvGUYGTo19W8/XZPRc6aj 7iLTj3npXuf+hp1Jvx/89vBylrqP0qqMDP2LPSJ+vV737pGQ7IN/b38oL/r19/Xta8azzwdvSwi 7JMEOAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

Address Translation Services (ATS) is broken on rk3588 when running the
PCIe controller in Endpoint Mode.

This causes IOTLB invalidation timeout errors on the host side when using
and rk3588 in Endpoint Mode, and you are unable to run pci_endpoint_test.

Solve this by hiding the ATS capability.
With this, we do not get any IOTLB invalidation timeouts, and we can run
pci_endpoint_test successfully.


Changes since v1:
-Created a generic function to hide an extended capability.
-Picked up tags.
-Improved commit message.


Niklas Cassel (2):
  PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
  PCI: dw-rockchip: Hide broken ATS capability

 .../pci/controller/dwc/pcie-designware-ep.c   | 38 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  7 ++++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++
 3 files changed, 72 insertions(+)

-- 
2.48.1


