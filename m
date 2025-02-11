Return-Path: <linux-pci+bounces-21212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE07A31613
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC151888AAF
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1B2641D8;
	Tue, 11 Feb 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="a5DtbJVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5332638A5
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303687; cv=none; b=SaNvUh9jFkzCmHWix/U+xuW8u++aHoWimt/Quyf4kANuvVxH7nfiQe8LTr8wAr7xhWaEcvJNTotI0gUfocjlnElKtjzd8pJauJ5+aVwFTb+26YggZuq1otoIDUGYdfJpCbHCuPn+QOYkzeFmkW7FZfH8x9SXWIeZRwpbny2h8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303687; c=relaxed/simple;
	bh=vLPYepmCn4mhfGlDn5smbuR/5pRrA54KLcq81jDIMU0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BzolE4AakC8w68JjYcxHSTWgJ2S8yNdIckjOqiPOd7DtBQFiz5FtrfA6o9z+3hu4c7yLaTdjy5FLSfrSzm/gyt4B1+kGA+q+bAbMB7K7I85UKEs/ERo7HLcP+a97r+M/So1/IKBpepFM0s51XXosb1B52Y3g+/CR/zc9KJUz9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=a5DtbJVv; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bjtWxBs83BeuDmTbDt+EHDOyKdhyT00WLwVNCX8IS6s=;
	b=a5DtbJVvwtvk4xeAZlHBtFv9PNrT5Ibudy9tbKBSrDOeYgmOY/LhvzgXaqIKmHU1rVRGR1
	lNMhh4/6bI/At3zCJVrIrDttdqUXM8Sl9oQL+fAs5hgs/DJIkWZJ76RfQixqvNhHeJrzIN
	4wsV1Eomj/5177fqUXxiQLl63Q731+b5Jvc0k/ZlQ1SkYIWlOIfO73OCNIfX7CS8K20mzM
	+Vyha15mA1vpWiOVmPaRTS9XBhDmYUP0gqtfPGgu93Z6ghvXIx51Jxt0GbE/06f+4/rLE5
	x2NxelrrE4Ibh4JhDXqXi5kHM1FINGakkaulLE6b9SKPuBfKEu9jsjxdlmdQ0g==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 0/7] PCI: apple: support t6020
Date: Tue, 11 Feb 2025 14:54:25 -0500
Message-Id: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPGqq2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0ND3YLkzFTdEjNd4zQTC0uL5FTLJMMUJaDqgqLUtMwKsEnRsbW1AIz
 yLv1ZAAAA
X-Change-ID: 20250211-pcie-t6-3f4898ce9b1d
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=vLPYepmCn4mhfGlDn5smbuR/5pRrA54KLcq81jDIMU0=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r1hX/zYTOcr8IsxIdT6f8LIeprpn21i7hFi
 FMMsjhwAHmJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9QAKCRD+/lBaCvVY
 DQBfD/9Vrm3zDhNnwWZJlv0XHhz5dXaXNFpop4FmbBwlOS1GI18cZWC6vaX65sUOGm2pLgG4i6F
 Tf9Vo6DRIEdQYPMkzZMg6AvsXjLrPO2CypPLGd8TOkmk9VowXTedeU+ub2KgUJXmOY7LQEO6VtY
 T+JF8DkiGLjvlxHrjkhRm0R7seTPpMfIP5Z+lSeJ3bS+LhkxSfC24d+CcX+1A02MZNAudHhiqWm
 SkxTDbiHRvJm5mjkXfnoIg0Q+2c4re8xd5TC0pk6wnTN+5XvZbZC3DirRGxAcEAN02OUddXVpVC
 Ong9Db+NV9xXoaRUhEiinE+emBlAabt1lIAdJOXe5pCWvP+8LZmtaeCofozy5ztqIWU+C1YjDY/
 Hrt9EZFGQUpypV0USyXLl/LAepePjC9SVaBhCcI2iSVV66RW4VBNyn3TZkQOlEneA/PzmG0jIHt
 sSgxbr19Yz0IHLZURp12jlSXDHojbbWknY1uPrrmL/llw8YoQQacVI5s6mfCYEiXDfwXv6w4WwK
 bwP5XF7iiqm8ZToXwAAhfzHfro6D/Ep6r0f6RuyNxJ2SHKJYavuyaDY8yQs0k6lhiorhWIOR1wg
 ykDz6mRLBMLq2oXcp9Jpvb1/VJH4/+wznxYsYZahNfiSVGPu8Sh4MP5unjkI5x5Y3WY4m+CkqA6
 iwEjEi2dojl2iGA==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

This series adds T6020 support to the Apple PCIe controller. Mostly
Apple shuffled registers around (presumably to accommodate the larger
configurations on those machines). So there's a bit of churn here but
not too much in the way of functional changes.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
Alyssa Rosenzweig (1):
      dt-bindings: pci: apple,pcie: Add t6020 support

Hector Martin (5):
      PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
      PCI: apple: Move port PHY registers to their own reg items
      PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
      PCI: apple: Use gpiod_set_value_cansleep in probe flow
      PCI: apple: Add T602x PCIe support

Janne Grunau (1):
      PCI: apple: Set only available ports up

 .../devicetree/bindings/pci/apple,pcie.yaml        |   1 +
 drivers/pci/controller/pcie-apple.c                | 189 ++++++++++++++++-----
 2 files changed, 146 insertions(+), 44 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-pcie-t6-3f4898ce9b1d

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


