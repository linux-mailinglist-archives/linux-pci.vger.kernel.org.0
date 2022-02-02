Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFBE4A6E73
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 11:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiBBKNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 05:13:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiBBKNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 05:13:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643796812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTbQhS0nAomVSVXvI4ZBw2g7TFGRH2Ml/TQfqhl0PBw=;
        b=kYkBXL5AW+b+hTMRVTwbebEjOirhVPiK+p81JQKYYec5TN2qW2sOcd4DFtiz9bAR4ZUzSb
        VWRDNWjS+VAv701iWeGNvvc63ljkoCp3CSA+NOkTa30sSeoEN2pgE4sYlNj01SYpNc+Jnq
        D1MfwGyAWNtEmLku6df+7CvGZNv4yieNy1JtPBFGl19REnNoXbPzsk+pGCR9Q589H8Vqfh
        Nu4vBv24bcjbkYIQOfGMkjVbx0P2Zq3vxuCSZCG88p/aC52/2C+WZmHEAVjLHlIVFRUoyW
        RP+jsaUFYCwEeNiBv9Ur09aIDM4obM82l0Qc5A7HW/wVHOdXL4jKsoKkVUQPYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643796812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTbQhS0nAomVSVXvI4ZBw2g7TFGRH2Ml/TQfqhl0PBw=;
        b=tRoQGuIEskb8IPgE6fXZTD9e29hdICxzXJBHkACcAC4z+asMRdL+onhHYaYhR5Y6Yvgk7B
        81jwvG5XTy0fMABw==
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Michal Necasek <mnecasek@yahoo.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] x86/PCI: Improve $PIR and add $IRT PIRQ routing
 support
In-Reply-To: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201021821480.56863@angie.orcam.me.uk>
Date:   Wed, 02 Feb 2022 11:13:31 +0100
Message-ID: <87sft1vano.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maciej,

On Thu, Jan 06 2022 at 11:24, Maciej W. Rozycki wrote:

>  This is a new patch series made around a discrete patch submitted earlier 
> on that has gone nowhere, which is now 1/4.  That change handles $PIR
> PIRQ

sorry for ignoring this due to stack overflow. I'll go over it later
today.

Thanks,

        tglx
