Return-Path: <linux-pci+bounces-2455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07B83866A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 05:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C550B248C1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 04:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D7C1FB4;
	Tue, 23 Jan 2024 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JjayIPy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D231FA5;
	Tue, 23 Jan 2024 04:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985320; cv=fail; b=XZFs1DgbV+cRKfhxYf/j+dEzkRVjfEYQv1iyW9xJIWrNSqzXFXt7W+VHi/fgIvt2mIOFsuf7mIgBmAvzLHG5WbxUJeoZUOuJELHKM7GD/Lzvs1EA+BuKdNwi/sD86Z9WFUgK/ErQYiHTJyA5xuuShiEN/RMXXjVtTB6WG2E1Q1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985320; c=relaxed/simple;
	bh=7H+LuHWLagDWUugj2rCbsNfTY61l8sJlm2dqGWqw0P4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XsSOMEY4tQqHuhDonlTxGTbTeTFdcyzSI63R0Z7XowAbYj4tioMLVkb7rqezqQKHtWIMps5DsuJr952Hqemwm+4X70PoN2ffCRs963ppEOXfSnkADQUP2iu8/AOqZTI6HtsiIm97+l1vlYB8+052tckv+zfwpJAW4/o8rvXN330=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JjayIPy+; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2eCZo747WxRD8sa1UJJCMlRgsVHzZGCETIWzux8CWEo84vhetHRzjgCIx4B4Sb0tkgt3jTQhYcZ2i0ooHYwInsSSfLJY/K3uHI0eKoMsNa0vgD8jHsrpt7xR5iFzgI572RDHEhF6NXsmomVBF1A+7afyq//cXlV3GvJcP6AoxuIhu3K5hbVIRRuTxqzelIi1/oYCGKnXs7CIYKKVbK342ln+2oq2q0XACAR+6dFWAlppNYmqKNfX1GVtKOcZCzekOhXvfH4Mg/cSBcE2Zk4mMmuYA/D4Onfwb2jzVPNgqtQz9FEpGc7wGIweJ5XTGF3w6oYzaehzAfglXzvnKSlYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVPH/1qYFoPWorobeB+/Vr7NZK51EN8Lhv2v5WKbPWg=;
 b=Ps7dnwjXvs8qWFC1WGEgK7XmexMrH0Pm5gFQTQAWlpweFvC7mnyYXp/2sn0AShhqDAdJv4u6M/rXwmo4kljQD7rntiFiMIRgS4fv2FomUKaqpqALwe8w3+Hs3EtHpTzNSeMqgQLRqt6RaRszH+tEzEHlEYW1tOIB8yATBNHnEsQnETNwLDw5V+YSE2BCEtlpYOdjdF+sd+nSTMu54EyId8fBZb/oJboxzwUt1yDczwcu4alBPfFlGhWB8S7D/SFJCllfcX5TD8itc+ZdfVdjUMU3d5TW93Uu1vOmr5uDH9zvsrMmnzdXrRtBSoZGiPqBumn6bgLw3IId2cvroqLumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVPH/1qYFoPWorobeB+/Vr7NZK51EN8Lhv2v5WKbPWg=;
 b=JjayIPy+YWPbhIF/ntaKrNO6RudAHPwq+5NX7XgIU1tgY15HsDWfQf9xZRzmlckRu87c0FobPj0rpBOnJSRUZyAO+dX54JwM+yeD17qXypADj1VrpRjrOEKdLRWWs/IMQF9aY5k/rb8OG2hjmr6Dz/R+V7oQI6xEXzADhoeWgyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 04:48:35 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7202.033; Tue, 23 Jan 2024
 04:48:35 +0000
Message-ID: <4ddd819a-76fc-5e4b-8956-ca0807247f0c@amd.com>
Date: Tue, 23 Jan 2024 10:18:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM race with PME polling
To: Alex Williamson <alex.williamson@redhat.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
 linux-kernel@vger.kernel.org, eric.auger@redhat.com,
 mika.westerberg@linux.intel.com, rafael.j.wysocki@intel.com, Sanath.S@amd.com
References: <20230803171233.3810944-1-alex.williamson@redhat.com>
 <20230803171233.3810944-3-alex.williamson@redhat.com>
 <20240118115049.3b5efef0.alex.williamson@redhat.com>
 <20240122221730.GA16831@wunner.de>
 <20240122155003.587225aa.alex.williamson@redhat.com>
 <20240122214622.32e8c5fa.alex.williamson@redhat.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20240122214622.32e8c5fa.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::8) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e55a4d1-09cc-4d99-bc3c-08dc1bce8e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tT0zgEr4tFssg+8e1x0SAG5+pytDQ4gGPMpgXefvv/ts2VqmVEwT0MfXtsJ1km/e3z5XijxLIbHmD4TEj/GheWqWdCRm1lgrnLzgnpOzcK2tMrcTKkBb7GQ2Uyz9+JN0OEA/121orGS3EmRkr159DTh1796zmCx6VuiquO2yvfaWR0SZX3u/jaerEpZZMcU8OcqW9TjLuCSC2ZUM4rFm9YJIinRWrGWNBJgSMOPLjxMiStIiGANAopcLMbeZkH1+jJnIUgiopVwaR7JiWb388Mm70cBmw8St1l7DuSlqKcsag/fX/ihEMW2DNUH62UMr2A2+cm9kiOcvvpJB1JaycuJ6DM0h7ZmPEw9nUskqYmLkaU/h1MfHeUIOsDVQpUCSw3pNcB3oS4MJCajjO1zsvVhzIN9caBmVztgpExFCSg1GPV3oI1CjRYLSyh32NearXWGDuk3O++csNUZfsMDuYYmYv2I3c5OWq2/uW89T8nhW/L6fMDZnqzseYzINyIM3OByKq75iaeUGo7Na033oc76Az09hPcbpwMFV2ldiHM7aPpAWrS4Zuq3Uck8p4q7oKSYD7i5NS+Evn4WMSH6ONUOz6q9Er49TgfaVAFDrlz+rLygupl9LWGqZErOU5aaz4LZjUQ6cAQbEl7tXRhnYvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(83380400001)(6512007)(26005)(5660300002)(38100700002)(6486002)(8936002)(4326008)(8676002)(66476007)(2906002)(478600001)(966005)(6506007)(53546011)(6666004)(66556008)(66946007)(110136005)(316002)(41300700001)(31696002)(36756003)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZLdHk2S1NnS0o4RExlUzhibmhyenk2aEE0QUNOb2tKbk05SzI4SjQ3cjkw?=
 =?utf-8?B?NGVFN1A0NWJjZzNqZlFlRW1SQVFYajFTVVhkZ2FZRk9JVlkyT2ZDb3RIVDQy?=
 =?utf-8?B?MzYrLzR2OVY2TXYyTSs4Sjk5bWUzT05QQ08xdXBuSnQ0ekZhY0ozU0dtZFRN?=
 =?utf-8?B?VzRyMlJSN3o1b3grODRVa0ZPZUFvN2R5S3FBSUNERy9ySDVieGxORXNOU281?=
 =?utf-8?B?blZBb1M5cHRmSzhVc09VUTRiNlY5emVwRnRCWkwwTWxYazF0cVg0dS9rQ1Zj?=
 =?utf-8?B?RzBrVzlncnNiR282SjF0d2dxUEFUMktKUEZHMzdTWjNtbUsxYStUK0hCUytv?=
 =?utf-8?B?T2k2dDZVdmpIZkNadGtJQTJFb2JvVFZ3eFA2dXlyRUt6WHAvWTJCcTdwSE9F?=
 =?utf-8?B?Z0QvODY5N1huTDRIWWh3V2lhRVlVelhsd0Y1a01EaWE3SUUxK0V6UUVuTTdX?=
 =?utf-8?B?SmdhVHJHaEdPVzVET2hWWnk4WjFheTJYcVp6N0xaOG1JMlJieWQvdFAwZHln?=
 =?utf-8?B?MXE5T2RKQnpJcFlmUnhUczJpelFzRnEyMjZLc01aVTBRS1U3Nkc2eGNINnVZ?=
 =?utf-8?B?czlwdVNQaFZ2bmQzNCt5WC9SWGZEMzR0cHlZa0hPNkVnWlFOd1pqaUdzUFZQ?=
 =?utf-8?B?WFFBOCtld2k0cjJESS81aVZkR3lLYTlGRG4reU1OZFJSeURieXNwcVNyS3Nt?=
 =?utf-8?B?K2RPSEY3K2NZd2tBL2I5VHl0blRWUWZDVWFqVm05N2JGUlc3bURtUzRzZ0NQ?=
 =?utf-8?B?dWtOckZtWTZFQnlGVDVnb3M4OVJ4bWVqWlJJVjYzbzg4TEs1Mkdsc2xjeCt0?=
 =?utf-8?B?dTIzS2RvUmFKelhaM2REZUtyS2ZLaTF3a1I0OXZSdlpwbXNpRTAxT1JPTWZK?=
 =?utf-8?B?M08xNmxNRGRVV3cxbDc2allWRkw3Z2J0ek95TW00M1U3WUh0eVUvTTdxK254?=
 =?utf-8?B?SWo2eGJvalZIdEozLzFBSzRJRWtkdHQrbGF5WXROUmdDUVhkeklFanF0NHVL?=
 =?utf-8?B?YWFLSm1VbkthQThXdVRWYkNWZHQ5K2Flb1NoamtqLzBML2xiN0xlQlA2TytF?=
 =?utf-8?B?Z1FBblRvSWIrUGtNajJGbHowdnpONXF1K1VXd1dLVEdVR01jbDFrbnBBTS8w?=
 =?utf-8?B?eGV1aWhhc2ZuOERIZkVDUFFwNkxjOEV1UFNpaWdYUzljZURqaWZNa1MrQm52?=
 =?utf-8?B?OHBWcTNiSzM0RHlOYW1WZ0hWK0IwaE5TRzk0QUFxdlpYUDhyREM1ZkR0d3A2?=
 =?utf-8?B?ekRYcE5iamlvSll0dDNRa1NybzhPU3VpZ2hENWtVd2o2RkF6YnFFK3owSmlK?=
 =?utf-8?B?WWI5V3V6NjdFN3hDMXhUdnlyeUwyd29XSnp0T1lnRkQvd1ZXUnlpVTdVRnJJ?=
 =?utf-8?B?UWM3a1U1R1VMZTBoUit3dzh5b0t4UXpBbmlhMERleGpBb2tVdDFDQUJkOCtp?=
 =?utf-8?B?cjhlYzJPRExZSUJlTmtMMEJVdmcyQUdvS2ROcCs5Y0hUZGpIdTlWMlZDOTd5?=
 =?utf-8?B?VmRqa1ZhZCtZSkpsNHlPUzZKT21yaFV0QTUrOXFUWm1tcFZLQTVtMHdveU4x?=
 =?utf-8?B?UWxsNUh0S3JqdkVaOFZMTDRISTZHMlk2cldoSEQwc0ZOM056eUFkWlY3amo5?=
 =?utf-8?B?eE1DSlRFdzZtN29pNjZVVnVMOTRvMHJrTUZMSG5RMCsrMEtQTjF6dWlLZ1FM?=
 =?utf-8?B?aGEyV2ZVTjJhbEI0ZjQ5ZXVpYmdsK1Bjc3BnelFMTitsWktoNklNaEdSM1FR?=
 =?utf-8?B?WnV2QXNsK0NkN2RscHRKMDAydXFvOGdralhBUys5WXNFUzFVS2Y2SmRBS2RH?=
 =?utf-8?B?NFM3VUpPRHNYNmozRlZPNnEwTzIzSEhqeTRPUTA4bGRBTGdoU0MwSGxTYmNH?=
 =?utf-8?B?RkdVcFpCakd5cGY3MTFWV0tDVE1NcVo2Sm1Cc3JtVW9ORzlRV2I4OGtNY2NF?=
 =?utf-8?B?UXI0a3VJNHV1MVdEbmt1bllITWpqWEM3OHFENDRxdUNWdTYvYjFKOWJybFJF?=
 =?utf-8?B?akdBSUJQQlZOQVlXazM3WmFSZXlaSU9oeEZnWFNjbHF1d0J4LzY3T1NiTkFV?=
 =?utf-8?B?YklEM28ybDRmV2lWRFVnTlpEUHgzZ203bVZOR0xxTm54eml1QkFacnFwU2Zr?=
 =?utf-8?Q?mkSc8qnH/hmTxaXRp9xrKzy2R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e55a4d1-09cc-4d99-bc3c-08dc1bce8e78
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:48:35.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi5vLuxeYcWgOCOhm7Zv5N3oje42eiFLeDxa1oPq0nY7Chj1rf0q1T6SaAdD7TBB0rktDbe97lx6fj42gEsWRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742


On 1/23/2024 10:16 AM, Alex Williamson wrote:
> On Mon, 22 Jan 2024 15:50:03 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>
>> On Mon, 22 Jan 2024 23:17:30 +0100
>> Lukas Wunner <lukas@wunner.de> wrote:
>>
>>> On Thu, Jan 18, 2024 at 11:50:49AM -0700, Alex Williamson wrote:
>>>> On Thu,  3 Aug 2023 11:12:33 -0600 Alex Williamson <alex.williamson@redhat.com wrote:
>>>>> Testing that a device is not currently in a low power state provides no
>>>>> guarantees that the device is not immenently transitioning to such a state.
>>>>> We need to increment the PM usage counter before accessing the device.
>>>>> Since we don't wish to wake the device for PME polling, do so only if the
>>>>> device is already active by using pm_runtime_get_if_active().
>>>>>
>>>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>>> ---
>>>>>   drivers/pci/pci.c | 23 ++++++++++++++++-------
>>>>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>>> Resurrecting this patch (currently commit d3fcd7360338) for discussion
>>>> as it's been identified as the source of a regression in:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218360
>>>>
>>>> Copying Mika, Lukas, and Rafael as it's related to:
>>>>
>>>> 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
>>>>
>>>> where we skip devices in D3cold when processing the PME list.
>>>>
>>>> I think the issue in the above bz is that the downstream TB3/USB4 port
>>>> is in D3 (presumably D3hot) and I therefore infer the device is in state
>>>> RPM_SUSPENDED.  This commit is attempting to make sure the device power
>>>> state is stable across the call such that it does not transition into
>>>> D3cold while we're accessing it.
>>>>
>>>> To do that I used pm_runtime_get_if_active(), but in retrospect this
>>>> requires the device to be in RPM_ACTIVE so we end up skipping anything
>>>> suspended or transitioning.
>>> How about dropping the calls to pm_runtime_get_if_active() and
>>> pm_runtime_put() and instead simply do:
>>>
>>> 			if (pm_runtime_suspended(&pdev->dev) &&
>>> 			    pdev->current_state != PCI_D3cold)
>>> 				pci_pme_wakeup(pdev, NULL);
>> Hi Lukas,
>>
>> Do we require that the polled device is in the RPM_SUSPENDED state?
>> Also pm_runtime_suspended() can also only be trusted while holding the
>> device power.lock, we need a usage count reference to maintain that
>> state.
>>
>> I'm also seeing cases where the bridge is power state D0, but PM state
>> RPM_SUSPENDING, so config space of the polled device becomes
>> inaccessible even while we're holding a reference once we allow polling
>> in RPM_SUSPENDED.
>>
>> I'm currently working with the below patch, which I believe addresses
>> all these issues, but I'd welcome review and testing. Thanks,
>>
>> Alex
>>
>> commit 0a063b8e91d0bc807db712c81c8b270864f99ecb
>> Author: Alex Williamson <alex.williamson@redhat.com>
>> Date:   Tue Jan 16 13:28:33 2024 -0700
>>
>>      PCI: Fix active state requirement in PME polling
>>      
>>      The commit noted in fixes added a bogus requirement that runtime PM
>>      managed devices need to be in the RPM_ACTIVE state for PME polling.
>>      In fact, there is no requirement of a specific runtime PM state, it
>>      is only required that the state is stable such that testing config
>>      space availability, ie. !D3cold, remains valid across the PME wakeup.
>>      
>>      To that effect, defer polling of runtime PM managed devices that are
>>      not in either the RPM_ACTIVE or RPM_SUSPENDED states.  Devices in
>>      transitional states remain on the pci_pme_list and will be re-queued.
>>      
>>      However in allowing polling of devices in the RPM_SUSPENDED state,
>>      the bridge state requires further refinement as it's possible to poll
>>      while the bridge is in D0, but the runtime PM state is RPM_SUSPENDING.
>>      An asynchronous completion of the bridge transition to a low power
>>      state can make config space of the subordinate device become
>>      unavailable.  A runtime PM reference to the bridge is therefore added
>>      with a supplementary requirement that the bridge is in the RPM_ACTIVE
>>      state.
>>      
>>      Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
>>      Reported-by: Sanath S <sanath.s@amd.com>
>>      Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
>>      Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index bdbf8a94b4d0..31dbf1834b07 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2433,29 +2433,45 @@ static void pci_pme_list_scan(struct work_struct *work)
>>   		if (pdev->pme_poll) {
>>   			struct pci_dev *bridge = pdev->bus->self;
>>   			struct device *dev = &pdev->dev;
>> -			int pm_status;
>> +			struct device *bdev = bridge ? &bridge->dev : NULL;
>>   
>>   			/*
>> -			 * If bridge is in low power state, the
>> -			 * configuration space of subordinate devices
>> -			 * may be not accessible
>> +			 * If we have a bridge, it should be in an active/D0
>> +			 * state or the configuration space of subordinate
>> +			 * devices may not be accessible.
>>   			 */
>> -			if (bridge && bridge->current_state != PCI_D0)
>> -				continue;
>> +			if (bdev) {
>> +				spin_lock_irq(&bdev->power.lock);
> With the code as shown here I have one system that seems to be getting
> contention when reading the vpd sysfs attribute when the endpoints
> (QL41000) are bound to vfio-pci and unused, resulting in the root port
> and endpoints being suspended.  A vpd read can take over a minute.
> Seems to be resolved changing the above spin_lock to a spin_trylock:
>
> 				if (!spin_trylock_irq(&bdev->power.lock))
> 					continue;
>
> The pm_runtime_barrier() as used in the vpd path can be prone to such
> issues, I saw similar in the fix I previously proposed in the bz.
>
> I'll continue to do more testing with this change and hopefully Sanath
> can verify this resolves the bug report.  Thanks,
>
> Alex
I'll verify it today and let you know the observations.
>> +				if (!pm_runtime_active(bdev) ||
>> +				    bridge->current_state != PCI_D0) {
>> +					spin_unlock_irq(&bdev->power.lock);
>> +					continue;
>> +				}
>> +				pm_runtime_get_noresume(bdev);
>> +				spin_unlock_irq(&bdev->power.lock);
>> +			}
>>   
>>   			/*
>> -			 * If the device is in a low power state it
>> -			 * should not be polled either.
>> +			 * The device itself may be either in active or
>> +			 * suspended state, but must not be in D3cold so
>> +			 * that configuration space is accessible.  The
>> +			 * transitional resuming and suspending states are
>> +			 * skipped to avoid D3cold races.
>>   			 */
>> -			pm_status = pm_runtime_get_if_active(dev, true);
>> -			if (!pm_status)
>> -				continue;
>> -
>> -			if (pdev->current_state != PCI_D3cold)
>> +			spin_lock_irq(&dev->power.lock);
>> +			if ((pm_runtime_active(dev) ||
>> +			     pm_runtime_suspended(dev)) &&
>> +			    pdev->current_state != PCI_D3cold) {
>> +				pm_runtime_get_noresume(dev);
>> +				spin_unlock_irq(&dev->power.lock);
>>   				pci_pme_wakeup(pdev, NULL);
>> -
>> -			if (pm_status > 0)
>>   				pm_runtime_put(dev);
>> +			} else {
>> +				spin_unlock_irq(&dev->power.lock);
>> +			}
>> +
>> +			if (bdev)
>> +				pm_runtime_put(bdev);
>>   		} else {
>>   			list_del(&pme_dev->list);
>>   			kfree(pme_dev);

