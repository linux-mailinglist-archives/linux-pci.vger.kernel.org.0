Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6D43C815
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhJ0KxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 06:53:11 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39773 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJ0KxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 06:53:09 -0400
Received: by mail-ed1-f54.google.com with SMTP id r12so8816069edt.6
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 03:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mq0+YMdh8RGU32blYz9GdwuPKv7CT4e12PGCFBhjRa8=;
        b=u5nzewlpOcOdcxC9SIA7ZtB3CuoLPeqJ2Yalnssa5WWWh1sGk6KcPeWiC9TjEO2dSr
         w6o1cEorPdm5OZu1bpN9S70xscu2QvxeSSA9x2C2vWKP/vWDuvHQTix3mQpbrbk1GNr3
         AiU4qZtf2Mu68u2ujZQuFv93sw996xvPIoK/TtQVDqgMPCVoakQcYq1gbd0LsKVMqLMi
         AmVBhMwGsDiTfuNotvy7KwlHqFT0uDUzNmtSv4FL9HiUhHrV4pLpuzVFqdvCl7tvD1Ff
         2VkohFFWBAbnaEKdLOv3QYnh3ignetauitAQL1+IY4x5AWjVwNiALyxBpXv72xFCqxnm
         xYYQ==
X-Gm-Message-State: AOAM533t/3dthXhYUpvaob28cY9JJqLTwU98Dsqpu/xKwJIVkquVreWc
        PuQBOhFOrp6BSTOo5z28eRQ=
X-Google-Smtp-Source: ABdhPJxx5vHkwmrcDmhJp9BUYtTRTlh0t/LWrKi6MmMN6wccTEO6uQPZsXDnf7AouXdhKnIF+pBSqg==
X-Received: by 2002:a05:6402:47:: with SMTP id f7mr43695896edu.52.1635331843049;
        Wed, 27 Oct 2021 03:50:43 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h10sm12573515edf.85.2021.10.27.03.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 03:50:42 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Update information related to the PCI sub-system
Date:   Wed, 27 Oct 2021 10:50:41 +0000
Message-Id: <20211027105041.24087-1-kw@linux.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the following information related to the PCI sub-system which
includes the PCI drivers, PCI native host bridge and end-point drivers,
and the PCI end-point sub-system.

 - Sort fields as per preferred order
 - Sort files in the alphabetical order
 - Update old Patchwork URLs
 - Update Git repository for the PCI end-point sub-system
 - Add Bugzilla link
 - Add link to the official IRC channel
 - Add files "drivers/pci/pci-bridge-emul.{c,h}" to the right
   section so that proper ownership is returned for both files
   from the get_maintainer.pl script

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v2:
  Add "drivers/pci/pci-bridge-emul.h" file that was missing as per the
  feedback from Pali Rohár.
  Update the PCI end-point sub-system Git repository link as per the
  feedback from Kishon Vijay Abraham I.

 MAINTAINERS | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80eebc1d9ed5..4436959c2f73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14459,9 +14459,12 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
 F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
 F:	tools/pci/
@@ -14507,15 +14510,21 @@ R:	Rob Herring <robh@kernel.org>
 R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
 F:	drivers/pci/controller/
+F:	drivers/pci/pci-bridge-emul.c
+F:	drivers/pci/pci-bridge-emul.h
 
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 F:	Documentation/PCI/
 F:	Documentation/devicetree/bindings/pci/
-- 
2.33.1

