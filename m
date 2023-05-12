Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DCD7000CE
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 08:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbjELGqR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 02:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbjELGqP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 02:46:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC13AA9;
        Thu, 11 May 2023 23:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4+hyeb7Zf3pfANFMXsF8oKCgC95OYRB2d9hGv56OY8kvfot3zRwdXnV1hkggBS0Qw3UiRmB1mBYYpK4UO/ucxZfSvpInmvCQ8vCc0FCsHh5OanZ3fjYpNzvIQTIqt7++E4zqsK8lSOCtHw4NT3QPEIhEXMbLr5Nk5czGHC6o06odVzoDm0dvelR0OMju/QkNNeiFwhtp/h+d6uqKdcesxE0FiDp2IQNB1qWMmQoggqUpBVpKnpWA6gmSwppZWldJYqbEg1Ti4cvGt4bo3OcKBkJwYLsnBdJvciDO+r4+tBh8f7cPUQZ3hTKlm7LXpqQID8SNcYcfboG3XYUBSfrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ORO4MqjS/SxsZvrzEWyfxWtage8R/7ZMvlY3eiug0I=;
 b=EHGtL22LQI1knU4VQdUyIxu0/cOH0YNFHS4ZOyBlBAAc2OKHrBHM+ZGq3B1SijiY7rNcchU5ucKwFNwQMr+qpZALvLf5mQsmGsE7qsHbVmpqGlpqC2PZWztRxkn91QDgrwPN10+3oSR7ZD8dPZzNM5iqhgS7iXg0sZq6vCk8sNhwr4YZHvqN4OsMuC4ZE+0SQylt0WvcmaASDsi0beu6kN2dQjMV4q1XvePf3XtjGzzJVmYtUKKrgrCicCMFLNw0IIoQx7aQxTaNkivKPZNJdr9rJwlAnitEHSWfmfmlxxE4s3FMqkwVWCXwYRqWO7/bvRs4hY4ltCELguAux3pBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ORO4MqjS/SxsZvrzEWyfxWtage8R/7ZMvlY3eiug0I=;
 b=xSep/i6xWJgXP6WzVJMyq6/1WLPeIcW5DbZHjPy5OuI5I3ACQPk2IeZRqHB7BrIAhwdORGHX8bEjrbjGY36iEwVok5i8AoyJds8zfwV9yQsnXK9Gh0wpJ+aA5fLSn5tVoVeqZi2rHPmN4fh9mqXzctbBj+9CFflJe0kNbicSbic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH0PR12MB5347.namprd12.prod.outlook.com (2603:10b6:610:d6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 06:46:07 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 06:46:07 +0000
Message-ID: <403a6de0-2829-c4e9-cf0d-40823e07e817@amd.com>
Date:   Fri, 12 May 2023 08:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/3] Move error interrupt bits to a common header.
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        nagaradhesh.yeleswarapu@amd.com, bharat.kumar.gogada@amd.com,
        lorenzo.pieralisi@arm.com
References: <20230512062725.1208385-1-thippeswamy.havalige@amd.com>
 <20230512062725.1208385-2-thippeswamy.havalige@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230512062725.1208385-2-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0265.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::38) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH0PR12MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 00341930-2a08-410a-6d7e-08db52b49061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhKmJBPD/gy645VeJWC7K7uvfvWihIupsQrPPkedkPci2PIN2GjU4WFZa/8ZK1sNSig7JXdWjd4GsQLk2nrNWwea3wg9LRa98DA/RvowpbagIOIdwKuj8W0Ix4BMdY3sZY3iR9lKMVaUrwBHeB2zVphBDWrFAaUmj4PE41cGRSKv5URX3BMdud6aq45RnfQriv2ju1QeOeWnQ1CqNrmZVMvSclrouLOEyYs14KD0YkUZetvS8wZ+9+cSz3+LIW5A05RRZJ+A9Nozn0gPELKqu18/JGSKkX9V0vQxZGlLOyyylYsvky2AXCUUC3K08baVoNshCcUdd9e+gibBpcOsigxlcTpCNqT5puMNWvutvQexWeYZwIlEoHNC17KDc7WdZWL3YJ+HZ45+d/7QbCR1Go5bOcxMPTH736n/rQtd7rFnJdKMPpyloS4bQl9ff14aSIg+8VyLRi9g3X6i7WaPmhaL2xmG64bRgIN7HXYXxIkffo8N+sV3c29rLjsO+LQabERoeoFuUFaWMtI/hP3djmsxQArRt1s+d6fNrWFOP2z0U3xxOsPvYMnJeIOUHg5R/xWZ3Tw3JMTD6xhWEdeCdpA55yYswqoX3vTNl4btP0PzIIIpn06xlrvGpo+gqRUJcJ5lGGyEIl/qLgREUC9TVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(41300700001)(2906002)(4744005)(186003)(6506007)(53546011)(6512007)(26005)(5660300002)(38100700002)(44832011)(8936002)(31696002)(31686004)(478600001)(83380400001)(8676002)(36756003)(2616005)(6486002)(6666004)(86362001)(4326008)(66556008)(66476007)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1QNGxudk56eW9TeDJ6S09YekUxbEMvUUV1NGw3VUFWMWVNcExKQzNMQVVu?=
 =?utf-8?B?VXN5a05abklxTlNBcFF4TjVoSkZFNyswdVc4T05rZUQrYzk0UitrbVozVHNj?=
 =?utf-8?B?aU5lcTNOWk5qVWxuekFWWk8xai9VY3lBZEtKekNPL2xaWHdTS3FSR3YwY3hG?=
 =?utf-8?B?SnJoWnBsUDdpd0JNNjJtQUhHaHUzajV4cXBoMDJ3M2VpOGlWRXRkWmFaUWhr?=
 =?utf-8?B?aHYvRHZxaEROTVdwSUVIcmZLK2RRNTBBZy9iWHUrNGdGTVdDdk00WlJEbkIw?=
 =?utf-8?B?bEZXcE9xWWdGanRYYmNnTUxldXFMNGxzTG1maWU4TU04dnZ4WllZaVNCRHp0?=
 =?utf-8?B?eU0wS0ZTQW9tUmwvcVNuMzNvaHRheEQ0dTlKcE4zTXovNlVkNGp6MS90b1ZT?=
 =?utf-8?B?dk1ENGhXZFY5OXVMUElZTXhsNHRCOUt4WURhU2tMMk42d3hIYTRFVTk0U2RZ?=
 =?utf-8?B?RHIrdWNJSTdmVjFoZGR6MWRBdHBTSnREZTg0NUFjcTlpTFVYK25id0tIN0RL?=
 =?utf-8?B?a0x2Vlp4aXMyVU1tblQzNG1qWS9HRGpYeTgybzYzbnFncXlXZ01zTGp1OXBp?=
 =?utf-8?B?bmF0bHc3Y0V6cGJtNnpNNWxOWEFmcCtkbE5Jb2RpQkozV3BFcU1oczZCbnBr?=
 =?utf-8?B?OVBuSjVqdjZjb29uV3lDSXNIdjVOWUVIOTFWNDE4a1doUzhlbmNsVWY0Z2Ex?=
 =?utf-8?B?RUhHOU12OFlxdFNuQjFKb0hvMEtTd2FHTXdZdVhQNUZmNVZWbkROMVNHczlT?=
 =?utf-8?B?L3MzMjlMZlNQSkhKZmxHcnE1dG1RR1RtWDBDRVpST294bmVYekpzcmlBVXRq?=
 =?utf-8?B?c0ZISkxSbk51dEpnMndWVWZHbU5ESmdJcXVyTlIyNGR5eDIzMHJyS3FLcnNT?=
 =?utf-8?B?MmRINkMvaHF4cHVUTmlQSHJLVVh4RGxDUTJiU244K3EvM1lqNnZpSkduei80?=
 =?utf-8?B?c3l0YVpMaFk0ZWRTWVFXczFIL2pEODl1N0xsS2lIMkJ5QTBieUVTMUttekxV?=
 =?utf-8?B?Y29mRlpFa054SzBiQlhMZzNWRjM3ci9qcWc5Z2xhRjY3aVF4RElxNlAzc1p4?=
 =?utf-8?B?dFQ4NFpuUGRmOVZuZWRxTzF0b0NvdExrbHNMVmRmaVpaOXl0ZCtDMTV6Wjhi?=
 =?utf-8?B?UXZ4b3hVODhjK1NlZGhWd1FpV2pJMWpRVVd5L203UFNqeUtkeEFQNktob3k4?=
 =?utf-8?B?dDNlbTIrWnBqaVY2dVJRZFdFNXpPWXVsS0Y2NkdibEhVY1RHVmVPc0pmMHFX?=
 =?utf-8?B?RTNONjF2alNWMEhTdXF4THR6b2l4djRNQWRaNEhmakV1ZHhtd1V4Rkhtbyt4?=
 =?utf-8?B?M0o2Z2VCV3ArNFF0UVhHYUpYbG1lTjljd3Jxc3hrdUxRbkJ6ZFJKUUpzaUJt?=
 =?utf-8?B?d3JmL3VTcGlKaFJOOThyMlFIanV4V3dYS2ZSZDlMend2V0dRK09IOGQxWHhy?=
 =?utf-8?B?V1Y1YTdwL3lSTkJucGI3K0M5N3FjUEJlMnV3YjVTdDNYb2FOTjJBeXNveFR2?=
 =?utf-8?B?ajJLV2VZVStuNEcyRHdjL2laVTc2NVRxODl0MU5iSXRQRjVYQlVEV3JveVZR?=
 =?utf-8?B?S2ZnNFlhWC8xSzhOTDZBMmx1N0dQbWp5SkN4dllPYXdTMnVFUlZsR0xLeUlF?=
 =?utf-8?B?WklSdVVnc2NWMkVjVjlqalZGWnAvNjhqTUpHQWc3ZjF1S0d1MGloTEJSTnB4?=
 =?utf-8?B?T29QY1MrSks4VFJOVkVaUGpIcG1SZUN2bm8vNWo3OW1SdlpHcVNGRy9qOGRR?=
 =?utf-8?B?cVhqRHY2WHFDUGVTWHdrZDdyb1lkT1JqbzNhUFNtdzY4VDJ6Nkt6STIrWlZS?=
 =?utf-8?B?RkJ5Y1p0K1BnOVBuOXVFQzRYN0RPZHk4ZmduNTdNOW1ISVYyRXJtdFMraTg2?=
 =?utf-8?B?SjB2MXdRSjFIeGdJeWtkelFXK1hKUm1FZ0NrdG51QklVRWlPeDYxckIrZzQr?=
 =?utf-8?B?SW9MUFBITlNRMDFybVNMWit5TmVEQUh1Uzd5UnMwNVdjOFlpU3RyeWY5TGQ0?=
 =?utf-8?B?clowdGhBa2h2WldseHpiK2k4SVJxK1lDN09WT2VLaW15RTFFSHBDbjJqQ0Q4?=
 =?utf-8?B?ZEJqMjd0VXkza2hsa2dlbWRaMkVFVnRDdDdBY0Q4bmpvV1ZJTnMyZW5UTmJR?=
 =?utf-8?Q?ZuoEtzFmOf9/fTlixEQR+vUBX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00341930-2a08-410a-6d7e-08db52b49061
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 06:46:07.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW07BxLr0G/C8k2QQ5oIs+N3MIxrPs/R7bu7bjmV0A3xCMJFq5jYO7bVuE9qt4a+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5347
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/12/23 08:27, Thippeswamy Havalige wrote:
> Moving error interrupt bit macros to a common header file for code
> reusability.

The patch below does more things then just what you described.
You also rename them.

> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
>   drivers/pci/controller/pcie-xilinx-common.h | 30 +++++++++++++++++++++++
>   drivers/pci/controller/pcie-xilinx-cpm.c    | 38 ++++++-----------------------
>   2 files changed, 37 insertions(+), 31 deletions(-)
>   create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-common.h b/drivers/pci/controller/pcie-xilinx-common.h
> new file mode 100644
> index 0000000..015dba3
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-common.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) Copyright 2019 - 2020, Xilinx, Inc.

And we are at 2023 now.

M
