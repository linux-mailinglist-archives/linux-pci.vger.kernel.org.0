Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932D71F3A0E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgFILry (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 07:47:54 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:6118
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbgFILrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 07:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1WZ+8W9CdsWta7pFCzGrEv9q+28e3qkfPSXNISPVqiSMSl75UpxmlWAbIYYMkjokphvgJucgFZKybVWjZ9Q9VTmwMwP+Q18KmtqOtCzR0tGZYwFEFJn6BgoZQ1KfVDrpXjA+m2EdyD0FlUWVVQKymqdq2eVDlfDOscdbhR7gAudJuUIYemJmNu7SnVorP+H7JgTiRhXsxc28BG3EG/ss0WEyKTCzvPzwmdRndpV5AGjXSo/EDizdbq1piGG7q9HL6xaaBmtXH2rX/5izbl8LxkvbOkKNKXNMhRXDWRvtnV8ZwCmVQXVr6ECArBmttky6949OOttbjmBXbECnW7p0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgJXXF16XS6g8+dfgYNzBEWE2+rH+9QCGitj2wJfE0Y=;
 b=XL756X28AftoDh2E6+svsTMsWSM3jZzGI1HlJcAiU76yb34OP8vEVM5vEDb8egYc9JeX13thUs5f22ybdVJ42hJxjzCsUtoPrAyJDGx7lpzZuzt0hODSaDnfY+nT/+4a1OptFGlqcthJWzC305+kF8IuetrYwsVbV4i9ccsdZEypdx1jQficmOoFdT1E799FOpHbBPQa5VHH4ZisL0/4L4Tr6a9ojd7+EiupOF9eZHSeGFq4g+0qNQzjH1PTbUDuRGZh2OPVXDXURdUalkAMplDlY3SWR5gzGbt3cB3lqDMkpuStQ/GIfDBD7e93KohhwDj+/kIAGNLT9zHVnxyRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgJXXF16XS6g8+dfgYNzBEWE2+rH+9QCGitj2wJfE0Y=;
 b=0Rm2a6EvQPjKaY66mYlvShQndgrP0tGKZjsuYhWfbupkcy9nTZ9J9zm9N1KuBZguhPqmVUa+kTN7dWn/8StSyU1l2GEIxlQrJIcqXKzk9145bjQGfd6vP+jb/essR3UND8vLM20nkgZvtK5zVapEsRGTp2W5NeM3EY7YBMmT3Ro=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8)
 by BN6PR1201MB0084.namprd12.prod.outlook.com (2603:10b6:405:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Tue, 9 Jun
 2020 11:47:49 +0000
Received: from BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::20e1:a2a0:370b:aee8]) by BN6PR1201MB2467.namprd12.prod.outlook.com
 ([fe80::20e1:a2a0:370b:aee8%11]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 11:47:49 +0000
Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
To:     Marcos Scriven <marcos@scriven.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kevin Buettner <kevinb@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20200524003529.598434ff@f31-4.lan>
 <20200527213136.GA265655@bjorn-Precision-5520>
 <MN2PR12MB448819B8491290B54E7FABC9F7B10@MN2PR12MB4488.namprd12.prod.outlook.com>
 <CAAri2Dqruwmu19o1V1b_=0-0RR+J_dgmxFi=izLej_m=XQ1VGw@mail.gmail.com>
 <CAAri2Dqm6vGySEFjUYKcED5fJcN2Gr38Cj-02ab5ONuz6r88jw@mail.gmail.com>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <28a6da20-c143-eaf9-d03d-dd00cb76bb56@amd.com>
Date:   Tue, 9 Jun 2020 17:17:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAAri2Dqm6vGySEFjUYKcED5fJcN2Gr38Cj-02ab5ONuz6r88jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BM1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::28) To BN6PR1201MB2467.namprd12.prod.outlook.com
 (2603:10b6:404:a7::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.88.77] (165.204.159.242) by BM1PR0101CA0018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:18::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 11:47:46 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53725399-7c9f-481f-a28a-08d80c6aef36
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00842AEAB284A2E563E1D320A0820@BN6PR1201MB0084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkYDFkzifPzpUyBmk+uVFkmhsoNTSeug3LnHAVLV6w/tMa4F2VBZY39/42fTe3Ip93uBU4Frq/von+3Ig0J9/UEKdxTFiHtoZAa3dj527PTMDbuAAaic1MRo3YYM/Us8kLqM2G8QTbL0sqOVsV8jG1frowlrj5Wqe7rX6dXr/k9dJDiVyakm5HKdpJR4rA+UjrM5TPA13aGRYQ77YH5rYm2lC+VhA3915EkKGwZYykh/rrxuQYQsEWgXCKMOWwSkE4LtHC+UbQTbsNe5g+2knZn7sKhjGzMOCg+iPWUBqw8jsuHm2sxFpRjm1h4MuJQ4Ixm0XgoucayHRl4CkJwC/xeggNWRzVxeM6lNgJYb+lyKTb7j3H0SP5gaAt8hoq2P/eW3O21nTOqsm0cpxVAXXQ/crt8imKXWGRHiQQZiMhKyvXWe2n0UKtok20AhgS9i3GcnOtU4M+u7xqtj/Rj33Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1201MB2467.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(66476007)(31696002)(186003)(66946007)(86362001)(16526019)(4326008)(8676002)(53546011)(6666004)(52116002)(31686004)(26005)(83380400001)(956004)(5660300002)(2906002)(36756003)(2616005)(478600001)(6486002)(16576012)(6636002)(8936002)(316002)(45080400002)(66556008)(83080400001)(110136005)(54906003)(966005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /YqnaPP3a5gdHaVcivDp6oTFOWiJfP+80TmjZx2RtNTQuD9hbLsFPIohD1ikvhmacY7S5JzHNJcf2x3QCtRa1ns/zYTfD3ZS+AZyCnW4F38uHMUGH7q3RFsnX+sr3do74etaKYElZp8ZiEnIxJhQ/GKHNxmeENuTtzHGJQ34Br7sliMwLOsKX6WZXrTeYg9Zhr3y+i8hm9TjSplep85Q62SY8u6wkvr0tq3ydRRodC7bPiabwGJ39YIMdA/MzNQlbBdey2+qc6Ju7JJC4eBmApZM07bB7GiqI9uTeSf5SWex6o+tFUMpfPYMLlCHheVMM06wLLCR6yUPdZ9TGgun0LexUQmo35pbmux0SazyhGAwg5+qkSh8vGHEjoUHZudJl248UrISUjfX0Jf2rQAvEdxdhrDScK6wT8FdKUByIoiw39P8Zjrdf25fAo1zu9Wtv+clLszjm7W6fyu44hUwdTvKuEwH5xLz46MlFBRKXOk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53725399-7c9f-481f-a28a-08d80c6aef36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 11:47:49.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfmk8DMsHau5ygKAy5yYHpwLhvo7FdGz8f1IQyudWENTV3xWV+7XZkHZMgmH9G+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 6/8/2020 11:17 PM, Marcos Scriven wrote:
> On Thu, 28 May 2020 at 09:12, Marcos Scriven <marcos@scriven.org> wrote:
>> On Wed, 27 May 2020 at 22:42, Deucher, Alexander
>> <Alexander.Deucher@amd.com> wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: Bjorn Helgaas <helgaas@kernel.org>
>>>> Sent: Wednesday, May 27, 2020 5:32 PM
>>>> To: Kevin Buettner <kevinb@redhat.com>
>>>> Cc: linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; Alex
>>>> Williamson <alex.williamson@redhat.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>>> <Christian.Koenig@amd.com>
>>>> Subject: Re: [PATCH] PCI: Avoid FLR for AMD Starship USB 3.0
>>>>
>>>> [+cc Alex D, Christian -- do you guys have any contacts or insight into why we
>>>> suddenly have three new AMD devices that advertise FLR support but it
>>>> doesn't work?  Are we doing something wrong in Linux, or are these devices
>>>> defective?
>>> +Nehal who handles our USB drivers.
>>>
>>> Nehal any ideas about FLR or whether it should be advertised?
>>>
>>> Alex
>>>
Sorry for the delay. We are looking into this with BIOS team. I shall revert soon on this.


>> I had read somewhere that the IO die in the Ryzen/Threadripper
>> packages are identical to the ones used in the motherboard chipsets.
>>
>> Since the latter do reset ok, it would seem a BIOS update of the AGESA
>> may potentially fix the issue.
>>
>> Unfortunately, it's not something motherboard manufacturer's customer
>> support people know how to deal with or pass back up the chain to AMD
>> engineers. Actual use of this feature seems to be fairly niche.
>>
>> After I added the workaround for the USB and audio controllers on the
>> 3rd-gen Ryzen, I tried contacting Kim Phillips (who I found as a
>> kernel committer to x86/cpu/amd), but haven't heard back.
>>
>> It would be wonderful to know if this can potentially be fixed in CPU
>> firmware, and whether there's any likelihood of it actually being
>> distributed by motherboard manufacturers.
>>
>> Marcos
>>
>>
>>
> Dear Alex/Nehal
>
> I wonder if you're able to comment please on whether FLR should be advertised?
>
> Is there any chance this could be fixed at the bios/AGESA level, and
> effectively rolled out?
>
> Thanks
>
> Marcos
>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
>>>> kernel.org%2Fr%2F20200524003529.598434ff%40f31-
>>>> 4.lan&amp;data=02%7C01%7Calexander.deucher%40amd.com%7Ccb77b56b
>>>> 62ae47f60f8808d802855759%7C3dd8961fe4884e608e11a82d994e183d%7C0%
>>>> 7C0%7C637262119015438912&amp;sdata=3z%2Btn%2Bv2pvUl3X0Tzk%2BLoi
>>>> Mk06dLZCmgUOrsGf3kLpY%3D&amp;reserved=0
>>>>   AMD Starship USB 3.0 host controller
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
>>>> kernel.org%2Fr%2FCAAri2DpkcuQZYbT6XsALhx2e6vRqPHwtbjHYeiH7MNp4z
>>>> mt1RA%40mail.gmail.com&amp;data=02%7C01%7Calexander.deucher%40a
>>>> md.com%7Ccb77b56b62ae47f60f8808d802855759%7C3dd8961fe4884e608e11
>>>> a82d994e183d%7C0%7C0%7C637262119015438912&amp;sdata=69GsHB0HCp
>>>> 6x0xW0tA%2FrAln0Vy0Yc9I8QSHowebdIxI%3D&amp;reserved=0
>>>>   AMD Matisse HD Audio & USB 3.0 host controller ]
>>>>
>>>> On Sun, May 24, 2020 at 12:35:29AM -0700, Kevin Buettner wrote:
>>>>> This commit adds an entry to the quirk_no_flr table for the AMD
>>>>> Starship USB 3.0 host controller.
>>>>>
>>>>> Tested on a Micro-Star International Co., Ltd. MS-7C59/Creator TRX40
>>>>> motherboard with an AMD Ryzen Threadripper 3970X.
>>>>>
>>>>> Without this patch, when attempting to assign (pass through) an AMD
>>>>> Starship USB 3.0 host controller to a guest OS, the system becomes
>>>>> increasingly unresponsive over the course of several minutes,
>>>>> eventually requiring a hard reset.
>>>>>
>>>>> Shortly after attempting to start the guest, I see these messages:
>>>>>
>>>>> May 23 22:59:46 mesquite kernel: vfio-pci 0000:05:00.3: not ready
>>>>> 1023ms after FLR; waiting May 23 22:59:48 mesquite kernel: vfio-pci
>>>>> 0000:05:00.3: not ready 2047ms after FLR; waiting May 23 22:59:51
>>>>> mesquite kernel: vfio-pci 0000:05:00.3: not ready 4095ms after FLR;
>>>>> waiting May 23 22:59:56 mesquite kernel: vfio-pci 0000:05:00.3: not
>>>>> ready 8191ms after FLR; waiting
>>>>>
>>>>> And then eventually:
>>>>>
>>>>> May 23 23:01:00 mesquite kernel: vfio-pci 0000:05:00.3: not ready
>>>>> 65535ms after FLR; giving up May 23 23:01:05 mesquite kernel: INFO:
>>>>> NMI handler (perf_event_nmi_handler) took too long to run: 0.000 msecs
>>>>> May 23 23:01:06 mesquite kernel: perf: interrupt took too long (642744
>>>>>> 2500), lowering kernel.perf_event_max_sample_rate to 1000 May 23
>>>>> 23:01:07 mesquite kernel: INFO: NMI handler (perf_event_nmi_handler)
>>>>> took too long to run: 82.270 msecs May 23 23:01:08 mesquite kernel: INFO:
>>>> NMI handler (perf_event_nmi_handler) took too long to run: 680.608 msecs
>>>> May 23 23:01:08 mesquite kernel: INFO: NMI handler
>>>> (perf_event_nmi_handler) took too long to run: 100.952 msecs ...
>>>>>  kernel:watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
>>>>> [qemu-system-x86:7487] May 23 23:01:25 mesquite kernel: watchdog:
>>>> BUG:
>>>>> soft lockup - CPU#3 stuck for 22s! [qemu-system-x86:7487]
>>>>>
>>>>> The above log snippets were obtained using the aforementioned hardware
>>>>> running Fedora 32 w/ kernel package kernel-5.6.13-300.fc32.x86_64.  My
>>>>> fix was applied to a local copy of the F32 kernel package, then
>>>>> rebuilt, etc.
>>>>>
>>>>> With this patch in place, the host kernel doesn't exhibit these
>>>>> problems.  The guest OS (also Fedora 32) starts up and works as
>>>>> expected with the passed-through USB host controller.
>>>>>
>>>>> Signed-off-by: Kevin Buettner <kevinb@redhat.com>
>>>> Applied to pci/virtualization for v5.8, thanks!
>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index
>>>>> 43a0c2ce635e..b1db58d00d2b 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -5133,6 +5133,7 @@
>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,
>>>> quirk_intel_qat_vf_cap);
>>>>>   * FLR may cause the following to devices to hang:
>>>>>   *
>>>>>   * AMD Starship/Matisse HD Audio Controller 0x1487
>>>>> + * AMD Starship USB 3.0 Host Controller 0x148c
>>>>>   * AMD Matisse USB 3.0 Host Controller 0x149c
>>>>>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>>>>>   * Intel 82579V Gigabit Ethernet Controller 0x1503 @@ -5143,6 +5144,7
>>>>> @@ static void quirk_no_flr(struct pci_dev *dev)
>>>>>     dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;  }
>>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>>>>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c,
>>>> quirk_no_flr);
>>>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c,
>>>> quirk_no_flr);
>>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502,
>>>> quirk_no_flr);
>>>>> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503,
>>>> quirk_no_flr);

Regard

Nehal Shah

