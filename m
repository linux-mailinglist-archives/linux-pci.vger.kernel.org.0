Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623716CEC02
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 16:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjC2Ooi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjC2OoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 10:44:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F061BA;
        Wed, 29 Mar 2023 07:41:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TEfVuv023350;
        Wed, 29 Mar 2023 09:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680100891;
        bh=2Il4jxvtfAKuNqlbBVyI4WnKDZ3OSApBhuRDUqtaCr8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qwSmbBkhXsR0ftZsk0O/+Zkge1zQJA/L2qwyPE+kjp8JJM+bYFlNO/RbMvEKr6TH/
         QHA98mD/asSR80IyJv20D/QkePd9VrPd+XCs8udugfGwEXjnLIL8Sjzf1BLYxtyM1V
         jUBWM04FhnMEqcZXtwYQtJrcWH60TatvK0pnNxU4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TEfV1d105729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 09:41:31 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 09:41:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 09:41:31 -0500
Received: from [10.249.133.214] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TEfPB2023296;
        Wed, 29 Mar 2023 09:41:26 -0500
Message-ID: <12c89cb8-8cea-df6a-7650-fa3059bf5a5b@ti.com>
Date:   Wed, 29 Mar 2023 20:11:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] PCI: cadence: Fix Gen2 Link Retraining process
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, <tjoseph@cadence.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <nadeem@cadence.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <nm@ti.com>
References: <20230315070800.1615527-1-s-vadapalli@ti.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230315070800.1615527-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Bjorn,

On 3/15/2023 12:38 PM, Siddharth Vadapalli wrote:
> The Link Retraining process is initiated to account for the Gen2 defect in
> the Cadence PCIe controller in J721E SoC. The errata corresponding to this
> is i2085, documented at:
> https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
> 
> The existing workaround implemented for the errata waits for the Data Link
> initialization to complete and assumes that the link retraining process
> at the Physical Layer has completed. However, it is possible that the
> Physical Layer training might be ongoing as indicated by the
> PCI_EXP_LNKSTA_LT bit in the PCI_EXP_LNKSTA register.
> 
> Fix the existing workaround, to ensure that the Physical Layer training
> has also completed, in addition to the Data Link initialization.
> 
> Fixes: 4740b969aaf5 ("PCI: cadence: Retrain Link to work around Gen2 training defect")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
> Changes from v1:
> 1. Collect Reviewed-by tag from Vignesh Raghavendra.
> 2. Rebase on next-20230315.
> 
> v1:
> https://lore.kernel.org/r/20230102075656.260333-1-s-vadapalli@ti.com
> 
>  .../controller/cadence/pcie-cadence-host.c    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Wondering do one of you be pulling this patch in? This patch was never
picked for 6.3-rc1 merge cycle... Just want to make sure
pcie-cadence*.c and pci-j721e.c patches have a path to reach pci tree.



[...]

Regards
Vignesh
