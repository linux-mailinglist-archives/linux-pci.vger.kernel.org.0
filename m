Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1221979F61D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 03:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjINBGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 21:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjINBGU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 21:06:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8A1BCF;
        Wed, 13 Sep 2023 18:06:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DGZgol032135;
        Thu, 14 Sep 2023 01:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=PhrOtT9oKbjaBUBwJlb3F3CQEiH4a2EsCBteVFN55Rs=;
 b=vD9BqpK83PgndiFOQyBjqmK9UK/XlzkvXgi66ugc8ZGKP3pjvEVOXBpQMN3ysexV27mz
 MeSJ6rm4HecVbRHmJZ1GOnU7mZkDd39ZJ+Y3zoC9VY4aA1qtD/2AFrdOOsr7+Ojn9L/m
 jC1QN5RgPO9hH3hvRlF4VpDKOwz3/yZvy+rDEH6WlnNNxr3MjBt033wcwZTyc9jZG4ot
 m294/WWmlUU5qomOzl66IfVwltENmj4vC+9Q9IQtxCDFPiIaAWmlTs5xho21Gxby68U1
 w/ECNaYvLXr4A5xWHSuryd8n6lhXoQSOeEZS7WB4Juujcr1ClsOZLjIdb7Txt+Y8YzqG EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7muej9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:00:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DMFNMD023178;
        Thu, 14 Sep 2023 01:00:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f588jeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYi7Yh300Q/erJdiH7DUun+lWae5D92GqoNvJ4qfqby3qlwfNaSjF+cu6uAndv5f9rzg9RiTBaPyJ0D/XX6T6DRGkYdXe60p0NkOIIVSo3VzQZH1aAE57iMFjIOgyKF7MyuWVD6BwrljXh7pRPOrA8WpYcx1o3aUEvHToZrpeuG8Y0+k1xEbDGc8lg4g9mFwUkvOm8g1X5Fke+teChmKYTjQwlN5hBGAVYqA1drBzgf1Q2chx7evrqON1aVq+c0fl/zEjNijxjyAqRCG5lMbpa3ClOhLDORg19ycRCxORh0Mm+UrI0vmU5uxFwrmX0z6GaL6wWJkxc0vCyriyNhYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhrOtT9oKbjaBUBwJlb3F3CQEiH4a2EsCBteVFN55Rs=;
 b=WM9/Lp3OADEvicFN2+1w8zVf5pq3LtMS2IyR66n8ZHdsA0irUEs1sLyAIjy63ThPC99sIp86w7R1uEWMkb+w5djpWPjXrEyUeP5JbGfUGDfiYc/gyiWU0+042a/e/JdSWQUF0+vytoxxtabTaJB7pPj4HoJ6bsWGVOeTbg6IXnW1llPcw9YDRtXdH1VgoqCdm2QGWJD1mzg6apoYDXOXzejc9+JGxeOflZUKzlruHfI/iLXASO7omJk0qQn13AGFN5KFWrCuK/qtj7PL+k7BEi2xJTmZbl7GMEYJgqOhjiLmFuUsJGHuX14vQIMYitzMX3cckl093rho01y8IYRVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhrOtT9oKbjaBUBwJlb3F3CQEiH4a2EsCBteVFN55Rs=;
 b=YkrG0aLjxsUcaROcSub2NguKbr465w+6UNvsAAITQwdnMC3uOOuQ6lw9oSEZwVih6UF/r+T0Pl15f7QNPIqy59962OnRtZShAcMl/xx9XYEAiMCY6ss/fO+SnDqKjD9ejRA2KMskpxdzzSEqx9EDBZ/TCEB03lb/0Tap3wFDSd0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA0PR10MB7208.namprd10.prod.outlook.com (2603:10b6:208:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 01:00:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 01:00:13 +0000
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        3chas3@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de,
        ink@jurassic.park.msu.ru, kw@linux.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-atm-general@lists.sourceforge.net, linux-sh@vger.kernel.org,
        lpieralisi@kernel.org, mattst88@gmail.com, netdev@vger.kernel.org,
        richard.henderson@linaro.org, toan@os.amperecomputing.com,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH v3 6/6] scsi: ipr: Do PCI error checks on own line
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzstfu2z.fsf@ca-mkp.ca.oracle.com>
References: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
        <20230911125354.25501-7-ilpo.jarvinen@linux.intel.com>
Date:   Wed, 13 Sep 2023 21:00:11 -0400
In-Reply-To: <20230911125354.25501-7-ilpo.jarvinen@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Mon, 11 Sep 2023 15:53:54
 +0300")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA0PR10MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d00dd9d-e7cc-4c1b-0074-08dbb4bdf3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /M2HSQOas1Wsw9xzFFJXcjlREl1EVOz/2QhXC/UN+p+u1sXQGnAXN4N3yE1l4Ptn56u+mYEc9p8HcfGkYS0So+eI8tzEU1nvMX7DOr72Mf4kNoGtYPthfB/GCRpMLVX9kylewWGUWpP5fuTVrTsdYyQxUt7R21310q3jUhoY/1jfJ7C9zD5Wahs7MSsYLrGKymEVcXfNzSRwqa9eMJu9GzOWjC8WHZGLBMA6P8agf6ysP79fgNCT/ZzTLM/GYuVB/KWreyCceck+59SLRwF/k4i1VVyAAawOcVG2svTWXrjjLVoa7e+4K2Lz3GTVbhriLrB44Vk2Iwhmd12+WCHfsaYGD0yV+jPOEQjUTp7ttq9f9c1quuE/zVuXtwZk0xX6S1MMuSyIxvft+iZZplpwiXDd9OnHdK6AsYboTigeffPWMiTGoBfWON6Xiofk3V4LnPia/OyJMP6IpJteBCYBMy57FArfjDyIR6ZelepzGWNrnUc26n2dTT6G0FYSuaIDXgopUUkz8h6B0MX2zzDjT0ibghAnBQs+qLjBgwjzYOUYZyFmO+qY28dud1wERonT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(186009)(451199024)(1800799009)(41300700001)(558084003)(66556008)(38100700002)(26005)(86362001)(66946007)(2906002)(6512007)(6506007)(8676002)(54906003)(5660300002)(316002)(36916002)(4326008)(478600001)(7416002)(8936002)(6486002)(6916009)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Fj/Wj75PkA5jhOm0ANHATkW93D3BrNaRRGR9Ql/mu9Mvd2ZY/ynME01kjj7?=
 =?us-ascii?Q?3OZn8fH5A8eT1s+CWN2p5Wr3G6bXjSPVPaW9lrfICq/xHQmc6iU+Tj3u/0Iy?=
 =?us-ascii?Q?fNJnZMgP6K1t9yaB/Y59rTePrnXweCYAjmxRdT7cns35U/SmmmmodG9OEois?=
 =?us-ascii?Q?kVOd8YOMwZCtw2Da1dYS6D3a86HkjCYCToOhctNEo3sXka+uvfxTT09E8DcE?=
 =?us-ascii?Q?NB+ezoSe+mktPPtMPbEcIU95nYXLpJShLzM1IZZkOfuAbZLmdihRKmudgFr8?=
 =?us-ascii?Q?Ym1lbMxaLs8Hd0hXBLrIiuCftzAug4DJYcvl8GhIFeXrUhDv04riJ6aot20b?=
 =?us-ascii?Q?USjCUQKvt2P70BdsPpfqqnjYCLi76wOhQ85ndJJFUJnVOvRklT6CTb3PUesH?=
 =?us-ascii?Q?94uqnridUzLE7z5zYWXahZabQimsbl5G0ik8H8cZNxH0D8K8u6vSwPhnYKcl?=
 =?us-ascii?Q?tPSiLE+HFx+vE2osUVc5X+LPEayuZ4g1xk9fFVNpN/O7VUYA/p4i93R93hFU?=
 =?us-ascii?Q?id7mXm1QXfPaqP+QVVY52f0disVTS38t8Gsqh2GOrg/oS2YzD8oP3FERsocN?=
 =?us-ascii?Q?kS6aRc7E4UL51CF5uHVM7pl8SaxDeTjbMUWMWHMZNEz8/AyDqrkr0HvvuOej?=
 =?us-ascii?Q?Q2n1rKQUsT95BVCQjx5auTOcN+t8AZANmoeT4M5A1EjtxlHseHvDXExwBgk2?=
 =?us-ascii?Q?jS3wxMCf6HtsdeoMqxUVjctckwwfQXmxuZzD7/XQ71I7FaAEM8nPkUgI4Vja?=
 =?us-ascii?Q?xo3CB36CNdgA9JHaXZGBxEjCMyFDD8ZXUn5aalpEyndvcR9IgWwlTN2bgnwt?=
 =?us-ascii?Q?bMGrj+GWziJHgAE2H0beK4Dehf5b0SgdPOjc23uwPZA/Y1LVP5LQXcJ5YXKD?=
 =?us-ascii?Q?zUtV2LQFgfmxNO3kBeO8YJjYFKzQ0rgzH27QsOLOXAa/NCAz5FXPzx+q6pw2?=
 =?us-ascii?Q?ss5RpG8HAmYgrGZeA6j/AX6S5NjmjZjNRQ/xujE1zdjYa69vtpu+DimfY2Dy?=
 =?us-ascii?Q?iLnRkvXpl8+j9P5ue8p9+hULHl3WxRMnRveuY4NoYlTqokEEv/DWVrC/ILP7?=
 =?us-ascii?Q?5oSQDEOKK4t9j7XuCak2DxZWXMTYX6tSjE446158xcfqLhuUZ8+HXnmvvHMm?=
 =?us-ascii?Q?ulGRt4OQdpJNAVyGBCRVfqeD8fKdWxMKl3y8Aj5tD/thcE0JooL0D3vx1j7o?=
 =?us-ascii?Q?Ar9MTf93QCGehUWq4KfRdgkwqWabsmpvYHRE6Y5jXYrCUWkdX/fVAjPHUhJ/?=
 =?us-ascii?Q?GmPHUV1gkKSYpWDgoGpDiE1PQwtIMc/FR8R1jgrzZ984ZXAbIe3ekwtiAbf/?=
 =?us-ascii?Q?9+v53e8wxVwyM3bCmlvoznlfS+gwONySOx0no6GO3bnIPi5jry7VQaDh8Jrn?=
 =?us-ascii?Q?r71lBAZca4la3s+AHvQArUJ5DR9Wpb3xfLw+x06+9NO5Df+VUlTG6KZ1Yn03?=
 =?us-ascii?Q?rzHLq5oOpCh2G1INAFWbjSVvi9p40Z9yUzfMoY9xjVA6ThPkXLUqwGVNhQGM?=
 =?us-ascii?Q?Sg8THot/BGTDNAcKFFl7EVkU1PVO/8EZ324ER7tbVIVTNgSQ9lqomiChipVZ?=
 =?us-ascii?Q?8biybXjmrIbiTUGthePbrd9zqXySOZVPsBO3P5NIYaBYUpxYrTfgcB6hcd3r?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Bt0PnBJ80q+zt9gZNqX4vAMbg8c8mFe3OGrIMZMtwoy/nPanNVPm5qXuViTw?=
 =?us-ascii?Q?jiiJGhn7IqI/PSGEpAwFAADMP29oSHWe3wFnXjkYU9FI0Dy6sWPPJJURyjx1?=
 =?us-ascii?Q?ye9C4tR6vERKR579yfitNrQg1WL8xkPyshX4AAScdONXKJgIF6MPkWY/CBKb?=
 =?us-ascii?Q?etHyH4gVUX1N+xK8EUtmCxefk1qS+bJPpgmxzwydUnJJjXbrGw57k0StTXo1?=
 =?us-ascii?Q?zR6XFRrV5B5hd1uDuG0oTWx56AnRaR2cQE3PVx++80hTE4oaGyrv4u0R4sio?=
 =?us-ascii?Q?fFylJczOkcs+5J4XBfigehe8hw2gS7FM92U+WOYbxUsz85Bi7ZEb2T+nMkl3?=
 =?us-ascii?Q?4UjK98QzpmX5FD1XqXBu92gZltPY5+hIdyAvmf8oyuZEa2Ly17pTZCAfbAlA?=
 =?us-ascii?Q?8N4uj1agUAwVnbC6IIAGJU6how+9BbYO1RjJAg7Nrf4V2fkp0HhFte4FXXGp?=
 =?us-ascii?Q?gC/6yMWlN7jXIrVxm7y68/w2vsN4ydGMXRoivze4t1DTg/bEF4oad4gRiYPq?=
 =?us-ascii?Q?xqS2EtxxkwPbhIogKVCgCBlCeDvENstcxsDtD+1YP/V+2NThRUaxHCgiYk21?=
 =?us-ascii?Q?6waBQQNk4ecUFRS9QZEOjQn9I6CY96k0gyZx0V7wnSRBl/TyTu76sRtFeYZ5?=
 =?us-ascii?Q?f45S2wnGLmuUgRUoBnhhNaTsrgWU98UTGLdCno9AFxVyETChfaLnYZDxskST?=
 =?us-ascii?Q?fyt+gx/tWOVHNM16SnkISw286nQLYSwZJuIn8lXaScr81qC40rCu/ObisD6g?=
 =?us-ascii?Q?3VH6/s8mX9+UTdlZ0d/wyWD9FSu9g4RBNVr7qb707LuiKQIRzhgo/xXTuEag?=
 =?us-ascii?Q?vTfWI7e/UNpq71ZBQ/E4znACOvTNVPp3m0Xq9SaHy3lqdusOcDJC3Hi4o/Ey?=
 =?us-ascii?Q?Duv3+jnTsVPhDkBGXZIdyYg8/hq2GPATsJ5QwoQHVdJ0tTcCLN/ND6J3Iahf?=
 =?us-ascii?Q?FigLOtyiqW9K4XFPHkj6d/vfyaYLS6RA6ZN+qcb4pDu0Ng1xpP70Bivxzt2X?=
 =?us-ascii?Q?BuKHvQu1UM7PxjC7nIvxyVjJxqlXL2KDKkVa6sAPa3NfSAvcHC03Z0jhqb7J?=
 =?us-ascii?Q?gK3k3sJQVJRB83FBv4UfGau8iFv1WggyDb+B6mWm4fXe4LZZQkofCInfKtTV?=
 =?us-ascii?Q?cFlpTwaJzmn2oHAFo3lRibncHQzCwJGO8S34Rhs8Zv7icVa8vM3yAVyrkvaL?=
 =?us-ascii?Q?GrrT/pgrM2JpxOXtz//k7ZsJ/YwueZ9x81uywvAfxQ/admLAcjZZlHYdxkV4?=
 =?us-ascii?Q?Dvg4VQpLytO8QXP+7tSF6u1F5vCn9M5dD33ugJEnLbLoB9woE7hOdnAkII+K?=
 =?us-ascii?Q?TnEsm20L5xXOksMFIfqZc3KNjOaG3TYwohfXYphlssGciQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d00dd9d-e7cc-4c1b-0074-08dbb4bdf3d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:00:13.6925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUZaJruQtxb8vrRuymc0HaK2Ubz8mgkmoRW6GBtohsXzcc7pFKdgJxCYxbtRTOnsOco8kzh/eNbjKKgMjugGB5NfARMLybZSmaGkE6PRaIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=991 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140007
X-Proofpoint-ORIG-GUID: GcjXtN8SqpJS2w893qHm4n3SAdD57HGt
X-Proofpoint-GUID: GcjXtN8SqpJS2w893qHm4n3SAdD57HGt
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Ilpo,

> Instead of if conditions with line splits, use the usual error handling
> pattern with a separate variable to improve readability.
>
> No functional changes intended.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
