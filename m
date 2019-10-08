Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3868CF4FD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfJHIZf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 04:25:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62192 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728866AbfJHIZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2019 04:25:34 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x988FcI0007503;
        Tue, 8 Oct 2019 01:25:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=aTs0NM8gEkTongm8zDqDK+Xvfu26iuNyD2dHN1k5TmY=;
 b=VZXJ/KS1dHmGVuj9j9s1qmB4Jcs+MwmCFF1guKqgN6yNs8wQzC1lo9odQXsYeS5oFWUn
 oRWyRxGaP3rIOMF7dsYCyyAdq61xZAvKkCu95vDDSGQd9faJ3L2m7nxahMDZT/4gB/1r
 DoG0LyX+qNfWtMjeEEpP/35O0+XygDtBNkHEaJQZQspHa+D4qTeelSwOcTcb/3mGpJZe
 OYBA0X3vyMLnveJ/aAFGWhWmltSSJn6qeqXSA7qJ8i92koeQKnwOU3PWN1BGsxGLdfO/
 9ZKJ06l7bAnD1VmpD6eAHAAcOnqUBaShqmsfieXLDG0ygbqe/ckGxKRzR6sDClWpKjKp Zw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vetpn1j40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 01:25:26 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 8 Oct
 2019 01:25:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 8 Oct 2019 01:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEg5F+lQhv1yBkD0X1p7U+4isKb2Y0dgTOPfUc7y6Zx57lxvobqzG12waD7xK012ys0CO5e8S8co+2mGWQzFvBWmcBlylUr4Ch4bsmyrV/hNsKhR9ngSuLIHuI3Bo2fgisAQN7rMnOtPMSfhLPG8wvs1sOCAswcA9F5xGbo/I4x5qQ3AeaUmh0Ws50+6WR0T2DKIDzaE4P8qSXqCPu0wWu3pQ3X5XaOmtIDpogmS3d9rpb+rMWJCKvlW8exCpUPo4a3DAjy2k8xmzpTl0BghfBqyCfhBuENJ8uI/G+EbYtPDSbGy442FfYZfMlGkYz/Q8i6C1/hAV3TgJbT6a3+iZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTs0NM8gEkTongm8zDqDK+Xvfu26iuNyD2dHN1k5TmY=;
 b=ZH/bZX238Cg99JBfU1bSnnfF6j06KIavIb19nj1n3FsYmOHTW6fhMConUV0G9+iKUyjZq8wGDm3w9VDhipqYMB4zFh25uShujiT5fEumFdXZUWhvEBoxIR8HFIp5zuYEpxDGZAILJwVBOGytENktpbeP+CqbLzIehAbFTjzqQrmJmJVOKSt1oyYrpFxFyGCxKWtkLWsSdVoD8zpsBZqANXXZX9RCmZFpgYECKE7p8IKb+h/jE+7ohrPME89ij76hb/mgTsK4tFG9ysowqfdCWuzpt60czLb1RMcbDWV/5C72L+L1kmwTzi0XU4EKLs2zMjkkD1zbAKF3DIjojnbNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTs0NM8gEkTongm8zDqDK+Xvfu26iuNyD2dHN1k5TmY=;
 b=dpLRQeibkLDXGte6FZxtXGN5AOQGp4UTJMgpRjogWFzBS+eLeWs/FSKh2g3oy802NG14D2VbCR2QAnW55YFsG2YlZ4UMCqPf01i+cpR/WXRfo32WCsPPIrMiiVmKUm4QLfXWctv8bCRouwbjAfy/PEl4f0QJ+B3Ev+Pgrpj9gZw=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.237.10) by
 MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 08:25:23 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d16d:8855:c030:2763%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 08:25:23 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shannon.zhao@linux.alibaba.com" <shannon.zhao@linux.alibaba.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Topic: [PATCH] PCI: Enhance the ACS quirk for Cavium devices
Thread-Index: AQHVd+WyQA/rX9/rek2UxMmqvqYW56dK6YSAgAWKgoA=
Date:   Tue, 8 Oct 2019 08:25:23 +0000
Message-ID: <20191008082515.ldm2i7j4syuzampr@rric.localdomain>
References: <20190930232041.GA22852@dc5-eodlnx05.marvell.com>
 <20191004194813.GA76466@google.com>
In-Reply-To: <20191004194813.GA76466@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.208.96.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ed66596-c036-4e58-43fd-08d74bc91035
x-ms-traffictypediagnostic: MN2PR18MB2637:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB26378DCDAFC12769E2197CB5D99A0@MN2PR18MB2637.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(26005)(66556008)(6116002)(66446008)(64756008)(66946007)(3846002)(66476007)(4326008)(386003)(6506007)(2906002)(53546011)(256004)(7736002)(99286004)(6246003)(107886003)(76176011)(25786009)(305945005)(71200400001)(86362001)(52116002)(71190400001)(186003)(476003)(9686003)(478600001)(6306002)(5660300002)(6916009)(316002)(1076003)(6512007)(66066001)(81166006)(6436002)(102836004)(486006)(6486002)(11346002)(8936002)(14454004)(229853002)(966005)(81156014)(8676002)(446003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2637;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yQynt2oU9/QMJxtaHCmPS8CYsgMikaYtWT2G/Ni2BpOVRayOaXDJFrBjc/XEH1tlkVzw7T9hpfsWslOhAGD1eb1XWz/zcwq6Y5NNXylO8DsDup4WGkZ9jwJ12E6cNk9ttduflsDgiRge2VN/pp2uobB2srWOK8Ygst7VJIntPbyD65dtDDqrnfZazM54JPfoNVXSYHaVxgTsWkwyPNwmGuQp4LUJAMHug/TNBXnRclYhQkkVEE6wnCWxJGJPmv4CL2nMM+t4TsxSTlI1ENWlcl60h+XAosA65BB0vUIimT7HLSYKiFCC5P/RDXwnwSTnib75xAuIylFwYEfB32f95RIOaB86yQ8zJWPv8eHzyTY+N/Dd7sHI9DaBjpSrZZ+2ZL1AOiDw5OIW5yieNMlctRbFESI0Z8546dkyCVI79Jg/xVJCBbwF1km6Qv5TgBUmwCMDO7NKfoz1hkltFVdeQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C5BB84DF9C195D4981F30B73E71339F9@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed66596-c036-4e58-43fd-08d74bc91035
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:25:23.1079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxQGRHsbf7NaV7ShPkAM3XQuCCjSvGe5Ss0NyPYop8AYSQ5kMo9p6VOvKKb2PV8+iyEG28dLxAFz+Z3frWHdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2637
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_03:2019-10-07,2019-10-08 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 04.10.19 14:48:13, Bjorn Helgaas wrote:
> commit 37b22fbfec2d
> Author: George Cherian <george.cherian@marvell.com>
> Date:   Thu Sep 19 02:43:34 2019 +0000
>=20
>     PCI: Apply Cavium ACS quirk to CN99xx and CN11xxx Root Ports
>    =20
>     Add an array of Cavium Root Port device IDs and apply the quirk only =
to the
>     listed devices.
>    =20
>     Instead of applying the quirk to all Root Ports where
>     "(dev->device & 0xf800) =3D=3D 0xa000", apply it only to CN88xx 0xa18=
0 and
>     0xa170 Root Ports.

No, this can't be removed. It is a match all for all CN8xxx variants
(note the 3 'x', all TX1 cores). So all device ids from 0xa000 to
0xa7FF are affected here and need the quirk.

>    =20
>     Also apply the quirk to CN99xx (0xaf84) and CN11xxx (0xb884) Root Por=
ts.

I thought the quirk is CN8xxx specific, but I could be wrong here.

-Robert

>    =20
>     Link: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.ker=
nel.org_r_20190919024319.GA8792-40dc5-2Deodlnx05.marvell.com&d=3DDwIBAg&c=
=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D8vKOpC26NZGzQPAMiIlimxyEGCRSJiq-j8yyjPJ6VZ4&m=
=3DVmml-rx3t63ZbbXZ0XaESAM9yAlexE29R-giTbcj4Qk&s=3D57jKIj8BAydbLpftLt5Ssva7=
vD6GuoCaIpjTi-sB5kU&e=3D=20
>     Fixes: f2ddaf8dfd4a ("PCI: Apply Cavium ThunderX ACS quirk to more Ro=
ot Ports")
>     Fixes: b404bcfbf035 ("PCI: Add ACS quirk for all Cavium devices")
>     Signed-off-by: George Cherian <george.cherian@marvell.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: stable@vger.kernel.org      # v4.12+
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..4e5048cb5ec6 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4311,17 +4311,24 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *d=
ev, u16 acs_flags)
>  #endif
>  }
> =20
> +static const u16 pci_quirk_cavium_acs_ids[] =3D {
> +	0xa180, 0xa170,		/* CN88xx family of devices */
> +	0xaf84,			/* CN99xx family of devices */
> +	0xb884,			/* CN11xxx family of devices */
> +};
> +
>  static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
>  {
> -	/*
> -	 * Effectively selects all downstream ports for whole ThunderX 1
> -	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
> -	 * bits of device ID are used to indicate which subdevice is used
> -	 * within the SoC.
> -	 */
> -	return (pci_is_pcie(dev) &&
> -		(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT) &&
> -		((dev->device & 0xf800) =3D=3D 0xa000));
> +	int i;
> +
> +	if (!pci_is_pcie(dev) || pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT=
)
> +		return false;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pci_quirk_cavium_acs_ids); i++)
> +		if (pci_quirk_cavium_acs_ids[i] =3D=3D dev->device)
> +			return true;
> +
> +	return false;
>  }
> =20
>  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
