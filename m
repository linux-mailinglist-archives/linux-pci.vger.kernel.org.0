Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55B6998C4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 16:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBPPZA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 10:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBPPY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 10:24:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E384AFDE;
        Thu, 16 Feb 2023 07:24:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GFOOcD000473;
        Thu, 16 Feb 2023 15:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=ryStAk6SRsTDT5EKlJ1iOSteurJrMonAhLJs0qDVX8M=;
 b=yVHXjluyMdYtbFeFJQMRgrtgylqZnp34Wi0lv7Osug7exZL+0oTc42WdMu9T57OERFjd
 nQeoVGW+CeOVrAUD3nOmyyQXeE1cYubprQu4W0Vg49LbhkZYsGt9kEkFqbK08wbywWzg
 kvmTi0hZa0SngE/EUlGGdmwwf759PLJCOrgdzeBTJUfPgc3Zn/lHc8ylqH5CaIXY8BZP
 oar3bxHX4CYHM/SJJTIyGFAkmpmJBXcxt0OCsRdVpJSRznAsOcFK4QKfdMLPa6AJG8Gg
 vMCGp4wstqYtuNEG+njQHweRgOKdIUDjCNy3vdFKHH9EBJtJetOssPZ956LLWnLAO0dQ +g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3kcng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31GE9B20032483;
        Thu, 16 Feb 2023 15:24:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f8rytv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 15:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLKRTfaLbHv4oAq3k8YESRXXvqn6sXTkARTMdhP0W3shFoIG1RuDPmFJZCqasB13f3kR0a4Ukn0izig9Tzx2/eQKnlA2KJAbI/hrX2bn6qUJNTJMm2RG8MlfuUh7THyujHehdcPOLPMRYGiopPTlL/UFqvF623FEgqussA+Ih1WbIxvCKpQ7UjG8YoX5lhH3DUdrX/Ghmcv2Es4wgpgT5nKjoOauQptudm23aJSVSrMr7nPYHcLDnNCMWlySibOmM5lubnM3pjwe63mb/8HOzeFNp1Vmw/h1i80Z9F1i37PuyD4ZYQ5n+67WdJhZ51NvQzUhRUsmyyOMCIe+9LSm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryStAk6SRsTDT5EKlJ1iOSteurJrMonAhLJs0qDVX8M=;
 b=bGC3i9qLQBF90H/FElAobQ1ZYtcTY8i+t1PibuX+n5x7OUh0l/ZPTpFwIL5m4hl64l0kxpRl55c8+yJbAuUcahgX+8AYedU5YRsTFmZ+XFkljoa/5JtFRF60i/qC6aNpuSM/EpNpdCY6l/N2AyPA0uBpjILwC6SoDn76c19YItBMe2XjN1U8g7VNtGsbdH5huUg90CLtcvxBoWPtlKR/XZcImgSANoZPU5GaMYaj39qSymMDZSduDYxbMgEzX3Low9mLaCgwgwGwgyQvgWbD8g90w5pYsVjL12gUCKQDnBrQYa6gpWXSmnEuKn2VCSP1dWccMLUUcX2TFNgqvc9trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryStAk6SRsTDT5EKlJ1iOSteurJrMonAhLJs0qDVX8M=;
 b=T9uUX3P0pSh4dS7lPlGgy0ALLqk52vsf4enwNX3vAjFvG3q2dmAtMEZiNM+hTyhuPHnDsjqpXRSuXl+FmZV6WQZz7HrC+BM/14BivgnMUjWO7ja28p1f0MU+sxMWHNYkVxsfJAntoYZqQ0Nv+CLkjsOmLiGbqGkkpUWOfJzkTiE=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Thu, 16 Feb
 2023 15:24:35 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.006; Thu, 16 Feb 2023
 15:24:35 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/7] kbuild, PCI: mobiveil: remove MODULE_LICENSE in non-modules
Date:   Thu, 16 Feb 2023 15:24:05 +0000
Message-Id: <20230216152410.4312-3-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230216152410.4312-1-nick.alcock@oracle.com>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0537.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a890a62-aca3-4886-1b0d-08db1031e8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgUIatp4xydiK5D6ljTAsdyvu0GuoaWLJDWH+zMOYEsTLXgDkzv5GcYyXW9Nd2gVkodS+5zLhctMEQ6+cQNzYK7GOhcP3Vni5ZARe6R/AkhC83EPz/u0Fy+dlsWEDP+iyLv5R+Cg3WdJYqqlaos60CSDP6J/UB+gDjgQSXLpLxJ3HhJY8jZp0AnQxWMqH8cGsqmK7dFQATG0JLlYmanitu1ym9ZLik5mosqV0A6pXQfxKNr5z3PdtCf7OHKOQ/rR0rVjQHo65YJNzJVSbsRb+e4jI4Fe2K1ElMXDM7VjMfDd+JmyP5SBnrkmO88Yeo4Kb5uA1ovLlQAN9wZfdRuH18Yx0fO6u5aB02UuhcKQYEbwmIqr+2VHDt9i4OmT16zFT3ygva5RgsQXhzb5EPmCTaQe6keWPVQgDyqalGQir7OHCYKMEHyouG5NuPFpundgz1EDwgIo5MZjjkcwpln/2Px90xzdDrUuBGjnxjPTwpCMzdUP/N3aKlN6alWtTtnvaucqgGjfxOMvUi/pvDSyMs2UCdN82Jl7prCoD4NV2ACbrmgEO52gHOqawp+vY+3qhkQzJ5eA1Oxx/xkKO/VGwe0C29MvjXjiBzTP4ilOFeC+SxQfCR2NfRAbMzBJUXUmpapDz8Fq0q1+M1/DrNROQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(5660300002)(66556008)(8936002)(44832011)(54906003)(2906002)(316002)(6916009)(4326008)(478600001)(8676002)(66946007)(66476007)(41300700001)(36756003)(2616005)(83380400001)(38100700002)(6486002)(6506007)(6512007)(186003)(1076003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ES18dhl0z1ky/Wh31phV6chFYpjt19iVKz9pZO0z6FhVOph3HbvZhqWp38M?=
 =?us-ascii?Q?YjJiFai/PAgI8tGVTNgyePAy/4ajH7Y5YtULLqqACgYsWyCjSbKZwY0hYNBW?=
 =?us-ascii?Q?fuoEPUu/3rKQJntrmPLd8R5Gl6IOesr8JgUCEzyn1gUg4bj5hIQHLueUwm8u?=
 =?us-ascii?Q?23wbAp8uf+59yzFdLLUErpQm22jiP6HR6MhriVQQ20Xc4Xa09SOskKl34lGw?=
 =?us-ascii?Q?8E/JT27YxJtUoff0WUHCdETvdN0l6RS5px0/kzuaLTBd2FPWujvc1WCTcxRk?=
 =?us-ascii?Q?kODHvHdHlXYUnswKEogsoAucJEUyH3V7g4oUy6/jpEAMWUeLfe2wEfoK9KA8?=
 =?us-ascii?Q?sLhOFUYhNTn7+xi+ZxCEKR7lWYHQen+iIb37KWxYDzjUdFbPFUTlFLdU0fcF?=
 =?us-ascii?Q?5CLOdqftRMw5+QRrZ/u0nvB7AUmLvMPwTTjwusO/IbrvmrWU/vuGtyKa4zAN?=
 =?us-ascii?Q?nTHWljpnJcGqReOIG1lB/Zkw+RzvWN1RFRpsmFTNWApS73TeZ+uBoCLjDyFE?=
 =?us-ascii?Q?uWJ1gtBBO+lR9S6q6BPDNVjbmUIsZTLNjTeAfFbyXruFarHlyqeoAMFLBlmA?=
 =?us-ascii?Q?oD+mKhOQBjJKSdw/nktCw67iT+WbLIJieeVC7rHNpP+C9uVD70h4Vz24DEN2?=
 =?us-ascii?Q?ou40NGyVHYZdTEXwyaEk0tl+USrZMJpd9qWjtAyTWqFEOM1YQ6QHoMsUC7GS?=
 =?us-ascii?Q?O+uNMKRBZeEH/3v6rg10y2GsR+aEQIhHH0RHGFxqVrUpOGiJ+Hl3zu3nn2/S?=
 =?us-ascii?Q?ClJ72e0g9u7gVlnH7X3n/2I80YVRB7NG2gs/OL9BH55tUXHAwyifZh6w9Ve3?=
 =?us-ascii?Q?iGM7/0iphVDnGLvnJ5ZfSzwsacdn4QHVWv0Z4/5JN7Bb+T/IA+BLAqGlqnYi?=
 =?us-ascii?Q?Qx8J+ddTZSdOR2yTfe5gOBdjuUQyF9QJuvx5HjSi1+HUtYV/FtfqbWbQPWbr?=
 =?us-ascii?Q?oeDK3MjSyGhNvhal8gfY32XZhwEwV0b+anRUV1nq15FFlcQc1FgvUR+OI06j?=
 =?us-ascii?Q?yhQ0xu9NsNHW+SRC2Fk0JN2VIyr5GPKDg946gEIr9ugKAst/MslSjw/rrsMC?=
 =?us-ascii?Q?T4wxj/dtypiopGeFdhjNqa3pwDXeLgGkBNwoTQZ5Y6Rt05QMwiXfiy4gkGTh?=
 =?us-ascii?Q?fJNhl99/wQOoefnb2+quADru3gLYpnKsS1EJyq3k7sCL+8S+Xsrj3pNPCIPw?=
 =?us-ascii?Q?c1B3Xe2U0EbdBNvDhCsOH2jsFHPVuy5fLn+3oXtU5/eK57cAxjonK8fmSMay?=
 =?us-ascii?Q?M/NYSiNIfgcs9vPfqsq/vKYl+tC5Q/YSysD7umOn7VE/EZWBc1VqXMAlMIlL?=
 =?us-ascii?Q?pkSQX641uQKqYav01VUhbckXI/b/8f0cpWULyKroaeW7w9QW4I3pbkf2HZ/d?=
 =?us-ascii?Q?3l0OM4dP/0cWi7/E55pbrt6oYETjk8gYC/TUDCvfyIy15vgbnDQ+0geGKCgi?=
 =?us-ascii?Q?PsecAsrqfAW4GoIQ75pum8QQoP30ylL9pv9LwAweKT6WznDOCQZ49Vbejk9k?=
 =?us-ascii?Q?nBxVBCsV+hEziqoC6f/f2lKSbWdUASUNT5dDgLxbc3vFp/e+489NrUBhH1c1?=
 =?us-ascii?Q?o/0KePvJB+64GcHvqutDa0VwH8vHu1zOf4I8NPQU1OVu9o4rHegTULcwgV6H?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +kZrLNSUu1wVC9JOqeXL62jmHBEyKE2SroJDpZ0OAQWa+hYU1MNtdH6pIjMykXJujDZ9tRemiduA1naUxYCvDCQGsjaX65+mB61MybunjRNL+DYIjcFnm7xecKQMVZb949Rr1kzejkC36xrsN2WI7o1hb5IVyzX68GouX11no6CoHOuXGpHpvH7kYzXAX/ZdP6P/0Ok8Kp1flzVSbTLwfT1NsNAulPMzGF0jSlu7tkE7fOOKPNKkGxsL06k0O9gFRfbX8SpY6Oj3gcDL5CC9LYu+cEQLx7b1IuzhOj/UAd7yWPDhxWUdwP5unbI6+r/YUeZakCZxpDVF2yVl/f7mN0XSczJKgzFeqgmwaQd65WsBdFd1eU/Fo1tgZZVt5uR/7Cni+SGt26XbCpHS9jI4DV+xwb47QBsAbkD6D9xMyX8uaommis2bPYWYPntRVCEWMdvCZyCpR15JtBerG0dirQ/dFhgwun+p1Zl+N8JoGDrD6LZEyXbbHYrlkXgxCGxf4ZzB6zVy4kadN1lqGRs9JRkgBuCgPfdvkPrEMziztN/B/xMRkrFLtWwpZmu2jN0r41dmSfVdECVzIqBlYbQa4Y7L+v4QqxquTjdDJ0bY9IGYi7FRcHwpp9QFQ7DJafnyCDQZ9y8XIJTzxI7FReKaxy5p8cBWTt2NO2q86251II95rvT76ZoOtExBiXslurW/FM7LZxMGInUm1H9LQtlAUBh1la9Fsb2Cg9MTSM/n0SxyJj9dW/n/5QHJdfWEViM28gxmfLnOA7PljoBZ8ZGAJMtAkX0ZlavYpEI53bDqPA0+5U5/WIaDt8xM/g6AMJ2mvGWHViIVqapBsq4eRfGGA/4q3YsmfSKGOFGKbC2xu0UicxE7BhG0NcJ5q4OhJ8N/mDyjGEM94PmEn/6FloxK/OxH+jjk/5Xvy5ht5jtV0iw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a890a62-aca3-4886-1b0d-08db1031e8ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:24:35.1889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mkq1M/x2cjkJ871vuEy2PFRS+aQ4hXPCNQhdKbuTupcMOQvzsIv9fStyE0bkugptfPh3kMIcX/AdNu7zhsjc5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_11,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160133
X-Proofpoint-GUID: ZXFZFmwuXlh04Yqnply_YhWv6Ajm8egE
X-Proofpoint-ORIG-GUID: ZXFZFmwuXlh04Yqnply_YhWv6Ajm8egE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
index f6fcd95c2bf5..c5bb87ff6d9a 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -56,6 +56,5 @@ static struct platform_driver mobiveil_pcie_driver = {
 
 builtin_platform_driver(mobiveil_pcie_driver);
 
-MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
 MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
-- 
2.39.1.268.g9de2f9a303

