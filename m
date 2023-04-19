Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29346E7442
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 09:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjDSHqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 03:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjDSHp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 03:45:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4A93FC;
        Wed, 19 Apr 2023 00:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGk43GGboLX7vqVCuIt3u+Dl61tUj9VlyR3VP95uJHm6T3qDzcueOxmu3DdgsKDj/0GPFgRDdIrsPnLwKi79JMO4tmVGCGDhFBBHNb9IHrDC90HjwaOmm4jZVPu3ynhSBKaX/mI/AOMyOM/LlmmPjwQs1oTApLmOqBIxS213gfiw7x01SqNFAHoxP3Vj0UH2Hnpfa+n+0hlkt2xbbIjKZTvoQW9pmwxCGTYYov54zZ522d6Kkez4gzqWkULfbkDr/3+I/zUBJ60Jy6qvculpXq+yuSGtSOF1KihMBYCLC8KrN4fMQxVXn78R08/THZKwBn7qPkxQ49UHrr2snBoLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxmDrK0UVuNZspei30uU+2MRSYgxMkF2yTKzB/gmACs=;
 b=MrU0C6hXStAqyXtxF3DKgc1A5JUtHmwVNUa9xcMuLQqpUdJvkCE7LyQj4e8giYMkyOrmjwUL7hNaQSz91kValQmhQJDqtWVFgrQU70h3ZAO8DwjvVOusyl7Jv5IpgCjkfJwui9H2WMwNkX4sIpOBdL9uEMmpIVc+7wVDyLAmuMFW/muE+3WLg0+N/s2Lv1zIhO7mKX6CEb/htANuqXM3o2NwoBWZzGABq00XyRMCp/juRu7EGKF+V6GiOdwDiiHQ6QISm680KivFOCX/wBomiEmzuPjCc7z33g7mNaG6NU14Xdw8eo+MNj90mNPlTNYVAF710gTD5xcQZmHnjPI4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxmDrK0UVuNZspei30uU+2MRSYgxMkF2yTKzB/gmACs=;
 b=ocXh4mwr96ubdGfg5yRHI4OthmHocI5M14VDsvPJw3JWACNGrEKi/ZhKSh9aVtjPsI9/OeejABuq5kOZnlGvrrGRr2UOfEiZLm3znWOjiNghC4SAu6Q3v4aaXHCIRdPxCSKB1Impj4BR+p1vuRkf1CYJXmRs7b8nLkEXENdr5sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 07:45:09 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611%2]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 07:45:09 +0000
Message-ID: <0e3d9536-03a1-3b2d-9f02-1b90abf5e890@amd.com>
Date:   Wed, 19 Apr 2023 09:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] PCI: xilinx-nwl: Add 'Xilinx' to Kconfig prompt
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20230418174336.145585-1-helgaas@kernel.org>
 <20230418174336.145585-4-helgaas@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230418174336.145585-4-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: a00c55e8-1e42-402d-0436-08db40a9ffce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKe8Bu7REXtAL7mxUgjJv1TmhDiLtXZJymXy6OL2NugEeS36oJ7kh1y+iPeAmoJUs4Bw/FRBfvEsmJWM++tOxfW73HbVGK2FMTXGCa0VGsFd5p+XowP+8Vg00NPLUv+fzAolCWVHHA6LpcQ1+CFgl5HkmgAgVOshvYyij9A09Xq+oQxIC2PyZp/ElTgfTmYo4q8Oq1Woh0bAE1DbH4c/oWsFDtt3b+3//cj+i0utrpCBJ/DX2xR9YXCb14/ENhUAp/sIbs6Wi3Z5s4vpnWaqSS9/THvuSGZkHBwFjn9/O5WRsw7ZBnkOL1GncLfvMORxI7LFwa4dUAA6yHW2OMSTVgoUZOVbzNcWYnnKMjOXIGmKidwnadzNzPfflqiDZHLfJt7ALCK6mhWHAqiOsqqaFdCKUAoOf+lv0l+qJrq1PYtOaHqgUhICtLi5EOo4U/YkljPSwwE35jsd35J6dck1z5FkoTYtW5asVJ3XS28HjWNx8yTcapO95FEVBHg2A4MbgYSq014Kx/P1JwfsVEomsalum3GRXngyCDR26Azg3c1i8muVZPhqPMTmso3r7tGhlq103UufS8yqRvSeAaLJQ3aeb5sU27hjWlOQMkFkzID3yxn5TBkupn6/ZNRQW5ppOjGQG2xZmijBL+thGaQn1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(54906003)(36756003)(31696002)(86362001)(478600001)(41300700001)(8936002)(8676002)(38100700002)(44832011)(5660300002)(4744005)(2906002)(66476007)(66556008)(66946007)(4326008)(316002)(53546011)(6506007)(6512007)(83380400001)(26005)(186003)(6666004)(6486002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJDMWpaMU5ZOUtUTkhmN2xmQ3c1OUlyaVdFeXhUeVd0OVE4bnFnaisrS2Vi?=
 =?utf-8?B?UDJwZjNLTVdOSkZ2WlNyRk5ONzBDblovMzBVZzJpaE5HZGVHOWpzelVJaVh1?=
 =?utf-8?B?cEpZUjFrQXQzbnJrMEtQVXdlUkIwMEdkdWtqc3VnTlNERTFnUHRuaStvWlNG?=
 =?utf-8?B?ak03bWVMaHBBMEpsMG1BR2wvU3g4Rm1zSEtjdnozcy9PYXo0NGxmcytpN3NB?=
 =?utf-8?B?a0lsTW1oamdBdFlOTmRZNDl6ZVN4RkxsRkU3QkZmUTB1Wk9CaEV3WGlQeFE2?=
 =?utf-8?B?QzJTYWJnTWNZL3ZHM0VUK291ZFoyWWE5SDBEMEoxYjIrTlZnNVI4UEpaOVhz?=
 =?utf-8?B?TGs5dVIyUEJkOFplRCtpTVgrYi9wcUFoS1hQdk1mN1JrWjlKTU9pSlliT2JD?=
 =?utf-8?B?elk4MEU5ZXBLR29idis5UGZaZXpIMjUxL2c4UUlKa1hkQTRpSTV6VnhpRGNw?=
 =?utf-8?B?Yzc2VndaVTkxS1IwbThDa0F1NXlxQUV5bDVGajNoQ0o1eHQ1NS94R3FzZ2VB?=
 =?utf-8?B?K1lZQXJ2TU91Z0ZzdkRlOVBEUGFueXQzaiszQlppUkdqS2I4RFlSQm8xYmVp?=
 =?utf-8?B?VUoxYlh3dy9jeU5vc3grN3lUcDJNWGY1cWQvWmNaaURQbkgrRFpxWWNBemhL?=
 =?utf-8?B?OU1FT2pSYmpRQWk0U2plY1psNkd1a0p0ZWM5TWMxcGx3dWhBN3N2VTRIaWhH?=
 =?utf-8?B?TXBzOXpDaS9uZHpzQ0w0VHllWGsvN0FaVUxiS2tTRXRRQTg1VVY0amN3cXNm?=
 =?utf-8?B?c3ZmTk9ub1V4UWt6cDBBSnlvMG5nd0VvbWpaZCsyQlFEVWZuMWcvTTV5c3dR?=
 =?utf-8?B?ZVNsLzJsUmJUZVUvOW94MTBUNkJBb3J3ZEt2U3NTdWYyb2JHSmdxaDkwTHQ0?=
 =?utf-8?B?Yno5OG9jY1YyWWxJdmR0Q0JKSW9kTE0zamd5YnJDcmkyRGkzN0JoRXl6YUk2?=
 =?utf-8?B?UlBFaU1kMm9HU04weWM2K0ZzTTNOVm5zTDk1OEVlVmZSd29zRERrY0NmNW1m?=
 =?utf-8?B?V0JqajlNRmhGYWlVUDBtclZteUh6QnUycG44UEZ5L0hqRTNLTnB0bGUzQUhG?=
 =?utf-8?B?dndYR0k5VDI0aVVZSkNtZExKdFM5ZWdZVXJjUzB3emVxeTNUcHVkTUcwUnhM?=
 =?utf-8?B?cEZORXlpLzdBTitaay9jNzA3WWV5djRtQVR1WnFUMGFTekZnY3FzY0J6TFRw?=
 =?utf-8?B?d0hNYU5MbFZvcTVSVU1XTHp0QXZHTzRDN3dFbjRVcFRQWnpIakJNWEc5c0Jz?=
 =?utf-8?B?NGtFeVF5Mjd5TUlndGNLTjZ3NWh1RzRteVRrdUhvWDA0OW1pT1JNTG9ROFpX?=
 =?utf-8?B?OE1CMXBsVXE2dENQWkZLWldkUzZ3emh1eE9BRDcyRFY0YjA4bmNoNFg0U0NO?=
 =?utf-8?B?L3FIQ1FZY2NyM0o1OHlzR2liNWFwcG9DNk1MaElUK2toSkgrcHo4RmpRNDJk?=
 =?utf-8?B?M0I1dlQwVWUvM3BtR0hsbG9Lbzc0THplWmVWb3U0Qmc5bWVRMU5vZEc1cml6?=
 =?utf-8?B?L2R4dlYxY1Zza2NxWnRwTXh4eUFFWXFJbUdPdms4VGJ0ZDJYT0lWZVBiSlh5?=
 =?utf-8?B?a0MrR2RTM3U5WE01OWhjckE4VkZISWQ3Zlg1YnVyYXc0NFNub0syNDJGcm5C?=
 =?utf-8?B?SnN1ZGNvc2VqajhPL0ppV25jRWpsdUtDb1BOeElJWEFLYzVoMU1sNUJubGgw?=
 =?utf-8?B?VnlydURZOFl6V2h5cUlmVzNicnlGVk91aXNtczZUc2dMOUovb1BvdlZzdHFS?=
 =?utf-8?B?Q1c0VWZrYnJiaXV6R3NyZHNSOUVxMUQwUnJIUTlJV1ROckNBWk5NaE9tRC9I?=
 =?utf-8?B?bXZMWHZMay90YVNuN1ZoSzN5cU9LMEVVSDU0c25tQ1QzY2VTamF3QzhGMTF3?=
 =?utf-8?B?ZGxrbHRqS0pjd01FV1FGdzhoNjgvZ3dERkJWbWk5N2Q4OHJYdW1Wa0lycndo?=
 =?utf-8?B?bWxvOHRwR2tsbmt4S3hqYVpVMjZwS2d3R3E3MWM2VEhQYmNWVGF1aUVoVk1Q?=
 =?utf-8?B?b3FIMXpDTmN2cCtJTmQzS1hFYjRVdkhuaGh0cHoyYnZNZnNtTjY0cFZMUm91?=
 =?utf-8?B?OVdjK3NnN1E1WGp2RzNGVXFsdG9wRHRhQmpZYnJhMy9TdDRKaEdDNm02MlZx?=
 =?utf-8?Q?aLOj7p9eiXeg24QwmiH4xThhe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c55e8-1e42-402d-0436-08db40a9ffce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 07:45:09.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpiVb5U488M3rMykMQ6zFUKilx0dTtISD2Oyl7uzRTB5UHsQdXuL9tIZPfDKjbOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/18/23 19:43, Bjorn Helgaas wrote:
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add the "Xilinx" vendor name to the CONFIG_PCIE_XILINX_NWL Kconfig prompt
> so it matches other drivers.  Rename from "PCIe Core" to "PCIe controller".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>   drivers/pci/controller/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 8b1f9a3f83ea..5875587d8b59 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -28,7 +28,7 @@ config PCI_AARDVARK
>           3700 SoC.
> 
>   config PCIE_XILINX_NWL
> -       bool "NWL PCIe Core"
> +       bool "Xilinx NWL PCIe controller"
>          depends on ARCH_ZYNQMP || COMPILE_TEST
>          depends on PCI_MSI
>          help
> --
> 2.25.1
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
