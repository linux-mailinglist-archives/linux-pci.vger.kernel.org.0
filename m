Return-Path: <linux-pci+bounces-17527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E359E030F
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFED288B32
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A0202F8C;
	Mon,  2 Dec 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ik0FCJnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2311FF611;
	Mon,  2 Dec 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145357; cv=none; b=ZJerlry6VmFAzLMuTq0P7wgjjdZU04lcu1fzsiGp/y/FZzao6etZW1VFhcKNaaPR3lhsb1Qq6UR/hvaYue8C8INKkT9acc7tn0PyrWeuaJcW5RGQKBdLGsXdlj2iGxF17IOU5Q4dUCAiaZpCNWn1gLGs+H7eFdKWcm8rzYdE/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145357; c=relaxed/simple;
	bh=H8MC/Q72vk0UPF9u8+tzJ8SETywEWYWPmMDVOO5AKeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfWd47LFZd6EfNzKs3OLMAXH6MfJelYPQ0hXPzl0FL+UPOhFgwxvE4ZGKFOX5h6XTNQmQnh5htjzgbbANOYndUOxcw3meJOF5cA2bcbZvspaL192dLo6MALyHiHm/CnYOEJO3ziVFsqmOSf2CjXwVO+amFv6+v22BEvImO6x5K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ik0FCJnv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 5D07FC000F;
	Mon,  2 Dec 2024 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733145348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD+dgpGNPBxXSWsz/EZ9nW0M7S5/QsWHsehlXFF/WCY=;
	b=Ik0FCJnv8/CJE97B+IAi2eGNXbw0F2+TuN2TVpCPReYddGqk14LVV7jL5REFRAMVutWk6F
	+aJ1mhRyxOfQlTYrtnkBV9SzNnH5PuzCOfw6tHS2uvjMRjcX09b3EmHVE9OkstqrfJLfSp
	LjxSiR3j+7T7MCzMJ0cGXSFRMOFJJ3Cw4daDAK9bVLgCCTezPOSHvRJn9n09MQak596wH7
	0cJyoZZapoo21+QbHE7WT/8zY936ojqk9WvxdKZHGls7jqGZStrVrJTSZm5x8oaFT9L9c6
	tlVNWCcVUGDYqNmmtnGaLM12iqvdCN2+76+5wJHUFPh0xRBqlj8R/syZJB044Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v4 4/6] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Mon,  2 Dec 2024 14:15:16 +0100
Message-ID: <20241202131522.142268-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202131522.142268-1-herve.codina@bootlin.com>
References: <20241202131522.142268-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The res parameter has no reason to be a pointer to an un-const struct
resource. Indeed, struct resource is not supposed to be modified by the
function.

Constify the res parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/of_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 8aff9ca1f222..400c4c2e434d 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -69,7 +69,7 @@ static void of_pci_set_address(struct pci_dev *pdev, u32 *prop, u64 addr,
 	}
 }
 
-static int of_pci_get_addr_flags(struct resource *res, u32 *flags)
+static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 {
 	u32 ss;
 
-- 
2.47.0


