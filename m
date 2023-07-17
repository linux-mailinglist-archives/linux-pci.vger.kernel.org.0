Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32AA7565C2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjGQOFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQOFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 10:05:49 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4067B186;
        Mon, 17 Jul 2023 07:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3oNLOA4yt95W95mWJkhcdhJJiUq+RyrSB3wqTMYSC3Yf4QVTRgy2ibdNMjz1p1lEFk0R24jRFaUmR8LDcqE496GSL6u4O1USiNk54KyEMybEF/13cyAGwqj0id1XwVSJlocx3Y95Jn/y0RSgHJIwTUGTmPKTfw+fzu4Tv73/DK37wyxQKBLeH+0Jmx89/1htEOEweK0GzYhqb6JV1JiPvRKrydvM+XO/0Q+HM3Ng8PGlXJS6FiqtrSsFYHhafsSmfuDt8P1KYLHEYZUvsmiSoesptppEcaQLeu2MSUAR8awTr8cjevllsaIE9oYg1PyWF8WCxtlfetNO0TujvzVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbD3Tt+t5Pg8t6YP0V1z0pkQqT507ftKJio1FXoZHQg=;
 b=AsoDemoPhX9OADOpXam7yU3bTI/74qnBze8Q6LTL8i0td7gZcMzWk79CCvVA0hp/zi5FjxBzHPYCJJNFSAAuzyd2dgxbTF7zgczjgwWyjnE0hfTG9347Y+nHyYQCTbHRkr2nPqt6i5jgtFHYeGbwTPFsrUD89++xZ2BPYsiUMAEdfW1LCH1XeatVCga2RFWFVhN+XutWRCSAytCTI6aA4Ks8ld1ybxc9nC7QzbAH/m5rT8GJei+zpIBzIZaijI8iTRSfjKLWWaMTf5w2Su9rZXVCj8U+AKInH2xnZpVGHs+BMcXJLzGHIgupF1sMdVxXa6EzrPfxndAco2KDzuRzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbD3Tt+t5Pg8t6YP0V1z0pkQqT507ftKJio1FXoZHQg=;
 b=o2lD7xUt9OBXYLCCTnJjQUXzS/TYVf5Vj7fr9GGqgHqbQMBcIc8eQ0oPiATWSCBt/+OaThim4zbbH2rCOAAfV/8Anzo8g9lJFIM8uG0HbZhV+5YBb/0FqtksabeC0El+TSmcopvBOdFiJqsX2ePn8e1SIsonfaBdy/8gAp1l4us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7607.eurprd04.prod.outlook.com (2603:10a6:20b:294::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 14:05:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::6cc2:14b2:ca51:6c0%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:05:42 +0000
Date:   Mon, 17 Jul 2023 10:05:30 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "kw@linux.com" <kw@linux.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Roy Zang <roy.zang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZLVKqsO1PSKRC70o@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <AM6PR04MB48383AB3FD2062334ECB66EB88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <ZIdE2KjOuyHmLqz0@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdE2KjOuyHmLqz0@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b36ca4-2c40-4850-4bbe-08db86cee849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMAcOUKOdsQW+lKksOiphJaDQieZV6CwFcGPUgkfD94/24BD/5ZkZHEbKM8TScS+mx57qiHvw6TV3F0YYVUmBTYc8WFtm9lrtSqsYpMYU9vfiabOdI+NpaUrpXCjoXviW9SaKWc+aNlmtS/DZbnmL4l1UOiAe97ixD7+jtX+8/bA6rHXxYyJH9An0sE/OUu1m0P1l2sxZho3AjoSa+zTB567tzq6uXnHSqy5G773Y026MDg4LKNNpaz3UkG6ER+GdEBw0HqDpDoFtNClJKjbdKAG0MqLftXi27t8MQt6B1jnMNHrHcDBOXIeZHRyHsbz+7Mjs/RX+YRuWSG2QeT26mZHNiO8MiC8y3yae+ZOeCJUEXtT/ZMjaUXHUmal4iPSkLIPjow8UBcAmR94IGqBEmHMwXLqiame9CI9ae+vqUMt8eVBd6Ri6vXtWRBUxlF3GcGN0RaAyYUM5Bhyp19Gmb1y/tODhVQn+wDuA341ewq9h0Wx8X3W+JSAZs4SM7iXgtWymeVtNVWT+WbN+eQz2bEWArQ98TnC7xP0fJ45hGlfBMASFDSIo3n8Tr3Hg4M5rttzO7GEBuFl37FGG4jy01qEnp6QuYSADEqJcBQdiDYE2KRjnpjchPbba+pPL6Eb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(6486002)(52116002)(26005)(6506007)(9686003)(6512007)(33716001)(38350700002)(86362001)(38100700002)(186003)(8936002)(4744005)(8676002)(2906002)(41300700001)(478600001)(7416002)(5660300002)(4326008)(316002)(6916009)(66556008)(66946007)(66476007)(54906003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HEXpbDxBGhiwtIPJOmifVvQIiER7sQWvJP8kZ0ivnAfkzCvlr4gwpsAJ9pHo?=
 =?us-ascii?Q?vNkl4CzyclvHuVBESr4r1qI1yAPJFC9ZG3Kl+oh7ejnSoq+qPrBnZb/xZMZ7?=
 =?us-ascii?Q?oShOZc8waU5jveNnC7fuZ9pAYr+4ldZwPgIMt2fVpk65GTVWfyoFYrpNyVW7?=
 =?us-ascii?Q?AZJIbkffWH7FNeoR+cBAX5NdvV4ZuzRrRZlkZJCrkCHUuXr33EUe9j6eXHsw?=
 =?us-ascii?Q?sZypTJg+U8+EdagW8OeVenjgj6bvQdebi21QKtO5x5NXdQZ+9nX5fpMiBg3p?=
 =?us-ascii?Q?4TG9mb+TsC6KQ6wPchiEdTkxaYXptG1dYDIiGIi4d7tzQVbibV5jOaM6XjEL?=
 =?us-ascii?Q?xpwQyftmHvmjZgOtIsPs4I+frmGI5Izxbx2b8Un1c0cmtRE7cjui8CgJgidC?=
 =?us-ascii?Q?AbYzeeBLj3lyGvRuflxYBFdI+rU5LGj3ytsv0MAtLn5fG2dQRMU3vqjkgqqn?=
 =?us-ascii?Q?EPcrkjF6agnpoiUQ2fK5FIVlP2Fu8oumsNfBjRsuNd2WIOG6GcF2rHiDQdKp?=
 =?us-ascii?Q?h4Ij3Wsgd5N76rUwx1yy+rzc6tuy5QDcraSnEiudM7zZEgZQjkvGXhb18VpP?=
 =?us-ascii?Q?5OmgmMW3sKI/xwoYaIwpJqa2MnSk1HDyZUcr4IMCwE38g4WabnfB/XPqFSJP?=
 =?us-ascii?Q?Ttzhu1w3r+MDioaEx+Cd3x4ZlbDD5x9BQJFqdXuvd7cDBkSGzspmES75tPsd?=
 =?us-ascii?Q?184iPTkEmoft4A8BZ0kLgsy7eGtkmt/ejmnCfp5ZEDWAmtFecNDJNO4am74C?=
 =?us-ascii?Q?QOpT6OBgFIXFSCbb7gbwmauxX7VQZrXjfs5KU9a2zVj7U5Cz3ciVECX8+v63?=
 =?us-ascii?Q?tYb8JVJP6Y+N9BvloA8WxF+JImSxRkBejzmFpJuc13P6anth+yT9BgtnOt2p?=
 =?us-ascii?Q?/WEGWpxetuNoHCdCegpEaaZbhRHrw3iadWw4xokpKQ/blyC9fq+YwZVwTnxq?=
 =?us-ascii?Q?VQt9Et+j7KxOPrE2qaMV36aODweBN6aPoFkffbgXDBPqGAsEcEBNplaNDkFu?=
 =?us-ascii?Q?StITVmebDnqNttNP9NbuetCD/+v5Av/OMSO+3P03V1/eePsQ1uIXQ/9aIGx7?=
 =?us-ascii?Q?LWSpi7TcgHYps0ZzJASSY61J3rBd93JYX1twe7eyfwg/JCgnrNYcdu8d5u+J?=
 =?us-ascii?Q?EqGafw7KZE0/Pb08j5Tvuw16h4Bc43JsJZhvSU3hggb1XcFlpv5Dfdwyj3zz?=
 =?us-ascii?Q?sJW2R7q8eOyfYBJPn2umGMA1RiMkXHHWXFW5l0kduXTKehunRTaUguQlMbPS?=
 =?us-ascii?Q?xSfPuMg0OSC3nMOdBgIeBT6KWFvZmuaCOlgYvRvzAqTskdEFsXZDPXX96vo8?=
 =?us-ascii?Q?++9nMG4Cuc+tH6xb2v6oJeOFw83PNpNA1y6HIi+f9H6DjUuhtE8L66UHQcHN?=
 =?us-ascii?Q?KXj0KccHwt9e5rtlOSXTeUlqOo6wOoAzvtrvfNJpS/GlEjqt3J7md65eR4UI?=
 =?us-ascii?Q?9owEuTHageApgI0GQbAxILGhT5IuLUrleCDn35zQyuy5FWx02TeHmyKQWSfK?=
 =?us-ascii?Q?n69Zt8W6E19J08t0AshRUAQ0cuOXc+nO0uh7G5NpO6gCSVZkD5rkXIRlqkw6?=
 =?us-ascii?Q?c4hXoOmZMJZcYQ4vEni8SxX+iZ1ueepNRzZlMWDQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b36ca4-2c40-4850-4bbe-08db86cee849
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:05:42.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUhHM3WdS5RLTR1DiNHxKd1axOV/nbireW4yP/wLD9h212pPOK8hAQEyIeneYm/5qvf2bywzEvnFlhKEI0h/aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 12, 2023 at 12:16:24PM -0400, Frank Li wrote:
> On Fri, May 12, 2023 at 02:47:46PM +0000, Frank Li wrote:
> > > 
> > > Introduced helper function dw_pcie_get_ltssm to retrieve
> > > SMLH_LTSS_STATE.
> > > Added API pme_turn_off and exit_from_l2 for managing L2/L3 state
> > > transitions.
> > > 
> > > Typical L2 entry workflow:
> > > 
> > > 1. Transmit PME turn off signal to PCI devices.
> > > 2. Await link entering L2_IDLE state.
> > > 3. Transition Root complex to D3 state.
> > > 
> > > Typical L2 exit workflow:
> > > 
> > > 1. Transition Root complex to D0 state.
> > > 2. Issue exit from L2 command.
> > > 3. Reinitialize PCI host.
> > > 4. Wait for link to become active.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > 
> > Ping
> 
> Ping

Ping? 

> 
> > 
> > > Change from v2 to v3:
> > > - Basic rewrite whole patch according rob herry suggestion.
> > >   put common function into dwc, so more soc can share the same logic.
> > > 
> > 
