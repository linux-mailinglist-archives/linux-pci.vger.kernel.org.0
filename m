Return-Path: <linux-pci+bounces-138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1898F7F4DE4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 18:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2D28141D
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517657888;
	Wed, 22 Nov 2023 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=baikalelectronics.ru header.i=@baikalelectronics.ru header.b="bo49231Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07C8B1A8;
	Wed, 22 Nov 2023 09:11:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 7CBE3E0EBA;
	Wed, 22 Nov 2023 20:05:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=post;
	 bh=xw3nPuMf6iDNRvKrBh2RHnMk81mNTUgNUkHajKp5iEY=; b=bo49231QwqBS
	PWqOeFS9dWnvyZLg/GaJSFUPEzKuFZop15yx/4DISgeM4vtT15i1/UVxj15Cii4e
	gw4rkE+E0ui9Ec9lrhK2lpxVSgexXGmEsrS7elHQo9MM8qvvKIJOhtcQSDj8dXOu
	/6SN9nsM5pZB6aacvM3uXXkiHK4jAQA=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 5DA79E0EB4;
	Wed, 22 Nov 2023 20:05:14 +0300 (MSK)
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
Subject: [PATCH 2/3] MAINTAINERS: Add maintainer for Baikal-T1 PCIe driver
Date: Wed, 22 Nov 2023 20:04:51 +0300
Message-ID: <20231122170506.27267-3-Sergey.Semin@baikalelectronics.ru>
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

Add myself as a maintainer of the Baikal-T1 PCIe Root Port driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e50a77d746e..52ee905c50f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16796,6 +16796,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/pci/axis,artpec*
 F:	drivers/pci/controller/dwc/*artpec*
 
+PCIE DRIVER FOR BAIKAL-T1
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-pci@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-bt1.c
+
 PCIE DRIVER FOR CAVIUM THUNDERX
 M:	Robert Richter <rric@kernel.org>
 L:	linux-pci@vger.kernel.org
-- 
2.42.1



