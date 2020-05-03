Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2112C1C2FD8
	for <lists+linux-pci@lfdr.de>; Sun,  3 May 2020 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgECVuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 May 2020 17:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgECVuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 May 2020 17:50:08 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3DC061A0E;
        Sun,  3 May 2020 14:50:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g16so8532064qtp.11;
        Sun, 03 May 2020 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZjIiTEMLVmqUP3ggI1JgtbaT6DgcJGqyDxuUhi2YtY8=;
        b=j/WHvpRTAz1WPwghbg/Qc4uDbPUSTQFCGx3WgjTeZRVB743Lf6Q1kCeAO+/8+NNGhv
         8I4QPRjJ7E1mgH0y9Hi0jUIZd9gRLgVZtlriDqGMpdVq8fnlibbAbpddEAhddZDZiHD4
         hrRVW8ShPaDuIgFZDodCNpdhixMMst5MGQyZ0BFi8d4DKveaB2V3rZbqHDbANz+zTRYO
         wjAkLPSuCRvzl0v4Jgh3w4O1XlYkGV+detNScv2eJLeHaIXpatVpZODyV/D6LGGUEF5R
         uJZjp8PRKe66YEt6OH7E0HrGud1MascD1LKpBATxZOVBuBbr3xpeXgNia7DXU3qVCGSk
         b7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZjIiTEMLVmqUP3ggI1JgtbaT6DgcJGqyDxuUhi2YtY8=;
        b=uKQRYFADAXvBhRUo83y+XJnr5w1RWZOpJ5Zr69HCOCuLZkBi99xZ3t4l1FWjkvY+iv
         0On7RJtyy7a30Jxcmj0DwSzNmAhy5E2Mz1QkMrNFsN4lv6whSCfKnH/pznp3uBWGVgB9
         IyXlmU0T7uouBC4tZ/L0dK9gGZukaBJfBwWmZRoYfnXn1y7qVlYWC8vKMJXoVLaIEUV3
         YYXKC98gj5XFAIjkDTdyGtFoFFZRn5KrfN6il/ez23slN7EAhx67ct+h+JcGB4Popcul
         wFoM8ITItkcDBlFl2X8n2NWWMm28cWqqelb54/0wv0eLPcutGXkPZQqtMzxnn3dUOolH
         Ps2g==
X-Gm-Message-State: AGi0PuZ/sWbrJkjSEI2rjkzU0ffTWOL9O2YXf/86ndxM1IWJBTT7fZhD
        WhStIZcr6PFU+/zpUXg6Ipc=
X-Google-Smtp-Source: APiQypLt2VHAWV3x/1O/uRAHvUr+OWt5u2AOhi5eAIwbM57jQqP+2CMjJbZHa48m+Js5g9aaneBqcg==
X-Received: by 2002:ac8:568b:: with SMTP id h11mr14370061qta.197.1588542606908;
        Sun, 03 May 2020 14:50:06 -0700 (PDT)
Received: from brycew-desktop.hsd1.ma.comcast.net ([2601:182:cf00:7ca0:d9dc:38ce:3821:f715])
        by smtp.gmail.com with ESMTPSA id c6sm8177194qka.58.2020.05.03.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 14:50:06 -0700 (PDT)
From:   Bryce Willey <bryce.steven.willey@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        Bryce Willey <Bryce.Steven.Willey@gmail.com>
Subject: [PATCH] Documentation: PCI: gave unique labels to sections
Date:   Sun,  3 May 2020 17:49:26 -0400
Message-Id: <20200503214926.23748-1-bryce.steven.willey@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bryce Willey <Bryce.Steven.Willey@gmail.com>

Made subsection label more specific to avoid sphinx warnings

Exact warning:
 Documentation/PCI/endpoint/pci-endpoint.rst:208: WARNING: duplicate label
pci/endpoint/pci-endpoint:other apis, other instance in Documentation/PCI/endpoint/pci-endpoint.rst

Signed-off-by: Bryce Willey <Bryce.Steven.Willey@gmail.com>
---
 Documentation/PCI/endpoint/pci-endpoint.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 0e2311b5617b..7536be445db8 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -78,8 +78,8 @@ by the PCI controller driver.
    Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
 
 
-APIs for the PCI Endpoint Function Driver
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+EPC APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
@@ -117,8 +117,8 @@ by the PCI endpoint function driver.
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
-Other APIs
-~~~~~~~~~~
+Other EPC APIs
+~~~~~~~~~~~~~~
 
 There are other APIs provided by the EPC library. These are used for binding
 the EPF device with EPC device. pci-ep-cfs.c can be used as reference for
@@ -160,8 +160,8 @@ PCI Endpoint Function(EPF) Library
 The EPF library provides APIs to be used by the function driver and the EPC
 library to provide endpoint mode functionality.
 
-APIs for the PCI Endpoint Function Driver
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+EPF APIs for the PCI Endpoint Function Driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This section lists the APIs that the PCI Endpoint core provides to be used
 by the PCI endpoint function driver.
@@ -204,8 +204,8 @@ by the PCI endpoint controller library.
    The PCI endpoint controller library invokes pci_epf_linkup() when the
    EPC device has established the connection to the host.
 
-Other APIs
-~~~~~~~~~~
+Other EPF APIs
+~~~~~~~~~~~~~~
 
 There are other APIs provided by the EPF library. These are used to notify
 the function driver when the EPF device is bound to the EPC device.
-- 
2.17.1

