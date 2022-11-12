Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DB6269EA
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 15:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiKLOak (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 09:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLOaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 09:30:39 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C361A83E;
        Sat, 12 Nov 2022 06:30:37 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6D4B1821BE8;
        Sat, 12 Nov 2022 14:30:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EDE02821BC8;
        Sat, 12 Nov 2022 14:30:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668263436; a=rsa-sha256;
        cv=none;
        b=LowArWQR1ubo44tvwjck1xopghn3KIdT/ec/1qbIkFTFfuVy9Wqe9xY5kv9T/FubsVKP19
        CTLRtLLe8MTdLH+PqiShrgoNSdNtFTQyC/tNYZ2k23um5amFfhdyt/njFvVzI73DMWeF5g
        bNCyN+38LKqecyF9u81AV+8HFDV9Hd+RBF/4ZzZR/VBAXR/fCHejj3xAabBILXCL1nG/nq
        MN6IOWASpxG2ujgG5UPxYiD/V/6pZP0hRPD/Bu61/jstFX6mbR7ZYzXC9z9nGroMf9JZMD
        RWtPVXml3ANwwvt6cDYf/TcBqG59L+P66cwaFI4RiwJZfYPWTLP2SbWF585ETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668263436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=iFOu58EziI41+nlF3fAgrd3T4bqfAOOprYCBnpz0jLw=;
        b=kRhcyMeGuTngjCA9taCj4RfHet0Plv65yglkHtmN9bNeF0t6BnYVxLWbD+GLO0iuFReJUa
        0gWmEIL6HIk55Mv3BL7sd2PBhcSlMYQuVoXyS0wplOlwvy69lXTGQfZOu73O2qwmmwrZ45
        uW8mjiWhWwAtR7RdJfxw6bYQ0WutgmoaKrJxBJfmSeybVFWlg0WGQxCoEXu4FY+E/XeBIv
        thdVyLQRCrpUxt8SNFbGUkaiScWfGrNmJiw/X3Lz088YuN7HKaIqlomZeC38+QfrI+jvfV
        hAOcrcIeHh5S0kvb2UT5p5IY6fNK0upV0jhJe58sVyZIpp9GdoYuYyCjrAWeWA==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-8nkdq;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Minister: 2842be025922d1d6_1668263436215_1143567332
X-MC-Loop-Signature: 1668263436215:652404706
X-MC-Ingress-Time: 1668263436215
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.91 (trex/6.7.1);
        Sat, 12 Nov 2022 14:30:36 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4N8dK72fNmz24;
        Sat, 12 Nov 2022 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668263435;
        bh=iFOu58EziI41+nlF3fAgrd3T4bqfAOOprYCBnpz0jLw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=nls1JS0aLZb+tSYINzICUgT6sbb4yRC96UOnJwHbgUJ9ayXFU0tx6BgwtGEZoUFHN
         XIF3/U3Ecl3i73/9Uz8T1Hel/+w+JikGVQoKUkCfcTUYoWB0pex5W4Yv10eXUN63bA
         EUCQiN5XesqQJB0VwtsRolOxZ4EldBnjXR94+XwM0OadaGeputFrPXxSppc7Z1+oQt
         7oq/drfy5PI2JoxOD8cq9LeJyl01J62AMSeA1vbDqrfooSl3I2IvdB2tLj819Vgi9n
         n4fgeO1mePLoChbL/5k3ZbmczN/Tr3VaSN27olcDwksXESGDjgJVmR25nhZytA68bY
         JD6lZESOdpbCw==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH 1/3] PCI: SHPC: remove unused get_mode1_ECC_cap callback declaration
Date:   Sat, 12 Nov 2022 09:28:57 -0500
Message-Id: <20221112142859.319733-2-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112142859.319733-1-ian@linux.cowan.aero>
References: <20221112142859.319733-1-ian@linux.cowan.aero>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ->get_mode1_ECC_cap callback in the shpchp_hpc_ops struct is never
called so we'll remove it. This removes that callback from the
declaration of the struct in the shpc module.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/pci/hotplug/shpchp_hpc.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index bd7557ca4910..48e4daefc44a 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -489,23 +489,6 @@ static int hpc_get_adapter_speed(struct slot *slot, enum pci_bus_speed *value)
 	return retval;
 }
 
-static int hpc_get_mode1_ECC_cap(struct slot *slot, u8 *mode)
-{
-	int retval = 0;
-	struct controller *ctrl = slot->ctrl;
-	u16 sec_bus_status = shpc_readw(ctrl, SEC_BUS_CONFIG);
-	u8 pi = shpc_readb(ctrl, PROG_INTERFACE);
-
-	if (pi == 2) {
-		*mode = (sec_bus_status & 0x0100) >> 8;
-	} else {
-		retval = -1;
-	}
-
-	ctrl_dbg(ctrl, "Mode 1 ECC cap = %d\n", *mode);
-	return retval;
-}
-
 static int hpc_query_power_fault(struct slot *slot)
 {
 	struct controller *ctrl = slot->ctrl;
@@ -900,7 +883,6 @@ static const struct hpc_ops shpchp_hpc_ops = {
 	.get_adapter_status		= hpc_get_adapter_status,
 
 	.get_adapter_speed		= hpc_get_adapter_speed,
-	.get_mode1_ECC_cap		= hpc_get_mode1_ECC_cap,
 	.get_prog_int			= hpc_get_prog_int,
 
 	.query_power_fault		= hpc_query_power_fault,
-- 
2.38.1

