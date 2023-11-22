Return-Path: <linux-pci+bounces-139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5797F4DE6
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F1E28155E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 17:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9245788D;
	Wed, 22 Nov 2023 17:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=baikalelectronics.ru header.i=@baikalelectronics.ru header.b="QZbubmNn"
X-Original-To: linux-pci@vger.kernel.org
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07CD91AE;
	Wed, 22 Nov 2023 09:11:34 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
	by post.baikalelectronics.com (Proxmox) with ESMTP id 37D75E0EB6;
	Wed, 22 Nov 2023 20:05:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	baikalelectronics.ru; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=post; bh=PaQ8UrY
	qoUK/m1kbaJ2p3IjQEyIB74QQMBgVZJwX1Jo=; b=QZbubmNnJ/JWWkDxD0DId1m
	G5uv4grvSYMYvuF37B9zNkGKbNmBWrInKwDoT1Lq24tq578FQiUstj/OWdwgm02U
	Ei4trnz5pVKMb8mm2VIf2YWWTSwUoslbnPM64LbQo01wBlDH+ntuiXrZ1oNVc8FR
	xHaHJgHkVbrpnsyUv2T8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
	by post.baikalelectronics.com (Proxmox) with ESMTP id F28E6E0EB4;
	Wed, 22 Nov 2023 20:05:12 +0300 (MSK)
Received: from localhost (10.8.30.118) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Wed, 22 Nov 2023 20:05:12 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>
CC: Serge Semin <Sergey.Semin@baikalelectronics.ru>, Serge Semin
	<fancer.lancer@gmail.com>, Alexey Malahov
	<Alexey.Malahov@baikalelectronics.ru>, Arnd Bergmann <arnd@arndb.de>,
	<linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] MAINTAINERS: Add MIPS Baikal-T1 SoC bits maintainer
Date: Wed, 22 Nov 2023 20:04:49 +0300
Message-ID: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)

For the last few years several Baikal-T1 platform-specific drivers have
been merged into the kernel repo. I should have added them to the
MAINTAINERS list in the first place, but didn't do that postponing for the
final series with the arch-specific patches. Sooner than later that will
be done (after I finally finish working on the EDAC and network drivers),
but until then let's add the already merged in drivers maintainer to the
list in order to not have them looking abandoned, especially seeing such
concern has already been raised here:

Link: https://lore.kernel.org/lkml/20231122054142.31322-1-lukas.bulwahn@gmail.com/

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon driver
  MAINTAINERS: Add maintainer for Baikal-T1 PCIe driver
  MAINTAINERS: Add maintainer for MIPS Baikal-T1 platform code

 MAINTAINERS | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.42.1



