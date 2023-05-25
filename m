Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC3F71193D
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 23:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjEYVih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 17:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjEYVig (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 17:38:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFF699;
        Thu, 25 May 2023 14:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgxTauAoVIMSP8e3a29vQB1NKxlvD1WjZQ354/943uxWL3G9qLZJn4delq/ShCXbqfSZ0TL/Zbb73N2AonphX+IRMnW0pRDKYRgFGOPy96cl/ES1EKa6C9iYZ1C2XyBZQ0/MlGDE9NacJSZy25WF9iZnHqiI8tejAU2wx9HE9dkIjjhYuN3E8JzohkPrl7GAMdsPqkdV8hxIwCOFBSmwkFlj34DDi8NuWfBos77+UB/uzAU5ek4tkDCR1XLLIznMyHzAjOweutSCNfDGJgo1o0/fRIofzeUYzdFpMpmKrJYdH8PtAzPQUSENtrlxsaBcdknqIB9VcDVk5hsz83KtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spd97eHgS4wQlSrpq8bmVdxaDmoSJ4du4RKzpofYtSw=;
 b=TSzXK49TwPtG2HnwJuwYxjr8ghtTX/j+V6xypvKiOBWPQLGsSv2egqqd2MjJ+aP8382snDjKgGMIQIH+KIYT3aF229QoJ9ZvbLrBxk6T3dsA38jRVdnpv4T6fJOoXU5KM1sxc/NgiiGev+5btqXxD/VTiiHGLomDRks3FDY8LMmLS+ZQ8pginbLlcPhb8eyG+wwaAiRtaDfiP4QtGLk5xcRuqeKh5nLGMX6Ewj9QIy1hh3Nea5LqjmiYmWiqvSpEPnqhqGQeKBRYcMRvy+TNz4Ythz0K1wEwAvNWDA4WT7F17GhJFh6vqWnjZYK8jFTpxOwQredbSIQ3GSuZsKs4dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spd97eHgS4wQlSrpq8bmVdxaDmoSJ4du4RKzpofYtSw=;
 b=ydbwC8/qyB6824PvOFfBp1d1Oq4KElnyn9dwTQLB+AUTAebhsAvTUnvbm5r5Qs39hoEVjFlnTJZRO1dreH6z/fahtaDLsECHMqwVksB7I91W+OnJ42p8k/boWUV46+2/bZfrmpMPMj4cKI094N8J3eh/5jWNr+dXvyUfAt7up6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 21:38:30 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::4829:e80a:6a6c:4327]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::4829:e80a:6a6c:4327%7]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 21:38:30 +0000
Message-ID: <9599617d-cecf-da2d-b938-80cef8e75e59@amd.com>
Date:   Thu, 25 May 2023 16:38:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 18/23] PCI/AER: Refactor cper_print_aer() for use by
 CXL driver module
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
References: <ZG5BdvAP1OuQVTWz@bhelgaas>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <ZG5BdvAP1OuQVTWz@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0989.namprd03.prod.outlook.com
 (2603:10b6:408:109::34) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:3b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d3bd8-e6ab-414c-7260-08db5d6861d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+9Crzgm2LCsV6KmMlJP3Ol84E+SDeguEL5l+zmSaI772lQnZQhTYArTVtbjIhl805T/pqr6YvgfSDwU9HzBlHl3zcuGJ0i52N7xa7bvyj54d8yDhoEUvUJJ8x0bP5kEeFeuHsbznprYhcM590GUsz8ZANcdsPi8S9i3ZKkUcgmTGr+aCkMMZuKKkJXF+6PfTodoPDtMn/U5kpvbPPAStujGpfpwg4rrwlzeIir53uYJy6tXeLBBi4008z9j/diEi/b+Wca16ZZpaL+vbXk4pc/WhzIwrbk/tZgGy5EXUe9KMrmQD/cIrqyAg0qOXfq0Xexc5O8jrKTKeCZDnvjB8+ZuYYJjA0r3jP7vZOwEVXJLtHYW5XMXiKnG7tFZi4OUcAkWsiC3THanq9QKzFJ6Z1dighQ7YBebT9TyRdGOjxlP0Nmp/Imo4f1yMuqUefnB4h/nLqpcOFt+mxj6MqzXTrY01IqpWC0bKMkf3x81lchFCLTGTAfoRbXnf8sFWX3BuKIfGRIdYRHYqr+9UtsiNb3FS5xlzsdeAIAmgqKdNWDz/zejrwFXRFUTNq5tsxE+c2cJ9WwoXdIAAG6kEN1TlQ8XifFXHbWtKkzxJ5vXhIKBf127EHNEK7ybvZnDiWRLUUxr885wEw+zvd/q8MrLHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(2616005)(2906002)(186003)(36756003)(86362001)(31696002)(38100700002)(41300700001)(8676002)(6486002)(5660300002)(7416002)(31686004)(54906003)(478600001)(6666004)(6916009)(53546011)(316002)(66476007)(4326008)(66556008)(66946007)(8936002)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1JRUN1QW85dTVYVEx1OEI5TUtWSkJzWjFBemsrNDJ5UTJidnZnT3FDVnB1?=
 =?utf-8?B?SEduc2cyaDd2M1FFSUlzSGxKZzRJWDVxY0h2blhHNjA3ZHRqZUE1eENYM2Nq?=
 =?utf-8?B?ajF5TVM5RmNic2JsRFJJTzZrRE54cHhkZys2dHNiZXYwSzFEZkZVcUY5cWU0?=
 =?utf-8?B?aFR0Y250cTRQQmZMRUlVeHZvaEJwRkdQVUYxQXJvQ3E0Q2ZsMnJJZlFtOWNL?=
 =?utf-8?B?TTc5cDY2b2lwaXF3UFJHL3ZTUElFN0JveDZ5NGNmNXJMMEt5SEpQWnBJcW5j?=
 =?utf-8?B?WEJwNXhJQWtrdUFhbFZmdnNvRDdVTXVYTkVsZ3dOcVhkd1pFb2xnVmhtd0U4?=
 =?utf-8?B?eXpVa2VxaGEyc0trYzh4Vi9Rc1VZektVcEJHaEZ2dmlrMUNsQWxFV0lyNVJJ?=
 =?utf-8?B?WlVncHAvbzlFY1hnQjVEOFlUVXdaN3E5NXQwUW1KVWxzRTkzejEvYlhVUHhY?=
 =?utf-8?B?UWZPV090YVpwTHM0ZUt3VjNEWGVEWU9WbGs5d0NJZlN5ZU8zUEE4NGlHUGpE?=
 =?utf-8?B?Wk5HTXo3aFkvd2cyd1BHbVhxdWJNZERSc3NRN1ZTaG9Td2FsSU03aTNMTy9h?=
 =?utf-8?B?UHVEaFdSejM1ZnEzV1dvRFBBajFOS2U4Vk5MbDNlL0R1dWJITU5UWFlUZTRt?=
 =?utf-8?B?UFFsL2NFeXlsSHZyR3Z0RzZvTE5IOFl2YWJhZkxvREN2K202NE9aZFpmdmRt?=
 =?utf-8?B?aGRoYmFjemEvVjUwWDRSblhLQmFkVDdaMGNYaHQrUmFISE8velJCYm5NU0JY?=
 =?utf-8?B?aDBGcnU1Q200RnhLektsczZ2MzdTdnZoTGg0WUptZ1A2elBMTFVLVCtRVUNS?=
 =?utf-8?B?NUV0cU1NdkdyRUUwaXByWlg1NEF5VFBEMEcrQnJRUm5qM0FpVnZVK2RuVE12?=
 =?utf-8?B?NUdFYlJ3emF0cDMwaEV2TXlsdGhvdjJmVnRQMHVUaGhhTzZjWFZsTnFVZlhS?=
 =?utf-8?B?Qk9mUkpseXE2aGpGazIyK1ozOEZtM2Y2Q2hKWlpsVkZCOVJkYldUa2FlUUh3?=
 =?utf-8?B?WER0cTFOWFFGczFjZGUwNlFLaWZyOC9Bbk1uS1hUVXNuRnZWTExjNTJGQXRI?=
 =?utf-8?B?eFVZUzhmb1Q2ZnJvSmhwSW5TM01OT1dpNitxL2hZUXpWUGJJdklDZFh6ZGZJ?=
 =?utf-8?B?a1lRa0F4Y25tSXFTZDRLaDFXeHl2R253cGdYMHdXcnNlKzhVaG1EbUxCUEFN?=
 =?utf-8?B?VW1zTGMyYUxTZFJFRjJpbnNxVncyQ2dZUm4wN05BVWZlM0FKeDFtTzhYWG15?=
 =?utf-8?B?V0xFUFNUYVR6QmxsK0ZIVWM3YW83czdQcGd0ZEN5Z1VVQUxuRzZmOWovUkho?=
 =?utf-8?B?TENVUkhmRGNINUVXNGtNTXhlSGxwaTcrbWV2amZ5cTY2SDVlbGVJMmFReHp3?=
 =?utf-8?B?Y2JTVnVBNFl2RS90TTE1TzIvUUhsVVZNYk1tNnd1WTcwUHc4VWhtOHcyOFFM?=
 =?utf-8?B?bzBlVTNVUmFVakhUK09SV2t2U2VxRnBJS2RjRUVIS2c2M3psd1VLSmNSTnQr?=
 =?utf-8?B?RW1RamZ3UU0rUmVjYlBMdjlHdGpsdDZlamJldFFrUGNvdUVGelBLMFlOTW5T?=
 =?utf-8?B?VHozcVFHeGVQdUJtcWs1ZkJEZHFqY21uc0ZMN2FicHA5Z0NnTTlFV0RkajM0?=
 =?utf-8?B?L2NPdlNzS2lDWHk5anIzalB3Z0RnaUZVOG1XWU9hWmhvMDYxeUNMNVd6RzJM?=
 =?utf-8?B?bklIbStLOWMxc1l0dEIvOGkzbWVsR3dNanhraVJ0cVduY0xhNzlGYkxJU2NH?=
 =?utf-8?B?WmVLSE9EMHBPaFBWamdOczlYd3drOUNYbktiZm45OFVUTWNkNHdCZUl5em9y?=
 =?utf-8?B?eWkwNk1SVzI5T3FvYzJXUytQK2FvekxkNzl5TXhxdW84WGVDL2dDMEx6TTZW?=
 =?utf-8?B?RXhpb0lMVk9CNzJBeEE1Qi9RdUtkc2RydVRTZDdkMlpYL3daSm8xdVJZVnhk?=
 =?utf-8?B?QmU2T0o4cXh4S21iVnZSU0I4WUEzSmdLMldJRTNnTm9FN1JscEhyYS9HNU0r?=
 =?utf-8?B?b3gyZWsrOWwwWjQzajlsK3ZIMVkwZkxpbktsbldKNkpHSHB5UGw1dFpGdExs?=
 =?utf-8?B?a01CWkR2VHUvejZDaW90Ukppb3dnU3V6WXhzYnpDUUR5ZElqQ3kxWnhFdGI3?=
 =?utf-8?B?UzZ5Q3hhbzdYNFJJSjVsL0lEUjV1b0YvWWllRmg1NXc4TFZ1RERGd2tDTjIz?=
 =?utf-8?Q?fFxFF8othDYki1D0816LmXH2gMhxvORAslX5HBBEH//Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d3bd8-e6ab-414c-7260-08db5d6861d1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 21:38:30.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaSBHZskfAYG7mX89vo155eNa98y1SWvJxd5lYxDnBd817+6PzfMC7v/iHTC6CI8aVCYFZ5UZC0Mj2uTBM4bSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/24/23 11:55, Bjorn Helgaas wrote:
> On Tue, May 23, 2023 at 06:22:09PM -0500, Terry Bowman wrote:
>> The CXL driver plans to use cper_print_aer() for logging restricted CXL
>> host (RCH) AER errors. cper_print_aer() is not currently exported and
>> therefore not usable by the CXL driver built as a loadable module. Export
>> the cper_print_aer() function making it available.
>>
>> The CONFIG_ACPI_APEI_PCIEAER kernel config is currently used to enable
>> cper_print_aer(). cper_print_aer() logs the AER registers and is
>> useful in PCIE AER logging outside of APEI. Remove the
>> CONFIG_ACPI_APEI_PCIEAER dependency to enable cper_print_aer().
>>
>> The cper_print_aer() function name implies CPER specific use but is useful
>> in non-CPER cases as well. Rename cper_print_aer() to pci_print_aer().
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 

Thank you Bjorn.

Regards,
Terry

