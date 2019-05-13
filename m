Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5E1B806
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 16:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfEMOUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 10:20:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbfEMOUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 10:20:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so6584883plz.1;
        Mon, 13 May 2019 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlhYJ90ofQ2Zr9Y+SOGQmX2unDhBRzK1V3FREqlRH+I=;
        b=AKMtRnklH+seg+WEw3Qyba/aDLReD06wyiitmqq4ZD72fRzwB9b0cyu/YszACKxEPb
         uZGiAcKFqzsrKiaBoZdiozfUVwhQbIATQ/zuSwZ58m+qPgyKZCW5gVbvZXI2AnD8SKly
         n9n7ujMAkzGD7x2eM2bxYsWMTra3iTj4ZsIaEEo+LRGxc/6dnW9cqI2k8PmVt1Nc2qVY
         nxPyfWHo58yxv7cYUfxneIKyFRCRhDxqVCfyD33WG+Xtkc830urXfXEhUgGnYzNFnHM4
         pOXKu7x5Vho6c+WHsR1WEviXiYit7VEiefjoeOPnnJiDNpBHe2JXW/L9kZpgCykQ4nQj
         Cj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NlhYJ90ofQ2Zr9Y+SOGQmX2unDhBRzK1V3FREqlRH+I=;
        b=piDFPkula0ZYJ/w7Vz5yWMlJU+Ir4k6acRnDv0/a8hg/OZqjMx897Sr1Y/Ci9oh688
         cPSa+LXxcKe5NA7mNQXu76PM+YlnlXX6Ktbd6e3dixTAYvl/Bl2T4ad5Aqa/LeajVSm+
         cwHwvqTkoSpsXibmIyx01ibjMuVs4QvsShVvfhchVS6QNho+COqfjjhabiBqSOJVdfD1
         HQW/RSvytqe9OZgiLAMOdX37EHQuVIR3fkZ8DfBqcFjGA1TFT79YveUcee6DhJARxKnj
         uWhC9UK0OHgrkwB08hp/1bM5+R6YOtZ6+kRDATUG71kt8mUH4SNbxyPhSbxD5JtSiJMQ
         h9JQ==
X-Gm-Message-State: APjAAAXkvVwNVlZfyMJK3nrwVZJx6V2xCFrNmDfhrfDZUPiw5mIJFrAE
        X/hiizvg3KpVkUT6sgMz9+sNAGC+
X-Google-Smtp-Source: APXvYqyk4gV/sp19JogOd/chm45Y4hPNu2PzX9sLqdp1AeoZk6HbnY0K43/n73YnCjAjLcw83NK8jw==
X-Received: by 2002:a17:902:b412:: with SMTP id x18mr31197262plr.304.1557757216857;
        Mon, 13 May 2019 07:20:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id x30sm15382513pgl.76.2019.05.13.07.20.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 07:20:16 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 00/12] Include linux PCI docs into Sphinx TOC tree
Date:   Mon, 13 May 2019 22:19:48 +0800
Message-Id: <20190513142000.3524-1-changbin.du@gmail.com>
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
v5: update MAINTAINERS (Joe Perches)

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
 MAINTAINERS                                   |   4 +-
 include/linux/mod_devicetable.h               |  19 +
 include/linux/pci.h                           |  37 ++
 17 files changed, 913 insertions(+), 689 deletions(-)
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

