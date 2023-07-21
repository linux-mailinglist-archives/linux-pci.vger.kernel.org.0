Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5DD75CEFD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjGUQ0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjGUQ0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 12:26:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B643ABB;
        Fri, 21 Jul 2023 09:23:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4qFMjjrEohpdNqoQxdUo2UESp/oxNtsnILoxSWRGTcTaxp/lHeh9QqQ0MqDlmWxjx5UktA+jvjtOfrAzzf8N4TaRDPMHmekAYNGOTMQXwM+vZG1FYnc/RmzIJIIOsI72Lb8sn8WV982TdieGozchZYPayQQHwikSKipiaJywpC+tzscW3r+RUKO03KxI3kg0DBBCidmvJ1+NPrujIcvg5mUVV3QE/BYL+89pTPrRpafalemVpj8gv9Rtpu5W7w8AgNHHMeYuj+n3f5i6paOnkPLs+9stmBDSxRwfliFtzhXJw2dpCrN8fyjrpeBX+pBKZW7vYxeE1DDDZ9mObHCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AXxNZYV5AqcMSbwWRmxRv3/GZrtwZ/ftRzRZwL2mGE=;
 b=hFoR7TmEFVnNhxMa4G0UcUAXJPh7s51xEeKJ2tcQpe6X00YU7gPClWwyBaTmUyyuT+i0AcmiNFoxG9kMSZ/Vga/f1sikb8FZ15y9JRCFJtJcM1jDsYS3pYr4Myg0NgxGM/wJMJl3xdanroFlzOEnRE4JliAUII7aPyH8iUyxZ8ZPLSP3Xw+K6zhdtsWlhPULghmWErL0a6PSI+CZRUdtoxfMVN1vrimvKSpO1CDS1rDbiq5OH7SVxc2aXBbrfEaIKDJppA7poagqmwdxwVtXd/I4R8L7tBZR+Str1EjHgdYX/ogs7SMilEePmVkAX/fctXvi07sdB4D987jv9VAerA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AXxNZYV5AqcMSbwWRmxRv3/GZrtwZ/ftRzRZwL2mGE=;
 b=bD1/0/WiX1ccTPIa54gIlcPnk8qgwUT33c2gPP2Sj2mi31PqIZA5bwI0p0vjwo/FHaCEu5kv16bPY7t5TAqxL1D5QCLFE+2Rk2o6vkW0kFtgaICMmlEfNjIFhox2c+3+zcV89VTePYD+itKPeRAhOahtBxVsYOmAOT6sOUj7pVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7680.eurprd04.prod.outlook.com (2603:10a6:102:f3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 16:21:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:21:54 +0000
Date:   Fri, 21 Jul 2023 12:21:38 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
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
Message-ID: <ZLqwkvoOszggGhLK@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
 <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
 <ZLqRwxmQr0jrhS3M@lizhi-Precision-Tower-5810>
 <20230721160755.GD2536@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721160755.GD2536@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f19a52a-aa1f-47df-5c30-08db8a0698bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3ymwkhE4h37F6XG8ZWsEOZvI0PDYU6EP041EuvS//FTJeBfW/dgnJqtlwLigEbIMwxTQO38QZpAxv4sIJlpeXfwtcxp1bVafzGmzT3tM7t+k4WKXrSn3UajNftlPG+goHXusCryC+NwXrABkNMqTeLZL6Bny4E/IwE16dfgocKZLkrdEc/QG/KJ7uXS/7T9r5feG434LxvRD/n+DmgAstGOKGGUHusavZvRlWt8Zf4plqOTbc0lmDqdL3P/R1wNl6NwjTzzIZEcSzWWofENXfG90G53gXz4fl/URNOwjK6o3Y/n2pzmztUKDVxNYUIIAvUubuDaBFWzGuKum4mBPeHlmkOdZy83474UdxAXTxoBvT5mHI8MLoPZHs1q8p7sQ9CPPNdqTkJ8JiypGQBkyqQYiA7Yvvo3zMLhoCa9PV9yTndbqF0dzPM0wSNBL/uDFeJq75HfcRwZko1ARqR6Vy5ASB1pbjKP66PyjHJDGGJ7zMB256G34MQ6MYlWDr4qF5bMLcAofrvP9Wwnru3kxI74narFaFqcJvhnlPW3gyEmhoF6ALIH6fO+hLEJ0re82RzUqoxp9r0hf+iMtC0Pwgenbha+YlTZdovpKb5OuXyRwdI8aoca6wsCPc+Yf9A7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(6506007)(53546011)(15650500001)(186003)(26005)(478600001)(5660300002)(33716001)(41300700001)(316002)(6916009)(4326008)(54906003)(66556008)(66476007)(66946007)(8936002)(8676002)(7416002)(38350700002)(38100700002)(52116002)(9686003)(6512007)(6666004)(6486002)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnUzbCtxZHN1L3dZejY0NkVJTFVKSTZnT2lTWStab1FvdWNwTUpwUlZPWms4?=
 =?utf-8?B?WHpLZHFIVTJ3M3dTNG8yRXlyWXVzV1J4Ryt2akJzMUk1ME9NcWFsWWNjTE81?=
 =?utf-8?B?enlnbm96SVFHTDU2OXA0blQ5UVVnTmg5Z0x6TUJ6amYxUHhsQ1N6UUJSZWxw?=
 =?utf-8?B?OWwzT0FLcFFDQnJTa1VVY1dYdFhUNDY4V1pwZlAySittc1NHY2ZyZWMzYWZP?=
 =?utf-8?B?R0dWRmVZalBVakpnWGdVaVUwaWNNaGZlMFFZQXRQaXpXZUwraWdFelhndEsv?=
 =?utf-8?B?R2dObEJ6ZGNjL3krR0hLc0hhK3VmYXRtR2RBdWlDa01tb05VYVNqejU4amZ5?=
 =?utf-8?B?ZThva1lsMXRjYjBTZTlWbm9RSDRoRERmYnJYeEx5bXhOdGY5QnVoT0lEbW45?=
 =?utf-8?B?RHBNdTRwN3BoMlluU3NPTE1xZGNWeDJKdS9GdGtLMXRhb2VqbHNVM215d2Z4?=
 =?utf-8?B?VFlveVc5bzlkYTlYMHZscXpTL2UwSlhZMmxqTUx2blQ4ci9KS1huNlRmQ2g3?=
 =?utf-8?B?eStBQ1BYZHJnRE04eVpYMXdPbm9WeEZlNndwdG13bnBFUk9ydEp2RlNLdlZz?=
 =?utf-8?B?REp5SDRDRDM3RmZTZnZ2RmN0VXVyQzVUOS9YL1owM01FUmU4QXZ3TlRHeGxU?=
 =?utf-8?B?b0c0NzFvU3hWNlV3dUw2OEdvVGlSMmxuN1krZ05mOU5Rd3JGdTduVytVdEFX?=
 =?utf-8?B?OTk0aWpRcHpCZnRjMXVkSXAwM3hzaCtUOWUzOUNXTHBGbHVueUh1TFJLY0VN?=
 =?utf-8?B?cnRXRmRKbldlamFPTlRyd1hsdnhhdFNjVnRWUlgyNlVld21FZmtMd0Y0QnhS?=
 =?utf-8?B?eHhMaHNWSHlaa0FxaVE3dkd6aCs2QTU0K3R5TkNNNzQzQ0Y1WHRTT1E3S3hu?=
 =?utf-8?B?VldYMkdCVkdrME54V2dZbS9BUkJ1U2dVcmpMcXlGalQ0bEhlWFZvZmlQaTFS?=
 =?utf-8?B?RFZWcUtVVWh0UEFiNFBDdUYwSmdhZFhTcEM4UGtZRXhnc3RIejM2aHJoWWVt?=
 =?utf-8?B?aGpsbGZpVFVIYi9FUXErUjJxU0k4WllZVmthY05TS2x5bkc2bk5jT1pyblZS?=
 =?utf-8?B?b3VXUk15eWR1VDFERVN3L1FxLzIyTDhOcTV6MUplNDJ4TDhRUVJTQi9CZEN6?=
 =?utf-8?B?dm51SERSMEZpVXBVYjh6TSt4cXVndHprdUtDYTM5TStMY2hObkF6REdtaXVm?=
 =?utf-8?B?MDhuSXRXYmJ3M3p3TWJRL3BHM1RXRUMwWU5PaWhPY2p3QWlQMFF0K1gvdlVi?=
 =?utf-8?B?OTc4dTBXOGhQRnV6QzNEOEIwSEE2SnRHMFhJNUR5SklnYTNCVyt0TmcybXVN?=
 =?utf-8?B?T0R3ZE5LekF6MTY1OTZvOUttdXVzWnFuOTQ3N09IRkVQUWIwRytPNktZc0Ns?=
 =?utf-8?B?aW5nUjVGY3c1bDdhUnVDeTJyTis1aVVFTlZQWklUbDZOV2tHaTV5NlZubFc4?=
 =?utf-8?B?ZDdOeTFWUFJiNTdlVVMzQ3MrQXNuZlk2enNIOWgrZnQwUUk5WDBhVmJGcWh6?=
 =?utf-8?B?Z29NeDk0Rm1DeEVhZEZaNFZqMEZnaURiUndBeEdMNjN2U1VDdkxlbUVSS3hk?=
 =?utf-8?B?cHZzNHFpRmZHeTNQN2xCZ0J0SFo1RVFpVCtUNzZWcWtpd1BMaEQ3QzVTOFBJ?=
 =?utf-8?B?YzBjTEV0V1JpQlBuc3V5bzZxbnovZmdCS0l2YVJzY3ZRWjUwdmtTRGdLQ255?=
 =?utf-8?B?ektlb3lJY1doaVZkb2NsZHdWeW9yblhKZHFOVEhtZFR2VXpvQUU3ckFrWmVr?=
 =?utf-8?B?K0hEMW92SGU3QXAzUEd1YXBXWCtycFE2c1dIeWM0UlRsRkRhMm41REsxLzNo?=
 =?utf-8?B?aUZqdy90TEp0M0F3YzJDMzF0Z1RhS0I1SURKekJNQlh3anZ4eGtKV0drVm9C?=
 =?utf-8?B?MkdpT0JIVFhYeVVZNng1dGdqUjBiV1FXWFZPSUlPS2l1SHpLbU0zVUxDMmo0?=
 =?utf-8?B?Y1JDRGl1SUhPcDBrWllpODlHOGhiZHFaVzNlbmt6Y3RFQkczYmt5alhZSTdS?=
 =?utf-8?B?amlSaXNiaWJNaXB2YTNDVDZkaDcybHhOM3JJaVRLcXowTnRwNjc4bmE0dEtv?=
 =?utf-8?B?ZTBIQ2VOdlhnS01pRE9HNXhJR081c2s0SXRwaTI2d1lpT2V2dVRua2hGbTM1?=
 =?utf-8?Q?o6tE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f19a52a-aa1f-47df-5c30-08db8a0698bb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:21:54.2916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr4EuJUjo8HFWmGeZzHNPzWA5BP6bARLWw7XD3Wxn6pbNXWy4PSEBMC2wNb1UYREprWYT7OM9ubeENi1+im2LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7680
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 21, 2023 at 09:37:55PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Jul 21, 2023 at 10:10:11AM -0400, Frank Li wrote:
> > On Fri, Jul 21, 2023 at 10:09:18AM +0800, Shawn Lin wrote:
> > > 
> > > On 2023/7/21 0:07, Manivannan Sadhasivam wrote:
> > > > On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > > > > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > > > > 
> > > > > > > > > > Typical L2 entry workflow:
> > > > > > > > > > 
> > > > > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > > > > 
> > > > > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > > > > 
> > > > > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > > > > PME.
> > > > > > > > 
> > > > > > 
> > > > > > One more comment. If you transition the device to L2/L3, then it can loose power
> > > > > > if Vaux was not provided. In that case, can all the devices work after resume?
> > > > > > Most notably NVMe?
> > > > > 
> > > > > I have not hardware to do such test, NVMe driver will reinit everything after
> > > > > resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> > > > > at L1.2 at suspend to get better resume latency.
> > > > > 
> > > > 
> > > > To be precise, NVMe driver will shutdown the device if there is no ASPM support
> > > > and keep it in low power mode otherwise (there are other cases as well but we do
> > > > not need to worry).
> > > > 
> > > > But here you are not checking for ASPM state in the suspend path, and just
> > > > forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> > > > expect it to be in low power state like ASPM/APST.
> > > > 
> > > > So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> > > > you'll ending up with bug reports when users connect NVMe to it.
> > > > 
> > > 
> > > 
> > > At this topic, it's very interesting to look at
> > > 
> > > drivers/pci/controller/dwc/pcie-tegra194.c
> > > 
> > > 
> > > static int tegra_pcie_dw_suspend_noirq(struct device *dev)
> > > {
> > >         struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
> > > 
> > >         if (!pcie->link_state)
> > >                 return 0;
> > > 
> > >         tegra_pcie_downstream_dev_to_D0(pcie);
> > >         tegra_pcie_dw_pme_turnoff(pcie);
> > >         tegra_pcie_unconfig_controller(pcie);
> > > 
> > >         return 0;
> > > }
> > > 
> > > It brings back all the downstream components to D0, as I assumed it was L0
> > > indeed, before sending PME aiming to enter L2.
> > 
> > If current state is L1.1 or L1.2, hardware can auto enter to D0\L0 when
> > there are any PCI bus activity, include PME. I supposed
> > tegra_pcie_downstream_dev_to_D0() just make sure come back from L2/L3,
> > which may enter by runtime PM previously, or other reason.
> > 
> > NVME ASPM problem is (at least when I debug at other platform about 1 year
> > ago): 
> > 
> >     1. NVME will not release MSI interrupt during suspsend.
> >     2. PCI controler enter L2 at suspned_noirq();
> >     3. CPU hot plug try to down second core (CORE1, CORE2, ...)
> >     4. GIC try to disable MSI irq by write config space.
> 
> Just for the record, this will only happen during deep sleep (s2ram) where the
> CPUs are powered down (including the boot CPU).
> 
> >     5. panic here because config space can't be access at L2.
> > 
> > I suposed tegra should have problem when ASPM enable with NVME devices.
> > 
> 
> NVMe suspend issue has several faces:
> 
> If NVMe is powered down during suspend, it will result in considerable power
> savings. But at the same time, the suspend should not happen too frequently as
> it may deteriorate the lifetime of the device. Most of the recent NVMe devices
> have 2M power cycles (only).
> 
> We can workaround the above lifetime issue by powering down the device only
> during s2ram. It will work great for Laptop use cases if s2ram is supported.
> Unfortunately, not all Laptops support s2ram though. And if the device is
> powered down during s2idle, it will hit the above life time issue when it is
> used in Android platforms such as Tablets (even future mobile phones?) which
> doesn't support s2ram.
> 
> So I'm thinking of the following options to address the issue(s):
> 
> 1. Modify the NVMe driver to power down the device during s2ram (the driver can
> use the global pm_suspend_target_state flag to detect the suspend state) and use
> the same logic to put the link into L2/L3 state in the PCIe controller drivers.
> For s2idle, maintain both the device and link in low power states.
> 
> 2. Get the power management decision from the userspace and use that to decide
> the power down logic in s2idle for both NVMe and PCIe drivers. This will ensure
> that the NVMe device will be powered down in suitable usecases like Laptop
> without s2ram and kept in low power states for Android platforms. But this is
> quite an involved task and I don't know if it is possible at all.
> 
> I'm just dumping my thoughts here. And I plan to intiate a discussion with NVMe/
> power folks soon. Maybe during Plumbers?

Yes, it is big work. Anyway, if DWC can use common suspend/resume function,
it will be easy to be updated when a better policy applied at future.

Frank Li

> 
> - Mani
> 
> > Frank
> > > 
> > > > - Mani
> > > > 
> > > > > This API help remove duplicate codes and it can be improved gradually.
> > > > > 
> > > > > 
> > > > > > 
> > > > > > - Mani
> > > > > > 
> > > > > > 
> > > > > > -- 
> > > > > > மணிவண்ணன் சதாசிவம்
> > > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
