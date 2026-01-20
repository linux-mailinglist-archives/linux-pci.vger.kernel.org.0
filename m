Return-Path: <linux-pci+bounces-45299-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJPvL8/Db2lsMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45299-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:05:03 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6553B49104
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A57C7EB898
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DED43CEC7;
	Tue, 20 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0WiK++a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E9B427A07;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931267; cv=none; b=ZwS5cf8ui5GtHGcn4FnJ4PYIBYd0npqsvMKe2N6io2Mq73Q6Mrk0/uE65G0+Fn1f0cyJTUCGyPiQVf5xln8VjQZJETSbCtlrKPaCVqpZFYAdtoOh/IkQEP33u+UnsWL3eaTW/L8qDSKJL23d4YFiWEF7DJJExU9ozUn36VnQOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931267; c=relaxed/simple;
	bh=1/PzY7KxBW6zbghIwRGPBP9Wm59bz5ElxYnTm8vmZPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHuFWaUVbHzuhYXBaInuVI+kd37qCNea1722SWuPMh8ca8RU+qh0HBuoT/Bq9ZaHMn0Ui8iLCPnujgdi8CiO+2hdAxoRlNFyvv4Fsy69hKsD+m2O5f0qYqNhTZTSr3lgeU8COccsMFf4CxGB2XTUk50fcAO5njCZFnTQ1EFa5kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0WiK++a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 939DFC2BCB2;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931266;
	bh=1/PzY7KxBW6zbghIwRGPBP9Wm59bz5ElxYnTm8vmZPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P0WiK++aT2XJnN7Mi024xICPANWnRVIpQQ60JqkA1FkZPo/8PebmOf3pf3RMU/Dvl
	 gHMYJi92TW/q1Zn5l9zzeJfrBlKnlTJhXT6D0O+zCxgFuNsYgE3oKdEVZ9i2RtP8k9
	 6FVGCRVCIMQM4KRMJ8B2qiDMcqArhD+sF5IBSegFemY5NAezzCQGiMnCn/Z+q5UvMq
	 TAhsxxoKMbqW2qiqtF87smsIxLHIbtqayCUIxywq4qOlkK3HyNmMpSazni0XzIkhO+
	 dGYIHaGKCGl5xh8CtEMkrKM0nnIXQUCVF3M8wJmQYrNcaSK6bv65R0dkEgAjPFCEHN
	 kMEVGE6exQsug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B2CA5FC1;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 20 Jan 2026 23:17:43 +0530
Subject: [PATCH v4 4/5] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pci-dwc-suspend-rework-v4-4-2f32d5082549@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Rybke+Ur+gqq01x6BcV5V2xkaSwi4rJ9Q7iHSJqNsh0=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYsjM338gqCWV5XC1qfOXGMYLN5nOZ65fOn/7/AZRtpX2i
 YnCmflenYzGLAyMXAyyYoos6UudtRo9Tt9YEqE+HWYQKxPIFAYuTgGYyLf17H+FzJhuNidPbUxo
 yr67LEHtWWOsoZGDsI8bb5bBi7ynXJq5XhXvvIpzNHf9tQiW3Xfr4A0xnVOrl+r5VB8VNXkxMbX
 lY5dySvwlk4S9b50OJHHtq6xuV1ge6e+n77OJ+ek225OZ9gZNa6ON6owatRdr+AUKzZx31eAwy7
 +beZnMk9Xux83cvFWMgVMhySxkfuh37fnlKyMSH3i71ZTecLJ8E1ufuFf7c4xceM+UKv6TTRzLu
 iyeCOs0uNax/bK1yEubvYKrNqfpWA23M6ei/TGH9WEH/cTWVRea361Yt052apacwfSKyjkBhvtY
 GZgbJk9dfFU99da5GQbPtn1Wfml6uoHT/1ykz6b5icEA
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
	TAGGED_FROM(0.00)[bounces-45299-lists,linux-pci=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pci];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,rock-chips.com:email,linaro.org:email,nxp.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:replyto]
X-Rspamd-Queue-Id: 6553B49104
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If the link fails to come up even after detecting the device on the bus
i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
dw_pcie_wait_for_link() should log it as an error.

So promote dev_info() to dev_err(), reword the error log to make it clear
and also print the LTSSM state to aid debugging.

Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index f74eae79cca4..2fa9f6ee149e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -787,7 +787,8 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 			return -EIO;
 		}
 
-		dev_info(pci->dev, "Phy link never came up\n");
+		dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",
+			dw_pcie_ltssm_status_string(ltssm));
 		return -ETIMEDOUT;
 	}
 

-- 
2.51.0



