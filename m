Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1E2140B4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jul 2020 23:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGCVWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 17:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jul 2020 17:22:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2F5C061794;
        Fri,  3 Jul 2020 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uLtSWlf/wl7gcoNSTGqlGLYfnZsXuKJLWSNWP3R9x8Y=; b=h8cSAQkTudBw8J96m8S+iDqOKv
        5qP+rKDdiy3CYy1bpBf2HSPltlLnIteQ5AlPZ7I53jVg6NK6bebY0yQVguHdCriZatNUbz8d9MOOC
        xa42XteSFljSGfvJt+hDlxtekPVTkWzLFEDNEhSCNfw8+Tz+proHnBk7oQ153hRNDjelm3Vcx0T29
        S0EVLApvROAE7vVw5aeEbtgMD/foIi4sGx2KyxEUmaXCwZiRuGdgslktCMTbGuHgSb/sqfyWofYxK
        z9SxU5HRd9cMC0vHNpf/ofv0dgLN+fsFCgBHnT3UbBCgUVCRkuRqI2bGkslS0pw3Z9uxuSDUf6TQ7
        3c9Pi2zg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrT8K-0005tj-1t; Fri, 03 Jul 2020 21:22:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 2/4] Documentation: PCI: pci-endpoint: drop doubled words
Date:   Fri,  3 Jul 2020 14:21:54 -0700
Message-Id: <20200703212156.30453-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703212156.30453-1-rdunlap@infradead.org>
References: <20200703212156.30453-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org
---
 Documentation/PCI/endpoint/pci-endpoint.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/PCI/endpoint/pci-endpoint.rst
+++ linux-next-20200701/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -214,7 +214,7 @@ pci-ep-cfs.c can be used as reference fo
 * pci_epf_create()
 
    Create a new PCI EPF device by passing the name of the PCI EPF device.
-   This name will be used to bind the the EPF device to a EPF driver.
+   This name will be used to bind the EPF device to a EPF driver.
 
 * pci_epf_destroy()
 
