Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619A7EBA7A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 01:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjKOAHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 19:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjKOAHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 19:07:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2114.outbound.protection.outlook.com [40.107.223.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB043CE;
        Tue, 14 Nov 2023 16:07:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDYFZPnwpbF6e2+xHG2oZr89ZgUSY1xYPGUY2AgqXni0Kv5eNc+Ht6X49fo2NDY+o/QJad0C5DP7/XN5QJnDp86kuEFB9yhPMkEDq6G/g5l3HzSsKCUKtglbhWt0Bb8TrDf3KpHy6H6j2CWcZzJxvyUty5CcTnG3ldGnLAzwpSbp7rZCT+dRmQoFyreo+FDgOy8rxk0Pnjge1LAjMbB7nQKNzrqATN8bCloLZl54lsg6bry/xWiQpSaXb4vNofv3yjaOodhSdOYgb+Bz3O7z9afvuuB4IgNUmLKpKS4skPQacy3+1FJobQaJctS+SeQ+8Edk7MdcoV3XclYMsQi4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4coedQgOL8gUoEme6I1DYwoQZ3bdqnjuwTecNKFqKA=;
 b=CHsE4VnwfsU0a3nPr7IDXoiWnk8aIZwdnta+yHk3jMjTOepdwK99BEFRmylTWddUeFNLojpbo9Y+DMKS1mCBoBZznoN1qcQAtOsHkLN/8ANlLlgGwlbWwoUDz0/RyfAIp7CyFhx3TQ3TBJtYr2QFZ+dW/75LdV6x3R9Awz4utp03AEZobVHBcEoUwRBacBBk39WEGpeZ9kzzI6QsWsUvp1c9LdSAcO3+OhNzAFNNMNKwrD3Miqpgk72HE3YDd2hTDs0vt58NHqa/uEV+ldnJ5MLZaTvYnc6jpgWkwzVrEL0Rm4Lp7hELzZsV1AB31mTxwB8cx+/RV6QErrxR1SYqPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4coedQgOL8gUoEme6I1DYwoQZ3bdqnjuwTecNKFqKA=;
 b=duvXU9Hqh7YiCbMTOgUtHApExv9RD4WMdE82eb+N7SrWSBzCZg/jVscQ/iaAHKdwn+jk3ynlvo5bczWRkw6orE9zDKAUc/7LMpbVevDTm9I69kCOSVRGTyH+9TXOrKNvuWwZzTOoniDkJ1/9O2qx2YVT9ojldVBhDYupxUBZtOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SN7PR01MB7972.prod.exchangelabs.com (2603:10b6:806:343::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.29; Wed, 15 Nov 2023 00:07:39 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 00:07:39 +0000
Date:   Tue, 14 Nov 2023 16:07:21 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 4/5] drivers/perf: add DesignWare PCIe PMU driver
In-Reply-To: <20231104133216.42056-5-xueshuai@linux.alibaba.com>
Message-ID: <e053a5d-f2a8-86c7-5af-d211507140c4@os.amperecomputing.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com> <20231104133216.42056-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:610:b1::17) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SN7PR01MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bf9c8e-12a3-4f48-03c6-08dbe56ee10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWnGL51KyXDAVKG6hnAz+rSB/CSGEIrMcEM9yHQ/PxSazSzgOmyI3LOIVnUo/KhWpzSkRq6qwedHPR8f7GlLpWl4gx9TM/MCxExegyAu0q+jd9qN2g1dyqLTYpW/jNH/acJQHpnt3wjQ4LDCBaNpVTwCowHDXzO113UblqkrE9277YV0wH1IDT7Rx6G4+o0Yhrmxw5/XthvmbJO25rW36GBkAOB65KOCtdcBm3PaDo/wyXrBKwJ3fQjFCfYCG/FvTtJiWb8Veo7zl0MLsDEnViLH9EoKXdHRxxZat2XT5QEbg0C/2ugKfdZWdebOObhrqEyUKhbwjNoFbGWM0FujZmF1ferhxHp0yZxvJowvdddb/A4Tl0lTHD7iHAJrCFYvPhpw255nrHXSXVmPpLG7ZfWq4nN4J1LNudTgYWaaJu+KJaR85YD3nfGW4Dh0z6a4/H0TlFj7jpZsOCtF1LkD/1KNmcmkwTBspcA7/SXG6wiUvny+21k7IXcYODwohAcuse2bvcRhrWiHPbuA5M0TRJuJQYdNRegymuFBzsDhzYbLp5XHnuUjxJ1CHtn0YVLx+v5G9gA0+jlRKVSjPg/hmNLrpZZzeUmPVZh1FKYK+LPAF/G+EIa6wbxeykdxA89F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39850400004)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(41300700001)(66476007)(2906002)(6506007)(6666004)(6916009)(66946007)(66556008)(7416002)(8936002)(8676002)(4326008)(38350700005)(86362001)(19627235002)(478600001)(6486002)(316002)(52116002)(6512007)(26005)(2616005)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mYsvEjmbZBre2nOITLmZKawVuqWDNX5VETGHiBaA5T7vqPYZLMIUvNxe3/i/?=
 =?us-ascii?Q?v2Etf7BTddkHOvug3jlD5NUNEP7+PTh6+tLJwsqp8DrfCjox900zl47fnwM3?=
 =?us-ascii?Q?68cOXTHDwHzEzhkG1cOufwwPlJ0Ip47pzTaG6TdyGg8W7cprGENnRXjb5yYn?=
 =?us-ascii?Q?pYYT7UUumSc1eIRlz5YqMWsdR9zRFvJ8+LCy0lfIaWArBcvzM7MGh2x1wrl3?=
 =?us-ascii?Q?inavtyRDMFKoHHJUU0ASDflj8X+POdTfbzU3pm2dSdJmV/vbnensNggxJ0OU?=
 =?us-ascii?Q?NGpwvPc/TNuxCo/0uQ2hEJHzqbbTANGYq5Q6ZfH/G/uTZjIZ6u6nFNUKQGra?=
 =?us-ascii?Q?Mw29uJZJALn6JF118jOqbo/tvnyYe+/RAFAjkoHIRKlyOAC89cLzHwoFSW0P?=
 =?us-ascii?Q?QutI5HTGdt9Z8acODWd2PA8Rj7OCD70ZVLq8nsOJkEJT2lZAQAum31NoQFY5?=
 =?us-ascii?Q?ZhK6y4tuDm6saHUxihhDIPUQwQdR6+K/8A3YN4J0RQLHhUsk+oAp975s6Rj5?=
 =?us-ascii?Q?1mqcgXbt2RAHCj61xQP7ftvn/RAZHISboXaiRtR9iLeEXCfwZotZ0uIwLDO4?=
 =?us-ascii?Q?L0sCs27mdVjZuQMXLZbNTBxZip9iokVqhG3I6etLZmO74bHvNK45E5CksCy4?=
 =?us-ascii?Q?HJSO0BZ1JwWDyep74UbSLLR3frwxHlQeoTIMM4aX6rZrGpazKg1BQxprqr2L?=
 =?us-ascii?Q?fFirJdlgTCQLpEpG6W4i4lvyshs4s54qL1prr4DHa87JtQjbZ8gpixnDCXAw?=
 =?us-ascii?Q?OVcWJ+azzY6cFR01h2JvFtw0qp3Hafvmkupu7xK64WO1dtgmJ1850BnB8rtg?=
 =?us-ascii?Q?SUnV9ovO9WZm+UboiVrz9bv0pyxp19p3ogIZabml+FvpigPOWDuR90pdEzsh?=
 =?us-ascii?Q?nsrKEkoORB9uENZfI/+NV4AK1RPlm2rSAX0HfKcREIJQ0tJNdC4vquzxxWVs?=
 =?us-ascii?Q?bMMsaER8OCk67ZTrH8zUwBCsSDniXY5nZwVZHMjAZT1v/AUespP831GcI+0k?=
 =?us-ascii?Q?2ksY+KL0+n1YFmSQUyNdZ7xTM6oZkA65LdxxpO2TLhRh40iDol2a+i7+m66G?=
 =?us-ascii?Q?FekOy9TEjyB2OciIpKTdFTAT8oKl+pGQMDchXLmHn8vQgHwuT4dder8T8qBH?=
 =?us-ascii?Q?qlfGD07isL5LcFtWRu1Y0QqSFZT8uertmzZxateeVuSTzdzvzc1+cebOMEE0?=
 =?us-ascii?Q?oRMc2DThqtB5RREVxsgG8JxUYwyptkuC67CoIIywiJ7PZLT/m6X1c1uMO6Wh?=
 =?us-ascii?Q?5x5qn7hjD0JlHMmZnvVYM3KxVsJdI1kkLqrk+YTD7r+Q606LiQW/7vKo+TjA?=
 =?us-ascii?Q?tYPuuGVW4I7LqyzjrgG8Kpdwt1zFAKSZqMnNELvbR3JjevDepTzuDwzl6MTR?=
 =?us-ascii?Q?4O/NF1/ByH1P1ofWVlPaGhV5DK44l3jYVljk4RFuU7gl93kSDQY3CVVYWL3K?=
 =?us-ascii?Q?cInU7FIpoVYiNEELPfuVUoM3G6pVukxkIo8/O9lvcoBuC0MkmwldRXcE5ODh?=
 =?us-ascii?Q?7ODdcezPc+t2lwizXvPFqfVM4688GGSCIQHJMiZ+8cEqUKx7rqL9YciL9wg1?=
 =?us-ascii?Q?Wgfv+1xXB5JNW5BFNjbOmWZb+hh28UbvBcWpJPPTFYGz2PECflKYxS2IRlTx?=
 =?us-ascii?Q?Tp+Wwt5uPZPqpqaIbAMAGqM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bf9c8e-12a3-4f48-03c6-08dbe56ee10d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 00:07:39.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylKPYgDQ7PGVvJoOGKoQeOhVHqPYr6nJ1l4zqSBM7S4Ud1l4Txx7xYipufNA+9zzQsC4dK646elaNMG7Y4HZcnYDvxeZGpcOnaMFPcKneH6t+aduMv2waQavyE/2TN81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB7972
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Shuai,

On Sat, 4 Nov 2023, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is a PCIe
> configuration space register block provided by each PCIe Root Port in a
> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> injection, and Statistics).
>
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
>
> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>  time spent in each low-power LTSSM state) and
> - one 32-bit counter for Event Counting (error and non-error events for
>  a specified lane)
>
> Note: There is no interrupt for counter overflow.
>
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
>
>    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>
> the PMU device name for this Root Port is dwc_rootport_3018.
>
> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>
>    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>
> average RX bandwidth can be calculated like this:
>
>    PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

Thanks for the driver! I finally found some time to test your driver on 
AmpereOne and it seemed to work fine. I had to do a couple of changes 
though such as adding Ampere vendor ID and support multiple PCIe domains. 
Given your driver is already in v10 and you have got quite a few 
reviewed and acked bys, I wonder if it's better to add my changes to 
your patches or me to create new patches on top of yours? I'm fine with 
either. Any thoughts?

Cheers, Ilkka
