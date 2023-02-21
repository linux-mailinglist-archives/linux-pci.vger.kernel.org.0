Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EBC69DCA1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBUJNi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Feb 2023 04:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjBUJNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Feb 2023 04:13:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F559E07B;
        Tue, 21 Feb 2023 01:13:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS4ifLzk6WMxJIJhAYFJWDBYa9MxuNyivyTscMq7xztNbZ0KygaGDS/khDlIjnufD5vbPQljvnlbBSih2oSbkuNMmZbUSVUkFh+x31fBxu1Op6XDq10/6RPrmQ1MaI58Bguv05QvIKqxOATtf3c6TmB6Fr0o1LSfmGzoXTfAP6jETT4MH2ipQGzCVaq3m5qx8DjO82aJVT7RWgpNg97wPqCZuc+Wgx3XA8nh0yD+0rUTUD4OEVUoh7PMX+SQnVqcZ7isPsD1Ak8R0fBGzopUbHAo2CzB9DY6Z4bviruEUDF8qEWfQyZNP7rwnYbHMhS0wnKiUrLVmaC9T6YtYYqdSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMIL1vPstxkhcdx8Yye8JXmF2cYBceAvGGcWDdTGyvo=;
 b=CNLzcuvgowv5SCgRkWFTb+Wyba//McNwGzQhKW/efPYZZkqaLBR3ebnI0hGTvmZHyEXS7X3Gy9VHDe1jAaQ9FXE7cNwpPz6M3HxS42Zo50zLmF2kyijrJZb+0UBAKb9d8HcNH7mgyDRvYe+bCEPcjMUb44sc1P2RtcyJXJsvcqna6nteQc24C/5bZf0GUcco1FEVJgjO1pURe9NGRZQGwf0oNvs1+ujg63VO+zdtCpaS3eQgj4aACSo7fxuRKrMdF56gh69dapfXIYXDuLHzQGgHAWAUNWlpjiEuwvCGjz5SNZEVLeK7q6eAl3HhSK8XYhNZKP9RNMwSzkF/kB4NGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMIL1vPstxkhcdx8Yye8JXmF2cYBceAvGGcWDdTGyvo=;
 b=eFANQ5ybRv5spMcPkxdoEqb7ECQE9gial+qBOKx+Qr/Ue5iRzfECDhJlfN849ITfudppfSQOAckHPPJNoNQ1U2c2r1ldQRszFzXzsURHR3oa722awbwyexpUqwXGDGLE6ig4L1peSzjS8LioyLIm0c9qhtdq0IPKtLIK6GUg8Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 SN4PR01MB7406.prod.exchangelabs.com (2603:10b6:806:1e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Tue, 21 Feb 2023 09:13:31 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%7]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 09:13:31 +0000
Message-ID: <2fe43de6-f356-f996-c2cb-22f66f2bf593@os.amperecomputing.com>
Date:   Tue, 21 Feb 2023 14:43:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] PCI/ATS: Allow to enable ATS on VFs even if it is not
 enabled on PF
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <Y+ksmNWJdWNkGAU9@unreal> <20230215205726.GA3213227@bhelgaas>
 <Y+4PmJb2rBGMhS1y@myrica>
 <3877b6fe-2b7e-3e0c-8b69-65e84c09cdd2@os.amperecomputing.com>
In-Reply-To: <3877b6fe-2b7e-3e0c-8b69-65e84c09cdd2@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0405.namprd03.prod.outlook.com
 (2603:10b6:610:11b::15) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|SN4PR01MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: f89125aa-681c-433d-b643-08db13ebe6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io7ogMTpMtN9sv3zG4K8O4igNaHpAFYwLmZ0n9KhL1c4dFB5NWXZuus93Jj8cOJEH23U2AdP+E1czWLpEuHD3nf/xm3JYN2pyx9RQNKJh1I198NIm1tUdnLZ9RlmshycRvcRIrCuHMQ54JUwmaK8IAK7PU8g6d/W1LGFSlCO0WZ2uSgp2Rf4lqgAOkQ4ePI9Pdon8Xpzcm6bKwnr8XHIjj/99gbp/e6yyAOzCmZrxw1SLbn4tWaiT9kXHQ128L5JMxF1B7yOg1AmouZDxrmrXjkNIa76YlvkewHV85wAsd9q/WFw7d9UHmJrpAaEtEUb1R+Zr/p+4mnEP3max4aPebaQvr63jlRxyI11Y5cWG76USfw76yBLMpNU7bIJ1Ebep+WLr/ratJbz6Y551RkizC2jc6nyrHUo+2KlOGHLhgeb0Rzpdr22GmcymonDsTGcyS0uKkpTYq3AJ73vs3BZ3+kz1YdwyU3xKaZ3pSxlvLM0KtDiYNlNVkJ76bBvU7wghn8YHHJ/IY8jWBta2jPjXd6EVS3D4mnaIiZGYpoyQL7JJ5f9Z9P8P/vZLSlCEPF2vo8Duxa4ITgy1mRjeVKk9Cr3B60zRZqqvzqFEjRWhZav5S1JjljU8ojNvuu2MSsivIzRt3Pcv2t3U593fjsEIzXrm72RdDbIjD5bLw+cy6GYCaW3/UfLm4JRnhocfOQBBOlp2c+CJWhb9dEx8Hz+bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(376002)(39850400004)(451199018)(31686004)(38100700002)(2906002)(8936002)(7416002)(5660300002)(6512007)(26005)(54906003)(186003)(83380400001)(41300700001)(2616005)(66946007)(66556008)(66476007)(4326008)(8676002)(86362001)(6486002)(6506007)(478600001)(6666004)(31696002)(110136005)(316002)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEYxemtHOXdhckp6RmEwQ0NPK3ZLWWxseG5oVDFOTGIyc2k3MEVpbURMYXVR?=
 =?utf-8?B?UkhqOXFJd2IxYUxiQnRxNXFEYU9QeWtuMlZET1ErUXlRL3NEd1RvRC8xSHRO?=
 =?utf-8?B?aEtGUnQwZkMxdlc1YXdZczVmeERoSGF5SlBBdmRyVXUyT1lFaVVUaDZPNUtG?=
 =?utf-8?B?aWJvNFVJdUk3SHZJOUlWNEZrZURLV3lreElOM2QrMUlRbmF6TGRCMStmOUFv?=
 =?utf-8?B?a0pXRmgzQmVmSHY4b2lZMkQySlNTRmIrNDBRTm10TDVBNHRCSk1mc2hVdlB5?=
 =?utf-8?B?L1R2VHJITXBjVjhrV04zcENHdEY0ZWZONS9BN21hZy9UYzIwQVhEMlk0VGxr?=
 =?utf-8?B?OUF6SjVLZG9OY2hVU3hsRHQrSlhNTk82cGlURFpVQTRMNDhXRVFKVUJUVHcw?=
 =?utf-8?B?b0ZxeXorZldCN0IwQUl3SGwzQXZRc1M0T3RRZ2lWbmJOVU5TdXBGOWFVN0hM?=
 =?utf-8?B?ZnNySnk1eVpNUklUQ1crSTdHcGFpNWF0UjRFQUxoNWN0TGpPZEVzN1FKN2tp?=
 =?utf-8?B?VEVieW0yZWxVL045QUU1ME1xTXl3clZPakdGY1dvV3JWa2pZK3NpNlpyNkJX?=
 =?utf-8?B?alN5c2NjamF4aWxhc2xKbzJjMnAzU3RkM3NCR2NkUGhiQ1ZJVlJkc01HR0hJ?=
 =?utf-8?B?emJJNVNQaVFIallTN1k3aWVCaTZpU1Y3UWRkdFZHYmJTNE0rM0V6aXB2U1RJ?=
 =?utf-8?B?QjdPbVhPNUkvTVI4VUNNd3NuNmZuR2RKa1k3REt2QThodEpEYzZkY2tlQjdv?=
 =?utf-8?B?eHRtVTgvOWw0dWdRaFRmNWNlWE4rUGwzeXpvbUM4ejNBS1N0RG90S09hdWky?=
 =?utf-8?B?VHdveWE5OWdhVUhzbzVLc3o2SzVaNytVT3FyTkhpWi9GUXFUYWpqaFVaL21X?=
 =?utf-8?B?am1WbUgrY2h2TkNoUkNnelQ4bHErUU5Ca254THcvMHoxRWltcWdKbS9KTlFl?=
 =?utf-8?B?MWpYY2FIOWUzcFVEaXFDZXo0eGtVZFQ2eDIvNVJLTUtvSllPVHlYb3JRNnhj?=
 =?utf-8?B?c0IvK3NxRTh6YXBjVUVsdFp3VnZPemt6V2dpeHJnVEpPSkNXeTRLTG1DYTNq?=
 =?utf-8?B?TmlUSmMyWS9mdDJwNER4WkFiWElhNHNRTDg5WEZLWTI1RGR5d3N2RldGa0Yz?=
 =?utf-8?B?TE82UytRNU1sU3FRNU9VUWhoM1Fkc201Wm5VRXo5QlBzNVBBaDBKeVVUU3ZT?=
 =?utf-8?B?OTE0bUtIaEVIRER6MXJaZE5SbkJIa0hkQkxMNXFqRXBVOC9yT3lsYnZDamcy?=
 =?utf-8?B?RWJDeTk5WjY0SXlTaGpBeWdpcmFzOGlzeWpSYVgxaHJ5aC96bzlZWU1uZE16?=
 =?utf-8?B?Yk9IS3gwVFFlVzBxWDlndERvcjBxbHNmMUlmT3BSTm4zeHVYM3R4S3dSaEtW?=
 =?utf-8?B?a1hIYkFhNzd3TkNoUkg3TVVtQ3czc1QzMHg5bWZSL0owSWVaTk5Pa01Dem03?=
 =?utf-8?B?clVkV1d1UFZGWlRocUNTeDB0bWxvTk40U1F2TnBXcjhuQk5CdkpudVdXTUJI?=
 =?utf-8?B?UllqeTcwVGtsZVRiblZabGYrKzkyWG42K2NITlhJTFZ6ZjM1Ync1VU51MTY3?=
 =?utf-8?B?am5ZYUx6cGNyK1VHRDhHVkxrOWFzam5ZM3ZyblVTZmtOVTROL3oxZVFBbmxq?=
 =?utf-8?B?eG45MFM0RXpQK21DbHZIU2trMmowaHhVei9CWWh1YnZiR0NRVTZkTDRLVHdH?=
 =?utf-8?B?OVdlY2lXZzRsNy9ubGZmdnJzZWpIMHkzQnoxWUtKRkIzbnF6NlZzcXhJazMy?=
 =?utf-8?B?a09FK01vL2htTml3Y2Y5WWRCdnpXbzhRL1VWRXMxNGVyZlY1dXNLNmd0Wk9p?=
 =?utf-8?B?czdUcHpEQS9PVTJkbzJrbkRtWlJPa09pd2dpRE9jRWdIVzMvelpFMEk3eVps?=
 =?utf-8?B?eC93U1lvaGs2QzQvc2xRdmpyUHNPRWkrV1lQMExiZ1F2VEtCam9jVW5ZKzhV?=
 =?utf-8?B?VkY4dFFwclFrUjRiVCthdnFvRVFHL0lhYnJMTU00cXVFTFNTWCs5djVidFRm?=
 =?utf-8?B?OXZhTzVqSzd0Q2FBVHF0bFk1NUV2Q1g1eDdSWkEzaHZzdG9kTUlBUklYQ01I?=
 =?utf-8?B?MGZEWGZyUHpnenUycmc5RlE1S3NBWTYwdHEyMWlyK0ZCbVUrOUV6T1lYU01k?=
 =?utf-8?B?QWprd3ZLMUY5TTVNZi9weEdJWGs2NFQzRkx4WmgyY2paYTFpOVJJSWN1bGxj?=
 =?utf-8?Q?gbCm8HwRggl/CGzz1wRgyYvDGW6430YjC6WwEmKOpOcK?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89125aa-681c-433d-b643-08db13ebe6cf
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 09:13:31.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3M3aiE5nbZWikScelPlUAzR6C3JG22W1jWpbfNTT5uDdvf4HaUscOOjEI3Ag+z8UbEX54xAvssn6x0LTzIu3mbV762oewPbig7hrwwMiwJArYPwQcbrZwjl7457+Yi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Bjorn,

On 16-02-2023 05:06 pm, Ganapatrao Kulkarni wrote:
> 
> 
> On 16-02-2023 04:42 pm, Jean-Philippe Brucker wrote:
>> On Wed, Feb 15, 2023 at 02:57:26PM -0600, Bjorn Helgaas wrote:
>>> [+cc Will, Robin, Joerg for arm-smmu-v3 page size question]
>>>
>>> On Sun, Feb 12, 2023 at 08:14:48PM +0200, Leon Romanovsky wrote:
>>>> On Wed, Feb 08, 2023 at 10:43:21AM -0800, Ganapatrao Kulkarni wrote:
>>>>> As per PCIe specification(section 10.5), If a VF implements an
>>>>> ATS capability, its associated PF must implement an ATS capability.
>>>>> The ATS Capabilities in VFs and their associated PFs are permitted to
>>>>> be enabled independently.
>>>>> Also, it states that the Smallest Translation Unit (STU) for VFs 
>>>>> must be
>>>>> hardwired to Zero and the associated PF's value applies to VFs STU.
>>>>>
>>>>> The current code allows to enable ATS on VFs only if it is already
>>>>> enabled on associated PF, which is not necessary as per the 
>>>>> specification.
>>>>>
>>>>> It is only required to have valid STU programmed on PF to enable
>>>>> ATS on VFs. Adding code to write the first VFs STU to a PF's STU
>>>>> when PFs ATS is not enabled.
>>>>
>>>> Can you please add here quotes from the spec and its version? I 
>>>> don't see
>>>> anything like this in my version of PCIe specification.
>>>
>>> See PCIe r6.0, sec 10.5.1.
>>>
>>>>> Signed-off-by: Ganapatrao Kulkarni 
>>>>> <gankulkarni@os.amperecomputing.com>
>>>>> ---
>>>>>   drivers/pci/ats.c | 15 +++++++++++----
>>>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>>> index f9cc2e10b676..a97ec67201d1 100644
>>>>> --- a/drivers/pci/ats.c
>>>>> +++ b/drivers/pci/ats.c
>>>>> @@ -67,13 +67,20 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>>       if (ps < PCI_ATS_MIN_STU)
>>>>>           return -EINVAL;
>>>>> -    /*
>>>>> -     * Note that enabling ATS on a VF fails unless it's already 
>>>>> enabled
>>>>> -     * with the same STU on the PF.
>>>>> -     */
>>>>>       ctrl = PCI_ATS_CTRL_ENABLE;
>>>>>       if (dev->is_virtfn) {
>>>>>           pdev = pci_physfn(dev);
>>>>> +
>>>>> +        if (!pdev->ats_enabled &&
>>>>> +                (pdev->ats_stu < PCI_ATS_MIN_STU)) {
>>>>> +            u16 ctrl2;
>>>>> +
>>>>> +            /* Associated PF's STU value applies to VFs. */
>>>>> +            pdev->ats_stu = ps;
>>>>> +            ctrl2 = PCI_ATS_CTRL_STU(pdev->ats_stu - 
>>>>> PCI_ATS_MIN_STU);
>>>>> +            pci_write_config_word(pdev, pdev->ats_cap + 
>>>>> PCI_ATS_CTRL, ctrl2);
>>>>> +        }
>>>
>>> For reference, it is this way because of edc90fee916b ("PCI: Allocate
>>> ATS struct during enumeration").  The rationale was that since the PF
>>> STU applies to all VFs, we should require that the PF STU be
>>> programmed before enabling ATS on any of the VFs.
>>>
>>> This patch relaxes that so the PF STU would be set either by (a)
>>> enabling ATS on the PF or (b) enabling ATS on the first VF.
>>>
>>> This looks racy because theoretically drivers for VF A and VF B could
>>> independently call pci_enable_ats() with different IOMMU page sizes,
>>> and we don't know which will get there first.
>>>
>>> Most callers supply a compile-time constant (PAGE_SHIFT or
>>> VTD_PAGE_SHIFT), so it won't matter.  arm_smmu_enable_ats() is
>>> fancier, but I *assume* it would still supply the same IOMMU page size
>>> for all VFs of a given PF.
>>>
>>> But it's still kind of ugly to call pci_enable_ats(dev_A) and have it
>>> muck with the configuration of dev_B.  Maybe we should configure the
>>> PF STU (without enabling ATS) at enumeration-time in pci_ats_init()?
>>> Is there some way to get the IOMMU page size at that time?
>>
>> Not really, on Arm the supported page sizes are discovered when probing
>> the SMMU registers, which may happen later than enumeration, during 
>> module
>> loading.
>>
>> What this patch is trying to solve is:
>> * want the PF to bypass SMMU translation, and the VF to undergo SMMU
>>    translation (in order to assign it to a VM)
>> * SMMU forbids enabling ATS for a configuration that bypasses 
>> translation.
>>    So the PF ATS capability must be left disabled.
>>
>> For this situation I wonder if we could do: the SMMU driver, seeing that
>> the PF is configured to bypass, calls a new function 
>> "pci_configure_ats()"
> 
> IMO, This seems to be feasible solution for this situation, which 
> addresses SMMU-ATS expectation in bypass and we could avoid PCI VFs 
> race. pci_configure_ats() can be called to program/configure STU of a PF 
> in smmu-bypass mode.
> 

Can we add pci_configure_ats/pci_configure_ats_stu helper?

>> instead of pci_enable_ats(), which would only set the STU but leave the
>> cap disabled. Then when setting up translation for the VF, the SMMU 
>> driver
>> calls pci_enable_ats() as usual, which sees the PF's STU set 
>> appropriately
>> and succeeds.
>>
>> Thanks,
>> Jean
> 
> Thanks,
> Ganapat

Thanks,
Ganapat
