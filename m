Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF75B639A2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 18:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfGIQni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 12:43:38 -0400
Received: from foss.arm.com ([217.140.110.172]:47120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfGIQni (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 12:43:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10AA72B;
        Tue,  9 Jul 2019 09:43:38 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420073F59C;
        Tue,  9 Jul 2019 09:43:37 -0700 (PDT)
Date:   Tue, 9 Jul 2019 17:43:32 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] tools: PCI: Fix installation when `make
 tools/pci_install`
Message-ID: <20190709164332.GA19709@e121166-lin.cambridge.arm.com>
References: <20190709161359.15874-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709161359.15874-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 09, 2019 at 07:13:59PM +0300, Andy Shevchenko wrote:
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
> 
> Cc: Jean-Jacques Hiblot <jjhiblot@ti.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> - addressed Kishon's comment
> - appended his Ack
>  tools/pci/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thank you Andy, merged in pci/misc for v5.3, thanks.

Lorenzo

> diff --git a/tools/pci/Makefile b/tools/pci/Makefile
> index 6876ee4bd78c..4b95a5176355 100644
> --- a/tools/pci/Makefile
> +++ b/tools/pci/Makefile
> @@ -18,7 +18,6 @@ ALL_TARGETS := pcitest
>  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>  
>  SCRIPTS := pcitest.sh
> -ALL_SCRIPTS := $(patsubst %,$(OUTPUT)%,$(SCRIPTS))
>  
>  all: $(ALL_PROGRAMS)
>  
> @@ -47,10 +46,10 @@ clean:
>  
>  install: $(ALL_PROGRAMS)
>  	install -d -m 755 $(DESTDIR)$(bindir);		\
> -	for program in $(ALL_PROGRAMS) pcitest.sh; do	\
> +	for program in $(ALL_PROGRAMS); do		\
>  		install $$program $(DESTDIR)$(bindir);	\
>  	done;						\
> -	for script in $(ALL_SCRIPTS); do		\
> +	for script in $(SCRIPTS); do			\
>  		install $$script $(DESTDIR)$(bindir);	\
>  	done
>  
> -- 
> 2.20.1
> 
