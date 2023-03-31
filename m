Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60CD6D1DF0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 12:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCaKX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 06:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjCaKWt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 06:22:49 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A228172A
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 03:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4W4lC+cZv7uL8fBGdAongG+Nwo/u/Cq0n0uK514UEujUL9HQI/u1C/7jMd55WdjhJEv8latJMjVmIQpI57dtqeZsn77c8Okk4cablPyffpFLSw9TVwDo3HWzoMw9mn39pwf6DUTzfMMiV0n21omuGtcLIxMQP6BCGbaT/VTl6SZyqO7QtRwZ7RA7/Pqsm6KJ/AXH1tHqMe2LGIQahhR7+0oA//ul++lmssD5oby5A/Im3Ma5CyLCUBxFMIpAlowmTiGDlKdHoPYaQPebGEhcEjfZ5mSzx2pSLn/rYHQuDCYP6+cOszliRhXh9j7S+boOfBAMOpeNenAzNqX0V4qpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czXgjXp+xnkGkiceFBLPffv3POe9ORtc5Hr+OC2llDU=;
 b=AajKwj+M1ZJ02eCcwBD+Q/9ErXRVZQ1tlcCQyen2VWfknHO+kGLQdE0dGJ8ERi0lGcmiXsjS/dx/iZ1KXJhNCEKxjJUyx8b1rcdZ34tFK/MfcVBuRNhlNVlSQm5Hzmuy2lp+4Bq2LqC9xiXHS5YhWIohfpGYZXrBDMNfWPK79oAvH4aFUdWQmfZnruhUNyYW+T/u4CMCrRdufoiYkUXGpXUdSGToQ4oO48n1hXI6nXoiRPklTXRSBIrIW5f2VD4j9Jd7i0cOgZprYVICbxww+ecyrxDhVN4TH1iAyQgb39Z/TULrRWuxCgBlBYd4SA6As17YlqqmIL25I+B50AWvBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czXgjXp+xnkGkiceFBLPffv3POe9ORtc5Hr+OC2llDU=;
 b=TBLXyAK0qljLkBvMB2EEmJe2l+zd9mUuaNYZ+ZfqIOukihwRBLLCqQnXMcph5uG2S6fvnLuLFftwfa93rxTwM0x4jXgYIcNfw5ArCPanDOscuq1RBrbUvHV48vE1IbFWmwq8cdCpatxffqdrP542FSCLwYZHSy96nSFzijj8wd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 10:20:27 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3f99:52bd:6b66:d22f]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3f99:52bd:6b66:d22f%6]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 10:20:27 +0000
Message-ID: <057a4d17-9faf-4920-7187-3e36667b1fbe@amd.com>
Date:   Fri, 31 Mar 2023 15:50:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3 00/16] PCI endpoint fixes and improvements
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
From:   Kishon Vijay Abraham I <Kishon.vijayabraham@amd.com>
In-Reply-To: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::17) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 85de93ea-14bd-4f6b-f35e-08db31d18c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ci5HSwLGGmZJjmvLxWHgiDfT1LZfxpJjTBuz7hSXcHjchpCOXYIbIhp3dSjYtTt4YLLk33qr7VIj55ZHpEO61usgJcGVY75KF3A2efzX2AJKau7V4jmxSvu+ZomHbjhBpn/O9tuitIuJyFJ7CdtUsddEhYFNSbZp1o9p4Vj4RddU9gEe/zhBEjjuJruIhYbjxxLBQ8SDOP593DC4FD52a/z66VBf97v2xoVEjvl2W9i/eu81vlsfsmyQjHmJ+bAP/h90GNE5u3V3WYm0M1Y3EByry+bpuAdsK1kgzQuHd6U8hepZxs04IUrAo9VS4lgzV/iHP4Y0Mr5zYUjjt3q+KpzSr71c7EkpLEfNsMqDKgs/Vsx45v2/f+CiaWqDoBCRN3xVbgDNp8ybytY5D1S/Jkwp+AirQf66Yvru5XugDbBEbXaO3s3Zh+aon1Zo8cujstA66rotPRAVrifgjFJIBlXVGe/Kb8K1sOOGTHy0C42ISpILaVmgcAdPM5bsHii39TV/KDgJY1OaOUEU5WSMcPhZWlqRvLuU+XgXQ8S7eZZVJPghQQuPK1Cw8RuUatKNQ5cBFwpWzYT0Fto/lbS9o3jj4+U1uhQdQ01TkPjD/p+lrE0Uxm0JLHROdBTWHyPWIH2tD94rXBvLbuLT+dyThw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(36756003)(54906003)(110136005)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(966005)(6486002)(478600001)(8936002)(5660300002)(41300700001)(7416002)(2906002)(86362001)(31696002)(38100700002)(186003)(2616005)(6666004)(26005)(53546011)(6512007)(6506007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1NoUEpPMFhLVldvQUNOMzU0SWtZSE9mWVY4eXJLVzIxY2I4TGFXTjhFVzdx?=
 =?utf-8?B?dW5yL2Q1Y3BZRm52SHVodlNVTGhWdHEzYjZUd3FDN2xkcXBkd2xic1VPeTB6?=
 =?utf-8?B?ZkdaWVloY2lWNmc1L2hmTkZuT1VJd1JBWWRWUnFJWlZpNUhGTEplaG94SFNE?=
 =?utf-8?B?OGx4RTFqaFVaN2NhTFQ4R3dkc0xDeExtSjdIc0Q0T2IzUG1FV0ZDZVpKVkFS?=
 =?utf-8?B?ZjQvbUE2M29VSTJ1K2ppNGxtWkMwbFl0VzhTdUJnREtpY2s0QTJpbHJMZXNx?=
 =?utf-8?B?azdWcjdZeWhMYUhXcWxiWlMwWTNWT3JNL21KRTdVQ2FjSHZUenhVTkY4eGxk?=
 =?utf-8?B?b3hDUFZVL0h6ZUl4SlgrUHRyU3h3cmdWa1djb1pmazR0S0tVdHFGc0FXREgy?=
 =?utf-8?B?MytSMzJRdU10TDBXN2N3L05qcTNWQkRoOXdNRzVtMis3WXJ2NjI3Zy9LV01v?=
 =?utf-8?B?TnlZa1BKSlZnYmFYMk5EVGJ4cG14K09Kc05QNHFkYy9zeEFBMVFFa3FYQklu?=
 =?utf-8?B?OUF4QmRTSDEzK0ROV0lEYWppYTVvcU9GcXoycGg2TTgrTmNER3pLK0dUbVBS?=
 =?utf-8?B?UEZBMkpLZi9KSG9EYmxOUE1PQW5MbnJlQ0tVY0p5QWtiVVVjUFprTnBpVjJO?=
 =?utf-8?B?ZVd3WGZyOVlKbXBLbmhLOFpNYXljVTBWQTUwZElKcnlsbTJwOXMzdW1DK3Ux?=
 =?utf-8?B?QmxoUWVuL1ZtVjZSRHR0SWVLOWRoSkZaN1A1eHd0ODF2dm9OZ0NIaHZpT0hh?=
 =?utf-8?B?aHpKMnUzZUtlazhxc1NwdTcwSmtnRlpIRmU1YlA2dkVCUVQ4UmpXQnZnLzha?=
 =?utf-8?B?K3BNTlA1R2orTzY1TDdYeDdaczdHMzd0OXRHdE1XMXFEeldKOGhDMS8yY0tN?=
 =?utf-8?B?dFlnbnlGUXp5Sm5Vd0d0QnY1SGZNeVBrakVlN01PRS80NjcvUy81b0hFdksx?=
 =?utf-8?B?OVhBRFdWbUV1VjA0Zk9DVmlDTERMSkk1SXJndjQ0YktBMmp6VWZuRGlIK1Y0?=
 =?utf-8?B?anREZVMwVkV0OEZ1MEk1dmN5Q0c0UEtzOThmUFVZbHUyVWN5Nmc5Q01yeGxy?=
 =?utf-8?B?Sy9Pc3VlSko2SXNLNW5FQnJkNDg5OVVVWFdMK1cyaDF1L1UwSEV2UTFIbEFX?=
 =?utf-8?B?ZEc4M2lwcEQ2SHJjSDI0SjRsdUhDK092RkhYOW9GNUpqaGJ2ZnhxRlV5WWJ1?=
 =?utf-8?B?aVlmUUtYTnhOemVGZTZld2RIa3o1S3hDS1QyOHRCalErZUtDcUoxTmZrKzdu?=
 =?utf-8?B?RDBmS2s1K0tlendSTkVTTEtJTWdneVoyMFRQMjI3L25aVXJNNW5NNXl6bTF3?=
 =?utf-8?B?a2UxNzNack1aMWkvb3d2NEJWNjRqZ1BaeDVPbHhaNklWOEkxTE03OElVNTBT?=
 =?utf-8?B?b3FYZWlkaG0rUWo1YVhDVEY0dFRKSk5mMTdkdTFleE9hOUNNaVllZFYyM2t1?=
 =?utf-8?B?R1lRaTU2NDg3cm5KTHVhelBtRU56YWcwalpaN2R3R2s2Vkx3R1RWN0l3OE9m?=
 =?utf-8?B?QWRUa2JGcTdoNHpKRm5iLzVJbUMzMk03ejVLQTV1VFd5M3M1OCtKNFMyc0R5?=
 =?utf-8?B?UjVtVDhKYlB0aU92SGg2TEYrZExHeFBOUEJYWEdleFJBWS9sVTkvV3Bua0ha?=
 =?utf-8?B?YzFhbjdLSEc3Nmc0RDdhQmN1Sk5nWHNoZG5KMUlLUE4yOExUKy9HNDMrV1RQ?=
 =?utf-8?B?Tzd0amZtY1JmTDQ0QUdBWlZTeG9mRlRTanluUkRoQnFURE96YU9SZnJ3Kzcy?=
 =?utf-8?B?VWpESUtkUVQ3TUFpTmxpTmZzMy9ldlhzWFZBUGh3aG9yZ2xCNTNRMkNOUzZH?=
 =?utf-8?B?amVQSXY0MEt5NkI3SXN0UE55QmszSGtoZzlNdy9iYTEwVXdDME5qUWZ2TlpO?=
 =?utf-8?B?ekJvWVNQYlNTTmlXMUk4Qi8xenpiMVZjNnMwc0VSS0Q3M1FrRGdSNng4Z25D?=
 =?utf-8?B?RjZpbndQT3BkZVBMNGFJOEFLclJzeE1TMSt1My9Wb1FTVkRHQVFKeDN4S1B2?=
 =?utf-8?B?SEp6d3BTRVMzdCs2Z3V4QUw1RVJta3Z1a1pwbnovWFd4Q09QZDhPQVY1dTZI?=
 =?utf-8?B?a0VyYWExTUl0RnpNa3JyVFdHS0h3TFZDWVg0WU1wRXVvMlN2TjMrQVJyWjFn?=
 =?utf-8?Q?ULw2EeZAwDbr8M4tlVOl/1ixv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de93ea-14bd-4f6b-f35e-08db31d18c1d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 10:20:27.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpcnyH/U8sIoyHDfnfYkWInX3TddQOzUQwzUWGtoKIL0U95OMNMYfkxxG0d/8PMpE69nea2c9f2IYtPW1KDweA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/25/2023 12:32 PM, Damien Le Moal wrote:
> This series fixes several issues with the PCI endpoint code and endpoint
> test drivers (host side and EP side).
> 
> The first 2 patches address an issue with the use of configfs to create
> an endpoint driver type attributes group, preventing a potential crash
> if the user creates a directory multiple times for the driver type
> attributes.
> 
> The following patches are fixes and improvements for the endpoint test
> drivers, EP side and RP side.
> 
> This is all tested using a Pine Rockpro64 board, with the rockchip ep
> driver fixed using Rick Wertenbroek <rick.wertenbroek@gmail.com>
> patches [1], plus some additional fixes from me.

Thank you for improving the PCI endpoint code!

For the series:
Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
> 
> [1] https://lore.kernel.org/linux-pci/20230214140858.1133292-1-rick.wertenbroek@gmail.com/
> 
> Changes from v2:
>   - Add updates of the ntb and vntb function driver documentation in
>     patch 1 to reflect the patch changes.
>   - Removed unnecessary WARN_ON() call in patch 4
>   - Added missing cc: stable tags
>   - Added review tags
> 
> Changes from v1:
>   - Improved patch 1 commit message
>   - Modified patch 2 to not have to add an internal header file
>   - Split former patch 3 into patch 3, 4 and 5
>   - Removed former patch 4 introducing volatile casts and replaced it
>     with patch 9
>   - Added patch 6, 7, 8 and 10
>   - Added Reviewed-by tags in patches not modified
> 
> Damien Le Moal (16):
>    PCI: endpoint: Automatically create a function specific attributes group
>    PCI: endpoint: Move pci_epf_type_add_cfs() code
>    PCI: epf-test: Fix DMA transfer completion initialization
>    PCI: epf-test: Fix DMA transfer completion detection
>    PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
>    PCI: epf-test: Simplify read/write/copy test functions
>    PCI: epf-test: Simply pci_epf_test_raise_irq()
>    PCI: epf-test: Simplify IRQ test commands execution
>    PCI: epf-test: Improve handling of command and status registers
>    PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
>    PCI: epf-test: Simplify dma support checks
>    PCI: epf-test: Simplify transfers result print
>    misc: pci_endpoint_test: Free IRQs before removing the device
>    misc: pci_endpoint_test: Re-init completion for every test
>    misc: pci_endpoint_test: Do not write status in IRQ handler
>    misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
> 
>   Documentation/PCI/endpoint/pci-ntb-howto.rst  |  11 +-
>   Documentation/PCI/endpoint/pci-vntb-howto.rst |  13 +-
>   drivers/misc/pci_endpoint_test.c              |  25 +-
>   drivers/pci/endpoint/functions/pci-epf-test.c | 238 ++++++++----------
>   drivers/pci/endpoint/pci-ep-cfs.c             |  53 ++--
>   drivers/pci/endpoint/pci-epf-core.c           |  32 ---
>   include/linux/pci-epf.h                       |   2 -
>   7 files changed, 162 insertions(+), 212 deletions(-)
> 
