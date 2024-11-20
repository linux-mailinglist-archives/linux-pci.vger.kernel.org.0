Return-Path: <linux-pci+bounces-17118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA89D4091
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8182E1F25521
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813E14A098;
	Wed, 20 Nov 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D4gyBuyR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46714D28C
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121625; cv=fail; b=FKg7AIJvmFNY1ymYDu9bkUMlrHoVuduIxzg2nuAgOVbBiKeSOuOSX9FXwf6OMYd3QMfmPlmEnWr5QmvEnFryyeQagUP/9J5/oil0t+7DuOzl5HVea/AYJdTZ6brmsZtcu09N0wvrLKzd1/meg/4uoj4IaH/M75LhuUg6b07GttU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121625; c=relaxed/simple;
	bh=RyMPKa0tj8OSAhBsqciNeYgj2Gl+UUL/GPbxOCPZC6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPGCcNG6IxpcwCUOkCSxw33RfhIadwODLwldcPJCDg7nlBSjVkg/Sc39NSXhV7DgyIRm4mBkGp1Mj+tB8UHTLAmRB4cC4WC7q4FyXTsdhJ5lbULlyQkUibraMDn1v5fV4rZGBteyW1CbTmFbs8uu2JnkGaEhaejvSRtAXH8W+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D4gyBuyR; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCzlO3clGvLxZR9ci4zwT+GxHSUNawec6W9rOtyqZ6ygR3hXsQq4L8OW0k4eGdxph7vHP2KdHGTffQ0ZwI2Y0XKERJad0SLwAzEB+v+fPwSyUezV70gUcgZmCcKpGFcr6LcCh/dKudTiN601DYQBdRPRw7kubGYQlqnN1HRL0SYujW/O4LjplonuXpO89lVTgTqLj4AtZ9SFVlffRIYMlD9/uVi09bT5uc7twjQEr2JA13f6MeBh7FEK27qIy9QzSQsZGhFJMEDYHB8ir/dzm+18eVjMD3MVyhjIYLeYWJ5fi4MdlhbLG/DHUZyaSDa7Wk8ohzKX2dkOmxIgGXBPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSAAL3GfEk5trLo5wqtplWxzMII3evrO9+dAKJQLdXc=;
 b=Zk0V4zabxuT3PGg/hgXeEPHtbmusUNnArd7zxG2+9rKc2hvBLnt9MG3F8Efne7LTd0AeMybGwRmsKcUYcXmZhAoUUsiSyjaU8cJoK5XNDE6KvvLQDeufKpZabT/v+khEgYtYa5TDfgRrDv7r7yZP6y7NWkoP7VPhAZllRDzr4t+Kj6YTNGRwAb2948QJBqoI19gWA3nSbBHTunduMhABaE2WciOg+FAAFs6ZO/dLyTKO/YCSMXsoZJIA8SLTQtwRLSX2fKODCIpio/6mGgvyWAOpGP/7z6m2xHvE5BA8SwnS7PAHcVznbeTfi6wCMb9Jw2+EgDiPqfOg1uBu1tiILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSAAL3GfEk5trLo5wqtplWxzMII3evrO9+dAKJQLdXc=;
 b=D4gyBuyRW1RaG6lAcc6iT1WXk+oJxxZyacZ0qHsdu5SwuKYNlousDGL17S7XopR2liFxjb8uQn3d2YzXcYdPkVYVszObl3UptT4itZLm0KNvee0QaVGM8Dzqo6iA4kXvKdCEyi+AE6PA/Apm0eXtqWBuYFcBwrRHH5iLyl5RMpoBmbBb6tOowdwzIefcvV3byngN5RN5mQKTT7XQab+3d31Te/NtaJR1fLddMLSsoC4QmsiFmYpdYFr3JMTEQJ8txBzZBfb74FYyO62y47mEevaxfi9Blq/fKMagmaCRJrhEGTf4NMHrpgC1qY8OfqNhgHejvX8zB6K+O3Zu6J1HeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9993.eurprd04.prod.outlook.com (2603:10a6:150:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 16:53:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 16:53:37 +0000
Date: Wed, 20 Nov 2024 11:53:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
Message-ID: <Zz4UCX3bl8MHae5u@lizhi-Precision-Tower-5810>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120155730.2833836-6-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9993:EE_
X-MS-Office365-Filtering-Correlation-Id: a3379e8a-3da2-49b2-9aa8-08dd0983e096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0v0pmwW9RHLTdzM2DJzw8ueCZb4mAEub7t1aJD41zZeQTmCyyY6HR3Dt7zW7?=
 =?us-ascii?Q?TtiyaHpmOSyTx4FRYjQW63A8060tpCLAdedT6KYqdk1JMRYgOVrtvytqQd/g?=
 =?us-ascii?Q?SOVcZKz8sI3ZMNW44slE5ba6q22tysmsfNbksHhIIYZFfE5f7eGervA92rS/?=
 =?us-ascii?Q?Td0e/2WzuilPGyxcHP3+vrtjELGlgLmwzdlBHEBeL+JJ8C2JrzmF7KyB6yC3?=
 =?us-ascii?Q?LtU9h/UKFFNm1K5BeVNJ3fCuuRpJzo2QjdnHgdQxdNeTLw0M7nTukS0L2gBT?=
 =?us-ascii?Q?NWjsIZqLWa+WY4IVbw9L+6GyD77uB4q5YtV9Bddc/cxNytkJ+jV1kj54gEmn?=
 =?us-ascii?Q?wtoqlXyNIgcE7l2SkR/pT538Muzupr/VJ/iQujHVxq25Rz+CHOCsHVombqRg?=
 =?us-ascii?Q?fBUEeonJNa+TUyFSAWiOJtLacrvO+v3Drv3/E2ds29Zn4mCY2mC9ieu3chse?=
 =?us-ascii?Q?6bDKBrjEAxoFu3C/ClW7LZbtChKK5SAUAWKfPs5kn1AIfZUhgoT2C9ewd5nW?=
 =?us-ascii?Q?aoDBMAegcR2snWFJcj4m/2XyrExdo7ILBCsdw75leD+pQ2E16YU2I15zWh4V?=
 =?us-ascii?Q?r2a+JpjL+VuRqkvBdKxHUaY2MnJSXW6feoSXRnkN8UbM++S1nLYpAqC/zKSL?=
 =?us-ascii?Q?kA0r70ESY4SfjBta9eM5z/2+Wk9C3SXk7UJrrltMXMSLpdoTdiSIBwgVJbyV?=
 =?us-ascii?Q?1pbcyHwFwaSk0XjyzOCfjOLbfBUXlmq9SR/35CGKGY6aiobYgZwckUaeHdHl?=
 =?us-ascii?Q?CH53O6BW1VLCKAInxNWf+FQMGPf8gCTBluv1aSbjSxhZnLbuf+g4QVZD9OrL?=
 =?us-ascii?Q?cz5OFhiC3qMylCzaJe7HuQt/xpy+schNK8XmjDW3e/C+uLeYQ0543o1GOVxH?=
 =?us-ascii?Q?KZn70cJNowST2LRrtQPQGnsYI0QuMLlwcnsUVrcddMeoUSixVEq/yN2IY4vP?=
 =?us-ascii?Q?2PepzQ44aubr7FCIN1V/3/QqHIyqfs1JdroIFcjYjE1w0h9yDxr14C079wDQ?=
 =?us-ascii?Q?FPRHBjcHbKcaZuqIlzD1QXRfDe1yHPT0ocUFM2etyds9gSRq6r0F41sY0ftZ?=
 =?us-ascii?Q?wYOCd4xtjeQPKS2mm+R/5G67MieBim+euE7iHHFXC2tiHDmONbIrqvY4jc+m?=
 =?us-ascii?Q?bEPd86tWYsAzw6+Rl0vP6SKJBCV0BeH1/0sBLrQxxYbeU9LQqsH2ZuXCNNTg?=
 =?us-ascii?Q?YH3Lz4SF8ghqWcSE28V7trkQ/fREH/moY8gYg1Rt5il353QEzq6ktDw8HHHg?=
 =?us-ascii?Q?dvJR438ajEnHshgiC0Ld34LesN/gzG+rsMQVUgD8aBmsQIO60ioUt2YPKGUK?=
 =?us-ascii?Q?YYKWdFDL8byXk8N5ooO9S/tDVYUWrArCf5GAbfIry1WZZ56H7B/754/xTrP5?=
 =?us-ascii?Q?oby/540=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTNBt8553iAW4+fFMyLEH2Q13Kc5o6ByuLsAiM3kPZ8tAk2TKU+R1ZBHf8lU?=
 =?us-ascii?Q?hTtawDs2CpYSdy4aXLF3buNzNSoYedWUm+QpeYdMV4yS34drEDpphgplDjj7?=
 =?us-ascii?Q?g7/FUw8jC4Oio/YbwmX0e3Q0XModxtbb7+KraPOza9o8iA3/rcRJkusCMd15?=
 =?us-ascii?Q?3e7IhiqnTRfHL/MI5w9cw9wv7mRwXpCbL2ObacK9DahcOex+BoqfZpJA7rYe?=
 =?us-ascii?Q?0+j8v6JnI9Hg4B/39sV0HRkg0zJIvCA2lOUUdHF8svVpGKG1ucFGZsl3C1h1?=
 =?us-ascii?Q?0dFaTHCT+Gb0/Md+z7g4sj9TuRw18309Bw2P2LZWzV7XgkVjyu2tvJzUpIhY?=
 =?us-ascii?Q?unXMHOmoZzwJGf8JjPTHz9l5KFPTsklHwZxmkZOq4lFNUhKWngsQnEiMqO2B?=
 =?us-ascii?Q?AM8ugHdZqJxUfnnB2GzwerBNZa2FICtAnkhMWUx7QO7ocff9O8guttc9jvd/?=
 =?us-ascii?Q?EU08GRjc+9HzcB/OmU5bZ2rRzoMQtt9Iw/6BrEN1fwh7pfPbc3KUsYuYBNKH?=
 =?us-ascii?Q?OL2I1x+iBPrqzBukIOSQO3PcJvwmfz3zrn23e/eOJpD8qvdxjR4X9nv3sTe6?=
 =?us-ascii?Q?evptqXh3yKgkeiCPhkepbACTqvX6IeJmDGTwl8kIJ24+d/ugZjiMCUyeQ8dA?=
 =?us-ascii?Q?wQ2puCs502RPYnrmfwcwv2WVIumry0EQLIG+7/g1STIAMbHwD2jOIWfsz6wI?=
 =?us-ascii?Q?x6vYZliPwAnwnhzjxTPqJrzZzmjRI6GuoZzjZ+IXt1fbGoT2NjMxayUwCl2B?=
 =?us-ascii?Q?+4vHHz1c+5pBITT/oy7UJ0M16tn8wsyMQdjx2dDtC3J0kpeG43GdKhEeyzXa?=
 =?us-ascii?Q?uRt6dXS0lFt+Easmp3tP3ACrGj0zwIMTvK0IUFD0sM1W45tXvb3RtUirp8pr?=
 =?us-ascii?Q?oC7qJTk08+/STFa3vM65AlxpMCz5Ih4l7D6zEqQpG8vWjdYF75Va4z6Ksy6L?=
 =?us-ascii?Q?L8kOvKrgNrcZ2TnFIHOEeVQe45cnYk2C/F5YqNWXxYHRvNPJ3ImkCTwsLogi?=
 =?us-ascii?Q?JdkznNlfTm07onqtAsvNrxQkyjo1Qm9g7EYodMyubTfu6vMOeXSC5d42MCPi?=
 =?us-ascii?Q?nysinxDlkU0GJKrpiE5nK1h0dTFrpwwo/FkCAzfFKCsB7b5zeXlooG/PqMT4?=
 =?us-ascii?Q?wzOrXogVPKLAlsH6AdQc8dWt2Y+VfurFcdupaBpJtHIjQA8LwLgQ3cl92xAP?=
 =?us-ascii?Q?ApgbRla7PLlTp83ErC67LLK+XF8VJ/MCeF0AOCC7gMgdyPzLA6CnxnaI/58t?=
 =?us-ascii?Q?9KccF2KRfKDcJnTIw8IH4LAJaqP9sgLXqx1FTKVIP9HUshnrO4EZm8KJUTk0?=
 =?us-ascii?Q?khYBC5T+aioKqeM193/kIk4YJ5x6HzAqVb6d5GH3a4m7B1eDKZOiLyUmNKHM?=
 =?us-ascii?Q?GvVKxbLhT+dOu9Qog4b5wLY3AdCy7k0SHWsrepEU/2qUnMbcyNImYOL0HMza?=
 =?us-ascii?Q?ei8+ALund7XliPewS44y0bKEERSn0589cIMtxXbMVkgHG7ivfjxXu+qbz7bP?=
 =?us-ascii?Q?IEQCCTJoJxbp8VLgVvHtutxiQaCCAnO5rzJDYizbuG067t3N2z5dyW/X3lLQ?=
 =?us-ascii?Q?batOI5X6sYh94ncnF9lApX4IGWY/LL/lywiD25TB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3379e8a-3da2-49b2-9aa8-08dd0983e096
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:53:37.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96q3g30e6unGn8YDXmRXeGKSUwnFPrYUYRj4nRFW3V/PNRqPP262+lblfatc8lq6a44LtSFZpLsx8WQY96Fh2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9993

On Wed, Nov 20, 2024 at 04:57:33PM +0100, Niklas Cassel wrote:
> If running pci_endpoint_test.c (host side) against a version of
> pci-epf-test.c (EP side), we will not see any capabilities being set.
>
> For now, only add the CAP_HAS_ALIGN_ADDR capability.
>
> If the CAP_HAS_ALIGN_ADDR is set, that means that the EP side supports
> reading/writing to an address without any alignment requirements.
>
> Thus, if CAP_HAS_ALIGN_ADDR is set, make sure that we do not add any
> specific padding to the buffers that we allocate (which was only made
> in order to get the buffers to satisfy certain alignment requirements).
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..ab2b322410fb 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -69,6 +69,9 @@
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
>  #define FLAG_USE_DMA				BIT(0)
>
> +#define PCI_ENDPOINT_TEST_CAPS			0x30
> +#define CAP_HAS_ALIGN_ADDR			BIT(0)
> +
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
>  #define PCI_DEVICE_ID_TI_AM64			0xb010
> @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
>  	.unlocked_ioctl = pci_endpoint_test_ioctl,
>  };
>
> +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	u32 caps;
> +	bool has_align_addr;
> +
> +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);

I worry about if there are problem if EP have not such register. for
example, if reg's space size is 64, but host try to read pos 68. I think it
is original design problem, it should have one 'version' or 'size' in
register list.

Frank

> +
> +	has_align_addr = caps & CAP_HAS_ALIGN_ADDR;
> +	dev_dbg(dev, "CAP_HAS_ALIGN_ADDR: %d\n", has_align_addr);
> +
> +	if (has_align_addr)
> +		test->alignment = 0;
> +}
> +
>  static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> @@ -906,6 +925,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_kfree_test_name;
>  	}
>
> +	pci_endpoint_test_get_capabilities(test);
> +
>  	misc_device = &test->miscdev;
>  	misc_device->minor = MISC_DYNAMIC_MINOR;
>  	misc_device->name = kstrdup(name, GFP_KERNEL);
> --
> 2.47.0
>

