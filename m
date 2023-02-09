Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39E6905AD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 11:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjBIKwG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 05:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjBIKvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 05:51:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401D24C3B;
        Thu,  9 Feb 2023 02:51:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 011E935323;
        Thu,  9 Feb 2023 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675939892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3VmvHsFuUSDUUnmjQ9gV//enwxyKX0UbQjfQC124yu8=;
        b=mHPdGmPR3MPglkFRBWIYdHUWa2DUx5ZOY6eOhz5G79gGxlsdCCjd2N49bQD2Jj1pqfAsWt
        jcHNpajmAwrezwxlf2nz6xUPKIKjBZzFCdbs1XJDKsJoMfaz0cIqIgjSBItkwO6WaDBKLC
        gvNIXVrulVemF82YFqo3TixkuQ5LcKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675939892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3VmvHsFuUSDUUnmjQ9gV//enwxyKX0UbQjfQC124yu8=;
        b=zEr45oRmoDqP2QtSBqE2khOBzdvry/jV+IzuVI3vpKFOjGq0C3SMp6BJBLK8VQFtCQC7xT
        gUW/GbVuOvrOceAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B60201339E;
        Thu,  9 Feb 2023 10:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 54u6KjPQ5GNOLgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 09 Feb 2023 10:51:31 +0000
Date:   Thu, 9 Feb 2023 11:51:30 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=" <kw@linux.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] PCI: xilinx: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230209115130.114e2ad0@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: "Krzysztof Wilczy=C5=84ski" <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 drivers/pci/controller/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.0.orig/drivers/pci/controller/Kconfig
+++ linux-6.0/drivers/pci/controller/Kconfig
@@ -98,7 +98,7 @@ config PCI_HOST_GENERIC
=20
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe


--=20
Jean Delvare
SUSE L3 Support
