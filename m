Return-Path: <linux-pci+bounces-2840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC13842DDE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F5B1F211EE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 20:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D479DD0;
	Tue, 30 Jan 2024 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m5Si2kil"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A879DBC;
	Tue, 30 Jan 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646642; cv=fail; b=hXnxKCsoxTcCM41Dj0k5bE8faA3TTVMCbNOH9Ie0tCXKNpkOdiyqFn9y5pLtSN0I1jWlhWAovdREBf6/QyZp7S7Zdl91zihpHaspFNezbDejr5IVuBRD/MOa+pDu6eAzwAr8GR+6rRu3WUDyes7RVvdEhoDAF+iUh428otgQJUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646642; c=relaxed/simple;
	bh=Uz65AO1E2ya58u4tHufjPJ/ZxOjDyGBD9UtOTxF7jRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euRfw1IrZuxglFL+uaep9hNwJG9zvwrp8dmyaYC5oEhYatANyYA51pBd3QF5kuI0Yi1fwvA9dLkVVG+rNsdw7cmQGRLfvpjYpvYVhGWaJIf/GHJxSYPJYdlyzDD/FDIJuUkKQqlTEku+hmHsT1oAS/aQFl/bWwboZGR6wIN+t5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m5Si2kil; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbqen98KyVsM3aWQv89uO5xgWqieGhT6FjeyKU6/DpYJ3GP8uSgrBH/Ne/z21la2JaPqxIrwD9hX1lqJ0//pfAu4jGearJRM4KhKi6xRODlVtsKu5r61O7bwHkqTi7CIgh1voam2Ash1b/vC6Lpy2fjHmPjWGmqF1LOaWJwpSU68+EK1wUbPoYXk3yz7Lz+7HExrehDdE24W2TQn4j1UuM/9wnqRFS/tj3OtJ9uAjT7ucAAS6giMu+iiResG5urSrXLUwwYzvfQJCpPZj0t5yXttxnhnY6zA83IshAoRPrBQR68YXQP3lWQHMBQBsFnu2+JRFy7OIN64iwQJ83vulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEEglG1DZF0kxyMfyBjQnyZz+O+yfijdSxbIckbAGqw=;
 b=SCuIMNEln+UfQPxB+DPMZcySyQ+wiEPh67WmeJfkvkNMLH3noRdIFaRmIsDl07S1W8hst7yaWoze3q2xTvLYWswaFE5A/8kKIGSC5ioEAuEZqT49r3UcwHacewPGYtybTsc1kINakb8JwMPQwzwETtsXr3c8M/lZN/gIw8RzBKjvrU0o7iPeO+96DnBgz7kwyHdKBDHv4+XB78biLEIc4ALqy4ja+2UeuAXRQkbh+n+3LcD2USB7iWPTJ3A9a1oC13xHvVo2DmlQ+I1xwjwwfyivzXv2MSBRePiQ3tv7TrhwkvynVWSiseR23tC3M22K7ji2oyuBFwvIdrbiowEZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEEglG1DZF0kxyMfyBjQnyZz+O+yfijdSxbIckbAGqw=;
 b=m5Si2kilq6KveU/eTo9li2vCieKf75rVUr1No+tqioIF9lk6sz9tMqPChs0J31KpxH3b1JsvB0DtQ+0Xh1s9MdDsfNkA6dZJPhEGM/SOXlo1r0rXgGkXFj4hEsejYkvpNxFgCoFT8lPZzvrKl4FZ/0TMZtIUQIz/7AzeHwFDREM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 20:30:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 20:30:37 +0000
Date: Tue, 30 Jan 2024 15:30:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
	kishon@kernel.org, kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v4 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer failure
 for fixed size BARs
Message-ID: <ZblcZnfUD7ZcEI8z@lizhi-Precision-Tower-5810>
References: <20240108151015.2030469-1-Frank.Li@nxp.com>
 <ZbJ/P5ldcrSs16q8@lizhi-Precision-Tower-5810>
 <ZblRXOabZWzRRWoT@x1-carbon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZblRXOabZWzRRWoT@x1-carbon>
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5b604d-726b-41ef-c1af-08dc21d2515e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	slG1w8dEmAivpWbSEnUrjll7Hlu7QMyWljw+v1AHf5JuxsWWj1VFK9AQ7RHwenid5H5zjT/LVZcm1p3BhiVGWShxKdU15OhoqrrdGuFIYTUbyphMRdoSwW08PCvA0Rah+2Gp0c3eR05WwvfUkhFUcqg4q0Cd93xs2ViRP+YTE8M1vU+fEYnjNbpwHFvglToCKn7ziLxyU0Mtnv0HWcpFAEVkQvaRLR/dq1Fq138W3oSsmbF8l7yJbnavJDvRoEubvp/mAfAIY0i+aHDLCXe3DCtkOLlz+Aq43p78Q75mjMhPVdyorAv3bP07qoblPHw3dCNOW1XXZd1/lNyYNTTOXbpo0E6iPzgnadLTD3YAHoMsYkTsmwNITh7B6JM/efWbu9FZRAgwVwHHs6GKw07ocVDB1oZ37d7iOizO0ZdS/xKkAVq+Uz43gK18euh/600Am9LFbAWIP3hXLwbkfDbCikR11QnjxOK7rQyxQSFfqLHbZ11FjUu86DSUmzfg+9oZuq8m07drBooYTiSFWuBNpZHZqw61oBcjHiCWJk+6nxl9uxghBRKhS22ELGRq43h861Loj72CxmzkrCb48rNMQS617x+hNkjIEj3a4jdUHFo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(33716001)(41300700001)(26005)(52116002)(38350700005)(316002)(6916009)(478600001)(9686003)(6512007)(6506007)(6486002)(6666004)(66946007)(38100700002)(66476007)(966005)(66556008)(2906002)(7416002)(86362001)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGa+lxQGuVU3cWVj4E/iflPFxO1jq4XWMsjszdBb/mPSCZ8CgT0RKIbEjueR?=
 =?us-ascii?Q?VXGLnvY5O0ONTrxBkfYdlb1IanDD/mOEwRg09EWXODCxoWO+1ZBV59nTfvt3?=
 =?us-ascii?Q?UAN6ULsvJhunRV1hnYjdeJRkOXye2Pl2lS1m2eahFfyYkXkKo7VOZTbklh9O?=
 =?us-ascii?Q?WEkJUVLaUqK4qc3UtXqTXmuUZJeaDyyZU7fIGQGt8RiFL4eb2oAL4kjqE7mk?=
 =?us-ascii?Q?d2g8vATlb1gBXKm7pn6ux2gI4gJAGqNLrvY6pqSh7DA2kSBUV4WujC1ILW9o?=
 =?us-ascii?Q?SPZMZq1bQZ6gPPq8t6Icg5yR0U0soiUMH1KOe3GqTdawgxMxzAzqsQ/5XhXP?=
 =?us-ascii?Q?bZNom/2UdbNHAp0TlZl7lcMYcxkhRGBKYKKDbV0taC958Sc8WqZbatD84CRN?=
 =?us-ascii?Q?m3n8URM3Mqm44vniWoeuHK5rLJM5FOyiVBx9LF+GgB/LzTdlPpDYRcOzBP9X?=
 =?us-ascii?Q?zTecJJaVY+4UcOFnlg+xNILAIJT6wr6xqOS0SPxkiIpcMRO92HXnYd3dxxIo?=
 =?us-ascii?Q?Evv0tNKgpBc7lQjEiGsIBrW+YVcJhc4IAtaQnP0Z7YKrPV7KKbm6I9b65xgr?=
 =?us-ascii?Q?QVACRMviOBQQAAJri8vFpnpCbofGGhygY499+MNMOBwSWWPMA+w5LJ56AI6q?=
 =?us-ascii?Q?OUtK4SmrWdewVdAOmxfFUAbKHk3c2CL5bvH4bVpeMFMX+0FZ7wNVOVvbSnfW?=
 =?us-ascii?Q?xQVUC36ERQAhuEuJfgS25pqnV/6i/wW+wmjFE6AaUTqvFc4w59lQJP9vFOsD?=
 =?us-ascii?Q?fnKmS77WgBAWaLZXMVekBA6QH2o68CyGmC2yB4JQJ2gkUHs5kbJ+EIYf4isI?=
 =?us-ascii?Q?q3BzEA6ceFocJYtXWNZ1ltMNIqVwozfArkRsGQWYxksgsuYeSjqeZMPLfsmX?=
 =?us-ascii?Q?0/e9pVl5DdS8hzJKIArKYaG264YO/P75WnI5GmZyGFuSjKE8WAN4iE0CHip3?=
 =?us-ascii?Q?ZzpoatFWuzYDh6TbTKaujsHiCGXd0V9MCtuKYYQ+/hV1UJAg13YtyAxhr8zj?=
 =?us-ascii?Q?6F/M2+I0V0g+i9IHmnW7sIAowt/uTBccXXxVhjPf6cR6uEksfr62SFOyICeD?=
 =?us-ascii?Q?iuFShXUz/2f9r6L9ucU6SGkTitWy8RhiLydb9561fy3XrYZAJU/PQkK0DqPq?=
 =?us-ascii?Q?/a5lMgqwu/2Ril5Gb5dBVdHzjSD02U01BNBwAQYabt07Rzy7qjnG2Gveobwa?=
 =?us-ascii?Q?c/u3smcmWxkWSx8cjNMAX598CGxmSsFIKy9cLd+lZtLFNPpOoD4nShz35mn+?=
 =?us-ascii?Q?nyjZQ5m9z95jC5s8Joje3C7cqd+SYZLklzjkrdMFYldwSNKTIZ2f4nwr+L/E?=
 =?us-ascii?Q?FZPaOq/COim/EOE803oHDFGnM3Or7rK31483iHqY/C6ZvtV47EtCiM1izHiu?=
 =?us-ascii?Q?H9oFZiwkwYERM5ZMjsilAsr1D3FY05NTdH95njyGeiO5jPLc+z1uInTAwko4?=
 =?us-ascii?Q?9xOIzGq6zHo3un03Z/qYTCNeVs6Q6bv1fqH6uEDDoFEajZJxNZkhL1NAPTV/?=
 =?us-ascii?Q?tjcOTkzKltNBJGNs1J3oyFxiZsxaMPb384ovwwH16zP5+SXKOKoZ5BR+WoT9?=
 =?us-ascii?Q?ZJuJKRR/GDX4KUSMxqzDJuPFw64WKepFu4Uh9JE0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5b604d-726b-41ef-c1af-08dc21d2515e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 20:30:37.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW2TJHbPzb9RZ9/32p+uPFHAO9nPo2xhe717GOXzj4Fao/g9OKkPLrhMsOYyzze4QxYPPsTChmYHYK5rn7VeBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

On Tue, Jan 30, 2024 at 08:43:24PM +0100, Niklas Cassel wrote:
> On Thu, Jan 25, 2024 at 10:33:19AM -0500, Frank Li wrote:
> > On Mon, Jan 08, 2024 at 10:10:15AM -0500, Frank Li wrote:
> > > For the inbound MEM/IO TLPs, iATU on the endpoint expects the target
> > > address to be aligned to the size of the BAR. For configurable BARs, there
> > > is no issue because both host and endpoint will know the exact size of the
> > > BAR region. But for fixed size BARs available in some controllers, if the
> > > BAR size advertised by the endpoint is not same as of the actual BAR size
> > > used in the controller, then the MEM/IO TLPs generated by the host will not
> > > be translated properly by the endpoint iATU.
> > > 
> > > So if the fixed size BARs are available in endpoint controllers, always use
> > > the actual BAR size.
> > > 
> > > This only fixes doorbell (DB) BAR. A similar fix is needed for memory map
> > > windows(MW) BARs.
> > > 
> > > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > 
> > @lpieralisi:
> > 
> > 	Could you please pick this fix patch?
> 
> 
> Hello Frank, Lorenzo, Mani,
> 
> 
> Frank, sorry for not seeing this patch earlier.
> 
> Could you please see if this series fixes your issue:
> https://lore.kernel.org/linux-pci/20240130193214.713739-1-cassel@kernel.org/T/#t
> 
> I think it is nicer since:
> 1) It doesn't add copy pasted code from pci-epf-test.c to pci-epf-vntb.c.
> 2) I would expect it to handle both the doorbell BAR and the MW BARs.

Agree! Thanks

Frank
> 
> 
> Kind regards,
> Niklas

