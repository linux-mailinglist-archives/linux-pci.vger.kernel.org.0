Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E279F624
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 03:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjINBH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 21:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjINBH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 21:07:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CA1170F;
        Wed, 13 Sep 2023 18:07:52 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E10OJq028872;
        Thu, 14 Sep 2023 01:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=W6a4Rl7RN6yzVSe3y8GTewn3g8DNyJr1rSWT8AG8o5M=;
 b=zc0WzcByRXV6SJCVr1K0RRW/kjxLhiNhGg6Qsh1qqH3QMhRkWH20hrxGsxZgB04RbQHt
 IY9Cg1kq8prB3IYAIU76FQb2TYjuMLirOUi6EjYpuD/cxPE1jpqcSU0yXIRB5IBCf7W5
 X4MkMsSvLAerZLwmuZ+mo6QBN2vIdCooGsWGC6pl/lPBg2iLZqIs4Fie6R/kCcDUIjCc
 /2laAhdax4KqzXzktQBkQLMNlHuUrpuT6vxFfudqr02K/PZ22fHX3Kse4B0MDjMIGs/y
 buFGn40Oe6Z7EAlpPcLo4WWyYishdDiVJjHeTYMrCfKXG3+votttsweVDy/FeYAn5kGg Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kbkue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:02:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DNXvW8007726;
        Thu, 14 Sep 2023 01:02:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f580wd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:02:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0ZaScT4fSVCMF0+CSrVEJaOx/Pj+qM7IxTDdpfhnpcyCz1prkMCdDcMzzgfbCPKHDhIdoVWynUcux0v4PShskqiFLHPc1WUKusaCrkXx/2WJZgqq24y4gsamJIwF6gKgaXrFfdyrWOpcRZmm+5gN//cghabbJIo0Z2aKLTHAIZ5cgSkyE49dVYMuqNf14xIPVPXAKkGI16vgis14ep3plF5sx/K1jcxqM5cDXXQg0QNBsZkzZTNhYpjvRJcf2YIxlzxR/EKUrPeds3C6ESwQ+4IAGZ9/PBRyjUExsDvf9kO/L62CyHvtq6sL4hkZEPUD5sWogoRv9us4Hgw1/XMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6a4Rl7RN6yzVSe3y8GTewn3g8DNyJr1rSWT8AG8o5M=;
 b=T94TeX4o3Ll1dgngnYnpv+XnjI/w2Cqg0e4MqNju1rxYcwC7cWb/EJli3dLSoMEnB3SGz/acpm+VMoRpWFH9prv9BQltMH7DvRok1U8ZpUabnvf45e3fnjWRLzmpbxFU8Yzax9DO8PYYcFWN/EidqpGrOaq81AH0D067PBNYB1nxo79sWIgRekgvrEVYgX8hpUpSPZTnTtDSUa8+949AphuKtBzu1j3Ahp0dWWS7KFplibCDxwWf5eXx2qr6W8WVqXPtz7rkrORs/eKOaMWt1WYRgyWSFDdtikaUpW9VrXEUIgCnCSQHftznkK6uWJWMWZmhB4d/YeZl+zyfBm7lOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6a4Rl7RN6yzVSe3y8GTewn3g8DNyJr1rSWT8AG8o5M=;
 b=Msj+NxzygUldeQtoUcMgnw3sGSoRZrDuKflR4ONG1wbMR3n9W8QzgC4teaDIIqWqEtW286zxcJDWbnPWVqV6y1eVZ6P2IgogGH009AcBMKLuQl0iaazDg8elYOXiqkOT3KJKoSaeqjhX/2GjTwUx8PlAT0UsAYZsPnF9la6K/08=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Thu, 14 Sep
 2023 01:02:37 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 01:02:37 +0000
To:     Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] scsi: qla2xxx: Use FIELD_GET() to extract PCIe
 capability fields
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18r99fty8.fsf@ca-mkp.ca.oracle.com>
References: <20230913122748.29530-1-ilpo.jarvinen@linux.intel.com>
        <20230913122748.29530-9-ilpo.jarvinen@linux.intel.com>
Date:   Wed, 13 Sep 2023 21:02:35 -0400
In-Reply-To: <20230913122748.29530-9-ilpo.jarvinen@linux.intel.com> ("Ilpo
        =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Wed, 13 Sep 2023 15:27:46
 +0300")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:5:40::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 18077320-b492-490e-c95c-08dbb4be498c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /gqiYdl4jIUDyu6wvCqzpyyW3ZigFjedU7neTAenD6Cis5IbPkPKK3X8955nM5ALYm2eSZbZpP0+ZKGJwpsolTYzLZ//3KiWELu6SvuLSA7S32po3yYMC6RYSfyp+KzFpnw+8n+hr5R6x5KeOooRZqrIaK/lVyWKNsTEeDpTTdR6Z4f5uHwLub4QbcdE7PlpUAcBph43s3mr53jRCsyIgyMMLE+T2wunSXMxC520IHX/LwI9J3WOdzmkv9k1k0bCw4Nq8joU80q17O4abzPPzROCmIk5rIySwuWmApB17B8soBT3z8Gx1qbzACmf94vg2RaxYJ0lFovdHy94l4QJJs08rRfM4nNs5tPp19ZLGlkFAcYzJBn47tqPxwxVpqODFaZFH86cyXSTlTRJLGrU9b04UqMeFQ8xU+zM9Ow0rw7NAKhmUf0LieUYCfJxO4hcStDSQpd/85lfc0pteY/OaC2iSVgxoUfm6ScbOgTF4KwSoo219KmHRDnZz7/W3dH433a4YU5hLVSYV0NGXAtlWzSfdjoy6e0D+jWbg8fqncyN/DB4/g0l0qbdYFx7OxJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(1800799009)(451199024)(186009)(316002)(6486002)(36916002)(6506007)(38100700002)(86362001)(558084003)(2906002)(26005)(6512007)(478600001)(54906003)(4326008)(8936002)(8676002)(5660300002)(6916009)(41300700001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9x0VST/wIvo6BN3O++cKNK5Kn3mEP3RCqKSPPYWJI/PRt49vo/QOmlQa5c/q?=
 =?us-ascii?Q?UwfTqhTxo2kHy1i1n2wasxdeRTygloqTCMHg/nii4tjW+7sUNB/oXSsrHgrv?=
 =?us-ascii?Q?AaULYg4N6b7RhuP/USLQ1E0Gr7xs4IhZu8sweNAFSxX6fTGyC68IWdflJ0qe?=
 =?us-ascii?Q?KTJ06Un/VNLQuE++H2+SxxF60kBVtQiIbBXydqY3JuuqZC8jZRvqq6fownsN?=
 =?us-ascii?Q?Ttpj9Vv8rmBvjv/K6cnqxEL+Sm/1gfsbXJJuJSNJhygScRz4MzujGS4r00xq?=
 =?us-ascii?Q?BBJM7ETiFQ98xGVygUkJNyDfcXq6pSvC0aqTLWZMAqsRmRMkkXpjvIE9yCpQ?=
 =?us-ascii?Q?ssADY8G77FCy/OYoz2akOx67DDUAhcLh+M06RFFo++4lPX81lnyCqm2VZuAy?=
 =?us-ascii?Q?HtQiNbDo0CDW+0348ovF4p3iJpR44ApuPMyNk+fiD/jChGhTO4INSTdqR0tp?=
 =?us-ascii?Q?yD1o1cIMoF6pc9BksvE0SE9Dozcw6igqDgeqO1WPrp77u90UFcvO7Js8mQQg?=
 =?us-ascii?Q?VzvOyAVXp3bPHIuSjspbL44nHNl8/BrdflsHwGoPMzIQ2jSRoARYoTxWwwDU?=
 =?us-ascii?Q?6uC5Sai3Z7qwvRBAYCo0crNae+aIl48+BEaMyw+n0gx6WobuaO0ik4KEakit?=
 =?us-ascii?Q?o7edD7EosPtMFCfB+H0lATVBdZCPPeHODFUxomHc6I+EgO6OO4Y4CX6Sdow8?=
 =?us-ascii?Q?TITjR6d30vbhnK/gebJYD634K7z8TRX9z7MEqV4+gjOh+5EiTAvdwcyv2QMV?=
 =?us-ascii?Q?JaiFk4wvua6M0DvxJPo8qGBwokAzOF7QSqzSHuRKue3fqZHXfBmh7rhBJcM1?=
 =?us-ascii?Q?aWznrAV9bAcclVKnAKcs9nr2gNpN0/3QCpohAsQvoNPZA569S5i5zrm0oM7Z?=
 =?us-ascii?Q?qGEXJIVmP8zKfPZM89C7g5+wJf/6gBDh8A0LDMUEBWwGkZMOd9pCBqIiPlBE?=
 =?us-ascii?Q?qp8ZK00Rc6FYt0vwxiczy/BCmeLBrbm0lK7zP61wK5Cj/S/J1mq17zhBoiDe?=
 =?us-ascii?Q?+2ismizB1PHGAGQjESTM4TgOj28bv4n1PtR1n9v7mYWeMPCR58Y+qJidFfa2?=
 =?us-ascii?Q?kgvgIXYjKry95d77IbMLq9kGt2CIDkHNKj06rht+wzRygHN+O0cbduJDslgT?=
 =?us-ascii?Q?Q1CPd+93tT4iRJuvdwQrr7qmlCAhUN1DhDJ5var99TwBWUSrc805XqBBs320?=
 =?us-ascii?Q?j3VegoLbdBLLRoiUBhtLhoBJZdaOdn2mevumqNxvnBlvJ5RHtp2VgvuL7HK+?=
 =?us-ascii?Q?BmAr6moWN4KnCI3U3sfbEMHEaDf6uHeqFwmWVIOpAQmT6uEcF2v/4TYZcfuS?=
 =?us-ascii?Q?wgqxqSGJiTbKMVS6W8OoLcxTZUJDbBIfa2vKLDKeDphPkSALtR+0AlogA+U2?=
 =?us-ascii?Q?FkP8KDxXHfxyYodbX3PgWn9Q5DQtiY2en7kOawxmLpUx7OlN7d34lBCv45je?=
 =?us-ascii?Q?EOgi0dZ+ZTdRp0CVAUddyi0aEkx1EY6oSS+YDOLvU/SHIcLnnOKSBMhlrinv?=
 =?us-ascii?Q?ypTwTQRLj9wysMwVsreXq1GHzqiq31vvsuiUMPM1gs+4U3r1m05LSwursXFb?=
 =?us-ascii?Q?mk6kk04oePU05E6ECoc7Dr+ZZUD27aCXK5XCP/GJ7dP1DneW2gamupRlfr9c?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uOxPV929eUfTe0vQNQgmmxpdgf232+ELcFkZv5qlzQ5oBQD2zPJ5sWij2XV/?=
 =?us-ascii?Q?yg7KiVdxefqPnATNqieHydNcJrTtAvyRECBnEX0mWpRGp6OxPYlO257ejqPN?=
 =?us-ascii?Q?8kbyhkiY4KvzyVrmGTgQndxLMHmrhJh5EJkxf17y6nEAOWr4Jzo/Gn0lDVn8?=
 =?us-ascii?Q?A4fdhej0KHZkRmI6qP8zhss/ngII1f+p3Vlzxz4liqOfEU8KY801K8dEbMJa?=
 =?us-ascii?Q?dehK8tWrWiM35H3B/E/pJGu/hwJxAeSqO+EbTNDndtVgrOV6nVqEvftdY35v?=
 =?us-ascii?Q?C8N+eHRT/KPeppbw232gQoRmMSpSmy6rTy1WxnGFqbVlo6upgasSwu/zgr5S?=
 =?us-ascii?Q?aDKcvpaUVJHkEkOlcHaNZnySKZGK2pLMv8PKm3beYASSNdJwmx7BJYx/j9+i?=
 =?us-ascii?Q?c2imo8qZPaFyMo6OuZHhqMP+SMEY/wHxC+pcxjtuSv7JMO/D98TNPi0uAqq8?=
 =?us-ascii?Q?n1EhcC3B0/R5OhqmGhHxJmse8cMvxwcK1hyxZm4/02H6n7RXCMq+Bn5lwXjd?=
 =?us-ascii?Q?soohN6Jaxv/lRGSmGB4nU+6nWRFnMWR+XlCtc+/jTZY3pXBSuQy0MijEJZV5?=
 =?us-ascii?Q?szA276u7TFS0YMc7xAIRE5gwdOJryUk+I7k8gV5FnMKlUB/D4dIsJR8xPxGO?=
 =?us-ascii?Q?0SwNBuahzvT7TV8UrXbp8/5h/bmElvBI16pBF/AstJh4uW1Ih4HlpSrDzXaa?=
 =?us-ascii?Q?7vuhZglCqFOSU5KoKZuKrsdHapYqJefti6t5opwsg+eZjGGcHiF9l/FjeW+r?=
 =?us-ascii?Q?3Ove90ukcF1skwIuewejtw9eGi8wJegxwj0VHEvuKXV5f50Vi24IJfCXhra4?=
 =?us-ascii?Q?M6cqRKvu9nTgfBYkmozUi0APE3QZU4AMPJhp1P/uqvGybe7eCKjnlMd5+AXP?=
 =?us-ascii?Q?yJgIVQ9Ovcss3nRLwhJFPLHEgX7GsZIFOTF7BOR4iWCR47gm3eW9/ncfOPFg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18077320-b492-490e-c95c-08dbb4be498c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:02:37.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8En1hAeC/ue5kHtpnkgETUMFv2Cz1XkQHO8KmhMPDg+wu6z2EBb/asgt8XIOuxIdwgHQmQ33olazEa7zGIaR4boYtvUOYkZS98cQv6N9lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=793 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140007
X-Proofpoint-GUID: qFJDLzbRJ_TjfBmKuQTle06oYDhGP7dA
X-Proofpoint-ORIG-GUID: qFJDLzbRJ_TjfBmKuQTle06oYDhGP7dA
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Ilpo,

> Use FIELD_GET() to extract PCIe capability registers field instead of
> custom masking and shifting.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
