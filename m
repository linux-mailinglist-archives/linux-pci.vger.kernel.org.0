Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CB6650519
	for <lists+linux-pci@lfdr.de>; Sun, 18 Dec 2022 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiLRWTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 17:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRWTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 17:19:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1193E5F75
        for <linux-pci@vger.kernel.org>; Sun, 18 Dec 2022 14:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1w3Mu15Klyqehc0emRr+s5Q87Q3EJoKrYgOc9yEtG5g=; b=smdWNR8LleMDbWvzwfjUvgxUR/
        XKQpk9X5gGquZFJpUO12BLjdeK9wEY5zZ2Nlu6kQMkh7jZlXR3odXpjD2U0PAXpZSnE2I4y66mL0b
        GNPwn3SOpsBuruAlaxBcrCR9c4XIP7iGK5zfKFeNh5p+SwtKs2Y0KMREvmTDaNI6h51X8cc66Et5Z
        5vhuGTOkrs+ddZZ55NrHz2ZUjj5+UZaYsmQm9F0NQ0gio4GmiEubIZpXJPrLWioUs3jeUSSJzt4cs
        tbmlyyVyRcPW7SOx3dzZKm3DrsUZdIIdKozNqOBDCBoPTgfRCX/R5MhT6WJyT0SETdZSQn19qQNpf
        E6LVn4lA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p720C-000BUR-HU; Sun, 18 Dec 2022 22:19:24 +0000
Date:   Sun, 18 Dec 2022 22:19:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <Y5+R7DUZFaFNEeza@casper.infradead.org>
References: <20221218033347.23743-1-gremlin@altlinux.org>
 <Y57x/iCSkdtU3kov@rocinante>
 <20221218122139.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218122139.GA1182@altlinux.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 18, 2022 at 03:21:39PM +0300, Alexey V. Vissarionov wrote:
> On 2022-12-18 19:57:02 +0900, Krzysztof Wilczyński wrote:
> 
>  > Thank you for sending the patch over! However, if possible,
>  > can you send it as plain text without any multi-part MIME
>  > involved?
> 
> ACK.
> 
>  > If possible, it would be nice to mention that this needed
>  > to make sure that there is enough space to correctly
>  > NULL-terminate the ID string.
> 
> ACK.
> 
> So, here goes the corrected text:
> 
> Although unlikely, the 'id' value may be as big as 4294967295
> (uint32_max) and "virtfn4294967295\0" would require 17 bytes
> instead of 16 to make sure that buffer has enough space to
> properly NULL-terminate the ID string.

Wait, what?  How can we get to a number that large for the virtual
function ID?  devfn is 8 bits, bus is a further 8 bits.  Sure, domain
is an extra 16 bits on top of that but I'm pretty sure that virtual
functions can't span multiple domains.  Unless that's changed recently?

Even if they can, we'd need to span 2^14 domains to get up to a billion
IDs.  That's a hell of a system and I think overflowing here is the
least of our problems.

So while this is typed as u32, I don't think it can get anywhere close.
