Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9029FF93
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 09:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJ3IXY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 30 Oct 2020 04:23:24 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43873 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3IXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 04:23:24 -0400
X-Greylist: delayed 37750 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2020 04:23:23 EDT
X-Originating-IP: 83.193.246.53
Received: from windsurf.home (lfbn-bay-1-165-53.w83-193.abo.wanadoo.fr [83.193.246.53])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AE53724000C;
        Fri, 30 Oct 2020 08:23:19 +0000 (UTC)
Date:   Fri, 30 Oct 2020 09:23:18 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201030092318.7c81a032@windsurf.home>
In-Reply-To: <877dr8oc7m.fsf@toke.dk>
References: <871rhhmgkq.fsf@toke.dk>
        <20201029193022.GA476048@bjorn-Precision-5520>
        <20201029225409.2accead3@windsurf.home>
        <877dr8oc7m.fsf@toke.dk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 30 Oct 2020 00:15:57 +0100
Toke Høiland-Jørgensen <toke@redhat.com> wrote:

> > I haven't read the whole thread, but it is important to keep in mind
> > that on those two platforms, the PCI Bridge seen by Linux is *not* a
> > real HW bridge. It is faked by the the pci-bridge-emul code. So if this
> > code has defects/bugs in how it emulates a PCI Bridge behavior, you
> > might see weird things.  
> 
> Ohh, that's interesting. Why does it need to emulate it?

Because the HW doesn't expose a standard PCI Bridge. On mvebu, the main
initial motivation was to be able to configure MBus windows dynamically
depending on PCI endpoints that are connected.

For AArdvark, the rationale is documented in commit
8a3ebd8de328301aacbe328650a59253be2ac82c:

commit 8a3ebd8de328301aacbe328650a59253be2ac82c
Author: Zachary Zhang <zhangzg@marvell.com>
Date:   Thu Oct 18 17:37:19 2018 +0200

    PCI: aardvark: Implement emulated root PCI bridge config space
    
    The PCI controller in the Marvell Armada 3720 does not implement a
    software-accessible root port PCI bridge configuration space. This
    causes a number of problems when using PCIe switches or when the Max
    Payload size needs to be aligned between the root complex and the
    endpoint.
    
    Implementing an emulated root PCI bridge, like is already done in the
    pci-mvebu driver for older Marvell platforms allows to solve those
    issues, and also to support features such as ASR, PME, VC, HP.
    
    Signed-off-by: Zachary Zhang <zhangzg@marvell.com>
    [Thomas: convert to the common emulated PCI bridge logic.]
    Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
