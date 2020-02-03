Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFB150DD4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 17:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgBCQ1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 11:27:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgBCQ1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2020 11:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GlhiWZUF/YX3gEFzvjYXVXI3s+IP0haz6QdP1XP2Q4c=; b=kgo2mZARm8v3jQFbI3uCEpxH6U
        NrmKQla4px8BTh70BOn737Z9BQ9vJ+P6KkOfQOO+oDa3aX79Mo8HTpZdx0ixdfGULQnTa+x7CIZaW
        4FvO8K4pY8lG89evFWlYd5jmRkfuuTibRnswe4k1mfSvHdlsgFWKUalivplkEc9Se3/+Y8HqHY8LW
        s2VxB3aNiEISZsdJrK+ijLNY3K0vXqtib3rE7usWPMxSnamH2ZaxOmiDv/Uf91pjSS+siRzJgAXdp
        2cC05VxR7Ub15GuCb4+zJBk4YyYwZ8cDHUFewBU0hsmd+MMK0xgNfeLHZu4DCGNYQoMDkMZ9ToE0C
        yXoNhI1Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyeZQ-00016X-5u; Mon, 03 Feb 2020 16:27:32 +0000
Subject: Re: linux-next: Tree for Feb 3 (arch/x86/{various}; all PCI-related)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20200203142334.4f699874@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b569f6f3-a757-5bbb-3e1a-9d78b12709b7@infradead.org>
Date:   Mon, 3 Feb 2020 08:27:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203142334.4f699874@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/2/20 7:23 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any v5.7 material to your linux-next included
> branches until after v5.6-rc1 has been released.
> 
> News: I have added an htmldocs build to the end of my day.  It seems to
> be building at the moment, but has many warnings.
> 
> Changes since 20200131:
> 

(trying this again, with more Cc:s since last week's report [on Jan. 28]
got no response)


on x86_64:

# CONFIG_PCI is not set

Several source files will not build when CONFIG_PCI is not set/enabled.

Examples:

  CC      arch/x86/events/amd/ibs.o
In file included from ../include/linux/pci.h:1778:0,
                 from ../arch/x86/events/amd/ibs.c:12:
../arch/x86/include/asm/pci.h: In function '__pcibus_to_node':
../arch/x86/include/asm/pci.h:126:9: error: implicit declaration of function 'to_pci_sysdata'; did you mean 'to_pci_dev'? [-Werror=implicit-function-declaration]
  return to_pci_sysdata(bus)->node;
         ^~~~~~~~~~~~~~
         to_pci_dev
../arch/x86/include/asm/pci.h:126:28: error: invalid type argument of '->' (have 'int')
  return to_pci_sysdata(bus)->node;
                            ^~

  CC      arch/x86/kernel/cpu/cacheinfo.o
In file included from ../include/linux/pci.h:1778:0,
                 from ../arch/x86/kernel/cpu/cacheinfo.c:17:
../arch/x86/include/asm/pci.h: In function '__pcibus_to_node':
../arch/x86/include/asm/pci.h:126:9: error: implicit declaration of function 'to_pci_sysdata'; did you mean 'to_pci_bus'? [-Werror=implicit-function-declaration]
  return to_pci_sysdata(bus)->node;
         ^~~~~~~~~~~~~~
         to_pci_bus
../arch/x86/include/asm/pci.h:126:28: error: invalid type argument of '->' (have 'int')
  return to_pci_sysdata(bus)->node;
                            ^~

  CC      arch/x86/kernel/apic/io_apic.o
In file included from ../include/linux/pci.h:1778:0,
                 from ../arch/x86/kernel/apic/io_apic.c:40:
../arch/x86/include/asm/pci.h: In function '__pcibus_to_node':
../arch/x86/include/asm/pci.h:126:9: error: implicit declaration of function 'to_pci_sysdata'; did you mean 'to_pci_bus'? [-Werror=implicit-function-declaration]
  return to_pci_sysdata(bus)->node;
         ^~~~~~~~~~~~~~
         to_pci_bus
../arch/x86/include/asm/pci.h:126:28: error: invalid type argument of '->' (have 'int')
  return to_pci_sysdata(bus)->node;
                            ^~

  CC      arch/x86/kernel/setup.o
In file included from ../include/linux/pci.h:1778:0,
                 from ../arch/x86/kernel/setup.c:16:
../arch/x86/include/asm/pci.h: In function '__pcibus_to_node':
../arch/x86/include/asm/pci.h:126:9: error: implicit declaration of function 'to_pci_sysdata'; did you mean 'to_pci_bus'? [-Werror=implicit-function-declaration]
  return to_pci_sysdata(bus)->node;
         ^~~~~~~~~~~~~~
         to_pci_bus
../arch/x86/include/asm/pci.h:126:28: error: invalid type argument of '->' (have 'int')
  return to_pci_sysdata(bus)->node;
                            ^~

  CC      arch/x86/kernel/x86_init.o
In file included from ../include/linux/pci.h:1778:0,
                 from ../arch/x86/kernel/x86_init.c:9:
../arch/x86/include/asm/pci.h: In function '__pcibus_to_node':
../arch/x86/include/asm/pci.h:126:9: error: implicit declaration of function 'to_pci_sysdata'; did you mean 'to_pci_bus'? [-Werror=implicit-function-declaration]
  return to_pci_sysdata(bus)->node;
         ^~~~~~~~~~~~~~
         to_pci_bus
../arch/x86/include/asm/pci.h:126:28: error: invalid type argument of '->' (have 'int')
  return to_pci_sysdata(bus)->node;
                            ^~

  CC      arch/x86/kernel/irqinit.o
In file included from ../include/linux/pci.h:1778:0,
                 from ../arch/x86/include/asm/prom.h:15,
                 from ../arch/x86/kernel/irqinit.c:29:
../arch/x86/include/asm/pci.h: In function '__pcibus_to_node':
../arch/x86/include/asm/pci.h:126:9: error: implicit declaration of function 'to_pci_sysdata'; did you mean 'to_pci_dev'? [-Werror=implicit-function-declaration]
  return to_pci_sysdata(bus)->node;
         ^~~~~~~~~~~~~~
         to_pci_dev
../arch/x86/include/asm/pci.h:126:28: error: invalid type argument of '->' (have 'int')
  return to_pci_sysdata(bus)->node;
                            ^~


That's just a sample:

$ buildsummary.pl build-r9671.out 
file: arch/x86/boot/header.S: errors: 1, warnings: 0
file: arch/x86/include/asm/pci.h: errors: 234, warnings: 0
build-r9671.out: totals: error/warning files: 2, errors: 235, warnings: 0, Section mismatches: 0




-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
