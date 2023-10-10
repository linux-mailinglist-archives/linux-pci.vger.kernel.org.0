Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC597BFF0F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 16:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjJJOVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjJJOVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 10:21:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7483C6;
        Tue, 10 Oct 2023 07:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZuODTkwh3Vdjsk+X6Xzv4N3hNsiM8SvV95KxtClhcNe8N/b61HeXnw0dUIBd/IHNWrZenpEySNIkMA48Ncd02rqO+dORnRJcuTIpXbVRwt5nJ0XZ+4k2py0ovXmYrDgyqER2OQM5NIHlSkb/n++hDjcIO+YG3mHqsBHKYgK6VllrMV7Gr5S02LjRvG2cF+DV9mEzn1vqyOati/UTgNL5VUm0vuM1qSut/i/ffamWQIsB8hRVXkB1Tf85rM5bCENSQqb7jgGLN3N31D6wrn3YysW+zwnJ9Vy4dUBHb2hBeyLgMxOuqqAaeMa3aye4bTjfDns/H+tdGlEi+C4BBcumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKN6VLn74l/xbbWtsfYsCb7nNmzLRYsQALQYBaG9GkQ=;
 b=Dcfw7MPgbcbQ5Ikok1kpVc5bQzLFzQ0UC0KRkZ+gxUmKylj7hQEB+uR7HOZznEiy4bI2RmdQ5E3ezrJD5WdcSgfV5Q6zHioWR97DJranRJI5jEcNtftWAmEFQIqvRsYPhV8cwLpwQakm6sxFINM5z8MyDiu4uQY23nE6XtprHfjNfbA7JePosyS2V4X7NCDMfiud777gVUk1YT0gmUSWVy9KJFi1Bv31CTyI7rp6Q+OXUF5CPGvzVgEA71d6vDcJ/re4BIDrsFvc0nH1rfM1y8jnuncew6tHr9x+LZzYeeWqcb0iSlKeRQ+KWPPiP4U2vpWJ1FemGcShNcgdeSh9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKN6VLn74l/xbbWtsfYsCb7nNmzLRYsQALQYBaG9GkQ=;
 b=XvYJodSE9xQCqZffq+fJXi1AobvgYoX/4W0/nGg2AxVZ4IJcSCpeT8hYLZrWxO2H0t6+/Qrs5oCbKbP/U74/fnGCP+WKyjPOGjtfWcgbLpo7zcuiLLefn6dz2YwVzlK0M+8p5SHWgJ836CL+e5a28PJqIHT147Kq+WPEf7dvClY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:21:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:21:31 +0000
Date:   Tue, 10 Oct 2023 10:21:24 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     aisheng.dong@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, jdmason@kudzu.us, kernel@pengutronix.de,
        kishon@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 0/5] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <ZSVd5GN7lJUfdF8L@lizhi-Precision-Tower-5810>
References: <20230911220920.1817033-1-Frank.Li@nxp.com>
 <ZQtmpL2vCMgR+Upu@lizhi-Precision-Tower-5810>
 <20230930090249.GB3564@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230930090249.GB3564@thinkpad>
X-ClientProxiedBy: PH7PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:510:323::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: af9d53cf-3115-462a-ff50-08dbc99c333a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yL1e56gGMA7w//swtk20M2OYhvScMhSdw9XiRQ4kS1za5QaH2G7GIXzMq1UEITa0KkCdlMdVbXMA1ATHdqkAdmorFyiw8SJQAdS4kSC5nEeihhvMEXsVkZ5abH78mgXUsFld8mmYiEWrQPjpI0U7ZC3EqwvdiUaoodoh6ltRqbQT/40r3GpPheh0RZsp6/LiKcZlL//eibSZiMBiHWXo8TJJy8Winb2/pWrE0KFUIpj+SrKhTI9JuPhVNVuGO9HgraXqvQUcAf9oe/LEEaabd79/tOhJTtUNS6RERn1TdVw5wRa5uqgtGVe1rASqrro8h9P0VOE+xwgnNjLZYMw8n7vUzTZomxPlU5LMP/BkM5yfOgj9R8+ju/ptDKCSeKWUSkJaay6ECUo7yUiOzlxCpbAVqUemOFRvx2CXzuEDhRpBPGLPQvtHEKS3x+aKOfY/REHR8fdHXola8pidKjSewI4IfuHGFK0OX4eAXB2qF16ZEq9Zb9Z03oAhljfbpgs4Zqvg1FcDxJtEAJnwUCYJqdt8hATjmvh4eM1L12ab2zoM3f6R64WAK2wzCno52jCBY0qN6EmMxuyKrBeQvZ49jVrxzRRVxikfo48f47Jxb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(478600001)(966005)(6486002)(33716001)(6666004)(9686003)(6512007)(6506007)(86362001)(52116002)(41300700001)(38100700002)(38350700002)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(7416002)(2906002)(8936002)(4326008)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9UWHF2UGZiSmRoeGd4UjZNcUE3b0dCMk5lV3dOczlNUG1iaHJZQllDdDlu?=
 =?utf-8?B?Y08rS0xxQjVTV2FqZ2UreFV1MWo3b3hIYzcxWUt4bm5HZElYQzF1SDBsbmcr?=
 =?utf-8?B?OE5lZzVROFVmNjhQM0NVQ3pWL0JKZHB0Ky9NandpOTR0MGJDaEtnYjFnU0Vt?=
 =?utf-8?B?ZEVuKzhFdWJHdWowMWdYNVM3aE5JMURHai9DL3lYcC9pOHhhcitGUjUwbk1N?=
 =?utf-8?B?eVltL2pyb3h0QzNqT1N4dU1pSTd4ZkhVRkd1NXhxQTVGb01oUW5qOW1QTHI1?=
 =?utf-8?B?SUJUMGphakQwamN5N1JvUW9PaHE3Rk5CWStpb05rZUJTdmRtancycTk1K0g3?=
 =?utf-8?B?NUVDdEViTThrVXNrWmtaNE8zKzU3SjFuVURXOVV5VmNiNjVhcVJIaWhKdWJO?=
 =?utf-8?B?SU1QNU1WNGZsYTNaM1Q1VFJTd2RlTUZzTGdxdGpUK1ZibFpQcW1xTU82Z2I2?=
 =?utf-8?B?R0pLNlA0ZVU5RlprT0xIdlZDWHAxZHo2Tk9RU3dTZEJpVlpubGl0WlB0R2cz?=
 =?utf-8?B?Tkw5dlFBczVPMkZ5VTlxUW5TQVJnc0tBVEo5LzYrNEYwZmlZVkd3M0hLNjZh?=
 =?utf-8?B?TTVwQzJ6TEszWjBDcFFPK1VEZUF4WHZnZkFHdE9YaFdIbWlpMk9DZjR4Znpj?=
 =?utf-8?B?ek93ZUczem53cURlR052UVVmK05Pa2ZKeExKKzZRa3VUWGs1b2ZFdnl2d0dQ?=
 =?utf-8?B?NmNwcGwrSG9zUEljd3ZwV2NrYXR2bnNvYi9mVjUvQS9RTkdlelNVUVF3TXJt?=
 =?utf-8?B?aW4rVk5PMnJoam1xTzN0bW1XZTRNVVdIZnVDYmx0RzEvcXovb1djTFBqTCt6?=
 =?utf-8?B?ZTZyTU9id0YrSlVGTmUrVXJXc0ZOQXlrazg1dE9PVDNZS2prT1Iyem5zOGVC?=
 =?utf-8?B?TzFmU3d1K0VKSWY0Z1FBcGFXYjNLQ3NWbCt6MWtuK0ZKNFB0cjR0OG9iU21I?=
 =?utf-8?B?dDJvSTBGc0dCdENaLzFRZ0tkcWY0K3V0UWtNOEQ5S2ZXL1B4amdaeXBmRmYx?=
 =?utf-8?B?dHFyODlNeE1UTmRLYUgxSHRtT2t6MEV0M3UvdWl5REl0TXU0VWRQV2l6UnRC?=
 =?utf-8?B?ZkQ0QUNnditHT1V0S2gxNCtMejhvMmM1MExDYVg3RjU5R0VYWjNMbERlNWpG?=
 =?utf-8?B?RnlHWDVKS0tFRENCb0M3a1dOQktZZ2xqUk1IcUFQMEpodDJyMVNPc1F2UFps?=
 =?utf-8?B?N0E5UVl1bGhPT203c0g3dVg3Y04rTlcvbGUzSWhkWGMwN01JYURndUxzYitk?=
 =?utf-8?B?anB5czRuQ3hIQTJMKzVyeWl4TGkxeGVSbVFPOTJZd3JVNUVVd05JbFoveEpv?=
 =?utf-8?B?UE1XMnQyTkZIOE9QU2FKWmgyNzZxc2RBSjVrRThVVE1hd0JoS1FNRFpzbEww?=
 =?utf-8?B?WGZRY25PK3RiK2ttUituMG9oRW9EaDRVd2RST2Q2UktRdHVaMFEvVzZFaFZM?=
 =?utf-8?B?cDRKUnV4bzhWdEVjTmEyOU5BK3Uya0NIYmpvalpoaGNvSDRMYzNlK0QzWTFI?=
 =?utf-8?B?dW9wMVZEVTJKNHh0OHhqcENRUHllajRJa2JEZ1NKTVZRY2FueDI1Z0tjOEcy?=
 =?utf-8?B?ZU8wS1BMQ3RkN0hKaVdVcHk0clBXbVdiQUZVeXMxZHZ2QkFURFFZS2lWN3FE?=
 =?utf-8?B?dTdQYWs4Y0ZpcVlMczJmVGpVZWlkQ3Rvc2oxYnVUSVk4WU01VDVpb01UQzlE?=
 =?utf-8?B?N1RWVU1jaUEyWUdXTXhYWUFIQ1ZpY2hvVStydHJkL2U1TFpleU1INlRrTHJH?=
 =?utf-8?B?czdkV2pwL3NZNVdiNmZtRjZ0VXhsbEFrd2tIOW1yd3B1NllQZVc5MGluU3JI?=
 =?utf-8?B?S2J5TTcxeEtIaSs1WnNtUkJTbEJIS0RHeURhUXhJQ3hnSXR6aGRFdDVGZnpQ?=
 =?utf-8?B?T1h4a3hIOTFXRmVGMFM2UlNNRmY5TThjbjFTNE9MTkdCOE5VMEVmV0NOajhS?=
 =?utf-8?B?L0tQK0N1S0dWOU1TZmNqalJWUVoxUDdPdVRJSWtPWEdLT0tIK01jMWRFMkpT?=
 =?utf-8?B?ZzVEanphU2pKaUtydE9oYzNyL1NCV0ZVRHI5NzB0SlFsZ1hvK2JRUGQ0bk9W?=
 =?utf-8?B?VVBvWE5KUmQzUmdDUnFFbmNSbUpGc055dGhRR2JwMjkxRnIwYVBqbGZiM21J?=
 =?utf-8?Q?tpSqgMjmGUENH7kICZvQGJERn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9d53cf-3115-462a-ff50-08dbc99c333a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:21:31.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHo7EjSjeY6b54JTGpUFWxE7hxq8mWy9Zx82eRaEzittO89kAh6SLudcwXt49YEd14DuUNnjMR1iZ7gcRrnVtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 30, 2023 at 11:02:49AM +0200, Manivannan Sadhasivam wrote:
> On Wed, Sep 20, 2023 at 05:39:48PM -0400, Frank Li wrote:
> > On Mon, Sep 11, 2023 at 06:09:15PM -0400, Frank Li wrote:
> > > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > > │            │   │                                   │   │                │
> > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > │            │   │                                   │   │                │
> > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > > │            │   │                                   │   │                │
> > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > > │ Controller │   │   update doorbell register address│   │                │
> > > │            │   │   for BAR                         │   │                │
> > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > │            │◄──┼───────────────────────────────────┼───┤                │
> > > │            │   │                                   │   │                │
> > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > │            │   │                                   │   │                │
> > > │            │   │                                   │   │                │
> > > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> > 
> > @mani:
> > 	Do you have chance to review this patch again?
> 
> I was on vacation for past few weeks. Will take a look in the coming week.

Ping?

Frank

> 
> - Mani
> 
> > 
> > Frank
> > 
> > > 
> > > This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> > > 
> > > Original patch only target to vntb driver. But actually it is common
> > > method.
> > > 
> > > This patches add new API to pci-epf-core, so any EP driver can use it.
> > > 
> > > The key point is comments from Thomas Gleixner, who suggest use new
> > > PCI/IMS. But arm platform change still not be merged yet.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > > 
> > > So I still use existed method implement RC to EP doorbell.
> > > 
> > > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > > and update this patch.
> > > 
> > > Change from v1 to v2
> > > - Add missed patch for endpont/pci-epf-test.c
> > > - Move alloc and free to epc driver from epf.
> > > - Provide general help function for EPC driver to alloc platform msi irq.
> > > - Fixed manivannan's comments.
> > > 
> > > Frank Li (5):
> > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > >     controller
> > >   PCI: dwc: add doorbell support by use MSI controller
> > >   PCI: endpoint: pci-epf-test: add doorbell test
> > >   misc: pci_endpoint_test: Add doorbell test case
> > >   tools: PCI: Add 'B' option for test doorbell
> > > 
> > >  drivers/misc/pci_endpoint_test.c              |  48 +++++
> > >  .../pci/controller/dwc/pcie-designware-ep.c   |   2 +
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |  59 +++++-
> > >  drivers/pci/endpoint/pci-epc-core.c           | 192 ++++++++++++++++++
> > >  drivers/pci/endpoint/pci-epf-core.c           |  44 ++++
> > >  include/linux/pci-epc.h                       |   6 +
> > >  include/linux/pci-epf.h                       |   7 +
> > >  include/uapi/linux/pcitest.h                  |   1 +
> > >  tools/pci/pcitest.c                           |  16 +-
> > >  9 files changed, 373 insertions(+), 2 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
