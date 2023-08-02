Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780B76D70A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 20:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjHBSpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBSpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 14:45:14 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBF19A4;
        Wed,  2 Aug 2023 11:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgAwUe3xLOnKjonL5MsQhRKnsNnCkLy/VdzwA8+X9bXc2G/qfkvZe1DkWDK+uwzlIzQGFMeYKEvHco6TI2D+8xsktGYxto3RZTUpSpWBFtL0wWby6lAlneE0rBP/rps1y2T5mHNS4uPLvmQqtiZsNNtFiWep39WzFhbqH+Mf76jna8gx/M3USx37IteDdJ1oYp1HN1va9WLwydZakThqQUHOQI36mxFGUEntAeViFQVLN/npRTU44/oPxdsuqGoMjHk8gpm8gis+ZdfV7NhL0FCLPgYsWuib2HbL1OkwGe2xH18Qk+G9EWMdwnOpzqT8+ycw9yzTKn5Qb11h7faOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmjjptg0w82ECi3B/KUJx6w2QCVP5Le0/SQbfQK49n8=;
 b=dDZj3tNWmdaLzYN82c2bt+8s6A0BcDY79Kif0oJg0hYooBrWMURs1k81FqtHcrKBGASFQx8/jyBcABS3TPv2yB/QRcMnnY7aRKVmKlG2xE2HQQYA0b77gFCR0d8qWAughh3kVowRrljgyd2Y6GTz12kW89Z/S3VyfoxApcRH7nJdiDhmCOeC+4GksjuFi+S0ahwSFa8hGVHv3Dy8mUI/7pijyqsSTR5wcR8z4l6YG3hkH3bfNbWI5sdJsc3CfqOY8DB4sSgcWmgpzI1ny8e2LCVoeg4o0zLx1N4Lyrdx3xkFrjnCaSWtMy6LoH79OTGQuoq1q6uX3EXHmaY6TmULKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmjjptg0w82ECi3B/KUJx6w2QCVP5Le0/SQbfQK49n8=;
 b=Xm6rxcJbyh7Crdj64ckiw7Po0OCeE42PbsmgQcsE0CnZKs59RTKv0x+KFAIRCluHSK7spAzXO2Qg8DKP+uCIjMCdffSTkhmvR10L/GLTv5z8OFhRZ5HPHrTfOuHRZVg0Mn/U8W3yisjq5D7cuRlR5VBlHtkT9YlW+uDg3hT16sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM0PR04MB6977.eurprd04.prod.outlook.com (2603:10a6:208:189::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 18:45:09 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::f70b:a2f2:d9ae:ce58]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::f70b:a2f2:d9ae:ce58%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 18:45:08 +0000
Date:   Wed, 2 Aug 2023 14:44:52 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mani@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v7 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZMqj/4Yc6U5YqmHJ@lizhi-Precision-Tower-5810>
References: <20230802155748.212377-1-Frank.Li@nxp.com>
 <20230802163138.GA61043@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802163138.GA61043@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM0PR04MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da1307a-4c22-40d6-93c9-08db9388985f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkVHNv/qFR+kuZNo2jNn7DkgBpj9/Weqw0g+ZvlxiCW9ALpKdS41hyaIdp3IOLf79CSC+m0SW2hE2gvq0sml2w6S/8oPVDgwiXMK8YX+fM5dFefwuLQf/OHPbfBbO2K/XJhWu4i6JBv2ZJshl1CSNxvkPkn4GwcYt8mgiWTKLHwA1co2efVkTcV7DwFdj4r6rSYlCY9tjCNLs2NPTwchEPvX4SfZXDcFND52/2l5aQr5BrGfpMdjrUO3b6IhD83qZT399JH2yO1Y9YvcRvArhkViVo516XqtcOnjph7ukpS9YzSMxIBzxVdY/uyXW5Bnh34EVJOSkVIW329K6d6v6+X0S3Y6wtoQ2Fltx2X6EIMKnF06czsoEci7L+/v5lqIzl1EksxW3Gle+ztEpIVx3Dz2aBhzWw43lPEVVfRAyKKUFXQc/BktxuSFgPGhUHYGvGBQyEJOTunxkH5H5vtounJyQNxwGrXe51wF6dggPfXvPVZaSZpr341uj8YzRTud1Sv93NHC0EVhbn0T/IJcUKv4vUmAoMhl6L9tIgI2sq8wmzHUT2VjUEo1QUTxtYTsbLXT6p4el2qtY1PvVJVN9Vi/JsyM0pV12Xw1BGTQbZYSllPWG/gqNZ09P2M5aavI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(9686003)(6512007)(316002)(38100700002)(478600001)(86362001)(38350700002)(66476007)(6666004)(66556008)(66946007)(6486002)(52116002)(33716001)(4326008)(6916009)(6506007)(41300700001)(26005)(186003)(83380400001)(8676002)(8936002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HJof27ue01EzyfRNr6IHFjEpYkKs+UJouri+9AQfs+u5jJvnhp17aUaMj1xe?=
 =?us-ascii?Q?7KkFuu4mczyj0fH/IL/GvJdmufxkvzL1SIWF3aLfV/JNlMEAD7bvLn4x+xZ7?=
 =?us-ascii?Q?kt8pK7wsXqgnDPn9pJZitRenr2mOs6KNE5U4CGruahISEjUsVlLjRzuWcyo6?=
 =?us-ascii?Q?hE7apSTlkoYr3OT6X616S+h0QTdRRnDqJH0bBXd5y8e5ucF7fv12GouzkNi8?=
 =?us-ascii?Q?yfwbANx8FY1lz3mkWkS2B2uEiBmbBnu8ZKpavYA6LIk3vyPOs4bPoRjfgo7i?=
 =?us-ascii?Q?rVhnglxpzhKVjHor76P4u2qJjNEiEj172AqJ0ELjca0RQgkb1BOQt5wELOq3?=
 =?us-ascii?Q?2D9N6EUbNqkfbDpjruvFOwv//wgw4Zjf6Kt53BCkZ5IksROP4odGvFI5LWkv?=
 =?us-ascii?Q?BSNDbPUQ05gsnJTR86Uu3kyxNabXMe59kPGu8G2BNgcxAFmvphIRiIqAzPQ/?=
 =?us-ascii?Q?kuiTS3KkwbbUSBI/1Fur5DndnweW6FBgmiOf0gLWhv7AWl/g0x6icK+TawqE?=
 =?us-ascii?Q?owj8iFheA9zoXeRhboHY/HQVSruMCNYDzeneo3T7Ciiyl47rWzqkwWtOI3q9?=
 =?us-ascii?Q?h2997oRa1R8JxQGM3QYu+wCWtQx/F7VKRqtDzjEAirJjm8q92mZdifigghxH?=
 =?us-ascii?Q?V9AmhoPdo6nQNxp0P2ivnKmNaVGUHs2vuCP6YgezZeTYRhKkYdgAGETCyCNR?=
 =?us-ascii?Q?z9fU3SoVlldXmwfJBva4n4Zrvv/GYf4qnhpz5LGTTZdI7LOXgYJ+5/8JIUqL?=
 =?us-ascii?Q?cf4L5PLBF4cpFhCz4jC7H7XreR9XfXIVdb96+qTKt9QGAmszREftoLztK/KH?=
 =?us-ascii?Q?4YMq7/0KVekxNMMA5sJMaAY/s2y1/kt/3Kjwg9onTj6XvBpKZ2U/4p7OL9fb?=
 =?us-ascii?Q?dm/r9/xABMvRKwYfKcHuyjWsU8n9eUw9qb/JhsGzh1sXdNOkAIobaQNxRsK2?=
 =?us-ascii?Q?Nhvsl6rn01es2ZfAJnrr6oT7bigB3XSGO7iM86du/Bj+jUo+xBq41cJGJgmP?=
 =?us-ascii?Q?v685ZkhdIbN/vWl2XEpAhLOmdhSEyHbExN1sDZZxapAdLM84WaAOoZdPrS6K?=
 =?us-ascii?Q?9TTZElpFkmXe30uHuKv4rUGVJFeaLrMhhpUWEpo7YLo8J+xV31yl7ndUjQIQ?=
 =?us-ascii?Q?VEzkqtqEI4NsMgnZekHLq2XgUqk+qQVtgwpQrHSl+BICErIUxwcecyOMiO/K?=
 =?us-ascii?Q?+TmQVceYsg8yzwAIZemYxnbYF3OpWAC2cilYUXlYXSjrkthBkvY/d+t4Hjfb?=
 =?us-ascii?Q?qYIhPWGLJbX8cxkKpmT9+4lreUaEm5RICBT8RER9bEGdekCeQzuuX/gxo70X?=
 =?us-ascii?Q?xVYMvctSb3u/lal5UOKuFiJUkxWlu62yGehYt6J5pR9IzGKHIGU0q7mMkdQD?=
 =?us-ascii?Q?ULNlDhvVQ7M4yB0/oORpLHpXq4y632Jxf9uQ3a4Ron1+sH6dmdvx9Z/ToKiu?=
 =?us-ascii?Q?tHqgE4pNL2D9QHGe4oSlZEyo7/i/oOcMV789NH5fFoe/Mm1jaPpQimeMub3e?=
 =?us-ascii?Q?jHHVf6i37hE+CeqOz9YvLCz0GD69BxlkjGcZXMdbBn8gJdV94pnHQh0BTKkg?=
 =?us-ascii?Q?3EXlXWkz2kDcEfqLYmgVY+JJPTOZTBkuLcxy1Bbd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da1307a-4c22-40d6-93c9-08db9388985f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 18:45:08.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbVfBlLz4sLl5n7yvJqYbsV6kXZ9BcgBmL7bcCOg0yX8S2BOJTJ53hD0QcepturPHFRdnW3Gu4c2Ovawv7rg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 11:31:38AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 02, 2023 at 11:57:47AM -0400, Frank Li wrote:
> > Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
> 
> s/dw_pcie_get_ltssm/dw_pcie_get_ltssm()/
> 
> > Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
> > handling.
> > 
> > Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
> > in dwc pci host controller platform driver.
> > 
> > Typical L2 entry workflow/dw_pcie_suspend_noirq()
> > 
> > 1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
> > 2. Await link entering L2_IDLE state.
> > 
> > Typical L2 exit workflow/dw_pcie_resume_noirq()
> > 
> > 1. Issue exit from L2 command.
> > 2. Reinitialize PCI host.
> > 3. Wait for link to become active.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Change from v6 to v7
> >  - change according to Manivannan's comments.
> >    fix sleep value 100 (should be 1000 for 1ms).
> 
> > +	 * PCI Express Base Specification Rev 4.0 Section 5.3.3.2.1 PME
> > +	 * Synchronization Recommends 1ms to 10ms timeout to check L2 ready.
> > +	 */
> > +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> > +				1000, 10000, false, pci);
> 
> Thanks for the spec citation.  Can you please reference the current
> spec, i.e., "PCIe r6.0, sec 5.3.3.2.1".
> 
> s/Recommends/recommends/
> 
> It would really be great to have a #define for this since the bare
> numbers are not very meaningful and they're not specific to DWC so a
> #define would let us find similar situations in other drivers.

how about define as

#define PCI_PME_TO_L2_TIMEOUT 10000

ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
                           PCI_PME_TO_L2_TIMEOUT/10, PCI_PME_TO_L2_TIMEOUT, false, pci);

where is good place PCI_PME_TO_L2_TIMEOUT in?

pcie-designware.h or pci.h?

Frank

> 
> Bjorn
