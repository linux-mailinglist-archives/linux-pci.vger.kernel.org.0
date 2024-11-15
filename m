Return-Path: <linux-pci+bounces-16837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDA69CDAD7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8291F21464
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30521885BF;
	Fri, 15 Nov 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKimHKMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04F174EE4
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660488; cv=none; b=Tpgoo7M8DrreS1OGPwuKMtDlk/XIavNMyrdVt3wysg9Pav3jWLh30VNY/7YJlmrFK0xDiREbWntyKRcFU0xBMnpYexTVBxwzkgoyIEbn3JE4bK6SFxUgrY8WBERC/Jo2TPTu7Ws3ZeP1lELD0IoAvlwkWUYQC8yWeEVAMT1cjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660488; c=relaxed/simple;
	bh=VP2MmCBnKiNgO1dlC1zhl6TzleAseMVYdB23HXBzFho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yckf0GeVandVgFUigKG7veJUsIGI5pFqRJmQ/2JmdZcPJq8+PU3hGHpNqseynKu3yByrdrylb41oJKue0PF2XW86U9Ss9qvabeYXfNQ1SKJsGpbcHHyYBoHtRWLfv4LWhrEBq+IhSFvMclcT2kgeOBeg7bqh+VNA/CC2wqgz4Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKimHKMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C06C4CECF;
	Fri, 15 Nov 2024 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731660488;
	bh=VP2MmCBnKiNgO1dlC1zhl6TzleAseMVYdB23HXBzFho=;
	h=From:To:Cc:Subject:Date:From;
	b=XKimHKMvNHjtWxlcdJYk3IbMKRCWxbLsF9E26t+la9BkdZRnMWmOU5bE2fLGB1Bis
	 R91e+muxM3NkrCegYjHjpZ86i7edO0lSWryvcbK4C1HAwcZ5JP+EnqepjUzGDtwCEJ
	 GgtTYYgLr8EmOg3hqM+1H0RFYMY4I12paUdN8UO86OY+s1XmNT5qjKFHpXAOanQnC9
	 3g2vWWI3AJBi0efdOgXmj9ZT1wzRSCJhiWi6FeYwIaDVR/dUTFShMIMPmOv06+uAgd
	 D2d6HOKYS8WeazjicgGnne9O+iSD4B+eSh/AMWA1Yx46xcJRDLStTXZgOt6+4dSjm3
	 lwblsZtzeXyrw==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] PCI endpoint additional pci_epc_set_bar() checks
Date: Fri, 15 Nov 2024 09:47:49 +0100
Message-ID: <20241115084749.1915915-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=cassel@kernel.org; h=from:subject; bh=VP2MmCBnKiNgO1dlC1zhl6TzleAseMVYdB23HXBzFho=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLNubZazI5UD8isc5zFt/1opXJ4ELOE0+p3oS9+Bu7/U /7Dg6uio5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABN5/J/hn3HXnvZNB5Y03ylW MTl4pva5YVYsy6bdZx6em3VPXvOCxgOG/yk3k/Z+6tq0luWcqPYK6/tLjZ7VrdMwMChTizXf8eX cAyYA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series adds some extra checks to ensure that it is not possible to
program the iATU with an address which we did not intend to use.

If these checks were in place when testing some of the earlier revisions
of Frank's doorbell patches (which did not handle fixed BARs properly),
we would gotten an error, rather than silently using an address which we
did not intend to use.

Having these checks in place will hopefully avoid similar debugging in the
future.


Kind regards,
Niklas

Niklas Cassel (3):
  PCI: artpec6: Implement dw_pcie_ep operation get_features
  PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
  PCI: dwc: ep: Add 'address' alignment to 'size' check in
    dw_pcie_prog_ep_inbound_atu()

 drivers/pci/controller/dwc/pcie-artpec6.c       | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c |  8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c    |  5 +++--
 drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
 drivers/pci/endpoint/pci-epc-core.c             | 11 +++++++++--
 5 files changed, 31 insertions(+), 8 deletions(-)

-- 
2.47.0


