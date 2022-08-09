Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D846F58D1B9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 03:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiHIB1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 21:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiHIB1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 21:27:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D712AFF;
        Mon,  8 Aug 2022 18:27:08 -0700 (PDT)
X-UUID: 27e598429d0541afa06531cf86b97cd3-20220809
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mfplZHXj79DnlaJB5yFqH6RkA8orBckNoJNlMVuwnjQ=;
        b=YXxD/RLyOqFTRphVVPPVt+FW+z0PvWhikqAnQLnTfypUmHm4P/V1UZbF+tzeNmxBhrQZq4zz2putGmxsYShnYkIrIVc7ZnlPnTWTdnpf3IYHeqfgE2B4Vd+LXFesifr7IFYb/Eir6OgU8lLJ4O7qAA8ABVdnI+QX5wSOQmXBwf4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:a5849bc3-2871-4064-9959-d6390f1d71ff,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:126c43ae-9535-44a6-aa9b-7f62b79b6ff6,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 27e598429d0541afa06531cf86b97cd3-20220809
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1292698929; Tue, 09 Aug 2022 09:27:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 9 Aug 2022 09:27:00 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Aug 2022 09:26:59 +0800
Message-ID: <13b0813576f57add0d2eacb519eedec73fcf1920.camel@mediatek.com>
Subject: Re: [PATCH] PCI: mvebu: Dispose INTx irqs prior to removing INTx
 domain
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 9 Aug 2022 09:26:59 +0800
In-Reply-To: <20220710001421.lqwprzgn5jrblqcu@pali>
References: <20220709161858.15031-1-pali@kernel.org>
         <20220710001421.lqwprzgn5jrblqcu@pali>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On Sun, 2022-07-10 at 02:14 +0200, Pali Rohár wrote:
> On Saturday 09 July 2022 18:18:58 Pali Rohár wrote:
> > Documentation for irq_domain_remove() says that all mapping within
> > the
> > domain must be disposed prior to domain remove.
> > 
> > Currently INTx irqs are not disposed in pci-mvebu.c device unbind
> > callback
> > which cause that kernel crashes after unloading driver and trying
> > to read
> > /sys/kernel/debug/irq/irqs/<num> or /proc/interrupts.
> > 
> > Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx
> > interrupts")
> > Reported-by: Hajo Noerenberg <hajo-linux-bugzilla@noerenberg.de>
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> Just to note, Hajo Noerenberg observed this issue during testing and
> debugging other unrelated issue in bugzilla [1] and triggered this
> crash
> just by calling: rmmod pci_mvebu && modprobe pci-mvebu && cat
> /proc/interrupts
> 
> I suppose that other pci controller drivers with unbind / rmmod
> support
> would suffer from same issues.

FYI, we found the same issue after unloading the PCIe controller
driver, if this is the proper way to dispose the INTx irqs, I'll send a
similar patch for MediaTek's PCIe controller driver.

Thanks.

