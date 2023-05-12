Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001767000DA
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 08:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjELGu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 02:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbjELGuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 02:50:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD850A5DA;
        Thu, 11 May 2023 23:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWmIQB5puVO0eEShcqPG97tJU+7uDPXE4MHOojOpz8gJMePUpg3b9ZxeCHSEadXq1Ip1ZzDoxsqXr3ElWRBNMY2V4V08/Bn7+qaMHt8kE9wT6FU9BhAJcrqyun8oMI1hxMh2sG3kQc3COSWj58bw1eulF6sjGrCl30YoeioGe7FikoCUPJRx7aIB0R8wW9Vc4S0MUhULdj3GkzeUJzMNTD17P18CEwLhpwjFXgbsHX2lx6OoaJpgRJSLp44IKIugewXp/Y2e2TvqXfz6TG/jnOLl+zzL4TyyvfleOqSJY0p5PVMuw+g3k29acCLetuThOEhWC/hRS1DQXkz+vARobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4pEQG4V1OrpGFDwCPPIzg/NbjzcrIsfMgNcTFcn9jI=;
 b=OGq/EKZqJNnizo15wBOO0+G6zm3iIyLEX9zWkVxvoCQ72ZFm5rbiFzR0yAG/Fy90f7TRdTt42m9wm08iqfGQibb5ck5Q5/l/oHDR0p7ajygnEavIZ58Ukqg/u4m+lzEhdxtMDmb7F3Q0muaB4nltmaAQIaJRh5sR2FuaWy/yhj8QIM/H7xjxyFsHfOLF+RqJqSnxs4Pv0Tej4pcQB89maTaHcZ6YEEbF7Ddj3dRTt/TO1ooNnvISfqP3t6z/xQHRDFfWD9ZNkpqa+y09nnO2t1GmTEJmHO54F8Q2ZBCO5Bv5HNk6oH+LzFKwE3baTQPUQacryou57e3xap/nQBDqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4pEQG4V1OrpGFDwCPPIzg/NbjzcrIsfMgNcTFcn9jI=;
 b=NAJhx8jJw+aFaiUjLVLEdd8xk/as7xLDR5JHtgHwkmIcXkyiKQE8ErBJq+dFTTruXS8lRIbzAPwMd+MFZGd5vIHPAGG4B7G/ELzRBhzZa+dPxtOEoIgQSLhUhPXF+SI6dFcFDwwg5//uSb9Jtas9665U3Oi493Zo7NwEulG860E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 06:50:20 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 06:50:20 +0000
Message-ID: <fd0188b4-53a1-9a0d-7466-41480000cb84@amd.com>
Date:   Fri, 12 May 2023 08:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com,
        lorenzo.pieralisi@arm.com
References: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
 <20230512062725.1208385-3-thippeswamy.havalige@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230512062725.1208385-3-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0083.eurprd09.prod.outlook.com
 (2603:10a6:802:29::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a48760d-53da-4afb-1c48-08db52b526e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3ktqNZl1Zrsp4UpJmSuyPIuVFaH1v1Jf40gc3JcoX/dQed4aJt+pVHnt8DsdOB+iPjbjicio1AlnJB2aV9rSpCVsbzXxIkUJd4hjDZuuqzoA/4tN8QlPEovqPG2VtcmYVs7gAIM/E+qa3ZuIVRn7bS3aypNUAeFS/eHWd7SBO5tSNKUTMO31WFFIybUr/MqQzhfCea2ipCV9TxwlaaJcTn57bVvvZmY+3pwUINLg9nFxVeD8+rOCBK8xysGnmuFG+MEAKyBcfvDr4oHNVnb6YTl4F24r2JpE/9FFPehEohNa/9HZCV5f/lgaIgODzYvBXi9i7+ZF+y1Dx5Vt1IKs6ZHv62Z2zhYTgHyJBrpGhA5miB7x0C7Km6US/I7vrIiym7pWbNwEmpkeO2exeaiaJrkNgGx0+X0y6nr22gRpZ0XU1Vkg6cSUzRoqdX1iL6LDnHJi9LAjRfXv1fLu4QZTjm6c2YCqzgzb96qw/1jFD0Y5Epth1XvZyZZliiLmr2uwJ+pm9HJRtGeiOUXTeRiN6HpUlI+WvoHHfsXjOjwESXCr7IzOU88Ew40zsRWphNunSaK7EsYJMfEFy+oYkfKJLxdUwKXQzqSK9sD+Pb6w+LyGPwrmjnsSHy6+p9pzXX/TUqYEXekTuAgD/wKT0avhNRL2Y7RM+YO33/LIQmZoWtiGunnG+8lEHKYatLN6TsW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(41300700001)(2906002)(186003)(6506007)(53546011)(6512007)(26005)(5660300002)(38100700002)(44832011)(8936002)(31696002)(31686004)(478600001)(8676002)(36756003)(2616005)(6486002)(6666004)(966005)(86362001)(4326008)(66556008)(66476007)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnYveWtoUUVlekNsV0c5WnpVcUVMdjRPdCtJUWxQUHdma1dIbW5mSHRRcGhn?=
 =?utf-8?B?ZnpTMFdDNnZCVWt1V29hVEdTYXVBY3V0M0FZWnJjM3BYZ09hM215TlZ0VVZs?=
 =?utf-8?B?M25WbjF2RkNQcmlyNkhtcm1aZmN1QzBMMm5id3lqL0FROXkwSjFqT0tLSFBv?=
 =?utf-8?B?dTlCeUYvVTFXR2dyaXJST0RyS3RMKzNGRWNMUWw1eFNMN05xVFdwUzRUTEMz?=
 =?utf-8?B?VFlFK3BMZmt5OTRDWGJydUcwRld0eWJpYUJScWdrcUVyNTlnVElET1dvSGEx?=
 =?utf-8?B?Z1haUG1PYUN0bGpBZXpqV0FwclBYeE03aS9Dblg5SktKYjBQTlRNL3JCR01v?=
 =?utf-8?B?U0ZnWVFZZlhnc1hDOU1yQnhoZXZhUzVHSThnYWVzN2xPU0FlVTE0Mk9PL014?=
 =?utf-8?B?ZmFSWEcrZ3Z2clNFVkhEZVUvYS93VTNoUXZxbHV4MlptVzMvZjFaQUo5dDcr?=
 =?utf-8?B?N1o0b0t2NTNRNHQxQkhkMXZMZVFNcG5xVFlMSHFSTWMwRVA1YjJ3ai9SNFg5?=
 =?utf-8?B?MjZHdUt5aVFsQUlDNzJCZUVrS3lRU3hsT3FrZXJPakFLUFVEK2hZN3FCZDlq?=
 =?utf-8?B?cjAwSW4xNFBYTjN1OVdNWHVMNXRkZ21LNDFVV0R6WHNKT1E2TXlOc0p2WGFt?=
 =?utf-8?B?Qll3NGphUDRJak1LcDYvNjFDU3BiMkZRcmVWaVZFV0gyYlNDeDJTUXhvam1I?=
 =?utf-8?B?QjV5SFhHR29JVWs5bW5jcy9UMW4wSE90UzFPS0lvZmhjTGhBMHFSVHUrUm81?=
 =?utf-8?B?MmptM0VqZnFrcUJvNHVwYm1kU0JISXdCdTVFNTNtbW9DNGMxOVpvM2pDNDN1?=
 =?utf-8?B?aG0yTWRjSVdOUlRET3pCZkZKZ2I3dkZFVFQxZzNEZUF3RGthckpob1BGRW1h?=
 =?utf-8?B?djgrdmM1MlFIclJsc1B1VUxWMUE1VE1KeTFXbk9iVUZvdVJ5Rzdhd01GMnlI?=
 =?utf-8?B?aTFvTzI5N0FJV0wwTXRKeVo5WkVBOHZPN1FobzZYbTU2TEwyQUhsaWRDbmpI?=
 =?utf-8?B?SGpSUm9nekRDbmhDMHVFeFpIQm5NY0VMaFVBaDBLM0lJMkhiTUF2YVRkYUFV?=
 =?utf-8?B?QXR1NVhmcnBqSGZrU2tkcW5ReHFQNjJPMzk1TE5BNDR4Vzh4SEZPcjlzYjBI?=
 =?utf-8?B?ZmxmempYdmJDRFFMYzBvREpSUnV5dTQ0YlZ1WElnUE4zUXRILzVKTnRJc0ZF?=
 =?utf-8?B?MzRlWVZQOVBaamRpeDRrZ2FCSHI4cm44WFlqbHgrNGdZRWJzcGgrdXJUaUh0?=
 =?utf-8?B?cXFIZ3A1NGNZY3RwcnNRVkhsalpiNTJ2Y1hHd25Ob09OU0tWVlVDdWZFd043?=
 =?utf-8?B?a0p3RVRSQUNKQWRQZXJSUnN1OGNqZStqSjdwMDcyWVhFUUdoYWpJbkpSQ2FX?=
 =?utf-8?B?TnI2MWQ0enlYSmNYWUE2Nm9tcDA5WU9leGE3U2dIQW80ckI0bkk1SCs4TUk4?=
 =?utf-8?B?c1dQVHRzbEFoYlByK1N4THNUbWdkM1dQaVhwMDVqcUdLK2V6V1pnU3pGR3dT?=
 =?utf-8?B?MmszeGNVVmZiT3F5NGZuUzhNcU9sNHNjOGhySTgzOUhyc3l2enY2U0ZUWlk5?=
 =?utf-8?B?MHpkUSswT29DeWFwWmZDTTJUd3lpNkJQb3lLVURJZVAzeHNBZ0N0TjIyVk5j?=
 =?utf-8?B?MDhaN3l4RURvYnBUNGV5TWx2RDRDSEJTNXU0L01JTWRzMmJDNzJrYi9qTjN4?=
 =?utf-8?B?QWtXQVJrZUlxV0pkeVB0eWZFd2FjQWpYNUI3ZXhBU3JkSGxMUGUyWW1tRFl3?=
 =?utf-8?B?ZG9xaTNZd1Q3Y3RNTnozZFZndVd5MWRyNTBXTUt3VFE5QTRpWWswazU5ZUxR?=
 =?utf-8?B?S2x2OUF1ZFZTajlHSkJSSlhJNmxaTEFHNkZzY3crTTNDdHNSa0RucFhSd2Jm?=
 =?utf-8?B?Yk8wWG1MbTltOGw5SW5rVS9RaXZKemlVMkdPSkx3RVhXQXVySzU3ZHJkQjhx?=
 =?utf-8?B?NmFtNjlvZ3dwMlBOSFoyc0JTbnQ2UWd3eG9LZll5dVVLajVzUmRKQ0xRUU8y?=
 =?utf-8?B?YzVYR0syWndPTmpzdXJDVnZaWnlLeHQvbWgwWW40WmE0V005ZS9VcVJFY2dY?=
 =?utf-8?B?Skp5ZzM2aE9sUmt2RWxJbUsxelpqb1lMdVNmUW5NR2loSVBzS2Q2aFk1MFVw?=
 =?utf-8?Q?QuJUe9Hh6hqzuO5ieivIFw7M2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a48760d-53da-4afb-1c48-08db52b526e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 06:50:20.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CD2hQ+xarkMnu08ilDx862S+Ps0z1e1mYnNEAbxYH8YJslg0Xbaa3fgIguz8buIv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/12/23 08:27, Thippeswamy Havalige wrote:
> Add YAML dtschemas of Xilinx XDMA Soft IP PCIe Root Port Bridge
> dt binding.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
>   .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 117 +++++++++++++++++++++
>   1 file changed, 117 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> new file mode 100644
> index 0000000..e3a1ef1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/xlnx,xdma-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx XDMA PL PCIe Root Port Bridge
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: xlnx,xdma-host-3.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges:
> +    items:
> +      - description: |
> +          ranges for the PCI memory regions (I/O space region is not
> +          supported by hardware)
> +
> +  interrupts:
> +    items:
> +      - description: interrupt asserted when miscellaneous interrupt is received.
> +      - description: msi0 interrupt asserted when an MSI is received.
> +      - description: msi1 interrupt asserted when an MSI is received.
> +
> +  interrupt-names:
> +    items:
> +      - const: misc
> +      - const: msi0
> +      - const: msi1
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller:
> +    description: identifies the node as an interrupt controller
> +    type: object
> +    properties:
> +      interrupt-controller: true
> +
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - interrupt-controller
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie@a0000000 {
> +            compatible = "xlnx,xdma-host-3.00";

This doesn't match with version listed above.

And when it is fixed I am getting.

/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: 
pcie@a0000000: ranges: [[33554432, 0, 2952790016, 0, 2952790016, 0, 16777216], 
[1124073472, 5, 0, 5, 0, 0, 16777216]] is too long
	From schema: 
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: 
pcie@a0000000: interrupt-map: [[0, 0, 0, 1, 2, 0, 0, 0], [0, 2, 2, 1, 0, 0, 0, 
3], [2, 2, 0, 0, 0, 4, 2, 3]] is too short
	From schema: 
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: 
pcie@a0000000: interrupt-controller:#address-cells:0:0: 0 was expected
	From schema: 
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.example.dtb: 
pcie@a0000000: Unevaluated properties are not allowed ('interrupt-controller' 
was unexpected)
	From schema: 
/home/monstr/data/disk/linux/Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml



> +            reg = <0x0 0xa0000000 0x0 0x10000000>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            device_type = "pci";
> +            interrupt-parent = <&gic>;
> +            interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "misc", "msi0", "msi1";
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> +                            <0 0 0 2 &pcie_intc_0 1>,
> +                            <0 0 0 3 &pcie_intc_0 2>,
> +                            <0 0 0 4 &pcie_intc_0 3>;
> +            ranges = <0x2000000 0x0 0xb0000000 0x0 0xb0000000 0x0 0x1000000>,
> +                     <0x43000000 0x5 0x0 0x5 0x0 0x0 0x1000000>;
> +            pcie_intc_0: interrupt-controller {
> +                #address-cells = <2>;
> +                #interrupt-cells = <1>;
> +                interrupt-controller ;

space is not necessary.

> +            };
> +        };
> +    };

M
