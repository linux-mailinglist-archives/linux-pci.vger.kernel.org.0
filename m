Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3C6269ED
	for <lists+linux-pci@lfdr.de>; Sat, 12 Nov 2022 15:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKLOan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Nov 2022 09:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiKLOam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Nov 2022 09:30:42 -0500
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F81A82E;
        Sat, 12 Nov 2022 06:30:35 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4F84642068;
        Sat, 12 Nov 2022 14:30:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D29E042075;
        Sat, 12 Nov 2022 14:30:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1668263431; a=rsa-sha256;
        cv=none;
        b=HCL1BAe1H/pzDrmFmWsj09mX0qwNjoLNeHGTxPhDTtih2wB7n+nwok5WdmrKxHnKWk00Kl
        S4AiNOsxpBvwFRqFZzCwhFo1hqdMKrnEuxOeXsYqke4cGTp0ummjXdYKDp90WDFrd0C0H7
        fmRRxCpNSL62T9wRbFXFLbzC6i8HNHTFF7f4bv5ljBW0YAcrHPIoS6efGNGjhIFvMqmo6t
        +5AgFZMwicsx6Vpy8lR6PTx9EpSPuH6JZt1ZxtEa7lTNYqcugXBBFK638mTLssv0pPB+fc
        H73dzHX6EXWks1F9RrlOEPewTYzSV4PG33Y0s61bWtDdJ+CK6KLcFFwNkCxgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1668263431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=mW17fZSHLBiDKN0vvyrLRRUmL3lhsMJhAt2HzFGSejY=;
        b=Prz8dkb7lN8KKeeE6CkmLLZDYgSRUqtug1CtWEO7AtkvB5OVt8tWUtA9nILOt+6Eso/Xg2
        BfPJjux0853ORrQ1RflIUhoCTotvAaCHlbLPSlnDnnBPeG0jui3LR7dy7lhoQiBk93sEGq
        NI3ZmG5Yew1DH5orGqyvq27Bg62i6oLucpS2UHW88eqtIeTEAxAZZd/3hjhvj4DG/T5cpp
        nk8Nl7aL/lpW7UhWTbRguTeyRs9TQgjzV1MFkHBbu7+OS0tZilab9CkEQT0v59lmuVFhLG
        h3xSce3MUN54jugC03AXq6BvqCzLOSCItbKepd6v0gdXq8zgthvAUn7EzZiAng==
ARC-Authentication-Results: i=1;
        rspamd-7f9bbcf788-s7lzd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Abiding: 2c043aca72c057ef_1668263432105_2405489284
X-MC-Loop-Signature: 1668263432105:464200031
X-MC-Ingress-Time: 1668263432105
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.213 (trex/6.7.1);
        Sat, 12 Nov 2022 14:30:32 +0000
Received: from rhino.lan (dsl-50-5-144-34.fuse.net [50.5.144.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4N8dK31RSvz1M;
        Sat, 12 Nov 2022 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1668263431;
        bh=mW17fZSHLBiDKN0vvyrLRRUmL3lhsMJhAt2HzFGSejY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=re4lm+fkEqqzkw6hVZVtSC/qj9RJ6i2Yq1kMYFf9kxcc5qTuqRYK4+PWDQwrgvmBE
         ZBGyX5eF/PIWZ4DyJAWXPDZvTDW2fn2anaIKs3NnAaiGx4mVdpsLVVqUzDJvojXADC
         mJ6yO2EhGY9RH90eY7qDOG+2zFqPow7T5JZJM8ceuVxa9PRyff4gq7vHzZyInRvQvv
         xdNjkuQunAMxqXajb2pEUlWrNgvt+uKi92pfZxLMQoc7DRBEOfwVS0paOhBkNzthOg
         xxerRL0JRJAs6PceyhAq5AQ/Naj7dTGWbT9Q+auMA0zud32cGK1yePfAabagwNbGdN
         KfIRRyXPdU2pA==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH 0/3] PCI: SHPC: removed unused get_mode1_ECC_cap callback
Date:   Sat, 12 Nov 2022 09:28:56 -0500
Message-Id: <20221112142859.319733-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.38.1
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

In the SHPC module, the get_mode1_ECC_cap callback is never used from
the hpc_ops struct, so this patch series removes that callback from both the
definition of the struct and the definition of the shpchp_hps_ops
struct. Additionally, this removes the reference in the TODO of the SHPC
module.

Ian Cowan (3):
  PCI: SHPC: remove unused get_mode1_ECC_cap callback declaration
  PCI: SHPC: remove unused get_mode1_ECC_cap callback from definition
  PCI: SHPC: update todo

 drivers/pci/hotplug/TODO         |  3 ---
 drivers/pci/hotplug/shpchp.h     |  1 -
 drivers/pci/hotplug/shpchp_hpc.c | 18 ------------------
 3 files changed, 22 deletions(-)

-- 
2.38.1

