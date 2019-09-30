Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75104C2AC3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 01:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfI3XVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 19:21:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727621AbfI3XVC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 19:21:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UNKt39019084;
        Mon, 30 Sep 2019 16:20:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=vSpZGY4Rt4DhMZyDpVOBVqK5fEdztH3D7nzpfU9Gn+o=;
 b=x6sJG/LsE5EUAyKNz3MHZDTnrr5DntcN9gia2lkNfjcf0gA/czXt3xhgzJeWZwrU+tGo
 qzWXH9WLihdnWF2zCvr4EHzHXszZH3pZqYqdWFW4DD+hbfkU+92Nzwmczdn9HDJtu/n5
 UOEKGP83dFulUBRrZ48noWZ/XAeQvdU103QFatkE4XLLKZfmI9FZcFJWf1Hgp6UW+r6n
 lBGSBZNjpZSj0ojtiV3VGC/EdcTZ2PnqBgM3cZqPxaEItyj9uLWIM0Ft7z4bvUVkRmKy
 oOYwY+bzsO35IPLQJlrQptgd5TSAEpjZqdA40Y8XWP8a9UsqHCfg5K3kAiiZO120foVo dQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2va71mg5fb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 16:20:55 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 30 Sep
 2019 16:20:53 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Sep 2019 16:20:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P46oc5zVyHTOWHxIXBcPsOV9HZcmXIoL0oRBRRgJUfQPqArtvlTEuAitbGRvSbjerH5MVADWR5pHfbNHwQvV/4isdzk6IKJHoA3q/RXv+931tMy7bOCYkkA/4s8QNFNvQEPGsmgJEvy2lCyFcWEtJ4csBt5oI4DRXdWo2tLgN+rhMy73WoaD7AT3CFY9hwxDjTZXsfYACywzediX0R0wtDcsuC5rdlTA14XoNRuKkeDxT1GiY2UN06InLI+SEz962jPvEX1SBbGxeybP4OGU4CflRB7jROgPS1SVnawbu6+fkBSU/kloCCfQPBZzI8+4BWCBRWAUgaVykJkZoICF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSpZGY4Rt4DhMZyDpVOBVqK5fEdztH3D7nzpfU9Gn+o=;
 b=DdGgIlwoHCEYOIPSMAiA786supip7LlOJmsnAabOzSleB5XxsiMARFu5suSWdkx9cL0tC4e2OE1vDGD1vchONaRpmHpvX4PmktDxE6RNQEc7xQlhAE+SOFVASXuUdcxf/J6DXSb7R3eEQrfBV8228TFbHl7oZC3wrhBSxV9OuqJ2PSAlPacJ2DsQPnpMwgexDXWWGQaaynkvr75EPUuJ3mHjgFfN6XpcWxcb3wwTLDhypkYbqntHs4N23OZCbnpcVC30KtKc0st7ILSFTTUDSGhUOodvY3C1MyWoMUYDtjJApusOMT+kNo+YnJ0DpS8ZfYDlwzOKW5zCVrWEVRKdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSpZGY4Rt4DhMZyDpVOBVqK5fEdztH3D7nzpfU9Gn+o=;
 b=ee4MB0Z8+F9TtT8jLP1Cu2N1jihc7go6GlhGb3LXQHddTSA5hQDyPr2upaT9VfKE89yvEg346Zzd9+pWYHxATfYl/u5IWur2inamXmptIOi3CJ2y+wWPcbMqxNvMTcOAdJOSmByLg8DYtE9RnsS1HQJsYM0ZJvsyVS8cNQoETgw=
Received: from CY4PR1801MB1895.namprd18.prod.outlook.com (10.171.254.153) by
 CY4PR1801MB2054.namprd18.prod.outlook.com (10.165.88.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.16; Mon, 30 Sep 2019 23:20:51 +0000
Received: from CY4PR1801MB1895.namprd18.prod.outlook.com
 ([fe80::95d8:1a9a:a3b4:616b]) by CY4PR1801MB1895.namprd18.prod.outlook.com
 ([fe80::95d8:1a9a:a3b4:616b%7]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 23:20:51 +0000
From:   Jayachandran Chandrasekharan Nair <jnair@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     George Cherian <gcherian@marvell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        George Cherian <gcherian@marvell.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>,
        Manish Jaggi <mjaggi@caviumnetworks.com>,
        Robert Richter <rrichter@marvell.com>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Topic: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Index: AQHVd+WyQA/rX9/rek2UxMmqvqYW5w==
Date:   Mon, 30 Sep 2019 23:20:50 +0000
Message-ID: <20190930232041.GA22852@dc5-eodlnx05.marvell.com>
References: <20190919024319.GA8792@dc5-eodlnx05.marvell.com>
 <20190930203409.GA195851@google.com>
In-Reply-To: <20190930203409.GA195851@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To CY4PR1801MB1895.namprd18.prod.outlook.com (2603:10b6:910:79::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57e0ed37-f26d-4efe-7c7e-08d745fcd526
x-ms-traffictypediagnostic: CY4PR1801MB2054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1801MB20542C006F2CF9BB7C59B785A6820@CY4PR1801MB2054.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(14454004)(8936002)(81156014)(6916009)(7736002)(71200400001)(66946007)(71190400001)(64756008)(66476007)(66446008)(316002)(54906003)(25786009)(81166006)(6116002)(8676002)(66556008)(478600001)(305945005)(3846002)(6486002)(229853002)(256004)(6436002)(14444005)(2906002)(99286004)(107886003)(5660300002)(52116002)(6512007)(66066001)(102836004)(26005)(33656002)(86362001)(4326008)(6506007)(486006)(386003)(76176011)(1076003)(476003)(11346002)(186003)(6246003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1801MB2054;H:CY4PR1801MB1895.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hATioA8Mf3IInbaFmpLQFDdZwtkfENwIjJG85e9O/LOxuUyhpKiYjAa8lUScXZ+5Cva3UqO0C3q0XDN5NiEMUsBHL5p83Ivo7M0Z2ew7Jww7UYvJBPGtGrODGoDyTOADyVoWWKlbBHL4ZbLaEHkV3Oq0X5SV1CHHC4LvVlrizpQf5RFelqS803NkN0H2/m6gereyIajM53Zc7BJvkzBvro8NntXKqTU3J/0bBjpm84vmf+5dPMDQtQ1Tge6Vnop246JdjCsvr0wUeeLWYQJfmbjKNO/iEqaIzONOrT6fM4JJRtZg1QPw2uKzFUc1aVTcofKiZevgTsFmpJYCT1UuFdQH3TG9+yhuCNXHCMaOrSuSWOjKQzfHCDZOeQIwwo7qbJ0zz8iUacpG4s2zoVgA3jGJ+wMeTMcRDyXRQgLFT6s=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38B3535B4CAB6C48A52C23912428D2D4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e0ed37-f26d-4efe-7c7e-08d745fcd526
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 23:20:50.9756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qq45HuoHAAlc9TWRhmkAcONhMbpM5yT/xBXyIXdlSAsxRG0EaLko14+nj9I6Gu66OXv5sPr75U3frV0Ws/LkaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB2054
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_13:2019-09-30,2019-09-30 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 03:34:10PM -0500, Bjorn Helgaas wrote:
> [+cc Vadim, Manish]

Manish and Vadim are no longer with Cavium, adding Robert for
ThunderX1 and Sunil for Cavium networking processors.

> On Thu, Sep 19, 2019 at 02:43:34AM +0000, George Cherian wrote:
> > Enhance the ACS quirk for Cavium Processors. Add the root port
> > vendor ID's in an array and use the same in match function.
> > For newer devices add the vendor ID's in the array so that the
> > match function is simpler.
> >=20
> > Signed-off-by: George Cherian <george.cherian@marvell.com>
> > ---
> >  drivers/pci/quirks.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 44c4ae1abd00..64deeaddd51c 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4241,17 +4241,27 @@ static int pci_quirk_amd_sb_acs(struct pci_dev =
*dev, u16 acs_flags)
> >  #endif
> >  }
> > =20
> > +static const u16 pci_quirk_cavium_acs_ids[] =3D {
> > +	/* CN88xx family of devices */
> > +	0xa180, 0xa170,
> > +	/* CN99xx family of devices */
> > +	0xaf84,
> > +	/* CN11xxx family of devices */
> > +	0xb884,
> > +};
> > +
> >  static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
> >  {
> > -	/*
> > -	 * Effectively selects all downstream ports for whole ThunderX 1
> > -	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> > -	 * bits of device ID are used to indicate which subdevice is used
> > -	 * within the SoC.
> > -	 */
> > -	return (pci_is_pcie(dev) &&
> > -		(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) &&
> > -		((dev->device & 0xf800) =3D=3D 0xa000));
> > +	int i;
> > +
> > +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PO=
RT)
> > +		return false;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
> > +		if (pci_quirk_cavium_acs_ids[i] =3D=3D dev->device)
>=20
> I'm a little skeptical of this because the previous test:
>=20
>   (dev->device & 0xf800) =3D=3D 0xa000
>=20
> could match *many* devices, but of those, the new code only matches two
> (0xa180, 0xa170).
>=20
> And the comment says the new code matches the CN99xx and CN11xxx
> *families*, but it only matches a single device ID for each, which
> makes me think there may be more devices to come.
>=20
> Maybe this is all what you want, but please confirm.

There are only a very few device IDs for root ports, so just listing
them out like this maybe better. The earlier match covered a lot of
ThunderX1 devices, but did not really match the ThunderX2 root ports.

This looks ok for ThunderX2. Sunil & Robert can comment on other
processor families I hope.
=20
> The commit log should be explicit that this adds CN99xx and CN11xxx,
> which previously were not matched.
>=20
> This looks like stable material?
>=20
> > +			return true;
> > +
> > +	return false;
> >  }
> > =20
> >  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)

JC
