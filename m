Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D33B00E0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFVKCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 06:02:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57188 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhFVKB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jun 2021 06:01:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15M9xXdR089643;
        Tue, 22 Jun 2021 04:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624355973;
        bh=Qd4RmrAwxAfDXl9SxLdC298+vIrXR4HFrot+dZtNW+I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jjHRRcJ+A71uHCk1eE86lNBY8nEik28cTnx+/IdfCeUlU40jjAtdKLMIn9iqCzQPg
         +LooNUXqnozEaGw6MEuHOcQHA+YsXczyIC7quSerUmUlk5tI99P0LpLkzhYkiEvrJE
         uco9PY+QbZPU/rbmt61EKNvQvGscKcTnguacwcPQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15M9xX1K074648
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jun 2021 04:59:33 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 22
 Jun 2021 04:59:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 22 Jun 2021 04:59:32 -0500
Received: from [10.250.232.62] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15M9xRTD033707;
        Tue, 22 Jun 2021 04:59:30 -0500
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <kernel@pengutronix.de>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
Date:   Tue, 22 Jun 2021 15:29:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 23/02/21 2:37 pm, Uwe Kleine-König wrote:
> The driver core ignores the return value of pci_epf_device_remove()
> (because there is only little it can do when a device disappears) and
> there are no pci_epf_drivers with a remove callback.
> 
> So make it impossible for future drivers to return an unused error code
> by changing the remove prototype to return void.
> 
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Fine with this change!

FWIW:
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 5 ++---
>  include/linux/pci-epf.h             | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 7646c8660d42..a19c375f9ec9 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -389,15 +389,14 @@ static int pci_epf_device_probe(struct device *dev)
>  
>  static int pci_epf_device_remove(struct device *dev)
>  {
> -	int ret = 0;
>  	struct pci_epf *epf = to_pci_epf(dev);
>  	struct pci_epf_driver *driver = to_pci_epf_driver(dev->driver);
>  
>  	if (driver->remove)
> -		ret = driver->remove(epf);
> +		driver->remove(epf);
>  	epf->driver = NULL;
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct bus_type pci_epf_bus_type = {
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..f8a17b6b1d31 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -85,7 +85,7 @@ struct pci_epf_ops {
>   */
>  struct pci_epf_driver {
>  	int	(*probe)(struct pci_epf *epf);
> -	int	(*remove)(struct pci_epf *epf);
> +	void	(*remove)(struct pci_epf *epf);
>  
>  	struct device_driver	driver;
>  	struct pci_epf_ops	*ops;
> 
