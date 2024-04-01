Return-Path: <linux-pci+bounces-5472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B5A8938C5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 10:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99503B20CA3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 08:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13086BA39;
	Mon,  1 Apr 2024 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TJs3oLxL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2099.outbound.protection.outlook.com [40.107.92.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272AC15A4;
	Mon,  1 Apr 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958402; cv=fail; b=N8kMt+blpDWC8lAi8vBL2hmvA5ejl2y3TiJowI7zV7FO9aNGpI9TXI144tV0Xn+bqZAAwaI4iy0VrqhcRTxIsGeTH+SohKPVr5u2nlIWEI2N6Axd5ilvroz4NEJ9A7ZpW4Y3iIext7kKebvUbpOzMVJUk/aNUKOoYHG4ToLohR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958402; c=relaxed/simple;
	bh=ABm5nJeRaGhExt1ThyKI3VqUjNF82qk9iP5Z0Ua13rQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tz7NNpp9zOKHBAvDG0Q1oxQ9l9lrngBOB5RR8dtRRSPhFtByD7vLm826ICY1HSAQ6QuT1C41AuCFui5xnLeY4tzwH6C49RJHHG1jzWiHuIppG+LZOLwl1OF5AeC3+5FzHpygzmhdzwRcULPbz70AQV8uvetkATA2eZZ1czQW9sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TJs3oLxL; arc=fail smtp.client-ip=40.107.92.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZwItGCr42Ukw/fKLLRqJmBAiaXk4kO7jxKvZMwRVA+4UK+vK/Cs/Zs1DhnnR7qsn4pRdwVgVi3zhLhVOpPK3a48J+PKJmqXkhNWvOTmzNeJ3RaBt24FsI1YIqlfFaPP5A80KHIL8FGxg07f5dz/PaVcuh+bFObe3DaIW3KRViTg+r49UVXQg57dunpGxwHG+5gtvptdZiZjokGbAxDCjBV1SOImiQFPdGWg8lmf5LgDDPxVkDolbgS6niob5Juabd1mJbnT33v2ijh2eK8O+Z1ITk99l00FOfcHtDTHOgPGipb3APaqAMC5QiFV5Cq3zbbdMyvD2eV02VSWFa367g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37JQt1m21pGTIdgQjEVYMF+XFoK9vtMPlMecpu96J5o=;
 b=jcmh39AJMMudHVCQP1wWzX+RmIapJOhNCN+YwDD44pCW2el5udLFdOmNs+WKoFwmZ2B+6y0J6GVlXwtG+Ty3YiU7pugwr13LTrPfRq1daaqhG++mCHfRPfcuc1bZutCnYEn88wa0ao2Xq5Cq8hwFmwz5bFoXvvuSsL8P3uYpCkqIpwpcxo6ExjoM5ZA+aLPZtt16XkEalEsdcR/WQRR98UJX+eOECucHyAZCoedRKsoCFiF7dCraKEIdd+vqXf2Ebdp++aDonz8XM57zpSsX+xbzZ6fGxPMKdn+eVry++sNcLjfk9fiHyycxSX5C4JYa8QKzSg4Bwuf/ZoewtgJdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37JQt1m21pGTIdgQjEVYMF+XFoK9vtMPlMecpu96J5o=;
 b=TJs3oLxLKrLNGvRbzJRTY0GovwF3qMkf/dx76mdbiAyRlg5JiwrAl9gPABQ1sNG6JiCCdgdpoRqCzAc42gW+TuDFokSTheY7UDVjq45tXAPSP4p6gUq4yzPrcMq8ldb9tDWgkxphT0vMmZoJ0B1L++O7UwDw5H20vmjkB1jIT8CqzaVui0mRx3JQGZPx/M5Ujts5wa+y7A95Y/OLggaYOjnqfknmOnwNGA8pbu761kPzrrz6XlEkUa6m8+F9tPpNBBvK2fXpMOlgSRNyy/b2DwtCwmF2hAg+RreAzJHHkxQJICopQqbKJfzxvE17hF8Viifxy8LuY/K33Z/mt6Ju/g==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 07:59:56 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d%7]) with mapi id 15.20.7409.039; Mon, 1 Apr 2024
 07:59:56 +0000
Message-ID: <0c948351-9715-4c5c-ad0c-3727cd2ba8a8@nvidia.com>
Date: Mon, 1 Apr 2024 13:29:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI: Clear errors logged in Secondary Status Register
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240122230026.GA290856@bhelgaas>
 <d93a3f29-b260-4910-aaf5-d734e6242223@nvidia.com>
Content-Language: en-US
In-Reply-To: <d93a3f29-b260-4910-aaf5-d734e6242223@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|BL1PR12MB5777:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BL0C2WyWlymT66IQtOmrBHl05Re0ABR8de0by4bJQn9pharq82+BcJIv28/JjzsANXnw/id4gp0tQaSF2n9godHrK6vuG1UfSZrxD7BlltsftVVHtUbG8Qmivh8oWZlNUT629JR6K8DjyaYHYR+kfSX8LXzLGns99mgLCYLDac/LwNL0+AJbLSM6Toifboj7CaDaPmOh34NAOGagJZ0DdrvJ9FvfGXV6OJAAuS5WH7W60QeQWKEGdsUa3B3M/XpF8yyBBi0/9RwxrY1atveqt15XlzEuGhxyTVDKPe6ex31/tHlkkR9Ltu4/i+KO6QrGolJHUsOFsLJX6F1FQUvgGq8NE74pGoFakzbnpWwJk79bbvRjFO7sVyC9GGE3055NFbHcS42wSzwiwscLqTDodforeVsw/pB3ghrNxUdarFKb4m7cIcJVLd/BUtAYqXGL7NIwKez+X4kYTMculyEsWbgHrHIN9F9YU/rhJK0piQtl+zxsxU/CmSHVTrRtph5t0z8w6VETM90hSGD1AhxKiApnhWXOUClVA5X3AzOVB6Rv1ugfwomJoYZiMYr0IvSa4PMeW058wkRYOMJwrpDcnTVFer3VKraRse0q60Gi27epmTcYblvmtc2s9PcaXGNsi+ifh2k+8VXnptPjDIbWH+Y1U2l8iV8iTKpri8EDjRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU5zalhSZG5MRStVZE5xaFRNQitmUjEyMkRuOE9uYmh3dFhIaWpFUno4RVUw?=
 =?utf-8?B?aExsMitybWF5ckE2QVV4YUpwcHFjektYZ3FFdGkwQnFreDdpNGM2MEFWa3ly?=
 =?utf-8?B?ckxFcHpDQnZhZFRMMnRjNjdoRk03SGlzOFFyeThmd0tZZkZXQXVXNjZVSCtv?=
 =?utf-8?B?SjhMaEYraUJoRjZDcGtXMWpVR0dqRGhNRW1lVklXak40TkhxZFJvc1JReDkx?=
 =?utf-8?B?OUx2VVF5a3gvUC8vdElkLzVLWmE0UUVXeWRiWCtFYW9hSnJkSFVVMFVZRlJY?=
 =?utf-8?B?ZTlZMHVJdnNmem1BeWdqZUIxcFZ3d0ZyNkVaVDBESXhoQzFxcDBjZkdqQkFY?=
 =?utf-8?B?M0ExVTAxNUk2YkFaVkVUelkxNFRDeVNjZ01rRnBnUE5BQkhUaVRZais1VFp4?=
 =?utf-8?B?VldJcWNiVEdCaWV4M1hqRGdNTGEzcmoyRVZPSDNtUkU3c2lGSitiRERnK2tE?=
 =?utf-8?B?UkhTaFZISC95dXlYUmRzbUU1ZnZwWXptY01RSFhBVTFrM1Zkb2lzdjVXQTJh?=
 =?utf-8?B?VTRoRDJPTnJDbjhBb2lWUTR1ZDdueDdVRFJURFR5MTRVTno2UjhaNkF6MHdn?=
 =?utf-8?B?cEpvTmowS01PeGFsMHE3MjBpTmRMYlpYVm1oZDF0dm5ONWJ0ejNwd1RHZjRv?=
 =?utf-8?B?V3M1ZjljZmZaTG9sNnpsc3NJOWlWUjRsdFM5T3BPaDlhZmltZkFjNEhTYnEw?=
 =?utf-8?B?UjJwcnc0TDUrSW1Id2hMTzRTNjIrMCtzMkVlZ2RhNThGUTBIdlppdG1jMFBX?=
 =?utf-8?B?bHhWakFtZkJCT0t2LytvUGhiOUo1Qld2UHduYzYxWTNLRkZtby83bUZ2WTRI?=
 =?utf-8?B?MG5JVUxNWm91LytZVThHODhTMnIvQXRRMVhIby9nNENKMG03eTBZRzVURWQy?=
 =?utf-8?B?ZFFQRmdvcXFoYzZGVmg5VlZQcUlPVkVKYlZmRVMzWU9vSXg1bGxhc3Q3Z2Uv?=
 =?utf-8?B?UlBQV0RETmhBUUkzWTZ4TEtzVEJvbUNYUmZ1VmtOQUFRNkdueGFnbFZnRXIv?=
 =?utf-8?B?YVRiMkNkMlhSZFk0U0dhYWcrbkEzUEoybHhQTWVxV0c1TnEzNkxDR09RQ3Vl?=
 =?utf-8?B?NXVzZTVlWTdMeFZ1ZEZJTXpETGpDR1cxeWdqWWtPcm1DKzdiZFFyeTh0czVH?=
 =?utf-8?B?eEE5eWZUdE1QV0p5M21LR2VBU2ZxWlpFdlBhYXNvdVBYYmRweDA0SSticWR5?=
 =?utf-8?B?emV1UW5iMnI2bFpXNEVQbGhkcW9vT2phWkV5STNiNG1jT0JkQ2tZVkFPbC9J?=
 =?utf-8?B?Y0dNUDhsbk5HQlhRWHJMU2ZwOTgxK1NoVkRoUjF4ZU1xUkMxR1hmVzdHejk4?=
 =?utf-8?B?OXd4YlBselozUlF2c2ZNdlVndW9qOFRZcWlZZ1hkVS9iZUp0ZTBvRzNoZE5K?=
 =?utf-8?B?d1NVZElxK01Zamg3ZWIyUERXdVk1WUhEYWNWTWxzOFNEdXVCZkhTS2dNNW44?=
 =?utf-8?B?ZUNZeWpyMkNFcUVISCs2dDMwQWRGOVVzTG14TXltKy9MTGtMMEpxVDdMR0Nt?=
 =?utf-8?B?S21tQ3lqc0EwbnVSY05KSDNrNDZBTGszbTRnQmUxdE0vdk8xRWZHMVNuZWNw?=
 =?utf-8?B?eUFvNEFSc25UQ3dTaERwTngzaXJiVlVsaTVnSTRBdGI4eFluQlViOVgwekVx?=
 =?utf-8?B?eFhFdXB2bkhEQ0YyL2k2Y25kZG5nYVNudVlReXlIVmc0bndYM0tPaTlaZDlY?=
 =?utf-8?B?c3hKbXU3aU4xZ1lwcmtweFZYdU5YL295ZDVaeEVWclhaMjlHWFk1dGFHVmhn?=
 =?utf-8?B?KzF5RnZQbEozbHZIVXQwS3gxWnYvUGVlMTR4Z1Y0NDdUb3lIRC9Xa1c3RjZM?=
 =?utf-8?B?WUx4UmVnU1lnSUc0Y3QwczN2Sy9sSGlzNEJzQ1lzVS9TM1o1V0JwQU9wdkht?=
 =?utf-8?B?YW5qc0hHQmVQZVB5VVl3WHlob1pRTGI5bjNjMDcrdWVaYnNpWlVPZ25ocjZK?=
 =?utf-8?B?Q3FpbXFSNUVEcjZnYUxKMTJkQ0s5ak0yV2FYVE9IV0FPazBiL2RDZVlBUnJx?=
 =?utf-8?B?MlFlSVVQNGRPK2VDRFM0YnpjVG9xTTNwRGtTOFo2UWZ2dlhRZFpoYnRDNVJ1?=
 =?utf-8?B?dEZtQ0JGY1REQWNvWFFnUGlUbk13bFJkMnBZWG5aSUQ4MGp5cUJ6MjhkcHVM?=
 =?utf-8?Q?u0o7OkpIjHI4zd/Pj4mlQpkqY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a96fde3-e5a1-4bfc-4e15-08dc5221b823
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 07:59:56.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMloaVxDBlQ4P3Y2Y31RN5yQlUPLyudOuqy1omP9mKPDgNtH/umqlZu5ms4fZ9my3g7MhDitIadmuBopmWynVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777

Hi Bjorn,
Just checking on this thread.
Is there anything else you want me to clarify on?

Thanks,
Vidya Sagar

On 14-03-2024 06:09, Vidya Sagar wrote:
>
>
> On 23-01-2024 04:30, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Jan 16, 2024 at 08:02:58PM +0530, Vidya Sagar wrote:
>>> The enumeration process leaves the 'Received Master Abort' bit set in
>>> the Secondary Status Register of the downstream port in the following
>>> scenarios.
>>>
>>> (1) The device connected to the downstream port has ARI capability
>>>      and that makes the kernel set the 'ARI Forwarding Enable' bit in
>>>      the Device Control 2 Register of the downstream port. This
>>>      effectively makes the downstream port forward the configuration
>>>      requests targeting the devices downstream of it, even though they
>>>      don't exist in reality. It causes the downstream devices return
>>>      completions with UR set in the status in turn causing 'Received
>>>      Master Abort' bit set.
>>>
>>>      In contrast, if the downstream device doesn't have ARI capability,
>>>      the 'ARI Forwarding Enable' bit in the downstream port is not set
>>>      and any configuration requests targeting the downstream devices
>>>      that don't exist are terminated (section 6.13 of PCI Express Base
>>>      6.0 spec) in the downstream port itself resulting in no change of
>>>      the 'Received Master Abort' bit.
>>>
>>> (2) A PCIe switch is connected to the downstream port and when the
>>>      enumeration flow tries to explore the presence of devices that
>>>      don't really exist downstream of the switch, the downstream
>>>      port receives the completions with UR set causing the 'Received
>>>      Master Abort' bit set.
>> Are these the only possible ways this error is logged?  I expected
>> them to be logged when we enumerate below a Root Port that has nothing
>> attached, for example.
> In this case, there won't be any TLP sent downstream. I talked about 
> this scenario in the
> second paragraph of point (1) above.
>> Does clearing them in pci_scan_bridge_extend() cover all ways this
>> error might be logged during enumeration?  I can't remember whether
>> all enumeration goes through this path.
> So far in my testing, clearing it in pci_scan_bridge_extend() covers 
> all the cases.
>
>>> Clear 'Received Master Abort' bit to keep the bridge device in a clean
>>> state post enumeration.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> V2:
>>> * Changed commit message based on Bjorn's feedback
>>>
>>>   drivers/pci/probe.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 795534589b98..640d2871b061 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -1470,6 +1470,9 @@ static int pci_scan_bridge_extend(struct 
>>> pci_bus *bus, struct pci_dev *dev,
>>>        }
>>>
>>>   out:
>>> +     /* Clear errors in the Secondary Status Register */
>>> +     pci_write_config_word(dev, PCI_SEC_STATUS, 0xffff);
>>> +
>>>        pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>>>
>>>        pm_runtime_put(&dev->dev);
>>> -- 
>>> 2.25.1
>>>
>


