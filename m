Return-Path: <linux-pci+bounces-44034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8A1CF4052
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 15:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26051304B3CA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D133290E;
	Mon,  5 Jan 2026 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMQIXrSI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3632C926;
	Mon,  5 Jan 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621366; cv=none; b=HsYhN8EhWg+G00zl9mv0mO1TfkstuIE07+yC6H7Yu20vZ+4So4iAuqR56Uuf/9oC1670m9XDQHDuhMhLa1cDQbbFxp9jqOreR/aqLPAmvKCFEd7sirbgiWB26/XpHtgn4h+g1qi0W2TpQx4IuWNcu+/1JzUqDg+GENR/wJgkBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621366; c=relaxed/simple;
	bh=lHNnF+M58t9NzRqWY9vnDhJTtOdSji0qAoWQ/MNoaYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9lgRa2dA5Nk4BO4hiyuoCoV4bL9u0oXg4zEB0wnPeT3CTXB6a4mznXkAjP7hRzIdd0Eui2JKANwm38NixR6iCHIjcCcJVLn50XSP1ksM59qTjUFnARRVgdwtKl1CdnS7pw9PS5eQB12KN46OdkwfPk1jG/XohEamWIt4ODElmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMQIXrSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B91C0C2BCC9;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621365;
	bh=lHNnF+M58t9NzRqWY9vnDhJTtOdSji0qAoWQ/MNoaYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qMQIXrSIaKkwfO3kl94qVYE8Vb9j3655vg/DGN3QadFLRTniHvRIrSRxhZjmPjpfO
	 a8uFvnKUi1bsi2VkNEFLRkDBGDHmuqCUmdKgeFQYK0rskw02IHlF7wKDXdhsiBgWZ+
	 CNbsAFCJ/yCYvnjJwaXUFoQlSHTtkiahGq+BQz/PVE/JAeMDLaejqECnhSrcaWn6ab
	 iBS2HOWfsofPDg46alciFyRGKbA4O3OXmVvM0I3xZf60I2+aiBL30+JVsxL36Tl9MJ
	 E6qDcNvAss+KvJ1n21FwinfZQCxdHdL4QqlKgx5r14ztu/wccf2/o+La29n7wCY+IB
	 kD/Q8JJDMnSxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3ABC79F95;
	Mon,  5 Jan 2026 13:56:05 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Mon, 05 Jan 2026 19:25:47 +0530
Subject: [PATCH v4 7/8] PCI: Drop the assert_perst() callback
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pci-pwrctrl-rework-v4-7-6d41a7a49789@oss.qualcomm.com>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=825;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mldIwFB+pfS0iHVRsCTaT7tjmBqPl6lu5qJtujWhd3Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpW8LyVBYfz3xhbl7+el0cIb91U5kt94P74OLiw
 o1Yhqe8zF6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVvC8gAKCRBVnxHm/pHO
 9epHB/0W4m7lYWGPNArq3VBa1EUKqIQ0qyhqXo2i+3axGgso/fDwuAtXcwiy7qPUJXVhrbrx1OG
 FeZu7WPbVDvZCBcnW1aASyZCX0F7vG25AihVgarQSXeJPXJTNmXwhu35ITKMVLQxGS6540DFwO4
 muAf/va91gx7t3s0jESMW6U/nqnu2JqpNNyC1SFS07Q+1NtTgHoflODnZY6XI435G6lUQUw/BI0
 wWMJvKAykAEll5V/cmKbgbaO/IpaK7wNUmftRGhjtkcjqqO2TsWl+L2FF9SCMw9UnfvlMIiGvAl
 AD0cHLWjQz05llQyOu+yGJVFH0ZbxhjBwiJs+ARa6fME8pWN
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Now since all .assert_callback() implementations have been removed from the
controller drivers, drop the .assert_callback callback from pci.h.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 864775651c6f..3eb8fd975ad9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -854,7 +854,6 @@ struct pci_ops {
 	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
 	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
 	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
-	int (*assert_perst)(struct pci_bus *bus, bool assert);
 };
 
 /*

-- 
2.48.1



