Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF8C486DB6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 00:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbiAFXZe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 18:25:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32928 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245448AbiAFXZd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 18:25:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 446F3B82484;
        Thu,  6 Jan 2022 23:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CB4C36AE3;
        Thu,  6 Jan 2022 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641511530;
        bh=Gy6I+DtL2sSZQd08niKoqAByMu4+6qH/opOo9vEsR5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gr6Y1sTddrKmcs93s/XPEgXhMSAQt22esW/5apNHYHq8stky8CfsaOwwF4BpffhBt
         OIDKNHeMg1jQuXHMxTgB/d2FDyZOxTBGQ78IdgRINFkP2ljNRqG+GMRelAQCFGPm2C
         UuveUHboQGib2e/Lgreb//aENKe0oE8pZcf42M5tX1DrBLDKjV4iAc/9SCa5vcolBA
         IZcs26u+5Q4I27oz8ByoyZf33ucmW7J6WEezx4Usi5sEjVtbYfRKeyTQDR274YfO7b
         jzNSZ7urBKuwBqAKrECsTOR9QFKi/kOjYcdb9ep22I9m5NNSwOOkHg3+xIGwoln/xk
         cl4J2jzLjJq6A==
Date:   Thu, 6 Jan 2022 17:25:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] x86/PCI: Odd generic PIRQ router improvements
Message-ID: <20220106232528.GA334563@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2201020142430.56863@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 02, 2022 at 11:24:19PM +0000, Maciej W. Rozycki wrote:
> Hi,
> 
>  Resending as this has gone into void.  Also there is a context dependency 
> with a change developed later possibly causing a merge conflict, so to 
> make it easier to queue the incoming patches I have folded the follow-up 
> change into this series, expanding it to 4 patches from the original 3 and 
> mechanically regenerating according to upstream changes.  I have updated 
> the cover letter accordingly.

I'm assuming the x86/IRQ folks will handle this, too.
