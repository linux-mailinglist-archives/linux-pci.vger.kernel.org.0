Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957D442E0C0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhJNSH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 14:07:29 -0400
Received: from out1.migadu.com ([91.121.223.63]:61247 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233471AbhJNSH2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Oct 2021 14:07:28 -0400
Message-ID: <4152471b-fdc9-5cfa-b72d-97f62fe4d282@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634234722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEmLw//Lj/QFJpBZ+ZGoCjcZ2/ZzcehH4/P8idSMT1U=;
        b=fkKyL41GzLdYjf3fP76BuKqQQ5UepaD3wmrmmSyq3UjI8OZo3pkkQqOctjLrinvav+ejIs
        ViwzC6dpng8Nl8kKKU6/HYwBVWChHF28CusB/whOS1JcA3ZjJ3naoP1GNyDhKsnQL7LAXE
        DWJFfS8//KZW60H3c7X47kmRfZvCWi0=
Date:   Thu, 14 Oct 2021 12:05:19 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] PCI: vmd: Use preferred header files linux/device.h
 and linux/msi.h
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
References: <20211013003145.1107148-1-kw@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20211013003145.1107148-1-kw@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jonathan.derrick@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/12/2021 6:31 PM, Krzysztof Wilczyński wrote:
> Use the preferred generic header files linux/device.h and linux/msi.h
> that already include the corresponding asm/device.h and asm/msi.h files,
> especially where the headers files linux/msi.h and asm/msi.h where both
> included.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/vmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..9609eb911349 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -9,6 +9,7 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/device.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> @@ -18,8 +19,6 @@
>  #include <linux/rcupdate.h>
>  
>  #include <asm/irqdomain.h>
> -#include <asm/device.h>
> -#include <asm/msi.h>
>  
>  #define VMD_CFGBAR	0
>  #define VMD_MEMBAR1	2
> 

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
