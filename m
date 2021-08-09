Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743943E44A1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 13:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhHILYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 07:24:21 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:58162 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235152AbhHILYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 07:24:13 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179BHauf031225;
        Mon, 9 Aug 2021 04:23:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=XahGUUgZOHeGUUZfEJRqpK2InKAU4huPvp+6gQ7bRfA=;
 b=j3HQBcZdiZtaWGM99tMFHkak8QXekQXi4lbuGvAsFZwXbFqOfPeVPDnxOOKDiEZpvtCm
 y780Tkr/AXFZcP96JTAJxa265clb34hTYiirNRj3REs5zOJxj6m5LpYwjQNM7BFMlKH5
 IPjml+27+Qb9WxX0zFbmFcZ/zvy4F8aucHFAXgf3r9uYU7vfd8z6Kxe9RjVZJ+hYsQSW
 fR6xKJM5rElqzbLOsy1u6MhxBeOwDn0MqAr1UxNTQT+baNUY1aCDlcn0lbi9jLtfIbgl
 xiV9j6cEQHlPwgW7fFF6o7ZLY8wsx4ejPNScw3mnYOAbVfxTk5MOZp05nNBy5cUB7F2E 8w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-002c1b01.pphosted.com with ESMTP id 3aawfq0mm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 04:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMtFBR2lVYpx1VPAXztIEgtLyDgl5TGt0HEzp7HxiFyb5kQXZPtFfpYTOS8iKQPTynG0l3m4pahquYUb8Fuv1eu2sX31rHly8QfAfnvzYRe8MRgZBlNjzLX+I+vFYpcSKf1trCtkP77NBkYwC6M9NdokdmNvMrB2mawwJOnnN3DDWg/sqqX0zeN0G+XlBCNGldYeOZRfPPmngHBSgNmHWH+NS4HlD8m337E8GOZh4qSo63797mlaZ9DIcqf29Neym1b8pU8RnM6za5yTc4zZfJXIOGiwyV2kqLwVVwh22p0CPJ1Mj16e2JOB0CXrlFMUawKx0krePlaL4jyNWyBsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XahGUUgZOHeGUUZfEJRqpK2InKAU4huPvp+6gQ7bRfA=;
 b=NEjPGdg4wCZWHWRnBlqKokT1JSSA8PfzjmdCRiAXinKgl/px0pIIzD3Lu+zh8WsfGvYj2DaB6a7VENPzACP7OdNIl3VGdHzhep3VtoDljPVcK6XwTPJ/h2iFxnQS5pFsPawb7fvVYFdrPMqXBbbsndrlWcuf5rGay+V/pKVtoeWwqJhq/Qei5OuTRCA1cnHwg+f2Mw7E2F1tlV+ai0aNC+ketQxl/3hiuCqh6z/LOdIFfyibE6U7z5DsNRQ2YqAt9gbfnuTRfUAsAGDC6KSu3u0j4dJn0ErpZbmX6MOSsFP7SzXjKxlPAg0HC9YpfCASyEaSGEGP3brgxayOWlXAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SN6PR02MB5165.namprd02.prod.outlook.com (2603:10b6:805:68::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 11:23:38 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 11:23:38 +0000
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
Subject: Re: [PATCH v15 5/9] PCI: Allow userspace to query and set device
 reset mechanism
Thread-Topic: [PATCH v15 5/9] PCI: Allow userspace to query and set device
 reset mechanism
Thread-Index: AQHXihci2YAVgm4jNkqhvqARRnIzaqtrDc+A
Date:   Mon, 9 Aug 2021 11:23:38 +0000
Message-ID: <20210809112337.GD867@raphael-debian-dev>
References: <20210805162917.3989-1-ameynarkhede03@gmail.com>
 <20210805162917.3989-6-ameynarkhede03@gmail.com>
In-Reply-To: <20210805162917.3989-6-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60986c8f-d960-4ea4-120f-08d95b282295
x-ms-traffictypediagnostic: SN6PR02MB5165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR02MB51651B9A7AE5F6297A4DD0F7EAF69@SN6PR02MB5165.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UkF3Kvl/zD4WKNjYzFVIPGhaFLBxaMYacuTQZ+KGEmOv4PALZ/hIZ7JOxU9fYqd+teL0TqpSflzdfgJfFIcqbXr6DjjP6BIm5ypGP3NUHiD+X7Jweik2jrhy80fP4OEjJQ/EebcQ61NZ4kWh4Q97ioWKJg9WgALIV68/IBAwqjpk11xNBFLWFvN/PL6M8iRkwWTCvzccPmArzK8WGuFoPBAjIIie9uPWTjjiN10PRgzWvwfvTkMdcBXFbODqnVoLp6pX8VXwcC/wakZUsVFRBW1aqigaqbb4oV69OBPD8XS86XHHvxv1LdwCew/JZOiSN4Rqu6B5w9PfFwIDljczId9rYa/xgSYIIkF0ZGS4AoMkTz/TYRxQjHtRV8HZ4FlFtEv6j479gZlLNu2cavSJtj6a/8jQMHBofvk7TJ2NOS0mNxPaseIIZQa7ifcQI24IhJ59wyU8K2RWZdPdV435ZirTzEzYhC0pKJnp+8MR+sBgpFjSerXbkAxEJHr1VF+I8YQHCHqkHcijfsS+CVGk5sFJSaUB3PWIspvNQHsBhyevkCetNgCTgfyJtPjWVekE5O3WQNIalFdLnRdBJ7Q6utuKYN8/4YrwVKsgqakBgJ4MPHUPzvj7/nari/n08RqTicAxayIF3K+cEWa9Y36w63hlokjD2wIrHIZFIAuba0Vze38IxAcC5LhKDUXqh3rUILY/Qg4gmy9vAEwSiKvYJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(33716001)(6916009)(122000001)(1076003)(186003)(4326008)(6486002)(66946007)(71200400001)(508600001)(66476007)(66446008)(38070700005)(38100700002)(8676002)(5660300002)(7416002)(8936002)(44832011)(64756008)(76116006)(6512007)(66556008)(9686003)(91956017)(33656002)(316002)(6506007)(26005)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KBUBZ7hvyxTTGwr28JZnC6yWMxNrofVqyCikhe2cwN9SEnb3yPnArHWyDhYA?=
 =?us-ascii?Q?cFS8mjmLM3RgpX8tQQ9XvDOsttGzrnSj+tjImtPE3wC5xqfHyt8vxPx5RCoA?=
 =?us-ascii?Q?novmH0uNk3K64oA1/DiGQZ2dfpD95H7Nu+dG67bs2XERBCHyyWJix5XuOZEx?=
 =?us-ascii?Q?yAlUMY8H/1DetB1w2rsFg0zM3cB5kOfyowllbHrg1ag/2PeA1/Qff2v/WiV2?=
 =?us-ascii?Q?+2Bcd7f9ejcpD2wr/Eqt5LND454Em1vAJFMdC3Lb7DIotjd2V/6bvo+fXaFi?=
 =?us-ascii?Q?8oVU2zEReWDbmZKwhHTtfkIXU2Z+YUrUQ17ffqEAdhFJs7oLl+ZjZzS8wPBX?=
 =?us-ascii?Q?Cz0S4rZpGp130PRYrwu/Ta4/BrX2PAjK9b/PHOhD8uCGuoLhuuvuijAUvNGq?=
 =?us-ascii?Q?rklAqO6mJKqOsU4NH+aEK2bm7FIgK76/PabY6SXHeTqvcD25kB1NBVgnmacF?=
 =?us-ascii?Q?CX4Qzd6ARWEqxdtlqE7uX/g8L2vsdyQ0ITWGZkrbS1i+I8cnbNP8Z7jeo8mh?=
 =?us-ascii?Q?9XHSljvO5PJZOFrp9Y6ez43HFst0CvsqqDzIMpIqXmsHUxPoAzzpjNuO/p7A?=
 =?us-ascii?Q?kYeCM6t4XbJClA4JmIpGQzG/GDC9ht8qTiBTYDCBKX6vXx3KS1/h0KQ+nm23?=
 =?us-ascii?Q?1GR7hr13kDmpklEO2+pw+iqmBbg9ybTkBw8VoIglvtbIdu5HttnQoxxXGePB?=
 =?us-ascii?Q?O/oFC69c7yWg/JG1+rQG13+6gCsaAE1CMkDs2R3mPbMmwlorf5Ta2hJg4tP9?=
 =?us-ascii?Q?CVO6V1ER449alr7T9aJ+vmcuI3DAjEBXtLDvrYGh0ZdZFCLjmh6AN1X8oRwS?=
 =?us-ascii?Q?3oKWP0H+4wZNzuySXyVVobJxLxfd6rF9YJHglQQUg1pHzhrdUMhtbCGqtXDK?=
 =?us-ascii?Q?ZEFd24fcJRtB9ELRNkI3OSF76mrWwADAkmnavsN7MO53k/HVyzQgasleFKbt?=
 =?us-ascii?Q?3RxsAi2Fay4SnVBWiB7cQuTE2jq7zj4B3xldmVV6kU1MAkFnxxMl6CvosiVG?=
 =?us-ascii?Q?T8YoKLKERFC4/T8aQ6fz2J5wmNNKLR06MPpk/7jOETFUm+ks8EDt8NiN45JZ?=
 =?us-ascii?Q?zwr4LI4qYzltsWgfak8SBXTH23FItLZQjc4kpbrI2wVVUMicKhIEV8jcUMl0?=
 =?us-ascii?Q?FEVetaTuN2T7K2nEvPYlfS8FhrV9Mew/SdJ6Fd1ugMD0Iboargp0i16IvaII?=
 =?us-ascii?Q?SJGjIwkKgG7gf9czxwR6D76A7U+b4WtcT2XGn+/oU5o+iKRvyqK5uat5lnBP?=
 =?us-ascii?Q?GdmCk7Rw/cG2x0tb9q5DD5EkO5tHcDb0DAZI/hJwCQLmanSl/xRrT1Lu8U3c?=
 =?us-ascii?Q?/o0e3Y8zXHQSi7OOropz4O8k?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <485E4A14AB98474A87AF97371EF03091@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60986c8f-d960-4ea4-120f-08d95b282295
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 11:23:38.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0g1iHhJ1Gw4Ne1xn4xxNbyWUGudUAJJmqhg/eoDpeDnRDxLpOeZ1QQzFPwodBJoDu0Z68mQcWwJlJknsYaOobECJOXywesLyOhnu6y3Ulo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5165
X-Proofpoint-GUID: qEvf4E87mDTD2GfrgXNIpXmTnEUWI-l9
X-Proofpoint-ORIG-GUID: qEvf4E87mDTD2GfrgXNIpXmTnEUWI-l9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_03:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 09:59:13PM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
>=20
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 ++++
>  drivers/pci/pci-sysfs.c                 |   1 +
>  drivers/pci/pci.c                       | 117 ++++++++++++++++++++++++
>  drivers/pci/pci.h                       |   2 +
>  4 files changed, 139 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/=
testing/sysfs-bus-pci
> index ef00fada2efb..ef66b62bf025 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,25 @@ Description:
>  		child buses, and re-discover devices removed earlier
>  		from this part of the device tree.
>=20
> +What:		/sys/bus/pci/devices/.../reset_method
> +Date:		March 2021
> +Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
> +Description:
> +		Some devices allow an individual function to be reset
> +		without affecting other functions in the same slot.
> +
> +		For devices that have this support, a file named
> +		reset_method will be present in sysfs. Initially reading
> +		this file will give names of the device supported reset
> +		methods and their ordering. After write, this file will
> +		give names and ordering of currently enabled reset methods.
> +		Writing the name or space separated list of names of any of
> +		the device supported reset methods to this file will set
> +		the reset methods and their ordering to be used when
> +		resetting the device. Writing empty string to this file
> +		will disable ability to reset the device and writing
> +		"default" will return to the original value.
> +
>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
>  Contact:	Michael S. Tsirkin <mst@redhat.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 316f70c3e3b4..54ee7193b463 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1491,6 +1491,7 @@ const struct attribute_group *pci_dev_groups[] =3D =
{
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8a516e9ca316..53d73770881f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5132,6 +5132,123 @@ static const struct pci_reset_fn_method pci_reset=
_fn_methods[] =3D {
>  	{ pci_reset_bus_function, .name =3D "bus" },
>  };
>=20
> +static ssize_t reset_method_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	ssize_t len =3D 0;
> +	int i, m;
> +
> +	for (i =3D 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		m =3D pdev->reset_methods[i];
> +		if (!m)
> +			break;
> +
> +		len +=3D sysfs_emit_at(buf, len, "%s%s", len ? " " : "",
> +				     pci_reset_fn_methods[m].name);
> +	}
> +
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
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	int i, m =3D 0, n =3D 0;
> +	char *name, *options;
> +
> +	if (count >=3D (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "")) {
> +		goto exit;
> +	}
> +
> +	if (sysfs_streq(buf, "default")) {
> +		pci_init_reset_methods(pdev);
> +		return count;
> +	}
> +
> +	options =3D kstrndup(buf, count, GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	while ((name =3D strsep(&options, " ")) !=3D NULL) {
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name =3D strim(name);
> +
> +		for (m =3D 1; m < PCI_NUM_RESET_METHODS; m++) {
> +			if (sysfs_streq(name, pci_reset_fn_methods[m].name))
> +				break;
> +		}
> +
> +		if (m =3D=3D PCI_NUM_RESET_METHODS) {
> +			pci_warn(pdev, "Skip invalid reset method '%s'", name);
> +			continue;
> +		}
> +
> +		for (i =3D 0; i < n; i++) {
> +			if (pdev->reset_methods[i] =3D=3D m)
> +				break;
> +		}
> +
> +		if (i < n)
> +			continue;
> +
> +		if (pci_reset_fn_methods[m].reset_fn(pdev, 1)) {
> +			pci_warn(pdev, "Unsupported reset method '%s'", name);
> +			continue;
> +		}
> +
> +		pdev->reset_methods[n++] =3D m;
> +		BUG_ON(n =3D=3D PCI_NUM_RESET_METHODS);
> +	}
> +
> +	kfree(options);
> +
> +exit:
> +	/* All the reset methods are invalid */
> +	if (n =3D=3D 0 && m =3D=3D PCI_NUM_RESET_METHODS)
> +		return -EINVAL;
> +	pdev->reset_methods[n] =3D 0;
> +	if (pdev->reset_methods[0] =3D=3D 0) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +	} else if ((pdev->reset_methods[0] !=3D 1) &&
> +		   !pci_reset_fn_methods[1].reset_fn(pdev, 1)) {
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user"=
);
> +	}
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
> +const struct attribute_group pci_dev_reset_method_attr_group =3D {
> +	.attrs =3D pci_dev_reset_method_attrs,
> +	.is_visible =3D pci_dev_reset_method_attr_is_visible,
> +};
> +
>  /**
>   * __pci_reset_function_locked - reset a PCI device function while holdi=
ng
>   * the @dev mutex lock.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 7438953745e0..31458d48eda7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -714,4 +714,6 @@ static inline int pci_acpi_program_hp_params(struct p=
ci_dev *dev)
>  extern const struct attribute_group aspm_ctrl_attr_group;
>  #endif
>=20
> +extern const struct attribute_group pci_dev_reset_method_attr_group;
> +
>  #endif /* DRIVERS_PCI_H */
> --
> 2.32.0
> =
