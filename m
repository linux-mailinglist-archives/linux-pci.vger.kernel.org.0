Return-Path: <linux-pci+bounces-24830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2853DA72E85
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086633B3388
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C020FA9C;
	Thu, 27 Mar 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV3vcoqO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDAB1F8736;
	Thu, 27 Mar 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073656; cv=none; b=DmCLyY/0c47G97evmCqcJlg+nPNWxJO4qXhL6Cew6Zm0mFSc9QAsjpNzXSx/8MUe5jmou4zHTMMtUghl7JPoTjupbDxfx1LcahL6EyoF4sFLYiZ6wY+Dguzt3jBWwTvQz5oHEWRa6rovxjQqX2ovHmnkP7gaPfp7f0tsDgEXh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073656; c=relaxed/simple;
	bh=DEt7nEClwnJ4SBU8HeiPuDhg2XrpLQRF46+7OEBIvUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGO4dfla07CZGi910wW41/DArF6lFEsHuYMRlZl24+5Y0Cu/jR+Y7E9JX6wmNVQwqnPY8TRBHElHA+Fy3K4Vk/r2e0XU2zt+XsoXIAf2mYa81fXKOSNoYmXZl2m/rl4A+NzgHvnSYBasCjEmyHAiy6aonBhf7ofSI6UNcLWx2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV3vcoqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9761C4CEE8;
	Thu, 27 Mar 2025 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743073655;
	bh=DEt7nEClwnJ4SBU8HeiPuDhg2XrpLQRF46+7OEBIvUo=;
	h=From:To:Cc:Subject:Date:From;
	b=WV3vcoqOor6w4RBDwBdmtn/+XUVjsZFnb2AjHUKslkFDLTBowmFaLOPlJ0OImErLq
	 lzgnqxURTqjH6453AwLTHF2QM7BSTalTWA87xFSoW5d9Ki/oNyRPIr+tJWdDAdmlIW
	 RBgTe3jnjvpi/Y9r3xlmHF6tPeqcn+qP+fdA/J11uvaBTnw89Isp4L50wszSl7A58t
	 zT2elvq+1631IeGKGFgDM0UZXhRClrQdYHNDTuCnRYDDU3mN9YpDWWQNmVWXEz4Pss
	 P3NLpjxtWtElGhNyVuSfcJ0Gqg3r0q2MAP5bgQTDzTXlUKdg6dpHg3Wj9uZHbUQuHS
	 vL8vvT2B2XYaA==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
Date: Thu, 27 Mar 2025 12:07:06 +0100
Message-ID: <20250327110707.20025-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last remaining user of pcim_iounmap_regions() is mtip32 (in Linus's
current master)

So we could finally remove this deprecated API. I suggest that this gets
merged through the PCI tree. (I also suggest we watch with an eagle's
eyes for folks who want to re-add calls to that function before the next
merge window opens).

P.

Philipp Stanner (2):
  mtip32xx: Remove unnecessary PCI function calls
  PCI: Remove pcim_iounmap_regions()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/block/mtip32xx/mtip32xx.c             |  7 ++----
 drivers/pci/devres.c                          | 24 -------------------
 include/linux/pci.h                           |  1 -
 4 files changed, 2 insertions(+), 31 deletions(-)

-- 
2.48.1


