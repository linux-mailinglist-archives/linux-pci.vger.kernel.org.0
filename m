Return-Path: <linux-pci+bounces-2641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA7283F778
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F61C223BD
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D626DD1E;
	Sun, 28 Jan 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO0XW7jq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005506DD15;
	Sun, 28 Jan 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458485; cv=none; b=Bo/A3q+0zqFBvDgk724q4uq3ZWMr4aIjkmmPROBBXqnrH25EJa2KbZBYcNZMzefjaoFTLeT+HtEhbikG4uc/eSXTUVpG2wQXMg6d561gRgS1nnILumR0J2qZHwifeSwvqOs87vKrO67mgT6BZpcL9zd+7mG/iT9j5cBOCW2ZgVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458485; c=relaxed/simple;
	bh=IpK14T6a2JY3qyCdxkZ5SFrzyR3FJ/x2m+Xk2BjcEmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUeytbVpx2/j7B5UPu/AdTTsuw90iDoegSGrDZ64ghx0onCGlwL3HRviUaNpemaov4DYoNs1hgOSqfM3cisXpm0/UxK0YIR0SQCPRWrpHwNn5UziF42ZUfi2eV11YNEpKYg+NGR/pJFpjhKGpmUHPCe5a4i3sp12mpy8c4WYaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO0XW7jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEBDC433F1;
	Sun, 28 Jan 2024 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458484;
	bh=IpK14T6a2JY3qyCdxkZ5SFrzyR3FJ/x2m+Xk2BjcEmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KO0XW7jqw93EJKcmcjzQsUpU0CzDoOrGNA/vg8LQUoJ2l/EFHu6r6a4s5poZSGghW
	 +Zo190krE+0Ft0QsM2hDdBWQ5pwWwFdIhHoNHldneByJxnP8mvEVd8yFIo2x9XqDVl
	 BS7ZvAsDKVHQihQfFaxju1BcCibT63jRY3xQEpD0HAKXE3/hb/gWD5aErinVsrrzmZ
	 9T244DQQr/k0NOiB8aApoKamoNa567Xok005M/m6okKfkU24A2ftf6jeK6kvUTeXlk
	 vIVBUfdbCZ95G8loO0HJS3sFDxUtpGfGrSpiEvJfxyVcgXIXGkMFA4Maw2D+99W0Yg
	 wQbtK+IvGHONQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/27] PCI: Fix 64GT/s effective data rate calculation
Date: Sun, 28 Jan 2024 11:13:56 -0500
Message-ID: <20240128161424.203600-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit ac4f1897fa5433a1b07a625503a91b6aa9d7e643 ]

Unlike the lower rates, the PCIe 64GT/s Data Rate uses 1b/1b encoding, not
128b/130b (PCIe r6.1 sec 1.2, Table 1-1).  Correct the PCIE_SPEED2MBS_ENC()
calculation to reflect that.

Link: https://lore.kernel.org/r/20240102172701.65501-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ed6d75d138c7..e1d02b7c6029 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -274,7 +274,7 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*128/130 : \
+	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
-- 
2.43.0


