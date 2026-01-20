Return-Path: <linux-pci+bounces-45300-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG7AJLvNb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45300-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:47:23 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF849C1B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50551A4939D
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BDB43DA2B;
	Tue, 20 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/jsnfDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8D43C059;
	Tue, 20 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931267; cv=none; b=Ln2qVT5fXcbjTnkH0CGYuazE8Oj0egyoVHKw3ZiL3iLpf8+kpY8i5NcsC7Vv9Tupep5qqmi+sqdGo/gTNM9AeYafsim6HsID7G8h23HyVWo1Aj1hHFcac+OnypjoU5mt5dSGIWMPUyv96G1LF8pt8XYNTYRjZsWFzl6hwFC4v8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931267; c=relaxed/simple;
	bh=zyCyFEEucX1UpG1LV+i4l3xIDB6N/nLsFMA+4IFCJ2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNuO2z+fNxmIvHzOT78FDkujLflxAIeUOnD8EEfztG3lmKI0s8L5lVl7aQGKebxoWQiHDwZ298EJ38lHS6RHfQFH0rxLAnTYHa1zmraQvZQAQoj/J7cGy3Yr5LYHb4KW9gSAtK0rLgZ3xjWfIO5oCgTgJmvft6/iBUkLMwMfNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/jsnfDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0543C2BCB5;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931266;
	bh=zyCyFEEucX1UpG1LV+i4l3xIDB6N/nLsFMA+4IFCJ2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P/jsnfDGsnenrYZ4mnHSxguJEGu9F0LAkdR68NKuwE7F11XjsKc3OrMJWpE8UldJ8
	 xvckve1/6N6TYyFdMozQvxe2fuOfwxk2mk8o+RoC6nIo5t3yFJHIMNih7Sw2CyPUcW
	 +y6qp73RGZuKjZHYO7AXNyaVzGBHLUN/P245++gKmOSey7e6yqBZ2SPzBnBVQp7W7n
	 qGmu3PH0ytvnylmB4g/quE8yed1OG7/IavxXHZmAyjybdYmgXHpWNxySfKxwgAZcPc
	 cDAtIY6Kvrs9P/C5+TWSN/cFpIPR1MQpWEayR7YIy8IxYi+KTXf0sH+D/01MdzBHai
	 xYGtyEEWlAM6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA7CA5FBD;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 20 Jan 2026 23:17:44 +0530
Subject: [PATCH v4 5/5] PCI: dwc: Fail dw_pcie_host_init() if
 dw_pcie_wait_for_link() returns -ETIMEDOUT
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pci-dwc-suspend-rework-v4-5-2f32d5082549@oss.qualcomm.com>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Niklas Cassel <cassel@kernel.org>, 
 Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=qQ9TgqyVy5+ZTMoD8oCUDVOXgBhw/z7F/8O2CrsfxGk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpb7/ApmJnuN5uPTosvZeuM/G6OR1nnq7vDyZvz
 i8+w4UuP3KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaW+/wAAKCRBVnxHm/pHO
 9do2B/4iXc3dd2qBrw5IsFyIssJUCFEvU7mpL7O8sXt23kvxu57GexIV5okRsT3/prQX11SZVQq
 jkkNZkfQ3aJStFEcIrBEWeI39UjAnDhAhYf3Zx/uKXq7eGvTzLBkN1OLEKHD8y2i6k3Exiz0vA6
 ByA+pK+IuGVrV6eCAKfrpyjm/hL/HklwePmncueNp1SuKHH1X6PU0sr04ZwfjriGk4nhT2eQPa9
 TPuPmKWjN4pgjsL8wZyePT+qcB18cNJx/K98qJq97H66NjY7QPYYizLY3ElS5pB0tqnIdagD15Q
 laDIpfBoa3v9NVGsd/2gHGl0hjDXjlqHHZr/gqjM5iZeGcW7
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-45300-lists,linux-pci=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3FEF849C1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The dw_pcie_wait_for_link() API now distinguishes link failures more
precisely:

-ENODEV: Device not found on the bus.
-EIO: Device found but inactive.
-ETIMEDOUT: Link failed to come up.

Out of these three errors, only -ETIMEDOUT represents a definitive link
failure since it signals that something is wrong with the link. For the
other two errors, there is a possibility that the link might come up later.
So fail dw_pcie_host_init() if -ETIMEDOUT is returned and skip the failure
otherwise.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fad0cbedefbc..a72406ef7e26 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -675,8 +675,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	/*
+	 * Only fail on timeout error. Other errors indicate the device may
+	 * become available later, so continue without failing.
+	 */
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret == -ETIMEDOUT)
+		goto err_stop_link;
 
 	ret = pci_host_probe(bridge);
 	if (ret)

-- 
2.51.0



