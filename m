Return-Path: <linux-pci+bounces-7874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C98D0840
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB8528E63D
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D804E16D4C3;
	Mon, 27 May 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KLsUYtmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2516C869;
	Mon, 27 May 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826524; cv=none; b=F1DxhGdPVx/w3ki31T/tZ02jQEzVm5aL7yCvKzCPOvsL4LK5C68INt05uYC0ldCihqiC3GD1AKUnjNY56O/UfLP1ySfZmKAn5wk408Ad1tyjpXjaAwOURhaKgDRWruvmIB41qshPFI1wr9kprdBrEya7SnU9EuMjSRr5XzFS+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826524; c=relaxed/simple;
	bh=NfXTvwTcNt6TT2yA4BeBzCWYH0x+WXyl8rDrM6Pn0ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfR0N6Nw4Zu7blqflTSf10XgRC9+jD9BLhXZMr77M2ugqiovmL27w6xvw4FXj0WWIaGNRyhIGLifPhJ3ghGrwni5dwzJKE0xHqX/TJ/e413l05CquT5e6gQ7IfLhv6sv03a87FxwrKVQuZHIev7lLmzEamOAD+EgaLSCz774y5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KLsUYtmL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B21FBFF817;
	Mon, 27 May 2024 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716826521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3h+hZPubtWgPDD7KPmRBpR6yZ07j+EdVtQNqtGhhR2w=;
	b=KLsUYtmLqQAKRcBHuSjg5r26CPzkClTo8OEYGfcU0kBluW6n8ZXHUvCneD3BtKdU7GiE6w
	19JB8grUr+P4p/NeZ2Jufvd/T9nuiIbFicmYJR6C1gCzf5+ibofv/IJLAOHeN6jho2H0de
	5oXisZKUr1TIJqnR8kpC9NljzGSlp8IKXMiM4VbuKorXEFjm+tt/wTXvwG+8jZD+OE/Tu/
	i81d66beg6ItjcpRSDnjG76BKTe8xwDy/gCulyQVLoz4QKOQZe4urKbJexgosAO26fwtfm
	pkzo0ficRtreEvNhHn3b11GEfkV7WRaCpAGxTjg8R/MhRKzDvn/s1WNwiRRJ/g==
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 13/19] of: dynamic: Constify parameter in of_changeset_add_prop_string_array()
Date: Mon, 27 May 2024 18:14:40 +0200
Message-ID: <20240527161450.326615-14-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240527161450.326615-1-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The str_array parameter has no reason to be an un-const array.
Indeed, elements of the 'str_array' array are not changed by the code.

Constify the 'str_array' array parameter.
With this const qualifier added, the following construction is allowed:
  static const char * const tab_str[] = { "string1", "string2" };
  of_changeset_add_prop_string_array(..., tab_str, ARRAY_SIZE(tab_str));

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/dynamic.c | 2 +-
 include/linux/of.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index dda6092e6d3a..70011a98c500 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -984,7 +984,7 @@ EXPORT_SYMBOL_GPL(of_changeset_add_prop_string);
 int of_changeset_add_prop_string_array(struct of_changeset *ocs,
 				       struct device_node *np,
 				       const char *prop_name,
-				       const char **str_array, size_t sz)
+				       const char * const *str_array, size_t sz)
 {
 	struct property prop;
 	int i, ret;
diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..ee9a385a13db 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1639,7 +1639,7 @@ int of_changeset_add_prop_string(struct of_changeset *ocs,
 int of_changeset_add_prop_string_array(struct of_changeset *ocs,
 				       struct device_node *np,
 				       const char *prop_name,
-				       const char **str_array, size_t sz);
+				       const char * const *str_array, size_t sz);
 int of_changeset_add_prop_u32_array(struct of_changeset *ocs,
 				    struct device_node *np,
 				    const char *prop_name,
-- 
2.45.0


