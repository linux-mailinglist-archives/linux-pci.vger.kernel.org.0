Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284FC3A925A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 08:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhFPGaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 02:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhFPG3z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5BE86141D;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=MzVBXfG1BKEroabGxLV1n0BhCSj3Ci7z9YuRqrErxvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mD6Kp5QEvk7O022uVIpL6FiHtnhbg481oWC/kFvecjPy/cLCox5wlJL4ScQnoyX9u
         oqEyxE10kS0uFxg4MFpXG+DgcR1l2/HtTO5z9ugInQsKbR5nxnjiBck2cJALW3PpwJ
         08QmYZlLy0j3vqRf5tLrBxtroEJjms2nQjvtb2odYpEV7ALk42SDowmhzzEQS3FbjN
         zNi3whiqXZ0R/yevK4Ww+aeklnfggeFXPKYHZZj+VfzlPHfinE2RaDElh0GyTWyMzU
         ouO7vZaNHYl/gESsSF25L1JS9nyDbe75NTQnlOHHK7imfyoNnv/KU2RPpQn4Bpw32N
         f06Q+j23VAx/w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1f-004kJi-0B; Wed, 16 Jun 2021 08:27:47 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 22/29] docs: PCI: pci.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:37 +0200
Message-Id: <8697cf945390f6b45fefb4c5fe22ed1c8070e32e.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
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

