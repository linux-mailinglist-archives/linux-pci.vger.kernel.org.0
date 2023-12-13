Return-Path: <linux-pci+bounces-843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1F810C23
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 09:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819881F210DE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5571CF98;
	Wed, 13 Dec 2023 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hg+490BS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nghY6e7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D65FB2;
	Wed, 13 Dec 2023 00:14:18 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7EHY5023832;
	Wed, 13 Dec 2023 08:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=heuig/hl1ENhTzK5mguPeBYIwCZSfY09v+azjS6PBUw=;
 b=Hg+490BSJ0RbrPb1z73YUPmq+pn1vjUlpSwfkAJi7bk/lcwqGa6HdLsxA071k24qS9Lo
 IOgLcw+TRGx0lxBcAQB8qomHfyPj++pJ4zCcTWqnx7nRY2uHBSfqhECnwUqEgGNTkRtN
 qYp/wadHCBOGXC46TWz0ej4iSaq7TF9na1z7+uKZuYTNuP6q+A4SjMaTgRdTLi+n/pgR
 YUwV2nx+tIlJvBJ4oshSvQhEtUw3A5cjXtWFpomWZRgFxO1u3jgCrjHRfcaTCZfV2wwW
 yWP13LwA7BbjsUuLOg14PEcedzA6oKZ3LyQ2zJBlOBqWYxSH79I9YInNfDNOH/kXGMGn 8A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d7pdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:13:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7arfv013012;
	Wed, 13 Dec 2023 08:13:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepe4mw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 08:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJhUoRE0ytgVUWT7UEvy1wvrxVjoF8JKEO2g3YAzGwRbAdiIPCsfIO3nxM+f9FfObAAYr0jTEAA6RaxVJaHLGF7O/4467f5vrCn4lPxf5bGRNWvYuthqylxfb3YRHjdrSBlC7V1pjhpvR9milWJHksDoJxoQ/MivBmgXRDAqlUqt1Bnv2m76mrBIBCu1BiyuBA+j9p8hMK6fD1s+qqBl99p6GtrEcz9/NNj6XL2vMV+O15UJIqrLvBDtAwuglTRqr9DmvqdpYnS7o6fLDTYHIL1iqOGBFBYsJet87XpsqHqMyqhLNEtdf/XKgU/YlVAud2WZ0UXM5HpL30As8kAFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heuig/hl1ENhTzK5mguPeBYIwCZSfY09v+azjS6PBUw=;
 b=NtkMnlhejn/nHwxCNSJRmK81SxNjD4udabx7ZxRaATJEfbNy7MQcLiDQJXmoZY98CeBkxi1rC2NOHa3TS1AKGhwinL0FA6TbJ0Q155jjavc1cA/iVfkGEVMDDovNHg1Il86+BHtbwEBx7tFU2/+kQFy7Pra5u3Z0zPNxSzpKEW8S/PNrtsudVeHNGyOax1AW6izsy32H47gmPvMDD7o3YvKzhXQQ2gTrvx0/v46oUNTCQWZsTiuyKrxMZSzHQXAi2aflA/U7p9/gDrDL6ByWUrlXEVMgnjyuljabaepM/+Yx9xomij6d9EP48yjSBbRikIp0J7oq6Us5gMxUZ+PaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heuig/hl1ENhTzK5mguPeBYIwCZSfY09v+azjS6PBUw=;
 b=nghY6e7Hpho71nHeO4JTFKjwJQo7M0qmqjWVNpUFMkDE7eEolkTBhAHqcHAX9ri4tCt7JV9eaSxCmx/5hpgFmLzxRggDEk0WmqbNKbHQidaIjdUhKgjKMD8W549sXlK6xYidazGHvvE5DjjKygiNTCM8V72sDK9T8wgJKeVWTbM=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN0PR10MB5096.namprd10.prod.outlook.com (2603:10b6:408:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 08:13:41 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::dec8:8ef8:62b0:7777%4]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 08:13:41 +0000
Message-ID: <d93c4614-1bbc-3a30-305e-28ff75d7fde2@oracle.com>
Date: Wed, 13 Dec 2023 00:13:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner
 <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>,
        linux-kernel@vger.kernel.org
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0343.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::18) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|BN0PR10MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: 77058b07-b26d-44f7-4397-08dbfbb36ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3iXmHvb2+0eew6h0SLf2wnilkefL8d+EoZxIfB0x+QE1u4UJoBy15at+JDb3To/oGA8rjzayqwLY+BzAyrugPMzDWDZeeUToF1EvH8gh6X2J34Oi+oEXpwhE6zZ1dPjbUv6vHmTL0KEJ1B0sbEpNjowpcRNoy8pifHPLN1Jo5j7vTowJ71SyuiV+SutvK+lGsR8/66LE8pG1ezztllxPT4wz6Y2yeOc+5G+AJyUC6+RTTxIsVXF5xFuARTwSL4LuuUdjfnvxmGSsvn60EkRXRj5umvP47A8naq+TpfBHMW+BmS3lQqshof195LNvwnnp40MUfm4vHOkAqXoox+hZB05+hhYZ+tX0ll9GKRTxvdNWOC4w5Q20K9g3GW0xEwr7WD6ago1HN8qEIetXc2fJLhjpU5BiSaAtydjArskvCad33g0AtUl9+JYf1uKPrMO/thaLrh8t6PYvI9Q7Iay1WnFQsYd761r0Vy6UOnXE/UivYv7+zZuxM3q4D8IuOEJLCxDPJ1rZ/Torcl+YMEarAJJ5cUpt5yh4pj9b/AATzjkCirvFLKaSWRiWu/rfbm+olphmirS9bzGLt2SGhjmYIZPV5fFrA954bP5TDbHKdxBiUDIg73TvuMQAD/xe4hf8B4ilAW8Pvt/Z7evraIVYDg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66476007)(66946007)(36756003)(86362001)(31696002)(38100700002)(6512007)(44832011)(53546011)(2616005)(6506007)(6486002)(6666004)(7416002)(2906002)(54906003)(6916009)(316002)(478600001)(4326008)(5660300002)(8936002)(41300700001)(8676002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmtYT05hT1VOVmxCNjB3R3FielZXVnFIN2prSjNhYklmWWxoZEhWREp0bDZS?=
 =?utf-8?B?d2F2Qk8ySzU1TzNZYUZ0bThaVHJYUzIySGpOWWRYSWJRUmFYMHhTbTdVeWQr?=
 =?utf-8?B?VFRWTVdBblIrUGpUNlBGN2h0N3A5WmhKSWhYK3JBQTZicmc1eFFORThHSFpl?=
 =?utf-8?B?T3pmTmxEa3gyY0NsVWNTbDNUZkFJcEN2eHFiTUE4dk1NOW1SNnFjaHc4WGYz?=
 =?utf-8?B?bmRTM1Y0eTZxV2RKTDVoSkVHUVZaakFmTFJSVExEN0FDb3EweUc5OXMrTllk?=
 =?utf-8?B?VGk1WUNucVh0ZWlham56azcyU0N3L0NLQjhjVzlldnl4NDBBKzVwbE80M29l?=
 =?utf-8?B?NDl1QmpYNitmck5ra2V6VkxlZTRRNEk4ZXg0TlBmNDVCOFVxMmxDTjRtcUJr?=
 =?utf-8?B?bGlDQjZvNjlGNkxvanpmeERkSWFndmlzSVEyYlpiV254Yk5Wc0xhNm54UEhW?=
 =?utf-8?B?b2F6YWh5WS93L1pheGpjVVd4ZklGUHI4UUxHbTVOZmhnSXhmdnhuQlFZSXNr?=
 =?utf-8?B?SjhLVlZoMHpqdUNSeWZQQndNRncwQWNJd053WmNKc0VNTTZvY2Rlb0ZqbXZt?=
 =?utf-8?B?TCsvV0lua1pVdElRNGt2ZVp1M09aek44TTZWK1lRQXN4N21FRDhiWXFQU3cz?=
 =?utf-8?B?UTgwODU1a09PNmRHbU95VUZ4RUtEZ0JNN0VyaDlSenQxL0JoQTd6MzI4OGJ4?=
 =?utf-8?B?dnAzblNLanUrTGZhdlVCQldjeCs3UDlqYy95QzNoUnhpRXc0S1doU0pFWUpR?=
 =?utf-8?B?dmRhN2M5K0RlTG1pM3pVTllpQkxwOU8weElGeEk5a01DQ2dZTUt2UVRTc0ZT?=
 =?utf-8?B?QXBmMXdiRkl3SER1WEhydDJMUS9jcWxYaG1jU2NmQXBXVTBhVFoyeStWdGQ4?=
 =?utf-8?B?RHAwRzVHMytadG5FdU8xTllTK05jcTBCNjNXTDcwTzZnS0lFSk5HZ1VGUHlL?=
 =?utf-8?B?Q1kzM1BEeThkbmQ1elJBUnF2UnBka3NnWUF0MVZ4aStFZU5jZldNWGQraHNU?=
 =?utf-8?B?TG1RcllTREoxU2tNVDA5ME1zc3FwTlEveTFHeDhTSlYxSVBMb2w3Rm9oQTJp?=
 =?utf-8?B?WUNaZ0pUbU9IRWJQcmR0aS95V2lwUlVWNFd4YWpDRklMWlBvc0E0dW5IV0Zm?=
 =?utf-8?B?cGl2Y3lTWUNVaDFHbzBjWE53dEVReFhYd1lJTlZCNFlVWkxWdld0bXdaZ3ls?=
 =?utf-8?B?elpCMHZKRG5WaE1uQS9kNzNnNlJKVGk2ZGlaUzBzMU8wQk1CdHFtL1B2d1da?=
 =?utf-8?B?KzRFaFNaQmZzemt6OGVkekJuVXBYWWVMN1FBS2Vnc1ZYd2gxQ2hTUDl5M0Ex?=
 =?utf-8?B?dW9MUFFkSlFvMjh3ZzBpTVkrSFBCdHF6Slp0L2w5TGo3M2pOZWlJZjFWTUJz?=
 =?utf-8?B?bjBQMm5mN1ZUeUNCU2cvd2k5UE12Y0VUTGlkSFI2ajNYVUpCMHEwbHpQYjR4?=
 =?utf-8?B?Rzl6UWZmbTdRM2lNRkptL3N5Z3lwR0NJZlArYnFtZExpNHJ3NWdGSm8zWmpv?=
 =?utf-8?B?V0laaGx5ZjJZNkJzd3hvQzZyRXZaLzJNNzVpWlduOVQ1dWs5V21BMXlrd3Jo?=
 =?utf-8?B?clFnZHZNWEgxR3lQY0VHRCtjSm81SnpBb3ZwR3FxT1c0UkxOY3UxdENpbHZM?=
 =?utf-8?B?dGNnVXB2OTAwR2pZV2xrRGw4OGtoSGZFMC9lcldRZHFKYUFzcHh0ZUFvRHJT?=
 =?utf-8?B?NndzTmFFUDZyZkduT3c2VTJyUzJNV0ZmU2NRSjQyQjVJL2lVNVFWc1hsbkQ1?=
 =?utf-8?B?NnFtZHIzcU50WFBKMUlVem95T0pDcU1hQjRQVGttUnZYRUVKaFFCMnh6RXlU?=
 =?utf-8?B?M1pLcFBCc2NRVUo5WG5UdzBiOXNNTG5CRFZwU1FxeTRzRFl4N0ZpbmxlNW1N?=
 =?utf-8?B?ZVFGelVvQkx4bEI0RytXcldBNG1uMkI3Ui9EZklEakQ4UGNjdlE2QytmMU1I?=
 =?utf-8?B?aFRJalVDOU1keUt0ZktBb0xyM05nQ1pXS2NuNkpUT0ZaQVUxdnNNc1JRd3hG?=
 =?utf-8?B?Smc1VnU2VXp2Z1ppNlVQbHV6REcrWGY5LzZDaEwwUjlpK2tVN0t5dUxUcE1M?=
 =?utf-8?B?Rk4yK0p1ZGFhTVRZY0hLK3dVNWd6a1M2c2dpakRRMGxkL3YybThQbWw0VUxi?=
 =?utf-8?Q?9sjq/BAVLZMNLB5dass9mFd+d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hANal5ykYDqUCV8p1jQ7jk3Ku7iS2eHTepdFODQTGtH4L2qfhqmVmtvTyAfWiSsgLE4d1s+ZClmm0Vy/hqtliAfIWgUeUTLKDJsNzcbFAmkcRP1Ay5fwgf2++6vtz/ceU31/FKN8JnJEA5avQmCdIDuRpXbg4Pu80SwHJAqbVCnmFNc+jYp0fu6PhsJPAwe6q/tVRbWTN5Ql1pkTPAjGps/6wmLkFpp8bngnA/g2Kzbzp4Dwty+6s0Sw6onbXfu0pEW8+0RoRvmw4MzF2yYCfyfr5Naj2VuYH9L7xzlyogr3ThNj0t1JL/PnrU2JamzvJewU2bapru0SRTa/VTo364OD8XvHuO7oGriZzmfRlzKgWwjg0X4kb53RgjRE9M27mtF8xa64IfIcaO+p0RE8X5SNMK+cL5OfpaT2sdQvC3YLh4W8qs9O4Xl9nnYWp9M3k98OZEX8n52/PrKdyEr+enI8drZsq4H+VWFzlJXM/ef6gb4l+opQ/s9qvOW/Blca3T7jso+Xh3fsnzZfox2Y53c11kHiLCk7QUR8oTs2sSOSIi6B8U94FNoh3U77MOob6U0xzm8fucyX9h0oXBxAQRxvHT1bgfWpk5TF+uKWU6o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77058b07-b26d-44f7-4397-08dbfbb36ae2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 08:13:41.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkM+GN9wm1MMmk9h4bnVyuqJhwzB/Lh0b2vGTgoVzmYLazdNTLRJS4fEe2d6jgRhS5wpr+rPkUYDdzPeU6sP9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130058
X-Proofpoint-GUID: OjxC00Pm3sxhyGZHzaVQm72sBZu9cVpq
X-Proofpoint-ORIG-GUID: OjxC00Pm3sxhyGZHzaVQm72sBZu9cVpq

Hi Igor,


On 12/12/23 16:36, Igor Mammedov wrote:
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug several
> HBAs and let machine run. That can hit the same race when 2nd hotplugged

Would you mind helping explain what does "pause machine hotplug several HBAs and
let machine run" indicate?

Thank you very much!

Dongli Zhang

> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 6b11609927d6..30bca2086b24 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -37,6 +37,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>  
>  #include "../pci.h"
>  #include "acpiphp.h"
> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  {
>  	struct acpiphp_slot *slot;
> +        int nr_hp_slots = 0;
>  
>  	/* Bail out if the bridge is going away. */
>  	if (bridge->is_going_away)
> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  
>  			/* configure all functions */
>  			if (slot->flags != SLOT_ENABLED) {
> +				if (nr_hp_slots)
> +					msleep(1000);
> +
> +                                ++nr_hp_slots;
>  				enable_slot(slot, true);
>  			}
>  		} else {

