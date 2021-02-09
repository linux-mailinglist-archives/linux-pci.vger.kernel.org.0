Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB73159EB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 00:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhBIXQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 18:16:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234349AbhBIWq5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 17:46:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92F1664E8B;
        Tue,  9 Feb 2021 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612905913;
        bh=3l1Lx2Zsd3+a58rOtqbr6Ig2BO03fAiJHekglj/tm5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oU9cIGGZ9+lvTz3ixoLQmevdhcqk5X5fN7zKiSKQ9km0FZCUZTRPHvOTCIzbD6M1W
         vnXE7cYSpKccas23kLuH6Wzm/8zSNH+onxHtt3UcPAj45dzkspoajXUixWJewEyJcV
         kOpAOQYYtuAuT/KyCLv7SWI8f46g/QkS6iar7Bg1GoH1e4n0uNJ78gI9Z7EDkafhlF
         N3k8hhiGuc7Rd28WV7BRooYCOpOPs7RNOIgJ2NYsuRiCMumVKv29td6rVNfiX87xdh
         Mp+OIUhUbzvT7WZHChGByhuK99QBjCHzvcLR4uhgnVvJH4mJZgKjwKkFD9lbErj1E4
         pKVsL82XoRPBQ==
Date:   Tue, 9 Feb 2021 15:25:10 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, prime.zeng@huawei.com,
        linuxarm@openeuler.org, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Use subdir-ccflags-* to inherit debug flag
Message-ID: <20210209212510.GA513360@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1612438215-33105-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Masahiro, Michal, linux-kbuild, linux-kernel]

On Thu, Feb 04, 2021 at 07:30:15PM +0800, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.
> 
> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

I applied this with Krzysztof's reviewed-by and the commit log below
to pci/misc for v5.12, thanks!

Feel free to copy or improve the commit log for use elsewhere.

> ---
>  drivers/pci/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 11cc794..d62c4ac 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>  obj-y				+= controller/
>  obj-y				+= switch/
>  
> -ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> +subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG

commit e8e9aababe60 ("PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy")
Author: Junhao He <hejunhao2@hisilicon.com>
Date:   Thu Feb 4 19:30:15 2021 +0800

    PCI: Apply CONFIG_PCI_DEBUG to entire drivers/pci hierarchy
    
    CONFIG_PCI_DEBUG=y adds -DDEBUG to CFLAGS, which enables things like
    pr_debug() and dev_dbg() (and hence pci_dbg()).  Previously we added
    -DDEBUG for files in drivers/pci/, but not files in subdirectories of
    drivers/pci/.
    
    Add -DDEBUG to CFLAGS for all files below drivers/pci/ so CONFIG_PCI_DEBUG
    applies to the entire hierarchy.
    
    [bhelgaas: commit log]
    Link: https://lore.kernel.org/r/1612438215-33105-1-git-send-email-yangyicong@hisilicon.com
    Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
    Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 11cc79411e2d..d62c4ac4ae1b 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -36,4 +36,4 @@ obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
 obj-y				+= controller/
 obj-y				+= switch/
 
-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
+subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
