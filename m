Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4869B75423
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfGYQfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jul 2019 12:35:10 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:6228 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729364AbfGYQfK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2019 12:35:10 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6PFxcPn022218;
        Thu, 25 Jul 2019 09:35:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=zVqy5QaPbbRnO2AOLgy4rE7ZOLCEbzX5XU9gZQTW7DA=;
 b=xWWS8Z3U/7J0YvL0VqvLrAEriFwSLjloSB5HIk0rf1NF0qwgBzExVUh2nvyJFW0X0pri
 5LGAkJEKQBz2k+jTWrtMa48i7PyaFt7rxkBpRom39Pngz2KlYffsco+8gAZvSIG0bmlc
 yOya4L+0DwMWeA61PQ4mLgPOUYRsSEpDOhJtAWKvY8lv/bfeDdqODYzVozVunXS03R+D
 8xy3lehZHDvv4UN2Vzp+sDmyzT3oXL0sll5s+ZKRRy36c8eVEcDlWO5gali57t7ZGl4x
 suSjIK2MN9jT+UKtyLP5FxlKxL8WwSqAcVib3oQmzcpFtINKh9T2v4mVOBtJYyKlkSam Bw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rjeyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 09:35:06 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 25 Jul
 2019 09:35:05 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.53) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 25 Jul 2019 09:35:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxYDzULJFp4m4y4ZxOFOJrOBTfFwIYTqtldaWA65+YPhcV/gMFBCoYGmpMngaI5T3th0IMfnzqDdS/6XEVRIkYb0nQasaKQgCMC2dVQNbCHO63Rn6eZkU8SrR+jen6DRXcRIiqDTNONWV7lOBVt/FupIqL1QmmLC6wc2SKtpw2tyGEY0OzKH2Ly+UhflNg2oZJXIBhiILGGbkaQ9clWdS+eaOQEzjoccPMif/ooD7wwoN64U5/uxn+CojN2QrDoZpOuhnlvS75cA4jiVMquD6VpwC6z6Mhozhir6ESseYTlNajcVV7VnO9/EXUUfDtaA/DJkmpc7OHuo1xUIFaJo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVqy5QaPbbRnO2AOLgy4rE7ZOLCEbzX5XU9gZQTW7DA=;
 b=mBA2fn+b56jh3SLzH+o06s/yfwm/W3llGzekCUZuXvh12nigJ2Qg0ZJkCDKXtoEtq8G+DfPi8o9zLvGJ3stLauZKWmZC6Q8f9mV72LMDeuda3H+Q/8pgHvFpZr/GyYUHvrA2d0nR1vY4FlqKvg6kx7apw8UmGrtkuVu+nJUPfuylhWGJvRB853G5xNhPOIB3z5JD+HiHg+Ek3zRAotvMZwNRmxkzGsoOMooGnUdpnZWKB2BLE062+yCFoMHjUzp3qCnmtaZ3QTB5toMyPgHOceKkDAy/M/hvzReun5MC9pds0t4tpyNcVhJfNGg/cK6pBK/aB6fF4uelRuXNF2KUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=marvell.com;dmarc=pass action=none
 header.from=marvell.com;dkim=pass header.d=marvell.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVqy5QaPbbRnO2AOLgy4rE7ZOLCEbzX5XU9gZQTW7DA=;
 b=QEQFNhQW21gB/voYb8at4nYEd+YmXrmSH03KXrBRZP08RUoN3qCLx2BK1pPGoRZGugfni2fcjl6aom68/lLwg+BcqUZSe0c4Rff8RYM8Nv6hQrImefDRPpNP2hh5jP72+tgl+FcXDAP69p7tEpGnhce0E/eQyrbbXNTROZ/RaGk=
Received: from CY4PR1801MB1895.namprd18.prod.outlook.com (10.171.255.22) by
 CY4PR1801MB1878.namprd18.prod.outlook.com (10.171.255.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 16:35:02 +0000
Received: from CY4PR1801MB1895.namprd18.prod.outlook.com
 ([fe80::c0db:b35e:8b2f:c1e7]) by CY4PR1801MB1895.namprd18.prod.outlook.com
 ([fe80::c0db:b35e:8b2f:c1e7%6]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 16:35:02 +0000
From:   Jayachandran Chandrasekharan Nair <jnair@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Shannon Zhao <shenglong.zsl@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Guiping Duan <gduan@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium ThunderX 2 root port
 devices
Thread-Topic: [PATCH] PCI: Add ACS quirk for Cavium ThunderX 2 root port
 devices
Thread-Index: AQHVQwboV84qzPxVD0yOX55pKvzUPQ==
Date:   Thu, 25 Jul 2019 16:35:02 +0000
Message-ID: <20190725163453.GA28724@dc5-eodlnx05.marvell.com>
References: <1563541835-141011-1-git-send-email-shenglong.zsl@alibaba-inc.com>
 <20190724185535.GD203187@google.com>
In-Reply-To: <20190724185535.GD203187@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To CY4PR1801MB1895.namprd18.prod.outlook.com
 (2603:10b6:910:7a::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d2b6679-bb3a-4fbe-94c7-08d7111e0adf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR1801MB1878;
x-ms-traffictypediagnostic: CY4PR1801MB1878:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR1801MB1878095CDD9FB5CBB81D7487A6C10@CY4PR1801MB1878.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(189003)(199004)(6486002)(305945005)(71200400001)(71190400001)(81166006)(81156014)(7736002)(33656002)(4326008)(2906002)(99286004)(8936002)(25786009)(256004)(14444005)(229853002)(3846002)(476003)(478600001)(6116002)(966005)(102836004)(186003)(54906003)(26005)(14454004)(86362001)(6916009)(446003)(11346002)(66946007)(386003)(6506007)(486006)(1076003)(316002)(6306002)(8676002)(6246003)(53936002)(107886003)(6512007)(76176011)(52116002)(66066001)(5660300002)(66476007)(68736007)(6436002)(66446008)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1801MB1878;H:CY4PR1801MB1895.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O9kEdx9HLIQ1aMye9Z7aHjfsP0Fv68Rxp6CM2C4rvlcN+bB8Nnd4xowT58WwAZoL81kXsqfsObDG31G+3FiHjmXNrZm/COWeRvkahPMlz0Y9apzWJkJrN6Y3xLp7IEEETxDksO4kycsqkbDGckNYU6m1blZHUU8DFA/uUYyLUOj1APKbwUPzocadxTQK871Wdc14ozXOJI8516Dm2EZH3IES6BfUbP9RbhT+DWBUYqzWE5w9hSuW/CfREigzI0ATaqLSz1Ei2Tp90ahnF6GdLVPVzK5JYVIrrbjIMIhw4p244rbVKxFxjitKwTne5NLJGj3LiAC8HPqyOdi7q9pkx5gwZYXRxAnnljLye9SanktRHrZOrD7l1rR8OKw0q11UDObwXLJq+m+Ysy5snq5JNExeO2WKDehfs+klKqr53uM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8EDB2E46CBFEFC49B3209104B6E48DC5@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b6679-bb3a-4fbe-94c7-08d7111e0adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 16:35:02.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnair@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1801MB1878
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-25_06:2019-07-25,2019-07-25 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 01:55:35PM -0500, Bjorn Helgaas wrote:
> See
> https://lkml.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.co=
rp.google.com
> for incidental hints (subject, commit log, commit reference).  Your
> patch basically extends that commit, so the subject should be very
> similar.
>=20
> On Fri, Jul 19, 2019 at 09:10:35PM +0800, Shannon Zhao wrote:
> > From: Shannon Zhao <shannon.zhao@linux.alibaba.com>
> >=20
> > Like commit f2ddaf8(PCI: Apply Cavium ThunderX ACS quirk to more Root
> > Ports), it should apply ACS quirk to ThunderX 2 root port devices.
>=20
> s/root port/Root Port/ to be consistent
>=20
> > Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
>=20
> I suppose this should have the same stable tag as f2ddaf8dfd4a ("PCI:
> Apply Cavium ThunderX ACS quirk to more Root Ports") itself?
> > ---
> >  drivers/pci/quirks.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 28c64f8..ea7848b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4224,10 +4224,12 @@ static bool pci_quirk_cavium_acs_match(struct p=
ci_dev *dev)
> >  	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> >  	 * bits of device ID are used to indicate which subdevice is used
> >  	 * within the SoC.
> > +	 * Effectively selects the ThunderX 2 root ports whose device ID
> > +	 * is 0xaf84.
> >  	 */
> >  	return (pci_is_pcie(dev) &&
> >  		(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) &&
> > -		((dev->device & 0xf800) =3D=3D 0xa000));
> > +		((dev->device & 0xf800) =3D=3D 0xa000 || dev->device =3D=3D 0xaf84))=
;
>=20
> I'm somewhat doubtful about this because previously we at least
> selected a whole class of ThunderX 1 devices:
>=20
>   ((dev->device & 0xf800) =3D=3D 0xa000)
>=20
> while you're adding only a *single* ThunderX device.
>=20
> I don't want a constant trickle of adding new devices.  Can somebody
> from Cavium or Marvell provide a corresponding mask for ThunderX 2, or
> confirm that 0xaf84 is really the single device we expect to need
> here?
=20
We are working on a patch to fix this quirk to handle more Marvell
(Cavium) PCI IDs. Ideally we should be handling ThunderX1, ThunderX2
and the Octeon-TX families here.

Adding the folks working on this reduce the churn here, hopefully
we can get all of it sorted in one patch.
=20
JC
