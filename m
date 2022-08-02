Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF939587B7C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiHBLUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiHBLUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 07:20:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59E114099;
        Tue,  2 Aug 2022 04:20:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2728tBQm012766;
        Tue, 2 Aug 2022 11:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=klrys8lMbC4KW+xUrn2wLVqRw3XR+kZOhBI8RTzKq8g=;
 b=1xvijUujnY4pUxUMrDyFg1j3Qrnz+OPxUxAZsPTyAG1zAuDldwj89lsdVw7iRQ5Zh8M9
 BGeZfcm11+liOUAb2fBnyLa2C6IdMpJT5NrZioDg2+5IXLtj/g0uT/I6zJZbYWErWrNC
 dQ6TzBKFqnfH8VaEiAl+aNgb+/M3nGfdEU9bzDfaIfLUEF8KwCxgogxyc/97zKGIm8ab
 gMAMz/q/YLokS07FfW897H0RKUI14PhuW+czeOvkDrPBagiz5/e9iHxA6hFZtKpz7gqh
 LXrtttD2ojLzQGAm2BBU7f8hu+yl90DouwxLrvkUfOiNUQlsOUeYymSoWII1iNhs0gWJ MA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2c6e04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 11:20:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2729ZAZi030874;
        Tue, 2 Aug 2022 11:20:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu327ff6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 11:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gfqaf0u9AUGOvSy7FQrPtWstac4+U+WovbsDg45a9wFPTUQCTiwi+3c0EBdMvaUn1YZr3VMJliByAP9rBFXDvfp6R1WhShm21v1n+7Sha5DMCDHR7AkpJ3VS3ustIOfLVlKQuyi8HYybO4wgGENkXKs3f/2xDzMQMgdvWvQI8pGjwp2BjFkAwm4xYgyexPZxzXq/XH3slqB6yIrXpuyVe5fVotFpqa4B//vgdiCtcmREPPkp4hblS3oSQV/95qvr7i9c4wHUjq/7dLT+WQuCEmDeDkxqEbb+1SlAaO25NPeQiGZAlhobL6BF4EN9xarU1+CVue1xezUFd3F3W8NANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klrys8lMbC4KW+xUrn2wLVqRw3XR+kZOhBI8RTzKq8g=;
 b=TsGNQWJQ+nV8r4M/5yFtCPCAtagugUext0L4YJBgoiMDsQqf0sFVswDWOOOLSWV4I5jP1FyenrHE6khEO/jXboaUxqa11+wMk4gEtCGuxIPUbEUsrw2mQvBxDQqCdNa0QR6yc+h8YclK2SZPZg5kP/oATgFekgzDhtOhFPtNG7bbfWZiixFV9FkGzjyHCZ+OVGzaKqHq0ZTUoW6agxYLc/rotSHTuoT6wYqtH5oubXfTSiBVRv1/dO9WwK2tUEEX/p9bmVKIcgPA4LwneFmT31y3YEJBmBqteTtd2kL+iSkiHmMmXEMAU3f6T74oMfsOFedjXVeZ5TcWlQGnqLbD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klrys8lMbC4KW+xUrn2wLVqRw3XR+kZOhBI8RTzKq8g=;
 b=PYsGVT+2+Z+TtkRd748wTl1bJ2FwAgowrZJmfeRDQNZZP/gpL3f3+rFR+qioaUgCs9xCnH28mbTJqokfTSxOglbG5KULznQGvFTTvBb3PxyOZSFf34vkN6SeUmcMrWuiSU0VTVCBXWP9LCMAyDS4oKmMoCFajIMdmGc8qBsssTE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1577.namprd10.prod.outlook.com
 (2603:10b6:3:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 11:20:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 11:20:30 +0000
Date:   Tue, 2 Aug 2022 14:20:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] NTB: EPF: Tidy up some bounds checks
Message-ID: <20220802112011.GH3460@kadam>
References: <YuenvTPwQj022P13@kili>
 <YueoPDOseM1BGiXD@kili>
 <CAFqt6zaLY3_DKC-=NJSrgzePrDS-q-dfUQxrN9puBf0+qVNfUg@mail.gmail.com>
 <20220802110133.GG3460@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802110133.GG3460@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c4b714-a249-48a8-cfaf-08da74790224
X-MS-TrafficTypeDiagnostic: DM5PR10MB1577:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HkhfU/fZY05KMuUzqjtDAUeUrZsXJ+rH9Bh0d/h1LD3RGbQk1QZAGB1Hch8W+d7XdM4CoRmHQAAFUd3X9++5o6sxL2sMOtSpUdNNtDCqVoG3PmeRAQK7+oWly+Qdek57X4kgLneW/Dx1wtMmKvOZrkj+4lf+vN5DcVcOpqYAwihLmpASM7V/wNIbWQeQrUfMx3wvBDxD1jEGdrl04iGo2KBLbz5ywP5PlrQMN2HI8slp63ggqtyX9msMIIfHAxcYWEqWDIVNbw7xCihvTdKdPttuMlVcNjpdoCivAzl3CzbB916DAi+UJjNfyI+5MFCa/M/uWhwjgJ6ZMNHMKDtlrh5LOGbpe6jaPF2A/DsT6a+fvZme0m9ltuPuaT7c3+VnXOo0ZIkgQnXCP6gTMeAngbfh4RyfqrR5StPntRWN4jXtKDrCLAA9/qWt5LQccm/2P8QifaWz8X9FoyRKqfy9A3GhExbSdSgk5cxMG5texYesSVPoUpwbuEClcFqxvjfqq6ykW1HGxcvO/JUbumpkPuoQIyvULWQ/2lT4pG6isI3awA/ULyVQ5txD+YVDxQ9Hq5ba59BX1rUBA6wYazux1ziWhdylQx/yb1lBN0BpNYsk8GWGtW/4m0FRG2COy15SSYRP4/1ngqh4vIqwtEoauEay4eBrAvuvSE5fDFtq3k6TuRodRToqDvKWfHU2vOCuhlftDOJNc7BS0QGE2ykdu2txp1wONhOca4ZtKjN4U1D5pOOLEYODIDxXL6mOtMIwUTIS7xUBwuo2Ornoj4ejBQzfqYBnkrdjh69825YTQgNHwrEuULUWjvzgmZF6OAz6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(186003)(1076003)(86362001)(33656002)(38350700002)(38100700002)(66946007)(8936002)(66556008)(66476007)(6666004)(8676002)(4326008)(44832011)(2906002)(4744005)(5660300002)(26005)(478600001)(6486002)(9686003)(6512007)(41300700001)(52116002)(6506007)(33716001)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gfo0fSsOlUNcd91IFtQ1P6GDyhtn0iIlwKwwcYs9c7/lp29Cjh/ORUN3d4bR?=
 =?us-ascii?Q?dQ0ZCpXlAknm9s1Rkx2xIuN2/k1+MFNZ4TyvYs/Xi6DECdoSoWrO6SFdg2lU?=
 =?us-ascii?Q?Gx8qf2Lyuk7BSmRhxnGzIBqqUDiw7dRCsNtyj8Z6y6K524qpbZYvMeyKM+4g?=
 =?us-ascii?Q?lc/ZmhVww30YUKYDwVfy9pLRLP86QGj15uLbTaL6nRMzDVNM7OefKhaKVhv7?=
 =?us-ascii?Q?gVIxamEnjHi9Egv9K0SO42ydaYxvbdomp6UCMt6qX9tFk49yFbGgFTDMoQmx?=
 =?us-ascii?Q?ARnTX0bF37Wj2lwg0fsPVpZdUmH8QVWvcVdNNRC7lRT77wh1AnUSb2nXfiOS?=
 =?us-ascii?Q?E68AV6nu66kk2QlkWlftldopNBH8qJEVvZSpf4gDEMkAVw9CC8TID5Y2rDJ8?=
 =?us-ascii?Q?GF5tSynVDa6mtOa86r1PP0cJ26JdZpZTLIrcYuW3+/BY3oS9Id7lhSNx9u5T?=
 =?us-ascii?Q?pkM2vnDo6d/fa5X9g7qDZvCunW6V1P2mlTWkyS5VK8/vnveub3uGVfIHsiXb?=
 =?us-ascii?Q?2F+O1DtBJBNRoU84AZnvVTWA/2ZbolDSpmEnAnmgIO00wGdAwA4EeD3wypVy?=
 =?us-ascii?Q?7I8DxRVPbQDiv/S3As3SeaNvZM+SCOlcAH6g+lxeuV+5qmfe/8UgoUKPH4Fa?=
 =?us-ascii?Q?+H/LMkKwuj6VZK2/fLNKGKO7iPlcFUK+P4L1KSVxShwGY1VHauQuVQSEtZtJ?=
 =?us-ascii?Q?Zik9O1Bnugsfw07px5w+0sw+y7l6T7SPTclzZCDJoY+UbuEBS2kh3jqWGAAz?=
 =?us-ascii?Q?acVaUeV5RGvfT6KiGnp7Uwh5rS7J1YOlptXTWfHOLeBQ5vihGUtjwNt4/j3K?=
 =?us-ascii?Q?Sydmu5k8f2wbsEtmWP50GRHF5kriQbf5M7kQCplquWau6wSTieEOUdcfeKsR?=
 =?us-ascii?Q?+7JUgsvL71xRqa/O+WLXBdZBvmZMyNqQK4KIjeVx+SAFV1+AM9VWVnOH6w/x?=
 =?us-ascii?Q?xJNpIjTl0uqsI0b3oCN7NWArAHoWli2PgoyQHLxL/m1hAjLGwGG8t5VS8GfL?=
 =?us-ascii?Q?8YNisuUNgKw40Ca8pjo2SAMMtO1pOQ2T77mkIKC6ttGWKLLZnnYX3HC0PS5a?=
 =?us-ascii?Q?0jMaGbeSobkpg/DedLgoHO0InNDHfBrm3bdMPq2g/Y7oh/IbQIWE7nJxr22w?=
 =?us-ascii?Q?aJTKXDppAscI4qjt7QZUyLlzFJz7fr8aM6QrFHrLR9V19pFw7qcFoOlqlCIu?=
 =?us-ascii?Q?p91BXaHwGUSUJe9fT3XxTH7gVx5WLSMVZLftI0Ft3aa+GqLNKYEgBkw0/5C4?=
 =?us-ascii?Q?k8SDeuIKoWbrjJDJYHlFt8wtzUPvZOJJRu7ghCnJVhrvvVeFege9LVHR7SJz?=
 =?us-ascii?Q?V20UrZbz2uTPtS3smJhJor+GxP0yZEy93biUqjwNg00PYQiCtGaNs1YAIHje?=
 =?us-ascii?Q?aHVystuGIhk084KJq+JaR6WMIi95aPj6tDgcYLMXJMMO3onhvhgE6DMnZZzd?=
 =?us-ascii?Q?qXK3m4Ge4M1n8rnh4dxXNbp9KE/qzcXXU1QxgoNhGPEPa+Kkww7gwxcAdqCe?=
 =?us-ascii?Q?SUJvpLxjmZYarm6L6IYwHnklDXQ4TQHLiYuFTIYls4o/Ip43/WqUxstVMvdf?=
 =?us-ascii?Q?b0sa485d94tx3h73HloDIapyNUuLeezpP+6WQPGtmWF/8OOqMNgzEMp5iANm?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c4b714-a249-48a8-cfaf-08da74790224
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 11:20:30.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn2Irh08ex/6mLA62bGfv1xxYmidk+YQEoNyOD99RGlamltR0kDN5hSo+OyBQJFxjD4v/Bi/Te5AeNKzYwOam3o9yI6V/v/i46CRBFElJi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_07,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=851 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208020053
X-Proofpoint-GUID: buvD5COgT0Z2L0IEy5-V4DqVL4Ehq48z
X-Proofpoint-ORIG-GUID: buvD5COgT0Z2L0IEy5-V4DqVL4Ehq48z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 02, 2022 at 02:01:33PM +0300, Dan Carpenter wrote:
> It's the same in English, the variable comes first.  "If twelve foot
> is greater than the height of the tree then blah blah" vs "if the tree
> is less than twelve foot blah blah".

Hehe...  I had a brief momement of panic where I worried that these
statements might not be equivalent.  The backwards if is so confusing.

regards,
dan carpenter
