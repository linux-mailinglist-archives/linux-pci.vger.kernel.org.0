Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9E6326B7
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKUOsX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiKUOo4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:44:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830EBD06CA;
        Mon, 21 Nov 2022 06:39:57 -0800 (PST)
Message-ID: <20221121140048.470680255@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Hb3esJ7fn5+7hYW7Y+IG4ff4JCmYbRpqleme76TiWY0=;
        b=WQdEFCP8WDLyVaqrmSMhWCpNYPxAJ7d95BE1qWFNeILuZ7WI5vbr6YOMqnI1+W9Wgg9IzA
        csn49rU5fXRJiQnpkTwYWBxod8cNsEATAzQ6M5+NLx34W2s2CqM0AAs4+L9W9qWddJ2FzD
        QGE/fz12qkjlOsbNEqibWlfJrqLZzHdUkRycUvhHb66DC35HNk8dhRJ3IkB5/VR2YMPqVV
        E4tQSxLRpa5pZxDHtpcS4XGXTFqswUG5w5PLtcyk3T6Jl6wZNJDawmN7d8Bi27AE4opyYq
        okzzlx/fTp+rSfg6iTojRN6V2gbvdy4ZrcVjRlPTKBckVUrGj4T+aP+x/exREw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Hb3esJ7fn5+7hYW7Y+IG4ff4JCmYbRpqleme76TiWY0=;
        b=BsWiPnHdBDyoonJO/vBkHO8nkDPzR94XOGsCAk9ljtJIPfuyV2rWN6QyBOSC6fNKb3EQpb
        Vfw0g4scDyNCRoCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 03/40] irqchip/gic-v2m: Include arm-gic-common.h
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon, 21 Nov 2022 15:39:32 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Vz0xIGJ1aWxkIGNvbXBsYWluczoKCmRyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYybS5jOjU3MDox
Mjogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhnaWN2Mm1faW5pdOKAmSBb
LVdtaXNzaW5nLXByb3RvdHlwZXNdCiAgNTcwIHwgaW50IF9faW5pdCBnaWN2Mm1faW5pdChzdHJ1
Y3QgZndub2RlX2hhbmRsZSAqcGFyZW50X2hhbmRsZSwKClNpZ25lZC1vZmYtYnk6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgpDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+CkNjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPgotLS0KIGRyaXZl
cnMvaXJxY2hpcC9pcnEtZ2ljLXYybS5jIHwgICAgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykKCi0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYybS5jCisrKyBiL2RyaXZl
cnMvaXJxY2hpcC9pcnEtZ2ljLXYybS5jCkBAIC0yNCw2ICsyNCw3IEBACiAjaW5jbHVkZSA8bGlu
dXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+CiAjaW5jbHVkZSA8bGludXgv
aXJxY2hpcC9hcm0tZ2ljLmg+CisjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9hcm0tZ2ljLWNvbW1v
bi5oPgogCiAvKgogKiBNU0lfVFlQRVI6Cgo=
