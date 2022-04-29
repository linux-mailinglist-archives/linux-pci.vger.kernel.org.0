Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F45514A7E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359781AbiD2Naq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiD2Nap (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:30:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E002C13B;
        Fri, 29 Apr 2022 06:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOR8zz4Eb5tDLjlZJzseCVBvTOc17iRxNUJTPR/O8pQXXyRQjgp/2CscD8iwBukcegCECejR6ngqVs91TGZa51YQ9qz83lw7fI/dsZt9yvge/5eF697kms1fiRn0Djv7c/efVFa7o8li2fOASugZoJqGDwmG2/utAYKCHv+80XPv+30tlr1VggVKtDgKjg6TzZE2OLa708o8zFms7ZQ04oorLUdEfaPBglq+LPT7rETmMo/35KvbQ/784SOblHEXMx7N1H2Opm9ZUMK0sOdhwDeOadOvr3jc4rQLfiCgLjUEMjK627eJxpMGTnW+PtaLUA9K5hs+jodxv6M70XQgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/pGZHU2F8TMXdVGUb8SYBSXXiUBifYCO0oV/ar0aao=;
 b=C1G4lv1GKfqxXa+fPV6jgKbyqUGIV5m1vwauG38q0sgGNmzZf+Gq19IJmOnG33l8qtaRBauhwGbcPWrFJseQ7/aaiuLM/rve1TqovPAsekPZ8npJAzJqUA3R766cq0vmWa6TVpshKrlF4I0ADS/qLu2aRD0JDlsMuGWLoCagRVudzSPpQO+P/Zp2ZvJsestD5h6bL7F1GLBCB38hOoor9I2+C7XqCgNZiw/K7JX/tkGxlyWsR+ZatWesg2XjZ0vv68QmIRNHRJiUks1OA3THdVH63kT8UttLxCPpyv9NhUK9Ne9YUQxYn6IPQkVWNO9isXq2JzbLw1eVF8dMirloWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/pGZHU2F8TMXdVGUb8SYBSXXiUBifYCO0oV/ar0aao=;
 b=bedlu/oVi9sfyUbh8A6VqRe6Bf+AYRPN3xLhwloquFS5ZWKzm+mGmx31mWVSAi12hgq8vZkNBK2o7SA/+rTn8HvSEGUIGTjViEf+uA9taUdDo9e9DNsgd9gqyanEKhNms4fN1xegPUU4enGxCoyoWzUH4UhjOGcZ+iw4Tc9HTNk=
Received: from SN7PR04CA0082.namprd04.prod.outlook.com (2603:10b6:806:121::27)
 by SA2PR02MB7577.namprd02.prod.outlook.com (2603:10b6:806:134::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 13:27:25 +0000
Received: from SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:121:cafe::91) by SN7PR04CA0082.outlook.office365.com
 (2603:10b6:806:121::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 13:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0041.mail.protection.outlook.com (10.97.5.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 13:27:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 06:27:25 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 06:27:25 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.254.241.50] (port=32836)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nkQea-0009hq-Qb; Fri, 29 Apr 2022 06:27:25 -0700
Message-ID: <fc268228-8188-953b-6990-d694cd499386@xilinx.com>
Date:   Fri, 29 Apr 2022 15:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] dt-bindings: PCI: xilinx-cpm: Change reg property order
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
References: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220429130221.32113-1-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e30cd6a-2f36-43f8-df5d-08da29e4000c
X-MS-TrafficTypeDiagnostic: SA2PR02MB7577:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB75778C7C5A957876A04172F4C6FC9@SA2PR02MB7577.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IBuWWhQf0q/nQBhexJkikoQe0lbs0bbAsjaItaK8eopeKF6daka6QAHwU3O6ukaFzZAEANwSExOEd9jpFwkdbvpUFxsK7sJiFiSlx2V9L4HsIqPrG8fhqPFruiljKES327VGxlV6g469sf7USxcK+qSoK/pTJUayjpx2uEjvyDMbCaCkU5o4RB/rvfMCdToI+rGWPxd3tSF62IuRdG81zVDmBOn6aU6ayW+uvZL64WWzX+YFt3uDWMuYhdS8+YosuvSy5YxZz12F/KEylmhg2N3CuPzSlgVjFXJq0MRdefdtupjNdGoTSsCIZ/d+2wt6u+XtkrpNBJswvTF+fLia303IapcmTJ920Vzy49pfCI98/OKelys1KFKdTFrwmG/Sef35fECb9z2M+kB4hADa6PaqUGBaMTjEZgvRXbmGqkS+A+E8XPO9Wsdbm3ar54M2/R7KtHfbcn2HQp2iy1XHvbBPfcoqD3RyHYwCgJNhuabXVDqtKfAOJaWw7hNtuvhlf5dnn8W7pVArL2j538KqB46s0smudLJuQyFgyi57N8wdm74ceBhqRq3dJ3ecF0GGZNCChCoOmrOm1cgh3b25U80GCxV1eU8XyW5U+cLqZ5u13sRpfeJJDljfdz9cUqdKomCGxjdXriqgWhqnNURSQ+9zsEk+ahC+A6ZAfRTePi6l6Rnrd4UiwZgZ6pD7NCu0NgMXFsTJ66vOMVihB2KxZXKjFA7y3MptK2N71Iqvqk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(47076005)(426003)(336012)(7636003)(44832011)(8936002)(356005)(83380400001)(5660300002)(2906002)(9786002)(36756003)(110136005)(54906003)(26005)(316002)(40460700003)(82310400005)(36860700001)(31686004)(31696002)(8676002)(4326008)(2616005)(53546011)(186003)(70206006)(70586007)(6666004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 13:27:25.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e30cd6a-2f36-43f8-df5d-08da29e4000c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7577
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/29/22 15:02, Bharat Kumar Gogada wrote:
> Describe cpm reg property before cfg reg property to align with
> node name.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>   .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..cca395317a4c 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -18,13 +18,13 @@ properties:
>   
>     reg:
>       items:
> -      - description: Configuration space region and bridge registers.
>         - description: CPM system level control and status registers.
> +      - description: Configuration space region and bridge registers.
>   
>     reg-names:
>       items:
> -      - const: cfg
>         - const: cpm_slcr
> +      - const: cfg
>   
>     interrupts:
>       maxItems: 1
> @@ -86,9 +86,9 @@ examples:
>                          ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
>                                   <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
>                          msi-map = <0x0 &its_gic 0x0 0x10000>;
> -                       reg = <0x6 0x00000000 0x0 0x10000000>,
> -                             <0x0 0xfca10000 0x0 0x1000>;
> -                       reg-names = "cfg", "cpm_slcr";
> +                       reg = <0x0 0xfca10000 0x0 0x1000>,
> +                             <0x6 0x00000000 0x0 0x10000000>;
> +                       reg-names = "cpm_slcr", "cfg";
>                          pcie_intc_0: interrupt-controller {
>                                  #address-cells = <0>;
>                                  #interrupt-cells = <1>;

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
