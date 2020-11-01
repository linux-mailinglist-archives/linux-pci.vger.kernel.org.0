Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC52A1D8E
	for <lists+linux-pci@lfdr.de>; Sun,  1 Nov 2020 12:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKALRM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Nov 2020 06:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgKALRM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Nov 2020 06:17:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4801C0617A6;
        Sun,  1 Nov 2020 03:17:11 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604229428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Krt6T563zJwnx7DxUOm/kUcEp/J3bUFP7nrYHXCOXd0=;
        b=XcEKVBjxXl0SEldDFHI0QsDBfa1MasLOx1JA+FAlyFQaf5+wRgC3TWvGFaa3eyC5b0Tuwp
        JvB1evcozCgR7TezCNLGNHitoUQPYT9SDs+OBbUa2XA1nVbAGT7zaHvh7pTwOI3bHQZExF
        V4nJv2sI5YsEFnddXD2GghwK/Q0wOocZQdWHfQQzOmYhIryE6dFtZclIAJwtmTw5MakPmo
        bMNyaVkrd+vJFywJyz/Qpb9g2xVqvr4EvUXNFeG292VDy+zW3fH+3+ZdpkfOYwWPw1iUQJ
        Q8C99zhUEIgvd3u9io5q+dhkBCUTNv3sa5ZDPTogpy4ytTwE9POWVPdiRlvP3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604229428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Krt6T563zJwnx7DxUOm/kUcEp/J3bUFP7nrYHXCOXd0=;
        b=hR48/JUdYqfu6FBuA6Z6JWnzxr5tXeCygZMkUG6YXwTjqcH0225c9X9IyYpkIeArbvQYYt
        ATuF7axR/bylv1Cg==
To:     frank-w@public-files.de, linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>, Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
Date:   Sun, 01 Nov 2020 12:17:08 +0100
Message-ID: <871rhd9vij.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 01 2020 at 10:25, Frank Wunderlich wrote:
> Am 31. Oktober 2020 22:49:14 MEZ schrieb Thomas Gleixner <tglx@linutronix.de>:
>
>>So it needs to be figured out why the domain association is not there.
>
> It looks like for mt7623 there is no msi domain setup (done via
> mtk_pcie_setup_irq callback + mtk_pcie_init_irq_domain) in mtk pcie
> driver.

Hrm. No idea how that is supposed to work. I defer that to the mt
wizards then.

Thanks,

        tglx
