Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A733EA718
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbhHLPG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhHLPG0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 11:06:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217FDC061756
        for <linux-pci@vger.kernel.org>; Thu, 12 Aug 2021 08:06:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628780759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFVE0XE8oSv3YcNUuDDegp7HumjJquN6I/uHX49z7Rk=;
        b=FZCnhyersPvM9wPNeqvTFiWy0Toa83C8QidnQy4wB3sxmmqypmHwwappFIlbhN2lYno1Ik
        0Ttt79RBE3Brkdf3lmMXuW4dhqjIlGltQ3JP3W0vpDJEhdAK56iBJrJ/Bk71oAloJCq6nI
        XDoGRDqfDXwSMcF5nkh5dngaEenKHS0/YQENEb96RL6qeeea6IjgDpNkeKRmywQXeoT0hL
        JHy9G920M+FIvZnFvJwf8ncLz5XAjaLD5AFdR43EV1C3XS4PtuAz+HMfiGz0jX9W8rNmEH
        UpxSbxCeG9kg0PjNryfQpFe/iamc8/3gL1o41Gkg03CrmAzFkCiqyI6dP/X/RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628780759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFVE0XE8oSv3YcNUuDDegp7HumjJquN6I/uHX49z7Rk=;
        b=KzoaaUxAzhIAbxHaUc+dyCz1/YyUL4Ssj2otG4socW1nHCgwI0GdtnFonnvNsW6r8Q+cSd
        r/AVEF2cI+iqWkDg==
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Add missing forward declaration for
 pci_numachip_init()
In-Reply-To: <20210729234059.1509820-1-kw@linux.com>
References: <20210729234059.1509820-1-kw@linux.com>
Date:   Thu, 12 Aug 2021 17:05:59 +0200
Message-ID: <871r6yityg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29 2021 at 23:40, Krzysztof Wilczy=C5=84ski wrote:
> At the moment, the function pci_numachip_init() is defined in the
> numachip.c file.  Since this function has users outside of this file,
> add missing foward declaration to the pci_x86.h file.
>
> This resolves the following sparse and compile time warning:
>
>   arch/x86/pci/numachip.c:108:12: warning: no previous prototype for func=
tion 'pci_numachip_init' [-Wmissing-prototypes]
>   arch/x86/pci/numachip.c:108:12: warning: symbol 'pci_numachip_init'
>   was not declared. Should it be static?

No. arch/x86/pci/numachip.c simply lacks

 #include <asm/numachip/numachip.h>

Thanks,

        tglx
