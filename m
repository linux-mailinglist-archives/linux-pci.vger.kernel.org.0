Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F154342E0C1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhJNSIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 14:08:18 -0400
Received: from out1.migadu.com ([91.121.223.63]:61592 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhJNSIS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Oct 2021 14:08:18 -0400
Message-ID: <3117b0ac-dc2f-4986-8952-cd97a8351307@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634234772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/N1wY+gpT76b6FYYA1y3p7za2C/XYM0nto66DpglIpY=;
        b=ZniFiqlKFoPWK1F+BYc/OYzEFkSvYXzGinFhiI00ecbB5qIYiUeGx+fM5B/Yddv/5EKyZI
        73zOTnmikanCmMra2RUzcyualkAE5ER5egAD/uEuVrdzYYEnW0lDr7cWPQ4E19MliJ2W54
        Kjiwglfn1jcm1oty+cyLdWaRNcdLJHI=
Date:   Thu, 14 Oct 2021 12:06:09 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] PCI: hotplug: Use preferred header file linux/io.h
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
References: <20211013003145.1107148-1-kw@linux.com>
 <20211013003145.1107148-2-kw@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20211013003145.1107148-2-kw@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jonathan.derrick@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/12/2021 6:31 PM, Krzysztof Wilczyński wrote:
> Use the preferred generic header file linux/io.h that already includes
> the corresponding asm/io.h file.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/hotplug/cpqphp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/cpqphp.h b/drivers/pci/hotplug/cpqphp.h
> index 77e4e0142fbc..2f7b49ea96e2 100644
> --- a/drivers/pci/hotplug/cpqphp.h
> +++ b/drivers/pci/hotplug/cpqphp.h
> @@ -15,7 +15,7 @@
>  #define _CPQPHP_H
>  
>  #include <linux/interrupt.h>
> -#include <asm/io.h>		/* for read? and write? functions */
> +#include <linux/io.h>		/* for read? and write? functions */
>  #include <linux/delay.h>	/* for delays */
>  #include <linux/mutex.h>
>  #include <linux/sched/signal.h>	/* for signal_pending() */
> 

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
