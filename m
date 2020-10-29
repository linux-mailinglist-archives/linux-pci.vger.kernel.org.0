Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BD29F75E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJ2WGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:06:48 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51922 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:06:48 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6A62F3A1C1D
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 21:54:33 +0000 (UTC)
X-Originating-IP: 83.193.246.53
Received: from windsurf.home (lfbn-bay-1-165-53.w83-193.abo.wanadoo.fr [83.193.246.53])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C5E2A240009;
        Thu, 29 Oct 2020 21:54:10 +0000 (UTC)
Date:   Thu, 29 Oct 2020 22:54:09 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201029225409.2accead3@windsurf.home>
In-Reply-To: <20201029193022.GA476048@bjorn-Precision-5520>
References: <871rhhmgkq.fsf@toke.dk>
        <20201029193022.GA476048@bjorn-Precision-5520>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, 29 Oct 2020 14:30:22 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> We could quirk these NICs to avoid the retrain, but since aardvark and
> mvebu have no obvious connection and WLE200/WLE900 and MT76 have no
> obvious connection, I doubt there's a simple hardware defect that
> explains all these.  

aardvark and mvebu have one very strong connection: they are the only
two drivers making use of the PCI Bridge emulation logic in
drivers/pci/pci-bridge-emul.c:

drivers/pci$ git grep pci-bridge-emul
akefile:obj-$(CONFIG_PCI_BRIDGE_EMUL)  += pci-bridge-emul.o
controller/pci-aardvark.c:#include "../pci-bridge-emul.h"
controller/pci-mvebu.c:#include "../pci-bridge-emul.h"
pci-bridge-emul.c:#include "pci-bridge-emul.h"

I haven't read the whole thread, but it is important to keep in mind
that on those two platforms, the PCI Bridge seen by Linux is *not* a
real HW bridge. It is faked by the the pci-bridge-emul code. So if this
code has defects/bugs in how it emulates a PCI Bridge behavior, you
might see weird things.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
