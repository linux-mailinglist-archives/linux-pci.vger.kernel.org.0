Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7456995E9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 14:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBPNez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjBPNeu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 08:34:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F83244A0;
        Thu, 16 Feb 2023 05:34:48 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G8Fq2R020136;
        Thu, 16 Feb 2023 13:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=lJV1Lb6/MUKqcrfPmjvRedtF7sMka/OC4stVI8dEmIw=;
 b=HYf1CesftvTMBvoZdCCvdrQ+eJHMbHi2tX7Gt/AMiHor5h0CpOuwTYDuQMIvr/SgpiRf
 +PkwgUxl7f4/uUxBJcMyift2LibnBv4zl8zrqQTgpGJ5RRQaWCNhCM1AmBlFMcHLjC8u
 T3fOeNkpbbXKqP8I/LfrUsnKEfXwUL0iI243HECKTmfioKHNKSwhPw+KxtCk4pohQJLW
 fOTislUHb9IYy3yUDn2RSoYQ6H+ZLqAXa/iElVVLDC3io8ratqevHr9/Yp1O7iPmfn7E
 sw5vIaQhup+PdE+bGsMr11qTrjipNOrZ8BsU/wf/09Ym9FNgcsdQHBV6q/EVTrRtQmPn xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtk4mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 13:34:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GC64sp032483;
        Thu, 16 Feb 2023 13:34:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8mds2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 13:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJM5xV0WrNx9SS0eRuu4f8hsUfUdBFrYkBpt/iOzzxAnprckfhoA/+YnmO/CXdySCRELj9T/Coo2f6Qb/I8+LHTY8NX2C8+zljM6xc75B1rpCQOYp7DPYi3m3t6SfMEU2J8A/8kOsVy8tpcnHaId/Wb2ZYTbK7/oLX61Gdw/H2M1IJgsQEYH9LOqvrD2HY79iP/yTwGbI6l0rfyYdTFduVCYjWW6r6XkY/4gkzOljh8Y0JmncqsnSwfXVcExacluU6h0T2vwM1X9WzHj9o+7goM2Iu3D/Z0jpTO/L00mIF+7hJazgxYrmr3v3KhUAKCNLObIc7Gu0ippfVkU1dKzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJV1Lb6/MUKqcrfPmjvRedtF7sMka/OC4stVI8dEmIw=;
 b=j00ijwur2vMhAWEHnLAOXJXKqD1/+2TFNmmk1Q9jI4npsYAU4pydQ+1fongEskUzd0QWDqTLGrD7W6Imk7ARE2QLH/Z6A48kun5CZYH2Uxyufaz7YKDNJBcA0hPgmpFVFgcQA6MivJ6DfVOo7rhy+rQidVvE5U4pQfDvltwq5yKs3WSDXvQkk6lcY53Pl/7khmhIRlySouS6YpDfL/ZV2EYceXZzy/Deygz4hxlva0SUlntw3f+LJXcj29EohSzDJzBu41hMemQumPbd7XcgIIwunsvEIsD45JqHLkX+CV/ucWvTmEGXo8x96oNonTgspkA+/7C7cyZKKWFpXoC+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJV1Lb6/MUKqcrfPmjvRedtF7sMka/OC4stVI8dEmIw=;
 b=AfjVspDHdFiWQzuL1fOYmPaCJ833thPFphrtV3nj1EK9mKsvs9DXkjByRasApfzkCAoAFSwOHOcEuDSg22aObVnCYf5GZMjPs7jxLvr27TB8fmB+zQcQi7k+1dJZUj2QCf157wj0/0waiRdJjkIIsvMxefAHM4nQTTrWH1YXYxw=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5336.namprd10.prod.outlook.com (2603:10b6:408:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 13:34:37 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 13:34:37 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out
 MODULE_LICENSE in non-modules
References: <20230214172053.GA3044917@bhelgaas>
Emacs:  ed  ::  20-megaton hydrogen bomb : firecracker
Date:   Thu, 16 Feb 2023 13:34:30 +0000
In-Reply-To: <20230214172053.GA3044917@bhelgaas> (Bjorn Helgaas's message of
        "Tue, 14 Feb 2023 11:20:53 -0600")
Message-ID: <87r0upvimx.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0933debc-3334-49f9-fd3d-08db10228c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9Xtp4tuea2dyEszIayhv64XXdlj/yuqqbGr8BfEiPRYTdZ7VJoELQtlcRzv2VeqY2PzYpogIIb2yzAfCuc3p/+ApeAhsm8tTboL2UkpyC63i3WnZSp+mI6yxkHbUgj0XtA1nzapv5a0n3B+Xp0Wznkll5PGMw1iHPq7MgzGhLPEQyc8dWhukUxIALAEB4fLi39OrD+dqpoltIJrNmWUcCC/MvYj3RyBJkMkVPRvqCaQh9XOrUoB2lwq4WoL0KUv3rQ5gYZcyreOBVEmd4LLFn6Eec0qGrw9vdqSFt8KeDVdsUT0+cY5Ofy8lnI1jgLZOKA/LjLQTdzwxBYFul1rccITbcglHQajB+Nu1KU05POq7swkIERUTG3zX9kEF8tE5Y1TIZp8htmIqgXSSdc5kuJuyq06DqNbQnIc/+x2BAukI53qXz0qiGARugHAKF652zPBc6jWsQ94sUi9GevUQMHaPXGkAQzCz8shA79MdrK57nqOIEPAhGCJUWczInvkxKjFzmfshAFZpcqSk8anwVBxR2Fj8PxnX2n6WepzByomfHgTMU3+WDjeXuknUbCgKvyDsSFZ74dG/pHYyakyQE/oEnEdDhkhUJ928zuBIm8f2M0YLUWLr9jU1CZzNr2WpIOlSr6MGdH59fa1TQpiAesKD2gKRTHy9+bkDzAfyyMqgeflFlApwEtcrYm8k0a7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(2906002)(6916009)(4326008)(316002)(8676002)(66556008)(66946007)(66476007)(38100700002)(6486002)(478600001)(966005)(41300700001)(83380400001)(86362001)(8936002)(186003)(9686003)(6506007)(6666004)(6512007)(44832011)(36756003)(5660300002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vtwwsJaqbznD5G+HDw/9JnHkw998tVfU+8k/JUcLwF5xqG+lDB50FN5rTAef?=
 =?us-ascii?Q?thRY/T9y82WGYNQhVq7U0gNnhrdheSjbsKXRD6RyXujDncpor45fd3v/FDJ2?=
 =?us-ascii?Q?kauo7zEL0ynFv1qyvxBAHS9Oe0DTP9Euv6iIglLY8psxO6lKrK1yeYwKB89T?=
 =?us-ascii?Q?bRKC5qiqs7wKz7fi8XKRZxRobkvNNdGLmpS1/5fo4sf16QXcgyOE1zgRG5Fd?=
 =?us-ascii?Q?+GWaZIiuGEKTW8hH1OoZPomLyV9BaIl7TqLvK35u3Yhsq74yvxjpsY2mLo9S?=
 =?us-ascii?Q?Juz8+BSz/r58mXtvkE1kYY0PfykF/ZFG7nmb71vg1jTuueMNRcExpV/xUk/M?=
 =?us-ascii?Q?nAZfr6bigKfIkpm64X6YiEYnNKVjurvT5kKh9mVj/mol+ozHsXG8xXe+isgp?=
 =?us-ascii?Q?gaxK9Ar/BWko81j8AdPpIIwnY3VBC/0wJBOIn/em3XJRaI/epl6ug6yr2qPp?=
 =?us-ascii?Q?IP49DQtT+yzmcvxO9nxGp5k7QgmHCLMtvz3qZR5Y1Oo7SawiXKS3DVlwf+rg?=
 =?us-ascii?Q?y0PURT5wCGUumn1pDRS/PcLCUw8cF9QwkrQz2KOJKvzAn+N6NtekW/a0P+ww?=
 =?us-ascii?Q?ZN25DdoqFcXLjnkrLD4AeKDiCkCEdCS4oaRas7rmZevwpvik4uP+ndoMS+03?=
 =?us-ascii?Q?miurLEX2j+5tyFprKBMUFaoJAMoqvnPXXxRIfTv3t7ZtNs1OS8ORyyZX0KOX?=
 =?us-ascii?Q?hBqpgWhrP5IRDWyvKbDfC0ydoBCeQzspuI5XKW2nKNfGrWcx8qWrLkzz4AgP?=
 =?us-ascii?Q?mGGdIHXDExEFlwgXRgMUcR0gZ1pebPFs1bQ7R9k5aCa5Gm7pz8Z7QOf8M9uQ?=
 =?us-ascii?Q?1WCcnOkPXjZg9vUQE/mhUA6j4dJrQgPuRiBzcNUZXI4KU2EflACcUFbNg/YS?=
 =?us-ascii?Q?4mgoNuSSzK53k8L41f22P5Dc1d5DKM8CADZN+9f2No0icDCLz0gIpMP2cp44?=
 =?us-ascii?Q?8R5cwVKDaIYYq6xmxQw6BO7w1NsnVgHHfNUZ5SG4TUT2cxkT3q4D9ciNopuR?=
 =?us-ascii?Q?ltiSrFmWJn5CuILsxzMK1Ybpi6xc/8yKV25Z0WDGvfp+/FwNAEkJBhA7DaHy?=
 =?us-ascii?Q?D5wvWtbdWdSN4Re4AT8uQDDb50GEjPxYri8SSIUBOuieSJHUI+cxQMLdG7ic?=
 =?us-ascii?Q?UQrh3wvmWvMABYeTv1n+8xMAXwBUqNuGpLKwR+Xd/YlTBjHHy5x8LT/G6QKy?=
 =?us-ascii?Q?JQSfHqiMY7ouXMsRoS0VhzCR3HVJjqcln96oNc5vjD94iGv6+LdbpzgcIT7t?=
 =?us-ascii?Q?CuWyjXilnhHIhq4gl1zP5RWsvxsRTmZ9xBOYzENu4gCiwJ79I+qx2KyPJajC?=
 =?us-ascii?Q?uyNd921DeJTRiIl20R2ZmwvldNB8TawwUbWnALHPqkZ1+6u3FFeZGebtbPZn?=
 =?us-ascii?Q?KBVqhot4cxuUl3BVsiCNzwitDFG3cmRYpNTg6kZSMEPWTus5CrkRewd/gs4f?=
 =?us-ascii?Q?NpQ40KtE4KdoYhpI3gRSsPthimp7CrYDY9H0Jw8HHPI7lP8DSQBEaT7iPmP/?=
 =?us-ascii?Q?+VC1ke9ALYjcnJLhSlDqQospiDeGQrDLgwqPeEKzoFZt60dvZXB8FYVqwCLz?=
 =?us-ascii?Q?qeH+0eXByxbIcPx89xYwXLAquzshMzUmYAE3N70VWQtJb7doZ44ppMtj8EBq?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9rF2qPwB3TZGqmELBWD05flO+pcIH28zjvDbMf4R1RkM3/jUcXPd2b95BGpXQBhGdpj9KzU6zI4SLiyg9k50+lEqfruljMlxQqMr+uqjvVbxVJoxlpl/nr438ymKvVpc8NzIDo4pkCivRfQ7eKv6H9+8fpV2SUlwWBvEcNj8rhzqx9WTZ5x+rdPkXMx2dYlapedCLlClhjm4/WWbLBXjYnp5yf1zLNvRjwl+0/hWUuj1S17/kRaAKzD2zAu1xCUPxNzZWWUq6JnrvYefGe6M2FXd2TIAFmplP37rWHfzIqAc3ggZ9wEgIFSWrLn/Njn8gd40lI9O8GSukHOwkbtntZL5GLZSkVl7Nhj+wLZ4AJWfRtnEtVfO7GEY/HezaieoOIGovS2Lxu825NT1INWMaUrgcqbomz0ulWWE9W8nGlZ0Gt3M+vPFvuyDBFMUSM3GR4j5gHNFrvyBpFBGdegp5Zy4cRGrV9V0XhD/El7csqMan2P18yFSUVrENvciW9duBP1bMloZYNabM5ymLRZvapx4rS93fE1pQzckccajUSnDHWesPfEg5u+xq1EnJ53gXJ8g7GC2CoB/VQ6Npcbcu5DCgo6UMexOuM1w7MQhnK4ULcSmAgvkH3v6y/4uLHBf6BQkAnSWdOc4gLCQjXwnAiLUoJBe8gsjwozT7r0wYFHZNJRpQqVvrSUIDNOGlueZJhnwW6LpFaewu8ureKn9RDWDz/Mktz9SpImE3XAHjwHhsD+86gv3qCkHefBYCNmbSC6Vf+lxWkRq4A/W4UfsOPKCY6vwVv2ICBgJ9+x527vEhnIeaRlC3ua9eocvKSPbhorsg/5Q2T1bQi3k3NaVjA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0933debc-3334-49f9-fd3d-08db10228c1e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 13:34:37.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwfJI61OtD3NRns1l96+Zvf1ebtHAzX6etFCxoiFH3T8ZJFy04SP1JAtK7gB54Dw23MZ1kXvswnb598km+FPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_10,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160116
X-Proofpoint-GUID: UzHdZ-80IUnWMizFt62cVuABqMZq3Dz6
X-Proofpoint-ORIG-GUID: UzHdZ-80IUnWMizFt62cVuABqMZq3Dz6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14 Feb 2023, Bjorn Helgaas uttered the following:

> On Tue, Feb 14, 2023 at 03:41:32PM +0000, Nick Alcock wrote:
>> On 13 Feb 2023, Bjorn Helgaas spake thusly:
>> > On Fri, Feb 10, 2023 at 04:47:42PM +0000, Nick Alcock wrote:
>
>> >   - Please follow the subject line convention for each file.  They're
>> >     mostly there after dropping "kbuild", but do capitalize the
>> >     sentence that follows the prefix.  The prefix should always be
>> >     "PCI/<driver-tag>: "
>
> I misspoke about "PCI/<driver-tag>".  I use "PCI/<feature>" for things
> like MSI, AER, ASPM, etc.  "PCI: <driver-tag>" is the usual pattern
> for things specific to a driver, and it sounds like this is what
> you've already done:
>
>   $ git log --oneline drivers/pci/controller/pci-versatile.c
>   6086987bdeb5 PCI: versatile: Remove redundant variable retval
>   b64aa11eb2dd PCI: Set bridge map_irq and swizzle_irq to default functions
>   669cbc708122 PCI: Move DT resource setup into devm_pci_alloc_host_bridge()
>   d3bb94d06aae PCI: Drop unnecessary zeroing of bridge fields
>   6a589900d050 PCI: Set default bridge parent device
>   79cbde56f98b PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
>   3cf0eead9fb8 PCI: controller: Convert to devm_platform_ioremap_resource()
>   a4b21b858b56 PCI: versatile: Use pci_host_probe() to register host
>   331f63457165 PCI: of: Add inbound resource parsing to helpers
>   2999dea8e94a PCI: versatile: Remove usage of PHYS_OFFSET
>   f9f4fdaa3509 PCI: versatile: Use pci_parse_request_of_pci_ranges()
>   0018b265adf7 PCI: versatile: Fix I/O space page leak

Oh good, that's what I was hoping.

After a bunch more bugfixing It's coming out as 'kbuild, PCI: versatile"
now. (This seems better than 'kbuild: PCI: versatile' because 'PCI:
versatile' isn't a subsystem of 'kbuild'.)

>> ... If the rules for generating prefixes vary by subsystem this means
>> I'll have to fight through God knows how many annoyed maintainers to get
>> this incredibly trivial change in.)
>
> I think your script generally does the right thing, and it's already
> far more than most folks do, so thank you for that!

Heh, I knew it wouldn't be time totally wasted: I've saved time already
on account of having had to redo the individual patches in some way
eight or nine times by now, and being able to make the changes in one go
and split it out into separate commits after that was definitely easier
than the alternative.

FYI: the splitting script's improved a bit. it's still an undocumented,
uncommented horror, but it now supports arbitrary regex-replacements of
"bad prefixes" in a file prefix-transforms.yaml, for this run containing

treewide: ''
fix spelling mistake: ''
task_get_unused_fd_flags: ''
x86/mm/dump_pagetables: 'mm'

I stuffed the splitting script in
https://github.com/nickalcock/linux.git mass-split (as
scripts/kernel-mass-split) just in case it's useful to someone else.
Definitely absolutely not for upstreaming!

(Next tranche coming soon, the previous set again -- improved as
suggested, removing MODULE_LICENSE instead of commenting out, etc -- and
then another, bigger tranche inflicted on a different subset of
maintainers.)

-- 
NULL && (void)
