Return-Path: <linux-pci+bounces-7623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5EF8C8623
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 14:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608A52823A4
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946ED3FBBD;
	Fri, 17 May 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOf1Vzmu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6423FB2F;
	Fri, 17 May 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947685; cv=none; b=L5W1VZkHoO5rB6xLx2KoW5WumMLuskl7MH1/WzEGayge0XXABRu9hsGIrlWpHusQYPNlPhvP18yj5ZjHL3VOQg0bG6ofnKjzBhTPurm5UHhiyHdhxM/lvDfbGuCKNNonpKFdpitvrS5Aklb6Q/V00/Mx/kPZ33SfpWoeKawezyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947685; c=relaxed/simple;
	bh=zC56IzlilEBxkuSnH3rPZXwuKG/OnaJ38XUHw1B6ISc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hklOcumsARoJ3fu9vZ/kezIjLXSDkeihWv4Vc8ogrJWvT54U7MHEC1W92LCtNQvc5UIEuSapRakGYw8P1uVU8NwVxcTqyGnEw+PNzkMSpa/wYPn4zXfO9e4n7CuJBmGMqeRss6sECDdwqzUCYyA48j0BmhsaqcT0YtoxPnW2yHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOf1Vzmu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0A5C2BD10;
	Fri, 17 May 2024 12:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715947684;
	bh=zC56IzlilEBxkuSnH3rPZXwuKG/OnaJ38XUHw1B6ISc=;
	h=From:To:Cc:Subject:Date:From;
	b=dOf1Vzmu/ZIMNtm7QkjK28wmbTDC0u5Ln9syDWmpSjpV5j3kbBze2RMGlD5KlRVRj
	 icqj8wW9aJOurtQu5ygXw/V4MLFF4Pg3d/5YaPMKFrApx4eZPQtA2NoWf6Pn8nFKp/
	 i/edhbu4N48y0eo1ihE2OXZLpsYbpRPNyf53lL939nQbZJe2l3QXmlAMzVxQcsWQVR
	 1IzNBozJf4eNmNpYZzggcDxSePc+uvkt0Jd/aqMWDDvcH013uc6/DBHkamf+IjAC+d
	 eZyz8Z7AEiIlmYN4FKZ2zl5xbJ+sDZ+VT5MhrI/2HhN0WlYXHYqxAGLX/ooYK6LU5R
	 UOLayVxuYYLgg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Pawel Laszczak <pawell@cadence.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] PCI: use array for .id_table consistently
Date: Fri, 17 May 2024 21:04:58 +0900
Message-Id: <20240517120458.1260489-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While 'x' and '&x[0]' are equivalent, most of the PCI drivers use the
former form for the .id_table.

Update some drivers and documentation for consistency.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/PCI/pciebus-howto.rst                    | 2 +-
 Documentation/translations/zh_CN/PCI/pciebus-howto.rst | 2 +-
 drivers/pci/pcie/portdrv.c                             | 2 +-
 drivers/usb/cdns3/cdnsp-pci.c                          | 2 +-
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
index a0027e8fb0d0..f344452651e1 100644
--- a/Documentation/PCI/pciebus-howto.rst
+++ b/Documentation/PCI/pciebus-howto.rst
@@ -139,7 +139,7 @@ driver data structure.
 
   static struct pcie_port_service_driver root_aerdrv = {
     .name		= (char *)device_name,
-    .id_table	= &service_id[0],
+    .id_table	= service_id,
 
     .probe		= aerdrv_load,
     .remove		= aerdrv_unload,
diff --git a/Documentation/translations/zh_CN/PCI/pciebus-howto.rst b/Documentation/translations/zh_CN/PCI/pciebus-howto.rst
index 65c4301f12cd..c6ffda62af21 100644
--- a/Documentation/translations/zh_CN/PCI/pciebus-howto.rst
+++ b/Documentation/translations/zh_CN/PCI/pciebus-howto.rst
@@ -124,7 +124,7 @@ pcie_port_service_unregister取代了Linux驱动模型的pci_unregister_driver
 
   static struct pcie_port_service_driver root_aerdrv = {
     .name		= (char *)device_name,
-    .id_table	= &service_id[0],
+    .id_table	= service_id,
 
     .probe		= aerdrv_load,
     .remove		= aerdrv_unload,
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..2faca06ff67c 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -786,7 +786,7 @@ static const struct pci_error_handlers pcie_portdrv_err_handler = {
 
 static struct pci_driver pcie_portdriver = {
 	.name		= "pcieport",
-	.id_table	= &port_pci_ids[0],
+	.id_table	= port_pci_ids,
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 0725668ffea4..225540fc81ba 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -231,7 +231,7 @@ static const struct pci_device_id cdnsp_pci_ids[] = {
 
 static struct pci_driver cdnsp_pci_driver = {
 	.name = "cdnsp-pci",
-	.id_table = &cdnsp_pci_ids[0],
+	.id_table = cdnsp_pci_ids,
 	.probe = cdnsp_pci_probe,
 	.remove = cdnsp_pci_remove,
 	.driver = {
diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
index 1691541c9413..50c3d0974d9b 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
@@ -121,7 +121,7 @@ static const struct pci_device_id cdns2_pci_ids[] = {
 
 static struct pci_driver cdns2_pci_driver = {
 	.name = "cdns2-pci",
-	.id_table = &cdns2_pci_ids[0],
+	.id_table = cdns2_pci_ids,
 	.probe = cdns2_pci_probe,
 	.remove = cdns2_pci_remove,
 	.driver = {
-- 
2.40.1


