Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB282F437E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 06:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbhAMFGz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 00:06:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40952 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbhAMFGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 00:06:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10D55B7K036083;
        Tue, 12 Jan 2021 23:05:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610514311;
        bh=vidDrT5qcgQkYVkM9hh520ntfgeWPUpIND+ozdkyT4c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hBJ/rPJfgQtY49OZfxVVd66EXKRPLb0/RkN12B/yGERhMmykTEloR6H0TPuz/D2WG
         KTawhu6ItgKcep4CAqfMV0pQNgrt9j6KXQuXHO6yKtv6LxUsHviJXRqntdaKUPBmV0
         Iu9utG+FCrI0Exga2Kc6GEneTaFxaRlmhBqiY/oA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10D55BE6045974
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 23:05:11 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 23:05:11 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 23:05:11 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10D556nr014148;
        Tue, 12 Jan 2021 23:05:07 -0600
Subject: Re: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
To:     Shradha Todi <shradha.t@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <pankaj.dubey@samsung.com>, <sriram.dash@samsung.com>,
        <niyas.ahmed@samsung.com>, <p.rajanbabu@samsung.com>,
        <l.mehra@samsung.com>, <hari.tv@samsung.com>
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
 <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b5b06656-913c-220d-3af7-bb9395252a7b@ti.com>
Date:   Wed, 13 Jan 2021 10:35:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/01/21 7:32 pm, Shradha Todi wrote:
> get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> dereference in pci_epf_test_bind function. Let us add a check for
> pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid
> any such NULL pointer dereference and return -ENOTSUPP in case
> pci_epc_feature is not found.
> 
> When the patch is not applied and EPC features is not implemented in the
> platform driver, we see the following dump due to kernel NULL pointer
> dereference.
> 
> [  105.135936] Call trace:
> [  105.138363]  pci_epf_test_bind+0xf4/0x388
> [  105.142354]  pci_epf_bind+0x3c/0x80
> [  105.145817]  pci_epc_epf_link+0xa8/0xcc
> [  105.149632]  configfs_symlink+0x1a4/0x48c
> [  105.153616]  vfs_symlink+0x104/0x184
> [  105.157169]  do_symlinkat+0x80/0xd4
> [  105.160636]  __arm64_sys_symlinkat+0x1c/0x24
> [  105.164885]  el0_svc_common.constprop.3+0xb8/0x170
> [  105.169649]  el0_svc_handler+0x70/0x88
> [  105.173377]  el0_svc+0x8/0x640
> [  105.176411] Code: d2800581 b9403ab9 f9404ebb 8b394f60 (f9400400)
> [  105.182478] ---[ end trace a438e3c5a24f9df0 ]---
> 
> Fixes: 2c04c5b8eef79 ("PCI: pci-epf-test: Use pci_epc_get_features() to get EPC features")
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index e4e51d8..1b30774 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -830,13 +830,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  		return -EINVAL;
>  
>  	epc_features = pci_epc_get_features(epc, epf->func_no);
> -	if (epc_features) {
> -		linkup_notifier = epc_features->linkup_notifier;
> -		core_init_notifier = epc_features->core_init_notifier;
> -		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> -		pci_epf_configure_bar(epf, epc_features);
> +	if (!epc_features) {
> +		dev_err(&epf->dev, "epc_features not implemented\n");
> +		return -EOPNOTSUPP;
>  	}
>  
> +	linkup_notifier = epc_features->linkup_notifier;
> +	core_init_notifier = epc_features->core_init_notifier;
> +	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> +	pci_epf_configure_bar(epf, epc_features);
> +
>  	epf_test->test_reg_bar = test_reg_bar;
>  	epf_test->epc_features = epc_features;
>  
> 
