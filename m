Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8C3E4481
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 13:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhHILQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 07:16:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:48398 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235097AbhHILQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 07:16:17 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179BCaDQ011627;
        Mon, 9 Aug 2021 04:15:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=EKeJ3gtHCxFAi94IJIXvSRrouGd6qvD/Vo25OhwdWHs=;
 b=eu4NIYorAza1VUh32edUeKYBqLVMxuy7h+78Fn8SVWxVujm8yHgFRoHoHhhGHo9L6GHD
 MMmIrxSXFzC9jChzHcrSVCSQRLEH202wGW+BlrCSPM+sDHNyhy1hJJPqy+Eoxd250nRH
 wgiGcE9MOheq4JvoqYt9A5YbqqujS4gRIaeUd0gdyYC2OWSVd2uBTMOJQkAfnEsoQRZw
 AgoWJQ8YLFEO7UaIPSzqDZXcqDTjoyJNU76o6KgETdMGpGI26qbH3wM/SEi+slUxhiod
 A+LBVkIqKvxAgx2SAyVrJ4tzhH+hvaJ4zmQ5HWK7SbqqiFpjogLCQM8f01XuLP1nla09 Nw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3aay458f6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 04:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLKoBy2NCuI/whEiRCEHKdNWcqbKWm9spHauLtvQ7oOcoZB8fxSdN1aUcKCTFbS71GgyYHJrtnklvOvtNnBgwipiE6Yrh6snGYT8JaISwAGarDUl9ooIK4SQuO1p/uX3xwnCDbz4nyIkc/VHGeySHUYem0nW7VoaHoxfnkE0fh/dJZaBE70tyrIy980v+EKHBbcvuJycxnXlLElvgr5TMGWwWBArWXBty0UpTrQnCP/Bj+LESobpeZyCRJaT+FoJoGxlg0uFJDkS8542hFQBjjPjLbzifbzTz0bEUQx1Nlj3vnoz8Cg7OFIZDdN++rlrZy5ALL/uva934Q3Vszo0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKeJ3gtHCxFAi94IJIXvSRrouGd6qvD/Vo25OhwdWHs=;
 b=DhZGVPiRrYFsdY+AoLSab6IJAVLugzVVLmaF6iSEljJlhd8T9dvW8e0XQu19vQm0JXU84WqmakrSI/SAEXefCMGML3JqQknINApX7zt/Zgo1acccQ8UC8P6QwQnQXDBS/DBWi+FgDXvLze+s8a5CJCpexlWMw++yBFo16Fz1XiC7NE8b90P9TpLvrDY/KBbkykbdhCpngbbpvPDAN5bdvnsADWNis5JJS94KlrLImnSVoURHIEZqy245Zf7029hryf9QoC71kwcAuunjwAWo8lC7b1+6Kjwv8wJUzx6hhUcRG2JJwaMDhmQ4EoKWQmjBdE/aguh1ng9IydIhk37fdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA2PR02MB7754.namprd02.prod.outlook.com (2603:10b6:806:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 11:15:47 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 11:15:47 +0000
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
Subject: Re: [PATCH v15 2/9] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Thread-Topic: [PATCH v15 2/9] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Thread-Index: AQHXihcchiMck93j40qatltqIKKDCatrC52A
Date:   Mon, 9 Aug 2021 11:15:47 +0000
Message-ID: <20210809111545.GB867@raphael-debian-dev>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
 <20210805162917.3989-3-ameynarkhede03@gmail.com>
In-Reply-To: <20210805162917.3989-3-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f8f4fa-a17d-46f9-f16d-08d95b2709bb
x-ms-traffictypediagnostic: SA2PR02MB7754:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR02MB775428E201A0F9C84B0E3BCEEAF69@SA2PR02MB7754.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NtRGeQHZka9mcKznidxf9BFtkDCpZ1VWeYY0lmvf0Y7JRuJXOMRwOBdufWJSJXt6Lp3A0BClOYwxcQVmWV0YG4FDBLaWMcEiMi7gXeokOMRunHaEiKrBBWGcdkG5tqAGo9U6XUoZE7hsOtWfQDAm0HZyG7oFZ6d+bAYZpqVSSAMGmEllyomF0SVuiwWicDWXhWQzWMGa51QZXUy6rn5iwO0aqid2tL2mPToVgk+GuvaMiNU+R9oz/OITY0BHt4qzV5ETSP5ekL3kQjGQWORjGS8b07vl/cxz2uYxF+lG7tzEVgBJ0/wM1Zdr2tO04P+Z/9Ie4GWK1TLHPjOQtbFqrX8Oo+e26rZSFJyqjkNmsreSmQvjVTkIkm3zszIo4XzqQhvAWTyQWLUMPEDPSY/n5Khog8y2evN7rWs+WCiug2S6sP4Z6sbbFFaMeTOF8mtoc1j94zbGka2NoY37EdOLZeyG0CfgtQ9YOq1TLmjWL2q1uiEP/qlRZ08523YwVJiV39eiqlY4gNKTvo5eG8IjomULSaA4G6cdwvN8ezebnLXA2cpjl5R0ZaZMbrHrKJQkX79smd2WoUMJNBaO7vl6QYZdEDFh/H2gMVHm0balta6cH4FAlHOqM9yKkyKw8SlfCpc6gvSX/NNNWYK6HZ25EznUH7F1/bX3N+LQ7a4XVRulrNVeH9+XH/pgiXI8qcvx25QZO6+BFSKJiGPyrra2QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(8676002)(4326008)(64756008)(5660300002)(66476007)(66446008)(66946007)(1076003)(83380400001)(6512007)(76116006)(66556008)(186003)(478600001)(6486002)(33716001)(6506007)(38070700005)(8936002)(26005)(33656002)(9686003)(44832011)(2906002)(7416002)(91956017)(38100700002)(71200400001)(86362001)(316002)(122000001)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ges/8C310T+FyuWekMIpa3PfePQxpVgw5UaB4alvE2mqL95LG+FtkymDXloY?=
 =?us-ascii?Q?VoYCcjR+GoU5UA99AQH+yW8jGSPP85OVRKeCRqHICJcLflBEfhcY4TSuM1P+?=
 =?us-ascii?Q?uae1KDGzShSll2YB7M6Eq14qU+4KlIVXSRhTW7Z9dHlCgj+oH+lEMoqtUDa9?=
 =?us-ascii?Q?ZoEuOADLugHkFIuVUut2jite/A6dt6mcfVo0lcnCKjiXlw0Glcd0Ji29fWsE?=
 =?us-ascii?Q?qD22ND0TNJgE043zIEqGZJzBt5ABuGK0uRleBfK3TmH385D0BGhBQAJt4prG?=
 =?us-ascii?Q?rIcGxGVBjgXjNRYmDWUsv8FlE2egnnMKRgck9xrrWytqNC7Jio1oRXvIgteR?=
 =?us-ascii?Q?pp9sxu+Y4aBF/ojm53VDzceImsM+k3U9bY54AP13z07Pae0+0Ol6QSCQ5cVN?=
 =?us-ascii?Q?kJCUovQuATItA37wjd2pTxLuQcGPYtvAIl4ZDHZEiZ7Y6UyNtQhT8x3q8gea?=
 =?us-ascii?Q?6hNXpKQT4d2TSzzE5qdryEwq+fLyn5rLHSqDBJ4RZSHwfeEQScnpuB5KswVi?=
 =?us-ascii?Q?gi5Sa0pULTDK0C6I3JJc/jtCs0u82Sd8bYItJHyiYN9DzNgzRxwiUrUBLufn?=
 =?us-ascii?Q?TVGN4yAjcIznN+P3bdc8QMa+rT90Av12VPFfNlp7AFp9m57tY5o7lNL3U8VB?=
 =?us-ascii?Q?4fAV9TgGJ6qf7+tKq/XGU6NP8TaPywlPO8o+DJUXGxukc79j/bfG5RYQSlCz?=
 =?us-ascii?Q?7epHiOFQmEvZTthsdfcIFkhW51u2Maeu20OXyk3slMrckLkA/ycFF7sVV/3x?=
 =?us-ascii?Q?62mGCHYjXxoUoIrOURyewwNficDx/f3VvYw6P8xp9noO9X1W6wnSpJrTnV60?=
 =?us-ascii?Q?GVrDo7ecZqNrqAnU7oT/OMdhw8u6/zNhY49I1lmFvP4D8wKc3HW6SF8gRXh0?=
 =?us-ascii?Q?3C/g9TBb91iOCu+oXbV6wdbrn7Zwh79B8lFtXVdbpimU+3xvNniUkoWuTgDD?=
 =?us-ascii?Q?rlc8y7Uqbi1yrzAa8uzronpdb15/DBN3NmDZyX7zOR+qQ+/tEzNYi1NvHvCv?=
 =?us-ascii?Q?J4qWsyEpt2Nz0SuNF49pNotET+ZeekeCctjwFEhO9Hm2dOjYdXza3pHAoTPx?=
 =?us-ascii?Q?TjTULnoWzfb6ZA3guBe5rjZRg34pykUyLsHFtLWBfQCJCh+l44Ao9MAIk1Ws?=
 =?us-ascii?Q?Th/s2m10J1DDz4G+j71CfqFNlHipyWVhak1L10HIbLfdqE9Xp8EcDeHPVvgt?=
 =?us-ascii?Q?xm8r/u3BlXKPlbh9lp4re4J34vHzOcVKe9KGzW0B9LPwJ4g/U2ukwPZ8dezF?=
 =?us-ascii?Q?adcw35MD1ucejs9SRGlUl5VtF+D3q9B4ZL15kfVip1tP7t9m5ylSLOllxKw0?=
 =?us-ascii?Q?17nhmxatvV1cc3488VtqtfOQ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24D515134305024594B68F090115E6CC@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f8f4fa-a17d-46f9-f16d-08d95b2709bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 11:15:47.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bWAMKhnxQH2HIdcTo3y6uScga+l2k2FT7jQCBhgkqD4zWoHwXKyb2g62MTK5IabjM6mkZ81vrL4rJY3sphlzKfR9txq8FGAnCk9TFsQ88E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7754
X-Proofpoint-ORIG-GUID: deGDHhwzyjnMNhJwcH-W9QbgvileY1EX
X-Proofpoint-GUID: deGDHhwzyjnMNhJwcH-W9QbgvileY1EX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_04:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 09:59:10PM +0530, Amey Narkhede wrote:
> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> is supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not. Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.
>=20
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +--
>  drivers/pci/pci.c                          | 40 +++++++++++++++-------
>  drivers/pci/pcie/aer.c                     | 12 +++----
>  drivers/pci/quirks.c                       |  9 ++---
>  include/linux/pci.h                        |  2 +-
>  5 files changed, 38 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/=
cavium/nitrox/nitrox_main.c
> index facc8e6bc580..15d6c8452807 100644
> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	}
> =20
> -	/* check flr support */
> -	if (pcie_has_flr(pdev))
> -		pcie_flr(pdev);
> +	pcie_reset_flr(pdev, 0);
> =20
>  	pci_restore_state(pdev);
> =20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1fafd05caa41..7d1d9671160b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4619,22 +4619,20 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>   * Returns true if the device advertises support for PCIe function level
>   * resets.
>   */
> -bool pcie_has_flr(struct pci_dev *dev)
> +static bool pcie_has_flr(struct pci_dev *dev)
>  {
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return false;
> =20
>  	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) =3D=3D 1;
>  }
> -EXPORT_SYMBOL_GPL(pcie_has_flr);
> =20
>  /**
>   * pcie_flr - initiate a PCIe function level reset
>   * @dev: device to reset
>   *
> - * Initiate a function level reset on @dev.  The caller should ensure th=
e
> - * device supports FLR before calling this function, e.g. by using the
> - * pcie_has_flr() helper.
> + * Initiate a function level reset unconditionally on @dev without
> + * checking any flags and DEVCAP
>   */
>  int pcie_flr(struct pci_dev *dev)
>  {
> @@ -4657,6 +4655,25 @@ int pcie_flr(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
> =20
> +/**
> + * pcie_reset_flr - initiate a PCIe function level reset
> + * @dev: device to reset
> + * @probe: If set, only check if the device can be reset this way.
> + *
> + * Initiate a function level reset on @dev.
> + */
> +int pcie_reset_flr(struct pci_dev *dev, int probe)
> +{
> +	if (!pcie_has_flr(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pcie_flr(dev);
> +}
> +EXPORT_SYMBOL_GPL(pcie_reset_flr);
> +
>  static int pci_af_flr(struct pci_dev *dev, int probe)
>  {
>  	int pos;
> @@ -5137,11 +5154,9 @@ int __pci_reset_function_locked(struct pci_dev *de=
v)
>  	rc =3D pci_dev_specific_reset(dev, 0);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev)) {
> -		rc =3D pcie_flr(dev);
> -		if (rc !=3D -ENOTTY)
> -			return rc;
> -	}
> +	rc =3D pcie_reset_flr(dev, 0);
> +	if (rc !=3D -ENOTTY)
> +		return rc;
>  	rc =3D pci_af_flr(dev, 0);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> @@ -5172,8 +5187,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
>  	rc =3D pci_dev_specific_reset(dev, 1);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> -	if (pcie_has_flr(dev))
> -		return 0;
> +	rc =3D pcie_reset_flr(dev, 1);
> +	if (rc !=3D -ENOTTY)
> +		return rc;
>  	rc =3D pci_af_flr(dev, 1);
>  	if (rc !=3D -ENOTTY)
>  		return rc;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ec943cee5ecc..98077595a73e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1405,13 +1405,11 @@ static pci_ers_result_t aer_root_reset(struct pci=
_dev *dev)
>  	}
> =20
>  	if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC_END) =
{
> -		if (pcie_has_flr(dev)) {
> -			rc =3D pcie_flr(dev);
> -			pci_info(dev, "has been reset (%d)\n", rc);
> -		} else {
> -			pci_info(dev, "not reset (no FLR support)\n");
> -			rc =3D -ENOTTY;
> -		}
> +		rc =3D pcie_reset_flr(dev, 0);
> +		if (!rc)
> +			pci_info(dev, "has been reset\n");
> +		else
> +			pci_info(dev, "not reset (no FLR support: %d)\n", rc);
>  	} else {
>  		rc =3D pci_bus_error_reset(dev);
>  		pci_info(dev, "%s Port link has been reset (%d)\n",
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d85914afe65a..b48e7ef8b641 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3819,7 +3819,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev=
, int probe)
>  	u32 cfg;
> =20
>  	if (dev->class !=3D PCI_CLASS_STORAGE_EXPRESS ||
> -	    !pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> +	    pcie_reset_flr(dev, 1) || !pci_resource_start(dev, 0))
>  		return -ENOTTY;
> =20
>  	if (probe)
> @@ -3888,13 +3888,10 @@ static int nvme_disable_and_flr(struct pci_dev *d=
ev, int probe)
>   */
>  static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  {
> -	if (!pcie_has_flr(dev))
> -		return -ENOTTY;
> -
>  	if (probe)
> -		return 0;
> +		return pcie_reset_flr(dev, 1);
> =20
> -	pcie_flr(dev);
> +	pcie_reset_flr(dev, 0);
> =20
>  	msleep(250);
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 697b1f085c7b..aa85e7d3147e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1226,7 +1226,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, s=
truct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
>  void pcie_print_link_status(struct pci_dev *dev);
> -bool pcie_has_flr(struct pci_dev *dev);
> +int pcie_reset_flr(struct pci_dev *dev, int probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
> --=20
> 2.32.0
>=20
> =
