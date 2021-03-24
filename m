Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3DB347D82
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 17:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbhCXQSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 12:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234881AbhCXQSD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 12:18:03 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF85061878;
        Wed, 24 Mar 2021 16:18:02 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lP6Cm-003YU9-Td; Wed, 24 Mar 2021 16:18:01 +0000
Date:   Wed, 24 Mar 2021 16:17:59 +0000
Message-ID: <87y2ecikzs.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, <anson.chuang@mediatek.com>,
        Krzysztof Wilczyski <kw@linux.com>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [v9,4/7] PCI: mediatek-gen3: Add INTx support
In-Reply-To: <20210324030510.29177-5-jianjun.wang@mediatek.com>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
        <20210324030510.29177-5-jianjun.wang@mediatek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jianjun.wang@mediatek.com, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, ryder.lee@mediatek.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com, chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com, sin_jieyang@mediatek.com, drinkcat@chromium.org, Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com, kw@linux.com, pali@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Mar 2021 03:05:07 +0000,
Jianjun Wang <jianjun.wang@mediatek.com> wrote:
> 
> Add INTx support for MediaTek Gen3 PCIe controller.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
