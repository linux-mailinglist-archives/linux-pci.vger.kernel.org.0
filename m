Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5346771A5
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jan 2023 19:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAVSsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Jan 2023 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVSsl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Jan 2023 13:48:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9314C13538;
        Sun, 22 Jan 2023 10:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0132560C8F;
        Sun, 22 Jan 2023 18:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CF3C433EF;
        Sun, 22 Jan 2023 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674413318;
        bh=gsccqyhXgczWujfYNuc8IWNveSbdGH+ZyHwJN2WZqFM=;
        h=From:To:Cc:Subject:Date:From;
        b=PZzAU6myHzlfwwNDBAp7BM5f5SfE6HBGwNawDwelEREuKD8hzBnSWdJYeuTXkFNND
         N+VSv5Obu/gt3kxFgQCbzqPMAcJ85Nvi5OFfh4bhpaR91aSD5CMZjDPQY+a9+yz4Dp
         WNTgF3S8Xe2NcLfQOq/EFCEZnnRSY4WmFkACfP+0+khAeTDd4JNEBvaFmkMLHX8n04
         IuauBpOYga+cs2xjxZmeEmhBCqYrXwP3+g2dUCDbEQG8ymRrAnlGWU6q35upGddfBh
         J8wAEm9wuvjASDyI3azF9SCn4Q6DKoNhU95FkxrdPbuRBIP7oGyvlpvL4FmmgeGQ9i
         X1Du+uzXPnzpg==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, openbmc@lists.ozlabs.org,
        alsa-devel@alsa-project.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 1/1] Docs/subsystem-apis: Remove '[The ]Linux' prefixes from titles of listed documents
Date:   Sun, 22 Jan 2023 18:48:34 +0000
Message-Id: <20230122184834.181977-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some documents that listed on subsystem-apis have 'Linux' or 'The Linux'
title prefixes.  It's duplicated information, and makes finding the
document of interest with human eyes not easy.  Remove the prefixes from
the titles.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/lkml/20230114194741.115855-1-sj@kernel.org/)
- Drop second patch (will post later for each subsystem)

 Documentation/PCI/index.rst        | 6 +++---
 Documentation/cpu-freq/index.rst   | 6 +++---
 Documentation/crypto/index.rst     | 6 +++---
 Documentation/driver-api/index.rst | 6 +++---
 Documentation/gpu/index.rst        | 6 +++---
 Documentation/hwmon/index.rst      | 6 +++---
 Documentation/input/index.rst      | 6 +++---
 Documentation/mm/index.rst         | 6 +++---
 Documentation/peci/index.rst       | 6 +++---
 Documentation/scheduler/index.rst  | 6 +++---
 Documentation/scsi/index.rst       | 6 +++---
 Documentation/sound/index.rst      | 6 +++---
 Documentation/virt/index.rst       | 6 +++---
 Documentation/watchdog/index.rst   | 6 +++---
 14 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index c17c87af1968..e73f84aebde3 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======================
-Linux PCI Bus Subsystem
-=======================
+=================
+PCI Bus Subsystem
+=================
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/cpu-freq/index.rst b/Documentation/cpu-freq/index.rst
index 2fe32dad562a..de25740651f7 100644
--- a/Documentation/cpu-freq/index.rst
+++ b/Documentation/cpu-freq/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==============================================================================
-Linux CPUFreq - CPU frequency and voltage scaling code in the Linux(TM) kernel
-==============================================================================
+========================================================================
+CPUFreq - CPU frequency and voltage scaling code in the Linux(TM) kernel
+========================================================================
 
 Author: Dominik Brodowski  <linux@brodo.de>
 
diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index 21338fa92642..da5d5ad2bdf3 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -1,6 +1,6 @@
-=======================
-Linux Kernel Crypto API
-=======================
+==========
+Crypto API
+==========
 
 :Author: Stephan Mueller
 :Author: Marek Vasut
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d3a58f77328e..b208e0dac3a0 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -1,6 +1,6 @@
-========================================
-The Linux driver implementer's API guide
-========================================
+==============================
+Driver implementer's API guide
+==============================
 
 The kernel offers a wide variety of interfaces to support the development
 of device drivers.  This document is an only somewhat organized collection
diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index b99dede9a5b1..eee5996acf2c 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -1,6 +1,6 @@
-==================================
-Linux GPU Driver Developer's Guide
-==================================
+============================
+GPU Driver Developer's Guide
+============================
 
 .. toctree::
 
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fe2cc6b73634..c2b3c1a822dd 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -1,6 +1,6 @@
-=========================
-Linux Hardware Monitoring
-=========================
+===================
+Hardware Monitoring
+===================
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index 9888f5cbf6d5..35581cd18e91 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -1,6 +1,6 @@
-=============================
-The Linux Input Documentation
-=============================
+===================
+Input Documentation
+===================
 
 Contents:
 
diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 4aa12b8be278..5a94a921ea40 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -1,6 +1,6 @@
-=====================================
-Linux Memory Management Documentation
-=====================================
+===============================
+Memory Management Documentation
+===============================
 
 Memory Management Guide
 =======================
diff --git a/Documentation/peci/index.rst b/Documentation/peci/index.rst
index 989de10416e7..930e75217c33 100644
--- a/Documentation/peci/index.rst
+++ b/Documentation/peci/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0-only
 
-====================
-Linux PECI Subsystem
-====================
+==============
+PECI Subsystem
+==============
 
 .. toctree::
 
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index b430d856056a..1aac972a652f 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -1,6 +1,6 @@
-===============
-Linux Scheduler
-===============
+=========
+Scheduler
+=========
 
 .. toctree::
     :maxdepth: 1
diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 7c5f5f8f614e..919f3edfe1bf 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====================
-Linux SCSI Subsystem
-====================
+==============
+SCSI Subsystem
+==============
 
 .. toctree::
    :maxdepth: 1
diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 4d7d42acf6df..5abed5fc6485 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -1,6 +1,6 @@
-===================================
-Linux Sound Subsystem Documentation
-===================================
+=============================
+Sound Subsystem Documentation
+=============================
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 56e003ff28ff..7fb55ae08598 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-============================
-Linux Virtualization Support
-============================
+======================
+Virtualization Support
+======================
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/watchdog/index.rst b/Documentation/watchdog/index.rst
index c177645081d8..4603f2511f58 100644
--- a/Documentation/watchdog/index.rst
+++ b/Documentation/watchdog/index.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-======================
-Linux Watchdog Support
-======================
+================
+Watchdog Support
+================
 
 .. toctree::
     :maxdepth: 1
-- 
2.25.1

