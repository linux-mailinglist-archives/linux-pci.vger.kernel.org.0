Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16BA4D8D7D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 20:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiCNT4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 15:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiCNT4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 15:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B26D8D;
        Mon, 14 Mar 2022 12:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5940611EF;
        Mon, 14 Mar 2022 19:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EFAC340E9;
        Mon, 14 Mar 2022 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647287695;
        bh=xo/dl+rzWKB5iDv2IhjiepvkwP0BaMZrXwe5xnF7NXg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UVIatPS6JWsrLdLjjAEpcPpHfprS0uVnOmSk7x0Rf8VbJTUD+ZFOLgv8SadcJRZEU
         QnXg1joEPcgUGew28Ra3jl4LpQlaA46s8ukaOxyy2z8rtAc0xxD9seET4QUPq3wOYG
         z2zCwSQtxJarxZ3Dz2E7yFbelYZWQoBJtAw1lOX00JkkEfkXPhbYGZubVzUSugfUKH
         7fbwlTeg4owhYddluYTKmxRXE3gNmN7F3MZcJ1djCdf3WfQvp/4PAc7zC6M0Xwj94M
         9rvTmBS/E07GxGq3cnOonszTErgW+CsVn+gnBWkM3DHcT4mHsgSNcy0IWUmSkHttQR
         O/RiTq/D0PESQ==
Date:   Mon, 14 Mar 2022 14:54:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next?] x86: PCI: asm/pci_x86.h needs more #includes
Message-ID: <20220314195453.GA527280@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220226213703.24041-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 26, 2022 at 01:37:03PM -0800, Randy Dunlap wrote:
> <asm/pci_x86.h> uses EINVAL, __init, and raw_spinlock_t, so it
> should #include the appropriate files to prevent build errors.
> 
> ../arch/x86/include/asm/pci_x86.h:150:10: error: ‘EINVAL’ undeclared (first use in this function)
>   return -EINVAL;
> 
> ../arch/x86/include/asm/pci_x86.h:105:8: error: unknown type name ‘raw_spinlock_t’
>  extern raw_spinlock_t pci_config_lock;
> 
> ../arch/x86/include/asm/pci_x86.h:141:20: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘dmi_check_pciprobe’
>  extern void __init dmi_check_pciprobe(void);
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, applied to pci/misc for v5.18.

> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
> Without this patch, I am seeing *many* build errors in
> linux-next-20220225.
> 
> I don't know why this showed up in linux-next-20220225 all of a
> sudden.
> 
>  arch/x86/include/asm/pci_x86.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-next-20220225.orig/arch/x86/include/asm/pci_x86.h
> +++ linux-next-20220225/arch/x86/include/asm/pci_x86.h
> @@ -5,7 +5,10 @@
>   *	(c) 1999 Martin Mares <mj@ucw.cz>
>   */
>  
> +#include <linux/errno.h>
> +#include <linux/init.h>
>  #include <linux/ioport.h>
> +#include <linux/spinlock.h>
>  
>  #undef DEBUG
>  
