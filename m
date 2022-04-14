Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F5500DFA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 14:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiDNMs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 08:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiDNMs5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 08:48:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D820891358;
        Thu, 14 Apr 2022 05:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXw5MUgfZXd5/LOFdvuAUZaVyOZHrONF+t8v6qWmP5P4QEDEbJqKVU7VjyDUKdgwwYdr5timUPogPCisJUcXtdOtVNhX+skRLlfeajjHqiCpqDDd/HdqK2WYeN86TL6lCzdKi2ok/4Mn0nT8GxsQ+JTp6uIC/9r5bU7YCSV4wK2T9mgAtE/yXf7E04/wx+LJRvv3jjjQwpg0RRf0wFMgxv+gFgDy9O6aRz9/KZoTJdmPGIgMpGYygOrfbU45GrzvXBzRZF0yoNOTDwRpbIann6DVRXkxqUqaEMOvgHeRtk9Sv31DXyi6geV+B22dhkPvbBLgqeAi+sQCo/TOSVNebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CGmYdv+qO7r4Ao8Q/59o/yKFWMnUntPiBbkWSg0ufg=;
 b=Vp6oyJlsCKv9grRzRPdE06AyBjVc1O5Tonw/4ayKzqrzrBzHzriT+SSRYILJQ65DL++B1gXyFXNqhnG2cPfSMxfq7hcuBf/XfBO2QjHn8xyjeHcBUFLBeXJcrHTELVugNr7N1Av0hGEhzGfaijXxH5RHCoL1THyyQzxOHKvt4VIUmL0zHn+dzCTtH18ke2t6Tl4l169mX1JHXM6k8fq3JM8QoqX9vMwIWXqqJvB6wqUq2ft6qAsoyX2GS0ja3r3hk28HGoDSym6EYhuyI48tBtI8PA7VFJbia548VrWPacTnx/nw8hbfX4M6//NnnXhjLwWTKRSXucS7lvFmRZ5JcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CGmYdv+qO7r4Ao8Q/59o/yKFWMnUntPiBbkWSg0ufg=;
 b=i0HCtFWTgyDueUYiig5T1aoQx6+p+YMo+rWuvZ0f6bBEgcntIXdIrWaHlP7YXdrKHB4TNMv1Z36rBJKK0kncTXfgMKEwULu5ujxjid81D09qiBckTuA3q+AAP0XjyCtDOoV6rnSJUoF9jinHi8swkn7Tc94RYNb7MtCrGSP6svg=
Received: from BN9PR03CA0939.namprd03.prod.outlook.com (2603:10b6:408:108::14)
 by MWHPR02MB2224.namprd02.prod.outlook.com (2603:10b6:300:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 12:46:30 +0000
Received: from BN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::5f) by BN9PR03CA0939.outlook.office365.com
 (2603:10b6:408:108::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 12:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT043.mail.protection.outlook.com (10.13.2.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 12:46:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 05:46:28 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 05:46:28 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.254.241.50] (port=41084)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1neyrj-0009za-O2; Thu, 14 Apr 2022 05:46:27 -0700
Message-ID: <91ef84f9-4cac-c0aa-c717-7f1b3bc566fb@xilinx.com>
Date:   Thu, 14 Apr 2022 14:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: xilinx-cpm: Remove version
 number in compatible string
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
References: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
 <20220414092252.12174-2-bharat.kumar.gogada@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220414092252.12174-2-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565c2d29-f279-4316-f147-08da1e14cc6b
X-MS-TrafficTypeDiagnostic: MWHPR02MB2224:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB222407DC1B6EC77362D550DAC6EF9@MWHPR02MB2224.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ik9YIMTomLqNb+poRrrkV/uLTTa8PycFlAbV7oggkluOwu+tUmbj7pkwW3O9tNgmVO2lpy1IsSsEWYftoGhQ9SGlLDUxp/ZCJpyTuXTyubMW+xAjQ92g/BTWWCY30wSLt1ST07TzY7iyhZL83SRDa3uOqDrZ92NaKTduEHcn/HhvW2WU5AvWvj+G9NSHXo84domhvX4cVhJh8x4+UVHUaEduyg9WGBhXs8Hd+aY90c1P1IwRMBIDMvrAFoSNXd6jGXEeknHKkGO/5qXnbwWM4JlA1O9r0t4qYD6a6WXkYGxThrwWz6QPTiPaeOg5gYyDfvlebrBItmwpUI/GsAe0OlCi97WQHlgOqwr+roe72xym6S+bbWrYheNAvF7BOxqTamfRBH6ysNQ+qM0hXYJGiILaUL8E3kBKZnqeaero42o7dHiD6hCT+V95yngbQrR/we+gGs3MuTnj0ORzlrqyDHpDW56Q2ofYRFWDfaW3lw1gRCO2sIN3aiD/EKqeL+oKes/q1/PJwkh65pbl8Xh8kFn72a9tmmWvL5dhWsfmEsdbbJRnRbpi/e9eQosF3RR0aCfXrGvwDyUZ2TCTqlrWu7xs+HLofSdfbugZDo7bSb6vXdz4k4oLvSLl1rvs4GpzxjTt9CKr0EQu/hCUbUcry3YSpowP/Du1aS0AAK894pDaZiXUVMc3DDACw90t2mBXe9RLNsyxGYHCNk3zJDLlKGot5AGUAnzLv6512NdHLlg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70206006)(316002)(70586007)(44832011)(508600001)(47076005)(9786002)(426003)(336012)(8936002)(2616005)(83380400001)(31686004)(5660300002)(26005)(186003)(2906002)(356005)(36756003)(4326008)(53546011)(8676002)(7636003)(36860700001)(31696002)(110136005)(40460700003)(54906003)(82310400005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 12:46:30.2901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 565c2d29-f279-4316-f147-08da1e14cc6b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2224
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/14/22 11:22, Bharat Kumar Gogada wrote:
> Removing unnecessary version number in compatible string.

I am missing reason for this in commit message.

> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>   Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 32f4641085bc..4ebcc838a1f6 100644
> --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> @@ -14,7 +14,7 @@ allOf:
>   
>   properties:
>     compatible:
> -    const: xlnx,versal-cpm-host-1.00
> +    const: xlnx,versal-cpm-host

And this is likely breaking compatibility for existing DTs.

M

>   
>     reg:
>       items:
> @@ -70,7 +70,7 @@ examples:
>                  #address-cells = <2>;
>                  #size-cells = <2>;
>                  cpm_pcie: pcie@fca10000 {
> -                       compatible = "xlnx,versal-cpm-host-1.00";
> +                       compatible = "xlnx,versal-cpm-host";
>                          device_type = "pci";
>                          #address-cells = <3>;
>                          #interrupt-cells = <1>;
