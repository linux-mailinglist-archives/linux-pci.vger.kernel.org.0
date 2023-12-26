Return-Path: <linux-pci+bounces-1388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC0381E84B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 17:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1878282D4F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Dec 2023 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D724F5EA;
	Tue, 26 Dec 2023 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rYUkC2HT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C44F5E1;
	Tue, 26 Dec 2023 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT1ePGNyqdhcr1FFGDbLgM8Q659S24wvVRzv6+4B3RFoFBkqvX7Nv9ISCr96JkDDhlTFq+1mkwv5MlFpq1ATbWryTRqanAJBv4r5khH0F9wo3+T3Oje9CNCLtiDH2nbYACYKahkN57gaFq8OaMytyA9iQnogO3qFob819PA9Vr/VFT39M+pNRJgAKYYuU67yXnS6BShwAFc6JrwNBtVDpLvCEghL2CvCk080JPKGLoBfvcS0iQ0MegcRowwgk8eRSdbAYdzM6tBZ57778R0DosDYbLzf40SkikVVWv/TLuHIGBwe/XjyCZzLARtJJUb+1LIyufxxm7nvi2CtyXy7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JJZbkEBJhEPRp6OoCkLCg/n1Q94qbuIJy+v1E4dKOc=;
 b=g7iBYy+j0IDS6sxf2gXqAGLFjSNnuCClGn2LCcoBVKob79LhlgJNkojBpztWoD8qac3urmR15ahypX0bK47bPC7RbB2Yk+lTtrjqGJnxHWR/LryRM0eFjgZWadpjN5PKaO7abO2JOodfVXbWlLCHYYiiHxZxkhxf9ivf/sFT23CaWQHx4h2YjFki34zFYjN+FXIzWIJu4qzJrCXM3OuOPaymxgZJmuURdc5sKPiBmJEvZ7iHgt1JVQFzOIRGAR+GgmmM9g1lNZJRWYIfpSTrdOqyydjQfFtoQOq9qApkwirhNU9VCKVCAkfbqEKmv1WI9sZXKk3Uhn/ibKdmA8nhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JJZbkEBJhEPRp6OoCkLCg/n1Q94qbuIJy+v1E4dKOc=;
 b=rYUkC2HTBjjTKhEAJetQNFk5RcBj3I/tmNh6ngst9FmfAnthrvO+B9va7QXIFVp+woe3Pl73gVh1qOq2YBHVvbmWxFpj/XM1f/E+mtMsNS+trPB3xV5WctmmldwU9RdGZ1dgcYbh2F7AZiw26aYzZRvDo0kSQkNi0Kic4oZllFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7210.eurprd04.prod.outlook.com (2603:10a6:102:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 16:12:31 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 16:12:30 +0000
Date: Tue, 26 Dec 2023 11:12:19 -0500
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
Message-ID: <ZYr7Y+mJea6fChjS@lizhi-Precision-Tower-5810>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
 <20231224183242.1675372-16-Frank.Li@nxp.com>
 <6a61f325-a58b-4aa6-9a0a-7a3086f63829@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a61f325-a58b-4aa6-9a0a-7a3086f63829@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 1308dec1-02bc-4e98-fb94-08dc062d75de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WtxBghQQ+yEWAVCA8NsbrVgkqJS5Ql/lNYDe5lZkOrZ9kDx4GkYX2VpZ+YDlDvIXbbAYJsO37TD3VbM6kwuZDtWX00j95Vf0l3PLbybfDsYIBKuj8C9yJNAnPZNAzJlZRuf5P7cbTJZhQQIVVdd4qhUzxtjzMEc9ZoiB3WiNu1BcMtNEKPUXD7jc6D2Pfr1o3v++eoMVy9wMuwN0CBcozMmi1Bn85NIh6d4l+S7rPUhykyPsGNa4cmCxvT/hfJMnSSQvgVNmfgYr61AUL9kbwbdy1x1kVr+YNJt97FHLhHeZVLe9BkI0SXmD4HNyRaex/zdgTarAY+SezUbXGPWCfi1CQMUDl86PUfF49D76ohm1uXn2WA9DyaXRdDTvuXaj5ct6EBLTtQWgembshE+K115dp+nFgsDz1OcjagLY/xx3oVsKt3iycrnAzrSp/gk1VUzMR562NDNlq+cm1iflsHIDy8OkXCUaft8Vlryg+sqb+EKJdInMKEm2irC7qOffDPjrRzx/EjhH57RfG4XjIyhYuY+aHyd+Xiy0xtVe7jWtf4gHp1s33xMYlymBZg8k4o60dLaJe81W1pP7kB6CUzRx5VVhAvcTPg83ijvjqkOhLW4ESFouAKmtDaCqM92oXbILPFrpnL9ZNvFpeR11tR/7d/6S0xuK3obtT+4j7CE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(7416002)(4744005)(2906002)(478600001)(26005)(53546011)(52116002)(6486002)(38100700002)(41300700001)(86362001)(38350700005)(33716001)(316002)(66476007)(66556008)(66946007)(6916009)(9686003)(6512007)(6506007)(8936002)(8676002)(4326008)(6666004)(32563001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJofG+n/YuZBfbLWM8dghRGCYBn2JeX8Hh8e5UbIIL01JIrjog1Q99JodYNL?=
 =?us-ascii?Q?kB50RsR+VJNXrQZFCDgKRKN3eF1DVNCuwYgczMaU7GLtngM6fUPNhQ4L1jl/?=
 =?us-ascii?Q?+SiEmpxz61OiCrSB+SwD9c5v2K26IAg81rnUQYPRcp27rCKVZzv6hpG3lPOY?=
 =?us-ascii?Q?szY0K//9prn89Qo3Y3HL6+SMygZCOFbe+GJnJLws5zrAzaGY0yCPDAtDfdo2?=
 =?us-ascii?Q?XXYVkz6ZW3JSXwJ3b7YekadSHlQlbVe3+runw+xp7B4Zwi9IZ9quCAYgg4lv?=
 =?us-ascii?Q?9VYXFVPYTT/lf1qLazUJGn0Dsz8ua3lJJ9Pm0bnLDBCfNrjSk53HbxLUcEYd?=
 =?us-ascii?Q?3mlb7Ab2bqc229Cj5Z+8rubmG+xa5KqsMKnqYs2KHPKmro9N7rJYIzGPE600?=
 =?us-ascii?Q?hq+j3yZ0Gnr7AHxIKI5RR/rcqEJlJtNktHgj3RwUs8lHX9eWBFclFgwaJK/k?=
 =?us-ascii?Q?dqZMiJtvS/+SKM9KTM80v8S+Yx+8S/HHPC6Se34/QJU/+pz+jNiX0xSKJ88H?=
 =?us-ascii?Q?UbAByr0QW2PPuvBH5e4tU4l+L+9gFGdz/fgKzbDXhPUnkGX9VBHt8uvI2fLn?=
 =?us-ascii?Q?NCR0OR6/KN8EE07GKm6prMs94KDhiIPkuywju2OkIn+tgH1De9iDhQXReA4e?=
 =?us-ascii?Q?kAQ0EDZZbPheIWTPCFEq5Y/kg7Fw2NHxrUWeKtSyh1tdI6wdENFGbJvch9K9?=
 =?us-ascii?Q?A+nZ5rnr1d0O/a9ho7LYlT8dm4w4VvHOPvaOFSbDhrUFYHsgvjQpQjEJeKrj?=
 =?us-ascii?Q?rao/zMOfSTdo6z++f15mnHkFOR1yjyoZhSo8e2RS0x+Vy0ImG8hV4x3Pmwi3?=
 =?us-ascii?Q?H/ZfjSgkKGaJAXKaoJOclgxvOqvIy5hibZeVwYLsBHm3CCOyzCBOewlGT9UD?=
 =?us-ascii?Q?cdbfP+rI+7fgTPzlrKACm7UM48n7X7xayfDhrworDL4KiJ3XwzagTfRWqHaY?=
 =?us-ascii?Q?tAtS2psVE/7WJKx9NA6H5+sFrp4koSIsw4KrOFEdBYKsIIiWFdussNNzyBrO?=
 =?us-ascii?Q?CBG/DorX8U03lCyo7ji32j43JDeOpckhFQ1w8Dlvqe38ngXkPmuHghTD0kzx?=
 =?us-ascii?Q?mUyhaf1rNoZ3GY1SZi6iKIUKTWqi+KgwvdHru3AO8qNF5ZRi/Ps1LBVB1SGY?=
 =?us-ascii?Q?Jjh265M299uc4QfHnuqiSv0uFpbRpQXgGn7ON1/zoE2LB4q+4wZe1pumY0TO?=
 =?us-ascii?Q?k1jmLzc3kGcx22yguPiTcp8L5vt8SBiR6+g74HxWRQTDlcGnxcMJJkW9wSXD?=
 =?us-ascii?Q?wmlzTPjNWh0GnGMsjkNzoi7QCCIUg3nK8puJCSYQ9vpK+0cgB6RGOITwKXlb?=
 =?us-ascii?Q?WphDS/1CSlXTlqaqAedd17uyqoRyootBgLjJbKWN+hgNJL5CxZ6imvyirHPU?=
 =?us-ascii?Q?KLXTYEg+NzFCN2xxWFN4NHLtneSgBJ1z4fcn6sM4G9E8wjxfKk75i2fZ4yLD?=
 =?us-ascii?Q?YvnKyxVR0ic2RKi/F21o17FyT8afhortznKYkU+8iZtd0thHdj/vVIVL6umy?=
 =?us-ascii?Q?vKFG0k9ukgY+UYscUPzSrZbrbshrM9kT5GouvnehGDA7rxIftmHxW8ryOglG?=
 =?us-ascii?Q?SC+9C//NWEvq/z0oe8P8Ii3t2Q21wFmcuwnbRamr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1308dec1-02bc-4e98-fb94-08dc062d75de
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 16:12:30.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Er8J02ANy6GzEtYSLpsvkb3lOu4tE7eW/v0p7DxtvDxGHKep52vxZuZ5wDG3lJVh2OY+toaCTS/9trAr6U312g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7210

On Mon, Dec 25, 2023 at 08:16:17PM +0100, Krzysztof Kozlowski wrote:
> On 24/12/2023 19:32, Frank Li wrote:
> > Add i.MX95 PCIe "fsl,imx95-pcie-ep" compatible string.
> > Add reg-name: "atu", "dbi2", "dma" and "app".
> > Reuse PCI linux,pci-domain as controller id at endpoint.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> 
> ...
> 
> > +# reuse PCI linux,pci-domain as controller id at Endpoint
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - fsl,imx95-pcie-ep
> > +    then:
> > +      properties:
> > +        linux,pci-domain: true
> 
> Same comment: why do you need? Don't ignore my feedback. You responded
> you will fix it, but it is still here...

DTB_CHECK report error after I remove it. linux,pci-domain is only define
in pci, not pci-ep.

So I add comments about this. linux,pci-domain was resued ad controller id.

If include pci.yaml, there are too much other properties was involved, but
not used by pci-ep.

Frank

> 
> Best regards,
> Krzysztof
> 

