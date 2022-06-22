Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41A554204
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 07:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbiFVFLA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 01:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiFVFK7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 01:10:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC8235DC1;
        Tue, 21 Jun 2022 22:10:58 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25M5AlX3046837;
        Wed, 22 Jun 2022 00:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655874647;
        bh=DrZQGD4CPguty23X5d/nt0agTy8fsBIfOiO5YBoPvw8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Qd3b+IQ3DoQyt4rNSzOQZJz0ssieZLV9V3l0telKS4KENOkt/SIfLo274MZKi/avO
         sxVteNJ9EXiZQgVT9DiKTh0e4AksPDOVZav+k9mHjtufASRXBrJTscHE2xbCW06mmP
         i8k/wYNzi4rwEIADLTzF8maQsUet8u/zvCKRYbA4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25M5AlEu037496
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 00:10:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 00:10:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 00:10:47 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25M5Ah6t022819;
        Wed, 22 Jun 2022 00:10:44 -0500
Message-ID: <4bc63a00-a220-e9b8-49ff-8c2d783b55f5@ti.com>
Date:   Wed, 22 Jun 2022 10:40:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
Content-Language: en-US
To:     Shunsuke Mie <mie@igel.co.jp>
CC:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622040924.113279-1-mie@igel.co.jp>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <20220622040924.113279-1-mie@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 22/06/22 09:39, Shunsuke Mie wrote:
> For multi-function endpoint device, an ep function shouldn't stop EP
> controller. Nomally the controller is stopped via configfs.

%s/Nomally/Normally/
> 
> Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Thank you for the fix!

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 5b833f00e980..a5ed779b0a51 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
> -	pci_epc_stop(epc);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		epf_bar = &epf->bar[bar];
>  
