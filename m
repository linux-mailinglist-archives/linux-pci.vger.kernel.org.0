Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AAF79C0B2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350402AbjIKVh7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244405AbjIKUXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 16:23:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9A1A7;
        Mon, 11 Sep 2023 13:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCRAYqLP8LfPtqE7fYWUbaKImXbpxfswgTc8IPnJNFVRKOrH3osKusVwgXIFBDHyrHlQjkVK4jKN9UMqqoTeDpEdfGc1zT8dXeqHrQdZRZ+1LSJ5IKKumNoAmvoaoz6vtBp/0EII/IhuNMudFkj725Oj0eGbJMbVmmHeN/IUyqnzHpb2g7AongluVuMoXgeTvjXpT/5DnXFHtp2y3A6EteM//VTN5D4YZjLyTu1WDYjlr29njW0Me1+fgzJqF2dlnLwGzsaan+x/KWN7tvWv8wFPdDBV2NOQf8gBPYTK4GzCb7Z6Q7xNVIJdGnLdrWHoR6xiwdDX8yfpjSv++X6BUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjlnqbTCyXZcGPQuajvQco2dWajzXilkERB8eXHeCgQ=;
 b=CnDG6ZBn5XST2OnWyeFjN1TQhALSEfRER054ehpRwR/8T9TVxQYeK+SqGamg0R0UD/zF2f8GZQe9depahVR3uJnf5+StjZsEuo1WUg21BfYAQVwA2oIVrs/Uu/DVVEMc2AeN2Xs0uop5NoPT8abBhx3LZ28vIZbN7SRZTXeacrl5naEEST6X+DWeg9LK8WwdytOR4jklcJxHT1K2NQosld2+7e6cZM6goSoiOjOultCO/E3ix2Lk571Xx2J81DcdRXbCG+zFbcS0gyagDeedoPbI0X6tGHcA+7oW/JLfL2kIWDIltRD51nJosHccFi9s4khYz5vFSh0PhWD+QlGz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjlnqbTCyXZcGPQuajvQco2dWajzXilkERB8eXHeCgQ=;
 b=OH6pPsEFyZI1aMYfq8xvt4gT9qDFCAJnPER6W0tsVKsMuMbFgPacdMWLwYt8VcZ4o88GzR0fVZOId7DkDzRJfnXkmqN1z3eTNXblD/LOyoulVkFkF2T/zXWNi9nRphGdOW5RavoMbxwq2iy79LkWl5nLvpKitAMUCUy1Vs0eS6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 20:23:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 20:23:40 +0000
Message-ID: <0cd6648d-21f1-445d-95f6-20f580bbcfd1@amd.com>
Date:   Mon, 11 Sep 2023 15:23:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/4] PCI: Add support for drivers to register optin or
 veto of D3
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org
References: <20230906184354.45846-1-mario.limonciello@amd.com>
 <20230906184354.45846-3-mario.limonciello@amd.com>
 <CAJZ5v0jgGOPcFMfRObAM1St1KLjZS0tEki4f32Rbr3ZXwFyFzA@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jgGOPcFMfRObAM1St1KLjZS0tEki4f32Rbr3ZXwFyFzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM8PR12MB5462:EE_
X-MS-Office365-Filtering-Correlation-Id: 398c9418-2552-443e-b07d-08dbb304fc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQeH8PEPSpEeFtn4o2BGI9WqkTCuphJvdoBhhso1w0WshJrHqXegmfnt6/WwzmEana5z8LoCjqnC+uZxrXbV/+Ejse7lq6C4gKGmDjKpGuHngdStbFs4LJm/TFh0q0WZNzdOpWbejpBM20Lt8wM9V12WTt1FV9kMHptTqEdFn+zOURuG2XAzLZ8akhW0pMvAEkmYfYaAW47rvxwlKP4y4dvXN8qkGU7DQIAVJuuF/RURcAt72VMSscJ5GoEdhVfPtkwtLI2xxLiC3sxoTu8812icuuGNJVU90O/US0DGFdB+GhACV8/CLPqTqlftVU4QCvqju9izlzk3sbsiRMTQivegCYcWd5gcakatZIj4faY21GYatptHjiT+kXioHANodzU1Zc/Pxt+TW0uZVaI/NPtHioV8l6LDxF+mIVGHW6dwMK13RgGm2zkSsdr8b7hK3MjTNtkyv7LgJEcbZQdZXMVvekpt269UFXZusdJjIHVJ519IfAwAfBcij2DWgBC+U0DK1DBdt6mFLulnfLaaor9DAcbiO4o+TIWEuK7zeqV7ZWpIF7EIo6Yo5h0zn1+ms5FjdME7FKxAdAOxrijqhDp6YMZfDzLI2Bd8OKUeyGFm7u6q5HzyZuYuPYjA7By8WzTyLAY/Y1RrjfHo//oYrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(186009)(1800799009)(451199024)(36756003)(8676002)(8936002)(4326008)(31686004)(6666004)(6506007)(53546011)(6486002)(31696002)(38100700002)(86362001)(5660300002)(2906002)(83380400001)(26005)(41300700001)(66476007)(44832011)(2616005)(6512007)(66556008)(316002)(54906003)(6916009)(66946007)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFnYmhDTHhvVjB4NW9iTUovUVNvUFNmeEN0U1FDZGozU2JVVUFFWmJFNHU4?=
 =?utf-8?B?aFlLcSt3VVVaYWI2TFpzOW9mQTY4VUVaTllJdi83YkZRZGNrdm53dkNMSndj?=
 =?utf-8?B?alBlUWpmaEdzbTV6NS9yVkNpZUxlZVd2Z0FlYVRPekRkdmpQLzUrSDUwdWRR?=
 =?utf-8?B?Mmk3cWZHNmJqaDNGb28rTHA5TnZ2ZEowM0NBVEt6czNxVUQxYzMxRlRqYW8v?=
 =?utf-8?B?TWQxM3ZzZ2hCWjVtbDB5YnJudVoxQ1lyLzNTci96eUZJYXh6QVMvczVueGJO?=
 =?utf-8?B?T3JEMXhRMzI1Rzl2K0dvOVI3L29nRzNuakdmbm02aXBtbzNCT2w4bENjT0Nw?=
 =?utf-8?B?R1pCRUx3OEJJdEE5R2hvaVRVQTUyY3R4VjJ5Zk1abStUY2xSWHl1QzdISFht?=
 =?utf-8?B?cFlnTTBjcmo0bDgwRnRiR1ZHOFk5blpzVTJiOTh5VjdQQ1cvc0YxZHJna2hL?=
 =?utf-8?B?bVYrb0oxbE13QXRUbW9zSDQzOThDYWZMaWJITDJwRjRTa3BjRHE4YmRZN0dy?=
 =?utf-8?B?R25UVS85andLcnkzWTI0V1ErODBoWE8yQXRYcnh3dXB2UjU4cHNRbC9oTjMz?=
 =?utf-8?B?Q1NEajVPUWQvTytNOU5hN3E5RUZwTjkrMk8yUUpwR0IydTZPZEhTeXB3a3pk?=
 =?utf-8?B?L29oaGRrL1BJWnlvNnBEdld2NHRVZEN6dXBieTk3eTU2L2dVR2lETStoelZn?=
 =?utf-8?B?YlAzNmZEemFaY2plQmNuT09UMTA4eGwySmNOdlp2dk9PZFNZNXYySENVNkJZ?=
 =?utf-8?B?MmZpb3VITlpUa012WUlrclgzRTZuZEFQRGR2bFJlc1Awa1M1dDhTOFZWSFlv?=
 =?utf-8?B?K0xTTTJzY05QT244R2tHUjZTWTZQbDV3QW5WcGxGSXVWTDNCWlJIQm05cEhv?=
 =?utf-8?B?akg1dDQydHJONFZkckxLOXRVdmJKQXp6ZTBjUTgvV2NheEFvSWtqY0c5dFBW?=
 =?utf-8?B?SitoMUZYZmdLdDdDZEZHaitGeXZPR1hybm9NUDBybFhsMXpvd2hzVjB1b2la?=
 =?utf-8?B?K0ZFTnE0amFQNmdwam9YNlhFbjRYK2JDUlZwODNQaEVDc1htUzNhaC9TTnFJ?=
 =?utf-8?B?bmlkeExYUjhSZU9KcGlENEZSMXJLQURLaGViNmxkN0xWWjA0N3lyVTVhaEVM?=
 =?utf-8?B?R1U3a3hTanl0d0Naa1FNdWJ1Rml5Mk9xMnF6TjBBcHVVR2taL0RyUS80VEdx?=
 =?utf-8?B?RHNLWng2MThpdnpXa0huU1lvY3AxNWo2R3VZWXBaQnFBY1lTSlZaM1Zlc3U0?=
 =?utf-8?B?WlJZRjA0UHVhbU9wNjRVZ1NrUVpIWVJsT3NjM3ZOWWUwOUd3RGNvSk1HUVFo?=
 =?utf-8?B?MkwyNVI2MTYra05pTzN6WFFVenc4ODZpaUUvUmNIMVFNL1VTNC9lNmhmVW5m?=
 =?utf-8?B?T3Q3dUpVNjlLTE9HNWpiQTNjaitDODFuNFFDOTUzRlgrbDMwd2gyWGR1djdt?=
 =?utf-8?B?YnMrMkxFT3gxQWV0Z0lNRENXbmlLaGNEa3RleG1ETm5UUjcyTFFUR0xOWHVw?=
 =?utf-8?B?VDVlU3FhM2I0cWZCR3d6S1Zid2p1cGpPR0xUMDdIU1hmRnEycU53ajhjcUpK?=
 =?utf-8?B?clFTRWk0aXpBbjFaeU1INnl3Y29XZWNDTlpsQnVjeFZQSlBRdTF6Mm80ZWFx?=
 =?utf-8?B?QWR4WUhzdHZHUndjNm5HRFU4WWtrUHA4TDZtNVdaakRLZ0JjNTdFRWozK3dP?=
 =?utf-8?B?V0FmR2J6U2F4TExiUFdTNWJRdHR6QkZ2djhtTWMrQ1FwcWlUUFdvY3doUVVi?=
 =?utf-8?B?UFpWZDVDT0FXM3lxRktkYTNYWE90OUJnRDRxWisyWjFRTytwbEFoUjBlSEc3?=
 =?utf-8?B?czVGWTZYRnpoYmpHVTY3N0lWcXVWN3dOZy9KM0lCOVhjNExZTmhKVHowV2R5?=
 =?utf-8?B?NW9FcjdCc3hqM0JHaDYvSDVpSmV1TG56aE0xazJwL29pYk5taEQ0WWNNMEJa?=
 =?utf-8?B?S3pZMzBYbXg3NHEwcWNIRWpQL1VueVRxNnJxQVp1SXJ4UG9qcmtuQkx3QzQ5?=
 =?utf-8?B?bW1ubUYxYVhWOFBDdWZ3Ukw0ellvdlNDTElXU0tFTEUvejhyNFZoZ0luaHl6?=
 =?utf-8?B?dnA0VHFkS25HeFJUUFJLc21rNTVjTndiUGQvUVhHMllOS00yWFJXaUJCQm5C?=
 =?utf-8?Q?wAaoNVfzBImmzhjcYpeYHUvDH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c9418-2552-443e-b07d-08dbb304fc90
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:23:40.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoVzF4ROD8BN38pkg/8hXiSrH02ig2g9gbiSTSzYozF+tfOJvCV90A/QMVQWy4HW5/RxoHu+AgvPOFPyFSKgpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5462
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/11/2023 13:34, Rafael J. Wysocki wrote:
> On Wed, Sep 6, 2023 at 9:16 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>> from modern machines (>=2015) are allowed to be put into D3.
>>
>> This policy change has worked for most machines, but the behavior
>> is improved with `pcie_port_pm=off` on some others.
>>
>> Add support for drivers to register both 'optin' and 'veto' callbacks
>> and a priority which can be used for deciding whether a device should
>> use D3. When drivers register the callbacks, the list is sorted by
>> priority.
>>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c   | 143 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h |   9 +++
>>   2 files changed, 152 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 59c01d68c6d5..06ab73f58adf 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/module.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/string.h>
>> +#include <linux/list_sort.h>
>>   #include <linux/log2.h>
>>   #include <linux/logic_pio.h>
>>   #include <linux/pm_wakeup.h>
>> @@ -54,6 +55,8 @@ unsigned int pci_pm_d3hot_delay;
>>   static void pci_pme_list_scan(struct work_struct *work);
>>
>>   static LIST_HEAD(pci_pme_list);
>> +static LIST_HEAD(d3_possible_list);
>> +static DEFINE_MUTEX(d3_possible_list_mutex);
>>   static DEFINE_MUTEX(pci_pme_list_mutex);
>>   static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
>>
>> @@ -161,6 +164,14 @@ static bool pcie_ats_disabled;
>>   /* If set, the PCI config space of each device is printed during boot. */
>>   bool pci_early_dump;
>>
>> +/* Preferences set by a driver for D3 optin/veto */
>> +enum driver_d3_pref {
>> +       D3_PREF_UNSET,  /* Not configured by driver */
>> +       D3_PREF_NONE,   /* Driver does not care */
>> +       D3_PREF_OPTIN,  /* Driver prefers D3 */
>> +       D3_PREF_VETO,   /* Driver vetoes D3 */
>> +};
>> +
>>   bool pci_ats_disabled(void)
>>   {
>>          return pcie_ats_disabled;
>> @@ -3031,6 +3042,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>                  if (pci_bridge_d3_force)
>>                          return true;
>>
>> +               /* check for any driver optin of D3 for the bridge */
>> +               if (bridge->driver_d3 == D3_PREF_OPTIN)
>> +                       return true;
>> +
>>                  /* Even the oldest 2010 Thunderbolt controller supports D3. */
>>                  if (bridge->is_thunderbolt)
>>                          return true;
>> @@ -3050,6 +3065,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>                  if (dmi_check_system(bridge_d3_blacklist))
>>                          return false;
>>
>> +               /* check for any driver veto for D3 for the bridge */
>> +               if (bridge->driver_d3 == D3_PREF_VETO)
>> +                       return false;
>> +
>>                  /*
>>                   * It should be safe to put PCIe ports from 2015 or newer
>>                   * to D3.
>> @@ -3168,6 +3187,130 @@ void pci_d3cold_disable(struct pci_dev *dev)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>>
>> +static struct pci_dev *pci_get_upstream_port(struct pci_dev *pci_dev)
>> +{
>> +       struct pci_dev *bridge;
>> +
>> +       bridge = pci_upstream_bridge(pci_dev);
>> +       if (!bridge)
>> +               return NULL;
>> +
>> +       if (!pci_is_pcie(bridge))
>> +               return NULL;
>> +
>> +       switch (pci_pcie_type(bridge)) {
>> +       case PCI_EXP_TYPE_ROOT_PORT:
>> +       case PCI_EXP_TYPE_UPSTREAM:
>> +       case PCI_EXP_TYPE_DOWNSTREAM:
>> +               return bridge;
>> +       default:
>> +               break;
>> +       };
>> +
>> +       return NULL;
>> +}
>> +
>> +static void pci_refresh_d3_possible(void)
>> +{
>> +       struct pci_d3_driver_ops *driver;
>> +       struct pci_dev *pci_dev = NULL;
>> +       struct pci_dev *bridge;
>> +
>> +       /* 1st pass: unset any preferences set a previous invocation */
>> +       while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
>> +               bridge = pci_get_upstream_port(pci_dev);
>> +               if (!bridge)
>> +                       continue;
>> +
>> +               if (bridge->driver_d3 != D3_PREF_UNSET)
>> +                       bridge->driver_d3 = D3_PREF_UNSET;
>> +       }
>> +
>> +       pci_dev = NULL;
>> +
>> +       /* 2nd pass: update the preference and refresh bridge_d3 */
>> +       while ((pci_dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev))) {
>> +               bridge = pci_get_upstream_port(pci_dev);
>> +               if (!bridge)
>> +                       continue;
>> +
>> +               /* don't make multiple passes on the same device */
>> +               if (bridge->driver_d3 != D3_PREF_UNSET)
>> +                       continue;
>> +
>> +               /* the list is pre-sorted by highest priority */
>> +               mutex_lock(&d3_possible_list_mutex);
>> +               list_for_each_entry(driver, &d3_possible_list, list_node) {
>> +                       /* another higher priority driver already set preference */
>> +                       if (bridge->driver_d3 != D3_PREF_UNSET)
>> +                               break;
>> +                       /* check for opt in to D3 */
>> +                       if (driver->optin && driver->optin(bridge))
>> +                               bridge->driver_d3 = D3_PREF_OPTIN;
>> +                       /* check for opt out of D3 */
>> +                       else if (driver->veto && driver->veto(bridge))
>> +                               bridge->driver_d3 = D3_PREF_VETO;
>> +               }
>> +               mutex_unlock(&d3_possible_list_mutex);
>> +
>> +               /* no driver set a preference */
>> +               if (bridge->driver_d3 == D3_PREF_UNSET)
>> +                       bridge->driver_d3 = D3_PREF_NONE;
>> +
>> +               /* update bridge_d3 */
>> +               pci_bridge_d3_update(pci_dev);
>> +       }
>> +}
>> +
>> +static int pci_d3_driver_cmp(void *priv, const struct list_head *_a,
>> +                          const struct list_head *_b)
>> +{
>> +       struct pci_d3_driver_ops *a = container_of(_a, typeof(*a), list_node);
>> +       struct pci_d3_driver_ops *b = container_of(_b, typeof(*b), list_node);
>> +
>> +       if (a->priority < b->priority)
>> +               return -1;
>> +       else if (a->priority > b->priority)
>> +               return 1;
>> +       return 0;
>> +}
>> +
>> +/**
>> + * pci_register_d3_possible_cb - Register a driver callback for checking d3 veto
>> + * @arg: driver provided structure with function pointer and priority
>> + *
>> + * This function can be used by drivers to register a callback that can be
>> + * used to veto a device going into D3.
>> + * Returns 0 on success, error code on failure.
>> + */
>> +int pci_register_d3_possible_cb(struct pci_d3_driver_ops *arg)
>> +{
>> +       mutex_lock(&d3_possible_list_mutex);
>> +       list_add(&arg->list_node, &d3_possible_list);
>> +       list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
>> +       mutex_unlock(&d3_possible_list_mutex);
>> +       pci_refresh_d3_possible();
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_register_d3_possible_cb);
>> +
>> +/**
>> + * pci_unregister_d3_possible_cb - Unregister a driver callback for checking d3 veto
>> + * @arg: driver provided structure with function pointer and priority
>> + *
>> + * This function can be used by drivers to unregister a callback that can be
>> + * used to veto a device going into D3.
>> + */
>> +void pci_unregister_d3_possible_cb(struct pci_d3_driver_ops *arg)
>> +{
>> +       mutex_lock(&d3_possible_list_mutex);
>> +       list_del(&arg->list_node);
>> +       list_sort(NULL, &d3_possible_list, pci_d3_driver_cmp);
>> +       mutex_unlock(&d3_possible_list_mutex);
>> +       pci_refresh_d3_possible();
>> +}
>> +EXPORT_SYMBOL_GPL(pci_unregister_d3_possible_cb);
>> +
>>   /**
>>    * pci_pm_init - Initialize PM functions of given PCI device
>>    * @dev: PCI device to handle.
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 8c7c2c3c6c65..863399e78869 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -389,6 +389,7 @@ struct pci_dev {
>>                                                     bit manually */
>>          unsigned int    d3hot_delay;    /* D3hot->D0 transition time in ms */
>>          unsigned int    d3cold_delay;   /* D3cold->D0 transition time in ms */
>> +       unsigned int    driver_d3;      /* Driver D3 request preference */
>>
>>   #ifdef CONFIG_PCIEASPM
>>          struct pcie_link_state  *link_state;    /* ASPM link state */
>> @@ -1404,6 +1405,14 @@ void pci_d3cold_disable(struct pci_dev *dev);
>>   bool pcie_relaxed_ordering_enabled(struct pci_dev *dev);
>>   void pci_resume_bus(struct pci_bus *bus);
>>   void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state);
>> +struct pci_d3_driver_ops {
>> +       struct list_head list_node;
>> +       int priority;
>> +       bool (*optin)(struct pci_dev *pdev);
>> +       bool (*veto)(struct pci_dev *pdev);
>> +};
>> +int pci_register_d3_possible_cb(struct pci_d3_driver_ops *arg);
>> +void pci_unregister_d3_possible_cb(struct pci_d3_driver_ops *arg);
>>
>>   /* For use by arch with custom probe code */
>>   void set_pcie_port_type(struct pci_dev *pdev);
>> --
> 
> I don't like this too much TBH.  It appears overly complicated to me
> and it totally misses the wakeup vs non-wakeup point I've been talking
> about recently.

Yeah it does miss the wakeup point at the moment.

> 
> IMV, the underlying issue all boils down to the platform firmware
> inadequately describing the behavior of the system to the OS.
> Specifically, had it provided a _S0W returning 0 for the Root Port(s)
> in question, wakeup signaling would have worked (or else there would
> have been a defect in the kernel code to be addressed).  

I think you're right.  I'll try and get BIOS guys to provide a test BIOS 
to prove this direction is correct.

It wouldn't help all the machines already in the field but if it can be 
done without harm to Windows maybe future SoCs could use it.

> Instead, it
> decided to kind-of guide Windows in the "right" direction through PEP
> constraints which doesn't have the same effect on Linux and honestly
> I'm not even sure if it is a good idea to adjust Linux to that.
> 

What is the worry with bringing Linux in this direction (using constraints)?

My main hope is that by generalizing this fundamental difference in how 
Windows and Linux handle Modern Standby / suspend-to-idle we can avoid 
other future bugs.

> It looks to me like the issue could be addressed by a PCI device quirk
> playing the role of a missing _S0W (but slightly more precise, because
> it may distinguish suspend-to-idle from PM-runtime, which _S0W cannot
> do).

Thanks for this idea.  I'll experiment with this.
