Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079A700AA2
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbjELOrx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 10:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjELOrw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 10:47:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0613.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B090C30DC;
        Fri, 12 May 2023 07:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPhIKzc4tnlcnLZFHk4FD797uF/k+zKlUFgRMNby0f8SBGL2NFUbHyAKpo5DoCFkQA4C2LnQ/d751TOtU7VlY14ieZux3sgIRkRHI4JrDD8M3jg3N2mXFHZOspVGWvx0RnsAbZKuG4nx/nY0AZXzpiNg9azbxN6EcKU1j9HDisrnfcRfC5uVsRG5iDDbw/SosalcXKlUx+ldTEkBbVaDe+8o6fsHjWZae5AGEXyZ0sRedajrT5i4Xmemk5QuHZuqXwGA/NFxaifnGb3kRfPtsBPDgNYAqXgJcpo59dX++IQTKfqpoPpNrh62QiJGOF+uvTBQ3pZ4c4O2Ush+ob64BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMqY9Zv24IwnKawHLUVSovvN0G5UTPw72PVBbdbuasU=;
 b=JKJJEEtmB24T2K6hKfqqXI8KjltplCxtgIahOfr42H7aumoUcN8r7PB6EytNj0FWNB1cv8S93o6x6G7tcSfFbCyBk5PZv0VjyMS0IYzmUhNLrMswArnfIi3sGKPW4CAeLYjhtJRzFZWTWTy/M5CmkLwj8r70bfr+6lkWvYrCRYFXJQm/jyYEpi/JoClLKNTuAqqVyDWMToGl2X9YJz6X6g/ehjWPLI0McEmsYxt3x7sitd9WxycyUGbnp4aE644SS3FrtTwyL52PJHXam7GQ5gwDONNImpsZFGNTjZO+vhpEI5ImXmnPpH3RECKZAPe9ok1dlMIvMICAq72yEbHp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMqY9Zv24IwnKawHLUVSovvN0G5UTPw72PVBbdbuasU=;
 b=hVymzXRjr3iRNzRKyYrpi1fU8qJqPrN5tveDZYODs2WA/OYMZajSY8StWkZ7z9nptJI7ZoRJbW480ZAl/Y7089RhJlJGpwz4Fa8kc5/GbzvGni+9YMN1mtAtAy19/j0TdoSNjVtmU/My7p2qNnvCUr7p3OT/WH2+UWTK3wrbsRo=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8478.eurprd04.prod.outlook.com (2603:10a6:10:2c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 14:47:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.023; Fri, 12 May 2023
 14:47:46 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
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
Subject: RE: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Thread-Topic: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Thread-Index: AQHZct3SW2dT9GmC60WQlV8ZXVruY69W24pA
Date:   Fri, 12 May 2023 14:47:46 +0000
Message-ID: <AM6PR04MB48383AB3FD2062334ECB66EB88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
In-Reply-To: <20230419164118.596300-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DB9PR04MB8478:EE_
x-ms-office365-filtering-correlation-id: 4a05b657-85fc-419b-9467-08db52f7d992
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVSVjvV518leJvdL86NCfIYlT9K/pNTD4lRk5q+tm2u7qiTBoG6zhs2BINta1K312m/RoCIKZEI8fIq7IbmMsTawCq02MxMtasoxc8eUs85iAmQwW1A0INeREyIrhQr/80Zec7mvZFnb0+BrlPGycm2A8rAaH/DUALV1hCJo40V+LTMzMfd4fD0ynHfCOBcKTORxMDOcWwn0No6KBUJ/kYqseUGT7tFpN16S8nSQJBvVjHrLbDSUM/kZipzX6lnHXreAyo4s04AAbxIDYIMrJU2GFpTiEnts6KNrdpD0iwL73YQ/pmmat5w59WmSwyYwVohnX7OAG8REgPkp0ee3oEdnwxEbmaoJDoV1sdj1geriM/cb7B46cm7nhF1z76Eap3aTmMK67dE1TVNIeN4j6mU04aZvnmnJ/9hBbdDVO/UEbfjGr6Nvf4W+Lq4VbyHXV10LjL1PD0J5zKJ6aVfd615PWKQk2c1l1nW/LRaIu6FaVN0XboU/M39M84cJpG1sLq5XmPCYgoCogpTDSvJWOsEbSFPdcNF26aPww8+50DDz174ZNhtzMDelZDXK+Ls99ZgmcweRFicEkijmxRHuWBMcOcsT+knrNHiPoLUMRDocBNjP4GWzZroqbVBPQBzG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(54906003)(26005)(55236004)(186003)(6506007)(9686003)(478600001)(38100700002)(7696005)(55016003)(122000001)(71200400001)(4744005)(2906002)(52536014)(8676002)(7416002)(8936002)(5660300002)(38070700005)(44832011)(41300700001)(66946007)(76116006)(33656002)(66556008)(66446008)(66476007)(64756008)(4326008)(86362001)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PAdN4lrvMBrrbL90iLzAxRvZcELMROCI5m/87prykpsE7y5/9c+cOuBDji3r?=
 =?us-ascii?Q?ZOaBMt2ChGQJ923A2lDg3t+1bu2fziAXwviCPZ3UF+R1BKXpS8YzFpjg+qx2?=
 =?us-ascii?Q?rq55xEuKpTwpZHWWZH2ZeydmyMoLuNiRWN8tiyUUtDZDTAL2iGi3dB+OW9FX?=
 =?us-ascii?Q?EukpqbC8i/vTPa2Jw7BmcNdS9rnKD74jZ724A65YCMoLuhkfmAWOsWpAKAAP?=
 =?us-ascii?Q?bZeWYANri5k9mMZvTjpCq+8yDeqXmWHwcnS8PMSj9qK//zMbRhTxcAFgMXgB?=
 =?us-ascii?Q?L2ROtTcWy7aXiVv2Uml0FLDxxRdapqwlBXS3HBXfDr2l9b1RIxxE2T6jKTSM?=
 =?us-ascii?Q?BUSnANnes2dauhI+Kk4mNPhnWsDZJJe+3k9ojE46lcYT78KC86LonP7NxQc4?=
 =?us-ascii?Q?lD5NXVGakeX9zNKmtmaUH8z2kVHBdCoXDwq/6sBVbhZdAVt4AIghSdGEJgPw?=
 =?us-ascii?Q?yiWRfXu8GPrCI12WFWE50bKwyBxREXQ9UTG4Gu2zEuZL0XPUM40IE5XNHbqK?=
 =?us-ascii?Q?Olr0ZF1qzzJtwTw7voB1eC4D3i7ImbSP86IILxnXzUtMCbnBSsFrFuQgvxFa?=
 =?us-ascii?Q?ar+rT0btWpIavw4wnIcIuSvLjHAxSObRVRQIsXx8ygYIrJeblNLAthEhtH7y?=
 =?us-ascii?Q?LXU+vCyCvsXT7mBf/NfgYnQSMNgKNbdfwno4QSoJEW0RejHO5kzkEc9PZQRZ?=
 =?us-ascii?Q?HdketQsFK4rD5DjOtNF3XJEuGIFQF1Z3G3zzRSvedlP6E4VqpD8qLnTqzdFL?=
 =?us-ascii?Q?bzdtQkOwcbsq2WjxcoSvHVRaGPB/rQeqmJbctTKuzqfIYqKAeJhDfq0gAtGb?=
 =?us-ascii?Q?yGpDZb4jfu52Pbzo1hD5INmIhQJqtmAs0Y92Yotrz1CMeCC0pll6UvkCygtF?=
 =?us-ascii?Q?hRK8jjtedw3NERRJ7zwvJCdZgU5YIH/nfkhxe7p6ryt8zunomf16wVLNLVR+?=
 =?us-ascii?Q?MJJ/GLUAgCAhBw0VGwAemXP0Qqh4tHT7HfUWG6DN8Evd6z3veV9ch5vA7ZII?=
 =?us-ascii?Q?YEaeSup7iyySa9RuXhSZ7tv2jZsC3KKaXf/KpOqpPC0heetyy1QnDnzsKy9T?=
 =?us-ascii?Q?Hpa9wGFPGeJ4zaIJQYP84AFNMS3EDs0C+VJ7EGXiZjgyMeKk4+w+0qyKgwtZ?=
 =?us-ascii?Q?0RjMBQgGXDsRootW4G36/xJi0CLzCXNs8JQ78zcqsvwG2sUa6PjNOwle+ZnZ?=
 =?us-ascii?Q?C0raDgwO8w8r4SOC9G/0gSAsAH5apsPLxlU2GpA+QctPWNlX4C07rWkXGv+1?=
 =?us-ascii?Q?DNmifLoVYyNAdKHQNy1tjzDVRCFHzlL4S9h3aPWxB6QKcXBEO/gzODaYwdd7?=
 =?us-ascii?Q?3ZGClH0RTeSI6bByCeyc4KLn/7H6upSgdcfh9yU56N3hkO8ea2cF6R3qztki?=
 =?us-ascii?Q?A3yec283A9qs3ClXp7XR1NbA4HGO3oX+4j3uNpdUtUcHlqT2otnJqLuPebNk?=
 =?us-ascii?Q?aZQ+OkrbFLeO2L2+lzX8aWV22QRidu/J+Zw+d8iDvNdE5RyhaSnEMNw3c59w?=
 =?us-ascii?Q?rSoKne6vpZfk7v++4YamOH3mYS6hWXCxap3Y2eNkHYkl4NTw44eZykXX+eD1?=
 =?us-ascii?Q?Ti8ISVE1ya+foX2qxXU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a05b657-85fc-419b-9467-08db52f7d992
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 14:47:46.3140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92wcn2ulQ2rvh1tY8KkAkdvqJ3mC38sOsSuibmTl6lXypFHpdE++EJzqOazoYjbIpsuBn7MZLYZzAkZzUSebuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8478
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> Introduced helper function dw_pcie_get_ltssm to retrieve
> SMLH_LTSS_STATE.
> Added API pme_turn_off and exit_from_l2 for managing L2/L3 state
> transitions.
>=20
> Typical L2 entry workflow:
>=20
> 1. Transmit PME turn off signal to PCI devices.
> 2. Await link entering L2_IDLE state.
> 3. Transition Root complex to D3 state.
>=20
> Typical L2 exit workflow:
>=20
> 1. Transition Root complex to D0 state.
> 2. Issue exit from L2 command.
> 3. Reinitialize PCI host.
> 4. Wait for link to become active.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Ping

> Change from v2 to v3:
> - Basic rewrite whole patch according rob herry suggestion.
>   put common function into dwc, so more soc can share the same logic.
>=20

