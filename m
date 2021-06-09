Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952023A1F8B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 23:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFIV7f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 17:59:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:58714 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230239AbhFIV7e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 17:59:34 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159LmNoH001397;
        Wed, 9 Jun 2021 14:57:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=txF9k8X1c9Nf168HaQt7wszDjF9HjaBxVGWsK2ocpmw=;
 b=YycT/xxfIFLAuQkGz4Lli63aR/DYgkIunfNgaAkZs4lZ1SQpbMXj6EuymNnDzV9/eDJy
 4qyzWsauA5733yI/ah9uTmszvMAQLRzntdH4MqX50u9fqGD7ohQWw3l2+1ZtWgYRsh0g
 6PQrNSARoLKcJFpka0XORI51+o1C/fWkDGlF0Yx0U/GBCjQQ9G4kRkpzzs28yKlc3MVi
 6B6jleblcnHP42sOE4HDac6ASEvu4Frtct2ByveRJc6ZGUelZMIUYK1tZzu7XnkKlq7f
 3H1NhvrNGB9r3y0PzXXsZ04MWWLZor/yNExhFH/o0Ocij/8CUZrAHhezvBOejXjMJKAA uA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-002c1b01.pphosted.com with ESMTP id 392auq3v53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 14:57:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwR728vUgQ1reWKEf+ZcaompMPXCR+r4aPkt8EVnvSJNqREZE/yFiROj7FQKbnCpHO8Ca1pJ+FL2vSOhEjkzLLcfJjejgzFSC88BJy3hjde9L9iDm9Dhybc60C7JIcf9c3eFgvyxZScLpNvaYtO/97AiBAssuTm8NapwyQEbCP9Hct7qoCXy3K5SKo8UeHcxA1ffvMbGwqYt9JsZoPmeaqBTU1nj4qybCwa6hTbNd2cRd5yXpWcuiQ8lzannjXTNE6L/PyeH87oJgQUnWlYCnbyfSxenbJZUR3Yfxazt7dfiOHHJgjsTGwE5mAnH9btn1wVE6sg+mpoZ4S8GKOf2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txF9k8X1c9Nf168HaQt7wszDjF9HjaBxVGWsK2ocpmw=;
 b=lnWZcKQWGsbiDK6eyCUv8VynmsBHs5GoB3zwSJtQic73FSSA5KYyM5iqn4dn9O2JRcW3DaE4vFaUJLlEo/mjDTpoULnlnc5q8K/QGTxXP9OrU82HRoC3fW6P9co4zZXwinyEwCsWhXKYEicWCTyOQnTd6DXTA0df5bWkTezhYhkW7hQe83Q90OFWZRzm1hynWfp0L+my6obsfwV4tgo0FaG3+RIW7xg/kpe5ptz+IeJADnJeCXYAQ9NUFR885zkn83jO9jpZjT6bhEkBUZsD6Yb3mz9zpqs1oAwbLKMc0lzhuELxUbg4lof0iRMAD2X+MiCEhxjTkpiNr4J/xtEYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB5694.namprd02.prod.outlook.com (2603:10b6:805:e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 21:57:25 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::bdbb:69ac:63f9:fc33]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::bdbb:69ac:63f9:fc33%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 21:57:25 +0000
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
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Thread-Topic: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Thread-Index: AQHXXCoL0P5HbzLU706U/y8QJTrdCKsMPIcA
Date:   Wed, 9 Jun 2021 21:57:25 +0000
Message-ID: <20210609215724.GB25307@raphael-debian-dev>
References: <20210608054857.18963-1-ameynarkhede03@gmail.com>
 <20210608054857.18963-5-ameynarkhede03@gmail.com>
In-Reply-To: <20210608054857.18963-5-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-originating-ip: [24.193.215.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9b19c49-41f8-44b5-59f6-08d92b91915c
x-ms-traffictypediagnostic: SN6PR02MB5694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB569445E7F893D47AF90DE10CEA369@SN6PR02MB5694.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jvCg7ODkDNWeKyshDZ9UacrmlDXuiwMKVZK/pvV+t3Mixp6hSTeDwQQDPluCin1NWVCe+tUQkAVxph1f0pa682SGwDcFO9AahAGJRB+k3ygy8ZXYUCGW8UeL3W6f8qxXDoJHVPdfGYJtOt3SCDRSNK6hBDZAvrRQ0taWP4IOpD8qgNilJha+ig+bM6AHv17RbcLs6T6FF/Qqiiy2wn7Eo815sBpLsOadx+XxKC6KDs0TKJHUGNVfXp780E0N1NGZr4G2qjD66HWh3bZFYlz5yB8271Nb9ZNGSeGEE58IGJxEuVBCNIR9B6lULQcQnDPzs9a4x6GrsjfYLMSMXJ7atszsMLRmWOl7TduRcj9gknta3HYXGnhbOfxQZro99KgbhW7526BIQZ9ICC/v2QSndQvja9x6xYIBjd2suhpM/R9I0DZV06QdehGHbDU9BZaMIQkHAdwHAm/f/a/RBtf7JgyUtk3FYZapzB0L/k7TJeQt30YebI9wIim2k0MlvpXX+Vlikl95H7VbqFcedCO3x3Bx9FsuXLhi6ZoVuXoRxigllPp+ldMbR9kfxtFdDRgjiZ6NBk6La0kurQRmVBxqSYT1S6NR3CyYV1zyHM34RY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39850400004)(366004)(346002)(376002)(136003)(396003)(33716001)(6512007)(2906002)(8676002)(9686003)(26005)(316002)(4326008)(1076003)(54906003)(33656002)(5660300002)(71200400001)(478600001)(6916009)(91956017)(7416002)(66946007)(66556008)(64756008)(122000001)(66476007)(66446008)(6486002)(86362001)(76116006)(38100700002)(186003)(83380400001)(6506007)(8936002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i/4WGYBb2WYh48BtMQZ7/PCXbPdFtY4woYizA+F1EacyKMHneD7DdCWBWVGK?=
 =?us-ascii?Q?rci7KnZPGI5UQVvR9e3SvBMZj91IaOVMLT5csbjehGyTUCkjijAbRKoQoQ7p?=
 =?us-ascii?Q?Ynl/+2mxVOxFh96YScT9YX+Svz+Z1sKPpdMIcikZbLdqaLtWXUqsG7w9adkk?=
 =?us-ascii?Q?Z67ZAOOtxir82y6/YsDcL9l/Yuc7dq02nvNRcVNy4gSJip2Dt0Ul705sn2TB?=
 =?us-ascii?Q?AZdaUaRhyCpoacBR8nej/vtRGg2TAubxw+IGJ+dGrUXlp35jSwGzRkwNJwTN?=
 =?us-ascii?Q?6bUayFcPoftUSsKSgwMauQ9FEE5sjIeylOe5pjmLy18L76dRkm2//wIFYVLw?=
 =?us-ascii?Q?bsJQjm3Yy+ocinj5ZDvWHvepIo25RpUGFesciNhUIx07nQpchE+E3d2AWbS5?=
 =?us-ascii?Q?Vo/9jPwmr0dAGSc/GZLop77h3cQrD+/fdbQgB9/85YL4APOkmsfFIzVXvr0k?=
 =?us-ascii?Q?A020BJyBeEVLUXxzP8m7YTBnpZIKYNL5qOhGBj53Ux8FLMtgtMENfbYgjNCu?=
 =?us-ascii?Q?hEgoJBs980QGXkXXtu2VQ4tlHOPAOETP//9GG0koMo+Ds80T/xDfj5DF88HQ?=
 =?us-ascii?Q?mXHxDowI++mpA/U4WQP6qZYC/LnZQwDM7NaxLiNBNltmsrExCAqfGHD+lGrE?=
 =?us-ascii?Q?eWpj8WVgkAexZ7m+P7eY1vvu0QXMApOSaYhr4E46U0T8REHmNVP5y37ppBMt?=
 =?us-ascii?Q?VqTsMU66OUYcq6RqRc8lR6fYMTu/DPfkAWLT47WP3bJDb9R+gQwC0TPBDKsj?=
 =?us-ascii?Q?56N2G8WKcevv+UfjSxRHzUGfBOpYOSnpJ7XvJUwlYwfTczZnPkb5piWGe/dx?=
 =?us-ascii?Q?mFTM30v5SMdleo3ZWae2eLLVc3RiCJDIh8wd5by+q5v69H/3/6KdD5tljFk+?=
 =?us-ascii?Q?E8kbRgtR9/Lz/I7bGV8m4bIWymfUBxWrLK6VLi9HCjjFvPk56zjsAK/xJ2W6?=
 =?us-ascii?Q?I4GRnrp3jDVcfxse65n42N1PJn9RcyHeX8Z59HZ70Ov597ZuKIfHHuZaeZew?=
 =?us-ascii?Q?b6DG6crLN7+/1jBlIfxwuaKxxV+YPdC7fTpsGMsqzbXAiFA1HuQtTuR25gjR?=
 =?us-ascii?Q?f8ocJ1apnXJczQmV5GkaGjweBgxxKhoWecEz3wLAIwYzjyDYHyu11JnsKYB/?=
 =?us-ascii?Q?ofSveBbtT650oKB0mxsG1KqHjaH9eCQ39W61z9F20N7+maJki+nIESwmQ526?=
 =?us-ascii?Q?5qp8ElJpxhnduKsqzTVubXKS8njwGw3xqclolRT4bjmjAUQtjmqqxUGID+6M?=
 =?us-ascii?Q?+/mofOHCac75Z1N7A3jMXLCIu375+62Gu8/ww6xFzAZzKt1l/7UxQnLdDyIb?=
 =?us-ascii?Q?dkKF8nS/39aqF7GvLHB/LeOuPjBIkjVG0qFR9JKFtTQQFg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F046C74DDCF439468F27C2292D0C22A9@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b19c49-41f8-44b5-59f6-08d92b91915c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 21:57:25.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0y5MSHNF+AaMH/E0fDCkHY+Dj4ykEbeoGTiIaC5pNRl6KIDf3VqhRDF0Psk8cZacd+j33j7+vaeS9e3SY+3JKEZ47UhyFKpViVZe7m4ytCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5694
X-Proofpoint-ORIG-GUID: 3cyxaO6KDqlVWsdcTr7cA1QCw0QgdyVV
X-Proofpoint-GUID: 3cyxaO6KDqlVWsdcTr7cA1QCw0QgdyVV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_07:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to
> query and set user preferred device reset methods and
> their ordering.
>=20
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  16 ++++
>  drivers/pci/pci-sysfs.c                 | 118 ++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/=
testing/sysfs-bus-pci
> index ef00fada2..cf6dbbb3c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,22 @@ Description:
>  		child buses, and re-discover devices removed earlier
>  		from this part of the device tree.
> =20
> +What:		/sys/bus/pci/devices/.../reset_method
> +Date:		March 2021
> +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> +Description:
> +		Some devices allow an individual function to be reset
> +		without affecting other functions in the same slot.
> +		For devices that have this support, a file named reset_method
> +		will be present in sysfs. Reading this file will give names
> +		of the device supported reset methods and their ordering.
> +		Writing the name or comma separated list of names of any of
> +		the device supported reset methods to this file will set the
> +		reset methods and their ordering to be used when resetting
> +		the device. Writing empty string to this file will disable
> +		ability to reset the device and writing "default" will return
> +		to the original value.
> +
>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
>  Contact:	Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 316f70c3e..52def79aa 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1334,6 +1334,123 @@ static const struct attribute_group pci_dev_rom_a=
ttr_group =3D {
>  	.is_bin_visible =3D pci_dev_rom_attr_is_visible,
>  };
> =20
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	ssize_t len =3D 0;
> +	int i, prio;
> +
> +	for (prio =3D PCI_RESET_METHODS_NUM; prio; prio--) {
> +		for (i =3D 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (prio =3D=3D pdev->reset_methods[i]) {
> +				len +=3D sysfs_emit_at(buf, len, "%s%s",
> +						     len ? "," : "",
> +						     pci_reset_fn_methods[i].name);
> +				break;
> +			}
> +		}
> +
> +		if (i =3D=3D PCI_RESET_METHODS_NUM)
> +			break;
> +	}
> +

Don't you still need to ensure you add the newline even if there are no
reset methods set? If the len is zero why don't we need the newline?

Otherwise looks good.

> +	if (len)
> +		len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t reset_method_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	u8 reset_methods[PCI_RESET_METHODS_NUM];
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	u8 prio =3D PCI_RESET_METHODS_NUM;
> +	char *name, *options;
> +	int i;
> +
> +	if (count >=3D (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	options =3D kstrndup(buf, count, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Initialize reset_method such that 0xff indicates
> +	 * supported but not currently enabled reset methods
> +	 * as we only use priority values which are within
> +	 * the range of PCI_RESET_FN_METHODS array size
> +	 */

NIT: missing period in above comment.

> +	for (i =3D 0; i < PCI_RESET_METHODS_NUM; i++)
> +		reset_methods[i] =3D pdev->reset_methods[i] ? 0xff : 0;
> +
> +	if (sysfs_streq(options, "")) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		goto set_reset_methods;
> +	}
> +
> +	if (sysfs_streq(options, "default")) {
> +		for (i =3D 0; i < PCI_RESET_METHODS_NUM; i++)
> +			reset_methods[i] =3D reset_methods[i] ? prio-- : 0;
> +		goto set_reset_methods;
> +	}
> +
> +	while ((name =3D strsep(&options, ",")) !=3D NULL) {
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name =3D strim(name);
> +
> +		for (i =3D 0; i < PCI_RESET_METHODS_NUM; i++) {
> +			if (reset_methods[i] &&
> +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> +				reset_methods[i] =3D prio--;
> +				break;
> +			}
> +		}
> +
> +		if (i =3D=3D PCI_RESET_METHODS_NUM) {
> +			kfree(options);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (reset_methods[0] &&
> +	    reset_methods[0] !=3D PCI_RESET_METHODS_NUM)
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user"=
);
> +
> +set_reset_methods:
> +	kfree(options);
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> +	return count;
> +}
> +static DEVICE_ATTR_RW(reset_method);
> +
> +static struct attribute *pci_dev_reset_method_attrs[] =3D {
> +	&dev_attr_reset_method.attr,
> +	NULL,
> +};
> +
> +static umode_t pci_dev_reset_method_attr_is_visible(struct kobject *kobj=
,
> +						    struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> +
> +	if (!pci_reset_supported(pdev))
> +		return 0;
> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group pci_dev_reset_method_attr_group =3D =
{
> +	.attrs =3D pci_dev_reset_method_attrs,
> +	.is_visible =3D pci_dev_reset_method_attr_is_visible,
> +};
> +
>  static ssize_t reset_store(struct device *dev, struct device_attribute *=
attr,
>  			   const char *buf, size_t count)
>  {
> @@ -1491,6 +1608,7 @@ const struct attribute_group *pci_dev_groups[] =3D =
{
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> --=20
> 2.31.1
>=20
> =
