Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF343AACC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 05:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhJZDns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 23:43:48 -0400
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:42934 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234754AbhJZDnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 23:43:47 -0400
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19Q36Z8i013243;
        Mon, 25 Oct 2021 20:40:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=vEDsIuXu5ENFvYfYEXEiqsRgaLRCbCQ2V+YAbijw5T4=;
 b=ZDAd/tbukrIt1bah+tNK5wgVZla1a+C8GMl3kOuwfCT6Myg3VTpuC0eueYyYVYjLc0G5
 B4kRTwT6y1PPt6h3xUTR8qlz8lvhbEMxJbphrYAnHgPm0NOA7p5Ywsb0jB+UFlejaKvP
 s/CLwta3vYhuXnOJeN+YOUoiYxIsEiMKTT1Uh6BCMPJ1Ijj9cFv7NvGwaFOZB+70aH9v
 eMThs0zdk5dlkqL+8IwKF3m5Q2wIM2KK8qZc/WaGa3d/y7cJV9HVOHxR796k1m2pGIhS
 TRkSQkhiIr9jejIMadRrIWFzk/NhYHHXVC3eHbEe/UIKZl73qurhDB/gzqwSYwXlCVlV 2A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00622301.pphosted.com with ESMTP id 3bx53gg3yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 20:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWbjwLC8lBP/bUG7zP95d9SKuZT4l2Bh/1+QHWSKkX467JbOUW5RW+xMqC0qxQY3MLP4NB+FpDHrRFCx1BeakUzsnI7kz/EjXkmg2u0zgYNPL4W4pjy8ikHQw5Ptl5OgZMWSjUqDXhRcP8+gDEYI2RuRtYGnLUc9MW7xn/BdiLZvRF3MNASRl6QgyIkjwGk3M/zNhjSZLk6PFVZIdeBScDndBzRrzMIaSZ0iFaCrj9eqtc3PBu8B3KM3PINQYLECcyRdmdAY3UHC8V6knZP9ygj9gc2Qq4NNGpOsuMQu6oojrjPZNU1KB/VEtr1IqTmOwckRsmUU3TR4KU+n29QN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrvaM6JZOcvTiTtqXaGhKVSxEjwsnHYZ/jBLPChTtD0=;
 b=LlwXzmpUmlF8VeUTFp4cMjE+PaZ+tco6VDcyeLagls/G6Nre7QR09IfZeLaTDHvAKfWlJWH1GHjdvLIxXU9Te7Z918SSPYm0G2SwxwYLKM0QHVifHZahgp8D3JNCXlF2xPe2n0eoYGlE8/2ggT3PCqvH9CZ1YyDRyedc1UsFfA8WV/Hx4wQm2v1F0Hf7g3+j06tVjrk8f6n98aTegu/uZD60rX/srNqZ0r3/RhQVsKlE7Jq/4bJKI+TcvCxl/tpkjwuQniT2ljUeSRRRTiPLUXUYx1hszBNkrVHe8JT3FkhzAu8qyfOb8e12jyJQebqToqomr2ZdYzdKDiQfIeHoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrvaM6JZOcvTiTtqXaGhKVSxEjwsnHYZ/jBLPChTtD0=;
 b=a2sNuRHJsXGKy2P95f/oR5683Nj0N2dhCSXT1Cn/a4HUprVuk/kpPk8gcjCpzegsFumjkjjTfeo8qTQgW6bhhWiBSDy+CPqj/tYLRvAF4F1rkAKwu20DoQsiPKOW79UgSLzLfQVEbIHt8YLDtHSNjhJgZguGrM1FyL4sxIZl5K8=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB4054.namprd19.prod.outlook.com (2603:10b6:610:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 26 Oct
 2021 03:40:54 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 03:40:54 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Topic: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8A==
Date:   Tue, 26 Oct 2021 03:40:54 +0000
Message-ID: <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211025154739.GA4760@bhelgaas>
 <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ac49a24-59a9-4918-1f84-08d998326a0e
x-ms-traffictypediagnostic: CH2PR19MB4054:
x-microsoft-antispam-prvs: <CH2PR19MB40549C1868D7030725799165A0849@CH2PR19MB4054.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 45osu9y/hIsfhyawjEdjTjfU50mzTVdqsrC75Pxw1ucA6OPk8LVLZEHJeNhRcmFE8XA/QRVsY9tUDaRW+JRyXnMcwJUz7d/2v9M71nu6PkwE10ae4swoHt7PUxqbUKeBpsw0UslX9mHslxmdZKq9/G0k/pILL1ajO08bshODxOdpSYT7FiEC4Bknq8yBEqk5TYioLgq8iLqSeTJsj1XE3rDtQA9zEwmkna+cysqLY4ZthjRyXMuyKimVRj1omw90d9XL0PVSecfgS5s5Brltrc48Oz9Z0f7gV1vFzIWT3pbbqm6SennExi+gNtJfNpXD8oy2YHWdSPdVgKRWFRsflfcy5omM5l1baPjRHtzkEbLPQNlAXmwwSbmatPAYEj68O1mD+WJ9BsaLMD70aO3uDItUiMW9S2XRV9rf842ffeddO3IXs7x4HzzJZJXgs8f6PDJPZXKMLOvDLzoghFyeIGHWbImv4Liu2CwhOHNBaYWCaNDev1bSw0FfLTqUq/yMH5QNxTXN1RbdbJh1QcmhwX43g9Smft8fKVuQowcidb9FL32g/xFFEGLg7posJvQy9ZybVXgUWEWKt4PgBG4rtiL3T28TaRxjK8qfd0ZWuLUCxMEKdtu9lSIbdp7MKZ5OKaMK3kHDVp0H0s+XM30rKBWMWhnkPiz1+ybb+D00z6RHoXjl2/alE5uJl+OTI3OQjGlqxnNPZ8YdXmofi/bdRu9LeY1b+cfQ0XYOWNWAzwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(8676002)(38100700002)(2906002)(64756008)(88996005)(71200400001)(66446008)(122000001)(66946007)(66476007)(66556008)(55016002)(508600001)(7416002)(186003)(7696005)(6506007)(316002)(53546011)(26005)(54906003)(5660300002)(52536014)(9686003)(86362001)(110136005)(4326008)(966005)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cMm3ojiNI01ZX00+q0YDklq3d6pSzAagJF5RhPCDGi4SYc9wxDAtaSlxBEtS?=
 =?us-ascii?Q?MfvBL6g0lnUijHloox2YmI1cxiBnEtIOA+1hbOXiKYqBmP8gg9qrPt5tLpJb?=
 =?us-ascii?Q?ykjusAK73Z/rWfiKexSO/96jZKBdZ+ldzYF/0j6hLZezjaGL83RH0IsIKUeQ?=
 =?us-ascii?Q?kBqsndL7eBmBk1/Kq4i0GfLgXyBbVlX/BGov7hKAAa1Kty0lUyz3BSIWi9G7?=
 =?us-ascii?Q?SkuGVw7BakDXi4bleQAujwiJNWqxkYv6TaQFK4YCrFry/Oaw4hF4XnKmTXq6?=
 =?us-ascii?Q?6GPfrTeAhYfTZTiSpqpyZUXSlE/4o9Si/fxNaDoW69oUyRVD2zFbi7cVApcK?=
 =?us-ascii?Q?gAj4/+ZjfPPjIdqn1taPyL9MVAyvtl+HIw8+IH59Wl5gmHEmk6CnsU5tNm//?=
 =?us-ascii?Q?KnYzbtizTfzBrK366yvOg6Nh8TiVnz/oawjXSiusQVqlkDBf71b5E+0SttCu?=
 =?us-ascii?Q?SBJ4B6gHSwbXPMQHq1bHkpWz9Jr7vzVIF/XwNZrQCQ57Ah+fUfXcx+Cs0aec?=
 =?us-ascii?Q?MPQvR9MTUWCj4jkMgUNOfirsCYOWifqesgf8zKQpYaoMGIyzRlftdsIAX6LV?=
 =?us-ascii?Q?4DsLJxVdBoUcIAEI91q+TqIvqZDqznRguBqrugsd4nfbTMKYtDla110U4hL6?=
 =?us-ascii?Q?xzHieDOiRcW5FPTUbC45e7f5UN2mrVcjzOwYehPJzGXiq+R9+zXHJN5ptYy7?=
 =?us-ascii?Q?BXq3V+NjUDoNBRFLZHCXWinKx3i9+851/ieI01aYgr62hBAFWSotcV3cPGUb?=
 =?us-ascii?Q?GtI1lRumo4TX+6Y2AE0MUG1o2esEVk4Qpb2gV411a3lxcFrTo7XNRV1YaE3A?=
 =?us-ascii?Q?9SPr/FLsBhbKx6ujCcURpdQlKUM1Vw6ySFrmD1tpAoayLUH1dIEpKEdhEjAV?=
 =?us-ascii?Q?EwU9mk+Lx1/Fu4N2FYx/WiUsa+Yo4kmw212+U4mFY6RHT9O636zZLJK+Viou?=
 =?us-ascii?Q?VrTSlWwq4eK2e64gXOFNsrkR1zs4bjMs3FZeMQ2LXIffzOmG8hvRa33zdOZv?=
 =?us-ascii?Q?MuvHZsKJf5PCbo9w+yTB8NPD1Wi7c6GNywQJPlxJRrDAgTouoDYT7eL5p82A?=
 =?us-ascii?Q?kU7ZmqGX889CYm4fu3TcH9tIwzWesVRvNQ1zmXSJ9JxF90ikehwqrT9o/E9M?=
 =?us-ascii?Q?ukAabStVTRGhf4GHY0mJS78tADTKQOfFnEevE0jkj+SSAs2EwKTPS+zqvuOg?=
 =?us-ascii?Q?ojexjOmJcKqoBaJ2a6PYyGDU0Miru+gyir+FOmQGLU1E4x5DMKmm6kp3sfme?=
 =?us-ascii?Q?HsAD8ZwXy0rcYzjryIc4XXjSuNM7R84/YhXG8ph1MvlP9AweW2D8XFTyPK/h?=
 =?us-ascii?Q?HudA6zfYgLy2mM2FtgTGCP8cMgKoo5oXj6UdZ0w/ZGHD9KPgm9VqHC2WzQ5n?=
 =?us-ascii?Q?T/EskpJl6azIkxL9FHVZbtPrE3AhY924Y/Jl9VLDgrFmHhKu25TRJc7yj4Rw?=
 =?us-ascii?Q?qtxeF82Fm44g7pc30BxzPWYSOfLFuhrtXKkhGCzCcDlALoq6RsLI1GXfD37O?=
 =?us-ascii?Q?2r3D6DKNDK+dJrVxQ1k/YZ8sOnhcTZGLXIHepKaj7eyiwfWfhD+phclcyVi6?=
 =?us-ascii?Q?IrCyrjYjIazSW4SzJvo9M0oFBFG41dI9zFW4AI6tTp2bmAKfTZcEooKzMgvk?=
 =?us-ascii?Q?WrFKDzW51s5VJpAXfiZy2oY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac49a24-59a9-4918-1f84-08d998326a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 03:40:54.1885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cs2taB3T0RU5XKm6RECaMmJaCcVTk8oNZAxEGjEaV1s9OzwRRPUc6xgQJXl2VeJpJOWUk42ZQjQNfI5d82qRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4054
X-Proofpoint-ORIG-GUID: N_moRxm2DVXyGnd3hEuU8IUftNvfJWlT
X-Proofpoint-GUID: N_moRxm2DVXyGnd3hEuU8IUftNvfJWlT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110260017
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Keith and Bjorn

> -----Original Message-----
> From: Keith Busch [mailto:kbusch@kernel.org]
> Sent: Tuesday, October 26, 2021 12:22 AM
> To: Bjorn Helgaas
> Cc: Li Chen; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herring;
> kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; Je=
ns
> Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> Subject: [EXT] Re: nvme may get timeout from dd when using different non-
> prefetch mmio outbound/ranges
>=20
> On Mon, Oct 25, 2021 at 10:47:39AM -0500, Bjorn Helgaas wrote:
> > [+cc Tom (Cadence maintainer), NVMe folks]
> >
> > On Fri, Oct 22, 2021 at 10:08:20AM +0000, Li Chen wrote:
> > > pciec: pcie-controller@2040000000 {
> > >                                 compatible =3D "cdns,cdns-pcie-host";
> > > 		device_type =3D "pci";
> > > 		#address-cells =3D <3>;
> > > 		#size-cells =3D <2>;
> > > 		bus-range =3D <0 5>;
> > > 		linux,pci-domain =3D <0>;
> > > 		cdns,no-bar-match-nbits =3D <38>;
> > > 		vendor-id =3D <0x17cd>;
> > > 		device-id =3D <0x0100>;
> > > 		reg-names =3D "reg", "cfg";
> > > 		reg =3D <0x20 0x40000000 0x0 0x10000000>,
> > > 		      <0x20 0x00000000 0x0 0x00001000>;	/* RC only */
> > >
> > > 		/*
> > > 		 * type: 0x00000000 cfg space
> > > 		 * type: 0x01000000 IO
> > > 		 * type: 0x02000000 32bit mem space No prefetch
> > > 		 * type: 0x03000000 64bit mem space No prefetch
> > > 		 * type: 0x43000000 64bit mem space prefetch
> > > 		 * The First 16MB from BUS_DEV_FUNC=3D0:0:0 for cfg space
> > > 		 * <0x00000000 0x00 0x00000000 0x20 0x00000000 0x00
> 0x01000000>, CFG_SPACE
> > > 		*/
> > > 		ranges =3D <0x01000000 0x00 0x00000000 0x20 0x00100000 0x00
> 0x00100000>,
> > > 			 <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00
> 0x08000000>;
> > >
> > > 		#interrupt-cells =3D <0x1>;
> > > 		interrupt-map-mask =3D <0x00 0x0 0x0 0x7>;
> > > 		interrupt-map =3D <0x0 0x0 0x0 0x1 &gic 0 229 0x4>,
> > > 				<0x0 0x0 0x0 0x2 &gic 0 230 0x4>,
> > > 				<0x0 0x0 0x0 0x3 &gic 0 231 0x4>,
> > > 				<0x0 0x0 0x0 0x4 &gic 0 232 0x4>;
> > > 		phys =3D <&pcie_phy>;
> > > 		phy-names=3D"pcie-phy";
> > > 		status =3D "ok";
> > > 	};
> > >
> > >
> > > After some digging, I find if I change the controller's range
> > > property from
> > >
> > > <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x08000000> into
> > > <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>,
> > >
> > > then dd will success without timeout. IIUC, range here
> > > is only for non-prefetch 32bit mmio, but dd will use dma (maybe cpu
> > > will send cmd to nvme controller via mmio?).
>=20
> Generally speaking, an nvme driver notifies the controller of new
> commands via a MMIO write to a specific nvme register. The nvme
> controller fetches those commands from host memory with a DMA.
>=20
> One exception to that description is if the nvme controller supports CMB
> with SQEs, but they're not very common. If you had such a controller,
> the driver will use MMIO to write commands directly into controller
> memory instead of letting the controller DMA them from host memory. Do
> you know if you have such a controller?
>=20
> The data transfers associated with your 'dd' command will always use DMA.
>=20

My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electronics Co=
 Ltd NVMe SSD Controller 980". From its datasheet, https://s3.ap-northeast-=
2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_Rev.1.1.=
pdf, it says nothing about CMB/SQEs, so I'm not sure. Is there other ways/t=
ools(like nvme-cli) to query?

> > I don't know how to interpret "ranges".  Can you supply the dmesg and
> > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> >
> >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff window]
> >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> >
> > > Question:
> > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
>=20
> That means the nvme controller didn't provide a response to a posted
> command within the driver's latency tolerance.

FYI, with the help of pci bridger's vendor, they find something interesting=
: "From catc log, I saw some memory read pkts sent from SSD card, but its m=
emory range is within the memory range of switch down port. So, switch down=
 port will replay UR pkt. It seems not normal." and "Why SSD card send out =
some memory pkts which memory address is within switch down port's memory r=
ange. If so, switch will response UR pkts". I also don't understand how can=
 this happen?


>=20
> > > 2. How can this mmio range affect nvme timeout?
>=20
> Let's see how those ranges affect what the kernel sees in the pci
> topology, as Bjorn suggested.

Ok, will add details in another mail replaying Bjorn.

>=20
> ##############################################################
> ########
> This EXTERNAL email has been scanned by Proofpoint Email Protect service.

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
