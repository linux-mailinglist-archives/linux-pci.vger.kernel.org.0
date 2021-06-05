Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9139C898
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFENUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 09:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhFENU0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B0E261450;
        Sat,  5 Jun 2021 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899118;
        bh=MzVBXfG1BKEroabGxLV1n0BhCSj3Ci7z9YuRqrErxvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0v622Bd//I3cnk+iSD5BWPKfs83K4LRsvkBH7J3PPv7RPuoYvH+xejNEs8xbSCSy
         rcyrp+WY1/RuXniNWp5cYwxOuhQpjJ2IOU4asSxremW2wXc98Ywu9uGtg1tz9nNk9T
         SBsUm2boSMeu7xpluNEQfgSwRv/v34Cs/ZK8zZsVmRwvrxnOMfWRmKMRdBHbL6Bb4q
         ELyqxXUdlBPF0zOq2zX+1XAuwiBWE4c3IkFQ4H2njggMQaoIcK3QCz4T1uwzBup+vw
         AwGLZaxrUoS7F//WVcxXeJplJd8z8LACfcOBlHX4p+I8Sm0H6Xn93nHs/QwTjkhkrK
         FXhGkp4rjPGtQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCC-008GGD-H0; Sat, 05 Jun 2021 15:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 27/34] docs: PCI: pci.rst: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:26 +0200
Message-Id: <d5f465357173f834709e467214f4842269815c05.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/PCI/pci.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index 814b40f8360b..fa651e25d98c 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -265,7 +265,7 @@ Set the DMA mask size
 ---------------------
 .. note::
    If anything below doesn't make sense, please refer to
-   :doc:`/core-api/dma-api`. This section is just a reminder that
+   Documentation/core-api/dma-api.rst. This section is just a reminder that
    drivers need to indicate DMA capabilities of the device and is not
    an authoritative source for DMA interfaces.
 
@@ -291,7 +291,7 @@ Many 64-bit "PCI" devices (before PCI-X) and some PCI-X devices are
 Setup shared control data
 -------------------------
 Once the DMA masks are set, the driver can allocate "consistent" (a.k.a. shared)
-memory.  See :doc:`/core-api/dma-api` for a full description of
+memory.  See Documentation/core-api/dma-api.rst for a full description of
 the DMA APIs. This section is just a reminder that it needs to be done
 before enabling DMA on the device.
 
@@ -421,7 +421,7 @@ owners if there is one.
 
 Then clean up "consistent" buffers which contain the control data.
 
-See :doc:`/core-api/dma-api` for details on unmapping interfaces.
+See Documentation/core-api/dma-api.rst for details on unmapping interfaces.
 
 
 Unregister from other subsystems
-- 
2.31.1

