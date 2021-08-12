Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317203E9CB9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhHLCwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 22:52:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22380 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233510AbhHLCws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 22:52:48 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2ifXN006240;
        Thu, 12 Aug 2021 02:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=GpVg7CPn3lI0qguLxoJ8xVA+b6aPkMFN+Rx5cneyeMM=;
 b=E3jweK0TH9E94eJQwA3vCOp1sI6oAtq2eyzvIvjeMZiJgKT34vjGCUDElowgLWPNL20C
 D1sPRQvgwFP2NohGd7z2VN7toQYgLTBZH/FcmceMUhww+5EccSd6p845DpNf84AnZ2m/
 x4kqE+wL9q1VHWB/Aa6fXlVWJFqAo+5hFzgC45dkxzDU6xh9R9jF6BRfoP6OWJMATBbU
 ZgzrF9Cwq4SlGbmW3PgFyx1JPBPEmpqXHC0izL4p7ILvxtRFMdBMwAxpvf3yEMDsRE7c
 TVPqvPET8WkZbk7jA5RnxB553dSRvw11P3qJaaXpPPh7GEzdrX7ar7m+WYAdrNRs8XWW wQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=GpVg7CPn3lI0qguLxoJ8xVA+b6aPkMFN+Rx5cneyeMM=;
 b=rjnev+0DvvzWy0oGzRtMPR+iwp7AMPk+kZVEUvjDzbTKzWs0I4OoKa7bcsyHaB98YSyy
 NptMbDUyxWlm+gIzxM9wrdE1+mKLaPaIWpKIUDKO1m8IxGApfcT1oF922YNSovoXv/L5
 nXeYpc7xNViJ1cCE5NoqJ4xgsyO3x3aVKYVxGGRDwPv1PFDEqhUG9ebjI2YmxTrcP4Iy
 S9kmyaPK5pKL9xV1Nz7w91rSHRwNSklK/Jx0JnWXLZgaB/vys8NBaml4FPxAGgyGyPOa
 UUAMS9dZSAJKQUZTMG6m/avgHyYfKlJ9l0nLjvieEUGGMI1PymvN8y233yoYdtSI9iSq ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c7jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:52:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2pNRg009037;
        Thu, 12 Aug 2021 02:52:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by userp3020.oracle.com with ESMTP id 3aa3xwbte6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:52:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCuGpxIYJvqJCgdNfkL50jN62K6ZoRG9WqyRqx4Th8HEPVA2LM8xXsz0Mzf3NwDHEuAZ/mnWLXqJkH07kVw/WgGzzRSpq/DVtRtgdbUxHs6ZZ/4KZSSbeEprWAlNYhFQPCJ7TA5Zho5/pHGjUhS73PCpFmKxJSg0+hra76HCbUpOwkHcTrd1zxSqisHd9QbkNHWwm2UcJxacJ8vRySZjVl6B4GcJyF4H//LwqIyP7SSEjU+zQdT0OWJgRD+NVsmu7atGUknNTwhWWcSQTaSh+J6YTii+PphExkx/KLh93HNfs74efICxiYfT/PgG79rHubK6Gd/yHGMMQgQvykQMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpVg7CPn3lI0qguLxoJ8xVA+b6aPkMFN+Rx5cneyeMM=;
 b=W/DeGJh5+yhXk4593jq32OIeKGQ1hPKLxvOTSERah+C1cpYBZcteha4gG/Yvg+eKkBdmwqtQtUsKLO/fDSbq7s1CDajBrNpdmjkaelE9hsXmF6Ifz0c4oBp9+Lh4WmWELn3tnNmO7qp+EXLsJYIVLOfvdeVkcXC8GUIxmuY7dDai5Ho9NDGhKvqIGtDj3aCCxXOgyFH+kLF9KZLNM1/gB2xb4RsSdNlw28U6FdLhiJ6aFc140gYlLkhnDu6EOUna6e5Nz1Gf/ry3gs5xRaMTPSxBHHKmRIu98iDsFy8HFxVz6MKtcra4FytXrbADvxq6EsyxyTGTSNQk+Xe1fsqmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpVg7CPn3lI0qguLxoJ8xVA+b6aPkMFN+Rx5cneyeMM=;
 b=b8sj6s/OFHkt1dcB/IzbYMyCELM4cI65aycVq1g8/xgAqPMrAeJOuJF8uyXoQIZ3/APG4FdA4hn3YAtcfMkwifH4cawLx0OeR66F1fmzd0DMrPHfS0fROCwog/lDcrb/8d2mDGRwSF7zZjzyqLVbEJrqyoLa+tfFf/VE6mkotd0=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Thu, 12 Aug
 2021 02:51:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%6]) with mapi id 15.20.4394.026; Thu, 12 Aug 2021
 02:51:42 +0000
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 5/8] scsi: message: fusion: Remove unused parameter
 of mpt_pci driver's probe()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1eeaztly1.fsf@ca-mkp.ca.oracle.com>
References: <20210811080637.2596434-1-u.kleine-koenig@pengutronix.de>
        <20210811080637.2596434-6-u.kleine-koenig@pengutronix.de>
Date:   Wed, 11 Aug 2021 22:51:38 -0400
In-Reply-To: <20210811080637.2596434-6-u.kleine-koenig@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 11 Aug 2021 10:06:34
 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0129.namprd03.prod.outlook.com (2603:10b6:a03:33c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 02:51:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a07bcb-8a1d-4a78-eb3f-08d95d3c1d48
X-MS-TrafficTypeDiagnostic: PH0PR10MB4616:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4616CCD378E24B02E953AC5A8EF99@PH0PR10MB4616.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYRbMhpzb6aOJw5ixeCC+OydO1NPlvKI3UGahIiPMNuLbqzRyROws5xPIZUPQwPsiNALDFRuYkJRyYjSCOvLB4Iuw/Nb0jq/LVS9p/DmfVNAlaVFch4l6+fTUFm1XGSvSpzf8MjNhTXFC9kKim/fjMhDVe0WCWQijZ1vShI+cnbeqrLBblkrexhIwAZrAMTt0eHmfpu7XdsXAKHDcD5/8da4KKRnBKTRnjju0HJSWEhkIw22mYBpm7FUMiiF6obmENp447XyPe54Ddk7zFxojJcKVX8syYnL521AzF8NCA5dMb3515moKEt01GxjCbE03DLsjQqzOpDms9KtLpn1Q/66aidVvB2mjfS7mFB41qibQmQipM4tKCAUfV0ZCoeozqucOa9tmWwgTYp1O9U1BHqGmaAnGnp70dV64K/nyrJgjEj5d4Lqs4Fzl4SnefLdeGqNY9mHc55f2dgRMbsw/X4pNzxmUWW9+8PilFLSOg93bnblmIge4Mcbnzjyzevf2ZphD0yZMGVvgEbTkDF8l68wK9F0dDwhr+rluQPboN8cLN0ifw34ga8BiLw3dVzT8fvlx/9TZnrl5tXLIJ+Kg7fximT9WiLbx8tDuv+hdLbYxx/ys6JtCoqbq587kB+TQmglku+n79x77EQSuJiDBG1HddHSqxTXxNbXpW08kV2Wal0+CjmbYkbisWbShh98Y+JgRP7WOC3qiSQIT+KeJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39860400002)(346002)(366004)(66946007)(7696005)(38100700002)(38350700002)(8676002)(2906002)(7416002)(66476007)(86362001)(6666004)(26005)(4744005)(8936002)(66556008)(6916009)(186003)(316002)(36916002)(52116002)(5660300002)(55016002)(4326008)(478600001)(54906003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CufVEt/O6CO5DaeMIqkR3R8IHjKV6fBQwjSdL3cOf3HAtGttPq3AM97MfyBo?=
 =?us-ascii?Q?+yW/kAHHixehzizZJEI9BlIdnmKC+krRDZoC9kgZ3P+fl0mLZ0cbbgO2fkXj?=
 =?us-ascii?Q?YZTreOnspcGsVuedmB9MLJt2hTsJ4WEomnKuL1Iyzbear8u7IRJtshfnO3CS?=
 =?us-ascii?Q?ebo0HYZKRJ3UEWG14gtiXwM9FwnjVBrV7CEGGWpL5EnXWpXkAy5oy7fxWliq?=
 =?us-ascii?Q?OBJlQiRQa9+dhwAf10ZNl1CWug/D3xwMG/DinlHK7vFCaGKHJdD/yBU1W284?=
 =?us-ascii?Q?dZxZu5aFv1v6nYaOT7BDMMhMVw4w0jRu/5a7JW84YKSMQWy7ERRdNSFP6Crj?=
 =?us-ascii?Q?vasi8EdPMYogpRzTq0Se2Cbpa5TV4IsU8OtGZQBlWfpV6Z9YcwpzyOfOw10Q?=
 =?us-ascii?Q?YLiivXvN947hj1Yt3kdl1YPNUa6J79TifrzDjEzZ25WaLtKJ7U3mZVFSZgTI?=
 =?us-ascii?Q?r0hxSIU9QPpWSCAXO0TdyrKsPSWELzMj53N+RUeLp+M05xs7kQnhEbeiMM/o?=
 =?us-ascii?Q?BFxQ5kjN4UY71I886ayt6YHT278FlrgfXiG+gxk9+0znEwFwIM+64lzmUJDM?=
 =?us-ascii?Q?KVyCc6CfYhiz2k8l9zrGvmW8BWgtBijKNXW3hTxT0kCiNNMbqwW9hy4IHoPi?=
 =?us-ascii?Q?lalCnEa+i7aKpX3XLTGmNMXxlCJDgbtcKFfpDW3foFBnKbbPtEVpskfGDipf?=
 =?us-ascii?Q?/YhclGzPn5S7eF94e8Z3vfhaFztTvbHkRDbLBEzEcHRcTLX/7aRUjoCjy70R?=
 =?us-ascii?Q?ZZIbAMA8PIm3IS8ghwg9ey/+TiJ6XmzjN2wkvb2zxicYkWVBH8kj9rrFia3O?=
 =?us-ascii?Q?AbTsGePMz9fVwB5AxryzJ3FBTzUEj3U4X2GpfpJOxXgaTtU2rKVoEgBZDHdX?=
 =?us-ascii?Q?J4MCCYILvxb3SVlG2qnR2FbByDmfKs4Ccrw1Oy6Sc8JRZBATJia7Uc2mUPq/?=
 =?us-ascii?Q?AhKhsisYTyXmicjWbI6CiUlki/6YIXBISrNjm0i3Bcm2+UBBkheD7rZEE7jZ?=
 =?us-ascii?Q?UHmizB5UWCui9ScvGm0Q7pIMo1CymyvVUZGTuKexwzxTCxgT95kukasKeFEG?=
 =?us-ascii?Q?mxJvL+CpuSecAdSahcaWUvG3Q6CK52AMkJeOoqfCqlk3pyUu/evPjVG3h9VE?=
 =?us-ascii?Q?4cZLEpjG7ks+4ohfS+ZRVuq66N4sSIHrBY+Uzw0387AILWvw2XJ3seWo1a5h?=
 =?us-ascii?Q?O5hsd2N+ZKVog7CtxGNDgzxTTAMrHY+C6nNr2Fwbl1svEIDHifMpBDWo96Iq?=
 =?us-ascii?Q?YwZzDgHIHbMZrpRC6s2JWRi1LYsa/hf44Pdw8aOTlKQ+7wl3LCMsEn0ZSRvF?=
 =?us-ascii?Q?TbdAYdX9uiqGF81YTtpFnx9g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a07bcb-8a1d-4a78-eb3f-08d95d3c1d48
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:51:42.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhUYHJuB+53GLQNwunpUIfYSurqT7Wud6HKf0f7sc0asZlysG0rs1e7ECfptj8aZuFqP5OVD1Ugs+3DHotY8U8SbA03j4kQH+nNPym2dbvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120016
X-Proofpoint-ORIG-GUID: cp1Fs0cbciASeI2jPz0Dz40zSf9fklJ_
X-Proofpoint-GUID: cp1Fs0cbciASeI2jPz0Dz40zSf9fklJ_
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Uwe,

> The only two drivers don't make use of the id parameter, so drop it.
>
> This removes a usage of struct pci_dev::driver which is planned to be
> removed as it tracks duplicate data.

No objections from me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
