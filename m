Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41D4E5F3A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 08:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348413AbiCXHVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiCXHVf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 03:21:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9928148395;
        Thu, 24 Mar 2022 00:20:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w25so4525766edi.11;
        Thu, 24 Mar 2022 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z7RLcBdTbxi1WJP/NXFvAkUEgz8GJWltXH26XBP4pcs=;
        b=EUJi+hW0qIpfw16k6ctPdUfv4TMiBL4PEvkuL7XBLZTCFbVaN0bsle28cE1XGTN00D
         AGQuT9u6Nl7JmOH8n7XahqSke0fjmsUEU1OuKNQJoVyJuIEwK6gC4TVqr/A+uSu7I/qh
         xLQ7E3z/SfuqWHywXtDGNsYMw8gdhVhsZouHJHpr7BGSUkqK3BPvgWitrW1kDcEdgrar
         x8PEnVuqbU+yK7wrTApECVLHi2CPGleN4jGpE/jUVzUanWNPN8RBW3PRVrD1LJmpdC+5
         v1F/5wu/RR2f2+DC3ybHd6WwV+oEa677OOCNAqaK5Nwfc5UtdUJrz0uHHu8amA1/sme9
         um/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z7RLcBdTbxi1WJP/NXFvAkUEgz8GJWltXH26XBP4pcs=;
        b=cQfRjO/snTveMv1FtZWjbgdO9gkGW1z4jmT8hs8DGIdR+Mry99e/FavhyJTefE/244
         dPt5u9R2psHHQ0XHSaCYHxQqKmDV7CcvWap0qAopNBD59TWQXYlMPvytNLaH/Y3XXtkC
         m9+dlgx5oMvH1kBnxqsH3c/isRI0kogUnHFIm3A1VrHPXbtEwINAZiAaK4jEakOE+o4z
         avNI8b7Nik4R1JviXfnvcNsRBY76cf9x9BvGNIxClqo66ep+Pdl5lps3akWK53EpgP5J
         fF0fd/mP8vLhwJm4xoAShbtow4lonvV6J/KzUBPZfZb+ET2UoJdW12S5sG/ofoebxjVX
         iAzw==
X-Gm-Message-State: AOAM531gMNiOMIW3T32aq4dS9CEsCHDayjbmFRjdoAm+NI7YnkMmw6g7
        /PaebICgs5QLs4hACXkEVuc=
X-Google-Smtp-Source: ABdhPJwVbOvL94lJaiSAi7r4eCIhA+TG4CK3uYT174+6+5cxOh0mz3JK7y0uXJ/kKuAGPBaVgb4HAg==
X-Received: by 2002:a05:6402:1111:b0:416:2ac8:b98e with SMTP id u17-20020a056402111100b004162ac8b98emr5026577edv.236.1648106402097;
        Thu, 24 Mar 2022 00:20:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id z1-20020a05640235c100b004192c7266f5sm989540edc.16.2022.03.24.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:20:01 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Naveen Naidu <naveennaidu479@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] PCI/PME: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:18:52 +0100
Message-Id: <20220324071852.61587-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/pci/pcie/pme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index ef8ce436ead9..dc8cbf8987ba 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -130,7 +130,7 @@ static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
 {
 	u8 busnr = req_id >> 8, devfn = req_id & 0xff;
 	struct pci_bus *bus;
-	struct pci_dev *dev;
+	struct pci_dev *dev = NULL, *iter;
 	bool found = false;
 
 	/* First, check if the PME is from the root port itself. */
@@ -169,17 +169,17 @@ static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
 
 	/* Finally, try to find the PME source on the bus. */
 	down_read(&pci_bus_sem);
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_get(dev);
-		if (dev->devfn == devfn) {
-			found = true;
+	list_for_each_entry(iter, &bus->devices, bus_list) {
+		pci_dev_get(iter);
+		if (iter->devfn == devfn) {
+			dev = iter;
 			break;
 		}
-		pci_dev_put(dev);
+		pci_dev_put(iter);
 	}
 	up_read(&pci_bus_sem);
 
-	if (found) {
+	if (dev) {
 		/* The device is there, but we have to check its PME status. */
 		found = pci_check_pme_status(dev);
 		if (found) {

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

