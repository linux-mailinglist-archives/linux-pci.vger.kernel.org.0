Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19491439724
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhJYNIe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 09:08:34 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:55369 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhJYNIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 09:08:34 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 09:08:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1635167172;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2KivBIZDND/s71bmuPR2OicjG/jSEt9jUUp6qvN9fMs=;
  b=eKAoU1WMSF+GVy7EBI1YI/rA1uj8MejiutNUDmGKaUnWLJTPS91PjF0S
   mfZWZRPJuKwtAqrKQSg9z0de0o0I6mE8SJXpuIHO4q0kyysLcntkUw3G3
   jxf2n51NoKg+0sU621IFH0Y0JypYW5zV4defXt+SU8pM/0S70uQOk09TF
   c=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: AGlHCg7y+hIsBHbp+Xs3RBUBzT33guBx1C7xpAlQS+Xq5QvllD21Sd5xBdy8hF34zRQqFS6+04
 MoPdt1D9rpo78sJYgFgLhs71sLcaqZ/Oa0r4xNvvWflvcnXH5KwIH+rl1uF/PrBPlopCLv0Fno
 DJoXSHoQUv2EcFOcmj5f/WirQF0WKS4AF7E8/KNtzbUP87zyAY+cTVtoZ6omXTESrS8a5JzW0t
 4p1c+wdiy6Ey0ih4LPydoSMwekPze9ZRRB9XGwjgzNBE+c9+3x0cob3+m2s0onOBX65yFLkOKm
 GNoh+7pYkMpZ+G6GuXoGDn6z
X-SBRS: 5.1
X-MesageID: 56003971
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:UVSf6a/leLbhi/WRURsoDrUD83iTJUtcMsCJ2f8bNWPcYEJGY0x3y
 WIYUWjQOf+PYTegeYoiYN61oxsFupOEn9NrHlFlry88E34SpcT7XtnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si9AttENlFEkvU2ybuOU5NXsZ2YhGmeIdA970Ug6wrZj39Yx6TSEK1jlV
 e3a8pW31GCNg1aYAkpMg05UgEoy1BhakGpwUm0WPZinjneH/5UmJMt3yZWKB2n5WuFp8tuSH
 I4v+l0bElTxpH/BAvv9+lryn9ZjrrT6ZWBigVIOM0Sub4QrSoXfHc/XOdJFAXq7hQllkPgyy
 NNgnJmuRjskL6Dpg+YFfzdmEiZxaPguFL/veRBTsOSWxkzCNXDt3+9vHAc9OohwFuRfWD8Us
 6ZCcXZUM07F17neLLGTE4GAguw5K8bmJsUHs2xIxjDFF/c2B5vERs0m4PcFgm9o3ZERRJ4yY
 eI6czk2ZwacbiYIeRAdWZgzsLysuHPWJmgwRFW9+vNsvjm7IBZK+LzsNsfFP8SBRO1LkUuC4
 GHL5WL0BlcdLtP34TiK6HW3ncfUgDj2HokVEdWQ8/d4qF6e3GoeDFsRT1TTiem0jAuyVsxSL
 2QQ+zEytu4i+UqzVN7/Uhak5nmesXY0R9VUA8U+6QeQ1rDT5QeJQGQJJhZDYdoqrt4rRhQl0
 1aIm5XiAjkHmLGKTG3H3raSoym7NSUcISkFfyBsZQkC+NTtiIY/gwjLR9BvVrW45vX1FDX/y
 jmRhCsznbMeiYgMzarT1VrAmTO34J/SUhQy+B7UT0qi9ApyYIPjbIutgWU39t4ZctzfFAPY+
 iFZxY7Ot4jiEK1higTOQOMgNbS36MqIITD5mlx3M7cf9jOirivLkZ9r3BlyI0JgM8AhcDDvY
 VPOtQ452KK/LEdGfocsPNrvU5VCIbzIUI2/DKiNP4Umjo1ZLVffpElTiVisM3cBeaTGuZo0P
 ouHao6SBHIeBLUPINGeFrpFj+FDKszTwwruqXHHI/aPjOL2iJ29E+5t3L6yggcRt/vsnekt2
 4wDX/ZmMj0GOAEEXgHZ8JQIMXcBJmUhCJb9pqR/L7DYf1M+QDtwU6eLkdvNnrCJeYwPxo8kG
 VnmAidlJKfX3yWbeW1mlFg6MNsDoqqTXVpkZHdxbD5EKlAoYJq17bd3SnfEVeJPyQCX9tYtF
 6NtU5zZWpxnE22bkxxAPciVhNEzL3yD2FPRVxdJlRBiJvaMsSSSoYS6FuYunQFTZheKWTwW+
 uzwiFiDGsFdFmyPzq/+MZqS8r94hlBE8MpaVErUONhDPkLq9YlhMSvqifErZcoLLH3+KvGyj
 m562D8U+rvApZEb6t7MifzWpoulCbImTEFbA3Pa/fC9MiyDpjivxopJUeCpezHBVTyrpPX+N
 LsNl/ysYucamFtqspZnF+o5x6wJ+Nay9aRRyR5pHSuXYg3zWK9gOHSPweJGqrZJmu1CoQKzV
 0/WootaNLyFNdnLClkUIAZ5PO2P2etNwmvZ7OgvIVW87yhypeLVXUJXNhiKqSpcMLoqb991n
 bZ/4JYbslXthAArP9CKijFv216NdnFQAb86spw6AZPwjlZ5wF91fpGBWDT954uCaosQPxByc
 COUnqfLm59V2lHGLygoDXHI0OdQ2cYOtRRNwANQLliFgIOY1Po+3RkX+jUrVAVFiB5A1rsra
 GRsMkR0I4SI/itp25cfDzz9RVkZCU3L4FH1xnsIiHbdHhuhWWH6JWEgPfqAoRIC+GVGczkHp
 LyVxQ4Ji9oxkB0dCsfqZXNYlg==
IronPort-HdrOrdr: A9a23:ZyzxJKzyBt644Ghtd7znKrPxOugkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ5uxo9pPwEU80hqQFn7X5XI3SEjUO3VHEEGgM1/qY/9SRIUfDH4JmpM
 Ndmu1FeaHN5DtB/IfHCWuDYqwdKbC8mcjC6YixvhUdKD2CKZsQkjuRYTzrdHGeMTM2fabRY6
 Dsn/avyQDQHkg/X4CePD0oTuLDr9rEmNbNehgdHSMq7wGIkHeB9KP6OwLw5GZcbxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819p4AtCWgMR9EESvtu/oXvUlZ1SxhkFznAid0idtrD
 AKmWZ4Ay1H0QKUQohym2q05+Cv6kd015ao8y7ovZKqm72IeNt9MbsAuatpNiLD7Uwupdd917
 8O8V64mvNsfEn9tRW43sPPUR5ykEqyvD4Fqs48y1JicaZ2Us4NkWQ4lHklT6vo2BiKtLzOWI
 RVfZPhDL06SyLIU5iR01MfkeBFFBkIb0K7qjBugL3K79EepgEL82IIgMMYhXsO75Q7Vt1N4P
 nFKL1hkPVUQtYRdr8VPpZNfSKbMB2Hffv3ChPZHb0nLtBxB1vd75rspLkl7uCjf5IFiJM0hZ
 TaSVtd8Wo/YVjnB8GC1IBCtkmlehTzYR39jsVFo5RpsLz1Q7TmdSWFVVA1isOl5/ESGNfSVf
 q/MI9fR/XjMWztE4BU2BCWYegfFVAOFMkO/torUVOHpczGboXsq+zAaf7WYKHgFD41M1mPSk
 frnAKDbfmownrbL0MQsSKhLU8FIHaPj66YOJKqi9Qu9A==
X-IronPort-AV: E=Sophos;i="5.87,180,1631592000"; 
   d="scan'208";a="56003971"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfdX0Zuj8/Frnz7c5fhNQK/Vj4YPjxc9rRmK1C5xDKN8B03+CL3NyVE/p74rr5qSxj7lhLahVLq/9RN5VjrGbo/Qgw7o+3oU1FxtcWahaNh5fcZJYAZSTdtcjDRXZK4hH807fX/9FC1aPYlX5umBsTX+fgQ6NT9oWGRN8/bPo0VzF9QlreMNWVWHxbCtGlBf8EM+/LiDRMbgDbRbbNajuCXUSf1Box/YBFzr8bLH8ol08FRD48iKZ6KXLn2JxIRX7p6Z2aIsdvY9Vh7sx1QtmR4zpee1EIHpuHPXWZliLHr2x0V8MnGiWuiCj6YpXyzkA0vv9BEcNo43G3SzriNN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5HlCx1T4j1mLh8UL4lgbY+XWzMabz9h68wj0xoDXNg=;
 b=PzXDVuG7S2bjYvbNiGo097D+Tvw0A0F0ffKC70pVBcjTLXew7mf1z6xTMwDZyaAVcRmlACWnnpw+cDkI5N0LFgLN4L8Ho5CN2y5C81R4FUKkR0meolKvVaoRT31YrxYg0kSkz3hpQBkiL7DB76qgdjDoNmS9/CTTicP2kesiuCKAxaf6kIpRdkwbG9UJ9TIzeDJjL0xL5Q3C66Gb6Lt0RilJV1EyT1G/yeK1M9T135fKYTNXJTjz3w0q/KMwSELD/zT+mb4xSFFhSfpoKZWnWBloHwyuRYxUmitJ5WPAvN4iAh+m32I05Grzpr0gA+8WDIxw7oNyvp+ozloxX5iLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5HlCx1T4j1mLh8UL4lgbY+XWzMabz9h68wj0xoDXNg=;
 b=YNVIzy2T8rpM1Dc3yg6OLn5r7WFYLmSApHGV4dZEhZhDq2VwpXlzBTumcgG6KOdW10E8CXZShUvbKFrIVsyaiTiKnKhsv1rDeBOsi2vwTiXTcnMH8+DBb1GGTEKQ7DOZTXWebPZzzmmr3FwbFq/1pNUnVZJJ5DMl0aQaGQuUU7Q=
Date:   Mon, 25 Oct 2021 14:58:56 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     David Woodhouse <dwmw2@infradead.org>
CC:     Jason Andryuk <jandryuk@gmail.com>, <josef@oderland.se>,
        <boris.ostrovsky@oracle.com>, <helgaas@kernel.org>,
        <jgross@suse.com>, <linux-pci@vger.kernel.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
Message-ID: <YXaqENqdjx0lJ+Fx@MacBook-Air-de-Roger.local>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
 <20211025012503.33172-1-jandryuk@gmail.com>
 <eb38c1d2707d03bf675d7b15f014cbe741de0998.camel@infradead.org>
 <YXaYe/RF6NWFKxGj@MacBook-Air-de-Roger.local>
 <72d763d055929b8c81f0c8deab14b33bd252c946.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72d763d055929b8c81f0c8deab14b33bd252c946.camel@infradead.org>
X-ClientProxiedBy: MR2P264CA0173.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::12)
 To DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f0d77db-ba27-454d-7db5-08d997b737a5
X-MS-TrafficTypeDiagnostic: DM6PR03MB3675:
X-Microsoft-Antispam-PRVS: <DM6PR03MB3675C7F0CB10528CB533D4778F839@DM6PR03MB3675.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCU3fhuoVvh+E1VtrL5opt3zvdy2Fc93eJqI0jE5nM6+EnR1AuhaK7MSFGyLz6Snsd64OgbH2KT9FoUUFV0SDzR4fG17VYp7Sy13Fucw1a2ZxhsAx5tvBPhjWWjVtgPzShng0TtIAWUbZks03+RAX1zgflCdWHIQ0+PAGQ9ANmBIdLYT6A1wkVnLl6g2VxbQ+xtVmV0qxL6aEZ0kcIsAasBcToJSzvykQii7uUJkim7FNCIEh0FVsVtNeO2snOrjR4iSowwRBaor/RWOjh/PseOEBXcrlxVzmA2YDWtyhxWcwJAkASa1bgDejAy9kFJb/i+SEnekCu9jBAyVsX3Qhz1O6KLV53Ae6Tk6MfkLJWQOZqIjDL4nqqIK/sTeHTdrHjgpPwkwkCLQgWgozi98XNL0M+zyXVl6dzXijz7JxMkFunDhUKUOnT6tVA+KAxc7LujNXbRnxWZTw95OIroO73HTbz+bain1YBUcV+dLSumh74yNyhBxwxvKldU+oCEU/CLU9PU1qjhKAH8HCh5Tz25lYvbDTlKOrMyP9qKfyyLg5qItkUWI53z9cb9uNneRy4ElWFXmXyGjiVSGw/kwiyX04oMEJ+V5UA5V7lEeWh2pWyrYS0p8nJluGmYzuIdR4wrXpqL14UYL1QCXDAijufujUY02iUsqt7tplVkBed4DgqIXs1EIYuilos2qR1IwMKqvuxRXmSFGAgTkMYDZeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5608.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(85182001)(186003)(6496006)(6666004)(82960400001)(508600001)(2906002)(86362001)(38100700002)(83380400001)(8936002)(66946007)(66476007)(66556008)(7416002)(8676002)(26005)(5660300002)(316002)(9686003)(4001150100001)(6916009)(6486002)(4326008)(956004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjQ0aytkN3NtTlpuMHBEWTFibFB3ak9xVUlDOHlzcHYwUTlUVmc1L1FTZlZG?=
 =?utf-8?B?eVRMY3FnQ0lnR01INkV5QWsyL1RTdkNSNzJScU9wRDE5ak1zelJxTmRpSTl0?=
 =?utf-8?B?OG1MRjcrWEQwMStCUzhrTWlhSUFvS0ptb1NLQnU1QWhkK1l5cDRrN2Y0UUIv?=
 =?utf-8?B?OW00aHYzWFJKajN1aEU5cU5zUk1mL1pNNUlDUEdLMXN4QVlsbHJQeFNwcXZB?=
 =?utf-8?B?bnB1dDBoeURlSzlNcnFtSkxzVkcvbFFuOThwV3EwUjZYc1V3cmd1TUR4UVlh?=
 =?utf-8?B?SlRIaXo0eDR4VkdhMG5MSXU4WkZGbHNLY3VwNDd5THBZS1ZLSHpCeE1SN0NI?=
 =?utf-8?B?V1YzVG9DYXNPTXhIV1d2aStzN0FKTUsyK3Vhdks0ajRIanQ4L2E5dmVFVUla?=
 =?utf-8?B?NUNxdkJyOHMzUUh6b3lHV0lDanpDOHB3d0Zlam1ZcUN6blhPNndCbVpOT2RK?=
 =?utf-8?B?Zy9KMGt1VDgzdCtKK05nbVBFMzRNeVExaWxRUGFpZ1VyYmVWT0lHTXNVK0N3?=
 =?utf-8?B?M0tZVWx3T1E1WXp2TEp6blBjOE94eG1RWnBqSVFVMk9XUG1xci9UREVtdXA5?=
 =?utf-8?B?UHhXdzFSc0FmNW9CUzlISHp4Q0hHWEZ5UkE0SmNkKzR3U0VLeDdxVjZjYktU?=
 =?utf-8?B?eFFPSGN1dUV5Z0FOZFRYaFVWbDhjNCs2QmFkWHlnTFd0dCtsL0RLZ3plWmJD?=
 =?utf-8?B?QXNPbDFsTEhzWkJRczBrQlpCbTUzR3N0NDMrbkI3MjlZT3JpbkpVUUtWcjQ4?=
 =?utf-8?B?bHJhNGZyd014Qmd0UnNjQ2VIc1FheDBJUi95QldyWllYVHNCeEoxa1BtdXRJ?=
 =?utf-8?B?UXhHeHNzSjFEWlUyK3Z4UWNJZkFFYWJOWUZTcExUdUJPd0hkQ01pNTFpZlVI?=
 =?utf-8?B?c1IxU2VGdzNMajVuVzNSalJ4aUpsZnVjd0V1VE1vZDFYQ2tlNmFkbERNZGI0?=
 =?utf-8?B?ZGpidVFaVW53UW9nVEdIRXJqRFM3c1dSSUdLTlNmYTZha1ZQdFY2OVFVNHVk?=
 =?utf-8?B?QUlqUzVxa2k1eUcxZkRxQXpRcTdLWWt5bHhuWllpUkIxM2JDWGQxUk9meWxT?=
 =?utf-8?B?YUMyQzA0OWVlMWVEOUpZVVJKbGZsd04vYnVWOFFQS2ppb1JKbitKQ1AvTFBO?=
 =?utf-8?B?bFpNbldGb2lDaDJnTGMrQU1Kc21iUk5zSzFDWjRsVEJIZVJNVGN2UE9rRlIz?=
 =?utf-8?B?MGduSXgra0I1aWxLRWc5Mlk3aDNuQWVJM2dkNlRncTkxek5aSmx5SWUxUmhu?=
 =?utf-8?B?czRDeFV6Sm9OZmVidkk1b3Y0d3Q0NUdBQ01lNVVlZEg1bTlYZ0J0cm5saGZs?=
 =?utf-8?B?TDUvYUk1cWNMUkpnQ05mRVZQSGpSWXdHOG90WmpjU0d1TXNscXJkSzZ6VjVP?=
 =?utf-8?B?blE5MnpiQ3c4bCtmNjQ0WWVnSG5JemVMMHZ4aVJ3TWZyMERXZzdvTEw2SGpE?=
 =?utf-8?B?THpkTy8yeStRQTdnanllUFdLYUtNQVNSM0E1dWdpclp2VEFLQTBQMmRPUDhM?=
 =?utf-8?B?RXkrTWVPMktycjA0SXFiUitoSjlJVGtXMjJrWVgwVk5FeThPWnBpeUpTZXVN?=
 =?utf-8?B?NkU0WkhSbjhHQUk0UWJOSTdwWEFDL1ZNVHlRYXRkOEk2cmp6cjVuU0RSUjB4?=
 =?utf-8?B?ZG5md1VHUUtoeFVXeVF0VUFmbktoekp5UmJ2ejF1bVQrQS94VjBxckJKbzRj?=
 =?utf-8?B?bVgxamRIdjMxQS9TWUZ5SW9jZFZOcXJEOEdCTXJrMGpYTW5UM2VmNmRLNFpq?=
 =?utf-8?B?OEJ5Z0FzeUgwR2lnWUo0eWVGZjAvMWoxMU1VZS9LZ2hqRjV3VVJBZjAzMkVl?=
 =?utf-8?B?TFRYMlg0TnNnd0ErQURCajdTTlVLdndXSEZacGxtL1MxMldXc1Y2cW9pVEkr?=
 =?utf-8?B?UUVVc3J5VDZqWmM3R1BJTnM1OEVtMFY2WG1ZN3NpcmNjQjUrS3BtUWozQUYw?=
 =?utf-8?B?TVd4enNOTVNEM2VmL2dVR09YTFkzbExFeDlLNGF5aE9kaW9YRkpZUUorbUZy?=
 =?utf-8?B?Sk9ycXZLMFdKcXNZNWx0cWYzb1lJWVJuTnhnSEcwelU3SDRPRTFOOFViQmhP?=
 =?utf-8?B?R1pwWEJXNnRmd1hKcDVzR29FTFAwTWVDMjV5Z3EyK0NhT20vUVJuaHRadlVG?=
 =?utf-8?B?Y1dBeXJCd05SL1VSZXNuWjJvZjIzVDlXMjJYRXNpQ2lJdFV6ZUN2MjFZMTMw?=
 =?utf-8?Q?tSxnq98UfvhIcuBjFh4Wa5Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0d77db-ba27-454d-7db5-08d997b737a5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5608.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:59:01.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ieeRC4EgEGJGDyA4R2IawlvL+OEvNlu/eiNKFLk7BeJ4R+aPx1Fd0b/YuFLjNo73EfhReWIi8D/QY72BLfx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3675
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 12:53:31PM +0100, David Woodhouse wrote:
> On Mon, 2021-10-25 at 13:43 +0200, Roger Pau Monné wrote:
> > It's kind of optional for HVM guests, as it depends on
> > XENFEAT_hvm_pirqs, which sadly gets unconditionally set for HVM
> > guests, thus dropping any benefits from having hardware assisted APIC
> > virtualization or posted interrupts support.
> 
> Indeed. After implementing PIRQ support for Xen guests running under
> KVM, I spent a "happy" couple of days swearing at it because it
> actually *worked* if something would just *unmask* the f***ing MSI, but
> the guest inexplicably (to me) didn't do that.
> 
> Took me a while to work out that Xen itself is *snooping* on the MSI
> table writes even while they are *masked*, to capture the magic MSI
> message (with vector==0) which means it's actually a PIRQ# in the
> destination ID bits, and then magically unmask the MSI when the guest
> binds that PIRQ to an event channel.
> 
> I did not enjoy implementing that part.

I can see that. It's even better because none of this is actually
documented.

> FWIW the *guest* could potentlaly be smarter here and elect not to use
> PIRQs when hardware assisted vAPIC is present. Aren't there some bits
> in the CPUID that Xen advertises, which indicate that? 

Yes, it's in leaf 0x40000x04. FWIW, I would also be fine with removing
XENFEAT_hvm_pirqs, as I don't think diverging from the hardware
specifications gives us much benefit. We avoid a couple of vm exits
for sure, but the cost of having all those modifications in guest
OSes is not worth it.

Roger.
