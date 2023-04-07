Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB716DB12A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 19:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjDGRIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDGRIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 13:08:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F07AF34;
        Fri,  7 Apr 2023 10:08:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 459CE1F45B;
        Fri,  7 Apr 2023 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680887325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ie6wEHsNZgPqz0wZRp+I+ZedRjgx8Me72Po9MHCYCYs=;
        b=QTNx7w7Ny0sKViODgzt0NBr9LFu+Gg0j4hl3Ja0gajt1kPRrcuUsu8RYy7je2R85DoxP/D
        AuLDD6uU1A3VKoVG2nN96J6BuHnfyHafC7Au4P72yWcCXNRolYkrdPnc/oVQuaKIsvHW7B
        KV2RG9ctxI/JePlTPq4LMmOoNVUgYzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680887325;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ie6wEHsNZgPqz0wZRp+I+ZedRjgx8Me72Po9MHCYCYs=;
        b=+kecgV9AD0dOm+f9VbbAIYKUwLRO9qzUQW3cTYoF84RgqvzsVRgwDbr30xh4/UVe2NDnLL
        m07OYiCMLvxT6SDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06169133FE;
        Fri,  7 Apr 2023 17:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 63dIOxxOMGTlPQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 07 Apr 2023 17:08:44 +0000
Date:   Fri, 7 Apr 2023 19:08:43 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-pci@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH RESEND] PCI: xilinx: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230407190843.529caf19@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
Resending as the context changed so my original submission no longer
applies cleanly.

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
 	depends on PCI_MSI
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe


--=20
Jean Delvare
SUSE L3 Support
