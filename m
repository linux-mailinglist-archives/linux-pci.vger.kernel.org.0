Return-Path: <linux-pci+bounces-32902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E5BB11392
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 00:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E3A3A3DE4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22123237B;
	Thu, 24 Jul 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YupcIv2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4022A808;
	Thu, 24 Jul 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395011; cv=none; b=iNR7J1hJ7IIi/m9wTxBuRUVetG4od1jA21QYEzzoxU3wc524vd7ru2s9kYofiQfYERv92yQcF6+C7+F17L6TYze7ibwhZhOv/ha3AY6vMYR6KoX51x+h7kIS16trMARqevVQNen+qmR6M7caDU3RKyOdvk2nd2ZD9bT+nV41lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395011; c=relaxed/simple;
	bh=WiYdv21J0lroPNKayHfH2R/NF65g0CAPVnxQvXnRmHs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RAkZcaITuDxTC/jqKvVvoDuEEAoUpQb0nd7VZOOOP5QH1r0k50PT4ibcZotEQiYBwKga2WidVnaVSClKyO0iyqONqVzknhooyW5AqRj2l47nY2QKTl75tzEAheA7gF2svkNQ9BmGFMQmCXQy2eIUH1IK4J4qzFfPK/9Q6SS215s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YupcIv2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E2DC4CEED;
	Thu, 24 Jul 2025 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753395010;
	bh=WiYdv21J0lroPNKayHfH2R/NF65g0CAPVnxQvXnRmHs=;
	h=Date:From:To:Cc:Subject:From;
	b=YupcIv2bv8c0h3TKn6jwzc6uzcJP5aqCBIbZeI166WAVpOea/VNkY4YgtnogpOiiX
	 6iSvi7EaMbdU7vN/gx/s4fgR+z5R1MHLdis4Pef9rjhKbknkwRBPyDvdw6D8T7DlXN
	 VkHAfCfytD72WYeSK9iCBzVAwuc1sEvNEl9uw/a+2C6ri8euu8yxUgxaBwvFlXRBvv
	 kr1Syr7SWihu22oBHnBai908JjApOT4z4QoK666OAVxlNitBg1itw0nC+b5jrYfE7h
	 FM55E9vcn5Kn+owtg0qEgQ0coDMrRk7s04cPgVZxJPdrVkONVhFF34v8vHYvr+2oHd
	 YEi2SNYqXEb8A==
Date: Thu, 24 Jul 2025 17:10:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [GIT PULL] PCI fixes for v6.16
Message-ID: <20250724221009.GA3059501@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-4

for you to fetch changes up to 8c493cc91f3a1102ad2f8c75ae0cf80f0a057488:

  PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled (2025-07-22 13:36:04 -0500)

----------------------------------------------------------------

- Create pwrctrl devices only when we need them, i.e., when
  CONFIG_PCI_PWRCTRL is enabled; this allows brcmstb to work around a
  pwrctrl regression by disabling CONFIG_PCI_PWRCTRL (Manivannan
  Sadhasivam)

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      PCI/pwrctrl: Create pwrctrl devices only when CONFIG_PCI_PWRCTRL is enabled

 drivers/pci/probe.c | 7 +++++++
 1 file changed, 7 insertions(+)

