Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9A74DE67
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjGJToa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGJTo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 15:44:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7E136;
        Mon, 10 Jul 2023 12:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGjDjfgFs6dVCNc+izHevtYrIrOXsL6i1/F3MZVDP7/CYRfdcjkkn+7bjdqx4cYExZpWGeRhDzJbLL9FRdWXvJyCH6S1utyMCpgRUXDtZ792bTvdnb+H6ApezL8+5xnNoL+RLqI5W6bPQn8bT2g7Vl9X4x1RWqJkfUOY6YLVdjNVPvToCkmn7p3VyuLbBNyA9oi5MZOet8ovZsjyxnWRllvidj7gwUKisX4MJwysxwKr/AeX6wAXvsdyZyleJpzGt7lvDY6zhFQU4+2gtRBevq958D+NbdGxMW0Pu8WRGWYlq9g+olV6ctKrsiv10GwYuWktRsHBMylFpRTyqlKh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vrn/FC7d6EWBgjmPFYjqAKiDfii4DzEH657/jxnRyQ=;
 b=ID6at+19rG+SF/J20shEdMfbEm2xOHdAnVSRrY3S1K2h42k1TWFlUgVWqif8DVmJtLbVjPRZHszPzEePIV68vZXZ9DbOEaeQlfqDEdMe6YcIyR+HgxOsTR41K2n8oRGGwxI4a6aZMCJMa1j2hQCs9x58gC8+WwrA5tV7c3gMvn+5n9QOkKd+tb4qshr26sZcW6GXKW0aMI0hz8Hr/lQL8Ckde9IiAUjFQUTYwaylD5YI5B9Z29O47fhHQHiAwfgFqPZ2u2pV1U0CQyDpUzjh/cGWe+bP4VnnsBhgvbq2+hGh/ZNkhiiBgfA5XpaRimWr9g+0MkIeN0STlh07vCj0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vrn/FC7d6EWBgjmPFYjqAKiDfii4DzEH657/jxnRyQ=;
 b=Kok8+CueMJvJCoTAwNDFadInXVwl4x4a0lBP4hFXRAIHGPaJFanPYK4fSHFU5vrdrEFB61R1KBch5HRLjC1K3ptPAbdgQOc0GzHuV7FKYuUFh5MBJnmDZ7Iq+VLKqfEIAX3JHxTXhpig50cY8jLu38JVpleITZA12iSJ2Mv2t8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:44:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 19:44:25 +0000
Message-ID: <2f052692-9406-3812-0c53-7edf8360115d@amd.com>
Date:   Mon, 10 Jul 2023 14:44:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/1] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>
References: <20230710193247.GA218021@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230710193247.GA218021@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:806:28::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: bd76f5d0-5185-4b1e-e455-08db817e10f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrLMeUUZ7hqmhgbpAf+plpmlF+l4iSHlrQuykhInzq+uHaqLWYKL/pjv/6dALM6ZLjDeuDeOeaCmHK5Dlovk9cwLERZ66Rl+KvnVuPTZ/3uzYzL3z9RP3mgzbSZtIVS4Zk//FcDzUxQORSFPDnkRYUN2WDcLI37jfP3nW10MbuZERi6HGvQKK6VT5uSN43Nk8wONuo1NjZFuBWYrgZ78zwYPijFWJSFwVurC74b7tfoGNqVYCU6xJG2gsQTmJWdZL924zQwIC6nVRQXE0if8asiaj/lsNiiEqwn5gltFRTWhqdoAEoxSwtQyx0gd2UqWKV5WCSuCXzZZOcSBqGCVL8jEUpGxYDk1wlIfZCCgHo0wsVTRk+mV8PrbBZ5RsHiReno0p/lLVD5PEXB7drJRRpyIn/q1K9JxGp+bi2pU4lW3yVYQ8NCB9k4hJ3R1X9b35mxE0VqX/qxFIKcl4dRsR3zzCo+3iFHIykIduXLJKEzofnoLymuDPmnnn3iCZ2+gpdoP4F0Q/tf/Ky4eGby9oAonm/V84ETV7wboi8yO1/RHuTZebXYERQPUnGYQ9s9JGqxKvEgTwZmcayuHLhIV6db5McCpL0cTVZz/iGp+ufF5MmGwpLN4q9dTEFZqt2jF5WBSZLaYggdoRW28RDYqnTfNR9AuvjOF31g9ApjHzYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(86362001)(38100700002)(31696002)(31686004)(36756003)(6486002)(54906003)(26005)(6506007)(186003)(6512007)(966005)(53546011)(2616005)(5660300002)(316002)(66556008)(6916009)(478600001)(66946007)(8936002)(8676002)(2906002)(66476007)(83380400001)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXRaVnZ1cXVZRDlYRUNkVzZDS29hVUk5bTZRK00yQ2ZLWW9TbnU1UFR1Zysw?=
 =?utf-8?B?S0JnY25DRUMyWjVxSGFkdnhNNUU3OE0rbW54cUE5cFh0Z01IcEVsTjZLY29q?=
 =?utf-8?B?bXVMY1dIRDJFM1lNZERoYXdOOEhEYTd3TXZjU21pK1VoMGIyZWlXcFFCTWZI?=
 =?utf-8?B?NGZOcDhvQm8rZ2E4em54bnFwQ3VVVEhrZW1TdC84b0llWHk0SzdqL010YUEz?=
 =?utf-8?B?NXArUnJVb1RjZkRNNFRqYmdVWVVza0FZMEU1dXMzMDRXbFZHL1gwaHZzRnE0?=
 =?utf-8?B?STFlZFowY2o3TDdTVnRFMXZkeXhCYWdrMk5Cc2ZyZXJvNER4MHFxNTU5bE53?=
 =?utf-8?B?T2pwMnpOYlZYRlJpRWJFV0t0ZVo2MXFEZXhLaWpIeXA2alpuZTJyaWJkZVIw?=
 =?utf-8?B?MVlsZVNVdnM4a0JxTHhkbG5hZnByZWp2Z05pRFlRSnZxQmNZRzk4Y0d4Vk40?=
 =?utf-8?B?MXBNOU5RcjZUQ2F1MlN0ZExxd0g2cnRJUkh5dUx6MmthV244aDVJUlR0akpD?=
 =?utf-8?B?emFud3krei8vUkloRDlGdGdWcjAxeUVDaWU4aEhmalJPWDA2cWZ0M3dsYkRj?=
 =?utf-8?B?R2dDeDlpTmdrTW5GaDU1SDhweXlQL3lycmFqMFMrWlFFVEcrWlBRODNWeHpm?=
 =?utf-8?B?c2FVcTcyOHBlYy9teWRYbm9UNXJHdXBmWXpGVEhKdFhEb2V1eTNjQnlrdXBu?=
 =?utf-8?B?WEUrL0ZhaVhOUlh1bEU3bjRKeGg2MTZNb1pkMzFZQkxCMy9UeEJoc3hQZDF3?=
 =?utf-8?B?Q2QwREVRMDNHSkRnZHFlYzlqYm42OGV0WElVZC8wYjNzaWhJTlVNbmNaREhR?=
 =?utf-8?B?ZzVFZy90R1huZjJmTXZORXJIOFdSQnRoMy9lRlE2VkJWR2tCOUNRTGh2U3hw?=
 =?utf-8?B?SEFTT1p5bmRDcVlWenJqaGJKM3Z5LzhzZmpiaEs0T1AvMGxFU2pZZ3drRDdG?=
 =?utf-8?B?UjJOVlM1K3VmQzdjWnoxcTRSYVJic0xsc0hNcGFIWDNiWHY5NzdlSDJSU0lD?=
 =?utf-8?B?V1ZjdWVQT3kyeDRwN3BpTGk2VVA1Nnc2ZmJZbFBaTTF3UnhtOE55Z0NkRkU2?=
 =?utf-8?B?VW1iTEdYdlY3N2tRVHFTVzM1bXZSYXpWMi8xY2ZXWC9yUXBGN3NJMis5NjMz?=
 =?utf-8?B?VW5qWEEyOHhxanZQWUpaQWZDbzByQlVpc2NZZFppSWVmNFBTbWRMcFJyT0hq?=
 =?utf-8?B?RUJiVmhNT1VOR2FHUlhmMXpEZ2ZsRjZ4RmpQa2pvbTVmQ1NRTEw4Skp1NlVl?=
 =?utf-8?B?UzZuaVNWaWFqcFNCTnJOWGRqVS82cVI3MEwxUFJQTkhWUFYwY1lRNVc4N1JS?=
 =?utf-8?B?L2c4TVlzQ1BBcUxCTHJMb1JYMW5xbGRYWG9uTXk0WUptWUNYUG83eGhiQjRw?=
 =?utf-8?B?Um1xSlVoT3oyZ2U5OUZVd1dFNFhXZzN4RFo4ckFBaGNLcmxzclNkTFJGWkV3?=
 =?utf-8?B?a3JNZWhVRUVZRUgwRldRNEtBelZ3SStHWC96MFNtTUVzaXJSbXJFZ1FzTTdK?=
 =?utf-8?B?cWdWUk9TTmtnOGdvaTJ3bllBSmo5RTBmVEtTbitIYlRtMVhQWW14bGtaWGdi?=
 =?utf-8?B?TUFucmVZb2tOb0QvbXcxOEdMRWxYREhqRXlDSXNaUXhFS0xISUV4bmJoUDNP?=
 =?utf-8?B?K29qYmVMdy9jZTdhcnZsWnUxME1kSUsydkNlTFM0MnpTZ09iUEZQUkExMlhX?=
 =?utf-8?B?OWxBM2Q2dHNBcDI1c2pEV0dreHloN2x6M2xTV0tLaEtzanpvcmR4ajFCQkJw?=
 =?utf-8?B?Q1BvQm1xbDI4OVp2dXZDMUtFSFZqaUNvdkZhdzcvL2swUEFoZWw2Zm8rRE40?=
 =?utf-8?B?VnVweWVxcVo4OE9HOGVMT2lyRjFKQ0tjQ25zcmdJSGRleDJNQ1AvZTBtUFRH?=
 =?utf-8?B?cVNybHVJUXA2V1loNys5RFlxdExTV3hHbE82NTg3NDkxU3RKVno5UHFGTUYv?=
 =?utf-8?B?K3pBWjlTVExoNWprTzl2aHhxSUNVKzFMd1ZKb0VJRUh5b3ZZd0hUcG9WVG40?=
 =?utf-8?B?ZVptQTNmS2plZ0NITDV6aE9NVUFnNHpMTVZWWlU3V2g2ZGZ4RTEybGZ0aDRV?=
 =?utf-8?B?MThsNDFsdy9oMkFwUytTTmhMYnpxMXg0YlplaWNFYitQdVhnYU1pam9nazB1?=
 =?utf-8?Q?izQ7FKxllqgkd8YFC25/vBGTw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd76f5d0-5185-4b1e-e455-08db817e10f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:44:25.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhN4OSiWe1LSZ5Rg4URr+jEiOrk+e0XCx87wq6QhdlHxxh8VEQBOpc8RxDz8BBxRfWDYMv9ooXf1fSjXGIdK5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/10/2023 14:32, Bjorn Helgaas wrote:
> On Sat, Jul 08, 2023 at 04:44:57PM -0500, Mario Limonciello wrote:
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> sets the policy that all PCIe ports are allowed to use D3.  When
>> the system is suspended if the port is not power manageable by the
>> platform and won't be used for wakeup via a PME this sets up the
>> policy for these ports to go into D3hot.
>>
>> This policy generally makes sense from an OSPM perspective but it leads
>> to problems with wakeup from suspend on laptops with AMD chips:
>>
>> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>>    interrupt.
>> - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>>
>> Add a quirk for the PCI device ID used by the problematic root port on
>> both chips to ensure that these root ports are not put into D3hot at
>> suspend.
> 
> What is problematic about these root ports?  Is this a hardware
> erratum?  

I mentioned some of this in earlier versions; but the problem is deeper
in the platform firmware and only happens when the root ports are in 
D3hot across an s2idle cycle.

When looked at independently they can be moved in and out of D3hot no 
problem.

 From the perspective of hardware designers they say this is a software 
bug that Linux puts PCI RP into D3hot over Modern Standby when they 
don't specify for this to be done.  I don't expect any erratum for it.

> Some corner of the ACPI spec that allows undefined behavior?
> 

These root ports are not reported as power manageable by ACPI.

As I mentioned in the cover letter how the OSPM handles this case is 
outside of any spec AFAICT.

> Does AMD have any guidance about generic ways to use D3, or does AMD
> expect to add quirks piecemeal as problems are discovered?  How does
> Windows handle all this?
> 

Windows doesn't put root ports into D3hot over suspend unless they are 
power managed by ACPI (as described in section 7.3 of the ACPI spec).

https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html

So on Windows these ports are all in D0 and none of the issues happen.

Linux if PCI devices aren't power managed by ACPI will either follow 
deepest state it can wake from PME or fall back to D3hot.

> Adding quirks as we discover random devices that don't behave
> correctly for reasons unknown is not very sustainable.

I don't disagree but in v5 I tried to align this to the Windows behavior 
and it wasn't accepted.

If you still think v5 is the better approach I'm fine to try to do that 
again and rewrite the commit message.

> 
> Bjorn
> 
>> Cc: stable@vger.kernel.org # 6.1+
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/quirks.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 321156ca273d5..e0346073e5855 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -3867,6 +3867,22 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>   			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>   			       quirk_apple_poweroff_thunderbolt);
>> +
>> +/*
>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
>> + * may cause problems when the system attempts wake up from s2idle.
>> + *
>> + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>> + * interrupt.
>> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
>> + */
>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>> +{
>> +	if (!acpi_pci_power_manageable(pdev))
>> +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>>   #endif
>>   
>>   /*
>> -- 
>> 2.34.1
>>

