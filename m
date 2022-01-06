Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8C486DB9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 00:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiAFXZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 18:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245448AbiAFXZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 18:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B45C061245;
        Thu,  6 Jan 2022 15:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 044AA61E7A;
        Thu,  6 Jan 2022 23:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32537C36AE3;
        Thu,  6 Jan 2022 23:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641511554;
        bh=IinBs6mH5AFLg8qOo9B/Wj65NsJ7/TDaB01X0T90BC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oG/OMQdHlCmhmJaumz2v7p8ahgNXDRw7jN6/7/H9Dc5qKPVI0r/4xsC23ujqnNIqL
         ZLgbKkJ4YcRU24/4mG7hM2A81ytlB/6O2koxfm7z9qMuvVnEADC0Szz10JdNtC1eN3
         4WRi2S+ERyJFwyRsJrOD4zkCgVy43cysElNGviQOPwY6cWGYPAI9rWkgBOEjXHnqY6
         ADEjsrNeeWhurnZebuKpmuvMAIdM9dEG1hffTTqlZPeA8MIC1riUC9GRZvUUQLw5zs
         DiPtbiypYXfmFKJB85/Xd3ZRx31iHknvQw6XU8tstqrJDreendcGZeI88eMIciyW3j
         O5FzqVJ9ibnSw==
Date:   Thu, 6 Jan 2022 17:25:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/PCI: SiS PIRQ router updates
Message-ID: <20220106232552.GA334613@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 02, 2022 at 11:24:59PM +0000, Maciej W. Rozycki wrote:
> Hi,
> 
>  Reposting as this has gone nowhere.  Regenerated for line changes and 
> with Nikolai's Tested-by annotation for 2/2, which now have been verified 
> in combination with generic PIRQ router updates posted separately (there's 
> no ordering dependency between the two patch series).

I assume the x86/IRQ folks will handle this, too.
