Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769B13E446E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhHILO2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 07:14:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:41574 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233516AbhHILO1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 07:14:27 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179BDvXh017245;
        Mon, 9 Aug 2021 04:13:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=Zel9s0+ucEEWQyXUu8dmUdK+9mkzNE9P9tZDb41iyqI=;
 b=dLfd35sIhgUT2+TEJMJ5H8UFB2+puYjv6pWdvdUJboWr66VKmxWljixbNbRsnfo9d8Hd
 RPAkj5pyk1dzSyjFMKHX82bX+EyB0xBXbPOvZ8xR/6r+gWdAKQJypzUvg4UGINEmT5dq
 //J92SKfHjle3mdE5LoOjsvKfPMisps97twtfGIvTuGzpQFtN5yfujKT1F+xupfUaOAv
 TbRR70AzxmBOf/nilojRrw+Am+ol5V/1cBUAfxwW+4W/xSgEPmAfn51+4Fzj9UQQc9xM
 CyJ3M/jvmi312cB/QctONmAnT/wEWAOVH12fAosxs00RuwgzjoDAmiD1UVgiQonABvmn Kw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3aawvg8jx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 04:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXgHTtXS5clZggXGYoVsVUEF6++4T8Bvd9VPhtW5HOwT/Wja4aj5yipzwxae7HNa82v9NzVWvGXLo54QGo61bmZ5VPKaB0WBmZHA4C9VmSOVFfXz8SGbrx/uYGyyfi/mHWP6fe/YffTm+EtJdfF3vhJt+YXZ0pbVLQw2+AkTfSimnBBkE53coP0Ab2b7u3/cRrE+xe9G37fbt0QdGzHnnPmguKvqzybUeQeHSSow/ZglD7EhxYbceIZqJhbQvzkJ0VBQkTDX4YeBhHJ+UUPGgaBWPFyysAAaLnRbuIYa515361h+81fxjhUiHLpziZrCFsfs9noUK39qULimVC3IEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zel9s0+ucEEWQyXUu8dmUdK+9mkzNE9P9tZDb41iyqI=;
 b=aJhW8XyzedE3c5p+eqklxwItvbXn+Xq9I8gpZkOXdy3GHSLEGkjX38QSFB5G6X6hxjWy0doBzhMnPKZer383FObT2KijyqCrWv9jy24iqh1Dh2xMzMqTBNvxN340j1TP/QRQEWSP7eINuqHfhLvi71w54Vn1613zbrRUNSFlVa2oqk8OLJzAG47M4Ffi/spIiYTSkcCNr4fD4hTVh03CKsS7gd9M61LNjABh4cyi8lDYob+knOMZuwluy8SqVfULqr7NYHBNIKw8xQgjTnMHlfi+p2P/xElk8GF9KMRI+LK4Ilg/Z/d5MPG9B0k4Ufg+gYwfh2KcL+gdk6uv5SOm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA2PR02MB7754.namprd02.prod.outlook.com (2603:10b6:806:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 11:13:55 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 11:13:55 +0000
From:   Raphael Norwitz <raphael.norwitz@nutanix.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v15 1/9] PCI: Cache PCIe FLR capability
Thread-Topic: [PATCH v15 1/9] PCI: Cache PCIe FLR capability
Thread-Index: AQHXihcaLdQv1XRRNU+UHrH2m10VyatrCxOA
Date:   Mon, 9 Aug 2021 11:13:54 +0000
Message-ID: <20210809111349.GA867@raphael-debian-dev>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
 <20210805162917.3989-2-ameynarkhede03@gmail.com>
In-Reply-To: <20210805162917.3989-2-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d91687c-072f-4a3c-2b55-08d95b26c6c1
x-ms-traffictypediagnostic: SA2PR02MB7754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR02MB77546A18E04EDAB63F43F800EAF69@SA2PR02MB7754.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: soRoC9wnKqAZewzGzMMbWBU4Y8nHGAVVqqkW+kSa22j+WPeNtuYWDD+Qei2E5MXvYUerBb/VIE8sOx0zZSaFa5So9rw47RhZRM/iyHJJEptaNd+CCiyhgT2XRSE93jYkwSx4G22LsR5203ysTNbqmtRbDnIChvE1BJBvpfSXKBgY+F/EVPfAahLN+uqfvA9WPvTLo0dOeHQDHXJouj92axpusm1RFMmb4/o97S7paazZGY4fU/iXhSaY4EK4Q2mteG425rYeRQEhXT/x3GaNrRGaQ6LHxgUupDPVHRlSzQL9ULCDx45/5dIPbnDFE5pgNZi98hixb6gIJBj0yLxebRhTTT2Iu5y7ys97f1STdH76uTHD2mNPCd9wC1bHhhSi3d5yVCpes5e7lZFlXFwfOnSroy+bmfo22s73fxBgNdRvyxhTG+J04uuDOyPtI/z54eHMG9dPSVfWnWEzQ2eYxmJwteMaHNP6LKaCa5hBfnpHK+vDiNak63ynMiDQ1/oWUZC8nVCCPqw46auXEaWcR31WWB3+EpEfB1/keThhGUf/FKxR5uIlEe06pPw2oVsNJDKcbyrLql/xTTn6VZK8PlWtFCZWtEl6myOilT0UpTucgIiZdlF4uzeiRhsWfOmygur4tue3LODdnW7sm8wWVkghGa48V6PP2Wn686xVHi/RBQEHVD1gLw48I0+GecNBBsCtEHJvdHJ/BSFhm/uLpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(8676002)(4326008)(64756008)(5660300002)(66476007)(66446008)(66946007)(1076003)(83380400001)(6512007)(76116006)(66556008)(186003)(478600001)(6486002)(33716001)(6506007)(38070700005)(8936002)(26005)(33656002)(9686003)(44832011)(2906002)(7416002)(91956017)(38100700002)(71200400001)(86362001)(316002)(122000001)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2bevv05JIWAgbuah9sclOBV/aDvcjH5HBLSU3yDA0ki7Mqir5bEAE3TKpcrn?=
 =?us-ascii?Q?sJ19JL3+c/zHgjtv/yRWlRBpmB1AN0w0xo2hgMPghVjkab6v9SSWpjNBb407?=
 =?us-ascii?Q?l9UD/EPIvc6+CVLMr6Lc/G9FgGO3/PVjrpxy26tpukFBBkgXs5SRAmTsqlOG?=
 =?us-ascii?Q?ZnD1x2gRqLZp/Ru5swziwO8TScXs1YZp5jXD3Y3muS+k4F6fJ96gRN4HlCEP?=
 =?us-ascii?Q?eKL0HLXuYz4KyVTwJ1lnbH2BIcv/skmM4WN4VIUULZRmd3kAms8sKnGaKtVT?=
 =?us-ascii?Q?NYyjCp9wnALFUt38pCqgGcozXbYQsgDtoGDTfykbuCdruMO0bCiMFbQGEdIL?=
 =?us-ascii?Q?PJPGB3+XdT+cmuX7QtuQYraJYJkjO0peetC1J5inKTfAdn3IHGgUmhqlc/xN?=
 =?us-ascii?Q?wh1ZxFXp26uYSe6lio8lHdSyrsAu4ab9AqdpdfaZLRsAea+ypZEJs4T0/fOg?=
 =?us-ascii?Q?3lgFLxZ8HRjzK4UeKKbRzZKvGW2Z9O4aRADmpQUHvT5G8//Ny3YVxC6O/n2Q?=
 =?us-ascii?Q?HOGNupRciaLYhQBcPlWLRCizH+U7Uv1JPm/Vbyubrw24k2L9C2GCNfj5N7Z3?=
 =?us-ascii?Q?+C2g4a+a/6NyZvi6TKQqu/XDIeeltuPaSxy0Ll2eKS0A+fV8JGSm5pHNAdKB?=
 =?us-ascii?Q?cQqRwk8dtzuI5puNgUggtwBK1c/mlZQPqWwXPBGBNbD9XsX1PRZhWnJ97OrJ?=
 =?us-ascii?Q?BMKq3VGDztGK49pdK4i1A2HlWLxh8x4C/1EWfmDa+vBpDDrYPyfzbmy/xVuB?=
 =?us-ascii?Q?dGi7NoVrkujWnPeXycPDSmZaN+y4aVcfTW02Y05IC2QsjD3lDdV2NvlILmNi?=
 =?us-ascii?Q?+QI1NONb1V530TJlf4Pl1W37geHQtlFd2x00gHmoAFI+P8pppaM+cCXspu1o?=
 =?us-ascii?Q?tz2K71HTU5UtBVeed+NX4235DfWno6mLWkeSW4ua0l0HeZDxSuA7Ct4sm95T?=
 =?us-ascii?Q?U/88iSc8QFh9HoiW4z8YS36JYAuCMlC6nlpY+FlOuJhw2zwJ80Vg58qVDChh?=
 =?us-ascii?Q?2CVtGGe2kSHksGDJjatyScxUAGj8CKn27Ffni4CUUjRdDCndff+W1z4vU/M2?=
 =?us-ascii?Q?BdfWdDKPQ9GPhpGnPdyVZae7+0t9XSV4IRL4YLnQIyB1NuK6v4DL+WQw9fiq?=
 =?us-ascii?Q?p/b876ZCiLQVgW9PDviV9+M2s33QHhQUiApv8U+4Rp0pWpSWGTuCkiwEDSkq?=
 =?us-ascii?Q?kRmgf++3kf8d4ieavnL2clK0Eke+GdaQkvrRbKz7DvaUWky1gJFpbWaiBzKF?=
 =?us-ascii?Q?Oo3ljlNezK6rjCnsrx6y2kw7b/hMymjcCkuwCGaOFrX3xlZbWJ6Ea2KnJhfx?=
 =?us-ascii?Q?j+1kr0SkynoWJFzCmnU9XM2f?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <756CE8A2531071478BBA56B8E8D34D12@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d91687c-072f-4a3c-2b55-08d95b26c6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 11:13:54.9399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8QZyNgrATqSd+k5dX0HF676avENCFidDU8/7Gn/FOPQOY5aXHcvaEa0A8aKMRoJGv0KVEsRJTyRqFMna1xp5MfC4ovejPS5fKlAMW9ATyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7754
X-Proofpoint-GUID: v1RV6wKsvDyfqd5MPRiiQlXMGkk5LqMe
X-Proofpoint-ORIG-GUID: v1RV6wKsvDyfqd5MPRiiQlXMGkk5LqMe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_04:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 09:59:09PM +0530, Amey Narkhede wrote:
> Add a new member called devcap in struct pci_dev for caching the device
> capabilities to avoid reading PCI_EXP_DEVCAP multiple times.
>=20
> Refactor pcie_has_flr() to use cached device capabilities.
>=20
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  drivers/pci/pci.c   | 6 ++----
>  drivers/pci/probe.c | 5 +++--
>  include/linux/pci.h | 1 +
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 452351025a09..1fafd05caa41 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -31,6 +31,7 @@
>  #include <linux/vmalloc.h>
>  #include <asm/dma.h>
>  #include <linux/aer.h>
> +#include <linux/bitfield.h>
>  #include "pci.h"
> =20
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -4620,13 +4621,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>   */
>  bool pcie_has_flr(struct pci_dev *dev)
>  {
> -	u32 cap;
> -
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return false;
> =20
> -	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> -	return cap & PCI_EXP_DEVCAP_FLR;
> +	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) =3D=3D 1;
>  }
>  EXPORT_SYMBOL_GPL(pcie_has_flr);
> =20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3a62d09b8869..df3f9db6e151 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -19,6 +19,7 @@
>  #include <linux/hypervisor.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/bitfield.h>
>  #include "pci.h"
> =20
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> @@ -1497,8 +1498,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  	pdev->pcie_cap =3D pos;
>  	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>  	pdev->pcie_flags_reg =3D reg16;
> -	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> -	pdev->pcie_mpss =3D reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> +	pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
> +	pdev->pcie_mpss =3D FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
> =20
>  	parent =3D pci_upstream_bridge(pdev);
>  	if (!parent)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59a57..697b1f085c7b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -333,6 +333,7 @@ struct pci_dev {
>  	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
>  	struct pci_dev  *rcec;          /* Associated RCEC device */
>  #endif
> +	u32		devcap;		/* PCIe device capabilities */
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */
>  	u8		msix_cap;	/* MSI-X capability offset */
> --=20
> 2.32.0
>=20
> =
