Return-Path: <linux-pci+bounces-136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72B7F4DE0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 18:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF831C209F4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5B4F21B;
	Wed, 22 Nov 2023 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=baikalelectronics.ru header.i=@baikalelectronics.ru header.b="lSqnmEKy"
X-Original-To: linux-pci@vger.kernel.org
X-Greylist: delayed 379 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 09:11:34 PST
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5E141A5;
	Wed, 22 Nov 2023 09:11:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id C065CE0EB9;
	Wed, 22 Nov 2023 20:05:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=gnCHnfuBhq/n3w/GmAIAGIuczS2gRN7GtB95t4RaqmY=; b=lSqnmEKy23sw
	k7EwB4T9Wx87G+mqey0DoSczT7qZMactdexV4vVxSIz3D652jMIDq84XvwVA/neg
	xzmy04Utz06iSZ7cvbdj2pDOB7YQWaxh/9wG5vKrVWENT5XUH6NeqguOhEHcX2rc
	F3EBYZet9PWm5EEu0Y9tW1PGXuSUW40=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 9FF9EE0EB4;
	Wed, 22 Nov 2023 20:05:13 +0300 (MSK)
Received: from localhost (10.8.30.118) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Nov 2023 20:05:13 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Arnd Bergmann <arnd@arndb.de>,
	<linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon driver
Date: Wed, 22 Nov 2023 20:04:50 +0300
Message-ID: <20231122170506.27267-2-Sergey.Semin@baikalelectronics.ru>
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

Add myself as a maintainer of the Baikal-T1 PVT sensors driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..9e50a77d746e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3467,6 +3467,14 @@ F:	drivers/video/backlight/
 F:	include/linux/backlight.h
 F:	include/linux/pwm_backlight.h
 
+BAIKAL-T1 PVT HARDWARE MONITOR DRIVER
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwmon/baikal,bt1-pvt.yaml
+F:	Documentation/hwmon/bt1-pvt.rst
+F:	drivers/hwmon/bt1-pvt.[ch]
+
 BARCO P50 GPIO DRIVER
 M:	Santosh Kumar Yadav <santoshkumar.yadav@barco.com>
 M:	Peter Korsgaard <peter.korsgaard@barco.com>
-- 
2.42.1



