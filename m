Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671B730CCDD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 21:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhBBUNn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 15:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBBUNm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 15:13:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043CC061573;
        Tue,  2 Feb 2021 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/r/WPmX0rkYqfttFzRKsV+hgjsh3bZ14tB7P3tI6PZ0=; b=yMB3HKvcHkZAxPZJHg9jJedZ/1
        w4rgaNnFfG/bu1H4w645NVgFdizX3cosn14fkdJGFxGAPptby0N38krynB5HJD3nWs6WxY0480vgw
        nJQYB2c7P67NDw5dJ4FGAxHnlbVvbt4ZnwUEvorD6xgHxWBREZol1BABKbTbiKI+kUgCojKLX8vQv
        Fl9gspfSAh16ipfnXKrOYypbjUkcaFBKtOUn8Oj9iDubENCn3l9Tn1YpvEkSNqZryuUTEI/6PNYq8
        T8k/Ccg62nWXXOQ15q2IILSUqeDesGbsjIKL02d4N9qPGQkZw9cBFt8k7uobaRcrKVb4WHrt7RK0l
        M68wP2UQ==;
Received: from [2601:1c0:6280:3f0::2a53] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l722l-00078f-I0; Tue, 02 Feb 2021 20:13:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: endpoint: fix build error, EP NTB driver uses configfs
Date:   Tue,  2 Feb 2021 12:12:55 -0800
Message-Id: <20210202201255.26768-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci-epf-ntb driver uses configfs APIs, so it should depend on
CONFIGFS_FS to prevent build errors.

ld: drivers/pci/endpoint/functions/pci-epf-ntb.o: in function `epf_ntb_add_cfs':
pci-epf-ntb.c:(.text+0x1b): undefined reference to `config_group_init_type_name'

Fixes: 7dc64244f9e9 ("PCI: endpoint: Add EP function driver to provide NTB functionality")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org
---
You may switch to 'select CONFIG_FS_FS' if you feel strongly about it.

 drivers/pci/endpoint/functions/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210202.orig/drivers/pci/endpoint/functions/Kconfig
+++ linux-next-20210202/drivers/pci/endpoint/functions/Kconfig
@@ -16,6 +16,7 @@ config PCI_EPF_TEST
 config PCI_EPF_NTB
 	tristate "PCI Endpoint NTB driver"
 	depends on PCI_ENDPOINT
+	depends on CONFIGFS_FS
 	help
 	  Select this configuration option to enable the NTB driver
 	  for PCI Endpoint. NTB driver implements NTB controller
