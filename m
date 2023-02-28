Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9D6A50C9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 02:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB1Bpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 20:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Bpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 20:45:50 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EEF21A3F;
        Mon, 27 Feb 2023 17:45:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArV+l/FHX1YvsBd85wsMkcZ0RQIKnk6pVjSC51fQuy7vzvt8nZO8p+QDDqhfawmfnoEUoDX4h0IlRcVa+dxpDizSaJ2/OqjUe+A19cDXLmLHTRCStGnpmYFazudq7ObghggvUlkVzr56qdcRU4Mj2SYWFLDhEyYkXlsscAePc4tP04d3g8qXfNFUJsdi1BR7ppGOyUoZMCr3+yb88/u8/CvFinOxG81dFtMBaBB/va54sY03tehQWXCrInbD1rZeq7Mves2crwIki9QZpR2LlENhl0s/TUtzlvj0FBxsOSXEYXKX96dyIcJQXO966nzXvxo/ploEu+90Ax7LlN+yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqCI9/C/RwjUDzCiNedwrmi65JdKR7UYg/33h8ey9ec=;
 b=ADznx0Rl2ECEX5EBjEGIqM976kJ6YyXKvxMqpF8nW8+wTBkEAbFNlDWWIo+68l9Ym3P6wuQC2OfoH3rgRONXEpKT4PocraTIMgQG8WbBjY771/IO2OTQaz/hjwnUgKVJr6fdJnd9eQ7ZmqAGhq26rWzVdzGcvO51IjT2tvHpf/fSX7l/fmp8ig0f9H1J++R/OFvDbRv/wwHAvO9A4nhTV7Owq2mBWXUaQAsUXytOq4k6psw0WhSEf2kj8HlMVQPcaeaZnhUo7hhA0kBfv+ZAdiAU7WaRiYQxWRS62L2U5Py+qhYDPWa8N3y/oR0QkfoMYm6BEhhW98lb4qul3N0w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqCI9/C/RwjUDzCiNedwrmi65JdKR7UYg/33h8ey9ec=;
 b=UBqi2/2XcwOu20OZebxPWdHuplsesAFeQTd0WJRhlKiCHX7flH7qSld12Z4oL02vpysa4r7uYk2VlkIyaFqsBD7P52UvqBnwrKottnL8Kd1g2quh1qNAN8rA2ZsfyEPcEWtByCbfUCdTqHvEYq2W+W9nuylDwloPfgr/8iItnRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Tue, 28 Feb
 2023 01:45:46 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 01:45:46 +0000
Message-ID: <10f9baf4-7fdf-b105-9222-5a1df59e2993@amd.com>
Date:   Tue, 28 Feb 2023 12:45:33 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 16/16] cxl/pci: Rightsize CDAT response allocation
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
 <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <49c5299afc660ac33fee9a116ea37df0de938432.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0068.ausprd01.prod.outlook.com
 (2603:10c6:10:2::32) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 5546dfd6-ca94-4da0-5925-08db192d82dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7n6CPMnZP5Heneum+/rCdezyAA/R5ZvAYUT7GvMOEXeG3XPmEtu+3TzoZxvS/B3lndDOsy/O5w0GYxdu8+HsY3AffYHlKzktTlM3Zdeh0O5eDJberbXePcH5l4S7RQ1XyQsfoL5l5QLkxbunPVK7+eH0BoNevNsmZaMGzgeUfhSs967BSU65mxDIInXhZpiIZ447bHwilJJWzg9G2lVvdHlRdHu7++/iJ45ZZ/ZU7cmfMUcOQpsFooP7CPABl2rE/8fVLLKJ/jPGxD9RJUMMiqbHYKvy+yPu4iCypMvy5VnJLSifn/BgnpOP/PLadqPBWDEpQLUpFnl84qcnx/gFJ2RdbbtCmMUb+o2800jE7fCS9BmqL04T+DwfYr1ED7bDIfT6LC/IO/YjsqvMhsX+1IuAFC61ul8DWpSZ+MQf17Mpc+lg0rEbxdYT1BNBELvxtntUuggBkDBRRpCE+AzeXW8Oah/AqtEWqEuq3hC1Y5OSveAhw37KAMNuEu48SanAwTf/2flF+QVKkkLfIOG33JJ80ehsnNM+7Zyd3d3tS7aN2I4U/s767gI9QWb4nII4tWkPrJ0XvpnxEiQ9x0ybuA+DVeDb4gBD2YuErjj/I8gn1YvZylMXhhsr8xz/E/wqV9yXMz4gPFZ3Eupconro2o3w3ugJQqKpod/GqHFm/ew+yQmx3GlSFjHhsZoE0Lst9UCWh5KdTNzfI7kR/FZi8L4ngIlu3w8F9uz/yQh2hnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(2616005)(66946007)(41300700001)(83380400001)(26005)(31696002)(478600001)(38100700002)(8676002)(8936002)(186003)(54906003)(5660300002)(4326008)(7416002)(110136005)(6512007)(6506007)(66556008)(6486002)(36756003)(66476007)(53546011)(31686004)(2906002)(6666004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGhCUGQwWURnZGxNS3VPdmpoN3ZaNWMvQ3dzZUM2NzVlVWdJQVVnekU2S2NY?=
 =?utf-8?B?THZ4UFNXNjZMdnE1S3dsZERUMXR3MzRQTUE0NTROWWlMQVA4WnAxZWJaY05Q?=
 =?utf-8?B?d1p3RWI4RnhTY0tRV21VSVFCdmFvSnRhSnlRNjlsUHB6bGNQeW53S2oxRE1j?=
 =?utf-8?B?T3lGdzhlU2NkNmRaMEJTam5tMkNLVHJtYzVWak43VDMveEFsQ0VXc2YvdzZx?=
 =?utf-8?B?Y0cyWURJTklvbEdjbVhLMmhzQWpZUlVnNXRMVzB3dzJGWkNvV0JuWlNsOHl2?=
 =?utf-8?B?Q2lINHEyeFAyQXlCdXRpRk9IOXhjcU1Rc0ppMmQ3NDZTOHY1VGJpSmdZaktJ?=
 =?utf-8?B?VEtXcDZSdUZtWFUzUW5ocVM2NW9RMkxQM1ZoL1pWd2I5MHhZajJ4enk2d3dp?=
 =?utf-8?B?d0w0ampYbXBLREExeWNTTTNTNTFsT0ZJeTUweXZXeWlqZktncVVIUUczenlh?=
 =?utf-8?B?aWNHUkNKeGdjeHZFbklqQ1ZNYkpwOEdwSjJrbmpKZmdvcUNXVE16SlZ6VlVW?=
 =?utf-8?B?OFFKbEdKa2FscHFFM0hXVWVrUHAvS2dTeVJ0MVN3SDFUWndpZnAwQXdpZU5H?=
 =?utf-8?B?dVpCQmx5akltZnJ6NWRwb0hZWEZ5WTNPRVNTQ2hXMVYzS01pV0RmT2ZqRUd1?=
 =?utf-8?B?R2E4OEJyQ2NSZFNjUHF5THd2ekczT2ZFMXVMMXdmMU5Ca2ptT2tDclZtb09s?=
 =?utf-8?B?bWl4N1F2Wnl6M0QzT2hYT0RGQklmbDlDdHN1VDk0WHI3S1JvUXlLd1RlV3JC?=
 =?utf-8?B?R0RRS2NlMi9EdFJZQW5Sc1k3eGhlMDhmM3J4MHRRMWRjeHhKOUozT2pFdTdN?=
 =?utf-8?B?RmdQYnRlSEFBMVkvbVU0R253TjVCQjZkSjBHSlp5c092dFo3VCtRTHlTdnBx?=
 =?utf-8?B?bEdab2RySnRGRGxTT0hBNlQxckE5SW1tWXI4ZEpIQnpmNjM3NmtiQXh3U2Uy?=
 =?utf-8?B?cWV1K2NPS3g5VlRjL0lXaWdJaEFtRzJraWs5ZWRzOU5DQm5FZmRsNk10c3Ry?=
 =?utf-8?B?RElZdjBIamNQbFI1MXNxQjNKaGUyelBZVm9JSkROYVFMMDRtTndrNDV5NGM3?=
 =?utf-8?B?OU5zRUw4bStuZDRjMEZabHd4L05FaWF1Rjh3UnZLcFhlcGhpZHh0SEU0Mng5?=
 =?utf-8?B?dit2djZTM1BkZm85NWZrcGNJaUoxUEVEcDMydUhBaC9IMXZ1aGxmYjdjZXpX?=
 =?utf-8?B?UWdsNHk1SWVEYzZ0dFE5aTVJVytRMW9lM2txR2o3V29rQklYRGhCRVowZFNG?=
 =?utf-8?B?RmlsTUczM1F3TThzVFJuOVpmQzY0eWUwQTZ2eXE2ZFBlRXJYVUwrdGE4SUZk?=
 =?utf-8?B?anBJUXpqZDRXak42SlV3Y25RdzFNYzlzNE9aM1QyVm85aVlWUHJER0hKTFEv?=
 =?utf-8?B?TlAvbTgwbkQxT2VjZmVVUytFYVJEZVU1eWFzODQrVUxlbllDYVNIR2hWZERY?=
 =?utf-8?B?TnRIWENoS3ZuVmxrV3lkODJhcjQyRFVvVjhSRWdvaXlDeFNreldwMXRmMG0y?=
 =?utf-8?B?TUtqWGJWNk1GRkMySkdhY2dsa2UwVC9BNjJQU3VvZWhET3BuRk5jTlRoM3lV?=
 =?utf-8?B?Y3R3anBDMWhTdVU2ZW5JZ1ZxWHFtdnQvUU1TUnlLU0QrY05JaU9sbWJtN0pn?=
 =?utf-8?B?V3pCZm9IanB4bGFMcXZDRmdndEk0MTM3eXd4bGprTUhLby90TjhkZVZQdDVI?=
 =?utf-8?B?ZEVyMExHT3NDZmw0MnlaRHh0YWU0ZWZJL0I3YWNXaTVFTW91cE9yeC9peDZx?=
 =?utf-8?B?MDJVTG5yUkNLSk10Vko4RytmVUU2NzYzR1k5NkFmcFZMQWlLb1ltQkxlQXJl?=
 =?utf-8?B?K1M2b1djQ0pZWkI2bE9GOXltS0FvcTRpMFBxZUxxaHVLbjZORXFYRkZjdmxi?=
 =?utf-8?B?bHRFYkRtY2MyVkdIaFJuMW9UM0hKZDZ5Z3BneTdnUWp2b1lTNFZIWUUvZDhG?=
 =?utf-8?B?bzBaWWFtOWN4bGJCNWRKOW85dFFxcVA5eTRocDU2ZUVKMjhuOFdJRGFRZXlY?=
 =?utf-8?B?VkJocW5SNmFKaWpOOHVxUm51NjFaMUxlc0Y0Y014c0UrQVkyUWg5Q1ZyYkx5?=
 =?utf-8?B?MXVVSVp0ZTlIVDFxYVFLdUNXcVl0b1VjcWUwN1Q2RUJWTWxqTThvZExOMlB1?=
 =?utf-8?Q?L2tcTUZMMmIU6mv4mdFZtYsY0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5546dfd6-ca94-4da0-5925-08db192d82dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 01:45:46.5792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IeW2t5icN7nPh9J54a56HmSlBiM0av69WxQh/OEN/ieOexEs5QJIBvqsJ9UGMJ1PrE16Sw2DGN3L/LrQz4+mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
> Jonathan notes that cxl_cdat_get_length() and cxl_cdat_read_table()
> allocate 32 dwords for the DOE response even though it may be smaller.
> 
> In the case of cxl_cdat_get_length(), only the second dword of the
> response is of interest (it contains the length).  So reduce the
> allocation to 2 dwords and let DOE discard the remainder.
> 
> In the case of cxl_cdat_read_table(), a correctly sized allocation for
> the full CDAT already exists.  Let DOE write each table entry directly
> into that allocation.  There's a snag in that the table entry is
> preceded by a Table Access Response Header (1 dword).  Save the last
> dword of the previous table entry, let DOE overwrite it with the
> header of the next entry and restore it afterwards.
> 
> The resulting CDAT is preceded by 4 unavoidable useless bytes.  Increase
> the allocation size accordingly and skip these bytes when exposing CDAT
> in sysfs.
> 
> The buffer overflow check in cxl_cdat_read_table() becomes unnecessary
> because the remaining bytes in the allocation are tracked in "length",
> which is passed to DOE and limits how many bytes it writes to the
> allocation.  Additionally, cxl_cdat_read_table() bails out if the DOE
> response is truncated due to insufficient space.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> ---
>   Changes v2 -> v3:
>   * Newly added patch in v3 on popular request (Jonathan)
> 
>   drivers/cxl/core/pci.c | 34 ++++++++++++++++++----------------


Almost no change from this patchset applied cleanly to 
drivers/cxl/core/pci.c, what is the patchset based on? Thanks,

-- 
Alexey

