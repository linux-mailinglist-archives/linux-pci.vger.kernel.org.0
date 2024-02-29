Return-Path: <linux-pci+bounces-4222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB4C86C00A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9DA7B24704
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 04:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA50F39840;
	Thu, 29 Feb 2024 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="SsBVlLBp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6738DED;
	Thu, 29 Feb 2024 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182666; cv=fail; b=dlQRkwbJqwwi2VgAvHz9HUypsAvUDirqewg18XaO9guzfB1pJpXzTKiCCR1jgpIS1hD1GmSzojt10/DK8XJQCZ6n3457eTJL0FgXwJD6Llkb1NREZbyAH/AM54V5vY9QwV5tGmoFW735LJUN6TpWcmNAvZl2Ba0BY3K/lY1f0mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182666; c=relaxed/simple;
	bh=lDgTrsdHaTWMSwm/E0fQ8We9nVhQY5nz++pb8D483F4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HhXgIlZXKK2y+mqjOHVjMevj/J6AFiMlKxJ3CtNvVYQ02Fr5dGYfKUaks4cey0Lo5cu130qCWeHT9RZIRDqInSYqXFpaYF0fuKCet4yDIoxESrNsFFiJ0TT9t50yY526CvKwRdYtfQyxHVWewuqegyY3qbKoTIqZ+NDDbZW2CQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=SsBVlLBp; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T42Y0H007323;
	Wed, 28 Feb 2024 20:57:30 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wj8e8tqhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 20:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxonM4SV6bn6PcQvpGFwj/qu7Ciq0yyhNSPsfpwsCCiinbQUmrBJMRt51ne7beO4eXo3a0v/W/3A/y812B980zHqiHWRgufYsRKrbksooshHDbQeFOCJHUn/vEVM4yrIdGJbJitDjFQytFiXHwcro/wRNo+0/WElzIlmuI3OJdfFUNHXd68zHGG7cWqKBWVw+HVHS3xOV5dwenwX5nEViOWfKwny6p3Q9nPMxa+4lwmIpZUe0UbWtCOb7MII9ePagGglwSNvcsIBfXjADdaoneMJRUqt+6m0pXLnTS6aMDNe2kil50FUjUVDSPLykWg9MMMmAdZbP0ci84ErrA9E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9Ut48Nk9cIfP0vsaV3gMDf8Y9NEFRUrndwrauQidxg=;
 b=SuH5WHL2GlUxHmJ+iNVM/hf5/F2QzMtWFTFWRQ37m3pc/hqFnKg6NsfYBdyL4exuYYXoxSJfJmyBYXcvev5VoOAAx6qEF7wzkRER+IOPLcngRthqOegij2UdFOa+8txDb4zuFA+XVUNh19kapywc7qfUMV4ZqcY32YEfyDhpFJrqrMiVhhxROyLSBdJdJOyIRuwmVdxrYGPoe1l2VatC7gLt1ZaCaTo96warJykWX5uHdF95jcje3+EgffVUHo4QN41WsZWZYeb5RfVYtSZuBe4zx3wql2kT5o9XwjyUpoA+UK+/O6/lPunlOgfd1F/uE/at0XWfEL5xUT3qZRpVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9Ut48Nk9cIfP0vsaV3gMDf8Y9NEFRUrndwrauQidxg=;
 b=SsBVlLBpLTKsPSU2OHs8ZkgbC9gmHCvFWnBSunixHkHBMqibdC2l1ldf34p17oFessAN0xVe1wJmJOva1OeSG+sKIqe9MByTQQZZYK7a8rAbyUfaOUKOIFkEEy5A0UzONwBE3Zh5YqeBaZShvFWqF9hPJeN7nBSQ2HqcXRgFzHM=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by LV3PR18MB5801.namprd18.prod.outlook.com (2603:10b6:408:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 04:57:27 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 04:57:26 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Thread-Topic: [net-next PATCH v2] octeontx2: Add PTP clock driver for Octeon
 PTM clock.
Thread-Index: AQHaasvK86DrYSiqL06CYCDK0W5VDA==
Date: Thu, 29 Feb 2024 04:57:26 +0000
Message-ID: 
 <BY3PR18MB4707E7764D59DF25C57CCB58A05F2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: 
 <BY3PR18MB4707DBB80B5949EA26F7ABECA0582@BY3PR18MB4707.namprd18.prod.outlook.com>
 <20240228160857.GA272997@bhelgaas>
In-Reply-To: <20240228160857.GA272997@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|LV3PR18MB5801:EE_
x-ms-office365-filtering-correlation-id: fd67817f-c281-4d63-5565-08dc38e2ecbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9+9vLN8+wQGJBBfhPRW0CLGco93foKCRaKSTL0FJ3kmwgJwZNUqDdgAep6ExmL4aDYt+6yoE2up0z6zVo1J9a02KOQgDv4WDfokxFqrs0eueP/6tj1PEB5fCX7zvD8194WMi3I377GGCnvtqLCqOG8cQzjh3px8dCdRC6f1QiBHqEfJ5qh1AwAUOtVmvTcRY7nDZPu3x50Z7Q+nnKlgtx3xoNNFfi1JE16t6saDxDh118RT3i/J94h9zM7MHYm2M8ZysQMNuwS/QpIRiQtlxdUMh8VV1JZdANv9iKhUmMVNWThecnM89d5y9dsbQmUgm7nke28ZL2qZ6SXOnSsQCVqxZpvEA1nSNFIQWRwedWjnzbPR0dgxPy7yVU0QRSuEWZPr2K/veNGrxE/8C5yDiPXke5us/R/maLYlBs0CVPIZ2mHRXyITZ9rNlIROBnDQKm4azDlnTo0yOC6NLuR+PkN82kLTrQzDLNlVHp4HhSiVwyDMWrfLHwa7mGZT+hS9adrS94cya6CzTC31RrdOGoXs3cklAWoJ9S0jYyxurEZKcmnKGImoJE4NacImXeZR/1OiR2iSzIN8NVopxSYpKa8kmh5cHdcgh0nYgeDvCNDx/ZnHXJOY1bOq8b7ZmwuXYw75RIohTWb3c2v7KYv0ID3eoZHIQ2b7pr01oHk5a9DKXaXxa195R5fwyhadquYWHibAmOgp4T0HtVbaGLRrFItcT8p8m2rtfjV4J237VzF4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?4sQkFrovQ1/VfYyhj+wrADGUQz10C26lwn1/oH05pTocD5B/ji54nH6dytaN?=
 =?us-ascii?Q?1lrA0/VM8FAYc/0XsA+8COVsnMh7DaAwSl3wcU3SfeBowgbNyrbJkCreB+Qq?=
 =?us-ascii?Q?hDBcZayuWtslL+xYxfg5W51Y8Wb66I2rkI4qEv0Gcgq1ZqMc1TvskDIEVnRQ?=
 =?us-ascii?Q?VnAHQ/bVn720CfCQ2OwPtEgZ2busfQwZbXLJHLcGyxZrLLqrUp7/IGG3xhKl?=
 =?us-ascii?Q?esaCFb3oGOsBP0zdZ7sakS2QOpoHPp152ZVTbmtLlMLVTZfIBvnFRRukjCAt?=
 =?us-ascii?Q?x1jQmehdkTjs3iw1H8HFxS5vqbaiXVEXtOI4JOnnEj2RQH6OkIKq+JwSVvCH?=
 =?us-ascii?Q?FEUBQN+pPeHkEu//scsy5cHo9fh6nC6xUzLEdo0GNdAzpf2SSQIn0R6rhAfx?=
 =?us-ascii?Q?hq8k5pejPnoooa70s0gdPNKUzqOMJfCZVrkkjBA8fqKLhpEIvGatRNb7rWxe?=
 =?us-ascii?Q?DEbH/Q9JeiKllMObRtNeibCMt9CvYQ/Cex26buKmWsxq0iyaVtJdwGNJl00T?=
 =?us-ascii?Q?4UC3dGwOwFSatW84h1DsPlAHHqXBz8XPUQGpSTnUg3Ea8Ffzd3w/k9FvZNW9?=
 =?us-ascii?Q?synmr09TyenyYsgIeJVySDm3MCz32dCjGpCDhwACrRbbLvjfL/d4SEeyqPx2?=
 =?us-ascii?Q?gTkouZdpChD93Vzfo40GFj4YyeU2Q4UOh/vevFS0bktXn/MHgUEbjktC1Yfq?=
 =?us-ascii?Q?JJFZGwHNIlJEL9HhV6orUR7MTvNz9EH9Iu6xYvrzsUEKNwpAkAUG47MG55gI?=
 =?us-ascii?Q?IpBVPOkUMca8Xj+lEPIfE+vqnEaFNs5/yGIBlRKXt7js4zu0p/9Y8K7qSuVr?=
 =?us-ascii?Q?6Oca+ET/KYJ1pouKnnSi2II9i5DFN/Y4UrJCGWoMRcjTGvNlqlfihK5Sktkv?=
 =?us-ascii?Q?TDr5DXeiVR4ze6Ci4z8U9COxhvwxrQP/Ze7U38T8GevdJUPq4gWjnCLrZG0m?=
 =?us-ascii?Q?GqeoWOfkLXl/y7fLPaGtz4eg6tyPTvQ5qASu9Xv6BiJvLw5jYs7OQzf0w5DT?=
 =?us-ascii?Q?qRU8Gher+Iy2e+nPmCGPKbDGkUXdIiFOT2akpkzM1UfeNMtWAMNwbclXM6WO?=
 =?us-ascii?Q?PsLqYqZPuJMAPQEIHi5WMiiUb7ADn9y77yX8KU4dCqFdL/6V26hujUic9/We?=
 =?us-ascii?Q?JG3KVLHqy7pDQtYdrn2Rs3ddicMCjcxKgJ5vFgQpik8rOmRbaLxOkpPGuHaa?=
 =?us-ascii?Q?7dyDnKXb/4WN3OPY4oxENNMh0qaHHqkvgFT9h8lJujMyuTvNORaHv/28ev7S?=
 =?us-ascii?Q?YCDCQnwPEJYUclw4yMhrzBHmEA3WFIXCCQBH3Jy/gyeGs+ngyu52/WOr4OPE?=
 =?us-ascii?Q?noy2B3Zxj0cjuXTKwqNPb+p4QDgME6DCejYdkobZ6AYAaPiB1fBXcjsC3iJS?=
 =?us-ascii?Q?nR2ue9OmFZmGFh731BywZIw/mFEpCilM58eErW0ASCWTS4+DQO7qN4fgKAPw?=
 =?us-ascii?Q?mPw87863x7gZ2767KMGzakG2NwmEIFZnYYqQpsNfAwLaseI65+lBqg5F0BC5?=
 =?us-ascii?Q?5GFSb77oAJizs6Y/ZKcoD2xZMTQTflLtyOQQTyCsifyNWAUEwRUIFqkmrmzK?=
 =?us-ascii?Q?Y3szxDJBxqIMd8BuUpHdkG1Z0M6NL6Ro1/IA/AZV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd67817f-c281-4d63-5565-08dc38e2ecbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 04:57:26.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Fah/SBUHE9z+M1nCrs4CeXVpojMEZlMvVYn7p6b+rxbtZBU4f0Mo5DqRnBx57o3EflXFiRa3hR/rJRYw8PAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5801
X-Proofpoint-GUID: uD_YDwKbmSZDHXlTIVA-psUEioezzHBN
X-Proofpoint-ORIG-GUID: uD_YDwKbmSZDHXlTIVA-psUEioezzHBN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 28, 2024 9:39 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org;
> richardcochran@gmail.com; horms@kernel.org; vinicius.gomes@intel.com;
> vadim.fedorenko@linux.dev; davem@davemloft.net; kuba@kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Linu Cherian <lcherian@marvell.com>; Hariprasad
> Kelam <hkelam@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Naveen Mamindlapalli <naveenm@marvell.com>
> Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for
> Octeon PTM clock.
>=20
> On Wed, Feb 28, 2024 at 12:37:02PM +0000, Sai Krishna Gajula wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Monday, February 26, 2024 10:31 PM
> > ...
> > > On Mon, Feb 26, 2024 at 03:40:25PM +0000, Sai Krishna Gajula wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: Wednesday, February 14, 2024 10:59 PM ...
> > > > > On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> > > > > > The PCIe PTM(Precision time measurement) protocol provides
> > > > > > precise coordination of events across multiple components like
> > > > > > PCIe host clock, PCIe EP PHC local clocks of PCIe devices.
> > > > > > This patch adds support for ptp clock based PTM clock. We can
> > > > > > use this PTP device to sync the PTM time with CLOCK_REALTIME
> > > > > > or other PTP PHC devices using phc2sys.
>=20
> > > > > > +static int __init ptp_oct_ptm_init(void) {
> > > > > > +	struct pci_dev *pdev =3D NULL;
> > > > > > +
> > > > > > +	pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > > > > > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> > > > >
> > > > > pci_get_device() is a sub-optimal method for a driver to claim a
> device.
> > > > > pci_register_driver() is the preferred method.  If you can't use
> > > > > that, a comment here explaining why not would be helpful.
> > > >
> > > > We just want to check the PTP device availability in the system as
> > > > one of the use case is to sync PTM time to PTP.
> > >
> > > This doesn't explain why you can't use pci_register_driver().  Can
> > > you clarify that?
> >
> > This is not a PCI endpoint driver.  This piece of code is used to
> > identify the silicon version.  We will update the code by reading the
> > silicon version from Endpoint internal BAR register offsets.
>=20
> > > I assume the PCI_DEVID_OCTEONTX2_PTP device is a PCIe Endpoint, and
> > > this driver runs on the host?  I.e., this driver does not run as
> > > firmware on the Endpoint itself?  So if you run lspci on the host,
> > > you would see this device as one of the PCI devices?
> > >
> > > If that's the case, a driver would normally operate the device via
> > > MMIO accesses to regions described by PCI BARs.  "lspci -v" would
> > > show those addresses.
> >
> > This driver don't run on Host but runs on the EP firmware itself.
>=20
> The "endpoint driver" terminology is a bit confusing here.  See
> Documentation/PCI/endpoint/pci-endpoint.rst for details.
>=20
> If this driver actually runs as part of the Endpoint firmware, it would n=
ot
> normally see a hierarchy of pci_devs, and I don't think
> pci_get_device() would work.
>=20
> So I suspect this driver actually runs on the host, and it looks like it =
wants to
> use the same device (0x177d:0xa00c) as these two drivers:
>=20
>   drivers/net/ethernet/cavium/common/cavium_ptp.c:#define
> PCI_DEVICE_ID_CAVIUM_PTP        0xA00C
>   drivers/net/ethernet/marvell/octeontx2/af/ptp.c:#define
> PCI_DEVID_OCTEONTX2_PTP                 0xA00C
>=20
> It seems like maybe it should be integrated into them?  Otherwise you hav=
e
> multiple drivers thinking they are controlling a single device.

Though this device does not appear as a PCI device on EP firmware, but ther=
e are some other internal PCI devices that will be enumerated.=20
We will remove the dependency of reading the PTP device to check the SoC ve=
rsions, instead we will read the config space of this PCI device itself.
I hope this clears your doubt whether this driver is running on Host or EP =
device.

>=20
> Bjorn

