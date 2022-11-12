Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442FD6269EB
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiKLOal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 09:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKLOal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 09:30:41 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E7C1A83E;
        Sat, 12 Nov 2022 06:30:39 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 572A0201769;
        Sat, 12 Nov 2022 14:30:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E0002201C06;
        Sat, 12 Nov 2022 14:30:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668263438; a=rsa-sha256;
        cv=none;
        b=bDbj0ovzR8m5yweB7/gcXHpa0RvoAGpP6ldzpSDs8GV7o5qpaSn4kjfA2MSyxRe40I7vTl
        exjmy9XzZaKCmpT4pRpoCl0/ZSfPYPlD3Py0UvoN7tOtaFUBx4u+FdukhrxL5RbhWeIWzF
        Ezemq/ZjlZuQTcbOanppdXQJ6N6lFgZA23Cd43IZvmF+3HSWuu2DJuRaEyO6znlcR1Q2RL
        Dj21NwCskpUeEH8AuW+1y7bHCUmePXJTuKgDZeA1iDCFy7trWkS65Q/TX7g4p6u7+nIBO8
        92nCDincfGNoYmWkr+SY3YhiOlU8VcxqikHlKL0BHaK+TaC4l5eiOo6Cpf7Crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668263438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=D3Xr03eLr426oQvYQ3eI2Of6RqoxNDQolv691ZaKJpU=;
        b=t3ULH7I6G/oysyfSjt/+OFay5mna2BkHFxnIuh5bz/tzHQkeHlroe8vULh5v40ZHOxKNn3
        dIF0ziWo8zTdL9/LCyrntBTs7FzB9EDAyq+qB+ORO/JzlNJSj6sPIkm+Y07kUYJ/7o1MF0
        42p6xvVgTne73Rzom9k5H0D+QmRq6v0xwiPpXE6XxJIXPIT6j1XySt3yMisW4MjomqEuUV
        WzgWgfueUfy2/Lq3sbG1MBm1YKLU4KZ3VMUGL/csq/Vn+64OoyyIMJf1wDyS86JmienroQ
        rVfZZ9G7PCrgOjz0mVpoW9i0FM+wiNOKpqlAQ//bfypH0imU2N+EvFB2LTUpfw==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-6fwcn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Name-Cold: 2adb1a1e20f0e52c_1668263439166_2745515620
X-MC-Loop-Signature: 1668263439166:4284031045
X-MC-Ingress-Time: 1668263439166
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.20 (trex/6.7.1);
        Sat, 12 Nov 2022 14:30:39 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4N8dKB255yz1M;
        Sat, 12 Nov 2022 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668263438;
        bh=D3Xr03eLr426oQvYQ3eI2Of6RqoxNDQolv691ZaKJpU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=T++3iiweLkJGr7u3ODBpW2LLaNmWW2YQ2ShrPdmFT/MQE3SwkU1kDqSkLRdsl82sW
         c404EJjNyr1aUJ+ONJrap9e02AfXMU7aBwVVXrEENtyH372YsaygRfstiddBgdmRc5
         GfUFPH4zPrBr3mxPXQ2mZY3Dy7DHfu+4Dj/oboq3Vi4DtS1RMrDr2/MRoj5R0XCobA
         qwcCiq6k4DmO9Z/BbwiQ9KPPohAAfrYWJFkM3OOfZs2z2BRsG0wMnavBEh4asixxyc
         Lz8yROk9Zamw5T2fyGwe2SJ07TZ5wpQre6iH6a2kqxhPJ8BZI6+rhX3+StjTs9uv4a
         nEAUA785fNigQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH 2/3] PCI: SHPC: remove unused get_mode1_ECC_cap callback from definition
Date:   Sat, 12 Nov 2022 09:28:58 -0500
Message-Id: <20221112142859.319733-3-ian@linux.cowan.aero>
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

The ->get_mode1_ECC_cap callback is never used in the shpchp_hpc_ops
struct, so we can remove that. This removes that from the hpc_ops struct
definition in the shpc module.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/pci/hotplug/shpchp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 6e85885b554c..3a97f455336e 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -311,7 +311,6 @@ struct hpc_ops {
 	int (*get_latch_status)(struct slot *slot, u8 *status);
 	int (*get_adapter_status)(struct slot *slot, u8 *status);
 	int (*get_adapter_speed)(struct slot *slot, enum pci_bus_speed *speed);
-	int (*get_mode1_ECC_cap)(struct slot *slot, u8 *mode);
 	int (*get_prog_int)(struct slot *slot, u8 *prog_int);
 	int (*query_power_fault)(struct slot *slot);
 	void (*green_led_on)(struct slot *slot);
-- 
2.38.1

