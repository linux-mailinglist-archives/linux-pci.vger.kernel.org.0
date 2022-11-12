Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEF6269F0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 15:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiKLOau (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 09:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiKLOas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 09:30:48 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD721C12A;
        Sat, 12 Nov 2022 06:30:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 184503C1EA7;
        Sat, 12 Nov 2022 14:30:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AEEE73C1997;
        Sat, 12 Nov 2022 14:30:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668263440; a=rsa-sha256;
        cv=none;
        b=rpyE8bGpSAdXfK7sLzn/u2LW+TiC0NZxTKL5Ic0LAQhSoHQWvDjaCMPSmLYHL7l62wpYYK
        ujNPepQxeCaVjLFy1nutWx1I6jYEF8E26qmDjTodt25HpORSo/yjNXeWe4aduhnm9vUNHz
        Mp+fIiCEEnnm58m58cZ5vXmB6oCXrfRO6T2xDf+HiOZ7OPWB8PxWGKUXiP5ztfzKXsOjvw
        h4Uh3VkIHmfEB2BCt2Mp570I1v07M9iuVpu7eNeQ+G1wx7AZwmR+Kt3KUQNBN5F4jI3+UK
        X0TkCmrjoIoOAFiy+7m9YKu4nyH+J27o7ykf/L3hS13bYuNr79aZxubE4UTZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668263440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZldjB1QXpaMaa585PwQA9L52Y7Bh6VzfKf1mPIq62YA=;
        b=1+3NLPGjx8DQi0OLIwfyBGFeyg1JIDdWwL2km7sbj8pwR1BkctQxoYUYPikqtWqeekmeS5
        QmdE4zL5isV1f4Isvr7dmDyrgXvT/FIvb7jG0Kw8yrmyH6aL0QspUSwOswJlibQ/IrITAH
        H56S+FLyE/P7k273bAtG6MaeI8PbY18o2hKkjU+7zRm8LRmcXF7vUxuvM0B2MuBCigxfPD
        PqHZMJYZWau9Y5aeS1uebVgCIBdaBPrE0zkDDTvPg0K3Dr5TzFiUGSl44U2REywm8q9htG
        8Pd98ZBdj9wL8bdoSbGEy86LGv+ZxOfM80Yasdw4lVGJ6SjBGuH3BASQ6JMsrQ==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-nvvnz;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Slimy: 71e11c3d6d4e732d_1668263440953_2366251542
X-MC-Loop-Signature: 1668263440953:951357203
X-MC-Ingress-Time: 1668263440953
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.71 (trex/6.7.1);
        Sat, 12 Nov 2022 14:30:40 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4N8dKD0NLfz5y;
        Sat, 12 Nov 2022 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668263440;
        bh=ZldjB1QXpaMaa585PwQA9L52Y7Bh6VzfKf1mPIq62YA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=tbCXFW7ibaOJkjeQHBa0rmK36vceGZEN6sP9Wx4b+sP2qW+I1EQW9r2Q95itCIBSI
         bHydwg12xMOgTVryJi4f3bCwRdvRbZKvpiobMPgaoKXNyVQt87+YoBUVPH9G7bmyOU
         RZJqye4wQ2vYpTjVEeeC/2zl2VykmuEA9JP0INpy3lVU75L7N9RslY3Ke+SknwG5SM
         0Wk7BpIarrovz2MZSWVMHDHt9FjOODdWROM68j6fJV3FjRAEe9hBptyAbpFYDCcv3B
         m2OxRhlaLaLG64Qv/ohOBjpRPwbk6qWYd6jt8v8oZN38COF/U2SGUinzbnQi4NLDr6
         H2JMzN6NegD9w==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH 3/3] PCI: SHPC: update todo
Date:   Sat, 12 Nov 2022 09:28:59 -0500
Message-Id: <20221112142859.319733-4-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112142859.319733-1-ian@linux.cowan.aero>
References: <20221112142859.319733-1-ian@linux.cowan.aero>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This removes the note in the todo regarding the removal of the
->get_mode1_ECC_cap callback.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/pci/hotplug/TODO | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 88f217c82b4f..fdb8dd6ea24d 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -58,9 +58,6 @@ shpchp:
   pciehp with commit 82a9e79ef132 ("PCI: pciehp: remove hpc_ops").  Clarify
   if there was a specific reason not to apply the same change to shpchp.
 
-* The ->get_mode1_ECC_cap callback in shpchp_hpc_ops is never invoked.
-  Why was it introduced?  Can it be removed?
-
 * The hardirq handler shpc_isr() queues events on a workqueue.  It can be
   simplified by converting it to threaded IRQ handling.  Use pciehp as a
   template.
-- 
2.38.1

