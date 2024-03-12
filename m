Return-Path: <linux-pci+bounces-4758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086C87927E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 11:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785E71F22CC6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CA52572;
	Tue, 12 Mar 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAsP5egw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A759160
	for <linux-pci@vger.kernel.org>; Tue, 12 Mar 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240769; cv=none; b=hDEW6gzZxXdvcdbNy0MghGFhY9uE8SefOnmVKdrY4Q5W1FkusDCsSzREDby0Q0uY2DxAdMXITcCGiafqn64LklS8HK/TyiJcmrtRZq8VAlbugPu5SveNp+R0Lu4XAjB/zp8JRZzrjLikU7JP81OjiKP7JRrRs75oDR9EhCOCGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240769; c=relaxed/simple;
	bh=fjgTQUcExh1iJN93AN1TOYbTttNnPvt1KtONXArKbVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu48yqSTfsGYwOV5CVpHsdBI/c9jxoyhtsT7OQ7MMXeB2tePNHQdWzuAeoNK8P7meN3i8R4szFCHNc29eraovRqlSdwR3xaq9ReQz6zJ+7/JA9S7RxS75hJDALqpgXGp7BKb2/R95NI6qnW0WPXpmLejGc5rV3HJFMIO64+zGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAsP5egw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC6CC43394;
	Tue, 12 Mar 2024 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710240769;
	bh=fjgTQUcExh1iJN93AN1TOYbTttNnPvt1KtONXArKbVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAsP5egwKN40NjrnJhDP0W3+HObFATvnEt3jC0BzqO3W2sFcu0m3iLBnos5xWobu7
	 VCre9dtEf/uQYi9jIxNggTdfvpnyjsy+IFlp9nm0E5bU0eqtaqPVuOhECKstdRsFW0
	 ZOapTVEAoIa+9jAkHCmht5nRxudsygtbFRmYbCp9sGxMkliCzgGHj4lCGjn8qzjkeJ
	 0KNKjJ8/Cc+HMl3TAqJAc+04p7G13lys5nBmS1p6JLG0wax+bK4NpYyOHvhf9tZyFM
	 icHK7xnI0DtglTFq5uoWJj/oNlyxPsJPHosNPwmEi1w5QiOACJSEcAZlnjanFmcDC6
	 z1h101eQCX8tw==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Date: Tue, 12 Mar 2024 11:51:48 +0100
Message-ID: <20240312105152.3457899-9-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312105152.3457899-1-cassel@kernel.org>
References: <20240312105152.3457899-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
is invalid if 64-bit flag is not set") it has been impossible to get the
.set_bar() callback with a BAR size > 4 GB, if the BAR was also not
requested to be configured as a 64-bit BAR.

It is however possible that an EPF driver configures a BAR as 64-bit,
even if the requested size is < 4 GB.

Respect the requested BAR configuration, just like how it is already
repected with regards to the prefetchable bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c9046e97a1d2..57472cf48997 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
 	} else {
 		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
-		bool is_64bits = sz > SZ_2G;
+		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
 
 		if (is_64bits && (bar & 1))
 			return -EINVAL;
-- 
2.44.0


