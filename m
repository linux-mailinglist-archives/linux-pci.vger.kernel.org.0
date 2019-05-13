Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E060C1B809
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfEMOUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:20:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42197 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbfEMOUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:20:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so6856654pgg.9;
        Mon, 13 May 2019 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea7nruMQN3xltZvYgCBaDR2hEGB3xQK7d3rHkYgLjnc=;
        b=G+q5VZQbO7eXufp4kJSVBf0ME6AnkUHOR8rZIkypYQa9tS6EFlXYyPAysc5X8BQQO/
         +bKz7nycBXIRIpHR6f2KKrHiWQc5i/FZ2y1Y0aLIyMpkOLqMlsn3NZiatUSzFA211oMF
         z6izXeniDyPJ53anykZ6cWRXJWymYN0ljn/yUg+1kK/U5u3B4nDQQXVbno/TFVfzObBw
         WQbb+gSzyNtETNrpZPBKLzXTAG4tnUcQbfBjDcBlxu7OR4jnssUxWm97YW451YyQnPLC
         7+lGCezFuqEUIB4vPPtuTZl4PVss0/ZqTaQKk1LiVFhsW7WJgufK8rRNrj2HV9M3DKII
         hW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea7nruMQN3xltZvYgCBaDR2hEGB3xQK7d3rHkYgLjnc=;
        b=HXIXdBVveJxQZ8C9avV2F5TxzcIllXG9lCtN1G/G+LC7Zh5EUZwEZerPasiso29dgk
         iA1vljnWRAvCqGg5PiOQ8PJ+TvbsAkXpcpTa29zkyp5MavpILQqhhzB6te1IubpIx6hy
         djA979sb2TvdDsaeSEBPLd/XHZESojMaLB2lQF6LlC2hLH5eN1jsZA/QVulB1myjVu2O
         rS6+qz5wL04RKN3BkCP1CJN9NirFMFzDTCENYVJccF9V0Nqb+QhZT1RokuLwa8NikmhU
         1+mRM9bhGdkF0TTTS4q34urf+n/g2StQpUU7/ETNFs2U+0cq5StrMjmqyH5hxECp6CSZ
         XJwg==
X-Gm-Message-State: APjAAAVLK9koHmteKkD3Dwi24imdmXLoXxmUrWKTZUrRigxm2npAqJRU
        cdX2OmIkfMWnqGcFC8BvbzI=
X-Google-Smtp-Source: APXvYqz2Lzq0ADqofSD1kaYKWyyKE8scQV+qXjYsX0bEreGuZyw8Nj5qwgr4T+noOYWRAIMspg2Bxw==
X-Received: by 2002:a63:fd50:: with SMTP id m16mr31726847pgj.192.1557757221391;
        Mon, 13 May 2019 07:20:21 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.20.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:20:20 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 01/12] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Mon, 13 May 2019 22:19:49 +0800
Message-Id: <20190513142000.3524-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513142000.3524-1-changbin.du@gmail.com>
References: <20190513142000.3524-1-changbin.du@gmail.com>
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

