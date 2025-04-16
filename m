Return-Path: <linux-pci+bounces-26017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F0A908EE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E38F3AF478
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0E21129D;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVCDUcIF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC01211276;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820955; cv=none; b=sxYhuXgpzDvLNWiOvEwyU0mOxrkJ8zFIIHdIujJd97VPh0UKLn+RgheLJMqy+mvDry82+LGuDDVuF5bCyMOARZg63UQqdgvE+bevzBzBHhBEBTZRog6Tyy63OKzK49VjYFVfrRcjDRZ0sdY4KjOnhPllb48swr7iiOlbifGLGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820955; c=relaxed/simple;
	bh=8w2ql223nYm+BErM3jbKkWekAvb+1IirdxYYwZl8YAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DqNmMzA8o25gfJBSQC/xGv7PiiBmxAwt+Vkvdxjlhd/gMbUw15OseCJ6hE1Iauhvb8mWUihS+w+Ul952kzJlHjHWwq8qexqPX3oBhBM0KXQoV/pGPAT1ojyNX+TecoVCgxtD+DSyQHzLfGRBjdS5FsbvfVprlEo6dbE2dUxNmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVCDUcIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 407D9C4CEEC;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744820955;
	bh=8w2ql223nYm+BErM3jbKkWekAvb+1IirdxYYwZl8YAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TVCDUcIFSljB2uo+bIYkxk8g/qfuweWjFtazSQOYc45nSoMnNTn8sdlpaXA5DPjrz
	 /0PkNb4B0GTXyI0VJTswXJMvCvu7h4I/+NZIXrP1L94tz2t92NJoPGM9XO3PLtR2+x
	 RjlSgcZfN+YtRK2V26yIDks52Edc6OtCaS/NhdpBQOuaHjuGqAlW+uwjMvKLKRBuEh
	 bbVVM3QcSWobvVaGN1U5P44+nzp79kKQ4plrJF+i6areGvOOv+BBGaHAhAw8GGGpwh
	 Ud+jpQmAZyBfHbvUrH+ADcTnuUGTQtCTGAA84W7bZIPAfvsl0Nl5jsmnb4Hpq7rt/b
	 BNl2wdUzX+i3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A80C369C4;
	Wed, 16 Apr 2025 16:29:15 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 16 Apr 2025 21:59:03 +0530
Subject: [PATCH v2 1/4] PCI/ERR: Remove misleading TODO regarding kernel
 panic
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-pcie-reset-slot-v2-1-efe76b278c10@linaro.org>
References: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
In-Reply-To: <20250416-pcie-reset-slot-v2-0-efe76b278c10@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=789;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=Aq+BoDTRwjfmiHKRLtODTEbwNFS8yDdFMEIJ4A/Pkz4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn/9rWO8MISVR64q676Pw7jrTyh1uamjj6mZUmS
 YdabH1Y02GJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ//a1gAKCRBVnxHm/pHO
 9bWZB/9jx+jNdhWu36G8URNn0X1XjAdW8YyUqH+VMtsKLIuiq09q37tDK/XUpiOURo7qF+/N32t
 qCsA2CmP5dW5v02FZRBbn1GYvjtaKjsr6BxPmk6rqCJ6LpPOJNQybN+taSVyTVDmmXqfsHf1Ieb
 fYa3lSy8KDNHy9gkynnX/6RIBwY29NVZH8tLD8xnTW0mcavswjXHpJaiu8Yljb7sNGDteE2t55t
 p8gZCWK9xdUsjz9vSRfjTHzYqKhMFlzahyrxvV/MEdc8N0rxX6LPT5/PD4VIWBvQK8s3SrUu4pr
 RB5gc0dqu0u5Wu5AhZYlAGbIbcTWNxKJgmK2EWFlSPd6gyU0
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

A PCI device is just another peripheral in a system. So failure to
recover it, must not result in a kernel panic. So remove the TODO which
is quite misleading.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/err.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffcc94e15ba6e89f649c6f84bfdf0d5..de6381c690f5c21f00021cdc7bde8d93a5c7db52 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -271,7 +271,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
-	/* TODO: Should kernel panic here? */
 	pci_info(bridge, "device recovery failed\n");
 
 	return status;

-- 
2.43.0



