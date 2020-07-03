Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25F2140B1
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jul 2020 23:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgGCVWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jul 2020 17:22:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3494EC061794;
        Fri,  3 Jul 2020 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rMwSX67PivDpF6NsrAsev2yjrA5+1p667mZowINMO3w=; b=tOELBrB/oAo/w96ROmuUMkKJOr
        SiqATKPQxAUGVClSuBi+KimWLLhNxM0dXtTy/3A0iI7EyURAcLSRHtteNvq5SPz90iRDR3CJHltbr
        5EME6DGxuLZctOJcJpYu+FDvWlF8zZpa9XieGQaJ3ZB4/AGUNx+HK3UzGj7JlMl7vOC+RAeM2nl6e
        L5sRk3jyE7VJ96OEY0vRYM3xkaf+Ql8tPindwpXJ/yVu9MMFZcixrKCeFVKW8lDLR5IAUiBuWQw+F
        hYdbnUlorYmJG/GbESNnAkrrDkZFv8j9JpuiO6ECRC0D+g5l84b3jN/YawGcGve3gvJ+0Mp8l2kd2
        Qy4qB4HA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrT8G-0005tj-PK; Fri, 03 Jul 2020 21:22:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 1/4] Documentation: PCI: pci-endpoint-cfs: drop doubled words
Date:   Fri,  3 Jul 2020 14:21:53 -0700
Message-Id: <20200703212156.30453-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703212156.30453-1-rdunlap@infradead.org>
References: <20200703212156.30453-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the doubled word "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org
---
 Documentation/PCI/endpoint/pci-endpoint-cfs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
+++ linux-next-20200701/Documentation/PCI/endpoint/pci-endpoint-cfs.rst
@@ -24,7 +24,7 @@ Directory Structure
 
 The pci_ep configfs has two directories at its root: controllers and
 functions. Every EPC device present in the system will have an entry in
-the *controllers* directory and and every EPF driver present in the system
+the *controllers* directory and every EPF driver present in the system
 will have an entry in the *functions* directory.
 ::
 
