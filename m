Return-Path: <linux-pci+bounces-15986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E89BBBC4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA45281EDB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B311CC165;
	Mon,  4 Nov 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lfPu+9Qv"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D91C9ED1;
	Mon,  4 Nov 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740815; cv=none; b=dTPbnZ2SBs9Ubz3J6wfvvrO59eGlEYPz3L/WRVd4jnqh/V31jzaBJawILyOnJp/KS2vbAj0bXJm4jQz31mm9He91TXTJok2xXDBwYIK4CsYGK9lTUPUSKn3HB6J1zrlIAm1HxPmWa6xRmD/tJk98c7brmzmUo2tcP6wcTXcakuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740815; c=relaxed/simple;
	bh=PCVCnfxn3uvwj+ZCYt1qF5vPcAytJQEgBonodYhLbUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Barc+sjMqa10OsRwXPToioaMXgbwgQDOlxBgUiIatj3iJWtCrnN/HLFART1GeHrM/XtTvZ9ZRzsGXjiC7frZXjeX7rH1fNQtJ4+bxRx1rqi/1TUbc/5lMYLduBIvCvQIql8CoPi4xkxtkOvXHTIu/mjclVkkUHwqC5Tn2r1WPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lfPu+9Qv; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 9BD2B1BF212;
	Mon,  4 Nov 2024 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730740812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oACsH740MGISvwOaAMqyJDhEnvLSJA2AqYvobBxaexc=;
	b=lfPu+9Qvt4oDo0U1topeTIBJjp+29fgu/1qA/x8rNDAmNpgPgIbZ3pK15e1Jb6aSAcXOXl
	K5s1KhEZflsD8hTK0bciHagWhft6QNY3XX60IidTO48IQz1Dr3LoACBvJUMnTDcTClf5/T
	v1bR93Yme2BD5xq9rCJNGxLjLckwKQ3Xv0DLMXcZ8YLrG31Ts4THxpASEgMxCuTadKqnIz
	fwj6fm+jXYgW17a8X4k3+B2MN2WHCqZjuBEupS5FWbXAtWBWF9gDHmdMcINCuMKggboAm5
	xed9teY7g0rVIYicBisDzOziSw87/b+dwk7ZVDYhUi7CS5/x6bmNJ2kq5WAhkQ==
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
Subject: [PATCH 5/6] of: Use the standards compliant default address cells value for x86
Date: Mon,  4 Nov 2024 18:19:59 +0100
Message-ID: <20241104172001.165640-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104172001.165640-1-herve.codina@bootlin.com>
References: <20241104172001.165640-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The default address cells value is 1.

According to the devicetree specification and the OpenFirmware standard
(IEEE 1275-1994) this default value should be 2.

The device tree compiler already use 2 as default value and the powerpc
PROM code also use 2 as default value. Modern implementation should have
the #address-cells property set and should not rely on this default
value.

On x86, an empty root device-tree node is created but as the hardware
is not described by a device-tree passed by the bootloader, this root
device-tree remains empty and so the #address-cells default value is
used.

In preparation of the support for device-tree overlay on PCI devices
feature on x86 (i.e. the creation of the PCI root bus device-tree node),
this default value needs to be updated. Indeed, on x86_64, addresses are
on 64bits and the upper part of an address is needed for correct address
translations. On x86_32 having the default value updated does not lead
to issues while the uppert part of a 64bits address is zero.

Changing the default value for all architectures may break device-tree
compatibility. Indeed, existing dts file without the #address-cells
property set in the root node will not be compatible with this
modification. Restrict the modification to the x86 architecture.

Instead of having 1 for this default value, be consistent with standards
and set the default address cells value to 2 in case of x86.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/of_private.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 04aa2a91f851..d8353f04af0a 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -29,7 +29,7 @@ struct alias_prop {
 	char stem[];
 };
 
-#if defined(CONFIG_SPARC)
+#if defined(CONFIG_SPARC) || defined(CONFIG_X86)
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 2
 #else
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT 1
-- 
2.46.2


