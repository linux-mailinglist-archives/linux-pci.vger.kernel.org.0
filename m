Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E22D2A02A1
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 11:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgJ3KPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 06:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgJ3KPo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 06:15:44 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC77221FA;
        Fri, 30 Oct 2020 10:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604052943;
        bh=ra8wXkGhkanUOX8ptlTzNgcj46dBDl6+hj9isNH764E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNgSqozcposDJsdUhuGQrkZH3rSI81orcdMeqCoop8qZE/bJk8mUq0PEXj1QuZsKh
         ZJeJRgILqgelQDBb1vrFWstowdekingflPH2r+ZmXH2uby04Si7kB2OsTERbuZ0KtI
         4Zzgix7hOmd4tyJcSo35cI+1FLlduRv+9w+ZN/AE=
Received: by pali.im (Postfix)
        id 90B3F86D; Fri, 30 Oct 2020 11:15:40 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:15:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>, vtolkm@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
Message-ID: <20201030101540.ypsslr7bir5lwtjc@pali>
References: <871rhhmgkq.fsf@toke.dk>
 <20201029193022.GA476048@bjorn-Precision-5520>
 <20201029225409.2accead3@windsurf.home>
 <877dr8oc7m.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dr8oc7m.fsf@toke.dk>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 30 October 2020 00:15:57 Toke Høiland-Jørgensen wrote:
> Thomas Petazzoni <thomas.petazzoni@bootlin.com> writes:
> 
> > Hello,
> >
> > On Thu, 29 Oct 2020 14:30:22 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >> We could quirk these NICs to avoid the retrain, but since aardvark and
> >> mvebu have no obvious connection and WLE200/WLE900 and MT76 have no
> >> obvious connection, I doubt there's a simple hardware defect that
> >> explains all these.  
> >
> > aardvark and mvebu have one very strong connection: they are the only
> > two drivers making use of the PCI Bridge emulation logic in
> > drivers/pci/pci-bridge-emul.c:
> >
> > drivers/pci$ git grep pci-bridge-emul
> > akefile:obj-$(CONFIG_PCI_BRIDGE_EMUL)  += pci-bridge-emul.o
> > controller/pci-aardvark.c:#include "../pci-bridge-emul.h"
> > controller/pci-mvebu.c:#include "../pci-bridge-emul.h"
> > pci-bridge-emul.c:#include "pci-bridge-emul.h"
> >
> > I haven't read the whole thread, but it is important to keep in mind
> > that on those two platforms, the PCI Bridge seen by Linux is *not* a
> > real HW bridge. It is faked by the the pci-bridge-emul code. So if this
> > code has defects/bugs in how it emulates a PCI Bridge behavior, you
> > might see weird things.
> 
> Ohh, that's interesting. Why does it need to emulate it?

I could speculate, they wanted to decrease cost of hw, so they did not
include bridge into hw and let user to emulate it (if is needed).

> And could this cause things weird interactions like what I'm seeing,
> where a somewhat buggy device in slot 2 affects the ability to retrain
> the link also in slot 1, but only if there's no device in slot 3?

I doubt, slots and registers are independent. Every slot/card has own
(emulated) bridge.
