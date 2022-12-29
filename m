Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95CE659029
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiL2SNE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 13:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiL2SND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 13:13:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E613CD3
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 10:13:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D0A2B818ED
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 18:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AC7C433D2;
        Thu, 29 Dec 2022 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672337580;
        bh=l/D2CzKz+miEhUlEGnXdga8DRdqgBLoREPjXAmzWUyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uGk5G5IJ1Tf7D3CXQ22VSWFs2n9NpRaCR8Bo5UeVoJY1PWgN6RtTQstNacWNb8tb7
         rOSpCPs4K0QpDLj9jpmKSNxDqzOdZjLeayPo71CMWu0aMnkm5kfpSdu1DFM5zfJEwQ
         N6oXHGZuk0AwjReTRjD0yxwHKsae4MS1iZjhS8dSaUvB5BzPA956hw/ZR14uDGx/7v
         OqfDf71/e1DMWRnqO1pYucW3+zi68bYIDS3ubl7igkpeH634nd26bIcpy7VZlHnG2n
         g+tULo3lgTWQLeUDlWRDUBYj/QiOETD8zlyxGo0RsiDZGSs9X/Ftc0M+IVL4/PQYyo
         nf7bbo+hs0iDw==
Date:   Thu, 29 Dec 2022 12:12:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <20221229181258.GA616291@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5+R7DUZFaFNEeza@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 18, 2022 at 10:19:24PM +0000, Matthew Wilcox wrote:
> On Sun, Dec 18, 2022 at 03:21:39PM +0300, Alexey V. Vissarionov wrote:
> > On 2022-12-18 19:57:02 +0900, Krzysztof Wilczyński wrote:
> ...

> > Although unlikely, the 'id' value may be as big as 4294967295
> > (uint32_max) and "virtfn4294967295\0" would require 17 bytes
> > instead of 16 to make sure that buffer has enough space to
> > properly NULL-terminate the ID string.
> 
> Wait, what?  How can we get to a number that large for the virtual
> function ID?  devfn is 8 bits, bus is a further 8 bits.  Sure, domain
> is an extra 16 bits on top of that but I'm pretty sure that virtual
> functions can't span multiple domains.  Unless that's changed recently?
> 
> Even if they can, we'd need to span 2^14 domains to get up to a billion
> IDs.  That's a hell of a system and I think overflowing here is the
> least of our problems.
> 
> So while this is typed as u32, I don't think it can get anywhere close.

Is there an argument *against* this patch (as opposed to "this is
probably unnecessary and it requires a lot of analysis to prove that
we don't need it")?

My biggest concern here is that there's no connection between the
VIRTFN_ID_LEN definition and the use.  Even a comment about how the
value of 16 or 17 was derived would help.

Bjorn
