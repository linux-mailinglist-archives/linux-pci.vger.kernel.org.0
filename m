Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3B4DD334
	for <lists+linux-pci@lfdr.de>; Fri, 18 Mar 2022 03:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiCRCop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 22:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiCRCoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 22:44:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367618B267;
        Thu, 17 Mar 2022 19:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njquApr+SOX5L6A6GUzDUV0cew/nV7fDAYropWHd/wPsOVMPe71cBo2pzurQEN9hcOZRQiHkJYMHYgDdnG18cVZdvaAWFH5xE+HX35Qskvbp+fKf6y5shC4mMlZDDulUGvsgnWluRJ0TvezR3FNAoUVX+6/Yl/ODSskEBAdDY+eIuaYMiAu29SFHOZzbMnT+I4PK+Y0rtGI687gZcYZVTjvfLKC+mx/4Y5Mb2M9t1yXsGeg+MeePKekE9AMqZlBP1yKcr60Hs8CtUBzV27tF6LTpOhqYNDNPw9ZlMycB+48H23xswOrL4x4RNtG6aGbUk/MLq3dVC9SU7UJ2mpgt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h/qYOBBtlJ0yhEtVSCSnc3Q0CZZ/juy915CZuEQ4xE=;
 b=BkDHhxXg6AGQBXH0EF+5ts4NPpBQ9iWnLFpscJysGaSo1/5QG/5O7LNCHJuPa1/GrQeSzJVONWBB+cuUsbKCsx+fqMf6J4FU3pHDwoaBStynofXpY0A4nGi1LanWTWy4/FfKQ2hdxnDiLJj4BTMkXjiH30PFdPXSYIcwwc8aixIPetReBz9xJhiHx7s0zv26u3EktG1aUnVeVAo63BjJ/om6Hc/+h1vpt9eqltInoO9/Xb3XIVfxMCJkUGZvj4AUEgMjkTPHT1jqOhGO/dYm0IyUgHo7xqcvbUrFcviFmr64S4CNwjJ5y8csYiFzdxyYyQm1DWUHEDkhIVWwjR3sHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h/qYOBBtlJ0yhEtVSCSnc3Q0CZZ/juy915CZuEQ4xE=;
 b=4aBQ/S59qgO1fT+S7iqQTG3HWn/5d2efj4+ry0vwA/8m71Q73W6w3Pv1qCLziCDJssds+c2g9YfnrUY2R7oEiYcCwoGPH/UUCqUnHjnJnk9NDQNPMCasHnXcLH17P6Cfokzo3Y4bIV52t7wN/OxvNrLKQ3yJvnpIv3JjlwUreas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BY5PR12MB3700.namprd12.prod.outlook.com (2603:10b6:a03:1a5::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 02:43:21 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 02:43:18 +0000
Message-ID: <f2c9ea68-17d2-f58e-25af-e98a56bb96a2@amd.com>
Date:   Thu, 17 Mar 2022 21:43:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] PCI: Disable LTR on suspend for SSSTC 0x9100
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, Patrick.Huang@amd.com
References: <20220317131008.6395-1-mario.limonciello@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220317131008.6395-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:4:60::27) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e29af64-8f85-417d-1410-08da08890ea8
X-MS-TrafficTypeDiagnostic: BY5PR12MB3700:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3700E7010295F5F8EDE5DD4FE2139@BY5PR12MB3700.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO0yTjmyEj7TN0xuguptNmusStBgho9z/h277UJPFuj52/UhdzMWKp52Xs8HdAIyZzEUTl53ec0dt/Zlb91tClP6nRCi4eXSKp9Ayei99Ky9VrZRCSPSSvP/8K0cGnlWUeogLXUd7IMptJZzIPHqdhsMfvG1H81ClQ1GC0+Z0MlFbhcAi5pr/ylMQpe9dWQkpnTxCuDRmZk59IOfTANoMUw3hB9PKbcshZ4fO8HbajO7VhESCYa60wRlhzdNH24/+lfxzP4qvawFZueWg1vQkaYtBzDetqD0E+Xf0zTfB+gx8jG3VJK9EgYLilKT24BF/WccnKblcX9rg9nWppIDjdIRTRV1wMuAy/h4ovJ3QSxAYU6C3YQ0qJY3ezp1U652XYqB8LwzUm4zOPyHihJUUb6p/9PWCLyPkJEh28l0urk4Qdf2xaF5v8jFyQTFjWz1i6InLdQgt7kiGnFsqxRLxG7AmUebVC65assfrjwXAbILdSfzkxpUfuiBI54/l2SFGFEyTLl7S3Im/Abqd8E/Z8t7jTFANIe6H/9deSJy41F6tGn8hzTMNHN04xrpdxUG77AS2u3DUsWQ+7TaJf4h3IH/LIfXpClLWQ1o0+uhxtBzx15MGq4eHUNgvfmmLlRjWGa3e5UBSp2A986HUR8G7FMq2I7WJxc6fQrdM2u7Pe1Fkze6Nbp9gCb0iwKimrAR9FFd+btbBrxN33TUlis5Fg1P71U80Gv0Bde3g5MOjsLIkxZ/0gIr5/6+S2T1aOAQRvti7YgI96Aarc28OQetiRLhZwnTCpUtFfWm2/m15uV5UYh5OlPjq5H92uWNUXTEz6Vz7PCVKpqBdM2NkR3UsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31686004)(6506007)(53546011)(36756003)(508600001)(2616005)(966005)(6486002)(6512007)(86362001)(186003)(316002)(8936002)(31696002)(2906002)(44832011)(5660300002)(6636002)(110136005)(66946007)(8676002)(66556008)(66476007)(83380400001)(38100700002)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkFWTzNIV3ZMSUg1WTd4aG9xQmgxSXFPVUdmZXpDdyttaXM4QjBqSStZZUlY?=
 =?utf-8?B?dEJSdUMwQW5lV3lMbm51OHFlcTZOd0V3NlA1VmVsZ2lyaDM5NXFWY3p0MkM5?=
 =?utf-8?B?SzRtbzJuWGppNktMTEpjdWhkeHJydmhHRUNhQlI3QzdTSDNsQk1iVDF5ZFRE?=
 =?utf-8?B?UlY5SVdtUmt1Q3FZNFBVQW5VWEwzQStCcTZLcnVOVlErRXFDS2tiSHY0WktN?=
 =?utf-8?B?S0t2U21VOGIrTDFLMVRnOEcwQTdub3o5WVUzelMzVUsvMHB3VEo5MnFvTE14?=
 =?utf-8?B?Y1dIZDRwaWhuWVp0UjJ1eUpQQWJKSE9BeStKVVB5dUFYajhOQWRVamxtVTgv?=
 =?utf-8?B?YXVRR21UTXJ2Q3oyS1B6UmNaNW5tWVFHSk5oMlFIeExseXp6Sy9YMlpKVFd4?=
 =?utf-8?B?eE5sZDlIdkVhS1pqL0RLQ1g1WnE3UWpaK1VPYjNKSy8xbmJwUWlFblVNSVJ1?=
 =?utf-8?B?RkpNc01DN2JXdmdGMXdnVWdrM0I0OU5mQUxkUDBIRGYzMXlUaUJ1dER4aHBm?=
 =?utf-8?B?MWtxV1RKVlE3Qm1FM0hpYVlLRGZqOTZqK3BlZjB1VVBZdkFqQ3VXbTU3Tncx?=
 =?utf-8?B?Q2FGT3VDck9ncXF6SmVHbmpxcTY2akI2M1NNN2VVYkdmL3BDaTRCc0s0SjRs?=
 =?utf-8?B?dGJKQnE4bmtFaUxjY3d3ZC8xUTVZL0R2NlFCQ3Z2ZUh6TGZreUd0U3VOSkty?=
 =?utf-8?B?WEJwZjJEUm5uRmxhSVRvQ05mWU8vR1cyS01GbEwxNW1XV0RCMUk5aDUrWk5J?=
 =?utf-8?B?bGY0N2g4YXQ2RWtRV1VSVWthZ0gwcjRMYU9EYWx6NG5vRXNSNXNqcUtpUjhq?=
 =?utf-8?B?VnFKUFJjWlVYQlIya0E3K1hrd0JiZzVGaVVZbjdjOWh2QXZSK3JqMmNQdkF5?=
 =?utf-8?B?S0NPTWFlNG9ZTFBleno4MjhTQjZUV1FxU1R0VVYycWdCM2JyTnlQSWswQWdu?=
 =?utf-8?B?VnRkV3NlRnZKcWdhTUtUNzNnbnVsYTNCb2I3QUdES0ZOKzlLNHJ2M3lpQjBT?=
 =?utf-8?B?NUhFUnk5VVlrM2ZzeWdWSG9hSk9MUTQ0K1g0YWtwS3MvaXl2SDN2bFZFMHdt?=
 =?utf-8?B?L0dDdkZ4a2pKVVJvTWl1eXo3bkdpNzhHNE91RjRyRlNtUmtvZGkwWjFsVkVy?=
 =?utf-8?B?M1JFU0FHSHJuQ25CdS9qZ0Z4aGlDQTlRajNoQktMNitXUE9jZEIrMU8yVjRC?=
 =?utf-8?B?M29RV3hhZW9xbWZqUGVaOW5CcU10RnpRdXBSb0RlTVNiU1haYlN4STBhS1dp?=
 =?utf-8?B?WWR2TzR2QjV1aGpmNlB4eWxSTnFrQWJiL2Q5UWRKMEZCc2tJbDZ4dGhQd1Vx?=
 =?utf-8?B?Sk43VTBlNnhLaHBHdUU2RnJiWjZjRkgxalNPMjNVTHBpVXB6TW0rUXR3ZWY3?=
 =?utf-8?B?eHlwZER6c3hUNitHQVdObm1GZ1JPY3ZkNWFnZ1VJcFZhZ05QQ0ZiRmxCTmVs?=
 =?utf-8?B?a2FTZ0tidWkva0FEenZHYytFTUlBVFVWTi9ycXBhNGJTdDdTVmJ2WXVoUjA0?=
 =?utf-8?B?UENpYXdiUTNTTFd1ZGtJdGQrNmFmVElpWlkyQncrV2c4a293aGZORU1JK0NS?=
 =?utf-8?B?QWZDK0NOc1lNUGdIU2ZGSXd1STh1QllSLzlKc05WcXBDcmRMUG1GSkNPdGY1?=
 =?utf-8?B?OVk0M2krTmVOR0dJeGY1dUdaRjlzbms3M28vZXdaSXlEUXdraUdtdVRSdjhz?=
 =?utf-8?B?SkJsc1pIWGoxSUpla1hWcWgyRzVtMU9wWXFCUXNRbUJ4dzI0V04wWnFVelQ0?=
 =?utf-8?B?WGhZeDRaU1hzemdsMGhxMk1YdVZjMFVNVldlenY3clRuSWFtb25QSFpKWTFt?=
 =?utf-8?B?cjYyeithd2ROY084YjlyNEw1S0VXeWZWUnh0L1RuaU5OaXJTUW1xLy9sZzZG?=
 =?utf-8?B?REhweUVwWTJkQVZSaXR3WUlsUGJPRmxGSGVOd25wSGI4RjZoVWtFWG84UnZ5?=
 =?utf-8?B?Zkt1d3NBb0dLQSs1V2QxQmlYeXRkRUN1bUJ0QnFFQm5MZmJPZm42UnNNUDZq?=
 =?utf-8?B?S09aRjNaa05MRXdSY01kZHZMazdKdGk0STVZRERpeWFzaGNOZG1qS1Q3T1Fu?=
 =?utf-8?Q?rCqZ03?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e29af64-8f85-417d-1410-08da08890ea8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:43:17.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYrOXnybhh5RY2MQJWNyysg7rCi7A9TWLlRcaGJT2DK6KJlcQ1Z17ffapMr0iPGZ3o2Q3PHsMG5deJEr9rdtQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Patrick Huang

On 3/17/22 08:10, Mario Limonciello wrote:
> Some drives from SSSTC are showing stability problems after s0i3
> entry when the Linux kernel is in s2idle loop if LTR has been
> enabled. This leads to failures to resume.
> 
> This appears to be a firmware issue specific to SSSTC SSDs, so quirk
> them to avoid LTR being enabled during the suspend process.
> 
> Link: https://lore.kernel.org/linux-nvme/20220315072233.GA2288@lst.de/T/#mb9b5782220a32e2c69fe37cf04ae1501b0f48221
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v1->v2:
>   * Move into a PCI quirk, handle entirely in PCI subsystem
> 

Patrick has been running stress tests with this patch and reported a 
failure.  When it's figured out we will re-submit V3.

If any concerns to this approach in V2 though, comments still welcome.

Thanks,

>   drivers/pci/quirks.c    | 17 +++++++++++++++++
>   include/linux/pci_ids.h |  2 ++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d2dd6a6cda60..005142d574e7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5879,3 +5879,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1533, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1536, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, rom_bar_overlap_defect);
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, rom_bar_overlap_defect);
> +
> +/*
> + * SSSTC firmware will continue to send LTR requests after device has entered D3
> + *
> + * This behavior causes problems when entering/exit s2idle, so avoid letting LTR
> + * be enabled during suspend.
> + */
> +static void ssstc_disable_ltr(struct pci_dev *pdev)
> +{
> +	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
> +}
> +static void ssstc_enable_ltr(struct pci_dev *pdev)
> +{
> +	pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
> +}
> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_SSSTC, 0x9100, ssstc_disable_ltr);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_SSSTC, 0x9100, ssstc_enable_ltr);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 130949c3b486..ab47ccdd2ece 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2568,6 +2568,8 @@
>   #define PCI_VENDOR_ID_TEKRAM		0x1de1
>   #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>   
> +#define PCI_VENDOR_ID_SSSTC		0x1e95
> +
>   #define PCI_VENDOR_ID_TEHUTI		0x1fc9
>   #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
>   #define PCI_DEVICE_ID_TEHUTI_3010	0x3010

