Return-Path: <linux-pci+bounces-32486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB7FB09A80
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 06:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2C75A30E2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 04:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925DB1C84C0;
	Fri, 18 Jul 2025 04:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SSC3e9Xo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5154652;
	Fri, 18 Jul 2025 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752813040; cv=fail; b=eR2jF/OoNDXes4V/8PngD0vpaSi3osYduWdjNpatefFAMiO10aoR8qq3527V2UPHnR2HS+A9w3kyCgaawY8d+LYHWHuXF+X1Vui2gDNTCib1wWUdRnNZfHc6Ak52FK37H1cL0IUxwT8BnAaEon6jfJYkMS3DjTRK7kNUQ0ntBFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752813040; c=relaxed/simple;
	bh=2zuCNjU0c8RNJ9mum1KYBvxZ7Isp8g3Ikk3uCyCp6Ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQNP//6fCLqbqOG3j33gda6kfXxoS/jsvIyMlTvk/ruTdQKubXC8GojNz8axljGM/hbBG5MKE822POM/L2gCRHkh/6o9wt5QG/QD4FvOx78r7ypKGd1KpZ+U5IcV2EeprRNX7iJ5XXJ92cHIGofk+M03rHEqFEdMWJ0He2YEYmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SSC3e9Xo; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKqM/2T9UGeoZ3UDcUsCbSd1sx42zd/VaAG8W526D6owG35kUXDTzcUpCvIzitKcEEtmJK3arQWGdumrNUIpB9Yz8LVe8jTh5pdf4+m0q0MoAHlJSSI4/4euyNDMW2YHHr35Q8bFTkZWZB01jIjg/BXfk+H8ZSssyYFzIvejibTI8MNTCQV9tAt/UrCNXiBeOLsyx1VvZwRgnGLBKmyOU8Vj0g4Ll6oH+vFncIpGDhLXXfyCt2OzFVAu5OIdCgnbrHrlLv0+1gcB2+shmmPfLD9gAy1xIk1+ZW+/40eN/cIWLCsftRwdIsnP+q5HEfTolxjkcnhMrlFmqy+L3yMHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRy08BcmyQQETp9fohFm3t9erwtAUUVtowH5bEtxc6M=;
 b=yxkszOMqUxVjoaMayaIcZOp33VZGHtTEEcvSGwnb+xh4J1Q4TadOhr7/MleSMhELk+sd6qijNgLfcD2iCRMaxqMWHIA7JbHo1fQ80GcvTXHDFXPMmQrfUVlDSdvHr4EJznMtOgSFIeCMIfev9m2Jt6VqnDysYYPf5+NlHJSaZYVZhU8K0EGJOi4Ym/3D+mvRoXmA5f5OkdKyNh2OyErxu5DqKiK9/X8QTY3fzSZTZ0Jg7j1tfJQNItjRyNd6/tZTwpPu5yI62q9lPGvz/rRg+J/AUB+Bbxr7SXrJK+hoVOJKltezuQ0USQYAWL0tZ48GsSmdL7U2y1wYsmW/QlEeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRy08BcmyQQETp9fohFm3t9erwtAUUVtowH5bEtxc6M=;
 b=SSC3e9XoYeUqPZRuV2uJc+0nBFylfFLrHLIqubVlKadl0XeSdAn/RTkWGC0iP3ySqhFg6tXp6iIZgQAF3tyagSqW3Jvjg33u/DEXgv0W0Q+t3HwYUL6Vp0OKVuSXnxOv1EzdvvkyYxwjK9yIdODo99OrIMVBXcZlgYAEEh5E5hI=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 04:30:33 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 04:30:32 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Topic: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Index: AQHb8iQRia+LCHEfhkup0319RPtRobQtj/EAgAjHjwA=
Date: Fri, 18 Jul 2025 04:30:32 +0000
Message-ID:
 <DM4PR12MB6158DFAD4351A17E3523CA58CD50A@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250711052357.3859719-3-sai.krishna.musham@amd.com>
 <20250711231830.GA2313060@bhelgaas>
In-Reply-To: <20250711231830.GA2313060@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-17T13:22:49.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DS0PR12MB6390:EE_
x-ms-office365-filtering-correlation-id: 7fde195f-4fd3-45bf-0401-08ddc5b3d588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pbutJl6UuevMTUSjserkg9zXiZmbs4/qtRvMCRc7kh64tsLF3R97fYg2jRju?=
 =?us-ascii?Q?6kkDdDPYVUXlJupwOz+pv7fXIMZi0i1d1rljC4GL5gubAR8EpxOZQVxBVOm2?=
 =?us-ascii?Q?+Apd5+7i//1G/HBnO6HFH669Pdr/uQ9B+9/Xf4TNmZZlhLr0y+8XfK2OX8bh?=
 =?us-ascii?Q?giujKcp6Lh4J46I8D0vyW+i27ruVoit168FRVhI6Bb3MQ3Mwz4dTj3VSFZIO?=
 =?us-ascii?Q?QXKAF8mgP+EpyY0eITo+Js6jEVucJe7si1EM/2r4kkpnGKzuyJnK0sGuYr+j?=
 =?us-ascii?Q?H9G2UlaZDlp5ytuGDJEq8ksWOu02OLubnre5yhoEFOGnxUvnrwIDOozJF1IR?=
 =?us-ascii?Q?R295JzBPGGa+GMvxoX8G3ajizzPMEJmhPLVrRpKHxylhFPhtB8wnnOxN1zxm?=
 =?us-ascii?Q?67IdK9T4RmB6C45mO1M8yukrLTWBeMUULrT9cyzsfiKuFKW/JOQWYffETBTr?=
 =?us-ascii?Q?8TADG99ah7gwb1RGjLm3aH/j+FDkRtsGUA/JU9cb1I+UrEPff/WBg932jqLM?=
 =?us-ascii?Q?3GLkTua+xOoZzJ8oB0quS3Hnm72zY5vMGnblUIDWfY16SVSw7spUXkKf46wd?=
 =?us-ascii?Q?ubfA9RA63kJhI3GN14b7Zs703Vc+xRgdN8M3vPFmzeAYjkVj5RUWdF59cgvU?=
 =?us-ascii?Q?vVE0mQ3nlOCb4MW5KrXG3kLve0eOe+pxH/zBWx15Agqe37JXIwwQ1cLNNBew?=
 =?us-ascii?Q?P5GZIS3wGPNvnhAYLLpizMOlY8KuU5nw6HrLtdQ64jLgZO8UDjWXhWinM31b?=
 =?us-ascii?Q?ZbfL2BN6M1Yuxv/Vg/XDWpwEPOb/vhdzgO8f6V+F5o5DusPXjpCw5CzrWOaY?=
 =?us-ascii?Q?enxqT1rjGsW85KhY+Mydy8HpMNexbp2+z3JPm2PYQF50Fz16FGf506aBl4po?=
 =?us-ascii?Q?W84pxaiKPbUKiGD/kWcwIp/Fp+rtejIXMM+5HPd8nwh9No1iuVowlV+HWmRT?=
 =?us-ascii?Q?U7KIJPjUTlbl4igyi3L7j76g+TNGhqmz7cckGu7tAwKVO+SAj96ZEDpIC46i?=
 =?us-ascii?Q?BTo2tuVDBWxBLVHbzMmxAn7z8eAk1eDEyNo5JtcGmFop98lLfxvhscO1ZZ+h?=
 =?us-ascii?Q?8pHdF8OG6xqHg0BzYpF4Xpy1wqoInzpHCSqJ8tCFpz5/ZsxPzSmw5aKlO6Wc?=
 =?us-ascii?Q?vq+7pgYVvkGtRnjkV4liEJKYmWBhEwYgq9Z0Sv2redvDEAGDa0RPXK4LU0yW?=
 =?us-ascii?Q?oWdjwRXMD5KbAkz8A16ptEkNU6k6ezLgfSmd0HSbpMAwil92er7DZo8+/BGd?=
 =?us-ascii?Q?Q15aP+orsVnHxhUzP22aO5RUdS18AZzsGnzH8tA/4ddwyox4QK1kSZSlDc4b?=
 =?us-ascii?Q?QTsboycbEeYC7s0S1Hhx9nMS5WhZTwGWa5vUFQvkTSZL5le3T9Y/14prlVHr?=
 =?us-ascii?Q?W69fJYHpfiYSpSihX8Cq1A7vufwRgxSV0mjex0wrB64+I2ZIfmmOgRbvrVOq?=
 =?us-ascii?Q?ckF4vFkvjhQFV2ikechkYVwuR1OWwVghm2uK9YKBcPsNixx2xi8b2hFacb5z?=
 =?us-ascii?Q?czgRJL+4OFuTFhA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9sv+C0/93nlTc2AbeGG910OTYRoEBXaIbb6Sb/penJxMBLvrSZ9KsVvV7pDS?=
 =?us-ascii?Q?MQjZ80+Uz+KiaeEzKnGIdzeEN/K8+JD50ZmvwpwFFYAtmYCVXCY21fef16al?=
 =?us-ascii?Q?p658OkfHytHjrUwJ2WZcQBb7GW2PS4qlUj6sj+QbkirsUQPdx86nlmjjeWb6?=
 =?us-ascii?Q?CLrl1JAjl+2R2Tsc3H54CVJL0tWFmKZvN8nr9MKnWVTQgRNfdqUeQgEwqcIC?=
 =?us-ascii?Q?2BsCF6KAMrlTILLZS2ONv/hKT5tyg5/I3tpn7IMyTJDGjO4ZtRYybLh1wXWk?=
 =?us-ascii?Q?VksTn54lZlIGq+aOvr7UA37u5KrK8HLitQVob0AxBhA2mxcks4k9SYH1PNxr?=
 =?us-ascii?Q?d+9S9IIUXlnZgYtITHVuv5u/dwyrtymwv8maWBTlsO2henvXr8kb1JR9uKZa?=
 =?us-ascii?Q?gpQvZKsZiXwI/hwTw1eQRJj+PcxwrdB96X094KpV4MlFi5XaintiX1NGsfSw?=
 =?us-ascii?Q?qqrFKY61u3tqsYCHF0SgDlYi4pzsjUTAWfJe4q5g2QVDBT8Gww7RJCUXf4ol?=
 =?us-ascii?Q?CXVg+bnK8TouWfkoNw19SA06WMnGVhqbkDLIhNBycauEEgV4DbEtVApqzurG?=
 =?us-ascii?Q?KsYvtU8l8HFnK2Zz/8Uj/Qpg6YzyypAdiGksqCZ+drlJaocgAmJHJowDPJ1F?=
 =?us-ascii?Q?Dk9uFlejwHVfXpZkVE5Sj5xytKqDTBWn8DPcsxXknOODDR+GMvNMmP0fWvGr?=
 =?us-ascii?Q?9VxOWGHVt/Jqt1rxkXRal72XMXmGtne14MgdCzLHbkMOPjVhyUDJt1TOEcQ9?=
 =?us-ascii?Q?1BLr8PoXR8tE/+zg3CpHD2ORFZjDqiShMATOFt5k9INnFMnwRJDpyKO9dcHY?=
 =?us-ascii?Q?COL3PR7fTtV4pMiKkKsCEAa+1/+jP6ttFyP+SoQbkQA19zNbzMkBz1fkjdK0?=
 =?us-ascii?Q?mUcK8jtMxUY0NFPTKIU+ZoOl83toOqI1nhIOiZ4omtR5zotvTEjq4+UbNXlk?=
 =?us-ascii?Q?1vFbL1Y9eSNkpNMU8phAMwZN3jg4AhQ+PuLjJtuK4y6JbhvAgf39TJN5up8u?=
 =?us-ascii?Q?erYxgcfzHEG/OELL7WpTwe51W5oO44GsorpccICpBD7esvCxWQSxgEgMlzTE?=
 =?us-ascii?Q?t+Uc7Cz2k9/jkU258T/S/jd0eB1vD0TiRWD7ZFBivFxZLqvLKZ4302Duxj2o?=
 =?us-ascii?Q?2CkcVOGMl1rMx7NAuBE/V6SfVxM7zFe+xtZ8QlspY/aabm1fXnhtSTI9hMH6?=
 =?us-ascii?Q?7e+2FWTLjjdbO1c6LK5fl9IbZxm2NzWqUXJWdawkQ9IPHDVZcMEkZmhXy3Xo?=
 =?us-ascii?Q?sW7PFLQp07k9wYYaZeIA5AriBFp7fbJhFWwhuw6PliyU0ezMNiviS8HyKMzp?=
 =?us-ascii?Q?43ajCPC5cmpVzVYL9fFayUqh53YxcEjDBoflQikfEN42MtIPEHGvWc2x1K3F?=
 =?us-ascii?Q?j1u7RtmCRrIBM2MbxTnYjG66ACrkFTybldcRa415OSwHzptVVh2v4qzCDW72?=
 =?us-ascii?Q?6l1GAoWHpAspJBr2GwcGoH4x9PJr0TC2+v8UTszZjGD+tkkeVmkum7EnqFrh?=
 =?us-ascii?Q?DoPehnOd09rJA45mS7lu+40UoVMR6TOQ+wf0VaSx6IBRSxWemdA69WCglXkz?=
 =?us-ascii?Q?npRU92Ul9KJC0L7uR/M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fde195f-4fd3-45bf-0401-08ddc5b3d588
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 04:30:32.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfRyYrercti4lj60zIfynshct2MKQTwLilLigToeRhmxC0gnmwyS7ahXoigaJQNgZj+PMDQkbyu7zoGs364QCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, July 12, 2025 4:49 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel=
.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> signal handling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Jul 11, 2025 at 10:53:57AM +0530, Sai Krishna Musham wrote:
> > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > reset GPIO. If the bridge node is not found, fall back to acquiring it
> > from the PCIe node.
> >
> > As part of this, update the interrupt controller node parsing to use
> > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > node now has multiple children. This ensures the correct node is
> > selected during initialization.
> >
> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > Changes in v5:
> > - Add fall back mechanism to acquire reset GPIO from PCIe node when PCI=
e
> Bridge
> > node is not present.
> >
> > Changes in v4:
> > - Resolve kernel test robot warning.
> > https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.c=
om/
> > - Update commit message.
> >
> > Changes in v3:
> > - Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpio=
s
> property.
> >
> > Changes in v2:
> > - Change delay to PCIE_T_PVPERL_MS
> >
> > v4 https://lore.kernel.org/all/20250626054906.3277029-1-
> sai.krishna.musham@amd.com/
> > v3 https://lore.kernel.org/r/20250618080931.2472366-1-
> sai.krishna.musham@amd.com/
> > v2 https://lore.kernel.org/r/20250429090046.1512000-1-
> sai.krishna.musham@amd.com/
> > v1 https://lore.kernel.org/r/20250326041507.98232-1-
> sai.krishna.musham@amd.com/
> > ---
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 63 ++++++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > index 9f7251a16d32..d633463dc9fe 100644
> > --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/resource.h>
> >  #include <linux/types.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define AMD_MDB_TLP_IR_STATUS_MISC           0x4C0
> > @@ -56,6 +57,7 @@
> >   * @slcr: MDB System Level Control and Status Register (SLCR) base
> >   * @intx_domain: INTx IRQ domain pointer
> >   * @mdb_domain: MDB IRQ domain pointer
> > + * @perst_gpio: GPIO descriptor for PERST# signal handling
> >   * @intx_irq: INTx IRQ interrupt number
> >   */
> >  struct amd_mdb_pcie {
> > @@ -63,6 +65,7 @@ struct amd_mdb_pcie {
> >       void __iomem                    *slcr;
> >       struct irq_domain               *intx_domain;
> >       struct irq_domain               *mdb_domain;
> > +     struct gpio_desc                *perst_gpio;
> >       int                             intx_irq;
> >  };
> >
> > @@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct
> amd_mdb_pcie *pcie,
> >       struct device_node *pcie_intc_node;
> >       int err;
> >
> > -     pcie_intc_node =3D of_get_next_child(node, NULL);
> > +     pcie_intc_node =3D of_get_child_by_name(node, "interrupt-controll=
er");
> >       if (!pcie_intc_node) {
> >               dev_err(dev, "No PCIe Intc node found\n");
> >               return -ENODEV;
> > @@ -402,6 +405,34 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie
> *pcie,
> >       return 0;
> >  }
> >
> > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > +{
> > +     struct device *dev =3D pcie->pci.dev;
> > +     struct device_node *pcie_port_node;
> > +
> > +     pcie_port_node =3D of_get_next_child_with_prefix(dev->of_node, NU=
LL, "pcie");
> > +     if (!pcie_port_node) {
> > +             dev_err(dev, "No PCIe Bridge node found\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Request the GPIO for PCIe reset signal and assert */
> > +     pcie->perst_gpio =3D devm_fwnode_gpiod_get(dev,
> of_fwnode_handle(pcie_port_node),
> > +                                              "reset", GPIOD_OUT_HIGH,=
 NULL);
> > +     if (IS_ERR(pcie->perst_gpio)) {
> > +             if (PTR_ERR(pcie->perst_gpio) !=3D -ENOENT) {
> > +                     of_node_put(pcie_port_node);
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +             }
> > +             pcie->perst_gpio =3D NULL;
> > +     }
> > +
> > +     of_node_put(pcie_port_node);
> > +
> > +     return 0;
> > +}
> > +
> >  static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> >                                struct platform_device *pdev)
> >  {
> > @@ -426,6 +457,14 @@ static int amd_mdb_add_pcie_port(struct
> amd_mdb_pcie *pcie,
> >
> >       pp->ops =3D &amd_mdb_pcie_host_ops;
> >
> > +     if (pcie->perst_gpio) {
> > +             mdelay(PCIE_T_PVPERL_MS);
> > +
> > +             /* Deassert the reset signal */
> > +             gpiod_set_value_cansleep(pcie->perst_gpio, 0);
> > +             mdelay(PCIE_T_RRS_READY_MS);
> > +     }
> > +
> >       err =3D dw_pcie_host_init(pp);
> >       if (err) {
> >               dev_err(dev, "Failed to initialize host, err=3D%d\n", err=
);
> > @@ -444,6 +483,7 @@ static int amd_mdb_pcie_probe(struct platform_devic=
e
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct amd_mdb_pcie *pcie;
> >       struct dw_pcie *pci;
> > +     int ret;
> >
> >       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> >       if (!pcie)
> > @@ -454,6 +494,27 @@ static int amd_mdb_pcie_probe(struct platform_devi=
ce
> *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     ret =3D amd_mdb_parse_pcie_port(pcie);
> > +
> > +     /*
> > +      * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that =
the
> > +      * PCIe Bridge node was not found in the device tree. This is not
> > +      * considered a fatal error and will trigger a fallback where the
> > +      * reset GPIO is acquired directly from the PCIe node.
> > +      */
> > +     if (ret && ret !=3D -ENODEV) {
> > +             return ret;
> > +     } else if (ret =3D=3D -ENODEV) {
>
> The "ret" checking seems unnecessarily complicated.
>
> > +             dev_info(dev, "Falling back to acquire reset GPIO from PC=
Ie node\n");
>
> I don't think this is worthy of a message.  If there are DTs in the
> field that were valid once, they continue to be valid forever, and
> there's no point in complaining about them.
>
> https://lore.kernel.org/all/20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm=
.com/
> has a good example of how to this fallback nicely.
>
> Otherwise looks good to me.
>

Thanks for the feedback. I've removed the fallback message and simplified t=
he "ret"
checking. Could you please confirm if this looks good for v6?

        if (ret =3D=3D -ENODEV) {

                /* Request the GPIO for PCIe reset signal and assert */
                pcie->perst_gpio =3D devm_gpiod_get_optional(dev, "reset",
                                                           GPIOD_OUT_HIGH);
                if (IS_ERR(pcie->perst_gpio))
                        return dev_err_probe(dev, PTR_ERR(pcie->perst_gpio)=
,
                                             "Failed to request reset GPIO\=
n");
        } else if (ret) {
                return ret;
        }

> > +
> > +             /* Request the GPIO for PCIe reset signal and assert */
> > +             pcie->perst_gpio =3D devm_gpiod_get_optional(dev, "reset"=
,
> > +                                                        GPIOD_OUT_HIGH=
);
> > +             if (IS_ERR(pcie->perst_gpio))
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +     }
> > +
> >       return amd_mdb_add_pcie_port(pcie, pdev);
> >  }
> >
> > --
> > 2.44.1
> >

Regards,
Sai Krishna

