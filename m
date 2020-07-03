Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8682140B7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jul 2020 23:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGCVWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 17:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgGCVWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jul 2020 17:22:13 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C39C061794;
        Fri,  3 Jul 2020 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Wf7c/ot6i/EIgvDh5sbY5y/dPVIvmb6VHh8zu4vC6F0=; b=CNEg3v60S2ZUe2zOETcqskPQgC
        movP2RdIzmkmGf7ANGhKhuriE2wh8ed4hw2UBKfPKO90Ph+HPlNVovCFjbr05vzdTFLD1Ry3RE1Rg
        BWANV0T1KNcoQ/ls+RhSoYqsCWVFgFyiawSy3gubxcFhPxNADa7V1GdwbG9rNK25+r+qSzparIq1B
        iTuyXWy+HBrlbNtuQd2kkq8VduMpv2c1EueBbKXCtML2Xlg0rTabhVe8gxf/8armuAPghewjZnAra
        tAKGDyT8M3uf6h2uJuvVemzmDphcraTu+B98A+uN0bmVaxY2tgrlKnJmAqKrtedTRfjwaoFHjKbU6
        265foSuQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrT8N-0005tj-AJ; Fri, 03 Jul 2020 21:22:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Linas Vepstas <linasvepstas@gmail.com>
Subject: [PATCH 3/4] Documentation: PCI: pci-error-recovery: drop doubled words
Date:   Fri,  3 Jul 2020 14:21:55 -0700
Message-Id: <20200703212156.30453-4-rdunlap@infradead.org>
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
Cc: Linas Vepstas <linasvepstas@gmail.com>
Cc: linux-pci@vger.kernel.org
---
 Documentation/PCI/pci-error-recovery.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/PCI/pci-error-recovery.rst
+++ linux-next-20200701/Documentation/PCI/pci-error-recovery.rst
@@ -248,7 +248,7 @@ STEP 4: Slot Reset
 ------------------
 
 In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
-the platform will perform a slot reset on the requesting PCI device(s).
+platform will perform a slot reset on the requesting PCI device(s).
 The actual steps taken by a platform to perform a slot reset
 will be platform-dependent. Upon completion of slot reset, the
 platform will call the device slot_reset() callback.
