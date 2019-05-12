Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806E11AC19
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfELMua (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:50:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38311 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfELMu3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:50:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so5316504pgl.5;
        Sun, 12 May 2019 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ea7nruMQN3xltZvYgCBaDR2hEGB3xQK7d3rHkYgLjnc=;
        b=p0dgvS6Gj0iqi7EIS2ptnTNiDMLFy7Vn9Av4n6d7SiTpBTRCGhwaajJO58XjV6oxi8
         GDonCo15IWAM8iKN7KcebLvSZx0cKCAI0VAR+MNB07sEnsx22AVxPFGNBg/OHcL3Fo2S
         kqcdREuRqaWNBpQ4BOihZZ0gwA36ZTVXroyFtO/lWao+US46f0RM8TvCKlGy5YhFqhSh
         TrBOqwiAp6k48Q4fOh41wFfjnAE4swtRAamiD3gq9hWAegaU54guQYUkD8pSTmYHeg7Y
         lPN7u495U9ZyEFC8z7TKTkACgtNemlXFmQWRDHFpS9NZGofSxMppOV1HjECVWKPnZ7dd
         xWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ea7nruMQN3xltZvYgCBaDR2hEGB3xQK7d3rHkYgLjnc=;
        b=XpzNdJjKgztuiJLOpXpmq4TDT1NHUfv+N0jA4ec+Bn4cwOxZxXa8YghEi+Y9FIcF/4
         3tG61gMIkYanGZbX+XNTcZ+ZRsYufCtlKpde6l4sY4QXzh2apSupfBfSG2lmMlGZ1tnz
         XH2WcYJplWsSIOofjcacjQ2uquYTWh/1PsoZJ4EQYIb+mTrwhyALqdHMbIp4jZju7EMn
         dlDBQk2GPIv+mpU2nGdfPCS3C1mP+DCtkZckDvnGmvRgG/9+561mg6vWQ54xctxtiwxR
         8BF4EOHBmnkjV/TT3GA8wgeW+xwcW4IBXv6QMWMNHBAq6DOzFB/zsBVhrjglx8A3KxsU
         hziA==
X-Gm-Message-State: APjAAAUaClpCnT1AhbHMyZvYq+TNn9jKFvttCkDH1SykX1PWlPbRZJOG
        vSRjM0kTPIp1x6AtXd5wKnY=
X-Google-Smtp-Source: APXvYqyVP6Xx9wc2yt7mn8U14ZFrkW8qLiGpuPYnjQMPJAgNd45rXY+Qco3vwNXaQIHHwK+grAhobQ==
X-Received: by 2002:a65:5687:: with SMTP id v7mr25696164pgs.299.1557665429129;
        Sun, 12 May 2019 05:50:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.50.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:50:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 01/12] Documentation: add Linux PCI to Sphinx TOC tree
Date:   Sun, 12 May 2019 20:49:58 +0800
Message-Id: <20190512125009.32079-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512125009.32079-1-changbin.du@gmail.com>
References: <20190512125009.32079-1-changbin.du@gmail.com>
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

