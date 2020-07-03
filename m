Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415B72140B8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jul 2020 23:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGCVWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 17:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbgGCVWR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jul 2020 17:22:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A37FC061794;
        Fri,  3 Jul 2020 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JXl+E0oYBWH0xWHaHqCciL9WMfvbPRZNvUr3AbrKGrY=; b=2gr9rVchUlmn8OJ2WB61HV5bpf
        x0phGo110WDSibJTZLnvlFs3VhhcXGzcX838xwHyv4UxRO7V7QYt8lSDXp7f78fENYGRPoCl8wgrv
        5T1CKikyRbAKjIN5laWEADItR0fjp5Rc2xEvkRy2DVhKaX+rxJ4hIeQn76Xl3m8AIfgrHVppzLNZ3
        yvOSdyp6Fan119bHJjtCgy/VsRFx//so9Gu6/h7Et1CK19U5OFReEECBzlGvATPfkPR/bO/ztFZCi
        tgm4QS95gseqXqLQOzLUsr7KuDmMPyz9LzrDlqoENjRppKNZNNFC/zCL6OIc2j8UkhXyAuvR06M4Y
        HXwkLsEw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrT8Q-0005tj-GN; Fri, 03 Jul 2020 21:22:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 4/4] Documentation: PCI: pci.rst: drop doubled words
Date:   Fri,  3 Jul 2020 14:21:56 -0700
Message-Id: <20200703212156.30453-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703212156.30453-1-rdunlap@infradead.org>
References: <20200703212156.30453-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Drop the doubled word "when".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 Documentation/PCI/pci.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/PCI/pci.rst
+++ linux-next-20200701/Documentation/PCI/pci.rst
@@ -209,7 +209,7 @@ the PCI device by calling pci_enable_dev
    OS BUG: we don't check resource allocations before enabling those
    resources. The sequence would make more sense if we called
    pci_request_resources() before calling pci_enable_device().
-   Currently, the device drivers can't detect the bug when when two
+   Currently, the device drivers can't detect the bug when two
    devices have been allocated the same range. This is not a common
    problem and unlikely to get fixed soon.
 
