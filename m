Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184EC483EB3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 10:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiADJDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 04:03:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51558 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiADJDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 04:03:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20493TOb085788;
        Tue, 4 Jan 2022 03:03:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641287009;
        bh=TwTfLCgT1Ye2TYDl4sqf2pvBQnKw8kixcDRFpionW3k=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=e/ku9Al+MXqTjPawc6Z1PI0foQnkkMhvT0qgNX8RPz9mULEYJ2kHyz2EF+Q4Bftz8
         E1hTzNr3B3XoqjWNhhpbW3nGz+GLnzoz0h1awKgk//I0lNl/m9/OldxXPeiFqChJNX
         WNNcRx4e0uk1BCXcJETsVpArLJjDfQG/UhT2S45w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20493TBr054433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 03:03:29 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 03:03:29 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 03:03:29 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20493RPE095669;
        Tue, 4 Jan 2022 03:03:27 -0600
Subject: Re: [PATCH] PCI: endpoint: set_msi: return -EINVAL when interrupts
 num is smaller than 1
To:     Li Chen <lchen@ambarella.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <CH2PR19MB402491B9E503694DBCAC6005A07C9@CH2PR19MB4024.namprd19.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1402c8bb-f5af-8a34-ee79-31c32eb26379@ti.com>
Date:   Tue, 4 Jan 2022 14:33:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CH2PR19MB402491B9E503694DBCAC6005A07C9@CH2PR19MB4024.namprd19.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 21/12/21 8:29 am, Li Chen wrote:
> There is no sense to go further if we have no interrupts.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 38621558d3975..3bc9273d0a082 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -334,7 +334,7 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
>  	u8 encode_int;
>  
>  	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
> -	    interrupts > 32)
> +	    interrupts < 1 || interrupts > 32)
>  		return -EINVAL;
>  
>  	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> 
