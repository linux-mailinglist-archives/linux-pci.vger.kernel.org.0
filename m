Return-Path: <linux-pci+bounces-137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C617F4DE1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3531C20B1E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3424B41;
	Wed, 22 Nov 2023 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=baikalelectronics.ru header.i=@baikalelectronics.ru header.b="EvhYv0D5"
X-Original-To: linux-pci@vger.kernel.org
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 081211B2;
	Wed, 22 Nov 2023 09:11:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 2C979E0EBB;
	Wed, 22 Nov 2023 20:05:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=DpPTDtezDz6LzG5AwmetxU6wxuU0QGpGPaHxHQ0gF6E=; b=EvhYv0D5GI5a
	ZTsWPVMAsSZ30a4g1To1xC50KVuGg/id8c0m653KIkp0cm37dHXHEc+w5m6+98yt
	tKGmA4eiduPRPEnHuUUPFkcHbZkX1BJviz3p6GKBJtv8ayzcMDUdLFQN430lbOBh
	ZVtyhMLWd93Y1pruwJNM4tJf4bR6RDc=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 07D53E0EB4;
	Wed, 22 Nov 2023 20:05:15 +0300 (MSK)
Received: from localhost (10.8.30.118) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Nov 2023 20:05:14 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Arnd Bergmann <arnd@arndb.de>,
	<linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] MAINTAINERS: Add maintainer for MIPS Baikal-T1 platform code
Date: Wed, 22 Nov 2023 20:04:52 +0300
Message-ID: <20231122170506.27267-4-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
References: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)

Add myself as a maintainer of the MIPS Baikal-T1 platform-specific
drivers. The arch-code hasn't been submitted yet, but will be soon enough.
Until then it's better to have the already available drivers marked as
maintained.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52ee905c50f4..a56e241608ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14491,6 +14491,17 @@ F:	arch/mips/
 F:	drivers/platform/mips/
 F:	include/dt-bindings/mips/
 
+MIPS BAIKAL-T1 PLATFORM
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-mips@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
+F:	Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml
+F:	drivers/bus/bt1-*.c
+F:	drivers/clk/baikal-t1/
+F:	drivers/memory/bt1-l2-ctl.c
+F:	drivers/mtd/maps/physmap-bt1-rom.[ch]
+
 MIPS BOSTON DEVELOPMENT BOARD
 M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
-- 
2.42.1



