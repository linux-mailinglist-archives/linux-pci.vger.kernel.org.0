Return-Path: <linux-pci+bounces-5296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343488F140
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 22:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EE8297D23
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57192153517;
	Wed, 27 Mar 2024 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR6OBFME"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25744383A3;
	Wed, 27 Mar 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576117; cv=none; b=M2gKLOfvCiS8NBTNjv7eonrAmaLWnPVAPxeJhSO7earo2EBqq41DZYjytxtNJmNxJhE4pbF9l93UkXZhs0uJlb8YNxwOC8eOsNbQmmDSFCh8v4v3yR+1IqbZlSf+n3Dgy5R4Jicp1oFNGZt0UHQCGp7Hma4hCSyDS+AFEWlhWNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576117; c=relaxed/simple;
	bh=kxTIljn3qMbQi8ISBUCuLR/Cn1aIMVKgyzvs4HWyVtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAnAnInLz6vdUiNE02TVpOXuuSrhZK6QeQoKGFtYmzP999zlKEI6C7G0tf2r1pb7lPp8PFTd1yEHBKSpN2yeikX1Q8acelsIKohiHS4w3XkK0/4aP0t9f6ALs232FPkbNe70b/Og0CbEkKIFNltcjZSHlPQ7WAqEcVov/CICzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR6OBFME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCCAC43394;
	Wed, 27 Mar 2024 21:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711576116;
	bh=kxTIljn3qMbQi8ISBUCuLR/Cn1aIMVKgyzvs4HWyVtU=;
	h=From:To:Cc:Subject:Date:From;
	b=WR6OBFMEfLKmlk2QPetZKRbjyXvbdrXrT3DP9Yg4/kSbgO4vn2D6W/P42lvwZ4g/n
	 AWLSd9XM5j1G0pBEhbS8Bhclx8XkTfbHX4bSqCWnO4+TOb3Wf4sizS+V8WnPqyAL5I
	 I5DxG4DlgXSvTELT+pTvF6ThewqMNpGdKgdSWabaTrJB/jRqNarSq3x1LXHBmhcTxn
	 vyhhh5Qn26YIJMHlQZaRuzWXEXtquFBErJ7kMFu1F0MzCsrgjGv1/3xhTek84kQ9Yk
	 nuEc2QrqTd4D7Xsow7l1ik/EK/9hKcYKMEyQ0LAT0jVvxpaaYlhH6B1hgoJWgGAvvR
	 Y1Ca1ojdAD6zQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Cc: Kai-Heng Feng <kai.heng.geng@canonical.com>,
	Sven van Ashbrook <svenva@chromium.org>,
	Stanislaw Kardach <skardach@google.com>,
	Brian Norris <briannorris@chromium.org>,
	Jason Lai <jasonlai.genesyslogic@gmail.com>,
	Renius Chen <reniuschengl@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] mmc: sdhci-pci-gli: Remove unnecessary device-dependent code
Date: Wed, 27 Mar 2024 16:48:29 -0500
Message-Id: <20240327214831.1544595-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the driver hard-coded the config space locations of the Power
Management and the AER Capabilities and included device-specific #defines
for bits defined by the PCI spec.  This replaces those with the equivalents
from the PCI core.

This also replace hard-coded power state changes (to D3hot and back to D0)
with the pci_set_power_state() interface, which takes care of the required
delays after these transitions.

Bjorn Helgaas (2):
  mmc: sdhci-pci-gli: Use PCI AER definitions, not hard-coded values
  mmc: sdhci-pci-gli: Use pci_set_power_state(), not direct PMCSR writes

 drivers/mmc/host/sdhci-pci-gli.c | 46 +++++++++++++-------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

-- 
2.34.1


