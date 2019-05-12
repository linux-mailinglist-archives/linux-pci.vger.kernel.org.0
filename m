Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9091AC15
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfELMu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 08:50:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40147 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfELMu0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 08:50:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so5316366pgl.7;
        Sun, 12 May 2019 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ID+FnkIsdsZZMHR0TLy2V6Zvg3KgV03Hfi0KeMPekp0=;
        b=NDlLj5nzt4sv/G1h38gd65TbDuLxRpNGGJB1U1LTuU0ZoxHqOPQ7B+rJBJ/5u5LEbP
         ltkpXruirUbrJEI3UW4h+7VZciaC4LHtNXlMZQAR/eULyuDKGEk5nYzmeyJXciopaOrG
         yVUu+yzY+fWNbEqV5+bktX0SHUw1b3L3EVNVxcR7KVu+wdQbA8WtPXbv5Cn22H1xVqK+
         TN35R53BKdeHblC6mxN/KieS+XTDhNqZUZLlUC9MQScxlmjNnfOcuYjw1gtY3yTkNwfY
         yvDf3fqAOE60zbuJL8ThOjbwqwlmlvFQr6cCTN6Hjbfk8/Oi0Bv6gGh4KkZRgaEZN82i
         YQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ID+FnkIsdsZZMHR0TLy2V6Zvg3KgV03Hfi0KeMPekp0=;
        b=a39YjTx+EW3D4p6re6xrHqZ9HKgQiuaS33B/WFjVVz3zSMkmPWmxIYP0BeDzUn4cVw
         LRAd+7fJg6TJ2x+iL14wTzurP0eb1+yc14wNEWNz68FD/gM9ltpSzRctxAVLw0M+ReB3
         zlt+GaFK6rhDOclx4ku1dUIPLpFfm9BjlT4bJP/s/PRpzg7ZePy/OpNL4sO0LzhLK+lj
         RluyWSXYwGfn9stQj4DA4WR2OK9AmJ/HlKWnErYTztJ1cK9fkvzdPVAMAWDwsnMhIE95
         lSsKVOQJSEzZYrLb3Egj7EYlxzMir0O6wNh1eqVAT3WMJVtTNTwlL8apUd/aZyusoaaG
         TdNQ==
X-Gm-Message-State: APjAAAVjqz3A/KWKuyPrIGS7pPAlH29cbaNSdENLm+1XYDhBiCSyioMO
        E29Ao/mF5QJff6EEvQ2Ea0I=
X-Google-Smtp-Source: APXvYqx1MURAMugsEwI2GJoOnkxPy/0xLoML4WLYdEwlv41NNm+VzQ+M/LTTCGTfl2TUoala8ffJxg==
X-Received: by 2002:aa7:8157:: with SMTP id d23mr90254pfn.92.1557665425593;
        Sun, 12 May 2019 05:50:25 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id n2sm146426pgp.27.2019.05.12.05.50.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 05:50:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 00/12] Include linux PCI docs into Sphinx TOC tree
Date:   Sun, 12 May 2019 20:49:57 +0800
Message-Id: <20190512125009.32079-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

The kernel now uses Sphinx to generate intelligent and beautiful documentation
from reStructuredText files. I converted most of the Linux PCI docs to rst
format in this serias.

For you to preview, please visit below url:
http://www.bytemem.com:8080/kernel-doc/PCI/index.html

Thank you!

v2: trivial style update.
v3: update titles. (Bjorn Helgaas)
v4: fix comments from Mauro Carvalho Chehab

Changbin Du (12):
  Documentation: add Linux PCI to Sphinx TOC tree
  Documentation: PCI: convert pci.txt to reST
  Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
  Documentation: PCI: convert pci-iov-howto.txt to reST
  Documentation: PCI: convert MSI-HOWTO.txt to reST
  Documentation: PCI: convert acpi-info.txt to reST
  Documentation: PCI: convert pci-error-recovery.txt to reST
  Documentation: PCI: convert pcieaer-howto.txt to reST
  Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
  Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
  Documentation: PCI: convert endpoint/pci-test-function.txt to reST
  Documentation: PCI: convert endpoint/pci-test-howto.txt to reST

 .../PCI/{acpi-info.txt => acpi-info.rst}      |  15 +-
 Documentation/PCI/endpoint/index.rst          |  13 +
 ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++---
 .../{pci-endpoint.txt => pci-endpoint.rst}    |  96 +++--
 ...est-function.txt => pci-test-function.rst} |  34 +-
 ...{pci-test-howto.txt => pci-test-howto.rst} |  81 ++--
 Documentation/PCI/index.rst                   |  18 +
 .../PCI/{MSI-HOWTO.txt => msi-howto.rst}      |  85 +++--
 ...or-recovery.txt => pci-error-recovery.rst} | 287 +++++++-------
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++----
 Documentation/PCI/{pci.txt => pci.rst}        | 356 ++++++++----------
 .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 156 +++++---
 .../{PCIEBUS-HOWTO.txt => picebus-howto.rst}  | 140 ++++---
 Documentation/index.rst                       |   1 +
 MAINTAINERS                                   |   2 +-
 include/linux/mod_devicetable.h               |  19 +
 include/linux/pci.h                           |  37 ++
 17 files changed, 912 insertions(+), 688 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (82%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (84%)
 rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
 create mode 100644 Documentation/PCI/index.rst
 rename Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} (88%)
 rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (67%)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
 rename Documentation/PCI/{pci.txt => pci.rst} (68%)
 rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)
 rename Documentation/PCI/{PCIEBUS-HOWTO.txt => picebus-howto.rst} (70%)

-- 
2.20.1

