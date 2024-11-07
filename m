Return-Path: <linux-pci+bounces-16278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC039C0E1F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E9A284A44
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11F2170D6;
	Thu,  7 Nov 2024 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgIYwLi7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A316419;
	Thu,  7 Nov 2024 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005827; cv=none; b=ijwBVvEQDOCvIANyPDZE8qfkZemVjsieawuswqBL2grcQ0rcbeRtjgVbhO1vjW+DttMvqwwwwqgfRK2Be+HxO8ch4fkjM7mfP3AKU22qMENGHom7LG7E8sB3FOovLmRGdMVrACKbMSQ/pXlGcNnBIcFu8FP2Ok+7yCoEMDsyTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005827; c=relaxed/simple;
	bh=KgoHIHK9HSb6L4DrF2oE0One5R4DZ781NKRZgIxJ9WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXDRBm/stEpz0VmbxWO+lOgoLhBGwVO1VynrVP8dhS5AYa+fqXvjCjOSW38GP1HwC+cjIQnyDzB/8S2VsgJtoRPcDKaDJNCyl7RG1xjVixSQSS5cRQ0dFSA1a0paARmXGHBdh92G7E8vaychgLdZP6B9id2By3w0jneNr2LQq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgIYwLi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51920C4CECC;
	Thu,  7 Nov 2024 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005827;
	bh=KgoHIHK9HSb6L4DrF2oE0One5R4DZ781NKRZgIxJ9WY=;
	h=From:To:Cc:Subject:Date:From;
	b=mgIYwLi7ktL2jSfCAsPyLqRx7a6ei91eNs+6dUKcH1gFAAGZ9+dHls+DacAUNXPJ5
	 gTTLUT5+0ziG+qb1NbEIonnll2MyFN7EwL9HE/5qn+AEkPUpqhxl6k25ZSXBbXLOJG
	 2xrLEKXnWzq8JLIHKTvu3UsdFznzh19SJkqO+6+MZiA4gW1QPe2fbAR2iWm7y/jNnP
	 mZkybGoxK3mNd1+ECX1WFx9fw+psU0LMpFDtln4YVb1/ssFL7EWRb30itWt2X8dtTS
	 8WI7AkNcTxGx6GOADYkx6v/FuBYeJgyeOEYa/9VIXQfGrBrSMsq+0STPNPLj8E1aHF
	 0lzjqnRmfUvUA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org,
	"Ariel Almog" <ariela@nvidia.com>,
	"Aditya Prabhune" <aprabhune@nvidia.com>,
	"Hannes Reinecke" <hare@suse.de>,
	"Heiner Kallweit" <hkallweit1@gmail.com>,
	"Arun Easi" <aeasi@marvell.com>,
	"Jonathan Chocron" <jonnyc@amazon.com>,
	"Bert Kenward" <bkenward@solarflare.com>,
	"Matt Carlson" <mcarlson@broadcom.com>,
	"Kai-Heng Feng" <kai.heng.feng@canonical.com>,
	"Jean Delvare" <jdelvare@suse.de>,
	"Alex Williamson" <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1 0/2] Fix read permissions for VPD attributes
Date: Thu,  7 Nov 2024 20:56:55 +0200
Message-ID: <cover.1731005223.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1: 
 * Changed implementation from open-read-to-everyone to be opt-in
 * Removed stable and Fixes tags, as it seems like feature now.
v0: https://lore.kernel.org/all/65791906154e3e5ea12ea49127cf7c707325ca56.1730102428.git.leonro@nvidia.com/

--------------------------------------------------------------------------
Hi,

The Vital Product Data (VPD) sysfs file is not readable by unprivileged
users. This limitation is not necessary and can be removed at least for
devices which are known as safe.

Thanks

Leon Romanovsky (2):
  PCI/sysfs: Change read permissions for VPD attributes
  net/mlx5: Enable unprivileged read of PCI VPD file

 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 drivers/pci/vpd.c                              | 9 ++++++++-
 include/linux/pci.h                            | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.47.0


