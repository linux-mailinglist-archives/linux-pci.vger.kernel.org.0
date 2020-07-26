Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7622E14A
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jul 2020 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgGZQ2u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jul 2020 12:28:50 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:36001
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgGZQ2u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Jul 2020 12:28:50 -0400
X-IronPort-AV: E=Sophos;i="5.75,399,1589234400"; 
   d="scan'208";a="355317949"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 26 Jul 2020 18:28:48 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: correct flag name
Date:   Sun, 26 Jul 2020 17:47:35 +0200
Message-Id: <1595778455-12132-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RESOURCE_IO does not exist.  Rename to IORESOURCE_IO.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
Just a guess based on the most similar name...

 Documentation/filesystems/sysfs-pci.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/sysfs-pci.rst b/Documentation/filesystems/sysfs-pci.rst
index a265f3e..742fbd2 100644
--- a/Documentation/filesystems/sysfs-pci.rst
+++ b/Documentation/filesystems/sysfs-pci.rst
@@ -63,7 +63,7 @@ files, each with their own function.
   binary - file contains binary data
   cpumask - file contains a cpumask type
 
-.. [1] rw for RESOURCE_IO (I/O port) regions only
+.. [1] rw for IORESOURCE_IO (I/O port) regions only
 
 The read only files are informational, writes to them will be ignored, with
 the exception of the 'rom' file.  Writable files can be used to perform

