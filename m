Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336AF3C3E18
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jul 2021 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhGKQyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jul 2021 12:54:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:47534 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230050AbhGKQyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jul 2021 12:54:04 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16BGncZV016028;
        Sun, 11 Jul 2021 09:51:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=o8F+HGOfT9d8N9o+NiSGntEeTQkmQ/x/oqd8JthmO3A=;
 b=M3UjWjxvmkB6fLwe9PFHbxlt+BztujorJ/M2txqgMlZLZ12ohV5XPGcYIpMqqeNT/bKl
 a0SdKeGkrbAMAivOwlJXe6pHSYXFGbXTRw74nrEzRw/ki2gqdOP74x1E524o1NYFVeAP
 enyYVuy0YxtAipaJZTQbkg9r9tJHEC5NRsuAlUoRC0hYG8brM8XgUgIV1B1wA0uf+lqo
 OURFBlA8ijvsmilQFWmK1ojd1tRxlZVn04IdW/P7xBb6cko0dsk9o75uadUNOiJxAfpI
 3pbU7RuPOfVtwTRja9oRYTzDqK74/fArzrxF4a2qiz3UVwhyif2NOeCUiew6f+8YfRuQ Jw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-002c1b01.pphosted.com with ESMTP id 39qamjsna2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jul 2021 09:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGBvMRc9gkelLY5uML32Lj6Yrh1K0tgqcm31WfCdYsuzK5os8OtbFPqPCypS51e3KGkfl+XuqOFAoTU+Er13/XHiVJ4LI1sIj01WwGjdKqgWNOwxeUM4Bktk9/v43kGxtOCXRs9WZpJyurciggYlqE6n3XP07XQEPzPkK9xPKuTZ6FD9GnNiyBp0ytcO6vw20qufj4cTkNRQOUm7PpqI6f5D6wDJj0yi/92RFtCGAoJ/2osgcwZDHrHm0YRrrIPDi2ev1js9gM1dlgRR1TVMxUR5hhj91Y1C71sIpKskLV3Pd/gP5wl8vrnPTtq0BmmzC+44/9mJVWcSUChHevXKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8F+HGOfT9d8N9o+NiSGntEeTQkmQ/x/oqd8JthmO3A=;
 b=YPHfqAfFjD8qpGbspt0HvVZ4cBX6NCDLLvYh2iAWLMqj8HTFalhdiaMJ5MGsPire62fTvkweoK0CZLI0GraMx0e0S9QW6S5+xMzEn4quFNzKBbmfiwzvetqPLCE05tqzz2fA7r2iWvB28ZtoKGXm/AU4WVp0HibyMcFs4P9JXJ1D/1WQcaqnZLa7fKwnzEWYsxRCfpHweTD9yXBHoNjC9ydGjJ7cjEgaR9EtqKXwAE3cEkQZGgaYd8z/2uqMEnh+CXrEPhz5R3fO0jIBeJ5Dcg06TfqpvbC/IriJaghhvJ9aNIvSwxmRAr2T+KfwZSmsmnnp/n7ckbZh601HFgPCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from SN6PR02MB4543.namprd02.prod.outlook.com (2603:10b6:805:b1::24)
 by SA0PR02MB7241.namprd02.prod.outlook.com (2603:10b6:806:ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Sun, 11 Jul
 2021 16:51:02 +0000
Received: from SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59]) by SN6PR02MB4543.namprd02.prod.outlook.com
 ([fe80::182b:62b8:51c1:ba59%5]) with mapi id 15.20.4308.026; Sun, 11 Jul 2021
 16:51:02 +0000
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
Subject: Re: [PATCH v9 4/8] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Thread-Topic: [PATCH v9 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Thread-Index: AQHXcaktjT4W9oc3UEOmIGnwEgPzR6s+BoMA
Date:   Sun, 11 Jul 2021 16:51:02 +0000
Message-ID: <20210711165056.GA30721@raphael-debian-dev>
References: <20210705142138.2651-1-ameynarkhede03@gmail.com>
 <20210705142138.2651-5-ameynarkhede03@gmail.com>
In-Reply-To: <20210705142138.2651-5-ameynarkhede03@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b20617e3-74c6-45bb-017f-08d9448c1134
x-ms-traffictypediagnostic: SA0PR02MB7241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR02MB7241AA1FBDCB3C76181D300AEA169@SA0PR02MB7241.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjXFlwjf7V31Poy6EtGE8bc32nkfSq7VYm82HInrnSWSpSWwRNvqHQ+zEQaZ304vaywKXDQihYcndumoUcU7abN//ZJApX3NfyqVyFUOJnu+qSlYWw1vZsc3ICv5YZMswROA+ao1hMNHIU6bJp9tXr/8O9LEhTEl83pmUF1RQwsPb7CmyGTBCEcM/F8KArYvqAUMhTra5dgwwesDcxNcOtnJuR6yTFhD6ck9wQsbRftTIOSsVcn7KhEUQNxp+M7F1BrlKe9h710m2rOYrQgivbxyDgGNvmMDHASkiywhCfRc7t8glhqd+aY7xjb59uS5xo6fAZp0p01XN1U3GcOYHPas0Xf8yg07Z9PrQ+q4BXd/VQ2FIq2q+A1ADcux5oZ80zUI2ysh7Lox6kNldHi6BYkqpVNtyLdn6e8+TrP6Le1pTV6vr0OYXZaaHQxfjCYkAuGV4RLkHukWS0nqp1kanvrvbj0tDupt/RjxXc4ID1rHIcoK7n9ZdwgNeIlyLvVi+WkMJgY0W+XTKVu3tDxMTn2p+yAEBuFpOIK8XikQdePZ57GtX5nEZ9ywEYJHQB1J4Po1OjQumywe614cEvieulz0uNq7Mm+DVls8D9WJzuwrkS3pRzQmE1JVIs8BzActsKEqk2yrKbZ8N7nD/tzBAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4543.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(396003)(346002)(39850400004)(136003)(366004)(8936002)(38100700002)(33656002)(83380400001)(76116006)(8676002)(6916009)(4326008)(44832011)(6486002)(86362001)(7416002)(1076003)(9686003)(64756008)(54906003)(478600001)(122000001)(91956017)(186003)(66476007)(66556008)(316002)(66446008)(71200400001)(5660300002)(2906002)(66946007)(6506007)(33716001)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WacBp6kc9PrjGBc90hViMWH2yMz6woBrwxbBtGc4ahomgKsqeoSfdp2E+LfC?=
 =?us-ascii?Q?sgylQleUhMEIzpb2kNshRtJGpk+od9S5vofOq1o7BaMxXwuMmgf4WWoKx6hG?=
 =?us-ascii?Q?IgghC8UtkcRdYET3om/qu+Vn8HFJ3Bji6CCLqUMeJve77Q7KggwS/mSztC6C?=
 =?us-ascii?Q?nff5PaeesVoDE9QZNBECc3LJ6n3Qx6J+aUxrnKgAMbS2d4Bl6BDauBtr5Gye?=
 =?us-ascii?Q?SY4o+ReYE1arpXglUwIrOzc2O31rFsKoZPrsrl4cGQL8jO34vd47zFVDNbqw?=
 =?us-ascii?Q?a4t0bfCbyr8j2nAnNfY9ZXsV3t+8j0WoLOZhAZh/SV3fK3LOAt0FtMHaIDtr?=
 =?us-ascii?Q?sdI/1WmMr/BId9afLs9Uc5dSmjPmJxqJk4IqlxUHCscDB+2i0ImYf66X36rH?=
 =?us-ascii?Q?wCNl/AGH/5alvbk8oClywmJKUCDR3LWnKi9Z8WqXi9jPd0ikmjJqYgCYnLi4?=
 =?us-ascii?Q?Dni9/5o4zssvlD5t++XHjLwkVt/O3LTa0jKw8zO7hP7cWoPvBFdoUS/netei?=
 =?us-ascii?Q?Vr1MEoZn/aEgIkBNadpB/qUY5W/chSycTEmcc1ztc2db50G0DKKQy6RT/5IS?=
 =?us-ascii?Q?wWy0vEltUvEih78KWvioXo5iM+O5Fo8le8LVHNyQ/sq7yHC25NQDQ9/Rqk8w?=
 =?us-ascii?Q?DY13HFysdGpRYSqAiuLItby8EmjS2Le5OvSnlFD23uWSB3nrO58mqDFO1gN7?=
 =?us-ascii?Q?eAGNXA51HRmNVgrex+K/Zlxzlq1nXMh4+0y2AEFNRV5Ri0IlwT/9iCA+lHaw?=
 =?us-ascii?Q?m1eG7uDKpfANWLT7D2w5ffDShraO02LLNSjprggtuoDZ9Dor18wCgskhxwgM?=
 =?us-ascii?Q?fZNPaKMWRokfxR0rCNChgi+thkBSonXukqhIMBQl7olZK1tJ9qxqZDEF81xV?=
 =?us-ascii?Q?I8OsGUSMDn7PvsslTlaqwO7CvJKQgX/D4RSwt0BOstJjcIb1xMf0qzycirqg?=
 =?us-ascii?Q?su714z6Ka0Grehi4Fm35aERWKbUt1EhEr6tZ8xIzF2xlUqwJAwymaaTE+6GM?=
 =?us-ascii?Q?o700DFplKkyEfPyVVLGuELLdhxbGqEgAAZhP6RLHc6vpk37LV3bohQjT47K5?=
 =?us-ascii?Q?2malBQzo0NGbbM/7VigVwER0Sr3Q4/zNCBNE0rWeADterBzL+WC8ghD17n0i?=
 =?us-ascii?Q?ELZauvYUs5Xoqc6AOLfS6fb6qj1b3ViAOUMGtYDlBNqa487IWJpyTDQXm5XR?=
 =?us-ascii?Q?g30gVTGc3ry/IhUA0BX9qH/vMN6CuHy7EItk2eN0WBWMioaYqNdxlWTe/GK9?=
 =?us-ascii?Q?0MX3JGBN02uWwXYD8ROSt7qSYH/9awl9QQWvi5+gjTNLIf3aFLKEhQDrvK3S?=
 =?us-ascii?Q?jJocORRXVPQFhCMq+hCE5tHt?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A959285D80C9E446ACA6FE9D346CF7D8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4543.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20617e3-74c6-45bb-017f-08d9448c1134
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2021 16:51:02.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3sPu4UMshBUNV+k9DUcK8g641j0mWdDVisquKZoEXoOuVJVjbb2koaAD8OF6kgq71luBHw/Nj1d7C2F+ymC+xnkRU8dXjt0gp3cQtrcLNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7241
X-Proofpoint-ORIG-GUID: -o39XnhOpTBypQStR5uMu34AU6bD2oN9
X-Proofpoint-GUID: -o39XnhOpTBypQStR5uMu34AU6bD2oN9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-11_10:2021-07-09,2021-07-11 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 07:51:34PM +0530, Amey Narkhede wrote:
> Add reset_method sysfs attribute to enable user to query and set user
> preferred device reset methods and their ordering.
>=20
> Co-developed-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>

Just some spacing NITs.

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  19 +++++
>  drivers/pci/pci-sysfs.c                 | 103 ++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/=
testing/sysfs-bus-pci
> index ef00fada2..43f4e33c7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -121,6 +121,25 @@ Description:
>  		child buses, and re-discover devices removed earlier
>  		from this part of the device tree.
> =20
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
> +		Writing the name or comma separated list of names of any of
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
> index 316f70c3e..8a740e211 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1334,6 +1334,108 @@ static const struct attribute_group pci_dev_rom_a=
ttr_group =3D {
>  	.is_bin_visible =3D pci_dev_rom_attr_is_visible,
>  };
> =20
> +static ssize_t reset_method_show(struct device *dev,

Nit: spaces on the following two lines. "struct device_attribute *attr"
and "char *buf" should be in line with "struct device *dev"

> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	ssize_t len =3D 0;
> +	int i, idx;
> +
> +	for (i =3D 0; i < PCI_NUM_RESET_METHODS; i++) {
> +		idx =3D pdev->reset_methods[i];
> +		if (!idx)
> +			break;
> +
> +		len +=3D sysfs_emit_at(buf, len, "%s%s", len ? "," : "",
> +				     pci_reset_fn_methods[idx].name);
> +	}
> +
> +	if (len)
> +		len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +static ssize_t reset_method_store(struct device *dev,

Nit: spaces on the following two lines

> +				  struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	int n =3D 0;
> +	char *name, *options =3D NULL;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] =3D { 0 };
> +
> +	if (count >=3D (PAGE_SIZE - 1))
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "")) {
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		goto set_reset_methods;
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
> +	while ((name =3D strsep(&options, ",")) !=3D NULL) {
> +		int i;
> +
> +		if (sysfs_streq(name, ""))
> +			continue;
> +
> +		name =3D strim(name);
> +
> +		for (i =3D 1; i < PCI_NUM_RESET_METHODS; i++) {
> +			if (sysfs_streq(name, pci_reset_fn_methods[i].name) &&
> +			    !pci_reset_fn_methods[i].reset_fn(pdev, 1)) {
> +				reset_methods[n++] =3D i;
> +				break;
> +			}
> +		}
> +
> +		if (i =3D=3D PCI_NUM_RESET_METHODS) {
> +			kfree(options);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (!pci_reset_fn_methods[1].reset_fn(pdev, 1) && reset_methods[0] !=3D=
 1)
> +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user"=
);
> +
> +set_reset_methods:
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(reset_methods));
> +	kfree(options);
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

Nit: ditto - spacing.

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

Nit: spacing following line.

>  			   const char *buf, size_t count)
>  {
> @@ -1491,6 +1593,7 @@ const struct attribute_group *pci_dev_groups[] =3D =
{
>  	&pci_dev_config_attr_group,
>  	&pci_dev_rom_attr_group,
>  	&pci_dev_reset_attr_group,
> +	&pci_dev_reset_method_attr_group,
>  	&pci_dev_vpd_attr_group,
>  #ifdef CONFIG_DMI
>  	&pci_dev_smbios_attr_group,
> --=20
> 2.32.0
>=20
> =
