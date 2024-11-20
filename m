Return-Path: <linux-pci+bounces-17121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C378A9D40DF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498AF1F21365
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBD1474A2;
	Wed, 20 Nov 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQxFzKqk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415424B28
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122783; cv=fail; b=Y7H4FZksj22AnD5B1MWJVYyRmLP362oWUW7mcBI9F7vnL36WL0+PHuo767uiiGyeXG/jgj+loC7iyU1d6g0gxtRw7koWNmiGLpwqvOZy9NvE6D8Z9IzgdHde6vXtltl2yzAD9932ngH4rbJtxNGo837Iv2oEmB6ItuzRKR0D6Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122783; c=relaxed/simple;
	bh=GvZ2j61zZQ6JF5+6y/MBwWnmc6n/8Zjgu7SeIsYseH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fd9+1QfIJopId23X7W/I6vjBF8SF+cfTjtwBT/rZCoYl3DT6n6NRajJl6Q8mCwQxIfIKHmdocLAZmt8GOJ6Le3bw18F+t9WsX++F0RztWlJE6vsB8T0uhBo7OlZF7SxRIh1lNJtb9Z5Y4YnpbQ8YW1zuTOCZtgrtjC9jjPbo3Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bQxFzKqk; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTVDQoLDn8l9gGxwMA/hmoKLB+vfJDHQ2RCEzGX/N0EUdEkoHhvX5yWgq04VtMljNNQrOCmAaLC5DAfSa0FjwJ/W82RgYxP9g7fbFKwXLhp2FpDxiTULkI4aT4kSWltp2zEEb82NZbCPyJrobHHPMrcqxPmhXoShcRhqU9KkB65F7vo44ibjajy01v4qJapjeAzAYOxVnlJ5EkhFozzJMauVe9i3E8kSF7T3Wgnws00qDgHnDZwiNOUdiFhtE8Fhw+pCA3XPbfBVa85O72r6vQd/xx/2GkIfyjeZyeWQCD+MvzDXPQ3Wv3WOAwAJCrQCuFH8uzzbjWefqPI5nWiYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeYeYWphFMWnPc7ahAhRt88lqVMnUvo4LpYOWXN0ObA=;
 b=FxwqhF8lcjPwq4TizlQc0Dy5OfQpQcfRHwTPVbuQbtBNMMdVMLh7v+93T5OKStdlMEimsGzyn5HS0ifXrJcAYyv+Ks3yvvX/UMK8HAu9hXzrm61YkAr7qvBsoGIpj61h7jHqz2Oqs9vjWd5k7eZv2pwh52yC8EYJq+BMuU0nrYTJsZArqGAtniPJruen1aQWd4r+YqUpMmcSBBNCnWQZ/LZpDM3U83SMQEvp5ExY39WpyNR9qYBqW8LdQrpIqVIu3NvVB3LbAokfKIqi9gmhN0cCwPDQY/3jrFE4nEFOzh1ziGLyCuyuLtxal5RtQrYFaYlLDru/p3gqgQNyaS8hpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeYeYWphFMWnPc7ahAhRt88lqVMnUvo4LpYOWXN0ObA=;
 b=bQxFzKqkuzMQmbB49fh3TpD2bC0YNND0JkoS1Wl0CPwzAp++xhbrhx9LVOzPQdBIweJnKJHR0/hnmMhqadHTUgVkPuu+/WhklfhiqdgC1ip0xH6mdFlbiVWNktDVSmhd+kzsV5lUXZMYc5htgpeUY6wBDQPa7To3YnTNx1X0CMTSBB/oOF4pPm4usm7fRs9JDZG2Ji4p+tzFonLwswOEr+ngLtgsysfzcWDkSgVYSj1wUr+lWznYOQG5psaYzuubiF79DtA6wAnJPZ/aEiyvt4Xj4NQ46HnEI2E9NfPveSC+ey6U9olHXv8w/5THj4AqF/YJgh/Z27uiv6ZTODSjfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 17:12:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 17:12:57 +0000
Date: Wed, 20 Nov 2024 12:12:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
Message-ID: <Zz4Yk+GoLoaRRSLJ@lizhi-Precision-Tower-5810>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
 <Zz4UCX3bl8MHae5u@lizhi-Precision-Tower-5810>
 <Zz4W26SFMohbvsN-@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz4W26SFMohbvsN-@ryzen>
X-ClientProxiedBy: BYAPR01CA0005.prod.exchangelabs.com (2603:10b6:a02:80::18)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcde0a1-8310-4621-9c36-08dd09869466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBGmrbzFLkpJvimBcn2YzMhdU66U9IcBVd4olvr2D9p2QTnJzBrfljXnzbTm?=
 =?us-ascii?Q?v8Tva0uAlRpBVvAf3JfrTu23FXSeDpevC4Y4HNRguubRFJ92PlX3Rv2fes6+?=
 =?us-ascii?Q?mXK/fxc1rfh37nFypc6UDsGucdB6XMg1E1vqBPU8AXQ8gIkxyhq3sJO2hhzW?=
 =?us-ascii?Q?c5HHkyFyujxEEX4Ej2MOgng9ByGx+FObaZY7XvHpdG2TE9etrqZTTyx+0Ki2?=
 =?us-ascii?Q?7ceIm+EaxZh4oyNtmlFPLsNfOlZzldRSBX8+M0E9xXHEr/LR1jy1/CzamDuG?=
 =?us-ascii?Q?tD8X+TZMDRpvnCkZ7PrMNjIhkLrfaLgnhNa4WsRPlo7fnn770Qj9fLHjvXeh?=
 =?us-ascii?Q?zK+LuQInuQgKw9Ecl1TlGheCYAYiwsGhWCGfIAlYlHNdIIPe93ftVwgpIdYI?=
 =?us-ascii?Q?3+Q57+wraX9ayPSrPZXqrW8URA2GVstt1zNbFgHMg9E6WNdBHEmQBSaIk9LS?=
 =?us-ascii?Q?AgWCQ4ZnHXFEZ4X0pFGKGrLb8mHb+oiQ8oti8eSsJUhYbSpYrwoflmMMSpVU?=
 =?us-ascii?Q?a6sLFWZUlLBPXiCSKeuRxnfThBjvbPwurHS2MKMUSaqi81INvSUniogqWg1r?=
 =?us-ascii?Q?HBPadSQpgiVRZ2zauwNX5rLegHgV80hRKSYwU1c0cLnOBK+tCvL4VB6ZsqwQ?=
 =?us-ascii?Q?RAFWO6Fp0weVfvdNrQwGRx1tuWaE/ZD+UrzWWH20iE5m4l88HiE1tWyFt1jn?=
 =?us-ascii?Q?R+OwyBFL6xtiKLG4m1B3t/sezTZlX+ZhA6Rw2aRoEamRKC3SdVPOjQK3aeZH?=
 =?us-ascii?Q?q3ktYv1KrGd6J6DluvCtBBNqWqHYyDwhhxI7dyuEbSQzgCpxaTdve4+hUkWi?=
 =?us-ascii?Q?5QAjhEwdeU5iWL8Cs/JN8/ryehqJR0ERxh21IbCvNxSk4VgrULWPyIQ7AQgs?=
 =?us-ascii?Q?MO02Bt6SdXirW+ArIl/XQ+ZmUvK3cqOcj9fQRuEhIqHOhnIzFar1MjMMoN8Q?=
 =?us-ascii?Q?sd6L81/OyEzGkH/pDDWzoX9FY4WchDOwRlu3MCxgz7Wxfcwe6DmXlRpp/lMM?=
 =?us-ascii?Q?EW4ZJxOeMPZMUR9lAUJXJdjNfvwvRoimdt1moQ94/nLv3UvhSTixzrEaeDLb?=
 =?us-ascii?Q?kA4iJCfuE7KrH6hLvSoyEbP43qPlFoISsrD7NEumuuo5tPhV209bQzhEbHxT?=
 =?us-ascii?Q?qEB+XrtqC3rb1oePUSsF2bEgvg4WIELsa/NMiWwRuAHPFfaaB6FKGwMpc/97?=
 =?us-ascii?Q?pw5v9fefuu0EbDgF34O/CklhaRibi30X2irzQesc5QSWccnLj3sLboWWdF3f?=
 =?us-ascii?Q?gW0z9QdVb1LhugebhiOhPyY/ggsqHqBF82y13AcWowKLtS4wHigQn6nMv2WT?=
 =?us-ascii?Q?aaz5m/gmmP1Zfc2rYySPbkLW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2eY+ztLen3b6zlR1CP4B1sN5ER7kg3L/Nn98vXAqnJtFF910u3x1KSM+8YJ?=
 =?us-ascii?Q?QO4jWaSELFJgX5V8IiuxoZdYSVCFyW2+nwZOVYsTjRq4nYr2l/1mM6leJt43?=
 =?us-ascii?Q?hwM2XCZAZpucZk0cKpozUUyQDbfJFYJ+LI7MJtPOkY/OQ73OjDOH/SEbzLup?=
 =?us-ascii?Q?oD3w5yTWr15cjNnOjXb1AlaOpOLBFOeayfq3o2dT7HmpdMr6E+CPu/d4nDnM?=
 =?us-ascii?Q?vUm1RJJVU7cdpi8ZrK0DEyQryuHlrAOCwMH7yoPN1RIodXKvbXkYpzbig6So?=
 =?us-ascii?Q?dQWGN75bpl+1bGmbfA+mltKcNnLl8N0QFLguT/ltKsmeav4uIOf3BRftwcUE?=
 =?us-ascii?Q?w5QPqc3coQGVtRMHGboo99xcrBF9UdOYGcO18LFpKZPCGzE5fOOGyceoKio0?=
 =?us-ascii?Q?fk3pwGilpO7t0lK/li66b4BSarvfu/fhdy9ZMjLLtavA9DVcQ0BMUED/Fb/f?=
 =?us-ascii?Q?HSFX4xH3INizPglU6e23+7yfobLj2flf4drrXWo3pF70fP27HFXI/pTisrzw?=
 =?us-ascii?Q?5rn2zT58H7oOYCX1kz54+JCUCt3OMpnfPr18bruIIsXeXUDEIp4zoFJYWVg6?=
 =?us-ascii?Q?2VEVpY1x+vXConcGe5Xou1dpHTKJ3RjZ0I6Ln64DEnCMCW2ghZkueUO7bsbA?=
 =?us-ascii?Q?6NG9mAR/RUP9gV9GAihyJaruJ9P+/MUm9AK0HFueH4vVvcxfGhPWgV603llD?=
 =?us-ascii?Q?81N16eDPAg+Eeu7XG3OMiJPWQuEp7lXbG8UACDA+eEPTsFj+gXmbdj8LMdJR?=
 =?us-ascii?Q?P27UqnSbqjhbGANaAaeDDnpCSEOb1UeGfLuQh3sRrm84SHJ4Cf+B3AYIXCMt?=
 =?us-ascii?Q?lEwEJS0xnOTiRqsmKBKT1Xfc/IHy7SRIp7plVdGuTvVcfmYdMvXsqQvx57P6?=
 =?us-ascii?Q?LyduK+X42oBDPIG5mbUE3075ddGGa84cnx6g8wgXQCc06MHvLJthfHpfkf/g?=
 =?us-ascii?Q?WihcE+EzjtpxB63L/istkdKuhLy1K1jIIWi7QRNrsm9tvjfKfzwmsvwMRYJO?=
 =?us-ascii?Q?3dSQODDjS5g4lrl2NIQiYJ+DxrUufkHzyWFj4Dv8z03Rs2E5xuRcH/TcRtiI?=
 =?us-ascii?Q?F+otPq3x9dClXWFiX1qK2AnDvQwGlnrRLt+qaheeWvHYH9CDZ3pVkJ3jQbuK?=
 =?us-ascii?Q?3BbEPuWH+lXnxWRQ35py2Jwu8lQzfeNoM5E1rF21ST83qrXRr+/UxOls+rAy?=
 =?us-ascii?Q?o6DSk1Y+m61WM+REvohUTpZ7r2+G8vPBp+P85xrWk3BToIjQIbSCtU+AVgMP?=
 =?us-ascii?Q?DuEHOHkeOm9rbxy2zoZsgplefXnP5nwmzAqWq7iSc2xnp1SOXseI4rlb4mIZ?=
 =?us-ascii?Q?2g7xS9VUEswiJQlXl4CIigMqZRNjI8nzMB0qJJ2/41S7YJKbJTcmOJA8S1BR?=
 =?us-ascii?Q?WlesEkEptSdSC9EE151NwxIRtSHuTWeesuD1p8kpThfG+CstmeWgsK8xhRQI?=
 =?us-ascii?Q?GJnyUM9/Krhv55Z2C2OWPfWWCa/oHCjQzIDp3ZmTALIseeF0fV9KYlsZ6JUx?=
 =?us-ascii?Q?Pqd6NcRYyZEZ9GMUXB/x7dbLhAUSYeGp99W/eI0QTFzYuwxoYGxRnvwu+K3f?=
 =?us-ascii?Q?yIbBBmk7e43zRMxiMGI73eQRJcDByYUbU8P1HK1x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcde0a1-8310-4621-9c36-08dd09869466
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 17:12:57.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXBLbr00V4WsIGO7q6rWdc4ws6d8jhW15pK0KeCzVvVo4eFgDGsZDrw9VPdBYj3+v0yXf4jMdT/xSzMv+cmjyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9186

On Wed, Nov 20, 2024 at 06:05:31PM +0100, Niklas Cassel wrote:
> On Wed, Nov 20, 2024 at 11:53:29AM -0500, Frank Li wrote:
> > On Wed, Nov 20, 2024 at 04:57:33PM +0100, Niklas Cassel wrote:
> > > If running pci_endpoint_test.c (host side) against a version of
> > > pci-epf-test.c (EP side), we will not see any capabilities being set.
> > >
> > > For now, only add the CAP_HAS_ALIGN_ADDR capability.
> > >
> > > If the CAP_HAS_ALIGN_ADDR is set, that means that the EP side supports
> > > reading/writing to an address without any alignment requirements.
> > >
> > > Thus, if CAP_HAS_ALIGN_ADDR is set, make sure that we do not add any
> > > specific padding to the buffers that we allocate (which was only made
> > > in order to get the buffers to satisfy certain alignment requirements).
> > >
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index 3aaaf47fa4ee..ab2b322410fb 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -69,6 +69,9 @@
> > >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > >  #define FLAG_USE_DMA				BIT(0)
> > >
> > > +#define PCI_ENDPOINT_TEST_CAPS			0x30
> > > +#define CAP_HAS_ALIGN_ADDR			BIT(0)
> > > +
> > >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> > >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> > >  #define PCI_DEVICE_ID_TI_AM64			0xb010
> > > @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
> > >  	.unlocked_ioctl = pci_endpoint_test_ioctl,
> > >  };
> > >
> > > +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> > > +{
> > > +	struct pci_dev *pdev = test->pdev;
> > > +	struct device *dev = &pdev->dev;
> > > +	u32 caps;
> > > +	bool has_align_addr;
> > > +
> > > +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> >
> > I worry about if there are problem if EP have not such register. for
> > example, if reg's space size is 64, but host try to read pos 68. I think it
> > is original design problem, it should have one 'version' or 'size' in
> > register list.
>
> Hello Frank,
>
> The test BAR is allocated using pci_epf_alloc_space(), which allocates the
> backing memory using dma_alloc_coherent(), which will return zeroed memory
> regardless of __GFP_ZERO was set or not.
>
> This means that running a new version of pci-endpoint-test.c (host side)
> with and old version of pci-epf-test.c (EP side) will not see any
> capabilities being set (as intended), so this is backwards compatible.
>
>
> And as you probably know, pci-epf-test will always allocate at least 128

Can you add such information to commit message?

Frank

> bytes for the test BAR:
> https://github.com/torvalds/linux/blob/v6.12/drivers/pci/endpoint/functions/pci-epf-test.c#L833
>
> This patch uses:
> #define PCI_ENDPOINT_TEST_CAPS                     0x30
>
> 0x30 == 48, so we are currently only using 49 bytes.
>
> So we should be good.
>
>
> Kind regards,
> Niklas

