Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE7D476ADC
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 08:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhLPHMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 02:12:54 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:34048
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232018AbhLPHMy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 02:12:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIeV9HwJd2pvUnUzzWAccSVaoilVknVEtWxBkx+8o9aKYTJC2Aq0/zFlG4KlPKZPWrn2+CxafEVZYGEDMSzwH6bs5RmZ3FpSdpRCxBKmZC+xhpE7qyKyL/NWATDGb9FgRjZK0Gi3Qfa52X9Tmln4/9T/RMcT/kOtkBmoELjJJ3GAXxpcEz1/lEwiXe1aVEir9WySvFMzEIzcm8xFgAFexGXffWAr5oSwFMj4YOiP9kTEOIEwQ2f0DC3+5QVCVPOzw6VMrUSuVUCGKiNulA++LTZGDOVqQxBUPwy+KpIyZWSSSP1DRM/jqypinjo3EWAr5nRKl4K99JVAP75PVm57OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eqia6S7D9p+rokjetD8YkCahlJxPdQ6VmDV96sRUmE=;
 b=BvC7fGCTWOQdMI0Wwz+MbwBnnZhm/2KeeVNnCv6rI7FPo1B1gQxF4axAxVhSUe5wI+fFVut3vDDjXFlWPp58Ye34uIdSfgg25N+0f+JsYsghHDfvwl52flGC7mZ8LReO+KRLDK0swcFucJVwbZos9ok2aoKA6xM4NKLRqasF5q9mNeUG48EhIafYkekZ7coqRx1O4jovlNzXbipaydpg2u2F/MOIih2zDdeio39pRgsGOuCP3gD+LHMh54o+HD7BBhHClQXGFtexapcSnV6Xqy8G7553AqDJQBfhDyRFptXu3eMKqZYH0LOSoHMW8BFVO+2LGqnax+GHylm1m2qePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eqia6S7D9p+rokjetD8YkCahlJxPdQ6VmDV96sRUmE=;
 b=wg3INUcS1B1DxUK5Tk0LF1cfytmj+Dg5MpXE3Zwv4CRxW1EQ8UPBOY4wlY8P8R6fiWUWtJzt8Vh4JbA2RfniIzbxyziLQFPJqxeoFsF/pNharZKaIRMR8KoELV6M4RoMHMmX88fkkJw8EdcBqSogXO71h2Oqrue5AOPeIs+VITk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1839.namprd12.prod.outlook.com
 (2603:10b6:300:10b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 07:12:52 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4778.018; Thu, 16 Dec
 2021 07:12:52 +0000
Subject: Re: [PATCH 2/2] PCI: Don't fail BAR resize if nothing is reassigned
To:     =?UTF-8?Q?Micha=c5=82_Winiarski?= <michal.winiarski@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
 <20211215141626.3090807-3-michal.winiarski@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <60ff4820-5dd9-bb3b-9baa-55ac53c0646c@amd.com>
Date:   Thu, 16 Dec 2021 08:12:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211215141626.3090807-3-michal.winiarski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::40) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d1b440-5258-4aea-a866-08d9c0637952
X-MS-TrafficTypeDiagnostic: MWHPR12MB1839:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1839E516A00CC709CBC384FF83779@MWHPR12MB1839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N38DpRYg/nrYaJMQfRNdamGIXXbUsM6D/jNWoNKVjv7fJ7Kj/jNS2aiV13t8nu5VBYsfaRLc0QXNU0rtdSdojx3m/3VP8nQfxqfdyuosU5Y/6c6EYxBpHyd/g/5aNybLCoiDGCgLCIKl0J29opKhM+/CDhCXJBqSE64+OQkXPPNiJk1d+kTwzMn/iOf4sfZjI1TwrjSNrO6mcIk8991mHf21lHhpw26SLOYwJ0rtyLdbBrMl+N3CN7FWVdffLoQt1VMrzyLIVeWMso911tbe5yLy5BKOjas4F9cOdJ9iRFcGht8eLOotPJj9krpzWh5D6ppPqIltusvwEqzc5lmGMc518GWVM7x9b6i3p6CzYkXAxPTyucLrTYaJeIouAkyfH9wsMcOq//6xxS8OztKQajNrp79WffqCDSg7izyp3yYHwoO+kl3Wp7cFc4pUKGi+ESSJ6oM74X1MKmMNeb6h1acL9IOSxgN7OE4KN9WTK6hI7u23xTdKaQUleAzFq6ZikvJHcMRFNlxZgnvRY/971GwYMO7Oe5xy05NnZECs1Pa0ZvYjAmFRtTzyshCFgFw1WDLQp0NgPKDdt9+14JlpikdS9QoMzRK9X0fxeC5mccfxHIDsBQJZIo1yaz3rpmt8l1d5uCsg4e15mO8+EyP11CxDV4czquaz1BMilgl8AN5QQ9zf67UOVDxnHdjHQbR06JtuuMbDF8YKFXtQuFKgMYe31f96RxFoAikYzdYEZSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(31686004)(186003)(5660300002)(86362001)(2616005)(83380400001)(38100700002)(54906003)(6486002)(6666004)(31696002)(66946007)(8676002)(508600001)(6512007)(66556008)(4326008)(66476007)(6506007)(110136005)(8936002)(26005)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5mNjFDampKeXJFbVNGVm5BcWVKZGtpWk9Ba254cWpoNCtDOS9SRG0rUTB1?=
 =?utf-8?B?OFZtcGQ4QlFIZ2lEY3dPZlVHOVZaYkRNYWgwbHcvZXJEeGtlL0VhVkhFb2dZ?=
 =?utf-8?B?bCtUMVVIUzJ0M0psYlE5bmY1a1MySUhiemIyVDNTUDRCYjByU3hkYmVmcGdC?=
 =?utf-8?B?M2RXSFhpdjNOM3JxazRTRTB0UUdDZzlRWnpTcUxuNlRKSnBubGFVT0NRQU44?=
 =?utf-8?B?YmpHeXhzTTR1clRpUVZvT2c3Ti9tdmt1emllNHdoaWV0cS9JdHdTUm1VVnM4?=
 =?utf-8?B?c1B1UXgxWmw0R1N1ODlrblFPN1hzdmY5czRyckhGT2JmRE1ZcFlyWHhvelpQ?=
 =?utf-8?B?dElrdWhRK21KVDVUOWVJWjJSN0FMVktUYU5TTVh3YTBjaXliTVQ5NWpOM0cz?=
 =?utf-8?B?QjUvSVgxUnNnbk1RYWdmSnhlSy9YcVN6TXFzYnBUcVNvZUJHN1gvdGxyRVJW?=
 =?utf-8?B?UExXQ3hBYk91UmJoL2d4dU5NK21yU0ZrYUFCTlRZUnRGaG4ySEJRWUo3TWxC?=
 =?utf-8?B?aEZsVGFDRmJNSnViMmxUOXBGemRBODU1eWg3Q1NkWlhKVkZYRDBNT3JlQ29D?=
 =?utf-8?B?OTdwcER5K1hXaUh2WmI1SFN6Y1BVanFXUlV3N2R2YVJ2R0RHWWxWZzBtVi9n?=
 =?utf-8?B?cHhlREdmaDh4eDYwaHJNUzFRMEhRMzBySTdXTnNCM0diTG40ZDJTRjlzU2pa?=
 =?utf-8?B?M1A3dVBHQVFnZU04bTVIWDhCVGFYYTVLcGVBYUFoNWtaSFAwSmpFeWdXajdU?=
 =?utf-8?B?Q2F6Vnk2U1BCUisxaU1Vd0lCdHNKMVRncTlUWGFLTGVwRUNHTU91RjN4VVQ1?=
 =?utf-8?B?K1oxU3N4UVhleUdZWFJEZy9jT0JWSUd2dFIyZ3E1TEhwSGJ0cTRpem55WkRS?=
 =?utf-8?B?UGxsVWtYT28rQmh1R0lJVlFPa3RYMUZTcjdkUHcrQkdwaDV0QzRmbGt6SzJQ?=
 =?utf-8?B?VUt4bElNdENVOWpDTlZseWFEbjI2MENrSXZhODRYRFJqeHUybWcwQUpFZzhn?=
 =?utf-8?B?WHR4T0xQbEdQUjc1dmJZWjdMQXNXejMvendxTEZkb2p2clI0UnY1T2VRTUFY?=
 =?utf-8?B?OExaRU1Uc0NlUjByTjNwdzBuRVE2WEw3SDg4dzNNby9TTUtKNVhNZm5rYjlL?=
 =?utf-8?B?UUlVT1pwUDBwSjN4WEkrYUo3ZWhFalBVblh1ZHBuLzJVTkF2Rm1LMkdyUjA4?=
 =?utf-8?B?VmhkYnkwRGlzelE3UVhpWDh0SEc4S2l3a29aT2lNdUM5enlUNnkxZXV4b1dX?=
 =?utf-8?B?R2lNNnZJVlpZendROHN1dFE4ci9OSHhYTXplellVOFhpc3dBSnJzTDUySG1I?=
 =?utf-8?B?MmFPOXQ5VEo5WUcxVWpvcitLRS9wOGJkSFJSZ29yOEpreU9qWHBXL05hOVZT?=
 =?utf-8?B?eEpFdGxDWVpIV2pESW13U0MrR3U3VUhQWEEwK0g2OTFGZ2dUSDZTZ0JPRnFi?=
 =?utf-8?B?Z0Q3MStvbm55U2ZRK3FjQmxiS1I5bjlqaEpFekt1NWdPc3o3U0g1Z3FlWnRK?=
 =?utf-8?B?U3h6TnIxNVBXNjRKbGlaS2F1SWVLemxaZitjbWFXeWFZNGo3WjJsOWI3TjRq?=
 =?utf-8?B?QXgrbWpmb0s1U2EzNUFaT1ZMUm9rTnFJTkFSTVVLYjlGYzdVbXdvekM2d1NC?=
 =?utf-8?B?RmFWdmNCdFAxanBHVDh0c29FZkQ2aXhxNEF6Wk1kcmVkbnBKSm1aUS93cUZJ?=
 =?utf-8?B?Q1FyWURpdzdWNDV3dy9heVc5Zk9nOEYzNXVMZzB3Q0hQMDZxWFNQV1p5YlRt?=
 =?utf-8?B?cTlacmYzWFZDUUJNZWYrMElpSVBBdmUzeUtJOVlRcm9qVmloOHQvTFc2cFE3?=
 =?utf-8?B?eS84cDlHSXU5TElpYVdIeWdWQ1RVUjN6YzlzSVhVRVhwYjFiZWVxQzZ5czhl?=
 =?utf-8?B?K09iamlud2pLZzJLQSt2cFZOU0hwcmJTL2hBOWx5WHBvVjlvem5qVmJqWXpi?=
 =?utf-8?B?b095eWhyeGx3T0V3bTVLei92YjFLQW5lZ3FMOERwZ3VYd3RkR3FYY3JBRDRT?=
 =?utf-8?B?Qk9WUXJ4dml6ODhsaytwUnFXbHF0NzhKUXZLL1ZIZ1BjOUErdlNyYnZJTnV4?=
 =?utf-8?B?Y0RvekZwWVBFMWYwOEd5dmU2bDFwY29wejVKMms1UnVlSFJPT01MOWVWKzY2?=
 =?utf-8?Q?xh50=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d1b440-5258-4aea-a866-08d9c0637952
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 07:12:52.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeE05SctRj+ufvWomITCZECfvjZ1Vvl+bsiRA3ZtRjgwc0wVhVuJKCG6r0pztMpP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1839
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 15.12.21 um 15:16 schrieb Michał Winiarski:
> When pci_reassign_bridge_resources returns -ENOENT, it means that no
> resources needed to be "moved". This can happen when the resource was
> resized to be smaller, and it's completely fine - there's no need to treat
> this as an error and go back to the original BAR size.

Well that doesn't make much sense as far as I can see.

Drivers mandatory need to call pci_release_resource() on all resources 
which might need to move for a resize, including the one which is about 
to be resized.

When you get -ENOENT from pci_reassign_bridge_resources() it just means 
that the function was not able to do it's work because the driver failed 
to release it's resources before the resize.

Technically we could indeed skip this step if the new size is smaller 
than the old size, but then the question is why would somebody resize in 
the first place? The freed up address space is not usable if you don't 
do this.

Regards,
Christian.

>
> Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
> ---
>   drivers/pci/setup-res.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 1946e52e7678a..5de5129055e0a 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -484,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>   	/* Check if the new config works by trying to assign everything. */
>   	if (dev->bus->self) {
>   		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
> -		if (ret)
> +		if (ret && ret != -ENOENT)
>   			goto error_resize;
>   	}
>   	return 0;

