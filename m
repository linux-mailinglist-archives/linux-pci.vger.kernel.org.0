Return-Path: <linux-pci+bounces-45296-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KDUCrnTb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45296-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 20:12:57 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD74A157
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 20:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB7D77EAD3F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D79743C06F;
	Tue, 20 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHuf2OoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEAC30F950;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931266; cv=none; b=iciZXkDbw3k2TdtBm96kYgMvcXANikITdV5mFS5eJtPXf0LZ7gZmvLZ5VUpNGTf/Z/S+ifXedE5mL7QO/v7T6kkPx3YtFxgirc5nVlxv3F0jWnEnqHrNxm1BQ51ckm3tqJy8YJkJ7XcFagl1yOWe1jSOMHRILJYt9M4DNHq1kwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931266; c=relaxed/simple;
	bh=LNIqiIz35Ow0dB+iP/L2EzA6wdMLWrPcxHXyLD9uLEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mx5Hug/WjemA2aMGFJo9oJV2TSZHiaUn/aNCAh+20bDIHH67XEu4K7yEK7Zhebh+4mRb7yQvXST0WahdzK9AnMdM0MD/zs6OuaxNytbLgyTIc6sgnMyzt1ujxJTZ0m7mu8naXtmPVLVfEHkENq2vOz3wdyy+KfjGjOx/GNvW4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHuf2OoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F5C3C19421;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768931266;
	bh=LNIqiIz35Ow0dB+iP/L2EzA6wdMLWrPcxHXyLD9uLEk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jHuf2OoOOi2nJjVKJqIrBokh1CQ5qHbiRYvwVNVcs5G5VHbTRhUlETVSARQ9qiz3T
	 lND/yC6LNo+XaRxfiuJcvOsDNYAxTrWKZL2CPG17Sd4dWKocI8borJQm0rWERcr9yf
	 y84pYWwhPHKHHr7PGBwBEmQ+LCMzHx8o0jCahWequ6PpvXod1b4+IWQWxqljf49OEN
	 kj9sbQL3HcCy9Tx1dhvtGh4eKipNtETvFGY63DnqM6HhPR+fkc64n267zVGlQeYxnS
	 vTgS59OwLNIFFR1vA13C/aoeB+hktP8AN5RKO1XHPJJKkwxRlSD0iAANt5JvPKVzsv
	 z28qpUmdwGJMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F3CA5FBB;
	Tue, 20 Jan 2026 17:47:46 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v4 0/5] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Date: Tue, 20 Jan 2026 23:17:39 +0530
Message-Id: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALu/b2kC/4XNwQ6CMAyA4VchO1uyTQbDk+9hPMxtyqIwXGVoC
 O/u4OJF46XJ36RfJ4I2OItkl00k2OjQ+S5FscmIblR3seBMasIpF4yxGnrtwIwacMDedgaCHX2
 4gjxRwYTayrKqSTrugz275wofjqkbhw8fXuufyJbtXzIyoKCUYbSQXIqS7z1ifh/UTfu2zdMgi
 xz5R+NM/tR40oSqqkrqktaF+qLN8/wGpZZfZhEBAAA=
X-Change-ID: 20251119-pci-dwc-suspend-rework-8b0515a38679
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=LNIqiIz35Ow0dB+iP/L2EzA6wdMLWrPcxHXyLD9uLEk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpb7+/u8cAJRCYx1de+zE2cF1PsPrS+sMLsbksX
 hOQ/ODi73iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaW+/vwAKCRBVnxHm/pHO
 9U1wB/0cB6ghiIJDfjb0BWy2iBYwszcPE/QFkdSSrE6n0aCXH7jxx7hx8eH1CIP8+tPdwBTojqx
 HC06tBxQqZq9b17jfTqGSQwumQ38pMwkq4pHQWBw1ewWeXSiQqv363fmAeNIDQ7HqJGUMXvo0YE
 UTu7f34O0zN1WvOhWYjOLuictjdbuizs1/26VZCElbn8QY1dal8hoUcOdWbOmkCw9SIZLH9Ie5h
 pIzuRtiyZWgo862sJOubuUObeyeqlJJQIpyBlM6Zx0HlovVp0Qn9HhVBMdn6D9xSdEaC6tlX8pT
 g5ciMy2EPgQ6onLDGF5PUSeZY8exGh8IIs92FiZleiRS09Ve
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
	TAGGED_FROM(0.00)[bounces-45296-lists,linux-pci=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: E3DD74A157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This series reworks the dw_pcie_wait_for_link() API to allow the callers to
detect the absence of the device on the bus and skip the failure.

Compared to v2, I've reworked the patch 2 to improve the API further and
dropped the patch 1 that got applied (hence changed the subject). I've also
modified the error code based on the feedback in v2 to return -ENODEV if device
is not detected on the bus, -EIO if the device is found but not active and
-ETIMEDOUT otherwise. This allows the callers to skip the failure as needed.

Testing
=======

Tested this series on Rb3Gen2 board without powering on the PCIe switch. Now the
dw_pcie_wait_for_link() API prints:

	qcom-pcie 1c08000.pcie: Device not found

Instead of the previous log:

	qcom-pcie 1c08000.pcie: Phy link never came up

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v4:
- Added a check for POLL state and returned -EIO from dw_pcie_wait_for_link()
- Collected tags
- Link to v3: https://lore.kernel.org/r/20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com

Changes in v3:
- Dropped patch 1 that got appplied
- Reworked the error handling of dw_pcie_wait_for_link() API further
- Link to v2: https://lore.kernel.org/r/20251218-pci-dwc-suspend-rework-v2-0-5a7778c6094a@oss.qualcomm.com

Changes in v2:
- Changed the logic to check for Detect.Quiet/Active states
- Collected tags and rebased on top of v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com

---
Manivannan Sadhasivam (5):
      PCI: dwc: Return -ENODEV from dw_pcie_wait_for_link() if device is not found
      PCI: dwc: Return -EIO from dw_pcie_wait_for_link() if device is not active
      PCI: dwc: Rename and move ltssm_status_string() to pcie-designware.c
      PCI: dwc: Rework the error print of dw_pcie_wait_for_link()
      PCI: dwc: Fail dw_pcie_host_init() if dw_pcie_wait_for_link() returns -ETIMEDOUT

 .../pci/controller/dwc/pcie-designware-debugfs.c   | 54 +-------------
 drivers/pci/controller/dwc/pcie-designware-host.c  |  9 ++-
 drivers/pci/controller/dwc/pcie-designware.c       | 86 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  2 +
 4 files changed, 94 insertions(+), 57 deletions(-)
---
base-commit: 68ac85fb42cfeb081cf029acdd8aace55ed375a2
change-id: 20251119-pci-dwc-suspend-rework-8b0515a38679

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



