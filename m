Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C85282F8
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 13:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiEPLRq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 07:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEPLRn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 07:17:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6533349;
        Mon, 16 May 2022 04:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IINLxNaCdZJ+g9+cUmnRuIkzkCpc2QBBPp5S2RnDb27JQBNdH0y0gWvO6Q3sQbptYsVpaEDNoYjLlqhmzGW5nCoXMiwsuDWdYZd8TQ9JnPcHy4iKdXcGW0sjA4WNteMsHAFFH7y8DCzcjb0KUtx+K7x90YFF4YOxEVDdZxyKfodNww06hxssxgf/6y3PBlFZjCQh6hfx/vQX1wJlQKknZKW3jgDIilDXbx/leSeh1VPvBOnYGj5b29mZ2UTJG+IMr9XtS+LAbsqVvLf5P565BJL7YWjLoZ+rt7Em36ujZ0hUares1tXJ3aCpzUmJ/9o0o7vvz2OzXgHQl654JBWgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1RxZjtQrJIJxiGB72D5VVVYWIa+cW7bPcYynWO/LkQ=;
 b=TvUzEQ8IALR2mHwcSLmYpj3fA51ORm/pNPS8nXdjejVEUqejZ/K116+az8gJnHTK97gTfg3TZxTEaemggRqUQ1tUI93smsDGc3NPvYza1jlkaZoTofy6zuOWhKn5zdz0qkZNgEWOIO1zL8YxHIIZWPL+1HfP8g3yJ9HX6gHuklhVM6AqbAyJswIyRUhaTW1C/ldULIqVfBNfdV9OkyOtXMHN16I/753m/O9+UVchRMS//f+B7DCTi9DvXYhBhKRKD/4i4X7GdMW3p9vW3rhydYX/LkJilUsAiCtLP9kmz3W7LY+HTDZjZ+p1bqXURURpgz1m8Lx8zt8cD5Lor2UfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1RxZjtQrJIJxiGB72D5VVVYWIa+cW7bPcYynWO/LkQ=;
 b=FjIwfGaQrsO6HxrfdHE+8xrx9Ntpz5PUfDP6no0MKzMUNYCLvoeaKBBg7Wn4EAFg/DNuEpN493Q+KXwdbSSMsZHqlu+45q3GaM54DbZm0euZ9S8ZsqDmflq29X1LDbw3A7z4B6+//ALVmRvHHDTkEmYY290qv2pYOHNb6Px6v0U=
Received: from BN9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::21)
 by BYAPR02MB5445.namprd02.prod.outlook.com (2603:10b6:a03:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 11:17:39 +0000
Received: from BN1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::57) by BN9P221CA0027.outlook.office365.com
 (2603:10b6:408:10a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16 via Frontend
 Transport; Mon, 16 May 2022 11:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT056.mail.protection.outlook.com (10.13.2.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 11:17:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 May 2022 04:17:37 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 May 2022 04:17:37 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 robh@kernel.org
Received: from [10.254.241.50] (port=33330)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nqYjJ-0001at-LO; Mon, 16 May 2022 04:17:37 -0700
Message-ID: <b9c36db0-fb4f-19d2-68af-25b926cd33b0@xilinx.com>
Date:   Mon, 16 May 2022 13:17:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Content-Language: en-US
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>
References: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b928f034-a8b9-4764-3eaf-08da372daf9f
X-MS-TrafficTypeDiagnostic: BYAPR02MB5445:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB54455D5623F95ADD42571E21C6CF9@BYAPR02MB5445.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgTuSBZ3kATRnXJXVqcdwcbli39TlQ6sxxtyh9jbfANcY0rT5BxTeuMXhLJzh8cpOIhnA9yctTCU5Jzarc1WgWNn5ttluMPZsD/rn9zyKGsD7zB3bbHAzYKCbdvomcQHsHONFdKw8oMvc7AeQidgioIFFFUcXiIRDaq1VqAxW0e+tt3HllauhF08oivjFd5JYZiuADpZmBxdz+ISmF99GtElH+ymPka1Ih6s6n5nKv4KwNupZtkLCLufYxdrlWshRsGylmxQQnvxuHQEnKoIqmqls1Qj0ehC+1evHDE0UV0q49zWbrd7OC1sPkD6GwGDgEpmymDjmnXfZgT4hJ3FwUj8OnOOQSTfvuMuVtGDkHPJDLAnv98QVCn5MkfCAlB1xeIE4nAQZWkDHE4v6IfmROYnuATSjxcLKB6oLTrDv6dN2qPN9wE8CwdRCHBVN/5pZ4Zf/iT12SKdQvmthiwsQsKqZrlDh7hhzaPhHwRgHtrjfLCv9dCbulFVQ5f9H3LaTq3EzfmBDlGG3hYrcpAWMMQe+7r871w5vYHLOjaKf5SnC1f7uldpbSAWq0+xOvl9AeMexMZQbOxevjhB+I87hiKqeq+DPc70cZ2k9ojz4m7n5oYtPzVwAJAhCYyLl7CGsGHzvchaWHdtj+fCXXzwTkm0zZwEWPOrjWNaSxPBv5jS7w4XWXEoZ8kMWT/RMfzOkZhzawSqs855rsS4MzqR95ZWIbm9Ip3KvHNt/+4Bi/w=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7636003)(26005)(356005)(186003)(9786002)(316002)(44832011)(53546011)(110136005)(36860700001)(2906002)(8936002)(54906003)(83380400001)(47076005)(40460700003)(82310400005)(508600001)(36756003)(70206006)(70586007)(426003)(31686004)(5660300002)(4326008)(31696002)(2616005)(8676002)(336012)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 11:17:38.4601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b928f034-a8b9-4764-3eaf-08da372daf9f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5445
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/16/22 12:22, Bharat Kumar Gogada wrote:
> All existing vendor DTSes are using "cpm_slcr" reg followed by "cfg" reg.
> 
> This order is also suggested by node name which is pcie@fca10000 which
> suggests that cpm_slcr register should be the first.
> 
> Driver itself is using devm_platform_ioremap_resource_byname() for both
> names that's why there is no functional change even on description which
> are using current order.
> 
> But still prefer to change order to cover currently used description.
> Fixes: e22fadb1d014 ("PCI: xilinx-cpm: Add YAML schemas for Versal CPM Root Port")
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

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
