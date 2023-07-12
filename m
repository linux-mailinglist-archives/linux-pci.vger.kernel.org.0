Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAA750194
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGLIcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 04:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjGLIcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 04:32:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31401FD7;
        Wed, 12 Jul 2023 01:27:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36C8RLU0080033;
        Wed, 12 Jul 2023 03:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689150441;
        bh=06UPusY4gnxau1P1+F2RwJdpg2VyUd3M7tfTUyfQxgY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=iFjWN6lACjjVqR7qvVi0V60xYXznS9b8IdobZrVWpwO09CrtK5HPuVqmHac5N5Wq+
         +7brEVPsjimlaGDxy1d2Ml5rwWTbsXLTO6f9CpXdN8QfnR+g+1dJwymLBaxVMPff5g
         7MSsbRdxDo2iChjk544fQNaKYrnRe8rGtik83SI8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36C8RLht126733
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 03:27:21 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 03:27:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 03:27:21 -0500
Received: from [172.24.19.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36C8RHfa113866;
        Wed, 12 Jul 2023 03:27:18 -0500
Message-ID: <d9a55de7-fcc7-97fb-3f27-31ab273cf1aa@ti.com>
Date:   Wed, 12 Jul 2023 13:57:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] PCI: j721e: Allow async probe
Content-Language: en-US
To:     Li Chen <me@linux.beauty>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1892e291fa4.1219137911620526.2248312811348305435@linux.beauty>
 <ac95ffd2-50c6-f715-5c37-f658bacf4ca4@ti.com>
 <189441ed2ad.124e883f62543235.4120232059297538219@linux.beauty>
From:   "Verma, Achal" <a-verma1@ti.com>
In-Reply-To: <189441ed2ad.124e883f62543235.4120232059297538219@linux.beauty>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/11/2023 2:13 PM, Li Chen wrote:
> 
>   ---- On Tue, 11 Jul 2023 14:16:01 +0800  Verma, Achal  wrote ---
>   >
>   >
>   > On 7/7/2023 7:53 AM, Li Chen wrote:
>   > > From: Li Chen lchen@ambarella.com>
>   > >
>   > > I observed that on Ambarella SoC, which also utilizes
>   > > the Cadence controller, the boot time increases by 1
>   > > second when no endpoints (including switch) are connected
>   > > to PCIe. This increase is caused by cdns_pcie_host_wait_for_link.
>   > >
>   > > Enabling async probe can eliminate this boot time increase.
>   > >
>   > > I guess j721e also has this issue.
>   > I have tested this along with:
>   > https://lore.kernel.org
>   > /all/1892e2ae15f.f7e5dc061620757.4339091752690983066@linux.beauty/
>   >
>   > But I couldn't find second patch in this series.
> 
> Sorry for my mistake, the second patch is just the link you mentioned(https://lore.kernel.org/all/1892e2ae15f.f7e5dc061620757.4339091752690983066@linux.beauty/), I accidentally removed its "2/2" prefix.
> 
> Should I post v2 to fix the subject issue?
I think you have to ask maintainers for this.
> 
>   > >
>   > > Signed-off-by: Li Chen lchen@ambarella.com>
>   > Tested-by: Achal Verma a-verma1@ti.com>
>   > > ---
>   > >   drivers/pci/controller/cadence/pci-j721e.c | 1 +
>   > >   1 file changed, 1 insertion(+)
>   > >
>   > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>   > > index e70213c9060a..660c13bdb606 100644
>   > > --- a/drivers/pci/controller/cadence/pci-j721e.c
>   > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
>   > > @@ -561,6 +561,7 @@ static struct platform_driver j721e_pcie_driver = {
>   > >           .name    = "j721e-pcie",
>   > >           .of_match_table = of_j721e_pcie_match,
>   > >           .suppress_bind_attrs = true,
>   > > +        .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>   > >       },
>   > >   };
>   > >   builtin_platform_driver(j721e_pcie_driver);
>   >
> 
> Regards,
> Li
