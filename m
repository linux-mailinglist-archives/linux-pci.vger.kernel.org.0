Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31666BCAB3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 10:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCPJYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCPJYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 05:24:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC7A37552;
        Thu, 16 Mar 2023 02:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSSYl6S7nWvlMFypMI874KlxtgE7skBdOB/X9snlGRL48vzZ3gA845qO9xhfchqwDa0Z++cDP8A/hAjrcgFeD49K+9xUQX6rsVPZ7XPUtcTHHGevCLlEvo4MIMFMIQCUU6Q5xHeg9MiDRLD6Yy5w81E2TXanoJlxwecu8oOT/WGcqJGK7IQnbhNrdQcw/HhA838UWiQfW4Nme0ULgWYLU3+6Myf/oQg2KmFMC0jckPetXEzWmjSVZk3gRZYb3zYU4xlenNq52wc7KOxtqSVGLcHF6Xm96sFGXm73UF9T1OTVOmzP5gdq7+crWtDvo9Ql43Hp2MSVQzVJ4gUXGDB5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfXJbqFL3Ciwgl8W1Ldbrra+W4JkzaILGqvExmrqoCY=;
 b=j2yXyPZIAfONjg2Z2mK/9SAbCjXsZclm39q/SPhOkx/j6UeF+ajezkExzwqqAhXl9tAyS0oxQrRtUZ2YepCK5s5P9q1TxnLckTWqdimWhlwGKkmNhhAxcfqz73ntSM/pptE4DlTHQ6K8vII+DtfUNzSP+V0zEVZY136jK0pehORU8I3x0tGbSVJaPv0oag2BkvKLiWemMif7Fsv3AsRYTbn+VckmS/lApXdkzb2A6fG1ho1DSIuFu7nI6q7pUJb20IhM9NcUtG4cmwc/Wh3ujIG87Zg86x8tqJAhkFxgimlK0d0LjIMdSh2T+unIAU0KN1ZZ3xdQzmFh4yYLk/6MtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfXJbqFL3Ciwgl8W1Ldbrra+W4JkzaILGqvExmrqoCY=;
 b=WqjiBsm33Dujnmhe64An7yslgBKlBcsYCEkirKs2LJZGXtzGcTKJWg7Wq0FiQS0jSKIHQCtR8uj73s8WWo9XjJ9053nMCcB9mCV+S4+MfJG16awrx/IMDfFWm7RsMmEArevT6G7fp4+KUhtvYsx/wu0YGkZNBqCKociLfK1J3gXhVauw8kdBnmhxYyF+8i5p2rkQIh4XfEepLyuvA1TgUEZ5cxWyzjGVC3yvBEXuetZoRE4KaCd++VADI2dJ+hLcYuLMei3NVtzxG8ULxYovp5QXGyramIjcHk5ZxiVQGm/GjxZRmDEgUL3OAegZBkDbCHqadX8WsynNnGYRCXPHjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by VI1PR04MB9955.eurprd04.prod.outlook.com (2603:10a6:800:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 09:23:56 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%3]) with
 mapi id 15.20.6178.031; Thu, 16 Mar 2023 09:23:56 +0000
Message-ID: <106b5618-908f-becc-6eb3-75ef136a48e4@suse.com>
Date:   Thu, 16 Mar 2023 10:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/1] Guard pci_create_sysfs_dev_files with atomic value
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Korneliusz Osmenda <korneliuszo@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230316091540.494366-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|VI1PR04MB9955:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c9ee7c-cd1d-4a1f-1355-08db26002af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +E9Azf6JRWFm+lMMAzHJ+SeKWinEbQG3OtiqPRCrD8gc4xX9mWQsCs9vT42Yx6z60rFU8BVeS2mOmwD8BqDKCOCwAcT7qJ9V1es7e+spFHXAlHs62dsP4cvBKlDZf0+4QlQlDGHDWIG7kIp/Up0vHfk3CUY1LrsbXqPdu4JD0PZOUPMMWHP9MVnPheYQ6fgnIpom+XqXaTkNOh3xidOdg1z+XU5I4f3fMIBNzT6US/eI+raG3xMBWuCii5PkFxQGqMOn72HQ6PdFIFcWK1Jq6XVdKa3iuoKi1Ueq55LL6harHxLwyCSKNTNdDC7IYllm7o383D48dAEA3a6+eR30QBGoL/Kxis+idt5NqK2GeZZQfSi0O+JUNLT7Mjmnl8PLUE4Zc9aX5KBIY6LsSajpxMsWStUB0FaVnfu1dd+XgIFsATjQuAN1zZgI/xFb/PPKe31uUaJF1ZAaorDGd/+lNQJ3cVzCWLpiwO4RXVPU6+9QxfwwYnS0kMLH/3LpF8ATPrZgAtakq8gPn53C8vho3S/54MU+FVjS4nCU5B+ICcktMcQRI8nQG5BQTT9jPIz/QkI24Z4oaHrnADXeRiH9h0Jaf2NM3hmbe9BdBJF5jqUnO8IPu78f4JTRoHUbZzq+6icJz4UtSrI/RCMS/zO1DBf7evSLN8wUpioiW0ygPaOkKLep7is0L6D8uNaSR6rc5Zj+XT4sqlBCFQRppYoRXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199018)(31686004)(2616005)(110136005)(966005)(186003)(478600001)(6486002)(6512007)(53546011)(6506007)(31696002)(86362001)(38100700002)(8936002)(2906002)(5660300002)(36756003)(41300700001)(4326008)(316002)(66946007)(66476007)(8676002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9LMlVNQy9zcHhxQmtTckJjQlhFQUlXREdvTEFraGE3eTl4ZjJtSGVCd3pX?=
 =?utf-8?B?Y0p4WHIvSHNuN1p2d1hGeE1KTzdxRUwzZklCd2h3Tm1OOGtiZEE2WjgxR1E2?=
 =?utf-8?B?RnZyVmd3UGtKOUZIQzJ0T1Rva2kwSjM4Wk9YMkVnTWZLRkFxbUZKdXkrYmRh?=
 =?utf-8?B?MjlIdXlTZWNQamZXUEVXU0xYZ3U5Y2swU04wSXhKZDFNeTFIU1FwWEJINmpZ?=
 =?utf-8?B?blZSc2RnN3F5VUltTHYvOGtkaGVUcXIzcmRIc2dxMlFJTEpnbzRWb0MxcGtr?=
 =?utf-8?B?dUJJSHJXYy9xNWNFVlVUZkE1WlM1RmFjMlYvVmFoNmFPTWpJeDdUK3YzTHlM?=
 =?utf-8?B?UXRmN2hPUS9WbmlMazByVjREaWVnZ2pOTDh4Y3lhdVNwLzkzcHNucXZYZEI2?=
 =?utf-8?B?bkxDdk10aS9ISFFXV041ZUpkTVVnU0Rnays2NmVUdDNiM2h0SURGRHJQOFVY?=
 =?utf-8?B?R3oyVktNeC95QXRWcGF6WUx4M1F6bmF0REp4dG5xRDhZaWRTVWtuUGdRU28r?=
 =?utf-8?B?M3ZWNHN4NE9HaWZhZzBjU1lLeVd0WVJvczk5VmNCRXdjS3dFNTVMN2wxVUJs?=
 =?utf-8?B?a3NaYWtoVjVnRTFCRlFxcU9RMUx4N015N3V2Tll3L0NvbEtMbHp2VE5RYXV5?=
 =?utf-8?B?WEFkYkg5bE5uZkhYUXNBK3dDaUE4VE1MczJpamRDRnBLU0hwUXVsakE5L0pB?=
 =?utf-8?B?dEZWeXlrS09Bc0tCUGRJdW85bm5kU0wrSHJTUWtzWlhqc0VybjFDU2RlTUJP?=
 =?utf-8?B?a1NReTRCaERIb210ZmFBZVZCYWMwYitiM0w5dWhmNjRtY3JmM0tmZTBGeEYw?=
 =?utf-8?B?RVdRb1lQSEdSZk1DL3dSRWFsczhuQ3ZNV3Ywb3hzRHhtQTJTcjRlbFFQRFQ2?=
 =?utf-8?B?QUVHelRsdCtPelNYZzlETUs1dGdzSVFmd2p1K1dlYnZvbHRReEtlNjI3eFAx?=
 =?utf-8?B?bFBpR0VTQ0p0T1FMV0thVko4VzFiejVFeU9NUzlGS3lxT0FBMFBNaUg2VXEy?=
 =?utf-8?B?Rkp2MkpvTmpia0h3MVJtVmdaY05FVnJwK1VHNGxmbmNwMXpOUGVWRThtRkNs?=
 =?utf-8?B?TS9jWGdwYkFsSFJ5aXhiaXBrT1Y4WHBFTmZKZFlqMWJXZVZrSkUzUm1tYVdO?=
 =?utf-8?B?aW1IMS9OTWNxb05rSkM2c2xNOHhZMERaRlZjV1VwbEhkTU56NWtzZnl1UUhK?=
 =?utf-8?B?U3hjcGVRK3BtcHFFQmxuY0M0U09HTXcvSjRwbXJwZGtYYk1meW5pZVlNYTlU?=
 =?utf-8?B?ZzBXbnNmUU1JdW8rMTlXbzYydmdoSWNraGFRcnQ5b3Z5RFlVR3dEVFZISzZi?=
 =?utf-8?B?UW5MVmtBN3pPdzRHZXcveEg5b3VNZGxJL2VrZ3FEZHkreDRndTBKSkF5anBB?=
 =?utf-8?B?MmtHQ0Y2aXlYaUFubFBJYis4NTB5dWhjRjVXYTYwdnFkYzdKNStIZ2NqTjFU?=
 =?utf-8?B?aGFKdnlFKy9kcWE0ZUErN2VqVCtqeU9tTTY5a240Kzl1Tk9nWHpoS0ZuWGgw?=
 =?utf-8?B?eWxFcXNYL24vZ3JuM01pUWdhYVFFbDZLNnlzV25yU2pOeGZGc05BcnlLbHJ6?=
 =?utf-8?B?V2xuc2hCeXgrS1RXY2Nja250K1QxQmdiZlc3SHpEOGQ2UUZWSjVHbVY5eGxY?=
 =?utf-8?B?T3ptMCtORk5DdnhDeHp4dEEvTzdreExzWGlJVzRXMGFtRVlWNFhoS21CSi9k?=
 =?utf-8?B?RUkzVXZGNUtuL1JhZWVGd3B4bm9rakxEVS9lL0owSms4ZUx6VmpUN1doSVll?=
 =?utf-8?B?TitWc0tHKzdadU5RU1VndVp4SXNNVmQrVGxxQ1NwMmVrUW5QeE9OMWJZbTVS?=
 =?utf-8?B?YVFMamx0b0hHTnhvT2V0RFprSlBnMjArQ09BdFJVdHI4UlVsMnA4VFdtakIw?=
 =?utf-8?B?UHgrcTdZMi82LzJaSkpGdHRMRzBFQzlPZFgxVk9yUFI1OFBjbWlMWkQzVmVr?=
 =?utf-8?B?b21lczdBU0RTNmUyc3lMeVMvSnhUS3hKUm9vUFJlUmc3M3REVXRuMHFGSm9o?=
 =?utf-8?B?dm9LVUVqZU43RGN5dTNiL1RiRTRGRE1vR3dvcEF4Y3VZQ0pMTTBMVUs3UFlE?=
 =?utf-8?B?NDl4NytucW9UZ2pLTzFQRnZqajNUMCtyRU56YlI3RVpjTWdON0pQUysxZExi?=
 =?utf-8?B?ZjlvaHJaMG1vbndFUkhGVklwS0hLSHRqZDdkRVdDaEF4NnVLbUp4MERxRXFy?=
 =?utf-8?Q?eddTfmnpnExqxXs1eYZFWuqnxQYxnLhjfIJ1HOlnoH2f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c9ee7c-cd1d-4a1f-1355-08db26002af9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 09:23:56.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0VL7rOGYBGNMX880TImvyfA1Jt3X1J+m2b1ywY80xv6TY6KFAfKSt8eDSTv8a6JSJynsPiTCFUEt5YV+gHEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9955
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 16.03.23 10:15, Alexander Stein wrote:
> From: Korneliusz Osmenda <korneliuszo@gmail.com>
> 
> On Gateworks Ventana there is a number of PCI devices and:
>    - imx6_pcie_probe takes longer than start of late init
>    - pci_sysfs_init sets up flag sysfs_initialized
>    - pci_sysfs_init initializes already found devices
>    - imx6_pcie_probe tries to reinitialize device
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215515
> 
> Signed-off-by: Korneliusz Osmenda <korneliuszo@gmail.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   drivers/pci/pci-sysfs.c | 6 ++++++
>   include/linux/pci.h     | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index dd0d9d9bc509..998e44716b6f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1497,6 +1497,9 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
>   	if (!sysfs_initialized)
>   		return -EACCES;
>   
> +	if (atomic_cmpxchg(&pdev->sysfs_init_cnt, 0, 1) == 1)
> +		return 0;		/* already added */
> +
>   	return pci_create_resource_files(pdev);

This is very likely a bug. You are returning an error in the error
case. Yet the flag stays. And simply resetting it in the error case
would be a race. There is something fishy in that design.

	Regards
		Oliver
