Return-Path: <linux-pci+bounces-6207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5B8A3969
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A11C21094
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70D7E9;
	Sat, 13 Apr 2024 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwljTYxv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528D4A24
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712968883; cv=none; b=NBSXK0fAkPGOLm7v07Yr5brdyH9E4w0hEOzqlJq8A7vJu/lCCvZxThTrpRKaWBS6i0m7Az1RsH8CkmsIx6gE8jsH1Yzg2GBJ70g8nnee8xv74SHh6saNR7XesCpd19YRhyaBicQIeRIvSIpoarhKSVfuoeGi6wvg+VRbtnMEguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712968883; c=relaxed/simple;
	bh=XfleRWVDTCRQj+kJIUPQXXmcjo6dZHce4XUmyc7jW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rug9tDtvDwGh1W+tbr+AubSD9nnBrfl/IAfWPMXx5/I3rDw7crgDpAXpXGu8xzdKPIgdo/Gd1JhNyp0+6O8UXihYoOL/uG3AQSzNpOY167iOpsrL/PsZPhFKMB0itsnvKWjO7PaKpgbVrOGTyouT9Dq9mhRxk1hyVjm6rb/IGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwljTYxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBC4C113CC;
	Sat, 13 Apr 2024 00:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712968883;
	bh=XfleRWVDTCRQj+kJIUPQXXmcjo6dZHce4XUmyc7jW/E=;
	h=From:To:Cc:Subject:Date:From;
	b=VwljTYxv5KDWTkQnYGJwIjLgyUDUfsfOlLlodoeGXk4Exz4JyUub0Y/e9L+npahCp
	 M3SJ2iaLCMShG4Syh1xj65+hSAy6QZ+/iwbR7BUjYkLQRQYKNfLJipZLqjkQdpQHK/
	 39yMOo6m3YTBqCT0YZBlkpKk99J4RypGN56WuwT/5wXYznMoXnkmrDGRp4uDROPIN6
	 NS2sTCHO25ardMP83yY0xJD7/8t76+o5twe6a5sTHdsCz7rQ++0OIHbSgCcOh5ScFi
	 nZrH9qhpx08CH8y7swQ075+XIwdntWTciLHfAXLRLCy7vXYlCKEgEkiX2UJyYm21fV
	 xP2akDN0zed8w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/2] rockchip rk3399 port initialization fixes
Date: Sat, 13 Apr 2024 09:41:18 +0900
Message-ID: <20240413004120.1099089-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of patches to have the rockchip rk3399 host controller port
initialization follow the PCI specifications around PERST# signal timing
handling.

Changes from v3:
 - Fixed commit messages as suggested by Bjorn.

Changes from v2:
 - Use PCIE_T_PVPERL_MS macro in patch 1 (and remove useless comments).
 - Split second msleep() addition into patch 2 as suggested by Bjorn.

Changes from v1:
 - Add more specification details to the commit message.
 - Add missing msleep(100) after PERST# is deasserted.

Damien Le Moal (2):
  PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
  PCI: rockchip-host: Wait 100ms after reset before starting configuration

 drivers/pci/controller/pcie-rockchip-host.c | 3 +++
 drivers/pci/pci.h                           | 7 +++++++
 2 files changed, 10 insertions(+)

-- 
2.44.0


