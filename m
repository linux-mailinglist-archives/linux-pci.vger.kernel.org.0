Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84DF500E01
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbiDNMuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 08:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiDNMuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 08:50:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BEF91AC2;
        Thu, 14 Apr 2022 05:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK07gZPBhd2jWSLzDr8sOnNHpw9Zz6/+43hunoqvL8T9bhnmQLKMYBtBq7khVzkgbWYz8HLzT9FJNFm4dFKDdJ6F+qEYFL8ZLhQDQTf98IIx/FAL8Y/MTZm/HdLdNWmNB3Ai+LC2yePhDojwNqTVWh2eEK/PvTQ2MyRNydVZeGoabvknJdmL7K+QsQT7fcCiviTACYRHDz7vQutfFxhrm4aV/jXLoESwHPZLB0X/CKhwLr9SOlXHYP4L1AJWipjKyifgB6Gc1pwQHVcFxqMEU33/j+kpVlIZFJT/sBRPdQBjBz2HShp231yxYBJu9mJeR0yyWTOMPiS3Ec6wvGualw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5XDkrmTrmwLfgc8QGPzKhcXE/R05iaR/IWvD6t6Hh0=;
 b=U3zENpHq4zPKToFRkP/NSdPlja9xomkHBwTWfggVHN2XvB/aXyH5fsH2Xb6Ccf9RBBjT9z3dIPKaAr5YXMuJeJgaTLlikRqlrmMp52919Dl+mykcsmE9HaDkixfn+ExU3cQoPWj2DiXAIoOGGYaJ+XxtAXYY8vuW/YSu+O517pMY/dr9xN3ux5EMg9fvokYiQbhbZ9TohJmf6dx5fuul+Ok5DvJ5P9RaQCk4MO4HXmdu/PCCXKi3nubjXFLJAeGod9KmKPONdBb9zYhRql8a4oNvB2czBlr1pnSwoNhZiLbPPcCyck2dMe8t/08qfRGSSaNkEC27gfayCFdCGWW8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5XDkrmTrmwLfgc8QGPzKhcXE/R05iaR/IWvD6t6Hh0=;
 b=Y/usIBym6yoh2hRgaa2WWvupDXf+SoXpHiAp9L22dXp/UgwPue7X3SeVZBwqevteyRyzzlW11Se3rGclAKJN3fqhy8ix0CufvxLyklSHQVsc9pSwtvjXr64dloc6nsxe7xfQj/9VfIteQ51m/cSsiKhz4fCN8HPerjOT8S0oaC8=
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by SN4PR0201MB3534.namprd02.prod.outlook.com (2603:10b6:803:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 12:47:44 +0000
Received: from BN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::d0) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 12:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT023.mail.protection.outlook.com (10.13.2.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 12:47:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 14 Apr 2022 05:47:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 14 Apr 2022 05:47:42 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.254.241.50] (port=41198)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1neysw-000A4m-KX; Thu, 14 Apr 2022 05:47:42 -0700
Message-ID: <3a16e5fc-e1a8-4a6c-d0bf-244376fae168@xilinx.com>
Date:   Thu, 14 Apr 2022 14:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 3/3] dt-bindings: PCI: xilinx-cpm: Change reg property
 order
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
References: <20220414092252.12174-1-bharat.kumar.gogada@xilinx.com>
 <20220414092252.12174-4-bharat.kumar.gogada@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220414092252.12174-4-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a90f18dc-d7b0-40f7-a89d-08da1e14f84d
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3534:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35340FC6DCA956EFC85D8950C6EF9@SN4PR0201MB3534.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iG8EEv/BI8OeuvOrWqZWU5Dps+sAf/FzDPGa7MPEudixSXXU5KUePa1OXXqdxnacoV712O0IqgeQgxsL7sEQBZk9G9OQkRMuuHzCihk5ubzFVsJIO+uL2DDhYDmpC7261354CqJ3+OBInmmJEVGXrJlxExQm/2dkqh0QShCsapIpyZYeqATEGcJQj/5nOZ0ccZ2jNcFYDS1d0n8+MDBFoB57XfRZm6esRENfWlpO3FaJgf+V3Mq9zUEVLD+BovDGQF6LVGDYoa7MbIk/nCpiV/qyRoB+ZOxO/4c9rXQzBBPvGi+g6cdl2ul0ulEWclTT7PpiyyEHhhbbLOkvvDP2dY95M8K4/58bvD5NhjZuy7DLnWNXv4kVv9r0KzfOxCrGbuaHnYjC5LthM6lVCBCE4dAxTCpPwQLCGX/OLJOKj6RrCn11S/7efs0+elYCwH38fX1S2nzLe3GcblFamoHtdSoYRRDvrmgpt/SPdbdnc0zKesqB2qo1wYg73b0MZgRutYWuhrYa8fKazMBqL48yDOcgVSsAU1MX9FpoKSWEUMktJ7ttZyJjKwu5ErgA6E50oHLkJ0ehlrIFMrXWBDn0gr9/bEsrVofHILEXyXTk7gC019pFlaDk1oK735RWr9JZD/a4K+9Ek4rPs1LAvNsflWAK0+k9cEsC8tjzRL7+bdGpaiwEhhvwI/jhm1VqWjjyURJSKurkhV+fdsupYhNGI8ZGfJcUWyc/WTHQciwQNaA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(31696002)(186003)(5660300002)(356005)(2616005)(44832011)(83380400001)(8936002)(9786002)(36860700001)(31686004)(7636003)(47076005)(8676002)(70586007)(70206006)(4326008)(36756003)(426003)(336012)(82310400005)(508600001)(316002)(40460700003)(53546011)(54906003)(110136005)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 12:47:43.9114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90f18dc-d7b0-40f7-a89d-08da1e14f84d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT023.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3534
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
> Describe cpm reg property name before cfg reg property to align with
> node name.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>   .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> index 4ebcc838a1f6..a3bc6ed9cf95 100644
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


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
