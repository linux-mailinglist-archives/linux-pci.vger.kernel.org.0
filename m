Return-Path: <linux-pci+bounces-1390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AD281EA35
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19D82831A1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8F05226;
	Tue, 26 Dec 2023 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AOxQ1PhW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695B4C97;
	Tue, 26 Dec 2023 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knY7eByV+qE/JpxGJGI+DBeSi+gjbcdt0anba29qEt3bPB/eUmY6+xfjmwgmcncRbLj/Up9Ha5bn/hP4cjVFjfY8pUjo2PWBoE/2Pu/KVUAoOcgtJE3+Pc4cKagUGVRJgXPXD2lfnROwDTAmZbH4HXNEzYEHMELde1AnGWEaLbe+Cn9KrAI69vFGnnKaY04MP4PYUuuiGHF9pTZN+53ax5ZjpSB5rTs8UdRYc2wBtr+aezBefQeDI1ucgM02TaOeIW+pP1ZhDVzVuZr9277/wvVPiD7QFFrY5TVYfx7lYRWtiN38be7/R+OQ/waqx+yaBRPflq+RXTHnaUrj10thIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRkjpilHyBczuICe00pATbVL+Nk5uadbcaNkU+p7M/w=;
 b=VAGVic5mXJexl6Fp9yU5QScC+4WHD7wpTES56rBb9e/6IQ6qv13koBLeVPu7rxTIY2fHBkHLp4sy0Li1K4CPUq85K3W1mDiVE4Z26rCOA7UtNXriGgZMIFy3WZcsFV2TK+CHtEMe2pht698T9YCnPucfYB0XCsQSPix0dWKTp3z7AaONFmVAwV7jkNFQ8Pa0iAAX+V9XvIWN9U44F7SMx49C5UpLRpcTlPPU0ZSnAfhTtLxcgzs6Ur/48v/kgg8jephRlfsmwcjoFUl3LWB+BYLkehxAPZePjxWdmg5IhtLiCRzoJwyq5MyolNQ0LB8ZAETXIISDu5s8EnYMn4ia9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRkjpilHyBczuICe00pATbVL+Nk5uadbcaNkU+p7M/w=;
 b=AOxQ1PhWK3QHBu1Ak63xI3/1Y7/Aum3P3hiShOAHBi65Co1+/6ExLunTMQX4/SJJ0UQ1sl1M3a2E+CMQ+JGwzAAJXeAvYbP4jWG8fYw5e3RpqJl99WoL0ylPM0WsXrS/f4Nzjv8Cu7TLvmW9mjbfO+RCdBkmBMsm2zB1kxa/arU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Tue, 26 Dec
 2023 21:53:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 21:53:11 +0000
Date: Tue, 26 Dec 2023 16:53:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v6 15/16] dt-bindings: imx6q-pcie: Add iMX95 pcie
 endpoint compatible string
Message-ID: <ZYtLPQgMVUSNduLG@lizhi-Precision-Tower-5810>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
 <20231224183242.1675372-16-Frank.Li@nxp.com>
 <6a61f325-a58b-4aa6-9a0a-7a3086f63829@linaro.org>
 <ZYr7Y+mJea6fChjS@lizhi-Precision-Tower-5810>
 <0233cf48-93cb-4f19-ad1d-e3e1835c1fef@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0233cf48-93cb-4f19-ad1d-e3e1835c1fef@linaro.org>
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fb11d4-910b-4c72-0ed8-08dc065d0dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9/cG/8Vjx7u6vOkkPFdZtrZEZQG1es3whgOtYob+jHUxd+xM+Ysj5y8QUKo8vgs1kV/oYkmQN9tkrvOSV0jvqvq71Ckvna925czDctJCVl9sd2VV5P7pvpydirv1XjgLidLZ79TQwXkdldGR3t0xMN8oD0Uebf/wAja3gD4+qeru/0Ly4nDmUfQHw0lsobFqXJpCKAElYQGc5tUSj3UIezKpocmpEfOmG3Gzv+cHTjvLePm0FpFdGItMwmBGRgYeShIvpyMRFKf3r3Ix2krhbm6zJOY9RGuh6JcllIed1s0Q1LVo0OdwaRNgqLzcgljO+taIp111F239Ijw2B9XT9gugokPhtl29cZ/uWeYN+gEkngVQfwzjT2+fD/pvCyYJs21dY5Hl26KzjjgD5ud97UFj7PPx54U/oEGxsy/iB4Y9b5spBdscXyZyLRV5apUm/AgUBJkWDhq36/MKaT4bzk2+FgQaLgcAOaJ9brlLiuRsO/O9g85+pYutIshHoDLI9ZkCyFN8s/tqqrMfOC/Rmu/DDFWBASbQ9faBifKh2OXeBZGVZO29Q7T8XC+K4vmTGzFkoCzppxVLDTVSkdcHyJbgnrZTc1JIyAaJS3f0cPNgohVxLitk00O0DdzMWIxZ6Hkwi1Qv4jTJvZc/1FOCTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6506007)(26005)(52116002)(53546011)(6666004)(6512007)(9686003)(5660300002)(7416002)(4326008)(8676002)(6486002)(33716001)(41300700001)(2906002)(8936002)(478600001)(316002)(6916009)(66476007)(66556008)(66946007)(86362001)(38100700002)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?woc8O5jnPg4uYGR90CExiUVNd4tBBXpGayxZ2qZ6OVhrUifC2PutXJMq7AY9?=
 =?us-ascii?Q?evHsd0ziC+UQ7uzzYJb51DOq7FdfAvU0FlS2PSyJFofGp+DgGUs2027fhVP4?=
 =?us-ascii?Q?WJpwWEAH3XTIK/aGPoyhXHIqk9e6WGb903nHDKg5f3O/Ppo5gq8ybWxo0vDD?=
 =?us-ascii?Q?sPtnYuV5W7KpuzCNLYoSTVuLXldaoztPKNbYNlYs41ettBTh7057GEofiTwc?=
 =?us-ascii?Q?vD7KQLKcgSSA0SbAYZLGs82Mr+nFc00jES29PS4AlsAJ143Bma9jyzIsgS6+?=
 =?us-ascii?Q?m1SLUktEh4Jwpx1Nxt7n8KANEN133MWxDzNF4Ejbrr9hjFiYOcFwpjzIE0z6?=
 =?us-ascii?Q?lBt+HmiJ5vkC3uK5j9utYzUfCUhm5Bn5lwrEmTd3RR8p4Zd51s5C7CsfRTYD?=
 =?us-ascii?Q?8PmsBeEG8X1pgJtipuaLzm7s+atClxOSY2J00l+mvPDMWeLwUJO8t9yEiEz2?=
 =?us-ascii?Q?fpvaLJFCH+uq1MO4uumc/F+lQo+GD3xOKIk2eQYPW50KZyEnn++8/JecBWK8?=
 =?us-ascii?Q?5Y98JwwxRgjL0EfwMgWO4uYJGOdVbBawv8EzmnePlZq/riHKFiDys5sg835x?=
 =?us-ascii?Q?dKzkh3LKmEkxbulC3N2jzyhqNOMkirXVQ5abltkj0r6nxzy5Xw7ydma3gxtA?=
 =?us-ascii?Q?46iTsTCWWrcaEg7huiFZKr/EiyBoFNaw5Ei6nQgFYfqUH6EAL3p2T3n2CwwI?=
 =?us-ascii?Q?CYwjN2YtAMLYWmuJyc+dZUSVJmlptInAxp36DiyhTYc2vgc9vXpDUnpqNnm2?=
 =?us-ascii?Q?TQixmkRXa1NkYC3J8SpDKkfj3l0Haaqc/+AxfBDAQ1uINRDLk81P+KAryACw?=
 =?us-ascii?Q?jWb05sxyEJT9s/ZzZnywNwko6NjJgMTR+IoQ+hIirocsURD+f+CiA6ODequM?=
 =?us-ascii?Q?jVJ1XqTPogd0CBIOvIDggWptcoXdPkmWuRFuvok3B3V4Khzhcdq7H/S1OefU?=
 =?us-ascii?Q?3dJlVbiWiFzdp5K/DmffGiwLuU+ROzBUrakJYj3aKRr6DzBbfhIUA7LmbDke?=
 =?us-ascii?Q?nC3LXeswVDYmU9S80tqOBLtyfW7HwZYBcSj5CCbbDgsj+C58Xqg9pTTNlRog?=
 =?us-ascii?Q?p+CxHLjwhfMyR4s19LAJmPhUmlXGYqVF7kmyqrxL/QBa15JxOwUf2/jKTgUu?=
 =?us-ascii?Q?GZ3XiNV4PLCEpb/VjTiC7yshmlhM69Rxjz7mmM+uRh7x7VMrflfojSlN5HeE?=
 =?us-ascii?Q?8RjFnCMBuoYajM1pU9mQPBaFDkR4v/jQhakYi2qFBFh5DRw2kJ2oBHwQOWmn?=
 =?us-ascii?Q?jDdhLW2SkfE7HBoD+5yp7MhZqJG0OFsWQsutklrFbp+eabR5tjSNhp0zK55T?=
 =?us-ascii?Q?WeBzhfYusptKotI7TFDiLc2uNF825eT0UQ8bleId8F8+fmhXIbzmpyoWhFMC?=
 =?us-ascii?Q?EnZeWs1Rbz3dy3fFSvjEfhdsgYtFiEUy1S/+5k4t9agIQx3UrqH9szASpUQm?=
 =?us-ascii?Q?JU+iGOf1U7jV+l4XxmplS4T7E20xJFUyhlzqw16tABJYmAMzA/0v5T4fBVpv?=
 =?us-ascii?Q?jxonVmV4PQRL4Qv3kegbKDqXe2I8lWRPYYgWQ741P1dRab+u2tFp3gYti9r+?=
 =?us-ascii?Q?INyxwuzb54hjlexKcqbI2lhLWAReNT+2F2JpmhbN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fb11d4-910b-4c72-0ed8-08dc065d0dce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 21:53:11.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQ26DvlDpsAhBAc+qiclxQR1wWteRzIyg/sP2ojK3gCurprFEItF5va+wWzKbvDzkAarPZjk3ek/RVtVhJXB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970

On Tue, Dec 26, 2023 at 08:01:53PM +0100, Krzysztof Kozlowski wrote:
> On 26/12/2023 17:12, Frank Li wrote:
> > On Mon, Dec 25, 2023 at 08:16:17PM +0100, Krzysztof Kozlowski wrote:
> >> On 24/12/2023 19:32, Frank Li wrote:
> >>> Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
> >>> Add reg-name: "atu", "dbi2", "dma" and "app".
> >>> Reuse PCI linux,pci-domain as controller id at endpoint.
> >>>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>
> >>
> >> ...
> >>
> >>> +# reuse PCI linux,pci-domain as controller id at Endpoint
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          enum:
> >>> +            - fsl,imx95-pcie-ep
> >>> +    then:
> >>> +      properties:
> >>> +        linux,pci-domain: true
> >>
> >> Same comment: why do you need? Don't ignore my feedback. You responded
> >> you will fix it, but it is still here...
> > 
> > DTB_CHECK report error after I remove it. linux,pci-domain is only define
> > in pci, not pci-ep.
> 
> Ah, thank you, indeed.
> 
> > 
> > So I add comments about this. linux,pci-domain was resued ad controller id.
> 
> However maybe there is reason why it is not for endpoints. The
> description is saying it is valid only for host bridge, so maybe it
> should not be used for endpoint case?

EP side, it is not PCI bus. So it is reasonable that linux,pci-doamin not
in EP side.

iMX6 host driver(and other some host controller drivers) already use it as
"controller id". EP driver is mostly reused with host bridge drivers. I
think needn't create new property such as "controller_id" for EP only.

A comments should be enough for this case.

Frank

> > 
> > If include pci.yaml, there are too much other properties was involved, but
> > not used by pci-ep.
> 
> Best regards,
> Krzysztof
> 

