Return-Path: <linux-pci+bounces-43286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E888CCBB87
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E12C301C95D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3681A32D7F3;
	Thu, 18 Dec 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USQmiORi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6F32D449;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059495; cv=none; b=eAlRXQjNS4FAamKSyHj39KrTcq5Y0GiYVgur8SVZKEE1duGU4i9oLh5qCmJa/NrY99XZW/THyD1Q537i3e59eL4iJnXKNX+somZUhhMEh2qnk2WWeCVAwaZk+VkoDZ1nld4X0sNnyIEPTIdjChIFcycEW8VQHDcJb4w9ZCPnsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059495; c=relaxed/simple;
	bh=Un1QrMZoYgKUn6xmBehYxA0h/rJ2Hz8sTCOdXY7E7RA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3yCCsERJKcxpHUYYgSOHp8KFdwonZrmVfdiRRZ7C6nmhP9mU0QUUQ75COFrdV24bzqCEP7UDmqFMpbVWVmSRpgCGIKVUMWUhr8SBGdozzoBYXPlJD95l+HHoiGk2GQq9Cg1DCZK1ydJYlo6hN/3+z1V3fUcufcVs2JTT1NJ1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USQmiORi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7E61C4CEFB;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766059494;
	bh=Un1QrMZoYgKUn6xmBehYxA0h/rJ2Hz8sTCOdXY7E7RA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=USQmiORiUsCe+omxJqKu+dtNG4WL8V7V4LZoOF7K3i1vwbZEiEu9Qj8FWPiPwUDnD
	 7MFBoynCBOkQqr9RdKk2O7GHm+y5cXOLfC7YeoOQKpe0UGYmK30XazMhMZ8K/5S2cS
	 VjUzoq5oFDSWuB5Y40ZhPFVtl6RmwRCeiBcPJC6kCdqHlOIqVuzqWe2zSQOkeU9Irc
	 YRGuatpzAbdfwd21+k2+goPlHep2gWtxH/3MfjSNxy6UMsSgYEgnIqMHt+qth9OoxP
	 IoZ24U1cvP3wTfoIH7b32Ly0JJB4YUPNEx5dxhCMJE/EBQTgG/KkFL/J3Yz/P8yFBz
	 yXBHDTO8Mr0wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C875D6ACDC;
	Thu, 18 Dec 2025 12:04:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/2] PCI: dwc: Suspend/resume rework
Date: Thu, 18 Dec 2025 17:34:51 +0530
Message-Id: <20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPtQ2kC/4WNQQ6CMBBFr0Jm7ZC2Wi2uvIdhUdsqE4ViR0BDu
 LuVC7j5yfvJf38GDokCw7GYIYWRmGKXQW0KcI3tbgHJZwYllJZSVtg7Qj855IH70HlMYYrpjuY
 itNR2a/aHCvK4T+FK71V8rjM3xK+YPuvPKH/tX+UoUaC1XoqdUUbv1Skyl8/BPlxs2zIH1Muyf
 AHvgU/AwwAAAA==
X-Change-ID: 20251119-pci-dwc-suspend-rework-8b0515a38679
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Un1QrMZoYgKUn6xmBehYxA0h/rJ2Hz8sTCOdXY7E7RA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQ+3kzBf+R5T3XmBxJx1jwtjyxhR0q0MBrgOSq
 gQ2KZAsHT6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUPt5AAKCRBVnxHm/pHO
 9XQMB/9lQ8zjM+FyNsCcCwFroBXwObpbD0YykfOi+ewIXOuF5vKk15CUAnC3CVJawYn3d1aNcWL
 vdFowGdk+V6C8lxDBDg6dFVd6jpe6Hiip6cnh8sdshB3eb6dhpwE7zJ7W4G4yyAd3vhNd8jbKvo
 OT9TcRxksB24iFMnEeW5yr4em13jmgOJiWV09581OynprqXsOURthWdHWXaoWBbAa/QFf3R1A7I
 Dwyd1yX79v2K/roo5VZ381s8tfh0pVFUKXeUNQ8DZsZOv/1qvE0o+Yz5ppxBMlyHjLlhDfVq3HB
 AGq/xkVFuomqDR32qgHYVd9jFSuzWum3YSNrPBzdXh/IRoob
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series is a rework of [1] to allow DWC vendor glue drivers to use the
dw_pcie_suspend_noirq() and dw_pcie_resume_noirq() APIs without failures as
reported in [2][3].

Currently, both of these APIs will fail if there is no device connected to the
bus. This is not fair as suspend/resume should continue even if there is no
device. Hence, this series tries to address this limitation.

- Mani

[1] https://lore.kernel.org/linux-pci/20251107044319.8356-4-manivannan.sadhasivam@oss.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com/
[3] https://lore.kernel.org/linux-pci/27516921.17f2.1997bb2a498.Coremail.zhangsenchuan@eswincomputing.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Changed the logic to check for Detect.Quiet/Active states
- Collected tags and rebased on top of v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com

---
Manivannan Sadhasivam (2):
      PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3 transition during suspend if link is not up
      PCI: dwc: Do not return failure if link is in Detect.Quiet/Active states

 drivers/pci/controller/dwc/pcie-designware-host.c | 12 +++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



