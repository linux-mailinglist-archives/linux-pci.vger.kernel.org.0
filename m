Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C24696851
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjBNPl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 10:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBNPlz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 10:41:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4143F211C3;
        Tue, 14 Feb 2023 07:41:53 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EESuW3018835;
        Tue, 14 Feb 2023 15:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=8tu6JbKlA+R1Y/DPkiSHIGpF+zoN16LJ+T0aS5LbpKE=;
 b=jDutuYxcG3f1io/pCBB8s3KbzGp6jKuh1kYYmJ7pqANrVuaskB3yNC0sehP0rkep5MVe
 MZX27H/YV1DPc3sLioyCe4BE8f2fe8uvQLNahpJV3JCrOPit/Fg77WZoMnNfCH6BuRNy
 Kr8NlC8emuDqp3Of+nTNvksu8H7EeFFAriHPW4kU4Zmhlj3sszyWxdRG2zhRHthyHAzJ
 bWaTYRR7blU4vmg9/5wRuIrwbUVuhaPge5yevogcoC5vxrytQB0jp0b1c0r32ODZHpiX
 nFV5mqoL52yG60fHra8K2wZ9+1unHPdWm1v1+5KrxqNtnBixus142xFREKtyrR5ZwWTp UQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3dqaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:41:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EFOMiS001624;
        Tue, 14 Feb 2023 15:41:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5f4bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glYS9sLWJZu2Nq1DtM7PY0gcoFOWmBJk3+TZ98jjCOAW9U+YcsYGdqGqCdlAI2henbPXBR7R7x6JLzyvmtK4ZNIM0/IJV18/1BhcpBZDuuTa5SNJTgWfo0fS4gxPgtE3yrXtjBn6MQaa+7Htw50w63KjUTbne66FjtD4H+YOyUQ1HpuGo1vpGongSngHmH8MLSWAVaGdLDVAXrUkRAnEYZoQWXwXgBiHCqbUk/TAG0V9jEuxBCqhJ2UsC71uDpXHA+VshzIZkr5WwcYKmVl2heHJ3amcZ6HyyW8b+4Ag6r8Vlhth4wass9L0XC5S0SBdGBfyy6V/F7hw/aWKKltMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tu6JbKlA+R1Y/DPkiSHIGpF+zoN16LJ+T0aS5LbpKE=;
 b=CBZkYe07eVYV7tYQJyuqGHkrL0D2mrnUrirTYD9bd9hNfwx3fao3z3luWXRq5yc0+OGIWJ+qCeiEXhMPEZXbO9Hmdo4SZZ1uH8Kzxxpl5GYkfYZ4jNg4IW0pB8bR9JDGIH0nP9gRbfa7HsSuc6jpyIpwBHCToyyiA7L10+wDwPjDAxIQpRipb5YnktDoD3piBpiMp96LGBSh0fQrUHibJTSiuUbz5oZrh8cspCZF2m6FjvRX4vXMeKzqRFElvBmTfm8FXMkdnStdMH9Y9Pn54fL60dqbbNM+YqGDBLhGikMKdfLtV4LGS082PqDLNW3K3YJYcdMHIyqrlC0O57xocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tu6JbKlA+R1Y/DPkiSHIGpF+zoN16LJ+T0aS5LbpKE=;
 b=PKUZFrQcgMyeGK2tGxzLthf1OX4cw5djFzpVzDemSBKwG7JFtE7DxUDqSAXL0FdCkZeOi1atPPIAVKRYAgUO7i3g4HG4K2VrGUbuxiMEv9vRiWCjoCGC9mZAcyAFlGQWhYDaDQNjEQk7gSIN7vqMWmBKd05zRA09wzXuKJZOveA=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DS0PR10MB6103.namprd10.prod.outlook.com (2603:10b6:8:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10; Tue, 14 Feb 2023 15:41:39 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b30f:e3aa:6ba:5c8d%5]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 15:41:39 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out
 MODULE_LICENSE in non-modules
References: <20230213225723.GA2941414@bhelgaas>
Emacs:  because editing your files should be a traumatic experience.
Date:   Tue, 14 Feb 2023 15:41:32 +0000
In-Reply-To: <20230213225723.GA2941414@bhelgaas> (Bjorn Helgaas's message of
        "Mon, 13 Feb 2023 16:57:23 -0600")
Message-ID: <873578xnir.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DS0PR10MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: bc80364b-2ab8-4475-b640-08db0ea1f64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVAfB/HaTH+AN2HKmk9aNX5zR5P54ybPN0n81uhmZAmOeOijaTJS0hvSq8PI5eXl9X/eHgSiBCAHqvQMOAFuVtpBinYMiTJoJvwKabzO6o5EtlxtYfiWzhJbcVak7/vv2yP+2vH1with2rYfny+T3K4UkrYth/5KCSL+ebZ5FRCj/e6dQ/3X9Vl4rQoPIsWAJojuHvQYZ9gkrQAm0leVe24UdtovETrqTy6HqI9/DRxql5f/Nxkyw/+SaTSMQa4HwvNmE6tVC1vtgMtePU5syqnFg5UYDEYwQJUD9tKp5wuGVERejyzjcAzo9MZmYXtpcvpH7Sc7fhywn3HJErl1CzkR9NvMzoLQA8c69FmoN3L9bgsh7Gak1C0VnriRAVq4e9RPV06XPkMio9FFnpMoykWZQ7bsQbhqaIX59fEtvsrJloUUwV0iHgEj/CMc/biF6lsd8pgGQqmpcPryY/kZoUIt3FH6a/CZqQOsQ/IInjWkD96TO9QMDNsdNwPUfe8I2aDSOGMkzMr0spa/85SVS0DtLgP2fqNbJ9h/BwJKq9T+f7RY38fWo5jb3Num2Z0738et5DHuqjCzEzV5rCzWcU93vsmgfvu110odnpU6OCbXIP4CkdT3ZO0cOsEdxP+0MnhbqEDq/nI5Lq23igcEbkurGMT6DeEwVTr/ej7sSDpoMAtTCIJ2usxr0U/MNusn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(9686003)(6512007)(38100700002)(83380400001)(5660300002)(8936002)(66476007)(66556008)(8676002)(6916009)(4326008)(41300700001)(66946007)(2906002)(44832011)(6486002)(6506007)(36756003)(186003)(478600001)(6666004)(316002)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHd6NpVbpnTKHJg7jAS+Ju2J99ImXni1E88mwkI1oOiybcMNZz/bVCQEOuFs?=
 =?us-ascii?Q?Hq4gesHI0SG4CuZ1zNf8941hnPzx1mdnRWGHvtMzWhWOhL8flgmbg/GGnjoM?=
 =?us-ascii?Q?tvLYvIEUF7Ym8k+aPf5ugmqD3MnI+k62bBnmmB79blGEXvPzXHdaZ2ZYIoOA?=
 =?us-ascii?Q?HkrSrSCshZmc0GA/UsXjncsrl1khSd26ZmTGzvxze8CIHIZJIs7Cyiwwb/cz?=
 =?us-ascii?Q?/b7CYesiW5RqcLvARRkm1NpMgkQ2LpKkGyUMWU9aLcOdqfjne+VoBHopxIz4?=
 =?us-ascii?Q?kVSo2lpvMuCDUoVL8t2uupKUYztGLyJ/H4+VrZoYEJK6G5iJChcH8xgU6IRK?=
 =?us-ascii?Q?8XvOCygmQKCQXsI0WVh4tTo/wi1DF1uEdXONYhCsfyr5lTnwMB1joAz2ogJj?=
 =?us-ascii?Q?2RaeBS6ue3Hm8hlwKHJVlM9gs9Grm/1VY9MN6ncYexWQtM2yOoEzEoTd94u3?=
 =?us-ascii?Q?rv8X0ocuYwgus3rX67pFsHzoZeIWcZnWyyn2SJ52yJsGYzZIIEIYIlMXW8nU?=
 =?us-ascii?Q?45lhHgxYTgY/mkF7++RKxQN+roeKTVfG3scJk37OMFBsaiv72cDh3fyjSebY?=
 =?us-ascii?Q?KbNBwnb8v4EkqFZ/5QnCBC9xAoosVX6ZNZv027BkAeE0zGohbEGn07xoEqdJ?=
 =?us-ascii?Q?iqK5T7POmXS2DcHjiIlRyyXg2WfAYfPYir9MrqKJVk6amhrcWi9rj9Kmz+GG?=
 =?us-ascii?Q?Y9ikOQr3kmUctuIMmj+jWwCiOhwBKsXzphwEpyw7YR0CZjqROsOZCMYo8nJ1?=
 =?us-ascii?Q?36hMzD/XfNkVF85gi0qCcKTgmbk8911pYUZfy1/+VmYAXDf/Eb1WsUNC0nbs?=
 =?us-ascii?Q?cqNwWYaBfutS7YawY3KQARKHrkMULq099nKrmUmL2NdfHtgmwCPG8N+6vDG+?=
 =?us-ascii?Q?T0TzSJgbuN1vtvtW9cRnJme1FuwlCiGETsdV+S9rdVRyNDgM1jVtyYoP0qXf?=
 =?us-ascii?Q?itFILkJFCOhdsqMaysq9i/dCz2PDTW/RYtCcixkCghK7deLl/XWeJDNKzNxm?=
 =?us-ascii?Q?Ab80tznPxwg4L1mCKNr5RZt00OLm885OGkdpv4N7fXa3NPUDVAMc4TZJTq8e?=
 =?us-ascii?Q?luDq6UlHlgPNPRG6znl8a1+qW+wG7bP5g6m/Anpc3XQ/1Pos6arjSAKsomj1?=
 =?us-ascii?Q?/JUJBJbpj9MrNxcu+AVtY19spqkGjUNyjv/ajI012qU9gxVjAH+cWJRW7Ywx?=
 =?us-ascii?Q?npO+nkCdVi83JjFeHqrQER6DpFhvyM+XFRep4UhS3LYSOMEWLhY+qb4bd9Ed?=
 =?us-ascii?Q?v4jG6nTYTtfzFEaQ34dBvEqAdaWyIagxBE4Yx++qHdnkTlF7qMuB5866d2+A?=
 =?us-ascii?Q?eKho4NtC1vci39ehQBMnoFLFXLPHT/D0CKpb00o3C8AnsvAmO7FdT1n4+0GQ?=
 =?us-ascii?Q?kre1Wu0X7xGXZtY/+7KNsHOu8Em9A6k3ROjxqr9rG1kLIWQQgu+cq8NoxI59?=
 =?us-ascii?Q?3q7T2AGhWWSaGD/iBmiL9jLSNKjH+8mm3Oq6/TowyX3TmnhEjgUSMbM5cgsI?=
 =?us-ascii?Q?35Cxd8VR5nB7MaZW8Mo4dpgu/PT1s7cgKPmxOchzXs7mbqMrVa9adS4zoGDb?=
 =?us-ascii?Q?eLgob7rmhW/mOP/0qtKh7vfJrmfSddfNqKL6zdwoXzrG1iuoPXyHNCgoHL+g?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kOlVrknEZnlMQGo/SVly3Z81VaaUOJeZYKezl2+KBZc5QvzUBj4S2PV1/ARbrk0aVsGwNwJto8VMsWKD/NZGNDWL+P8Hj6Sy1G/nwxGXLM2NTKjkuDtfZo3t5bLmZ7V1qBNRKtbiN6HVlEvbXyWWQB69tLxh/Eo9/UhfVLUkPIjZmjxDPIuioguVzWbXRVuXXA3FuCuL5E+6lBz9nWVdZLrT69bgl4H53K43FVR3m9syguCbnTfIv0pIW5KTe5toSav9mCzqNjWNZdVYJewkq1nuFtFC4B6BpLTqdkyhHo1+sD9bUsuoV2U8fHNgWOfakIra5Ra+ytnVF84tGI4+Mi418T8/KZjWtk1S8TSHHneCez8s7WM+QxCvCvcesyjaxdxQ+6LPTig4DI+DnTkPg3W+JkJ7a7JqCGN3EiDgK8FlqXhnmmRv4MhnKZAOgXGPf6crKZCuiroFho0H4x94/m+lljtE/U/1/YpScyGOkLTEchjvv2PwfUwQI9SKRKIwoY2ecHhj1f1pNA5Avj55MIhQKGacvoDkbrq+oaK9J1EnyCYqu2rQeesjX4dgZ3IzoXQ53mTps2bK2gf2XOlBHmuZaWOnJ0JvdNxJseg2gqOs4FtNWH/TqLNTf+eiOv5oy0gDdM1p0yCuq72C3h9W8K5Lf13CQXz7YcGtXWF7fIdIco0NvRzQDiPLxWfjQAaXXttq8PlP9eKwaiqsJQM1yIE6twLJdOkElnNTllU0qXpS2mwOGOMYij48fXyCaIAeI172kttG6gYv4xLWdThPdEPq14u1QjaTD1eJbxNskHfx7Zl8G2aL5zVBLgxxnb6wpWvbZMsVun8pHJW500fKuA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc80364b-2ab8-4475-b640-08db0ea1f64d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 15:41:39.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zly4UUVF5Tn8pW9ZhaH3uw/wwGTcTlL45pa/qYhhIxUxf9tQkfzui6aOjzGZVIq8Ub2ZOCv0AjN6rzu66tGOTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140134
X-Proofpoint-GUID: MBO9QItNRht-H38Wo-qnzf57McF786_E
X-Proofpoint-ORIG-GUID: MBO9QItNRht-H38Wo-qnzf57McF786_E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13 Feb 2023, Bjorn Helgaas spake thusly:

> On Fri, Feb 10, 2023 at 04:47:42PM +0000, Nick Alcock wrote:
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>> are used to identify modules. As a consequence, uses of the macro
>> in non-modules will cause modprobe to misidentify their containing
>> object file as a module when it is not (false positives), and modprobe
>> might succeed rather than failing with a suitable error message.
>> 
>> So comment out all uses of MODULE_LICENSE that are not in real modules
>> (the license declaration is left in as documentation).
>
> Weird that all the patches are for drivers/pci/, but the cover letter
> didn't go to linux-pci@vger.kernel.org.
>
>   - Please drop "kbuild," from the subject; I don't think it's really
>     relevant.

Every other treewide kbuild modification that I can see has a kbuild
prefix. Many of them have *nothing* else, just kbuild:, no per-subsystem
descriptor at all. If I remove the kbuild: prefix from all these
commits, will other people promptly complain? Luis?

>   - Please follow the subject line convention for each file.  They're
>     mostly there after dropping "kbuild", but do capitalize the
>     sentence that follows the prefix.  The prefix should always be
>     "PCI/<driver-tag>: "

These prefixes were automatically generated by a splitting script which
computes a prefix to apply to each commit's log by reusing the most
commonly used prefix which is present at least once in all affected
files in the subsystem (in this case, that's simple because there's just
one file).

(However, there appears to be a bug in the script here: "PCI:
generic,versatile" appears only once. I would expect "PCI: versatile",
which is used repeatedly in the history of that file. Will fix.)

I guess the convention you refer to is new, because there are a total of
zero uses of "PCI/versatile" in the entirety of git history. Are you
*sure* you want me to use that?


(More generally, I have no idea where these "driver tags" come from,
hence the weird ad-hoc approach I had to use to generate commit log
first-line prefixes when splitting this commit by subsystem. There seems
to be very little consistency here. They certainly don't come from
MAINTAINERS or from the files themselves, nor are they the filename, at
least not always. Could you give me some sort of procedure for
generating them, if picking popular prefixes from git history won't cut
it? It's essential that the process be automatable: I've had to resplit
this commit more than half a dozen times already and if I have to label
each commit by hand every time it will become a nightmare of human
error. If the rules for generating prefixes vary by subsystem this means
I'll have to fight through God knows how many annoyed maintainers to get
this incredibly trivial change in.)

>   - AFAICT, SPDX is the dispositive license and MODULE_LICENSE just
>     determines which interfaces are available to the module, so
>     dropping MODULE_LICENSE shouldn't be a problem as far as legal
>     issues.

Yeah, looks like. I'll just drop them, everyone seems to want that. If
someone dislikes my doing that they can always put a commented-out
MODULE_LICENSE back.

-- 
NULL && (void)
