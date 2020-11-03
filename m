Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2334E2A47FB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 15:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgKCOYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 09:24:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgKCOXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 09:23:04 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604413382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQk/S97ZspWiP1IuSwnWiJWHXBzyWFTe6e9hOnmA6WE=;
        b=QalBqNAlxHCvA00U58wEBxzceCcxe6LuAsBqou0YkPb69sAg6Dc5SsXKt0KflY23a9gqio
        HjzxxXFDEHPOtciZQw7z+k5kphA/aRZGpa5uBtMVlQwoKXVBP3fE2E4wMcWTv73gVzfg+Q
        Zg9dyWFt9POExqgBYBMYAHFscyYePzEwiWooI/iG1S94360E+p9lSWzbLJ3DvjlAf5ZT8i
        ieX0nGBK1p8OOBdsEvZZENvT755t6QTkbZKGBhG9jvVJIuVnS40MoXHNI5k+F+5+Lu+oyP
        PmvKmP4enLYz+aSV3PAhqcxvI8VG/x5iMkt4IzUR1/P9jmQiuzCpDHxaMV0lfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604413382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQk/S97ZspWiP1IuSwnWiJWHXBzyWFTe6e9hOnmA6WE=;
        b=oNuU5EJETbCC1hnFqgqleMG/b4FxXNvPyqRgnq0lRnt8yGGAJfGSdQPnE3oHZ+jbyiRbFu
        og17+KydbVPoo1Ag==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <41e2e3ea115aa8cbbb9a5c313dca0210@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org> <87h7q791j8.fsf@nanos.tec.linutronix.de> <877dr38kt8.fsf@nanos.tec.linutronix.de> <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org> <87k0v27mve.fsf@nanos.tec.linutronix.de> <41e2e3ea115aa8cbbb9a5c313dca0210@kernel.org>
Date:   Tue, 03 Nov 2020 15:23:02 +0100
Message-ID: <874km634ft.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03 2020 at 11:41, Marc Zyngier wrote:
> On 2020-11-03 10:31, Thomas Gleixner wrote:
> We can do that, although I worried that it isn't 100% reliable:
>
> pci_host_probe() ends up calling pci_add_device(), and will start
> probing devices if the endpoint drivers have already registered
> with the core code, long before the flag gets set.

Bah, you're right. What a mess.
