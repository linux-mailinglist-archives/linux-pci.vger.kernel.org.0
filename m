Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9A75B6CF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 20:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGTSbZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGTSbW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 14:31:22 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C9F196;
        Thu, 20 Jul 2023 11:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhwFTgRmJv7eoI7VRTbLo/6S5c1/QAyG3XRi7jFFQoA5t6bii3tu4i9SlZCMoHBTRANw7JnJhelXa3V9dX078ol3lpGTJUa92N9BT5/sNufe73rpOqWYN0BNYMRaLBHZsO72ttPyKowr4qx/mwhqWtHPjX0uabwS0ypLxyGRcT1XBLuM3Bo2iWOLN8uKiZigrt4dpYeBqmt/XDnC+t7xc4hKicrr3rVqxTd0A10+tZo8zKVgT52rIE8k6EAXN/hVocpZfx2bcXpUJCeuibPZxEvOMTafkBaHFnQga174RI63yRdmmXyPMVCbbVR+zvySasvnOxcrMLly/w/fPRFK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu5I9vdWUnpr2tsaUClKmxxD4hTXuGrHBkx2uMKcL60=;
 b=N38ivpBoUypWLAfaBUkzi4s0+adOYj25ifgjspUp6Ek1oFThP7QN1Bt1IfenJ+k7z5czdCg3GSy1mQHA04VMjUn7jiRuxx1YOt1Y0nDqEnTMWzDOlO2GnBOEEIy9+yVBlGiTkC7Bh6+wkSL2UMVLm7oxg07K7RpPGGOds0N8b9t4Eja0ZnZlPo120MHNYAWkzsCl5Frsl84W/2gnpoo4TYM2czVfqAIE+WHncuPdERH6EyAEOqQw3tRuIcSm5onvAz2GpaAlZVJXI8b3D1I1jvMpF5m7/jI7Y+0Ym9YLAFOyMNZvfIbBI1Za7Bx72WytuWiYVex5HhRI68T4RdZdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uu5I9vdWUnpr2tsaUClKmxxD4hTXuGrHBkx2uMKcL60=;
 b=rRwL8zVMwGsp4EStEhRZY/h3zSyjTh85gaxttzVBiLUAVoLZ/OwDf8Ore6/4vrNBQ0Yp1l/d2Qwzj+jG5bBoV5DwglttkQjjj/mst0A6CTIV/+veDuLTZ6xFiaih2ReuGb/+0DrzfPlegCFWeLB0upM5EcQdJ/X5s/V+A2p63Q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 18:31:18 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::642c:a4b0:ae3f:378b%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 18:31:18 +0000
Message-ID: <fdadfe06-5d1e-978b-82bf-637a9ad9754a@amd.com>
Date:   Thu, 20 Jul 2023 11:31:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] cxl/pci: Fix appropriate checking for _OSC while
 handling CXL RAS registers
Content-Language: en-US
To:     Robert Richter <rrichter@amd.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        oohall@gmail.com, Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
 <53d5eeb3-5a13-3663-57a1-e927c4c369b8@linux.intel.com>
 <937d872d-cbc1-3671-9c3d-ddceb9cb270b@amd.com>
 <ZLkxiZv3lWfazwVH@rric.localdomain>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <ZLkxiZv3lWfazwVH@rric.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: ed685d09-16e6-4353-33e5-08db894f81f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQTBYLNZ3j2cMoTCwTyOyxG3sBQ0hum0zqvSzHfd1nAcQvfJLVAFdR8Hb2Xq3Ezxu8Um1lSdUDPWIVGDYwulnfz2yIJglJOM1xQL2gJb2Mg3sRolYZI66ijL/PjxV/vhiMj0mCPgPh2BEb0oM93LvjA/YPMLUVE1ICvzSvabL6VgWgHldiHrz7GrxhpckOdoTv9UxpNCXCCFH7xHdQx37Q+DIB+NFIFqlwhkgJ9RNFyHOVSHLzqIZ/Rd+SUxGrzFMNGQCQKKL+2x/wGj1Ky+MIAs2/WxDbK1hNLfX+3wLVq2zj8CDhyUZBv4nxCPv4Ie2m0IxpnJJwNYZst4OaO1nTZdty1iigDifbgY4czwDdl4eFR9o/41L8oNGix3jkNOHQeBuWMH15LdLU2YCQd4GJfw6KfhbpoGP8AftoUTIZ9yoHjbnVzqDdyPFIMJ5WtiViXvfuA/OKo1aQgaoQUbC21RvNV8k0ERFfn3XQv8qQ5PIOyeH4RZ7PzIb3rgYz/OqoBD9KuIxBXDT6qAU/uLytgC/Rk46KqQgF+l/YkkNcL9hSxn5JiX+8nC4CSrVZT3nIpIg09oX8DRlhwbE6Pyryfi4lpFZCxnfEbH/jgNIc44EEA1fWXMtwAftzz6F1lMe1rJTGVnuwzMEvN9AIcK2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(316002)(36756003)(2616005)(53546011)(6506007)(6486002)(26005)(6666004)(31696002)(86362001)(54906003)(37006003)(6512007)(478600001)(6636002)(4326008)(66476007)(66946007)(2906002)(38100700002)(186003)(7416002)(31686004)(8936002)(6862004)(8676002)(83380400001)(66556008)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1ZiUWNyRytGNjVXcnVHK2NSSkoxQkJVYjdWazZpalRFeStiQVFQUEQ1ZWRw?=
 =?utf-8?B?K0tBS3JiNHRXSytnZWQySEEzN1VpTGFNa0tFdFFXTnhWR0o5WXNjWmRnUHdK?=
 =?utf-8?B?MzRha2VlakFsazFadWVSTGVUOHEvbmp2SjhUZnJpZFhMd2N4SUhGZi96ZDMy?=
 =?utf-8?B?U1J6ODZ5emFBQUF0TzN0L2Z5dUxsUTZ5WmF4TEw1eGYrdmZ5YVY3aUlOQmRk?=
 =?utf-8?B?c01LaXRQdWpvNkR2aDhKNTlnbHJQYWpGdEFHNW95cHA5VlpsT2JJV2JzNkY0?=
 =?utf-8?B?THRlNmtJejJIYmtCR28vV1p4a2Z3Y0VMeW80RlRBam5EdlBSTlY2eFhlQUNZ?=
 =?utf-8?B?K2laVDJqUFhLT1dmUWNpTi9QWWNlMmtOZG9ScGd5ckVxcldLODIrS3NaNVR0?=
 =?utf-8?B?NVc3WHFLSnFyK1NMdk9hQmZtKzcwUDl4VXhGNXlnbE54TS8rUWdkbUo2U3g5?=
 =?utf-8?B?dzVRRnBXRitmcStiUzhXOC9Wd0Q0MFh0cmFRTStONkVqN1hwc053RnV1cE11?=
 =?utf-8?B?WHZhYzJhMTBuTFVWazNobXI1Q2drYno2VlNIa05LS0duVEVINUUwQUVsN2RR?=
 =?utf-8?B?SGgxOEdyV1VjMW9nSVVYM3AzQnhMd0RJalRhVThlNUszSDlaSGM0TkFnWjU2?=
 =?utf-8?B?WUYrUlVCMXJCcWhXQ051c2tYcHV1Wmd6c3BBYUtYNG1mSGpOd2lpa3EySmtv?=
 =?utf-8?B?M0hoSWI2SkloZWRvdDBjYzljamRneDJBNVNsem1iOGpOSkVRK3lVYU82SElk?=
 =?utf-8?B?UVRKdkFuaFFwYlFDSnBXd3dycHNtTXVTYnRIQ29iVjMzOXM3NGFTdENqazRF?=
 =?utf-8?B?UnlKK2VMQjVWdmN2U2RZWDA1TVJYWDJTaFV1c0xwdmI1NklNTlBDVWRiUWtP?=
 =?utf-8?B?OEZPN0duWDFZQTNCalNGMEZtKzdkTHJpMVNPbVAreUtySXR5c1VYSEhLMklZ?=
 =?utf-8?B?RzZpNEM3ejA3WmsxeXBtb284Z015NTJJQ1NKeGNRK1VSTktZMkxabFZLVFZY?=
 =?utf-8?B?VXlWN0dyeGM5RTB2YTNscXRnNm5rTWJpTThxWW5oWmRLYWFGZkV6dGROYWhI?=
 =?utf-8?B?TTNhYWVCZHZDNGQ1WjJFeVNPcXB0OTV1VG5jaW5NKzFLYjdCeWVSWkV4T0ZN?=
 =?utf-8?B?VitWejVzNHJndk5uSXQ2ak8wMk1GS1pRVHMzamJtQmFFRlBadHRMMy85Znpv?=
 =?utf-8?B?a3JoNWR0dUd4TnpJNEJIT2Jkdy9hMUgyTjF4aEdCRUxTZ1BPS3pMTFhvamxs?=
 =?utf-8?B?WFd2WUZhL3lOU0tOTmtFSHV0TnpkSWpheit6b2RtS1BTT2I5MWpjaDYxT1Nr?=
 =?utf-8?B?bVNCeW1Yc3o0TVV2dWkrVS9kUHJuT1picml1ZnczS1hIdlR5cTZINUN4M1dE?=
 =?utf-8?B?RDlBN21yOWwvVFhtZFdxYkg3WFpLRE9ZcG16WlU1RGk2dCtkeEFqMHFweE5N?=
 =?utf-8?B?d2oyVXI3VEp3L2sweU9FWitDM0wzQUJNRHNDQmVmaUpZYURqT01kdFFaKzZk?=
 =?utf-8?B?K1FheHloeEVNVi9IL3BhdEVHVFRrR3NURVYzOVR2RXFHNUhsclk1Q3YycCtM?=
 =?utf-8?B?emNSMEJhY2d1YnZuNGgzSlpJbm13TThRaTgwM1VqSUJqUmFXYlBnRDkxdldv?=
 =?utf-8?B?WDhBdVJBZTdxV0dJdUdZNUFDdTVyOHF4T3dqN0ZHenhyMXlVdVlFbkVxcXdn?=
 =?utf-8?B?dFI5dEp0cS9ibncrdmxNV1pCNXFrVkd3T0ZnaGc4dGJaZ0EzZVhRWXRpVDVV?=
 =?utf-8?B?RHh2d293N0kyQjRSSU5iOFJSOGs2djZheW4reE9nVW85WVRMcUlMK3cwL2x1?=
 =?utf-8?B?Y3BVOHBDQWNOK0NHNEl3ZWVESVNjNDBLOVFoL0JmKzVndjRYZVZDUDVaeEh3?=
 =?utf-8?B?Uy9OMkpYTkxET21OR0x2cTI0ZjRvUE5FU0NnZTV3ZlQwcnpEZ1NyN2RnRlNV?=
 =?utf-8?B?eXNKSlBhRCttamRkUGs2d2hoTDg2Tmd6MkZuM1h6dERwUmdXZkczWUVLNDQ2?=
 =?utf-8?B?ellkMWlRV2FQM25NVjFGRHdNR2JJNmxRdDRMYmJSVGpDWWQ5b0dXalFjeHI3?=
 =?utf-8?B?YUZDQ2Z4MlBUNmhQM2ZIR0dxalhDZVc2bENqWlphTmZFU0U2WGsrdnRoY2p0?=
 =?utf-8?Q?15hH3tFgnLgTcvlwxb5KMlu8c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed685d09-16e6-4353-33e5-08db894f81f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:31:18.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWTArcW/MhOgdBbHk3WFtCt715DguCA0QUejzZJe8z48uURFvuUjhK6o5L1IpSYb0q4pSpcP9frLECdqhPh7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/20/2023 6:07 AM, Robert Richter wrote:
> Smita,
> 
> On 19.07.23 15:30:25, Smita Koralahalli wrote:
>> On 7/19/2023 1:39 PM, Sathyanarayanan Kuppuswamy wrote:
>>>
>>>
>>> On 7/19/23 12:23 PM, Smita Koralahalli wrote:
>>>> According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
>>>> of AER should also own CXL Protocol Error Management as there is no
>>>> explicit control of CXL Protocol error. And the CXL RAS Cap registers
>>>> reported on Protocol errors should check for AER _OSC rather than CXL
>>>> Memory Error Reporting Control _OSC.
>>>>
>>>> The CXL Memory Error Reporting Control _OSC specifically highlights
>>>> handling Memory Error Logging and Signaling Enhancements. These kinds of
>>>> errors are reported through a device's mailbox and can be managed
>>>> independently from CXL Protocol Errors.
>>>
>>> Does it fix any issue? If yes, please include that in the commit log.
>>
>> Yes, this fix actually makes Protocol Error handling independent of
>> Component/Memory Error handling.
>>
>> We observed that OS was not able to handle the protocol errors ("i.e unable
>> to reference to the cxl device node") with native AER support. The reason
>> being Memory/Component Error handling was under FW control.
>>
>> Since the RAS registers are tied to protocol errors, I think there is no
>> reason that memory error reporting being in fw control or os control should
>> be a roadblock in handling RAS registers or accessing the cxl device node by
>> OS.
>>
>>>
>>> Since you are removing some change, maybe it needs Fixes: tag?
>>
>> Missed this. Thanks!
>>
>> Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
> 
> the fix must be isolated to this patch (for automated backports) and
> you need to remove the dependency to the first patch then. So swap
> them and ... see below.
> 
>>
>> Will include in v2.
>>
>> Thanks,
>> Smita
>>
>>>>
>>>> [1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.
>>>>
>>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>>> ---
>>>>    drivers/cxl/pci.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>>> index 1cb1494c28fe..44a21ab7add5 100644
>>>> --- a/drivers/cxl/pci.c
>>>> +++ b/drivers/cxl/pci.c
>>>> @@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>>    static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>>    {
>>>> -	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>>>>    	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>>    	void __iomem *addr;
>>>>    	u32 orig_val, val, mask;
>>>> @@ -541,9 +540,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>>    		return 0;
>>>>    	}
>>>> -	/* BIOS has CXL error control */
>>>> -	if (!host_bridge->native_cxl_error)
> 
> For the fix, you could replace that with:
> 
> 	if (!host_bridge->native_aer) ...

Yeah I tried something like:
+	if (!pdev->aer_cap &&
+	    !(pcie_ports_native || host_bridge->native_aer))
+		return 0;

But then pcie_ports_native needed to be exported as well. So better just 
keep the check to !host_bridge->native_aer and return zero in first 
patch, EXPORT to second and replacing host_bridge->native_aer with 
pcie_aer_is_native() in third?

Thanks,
Smita

> 
>>>> -		return -ENXIO;
>>>> +	/* BIOS has PCIe AER error control */
>>>> +	if (!pcie_aer_is_native(pdev))
>>>> +		return 0;
> 
> ... and replace it with this function here in the patch where
> pcie_aer_is_native() is exported (or in a 3rd patch).
> 
> -Robert
> 
>>>>    	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
>>>>    	if (rc)
>>>
>>

