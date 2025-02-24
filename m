Return-Path: <linux-pci+bounces-22209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D056FA422C9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD80818976D2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386D19006B;
	Mon, 24 Feb 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mxjeDg00"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9921632D3;
	Mon, 24 Feb 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406454; cv=none; b=PgwUMkHR6/WhFEFinV40fv6IkqSu6VuDvJaYdPSsNt5mxJjR6ZpdXMezo7F7zsn/UNPzfWOjHc86XBvznuA5XE0VMv/avz+afOqA9vD54OYtFr/Oug3ZVZu1J3DVj0pTKSP9nUNDY1EHRwGYYfvAJ7pvKoiG7zpIdA6x3E8/uNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406454; c=relaxed/simple;
	bh=/LDyOz0RsXcvdUFWiFEFjOiedBmnph8/U6SaOudkrrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOax0z0hv+pzZGqN9ubw1UFfSQxjHVEq422fg+aQnMic87s6SnHUPU0m7TNwx00/NAt24UbJiqZxuZqaE+QMjNHlZz3MyDCJPva1yDnnhO925fhIj1SR7ogYRLLk7mDcEIrFA8t+fDs2zZxpqy4/AFv11DlaaLRCk0DrcpoyZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mxjeDg00; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 78B2F44260;
	Mon, 24 Feb 2025 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740406451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aaSExgR5kTI3wUJmhiH8eII8M9kjr/AchE6YRup9qk=;
	b=mxjeDg00Mq+73CqvBeOi6I+gmSOMgezDW4n1ycuQWphSwgUSZp2Y9OPLLdFmeDZ20tkDHC
	y9MS8LQ5z8v4yLyKI6n6JFWvtVAuU9IaDAwbIORyXA6sB0qiOCScIxDYw/VTL97gthlfQF
	zN6Ftau3M8aHz7pKD+UkJo2/mI+qt7VwlcK1vgZH/8upxGMSlHdvFWdXFHossB2wXpqURp
	5vG0LRlw0Qpt/rvm/SVZYwIwxpG+7h3Eb4xqtstg8BLkc8vQ1Is5cJvARnBTQDtDnn+GTR
	R2JPiHB/oHYwn6rIUOM3JpTY8tqG7HNkyHzvMRysaCFH2HUyUbraiAPkYJQ7cw==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Subject: [PATCH v8 4/5] PCI: of_property: Constify parameter in of_pci_get_addr_flags()
Date: Mon, 24 Feb 2025 15:13:54 +0100
Message-ID: <20250224141356.36325-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224141356.36325-1-herve.codina@bootlin.com>
References: <20250224141356.36325-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffeigfejueelueeuffelueefgfelhfejhfehieegudekteeiledttdfhffekffenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegsh
 hgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhiiihhihdrhhhouhesrghmugdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: herve.codina@bootlin.com

The res parameter has no reason to be a pointer to an un-const struct
resource. Indeed, struct resource is not supposed to be modified by the
function.

Constify the res parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/pci/of_property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 962d2e8cc095..b17dcb04de18 100644
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
2.48.1


