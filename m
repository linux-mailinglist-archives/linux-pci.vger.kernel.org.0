Return-Path: <linux-pci+bounces-20832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86305A2B28C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 20:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389603A525C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941C1AA795;
	Thu,  6 Feb 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7l6qokz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14221A9B3B;
	Thu,  6 Feb 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871203; cv=none; b=anJl+3Ik9qEKPUGy6tTWZ602j+WEc/cr6aiVh7L6mv68PSxD8MY+M0TxUu3v+4YmzXK4tKnbE6G9xQ7XpaW7BEW5E5mcsD+ELxnQ7bfVPVV7eT4JiQd6i6d0u5j6OKAvuHoMByTwvcWj3Psw0JfBjYeZvSZTvQcQ7Hr7WdOIyxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871203; c=relaxed/simple;
	bh=bL8+SOA+iQknnPek2QO1gBpHGt5W0YkY1YJTCqC5v8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z9MRyC+ypnqpy7bzXRymE37LfpVqEGo3Rb23DlgkZUn+S0E8RjLbcocGczvzc69yCaNi7jZSCzainGUAk6jv2Two2Y4RtA4PE7B6gjocvOGBWVr/aXf7joxsv/D2voDG1qGReefdSCJHAJr4Ea9X4Dt1sV8WCuhfh44Z/3Ez7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7l6qokz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727AAC4CEDD;
	Thu,  6 Feb 2025 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738871203;
	bh=bL8+SOA+iQknnPek2QO1gBpHGt5W0YkY1YJTCqC5v8M=;
	h=Date:From:To:Cc:Subject:From;
	b=E7l6qokzgWMf/ShhRfc4HxLBsbyuL51/7VMOa2jWaHCshBf9BcXO9UYzgz372YVHm
	 rT32KLY4syT7hGmk3WO6lKmFoVc/Kxzx6gUQx6U9k7DyHwzZ2aP/FjcsrJ46BzrLA1
	 HvS8foAqTrOobxI1U85/iFeZRlZJW/JZUzaZawmB8hvreoiEfbBcW3cn8j6Xg4tfdB
	 M0ZNyr0Yo61q7ElH2r3Ellmz81nXoMDgC3NWlLP3OicFpL4XMgGFt5vupVLiFu+5XO
	 C8v3kJ95opa309weBsZKIKaB0YPunYoFV18nGvucqdd+GCG0GxtvUSaNu9Un/MQr0D
	 PPkOd9oY7KJfw==
Date: Thu, 6 Feb 2025 13:46:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Huang <wei.huang2@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tasev Nikola <tasev.stefanoska@skynet.be>
Subject: [GIT PULL] PCI fixes for v6.14
Message-ID: <20250206194642.GA999100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.14-fixes-2

for you to fetch changes up to 6f64b83d9fe9729000a0616830cb1606945465d8:

  PCI/TPH: Restore TPH Requester Enable correctly (2025-02-06 10:30:11 -0600)

----------------------------------------------------------------
- When saving a device's state, always save the upstream bridge's PM L1
  Substates configuration as well because the bridge never saves its own
  state, and restoring a device needs the state for both ends; this was a
  regression that caused link and power management errors after
  suspend/resume (Ilpo Järvinen)

- Correct TPH Control Register write, where we wrote the ST Mode where the
  THP Requester Enable value was intended (Robin Murphy)

----------------------------------------------------------------
Ilpo Järvinen (1):
      PCI/ASPM: Fix L1SS saving

Robin Murphy (1):
      PCI/TPH: Restore TPH Requester Enable correctly

 drivers/pci/pcie/aspm.c | 3 ---
 drivers/pci/tph.c       | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

