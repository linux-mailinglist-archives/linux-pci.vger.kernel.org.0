Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C814123D21
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 03:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRCao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 21:30:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:40722 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRCan (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 21:30:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 18:30:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="205690459"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2019 18:30:42 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 18:30:42 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Dec 2019 18:30:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 17 Dec 2019 18:30:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU5pqH+PWrW0xZ+ln0dn4v5dbY/VYbS/CkFTZ2ObwkyVTSICZT+cM/9hcoOzOi9A5h5DK/hY12ltuCVCe0PbhtgfCQf6+3Pd3/cXS+lidNVja1hgMwTQ/Vj5ObRwFOWe3FoMQic417XGiwY6Xrz5rpLjHzMi+z176HPeW+FZiBjQlr9DeeYHU5SbWXKQKq2CiKkk2gobgZpUXHlC/tFsUCPDnG+tiWAUhxsAMzaGXvUX70h163LeTZFQELIloCZ/9qj/hmIQnRhKzzQb0EfGEM0j10/+6E7dgUolHux3roCNnmGSyECmsG6H/jOxBdmyMO7VJ4RzLV9Fd7jqCKMuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c4rRW+5srLLSVTHfEJEBHhSWTNAO6+YdRUmMlKx5D0=;
 b=gNReFJOz15gCwonRdN9zWA0j7guq14ohTumz8yw/gj7mWdczYGwEmb02umS1L6ZxYn4NWbHJ9rIk0XRckMaRRxiKg/0eL/rF7mN+Ftgu0dbrW3dxp2NeITiQawDWVmxfgobQDwByePolOX8Bw1qu+QWq8+U5uMF8WDCwj3oCHVWWF9hX1oI8lXLdq3hyY264JeBAke4U9rXv1ZLxM7Z516zId0sdZX3aUM3gXKdbYLf7jokLSM1cPMCGdYHqK1BZF/9pDpP8o9w2Kx34yeBgMRXhnkDVSEE6MLKSA0fY8/m77fdu5zO71xiCUpQJnp638JLg1BbiiO2EfiBaRWFG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c4rRW+5srLLSVTHfEJEBHhSWTNAO6+YdRUmMlKx5D0=;
 b=mdUel7xqpYpvu6neLJSEkHlykgf26ikkNhq0Nkvl2sU1KYyTVhgzDKj7V/ZYRn9lbf/HV0R7blT2MpOUmBnCozf2z3y+WFSqOnaXgWJclHiYnptXQ8m3RUTStHiDSuAB3BYTXMJvM5OI+rmaoCqXV7imIYwNTCzNMwj1alYjV58=
Received: from MN2PR11MB4509.namprd11.prod.outlook.com (52.135.39.90) by
 MN2PR11MB3694.namprd11.prod.outlook.com (20.178.253.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Wed, 18 Dec 2019 02:30:40 +0000
Received: from MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d]) by MN2PR11MB4509.namprd11.prod.outlook.com
 ([fe80::bd81:f020:90e3:a12d%7]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 02:30:40 +0000
From:   "Tan, Ley Foon" <ley.foon.tan@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Andrew Murray <andrew.murray@arm.com>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] PCI: altera: Adjust indentation in
 altera_pcie_valid_device
Thread-Topic: [PATCH] PCI: altera: Adjust indentation in
 altera_pcie_valid_device
Thread-Index: AQHVtUKDuQwl3+EaE0qjwoEcgXzj7Ke/K4Ew
Date:   Wed, 18 Dec 2019 02:30:40 +0000
Message-ID: <MN2PR11MB450901255175CCA4C7CDBF3BCC530@MN2PR11MB4509.namprd11.prod.outlook.com>
References: <20191218012752.47054-1-natechancellor@gmail.com>
In-Reply-To: <20191218012752.47054-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTdiZTJhZWYtNGJjNC00NTU2LTkzNzctZTA0OTQ2Yzc1ZGYzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNnIwUHBYaVhRUTZzYVlkTG0zUXdqcVprQnB4WUE4aHhDd3M1REZSV0RyK3A3U2swU0tlQUFNM2pWNVdTdllPNCJ9
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ley.foon.tan@intel.com; 
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 853fbec0-9503-4c05-e91d-08d78362467c
x-ms-traffictypediagnostic: MN2PR11MB3694:
x-microsoft-antispam-prvs: <MN2PR11MB36941A9F6850F34E917B8D97CC530@MN2PR11MB3694.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(13464003)(66556008)(316002)(53546011)(54906003)(966005)(8936002)(66476007)(71200400001)(8676002)(26005)(2906002)(33656002)(52536014)(6506007)(66446008)(64756008)(66946007)(81166006)(81156014)(76116006)(5660300002)(478600001)(7696005)(186003)(86362001)(9686003)(110136005)(4326008)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB3694;H:MN2PR11MB4509.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUzrOQiCD/8f6qBI4aEuviHLdoC4JH4jo6ndw6irCncLdCIUxCZmEEX+zWp21wER8eApKBxlvYqSywxQ4x3soyHTqHGv5m+N/4cxiYfx9a1KKc9nwI+ucNbX5MH4X4uBNbctdDpnTqks3Q1KwMVzmz2++my2cXNwDT1IMjc+3K4H6Dxfn+OATXTCOJ91qxOjmgInD1wH0BdIM8ULcid4+DPJ3QsyV65+dlDxBcflcuS5hTsZu6VZEI1CJPqdOzBbTeS1zJYIMZ/XaRHUvyiSewDzH0eYoZz2JZjOOQIVitIUBpGfbPPZZ+LDQu7in0hthVEMNKCcHOcZT1S8ryagbhMxjCgZeiBCIIps9rxR8vHcJwl5z8GV3wWYk2RGDYcqE5OTt3id2x5HyGaABciltoHjeDopaikoKQlV+q+QMpdOGNIEA4mD5vWY85WZjvHKj9gyPXsPBl50maQOJxNmCS74d4LTSo1ZIH2mgpyauPFsPUGsrCI7meqeSXPWnVXHJgfx/o41+K9IQivbamSPSUEuOU8QX3b+p5HIjH6kIuE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 853fbec0-9503-4c05-e91d-08d78362467c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 02:30:40.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IXFqQhGs47JgWE03vsbgnRnQNn3+Z8dYWhSLpGHV/YRaWz64b0QoJi1FtQJgRpiDRExyfU2MZ4Q83TigImfjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3694
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Nathan Chancellor <natechancellor@gmail.com>
> Sent: Wednesday, December 18, 2019 9:28 AM
> To: Ley Foon Tan <lftan@altera.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: Andrew Murray <andrew.murray@arm.com>; rfi@lists.rocketboards.org;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; clang-built-
> linux@googlegroups.com; Nathan Chancellor <natechancellor@gmail.com>
> Subject: [PATCH] PCI: altera: Adjust indentation in altera_pcie_valid_dev=
ice
>=20
> Clang warns:
>=20
> ../drivers/pci/controller/pcie-altera.c:196:3: warning: misleading indent=
ation;
> statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>          return true;
>          ^
> ../drivers/pci/controller/pcie-altera.c:193:2: note: previous statement i=
s here
>         if (bus->number =3D=3D pcie->root_bus_nr && dev > 0)
>         ^
> 1 warning generated.
>=20
> This warning occurs because there is a space after the tab on this line.
> Remove it so that the indentation is consistent with the Linux kernel cod=
ing
> style and clang no longer warns.
>=20
> Fixes: eaa6111b70a7 ("PCI: altera: Add Altera PCIe host controller driver=
")
> Link: https://github.com/ClangBuiltLinux/linux/issues/815
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Ley Foon Tan <ley.foon.tan@intel.com>

Thanks.

Regards
Ley Foon

> ---
>  drivers/pci/controller/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controlle=
r/pcie-
> altera.c
> index b447c3e4abad..24cb1c331058 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -193,7 +193,7 @@ static bool altera_pcie_valid_device(struct
> altera_pcie *pcie,
>         if (bus->number =3D=3D pcie->root_bus_nr && dev > 0)
>                 return false;
>=20
> -        return true;
> +       return true;
>  }
>=20
>  static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
> --
> 2.24.1
>=20
>=20
> ________________________________
>=20
> Confidentiality Notice.
> This message may contain information that is confidential or otherwise
> protected from disclosure. If you are not the intended recipient, you are
> hereby notified that any use, disclosure, dissemination, distribution, or
> copying of this message, or any attachments, is strictly prohibited. If y=
ou
> have received this message in error, please advise the sender by reply e-=
mail,
> and delete the message and any attachments. Thank you.
