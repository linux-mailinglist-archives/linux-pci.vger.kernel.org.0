Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69442E5BB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJOBJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 21:09:51 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:36417 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhJOBJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 21:09:51 -0400
Received: by mail-lf1-f47.google.com with SMTP id g36so17850004lfv.3
        for <linux-pci@vger.kernel.org>; Thu, 14 Oct 2021 18:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnpB7GLmJUWLLjvW/es//ZQxgSG2Qq19iOYvBaKTgaM=;
        b=MyzYzT39yIbHpYEZifn2vbm8h9ftHkSo9302R6sfkeWOinGe1YiO5PRFU9EMkfW7E8
         gDtzN1qOSKP6F8yvFpNBMd2r/fKdcM3/WSCz99nsqc9/oenUQogao9GnBOe7/jxhPOqF
         BwEgP2M90Hx2HS/bQ7UCa7A4xQNKGbScdci/N5Xv0iEc5VeNSKaiKH4cjhAMJdmQFp6z
         oWsdLaS3dCdKIyXnKXL4fXbVnH4qm8GKZGMyV921PdbxFrLsxJZVNoUIEWJb8tUQ3Pyd
         I4ahxiQOaeR76y9PM/KEJjoCI+54UlZc1ZlXOwO/6ZFil6Ijijh4n2CUkxMHxQvtnuPD
         nX4A==
X-Gm-Message-State: AOAM530u9RoFbchh9uFUJiJb1Y+LDGclbYGQw1uvNVLr9fB4X5NKZJ2z
        NX1x1QyX9jjngyWWCTGhB48/9PbfGAI=
X-Google-Smtp-Source: ABdhPJz+mgcvRhrEogADXYKG0NXq4TDEwPi+NRbwYAHD7BJdUJLuR0x5kPPbo6FPEewJiWj0vhud8w==
X-Received: by 2002:a05:651c:987:: with SMTP id b7mr9788251ljq.279.1634260064616;
        Thu, 14 Oct 2021 18:07:44 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z12sm359958lfd.283.2021.10.14.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 18:07:44 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update information related to the PCI sub-system
Date:   Fri, 15 Oct 2021 01:07:42 +0000
Message-Id: <20211015010742.1236057-1-kw@linux.com>
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
 - Add Bugzilla link
 - Add link to the official IRC channel
 - Add file "drivers/pci/pci-bridge-emul.c" to the right section

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 MAINTAINERS | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 703aa3150a15..454303f95132 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14446,9 +14446,12 @@ M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 R:	Krzysztof Wilczyński <kw@linux.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
 F:	Documentation/PCI/endpoint/*
 F:	Documentation/misc-devices/pci-endpoint-test.rst
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
 F:	tools/pci/
@@ -14494,15 +14497,20 @@ R:	Rob Herring <robh@kernel.org>
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

