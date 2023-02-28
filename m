Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E206B6A517A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 03:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjB1CyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 21:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB1CyT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 21:54:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033471E9D4;
        Mon, 27 Feb 2023 18:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh1mHvKme6Q4i+oFJ3jYndTnQVekLBMh6Bi6semBrX0kBOkfhYCHx4x+Rx9BzFC2fH1MsoScbnUqdlNqxCkJyPW8gswZg6bN3TLK4FF3Y5SFSk2USP/cMHQYhOs0Ag+p+wW1m7ZEF7/kd8xvrYHbSh40GPJSVcfmY7Z663JnvIH0ThGT2WzFz9M4DuWEDpQeMrean0wTkQhNfts8WshrA5OxrHcTfEDHp9kFYj/kFYAYWrLZ8qGQQ0NBb4lMqulbscAtrMaqSEF9sYd0LjFLYLyQBKCDT8a4O0alNyhQxPXYVuFzG08wBpTNSyo+nc3XY+CKOOfUy1EeTdfVZmViAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XOh36W/JRNjEzqaiFqfCjlp6y4DLfE0hTGwK4DC8oU=;
 b=S6/7ish47csoAddCWLnFuQYBc9+Wm19y88vx6nVI9Z8Rg+cDkOb1uJGnNgAg13QTetzYk77LiKZIpfwhSPTGIL0ss+hNZLcE3H6HL4OB3Bghjd3MWISiBxFlwRUUBxVLcfYODIJm2vp1ZOY9oELjuAjaCoU+XnLiMj3EcBMNrCCGHZYDNalIuhu3WPfKHaNVzRcbPQwQTvKTdPUazHpFzTZvzWLttwW7jtSsp3HtKx9hz0fYu+2/Qq16zWNmHi1MqGgJTTTZqjQjWqJj6QTCkjEz5+7QeJHtq9cxu13x7X7s3XmFJWQpequlecDsKy8xoo2XtlRdkJ3aJkT2WcAkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XOh36W/JRNjEzqaiFqfCjlp6y4DLfE0hTGwK4DC8oU=;
 b=Edek+OQsJ2i5wbJtK0w++wEOwV3tmhPf8+JK23O0mdd+hGkQNDPyCcoYGuI2tUUSh6nE77f9WJXYYCE+no5O7JuMkrB2rPzTS0a1c3fDbRGHi3w3cRqvIwF4L3WqsbLJVJ9oAZBbJ7F9+IFQNEZNX6+bnGuyX0rDWnOGX1Dl9DM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 02:53:58 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 02:53:57 +0000
Message-ID: <ccfc3dcd-a52b-7649-fa8e-89a6ac7ebb3c@amd.com>
Date:   Tue, 28 Feb 2023 13:53:46 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
References: <cover.1676043318.git.lukas@wunner.de>
 <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0163.ausprd01.prod.outlook.com
 (2603:10c6:10:d::31) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: cb097f99-3cc8-4cc6-b6f7-08db19370972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdIRDRpnfR+yvir0k+V9mJ7lGiK0lhYiP4NCoa/ok+CFVtLp4mDPSU9U1T+nmdWu8U1xa1m28/6Kn5MhOf8rm8QJeOKELOi642RNNP+1sMrJYai4BbEVLgWmdB+THXrDInIhMZVc5LQvOknwC6/2LbEDdW50hZ5XecotMqozVMPgjvsePIK/9X0hwmc57actkiBlfoGsNOmNeGsGS1b4ZVZiv4C7hlL5mGWscA51bB5uvgJcbhmfqMBNPNBfN/hgvZbpkdI7ib1pu91U/ErQNw0hQd07fy0QJ7OIxYVPR/+V/1AyLBSMU8/4jdwZa/Zx9alBuyjflbFHBOeiUI7ni1eobSC/MZ3fl4/bzZ5jhOhLhfI0L8xY7KAv6NR3H+NSikfV+llzl8N4ItBQIa61aoUhtMcoAyWujL6fVhEuHo4S5hC6VVTdOeVmn6cicjmoWnhAIh23jY+75shweKs7fPAxuYHHGF3ta+SJHjVQztxPANNgm77/fDeNVIeI9uwdB733bnr0qD3qpVEXNZgjXbUlg2jCKrPff9ml6mdKHiC7BdEXXpuV39d7g9bofP81XrttC69MLYeDu5tIT8apBr6Fx1Jtkc7MmzdJXk6LmU5el9rZWmcsMkd54rYf9+6uEsXFkAI8ZAfPV+RpI1OQSIzd8HN//Gf7ROn7O7jcnuGYy90joK2WTyB/0S8b2j7KyU5m0QX2PY7eeAeYmA661rxNRXGdzHj3J3NrYeHBO1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(31696002)(7416002)(5660300002)(36756003)(478600001)(83380400001)(6666004)(6486002)(186003)(26005)(53546011)(2616005)(6506007)(6512007)(4326008)(8676002)(66556008)(66476007)(66946007)(41300700001)(54906003)(38100700002)(110136005)(316002)(8936002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1hanRBa0VMR2Y0eW5IY3A5Zk12SkZWSzNXZUl5QjZJRTJYY2RtNDZ6ZU9H?=
 =?utf-8?B?MmVyM2gyRVU5VTV5SGdxdDZtV1lYQnVSY1BWcXByUExBaWZrVDJVMTExcGlL?=
 =?utf-8?B?VmZ2ejFFY25UWlZEc0k2ams0aDRwaG5zOUxWQ0JMQUFMT05sRmZ6UkhSekNi?=
 =?utf-8?B?RWdMS2thRitKOHh1WmFkZyt2UmJiVlVNZHczMEtXZlcyMWhFTGZ6Z0JNZThC?=
 =?utf-8?B?OXM2MmNGNnNqQnVJSTh3YUVqZTBENGQzSG1IQUZRL0FIc0d6UXcydFlHcy9T?=
 =?utf-8?B?OUtjYUl3L3RuYXJLTENTS0loQjZVYVMveWljZVZ4N0VuZ0JXdy96TDhUbVhH?=
 =?utf-8?B?RTZDU1UxVHdtaSs0WVZEZGRqd28wdUppd01yQzM0bHJkZHZIbzlOVGwxNUtH?=
 =?utf-8?B?Y2E4UGNSTVdLYXIwcndyQWpXbThQYWVCbTNZYzJBN2Roem1UaVRKeGZaV3g5?=
 =?utf-8?B?VHpiTmFXa0taaTZmSFlvaWl5ekpWQlBwSnc2VU5rM1lFeWx5Q0pTVDQ2SWJK?=
 =?utf-8?B?R0RjOWdkWU9TQjBnaW92bXIwNzZveXFrOU43bzJYSXpsZHpTa3U2eGVVRGJx?=
 =?utf-8?B?TjdLdE1JcThHNjA4dFB6QXdQOGprUVZ5YmQ4SEJ0SnQwQUJWSCtmcmFKa09h?=
 =?utf-8?B?dElqV1haeEs0WlNVQ3p6V3l3bmtraXBpL0FJOW1BdlhISWVxSzl2RHc2aWo2?=
 =?utf-8?B?bHhGanNyMmpLaTJFN2lMUnB5akV5ZnV3djJEVDVYYzV0QWZieXZhbHAwRXo2?=
 =?utf-8?B?bGZUWEV0cUprU3hKMjdlck51a1dpMGhNRExtOS9MRktudW9FM09wckFZK2ZP?=
 =?utf-8?B?bUI0SGhkY0lCOXpmZk5Md2tERUJpWUxvQmZOdHc5Q09oZVJiZTI4WG5DR2ty?=
 =?utf-8?B?MTIyTUtlYkNWM21OZjdZelhma0oxNVJocDhDRDJCbklHaFhmK2pTVCsrdDZK?=
 =?utf-8?B?VDFXUVpYdStpVlU4eHY5M3MvTzRqK0lJVlFiSDZmSkZlQ0ZjS0NKMTNEQytQ?=
 =?utf-8?B?aEg0bnNtWmMzRTBjM2YrS3lJYnVzd3dQd3R3YUdwQ3RmbFZvUEdqcFdieTN5?=
 =?utf-8?B?NTVZWUx1aC9mdFEzWlRVbWZlaG5hVlhabWorWHYycTRBQ05EbndrTU12R2ZH?=
 =?utf-8?B?TWp0dFp3aTJoK0hjc2psYUE4WEl1OStCdFl1d25SUUJtOCtDaFFBTjRYQTJy?=
 =?utf-8?B?anNvblVlZklzNlpmV3FVRkpuOEorS2FQUStWWmpMTTdiQ1JodElpeFZWWXZT?=
 =?utf-8?B?NDZPZzEwZU9DKzVYcXZWakpSSmpQdUhsTmU0MkV2TnZNRVUwb2pyNHdJOXBm?=
 =?utf-8?B?SktOOW5aQ1NVQUc3WHFrZDJuOWhpT21oMnZNRmlDWlN0dUdObkVKUktmWUZo?=
 =?utf-8?B?Y0NybDZsZDZBeHNZWEZDdmlSMTBtNzNhaGduQ29FRERPS0huNDFBaG1MMWZH?=
 =?utf-8?B?TGE3bkFNeGZMd0I5dWYzcEV0VitvUldUY2RVWUxxTmJ1REZrU0syUldjRW5T?=
 =?utf-8?B?MkhXbHRMMWpGemQ5c0VyZmthbDk1MjlBUCtuZzA4NTBRSERKTi9OOURNNllr?=
 =?utf-8?B?M2xmWW9XZTNzelI3bGJTTjEvZit4WXV1UmVpckxKUFdvQjJhMkNFYTV4ZmtM?=
 =?utf-8?B?Z0M1T280OGxkTDFORnZDeVRzL094TW1ZdXhQQ3AyTFVkM3l5MEVTOXZaN0h1?=
 =?utf-8?B?TWlqSG96eGRIdStmQVErLzBVNG4zYXFva0ZaNFNQUk1JNGhQM1pEVTdaMTVx?=
 =?utf-8?B?MnFCWUZFdlU1NEg4U29FN1pBUmtJaUdWclQyYTJkN1lZK1BwdDNuM3V0bVhn?=
 =?utf-8?B?c2lGOWJWWjZsN0s4d1NqUE8rMkw4VnEvWE9tcmwxZjB2WWlFdndxQ0Z4Lys4?=
 =?utf-8?B?aHFGbWdkemlWMjhHcnlYekNBeDlBcDJTWGdXUlh5RG45c2FVUUlVQU1ZZTdP?=
 =?utf-8?B?Uytyc3l5Q2JBM3pjR1RkSnVrbTBOdW1COW1ZMWQwdzNpbURnUm0wRmF3dmtI?=
 =?utf-8?B?MERGOGVPcWNRM1ZIYkx2dmJXeVVaR0ZSZHQvdjZLZGM5VzFSNjkyQUdoRGND?=
 =?utf-8?B?WmZIb1hOVU5HWDFhY0ZydVViVlNjWVVzdEFwYzcyNWpLRXBzNW1VMENGR3d6?=
 =?utf-8?Q?kfLB4DBY9cpA1gv865fakmY3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb097f99-3cc8-4cc6-b6f7-08db19370972
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 02:53:57.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNXOGUSa6nJCEO6Qw3Rztgm3PUh3Tv5Oy/2HsL1GBBgR/caGpap/ZFm4JlVG9s53OB9VIikFlOFrp+PJ/koPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/2/23 07:25, Lukas Wunner wrote:
> The CDAT exposed in sysfs differs between little endian and big endian
> arches:  On big endian, every 4 bytes are byte-swapped.


hexdump prints different byte streams on LE and BE? Does not seem right.


> PCI Configuration Space is little endian (PCI r3.0 sec 6.1).  Accessors
> such as pci_read_config_dword() implicitly swap bytes on big endian.
> That way, the macros in include/uapi/linux/pci_regs.h work regardless of
> the arch's endianness.  For an example of implicit byte-swapping, see
> ppc4xx_pciex_read_config(), which calls in_le32(), which uses lwbrx
> (Load Word Byte-Reverse Indexed).
> 
> DOE Read/Write Data Mailbox Registers are unlike other registers in
> Configuration Space in that they contain or receive a 4 byte portion of
> an opaque byte stream (a "Data Object" per PCIe r6.0 sec 7.9.24.5f).
> They need to be copied to or from the request/response buffer verbatim.
> So amend pci_doe_send_req() and pci_doe_recv_resp() to undo the implicit
> byte-swapping.
> 
> The CXL_DOE_TABLE_ACCESS_* and PCI_DOE_DATA_OBJECT_DISC_* macros assume
> implicit byte-swapping.  Byte-swap requests after constructing them with
> those macros and byte-swap responses before parsing them.
> 
> Change the request and response type to __le32 to avoid sparse warnings.
>
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>   Changes v2 -> v3:
>   * Newly added patch in v3
> 
>   drivers/cxl/core/pci.c  | 12 ++++++------
>   drivers/pci/doe.c       | 13 ++++++++-----
>   include/linux/pci-doe.h |  8 ++++++--
>   3 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..d3cf1d9d67d4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -480,7 +480,7 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>   	return NULL;
>   }
>   
> -#define CDAT_DOE_REQ(entry_handle)					\
> +#define CDAT_DOE_REQ(entry_handle) cpu_to_le32				\
>   	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
>   		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
>   	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> @@ -493,8 +493,8 @@ static void cxl_doe_task_complete(struct pci_doe_task *task)
>   }
>   
>   struct cdat_doe_task {
> -	u32 request_pl;
> -	u32 response_pl[32];
> +	__le32 request_pl;
> +	__le32 response_pl[32];

This is ok as it is a binary format of DOE message (is it?)...

>   	struct completion c;
>   	struct pci_doe_task task;
>   };
> @@ -531,7 +531,7 @@ static int cxl_cdat_get_length(struct device *dev,
>   	if (t.task.rv < sizeof(u32))
>   		return -EIO;
>   
> -	*length = t.response_pl[1];
> +	*length = le32_to_cpu(t.response_pl[1]);
>   	dev_dbg(dev, "CDAT length %zu\n", *length);
>   
>   	return 0;
> @@ -548,7 +548,7 @@ static int cxl_cdat_read_table(struct device *dev,
>   	do {
>   		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
>   		size_t entry_dw;
> -		u32 *entry;
> +		__le32 *entry;
>   		int rc;
>   
>   		rc = pci_doe_submit_task(cdat_doe, &t.task);
> @@ -563,7 +563,7 @@ static int cxl_cdat_read_table(struct device *dev,
>   
>   		/* Get the CXL table access header entry handle */
>   		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 t.response_pl[0]);
> +					 le32_to_cpu(t.response_pl[0]));
>   		entry = t.response_pl + 1;
>   		entry_dw = t.task.rv / sizeof(u32);
>   		/* Skip Header */
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 66d9ab288646..69efa9a250b9 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -143,7 +143,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>   					  length));
>   	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>   		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> -				       task->request_pl[i]);
> +				       le32_to_cpu(task->request_pl[i]));

Does it really work on BE? My little brain explodes on all these 
convertions :)

char buf[] = { 1, 2, 3, 4 }
u32 *request_pl = buf;

request_pl[0] will be 0x01020304.
le32_to_cpu(request_pl[0]) will be 0x04030201
And then pci_write_config_dword() will do another swap.

Did I miss something? (/me is gone bringing up a BE system).

>   
>   	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
>   
> @@ -198,8 +198,8 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>   	payload_length = min(length, task->response_pl_sz / sizeof(u32));
>   	/* Read the rest of the response payload */
>   	for (i = 0; i < payload_length; i++) {
> -		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> -				      &task->response_pl[i]);
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +		task->response_pl[i] = cpu_to_le32(val);
>   		/* Prior to the last ack, ensure Data Object Ready */
>   		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
>   			return -EIO;
> @@ -322,15 +322,17 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>   	struct pci_doe_task task = {
>   		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
>   		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> -		.request_pl = &request_pl,
> +		.request_pl = (__le32 *)&request_pl,
>   		.request_pl_sz = sizeof(request_pl),
> -		.response_pl = &response_pl,
> +		.response_pl = (__le32 *)&response_pl,
>   		.response_pl_sz = sizeof(response_pl),
>   		.complete = pci_doe_task_complete,
>   		.private = &c,
>   	};
>   	int rc;
>   
> +	cpu_to_le32s(&request_pl);
> +
>   	rc = pci_doe_submit_task(doe_mb, &task);
>   	if (rc < 0)
>   		return rc;
> @@ -340,6 +342,7 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>   	if (task.rv != sizeof(response_pl))
>   		return -EIO;
>   
> +	le32_to_cpus(&response_pl);
>   	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
>   	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
>   			      response_pl);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index ed9b4df792b8..43765eaf2342 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -34,6 +34,10 @@ struct pci_doe_mb;
>    * @work: Used internally by the mailbox
>    * @doe_mb: Used internally by the mailbox
>    *
> + * Payloads are treated as opaque byte streams which are transmitted verbatim,
> + * without byte-swapping.  If payloads contain little-endian register values,
> + * the caller is responsible for conversion with cpu_to_le32() / le32_to_cpu().
> + *
>    * The payload sizes and rv are specified in bytes with the following
>    * restrictions concerning the protocol.
>    *
> @@ -45,9 +49,9 @@ struct pci_doe_mb;
>    */
>   struct pci_doe_task {
>   	struct pci_doe_protocol prot;
> -	u32 *request_pl;
> +	__le32 *request_pl;
>   	size_t request_pl_sz;
> -	u32 *response_pl;
> +	__le32 *response_pl;


This does not look right. Either:
- pci_doe() should also take __le32* or
- pci_doe() should do cpu_to_le32() for the request, and 
pci_doe_task_complete() - for the response.


Thanks,


>   	size_t response_pl_sz;
>   	int rv;
>   	void (*complete)(struct pci_doe_task *task);

-- 
Alexey

