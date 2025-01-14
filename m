Return-Path: <linux-pci+bounces-19753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A1FA1108E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE56188710B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4121B1FBBC5;
	Tue, 14 Jan 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIHssNk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C51FAC5A;
	Tue, 14 Jan 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880993; cv=none; b=saDSFmhzN6W26PFwO9qtXCTUmYUYG0X21dQj8JmLNLywCwoYet1gp4gDaz+pGVRD9f/kLk/rfF13paaeLRehf6A0rk9N2PliOCdMoTGQb4ctUMQaeyqA/Olz59fbTKSYG0UT/3dgthULoeqGIcE4ZlIL6RXpZru9DROxAkSgbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880993; c=relaxed/simple;
	bh=qxcXqTocWpMZEeTw30FPBa/pDHGrp1L7EsOTECC6n5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ro1w2Uzs3hU7QOEGWdIUr+UHJDcRSts4/lT0lXMods/SyT4vmJxeI9wvOXPyz7244eS2IPJUdWtA1p7+ChaD735s5RL9uIRJ3ZrFY0pYtxarIc3NNO2/ePULEOvSxxrJQ0ipi/DRVqqnYUvIs+G3yJb+nMH/Dk2AmspUXG33G3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIHssNk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683BCC4CEDD;
	Tue, 14 Jan 2025 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736880992;
	bh=qxcXqTocWpMZEeTw30FPBa/pDHGrp1L7EsOTECC6n5M=;
	h=Date:From:To:Cc:Subject:From;
	b=KIHssNk0lYL2qMmsyfBpfGKstvs2u8K6IGSAjdR5P2L2CZpZwD8s3jicbqnOa6sOt
	 vJboBx5XWqX5Q9WzK7vgrcfBJagG0pjpiWCgqbbRuGBVvmt4/PSX8i7m5vROGAl2o8
	 kuY+U2FpD3EgT9raArMLslmD09WbDJL1zgHNmvdN/lvlKYnalng8nwV/Bxgo0aCfX4
	 Ahec8SLxGEj2kt82y9qHFo1pXOgEmOD8ga7TqmVRrdU8cdhIQTnGsdoJwDYoQL/iyM
	 vfj5dG733jkPFjNI1cjXC86VjgrPquHx+k9fHDS/r7eh++//J1/pG/4r/vAIcAtIlw
	 4MVe0x9/D0QXA==
Date: Tue, 14 Jan 2025 12:56:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lukas Wunner <lukas@wunner.de>, Evert Vorster <evorster@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v6.13
Message-ID: <20250114185629.GA477417@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-fixes-3

for you to fetch changes up to 15b8968dcb90f194d44501468b230e6e0d816d4a:

  PCI/bwctrl: Fix NULL pointer deref on unbind and bind (2025-01-07 14:24:06 -0600)

----------------------------------------------------------------
- Prevent bwctrl NULL pointer dereference that caused hangs on shutdown on
  ASUS ROG Strix SCAR 17 G733PYV (Lukas Wunner)

----------------------------------------------------------------
Lukas Wunner (1):
      PCI/bwctrl: Fix NULL pointer deref on unbind and bind

 drivers/pci/pcie/bwctrl.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

