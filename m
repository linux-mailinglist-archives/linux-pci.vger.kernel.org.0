Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1F679F626
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjINBI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 21:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjINBI0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 21:08:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF52D1713;
        Wed, 13 Sep 2023 18:08:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DNMm2D029751;
        Thu, 14 Sep 2023 01:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=p5GAGXQUiC9AnxpCwHxTP3P/JC9wY2tcgUja2oeJMpk=;
 b=i/a+tzrS7tVxwOQ1lNprwVAT93YLw7IWmTEU62JHs0q68cirEf1GJud0i0//Q3tHSQij
 wDIL6+F0qlOOg2U0zmN6JemYIk13s79KisDriKee7eWsir04Bfa9aWW8FCCvLCe7nSOL
 Fl7U0182XOcrvX7HM4weLD50KV/4iYYZW+QiijCcHpx9DdSg+XYsK9znx/ZtTplHqlkx
 L58eA+Dg/uTYn0mPEB85lWxaXz3SpN69bFXDXBnni5YbGR9r69ebzm9DuSrzSQbh6gyS
 YvtxsuotD+sAU90euVX+mCBlvSb3lpDzoMTDYNrVbJl88uprdlqeHqxzQa3YVSTlMgqe HA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rbp2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:02:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0j53b023016;
        Thu, 14 Sep 2023 01:02:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f588nht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp7m05GrY2lrvJll/L0WljIkcmWpGExYtQ4ZuHysSf7zvOxWmv9vN0pZTjH7URAouIz9Mv4YF0ZOLL2yTf4b/vbdZativrFPXs5tvDRcajbnFAeazfG5xQ0qyHaoVYp3Im9gqUkbf8dh30ghZvARcDYVV7u4czAGsrakLOnLYdDLiM3NMEARi5oxAZoPIoAS/ztIGoQJ4F3ngdGghw36+wRDjvsvsAEzd5yiPkHpObnysVPziIjcdmUSynGSm44ozx/BDamSNknSQ0E8IM1wJhJukBwBeqNeGSdSz3PCl7ca7VkGoOIf3OFbYhlYo094lRyPneFyfOI+Ly3fCEYKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5GAGXQUiC9AnxpCwHxTP3P/JC9wY2tcgUja2oeJMpk=;
 b=FBAUtIYOG6oCrLuZ40BqosUfHy7hsYZ7xieqdv/izzgPFpHVY+2NxiL+lCXwFbgtYaj5PM2Qo65p7pIqB9+ACdjlZUzYEqIwQZ7SDkgFECUaNWy0g/SLFfh3CEHNlGly55bOcaxlPAbLij3Rdq0DlkAodMbbCl4Kv8HZmMmQ5Ut57n6OJ/y2MmNl18edgY0sNuDxrYBbHgjr2tZ9aMeu9473UG2I2QpMt2DROTlyzLpKu1P9/fdDpgruWh0MzMjOPAdG8R6wwIc0bMJiB+heGJBa7SPpibS08NLIt5jToqpZ1CW6WEI8XJeLgEr+P7XU9CQYK7q7SRFHXaNjfhhQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5GAGXQUiC9AnxpCwHxTP3P/JC9wY2tcgUja2oeJMpk=;
 b=novfilStm0od2B6yGt4MDHjeAbToUjJWNtlG6Qek9vd0Vnl9zGZk6nj0fljwlNRdBw5oqvfl09NeD1cqtFUn/p6VaqGqpTNZ38Zqz3i5jgTEzqBn/6GNbW/7Xjmr++wtnQ9+eMer1yoDAFsLKZAL7I4wf9e37qdeMFepfYCTZZk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Thu, 14 Sep
 2023 01:02:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 01:02:20 +0000
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bradley Grove <linuxdrivers@attotech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] scsi: esas2r: Use FIELD_GET() to extract PCIe
 capability fields
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edj1ftyk.fsf@ca-mkp.ca.oracle.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
        <20230913122748.29530-8-ilpo.jarvinen@linux.intel.com>
Date:   Wed, 13 Sep 2023 21:02:18 -0400
In-Reply-To: <20230913122748.29530-8-ilpo.jarvinen@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Wed, 13 Sep 2023 15:27:45
 +0300")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e8d9ae-9220-4dc0-fb8c-08dbb4be3f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNzRm4p+sLnAnhYleh3fvIvmUc314JL6guiZWaitp1piY6psRm4IKF1AMX1cY6rTASpNtMl2hwCp/gl/AYL/YwAR3bUWTR/JL/lGxFcWwVtO6pABbsEjWKVEJ1esjtppiQWS3evpbXi7XJlXPRdBa9mSeXdyVuDfHI+Me5mSE+0ug3BQBM1xBR+0fz5iqGkVjXCS8sFGWILyYqlc/12ZDVM+nYaSY+qiNnSnD9rkfc6GvDb1Rq/6ZilKBUf+NsaVbvNdd+z1XPhOGrgbIh4ttZ2Pgtc24i7LiTnjpb9jPscCsBoeFtY9IsP4T0w78FhvDzydQphhMwi92xqsGQNllu2rvksfqyXMYdOw/IBAOjl0bo5GdVSSp66aeOOiKCt4TSx50pnI3D/CHAwixyUZRDH7kfEXxniuaIv0psT47tnc02onyZ1LBYvby3O/e0aTJmRmPKnRVWClxtLuY4DrPDvF3mCF+S8eqV586ngHwU7R7eeD+f8JMYRLLqjoqgnB8KNCUe71f/0Rebe/Q4ZXf83pz+96H/k/gDnMBxe6rzlqi+C4O+NUkVP5xNrT+Rhf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(1800799009)(451199024)(186009)(316002)(6486002)(36916002)(6506007)(38100700002)(86362001)(558084003)(2906002)(26005)(6512007)(478600001)(54906003)(4326008)(8936002)(8676002)(5660300002)(6916009)(41300700001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hpvj8JQodP/LehZ2dCmR8PGLSZTFH8Y+dBtwGPxPe1WSJ3u+jAZy44MmOR3L?=
 =?us-ascii?Q?+ix0qvsoYddhgD8DMrcFta/SFTSvhVjeZm2VWd0Hifg7JreGi6udmLBdF6pM?=
 =?us-ascii?Q?plfLmon4PH9kiJTvV7itI+QbAYzld52eTf0asX2QdrIxM5E3M/t8s8QLGJrA?=
 =?us-ascii?Q?jjnE1Ieaw7JBUz4gX5Jo+hnE4BDYrpGcsyyvPW0nzchrsxBvIioiPyRrGA2N?=
 =?us-ascii?Q?gSmAC9i6qm1qibv1QdEwTA81D/kXbmuiCyGZopIJsx0Fm3WCMRxvK3/18cFp?=
 =?us-ascii?Q?BJj8hOgPgFO2hLLw+iO7L3k0vx1RHyWIaeK2zG/5aeK+oxL92MP6O1U7a8ob?=
 =?us-ascii?Q?1t2nPQ5im83JzfEXayA3Wt5ufNnoKcnuNZYy3ovdlF2RAZtFtWcaCylgvpCP?=
 =?us-ascii?Q?BfBB8wNY8YExIO1+Y3ChMbM2r/RT5A3Bz4DA8LrtEMqCinLdys3THuV9hjR5?=
 =?us-ascii?Q?5V2JOPOmU5N43JZm7mwDYc1UwRHF7Uz5uK/SEOrLzLKKAcWvf+u2gYXhsu34?=
 =?us-ascii?Q?NWpWMpzEl6vfovmkjB6WJNxYpIJfVRGF66jR1ZupCgk8pKFubqWoXCXVgPeA?=
 =?us-ascii?Q?0k4PZM1FMNA8rCDdUsHOUa5cw26djQ6Qv+5SQpOdKgO0KMzPkhfydRS1ejpC?=
 =?us-ascii?Q?rHh2Kj0EmCXJnmxrPKROm/ocZl0DZuKqrX/No3uXsBkZ3lT6kLBnbLojXXL8?=
 =?us-ascii?Q?+GFXC0q7q7ctPkcG+4vXV4Fw2NGd0H/sCYNjvOdul/EiGe6jhm1SKlfEBC70?=
 =?us-ascii?Q?FETqRPXUSpqXiQC1oGopsdCRuAVhqihf1oNM8sborr8U7JAhBfl8w8fDqYhV?=
 =?us-ascii?Q?wwJEk+5VoVa1HxiDYIXBGxgCfNwEZoiu79G0afPAkHeER1xInQRsL5KPnmRR?=
 =?us-ascii?Q?wi9woaJZ+Stk7DE6TxXdCPhjHmrpoe8BcfEHzl8VQ5ZqUdeVqRRtqpMDHJzA?=
 =?us-ascii?Q?mXSG68BZQnEglOLFuqGHoFLRx5cqMLXpOsUt7buFTZdP93Lk6Fw9hqPOcNUG?=
 =?us-ascii?Q?6cmTl5mFZh/nHpduXIFErYff47X+EQAjD+cVJog2/j6BM+kk0vFRWJq5BRVQ?=
 =?us-ascii?Q?+oT/hV4BjGZCohitWsAYQYYHNQEo3RZPzZUDHYSOq0FDeON+wn3aRFP3QPLM?=
 =?us-ascii?Q?yYGr63vSFR8HAQvezq0yvkZfk7ZzKujY6mXSmyBxiSEQPa0o+ONX25YPI3Gj?=
 =?us-ascii?Q?1VVimKmJE0DJHbYhvksHbfHAq1sfttSc3bTRbBAhxQxuTZ5nKXOeIet6Dv6i?=
 =?us-ascii?Q?2eiklXeSiIFK0kpsJHaD3qykk3vD047yJHjH07OgqM+INApfU2ohq0uZ6H4a?=
 =?us-ascii?Q?1WnB9FQl2nZtBIpyj90JdIHD4ltumCaGkyOaOcWmkM1b4VKBm2I5GRk8sTAV?=
 =?us-ascii?Q?d3KwQ3T7Ze7fG6mixSydrDG1h6O1Rejf/YxbwohPXN2U/Rtdpqe+Hkz7jYe1?=
 =?us-ascii?Q?tP9y1WRiiBDoOoR3F1kFNF6tDskDmhdnwgCuGfxmsYSysCNhmf3bBtBjnktu?=
 =?us-ascii?Q?8Mn1sKCVDgX3RBsofeVEE11DNgumHiEL/5zjJVrmBwlPTonrvIoqXs1U1vmH?=
 =?us-ascii?Q?rGLZXG61pKWzs1lfNh5Rn/eFgVVcOf4351xN7yPmtVUeyoo2SneE+i0kS300?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n/vnF5xTXCgpmLRwx682LBdP1qZRcwOH19k5e+U0l5MmLeX4G+vSiJs9P9aX?=
 =?us-ascii?Q?iM+21HSJkyiQjXd54NLfWECGH6HyHj90oSFLoU7Q0htDwSbV+puoL9vsThPT?=
 =?us-ascii?Q?bGws5PAleqfCMk2bvNdsISfJTrPk3pldggZfS+dhH0mlCdyO6S0xM0qk/gr7?=
 =?us-ascii?Q?tLo5BQ91VBlAdRASVW+31YSTP7GMQxWQWRNho9AJpogTPmAe1C2B4Q9igoiL?=
 =?us-ascii?Q?yER3t5xdz3fiXhQuyOxTklSRWyZzjC6ozCz2A7AQeScPCx4kiFow6eLwwa9C?=
 =?us-ascii?Q?3KKuDHx850nLzLt7M0JS+fDlrINVO9geadTE30EB5jOOdNJswKWgY3HOU6Oe?=
 =?us-ascii?Q?aAuv36wAFfD0DoeBI+KOJfwC3WTW72Z0BDnzb3vnWJS4JWvRZoZE3nQOqT6U?=
 =?us-ascii?Q?uOB6xSONFKiYR/dtUdRLlW73Zii6uBGv87EVjeaEPWKrLo+daHyvk0J9Jlo9?=
 =?us-ascii?Q?jBmnUFs6vTMa6KXYgZ0eqp+Vj1eCcYzjJVKkgeNwnZW13IH6/OYTRXunu5xn?=
 =?us-ascii?Q?anTx6Sua0dOazMhKtPKYQsOZeLLlMHvCx095+kjM47gYXHxEz5aZyPy8SywE?=
 =?us-ascii?Q?NL2+XDkIqYxiAG0vD6uXrWUdI0AJpicG0Ohr04Ej9GSI21V+PGQqimoHYhw1?=
 =?us-ascii?Q?Qb+jDI7fTgS0ZDdKX72OabgnxlVQYmcHikN5nrO/y/JrqiIGzZWeTbfeVj1X?=
 =?us-ascii?Q?ikUqvSs0VnYUq5oELEYZ94wX5BpHzWkPdnX8gmWWwEO6YPccem8m7mv2r9mA?=
 =?us-ascii?Q?Du39tD7tBRIKgdeHntqlkoLVoPYXMerGsXYF7QXNvybV47SpRnqDqbGxrmKw?=
 =?us-ascii?Q?fUfun6D8X/kpSwsVa5JKF4Ny1/md+yNehejVB7KmKHUeDuApP2YSTileYsu6?=
 =?us-ascii?Q?o9kQin6Vf972UCp1OKrnZTDpCjQvClr6E7QZZMsu2y/jc4pmSjifVVdywBlh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e8d9ae-9220-4dc0-fb8c-08dbb4be3f7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:02:20.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51xeNqgzo5v3sRwFe0POVni4lqszuQvdzKEPoUEtFXB0G1SMYR+cnBUeHYhXLd+Ap4FufPi6CkbXAPFXdghr6fbHl2Bls0itv/SOyBbq2tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=891 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140007
X-Proofpoint-ORIG-GUID: zbJAV9oumKP3jFoQyq8pulF6rMtiCUG9
X-Proofpoint-GUID: zbJAV9oumKP3jFoQyq8pulF6rMtiCUG9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Ilpo,

> Use FIELD_GET() to extract PCIe capability register fields instead of
> custom masking and shifting. Also remove the unnecessary cast to u8,
> the value in those fields always fits to u8.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
