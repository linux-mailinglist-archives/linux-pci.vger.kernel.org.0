Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D751579407D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbjIFPgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbjIFPgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 11:36:46 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B4C1724;
        Wed,  6 Sep 2023 08:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkCKRGrKP83+VTQP/w95iABZb/coGCAOlF/bUT2TRKCOYhMLZL5NRaXyzETj0bMuDudaJSj3cCW3oLJp3BfcM/+LL5xUge2DyJiUhbq18ZsgrKveAjKjAe0BP0DFPraJLLJ2hHjrd4AlC2Nbb7S9RedPxKqkF0Q6mEdXIaxfMqAispKUK1eZ4cn8r+JTH+BZf5MDpraBjT1ZJl+M9HczHS6ETXbxVIHuEsvDt2Lt9zUOniFqiq2Hlvh/I5iDpJzXDJD6fNNxVPjm9OF62vGXjdEvOEYiCyguKcrbPtuJ1k59HEMZD9AmDujnWihMgHkVif+yexiwrg7OyYmfxJW9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv2cU0NeRL9oU80ZsDEt8XZGBnwonjhTuNxen1PVkUw=;
 b=CSQlNlb3L4mw0xiqIKsCEkl8sfcWeer5e+1SM4w5Td1jSt/9KRoFZI+tYFPvN1gs/QShyLJNfRoiq34TyXimaFqeMdyuEXgm7z9diM7HdbUUzdIDrWd9DLOyOgUgvirJpyt4Dn9CV+DUrxBtz0teDK5yGcLEfCdN6ulchjunvioWKCH5znAAFXPQpUr+ceeZ+8PIp0vsXIkiiC5Br/Oi6B0wRCUnQ4sxxAeTzokYDgYJnqNrPxU9/J4FYDPEAMbECbIZBQQYTF1WPl131YIxNp2qdPG99cLFxadXifkiy0UpZxME7XEcME1bY5m+3+VEDHSId/5MF2dgAQQ5JlRyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv2cU0NeRL9oU80ZsDEt8XZGBnwonjhTuNxen1PVkUw=;
 b=jYkfX1RKgDdmWAndRLhG5QOIR/sisE0UJkdIxNVy0yqCj5vEyM4Kta0FpLqmtCEFUk7zXCY8qQhAhonkpnVN8kqK2gFTAo0TA3IsCpXkJl9RF+/HiegWDwQQXu5dfEoByQE2cTjoaB5WnzcNiDy44amERCxt0Tm4Vm8gZQMzYYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:36:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:36:40 +0000
Date:   Wed, 6 Sep 2023 11:36:25 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@ti.com, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <ZPiceT2SidayOwDk@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
 <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
 <20230906122605.GB5930@thinkpad>
 <ZPiNwQg3rDQMRA/6@lizhi-Precision-Tower-5810>
 <20230906145227.GC5930@thinkpad>
 <ZPiT/LJGpNbCRDZk@lizhi-Precision-Tower-5810>
 <20230906152704.GD5930@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906152704.GD5930@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dce2ae-7048-4e0a-b611-08dbaeef106a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6vBhVYujDK3oZfgkwWP1FOsFIcOLllduR5szOSM/b8ySxWnd2D16Yfkkt3sILRfJAKLGivC0MR7OhnGVkHpPDBHdQB/xLMX2sLkEevv05bQGlYHGkF+dSz5QQTQeJ7yUZxMaNMaU6HGnELDxIimT+rL1Vhf2NxiQ3yGe/tXc0GUpwwtFYGAcmO/4vKPIgUjt1NySLPrKYkQWYpBgNG4TDLok00wbTab621WORnEci+ngDpvh7ZJwqLEjDx7oJnbKRlHCmJHeB3YchdIn4joMmLkGmw+inJa2iR/Kpf+yiWdVOEvAgm1CA4oPuHVpv1vF2zZ7eFPer4iBPcYAWkaqFXD20X8L+jY1tSytNA9jspqrXKIvn4qHCwxgLsH9wRuqwTKz49icm4Y/JzC5fFqfGkS/rGaP5BHKulcoqa/pexYw3LqZiXq2PCF3wJfW58XQ6Sx98GdP/FDjCsBv8SFoHb2H4PHBBgeRCExYslpqO7oFgl+qEBCNd+msuzq7Dbv2No71TlU2HKRE8Y/X9kzQEPQIKRdjj6+GwqjJMM7/NkhfubmDSPaMBZ5Qj6OmID74IWbc7v/r4XtjbUZnu95obKHoa9vejqsc00ZS9rwpcxguYkBOwVaTghbalKTAY2I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199024)(186009)(1800799009)(6486002)(6506007)(9686003)(52116002)(6666004)(6512007)(478600001)(83380400001)(2906002)(26005)(7416002)(66476007)(33716001)(6916009)(41300700001)(66556008)(316002)(66946007)(4326008)(5660300002)(8676002)(38350700002)(86362001)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0t4dkMwZ2dsL3QwdWtxWjR3WUtYMFpGaXc2bVVKL3pmYnJaTTgvZTRoSGNX?=
 =?utf-8?B?bU8wNzRVZ1ZTTE1qRmFSK3pFQlhtZVRVR3NYemxXbm92WEFkK25kendhL1Fh?=
 =?utf-8?B?aGlGRll6Mm9OdGVnSUtiZWNYRmptK1VhdldmSzh6azBUbmw0RlN0WjU5NTJv?=
 =?utf-8?B?OHNGY1B6V2hiQ3VobEVXYmpVWmg0bm1OMzV2MUNkN3VZa2tPZXhrL2JCZW4x?=
 =?utf-8?B?clM1NHhFV1pYeHJ1K0liWG0vU3B1bTVxNWtzYVozVW5sQWNzSmVQYWx5N3Bz?=
 =?utf-8?B?WmcrbjNjMlViREd1OExkdnNjUnVmRytSTWF2N3A5WjU3ams1WDFhanVvY2R0?=
 =?utf-8?B?TVVsdnh6enFqMUxJVkEwcnp6dFdhUVFwbnlrUEZLQ0g5MCtJbTBwcUk4a2oz?=
 =?utf-8?B?ckllRitQUFBFNkgrQnUyMFdyWDJaVHpneU9wUFFrdlZnS2Y5ZWFmUzEvOVdP?=
 =?utf-8?B?Yk1DVktvWFlQUmM1dVhWRFZDenlpOVZpTEdYOVM2QzRmZ0pNeWlsMWlVSklY?=
 =?utf-8?B?NkMrVDhjK2oxMGlwUSsrV3VGeG1DSGRIWDdDZzFBczFvTjhLZWh3aVFFWHlS?=
 =?utf-8?B?SHQ2anMyKy8weGdLRVYzSVNwYXZOUWJoSjJDbUdjNnZXakhERlhPNndOUk5H?=
 =?utf-8?B?TjR6M2hOamFVaExONldQaHlvVWx3eFY3TStkQkZ1SkJTY0F4SE1SZk1NazUv?=
 =?utf-8?B?Z0lMZnlYWFdkOSsrQnJQdE9ESzhoMkxwRktCUGs3QU9Pb0dKVGc3bW10U0hR?=
 =?utf-8?B?bTlZR290U3ArS29DYU5xR2lNaFpTUXVNVEVTU1dydWpyd2o5ZVl6RDA0czVS?=
 =?utf-8?B?VXplcDIwV1QrUmZ3bnhjNlpud0dCaEpFQXd3Snpyc0RrbVd0a3ZLSXZRZ1VX?=
 =?utf-8?B?QzFVaU5YUENGYnZLVld6QThueWwycVdFNWMwSUtiYVFwRllZVElFdTZyekE2?=
 =?utf-8?B?TlY0WEcrQ2tmSkpPY2p6UVNvODNXWjgzc3B3ZFl6dHJieXNCVnhYQ2JDVlZK?=
 =?utf-8?B?UkVnSjNkOFN1ckZvRmJyeDJic3dqakx3SkoxeTFQYnNvQ0dIbkJXeUUvcVEw?=
 =?utf-8?B?cFFJbXoyWEpKZFRSNEtzY2UrWUZGaWJrb2RURGFCSlFtVFhBT3d6WlpTRHFJ?=
 =?utf-8?B?bUpHR0U4ZEZjSFFrMVdHNk1nb2xXVE4wcS84VlovTUFLeGF4NjZYMnJQSEMr?=
 =?utf-8?B?UUYvVms1anlGZlo3c3RQc1MvZ05BeHpmd0tjMVhXMTVDYTg5ZjRhY0R1eFpX?=
 =?utf-8?B?M29henhLQXBnMUtNWlo2cHAzanZ1cjVPYlNXVUJTZUFqLzltL0d5OXNJaDIz?=
 =?utf-8?B?OWdqSCt2bXFQS2xVNnZud1BMWW44b0hQSzZYdHN5Y1RGUkJvTXJLTHUyWUEv?=
 =?utf-8?B?UVoyZzV4TlFxcXNXVUxPVTNhQ1FMaXRWWlNGK1R5Yk12Y21mMm9PVDdpM1Fv?=
 =?utf-8?B?SGd3T0JYMjdncmhNR1lmTFVVdU9mMzdOVnhVQ0xCUiswdVkwTk1SMEIrYVN1?=
 =?utf-8?B?V1FQT1E5SlhvQkpyQ2RoL2ZPR01BQzdRME5ObDBxd2tsSlR1U3NybXJWMlc4?=
 =?utf-8?B?bHhIVkU2NnJMdGVrOWF6L2lEY2xzQUN2eDl5TVBBcmZZVXFmbDF2K204SWs2?=
 =?utf-8?B?ZlE1NjVvL1U3TmtiSkhkZlhUSmxDRnJUWElZNHRyZjJHVkJLdXk5SGxtdzRN?=
 =?utf-8?B?RkJqQUI3ZTdFWjM2MWVYZ3lMZDMvNWQrNi9FTkQxOHZEWlV4eUNEazBLenBK?=
 =?utf-8?B?UU9NMU1NK1prTzJOeTJDZXRDc1lDQVlzS2F4YnNrNEFqRW14Ykt4eFYvL2lt?=
 =?utf-8?B?Rzh0dkxqcUduRTAvL1NzYjAzdUREU3hxczNtcVdmdzZpN29VVFhaWGhCR0Nx?=
 =?utf-8?B?VmZBTTlBWTdYYkRrY2ZGcFBKNDlkQmRON0g3dXJVdDR4Y1crUFB2Rld6cnJ1?=
 =?utf-8?B?My9QSFREWGI2MTJQU3NpQ0dTcVJ4bkgyRkNIQUh0SW1xWnN2eVczVGpPcFV0?=
 =?utf-8?B?Sk5hZm5LNThBVXNuSkwvSEZ1ZW1VMjlUL1ZueHNpTG1DZWsxQWYyNEF4Q1BR?=
 =?utf-8?B?K05HWGpGNHV2QndQNWlMNk9ZdkNNRVp3d3pQVm9PMjg4d0RiK0ZNbkZyVTNx?=
 =?utf-8?Q?eNyxVihiPMrxPi5LUYFzCiynP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dce2ae-7048-4e0a-b611-08dbaeef106a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:36:40.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei6VGU4XCgeOCgj0tSXOhmMYTcpICBfSO6vnev2LPrg4m13i+BfTwOuGFS7NUuSz/s6aYV+kqqGRgN+bkZ4rXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 08:57:04PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Sep 06, 2023 at 11:00:12AM -0400, Frank Li wrote:
> > On Wed, Sep 06, 2023 at 08:22:27PM +0530, Manivannan Sadhasivam wrote:
> > > > > 
> > > > > Can't you assign it in the EPF driver itself? I do not want any OF reference in
> > > > > the EPF core since it has no OF support.
> > > > 
> > > > If that, Each EPF driver need do duplicate work. 
> > > > 
> > > 
> > > Yes, and that's how it should be. EPF core has no job in supplying the of_node.
> > > It is the responsibility of the EPF drivers as they depend on OF for platform
> > > support.
> > 
> > EPF driver still not depend on OF. such pci-epf-test, which was probed by
> > configfs.
> > 
> 
> Hmm, yeah. Then it should be part of the EPC driver.
> 
> Sorry for the confusion.

EPC can't get epf->msg data. It is too long time. I can't remember the
detail.

Let try to move to epc again. 

> 
> - Mani
> 
> > Frank 
> > 
> > > 
> > > - Mani
> > > 
> > > > IMS will support per-device MSI domain, then we can implement customized
> > > > MSI irq allocated. But so far, it is simplest solution, we can update it
> > > > after IMS implementation at kernel. Only one place need be changed.
> > > > 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
