Return-Path: <linux-pci+bounces-27612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D05AB4CB8
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F27F3A03F3
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 07:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A52D7BF;
	Tue, 13 May 2025 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4u91AU2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD583FBA7;
	Tue, 13 May 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121471; cv=none; b=GDNA0OiUvJxgf8dFOtp986Sn1C693qe7BpHnXWryjg6sjL+jQd1/9Kit4KkiTRhxT3yUPz73+PfhBf6BMemTjrKozXPAOWLMi1m/UfDk7YrPnMUHdxgAJwCo0vaAopHkjbj/dRK/aZHB2DS49O+93t1Va+zoncJjwUitvR/+vb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121471; c=relaxed/simple;
	bh=mhXaZrEiTTFXiKUS/evmkAlm33VGdO8jQP529dU/TcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L7iHCcqfGKyq1vzE/UmpsQBdloxG1tHJOmg8vvEIqLZxuCWK0Nm8Hwfgjp69iv9n85UJLzCKeOJpuYJk+SEJUv2klwOkC6gxdiIqUycWq3ZZv4aU1bOExsbPxERo1+ZWlf3KUNtY/ObnnoWbkmtLg9MiusqAFZAk+4AJ1VUUNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4u91AU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6A0C4CEE4;
	Tue, 13 May 2025 07:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121470;
	bh=mhXaZrEiTTFXiKUS/evmkAlm33VGdO8jQP529dU/TcY=;
	h=From:To:Cc:Subject:Date:From;
	b=X4u91AU2J6XsZ6JBGzmgxBbFV7gICrDqeuWvPYXUE8msg68HR6wlrPE47xgh8Af+n
	 mDESEXxZw98PYFNgN6FAJ11HWzjjro+gRvnaBKaxeUTiZ9DehzGKWPMPUrqztvjf6E
	 8Kh8FyvKV8VKb6RkAZPnzI9BJ8kwwDAVB08vGAdYZggjt8/cl0xUdgrZ5+aUsBIqA9
	 2SB8XyLch8rQMxbL/c1A5zX+c/SaZiqrbO0KMobQtdYujSomr61+zwoqsC/Ss4CFVt
	 B9wJ6OfZgAUwnhhTmnGedRW2i0Aemuv2mmZRspX61EK0qhYzw0bUO2B8cR+4x+AFq2
	 2CJdAi10sxaNA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Alan Douglas <adouglas@cadence.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/6] PCI: endpoint: IRQ callback fixes and cleanups
Date: Tue, 13 May 2025 09:30:55 +0200
Message-ID: <20250513073055.169486-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=cassel@kernel.org; h=from:subject; bh=mhXaZrEiTTFXiKUS/evmkAlm33VGdO8jQP529dU/TcY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKUvupfD9gqv7h4wy6jTLsv2isvS16bNP1o34J39dsff zhxK79tY0cpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmYi7A8N/pZq/8ok1uW8/7 pbmaaj3otZ0z7eLNnRIxK52so3dxiuow/I+2lWFyv/Zfxd2aWauR/fWK1XVp4Y/jd4UXf/gkyLA /iREA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The first two patches in this series are IRQ callback fixes that should
get backported.

The reason why the bugs existed in the first place is because the APIs
are very confusing. The rest of the patches are cleanups of the APIs.
These cleanups should not get backported.


Changes since v1:
-Improved commit message of the fix patches.
-Picked up tags on the fix patches.
-Added cleanups patches.


Niklas Cassel (6):
  PCI: dwc: ep: Fix broken set_msix() callback
  PCI: cadence-ep: Fix broken set_msix() callback
  PCI: endpoint: cleanup get_msi() callback
  PCI: endpoint: cleanup set_msi() callback
  PCI: endpoint: cleanup get_msix() callback
  PCI: endpoint: cleanup set_msix() callback

 drivers/pci/controller/cadence/pcie-cadence-ep.c | 10 ++++++----
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  9 +++++----
 drivers/pci/controller/pcie-rcar-ep.c            |  5 +++--
 drivers/pci/controller/pcie-rockchip-ep.c        |  9 +++++----
 drivers/pci/endpoint/pci-epc-core.c              | 11 +++--------
 5 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.49.0


