Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4A0793FCE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbjIFPAf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjIFPAf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 11:00:35 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81AC172E;
        Wed,  6 Sep 2023 08:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIBVbTl6WZhOlYtvqaORwm7MgpDRc6NlcB6A0SmRnImWbBK5jPrj/BGWYb+7BAd2cvMIhQz28DCVlzPKw1PQwebu9e/f35l/XU9lyWIfFTZ/CXrUWcjfj+R9eX3P4ElVeyDFLmareoZBJqdhgFtCSt9t0voIT3oV+e3UPIEZ5HE5HuzDZBnxPIbfrXpxbL7xFJ63q3Vd7aNf/XddRWMJyc6HxrKamBPoOuWikA/TtnbbcMEnmgfc1c8aswRbQ643DiwuvEITUXms+C1dwO4O4OhXTA0UJ1FwQYI3DkMwlbT/AoPccoknaM8c33Hvlf/tBrMuQp00vOo+ZVzX92wpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GTfce8yE0Erh6aoplcgcty/02lNor+Bh/rDuulPXdg=;
 b=h8kaT0xzGOhVVJ3F0HjdeirEqBy4152LyCFPnbFUcqm2A3k/A25PF7PWbIXIy+7Po/+PR/BjFvaiwilg6a8FDxz89ijuqPNTxf6bnWR/ce85GowlFoQTXIEhFu+SEef5i3k6gJMgskAaTEoRFGOJNmXVCvS7BbIxNKMuCUu6BysYjli8dA/ihDnZ9TGu9a0E4XVBJDYB/5h0NrYXfINVyPKduGLDGNWOBq2IzoXBL8y9DBXE7QUWLaYSV1HbvspqKN0aYD8eaHnKebZ6JPWvqQ9Kq2/FuMsyaFFhxuFVIhcr/KrcHkQd5XkrOf6+bxxuvOIenjuQWBav9Yy20uGQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GTfce8yE0Erh6aoplcgcty/02lNor+Bh/rDuulPXdg=;
 b=QiNuDbX76+ud6mCpmcNRH7ylSnnBx8i10GsS3U93Iapj4LuUcB2w9rgGPch2ODK1JxJBmj/YAFQP1NVc9Vn9psmwbPcsbkmRCXxJoxOk+m58AqsD6C0Y4een0N+/FsU5aJCNRzIf2rlJJPD+0PqeOAXD7X4O0lzgCLdLh8ygh7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7528.eurprd04.prod.outlook.com (2603:10a6:20b:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:00:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:00:27 +0000
Date:   Wed, 6 Sep 2023 11:00:12 -0400
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
Message-ID: <ZPiT/LJGpNbCRDZk@lizhi-Precision-Tower-5810>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
 <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
 <20230906122605.GB5930@thinkpad>
 <ZPiNwQg3rDQMRA/6@lizhi-Precision-Tower-5810>
 <20230906145227.GC5930@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230906145227.GC5930@thinkpad>
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: f393c4e8-920e-445e-2e36-08dbaeea01b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQasP6ZZAZKGQLgSlPmRVY3C2MQjGovzjTe05f5G4MEK715M86I5C0KdFmPXnuLDs4E03LW1WoE4Fx0dnC+H9Vla1DWtyfW93W5jMJ1tAGRdGyCqKYDxAN2BhbdLDr4DTNW2A3M92599AA/jM2lTVdGpIdE9mpB2n0xcecG7rMxs21wbQR/Pz7mKtikFHSNJIsrSqZE4wKMVl5A1k3tEOaayAx0TT46YnonQLc6fQPqEQi0IXgs6X4ssL76MSzCMjbku+uYwedkfovV3tP+3c33BwSR/VjATcMTsalEUI7qr2nR9t9UBvokZNGWoy+xNIejxZyTZfXyNSDDd1cYgTljOlzDkpMsrFYAzwTg/y9JIF1T/gU6Lztu9MouWhw681dnQaXVv+LKk2L/kybfk10/OGb+4SkGLvAjd2ScvTb3PNlomErmazUmEtauRIUGSiQpqQXFwd4IJRbm4rDbEi5dfv9GbuQ8iq1ExX4uh9zMWfY8/kfirf6fRBoiDaUQSB1trcv3Wod9CmPNqxv2sQSF2UFju2FQzIXu4HvTzBhMOPRqbjeH4jT7kGd0LxMa5g8R2xqc6l0HLjYMdyQUUFOIh0MU9GPTzPDE/1ft2bt1UgG1WndR80UdNJLfVLjNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(33716001)(41300700001)(6506007)(83380400001)(52116002)(26005)(7416002)(5660300002)(4326008)(8676002)(8936002)(6666004)(6486002)(9686003)(6512007)(2906002)(4744005)(316002)(38100700002)(38350700002)(86362001)(478600001)(66556008)(6916009)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhtMlRhTnVUd040Y3l5a0xvd0FVbjcySXErcDZxRlNITENHWnU3d2J2WXJJ?=
 =?utf-8?B?VmFOV3Y2NThUT3IxdlI2UXlsMkl1VCtsV0tHL0NWQ21Ha3VBL0UzVGFBSUV6?=
 =?utf-8?B?NzV5Q3I1QzRGVVppTUxsZU5PUEl6RDhtMmlaZnlzRW9Sak44N0xKV2k0UitO?=
 =?utf-8?B?UlRTdWdKNk9ES09FQlJrc0oyZE1vKzZPbnJyeWp3c3k0VlpBS0twcklFTkhj?=
 =?utf-8?B?enpQVThQcUpQRVp5S3Y2UktMZFEvMWtsaUNBNmNRVS9TVGFaclFoM1FPUWwr?=
 =?utf-8?B?NUVGUHlvT2d2WnE5ZU9aenkwUnN1b1Zia01Ic3pxOWI1RnJSYnZBckNvMG44?=
 =?utf-8?B?bFJ5T2UvMm41b1UxdDhiMnFsVCs2U05BRXBaOFpmcFNYVWgvR1hJcEVXNkMw?=
 =?utf-8?B?N2JqNzd5N3g4SHV5d0tJMEJQVVMydnI5SFZXZzluU1dzZUFQNVhtb3MrWDRu?=
 =?utf-8?B?QmhYWGs1N2czNkorWWdHZ2k4LzVPSVZRL1p4M1NONVJZV0NCNWJqeVU4TWRT?=
 =?utf-8?B?dnZ0Y0FYazZIeHBZM3l0U3pHYmc2Rk1tekRNUC9CSURSRmZITGRkMVVOOVRE?=
 =?utf-8?B?QXkvcWtVbVNsa2tQTC9zeWhVRVRqY1VyRkxMb0krQ3JVT0o2Q0tEZjJTbm9L?=
 =?utf-8?B?SlpRWDdyNzM0R3didFdlN0swQ3k0Sm9wQVJSOWVtUjFmUGFZRXhJSnpRRUhU?=
 =?utf-8?B?emNtcktGUHdlVGZSZ3BRV3FpaFZCSGlRbVFweUpzakNVRkszc0ErMkEzaXFv?=
 =?utf-8?B?MWVZWEd1TEkzMVIrckV0MUEreHc1SWJiVGtXWFJRRWFpYVlZRTdFL3djTEhY?=
 =?utf-8?B?blN3aTNucEE2UEErSFRvSGdHN01KVThZcGJvL0J4SjVWeW0zOWtBSlU4MzRu?=
 =?utf-8?B?YngwU0FHYUtSWkhKNWs2a3lFWGtZZFFHbUl1am5pNUllYk9Za0xJRDN2a3Uw?=
 =?utf-8?B?cWVqdEF4cW5qNFh6bXZPcDV4dGdvZDJYbGJpVDhPMHYxM2pSQWhTQ2djMEZw?=
 =?utf-8?B?a2FNQndwbWxOUzhtOGZPeStkZTUzQUY5c1REYy9HNHAxSU9EaVdZV2VPRENn?=
 =?utf-8?B?ZXg1ZzNCU1p4QkpVOEZyUnZaZ2pLSlBBMW9uZ0NRbmZQNFdJR0NCUGErODhW?=
 =?utf-8?B?SDRoVElua0xvQ010WXJOOTZCU3VlOXM4Z0w0M1Nvc3FXVHBKL2FFTlp0Wmll?=
 =?utf-8?B?aWxZT0tBcW9RK1BZSzJlaFVxQVJrRjJIQ3Z2ZGF4d2xYU25neWg1bENGVnJW?=
 =?utf-8?B?K1dnYTNibHJULzFQMTJUb2MvQTFPT1lNaWNwMjJQbk8xaFV5NzlFditmYzRZ?=
 =?utf-8?B?REF5WUEvTlE0b3RYZW80NnYrVFBISDVWOFJZSDR2b2dIRTFEOXh1NCtXMFlo?=
 =?utf-8?B?UTZyVndrdUE0QWgxODM4TE9VclpicVVCSUpKZ21yQVdtOUFSNXIyeE1NVzlG?=
 =?utf-8?B?cnlJaDJWQlhPYWJFcjA4SDJxRnlZc0NId2tVWGNrdjRCOUN2emE5YmdJVkJ0?=
 =?utf-8?B?dy9IVXQ0MmdJL2lQc2pxZzRrUGFlTFVHN3FjV0Z0dUwvNFU2VjI5V2Qrd0JS?=
 =?utf-8?B?N3ZlaHZVdnpMN3VkVUMwYjlqL3p6cndzQmNMR25JUm1PTkU2cDVtUE5zRWpj?=
 =?utf-8?B?NEppSUZQdVFHQlQwUEEvYm03dERWRTFTUGZha0ZhMmxmaHlCYk8rMG9aNzZ3?=
 =?utf-8?B?ckxSZ3pQVjVFL2NvQVRkMUt6Wmcrc1ZuTmdONUFDaTJXblk1b1hwbW4vcko3?=
 =?utf-8?B?RTJKa3dYKy82ZExRbU9wTWx6YzA4MmZyd2Rtd2l6cEIrT3lObytUY0tEZ2Er?=
 =?utf-8?B?ekJiOVNDY1NwMmJ4SmEzLzJUd2taNlRqazNmeFM3djJYSFZqN0tBVk4xcUJB?=
 =?utf-8?B?ejdSRUtMT21nUTNRQ2NnODYxdWViSVFnOW1yc2JpNkd0bGM0dnlyaDBoQ0gz?=
 =?utf-8?B?WG9zNXJHbEEyQkJZWFRvWGdNdHhCVkZVa0Z3VERXblhDZ1lBV0wrbGdFdjdP?=
 =?utf-8?B?NCtjOVpsemFQaE9hdGRLUmdwRnRGRjg2Z20vc29xcVhuV3EwdjBQbWJDdFB2?=
 =?utf-8?B?ekFTVXdnem5SblY0LytFRkhBMGNUZmRuTWk5WVRReGhZdno1dlN0TVA1NjJ0?=
 =?utf-8?Q?JyYO5vhHGyWPEgLIRQlUJNpKV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f393c4e8-920e-445e-2e36-08dbaeea01b2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:00:27.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4pw0HXhPEiwaiRS8E6y6epcj2gMl+QdaseM5dsEW7DOk+cfb2vNcVoIMQKYSvMEuRF0Li/dIQXCSrSzEYgetA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 06, 2023 at 08:22:27PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > Can't you assign it in the EPF driver itself? I do not want any OF reference in
> > > the EPF core since it has no OF support.
> > 
> > If that, Each EPF driver need do duplicate work. 
> > 
> 
> Yes, and that's how it should be. EPF core has no job in supplying the of_node.
> It is the responsibility of the EPF drivers as they depend on OF for platform
> support.

EPF driver still not depend on OF. such pci-epf-test, which was probed by
configfs.

Frank 

> 
> - Mani
> 
> > IMS will support per-device MSI domain, then we can implement customized
> > MSI irq allocated. But so far, it is simplest solution, we can update it
> > after IMS implementation at kernel. Only one place need be changed.
> > 
> மணிவண்ணன் சதாசிவம்
