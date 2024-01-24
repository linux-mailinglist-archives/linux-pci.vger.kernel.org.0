Return-Path: <linux-pci+bounces-2523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7732483AB99
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 15:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052C6B2A18F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311207CF13;
	Wed, 24 Jan 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qei2i7To"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B867C0BC
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106081; cv=fail; b=T4MqPqp5bF7xh3fdje3lCPyhmgG/VkFyEcKQuBDVPtCU8od43uil8HMJl+Cpg3eH0rUx2Oxtlrf546rH4gyln875g9tiE3IMI622lulLlOJuQtBykAdOxHrWOqmxHohWBZd4kmXWWr1dC90NrcnCjAw1oTOLs8eovGwAl7/DS0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106081; c=relaxed/simple;
	bh=YhV2H0u3RUNvxbbEbC5L+W1k0Rb9pTTS+VisTBufUNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/TNFGxk19onlL/54nRNGbTa+AWXB2WtYCnhnAb2om/eB9NnGe15cwHuUcsHge1cBA6ENbeUp9s1/Weo2U1fZKN/XU9teqqE6pi0EykX/iAmL7gRJOb1EETuQMhF3ItI1GHg5M1fHYDC87AmFPdTiuVA9iC2AMhT6EiLSjRbpRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qei2i7To; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHloSmYGa2AiLXErGJmUcI4JprLFxf2755HJ6v6J0xtesi2ZItHjNAa4MTaEC+Bc/+eADinsqenMZdCnW/d96hwFqUzPJBxkT/jO7whFSuuX7ofkJhHiozLM76huB35vMqgdUA8pKeDLhYALNPAENev/ng04n5Sp6LeNCOEzTF2S0YOWWgqK09tRgqrhBjj+AdFOJQqmKjVRvg85JnVrqMMBashjv9P8n4ic+3pEbhzXbJqC3el999Hln0IIM00Wd3wYTnWqI7nSOp2uq7H3ALNRuymPZhuSKq/4/fSk2+k5bVRtjy7hU6ppg+CAxPxmh0LrNnsbd2OQQInxWVsm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dNhdTbPi7W3aeyf0J2RSdC5jklUdf+VnyG0zujFhpY=;
 b=QsaCeJ21mWLUMNGrOUXodVHVPRp/7f48l+ccdkBdMCSoqBcw3EEBBB6c88FE39kpRdJrQC+e3q217TAeyE7vX2aOK1VJxkRj933GG6K7n9nd3RATaSy/0gcqsIo0qsqc5z+yGPUCY4ANIyMgoe3u71MTGS78gMCu11MNurP+/sr1f5AKW5msshtniAosMWLI9xp1fJKoWhpHiQuxF5sZjNP5PvTxlvyQVTPP63Np8NdcnCs4jaTHVcG6FePggnGpMLKVX+L7rja3e7hPDlVVAG5uM/TzYa/3xDqKgkNlgyrgUCHfaFD5ugbyWAgEH0U4iSdAExVx82pmqpMWj+dBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dNhdTbPi7W3aeyf0J2RSdC5jklUdf+VnyG0zujFhpY=;
 b=qei2i7Tol07ZhRzqqSOXcM2dwSb7b7cHevJ7mt9KXghSz05mInhwMGcl5+xSFO4l5t5TJtbl7SyZNNnPQkRRX1iTLL7RDiAqbOHMwd7yrvSEGVvH9S907JhWn7CkpDOjeBM04TFh8prdqtaeGYHHVECBewOCuvfM0Itn3ZoW9EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.39; Wed, 24 Jan
 2024 14:21:15 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:21:15 +0000
Message-ID: <b99aa905-5a77-0599-93fa-2d7085760c90@amd.com>
Date: Wed, 24 Jan 2024 19:51:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
 mika.westerberg@linux.intel.com, sanath.s@amd.com
References: <20240123185548.1040096-1-alex.williamson@redhat.com>
 <CAJZ5v0gcjxmBnFy=qrUfPCwJyvzS_gy139TqhoF=gf_U_E2jPA@mail.gmail.com>
 <20240123125052.133a42bc.alex.williamson@redhat.com>
 <CAJZ5v0hLaka9od=_DB8L5nVJMPdu-9WKDgt5ro3jzE5b7MY-rQ@mail.gmail.com>
 <20240123133917.765743ed.alex.williamson@redhat.com>
 <CAJZ5v0jUHC3=Ga-5Sb41LK=BzJ5GitmrHUCOTCTZP7rtZWNULQ@mail.gmail.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <CAJZ5v0jUHC3=Ga-5Sb41LK=BzJ5GitmrHUCOTCTZP7rtZWNULQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8abfea-83d9-4247-6e6c-08dc1ce7b91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KzR+W1DG6m8BjwbD1uv/9Z/KR58yOGe0iZAfrnI4INjb/dm3NS+QR1nVRa2cHLyqqvm/kG2BWYoIKJVszjg+8SB9XOpk9uMTVWDNholDYRHjg0uLgaDbAyfKVXC/9HbvRnD1At2o880EZZbsKgecUbwaWPa+/BPP4vb8epYDflWn7qBGdZM9EjQkyyE03tAtOm/rHM2LJ9CnRBbDiOFjivk76H8ILdLag3BHgADdWvf0rAkdEL95S2CXwJ/YtBA5zi4FYPRvFNFtWhOOuDwVTdTD92Z2/8rYicdU+ACs/aAuviebn+51M4Mk0aDu3qcb9mk4uxwffDdoAxPyqzqAjcVMMCtCo3CkOdnkWDy0YAsxNWYN00hQMNuyD0iEJPoUdTkZh1BjY6kayYSnofYi9EjsJo8rQk2wWNxpvlLQPg82SNRnCw2I9zT0pPStc35o2KHUtqzf9KkJCp1cgoiFeUTrL2BxGC16D17Ss+LmX1hSSFL81TLEyqkFBw1EDsx33XTKCnNnVKPvyVF84D2PQkpIGu3b+6McFxXg+/3eLl1jdPaKRtnOI6ja8UKm3bl9huqwhm2ESxJa+PhbFBef7M3YCnIgfPipRTSTNLoKtepYwuAvSRQvjGZ9APARyBsRLzbZhihq4NxfRRAlPTG45A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(966005)(36756003)(41300700001)(478600001)(6486002)(6666004)(31686004)(6506007)(53546011)(6512007)(66946007)(66556008)(66476007)(2616005)(110136005)(316002)(8676002)(4326008)(26005)(83380400001)(8936002)(5660300002)(2906002)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFNrNnBaOEVNSEk4RVlDNVdMQU03N1dzQ0VyRGZnSVpwQWozZHg2ZHVFbDM2?=
 =?utf-8?B?bzIzZ1NpNlpCNzdpcjlQY0poVGY5YjRvZ1YyYXAwREl3TkhBTG5rZzdmK2Zq?=
 =?utf-8?B?WGo3c0hRRUN1NU9wcWE2WDk0WXlLWGxkQlY4UE9BSTVZZ2FQZzBROTh5VHQ2?=
 =?utf-8?B?QjdsTWFJOG9SWGI0elJLRkcra1RJSnB4Mkt5RW5IQTZiTXhQd0tZYm13enJR?=
 =?utf-8?B?REhkYUJ6bHB1YlpDc3pCdGdyOEFVV21rWkdTR2ZVaklaWklPSGdzaXJzSWpi?=
 =?utf-8?B?UHd2V3RnYWlvaEd4b1NlMmpYaWt0ckkwOXd0SVQ0c2ljamZWY1NneU52NXNT?=
 =?utf-8?B?VzN0cEprRjF6ay92cFZhaEJ1QW5aQzF0QU1PU3VTcEdSd1NTaDdwUG5yREtW?=
 =?utf-8?B?TVI0VDJIMnhmR2t1cG1GdWFzZDFtSGMrekhSbWZvQktDd3lnZXM1Z09JWTBN?=
 =?utf-8?B?YkZHT1RrN3E5b3RocWFCcS9LaGhOTjhQWW9wMVpJYzUvTzFYZ3R2eXFTQmR2?=
 =?utf-8?B?angrTm5wMjgrVWN5aFpXWG5xVzNSbmRaVXhTeVhMYjc3b1FVdmJJNFBPMDdi?=
 =?utf-8?B?dWFyNmxheHR4ZVdqU0poQitkRGlteHVydTRUNVdwU1dMRmNEdG1kSGFsMnJM?=
 =?utf-8?B?TEwrYm1tSlBtNDRuQzVuTzB4T0tPTG03Zk9VdDBMR2VwSjRsNTVDZElHZGN3?=
 =?utf-8?B?QlVMMldMelpZTDhWcTgxWDNINFpSRXNXMzNqeTVHZklhQThqTWQyMUhlVG5z?=
 =?utf-8?B?RmRxb2RhWXFMWGhlV1RZcXVUM3hvaGxXUFlUMlZSZVF3OWZ6Z3JCNkpyRFhs?=
 =?utf-8?B?NFRHRThaSHQxZk5JVHRQNnkwL2hWTS81eGJ3SHN5QXgvTUdkZmFYamx3cndY?=
 =?utf-8?B?VHhWZ1N5SVZrcnhWZEpCcU00OGZKMnJHeFlqTXo3bXdnL0xWb05CQ1FCeTZ2?=
 =?utf-8?B?T1o5a3hFVnVKUEZNVGUwaEpZRkZmMGwzcE4zN1NldnEvdVoxVElIL0tKb0xk?=
 =?utf-8?B?bzNuZDNKTmlOMVlTRVM0aWkrUkhNcDRKZFN6Wm1CeXFpd2FlNWlzRWRZTWZB?=
 =?utf-8?B?ZTRDTlZZRW9oUHA2eS9IQzJ5dVB0UFVSTytCUGFieTlIZUdVaEJyZi92Tk9J?=
 =?utf-8?B?SnJXSSs1TVg0bkorcnEzc0liQWpDZWhwd1JoaFdJTWFKdWxZL2VRUnFuVHpo?=
 =?utf-8?B?Z3lKRDA2VjZMMGVBMm1KaiszcFdRYThWVW41U0Q1NnNOU3dJWkI4MVhPUENk?=
 =?utf-8?B?OVJrZGhvTFpCSHg2ZXlSVFBITUd5OXljTVp5UG1pSE5LNjRRdCsyN3k0N3VC?=
 =?utf-8?B?VDFtNzBaVzRUblpjOTF6VkNGbVRHbVNxQ3g2dHo1M2E4WGtLck4rV2RtWnhI?=
 =?utf-8?B?V1VUa0NDeGNnUWwrR0prbjNLYUFmbXdEekplaDBBYkEzaW1UUEFpRjlmeXk0?=
 =?utf-8?B?UU1Ba2JtNHczRlFUc0pFdWYyMG9tczVmL3pBYlRSbEt1U2FGZXo1UTlRRG9o?=
 =?utf-8?B?eUNoR3ZQSjd0NXpOM2FZbzllSTQ5dm1xdTBqbElwbWkvM3NTZUowRFZXaUgw?=
 =?utf-8?B?MlgwQXdFc1BaY2oxM0tKNC9OcnVvNEFUL0JIeWFVaGw5Q1gwNlg1ZFdqVVRt?=
 =?utf-8?B?MkVtY0Y3SGIwa1JrY2hpTXdhUVI5VzBHbXRLNi9kSG9DT2o4cE9CRURWZVAw?=
 =?utf-8?B?WmRqOU44ZXFjWDhLTDhYOUFlL1liOVFaeVl6NG5ySnlVZ2tsd2NHcXQvazV6?=
 =?utf-8?B?eks4K2NiMVFMN0RDemIzVFh4WHhNOERFSUJFSWNWVmxGR3M2T1dobFZMWHJX?=
 =?utf-8?B?YXFZNTdkUUhjOGFjYm5ZZC8xQ2JyeVpEbzNncTRmTVhWejhDbHhCZFlRTldV?=
 =?utf-8?B?ZUhGYnRzck9UVVhoQi9KSXY0bVloT1lRQndibW1ZNFA0OUdzdkUxKzg0ei9a?=
 =?utf-8?B?ZmE5cXd4Q1JwVk92N2doTFdDZlNiTlBON084Zmp1OStLRW9TNVZFdnNMcHBW?=
 =?utf-8?B?alRzZ2ZCWGpDSWZVSkxDUVBkOVV5NUVWZTF6K2hVNy96eVVjMU9NZFhtQkFG?=
 =?utf-8?B?M0FZMkIyalYyRTVrQXdaRzRhSytiM3lQSVljbzdhNTQ5RkJYbjR4dHBsZ3R0?=
 =?utf-8?Q?tgkT6vaM7fZVIQW3qRRVk6JHI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8abfea-83d9-4247-6e6c-08dc1ce7b91f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:21:15.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R64U8JdiXFaPRjh+WSSRUcZGvOqWL4F9dx+ffQEmTMeotbbZp/YlIB9NtpvOC/8D7lALLBZHpwO23aqb8+Tv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033


On 1/24/2024 4:03 AM, Rafael J. Wysocki wrote:
> On Tue, Jan 23, 2024 at 9:39 PM Alex Williamson
> <alex.williamson@redhat.com> wrote:
>> On Tue, 23 Jan 2024 20:59:50 +0100
>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>
>>> On Tue, Jan 23, 2024 at 8:51 PM Alex Williamson
>>> <alex.williamson@redhat.com> wrote:
>>>> On Tue, 23 Jan 2024 20:40:32 +0100
>>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>>>
>>>>> On Tue, Jan 23, 2024 at 7:56 PM Alex Williamson
>>>>> <alex.williamson@redhat.com> wrote:
>>>>>> The commit noted in fixes added a bogus requirement that runtime PM
>>>>>> managed devices need to be in the RPM_ACTIVE state for PME polling.
>>>>>> In fact, only devices in low power states should be polled.
>>>>>>
>>>>>> However there's still a requirement that the device config space must
>>>>>> be accessible, which has implications for both the current state of
>>>>>> the polled device and the parent bridge, when present.  It's not
>>>>>> sufficient to assume the bridge remains in D0 and cases have been
>>>>>> observed where the bridge passes the D0 test, but the PM state
>>>>>> indicates RPM_SUSPENDING and config space of the polled device becomes
>>>>>> inaccessible during pci_pme_wakeup().
>>>>>>
>>>>>> Therefore, since the bridge is already effectively required to be in
>>>>>> the RPM_ACTIVE state, formalize this in the code and elevate the PM
>>>>>> usage count to maintain the state while polling the subordinate
>>>>>> device.
>>>>>>
>>>>>> Cc: Lukas Wunner <lukas@wunner.de>
>>>>>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>>>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>>>>>> Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
>>>>>> Reported-by: Sanath S <sanath.s@amd.com>

Gave a try on couple of thunderbolt docks, issue is resolved with this 
patch.

Tested-by: Sanath S <sanath.s@amd.com>

>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
>>>>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>>>>> ---
>>>>>>   drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
>>>>>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>> index bdbf8a94b4d0..764d7c977ef4 100644
>>>>>> --- a/drivers/pci/pci.c
>>>>>> +++ b/drivers/pci/pci.c
>>>>>> @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_struct *work)
>>>>>>                  if (pdev->pme_poll) {
>>>>>>                          struct pci_dev *bridge = pdev->bus->self;
>>>>>>                          struct device *dev = &pdev->dev;
>>>>>> -                       int pm_status;
>>>>>> +                       struct device *bdev = bridge ? &bridge->dev : NULL;
>>>>>> +                       int bref = 0;
>>>>>>
>>>>>>                          /*
>>>>>> -                        * If bridge is in low power state, the
>>>>>> -                        * configuration space of subordinate devices
>>>>>> -                        * may be not accessible
>>>>>> +                        * If we have a bridge, it should be in an active/D0
>>>>>> +                        * state or the configuration space of subordinate
>>>>>> +                        * devices may not be accessible or stable over the
>>>>>> +                        * course of the call.
>>>>>>                           */
>>>>>> -                       if (bridge && bridge->current_state != PCI_D0)
>>>>>> -                               continue;
>>>>>> +                       if (bdev) {
>>>>>> +                               bref = pm_runtime_get_if_active(bdev, true);
>>>>>> +                               if (!bref)
>>>>> I would check bref <= 0 here.
>>>>>
>>>>>> +                                       continue;
>>>>>> +
>>>>>> +                               if (bridge->current_state != PCI_D0)
>>>>> Isn't the power state guaranteed to be PCI_D0 at this point?  If it
>>>>> isn't, then why?
>>>> Both of these seem necessary to support !CONFIG_PM, where bref would be
>>>> -EINVAL and provides no indication of the current_state.  Is that
>>>> incorrect?  Thanks,
>>> Well, CONFIG_PCIE_PME depends on CONFIG_PM, so I'm not sure how
>>> dev->pme_poll can be set without it.
>> I only see that drivers/pci/pci.c:pci_pm_init() sets pme_poll true and
>> I'm not spotting a dependency on either PCIE_PME or PM to get there.  I
>> see a few places where pme.c, governed by PCIE_PME, can set pme_poll
>> false though.
> All of this is a bit moot when CONFIG_PM is unset, because PME polling
> was introduced as a workaround for problems with PME signaling which
> is only enabled when CONFIG_PM is set.  IOW, if CONFIG_PM is not set,
> there is no reason for PME polling.
>
>> It's also not clear to me that we should skip scanning a device if
>> pm_runtime_get_if_active() returns -EINVAL for the bridge due to
>> power.disable_depth.
> Let me recap things a bit.
>
> PME polling is run from a freezable workqueue, so it is not carried
> out during system-wide PM transitions, only in the working state
> proper.
>
> This means that when runtime PM is disabled for a bridge, there is no
> reason for its power state to change and all bridges start in D0.
>
> So you are right, the endpoint device below the bridge still needs to
> be scanned then, but I'm not sure about the current_state check.  In
> theory, it should not be necessary.
>
> But I agree that this is a minor point, so please feel free to add
>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
>
> to the patch.

