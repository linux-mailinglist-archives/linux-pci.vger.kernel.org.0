Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9A1CAB5
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfENOrs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:47:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38353 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENOrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:47:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so3285392plb.5;
        Tue, 14 May 2019 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea7nruMQN3xltZvYgCBaDR2hEGB3xQK7d3rHkYgLjnc=;
        b=Oium+gMmzkDR2We5B/z0hKCVKAbrqYaoB2WQHc90qg5fZMruPur14tFK1aYiKwh326
         wZQi8IV4btKhQzL6gy780H8W7QGX6ybhOWSKPyQS1uxe4TN1G3p01nUp3Bv4rWmj+Uge
         7np8BdbQU30JSMcZ3W8wlG5sGn30mjYp5HMxKUq/a2D9+xXDgZd22HxT6GCcTLxU9TQD
         geB/Tv8lPW7LKgzc+lwfHtJkNxF9y+F+5N2hEbFedTmGNq4haxY3F5e9TIc3XRg51nwp
         ty0HzzSTjq9w1vbN1EncyBeRKnNQHrvNjUwUY8stTOGsshCXKGkbt8n62yBlRTRbLE2h
         Vr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea7nruMQN3xltZvYgCBaDR2hEGB3xQK7d3rHkYgLjnc=;
        b=JRhzYSNR05CXFGBCxkU02HptEoWn5az95TyUJjL5PO5WW8Y/OR3iqaN91AT/D2y3Sr
         fS/9yglJcYdMoRcHn7ChNcSOvZdpJRJqppeghKxtsHQIjnfRW5aL9U+rk5/bhJj7t2G0
         6GWHo8AVtTu2BikGleDvjVmapOfDBM9zvwfgD/FbCEm3gscBf+PJI7rLZh+Yd/MLYMuw
         GigIhTImvWx/b27D6k9kfZVwQMwqklEYxGregW3GXjC2Pf04cmqXMvuECdi8tPwK8R7W
         LUbNBT8BTnfQp10wgKaCxIpzW6UHjE+J5PpH5GqP/svyE1m//kALFWyytodz3tPduHh2
         K0rA==
X-Gm-Message-State: APjAAAUuIqrZyAKyXzz4sPrae4rlBIuxhezHQFzUCtY6VR7fT3V0EjfK
        orPeOUvjXCv2B3i3oxhHl2s=
X-Google-Smtp-Source: APXvYqweRDojunBB0G6d++cMRFo3OyV9PMyL2KaeV6iPXwT3zUaeE0u5LciqR46V9uEau19WAMrRPg==
X-Received: by 2002:a17:902:6b8b:: with SMTP id p11mr37393091plk.225.1557845266955;
        Tue, 14 May 2019 07:47:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j12sm20461415pff.148.2019.05.14.07.47.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:47:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 01/12] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Tue, 14 May 2019 22:47:23 +0800
Message-Id: <20190514144734.19760-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190514144734.19760-1-changbin.du@gmail.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a index.rst for PCI subsystem. More docs will be added later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst | 9 +++++++++
 Documentation/index.rst     | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/PCI/index.rst

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
new file mode 100644
index 000000000000..c2f8728d11cf
--- /dev/null
+++ b/Documentation/PCI/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Linux PCI Bus Subsystem
+=======================
+
+.. toctree::
+   :maxdepth: 2
+   :numbered:
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9e01aace4f48..fb6477a692b8 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -101,6 +101,7 @@ needed).
    filesystems/index
    vm/index
    bpf/index
+   PCI/index
    misc-devices/index
 
 Architecture-specific documentation
-- 
2.20.1

