Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF386B1C6D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 08:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCIHe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 02:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCIHek (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 02:34:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CA7DB1
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 23:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmlPi5RDM2a4j+NQ35VzhGj/8rewmcsJ+Ww1yZs0yIB7TKudHad/IyYm6ZzqWxHJ2z6t+PQhscj9jR90HJ1SVCWRThz2AQdNgLtokfmcnnXSaeyNIop6jtvqMQ2qN/97FaE0I7Gem3u4pgPQChuzQyaLBlwExtDJocTPSB2DMBwFSHWLeY0CQ9F3czcoJqjK07f50Cwt7FP6V5rnGDosAm4fG//s6rJD2ZyCNGz68Vq7cd836rxW2tvBM0Lx0bGR5jil8mQURVE1sCYlzMXl/OVd/rGWloB42RohFa9RK7t90VIYY0sdLnWE9SUZSohAnexBCuMnuHxjee35uJBmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrZRMJECquCXhH/WNj9sSBH6eb48gbPFBOjK4NrCETU=;
 b=iBMEfstBUYsoRKZbRa+4+eC1ENTZ9eveU5hdCOPql+ouEgL48Byy2mC/LMPBURYtHWgsNDd8H/s6xBf3OOeJ1n+979pR93MvWzXIPF2o4ikRAaoOylFWJEqA+rPG6Mr0kmr0dYdaL3XqAZcd80AFAhRCH3/tGIGGOFnlvo6xMCIEEMBI7vwytIiw4utCZaKmR5KuC1HWqyaNrh8XaOrHi2cBa8nyie6+DZmcWpizB+lKgXl9HLi0ngTfkAurZWD6fwQSc9B2UqaIz/DAhnUxrl4KmCqTUFLqgZkuTKDTQ0QpuY4OuDBn4V3C6afahdqvn7c4hUOt7F4NYz0YYZvlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrZRMJECquCXhH/WNj9sSBH6eb48gbPFBOjK4NrCETU=;
 b=gliKOSQaLXD+TB7dp7Oox6WRADHnHIHlT7DhNoX26iDmpa80eMFmlVoAHr5XAsFW3SeDkXjyyJflZwjDg2CTgKmKkHCCcElHP0ycQQEaC/ixMtDBsUORDpEKa+0xeK8zG4dJ8wYi8l6O/sGi+Jub9W2kDV+CbI72JhwikUVlTeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 07:34:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::3ac0:104f:8959:a7fc]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::3ac0:104f:8959:a7fc%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 07:34:29 +0000
Message-ID: <39644d3a-a57b-4843-b2a1-701992312e1f@amd.com>
Date:   Thu, 9 Mar 2023 13:04:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
References: <20230306072340.172306-1-Basavaraj.Natikar@amd.com>
 <20230308224428.GA1050977@bhelgaas>
 <MN0PR12MB61011CD561076CA23B17B813E2B49@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <MN0PR12MB61011CD561076CA23B17B813E2B49@MN0PR12MB6101.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b84a62-6c31-48b9-f2f8-08db2070b777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O5TSGsBCq8o8kuoCiry4gR+E9MGW+pnuxLirAvai79Om5jqsrTvaAGi3PwnxbigG8Vjzg816hrujbGKkyufFPtn4dpwC0m/4IKF0OAUopx0QZUxkjZ3x/P6a6TTbcnj24sQVA+qLCQ5GvF/AMfJixC/DOUyeGMWaN+b1DjRc8otkRG3ZLlxpF75L+S1fJOj6zfHy0lqUYlc9i/chWxC5KaF0NY9njCqLSw4dtubd43oesb/lAmjevSDdv6PQ/0XI3AQsdefizFNBliCuO34c2M2HFNSSrdVcFn1rpErtDC7jxlccF1s8Qm+EIA9sQEDyPH5OxrzNoLZSoE+g5Oi7HB05zUjkHE0aiPObRykOVwgtgfBzGwWAJKzfeCFnYg6nkREmfzLvYVcRjgQ1RzY0MA0GxVZ7zSZiKpEZs2lPp7Q9lHDN95Q2U0D+fVlfTzNYimJdXwzRrExmX5Zpo+pnE3hfJpmdG0EVrtVEORWtHiw7qLO/d5DYrg70ZCBpD6zbNR8BIZgSvi7yRl66BHfv8bEZ00mqhDt8z+qAlVctXC4jFvpmvY/5u3AS9hLGaiBHLtuuhczKCoXz9IWho/uZqOw/nqRBaEkwel1aME38OaC/PDl5Ye1Kp+W/ZC7Dfp8rZ0uKQuwEwusD7zZQOwrcG4BMfAfT4+v6mnbCBIah8y/+X2ZyMwEpwDLzwOZZPeEoswr3DmMyE3boDzxn0BYs5stL1OmhP7AdA7R+jW1Yx8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(6486002)(31686004)(8676002)(66556008)(8936002)(36756003)(66476007)(41300700001)(4326008)(5660300002)(2906002)(66946007)(38100700002)(31696002)(6512007)(6666004)(966005)(26005)(6506007)(478600001)(316002)(110136005)(54906003)(6636002)(53546011)(83380400001)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlNRXFGSzhjUGZQa3Y2Nnl5b21adEJTcmE0djFuTGhIMENCVjlqZkpsN2ts?=
 =?utf-8?B?Vy9mQWwvbW5nWnRXd1QwVUc5YTRNbWtvSG16OWRkLytaSTFpbGVvS3NQWnRP?=
 =?utf-8?B?RTkwR1dmdGpPZlp5N0VTMS9Hbi9QNTd4cGRYendFMzRKREk1NENwV3BpdXpU?=
 =?utf-8?B?cU5SSU1ic1VKVkErMXc3N3c1UGV6aDlKU2RrWVVzc3lnb2ZtQ0FJa0FVbGlI?=
 =?utf-8?B?WTdYcmxaa3hGTFJURkZKanBSenJLNGZVOHZqTDdiQ215U2RaOEE2NklsWGNX?=
 =?utf-8?B?U0l0blc5Z3dINmlTbjNabFhoZFBLUm10cU1VTUcrWnNFay83MUNkcjE2SlZa?=
 =?utf-8?B?WG1EemUyajVWanZOTHF2NUM0SFBLZEwwYjNseUhYL2YraUV3ejRST2RSN3g2?=
 =?utf-8?B?bFBqK2swVDRBSXBzY2d5eWV3dklDRnBaY0RXQmQ3SW5TQS9IUURncnhCdVdj?=
 =?utf-8?B?RFNrWUhWSG5YNWxvQmdmbGVUeWJsc2ZwRHFwWVUwWnJ1cHJ5NThGQ3E3UXlp?=
 =?utf-8?B?bXNGa0lKR2o0bmlYOXVBdkEweGJnVlVCRTFLYjZzODJoN2JTajJuYzhuTi9H?=
 =?utf-8?B?RW5XNlVZcXlod3RQK3dFc1paU21IMzdMeUhCOUN5NWlFQVJTWWZySDZPUzND?=
 =?utf-8?B?bXhFSzYwc3kwTUJSWVNEb0w3QVJJNm8xZFRtWUVnL3RCRXI1STV2UTZ3aG9Z?=
 =?utf-8?B?elJRL3JyZ2xET3ZHR0ZrT1pDUkxSSHJBTHFQQXBaYk0ybDJheXdBR3hmaklQ?=
 =?utf-8?B?eng0YXdKOEpYakl3T00zelN4eGZ2N043SnVtR0RHZnRib1ZQVEtHMWJ2K1py?=
 =?utf-8?B?NThYUEZQcmJYeGhGdXVERldmblBmTVNmUGNHYkN4Nm5VaWZ4dmVVZ0F3UC9U?=
 =?utf-8?B?L0luN3UxNlRheEt5eVBieWcveEUyaVJyMDV3VjZiZXNzSU9ieWtCQXJWZEx5?=
 =?utf-8?B?U1RvWnVFbnFSeVhnTURZa3EwZ0JhRHl1MmtqTDVLUkhVQ1BrMUNweW5ubEc5?=
 =?utf-8?B?Yy9DMUJOb1JDeW5NcnRHWVJ0ZG11c3dqQnI1SEVhMEcrVkxnQVVxamhTMXlB?=
 =?utf-8?B?S290LzZWUVRBSnJuQTk2aUlzZW1YM2Q4ZmRVREVNQ0VDeWRHTVpUUGtSM09j?=
 =?utf-8?B?OW8rMkt6YmxBdDdtcC90cW11akFSaXQ1djlqRHI1SmFXNWhMdlBPaVJ6N0dK?=
 =?utf-8?B?Q05VbUR5M2JMUkRSVlpTMkdsbkJPU3FLM2dld3BXZG5RWlg0QU5icTVQYVdQ?=
 =?utf-8?B?Z3VBT0N4eS9GKzYzczR6YkFybk5tNEw1MHdkM1ZWNmpHZitCVFJscjdFU0pw?=
 =?utf-8?B?THh6cnNxWFB2NktjL0dYWHVSZWtEQTVJVjIyVU5IYzZBczhydGduQW9JN21z?=
 =?utf-8?B?Tkd0SUtFTHNkRFZYdWZzdmNXRXFpNzJKWEZGWFN2TllqUjBGQzQ1ZUlwTG1N?=
 =?utf-8?B?SFlHYVcyQ21HTkJnUHdmcDU3MTM0M3Bqb2ZGUkhtRm5BM3NNNDBGaUdqdnI4?=
 =?utf-8?B?aGtHWmYvdWV2cmVqVjZsYWRMR2duZU9oN1BnWjY4ZkI5dVRuK1hVR1drVFRB?=
 =?utf-8?B?VHlSb0VkWEJ3NlE4YzBDSTJ2M0ZzWG9XVk1PYVVPaWxiZDBWSnRTZjB3Z3Vx?=
 =?utf-8?B?SjhjMW5SUjVXV2NZeWx5QzVUTERDOU9YejJSZHFUT3ZpNC94ajVCMFFpRFFE?=
 =?utf-8?B?b01XQWwvMWtjTUFlMVh2UXhqRGdPTkdhZVIvSW9BbU05WVFQKzMzR05WeCtx?=
 =?utf-8?B?amxwZEpQYk1neUtiaDc0VGw4UEJCcmV4RkVvMTlkWE1xeCtNaTI2V3JPOW5i?=
 =?utf-8?B?c3BDaFNLc21weVA1L1JUeTJ4SUp4OThOTERZWEJhSkdDNEFQSFB4bzVGL2FU?=
 =?utf-8?B?MDc1VVVvRk1mQzEvbFVpMGo3SmNBSUgwVzE5WjJGclJyeEFHSXhFWHI1OWtK?=
 =?utf-8?B?MWVzOE9DcTV4TnRac3RmTjB0dkVJYnBSdmFGcHZYQzN4N0s1UDB2UlY5aFQr?=
 =?utf-8?B?OFhCR1IzZm9obUdrOE5iWEtqREZNcWpxUXYrUkFnYnp4VWZEci90SHQra1h0?=
 =?utf-8?B?UjFyemhnWHd2Nk1Iak9VMWNKTWMrZGE3WlVNT1pQQmFNSUQ2M3ZrN3l6SWNI?=
 =?utf-8?Q?VW+wzGlpmTrJUkH585aFlLZu2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b84a62-6c31-48b9-f2f8-08db2070b777
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:34:29.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVoE1UIbGG3mWnGpyVlJHG9jFrTaUzjvGgrR3oSMnuMNoeVKs7lysD9mOPyGP2FUNCtD4Y7XvgQBJpltnTQtpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/9/2023 4:34 AM, Limonciello, Mario wrote:
> [Public]
>
>
>
>> -----Original Message-----
>> From: Bjorn Helgaas <helgaas@kernel.org>
>> Sent: Wednesday, March 8, 2023 16:44
>> To: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
>> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; thomas@glanzmann.de
>> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>>
>> Let's mention the vendor and device name in the subject to make the
>> log more useful.

Sure will change subject as below.
Add quirk on AMD 0x15b8 device to clear MSI-X enable bit

>>
>> On Mon, Mar 06, 2023 at 12:53:40PM +0530, Basavaraj Natikar wrote:
>>> One of the AMD USB controllers fails to maintain internal functional
>>> context when transitioning from D3 to D0, desynchronizing MSI-X bits.
>>> As a result, add a quirk to this controller to clear the MSI-X bits
>>> on suspend.
>> Is this a documented erratum?  Please include a citation if so.
>>
>> Are there any other AMD USB devices with the same defect?
> FYI - it's not a hardware defect, it's a BIOS defect.
>
>> The quick clears the Function Mask bit, so the MSI-X vectors may be
>> *unmasked* depending on the state of each vectors Mask bit.  I assume
>> the potential unmasking is safe because you also clear the MSI-X
>> Enable bit, so the function can't use MSI-X at all.

Sure, will remove Function Mask bit only clear MSI-X enable bit is enough,
actually MSI-X enable bit doesn't change the internal hardware and there
will be no interrupts after resume hence below command timeout and eventually
error observed more logs below:
[  418.572737] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
*[ 423.724511] xhci_hcd 0000:03:00.0: Command timeout, USBSTS: 0x00000000****[ 423.724517] xhci_hcd 0000:03:00.0: Command timeout*
[  423.724519] xhci_hcd 0000:03:00.0: Abort command ring
[  425.740742] xhci_hcd 0000:03:00.0: No stop event for abort, ring start fail?
*[ 425.740771] xhci_hcd 0000:03:00.0: Error while assigning device slot ID****[ 425.740777] xhci_hcd 0000:03:00.0: Max number of devices this xHCI
host supports is 64*.
[  425.740782] usb usb5-port1: couldn't allocate usb_device
[  425.740794] xhci_hcd 0000:03:00.0: disable port 5-1, portsc: 0x6e1
[  425.740818] hub 5-0:1.0: hub_suspend
[  425.740826] usb usb5: bus auto-suspend, wakeup 1
[  425.740835] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
[  425.740842] xhci_hcd 0000:03:00.0: xhci_suspend: stopping usb5 port polling.
[  425.756878] xhci_hcd 0000:03:00.0: // Setting command ring address to 0xffffe001
[  425.776898] xhci_hcd 0000:03:00.0: WARN: xHC save state timeout
[  425.776910] xhci_hcd 0000:03:00.0: PM: suspend_common(): xhci_pci_suspend+0x0/0x170 [xhci_pci] returns -110
[  425.776917] xhci_hcd 0000:03:00.0: hcd_pci_runtime_suspend: -110
[  425.776918] xhci_hcd 0000:03:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)


will change function name accordingly quirk_clear_msix_en
and with only ctrl &= ~PCI_MSIX_FLAGS_ENABLE;

>>
>> All state is lost in D3cold, so I guess this problem must occur during
>> a D3hot to D0 transition, right?  I assume this device sets
>> No_Soft_Reset, so the function is supposed to return to D0active with
>> all internal state intact.  But this device returns to D0active with
>> the MSI-X internal state corrupted?
>>
>> I assume this relies on pci_restore_state() to restore the MSI-X
>> state.  Seems like that might be enough to restore the internal state
>> even without this quirk, but I guess it must not be.
> The important part is the register value changing to make
> the internal hardware move.  Because it restores identically it doesn't change
> the internal hardware.

Yes correct, even though pci_restore_state restores all pci registers states
including MSI-X bits __pci_restore_msix_state after resume but internal AMD
controller's MSI_X enable bit is out of sync and AMD controller fails to maintain 
internal MSI-X enable bits.

>
>>> Note: This quirk works in all scenarios, regardless of whether the
>>> integrated GPU is disabled in the BIOS.
>> I don't know how the integrated GPU is related to this USB controller,
>> but I assume this fact is important somehow?
> This bug is due to a BIOS bug with the initialization.  We also posted in
> parallel a different workaround that fixes the initialization to match what
> the BIOS should have set via the GPU driver.  
>
> It should be going in for 6.3-rc2.
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139
>
> But because these are desktop processors, users can decide in BIOS setup
> whether the integrated GPU should be enabled or disabled and that
> workaround won't work if it's disabled.
>
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
>>> Link: https://lore.kernel.org/linux-
>> usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
>>
>> Apparently the symptom is one of these:
>>
>>   xhci_hcd 0000:0c:00.0: Error while assigning device slot ID: Command
>> Aborted
>>   xhci_hcd 0000:0c:00.0: Max number of devices this xHCI host supports is 64.
>>   usb usb1-port1: couldn't allocate usb_device
>>   xhci_hcd 0000:0c:00.0: WARN: xHC save state timeout
>>   xhci_hcd 0000:0c:00.0: PM: suspend_common():
>> xhci_pci_suspend+0x0/0x150 [xhci_pci] returns -110
>>   xhci_hcd 0000:0c:00.0: can't suspend (hcd_pci_runtime_suspend [usbcore]
>> returned -110)
>>
>> We should include the critical line or two in the commit log to help
>> users find the fix.
>>
>> I see this must be xhci_suspend() returning -ETIMEDOUT after
>> xhci_save_registers(), but I don't see the connection from there to a
>> PCI_FIXUP_SUSPEND.  Can you connect the dots for me?

Enabled more verbose logs in above comment for actual timeout due to MSI-X 
interrupt disabled internally even though in register shows MSI-X enabled
due to internal hardware de-synchronizing MSI-X enable bits on suspend so
explicit clear of MSI-X during suspend help to maintain and restores both 
internal register in sync with MSI-X enable bit.

[  418.572737] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
*[ 423.724511] xhci_hcd 0000:03:00.0: Command timeout, USBSTS: 0x00000000****[ 423.724517] xhci_hcd 0000:03:00.0: Command timeout*
[  423.724519] xhci_hcd 0000:03:00.0: Abort command ring

>>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>>> ---
>>>  drivers/pci/quirks.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 44cab813bf95..ddf7100227d3 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -6023,3 +6023,13 @@
>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d,
>> dpc_log_size);
>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f,
>> dpc_log_size);
>>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31,
>> dpc_log_size);
>>>  #endif
>>> +
>>> +static void quirk_clear_msix(struct pci_dev *dev)
>>> +{
>>> +	u16 ctrl;
>>> +
>>> +	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
>> &ctrl);
>>> +	ctrl &= ~(PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
>>> +	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS,
>> ctrl);
>>> +}
>>> +DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x15b8,
>> quirk_clear_msix);
>>> --
>>> 2.25.1
>>>

