Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D4587B36
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 13:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiHBLCA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbiHBLB6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 07:01:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B765EE7F;
        Tue,  2 Aug 2022 04:01:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2728mFoD024575;
        Tue, 2 Aug 2022 11:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0r9LEJ6TyXQcA9UD2pRRKXRqcu78k55GwQ14PU8F4Dc=;
 b=SS1/iB7O9O7pGGCThXRvi7HWagpGYy1C0gaRLwqbaDnwv1fTpGiET/vO5EkML2K2Ytw6
 4J4j4Njw+k+zdvGC7CVlzd0+E/jJhqD3puJFokoL6FHg/WYhN5fpGWWS2i2+JsyvAR+S
 tLCvyBarpQjr8YDIisoP4VzUN7KUBKLemz6b5t0euP6w9Tdv4K03qOzkA7bXUjkoSJdu
 v3tNGaa953RA0SwNyedDVRNhBLcP+y9uspzEcB0FHpsMkW9aaun5FOvKYKgRCL0Mxkui
 K5DaybIo2dqwipogmlorWQqLhjjyBcLeDKbXD4MQYHy1ted9NFZKiElz75cV1b+d1kuJ BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmue2phaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 11:01:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 272AoBuu010928;
        Tue, 2 Aug 2022 11:01:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu324yc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Aug 2022 11:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvSVZ29cTih/bB7keCHYtmPs/r6yDIfRwq62IzimLav8U+9StML9d5oPyZ9Qg7bwuSDxWhEPCzik6xxWiUWzq/Q3fjWXL3p7C+HQHICHtHccpHCLUoVsQKnDNHpXm4nCHV5AwM5ui4WFqOke9ipVNm0AXdrvxnCYN3dNWJkPcNsyM8PSqUggvxR04Cap28pPnx+PEl6tSs4QiHWQ+73VgwGaJg59MLvDUeYTWccxZvbU0lLtdS+mqHkoATEUoSuIGCAXfUDaRrtnOA8AkZ6xpsH0UWSjd7snPg5ubFfxPT7Zr+YFaL6gbCND2N0iHOBcsEZQUSU5HFrX8xmR4g5Vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0r9LEJ6TyXQcA9UD2pRRKXRqcu78k55GwQ14PU8F4Dc=;
 b=I8T5r0JbNvepDGgxseyxNujTys9rvOt2AfUr8H7SJJ2yf4XTg2z1aJcf1DZniUtWEVsNkKqxIsnt1I3/o1j/4WGCoG9UOPpqZElvKfKMstB33Ej+Dpfjg9kOMR3WHe1mArlvNqrpJW9kUTwwYURnI/YI+zrDjWYJJLa6jSj2euXXlNrSKRu+0Tk+emfCvUzqaFlaMP+411Ly+frY+xb3f6ZIT1kiEnD6CzmJZyzdi10hncb90b8+UkucSU4Yjkw2eIY2RtA7DFQmk27+27XlA/e4KSdUVG6z7bg8nASuRXNOLL8/sunqEEwL3fUzxinxSpqQ4wihVh1NgHzb5rJyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r9LEJ6TyXQcA9UD2pRRKXRqcu78k55GwQ14PU8F4Dc=;
 b=JJpu8PNBvHDXaYDaq7H8iVrGxCbgHi7Av3vh4AFyorusFADv/uGzVEODU110irFyNHelgH323WCCbJKFdpEFFXssMa2GTM8sT6GcHOh43bbfFpFWfGVDm8PIpcMomu+NYBFUti8crImTe9aB7yYDXW8AmdWiz2u4KP1TpljmBgQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2055.namprd10.prod.outlook.com
 (2603:10b6:910:43::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 11:01:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 11:01:45 +0000
Date:   Tue, 2 Aug 2022 14:01:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] NTB: EPF: Tidy up some bounds checks
Message-ID: <20220802110133.GG3460@kadam>
References: <YuenvTPwQj022P13@kili>
 <YueoPDOseM1BGiXD@kili>
 <CAFqt6zaLY3_DKC-=NJSrgzePrDS-q-dfUQxrN9puBf0+qVNfUg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zaLY3_DKC-=NJSrgzePrDS-q-dfUQxrN9puBf0+qVNfUg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c94dca-820d-4203-11bd-08da7476635b
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2055:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JtQlb0gqSIg6WMYkkmpInjOS3rWh6iLWjrraLAOPefDyrJkIO2+N95PieLfcQyKA4X+1SIPPmj2/IbzLKwCR9EBufO9q5Y7z4cEbgdQuFf2cIiX8iVF0xmpLzjRVV2/LphswEpMY0Kd5mOGHlxKLQ7DyU4DcKsGRyGOg4XEobmMDJM4KHfG2Zvy7MJDseasg/TTu4lfcON1Hi5A1ZsEHlrbfNU+xWTp/UNow11oVmxIcRMcFmS4SpKvFUSvI0T+szE0swD6ueqbPnmP51PMEPHfAA2bNw/OmRDqP1eIWYrIDgwGf9eYlKsu9oprB6V2I5924gt0JKT6iCErDim3TT/w64QwUwHAAApIKoDCf5kL/ZFINj7mrssMpOrlkwffHy3acVBaUD0/GZD+QXiAgLkIuwxUKzbRr9YwzmTUScIK0PSWtJO+Q1NedEDg1ZS0D1Z1uUDTM7eVnOxIFDpyJDGQRsv0flZkyVfRwc/TmYu1DHEXPh5Gb9wDjLFulwlCUnj/QQPPJc9ozqz0NaDCNPye3pgApM1JaOjy0/pE3HPz6q0xDfqekw9TNBbDH2+kWpclb2Gu5crxHiRxAf+7Xw3JYbVoAj5mrL7ekdPiuWivu9X5QRSL5BiPZZhGmXv07twZzH4Ib2nmUdrvXkLoKMOu6zpV37qDdX0wA7tDm3xlbDmf0rj+wUy3KNYKxlrJ7GI2Fqrih+SR1jSbnXt0IP4oiU3HXUvS5DgDwiuY5h8mAbgtqnvQLoGmuZmCyuCofHoTKJiNN6k+3KstQpI2wFIOggxDqpWFb3hKnGnC7WOWKIPndDFEWs+PwxSZAD/M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(39860400002)(136003)(346002)(396003)(6916009)(1076003)(44832011)(54906003)(33716001)(186003)(83380400001)(33656002)(316002)(6506007)(38100700002)(38350700002)(52116002)(53546011)(2906002)(5660300002)(6512007)(6666004)(9686003)(26005)(478600001)(66946007)(66556008)(6486002)(66476007)(4326008)(8936002)(8676002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QchOcbm6k/kX17qRJZ73cFjptW8cVLUZzgdSS838MTgYXMqNvFGYbtOZmysn?=
 =?us-ascii?Q?vHOfWNO1i3mq8dBEQf7im66GHhwI+EViGZQ2Jiqu/HSMzyRWBkUsNxsFV8nr?=
 =?us-ascii?Q?fLQrDDkJ2kq3AKjXe47Angml+vt3B+w/xuuyAiMryv8uohMW4/bN1ZD2OIiz?=
 =?us-ascii?Q?ierKuCeqHv7CWj21dfnBY+gx6HSUxCV6DcsKrk2rkd1C6G5hu6+g31uHl4Cp?=
 =?us-ascii?Q?meg1ltu3lF2U438yadv0mB4RIt2xf1huNI4UrPsKCsM1cfBKrtpCYhYv3BkX?=
 =?us-ascii?Q?R1oE7KizvTVaJp7aft6bLRB/urWbrAb8RcWcU2mZCPjUH1GLa9RYWXM6QaPs?=
 =?us-ascii?Q?u55kxMIFMqj9PmOfhhWOReydgTSlcRbAfmkoa1t8qKRfDcdob7MrSlrfFYR3?=
 =?us-ascii?Q?9ai+deIj1UakIu6pJFiws+fiFkTQuclmbW5I7joOyPk9IzuiTRCTO059ai4E?=
 =?us-ascii?Q?9QNs8ViyjIt9MxeEwQjVrP/+ffBM6UEFhQfmhhgZR2HwYyguxt9jO2hJKJ1b?=
 =?us-ascii?Q?mX/N0s3wPg5YNQd7678sXXfxJmuvZG4/B9Yn1BE+m61VTr8+VhghRXCgAmsH?=
 =?us-ascii?Q?j75j7qkYKCEDcVomKhlT6CE3g0q2dPuu4k8YL80NHNJSxQIt/OL07nB2UXym?=
 =?us-ascii?Q?eLHoQ+hbmoDSJbJ8whOXwHUCJPGY0ErzkXKGfsBU60cdBJkIfSmo9X31NvGe?=
 =?us-ascii?Q?Wgm966gkn60LEaf23kqZCAuOEOKVSq/DJrCd5H9iA1uxdm88cB0G92Zsa+vx?=
 =?us-ascii?Q?xKG8T9ZEqzG0a7BKDZ7XUFrYLvvlSY1WV4piMkeJbgT7EBy/LCgPvrOGY9P+?=
 =?us-ascii?Q?4X2cRCXM3L3TpmY/xUtewwO8FjlNFO296/VN+rI/JNGTzkNPC8QSTjotYTO1?=
 =?us-ascii?Q?l1g/B25Sftf5HgQOpbo+F9AuisjanIa8A0/aQVJuEi/3nQu3gkSecGnPS4s1?=
 =?us-ascii?Q?lb/mWHQrjuqCO9DU0KHWFc2xal7h0mOUF6t7thTNEURMaePYHJjf+memz+1i?=
 =?us-ascii?Q?G0JJCqLCTxe0+SqLENMZgGEy3gNUuvHK6NYTvy0gDb0etUabWLnGb7ikkxAH?=
 =?us-ascii?Q?TCtfYpvmijTa0pZzE4ioxk17oL8rMayJJTpEJBFe+tR7U9FS3kg/uMlwe9Zv?=
 =?us-ascii?Q?6VMc+2RFl5D1A6aiW66H53nUtM8y0PbjR1hgSK3jH3Z87wKH5ZfgV4qXlwEh?=
 =?us-ascii?Q?w8lRkQ0jpWNWqZuuupBKEI4vNy0A/Xx6hJQAGg0u7dPeAae+g+PUYVbrEA7M?=
 =?us-ascii?Q?4qjMT8CkUIKPb599ArsjB8bbYEAI0ras+Y5sE4MMgVwk8e71ekGlSt1Y4sHx?=
 =?us-ascii?Q?aM/TYUqlN5D/4Fz4KgZEXofWSKgxww/MVz2c9nqSE/Es3aRVgjq0H6bA5lkI?=
 =?us-ascii?Q?AH0A+klC3vruhhJwQ6bgIQ8a53s0AtsqCZyGA14m89TVt6dXcASVqUIS8r1E?=
 =?us-ascii?Q?s4d3RGXQN+wL6N6Vgi3Cv9qNCvLypYqyCDys0kOKdfVWDiN/JOndVdSdg89M?=
 =?us-ascii?Q?hHoFiP201qgSmp+QxmtUFKcSq5hjiFRmH4eRtQ27qPIJL3BNOMaMKIGtyqPT?=
 =?us-ascii?Q?mL2Os5v2veqnSgmnqaQs76VSm2fNCdriqsrfMFDvgHXiBEkBF+Tls5BLpPHk?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c94dca-820d-4203-11bd-08da7476635b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 11:01:44.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dFu0ptcda7wWmKjAFTDXRYdIdi26Adx17ASCN3PviP1f5QYsJV8QtOApvL+wTdxhu6XQrP5eU3UZojrl+lWKxmYfc9OegBExd3/HiyC34Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_06,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020051
X-Proofpoint-ORIG-GUID: d4nyl7Hx2aqfx9asaJDt22EFPzoui-kN
X-Proofpoint-GUID: d4nyl7Hx2aqfx9asaJDt22EFPzoui-kN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 02, 2022 at 04:19:33PM +0530, Souptick Joarder wrote:
> On Mon, Aug 1, 2022 at 3:47 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > This sscanf() is reading from the filename which was set by the kernel
> > so it should be trust worthy.  Although the data is likely trust worthy
> > there is some bounds checking but unfortunately, it is not complete or
> > consistent.  Additionally, the Smatch static checker marks everything
> > that comes from sscanf() as tainted and so Smatch complains that this
> > code can lead to an out of bounds issue.  Let's clean things up and make
> > Smatch happy.
> >
> > The first problem is that there is no bounds checking in the _show()
> > functions.  The _store() and _show() functions are very similar so make
> > the bounds checking the same in both.
> >
> > The second issue is that if "win_no" is zero it leads to an array
> > underflow so add an if (win_no <= 0) check for that.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index cf338f3cf348..a7fe86f43739 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -831,9 +831,16 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,            \
> >  {                                                                      \
> >         struct config_group *group = to_config_group(item);             \
> >         struct epf_ntb *ntb = to_epf_ntb(group);                        \
> > +       struct device *dev = &ntb->epf->dev;                            \
> >         int win_no;                                                     \
> >                                                                         \
> > -       sscanf(#_name, "mw%d", &win_no);                                \
> > +       if (sscanf(#_name, "mw%d", &win_no) != 1)                       \
> > +               return -EINVAL;                                         \
> > +                                                                       \
> > +       if (win_no <= 0 || win_no > ntb->num_mws) {                     \
> > +               dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
> > +               return -EINVAL;                                         \
> > +       }                                                               \
> >                                                                         \
> >         return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);      \
> >  }
> > @@ -856,7 +863,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,    \
> >         if (sscanf(#_name, "mw%d", &win_no) != 1)                       \
> >                 return -EINVAL;                                         \
> >                                                                         \
> > -       if (ntb->num_mws < win_no) {                                    \
> > +       if (win_no <= 0 || win_no > ntb->num_mws) {                     \
> 
> This might change the existing logic. will it be ?
> if (win_no <= 0 || win_no >= ntb->num_mws) {

No, it doesn't change the exiting logic with regards to the upper
bounds. if (foo > bar) is the same as if (bar < foo).  It just adds a
lower bounds check.

Normally, the variable part of the condition is on the right.  Check
patch enforces that rule where it can.  It's the same in English, the
variable comes first.  "If twelve foot is greater than the height of the
tree then blah blah" vs "if the tree is less than twelve foot blah
blah".

regards,
dan carpenter

