Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B304624BB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 23:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhK2W0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 17:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhK2WZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 17:25:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FC7C08ED70;
        Mon, 29 Nov 2021 09:28:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638206899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqOKj3IZWMqS0ugg10eOFI5oEB30iI5TJapcXH2ni4A=;
        b=IOCjwDnV+IhR2HGDg4wVW6lOUizRnX5reRLkcfy7IRV/nMGiAjTI2+oGxxK38tfywRFsWe
        EqGxuI8LaAsxJ91CSBaG/Ny4PUPGFBzKec91201k62zrl5ylKwAJ7VvLVyjvYcmX97yJgJ
        jlhghtbx5kqCMWQEAQ6Tj79vF6/jFLq9K638DL4nnmZC2uTuC7qHv+hQouGs+XwIrl6AVQ
        RUinNzARNB8tKdwysaZqzVoSHC6uvNgYZe9de/S/0+EwNCAoJtBFbB2VaL+3HemYbbawj9
        uMUhH7WxAWbpeHyhP/oMxZ6AFxKlmnDpauO3W1U1WL5S8emIaNO/cYOI7lRQAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638206899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqOKj3IZWMqS0ugg10eOFI5oEB30iI5TJapcXH2ni4A=;
        b=Ka5WIX7ljoOUvjodiScPWGQPf8TJxN+HN3R45g4Re/IWJ59DCK96971cDB4QWE5pYu9633
        JWWorprRZAvg0xAA==
To:     Marc Zyngier <maz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [patch 03/10] genirq/msi: Make MSI descriptor alloc/free ready
 for range allocations
In-Reply-To: <87a6hof5sr.ffs@tglx>
References: <20211126233124.618283684@linutronix.de>
 <20211127000918.664542907@linutronix.de> <8735ngs26o.wl-maz@kernel.org>
 <87a6hof5sr.ffs@tglx>
Date:   Mon, 29 Nov 2021 18:28:18 +0100
Message-ID: <877dcqeurx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 28 2021 at 20:17, Thomas Gleixner wrote:
> On Sun, Nov 28 2021 at 15:57, Marc Zyngier wrote:
> Hrm. The stupid search should terminated nevertheless. Let me stare at
> it again.

Found it. Just my inability to read xarray documentation.

Thanks,

        tglx
