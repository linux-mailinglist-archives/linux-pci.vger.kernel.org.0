Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326D548B2E2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 18:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiAKRHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 12:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiAKRHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 12:07:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B028C06173F;
        Tue, 11 Jan 2022 09:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BE0EB81C01;
        Tue, 11 Jan 2022 17:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D3BC36AEB;
        Tue, 11 Jan 2022 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641920833;
        bh=Bb3A3XFCuWFd37ZgOFBZ6v9nl+Hpbl1G5QlYpLgRpGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FFG3DSiV2Wpd/y9VgiD0yjfSnf2K0AdK+UvJi3GzF6RjCSirT91FRbzTkLRhlbi/x
         3jJcRnVLq4dbnhkE4Cj4WNAOyenHrlGVlA4ebywvDSKbyrV+3uLI7I4NjbMuvBHrkX
         wmuEGwi/3mLqHcpONGEH0mZt5i4rzd4nCx+h/EqU8FcUYTXg88H0SLBuVNqoWposvH
         5o9aGwiLVhllnGoSga5L1s646vAkvYb8Q2WNkfDoR+L6HOdIuWEx4/Yc1aHZxk+Klq
         53N2//GoOXvw0BDyEFlPCompSGVo+W8ddeLaY7wytpcmlRofvmv0J2VreKJWjUktuZ
         uchRelT6qVAug==
Date:   Tue, 11 Jan 2022 11:07:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Longji Guo <guolongji@uniontech.com>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] X86: PCI: ACPI: Remove initialization of static
 variables to false
Message-ID: <20220111170711.GA151667@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203080758.962-1-guolongji@uniontech.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 03, 2021 at 04:07:58PM +0800, Longji Guo wrote:
> Remove the initialization of pci_ignore_seg to false which is pointless.
> 
> Signed-off-by: Longji Guo <guolongji@uniontech.com>

Applied to pci/enumeration for v5.17, thanks!

> ---
>  arch/x86/pci/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 948656069cdd..052f1d78a562 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -20,7 +20,7 @@ struct pci_root_info {
>  };
>  
>  static bool pci_use_crs = true;
> -static bool pci_ignore_seg = false;
> +static bool pci_ignore_seg;
>  
>  static int __init set_use_crs(const struct dmi_system_id *id)
>  {
> -- 
> 2.20.1
> 
> 
> 
