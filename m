Return-Path: <linux-pci+bounces-3796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF4985C8AD
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 22:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BEC1F21DF5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6745A1509AC;
	Tue, 20 Feb 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndRR7z08"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB6151CD8;
	Tue, 20 Feb 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464265; cv=fail; b=OALCC26C1B7h7CY1TgZIVyIdDEcjHm7vM8RPDwigO8aaXq1EBAdVNyT5VDBDMOfqLFe4LmKsTljN/69Pnv4nGE8gJvaTIa0WiWx12NoNsAjLxs5uFyi+5pCOh1fn4tjkG6gIQFKbQtjoEEC8XgrpspNBbP9HjQnAnmE3UlKyKI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464265; c=relaxed/simple;
	bh=Bre9pGj6rBEHL0ym9Ay/IinDxUXtrFLCTJSDDiUHCWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dn9eclQvcCiosH6vpfpQpKrRgibuJH7rw3+LMX7oM4ikPFNKhq9Pf+BnLP2l4W0ynt+wB3AAoRBXBeyOk0gM5vXBgWMZ21NrYPZEvOLpb3LA04dDWiNL49bV/mURXSw13D+DefR5RL4MFFMcgU1NQO6zECZ+hzgupSJq7BvsLOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ndRR7z08; arc=fail smtp.client-ip=40.107.6.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2Q+cy6Z+sVLCziw0PhD6FXrxLAYmEao1ba+Aj21IzdoxeYcUMrfSa1ygNkRvbRzkhuLqxcgXkiABfaa4GFQ46XtK/NjbZbRBSFARCTrhNE0SY59g1b3pahHC2dF/w26YaM4F2iCAZNH+XWw+D9LnCTHQpPreVKBD1cPhSJ5DpUAl2gFu7XyypmDYa4rcfGVXx8dRuHkoJaRUW5pVQOej0PvWYshxyQyeOxL8KoE5KLInynIO12RWqNPHOO2Ha1Ls0cuChD07mkRSreqjFe1aJgXdDJBmoCzlGEM3YOTq7ExpxD7b5yn/RdOM4RwJbvzuvPEhHnvGfh/P4s1C76K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFUGFBgUbAZZ5G/lCxF5ssr73xy+CGQOvkhDdGTd0qI=;
 b=ZHEJde/tPSlabiomS3qkRfp3QvtgcdQyMk7U+gfNogxWh4JdIovZmKAaEU9tCWqTfMcEMT4NZH1hpt+NuOMtTtysbxe3CptD4ndADWxi57imcAv3vwxtkV68OTraAohEc2EO0LJjCEh9/dzs7IUYHW6Sg5wCCq38AwrX3wHnE8zmp75T9OfaneS7k4RVk12MaSgab1PtrOhrBXkjZYhCoCQLCgrwoVcMqGbL1csQ1GUpVb1EQ3+e1fmJ90Kt1HSnw6ptTSMASGZppg1hnMFkRA+YQt8ma9Rly78XgZRwWUbLYs7Tk0KjGQb4apI+VshgbZ1CM70pFnW6L756oaZxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFUGFBgUbAZZ5G/lCxF5ssr73xy+CGQOvkhDdGTd0qI=;
 b=ndRR7z08PoRatTq5o6vZOqtLbFhcifMtRkz/z1qbAR3G5MK13Q0e890eQpGkKMzcZCr++bxvlM2FWKfdRZAzV7W85Szt04NnWXnTBnFcrj7UpLCNJzqWp90yAXQgSVqFxXGg271NNU2ABWbq5O9VNWRSk7mAo6i7UbsrRw3vUyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 21:24:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 21:24:19 +0000
Date: Tue, 20 Feb 2024 16:24:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 00/14] PCI: imx6: Clean up and add imx95 pci support
Message-ID: <ZdUYeYI4UJ4ApV2X@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <ZdNvsdao8jbB/52L@lizhi-Precision-Tower-5810>
 <20240219161208.GE3281@thinkpad>
 <ZdN/OyNpw0Xa7qXG@lizhi-Precision-Tower-5810>
 <ZdR2FRQ9Fe8hhK9I@x1-carbon>
 <ZdR6EUOv6hzLEmUa@lpieralisi>
 <ZdTRiB9JdQSvBwKn@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdTRiB9JdQSvBwKn@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 511637ae-8672-4c3a-219b-08dc325a4c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PaFcohLzCjvuZLuDwDdsloF3XiYuevKf2by7Guk/I+zG2ShDJ4lXOhiB8FQJ7gkyhBJdzG6GA03NAfZbW6HtzoA6lcaKWc9hIFQTxybgodt6kICPO4dWz4rtmiyiBv4TR4yRZhJWyK2802UBZKFT0glzpxDv93S/6VjPa7Vhd7XPuyV5BU6sHXU9RTxT0Elnqbt2Bze4txHw3XcatuGBmQeQRjnGjpPR9l6SudsT7cBkOJG4592QDnmDXXdCcg8Lu49y8LlM55dLuTypTevloQYf0ECaug3x6raRcJvy+Kee7Cv5HNLG+0c9YpilFFAnSjDNgU8HKmUHN9KWlM6EiF81JQxvCfA5XFgbf2IOpwcpgpLwteEhMXZcWBiWiH/y3ZZeM1IlluyZ865f+is0iGo2NMpxoHNL9ioUfM1JN+kYrX91M55ZMHQ0vch3eyWYBqpGruaqOq02TvDGc8uAEZFUjAJyxPQQb/cyOIcYG29jk9KXgjOIvAZX1RVDwZo0HAYoDSNsJ06UfXYXLcXIhinOl9vQ61EyiIYBKXAV0Y5KcM390WHvZq02NEYVQZ+xrH4L953qvrRO4NH7j0fUi9yg72T8o5XfudSgnoeI1Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rrm2Tf/2QPqEptH14xNJMS/QxM081qUFRtkzg07dHuHW2LOpjZrnO0tbRWd6?=
 =?us-ascii?Q?6FzB49/U3ELHIV/UMtTZEQbJjuFnV8TxigUbtqV/km4rhMg6fX6dGFrhBBJ4?=
 =?us-ascii?Q?xBKCDwK0yLEqjYyyDOqHJQq14YmNykoSTtn/VJyM31mWaaTYffHkahtbw54L?=
 =?us-ascii?Q?/PgywBsO3IOwygoycumz5IpqCCJSQFCVFbGt+8B/TqjgSAXnI/bbfx8/VrB6?=
 =?us-ascii?Q?7tzM/id8NcWYXW0TzH90bLCb8D5OGXo+JuCLChWdMQ3b41oiWYAH0zWKW4kT?=
 =?us-ascii?Q?j4AbCysvd8ohpSZzlcWQ072bkbdXa0UAT/lary7RGVsL7KZGNU4iBxwtWUun?=
 =?us-ascii?Q?qDJUAHZiyo8rDbgfTPxQe/Go9ArY6TdE+A3jKth24AKoYTUjWHdgyfiTHwEl?=
 =?us-ascii?Q?npr7a3jzQ/0enkYQQvStiuzm/afTUxdiJpdNgNbuc3GrPzyUCAzhL6dKU+15?=
 =?us-ascii?Q?E8m2hTs+YVzs4j/qYIap8Hjy9mXPWiJtsCR9QY+YxtIkb9cM/ARkGIDHJepW?=
 =?us-ascii?Q?0kHHVmke+Y+Jaqh1VBC30gZUrPb1QzstZ+Ssc8cvWcNIqGSF5/lKlrVVLCAX?=
 =?us-ascii?Q?foyO5/fEz9jQUiHQM7AajgqglW1sTnfOeWvrqQUTC3OOd13+jIJJz1rgai5W?=
 =?us-ascii?Q?nB2oMV8X1ECA8o7rxUxFjdNnMJgWn0w6sV9w+EG+U0pmeSRY7h8LFrRsCP+S?=
 =?us-ascii?Q?FmHL/EIm1acRHt1+K3D6GKO7yyzQEYI/eURVonQ7v5l1NC/j5tQFYl1tBqWF?=
 =?us-ascii?Q?PQKEqGRLemeb2ikcIsNzXdMfHS8eDOIxJBbGH5K/snDN+JMNOQRIugcGEcNt?=
 =?us-ascii?Q?yNv/M3xOWd4SLt9Aqw1dGiybIaHubIqIITFWb+hbPnMHzRy7G+DiOvoDzo4y?=
 =?us-ascii?Q?1+L4hoQG1RI4eNin31SrWZqBLPhKrQVLxizyAFYRvHtFAX08ihSmI1r49N0O?=
 =?us-ascii?Q?BL0+Nj6FmU/arTLpEPfFq7gsXbcCX/Iu1sYekhJNp6dbkitubYwQ34NKUfz9?=
 =?us-ascii?Q?hERfhc1C0Z8frLXGxhMSBThS0lXrcdPv5xW/HYv6AE/Pr9Xz0nu6Khf8nE0e?=
 =?us-ascii?Q?Od8AFBYstujXNmu2QGKi+cAegx7c5h4HRVrC6ZUlFRS5SCdwsECE+A/ijPOL?=
 =?us-ascii?Q?8v9x0fku5++y63FFtpFO1ueM1H5rcFlCyWuJqPNq4NitTc6xtqB5acdkb0bV?=
 =?us-ascii?Q?h79XlasBNJed6TKyM/oAdHOAsrULNWxDJm67XDEKzu4GuMELryGgwZa6Wtfh?=
 =?us-ascii?Q?8/H7oiU/jWeTpMeGyqsyzIEMmiJlxsVnZ5/eCNxxH2ROJ9qQn6y2cXgViR+2?=
 =?us-ascii?Q?trela0sWvmHq5zLxqcWLCq/vwiJOXkJC81t/bSzVxEmo/jm70aZ+t9R5joIR?=
 =?us-ascii?Q?hEh13OG/iK8OunK0voyxQbdKBqroiNQFxYazClALmPpt5hefC61PJC8oQqi9?=
 =?us-ascii?Q?TzxKy1lT4He6OAn8HBeYLS4nvuYxUQEqeUCykbjqBjlY74KVk8AgUM6e2Nbm?=
 =?us-ascii?Q?r//ErMtjsLSr697tg3Hr5Pf9T9VTmPdLLbhfW9K+7/3uL7zQsJT9XHuwV8T6?=
 =?us-ascii?Q?ohD0ZKvcAVNzCKsb2ISvv3pbWR9aWs4Wg6XjnrNF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511637ae-8672-4c3a-219b-08dc325a4c7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 21:24:19.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/5TQWZIi/f8X2A+JVPWh5yFYNYj1ia+EHGe5uuzyF+CAdWzFowlDWQb4lP7/XI3BSiricaiBzWisxaJHGmMLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786

On Tue, Feb 20, 2024 at 11:21:28AM -0500, Frank Li wrote:
> On Tue, Feb 20, 2024 at 11:08:17AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Feb 20, 2024 at 10:51:17AM +0100, Niklas Cassel wrote:
> > > On Mon, Feb 19, 2024 at 11:18:03AM -0500, Frank Li wrote:
> > > > On Mon, Feb 19, 2024 at 09:42:08PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Feb 19, 2024 at 10:11:45AM -0500, Frank Li wrote:
> > > > > > On Mon, Feb 05, 2024 at 12:33:21PM -0500, Frank Li wrote:
> > > > > > > first 6 patches use drvdata: flags to simplify some switch-case code.
> > > > > > > Improve maintaince and easy to read code.
> > > > > > > 
> > > > > > 
> > > > > > @Lorenzo Pieralisi:
> > > > > > 
> > > > > > 	Do you have chance to look other patches?
> > > > > > 	Mani's apply EP side change. 
> > > > > 
> > > > > Even though the controller is for the endpoint, it is still a controller
> > > > > driver. So all the patches should go through Lorenzo.
> > > > > 
> > > > > I only merge patches under drivers/pci/endpoint. Hope this clarifies.
> > > > 
> > > > Sorry. It confused everyone. My means was that Mani applied Niklas Cassel's
> > > > patches, which cause my 14th patch build failure.
> > > 
> > > Hello Frank,
> > > 
> > > Patch 14, which adds this:
> > > 
> > > +static const struct pci_epc_features imx95_pcie_epc_features = {
> > > +       .msi_capable = true,
> > > +       .bar_fixed_size[1] = SZ_64K,
> > > +       .align = SZ_4K,
> > > +};
> > > 
> > > 
> > > Should, after rebasing on Mani's pci/endpoint branch, instead look like this:
> > > 
> > > +static const struct pci_epc_features imx95_pcie_epc_features = {
> > > +       .msi_capable = true,
> > > +       .bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
> > > +       .align = SZ_4K,
> > > +};
> > > 
> > > 
> > > > 
> > > > I asked if I need update my 14th patch or applied 1-13 only. 
> > > 
> > > I see, you want the maintainers to apply 1-13, and simply drop patch 14
> > > instead of you sending out a rebased series.
> > > 
> > > I assume that the maintainers will be fine with your suggested approach.
> > 
> > If patch 14 has no dependencies on 1-13 yes; if it does we need to
> > coordinate the merge between branches in the PCI tree.
> 
> Keep it easy. I rebase to linux-pci/endpoint and v11 patch sent out.
> https://lore.kernel.org/imx/20240220161924.3871774-1-Frank.Li@nxp.com/T/#t

Bjorn just merge endpoint to next. v11 will work with linux-pci/next.

Frank

> 
> Frank
> 
> > 
> > Lorenzo

