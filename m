Return-Path: <linux-pci+bounces-4178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36486AF48
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 13:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FA71C25001
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BBC14534F;
	Wed, 28 Feb 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="T7V73J8S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E06145351;
	Wed, 28 Feb 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123861; cv=fail; b=IbY3hyhonnezfD44zxO4JEUioKEcRw85cP4IfaL69o59SkrbsGcPHV69ozFMNZhfyZebp8/eI2rPM7+iqxYwRHOUeb5XM8kKxTKl7DYGW8ZoCqnraLaoobIN1VOV5F9zddYmq1CavTzzjSUjfqo+JbO6XYdD6Oper7fVGlEPkD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123861; c=relaxed/simple;
	bh=lPCw3HCTGpF1gTvUGLzrhlUWEBBFw6aAyq0O+eW9Ek4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7gB7NJkiTV2TApunT740c8Mv1m20U0IY2ofoZE2xtb80R5yygQ/0Ad1BfkL6EzMpygWPxcvUsSF+DCAwDvhJwAjygi7Wd7CXXJU//gus25cyqLbSQJFX+6L57CXtcYmArpI4YSXqM1tVd2KULelK6XayrTj86ygKSg+itmg5D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=T7V73J8S; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SB1FnR013297;
	Wed, 28 Feb 2024 04:37:06 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wj04sgwpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 04:37:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obRtrgkrvzlN77qFsHHiWQNwX6qB2dEyUbj0CuIfrZ0o9q8aMYzPQ1Dqcp6CSp+YAWyuxj+lXfgcOLQKLzQ7KJ5THAmHFFBvFKyn/DtaATtlAR+ugzPNITZWP6/uVvpHjlVLNFno3di/R1wH03ZaZ/v1jAB76JZQWtKT9usNhm/8W44Gmnc12/gxZ8Kh26iXMfhTPUKQiSxVAQ8YiMhdCXwnKjodNgnY//6TbC/Q6UWT3hROsP5A+1xGa4KH17cijeSOMLqHqHL/AEgfyx/+UUqowAxNZE12duvApBmGiSuCSTJdTcuMH6qviDSjWb+9HWwmFKdOeZOY6e3IYaU70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIpmXCpk4qkF5pJd/Z3xLv6reCekv0j+IYP6VlL2Qkc=;
 b=BfIxlKFl7WWJa5JoX61xtKaQLXtlMTTTvIVVZscBTcYpONqOigv9Ex0FXkhR3pCkFGl4RNNEAGp4i9ZGTLDcauRSfMmUO56SlPOJShDSq1DogSSwImr5pGrdJgOuLjqErCaGbfXUAxJ3uleWSX9CBd5UjmjBbkDuqASx6Q7yXiZt7/Z3kXunPD+kd/DcW6RWJKbW2/G372yiAPxTm3WNQ8AEI/f5yVKf2h6FPo2m4MJm7+PA622iTVDdGmh96dq0+wXQjLcVI2JPCwg28dR2hR2dJ8qamBQC0AaS2jaFTsnZR4x5ar/hWazyWtpf9hsqytgvJgv6JrvfQ0hVxi5kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIpmXCpk4qkF5pJd/Z3xLv6reCekv0j+IYP6VlL2Qkc=;
 b=T7V73J8SWmwv+2tMMt4JNuoMF9p8isIAVd0D4k9Eubc2A8XaiBNIFNLpZNCwA6kRxp8dvYqOTBBBEOck9PTsP6D0P0h4g63m6tSrBV3RIucCZBTiw52xPvta1M9S+RWNdB9WkWjTErrCXI1BlhaKLcwCPiQnNy7sD8tSmFi2BKU=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by MW3PR18MB3659.namprd18.prod.outlook.com (2603:10b6:303:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:37:02 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::493a:b05c:8118:9dd4%4]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 12:37:02 +0000
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
Thread-Index: AQHaakLUium3yited0ucA5q32FAW6w==
Date: Wed, 28 Feb 2024 12:37:02 +0000
Message-ID: 
 <BY3PR18MB4707DBB80B5949EA26F7ABECA0582@BY3PR18MB4707.namprd18.prod.outlook.com>
References: 
 <BY3PR18MB470764DFFE3E532B8D1851E4A05A2@BY3PR18MB4707.namprd18.prod.outlook.com>
 <20240226170032.GA202638@bhelgaas>
In-Reply-To: <20240226170032.GA202638@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|MW3PR18MB3659:EE_
x-ms-office365-filtering-correlation-id: 00b0cb0e-a7b9-4d47-fc94-08dc3859f6ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hhk5K4bDpUnYGArIdBzJs0nVuM4EMwf+MbWvvub00qrrTjFA/z8HIihWrCUalrBvpixM+reeA+iYxNxaOTsbRfEKjE6cHKZe2+X+7Kb0k7hflDT09q+r4hIk3T+bDuoGPZlg5DSuO4+2pdT86o7EgEP5cxVSXEEWENTx+dA7cRU4DZ0hya58CkkNzz8fP8butHK0cwc2xysmJ/1h07oI3PHFVeZPvdm/sAYPhmKefOvQJATMDyIFQuABu/xoLcZJ3joYE7VwUag+IhwIs8LNC+lG65bdNQdsQ5LWsYPyAT/+xPT51U+0/9J2GPCFHeb1btC1rbFMabL/9Ub+IyeDCENjslct6QlBqDGGnXZcLNMp0arxHxuqK3ET8LsVr8NA83SQsa5UnAOMwK4aBTAMaEL+zd4m9YdT676pxEHYqyv9pvkEn9BUwM3AY3e3Um2/vWFHE2TeNY/K3cYdeinbcI13w5yDWYdR101j/2b6d+EdhKthEj3WvDhf2XXcV9PJ9aqyNnZZRUNUqk8V1weOIJgyeiVtxsH0VcxBa9r5J8TYvUiSFimucj1Egb8fIBhRN1aY7IP/Awo4qovQkKv1r1Xg2SitKawKcQbTCIQKNLICxNszF6wdQrZWXL9f5pRHOtk33MUWIgDVdogwGpvkzrDnA83eSyi+NSkl4cW6+TPuueqrlejhlNC33mvYEFJTSOLiKe0nsQa5msDQzqzIqZ6M8MZKBPp7SZJ7GtBTOG8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?/xf1raicblEcL0dpVmf0ROppLjPfUzzjDcuu8/gDQ3RfrxbiSsjCIp/YpG6r?=
 =?us-ascii?Q?MZUVRs9IM8EwzYtERNrFJpDS+zHUbHKK96FTE1v7b7D3Ad8HhoJb7vBjF9pj?=
 =?us-ascii?Q?RZfa+nY05Za+XnLj8ClEbHFzHnvN4ZqGURlylM0OItxEzhBRIRMtLZN3UqZG?=
 =?us-ascii?Q?KL89wi3NMHZFd2aLnddDsteNfW+RRh/4nn2fv3bR780MZZcFxolM5Z2h1gKz?=
 =?us-ascii?Q?nXoomCoeqquaYPNQ8cFup2U4GBKU9UU/BOi8saqyUkFIAe93FJWWCvYpmVmE?=
 =?us-ascii?Q?T2nrrGHeqOch4kTY/n6KC9JTiC0vbTEysGhtOXwk/PVhNBHQD7v1f+RXKnWI?=
 =?us-ascii?Q?bp2b8ZnDMgJ+tYlwDPpTTa7Q4hu4G5SAfXWfaaDfkHBX/+9hKY205YaJr36A?=
 =?us-ascii?Q?M9jnYMx3pOLVbKeQyeW14Sk6z0Ii5YBNhWWyBwwEInlY/XApSF9eo/8JEwUL?=
 =?us-ascii?Q?ApFrpfOGwfGwwN43tyuBgrYu8hqQ0xMoGEeossJ9Sci1PfD0daP5cxP3JI9l?=
 =?us-ascii?Q?0fS/P+0YkfZJciw/aQTWsuKcu+0ORFm1YuNjrpN98RGgUAAU4zY53Hi8KiEB?=
 =?us-ascii?Q?nPHc/03Vw433ZsugoylkYKqkFVTG/6+BEbDhu3ckp5NEhooy8aG7xyvSmIC9?=
 =?us-ascii?Q?pFTSoho+4WPkP9rrXoz8Aw9+bKI9KXj/RlTi/K6h6Omc7our+OU5qnW8Zaii?=
 =?us-ascii?Q?l3p6pNb5+veivTqagxMFp/WzgbRXYXdx/uwSIRkpzbaOd+FhkLyuwEt3n9L+?=
 =?us-ascii?Q?kjYECJSupe4hJvDeOwL1q7jbcrL3tEPIlW7y/m5uMJuWa6KBOcaw66mUB2yn?=
 =?us-ascii?Q?u3yOU21557LfNgi1/kakfF47quyhWt9ghU1T6+eXCUrMmTlKDAT3XqohUeUN?=
 =?us-ascii?Q?XUpDI8ioI9KCai2Nab4uPtCKeZFmzxlRDMsi0uDIvIBA1tN0GGnDR25Be6Ix?=
 =?us-ascii?Q?vJI3i4fSfRQSmxZoKGTpAFjpLskBQU4bR9wdJgeQwavR9hixVrzDWCuYnrgO?=
 =?us-ascii?Q?tMQqhHJLOgR921f1OtS65eZbKEAtGRWX6oauyI6TLQcNR1C1/6P7bhLw9RMX?=
 =?us-ascii?Q?9vnnHFlcw6/yAJTJNhEA5KJ2mFB3kaodgSH3ateb2GubjbOUOBpOEyLtFKJ2?=
 =?us-ascii?Q?2lVKp0ZCI08ywduvxqbP3LGklqHa0EShCSf6Zj7k2KifeQTZtOarNlqNqBEQ?=
 =?us-ascii?Q?IMlWppaUoH79h/rxbUTOOYQEXObRHV1f99D6RxVKt3VTJgIMz3iMY8M4nA+s?=
 =?us-ascii?Q?sq7QfVj1HExEhFPED8pcFdapmk8c5NlgaDNP9tFr9cfdzTUb6t/RgVM3yqZL?=
 =?us-ascii?Q?IBlhYrAqkNA9smy7nq0/J3ujFFnA+t61/d4Vmym7SWjwV9GjHd/CpuhYq4KK?=
 =?us-ascii?Q?URYlnqwM3W2dNuLEFDSKHpinrjp/4eRvqZwX4r9VjIrX+XSRnVavi/ybANjr?=
 =?us-ascii?Q?sSkGKCS73m9ZZ8b4CdhxSSwINZE3yxBTERszr6JxmJcuBkB5bejPM43m2I+B?=
 =?us-ascii?Q?sKHWzQjaME+wXZnMgxzVCS7eOWV+wX5oFl103OvoXpqgFJcCp26/4dlGN+h/?=
 =?us-ascii?Q?5YMFRczGFZGa872Q23X0P6R9DIg3Bzgv2HoID2LB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b0cb0e-a7b9-4d47-fc94-08dc3859f6ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 12:37:02.5020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FYUUzliCFQIwsulWX9z/c9EZW/qTLytDNxg/xne1ktk92CpLn13b6rZkZ5PmtAm2OuGPcGrBljXiFZ+cZqO4kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3659
X-Proofpoint-GUID: vnS--7JNnUNKxco-pyKfjCeYgK9CPxJJ
X-Proofpoint-ORIG-GUID: vnS--7JNnUNKxco-pyKfjCeYgK9CPxJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_05,2024-02-27_01,2023-05-22_02


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, February 26, 2024 10:31 PM
> To: Sai Krishna Gajula <saikrishnag@marvell.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org;
> richardcochran@gmail.com; horms@kernel.org; vinicius.gomes@intel.com;
> vadim.fedorenko@linux.dev; davem@davemloft.net; kuba@kernel.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri Gouth=
am
> <sgoutham@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
> Linu Cherian <lcherian@marvell.com>; Hariprasad Kelam
> <hkelam@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Naveen Mamindlapalli <naveenm@marvell.com>
> Subject: Re: [net-next PATCH v2] octeontx2: Add PTP clock driver for
> Octeon PTM clock.
>=20
> On Mon, Feb 26, 2024 at 03:40:25PM +0000, Sai Krishna Gajula wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Wednesday, February 14, 2024 10:59 PM ...
> > > On Wed, Feb 14, 2024 at 06:38:53PM +0530, Sai Krishna wrote:
> > > > The PCIe PTM(Precision time measurement) protocol provides precise
> > > > coordination of events across multiple components like PCIe host
> > > > clock, PCIe EP PHC local clocks of PCIe devices. This patch adds
> > > > support for ptp clock based PTM clock. We can use this PTP device
> > > > to sync the PTM time with CLOCK_REALTIME or other PTP PHC devices
> > > > using phc2sys.
>=20
> > > > +#define PCI_VENDOR_ID_CAVIUM			0x177d
>=20
> Already defined in pci_ids.h.

Ack, will use this V3 patch

>=20
> > > > +static int __init ptp_oct_ptm_init(void) {
> > > > +	struct pci_dev *pdev =3D NULL;
> > > > +
> > > > +	pdev =3D pci_get_device(PCI_VENDOR_ID_CAVIUM,
> > > > +			      PCI_DEVID_OCTEONTX2_PTP, pdev);
> > >
> > > pci_get_device() is a sub-optimal method for a driver to claim a devi=
ce.
> > > pci_register_driver() is the preferred method.  If you can't use
> > > that, a comment here explaining why not would be helpful.
> >
> > We just want to check the PTP device availability in the system as one
> > of the use case is to sync PTM time to PTP.
>=20
> This doesn't explain why you can't use pci_register_driver().  Can you cl=
arify
> that?

This is not a PCI endpoint driver.  This piece of code is used to identify =
the silicon version.=20
We will update the code by reading the silicon version from Endpoint intern=
al BAR register offsets.

>=20
> > > > +	ptm_ctl_addr =3D ioremap(PEMX_PTM_CTL, 8);
> > >
> > > Hard-coded register addresses?  That can't be right.  Shouldn't this
> > > be discoverable either as a PCI BAR or via DT or similar firmware
> > > interface?
> >
> > Ack, will explore the DT implementation for register addresses access
> > and submit patch V3. Thanks for the review.
>=20
> I assume the PCI_DEVID_OCTEONTX2_PTP device is a PCIe Endpoint, and this
> driver runs on the host?  I.e., this driver does not run as firmware on t=
he
> Endpoint itself?  So if you run lspci on the host, you would see this dev=
ice as
> one of the PCI devices?
>=20
> If that's the case, a driver would normally operate the device via MMIO
> accesses to regions described by PCI BARs.  "lspci -v" would show those
> addresses.

This driver don't run on Host but runs on the EP firmware itself.

>=20
> Bjorn

Thanks,
Sai

