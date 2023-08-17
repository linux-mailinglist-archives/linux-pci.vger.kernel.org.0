Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3177FE87
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350164AbjHQTaa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 15:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354513AbjHQTaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 15:30:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70382125;
        Thu, 17 Aug 2023 12:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6rDi/Glm9SALnAToE6Ex7LvAYSOY2R3H/Q8ge63x7lkdBzi02lgIzrIdk1sOv9LNEUDalSk4FVa72cKebsAw2iYIeRdo/BO+cksqcFIGQ0+qt7TMfNDqacIg5vOUKh8OEqWgZKesau1XTQKYx99Ni1H7tqWj2Jsl+DgbqQrgkPU9pHGznjgL1fLZJn62z2Sc/24Enu4Nn63FwxENcW0LEMUajpw2nTeahzVhXFyeSKWc2DdsptSF8kuaP1c1ApOU8h0f7YhUbv+FaWrZsIDddvxLY57o7P7qXwmw4xZyxDzNR62wIZe/xnQo9PbDC8zA2M02wI40rwr8DB2TzMwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRQAdepkE9ftdMIcDh6XMZ+ac9A50p7L3JxQOtFfGxs=;
 b=OLVG3BGtf4M2y2flmiitDK3WFj0GcASI8+eis3rCtxRXpSISNP7E56ltvYYFgRK4cQfsYhOQSBMVDOQFh18wZzBsiKV8LkpXOiQVm+UtGpX7Yjti4k6/wv+z9QZKvRjOSHpKsGVIbIMcfLnBL7VZKRC+7yXg1cQMcQ3d+b7THyFN1PgknfkPNXyEXLZYtcne4zYMX/27m77m5vJzKN7QYC4i9LwUGLzZOTVnwotaJoS3YVru70576R1NNY0dguPcirYY+yfCBmZN2JoXEAqYKjoFCOk2AXwsJnKhfmkHR/QgPkmfVy/ZAp4UDNBJKPYQMKNUXbWr3tbGK0jeQEdmjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRQAdepkE9ftdMIcDh6XMZ+ac9A50p7L3JxQOtFfGxs=;
 b=f+GHbCrx1N1n0Mk8Mj+q7/H6/ffOfFIcj/FdxNw9nf/jtoDPfQwzktprqfDJxMXtcpJO01iKlcr31U5WIIMwux45mQQm4Sq7IDm8wiODJUafDJxhhlccD7hfF6bBtMP5idDHGKTsm695mNN/bxQTbp0wdsE56PUIArv+ow9sW4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:30:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 19:30:06 +0000
Message-ID: <beb88d67-9437-4d7a-b1b0-a763583df17e@amd.com>
Date:   Thu, 17 Aug 2023 14:30:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 9/9] ACPI: x86: s2idle: Enforce LPS0 constraints for
 PCI devices
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230817192537.GA322922@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230817192537.GA322922@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:5:333::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fe295f-279d-4cf0-3b8f-08db9f585c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjrz3BZB1EqSFMTcZAZkWVjlmb/dT+GVwohoEvl15gDWm40MY2VfejOjhcove4Bhrgq4mfo0ipq1Dy60cxYb3G3InyT7Rtll6kDqAep+gOcEu2SCXEWQ9ezt3gpXnWVcrMJddbFE5mlKGtCLNNq1YYeSxmUxQivqQDEJOPRWRVoD3U2X4vw1WVs2Tnim+YCwSg6GnL0j0o1L7CrlU7Grni5a4o+YRjcoYjEhsC/+xQR2IHskhkh2jdLZIFUSqyNDimAUTd0FOxw7JL8irFHtMEbxJYnzT21820/l6eG4hd5fTUG5cnL0GrWQHuZYcZqyNFHpjEZk7NOshlqa5K5ncSKUgMTdrU8pwArJ1LIFUf+YOi9j08TDV+n1HiHtPouioly0hlFjmkmFf6vfUbDO2voY5VtgUFY2NiAw0at66Bf3kc1nlbY76IFcpZi/3DZja/AUu/KDPsq5k+rLwJ8eceQyi7JREB2UZ3WcZGIc4cMyb27LxmHLV22KK5xSw+3hgxBLqweGpZUX7QAk3sFjY+kR1xM/4g2uItmozeDPH2RX9g24R6VDFnLe0Nyw17KDLIy2LC2XauYbKwre4dMPQ6GDIRQ9lGXd1KiyvYdimm2gFzhEKVdk7+aSh2pL2fyOGFd3DG3Q07yx3T4MYrHc9C28sU2Kh/rqozAi/o7COzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(36756003)(86362001)(31696002)(31686004)(5660300002)(8676002)(4326008)(8936002)(53546011)(2906002)(41300700001)(26005)(6666004)(6486002)(6506007)(2616005)(83380400001)(6512007)(478600001)(38100700002)(6916009)(316002)(54906003)(66556008)(66476007)(66946007)(3714002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZSV2tNVVFUMG95TEh3dHJMVWJsRlNCMW9OVjRxdGRoSXhyVVJvVXo3RjRP?=
 =?utf-8?B?Vi84a0QrSXV4V3g4Y0xBM1FuWGtPQWFPNjE2dFRsQ3BYRGdRZXB4YkxoN2R1?=
 =?utf-8?B?Q1cxYmttQWlIUnROQVZGUW55RWtRQnJBeVp0MDNQUzFuWFhhdnhyS1pQV3Yx?=
 =?utf-8?B?L2t4ZnVtNXZOejRiYnVaUWdIbkkxdktWcmtwWkVzLzlNbCtXTytkZHkwMFNr?=
 =?utf-8?B?QnhiT05EeVF6SzQvOWx5MlZBUjdVUzI2NUR6QnFISUZhWGErWE1GZ2I1OG9a?=
 =?utf-8?B?cTVBd1h1ZXFnSnF5R2ZiMnlOTnlmcDVMaUhuQ2hnMk1wc0pweGlnY2JNY2Fp?=
 =?utf-8?B?c1JkM2xxYlQ1UXZ5RmRjT3lCYVdFK2oyaXYzYkR5Zy85QmlDY0NtTzMzcVZv?=
 =?utf-8?B?UW8rNXJ2NWNrTVlWN2FsaWZBbUFTNWVWUXRZTTVWUmRmUGRYS05RcWpoM3V6?=
 =?utf-8?B?Mlp4bXNUT1ZYQjhsV3pNTlFVbTM2TCtoOHN1RWZmdUd1NXpONnluK2tyK3pI?=
 =?utf-8?B?R3lWTkNYMVk5YndBYkE5MmZ1Y0E3T00xcDVkZjJYRnVYMlNwZkpWUGJrZ3Bi?=
 =?utf-8?B?WDV5QURMUUY1VVFmbTYzV3pGMGJibnl1cTNtejIwaFpadmF6RWh5WWZsbm1y?=
 =?utf-8?B?VUUyZTVsVTB0dlBZVUJIWkpxQ082b29aR2tjR0JSa0U0cDFXQkRDS29yNUo3?=
 =?utf-8?B?TzJrSnllN0djY2EySzZIS28yYUVzbHBWNE1WWjZ1WUl4ZWtNSnNFQXVBaE5V?=
 =?utf-8?B?czI2SG5aRkRzVnM2dTZESGxRdlBHRlduaHB5SDRiMWg3YTkwd2RkZ2ZFaEw4?=
 =?utf-8?B?ZW00TFFnclBuZGNGU3lTdjB1QjhxUmdWaVFGeXF1MUtqcjNJNEUvclA3aVRs?=
 =?utf-8?B?NWV6SC9EdWdsemtiQnI1RlMvZ1BYcG4zZnlneCs5c05yVEVXc0sreXVpeFYz?=
 =?utf-8?B?bEdtR0xteWRIMExxazFTYmZtR0x2RHBFRi81WUYzM3ZLQWFrV3VBMXNGa1Rr?=
 =?utf-8?B?dHBEcVFkQ3h0bmJCYW5Ud0pJVlVOMTdDUDB1OVlySnZyak5Ua1ZkeHZMNVFj?=
 =?utf-8?B?enZEVDVSWXFyVmFPcHljSnhSZXNGd1l3dU1KSCtuanF0MDhMQXp6cmViakU0?=
 =?utf-8?B?Uk5xN05pbXJFMUM3VU8vTTVlNTBrK1U1MCtQc1NQbG5xZnErWWFydmpEQ1Q2?=
 =?utf-8?B?a3YrYkt5SFZkejkrMUw5QUZNVUlhNWpNK1R5NkE0b1BJTG9COThUdmNtRC9m?=
 =?utf-8?B?ck5VMEJOZFpvN3ZPRU5KNkQ5TGFFbWFZZzNpQzBKMUUzemtkY21RRU5aOUFo?=
 =?utf-8?B?SFYyZGVXakZRa0NRYSt4VDM2c3ozWVJiek1ubGJ4R1VVd3dTbVlCRUl4QjNN?=
 =?utf-8?B?UGJwM3VESEpjVCtUMFBlOHNNSmhhZ01vcmQ5L0VnaWRpR1dxNVBmekFxSjgx?=
 =?utf-8?B?UEFqSmhyVDZIaWF6MTluVE1XRC9XbTY1SjdkYlFaUjlnR2lHUkY2aGN0REhW?=
 =?utf-8?B?eEZpOFA4Y3ByMGszcjgrWEM5VlQwL1VUTTR6RDlyWTZYTkk4Y0tCbFA4THZD?=
 =?utf-8?B?dEMzZWNUYytHVThoUGJmejlYY25CVWIzelRuOG1vYW9SOG54ZGNaSDFSUUZu?=
 =?utf-8?B?dlZ2VjIwL3drZjZJTGtzZzhkdURXQVFDdWtCdE1zK0dqN3Q3S0xIOE9MYVdZ?=
 =?utf-8?B?NmtPVk1GYjV3SGRnUkw5QzZKWWtkRllpVitnRzhTSlViVStZcVMxMEtGVHNl?=
 =?utf-8?B?VEg3bUhYSi80cFIxTFA5SnBqRnVNUTlMSklpdExMZTBvS1pleW1qQnFDOWNk?=
 =?utf-8?B?M1dndkcxTm1zTmlZcG16WmxhSnAzcWs1clJXbUYyclhWOGpNR3RrRzRhUDNn?=
 =?utf-8?B?Q3liTVRwMHlpekhacCtnT3ZrVUJXV0laelhOZUFseFpwL3pSSDZEbmpTMGdL?=
 =?utf-8?B?U2ViWnoweXc5Szk2VVBwMy9nd3k2bnhxL1g5RXJYV1poSDJuRzdQTjR0SlNx?=
 =?utf-8?B?alQ0NlRNYWFkRE53blJ5SUFOWmpuaDlRbU9QZVBWQmxURHdCbUdZQTJ5eG1N?=
 =?utf-8?B?RWNuOHV4UndWWHpsTFpNODNJZnM2RkNPSGZ2QVh1S2I4UG8xUEgxa3Fra3dR?=
 =?utf-8?Q?hw/tKt2XPx9YQGI1QpYhq1E5G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fe295f-279d-4cf0-3b8f-08db9f585c4d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:30:05.9544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T46blkrAKby0B1hUOgIaOmxwWIM16HjK5sKHOKELV04BcDT/3/7qCrURlIumu/UPT9lUxkGFFKlEP1eDNNWrmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/17/2023 2:25 PM, Bjorn Helgaas wrote:
> On Wed, Aug 16, 2023 at 03:41:43PM -0500, Mario Limonciello wrote:
>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
>> storing a value to the `bridge_d3` variable in the `struct pci_dev`
>> structure.
>> ...
> 
>> +static void lpi_check_pci_dev(struct lpi_constraints *entry, struct pci_dev *pdev)
>> +{
>> +	pci_power_t target = entry->enabled ? entry->min_dstate : PCI_D0;
>> +
>> +	if (pdev->current_state == target)
>> +		return;
>> +
>> +	/* constraint of ACPI D3hot means PCI D3hot _or_ D3cold */
>> +	if (target == ACPI_STATE_D3_HOT &&
> 
> ACPI_STATE_D3_HOT is not a valid pci_power_t value.

Based on this, kernel robot sparse complaints and your comments on v11's 
last patch I am going to split off to another function that returns the
pci_power_t state based upon the situation and better comment the reason 
for the D0 when not enabled.

> 
>> +	    (pdev->current_state == PCI_D3hot ||
>> +	     pdev->current_state == PCI_D3cold))
>> +		return;
>> +
>> +	if (pm_debug_messages_on)
>> +		acpi_handle_info(entry->handle,
>> +				 "LPI: PCI device in %s, not in %s\n",
>> +				 acpi_power_state_string(pdev->current_state),
>> +				 acpi_power_state_string(target));
>> +
>> +	/* don't try with things that PCI core hasn't touched */
>> +	if (pdev->current_state == PCI_UNKNOWN) {
>> +		entry->handle = NULL;
>> +		return;
>> +	}
>> +
>> +	pci_set_power_state(pdev, target);
> 
> It doesn't seem logical for a "check_constraints()" function that
> takes no parameters and returns nothing to actively set the PCI power
> state.
> 
> lpi_check_constraints() returns nothing, and from the fact that it was
> previously only called when "pm_debug_messages_on", I infer that it
> should have no side effects.
> 
> IMHO "lpi_check_constraints" is not a great name because "check"
> doesn't suggest anything specific about what it does.
> "dump_constraints()" -- fine.  "log_unmet_constraints()" -- fine
> (seems like the original intention of 726fb6b4f2a8 ("ACPI / PM: Check
> low power idle constraints for debug only"), which added it.
> 

Great feedback, thanks.  I'm thinking to instead change it to:

lpi_enforce_constraints()

>> +}
>> +
>>   static void lpi_check_constraints(void)
>>   {
>>   	struct lpi_constraints *entry;
>>   
>>   	for_each_lpi_constraint(entry) {
>>   		struct acpi_device *adev = acpi_fetch_acpi_dev(entry->handle);
>> +		struct device *dev;
>>   
>>   		if (!adev)
>>   			continue;
>>   
>> +		/* Check and adjust PCI devices explicitly */
>> +		dev = acpi_get_first_physical_node(adev);
>> +		if (dev && dev_is_pci(dev)) {
>> +			lpi_check_pci_dev(entry, to_pci_dev(dev));
>> +			continue;
>> +		}
>> +		if (!entry->enabled)
>> +			continue;
>>   		acpi_handle_debug(entry->handle,
>>   			"LPI: required min power state:%s current power state:%s\n",
>>   			acpi_power_state_string(entry->min_dstate),
>>   			acpi_power_state_string(adev->power.state));
>>   
>> -		if (!adev->flags.power_manageable) {
>> -			acpi_handle_info(entry->handle, "LPI: Device not power manageable\n");
>> -			entry->handle = NULL;
>> -			continue;
>> -		}
>> -
>> -		if (adev->power.state < entry->min_dstate)
>> +		if (pm_debug_messages_on &&
>> +		    adev->flags.power_manageable &&
>> +		    adev->power.state < entry->min_dstate)
>>   			acpi_handle_info(entry->handle,
>>   				"LPI: Constraint not met; min power state:%s current power state:%s\n",
>>   				acpi_power_state_string(entry->min_dstate),
>> @@ -512,8 +546,7 @@ int acpi_s2idle_prepare_late(void)
>>   	if (!lps0_device_handle || sleep_no_lps0)
>>   		return 0;
>>   
>> -	if (pm_debug_messages_on)
>> -		lpi_check_constraints();
>> +	lpi_check_constraints();
>>   
>>   	/* Screen off */
>>   	if (lps0_dsm_func_mask > 0)
>> -- 
>> 2.34.1
>>
