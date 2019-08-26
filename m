Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587CF9D26A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 17:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfHZPOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 11:14:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43668 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfHZPOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 11:14:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id h13so26944230edq.10;
        Mon, 26 Aug 2019 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCDy+7K0fwF6nt7MbSVX8QMpTTG0g3KoAzAmdTsb8DY=;
        b=ObJMH1xIehE/7oddlecJPARz4qG1rnqBa8UxW+F7d5CbSW9le+05fqM91jvngewFm7
         IAhywnYGhMJV+QiaU0CiGNlGOQbbbyW6S+pIs3+LjabTbWy6cehK3Q1yeNYSU9ZHMZlX
         5sxuaVbJnKouPfQRlLo9I1hMCJdZvACLzbC+Tp2z0RYydY1Lr8j5DYqlfQoDp6psvPyw
         hIPkycJ8dvsDjToArfL3HFvAoW35LpHICPBlqpabSFG5MKfgezZvT4CMjYW4DesFTNx/
         IFxK1A9l+/Vj90h8Hiwzic/P0mCKWhUuQIgpWmKcMCl+5d+qlai/p8Qpw2ptP+B9bgMt
         Sw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=RCDy+7K0fwF6nt7MbSVX8QMpTTG0g3KoAzAmdTsb8DY=;
        b=VUqv6ZSz4IS77L03KD5FEFBXj4VL1C5Cm/ehQwnDD9okdW8/gGIQYXfssdW30Z2JI7
         Ix8cEjTqIkxR+1NS24eYX7sbVbYWeDBDGVdiJpag9wMGYs9DfaekL8oB7u3Wb6/y84fT
         sLg8wdt66ijD4+gMmIjNZTvNITGRJWd66Jpfsfd4ICSxTsLRq0toIRg5mpG/bFx//Uw/
         gj5a2Oaezj5Yb8E5j9iQkBRf+nZr6nzrJ3ROr8MS/KBJirsAykfmO7TsbvsPdvK0/OUa
         znjPa1ceIyROBatecbItDGr7+cvMU8RWkOb1Uxyf+nVvPi5s83DuTQfq5h4VzC/Vaxw5
         hvig==
X-Gm-Message-State: APjAAAVpTcqIKIEVfr9Y3LKSbbmECNIERCiw9v0IIhdzrtGZdjUVAbEz
        KruqhYWfsHkUQrUmgQ1sZb8=
X-Google-Smtp-Source: APXvYqwVjsfeA0fvtl5KyoGIk6txpb1HMvzkepsVRJ8coXd46DZ5CYhwp3DfC0p/YyPArLJg+vm5WQ==
X-Received: by 2002:a05:6402:1344:: with SMTP id y4mr18841237edw.124.1566832478387;
        Mon, 26 Aug 2019 08:14:38 -0700 (PDT)
Received: from localhost.localdomain (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id r16sm2976795eji.71.2019.08.26.08.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:14:37 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Move static keyword to the front of declarations in pci-bridge-emul.c
Date:   Mon, 26 Aug 2019 17:14:36 +0200
Message-Id: <20190826151436.4672-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the static keyword to the front of declarations of
pci_regs_behavior and pcie_cap_regs_behavior, and resolve
compiler warning that can be seen when building with
warnings enabled (W=1).

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/pci-bridge-emul.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 06083b86d4f4..5fd90105510d 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -38,7 +38,7 @@ struct pci_bridge_reg_behavior {
 	u32 rsvd;
 };
 
-const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
+static const struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
 	[PCI_COMMAND / 4] = {
 		.rw = (PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
@@ -173,7 +173,7 @@ const static struct pci_bridge_reg_behavior pci_regs_behavior[] = {
 	},
 };
 
-const static struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
+static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 	[PCI_CAP_LIST_ID / 4] = {
 		/*
 		 * Capability ID, Next Capability Pointer and
-- 
2.22.1

