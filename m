Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEE929F75F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgJ2WGt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 29 Oct 2020 18:06:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51972 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2WGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:06:49 -0400
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 513683A4F44
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 21:55:39 +0000 (UTC)
X-Originating-IP: 83.193.246.53
Received: from windsurf.home (lfbn-bay-1-165-53.w83-193.abo.wanadoo.fr [83.193.246.53])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BC7DE1BF203;
        Thu, 29 Oct 2020 21:55:13 +0000 (UTC)
Date:   Thu, 29 Oct 2020 22:55:11 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@redhat.com>, Rob Herring <robh@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, vtolkm@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201029225511.1aba193b@windsurf.home>
In-Reply-To: <20201029195731.GS878328@lunn.ch>
References: <871rhhmgkq.fsf@toke.dk>
        <20201029193022.GA476048@bjorn-Precision-5520>
        <20201029195731.GS878328@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 29 Oct 2020 20:57:31 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > We could quirk these NICs to avoid the retrain, but since aardvark and
> > mvebu have no obvious connection  
> 
> Both are Mavell. There could be some shared IP.

From my experience, even though both are from Marvell, they are really
different IP blocks, made by different teams, used in different SoCs.

However, as I replied to Bjorn, both use the PCI Bridge emulation logic.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
