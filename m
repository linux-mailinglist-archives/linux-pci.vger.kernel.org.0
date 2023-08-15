Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860277D1D6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbjHOS2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 14:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbjHOS2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 14:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C3DE48;
        Tue, 15 Aug 2023 11:28:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9526F64BBB;
        Tue, 15 Aug 2023 18:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8859C433C8;
        Tue, 15 Aug 2023 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692124115;
        bh=sQ9J2WQcSOmp89HXvpJIqsEfZ7mxXbZlxpDqSSVn20E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lHtvIyUmoC8E5hQQjrqmEINaoPX++SiXLNmz2nxtDgec3ywMPjJGtglbDyheEV6yj
         qYcxKuaDSNLGPk8iTO54Ig24zH14wc1Oyqgocwr+d5Wcu4eI7W7ONBl9i6f3rebJdt
         2Wes5GPyL5RmyST99Ro4h6px5GE5eSR3ya9rYgo1FuxhhDecx/eiK9lbCxPvqM57VW
         8yIvWdK2Rj0slBORp0oZN/F4ur4R8Jh03jQXYtUNEmxsMfv/5F+djq7P/VFDLP8C0g
         78BCjfkLYNemkL5XJXulhJShAH/yniMIrxhhJMaQnmlVXNx8Gbd83kSjQnHoz1omGy
         Q6rVL3/eVE/qw==
Date:   Tue, 15 Aug 2023 13:28:32 -0500
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
Subject: Re: [PATCH v11 2/9] ACPI: Adjust #ifdef for *_lps0_dev use
Message-ID: <20230815182832.GA233199@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809185453.40916-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 01:54:46PM -0500, Mario Limonciello wrote:
> The #ifdef currently is guarded against CONFIG_X86, but these are
> actually sleep related functions so they should be tied to
> CONFIG_ACPI_SLEEP.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v9->v10:
>  * split from other patches
> ---
>  include/linux/acpi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0d5277b7c6323..13a0fca3539f0 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1100,7 +1100,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
>  
>  acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
>  					   u32 val_a, u32 val_b);
> -#ifdef CONFIG_X86
> +#if defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)

What's the connection to CONFIG_ACPI_SLEEP?

The acpi_register_lps0_dev() implementation in
drivers/acpi/x86/s2idle.c is under #ifdef CONFIG_SUSPEND (and
obviously s2idle.c is only compiled at all if CONFIG_X86).

Both callers (amd_pmc_probe() and thinkpad_acpi_module_init()) are
under #ifdef CONFIG_SUSPEND.

>  struct acpi_s2idle_dev_ops {
>  	struct list_head list_node;
>  	void (*prepare)(void);
> @@ -1109,7 +1109,7 @@ struct acpi_s2idle_dev_ops {
>  };
>  int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>  void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
> -#endif /* CONFIG_X86 */
> +#endif /* CONFIG_ACPI_SLEEP && CONFIG_X86 */
>  #ifndef CONFIG_IA64
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> -- 
> 2.34.1
> 
