Return-Path: <linux-pci+bounces-825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EAF80FB3D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 00:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E816282146
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 23:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191EB6473B;
	Tue, 12 Dec 2023 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ClhlQg0S"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C328100;
	Tue, 12 Dec 2023 15:19:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0hbhnA+OS061LRs8TYwyans5XxPOelIiCFfzphTh/+Pn4Yt9fUov6Xdvjw3DBKbveKDhTkw06IZtGgoN4++vaijGa1Yn0TfX3Sq3z0patwm4J1lmObwuXKruHJXd4W4HqgJWgXsgJd9uu8UJ99japh7L954aNO6W1m1pEPRZ6idlQx0a6IZlcndqIbCWwBqd1PpiF1Dgnlt194L+o9Xmiqm8Gz/yepsLAvc6Hu3NY1P1aGXTOQMiyQN+MnUh+otLCXbDViiKruk8DESR9E+BvGqLafSLFLWsdhIaSTEbZBat1vmIFdOMHh0A4IZHivGZrcFsaTM/g1ImOPWw7b5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vveGhXRNWPtOaY59hn0FvvQqThq02pyK6m9coM5IQk=;
 b=DctFh1G16tkogL+QC6FJXng38HH50AcpjHGT8K4G9hRFPSd33oTyzjRkQYT45+mvfPmYf2zXHsJUZX49lIXexjsuxvT4LKAMjA6qhiDnQ4ZFGgcvYLGoryC3hEeLvFJfNjgokK9gkrI17tTccNEFLpIXBDqQChylJOGlwad6Os4kwnWUCAIh27oAa69tUJ6w5RkrFp8J6b7ueS17i/4/4xJDu4oGnP/yGdfTKmkkg0ZpGhLf5QHJ1yq3NDNfmHyAglj2ZrO5ZSMs0oKL3/L17N2omsaGAyd7ukpd7So8nWXDZAs3GbWpEuPS34yyLMk+0Tvmcxv28/yOXrWqIhlPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vveGhXRNWPtOaY59hn0FvvQqThq02pyK6m9coM5IQk=;
 b=ClhlQg0SAuSgjlFIa4Im//WtzTNg87Ase5I0cJ4vetysymLAScbREPafU9iglRLUsO3KDyZln0TZJwB2RxWuJWwGUZQRZ45YPWdiOP82n9UuysGB5ezX3D20Kk3iPW01Nk10eOIvVTWBjymT+xwtK/tcJyA7bemtz10k9MNbI58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 23:19:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 23:19:05 +0000
Date: Tue, 12 Dec 2023 18:18:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 01/13] PCI: imx6: Simplify clock handling by using
 HAS_CLK_* bitmask
Message-ID: <ZXjqX7uYm3TGFdzE@lizhi-Precision-Tower-5810>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
 <20231211215842.134823-2-Frank.Li@nxp.com>
 <20231212164913.GA21240@thinkpad>
 <20231212225426.GB2948988-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212225426.GB2948988-robh@kernel.org>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffae849-a1f7-45c7-c8c7-08dbfb68bbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/vWmq2/0QYHH/bYyV453kkityHf1J9eOQ75r6jCZ+TCD3nMRFMPR6OhWN5bzzzmxKZI+VlPp1wwouiG7Hi4NV7b0JhM3b/TE0Jr6JyyYJCZPz1xTNKjQ3aMRsyCYCs9sVl3COoLQ0GdR6+0XHd4JgxqwSAGQmpmqSO/aK2BDmlNiUGiyRw94+b34fLAkYxdyr9Id9KIGEC1D5l4KWvwkf8kw726j3UR2mp98RqrI0N+lnzUf5Y7pBPoeeUWyMy3mWT+i90/VBRT5cjOoY+b4fRDan64ImCD+Vj9mebMSD34Syk++evvXx3yFSp8N5y0lEL8xTeFupUkhdJFHkg4VbSj6CKIuVCSkcyCwUaob2pHOVi0GW+zpo1YzwXc8l44biEEZcIcVztYg3I3HYYXblAvgCFx42jrLen9g8h/wwy4R9S42R9/kzNgSI687skHN1LTyDOwrbPYEYLk47avWteQLhUAZhuS3Qt9ZUPq9kzhEuki3j94LC5pABZJj+VBYS2xvj3Z4nu01OgIUOiRY3MCQt2dXKiTQBYUHlrMSr/9Hhln/BjL/O8tAld6MMdKfFHBjK+4ne/XBVM9/pjMQCkpMhzSiMA2vbsjnCV2FvonHoiLMEiz/jeSoaTXBDgmo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(52116002)(6506007)(6512007)(9686003)(38100700002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(6486002)(33716001)(6666004)(478600001)(316002)(6916009)(66476007)(66556008)(66946007)(86362001)(38350700005)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTkA3Z1JRD7r7XRjQpt0jI3IbmLPY/q4do/NoCfHoZREmYCNc8x/+WQL9LhG?=
 =?us-ascii?Q?FagMTIu/gdXz3sCxTR6b2a4HhocpG+//8RT87YsLcbvGccZD8ItOX8GxBgcF?=
 =?us-ascii?Q?a1Xfdrz75ic/8u4W1oFLpRYj4D2Pd0qwrknxawpnlqX4RAK04DWAsHqQIUJm?=
 =?us-ascii?Q?PaGH24rLJ5WzSLu0m2wIxT0r3eVNJLFVorhaRmkrAEPmzBcEcBVJblbSzGrr?=
 =?us-ascii?Q?UX3rUR16bQjZOhX4g3avKCWyl0V2XCiEL67EjRFEpAVSTjnLxydiZVRqv14n?=
 =?us-ascii?Q?kaOZLakrNj2dzG5mOAsN/rhom2vCMvhb3CqNLMV5K+BxEqtz3cOm0VtB+Ft2?=
 =?us-ascii?Q?ubZoR7j78n8g4IRAIWo9s0zMnUuGmPG1jJhmGWzdCGpxwOqvSkbRjY61nkEa?=
 =?us-ascii?Q?RMTvQznx4Z6n/Rff0DXvd6+i1fj3Sw7Ek4vQUsJlenzMMs0oC/9Ik4o6Ofqp?=
 =?us-ascii?Q?sySXVquAoy3s+VPShklh8RHUuJh9l77iLNw+0dtul/JdWSiLOmfC0gkAQog6?=
 =?us-ascii?Q?DupVUN+iyMp68Sx0jem0VF3oYXR7zbi3Yk5amTtGJA3Rcn1Ghx2AyxVE81MO?=
 =?us-ascii?Q?JU4wYR5zmqlJR2cb8ceLcjiaoYT5yTsagGa7xura0dKhri1yF12p3MAZ/mAs?=
 =?us-ascii?Q?RdQgnbVeA7cXvrI3aWCv/Mnq0246G87k3Bp/BVFjukR/DLRAuKkijFzanxdu?=
 =?us-ascii?Q?hc7DdGpE1hXQSPWqx4Vc+9WoZVbQb9W6s3RIX64nA+d7J+DTomsOdG/Ci8rg?=
 =?us-ascii?Q?MmWe9WKHrF5uOwZoae7Ew2YqmGORW+pBEIqb0++NYOf8wOb0V1ytaRIWLUmc?=
 =?us-ascii?Q?JA03qaDNVMMho6TSxwXei2L8QldYTsg7JZtlY3Pea2SeQJYrGLS44168vuLf?=
 =?us-ascii?Q?Bnm8JpZVyb4PEhOZnIJx5F3kXYAY6f0dYVhd2Jii/ctp6WnCFhelNLzZ3BWZ?=
 =?us-ascii?Q?qM4DY+fucVqgbcjmAe+D/S45zFj7HB1nQe/mw2qTPEmMB18BAnmKNFtKr7C9?=
 =?us-ascii?Q?ZF7MNHy9USmnJbovYU8sSUYOE9cff8xc559p04OgRpwZavg9RAN7MUCtXuqB?=
 =?us-ascii?Q?8flnePv60nqGjkN8QLBOYK1MYSj8Zl+YGIHmR3DUYtuhJ8MyNFpC2x0l/PTj?=
 =?us-ascii?Q?X4a13xqa5Ni3mbguJgX8M281j6HMqA6SupGvQt4po8gJzHpJpfpMJUz3AZAy?=
 =?us-ascii?Q?DDCbLxPVN6kGhwt+IOZ9K5tB9NrG/CXM6UsgoJS6bc+SQlVLSVXnnwNhmMmL?=
 =?us-ascii?Q?FP4laPsY3nUj0uf9uqi52Udqh/3yKt3axNZ1x0NPfO52IIc0vOuCZFx3hX4b?=
 =?us-ascii?Q?Rh48FkGnm/pQhpKylLHP2ABLS9rLH9Vaprf5I1QFDAQ/qSGocL9CPuEbulDx?=
 =?us-ascii?Q?zjQdep2SxeldBc1B37raL2lo75y9EXggN27tYllP90OCb62mXw+JvAZFmBoU?=
 =?us-ascii?Q?cfXsgU5VGA0zZNj7Bs7tWEQNH5UiFXvivkchCrSDFxBb5vIed9c4wvPXWMD0?=
 =?us-ascii?Q?NvjXTH4L5HH8fNjnAE/Kv4FgT/GPvEAkUdezyzrv5kvil6JyQrGfaHom+3uP?=
 =?us-ascii?Q?iQaGJuFTl6Ie3lqFGWc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffae849-a1f7-45c7-c8c7-08dbfb68bbb2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 23:19:05.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU4FgG9kP0h7cpa7Tux7RiI2LgmgpRZkMhppCgE9dd9wU7hIzQ9ilJ8cF/LmNyrj609+k9A9Hcso8GnDz/dcfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359

On Tue, Dec 12, 2023 at 04:54:26PM -0600, Rob Herring wrote:
> On Tue, Dec 12, 2023 at 10:19:13PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Dec 11, 2023 at 04:58:30PM -0500, Frank Li wrote:
> > > Refactors the clock handling logic in the imx6 PCI driver by adding
> > > HAS_CLK_* bitmask define for drvdata::flags . Simplifies the code and makes
> > > it more maintainable, as future additions of SOC support will only require
> > > straightforward changes. The drvdata::flags and a bitmask ensures a cleaner
> > > and more scalable switch-case structure for handling clocks.
> > > 
> > 
> > Is there any necessity to validate each clock in the driver? I mean, can't you
> > just rely on devicetree to provide enough clocks for the functioning of the PCIe
> > controller?
> > 
> > If you can rely on devicetree (everyone should in an ideal world), then you can
> > just use devm_clk_bulk_get_all() to get all available clocks for the SoC and
> > just enable/disable whatever is available.
> 
> Or just use the *_get_optional() variants of functions. They return NULL 
> such that subsequent calls are just NOPs if the resource is not present. 
> Of course, they aren't really optional on any given platform in this 
> case, but does that really matter.

I think it'd better use devm_clk_bulk_get() by passed down a clk name list
.clk_names = {"pcie_aux", ...},

So it will not silient when dts are not matched requirement. It is not
complex because only check once at probe.

Frank

> 
> There isn't an optional variant for phys, but it can be added.
> 
> > 
> > This will greatly simplify the code.
> > 
> > Only downside of this approach is, if the devicetree is not supplying enough
> > clocks, then it will be difficult to find why PCIe is not working. But this also
> > means that the devicetree is screwed.
> 
> A sufficient schema should prevent that... That's what they're for, not 
> just torturing people to learn json-schema. :)
> 
> Rob

