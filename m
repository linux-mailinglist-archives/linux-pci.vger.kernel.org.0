Return-Path: <linux-pci+bounces-16294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE69C11F3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC2D1C222FA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5CA1DF989;
	Thu,  7 Nov 2024 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V55LVbPy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA261DC04A;
	Thu,  7 Nov 2024 22:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019560; cv=fail; b=mmZhSmGnLClr8joepm/keAWrIUBfyq0nEC5/VdCf9U29xHDc+l+JckFKfFjHuvKYHzKFbYj6gHC/yn8sOHRt6dmNhzR/C+YThqafQGQo5Ncr3AbBLYhcXU1RCy4S1zEOydDvZkH4Xtt1Br73caV7ZFjYMLXqJXD1ycPiNIcNEw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019560; c=relaxed/simple;
	bh=8bNKxf9sAvlISAM6XadtXTsiGgyDQ/oFimhIhlUlCOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wj/NcUULAT5gPhKFFwj4ct+l7U8E3rtAzqrisZ+vst/QTFPCxcuFzR6bV+Doa8xNRWxeIKRUvSLqAZbKPoGUh+BYHZp85T3DpqnasrwMSyeF3xMN1gsbNO/hbuhspAC9MdBYDM4+8aOZB2C8wKQYrR113Y2o1x2qzYQ9Lwktsp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V55LVbPy; arc=fail smtp.client-ip=40.107.247.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adwwO5PmGtpc7PtSxjg5fQCW8Swf9kuEiLvqHkwXNCKe8I3mC6SSH2btKHdhBYC0foKAMpO8rvo3nGuBpni3aVsXdZ5CwBVyNnKtHRc5JBrvN22n779hdfRSLniGHXH/dOg8uQpySTxmyfN1llTjxEyvZTo/Jp2euJn8+jEnbX/SmjWTjI93tV/xe6HhYn+T+raOHnqkXK3HNSjQoXzDYOq1upYfJd3o+i9r9J90xr9Zxdkv9W4R0sFhUYbuwFdGEoE8xUOmHZXhmNM+x7oW8KO08iQqXnj1gd7xBChF7XQTzDZBz37qtaNueJyTDpr/wOvUuuwPb5qpiEXYsFO1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUBJpZhZghW9zBa2Oq9cwE0T/XzimC5x/cA0NilXfVc=;
 b=okbYy57dx8gQNX9kALB35fNghH+Cd0rMtrAnL39X4QxrxVC/KUhTMJD18G+4+ZQnHjwPeZXR0MCkysfDaBHP7H9qY7GVAwxhn02TA8itsAJzFwFR9xkYZyFmE1eBoGY3sqWEweLuapTDT4Q0bhb1T3opaE3BgekKWcBxzXSZNCxjDoWg58MuRCBh3D/wsoVRXum/pjBBsWDDrQHydVgjAy7T9fq1VstjFQR2HfSK46A4lwehAl7Adb57KSjIOiyCO8cBI2ozu7vEupTi8XEv8ykBSrqkQzr2VprQnKGOpMorEfY7/JO3xjG/BbDp05gTAfr+kapNx+umZZMahEjhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUBJpZhZghW9zBa2Oq9cwE0T/XzimC5x/cA0NilXfVc=;
 b=V55LVbPyo4shtnL8H+Fe5goFDXIRWypHSp1czpS1er4bpPC68DLehSUuLBX/oEgugDlZIi5wCi6ZbpmxCcE8fRyAjg4BkaxXHnYwhmDgJc2m8TCLghEcN5DcHwSCIA9TLHF/yzpmMENnGzk1e/HS2o5boazB0EJObsFLBaL55bUUgAZhIQs6bcY/5dORqHEH6WThPoTiQA1OEq6dTRolUL55dexzlNR6weyOFPFv4zW59HnhUGvBZ6u77+R1lIOWWukYB6Q04PkP08zachXMFjWE2IBv6UnY2Wc+0ZY+HOgXhppCvr/06tqBLujmfFDZsBqOC87xW4L6+vMy4dUfZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 22:45:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 22:45:55 +0000
Date: Thu, 7 Nov 2024 17:45:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 4/5] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <Zy1DGsUtxO4gIcH2@lizhi-Precision-Tower-5810>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <20241031-ep-msi-v4-4-717da2d99b28@nxp.com>
 <Zy00REIOJlijfmPW@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy00REIOJlijfmPW@ryzen>
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e69d805-0209-4efe-0b26-08dcff7df05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/2vZ6UXkGhAVAeiUEG2bDyIb0tEDZxCI4KQyJUQp0ywZN9vFaes2Bcx85H35?=
 =?us-ascii?Q?ZmBnrIqZAqQlTKoM6h3Bk9IkrfMJD9Jgrw788e6TQpKHt2KaUVxdjtNK8Ph2?=
 =?us-ascii?Q?5MpmSa6MO4btUukt/sakZMGd/RDV0mJxa5DAAB8WHvqP4U9AMFVeqUyQ7ubR?=
 =?us-ascii?Q?NbkBHBpiWk3dBgKJNvBziBlWUlj2tApCLrBKAn+0Hyfjqzy7boJwfVRGHHGP?=
 =?us-ascii?Q?/D3sCr0uR5ErM0Jt3hosHFymJkHhdRbOA+XE2hm9+oCwJaHVluLgf0ZWTshF?=
 =?us-ascii?Q?eMvVl+57TjYCaounwJVIlS4jS/Dr5ZrG0YfNLwhJ9HVrv3kTqmaHx1Va6XFM?=
 =?us-ascii?Q?ip3v5iIIGxHYjzImRQoOwHC/d35pSWyDpdItp0TvLCV1khDmv2T3xg/JLSWi?=
 =?us-ascii?Q?e2/gXhEhGOUALTvLITNGmD639ZCCS9t5QH4ZNqIARMcLWqLfkP8Lhx71pgbF?=
 =?us-ascii?Q?e8lWzOYHmepYUOS/JHVp1vIOpN5YKOLMBcmSBSyK6qLykAyzF2UACXxKkVM1?=
 =?us-ascii?Q?pEaMhL6PyL8dxEJc0lKRjkjNu+IB+57+OqtYSAJJsMXoCbjzLhyVOZ0cAsCS?=
 =?us-ascii?Q?I2IEy2i60uwxCX5PtxNbuutANTGkpQH73rjcn5OVuEWvilz1wcs8ViyCe7f/?=
 =?us-ascii?Q?L21c6JidvIDSBiIuGm+SZcUTfvEGcsRqCVdw7QggQ2oUERTH7xsKcgArbDCR?=
 =?us-ascii?Q?80PBEeIA6u8r8U12qD3qA1+Ro49IKwjLH1ObrQqKI/0FWf051ffdG6m/zhYV?=
 =?us-ascii?Q?IGuHndnfFRyrt3hjFKQ8CdSf+y5ZBQfrEqy//0kTZOLG9IyKnIgXiQQdOwE/?=
 =?us-ascii?Q?MPh8GjBDzh1e6gvdCulYoOzHVU6wXcRHRHzNJRq1U+CspCqh6ZB1MxRPgPNr?=
 =?us-ascii?Q?RifwZ0FTZwAEa9J3FFa+kI11410rxZCvq7UHuP4HcRqQLQieP5b7uSqQwkuc?=
 =?us-ascii?Q?IMm51W78oi7snOcn9i21/lSI/2YrjZD8SkP/e1LIhiip6GCQo04BnumqlOuu?=
 =?us-ascii?Q?L+zT90YFknblnq3yRBKJOYrN7IkvFWG6uP8F+J9UwiJ2QfJBaiAatw7sJIPk?=
 =?us-ascii?Q?+6NHNMoE5kTalmwGfPPLDI+iw6p35WnSpKYMs+k+Awz4mVfCy8wXSh0fOfkW?=
 =?us-ascii?Q?mholMAuuEa4Lcr9y4BYXqKdjhoL4n+zki/TQPLDaxfkZXqKXP43+T6gPSrLY?=
 =?us-ascii?Q?6K3D0qdYJUWXiM0B2XN8kFWZUtH8KLP3Ej1hm1yhI9ouAsGT/HZVsMo2ht6c?=
 =?us-ascii?Q?M3havBBV1pEcFbiwo++xsW0Ps+rnKgQHLL6vQJ9zd2UJkurDiRzYZ7jZxwIG?=
 =?us-ascii?Q?LbKsS0Kqyg+MrkTBjeiuGTB1gfJxcj73aHiozWnjgn8unCfaFVxHO7tOnA1C?=
 =?us-ascii?Q?ygpXzdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7mBsvA8xTEyy3D7moX2LJB3LHU4QevtgUBDRuS8t1pksmdD8ZgIBJ8ELkNl?=
 =?us-ascii?Q?QYuY9hA624E3U7wGsbrPQWccQu8jTqFGnGVpp65+m41ia6xLfkw2nDiCCj61?=
 =?us-ascii?Q?ywCAtlJ+jGnFJSr9PH/+8rh+MYO2XV9IX+Ep1i5/bX+VHK69ijqt7CfmHf0Y?=
 =?us-ascii?Q?GIiCptDH1XF2vMB1pludZ6AuqVzNdjb9xqskFxVPa+5z87yMX0HCrp7EMFHw?=
 =?us-ascii?Q?cn40hrTN/vCmYzUNhEqv6TvAJ7ZfS3SvtfI4r+SNwcYdy8+Lm2RHTI9JOVcp?=
 =?us-ascii?Q?VnYiJu7pYI8DOwGRM5Fbdi6ug8Q9EqMbR/4fLDGrnVEKFJ0BHvNR0nAgmLku?=
 =?us-ascii?Q?RChG1Q7eBmOWQPXImr7jdJ+0StJu7nRa2mDxnm/8ZP+JDtDgbJIAPGrycjtb?=
 =?us-ascii?Q?xT3qHPA3OlISEgA1rk3EBzCOk5wRo2SneHt+mXkD8PUsxkLWtdzwtWXo/sPO?=
 =?us-ascii?Q?45jgUqE7uI9KwxOXGs9Wf2/IA4VCTlGmAz8m1q1gRWkutsaz4K07WGpdNDXw?=
 =?us-ascii?Q?BG0X/akNATRiNDlJk2p18kyI0EwO05SyApRVhwHkdslVZZ66O1v56K+XaDUB?=
 =?us-ascii?Q?+f3C1JCkAPcUW0jEanFlP/sJXxYoAseM6SsyEJIUz/FTHI7WHgwc6Qc6tHhb?=
 =?us-ascii?Q?N8pnSn2Dx1ktQg5RC6pCYIFAzFo1jwswC9OlmSOnFGYEqDuXdKvBYOngN9tC?=
 =?us-ascii?Q?tGBMcIIeEuepU1swxPzfkZL2Zi7BreXUy6V7LMcOL+dh3yzHaDd/JTZ64NrU?=
 =?us-ascii?Q?TsiZZBd75d5H8qBv4EXh5c2Ex56oL6vXopK0oPJkhLNWyffpoqSTrEqi0q4z?=
 =?us-ascii?Q?vpGPEF2oMDvl7jwXABHCxx0Epj5g/QA3LvxbzCMXPmbRITb0drYOK1dn1xwA?=
 =?us-ascii?Q?SkQ4+w4KNiJvOARNMBTDbeQABJsjdFqCfZqAlvExHeFEbGxpQnxXw2I5crqH?=
 =?us-ascii?Q?17ljxT6w9Iz1D93uwRpiVjpBCzulsjJNL8agTQW/Khyu9YpohfC9BwhCNgVm?=
 =?us-ascii?Q?Xe0Gc2/dUUSEsf6HAwFJwWnjFqYOfCHUj4IyoVZCUqBIWXLaLuhLwlFLyPIk?=
 =?us-ascii?Q?rwFsWGWAcoJqiGkoEaLqTZmgn3n7N127HUy025m3RQU34aBAca3XSqX4N9WI?=
 =?us-ascii?Q?VuHywGUd5lRUvt8ESNJppXDFPUvnTqIy8sBghP4geggbyt3MKSPj8QzDFuBx?=
 =?us-ascii?Q?Kp61W6O/7stO2y7atbO/UK1E4aBdvy8JSsj5LfWqDQWZDBZ7oqJu0cjYmfX1?=
 =?us-ascii?Q?OkVANM+VHFLmONkDSnsZRcVb8q3AtOXTv8juFeP1IIX88GpcTGd/Nv+hiCfu?=
 =?us-ascii?Q?TIAuZjKNO659tJ4AgqJLofNt9DhRYUdqS9kE4lLCRQbHCvnYBYwqVlFp74T0?=
 =?us-ascii?Q?TV6s2z1NjbSoLWC/+GeT33MI7qM0y4J0pYMWAenek8OYbqBEApzl2uKos1QJ?=
 =?us-ascii?Q?ZAru30h3YaQTlygV6AD72CDNgnmmgXfEx/nTfnSMfad8msd0SPADl2rUMqYf?=
 =?us-ascii?Q?ZBGGF+lfGfbJUTG6eULTIfs65pZFqZsrWxfXkYHWm0l6taq18NfK1F7wPO2P?=
 =?us-ascii?Q?b3BZmVx0l8HlWc1TNrNfrgctv8jZKsEZUjMMYrNr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e69d805-0209-4efe-0b26-08dcff7df05e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:45:54.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z70yiI+6hUGBXLBSwf4nlcLTeSOO+w/XM8DaInuqeTq+TaGu2K7CNAXayRCe5BoIc5fqUF6zq4HmsqH0s2h08A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240

On Thu, Nov 07, 2024 at 10:42:28PM +0100, Niklas Cassel wrote:
> On Thu, Oct 31, 2024 at 12:27:03PM -0400, Frank Li wrote:
> > Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> > and PCIE_ENDPOINT_TEST_DB_DATA.
> >
> > Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
> > address provided by PCI_ENDPOINT_TEST_DB_ADDR and wait for endpoint
> > feedback.
> >
> > Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
> > to enable EP side's doorbell support and avoid compatible problem.
> >
> > 		Host side new driver	Host side old driver
> > EP: new driver		S			F
> > EP: old driver		F			F
> >
> > S: If EP side support MSI, 'pcitest -B' return success.
> >    If EP side doesn't support MSI, the same to 'F'.
> >
> > F: 'pcitest -B' return failure, other case as usual.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v3 to v4
> > - Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
> > - Remove new DID requirement.
> > ---
> >  drivers/misc/pci_endpoint_test.c | 63 ++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/pcitest.h     |  1 +
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 3aaaf47fa4ee2..d8193626c8965 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -42,6 +42,8 @@
> >  #define COMMAND_READ				BIT(3)
> >  #define COMMAND_WRITE				BIT(4)
> >  #define COMMAND_COPY				BIT(5)
> > +#define COMMAND_ENABLE_DOORBELL			BIT(6)
> > +#define COMMAND_DISABLE_DOORBELL		BIT(7)
> >
> >  #define PCI_ENDPOINT_TEST_STATUS		0x8
> >  #define STATUS_READ_SUCCESS			BIT(0)
> > @@ -53,6 +55,11 @@
> >  #define STATUS_IRQ_RAISED			BIT(6)
> >  #define STATUS_SRC_ADDR_INVALID			BIT(7)
> >  #define STATUS_DST_ADDR_INVALID			BIT(8)
> > +#define STATUS_DOORBELL_SUCCESS			BIT(9)
> > +#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
> > +#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
> > +#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
> > +#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
> >
> >  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
> >  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> > @@ -67,7 +74,12 @@
> >  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
> >
> >  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> > +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> > +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> > +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> > +
> >  #define FLAG_USE_DMA				BIT(0)
> > +#define FLAG_SUPPORT_DOORBELL			BIT(1)
>
> Unused.
>
>
> >
> >  #define PCI_DEVICE_ID_TI_AM654			0xb00c
> >  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> > @@ -75,6 +87,7 @@
> >  #define PCI_DEVICE_ID_TI_J721S2		0xb013
> >  #define PCI_DEVICE_ID_LS1088A			0x80c0
> >  #define PCI_DEVICE_ID_IMX8			0x0808
> > +#define PCI_DEVICE_ID_IMX8_DB			0x080c
>
> Unused.
>
>
> >
> >  #define is_am654_pci_dev(pdev)		\
> >  		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
> > @@ -108,6 +121,7 @@ enum pci_barno {
> >  	BAR_3,
> >  	BAR_4,
> >  	BAR_5,
> > +	NO_BAR = -1,
> >  };
> >
> >  struct pci_endpoint_test {
> > @@ -746,6 +760,52 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> >  	return false;
> >  }
> >
> > +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> > +{
> > +	enum pci_barno bar;
> > +	u32 data, status;
> > +	u32 addr;
>
>
> You need to do:
> pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
>
> Before sending the COMMAND_ENABLE_DOORBELL command.
>
> Otherwise, when EP sends an IRQ in response to COMMAND_ENABLE_DOORBELL
> being done, it will send it using type reg->irq_type, which will be 0,
> since you haven't initialized it. Thus the EP will trigger a INTx IRQ.
>
>
> You probably also want to have a variable:
> int irq_type = test->irq_type;
>
> So that you initialize irq_type to test->irq_type, instead of using the
> global variable irq_type.
>
> (This matches how it is done in pci_endpoint_test_write(),
> pci_endpoint_test_read(), and pci_endpoint_test_write().)

Thanks, did you trigger EP's MSI at your platform?

Frank
>
>
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> > +				 COMMAND_ENABLE_DOORBELL);
> > +
> > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > +
> > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > +	if (status & STATUS_DOORBELL_ENABLE_FAIL)
> > +		return false;
> > +
> > +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> > +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> > +
> > +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> > +
> > +	writel(data, test->bar[bar] + addr);
> > +
> > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > +
> > +	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > +
> > +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> > +				 COMMAND_DISABLE_DOORBELL);
> > +
> > +	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
> > +
> > +	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> > +
> > +	if ((status & STATUS_DOORBELL_SUCCESS) &&
> > +	    (status & STATUS_DOORBELL_DISABLE_SUCCESS))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> >  				    unsigned long arg)
> >  {
> > @@ -793,6 +853,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
> >  	case PCITEST_CLEAR_IRQ:
> >  		ret = pci_endpoint_test_clear_irq(test);
> >  		break;
> > +	case PCITEST_DOORBELL:
> > +		ret = pci_endpoint_test_doorbell(test);
> > +		break;
> >  	}
> >
> >  ret:
> > diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> > index 94b46b043b536..06d9f548b510e 100644
> > --- a/include/uapi/linux/pcitest.h
> > +++ b/include/uapi/linux/pcitest.h
> > @@ -21,6 +21,7 @@
> >  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
> >  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
> >  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> > +#define PCITEST_DOORBELL	_IO('P', 0x11)
> >
> >  #define PCITEST_FLAGS_USE_DMA	0x00000001
> >
> >
> > --
> > 2.34.1
> >

