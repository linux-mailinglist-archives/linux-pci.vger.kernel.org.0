Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD8743C319
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhJ0Gkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 02:40:42 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:21628
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230342AbhJ0Gkm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 02:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOkHQ/cemHv80L+cxVynE3QtRrXv1PM/yr5sKAhfY2PK7RJBmdUhYJZ4yY5F+hDe7SFE0JwjURaWxvEo1AJDoFeJd9RTsWssNnRwFdxEtPi5Phu/9EhtXx5jSrw6csACLb8FzT0L8ZKMI0hcdUEbvCMs0knvSyjYDTkhLdJ3sTxop7CsPh61xVQwDdd2vBXtjpPow+UKYDNWvjz4ajKnRekUkL5PUWF+f7NpITCdrk2Dfr/vNkbI3czTedmRKZgHEVEfAk98LhVJcCdgxaeuJg+e2cl1Pt1mzJKWez0d/Om4IHLGAUbGQ+Kf8KHyYey3lTSHzLzSUp/CLfQiGelJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtyMvV6sDEj4BQ1W4UD+APmVYgYp5YeoulDpCvmcpRA=;
 b=M5AskhppWd44LaSuYO4mP0Ow4uITzUtkittcjsKjEYNZu1Xiq1DWSjhI+/li1RIZjMjXY58N+gIJP4hiFHWSABSmtuYHErhu9nXsMEp3E3DWVDVtU3JEXKHMeQ7Yv19obMl5zPqN9+K23A2mPt48MVfcU4DvxKA+dwQRlUvEix2bmM1cD5ILswsiI5CENN9gV9YRnEKRrI76ItySxH4RNf+cuDlXnP68UrCErhIVIlFtgGllCzlG2vIpOy4pjEkCVHvbGNUlov0DeLkEh5My7X5v+8ru6vPlLh9zVvkf+HjhTN5w0bkgVmcpMCZ89GrNSD6M4jGrbbvh09JMRoD2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtyMvV6sDEj4BQ1W4UD+APmVYgYp5YeoulDpCvmcpRA=;
 b=jkkFiwh983jUYp1fMC5f1tnO9d7dPUNEwMzpkNXXEe0ePxqBJWQbzyYfKalpsJwakC8rdC52QyzfOLmiUfjuAWGXAVe8jXOnwkkI89Kgybo2m+uM1Vr+tdpmU6aXmctAIQ5q66hZpaDvdqrA72rbRWj9WyQ82Azh47HwOFDb8aM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4491.namprd12.prod.outlook.com
 (2603:10b6:303:5c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 06:38:15 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4628.020; Wed, 27 Oct
 2021 06:38:15 +0000
Subject: Re: [PATCH] Limit AMD Radeon rebar hack to a single revision
To:     Robin McCorkell <robin@mccorkell.me.uk>, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, Nirmoy Das <nirmoy.das@amd.com>
References: <20211026204639.21178-1-robin@mccorkell.me.uk>
 <20211026212835.GA167500@bhelgaas>
 <CAJJH32EoZUEoi48qAbfVK9CJDQfUUTOFYq53+wuN=E0RQXZh8A@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <61757e43-9cd8-5f04-d1c6-88940b1e8104@amd.com>
Date:   Wed, 27 Oct 2021 08:38:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAJJH32EoZUEoi48qAbfVK9CJDQfUUTOFYq53+wuN=E0RQXZh8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:20b:312::11) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by AS8PR04CA0036.eurprd04.prod.outlook.com (2603:10a6:20b:312::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend Transport; Wed, 27 Oct 2021 06:38:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c42d5988-331c-4684-613c-08d999145aa6
X-MS-TrafficTypeDiagnostic: MW3PR12MB4491:
X-Microsoft-Antispam-PRVS: <MW3PR12MB449198F202EB1CD6083DE7F583859@MW3PR12MB4491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRQ0jqnt18kgY5sf5n6DSqbict6fGPVi/6qP1kkRSox9hbG7mpngmBGj09fLSUcbDgIff34v7wCbt7Dc9+UxdfGlpfekqcb93VJeiaSwHobpdXoEziH6u+1stYuhwWwqZp4YWoxsW77rRFl9sHH478DWNXEVdZJ80rxC4zcH4YWkiSXFKtWlPgWPeXxBoWWm6J1UqNEam/1P9N8YcofjV7Retbcv/ONLW7Dz/BHFaOGoDHDLVY0sS2rOcnXC0X/07uBJY0A1MZGIoa5RKg+YsI/fqTN8dwbLno03roHwHmXQuDVSGI0wejQGIujpEZM5E/Tv/3QC3YO+J+7XhA2IQ+TRKiz4KE3TSh5xnwBvL/4J2RpRJ7m6BhsS+vrPwWuiDwMEMSwBcjiklMozzYSAQVRzjSWXM0DHI16yCJzSPLVyGSWy94Rwa1jZnGt8Vdbv8s/V+ruKTklv5B0oqsB8t0pNcpoEIKiNHaMvk3C2WxGy+QzAW8KH3bFHD+qGnwZoNPdk1CtPhCrbDRLtIOoYsGtMRv/4HsRTdPcFQzBZS8n4r4bQS2VdnZfnpLmz6UK7IrJCc3O9BO3G3ZMQS8jjy+ZJSvUnhhgWfs9nEwzLrD5BPN7YdrWN1bKjkGbNpWnUEFG/D90PSj4y6VUziQmlNxfw+7otqj/x2B+63FOdTtZeA30x+3E8nyIO4M8C5c6l5MXW/qn1AmnePH8bik4loc+9lLzaNcw/3dZKZE85SMgL/Kg/60QB/JXSUFvrrUXsfvLaQBx2lAcAO7cCrNJu5fr6ICBAo911F2kFM6iGVFoOs6J9EhEIXVG4TPrQpEci
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(4326008)(6486002)(86362001)(6666004)(956004)(83380400001)(45080400002)(26005)(36756003)(8936002)(2616005)(66476007)(2906002)(16576012)(8676002)(66556008)(966005)(31696002)(5660300002)(66946007)(316002)(508600001)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkxob016RktEVndNWFQ0QzhnRFpJNVBiUlFoNHA4T2NETVBKS3Q0ZkQyV1V3?=
 =?utf-8?B?cnVyTHlPVnI1MHg4QjQvVVFqK3FxNU1GTlZYQ2hsMnU4RWRWWHZFWmFwSDdI?=
 =?utf-8?B?SWhwRkxFZWV4eGxsZ1ZHUjZXTGFReExKWVZEVTA3aGZXRTVQVXpLMENoaFJR?=
 =?utf-8?B?TlhacWxZMWlRVEY5K0E0SzdqU1NSOGQvNGRjcHJwTFM0MkJwUG1TZ2NLeVdw?=
 =?utf-8?B?dk1oQyszd3BuR1A3bGJ6Wkh0bVcyMHBIaEhGS1p2Z3FDSDRLazhBeVJiUnZT?=
 =?utf-8?B?TVpHbktDcDNoRlBOM1doVVRFb09hcCs0Wk90cHhNVUlaY09mRURKUW5QMy9q?=
 =?utf-8?B?NnM4ZGJZd3Y5RzBTeFdJcDlrRWtyd05ubVRKVW9sMkpPOGpJdnZobUtla2Jp?=
 =?utf-8?B?ekRZZStwdmgyTWlpemNvRVlITlVOcmUzbXYxNndDb2FKR2V5emkrTUFUeW5m?=
 =?utf-8?B?TEtVVThlSXFsK2g5c1VLRWY5NVUxMkZiRHFhZHVaVnQrMVNCV0xLQkkwczgr?=
 =?utf-8?B?QnpoQ0FwY2pQTnp2T2crVzVSeVZpTHNPeWxnQnVXaGdnNWZEbGJMRFlVc1ZK?=
 =?utf-8?B?dzFIdU9MdGREUytEVFBKNkZHcEo0QWlVcmpaSUM0YXZrckc3eWhTQTJOeFoz?=
 =?utf-8?B?RVJmeEVnM0ZWQUl1ZDdIdStCSTZHUWIwUVRaMXFOZzA3b1RMbXFvK1RYUTFu?=
 =?utf-8?B?eHFPb2NQWEtkcDJwLzNia0ExdG50V2owaUIyc0xITjhBZGpRMm9xNUowWkxs?=
 =?utf-8?B?anNpTWlUUFFSQnhldE56dFZoalJpditLTVByM2lmaHpCOVNSb2U5eW1GQnNN?=
 =?utf-8?B?djhtYUp2Y0JLaVdZN0FqZm9yNm1UdW1ROFF4eGZXTU1zTDY3UHVsdVdNWExn?=
 =?utf-8?B?cTBqWVd2S1V2a2JmU3FPNjRqR3FyRzRIY1RKa2NWTEJMSURSM0R2TENkbHBh?=
 =?utf-8?B?UnJrdzB4cHFJMU40aHVqRkpSWmdyYXB5b0l0eFk3OGY1UnFWUUpwUy96RmhU?=
 =?utf-8?B?ZWNsSnNsc2YwV3JtTlVmWitMYmVhOWdORCtqdTVmSzRHZUNKN2tYRUhlTXQx?=
 =?utf-8?B?MkFTdHp2WXhtS0gyK0V4M3RDSi9qRWEyR1NJOFhnQnIxUXV1aDRsSWt1YUcz?=
 =?utf-8?B?YjlsdGJvWEU2NVlvTzBESDd0bmE4N1c5Unc1Ym55cmhVS21zdk10Wnh0cXc2?=
 =?utf-8?B?SXQ4M1pvVGl5dnhBOVBieG9HRDRVZXVOTHM3czA5c016ZGx0MER5ZWhwME4z?=
 =?utf-8?B?ZTN3VjFLOVdzRlorelh1b3dnaS8rYjVmS2hPVnJ4MHkzQ2d1Y2xiVHpnMWhP?=
 =?utf-8?B?TTJUZkpibHdYajFraEhZWWR4OVNHVUtBN01oamJlTHpUYS9WODVwMUUreEtF?=
 =?utf-8?B?UlBQUjVId2Z4QXRyOWszYklvMDY3Qm43TmFFaVFXcS9HWjRrc1VDTHozYUg2?=
 =?utf-8?B?emhqVkhKaGhoSlgveHBqRk9Vdm1LMXJhUFJNQ1A2OUx3Wkl2Q3R2QzdMMjcy?=
 =?utf-8?B?MUd1c2VRNFZ3UVJ1ZFpCc3QrcHBZY245OXdsU3dxUXlSNFNuVkJKcXEvMFVT?=
 =?utf-8?B?MThPbHBvL3B6Z2pxYXJKZm9mK0lRbkpBSDhtQi9xaEVEV2tDSjd0WjkvRkRR?=
 =?utf-8?B?WkR6UmNnNlBGZ1F4NjNtelN2aXJsOFpzOEhLOW9UYXdNbnlPYnh3WFd1Q0Z5?=
 =?utf-8?B?OFYySENxZkdlTjdJc2MvMjNXcVQ5N1RwSXhUNnY4V1I0SkNCSnB3YkE5RGN1?=
 =?utf-8?B?VHdOQjEwbHcwbFhCMTZWQWZxbFJxNTJKZDNuYm0reVRDelNnQWsvWnpqa1Bm?=
 =?utf-8?B?ZkZ1RXBLdmx0MmhaN3ArYkM2ZjFDbFJzQzlhVVJjYUZ4Q0pTaytkMzhZWUN0?=
 =?utf-8?B?YnVEV21ldXMyYXpTUXBKNW1Xa0N0bVBXVnExV3BnaUI2djRvaVhrU3VPdGow?=
 =?utf-8?B?emZ5Um5kZ0FXamFHRzZyTjRSOXdaLzZ0UnVDYzBtbDZWNk5aOWJmWHlNUU9C?=
 =?utf-8?B?U2MwbGNyZHJnb3pKdlM1QkE2OEw0aUVpRXV3N3pndElSVmdIZ0ZPeEJTcFk2?=
 =?utf-8?B?Mld6SUwzZEhhNmk1OFk0enh5OElYd2VQKzNRR1dtOExZNDczZzlicEJ3cmNu?=
 =?utf-8?Q?SOyM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d5988-331c-4684-613c-08d999145aa6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 06:38:15.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6l/pvY5TJA/o4+dTr0TzoisrBP1NO1kmjQqEQmt2hVDS5ojXIMotNbYdbs9W6G3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Robin and Bjorn,

Am 26.10.21 um 23:49 schrieb Robin McCorkell:
> Thanks, v2 posted with the commit message fixes and correct tagging.
>
> My device isn't a Sapphire RX 5600 XT Pulse, it's an RX 5600M and OEM
> as far as I can tell. The condition in the original code was too broad
> and was catching devices like mine (or the devices of the other bug
> participants) where the hack was breaking things.

well that doesn't really make sense. As far as I know the problem is an 
invalid PCIe config space on the whole series of the ASIC, but I can 
double check with the hardware engineers once more.

What could be is that a later hardware revision doesn't have that bug 
any more and we don't need to apply the workaround. That is trivial to 
confirm with an verbose lspci output, but even then the workaround won't 
hurt in any way.

> On Tue, 26 Oct 2021 at 22:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Christian, Nirmoy, authors of 907830b0fc9e]
>>
>> Subject line should look like previous ones for this file, e.g.,
>>
>>    88769e64cf99 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
>>    e3f4bd3462f6 ("PCI: Mark Atheros QCA6174 to avoid bus reset")
>>    60b78ed088eb ("PCI: Add AMD GPU multi-function power dependencies")
>>    8304a3a199ee ("PCI: Set dma-can-stall for HiSilicon chips")
>>    8c09e896cef8 ("PCI: Allow PASID on fake PCIe devices without TLP prefixes")
>>    32837d8a8f63 ("PCI: Add ACS quirks for Cavium multi-function devices")
>>    e0bff4322092 ("PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI")
>>    ...
>>    907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>
>> Would be good to mention "Sapphire RX 5600 XT Pulse" explicitly since
>> that's what 907830b0fc9e said.
>>
>> On Tue, Oct 26, 2021 at 09:46:38PM +0100, Robin McCorkell wrote:
>>> A particular RX 5600 device requires a hack in the rebar logic, but the
>>> current branch is too general and catches other devices too, breaking
>>> them. This patch changes the branch to be more selective on the
>>> particular revision.
>>>
>>> See also: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1707&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C23c4b6057dc641fd111f08d998ca8666%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637708818349122129%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=lhBo74fAemYtZKYSqkfRtvN1Jo48%2BnZtNIaAAFS2DfY%3D&amp;reserved=0
>> There's a lot of legwork in the bug report to bisect this, but no
>> explanation of what the root cause turned out to be.

Yes agree, that bisection is extremely unlikely to be correct.

See the driver allocates addresses from both ends of the BAR and works 
towards the middle.

So if something doesn't work correctly we see that immediately because 
the driver isn't even able to initialize the hardware.

What could be is that resizing the BAR reduces the overhead drastically. 
Resulting in some use cases to have a 10-20% performance benefit. When 
we have a timing bug somewhere else the patch could potentially make 
that much more likely to be seen.

Going to comment on the bug report as well.

>> 907830b0fc9e says RX 5600 XT Pulse advertises 256MB-1GB BAR 0 sizes but
>> actually supports up to 8GB.
>>
>> Does this patch mean your RX 5600 XT Pulse supports fewer sizes and
>> advertises them correctly?  And consequently we resize BAR 0 to
>> something that's too big, and something fails when we try to access
>> the part the isn't actually implemented by the device?

We do have devices which have a non power of two local memory, e.g. 3GiB 
or 6GiB. In those cases we resize the BAR to the next power of two and 
that still works.

>>
>> It would be useful to attach your "lspci -vv" output to the bug
>> report.
>>
>>> This patch fixes intermittent freezes on other RX 5600 devices where the
>>> hack is unnecessary. Credit to all contributors in the linked issue on
>>> the AMD bug tracker.
>> Thanks.  This would need a signed-off-by [1].
>>
>> We should also include a "Fixes:" line for the commit the problem was
>> bisected to, 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire
>> RX 5600 XT Pulse"), if I understand correctly, e.g.,
>>
>>    Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>>
>> And probably a stable tag, since 907830b0fc9e appeared in v5.12, e.g.,
>>
>>    Cc: stable@vger.kernel.org    # v5.12+
>>
>> If stable maintainers backported 907830b0fc9e to earlier kernels, as
>> it appears they have, it's up to them to watch for fixes to
>> 907830b0fc9e.

What would be very helpful as well is to CC the relevant AMD engineers 
which wrote the original patch and signed it off.

Regards,
Christian.

>>
>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%3Fid%3Dv5.14%23n365&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C23c4b6057dc641fd111f08d998ca8666%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637708818349132123%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=cY7hOAFEuEqQuwUOY50hXmS0BvyP9D%2BQNBNsxn%2Bgmtg%3D&amp;reserved=0
>>
>>> ---
>>>   drivers/pci/pci.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index ce2ab62b64cf..1fe75243019e 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -3647,7 +3647,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>>>
>>>        /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
>>>        if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
>>> -         bar == 0 && cap == 0x7000)
>>> +         pdev->revision == 0xC1 && bar == 0 && cap == 0x7000)
>> I'd like to get the AMD folks to chime in and confirm that revision
>> 0xC1 is the only one that requires this quirk.
>>
>>>                cap = 0x3f000;
>>>
>>>        return cap >> 4;
>>> --
>>> 2.31.1
>>>

