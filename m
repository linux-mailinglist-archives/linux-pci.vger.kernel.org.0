Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FABB3048BA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbhAZFkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbhAYN3o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 08:29:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10558229C4;
        Mon, 25 Jan 2021 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611574489;
        bh=a2bSyOMO46IPcaFlhR4MH60Iu4lFxH8xggwH3p3rK9w=;
        h=From:To:Cc:Subject:Date:From;
        b=G2/Q0fCoKAJfCaoAmqMH2wmRka3USgb+UlOaBSbjvk/m2dkjMCVZ5+AWKm427llxi
         OnIgWX9MjYwhGs0QrApuDiD9OMdoXO860ehCMDcUjqFX1IndJ8c910aRUtZXzORSqK
         WHUoUORnj50bUZecM/JN/qMsRZM8KLANnLE9Ehvw1yHmxpwMqwmo4nsgJyU2g/4rK/
         OL4qqzNXrBN3MUdI3p46WWWP/L+XzGzc0J5txZoWCxMcyO/A+w1wQKazU2c7eO8JAi
         Vf++JuIwIYV3rGH0sfxtPkn4354V8Se6FBwMmzi9bSUiwFputdpI2cUuNoZcuITvzv
         ehnC7OLzUer3A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Select configfs dependency
Date:   Mon, 25 Jan 2021 12:34:39 +0100
Message-Id: <20210125113445.2341590-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added pci-epf-ntb driver uses configfs, which
causes a link failure when that is disabled at compile-time:

arm-linux-gnueabi-ld: drivers/pci/endpoint/functions/pci-epf-ntb.o: in function `epf_ntb_add_cfs':
pci-epf-ntb.c:(.text+0x954): undefined reference to `config_group_init_type_name'

Add a 'select' statement to Kconfig to ensure it's always there,
which is the common way to enable it for other configfs users.

Fixes: 7dc64244f9e9 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/endpoint/functions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index 24bfb2af65a1..5d35fcd613ef 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -16,6 +16,7 @@ config PCI_EPF_TEST
 config PCI_EPF_NTB
 	tristate "PCI Endpoint NTB driver"
 	depends on PCI_ENDPOINT
+	select CONFIGFS_FS
 	help
 	  Select this configuration option to enable the NTB driver
 	  for PCI Endpoint. NTB driver implements NTB controller
-- 
2.29.2

