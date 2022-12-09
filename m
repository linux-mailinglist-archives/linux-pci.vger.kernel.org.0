Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4408648963
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 21:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLIUKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 15:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLIUKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 15:10:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27D75BC8;
        Fri,  9 Dec 2022 12:10:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABFB2B828E3;
        Fri,  9 Dec 2022 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F43C433EF;
        Fri,  9 Dec 2022 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670616615;
        bh=cpwj8aLB1ZSo0VyHds3i+gDgN3tfM1UuJLmIqM6xe0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H3u9AoyALXeWTKNvDfwO58lXMg32cZkhySUu99Jmc645UBUDYk5tVMmmNUfGWPhrq
         8d/kYR1tBvW1wTZEXj3MRs4F1XOoB+2KIu6VnvDhvK5WY8AWTPMxIcyvg9mCvzBR94
         ggN+pxXqwq0mOA/pXLioSxBQxQplEoNQgApf5FI3tUUnJJvWgDG82DjENdXZZXhYba
         vnXbpn9syy/E0Y+OBWujJjm9la6CFT4ZljLJCc7DH4saF87uPbUtnm2ly135Lgvc2m
         nYyq7WSzf3/sD0XDAc6ikPqjJv4nbWpZYo0qk09RCz6MqrNyQYFqETSExRZ+ne0lqg
         6z821JD2dvnXA==
Date:   Fri, 9 Dec 2022 14:10:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-pci@vger.kernel.org, Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] efi/x86: Remove EfiMemoryMappedIO from E820 map
Message-ID: <20221209201013.GA1719699@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7418ea8-6b1a-f648-da5f-bf6ae412e359@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 12:04:53PM +0100, Hans de Goede wrote:
> On 12/9/22 09:06, Hans de Goede wrote:
> > One comment (logging bug in patch) below:
> > ...

> > The logging in this else is re-using the start and end from the previous section which was actually removed.
> > 
> > E.g. Matt's latest log from:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1868899
> > has:
> > 
> > [    0.000000] e820: remove [mem 0xfc800000-0xfe7fffff] reserved
> > [    0.000000] efi: Not removing mem46: MMIO range=[0xfc800000-0xfe7fffff] (4KB) from e820 map
> > [    0.000000] efi: Not removing mem47: MMIO range=[0xfc800000-0xfe7fffff] (32KB) from e820 map
> > [    0.000000] efi: Not removing mem49: MMIO range=[0xfc800000-0xfe7fffff] (8KB) from e820 map
> > [    0.000000] efi: Not removing mem50: MMIO range=[0xfc800000-0xfe7fffff] (4KB) from e820 map
> > 
> > Notice how all the "Not removing ..." lines log the same range as
> > the actually removed map entry above them.
> 
> I realize the fix is very obvious, but since I just fixed this in my
> local tree anyways, here is my fix for this:

Thank you!  Incorporated.

> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -331,9 +331,9 @@ static void __init efi_remove_e820_mmio(void)
>  	for_each_efi_memory_desc(md) {
>  		if (md->type == EFI_MEMORY_MAPPED_IO) {
>  			size = md->num_pages << EFI_PAGE_SHIFT;
> +			start = md->phys_addr;
> +			end = start + size - 1;
>  			if (size >= 256*1024) {
> -				start = md->phys_addr;
> -				end = start + size - 1;
>  				pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
>  					i, start, end, size >> 20);
>  				e820__range_remove(start, size,
> 
