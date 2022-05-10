Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6C520EAF
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiEJHit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241554AbiEJHda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 03:33:30 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE32A4A06;
        Tue, 10 May 2022 00:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5eeQI8La8lmF8ix0quxfY5APQ1LZrpvHYLr/Qqi+fpyyo0Y8YeCmVR5srnYnQ5p4b/zrVU+NbOsihV/dJhSq1bC9BtyY7kke31M21TtoTCTPe9dlP1pEUcujo4Tmfnhyy7a4/30tFSs8gE/i6VFw33PBGHMZFrGsQutkrk3uhY7H4KFW6vgp1O+zxaZWdeGJ6FE+yjPLnIjKZpk7cuYobhMG+iJxBnoPO/6s9jEDUbTnhl3rgZqK1LIkXcOQvvsDzsGX6ldbjTz6UR/iOJrtmXZqERS3MBvNrlFqm+Wa9eHa0vdZVxsgF0VqRRkXBrw7yWXmqDglaOhGAe7qvpgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcY8L0pdq4QgmTw+FyBYNnSV18M7DfU6uQ/WqTf51LM=;
 b=hUP2M4WYo07p3Z2lDgbOph412wef40XUoYnKvsg9SFPDN0lhnjYc+6W+vX7ioe4OD3IDn6ynL0xXpW+1RFCC8qX9vW5c4wSTh6S3tmQHWzDkfvEUy/B1KR9GG0fE0h6NFX79ENJr6kJiFQqGiWh5SpbwYT9Lo3VGfzBiAAVVg1UUBHN9KB7Ztx3s4t8LOC0duw0q1ZulGlY8Im3DziUkfTCx1ZoQUTBCn/OyZRTA0yI5zdS0YwVPLuNveNsJC2P2F/WDFH/dZJQPhNMtGE1cG14dMUEAD0PORGnH9JZBuT9yyivFF4K/UAmqZ/I0zdc1C94aodQyvGcEtgWX7CCWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcY8L0pdq4QgmTw+FyBYNnSV18M7DfU6uQ/WqTf51LM=;
 b=GJhWrnnZ2Jea7gWf2fOAMZLu+jLli+zSJm0ceROl5Gqyf8LhESnwzOmfRE0wioG3QozoutdnwVEDOYaDt8B5dTANvEsvkbrVeyW04NgSBCKQp/9avc2CGj4avV0Keort2dzd3GhBWqAjA29LSToY4+09nGH0NgjCpeJLT8vpKbg=
Received: from SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) by DM8PR02MB7928.namprd02.prod.outlook.com
 (2603:10b6:8:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 07:29:30 +0000
Received: from SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::85) by SN4PR0501CA0123.outlook.office365.com
 (2603:10b6:803:42::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 10 May 2022 07:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0018.mail.protection.outlook.com (10.97.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 07:29:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 00:29:26 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 00:29:26 -0700
Envelope-to: robh@kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.254.241.50] (port=44464)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1noKJC-000A04-BY; Tue, 10 May 2022 00:29:26 -0700
Message-ID: <eea7db0b-b483-e61c-8f2d-174f2032fd51@xilinx.com>
Date:   Tue, 10 May 2022 09:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] dt-bindings: PCI: xilinx-cpm: Change reg property order
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
 <CAL_JsqJkHRbXoHdgDYgeF5JhdPgDhjCg=W7YUmCRdBR8xSKz6A@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <CAL_JsqJkHRbXoHdgDYgeF5JhdPgDhjCg=W7YUmCRdBR8xSKz6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6546202-c8ec-4a27-0602-08da3256d279
X-MS-TrafficTypeDiagnostic: DM8PR02MB7928:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB7928CE45C6A05F154341B75CC6C99@DM8PR02MB7928.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TmNqv49u85aqtFPIeSnqAaRFshR/tGQ8pMmjiLQ1Q0zMirYZOp3cx4ipRWAKM76EqAXeAtNOFuHBMct2Qf+Lsj4C55DGYIBKrYphayJcFM2OFQdbqe6pC6VTpW/ccl88lMT+8PUUuZU3rtqZDbbFNxMzv5HH1SRdS6TT9pvMO4y44IU5GwrwaLH7EE+QW+Es66tkkTv5SW0urIQw9+Eu3+iREhS1w9C1W1wHIqz8/6OgvnxfLNGiMikqfAMZoKCxZQX4V9hmA8+pVtoqSWvkY3+j9fb5LgPQWNfMgb3uZN7HYPuRP+vMZ3Fho2hJ5asibi6DEgFPyfdqZnudYV4JSwUhnuiv6dE2iO0jSs/KF8eAMsqObei31PRPMkDeJcCIVxZL3yP0yF+sj5x7eT4CBuvmjQoSoirBv84sdEt1fxihVV6aZVqw1Sz56hBY+/Vh9JWjzTYFkPMMAYC0oVdgHX6e04H2pLWEIm5V8II1zqAiG79TnxOpsvkA/JQgrTBt4jsCehsjqJp+jWPzQy4SMZIvYm/po8RXQRbHzuSiOz5Q35Wi29oJXmdi1Uf+8it30GorXJGGEbt5VfLeVgQzZNGoj+/Bw79rkP6UgptqXp7EZ/ho+dghx51FwY6tLvuNDFOKgPFb+dnZB3B0XG5xX6OWL2xDCRkTXCSf6UnJvQQkBClQDfLvKD/B7h832a+ivPNJwWULJ80iOHuhipD3mZ06nLVQ6cwH5c6mSUvR7Rwk00rYDw4QQ6cZaHCqrl+CsaDNlGMCj4DklDWU0/ULPdZ8Co1MGWVz08OHgH5yAnUzIzSRgdfnfFdoBxAv8yMM
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(31696002)(26005)(70206006)(53546011)(9786002)(4326008)(8936002)(70586007)(8676002)(44832011)(5660300002)(966005)(508600001)(7636003)(2906002)(2616005)(36860700001)(54906003)(316002)(36756003)(110136005)(82310400005)(6636002)(336012)(40460700003)(186003)(426003)(31686004)(356005)(47076005)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 07:29:30.5288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6546202-c8ec-4a27-0602-08da3256d279
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7928
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/4/22 17:43, Rob Herring wrote:
> On Fri, Apr 29, 2022 at 8:02 AM Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com> wrote:
>>
>> Describe cpm reg property before cfg reg property to align with
>> node name.
> 
> The order is an ABI. If breaking it is okay, explain why here.

I didn't push any description for versal to upstream u-boot or linux yet but 
xilinx is using this order for years. DT binding order wasn't aligned to it.

For example: (Xilinx Linux is in sync with this).
https://github.com/Xilinx/u-boot-xlnx/blob/master/arch/arm/dts/versal.dtsi

Driver itself is working with reg-names and order of regs doesn't matter. It 
means changed order doesn't break any functionality.
Right now reg order really matter in binding doc but would be good in these 
examples to record that both ways are fine.
Would it be better to describe that both ways are fine?

   reg-names:
     oneOf:
     - items:
       - const: cfg
       - const: cpm_slcr
     - items:
       - const: cpm_slcr
       - const: cfg


Another small reason is that all hard IPs in Versal are normally placed below 
4GB address range. And there are some others which also have mapping above. This 
is one of that example and we normally aligned with 32bit address.

And the biggest reason is that current node name is pcie@fca10000 which should 
be aligned with the first register base which is before this patch 0x600000000 
but name suggest that the first reg should be cpm_slcr instead of cfg. That's 
why I consider this patch as a fix and the patch should contain fixed tag.

Thanks,
Michal



