Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA1D6B2CF0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 19:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCIScs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 13:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCIScr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 13:32:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D4F6939
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 10:32:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU63vLjclFdtbbg308KXi8oQf9kbAn3zW90q5cOSgLeu22hXURluve2htrs3KGo+NVnJdzWDrzHEpC+uacKAOZu6dmRryl3kyTnv5jwPo7Xvavg3f4DhSptFdU+Ypmc4YNywS9FVoBVhVHQyM9MDIabpKas4XgeSO1RQizbE5bx8vj5VxcrbwSjlo2o6FyVo0HBqidmAqm+LkXt+07f6l3GnX1ueuNVmGCY1iCErVO1VWvq5JfGeseAU/AUMhhujIEQTGk+nIy4uL/m5hw+7G+ODawoTdnTndRfaBKVq9gcfWND+I61t+UWMh/hNWIDwTBBjZ9AGNwaRttziHi1htA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWEPRU/eVuPUj2Z4WUBlQUMcNg2o6fewaoBlNAR52MA=;
 b=HiRK1NfM6qiam7frxXr/LBNFMG7O1vwdkT01/CoLxonU26uyCnq3++/EZsXts7jlYvN3kV84f8gTWgrHYLg2/2w9LActeVZB9vkmulEos7pqt/wrQna7iYOgRlltFDNIeBl3wPHYG+VXDHSk9iLNx8XU9i58CswbHK0dadpvFRSYzi6gvQl58d/GuwLD0z2gMJD4WNVq2E/xw77Ctz6nzjfUmFBTmNNVQ7QPLDiSEWR2xbCz6OyS0m5BZusQjLmUsSqzycbD7Erj7WTW3bJVN5kSNxZSfQ81kESZjl85j6MwymneZIqoG9nlURATNBsFpEXg1sYyPXbn9pxFlo1a9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWEPRU/eVuPUj2Z4WUBlQUMcNg2o6fewaoBlNAR52MA=;
 b=xIZaFdxpl3Gh17nyDqp2c3A1h76z3gk0n0GqNgk6nRu27zSISdQh5MGG+ApO24oG2nWPaLwDZ6n+Qr8MpYQbgxE79FGt9scS3m1L+C7f0dQUmLDShGPwpjinqhfOgfIU9u+5GYdKIOeq6pykx0VNncJbwTkrNtcOyMot4Mwkgo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 18:32:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 18:32:43 +0000
Message-ID: <3edd370c-e9e2-733c-2d79-51a08dd10e9d@amd.com>
Date:   Thu, 9 Mar 2023 12:32:41 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Basavaraj Natikar <bnatikar@amd.com>
Cc:     "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "thomas@glanzmann.de" <thomas@glanzmann.de>
References: <20230309182514.GA1152206@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230309182514.GA1152206@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0332.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 724b7eb5-c29b-408f-a0f9-08db20ccabd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jM7oM2kVRGYHZehsApTvyCnqSpGdJi0uiG79yh3JUbKlAZdQGtyzCHvy5I2UsORN0Dhf7rZ1RTMh2i6+u2+fudeI3o1iuUEzYkRjsWeKYiDzaok5pHVG8skOR3K1hGMSXOB7Q0WwLVAj+aG6Ge/XZOCFfSbMMrPP23BIX96mqsDeD2dksRRdRbArMbDywZS/QyYw47Nmv+A493O3avtMNApDLCp/rz/sECBrs8LyJw5AxBoMru7BzghCR2OLPxlojYf8gYqzc18+bEI8m8QeJ6hZncVmY4um+EyBbNyZ4Uuu05Okj5nmgH2Rqna6jCSbM/LWl/WmvtjhpTiG3qvu6WREgXBglCBJhSjjGtYYgU2ojsDQgA6WHTN1SC5RnT3JwHR0RJJzRL4s9mY9xvV3o//Vl7YjfsPWDbmvPXRs5Qd2lj0Y7OafIz3yL5xXJiE3r8FrNAEPfF7DmPGjBpBRDmUE78168tKlbcJS9lMFgSePoWL+vFKh9HfbDqoJISFu+GD49/7/QYIVKm0AD9JmNMtzhWHCRvsfiHXNHMSpLsuNBuEFep+gnjmBqaVEoy3W395qHj4cK7INHMtB0LrpTAPXZj4mWKdQRIENJNZVNdPd+ZjWdvgi20Hl8qrTTxVJJBitBmkJPwBfmsxTGPHc6D6nx73skQ2WbXy4CIO5/DWkF9suZRQRFqCaqJETu4dyK/wf8wnxgDmuG1bVRlzQXACOy4J1X2RdOzNJotvRbYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199018)(31686004)(2906002)(8936002)(5660300002)(41300700001)(66556008)(54906003)(4326008)(66476007)(8676002)(66946007)(316002)(83380400001)(6636002)(6486002)(86362001)(966005)(6506007)(110136005)(53546011)(6512007)(478600001)(2616005)(31696002)(26005)(36756003)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RERvd1c3K3c4TTdWTGZUOWZyalo0L3RzRlUwT2MwWWhBVFM2WFNmZW5MMzZo?=
 =?utf-8?B?clBTWXE1U1hJWURoSXhYcmN3eE4wYzlleitwa1kwSm5KZEJDR3VDNEFaaUJF?=
 =?utf-8?B?V0NXMFpBei9TRVFJVzJxVThaeU1wWHJOR05wK0Y0SDI0YjBndGR2dlVDeFZR?=
 =?utf-8?B?R1BSUEpzQzY1ek5RWHBHNm00ZFRoTS9NNkkvTnNSM3JMM3BiZkNkamd6M3Y4?=
 =?utf-8?B?RUNNTEFnME5yWnlPekxnQ0xiaUZvSU5SUUtKTXNmc1U3TjA4WEZ4SWdFRWRJ?=
 =?utf-8?B?UWtheXQ0Nm9vRW1tN0h1VmFOMWRHc3BMVW1KYWFwMXZDeURLZGlVdjh2NjUy?=
 =?utf-8?B?bEhDOURuSjhSbnhsVnVpamFMMmUvNUwxYTJoV1Y4UkNyTTFNRDdXTGpzVVl5?=
 =?utf-8?B?Uy93UWFpL0orOTJwanZzSzJoRWJTUmVKZUNJVFEydk5vaHhHMXdPYURnNE91?=
 =?utf-8?B?TGVPemppQnpUcHpVSEdtYnA2dHp2VzhpUWJYdVFrSndRRjlJZ0Q0NzMzUXRz?=
 =?utf-8?B?YlppSklDTENNektFOE51RXpreFJHR0tnQ1ZQaE5NVW1OTTh0REhOUVd5RjBY?=
 =?utf-8?B?ODRNNWlCTERuMSsrblRoZE90aWd3WTNDVFBOTW5jUWZXRkJDSmV4REJDQ2Fs?=
 =?utf-8?B?bkRsb3lrK2gwd3FNTU51YkV5YUcybUViZ1pib3BDVHZ3MmlkcDBuaTlUZzRL?=
 =?utf-8?B?WkxyQU1yeW9ZMEFqNC9uV3UyZ0Z6aXhZTTFJYlZRRmJZVTF5R2JYZ3JaRHNX?=
 =?utf-8?B?Tmh1UnhJSHVkVzF3OW1zckNlZ015YitaRVlFMDJDK2lIWktsZitIZmhOSmVu?=
 =?utf-8?B?Y1FXbTdSZTZ2SjhJVjN1K2dRL1VKc1lvd3Rid2dENjRzWkJZcXJEU0pKbVo4?=
 =?utf-8?B?Nld3VWtOc1ppZXd5cVVHOFRQdytuS2dBVFFuR2lNZ2lDYWtwTlRTS1hlWllh?=
 =?utf-8?B?Vzdvc2sybjAvRHpUa2F1RGoxN0Q2U1hDRFZEUFRRbW84WGpZM1ZKeXg0ZlF0?=
 =?utf-8?B?YUNXVm9Hd0hNUlAyTERUbmRpend2d3MwaDUzUzlDNGJyVVRVRmxKZVdFSlNJ?=
 =?utf-8?B?azRjenRtajZNTWk0TmxLWmFZZWF4MGpUR0Q0ZE1PWWV2ZHVTUXBBVW1VK1FQ?=
 =?utf-8?B?ZVFtWWY0TGRpcUpvZ0IvU3dGSnBDYm1LYUNuRnNDK1BxeFY4RWZxU3FSZzEy?=
 =?utf-8?B?elg4VlBvSjNjblpGY1hIQzNWeU8xR3c3VEZ2Uy9EaWE5aVRma0xEOFJmazNo?=
 =?utf-8?B?VEkzVHdmZWRoOHlIUDhBOE5NL3FxRGxrYmpMc3JXNHFUWnU0Mnp6dG4xWkZD?=
 =?utf-8?B?aGp2WE1NR1pNVWNUY1N1anhIVWI2TnY1V2ZWVDJ5cHNDMFdxdUUwTnJOUXVW?=
 =?utf-8?B?SER1dllWVkF0Zy9Tb3pmSnVLalhweGtNMm5EOW9INUJXdnZmWEtscWg2NCt5?=
 =?utf-8?B?U3lBNGwrYkg1dDNZUnJOK3JXTW82aSszSERtZWxxSWtLMlNsSUY1NWhxUU80?=
 =?utf-8?B?bm9PdzU1dE9SZTZHUXI1alAvdFRVNUlNUXBVR0N5R3JENjhjT09yaWJCQ0FM?=
 =?utf-8?B?L3hLRTVrV2ZpNGY4Q1BzZE5RWHVWMnVibEJGVHNrNlNUdFduclFHMUMxSkpk?=
 =?utf-8?B?aCt2V1VoeitOenhDUnVmYytYVWJ3cy9vZ3ZaMktGcFdtTkpIT0VmcjN4K0hM?=
 =?utf-8?B?d2xaZ2ZsYngrTUg2QThYTVp4QVBydksvakJqeitvVWVjdWFiMXBhYUhWdjhE?=
 =?utf-8?B?M2hzRzlhSjF4VmREMFQ2YkZwUDRxR09aMmJZZjlsRGJ2VU85aVlUQXJpcS9o?=
 =?utf-8?B?cWdOZFVWLzFiejJnTnlNbnBkY2x3UUJMVnloS0VmNDZMczd2WXptTGpPSmpE?=
 =?utf-8?B?aUpmQW1xVTliYjllSE0yMjJWb2cvcFAwWGticnFqTExyYjV2VWdCWW5sS2M5?=
 =?utf-8?B?c3ZUbHdjQWZOZWkrTDJWeVJlc3l3d0hQb3dJUlFMdDRGOTZFZU1YS2dRLzVo?=
 =?utf-8?B?ditxVk5TaVUzZm9hV1lMOVNUV25aWWFDRWxrSmhIT0x5OUVram9vQ1NZU0d1?=
 =?utf-8?B?TDVRUGU0dlhkN2VObURIM1ZiaDJSa2ZuTy9UeTM3Ym91cWYzWkZob1dlUG1E?=
 =?utf-8?Q?+q8DTdq77uS4GNAerewKnnmVr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724b7eb5-c29b-408f-a0f9-08db20ccabd3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 18:32:43.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ior7++gex4TlowWpYtZ4s7k8GQaSrr64cfF0mjKzBYVIwJVAXwF7s3s5wXG8151OH6ErczthCpzu3W1Cg+qBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/9/2023 12:25, Bjorn Helgaas wrote:
> On Thu, Mar 09, 2023 at 01:04:17PM +0530, Basavaraj Natikar wrote:
>> On 3/9/2023 4:34 AM, Limonciello, Mario wrote:
>>>> -----Original Message-----
>>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>>> Sent: Wednesday, March 8, 2023 16:44
>>>> To: Natikar, Basavaraj <Basavaraj.Natikar@amd.com>
>>>> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; Limonciello, Mario
>>>> <Mario.Limonciello@amd.com>; thomas@glanzmann.de
>>>> Subject: Re: [PATCH] PCI: Add quirk to clear MSI-X
>>>>
>>>> Let's mention the vendor and device name in the subject to make the
>>>> log more useful.
>>
>> Sure will change subject as below.
>> Add quirk on AMD 0x15b8 device to clear MSI-X enable bit
> 
> "0x15b8" is not really useful in a subject line.  Use a name
> meaningful to users, like something "lspci" reports (I don't see
> "1002:15b8" in https://pci-ids.ucw.cz/read/PC/1002; it would be nice
> to add it) or at least something like "USB controller".   You can look
> at the history of drivers/pci/quirks.c to see examples.
> 
>>>> On Mon, Mar 06, 2023 at 12:53:40PM +0530, Basavaraj Natikar wrote:
>>>>> One of the AMD USB controllers fails to maintain internal functional
>>>>> context when transitioning from D3 to D0, desynchronizing MSI-X bits.
>>>>> As a result, add a quirk to this controller to clear the MSI-X bits
>>>>> on suspend.
>>> ...
>>> FYI - it's not a hardware defect, it's a BIOS defect.
> 
> Commit log ("controller fails to maintain") suggested hardware defect
> to me; maybe could be clarified.  If it's a defect in the way BIOS
> initialized something, maybe the workaround could be a one-time thing
> instead of an every-resume quirk?
> 
>>>> The quick clears the Function Mask bit, so the MSI-X vectors may be
>>>> *unmasked* depending on the state of each vectors Mask bit.  I assume
>>>> the potential unmasking is safe because you also clear the MSI-X
>>>> Enable bit, so the function can't use MSI-X at all.
>>
>> Sure, will remove Function Mask bit only clear MSI-X enable bit is enough,
>> actually MSI-X enable bit doesn't change the internal hardware and there
>> will be no interrupts after resume hence below command timeout and eventually
>> error observed more logs below:
>>
>> [  418.572737] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
>> *[ 423.724511] xhci_hcd 0000:03:00.0: Command timeout, USBSTS: 0x00000000****[ 423.724517] xhci_hcd 0000:03:00.0: Command timeout*
>> [  423.724519] xhci_hcd 0000:03:00.0: Abort command ring
>> [  425.740742] xhci_hcd 0000:03:00.0: No stop event for abort, ring start fail?
>> *[ 425.740771] xhci_hcd 0000:03:00.0: Error while assigning device slot ID****[ 425.740777] xhci_hcd 0000:03:00.0: Max number of devices this xHCI
>> host supports is 64*.
>> [  425.740782] usb usb5-port1: couldn't allocate usb_device
>> [  425.740794] xhci_hcd 0000:03:00.0: disable port 5-1, portsc: 0x6e1
>> [  425.740818] hub 5-0:1.0: hub_suspend
>> [  425.740826] usb usb5: bus auto-suspend, wakeup 1
>> [  425.740835] xhci_hcd 0000:03:00.0: xhci_hub_status_data: stopping usb5 port polling
>> [  425.740842] xhci_hcd 0000:03:00.0: xhci_suspend: stopping usb5 port polling.
>> [  425.756878] xhci_hcd 0000:03:00.0: // Setting command ring address to 0xffffe001
>> [  425.776898] xhci_hcd 0000:03:00.0: WARN: xHC save state timeout
>> [  425.776910] xhci_hcd 0000:03:00.0: PM: suspend_common(): xhci_pci_suspend+0x0/0x170 [xhci_pci] returns -110
>> [  425.776917] xhci_hcd 0000:03:00.0: hcd_pci_runtime_suspend: -110
>> [  425.776918] xhci_hcd 0000:03:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)
>>
>> will change function name accordingly quirk_clear_msix_en
>> and with only ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
>>
>>>> All state is lost in D3cold, so I guess this problem must occur during
>>>> a D3hot to D0 transition, right?  I assume this device sets
>>>> No_Soft_Reset, so the function is supposed to return to D0active with
>>>> all internal state intact.  But this device returns to D0active with
>>>> the MSI-X internal state corrupted?
>>>>
>>>> I assume this relies on pci_restore_state() to restore the MSI-X
>>>> state.  Seems like that might be enough to restore the internal state
>>>> even without this quirk, but I guess it must not be.
>>>
>>> The important part is the register value changing to make
>>> the internal hardware move.  Because it restores identically it doesn't change
>>> the internal hardware.
>>
>> Yes correct, even though pci_restore_state restores all pci registers states
>> including MSI-X bits __pci_restore_msix_state after resume but internal AMD
>> controller's MSI_X enable bit is out of sync and AMD controller fails to maintain
>> internal MSI-X enable bits.
> 
> So the register value *change* is important, and you force a different
> value by writing something different at suspend-time so the value at
> restore-time will be different.  That's a little obscure since those
> points are far separated.
> 
> Also it changes the behavior (masking MSI-X at suspend-time), which
> complicates the analysis since we have to verify that we don't need
> MSI-X after the quirk runs.  And the current quirk relies on the fact
> that PCI_MSIX_FLAGS_ENABLE is set, which again complicates the
> analysis (I guess if MSI-X is *not* enabled, you might not need the
> quirk at all?)
> 
> Is there any way you could do the quirk at resume-time, e.g., if MSI-X
> is supposed to be enabled, first disable it and immediately re-enable
> it?
> 
>>>>> Note: This quirk works in all scenarios, regardless of whether the
>>>>> integrated GPU is disabled in the BIOS.
>>>>
>>>> I don't know how the integrated GPU is related to this USB controller,
>>>> but I assume this fact is important somehow?
>>>
>>> This bug is due to a BIOS bug with the initialization.  We also posted in
>>> parallel a different workaround that fixes the initialization to match what
>>> the BIOS should have set via the GPU driver.
>>>
>>> It should be going in for 6.3-rc2.
>>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/07494a25fc8881e122c242a46b5c53e0e4403139
> 
> That nbio_v7.2.c patch and this patch don't look anything alike.  It
> looks like the nbio_v7.2.c patch might run once?  Could *this* be done
> once at enumeration-time, too?
> 

They don't look anything alike because they're attacking the problem 
from different angles.

The NBIO patch fixes the initialization value for the internal 
registers.  This is what the BIOS "should" have done.  When the internal 
registers are configured properly then the behavior the kernel expects 
works as well.

The NBIO patch will run both at amdgpu startup as well as when resuming 
from suspend.

This patch we're discussing treats the symptoms of the deficiency and 
avoids the impact.
This patch runs any time the controller is runtime resumed.  So, yes it 
will run more frequently.  Because this patch is treating the symptoms 
it needs to be applied every single time the controller exits D3.

