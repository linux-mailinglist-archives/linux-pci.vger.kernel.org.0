Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2669D3DEF4F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbhHCNvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 09:51:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2250 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234324AbhHCNvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 09:51:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173DH7AX028923;
        Tue, 3 Aug 2021 13:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2mZbZyfiuTlms499V4IG4PxVGNg36eQfGrSwhjFZGXI=;
 b=UhFyGFgm3mcMyrQmcZbxj8rx0kX3MjhEPKJETf6aKf45mVL+RjompB5BrX6j7CKVatfO
 Ymglcn6DvEqdYqcKn9f7hMgNizi6gQkboysuzDDRfZy+aBptZDXZQOCNTAumnHlVHalS
 oAz2cR82FxMbsi5O5KVMXQNUVqrfvRG7xB86gXjazzIgDIsNbYOjdgIPMKW2iASdW0D+
 jCyHUc39ar6LmbClyjtZlH3OCBXiA/fgkKU0wOrSvX9Z04tqcMY6Rv+dEvtd51eHJDP9
 7cFDJHZkVkDg1blk0GpDYUCqtYlTCDJumeTp7o/5drfiiWQrPoqP0xhdRJKysDHm0S6q ww== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2mZbZyfiuTlms499V4IG4PxVGNg36eQfGrSwhjFZGXI=;
 b=QFy/VipurUDmkZXn/W+0Q/+q2knM6xsYPEbpH82dhkXkiPnTnk2ZrKm9IBYRUqFxgP8M
 6S1sn3pW40Ga9Dq8eb3D9WQXhhxUO2Z0CACfsN9SvjgNf4ToYO2+c/Kp11Tufqmq89LG
 NSp6DSRDNpDIfCT7RR5OXWZ6GWuK5ET4a93hsgswfRotiRmerByDtwT/VKlUQIokKVCp
 ewZslxQeh2zltkJ0ctFExW9hFIH14ogMJljof446m21PvwCwPuWcztlXa7slBuayKDUv
 3+OSIUhXrk6XI0tVXv7Aas+aH42JbEFtrI28s4oL+S67ev8TsXE1yfrlfe43DcHkxfAt eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntkn5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:50:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173DntoS128472;
        Tue, 3 Aug 2021 13:50:38 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by aserp3020.oracle.com with ESMTP id 3a4xb6sgyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0YxpPmHZkvee1a7FOhOqnpZaHrM4j61qwkN1798EO29z/fNxwL2ZhspOwfJQ6oTdhv8oltoyHXi8lWHlVDy7clHbwPnXtZSfONoLf67EN15dPVzLTECHbUs/AHVuIvSrWBWYZ8XjLNKROoFYLQL7wGZdbrjRXEhxIdfNO8vvSeKs4OAn2zmIYrLzSeyZRWtM/7CMKNFGajXvHBZtshxyTW0v8gU0zcqzcbN/mLkM3wbSDGTM6/bJ/5IpLPNTiKe/FX5rmJzKMp7/+k1UsUfMlyKkjt+0vVILWp/ajBb2zRtQdU8FDuDAkEap/l4Kwch/BUD+GvpUk+R0Qm/Iw6UQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mZbZyfiuTlms499V4IG4PxVGNg36eQfGrSwhjFZGXI=;
 b=Cng+ksvQhR0drv3DPDob39/s8oQJgcfaz2WCIHbKXsGdSOzc8sGmCghmL2vwoFqlV7Ax1zrp35NE8xAUnYVL7WR6DP2UoSqA8kUQa36p9FEnCbIcZ8sfyc7aeEkt2B4JMmXHVfK8MG8OIv2oq/v+gRyvtRk/Dp+dROPu62ezR6LN+4FtA9r88c0sHGAl11nl0+x88Wd7K0rinEm3SIhdn+9MeH8ljsfZZk+qJpqS1EybXPrQMeaR03nh+T2Gv+hOjOPWBm7D3GxxWtLEBWUx1B1CHcMZ4n/d782Ji+DB0BNLZc8tX0TkqewrygR7qA5yM/CVZkK7utsl+5U4gU1mSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mZbZyfiuTlms499V4IG4PxVGNg36eQfGrSwhjFZGXI=;
 b=BD5TlQ1hsXP7tUFSSI3VYElmMBDrBwbBOSHxZCVUUWyzprP0RizNJODyfMSpIbs3MO1k4Q7F0dlMNdDgqy712TVwh22uIo/sW5PDPwiMQGjr2Byq+dfKozTxgQEMJNurOOcX0AE6663BGz5AvrKxrzSiF7KxsbZBuLRpS2zdqFs=
Authentication-Results: lists.xenproject.org; dkim=none (message not signed)
 header.d=none;lists.xenproject.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by BL3PR10MB5490.namprd10.prod.outlook.com (2603:10b6:208:33d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 13:50:37 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f10d:29d2:cb38:ed0]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f10d:29d2:cb38:ed0%8]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:50:37 +0000
Subject: Re: [PATCH v2 3/6] xen/pci: Drop some checks that are always true
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20210803100150.1543597-1-u.kleine-koenig@pengutronix.de>
 <20210803100150.1543597-4-u.kleine-koenig@pengutronix.de>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <a2badeb7-232c-4ca0-774f-4bf7fbaff786@oracle.com>
Date:   Tue, 3 Aug 2021 09:50:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210803100150.1543597-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.74.97.38] (160.34.89.38) by SJ0PR05CA0076.namprd05.prod.outlook.com (2603:10b6:a03:332::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Tue, 3 Aug 2021 13:50:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39aac61b-2bb8-4e84-038c-08d95685ac39
X-MS-TrafficTypeDiagnostic: BL3PR10MB5490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL3PR10MB549099CCCA0AEC8C3123DFB98AF09@BL3PR10MB5490.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2tqVhf2bB/my5ArdG+4PukUwtwBHdLQ7NeHhcXfp94mq+NGYq2+2rw6yTlZQWiJ9Q1MWRaxEkoS9lQnk94ZX7OqRl6QDLTNh3M1WsXEg+8hY2213p+CIaHbqcuBHEluKd+odSzeYJfQZoZ1OY+tv1TtOc3owmLJBGWRLTu+hS+avohcGYLpxboy3xOiSrSuyD2nCat6CO//t76TC5mo0pok6yDicJcL0cJUg1V6MFEk97cDoJlU5ILjBlRHBrsIkJp6AqmcKVhrGYxFMYHclNj2cQsxXX4YtI7luL4pb/hCIHsbSnNXSHUnYl+m48eh9GL2E1vKQnUDBFh833VxE9KIFJHS/D2KiGmHW8mUHyPEKlAgstLFzf85e8CFe8RDbWXi+spv106NYkGdtKhvrsv8t3hJZ8qyonyCOMFq4ccStMlFm2Y3KC1rhCO4khjGARwtv+SaDPv1Ke5p47xIKj4ZJ7eSEmwWPljTc3xIa79CrSknoKK0+NqPLG1/4gxYOw+4j+3TXB4MamVcFqZB42LnylrIkFZ6RPGv2xRVKFMfqR2f5vj8mPdx+8d0c7wcTSj8n/fRG3cR/3HtPUD9EVsrIhaKKpYJvGRiAzxknaEMduYhW4WVEdtu1brFE6eXfohHu7+aepu3+nusYV1Q5Oh9gMdbXKEzqxFdcy1utQW8Gxl72XwOFOEt68mwGDIhUVJ6vzw2PFHod6TQD8x6727Gi8a64PMTNJ76zK6IQ5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(39860400002)(136003)(4326008)(86362001)(31696002)(4744005)(83380400001)(53546011)(66476007)(66556008)(66946007)(36756003)(5660300002)(186003)(44832011)(956004)(2616005)(316002)(478600001)(16576012)(2906002)(6666004)(8676002)(8936002)(6486002)(110136005)(54906003)(26005)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdKN2dWR00vZnRENkwvdkovOC9KZXo1QU51Q0YzVTdIQUlHQ0RVVCtjeDhR?=
 =?utf-8?B?SC9DVWJEM1dMU0FMM2hIOTFhR0RybjJhYUVyQTcxRTNPVmtJUnl3Rk52UEdm?=
 =?utf-8?B?U0JxUmg5amltazU5MHBGc2hna1p6YVBpK3kwYW5MMUoxRklYckdDekI4aExs?=
 =?utf-8?B?bVFPcWwyWGJweTRja0Y5MnArSWxkMXdMNjVyTENJUThvbXhsK0RWWFJPR1pY?=
 =?utf-8?B?bWJkbSs0NUh2dlVPYnhhUW43VFJ1V1BiTWFjZEE2T0k2U1g2QWZYTS9JdVpV?=
 =?utf-8?B?KzlVSzloR0dUcXI5b25jb0cwb09qa2dHd2JjMlZGdGx1ZG9sSUFNTDV0SkR4?=
 =?utf-8?B?MGFjRUhGY2ZMR0luWks4dkRxQmk1NTBCSmwyU0hEMFJXdVc3WWdkYWllME5x?=
 =?utf-8?B?RkJSSTBreU93Z2pJazJ2RmgrVmZXVW5FTVpIR3NSK2JYQmhJUy8rNENVSjhp?=
 =?utf-8?B?UVIvRXYrTWlWSkdrT3g1Q0dBL1dKUlN4U1JNdVlxOUl6ZVBtR2VHMDQ5cisz?=
 =?utf-8?B?cHlkYXJPYnFURzJWQkt1QWI4Uy9WUWdxelJBWE9WeVBJdlBDdnVSKzU3QjNT?=
 =?utf-8?B?YktzNi92SGNqZ25FbWUvemxERzVJdDJtemNIKzdTWlpqZ20rVmJnNG9iSjhj?=
 =?utf-8?B?YWozWVpBOGticHlCZmQxanMxZ0F3Zlo3ZnhpMHV1NTlmU0xYVm1VTXMyc093?=
 =?utf-8?B?cHd6WmR0UUJwMmpRaUN3TFhIQ3czYnRQUlpFUFRqM1Ntam5FeHFNWlMrNTdr?=
 =?utf-8?B?WnZ6clB3bU1iOHVSUWtWSkc5cW96MUEyeU00NkRKZUd3UG9mZVJBU2N4OFFi?=
 =?utf-8?B?ekNuT2pURzhYRHlMR1RiTmQ3MGVIemRmTjBtekc5dTNrTmV1QXUxWjhOZU5x?=
 =?utf-8?B?UkgvTEd3bVZ6d1pQUEdKT3FBTjZJNWV1ekk3RE1vaVgwS0Z3NmVXK0Q2U2RK?=
 =?utf-8?B?OEZBMTBFNGw5MysyTlBQMlFXWnR5cDJTODVJR0FONk9DaUpwREdpWGhwcDhw?=
 =?utf-8?B?RWVzYkw5M1J2dWQzaDFJUldmOTFua2tRQWtaTjAzdWc4TUd3VmZWdVlRZ0ZH?=
 =?utf-8?B?eUVGc3dtK2lRcUZjY1B6alRnbllyUGV0OE9mSjJ0a1g3bU5JaTNMN1QydXpp?=
 =?utf-8?B?NjRZbWViem5lSE5GcXdEczVoOEZFOWNxQkdMQ2Z4bHVRUVFrazFGTU1pTXh4?=
 =?utf-8?B?V1BTQnBIaFpMcU43cXJZNUdwNzFNUURVNFIvY1d1Qk0yeUpjUkwwVTlMV2Fx?=
 =?utf-8?B?bW81cW9yRTMyQ2lUQ25Gb3BvUlRYVlhkK21aeDdyRDJEaGFLK3hGT245aWZW?=
 =?utf-8?B?QjROVnJzZ3pWS3RmSTVjeXJMbG1VeGRiZy9EVTNTZlZiYmRxS21FUHp3bVpk?=
 =?utf-8?B?NnpKZXNwa0hubm51ZFgxRWxNR0xKa1FLd3MrNDRzdWRUUlZKaHJOWS9mRUtv?=
 =?utf-8?B?dTNaWWV6ejRoUHdoeVBocTF2R3AzekNNZG00Qmh6dXZrNUY0aVNlZVZrMkJl?=
 =?utf-8?B?QnZmSlpzUTJFV3EzYUNCSzlHc3A5VkJRcFI3OGRwRWdBU2RXM293SmhFdENw?=
 =?utf-8?B?THZDSmR6YzJJN0lLZVpITlBZTWpHZzlZT2U5QjFVRmNOSS9UU09xS2NldGFw?=
 =?utf-8?B?cHpoNEpYSmFFbk8vYk9IT0dUVGlhYWh2dnhLZ0pralVycnJJaEg5ZFppZERO?=
 =?utf-8?B?ZjI4U3BRYnpyR0gwVHRZT1pKS0QwZ0RpZVZLa0JGTUt4SjNZRHBkL1libmQr?=
 =?utf-8?Q?YIxvWSCYSTkg/gg8+7ybrrjJyorYP1MAbgsE5nM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aac61b-2bb8-4e84-038c-08d95685ac39
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 13:50:37.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSryBKrtG/K3eCzky3gDpcu4ALEY1/GqGkOCOoZzNzb5enNX71NQO9Zo4W5821jmff8YqCIMUnjd4U7OFOIOsAx9iIRDoaqAHIdoVcwAHSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB5490
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030092
X-Proofpoint-ORIG-GUID: o4ipFaYbBObvKNOASI0Z8A1gNXKFBGRK
X-Proofpoint-GUID: o4ipFaYbBObvKNOASI0Z8A1gNXKFBGRK
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/3/21 6:01 AM, Uwe Kleine-König wrote:
> pcifront_common_process() has a check at the start that exits early if
> pcidev or pdidev->driver are NULL. So simplify the following code by not
> checking these two again.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/xen-pcifront.c | 57 +++++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 32 deletions(-)


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>



