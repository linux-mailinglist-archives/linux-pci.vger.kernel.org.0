Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106247D9DFD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjJ0Q1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0Q1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 12:27:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79D106;
        Fri, 27 Oct 2023 09:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEcYHgA5ky5sJmlgFPB2d5Xd1iClM9vnp+u20RSYQBu7+c+G9KYDDjioXv+TMZGJFvdBlvF4n7deYijdc1VMHbmFwmWkHO0EZSrq71k1i9UoKjkdwyBJAl11NGkAk/mexPIx1EBohpQ26M/MJSW4OqtPDamL75xKhG+Yfja9WLkuS0UJvFTFJfNa18eRV0//ewLLieLNlTG6QupiFEf1uCEOlkuvxvoBAZIKSz9ESpaeyLRbeYAkKklEjFMV8VN2irkChusaFurgUqQ+qFCZOLtwRPFbX+qZgbY82RVAjZTm/O9Elm4hVIH12PbZySepZrfakgl4o6KXUgaBQbUFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WShDxNiXMiu6KEAYL3G8vyEob1ehxCnViYThduEi1PI=;
 b=ChsYBKjqZQlMOb7YFowLuzLc4AsglN5S9gO2rwY62m1z947b5k6aHGJLUsbby1CBMvKl3qTYR+meXR6Dk+muV5y74glbs2uDQAdotnX2wwPrVwFKp7rKPFXopt1at6nMX2xi7jiTRwkpeThEk89n5kqmgkraPJ4n2bdqyh99NE/E74TWa2Ub2zwhNPA/UnGst3bFQoLhFNiIC5s8pkErQ6zEMnXHbGM6aJ/qx77dlxi+b+W+Wms5/YXW+DmtlVYbXdvnUlMsDKc5yjGacm6CLxhQZ8PadMzKRDD5vt3x/Q0HNTvi0N7tigG5SGo2DjvuE0E2+L0uQueSCbBN1T1rgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WShDxNiXMiu6KEAYL3G8vyEob1ehxCnViYThduEi1PI=;
 b=dD4gZ2WLBNbozKUGUsRstXLgVrMv/H2AGl7ADN71TH1lnQdpmOSLqPD+tpPXT40NkNcoYeZDQ1tc8TCMpU9D4tllamo1gKvkI/lhsreFjTerX6XC7PWHNma4ikrjj5pj9mCzT6tMDoouMEH8IQFiS+SEWS/vxuBuHBY0lkNm4KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Fri, 27 Oct
 2023 16:27:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Fri, 27 Oct 2023
 16:27:09 +0000
Date:   Fri, 27 Oct 2023 12:27:00 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     bhelgaas@google.com, imx@lists.linux.dev, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lpieralisi@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        robh@kernel.org, roy.zang@nxp.com
Subject: Re: [PATCH v3 0/4] PCI: layerscape: Add suspend/resume support for
 ls1043 and ls1021
Message-ID: <ZTvk1Mo/cg0CKKJ3@lizhi-Precision-Tower-5810>
References: <20231017193145.3198380-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017193145.3198380-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:a03:117::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 7167e7b3-1c94-49ab-a217-08dbd70990de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AOcWX9I9wcvCNasC7rR8ye1FDwQaCcdxufoTNjLNwdx09Up04XPLyMCaTCRbBa5dfJ4lDy+lUJVTfeoa5T1+ubukTpS/+9GFj2ARgZwc8v152y6WmyBiL8lMdAiuOVMv8CATzu7IwauIgO1V6hNHzgxxmo+PCyZDB24676hWfJvMwpI8/6LW7TLw4V2dfZY41TEvyTFSfGExCEPJIC+iqL9Z/iAyueM4E427nYc82zm1h5c7WbICbObqsWLmFvvntsMmwa1LfsTkroJlq/bfqi9rLjgbh/Y1+AdQaie/9wdASV7vYf0qBEASH98km/EzHYhPDnf903WIOn8mGitUql/7vTqWN6g0cBjbcM3NF8z0QrRmAkCzAGk3Rbuj7JxlXISjHa55aGiPkRbedgteRJa+ynYOonjVdpL3v7HfK3w4UkyCmU6JOICusPPw9jiKzpNP5vRQsO7p5ra3gWFopqVcvUkuTV+Icr1wgwaIE4d7+6P53+vISp8a6Kp20eZFJXA/r/dsgPJdEnm8uGkUc2+UrO9/kqi5Gh2Md0ICyQ/lkIfdAVHhwQgq2CqV9jvrIKoLlMdzYhcOWFSo8ASjNzUX8pocEY54SKMunhECa6QrbZV1TutTBOjt1m/UZP3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(9686003)(6512007)(6666004)(6506007)(83380400001)(66946007)(6916009)(52116002)(478600001)(316002)(66556008)(66476007)(5660300002)(8676002)(8936002)(4326008)(6486002)(41300700001)(4744005)(7416002)(2906002)(38100700002)(38350700005)(33716001)(15650500001)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJsGDbQABsLgqNHh4IkyMXPYSzyLh398wgoUntrn0H14qOB7IDHPfzkEtMF7?=
 =?us-ascii?Q?O0Z0F//Sjm3AmKzYxSCR4QBpHUqaGE9WL8HC6X4vl5NqiiqOwWR942xJpPA6?=
 =?us-ascii?Q?NzQJhLFnIynxKofYVYEEjDNUlTWO9mXnx/MI5yEBD8obof5aY/tn79BtNrDU?=
 =?us-ascii?Q?a2NrMMIrNXMT0n8oydGONtIP9RP+jNgeljCDEOj2U5Z66EvsaD/DcX6I6kUn?=
 =?us-ascii?Q?nBNaVJvwvfXY1ys7FXpa5bKmsgjb8KpcV7RwMGRBFM3m82Zlb47epieryjQu?=
 =?us-ascii?Q?AG7jkwoHMXrDLw6xt6f99ccH2TMX9gNxX5CcysUZMuo8lPfHgaEOddTQ2INO?=
 =?us-ascii?Q?ubhONm1NMEpu4+cOH3Vc7IDJZohqG/bFcXmz80Nruddz3XuzH65J8aV1KEeN?=
 =?us-ascii?Q?fy5xNAXW0unSTXLyPwBP5fBhDvw3Ga4pI6JlPkaNf+sY1YoWWQn0FaGqEO++?=
 =?us-ascii?Q?HMLvBc072Sc4W/aGAj8qPRhp20kDDBpeh3CkKUMILKeWa33SV59Jp/m0kpqQ?=
 =?us-ascii?Q?dasoy6LTP0WIEyG6557yxzQtIdiI7nu9LZa0/MnsxGIB4mavRG5p2zHQOExl?=
 =?us-ascii?Q?4HHpfaH/yNkhBQG107aZME3YNnHWAt8p/tUH1qahGUotSLI5lMD+9QRfR57G?=
 =?us-ascii?Q?X/3mh+NtPwRLchrNBj2F5cCTBLTJy010/YGtcCgmW83loHzv1ubfDWQLfL8k?=
 =?us-ascii?Q?NAWkjTbjCKjcC2nlG2rjmMm+4fvgKdkwkTvl/I+SwY18dYAo2ues3emPI9MG?=
 =?us-ascii?Q?b2rvvq6i8IpiTKXHyBoTrT7mMgttH5i1u1R4FeOCUR2gHT6YxyfzSYqyQ+8a?=
 =?us-ascii?Q?edp4uJSIelSZcaXAzEJRVQ0ZKFvkQfJYfIkPM+NstIGsLwKV4Li23OmCuYBc?=
 =?us-ascii?Q?zdQDNtsAYsNcbRck+ufPmqsE9D4CeJzMD9cUDTapS/B9NF/zRg4F6IgwOOhy?=
 =?us-ascii?Q?28rPkCGlLtAgTHl+G7gNH+ZdZkf4/mBCnWq4WgVsCuPZxfaLdUhTy7l0HgRx?=
 =?us-ascii?Q?sfMO5TKOLprILAUvsr4/ZyI5IcA8NFcZXVybED6AzGRERIo1qcyqCBEKjPRF?=
 =?us-ascii?Q?ghHgAsS6ZBuv7QWRMEYL9B/sqWTxjAvVGszf2K4otSKHWoDyFIg+zVIXehJO?=
 =?us-ascii?Q?G68H7Euab+OdqXwBJV4/rdzWPw5CS3cPv9thJHp2exd3N6Rsh1Lu/6ZOWdyL?=
 =?us-ascii?Q?UMsSFDMhpMiE1S3Wid4rYWnEuGib71+4zfaN2W9UfUplu86Q2VdwJVIZjeBp?=
 =?us-ascii?Q?rG78YN/dSltqmDkC5Qjs5RytHJgREAWo2tXB2iNbI1pGPFOCfBNEYw47D6k7?=
 =?us-ascii?Q?geGt0m6TuHOoH7u0rAF5Hln6YJ3sKPD2pRa2ocelpdQt1CEv2FDYjimKR9Ho?=
 =?us-ascii?Q?akp8wOySipCHkHhPgMKg5VqO9VzCWJtNgo1mFIn+5/KBnSehqgc7LaCN9BuP?=
 =?us-ascii?Q?VOR+FTIdORYRgZ1vVx98gtAo9Ts94pgcgVEPiNaIuLcUbWgPjp4ayY3biU37?=
 =?us-ascii?Q?CHTrkdXaVU2HXQVkpYIoWwvrKk+evw/bxptk7I3XqcOaoxLbVVxeAbBPhD+l?=
 =?us-ascii?Q?7DMxqf0w57FkbxN/rHBwmlCjg06+8sIjS2UA3QOe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7167e7b3-1c94-49ab-a217-08dbd70990de
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:27:08.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw+1qHxxwdwKCaxTth+3pnCScSz5FuncHi2COcuzcRV3buPn7EpZseAuSvzM0EtPtrpBZf01Fkn+1OKUjfCu5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 03:31:41PM -0400, Frank Li wrote:
> Add suspend/resume support for ls1043 and ls1021.
> Change log see each patch
> 
> Frank Li (4):
>   PCI: layerscape: Add function pointer for exit_from_l2()
>   PCI: layerscape: Add suspend/resume for ls1021a
>   PCI: layerscape: Rename pf_* as pf_lut_*
>   PCI: layerscape: Add suspend/resume for ls1043a
> 

@mani:
	Do you have any additional comments for these?

Frank

>  drivers/pci/controller/dwc/pci-layerscape.c | 217 ++++++++++++++++++--
>  1 file changed, 196 insertions(+), 21 deletions(-)
> 
> -- 
> 2.34.1
> 
