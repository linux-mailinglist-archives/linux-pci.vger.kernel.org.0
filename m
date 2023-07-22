Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE30475DF48
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 01:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGVXZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jul 2023 19:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVXZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jul 2023 19:25:07 -0400
X-Greylist: delayed 935 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Jul 2023 16:25:07 PDT
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019F219A6
        for <linux-pci@vger.kernel.org>; Sat, 22 Jul 2023 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=lBbeBShkkFDKlYKODKONmviuP1PzwtNjdCIXfLBCH5Q=; b=U/fTHd6XLgHw07JnC6UGT4NDP7
        6R6cEX0o9tbjE+KIcISQVgwOm0QDWaNoCgOyBAaVwp7BQeTo/Q/H9o5Jw/IlXzDznat9zzISccA4q
        0Q0cYlLbu0eKM8OfgpSiLgcdPQkDLFMaMTtz8OOJDaAPHIo5Dele+ZVKuLSOkDJ1pbvx8KM7h21gt
        fLHlfPQ3X8y9fb2Bxkx+Psne3yOJo5NBYmIFaFlm7qNETrhu2Y69GgiSxxxHU6sTYXpP5+qWsng7E
        LLE0C7IgoCrVBouApHS/f13Dp0gD/PuCHmtJjWfYCbwf2LqHHlHc2r7LM9LPkJhJ6mp+k5NQ/pPE5
        mM5OhDDw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1qNLiz-0001HF-P4; Sun, 23 Jul 2023 01:09:21 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1qNLiz-000OAF-4P; Sun, 23 Jul 2023 01:09:21 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        mhi@lists.linux.dev, ntb@lists.linux.dev,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] PCI: endpoint: Make pci_epf_ops in pci_epf_driver const
Date:   Sat, 22 Jul 2023 16:08:44 -0700
Message-Id: <20230722230848.589428-1-lars@metafoo.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26977/Sat Jul 22 09:27:56 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_epf_ops struct contains a set of callbacks that are used by the
pci_epf_driver. The ops struct is never modified by the epf core itself.

Marking the ops pointer const allows epf drivers to declare their
pci_epf_ops struct to be const. This allows the struct to be placed in the
read-only section. Which for example brings some security benefits as the
callbacks can not be overwritten.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/pci-epf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 3f44b6aec477..34be3f1da46c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -98,7 +98,7 @@ struct pci_epf_driver {
 	void	(*remove)(struct pci_epf *epf);
 
 	struct device_driver	driver;
-	struct pci_epf_ops	*ops;
+	const struct pci_epf_ops *ops;
 	struct module		*owner;
 	struct list_head	epf_group;
 	const struct pci_epf_device_id	*id_table;
-- 
2.39.2

