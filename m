Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB30C75C940
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGUOKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjGUOKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 10:10:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FDB2D4C;
        Fri, 21 Jul 2023 07:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG4zC/uAdTFt5tzQuOdh0e387mYrxS8nUud/XkUJYAJ8EKnBeiEuTuSB06pP6NICXR1tFpiVpXaz8Ezk01J64SuLfhE2TSB5ZElvT+5Vv/hnfoK2HXo8W8H/4U3fwfidTUSe5VW0ntfm+QgpHwwUANGFmFwgPhJdBgZSKOMxFWcpLlJn7Xz/HnbjLeLrBb0BL0u59kO3s+2z0eOOJ8BLbtRhVVdA1ooXR0qJ6vD4rc8UzcMnhviyz/7fYU6lxoHza20vH0/EpnqgAbcEcqZXX8LNkmV7wLLIpEQtoeM23UXUUlxWBOyhAl2GwVvcnXSz3nGiV12ISEzgEIuEd78cTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vweO65zncnXGcKsw8XnRSycf13bKgrFa+UEk3Tzvfv0=;
 b=SQz9JefIi5urcDOuUrihHk3AZLtvi0LXcz5mRgZMp3NmeWPtztdkfe5YToWtVO43Vnx2ZsC3e84CoBNKgpcF20D+7Z+5B8Umf2sMAUjDHlKBL7QiXzgejE95zBiVa2FHQb8oJpPYPxUBFm4pYXsOgEMeFETaKCkUB2itgvn+ASrjnhf/U9Z58NsWlNQqc0ssh/ElzlfQV1EqvgXHTuc8MwGRg+pmCr97lYqaEwPjmozcuIxeOjCHyt6IesZfdaEAOqkhsDDr5xol7yw+9astN3URICEZzXUMuWW+D2kA2F88Qsnaenh6L/a4xcpcg9xDNARrCbTZayQsXAY+OmoXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vweO65zncnXGcKsw8XnRSycf13bKgrFa+UEk3Tzvfv0=;
 b=D6Pdr1Stf3DOO9hQFt6FXn2lT0rh+OuEVpuppKIXfyekEpewc9phekmM28x/vTIjLaM+SJi8mfvvA1DmlE4qRqJv3542a6vGEzsFzOytolfGWwO25LlALo1BctJgHto/0tCuEak5CqHipf0TAI+gHQH1atWNvcJN6mP7IlQIsAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9315.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 14:10:36 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:10:36 +0000
Date:   Fri, 21 Jul 2023 10:10:11 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <ZLqRwxmQr0jrhS3M@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
 <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
X-ClientProxiedBy: BY3PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:254::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f59edaa-665c-4b49-bce1-08db89f4414f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rekWOZgvoIHXcIpDqmudvv3fiDfChKa+xDGJmxkRH89ONJtn/npUNSMi/CxxZTacy7z4QkfHfMFAPE1IIA4LdF2pF3Cvm+sSWegPkE+BuR4vMjyzQQen6yyV0huFIbpK+B3RhW5fshAcV55HbU1NOVK2zQd7gvh0H6h+YXtdVHDexATOy++4GH2BeDTMLxn8Be/HCf0h+Wg4sMrNJBzFDTQzPqRPmZV5oIruMuOllgAKVgxBM/+71tj1+VgyGkaLntVSlbCRBLjvZBAUclHORXt1kz8cK6YdySzpt/f3rYujmIR3FggHB6aa8ts03pYAcMDnA0j/dHmuaNrnEspjU34SQnDNYBQfvnfgYWHYwB1RdLJKdBgVLnymAPmOAJxgyNNXeUEL20neBgzuIelbUjKSocaSqBN2VThgHeojgQbpuyI0po/+eeCdho8YwDiQUQLBBCbHqNgzIUelFpzVkAZYRrmJ0ilZWsGEnjsyWmkV5FK7BlT9qTg2rBZZl0Uw8+JlNVsB/g1acgy7QULLOF1nkD5bLR1FyUZamqGC3AFD198E8gYP+xa1/1bEqtMxSnmOm5d9qNai6o7hqknhZ7a/PWQ2YnfVWxX6inct1djbHplHqbEtoGxKQUMyG4m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(478600001)(83380400001)(26005)(53546011)(186003)(6506007)(6486002)(6666004)(52116002)(66476007)(66946007)(66556008)(54906003)(38100700002)(38350700002)(9686003)(6512007)(4326008)(6916009)(15650500001)(7416002)(5660300002)(41300700001)(33716001)(8676002)(316002)(8936002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M01YeXNSTTUrRzkxSDVHRHhobjNzT1ptUEk0UkgvSGJJMXJlYjY2UVUxeUdB?=
 =?utf-8?B?blZCZGJtaUNwQk5Uek9GSXdrV0dJYXFFM29SWkJDc0V0S2w2bXBhRm9DL2tG?=
 =?utf-8?B?OTZ4dDZMNWhVclQwSHRBN0drOU0vazhTVTRBQ0RCZytnUnZxQ2lyOWI4WXBJ?=
 =?utf-8?B?QTk0Y0xET3lIVWttUHVhK1lsZm5waGJsL0YzeVZxZE1NWkxFV2NCdnJZbFEz?=
 =?utf-8?B?MUhVMUlMUldmc1VHYWExdldwUmd0SDFVbVVYUXp1aGJ4aEZPTHNwWXVGNzA5?=
 =?utf-8?B?VTZwZ05DbnZmc2lyQW5wT0RlREdBeTdmUVRkaTJKMW5QYTRvVHJ6dnFvNTgx?=
 =?utf-8?B?TUoyMW9NaWJTNGNlL0RkRFF3eG1IMkFWdHE2ZUVMUEhXTTIrUkhXcFpCeTd1?=
 =?utf-8?B?UmMvV29wcVl6OVhmYWlROWJ3eFdpVzRaM2RZMVhtMmw2VzBoNGdqTVZjTndy?=
 =?utf-8?B?STBReHozWU9KdXk1ZTA5MHowQ1JOZlVocnQxQ1hXSXBrRlNwTjROOXo5OEk2?=
 =?utf-8?B?cElYeGtaR2FTNWRyQ2gxR0RCK0YxU2tjMDhGLzVoS2NHQ0RGYkRyaEVqUFJJ?=
 =?utf-8?B?bG9OTlBqNkZTL1pOZ2JYcXNRNkdZQTEwVlJTZkRrVG1EODAzb29EMUJJUGZ2?=
 =?utf-8?B?TjlJUEZzQVdxc3IyNEpxMUFGNDRzTExOeXdmclB2M012M3o0UFRER2JtMkdi?=
 =?utf-8?B?Z0FnUEU4TnZSd1E3SlBjRXVCMUwzQlZSOEVRVG80b0x4cTNXYjQ3YWsxZjRK?=
 =?utf-8?B?YmFTTFZ1WVV1aEJobzFPQ01BdzhxTHFFUlU4b3B2cXlCRXZiRlE3T2hoZlFE?=
 =?utf-8?B?V2FzcllSczBNeG14cUFxaGNHOGZ6eStiLzByQ1F1NmQzQjI2UzNCSEhOZ2Fk?=
 =?utf-8?B?WHpiUlRrOVlVbmdoaXB3K2hXaG9OQzZhU0JuTUJvdUhIQ09PYW0rTThuaHBH?=
 =?utf-8?B?WkRqNHBQbXVvMGdNeGlaRHBHZW9lcmJodGd2WmIxZWVYN0VmUy9tMUk4b0Ux?=
 =?utf-8?B?SnNGQlQzSk9taHBPQk9MMFVReVBIdE40RTkwRkd0bTlMTVltRklDMWFCS1dj?=
 =?utf-8?B?M0tIcDUzODR0Tmxid0N4aXNBcVZ5Z0QrWGxaL3dqUFQ0VGpndjZXSmJiMnJr?=
 =?utf-8?B?SC84SDl5eGdUNmxYa0szOEJWajBwOHo0SGtpSHV2dUdTS3FjdmRENGNTK3RP?=
 =?utf-8?B?K0xoQ3pLRmJxWVNyZi9NcFNEa0wxNyswK0FTSEFMQ1A3aTJJdXBLdXBZSHVY?=
 =?utf-8?B?TzF2aHEyTmdmWndPWm5rWFZNaHlkKy9QREpablJEMnVpYWNRcFJNeENXNkZw?=
 =?utf-8?B?dDU3K0duRURtbld5cG1FRVhWSXNQNk5hRU13WmN5emEydlNycnhrSHpBSzhh?=
 =?utf-8?B?em9GcU8vMWtuMXlwU0M5RFN4ZjV6Ymw0c2RicHlPTkRHSWRncEp1cUR0WDIr?=
 =?utf-8?B?M05rVlNZWXJ3ZWZya2g0RnVia1gyQTg4dXhjZk5wZ0NPKzRiRitOazVjTXFB?=
 =?utf-8?B?T0xlOEs2bGpqb2w3QkU0bW1HWFBpUWFnV2J5QnlzN1Vxek54WmYyckQ2QWxJ?=
 =?utf-8?B?ZWxQSXdkZHppSDZqeXJTMTNvbERCVnBUUFZpemhHb0I4clNEeVNuUTFMUWRR?=
 =?utf-8?B?RHM0QzVBRHpjMEtmVXpKTFZBMnpKSTF0VUpHZ2hrNG5vTWp0ZWF4VHFVYm5Y?=
 =?utf-8?B?Q2pHUm5kei9qNHNVRFRxZnpyN1Y1WWo4Ylc3Z1hoV1l2ZmpOYVFOaWVmbUw4?=
 =?utf-8?B?ZG85TUMvNWp2WTIvbjd6cHNNWW5lODBpV1Q5K3pINlZUcTBSL1JhdVRWQlgx?=
 =?utf-8?B?ODNtN1M5eXR4dkxxNUVpZTNjYWFYdGZrcjFMaTlDdi9xNzQvNFpIYmRwYlpy?=
 =?utf-8?B?WmZHMzFlQmZXd1JFSWtDdEZTSU1JYWxrTHhabGtGZVhmdUpWaExUb2s3ZjNu?=
 =?utf-8?B?cGRZODJha2lkZ2FEN0VGQWUwTFo0cjlHa1FPa05FcU9ueHVlR001aWVhZExr?=
 =?utf-8?B?clNWSm4vU3gvUW5VNkVJbE9nQ1hVeCtxMDYrYUhodFc3UytJU1RBU0ZMR3lS?=
 =?utf-8?B?UHhvb2hlUEZ5NFJrc0Zrb0hwN3k0Z291Mm4yR2VFaHRPeUJEZ2ZBSGpIZjg5?=
 =?utf-8?Q?sJtj3D7JlsGn9M7ooUKWytiEx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f59edaa-665c-4b49-bce1-08db89f4414f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:10:36.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h67eAdJAd9jw2QB0XaFfUvVAb3WvPexgVNMTYfv6sB/NUJ/7fj1wMa3hmGYHUo1m4gh2UnI4vJA8nSbsrUJ+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 10:09:18AM +0800, Shawn Lin wrote:
> 
> On 2023/7/21 0:07, Manivannan Sadhasivam wrote:
> > On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > > 
> > > > > > > > Typical L2 entry workflow:
> > > > > > > > 
> > > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > > 
> > > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > > 
> > > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > > PME.
> > > > > > 
> > > > 
> > > > One more comment. If you transition the device to L2/L3, then it can loose power
> > > > if Vaux was not provided. In that case, can all the devices work after resume?
> > > > Most notably NVMe?
> > > 
> > > I have not hardware to do such test, NVMe driver will reinit everything after
> > > resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> > > at L1.2 at suspend to get better resume latency.
> > > 
> > 
> > To be precise, NVMe driver will shutdown the device if there is no ASPM support
> > and keep it in low power mode otherwise (there are other cases as well but we do
> > not need to worry).
> > 
> > But here you are not checking for ASPM state in the suspend path, and just
> > forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> > expect it to be in low power state like ASPM/APST.
> > 
> > So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> > you'll ending up with bug reports when users connect NVMe to it.
> > 
> 
> 
> At this topic, it's very interesting to look at
> 
> drivers/pci/controller/dwc/pcie-tegra194.c
> 
> 
> static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> {
>         struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> 
>         if (!pcie->link_state)
>                 return 0;
> 
>         tegra_pcie_downstream_dev_to_D0(pcie);
>         tegra_pcie_dw_pme_turnoff(pcie);
>         tegra_pcie_unconfig_controller(pcie);
> 
>         return 0;
> }
> 
> It brings back all the downstream components to D0, as I assumed it was L0
> indeed, before sending PME aiming to enter L2.

If current state is L1.1 or L1.2, hardware can auto enter to D0\L0 when
there are any PCI bus activity, include PME. I supposed
tegra_pcie_downstream_dev_to_D0() just make sure come back from L2/L3,
which may enter by runtime PM previously, or other reason.

NVME ASPM problem is (at least when I debug at other platform about 1 year
ago): 

    1. NVME will not release MSI interrupt during suspsend.
    2. PCI controler enter L2 at suspned_noirq();
    3. CPU hot plug try to down second core (CORE1, CORE2, ...)
    4. GIC try to disable MSI irq by write config space.
    5. panic here because config space can't be access at L2.

I suposed tegra should have problem when ASPM enable with NVME devices.

Frank
> 
> > - Mani
> > 
> > > This API help remove duplicate codes and it can be improved gradually.
> > > 
> > > 
> > > > 
> > > > - Mani
> > > > 
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > 
