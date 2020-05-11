Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798131CD6D1
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEKKr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 06:47:27 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:33376
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbgEKKr0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 06:47:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8SH52CsP5kc/mt4SIHjtpgGxgKw+SpB9Co9KBraJL1ZgEDupTA7PLn4oYCAh1MNHVISzlCgkhdL1NRyf+/CGfLNtucsdnIt3v9IMgd2xh5dYp8ujt8GSQybGE/YQNSIiBVqWcXHoMB3w+3iyULH8NTg/A49jw5JBKvt6O83gf/PQEJ/hxQqJJ228hknt1FTfmyPalYvWFm5xpB7SB5dJpi23jisXVeZ67z0ZWMdP87SE93v+2tS9a+YM+3kuu8nmejystsB/Ymr337bc2ZEw9VgIN4gC3OlTVCSXedBf4z7/zNpbdNIPDtlJgptBEniV8CJxRd1u2LtrJL5GpyUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmJr8PlZ65wEktyFUqF1qZsSkM5wYEXgGaFXd+j9blQ=;
 b=meszIi0omXXQ9m0L1IpdPlRgpP3zt58KLkT2cLY4+F4ix/rJrzbhOOBALkoE08BzCG71VlpTcdPSTg+M1+OHOjE4rlkIZnMjns8m0NZBUmlI3smJBcOoXjuVC/PCp5M4bZuGBCAw+27/uGnc4BQTNvVALc6Qo3OzWhnzzKSlfyzrQoiFiV6JqgKZF0Kg9dOVdRFlGWJlo2Qs6OM/3q1B879srXbeQiZDOIKe09A97/X0QVOz6B8V6/p0td3+yV0OGqYeNjzHIBtk6oD0tQ4/uH4290Zf4QuSBu16Kn6wLCcXJj0weV4+tSs7Hbyv+jXgz443qcldOKV/K1pPiPeUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmJr8PlZ65wEktyFUqF1qZsSkM5wYEXgGaFXd+j9blQ=;
 b=grFiAO6IBnRvx01QtJUtv5wpgjW+Rux93c++x2/3Vj0kPgSMRg4K4l7I4pvkiWqjjmfllpqJXuTR1Ar5P2UgCVuckEyBaS2dNyOZEEe8dqug2hyhDCIz1Wbt788vjo40FSfYekezohJC5vQpdx3/mf4khmULCoqcOvm0dnnYg1E=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4583.namprd02.prod.outlook.com (2603:10b6:a03:12::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 10:47:23 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 10:47:23 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWJGcFkx3tnPS0S0KeSN8z5DhGVaidCHuAgAWxoTA=
Date:   Mon, 11 May 2020 10:47:23 +0000
Message-ID: <BYAPR02MB5559A6485ECA87362EF6A84AA5A10@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1588852716-23132-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200507194939.GA21050@bjorn-Precision-5520>
In-Reply-To: <20200507194939.GA21050@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06bee935-03ea-425b-5e5a-08d7f598b032
x-ms-traffictypediagnostic: BYAPR02MB4583:|BYAPR02MB4583:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4583CED78B1FF1F8817C919AA5A10@BYAPR02MB4583.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMA3r1Gjgr9HPXNlfrrVYVlMAbfaBkRo410jkpPS1K+zibHHMFbYOLHSbqZK26cI0IrY/A9uf52vnkis5NTyxTfMIJuMNXyBdaCMEijdKRglts979MlYYGIVPgI3Mv/XYgHcX4lbOH9xW0rQtvgiNlPLB9P4ys67jIzTKZ/HiRWMaPJZztxjC6UPBGp7mdGGRZrOt+tg3V+Eodu/UU0JsY8qpzJstkNRkT2yZwwXfkpBm2ydq91oxKFYYcFH70ZbPN83mUDzEIYPjdWUMp3/Qs2nR8yxaAUyfphk8NKxxYEzU1FwSu94nAcdKz3Mp2jx2urx5pcAO4I1jEYP+yscDdk6DzoLc1zKZvzIZvAejKnglhJ8Wjz/rIVzI7KJ8IQHzTTKwrXwVRDHjwN/ZPmRHXb9g5D9oMpJElq/Ln615ZQXYu89sPbTi8l1uk+lydOULHgbKDYLUfZ1Y5y5hGLDROQCYISRJx9MxyqlFs6uHqKdZeHuLj8Ts2e+BnqJ+bh1NRCz+t9fWPf9KUVdzcCCx7uInFNTOTvfqktwvf1Za6t1k3SvPFszjUuUMVRxlXx2sR5hQL4RPAvSQ6AmtcyeaTpvqRo3V2l/ZT3K5c4z2Jk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(366004)(346002)(39860400002)(136003)(33430700001)(5660300002)(186003)(54906003)(4326008)(66476007)(66446008)(64756008)(66946007)(76116006)(66556008)(33656002)(966005)(107886003)(478600001)(8936002)(26005)(6506007)(7696005)(52536014)(8676002)(2906002)(71200400001)(316002)(6916009)(55016002)(33440700001)(86362001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 3OaVBRrhNDRU1OegosR+e2P/N/stsaahTe+7omglP+juR6oVoERB7Z6jVQdSwFiuWpxFfHShuk6Ll6HFPlJ1EGsx5WGbyiLOz4Z96Y3oa24imgc3h3KjvbF+BtXCs6ebAsnIxXabzSsp5wZxE1u4vhBm8HHDyLsVF1t6cAQtSlVbdK1s2kVLJn1Tbc8PZ9v+aRG1eQUTi9eLnvFU9lCoJ5bE3DVn22C06hnrgzcQRtTSM8e31DYPqTL4eg3ipQlsT0iX/yAU59N+JI0J5d8+rLMiD/xzwCYu3EMUqRUo6HT1fZRHijWj/1meUbwsMuC8VGbf9BebjMaTRXMgUJf41kHQCmUCo7BXaV1vTtiLzRVFSRd2J80n7rgeXYxf98ZGLCAueL1xJzoLOhldYrHiE7y1USGM5jpEL/0J1srCrPPj6gHCVfK+ranhlX+86qREI6TK+lb5FJthVpI/ChEmcTvOWbxAimTa0p9E3BnxZkE1JjoDuXEn+RQ46F/t49FI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bee935-03ea-425b-5e5a-08d7f598b032
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 10:47:23.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stjtG/I7zIepazcgZ14ySYzgibw9vrWYtg20032lXG0Qd/rTeMhG6ep/8LmKZNPNGpkfPj+el1/ESU6dAhC1RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4583
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v7 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Thu, May 07, 2020 at 05:28:36PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific interrupt line.
>=20
> > +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port
> > +*port) {
> > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
>=20
> Almost all of the *_link_up() functions return "int".  I don't know if th=
ere's really
> any benefit to using "bool", but if you do, you should probably return "t=
rue" or
> "false" instead of 1/0.
Hi Bjorn, thanks will fix this.
>=20
> > +	port->irq_misc =3D platform_get_irq(pdev, 0);
> > +	if (port->irq_misc <=3D 0) {
>=20
> Use:
>=20
>   if (port->irq_misc < 0) {
>=20
> See https://lore.kernel.org/r/20200501224042.141366-3-helgaas@kernel.org
Agreed, will fix this.

Regards,
Bharat
