Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1682586B7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 06:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAEQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 00:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgIAEQq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Sep 2020 00:16:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02899C0612FE;
        Mon, 31 Aug 2020 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uzhqqdZx9jNcfD1fIRfqPbz58tTt8QIP5mco0hX64GM=; b=I8M85DYxXFwTKfCgfmwTZ1Imq0
        LA3oYRRdSQpyoxc7IGs6ZsOUJo3ETh3WNL6u5JU427IKX1TuFgYIAiIjiPxjkBYi5ubJKO1r3EDS6
        EozLQNOs65YVKKf+Pq7jFR8C2FGm8eE7ew6Z5m7c4TWnMYCir6y/iDH+0rD5PkNIhOItmyi/7GbsI
        uZOytiZzdHHUlXldgqFZOO0UuSIqKI/OkFpX0SRIasqh2CMxjaSvnHtswlFJyU+4k0wK0ta29izoi
        LT7U2wHOvchmbDkIzE1nkeJRJjhazDtggMxaUktTbdz8EsxlkLzsLz2HPXGkKECpcdd54ufr0XJ5f
        bSh6nTQw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCxaR-0006N5-Tr; Tue, 01 Sep 2020 04:08:00 +0000
Subject: Re: [PATCH] x86/platform/intel-mid: Fix build error without
 CONFIG_ACPI
To:     YueHaibing <yuehaibing@huawei.com>, bhelgaas@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, efremov@linux.com, andriy.shevchenko@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200901035825.25256-1-yuehaibing@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5427fca0-6674-42e9-a3b1-52b060ef0301@infradead.org>
Date:   Mon, 31 Aug 2020 21:07:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901035825.25256-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/31/20 8:58 PM, YueHaibing wrote:
> arch/x86/pci/intel_mid_pci.c: In function ‘intel_mid_pci_init’:
> arch/x86/pci/intel_mid_pci.c:303:2: error: implicit declaration of function ‘acpi_noirq_set’; did you mean ‘acpi_irq_get’? [-Werror=implicit-function-declaration]
>   acpi_noirq_set();
>   ^~~~~~~~~~~~~~
>   acpi_irq_get
> 
> Fixes: a912a7584ec3 ("x86/platform/intel-mid: Move PCI initialization to arch_init()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Bjorn has merged my patch (or so his email says), but apparently it's not
in linux-next yet.


> ---
>  arch/x86/pci/intel_mid_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 00c62115f39c..0aaf31917061 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -33,6 +33,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/io_apic.h>
>  #include <asm/intel-mid.h>
> +#include <asm/acpi.h>
>  
>  #define PCIE_CAP_OFFSET	0x100
>  
> 

thanks.
-- 
~Randy

