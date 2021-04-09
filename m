Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19674359860
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDII4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 04:56:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:49743 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDII4O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 04:56:14 -0400
IronPort-SDR: epdusYrUqQZ6EFueaVnvCsZJ0n5gEgUThsaCWbtQyNYcDE5S8iKSHp3q9EI2QSeSBQVUa5MsEr
 1oFn49ZAo6yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173200032"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="173200032"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:56:01 -0700
IronPort-SDR: diwBal+VNirmZpYNOpdkQahq8CyDYs0AyeoGUVgufIWbvR1QM+UYNuSxQSQHjAbypd305N5vBv
 SVGRTQsGIq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="419460456"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 09 Apr 2021 01:56:01 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 01:56:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 01:56:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 9 Apr 2021 01:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwXnPP4Vgb7o0+OCskt7jCXetCb92Ro4Lu7yhhg19IKmag8QIrkYazpXV53xqBYKDAzjxoP2/MJnyhyosiXnqcCUJOptI9jI7uCy0QWpfXJhVV2y/oZdzpRg6sgja7cG4GTUlEHg4qqf5glFfn5BOFum83+UGsCr2LpZUY3X6Fwjsnbx2NuGP/6hqoXpDPx521cCNM5xoQVk4sNBLRlBHDu+couq7M7Yfwu8mHd8cqq/VapNEPYgWgtBvkciBc7tLfbmXmmNPdMGFPnWMipAI+WJxbYAbyIpEmcXgnnsRzvcR2DXOHCcVNZ/s4u3k4kGz81CsffRJJ4F4jSa36jifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgLBsMV9wME50D+8AQP1DWtU3TXKuTaAAudrxPIvOog=;
 b=E6TVsYu5mz6b8ie5h6rwWMh2iBY16u+JJ1AD92pE5YArVsEeIqS1mNoyg7Ct7c7T6xExmjto8mKYMKpkR4GjnAc2cisFDm7jOpDG3xUbeYJS6EbaPBPcnEbcDbEI0sWaqG2tPRcqDKt0xwLuasC+j8oBE4LzYGvDIRqQSipFhUR+hwUCsdbsgJXoyydZ8BgwD6ZZD6vz3R4kapC+bgZAN74Vv/ca8+u9IC/M8byfs+U8TMc1b23ls+XVvZNf60JSlaHtzcQE4X3raZ0BmZvHY7aFQ7QoI5i2yIaXQ0tKGZfamMRTzsOHhryjzw1vcswxMuRO5t7m0sk0YOtqmn5FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgLBsMV9wME50D+8AQP1DWtU3TXKuTaAAudrxPIvOog=;
 b=Pr37PGGAPNAa0eOnC4MxelbZMiFN+SIqwNjOjYc3X8A0u032O1FHMDyTEHJ0CUnPGPCj99bprpAXwgjgffLdURgkgGHk3/B4O6ueZmqXgJZXpqZy1MgS5wsYCL6LHkqE9BKMggZo3lH/gnKUxMiG10MQRz2lueGE4PV2eeQjViE=
Received: from BY5PR11MB3893.namprd11.prod.outlook.com (2603:10b6:a03:183::26)
 by BY5PR11MB4401.namprd11.prod.outlook.com (2603:10b6:a03:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 08:55:40 +0000
Received: from BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::297b:a818:3bfb:f897]) by BY5PR11MB3893.namprd11.prod.outlook.com
 ([fe80::297b:a818:3bfb:f897%6]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 08:55:40 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Chen Hui <clare.chenhui@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] PCI: altera-msi: Remove redundant dev_err call in
 altera_msi_probe()
Thread-Topic: [PATCH -next] PCI: altera-msi: Remove redundant dev_err call in
 altera_msi_probe()
Thread-Index: AQHXLRYPLvJ44PKbm0W1mCS0OXQ8R6qr4e1Q
Date:   Fri, 9 Apr 2021 08:55:40 +0000
Message-ID: <BY5PR11MB38933FD0DB01EE34D07ED151CC739@BY5PR11MB3893.namprd11.prod.outlook.com>
References: <20210409075748.226141-1-clare.chenhui@huawei.com>
In-Reply-To: <20210409075748.226141-1-clare.chenhui@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.153.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad50dd95-191e-40ba-17f6-08d8fb354056
x-ms-traffictypediagnostic: BY5PR11MB4401:
x-microsoft-antispam-prvs: <BY5PR11MB4401F589B7F06D868FAFC992CC739@BY5PR11MB4401.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xe2tcm13PN9GoEoT14DbeWXkp5fTf6Jqid6ep7IuVel5z0yo4Qmmiu8saBiPc2tdn2pWIFHGjOkg5A++B1E5+DCqUPCX2WbkuAJuozsJi3X9BnpRje+pE8oAVfsZ/f8bx8l0+v3q7T98hsPba9SgTCi2nRN9UjdOwiyz3tfa5PJSfWhna6JSGeK7fQqH3+oAUh0vPr91fuNOmSsVPAQI3YDsFjm8pxqbZPw6sFZaURHHZ6GvK9nGzwtXZ1PNerNgLRIfuyOuWb4Gr99Q5XOPPA/6fuHWGfUkLCHVmLPAuulikAkO0+xp6EKMElbPFkeL3dCH+b+TyVQf/ii2Yp24cRs1Kz82OjkFR6/gO7Vr8TExoTTzsvK6WVkYZuFaz5kn2WcgSJ3TQuBEG/3eeTmJKiyrdv++U9dHM6Ulp4658DDqq5DZVs+OfTlU+nHrPyxK/qiCN/WfGGz/NakjuJZrmdpfVS44UU0dxBqApKshDfGx6RIL7/rSg2Keei/FGVdOBwM6sIo4EOpSjDgTm3FOlTEZOW5esxMTuXfuodM7o3SlyldCk0XL/3NjXKy2QajbbuQ6U+r29FdwV5oZTtWQ2hD/piLiwe/JaIPeLcpCXMqAzksPI/YL48XgEaYW5DEZuNZi8UKUx+I7KoG379STXTi5aKGR1aAPMmzt5L+Ap9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(39860400002)(396003)(316002)(5660300002)(33656002)(54906003)(110136005)(186003)(83380400001)(4326008)(38100700001)(52536014)(8676002)(55016002)(71200400001)(2906002)(26005)(9686003)(86362001)(66556008)(66446008)(64756008)(66476007)(76116006)(66946007)(7696005)(53546011)(6506007)(478600001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2pyFNMM2WdcVW0jVCvAlIVoSmup2SPuCnmM9c7PR9jdhROKmFxc2DBhURdCP?=
 =?us-ascii?Q?oS5WBrCLXwFUOl+/Vs9Pe0cmyg0rCDZoPRXIzca1fM3vJhBG6vK/NgWPZa6v?=
 =?us-ascii?Q?2vBSp5IKb9D/W233JHbftx7gMKmRnNcNCNM6nOkzwn8SiALGjC4tp9r0KDGK?=
 =?us-ascii?Q?hEuJrAQ8LvR5A5uPvr2j3dublWx6QWfspE7EsQQFvdOTB7fw6X72gonDJZ8Y?=
 =?us-ascii?Q?zSWBh/1C9WG8n5t/jfx/Mdq/Sf85hpAPNNVikKyDPyEDBJiQEaNa9NOl89jN?=
 =?us-ascii?Q?rdCbvAMzfev8vMRyDrMOsPO4osUQkYL08b9NDl5vUxR5oaV3UZJOs5NPC/vr?=
 =?us-ascii?Q?Yk6yvKz/m//19Jf/5hoiSQiMAeCb8n/X8jUyTt/rZJoPDt8SZAt5sSEt70Wm?=
 =?us-ascii?Q?RrROkqOADJs7zb8HnbOnRmw6xqSE3VWw7z540kt7+GFdHEiiVD+BwVwL7sm0?=
 =?us-ascii?Q?cp8XMGNOYKExJr5BfKwlxDWWB/Gp2ngkX3qxF65Zl8v7EcjTggW49kHXafb8?=
 =?us-ascii?Q?l8AQrUGM9/P96uFixovIesjfIqv/MyeBbpTyLN7C/Wh21uqBWCQSUobb/gJw?=
 =?us-ascii?Q?Cze1snS+BnCFlqK33iPQvB0w43Cz1O83gpBH+dGVniiXYZFv5Gm02nGJP3N8?=
 =?us-ascii?Q?XuWlfDEe3FVdfRuj+dD11ue0N0+CnDlrH8lGegimqsM9scGTuTst/gyzGo7G?=
 =?us-ascii?Q?Z3DzhidPUuLrwBxaMT+ki4vlYgoWnz498jmEvwtqiqai1Rpl+a/Qt5Kko+YO?=
 =?us-ascii?Q?E3KO+ZiqG2/B0RJse4GiTiGfK7JC56mA2pnqlBKtUAdlBkn1wfvgtpOL9hke?=
 =?us-ascii?Q?tVqYqGot+/70WpL/rmhllKfldD/Qfyh42sZl5O+eNQpbKGeBGxSRbvV2VniA?=
 =?us-ascii?Q?3PxSULcyEyqttMFnaOhpwxBiNngbOzkSsAJAm5joSJSiQa2PDKR2FHLJXPXn?=
 =?us-ascii?Q?K6wiCaEXpHc6MVXob6JHx05YfKQ+UQBxhKvlKWlm901a+GyEiTj8/ioneMvo?=
 =?us-ascii?Q?X06roPaHGhY2xUJVJEz4R1bFrcuGiHhIqsiHHptER3MOFBO5uMUEdIb49vBs?=
 =?us-ascii?Q?eWLxRMHBVZHFp6oad5ZZPCEQAjEZ32N6hgSEVnxA2doB9/0oBLlMVlmLvEp/?=
 =?us-ascii?Q?aYN0xc5gREIU2ti3kbEZcPTdonJIQVtQJWk2K0cZcF5wYHrTIlnNaSC/AITi?=
 =?us-ascii?Q?AtHmSbDGS5QeUE00CGI+6Hb9of2PARiHlVYexXDjn8gqOyCPnxPRLyusJO8F?=
 =?us-ascii?Q?fWkdaIgg/RmhG3l5qdPxvtlDB34b118GhVda+xUj9NmyUbvwV3QLHP6NMJWp?=
 =?us-ascii?Q?wqJMfwOkQP42UsvdYGknzrsj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad50dd95-191e-40ba-17f6-08d8fb354056
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 08:55:40.2418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9eGeh3EEKYd8kgcQBedvysmM7kxvMPttZihW8ajQK63vtBCQ3bshMpLWtdO+Vm7jctlA2n8t4CRQKdzqFZYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4401
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Chen Hui <clare.chenhui@huawei.com>
> Sent: Friday, April 9, 2021 3:58 PM
> To: Tan, Ley Foon <ley.foon.tan@intel.com>; lorenzo.pieralisi@arm.com;
> robh@kernel.org; bhelgaas@google.com
> Cc: rfi@lists.rocketboards.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH -next] PCI: altera-msi: Remove redundant dev_err call in
> altera_msi_probe()
>=20
> There is a error message within devm_ioremap_resource already, so remove
> the dev_err call to avoid redundant error message.
>=20
> Signed-off-by: Chen Hui <clare.chenhui@huawei.com>
> ---
>  drivers/pci/controller/pcie-altera-msi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-altera-msi.c
> b/drivers/pci/controller/pcie-altera-msi.c
> index 42691dd8ebef..98aa1dccc6e6 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -236,10 +236,8 @@ static int altera_msi_probe(struct platform_device
> *pdev)
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
>  					   "vector_slave");
>  	msi->vector_base =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(msi->vector_base)) {
> -		dev_err(&pdev->dev, "failed to map vector_slave
> memory\n");
> +	if (IS_ERR(msi->vector_base))
>  		return PTR_ERR(msi->vector_base);
> -	}
>=20
>  	msi->vector_phy =3D res->start;
>=20
> --


Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>
