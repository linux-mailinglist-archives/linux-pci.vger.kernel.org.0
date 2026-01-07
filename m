Return-Path: <linux-pci+bounces-44189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E70CFE37D
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071A13040F3E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B69F330655;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+U++E+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A732AAC5;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795086; cv=none; b=lPiGTCeygRbZ0P4mq5e+WvYjzdXyVL3AyXBCLiJF5R8kmICjDMSB8Emai3hqDOJscLyf2qG2XhxCA6mYGQe2J30MdjiXE0eAMmI26rOqjn4+/jcxrxA3FwzDaB4UesCFOC5K7S0kjs3Sl+dBz1kKzUf96dKgNH/luDEksFwKkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795086; c=relaxed/simple;
	bh=586xK+Tt3k7/bbGWV0rchSixVB7IEZBKxgz1tfKFOmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNg+4whlsYT9BiwCO1yVLoKe+sH9dr33mCe39Wcr+bsjKdEEyk3l35SRQk9bKWlCMctO6GLWsPADvZRApiTtQ/WV1guLlaafvMxFU0UKdI6N1+omaRJQpPOCsKuzxPB+Jh3PpO07dY3eIB9iNYWprmD2G4qoD1j38iewaBp/Y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+U++E+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE8FEC19421;
	Wed,  7 Jan 2026 14:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795086;
	bh=586xK+Tt3k7/bbGWV0rchSixVB7IEZBKxgz1tfKFOmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M+U++E+zmJXnCjwt2Q+renEf+ocL+yNHhLVYF/Jex/lOY3JCKY/s2Cc+FB5wHTBNy
	 5t1yeei0PO9kxbddOAT2oKfAwazmwWJDDSyEANM5pQA+GiylSLMaGYLXaDxh1XTBZU
	 PHRxF8Dc2Ra2ccYUobBjfDggh7CEVcW4gTve9+DUNAald8XIwzyzHbYFHEb61il/Pk
	 9A9sqvR1X9JzK31ljcqlpYAI0axSip535+u0VB9ct1ec4jDqkfIOVEDp4CTvQoPctZ
	 Gfad7i7PtOBftiqchxjKNUfGJsAfjKITN5iBYmD6KW7tUhDbDf2ncadxWBl9GQjuDw
	 aKktx/oGqoFHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC1DCFD641;
	Wed,  7 Jan 2026 14:11:25 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 19:41:23 +0530
Subject: [PATCH v5 1/5] dt-bindings: ata: sata: Document the graph port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-m2-v5-1-8173d8a72641@oss.qualcomm.com>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
In-Reply-To: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=917;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=9i4SXdeQUf4xFNTVF27hrzTgaGj3TYdVJNxV8w9WdaE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXmmLGXHl/IauCFQ+UOyeR70ghPTr+GzfjvDCN
 oQNv7m4UYGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV5piwAKCRBVnxHm/pHO
 9SvMB/9+LmMbrio/668Iyce2ZVSAg803BhvaWzOavaKxc70H5dpTsdDJo1cHf217cJ4CTMkFNXH
 0ZTHra88qnDl2Ot3juCRc8LbCId8gwZR4lsVwVNnm+SxbSZ9Q9ZIRKYJF1Z3XlpRjKGfkryRGBg
 O/LhI26yewj/bn9ZxSrAyLLETfnVu5YmqMp3E9g9jql6S7WkI8QVbaRnwkJYPzZzqvCxshk/RRt
 7R7M49DiqWC3pazK+f/CPo55sfZHgY3iqU3R/G9OsG73s29yfLCV0Q9DALXBTirWfbLNUY1XFfC
 3QlfjWUHeGWmqMFqaCBJBGMsvzvcOJqb3szqdbhYHsRc3V8D
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

An external connector like M.2 could expose the SATA interface to the
plugin cards. So add the graph port to establish link between the SATA Port
and the connector node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/ata/sata-common.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index 58c9342b9925..97cd69ebf331 100644
--- a/Documentation/devicetree/bindings/ata/sata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -54,4 +54,7 @@ $defs:
           each port can have a Port Multiplier attached thus allowing to
           access more than one drive by means of a single SATA port.
 
+      port:
+        $ref: /schemas/graph.yaml#/properties/port
+
 ...

-- 
2.48.1



