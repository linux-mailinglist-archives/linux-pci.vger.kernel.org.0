Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200A275B15D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjGTOiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 10:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjGTOhz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 10:37:55 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB026AE;
        Thu, 20 Jul 2023 07:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVTteGAzLp8VDSvnkYWex/Gzm/uQrXoDT5pAhiWIaxnQFFx6wyzOERBT/psQgoPR4/gvxZQ6JiiQOhnsuchg7/VIzbt6Hs2S0IOOa8k9i3G84OMbcS76usmoDA1KviLCzp0PKyhRC/+O52Gt75R5AlDLnDHK/iTJs1YkdYH8XXKcX9B8C8Q8u0J28aPUo88jwL8nZ3F88HdASXz0X+bVZmH5qxhxqNHuWb4TcRwi3Mwr5gnRtiT/y/EP9IZ6QD4vM9vtQXYOJCtWKQzSr959p6CNCygJh/s7uyJ0gMR64EZdiKe6UK4oQw/2rHN5utayvPlN/ILN06z2ZJESC9S1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8az8gR3DmDYfQJ+G9Kvddl/2g/jlbfQop/VK4ZbJbdU=;
 b=N3bT1/iSFPFrv36RtFBIRh0pRbHN5QOCqPdA1PK1xMAWCDmTLsHr42VXmsd5kGtK5yZjXTXmjS4zf3TU9TQtSGGbPzJyVDiLNvD+jKFzDaA921vVcTWc9OYGyhV01iJs5foQMthqR0dv/59ZW1ZuKa5itkZ+PbZ+lDdYyUEG3VO0kaTmtlmD3TmRmawxSA/VZO1nCdcmROUAvW6fONXAvSuA1qGohh+dqU3J+Dlp/RlxsAcqlpPRKE5scFs9w+iacCMB75eiNKmzmf9XNoKULC2tZlFsjnQiVftESZ5qCWiGxY12ihHOCqeRoJZEz4CR5lX0TYYwSTVhvqsy+38i6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8az8gR3DmDYfQJ+G9Kvddl/2g/jlbfQop/VK4ZbJbdU=;
 b=Y24TqXrP+CVl6EliiAKlOzeUUZqAlpaT7w2sioRJjBxjKZX8EwFBFVLOdQUusPq69Lr87N/Wmk0A7MSLp8q8f0MscMzcJ2RKoQBlfWmW6MtXf5LaXVQDmZKmBCxxsYHOBdg4Ke3tJs3swpe1lmFLItWZsNCJ0ZgfCownEefvCF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 14:37:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 14:37:50 +0000
Date:   Thu, 20 Jul 2023 10:37:36 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720142509.GB48270@thinkpad>
X-ClientProxiedBy: BYAPR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e2a077-432d-4af1-ebb2-08db892ee4a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFE02nqwz+pplkfRcsIZ1YoTWrWsMhKu3RAJ23Hepjz6ImhgHeHqoLuutaLEAEva5recr3ML28/yFsSmWotigJW1Yit6Lv6Ch+av/c19vsJtRBhxTbuYAm846f8hpveONK8rHh2xSEr5vpKgkCaDeuFkKriPsBmpPFXXxJQCiyHt4bGWPvAk5NHQd/UTDmkXZLIpAYOSRUtbel2wgVv7YdTG17O4JXw5HaD6pGc/yVjF2tZxzICZPn5ZwKjfwOFrM0FAUqEh0Sd1u3RLK+ObsMO4bLK0F28wtr5r8106jimPnlRO8VrmQF9Z0kZWEF9Xa0u2KLKMqn65RVLe6pvxMhWA0BsEAsktBYQ4nqhpIWwBguna8szad4XcBTaPSR3+Y9r2BuH27+vBx2n60xg0oSYAeUlam39o1lcCENofzWlMJlrr60lankr0bhRdYs1BmfhYa4+pY6bzDAt7pt/UkIMZrgZRsUKuRwonIC7prw7NQKmxZBmEoyjKBFkwcDDFb0Nt4CngORIwQ3bWb9PzwitJY7wXtcv7s3YkZqSzvGynAODLUIjm2Z7fL3zuIS6/NbysLpsN5Byh9CqAAcUhOb2wsZ+nakxH08hEEpJorc6Bd28N3ui1MksHb4+cQ8tO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(33716001)(6512007)(478600001)(6916009)(52116002)(6486002)(316002)(66556008)(86362001)(66946007)(41300700001)(66476007)(4326008)(6666004)(186003)(9686003)(83380400001)(38100700002)(38350700002)(6506007)(8676002)(2906002)(8936002)(5660300002)(26005)(15650500001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ROQ2pzODdldTFGWU5pUStLTmtSUU1YUmdPNG1obGZydkZRYzZkYmw5K3p0?=
 =?utf-8?B?UXFoalV5c0NKZXdoV21IdnllMHRzNnRzRkROWDZCR2d6VElvMEN0d1ZHSGY2?=
 =?utf-8?B?VklUMTVyd3BiU2k0OGtBbExmemUybGhYSXg2bnUwQ0R4WW9UekduOE9Wd1BY?=
 =?utf-8?B?NHIyVUpHcUQzZmRjVkplSytPbEE3VHZkMjVtMFlIeDUxT1hVYTRyd3RGd1ho?=
 =?utf-8?B?Q1V3YkF4WFNBK2FRczlQT0dRRjRKVWw2enJ6NUhud0VobmtLVWVheCtqWG96?=
 =?utf-8?B?em5KTno4SXBZUzZINmdxeTVKVzhZNll5MjMrVXZTUTMzdnNvRGo2a3lxVW9h?=
 =?utf-8?B?dGVGcStCQ3N3SXRZM3YyVzJHaXhHNHh0NXg2cU9QY1BCVUs5aG8zMGZPT28w?=
 =?utf-8?B?RTA5OUZKTkVsR012cjFYbHFmTEduQXJsSXFBdkx1TFE2SVNEV1BxWHZwUy9r?=
 =?utf-8?B?UWsvZjc3SnZmbjdLVnUrRStOdXJQNDJra3BLcDlIdWIrN3k4d3ltUmRUSkNh?=
 =?utf-8?B?NGREMFBUdVR2VktpL04xZVViZ2lFRmF1cmtHTDV2NktvVFBQSGhHc1BzVnNq?=
 =?utf-8?B?RzljSUNIK1NHTG4xa2dDRG1PRU9ibEhwSkxmSTUwVDNDOHAyMC80Qlg3Y2ps?=
 =?utf-8?B?R1lEZE5FNG1pa1RaMHVMY1RSbXYyU2wwb1N0T0VldVhCc0w0TFpydHZFOW9Z?=
 =?utf-8?B?RFVRbit0WUtDN1JQZXhYaWc4KzVZMzI3SDVqY2s2ZVpoZW1UOHpaK09IN0JD?=
 =?utf-8?B?UGJ0R0VXelZTU3pKZmQwRDd6TEpNdEJzaWdXbm5ucXhFa1dUQXJNVFNuNWg5?=
 =?utf-8?B?R2pwcG53UzlOTks2eHJobGIxWmNRVm1pY3cvc0lOK1RGTGhRWFZvR2laY3Q2?=
 =?utf-8?B?cFdLWnRWcUJ3TEo3em1IK2VVTHdhVEJDQ1NuMXJTem1VSVA5ckRWaGlWeVZK?=
 =?utf-8?B?bnJlclZocEp4VE8yekJIK2pyYndreGwvbHBNK0NUTU4rcVRNai9jcnNtRlI5?=
 =?utf-8?B?b0tUYTZ0VFJrWmtsemNrYXBxMjVmTVMxMmRsUGF2K29zRUgrUXpTRVVSU1ZV?=
 =?utf-8?B?cVpRNnNYR0hWMitrQ0w3YTRmUFVRamYxazJkdnNuV3hVUmpTSzJLbXBPUEMz?=
 =?utf-8?B?dDcxZlYyeWhuQkRTS0NiYTJpQzhvY2tyK24vSmFTMXpFUXVtY0Y3Z0tLVnht?=
 =?utf-8?B?WGlXNVA1bVNHSUpkMnZzR2NLSk50MDZSV1pOaC9PTnAzK0o0S1B2VlNCRElZ?=
 =?utf-8?B?NnNCUXErdTFHNVFBNmkwOE11MGZEN3YxVjFDb1hqVmRVdk1IZ3o3Tmh1R3di?=
 =?utf-8?B?UDBLYm1sRm4vWjFDRGwrZ3lGYXVMbGUyQmJYSFRSSUxjMUM2bVk5SWlFeDhq?=
 =?utf-8?B?V25YZVFVUC8wMVBIVXI0d3dGOWJrVFhPSWloZFZsRnhONFEzeXNVa3pNcHpt?=
 =?utf-8?B?Zk45ak5VNFQ1WjdubWlQSkJLZjcyUzl3WGEwcDBjWmFXTXJsT2FaOVdOb0s4?=
 =?utf-8?B?ckowT2cxeGdHa1g5aS9IZkxYN3pIVWorUTJ0MzQ0R2ZUTzkwQUhSMXFneTA1?=
 =?utf-8?B?ZkZOaVR6b1JlMDJWMUJKSjRnNlY1aXJYVGw3VEFwMGs3STk2azVyS0RSQ3lD?=
 =?utf-8?B?aW14WUpidlNnd1J2Q1EvQ1lhWFNrMW1QeFoyVmpMQUNrR04rREl2SzNlNjNh?=
 =?utf-8?B?a2h3RzJrMXpId25VM0FnUk5Rb3QyN3BFbTB5OU40dHR0bVZUL0N1Ty9VZ1cz?=
 =?utf-8?B?ZTVvdEZPVnJYODBRdTV2WFNqbDFnN0hJNE14eElISjdJNkloMGNmR09HZ1Nq?=
 =?utf-8?B?ZTNRMW9ZNVUwdGJ0Zk5lYXBCa2d4MllFOTVhb1B0Q0xvcXJaeW8xMGtDV0J2?=
 =?utf-8?B?eDFsZGh2QnRKdVpIZkZTa0VWZW43L2ZTVUxQekw3Ny9ST1JrOXBjYzBiWmFr?=
 =?utf-8?B?Y3FHWmJYOUNLNWRDbnhNMTFxQ2h4VURjWmZQV21tbm43cWMxNE5XS1lmRXdS?=
 =?utf-8?B?Njc5T0JnRkNGZm9sVkpkZGt1YW1EZXhONERienU2a2tXdnNOWTF2eVlhQllP?=
 =?utf-8?B?eW9reGw0S290S2Z6Und4YWgyN3dNTmRibisyS21MY2k0L2pWV2hYWnZnUzBH?=
 =?utf-8?Q?PJyKyb072PwCMGNyh6PpeC8Ut?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e2a077-432d-4af1-ebb2-08db892ee4a9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 14:37:50.2332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH02jsokC5Usyp+NSNrcSJM5KpNky9GJIOtlIzowTvKyQUjUPvvo6AqmZOdP/csRw/MfMVuSwbml83ACJ2AWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > 
> > > > > Typical L2 entry workflow:
> > > > > 
> > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > 2. Await link entering L2_IDLE state.
> > > > 
> > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > 
> > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > PME.
> > > 
> 
> One more comment. If you transition the device to L2/L3, then it can loose power
> if Vaux was not provided. In that case, can all the devices work after resume?
> Most notably NVMe?

I have not hardware to do such test, NVMe driver will reinit everything after
resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
at L1.2 at suspend to get better resume latency.

This API help remove duplicate codes and it can be improved gradually.


> 
> - Mani
> 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
