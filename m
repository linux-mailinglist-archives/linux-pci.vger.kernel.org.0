Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839DF77D357
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 21:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbjHOTYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbjHOTYA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 15:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0466D1FE8;
        Tue, 15 Aug 2023 12:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A983644DC;
        Tue, 15 Aug 2023 19:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70879C433C7;
        Tue, 15 Aug 2023 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692127243;
        bh=juaV9ptf7G8D6/MebPy6CX23F3T/jcHKcNtLtg9ebDM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Me6cv4bbbEwLZSsRoScgM4XqzJHT2vQMeTONh/jcANKnQQQFb+Ho+rpW3tgTxsM4C
         ugCtvS9NDZElc9L8olZL/aXlVDKCS7vpmYH5OtTzvHBy+oA0bVw3xoUgC2tUhiNXUX
         2vVm1q2Z4b9Agi2HjFY3g1HfSDBvCVCURzkEYNH2uq6deVuq+yOO6HKD/hHdaW2vsn
         QFwHhgHBbYZDjlFcIQqjFJ96z47XI8/km9w/5gc90NP6oaRcXJoeKUCkTl1QRNGBHl
         v8U/Q8UVVOHZOG8qTF3h+8OyYfX7q9xZcTi+3Q1HvrdwVFWEEPigPPUTh48cJmtheY
         U5XuFUSlawLJA==
Date:   Tue, 15 Aug 2023 14:20:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v11 3/9] ACPI: x86: s2idle: Fix a logic error parsing AMD
 constraints table
Message-ID: <20230815192041.GA233609@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809185453.40916-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 01:54:47PM -0500, Mario Limonciello wrote:
> The constraints table should be resetting the `list` object
> after running through all of `info_obj` iterations.

This *looks* like it should fix a real problem (see below), but not
the one mentioned here.  But maybe I'm missing something because the
code that looks broken to me has been there since 146f1ed852a8 ("ACPI:
PM: s2idle: Add AMD support to handle _DSM"), which appeared in v5.11
in 2021.

> This adjusts whitespace as well as less code will now be included
> with each loop.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v9->v10:
>  * split from other patches
> ---
>  drivers/acpi/x86/s2idle.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index ce62e61a9605e..b566b3aa09388 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -129,12 +129,12 @@ static void lpi_device_get_constraints_amd(void)
>  				struct lpi_constraints *list;
>  				acpi_status status;
>  
> +				list = &lpi_constraints_table[lpi_constraints_table_size];
> +				list->min_dstate = -EINVAL;

I really have no idea what's going on here, but the code still looks
weird:

  1) Moving the "list" update:

       for (j = 0; j < package->package.count; ++j) {
     +   list = &lpi_constraints_table[lpi_constraints_table_size];
         for (k = 0; k < info_obj->package.count; ++k) {
     -     list = &lpi_constraints_table[lpi_constraints_table_size];
           ...
         }
         lpi_constraints_table_size++;
       }

     looks fine, but lpi_constraints_table_size isn't updated inside
     the "k" loop, and "list" isn't otherwise updated, so it shouldn't
     make any functional difference.

     HOWEVER, this patch also moves all the
     dev_info.enabled/name/min_dstate tests outside the "k" loop, so
     they're only done after the "k" loop has completed and they've
     all been set, which looks like it DOES fix a problem and is not
     mentioned in the commit log.

  2) Both lpi_device_get_constraints_amd() and
     lpi_device_get_constraints() overwrite the global
     lpi_constraints_table for each PNP0D80 device.  I assume there's
     some higher-level constraint that there can only be one such
     device, but the code doesn't enforce that.

  3) It's obvious that lpi_device_get_constraints() can only allocate
     lpi_constraints_table once per call.  It's NOT obvious for
     lpi_device_get_constraints_amd(), because the alloc is inside a
     loop:

       for (i = 0; i < out_obj->package.count; i++) {
         lpi_constraints_table = kcalloc(...);

     If the AMD _DSM returns more than one package, we'll leak all but
     the last one.

  4) Both lpi_device_get_constraints_amd() and
     lpi_device_get_constraints() use pre- and post-increment in the
     "for" loops for no apparent reason:

       for (i = 0; i < out_obj->package.count; i++)
         for (j = 0; j < package->package.count; ++j)
           for (k = 0; k < info_obj->package.count; ++k)  # AMD only

     I'd say they should all use the same (I vote for post-increment).

>  				for (k = 0; k < info_obj->package.count; ++k) {
>  					union acpi_object *obj = &info_obj->package.elements[k];
>  
> -					list = &lpi_constraints_table[lpi_constraints_table_size];
> -					list->min_dstate = -1;
> -
>  					switch (k) {
>  					case 0:
>  						dev_info.enabled = obj->integer.value;
> @@ -149,26 +149,25 @@ static void lpi_device_get_constraints_amd(void)
>  						dev_info.min_dstate = obj->integer.value;
>  						break;
>  					}
> +				}
>  
> -					if (!dev_info.enabled || !dev_info.name ||
> -					    !dev_info.min_dstate)
> -						continue;
> +				if (!dev_info.enabled || !dev_info.name ||
> +				    !dev_info.min_dstate)
> +					continue;
>  
> -					status = acpi_get_handle(NULL, dev_info.name,
> -								 &list->handle);
> -					if (ACPI_FAILURE(status))
> -						continue;
> +				status = acpi_get_handle(NULL, dev_info.name, &list->handle);
> +				if (ACPI_FAILURE(status))
> +					continue;
>  
> -					acpi_handle_debug(lps0_device_handle,
> -							  "Name:%s\n", dev_info.name);
> +				acpi_handle_debug(lps0_device_handle,
> +						  "Name:%s\n", dev_info.name);
>  
> -					list->min_dstate = dev_info.min_dstate;
> +				list->min_dstate = dev_info.min_dstate;
>  
> -					if (list->min_dstate < 0) {
> -						acpi_handle_debug(lps0_device_handle,
> -								  "Incomplete constraint defined\n");
> -						continue;
> -					}
> +				if (list->min_dstate < 0) {
> +					acpi_handle_debug(lps0_device_handle,
> +							  "Incomplete constraint defined\n");
> +					continue;
>  				}
>  				lpi_constraints_table_size++;
>  			}
> -- 
> 2.34.1
> 
