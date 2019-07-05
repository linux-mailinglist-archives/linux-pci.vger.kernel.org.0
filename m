Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7555660A32
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfGEQYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 12:24:04 -0400
Received: from foss.arm.com ([217.140.110.172]:43510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfGEQYE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 12:24:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032C52B;
        Fri,  5 Jul 2019 09:24:04 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18D923F246;
        Fri,  5 Jul 2019 09:24:02 -0700 (PDT)
Date:   Fri, 5 Jul 2019 17:23:58 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v1] tools: PCI: Fix installation when `make
 tools/pci_install`
Message-ID: <20190705162358.GA3080@e121166-lin.cambridge.arm.com>
References: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628133326.18203-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 28, 2019 at 04:33:26PM +0300, Andy Shevchenko wrote:
> The commit c9a707875053 ("tools pci: Do not delete pcitest.sh in 'make clean'")
> fixed a `make tools clean` issue and simultaneously brought a regression
> to the installation process:
> 
>   for script in .../tools/pci/pcitest.sh; do	\
> 	install $script .../usr/usr/bin;	\
>   done
>   install: cannot stat '.../tools/pci/pcitest.sh': No such file or directory
> 
> Here is the missed part of the fix.

Sigh, hopefully that's the last fix :), Kishon if that's OK mind
ACKing it please ?

Thanks,
Lorenzo

> Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  tools/pci/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/pci/Makefile b/tools/pci/Makefile
> index 6876ee4bd78c..cc4a161ee2cc 100644
> --- a/tools/pci/Makefile
> +++ b/tools/pci/Makefile
> @@ -47,10 +47,10 @@ clean:
>  
>  install: $(ALL_PROGRAMS)
>  	install -d -m 755 $(DESTDIR)$(bindir);		\
> -	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
> +	for program in $(ALL_PROGRAMS); do		\
>  		install $$program $(DESTDIR)$(bindir);	\
>  	done;						\
> -	for script in $(ALL_SCRIPTS); do		\
> +	for script in pcitest.sh; do			\
>  		install $$script $(DESTDIR)$(bindir);	\
>  	done
>  
> -- 
> 2.20.1
> 
