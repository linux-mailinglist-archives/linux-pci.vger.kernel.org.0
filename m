Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491C92DE3EB
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 15:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLROVK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 09:21:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37710 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgLROVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 09:21:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIEJQJC093197;
        Fri, 18 Dec 2020 08:19:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608301166;
        bh=S+0GamKVCQ687Tv6EqyRvpQ1fBcSrBgLoRk//UMEKCc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OhInuthfyE1sUT8QW2eEhRFjnbAPn+XfqGsUV4TRoOxjVnbfsDsvCcSie1YV4266F
         8/RGvWMmDTkhyLbGDvbXCCq2Lny1atTCTREMQH03bwULQo68I86n48w5a1mGsKnPFE
         ZUs2go+hyKlixjJWH7kN4clMEnqDp82uw8nSOeuw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIEJQSm095816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 08:19:26 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 08:19:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 08:19:26 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIEJNTE090472;
        Fri, 18 Dec 2020 08:19:23 -0600
Subject: Re: [PATCH] msi: use for_each_msi_entry_safe iterator macro
To:     Jacob Keller <jacob.e.keller@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20201217005557.45031-1-jacob.e.keller@intel.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <4b3ee539-d5b0-d316-5ee0-0b7bd543c283@ti.com>
Date:   Fri, 18 Dec 2020 19:49:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201217005557.45031-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 17/12/20 6:25 am, Jacob Keller wrote:
> Commit 81b1e6e6a859 ("platform-msi: Free descriptors in
> platform_msi_domain_free()") introduced for_each_msi_entry_safe as an
> iterator operating on the msi_list using the safe semantics with
> a temporary variable.
> 
> A handful of locations still used the generic iterator instead of the
> specific macro. Fix the 3 remaining cases. Add a cocci script which can
> detect and report any misuse that is introduced in future changes.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

[..snip..]

>  	}
> diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
> index 0eb9462f609e..66f9772dcdfa 100644
> --- a/drivers/soc/ti/ti_sci_inta_msi.c
> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
> @@ -64,7 +64,7 @@ static void ti_sci_inta_msi_free_descs(struct device *dev)
>  {
>  	struct msi_desc *desc, *tmp;
>  
> -	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
> +	for_each_msi_entry_safe(desc, tmp, dev) {
>  		list_del(&desc->list);
>  		free_msi_entry(desc);
>  	}

For ti_sci_inta_msi part:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

