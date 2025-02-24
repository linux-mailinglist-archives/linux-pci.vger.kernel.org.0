Return-Path: <linux-pci+bounces-22248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44449A42A78
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A440169535
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B087264FA6;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKY/Xj9U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E595264A92;
	Mon, 24 Feb 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419821; cv=none; b=MkKp1xt2+8dXq7KuaR7Vhg6uHfxfARoGOFyhzRtSkBXFvgZEo/BjvngtpnulEM7L2RpNQRUUOPNlVkYzXWTUCHpP/3pzXkEcUQW//NKZPqyaB/ByGIoDRgcTllZVHvjr1xIOsatWeOu0DW6eJLFr222mP7QseLh98QKTIDEEnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419821; c=relaxed/simple;
	bh=98Z6rWquwnb+oqau6pISJGfTMsaiWJKg9oR7AsN7MLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VtuHnP978L+TZmYEea0K9nKWylU9nY+b9jsO67TrvYpXoSiHvyWL28wdv53wjOE+notPCNNwc2c8xy1dcr5Xu4cRMC0W+X1dqCfA89+qoF/42heSXaK4w1F5sgeW4PfuBvMz/rW7uYyHDbzj8cSwAWtO9jNcQtJL14rEGSLfBGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKY/Xj9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E503AC4CED6;
	Mon, 24 Feb 2025 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740419821;
	bh=98Z6rWquwnb+oqau6pISJGfTMsaiWJKg9oR7AsN7MLQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=vKY/Xj9UEObtFXb1O4O4gx+CotG9LPPrPo5gAo61O4uqu9J5ffjOaiRUfAVLJB0ka
	 HpM/XaU+RLmv7AkPiP/i0hNMvycYKB9CYCGq79CZPkdb/C+IAmIti8lReIIn7ZS4xD
	 n3mkaMjX8b3PgQRj7zFvttEMxsJFTQnBxPQJ5EHd42SE36OrZwD4T/3QPCiUCrsyiE
	 AlQwg/fAgTguxyAvmu5P+TeelivESdJlhUC+vPvIaiRX+pDMKTE/OObOee/gXRU3QO
	 +26XZgn+7ih1q/d+rtPPcJzf/tUgcvZZxniPKWRB3FXx+rXpIG8vpqu4o4ninhj/vQ
	 xBL7EnxU5AwzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC103C021BB;
	Mon, 24 Feb 2025 17:57:00 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/2] (no cover subject)
Date: Mon, 24 Feb 2025 11:55:32 -0600
Message-Id: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSyvGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMT3aTSzJwU3ZLU9KJEI2MT3WRDC9OklETLtBSTRCWgpoKi1LTMCrC
 B0bG1tQDeDU1GYAAAAA==
X-Change-ID: 20250224-build-tegra234-c185bda9fd4a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sumit Gupta <sumitg@nvidia.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Vidya Sagar <vidyas@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740419820; l=723;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=98Z6rWquwnb+oqau6pISJGfTMsaiWJKg9oR7AsN7MLQ=;
 b=iARYKkm2gfxVmnVK8DYl1ygPH+MXiUi2obi+p9pHnMiJJH3kPeSHY4FES+MyFsGKXyVN4z984
 mxKf7YYuNk0DrCqYGfvBq/7H/VUvvLRujZj1xLNpRYw92WAaZu3INUa
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

When Tegra234 support was added to existing Tegra drivers, many of them
did not have the matching Kconfig entries updated to allow building for
the arch. A few of those have already been fixed. This series fixes a
couple more.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Aaron Kling (2):
      cpufreq: tegra194: Allow building for Tegra234
      PCI: tegra194: Allow building for Tegra234

 drivers/cpufreq/Kconfig.arm        | 2 +-
 drivers/pci/controller/dwc/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-build-tegra234-c185bda9fd4a

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



