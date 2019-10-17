Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184C7DB711
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441494AbfJQTL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:11:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfJQTL7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 15:11:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E97B307D985;
        Thu, 17 Oct 2019 19:11:58 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-81.rdu2.redhat.com [10.10.123.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45D23600C8;
        Thu, 17 Oct 2019 19:11:56 +0000 (UTC)
Subject: Re: [PATCH 3/3] pci: Default to PCI_MSI_IRQ_DOMAIN
To:     Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, peterz@infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20191017181937.7004-1-palmer@sifive.com>
 <20191017181937.7004-4-palmer@sifive.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <38389bfa-3fb2-c941-9f9d-0fa573112c58@redhat.com>
Date:   Thu, 17 Oct 2019 15:11:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191017181937.7004-4-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 19:11:59 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/17/19 2:19 PM, Palmer Dabbelt wrote:
> As far as I can tell, the only reason there was an architecture
> whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
> built this for all the architectures that play nice with make.cross, but
> I haven't boot tested it anywhere.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a304f5ea11b9..77c1428cd945 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -52,7 +52,7 @@ config PCI_MSI
>  	   If you don't know what to do here, say Y.
>  
>  config PCI_MSI_IRQ_DOMAIN
> -	def_bool ARC || ARM || ARM64 || X86 || RISCV
> +	def_bool y
>  	depends on PCI_MSI
>  	select GENERIC_MSI_IRQ_DOMAIN
>  

The linking of asm-generic/msi.h is currently enabled for

./arch/powerpc/include/asm/Kbuild:generic-y += msi.h
./arch/arm/include/asm/Kbuild:generic-y += msi.h
./arch/mips/include/asm/Kbuild:generic-y += msi.h
./arch/riscv/include/asm/Kbuild:generic-y += msi.h
./arch/arc/include/asm/Kbuild:generic-y += msi.h
./arch/arm64/include/asm/Kbuild:generic-y += msi.h
./arch/sparc/include/asm/Kbuild:generic-y += msi.h

Your patchset adds 2 more and x86 has its own asm/msi.h. That leads to a
total of 10 archs, but there are 37 sub-directories under arch. It is
possible that the other architectures don't have PCI_MSI set. Still it
may be a bit risky to set it to "def_bool y".

Cheers,
Longman

