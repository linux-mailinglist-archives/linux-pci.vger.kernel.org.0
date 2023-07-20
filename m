Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2775B427
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 18:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGTQ1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGTQ1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 12:27:10 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4D1701;
        Thu, 20 Jul 2023 09:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFJtuslAUsSgMqvRHXT5TxKTi/lBl5Gx2g3qjHLDylm9wGNhUX/3v1bYSt5HVavYUcpB0zgQ4O5Tvm4BbDTAA3CCjaWZu2hN3H14KygdlrwKK9uHg87+sZXFdEXAuGK61GV3cxXCG/x8bwFRaSylbXKX+ca+mOSz37p6APOUJasmrFfk1Ex48QAZKI2Y8r2VSHja4jD05CR4SCAElD5i5UkmBZVH8SxAuamu0tEtoqBXWQCUT71Ze3JhNt+VFon21uzlzHTYngKS6u7u55oeWbAtkR5i7c9KEc4Zmx8wcAh5ffY89uZMB4F8PC0UbGZCHN35sLW178phDy16S90cWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVDQuN8FbzH26I7P1amS7aeE+1RpzrewlVqm2JFjq5o=;
 b=a+DesNlL4zOdsww34ZyhZwmlCrRDc4clkaZXO5EWQOWGKwpL2ya3rt26/mqkDZuiPiV/ItO1z+Hz66zhHtGfvERIzilXVVndU7ds5yl4oyz7bYbjMD59jvGdn1xof6VVMiz1G3HiaYnGfZR+td5YLKKgaUIsUWWX8vbJ3h9tJfKb/dPBod99smJAFhbrzVr81EWyMgceG4L1Sw6FiFI7L9UW9RX+oZyUt496p/Ygc6Wd4jVPgJYl+WQZk36RvpqwBFKYgkM4WqDaOWa8/pGgrTJVpoux0PRibMS6dx9Ads1LQl82J3sllN9SQllX4auAPmai11wMqtc3agghX5aADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVDQuN8FbzH26I7P1amS7aeE+1RpzrewlVqm2JFjq5o=;
 b=BcFN/MG45l3jnguNy7cnf+wmNqk5ReRlhiECUz9Ksl9e05ZQEYK2ia1rcNGio3uPDEhUe+voLik8vAK6yU9CI2L3O9TAv+fuD7lNX0FYUPWgG0crYXGSYt+A17uoGptO6Y9FQn7KSLJZ5cYHR+VoX7CNPsgZAZMkGCLPatmu3TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9254.eurprd04.prod.outlook.com (2603:10a6:102:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 16:26:56 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 16:26:56 +0000
Date:   Thu, 20 Jul 2023 12:26:38 -0400
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
Message-ID: <ZLlgPprvtuDbGFVu@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
 <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720160738.GC48270@thinkpad>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6c4a8f-9bd0-4333-d222-08db893e2251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpJta6lrs7aPH3U4CQmelndlFD0eZhdYCKLHiLDmaovK+18nMPix23O6ggwYUZFwViXRUphxrZkqBov2YvXMonzrsrADqLZMpeFaUT+XBFVlytHlrpHenQi/br3HsNJWgvymM9ISNCPQASQe2Lwihrs4s+34c1MjzrNxl/I2c3cObflkrr2z57Jw/dbFbXCZ2b/dwDMTZWHyl/X/hQtNWt/UYyIV4b7kBG+N9SgriVfDefH0+5VMOQQHe9pWr3S9ZwHq3TMAoPgAiKMoUlGIxcWUHnFQ/ZLx8mxiBM3hAwpuf4e7jMf7uVyvnDTaxmiPXRwmyxcUrkRlUTQeGoG8W7df7DRz5Zr/s0640hYpdgwlVFSXtm9zrgjf8yIsAFP7j78yMkE/7e2D/nYXWDZSOHIweRgV/lLn0/2jHtYlVZmSqwBd/YMXTjOiTqhOndgI/6awLw3WNKogq4swdRGZygLPMIeXTqmzH7+UMwxMII6LdZV9RqU2p6xsHA23w8bBg22pbwv6zidLnceU2L4N7EAmM0nLAljYjTMWjJs9VKM2rAn1VqL44OGo1A5a4VyUg84sNNkz02E1NAT3Kb8Xvc9eWSWoL/IKRDwjBKGK0a5TFmEK1xpCxXalh3lGhKqq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(41300700001)(26005)(186003)(6506007)(478600001)(66476007)(4326008)(66946007)(66556008)(6916009)(316002)(8676002)(8936002)(7416002)(5660300002)(6512007)(6486002)(9686003)(6666004)(52116002)(15650500001)(2906002)(83380400001)(38350700002)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlZZmk3MlRMNDNPMXovaHZ6ejZoV0pHQzRzQzRCZml5MmZWMG1raHpic2NL?=
 =?utf-8?B?dFZlNEdRcUN3NEY0TWUwandXZTh2Z0ovY2NHUTNSWlRLZy9YMTdtMFlqRHVJ?=
 =?utf-8?B?dTZhOWdMT08reUsyajZWN0ZUejdwM25yRXRYeXdYUHcvQlpSL0VWV0JBUDFW?=
 =?utf-8?B?UkhGSU1NZ01WNHExRmkxd25jc1JvRmoyL0k4SXpucmJRU1p4Ukh3VWk2ZFlK?=
 =?utf-8?B?d0VtOHUvN3pHbDNKUDc1blNXY0dhcE1jRXBWTWZZZTRSTWtGUGw2WU40WUlW?=
 =?utf-8?B?OC8xU291by9DQ0dSUXpQMk1CaWxJTTdPVWw4NHcrWUEyOVZoWldia1NTcHk0?=
 =?utf-8?B?SE1jQkkzTFBjK2laM1pTUGJrWUsyWXNBckh5RUUvTUcrbytsM2NYMlBOMitQ?=
 =?utf-8?B?dFR4ZlpTd2hJY0NVYUlwN0dGVHc0Mzd5TUk3RzZSZlNxdDd6ODZnS3lXdElj?=
 =?utf-8?B?TVB1c0NRMUxzbERudVZ5NXRWNFBTOHdMLzMvVUtETmJLV0lJQ2p3NkhoR1Ru?=
 =?utf-8?B?cHYzNGtHOHZqY1N6MTV2aktJUjQ5bklYTkpEajk3Z05Ia0F5cWVSVEdvQVl5?=
 =?utf-8?B?cTAyWmpCMXlBa0tHR25qTWRVODJwUmZlZmhJNFArRG80aHp3LzhqazhQTXZS?=
 =?utf-8?B?ZUt1TnVycDJtRG1iNmFwZVhub2dNKzdQTXRydmZuaW1UQXdKSTBEbFA5bG1N?=
 =?utf-8?B?MHlZd3ZhTENOVnBsaERvVG9ueFFoenB2T2w0QXRZSGdxM3Z5L0tiR0pKVDdB?=
 =?utf-8?B?cFQ4UzhMbVhnQjdOU2d1cENyNXBHVDIrN21LYTJ2OCtBMFhMS0NLQjR0UHQw?=
 =?utf-8?B?b0w2ZmFyRG1KTDkvY1dkZTFFODhUYlBLZVE3NWJWeStTbXczTXkwR0JWMC9O?=
 =?utf-8?B?MURRRTBvdHJNRnB2Sy9SRTVKenMyVlRXOGZnN1A0dWxYaUdSbnBJazN5L2Zx?=
 =?utf-8?B?SHVjVUE2VzRBN2hlZWx0aGtzZ1hYd01EQ0d4WUQvaG9yTEwzemFrLzZUNVNp?=
 =?utf-8?B?dVMzL2tRRzljSHVpS1Q4MS9sc054VWJkWEtDU25KVW5tNUc1Kzl1WndUanJa?=
 =?utf-8?B?UkhiUjEvYm5yZnNldk8zVVArNXJnWUw4QllSeWp4VVpJdVlIRFJCZ3ZDNUV0?=
 =?utf-8?B?RisycExLd2NkeVJhVmtUa1JNNGFFVm13ZHJEOHBmV29OeXFiMm9ZUWxNR1Vq?=
 =?utf-8?B?czUrbUQ0bysrcnh6VFNRc2JySGZmNFJBVXpxTTkyYkR4ZkZlQnp3a2JpRG96?=
 =?utf-8?B?MHBJdExmVko1NytPMDNjRTlCWXVVK3hoZ092UVJkZWVMM2dBbzJBbXc1THgv?=
 =?utf-8?B?cGRlWFBmTCt5bjVJaHJVWUZBcmtiRGZYRkhvNE9MeWIzdXdlSk5nSHVjK2sy?=
 =?utf-8?B?STNDeXQ0UDBWVXRiSDRMZ0t3MUVyYVNYd1dRRzYxa1BSZHl1ZzRvaTExbGk2?=
 =?utf-8?B?dDU4MlNhZEhYZ0EzTmtla1NlQWs4NmRMcU9aZE5qVWJRV1NpMng3Q3NXYk1l?=
 =?utf-8?B?WHB5dUJPQVVjcEJGaExZNkFzUlJ6OUJELzB4NDZWbjFKR0ZHUWFRcGU3RG91?=
 =?utf-8?B?RXROcjlSeUM5b3VCT05MU1czMXhSdnBiaXd4b3pLdTAzMWlTbHRNQVdNa3Fw?=
 =?utf-8?B?VTRGbld1OUtUSHVLLzIrdkxiM2RTSzZmVWtnenkxQkdEZ3V6RVZTbXAyN1g0?=
 =?utf-8?B?NlRzVkpLQng2UEVLOTlOcXhOdkFDNnZFTTZhNHJzVHpvd0R2Q29uSzFQaTNa?=
 =?utf-8?B?Ry9STDJkWGFzRFBmWldseVBaNUtiRG1ycEdXZ09Pc3pmYkJESXpYYnFhaFho?=
 =?utf-8?B?L3R6dTVSUUk0OGNZbVdRUkRjVkFGeitvNmFIRXNVUHhEcHgwZlVZOWVxZ2hE?=
 =?utf-8?B?OUNJalJoMjd2NkM5cGI4ZzFueVVqTVpLYnkwZXpHRUw4aHI1akZkV1pnckdw?=
 =?utf-8?B?aG8ydTk0dnQ4KzhUNWttQ0wxcHpYYnU3YVU2c0VTa1lVMmRQV0FEN3ZQazZ2?=
 =?utf-8?B?TitCWXVCQ1pONmV0eWFocCtxSGplRTFOTzBCTEQ2bkJoRGN5V1p6N2lhQUY1?=
 =?utf-8?B?MWZhVVYrRzBUc1I0UzZBYy96WlRtcTNrYkNNNDlMRE1VSDhtOVVUNEx1L1dP?=
 =?utf-8?Q?fgtRhXYWNSKB/PhITy/m6lghc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6c4a8f-9bd0-4333-d222-08db893e2251
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:26:56.1198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QA1028+azEW2acbCISkCgfVJmhtKf6rkf4mNhBvLEXkFWGabu554ZsThvFskrlrbo8L2KFFii2rT2kOPsO65dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 09:37:38PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
> > On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> > > > > On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
> > > > > > > Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> > > > > > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
> > > > > > > 
> > > > > > > Typical L2 entry workflow:
> > > > > > > 
> > > > > > > 1. Transmit PME turn off signal to PCI devices.
> > > > > > > 2. Await link entering L2_IDLE state.
> > > > > > 
> > > > > > AFAIK, typical workflow is to wait for PME_To_Ack.
> > > > > 
> > > > > 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
> > > > > I think PCI RC needs some time to set link enter L2 after get ACK from
> > > > > PME.
> > > > > 
> > > 
> > > One more comment. If you transition the device to L2/L3, then it can loose power
> > > if Vaux was not provided. In that case, can all the devices work after resume?
> > > Most notably NVMe?
> > 
> > I have not hardware to do such test, NVMe driver will reinit everything after
> > resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
> > at L1.2 at suspend to get better resume latency.
> > 
> 
> To be precise, NVMe driver will shutdown the device if there is no ASPM support
> and keep it in low power mode otherwise (there are other cases as well but we do
> not need to worry).

I supposed this should work. but I have not hardware to test it now. NMVE already
sent shut down command to SSD, which can safely turn off. after resume, that most
likely a cold reset.

> 
> But here you are not checking for ASPM state in the suspend path, and just
> forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> expect it to be in low power state like ASPM/APST.

This function is not called defaultly and need platform driver to call it as need.
Actually, I think PCI framework should handle L1.2 and L2 case, some devices
or user case want to L1.2 to get better resume latency, some devices want to
L2 to get better power saving, which out of scope of this patches.

This patch just handle L2 case, I remember L1.2 don't expect send PME at all.

> 
> So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> you'll ending up with bug reports when users connect NVMe to it.

Platform should choose call or no call this function according to their
user case. So far, I have not found a good mathod to let ASPM to affect
suspend/resume. 

> 
> - Mani
> 
> > This API help remove duplicate codes and it can be improved gradually.
> > 
> > 
> > > 
> > > - Mani
> > > 
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்
