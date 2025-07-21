Return-Path: <linux-pci+bounces-32661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81335B0C7B6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9A13A8600
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16498299957;
	Mon, 21 Jul 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uK6M5eBr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100317BD3;
	Mon, 21 Jul 2025 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112217; cv=none; b=YWt5lw1YCom/dSKeo/cPkass1rIeeYf7a5wl8RnwuiFDOkZYR2bm2c/j21VeR90N6AEu28zoF17tjLRNbVnf5donxQbM1Mp7tSTpYXHHhodaVp8jwTS/AJkU34BbBLMUxxKCGI5ldNF6v48EHeSqYYcPLuS6qfdgwWEiCzQFZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112217; c=relaxed/simple;
	bh=qX9OX5uKEymNFW/yiEYO36KT36RPvL+hS8FQnSGm65A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgBnDz+cslkgI7LcSSLgqJV8/HfUVQ70plhpw/f2nNzuxIgGAStCAVsFCgf6znCjUk2h1R7VP9/nXD4MYAOUzAZWCT7Blt1pl7Yg9o8ailrPQWPav8oqSOdtLVhVjxYzjJ/TgPkMsovwxXyRSzvOcHtt/f+A+Yl+Drh13RfMpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uK6M5eBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCCBC4CEF4;
	Mon, 21 Jul 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112216;
	bh=qX9OX5uKEymNFW/yiEYO36KT36RPvL+hS8FQnSGm65A=;
	h=From:To:Cc:Subject:Date:From;
	b=uK6M5eBrKfLpy/xJ0pz4aEfCb5VMAO7en8gk/AOfHN7aVptLtnu52K+FVnawQ7/Bw
	 ibZo0OLQxlFKFrgFttU8MglZftnPEramIOvJga7o1IAJv6lYA1tk6GQ9vUqGbU41my
	 Ot4oUSs3dHA2oImQefQMUs9YNzszzm2Vmrc84fqmZb8Kk42+KF1hIaOKMMH3X+uchm
	 41Argg21e6JWQSOwZAGjjFz/jrW09AG1dDorfY/CuBJapYXqGr+VmPICiXgGokVco0
	 8ZytN2/RMug9LXQ///4b1Ra3e75Zr7w5JRFv0IjHlQpEAlNqf13wJPu3UBpomm8sHo
	 xyhgjXCugEFkQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1udsZJ-000000002Fd-1be2;
	Mon, 21 Jul 2025 17:36:46 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] PCI/pwrctrl: Fix device and OF node leaks
Date: Mon, 21 Jul 2025 17:36:06 +0200
Message-ID: <20250721153609.8611-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes some pwrctrl device and OF node leaks spotted while
discussing the recent pwrctrl-related (ASPM and probe) regressions on
Qualcomm platforms.

Johan


Johan Hovold (3):
  PCI/pwrctrl: Fix device leak at registration
  PCI/pwrctrl: Fix device and OF node leak at bus scan
  PCI/pwrctrl: Fix device leak at device stop

 drivers/pci/bus.c    | 14 +++++++++-----
 drivers/pci/probe.c  | 19 ++++++++++++++++---
 drivers/pci/remove.c |  2 ++
 3 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.49.1


