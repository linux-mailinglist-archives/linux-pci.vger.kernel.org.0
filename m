Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824AB1CADC
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfENOro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 10:47:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENOrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 10:47:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so9258134pfn.7;
        Tue, 14 May 2019 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvTVVtDZuqjWYWGv3wOfnHFg54NPDwz8Y09qcxgYGas=;
        b=nY5b8E423/ei9n51fU7pz6LahDlN6P5pg7XmmvVpW6Kt8YIjvLAynVKwrR9dt6zoQ9
         m3aGr/5i+rm5H+AK8kB15ksxlQkL0HwO7gXjqsbCAc/GqVqlEEc62Vs4/2kszSTpc+ob
         475tVx7XeBFl2S5Z9P0fSgUweqKyIkz/5kL78YHdR0u3sZ2ujXt6TnthKWIYJiL6qkSW
         7otrl7Wyzb1B52ATfbepn22cxAlW2Qx0hYN0Ylza4uHgwlRc6PEaXdkxXnRP4M/J+aAn
         HGzqA5gj7T0H7xBNE2gMAUk1tBracDKTOyJW4d6jPbHgRwnDDFJ84CBcjbfudmfVfBOB
         Vzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvTVVtDZuqjWYWGv3wOfnHFg54NPDwz8Y09qcxgYGas=;
        b=j51rctbgbVUp6Zh7fB5xJPtR8+77lfxTs4JK2f2V1D1oH9IpAtMaqPrIQIVOYdoJn+
         9XZlPIjSGWZuH2KQ6DCHMOJd+s1lhQml1YWkqHwf/AHItEtOPRfFPUS/PvdO9MIcaFcl
         I3hLVhrFEyBqluEe4QkE3W3uZbLS/PEWXNdmLQBU9m45hE/XtrtpycPnY254e675K97r
         4Nu0+kNBR4nfL3icOI5jnsrw2mZt7usmZrG+KKGBIEPOORa6gsj3LQfNx2BK471/95Z8
         rzvaMkrJJQRg7XswDOW4u7g0NDHtLJ/JbQlRw+76LVm/PehfpK2wq75lZYCCOi6cVE/7
         tRcA==
X-Gm-Message-State: APjAAAXb/9OIVhIFuM6q57x+PSmaO10wPCeCDQbgZmO+dPfDuVBnCR8l
        KQwvNJZtmaXaKKIASfv7AF4=
X-Google-Smtp-Source: APXvYqywCPxowiffZWYrYtb+FnI/R/I4J4jSzp35jr3GmLi09Z8qkPcaSnJjmtz7YBgG2C88CIHrgg==
X-Received: by 2002:aa7:83d4:: with SMTP id j20mr19823511pfn.90.1557845262955;
        Tue, 14 May 2019 07:47:42 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id j12sm20461415pff.148.2019.05.14.07.47.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 07:47:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     bhelgaas@google.com, corbet@lwn.net
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Date:   Tue, 14 May 2019 22:47:22 +0800
Message-Id: <20190514144734.19760-1-changbin.du@gmail.com>
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
v6: fix comments.

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
 .../{pci-endpoint.txt => pci-endpoint.rst}    |  92 +++--
 ...est-function.txt => pci-test-function.rst} |  84 +++--
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
 17 files changed, 938 insertions(+), 710 deletions(-)
 rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)
 create mode 100644 Documentation/PCI/endpoint/index.rst
 rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
 rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (83%)
 rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (55%)
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

