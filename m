Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE43C1AB2
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhGHUvz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 16:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGHUvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jul 2021 16:51:54 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73072C061574;
        Thu,  8 Jul 2021 13:49:12 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 35E9192009C; Thu,  8 Jul 2021 22:49:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 26E2A92009B;
        Thu,  8 Jul 2021 22:49:11 +0200 (CEST)
Date:   Thu, 8 Jul 2021 22:49:11 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] x86/PCI: SiS PIRQ router updates
In-Reply-To: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2107082246190.6599@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106240047560.37803@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Jun 2021, Maciej W. Rozycki wrote:

>  Posted as an RFC at this stage as it still has to be verified.

 So this has passed verification as it is, although with an extra change, 
not directly related.  Shall I repost the series unchanged with the "RFC" 
annotation removed then, or can it go in as posted?

  Maciej
