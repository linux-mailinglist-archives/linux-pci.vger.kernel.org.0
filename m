Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87DD3EA747
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 17:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhHLPPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhHLPPR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 11:15:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421BC061756
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 08:14:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628781290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlGECFIhIkCy7fbFwXbIp4HM06TT59g/ESpE0tEms9A=;
        b=Qr+phJx6S0ABTERHbYOfkurPXIk0HCCESpBnwpVm0mstiewoPoASdnw7E8VP3T4qWH0MLc
        NT11uJbPtgMy82tgrOwG0LYoHWiGSWtalCLYutZJ3SCAsBNBeokN8UWnvTGi0R4JEQZa93
        Wykss3XaLEaRhUrXBwtzl6onzvuyPRGck2gy5h1bVcFdAyvv87g3X/8i/wsQr7cx53PMUL
        YromBh5r0uchWj3DgN+dj8GzSV5kSc5UW+LDFkSpbfOrSav4987iDQi1AXoT6XFJWKO+7W
        k3q4zfHIB7jsWo9wvbh18zJaqgozdBbNM4AovhQTjK5JtOZhTuRU4k5xnRGctg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628781290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlGECFIhIkCy7fbFwXbIp4HM06TT59g/ESpE0tEms9A=;
        b=3QbEGt1GKK06z9T0NkWssXW+9eNBoNbGbJkF2tdlpn4xDvimAax3erX3z4YzHfK578rM4s
        zP5dSKMZSGhBahAQ==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84sk?= =?utf-8?Q?i?= 
        <kw@linux.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Add missing forward declaration for
 pci_numachip_init()
In-Reply-To: <20210730211920.GA1099849@bjorn-Precision-5520>
References: <20210730211920.GA1099849@bjorn-Precision-5520>
Date:   Thu, 12 Aug 2021 17:14:50 +0200
Message-ID: <87y296hez9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 30 2021 at 16:19, Bjorn Helgaas wrote:
> On Thu, Jul 29, 2021 at 11:40:59PM +0000, Krzysztof Wilczy=C5=84ski wrote:
> What should be done with the pci_numachip_init() declaration in
> arch/x86/include/asm/numachip/numachip.h?  It doesn't seem like we
> should have *two* declarations.

Right. Include that file in the C file and be done with it.

> The one in arch/x86/include/asm/numachip/numachip.h is:
>
>   extern int __init pci_numachip_init(void);
>
> I'm not enough of a C language lawyer to know whether "__init" in a
> declaration is useful.  It doesn't *seem* like it would be useful
> since this is not a definition and the compiler isn't generating code
> here.  But "git grep __init include/ arch/*/include" finds quite a few
> of them.

__init on the prototype is not having any effect except perhaps
documentary value at least with current compilers.

The attribute magic is vague in both the C specification and the
compiler manuals, but that might change some day in the future. But in
which direction is unknown :)

Thanks,

        tglx

