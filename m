Return-Path: <linux-pci+bounces-22150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B4FA41570
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A0A3B32F8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A51D63C6;
	Mon, 24 Feb 2025 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UERUdkLk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058C1C6FEB;
	Mon, 24 Feb 2025 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378908; cv=fail; b=qI7HDmmZVgGWT9CzyK2EqGhfeqAJI7XktCp6rhk3PKBJeYj79aasVL66gY+h9lXPWeS6FQujCN761JrskoxfeP9LcPSGG2gkH9Pqrg0hHCo/oOu9pR/D2BWxBHeShm29dOMFyPUhbNnJ6qz+I4E4p3ijsmyPzpZU2awIdmvjDng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378908; c=relaxed/simple;
	bh=o0e5CR89cKynyePxnRUnIYUU7Ow5mNkSxN2D9pE6Ln4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXTJITY7a6Ty08nh+U/Ise3SdUVb+q5meeTQEfIci2QB3gTDbsvwtVBtI1R1JJgLjbj9VpVs/uN17u6aG7jccfAfyN1MEiu7+oPs2b/vCdRmt+O52RRhAXEeHpXEqGSrAJRGp2YwPTWr0GBDYDqtmmwwkCA6m5tB4bCZHuZ3bxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UERUdkLk; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWDA0F+U+PMQ6XGszTD4MB2GKctcee3KdO7QpmtDnMVOKtR4Cv+5lC70g54Pf2BlUp8ZK1phC+UDuFmWt6ZZIrylPcZkoi4oV4L6/Kej1tMWTtRotxNgDuJpz+xY1soGK8yzEfGkfjOLeuIaMLWB7JS84Qc2QFpbfWnnHtREANNpTEPyTedfA7a9pyDA9akGkQD++ZOFfWpl5HX76Rfn1+fl3R098NBkyQyMsHFIkvdWW4yZJsi4RPVimLr26Bqpza/z5MXKxNEdhk7RyvAcVtd08JKPrF15kVaHQdkrKlNBIVE6ONdY/1/CtYif7Ob5H9gkqZSlQWxSbN8sSvr6vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqHbeSl8cwKwLOJlPkorlZ6nNaVqez1NC6VPod1i9v0=;
 b=Xkf7Vo+Dntb3mmVzj3rsazSOr6SFbUqo53cRsunkZ8BJfbd5ZMIug6eR+XQOJb1164ibuYUJI+dBkGBNOrq3qoeC+QlAm3I/hoQzq6wU3PeMDtN/mRA2Fe6JYxy+bqK7RcOR8Bo4nxD/Algr+PH8l870AK/58RcbFDbyPEejt5AyiFzZjGysY1v9KsDw5qJBQb4m1VxWKITw8vqs85YaV3/z2MIOVlUFq4qaWyuLT7q6jAD0VujUia0PtpsakS7EDCZRGdarBSnU14DZ9cUCjB8p7wn1oT7/tQ6K8fjqtpfvieEo9ZwesyggL80y/hAklg1d9UDA1hIxCEu5BZBoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqHbeSl8cwKwLOJlPkorlZ6nNaVqez1NC6VPod1i9v0=;
 b=UERUdkLk4CavDfznhM6C6a4Aqttb7SqYzcsqP+lKF9A+HAkqE6bIX5hF7DLYGxcwpR7UbNZYKUEQNMLHVWlWXiE7qDgJcqN3JdRjZwipAuELGAHvpUALK50agEwdPsyy7+N1GqPnZGTtCBGdmi+buGBYPMuScTCrQgLJtaNJq64=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 06:35:00 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 06:35:00 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Thread-Index: AQHbgQ2AaHkh28uBDkKj7of8FdlNDrNWCiuQ
Date: Mon, 24 Feb 2025 06:35:00 +0000
Message-ID:
 <SN7PR12MB720170AD6430415A10A3F0118BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
 <20250217072713.635643-3-thippeswamy.havalige@amd.com>
In-Reply-To: <20250217072713.635643-3-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7455fd6f-61d9-4b17-8eda-de78d2b13d5b;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T06:34:21Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS0PR12MB7971:EE_
x-ms-office365-filtering-correlation-id: 5798617b-61fb-4f1c-4d35-08dd549d5d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9ueAU/8pisAf7WOnGA35TkUMWoWZHcQPR44Y1r2uZ+TaMxFJa0DKUSNnuhGc?=
 =?us-ascii?Q?VYkOC0OSKIKiiRvgoV3glagNvhMhbEClytkiWeaRQAiLNo8BQHvvrx83+zNO?=
 =?us-ascii?Q?zlK6i7QUlGA9OUs/m6OGiTs7sD+MuF9sbMJQl/b+eb7P8voIWbNjv9MXzdzb?=
 =?us-ascii?Q?jhnvK+tl2u8aNQB7A1kpU/0kuvSVHEFmyj3aElwTtxnVBv5FTKmKB/IRBLnm?=
 =?us-ascii?Q?IwtDg0/Pb+QH7+JN/jVujds/sQUg/jUH+uNwl29wxycEDiNnb7eMzt/oQ3Vs?=
 =?us-ascii?Q?sl0loXm1PLXAwv2utNIR79/Xc4oV6m+tLEl5E+UqFXX0nxrd5IxBbVE+SDQC?=
 =?us-ascii?Q?tttNonsTsW6hOIcQ1gSKOJPIl+nmxWn9Jqvl/7rSFbYtM9d+SCAczY5RO4kC?=
 =?us-ascii?Q?aqQ1BlsUrSDvgKpl7mjNmZt8ZGpQAnlzaYLSVsyOOL3GK2OQW9OwCXN1+lpn?=
 =?us-ascii?Q?j3q7cez1CGtECUT4KHnmPvXrAdPERg+yC+FsItq/UWQxtxQl14jSgOElqKuc?=
 =?us-ascii?Q?ADGylzgCy1G+pOGskL20QMfdqWyRpS+sZhiW00Uwlg+sd1jGiH8vsm770Xr9?=
 =?us-ascii?Q?Svu6QCwUABKSH6jroCUNILe8ryCyCfmNUuB6m+00tycSiiaoPf2b7IUgKQP5?=
 =?us-ascii?Q?AekWSMKsoHpC1lVogABkUgSKSstCtTQTdeewwg0WIvdyBPB/mc7opcF7K/k0?=
 =?us-ascii?Q?jvhB104qcxKkIMNBEBJ5rxzioG2KcUV9OFXpckSIeqH+WFuQh7kwAoxnUcY5?=
 =?us-ascii?Q?peJvGt16SSA3TW1urwbwRMWzcEP5DYppo2o6sON75Xv7xBEDGDmd1YpeQbN5?=
 =?us-ascii?Q?Pla+pDuCcEIO8yYOm/UQhZ/A0dSNehsYIlbtSysaBlaBRWQD5f+yDaGIfsPF?=
 =?us-ascii?Q?79cErBWOn0AJbaqEv9XYLNg2UcZ3MXfpkafOSvkocnQ4EYd57WNP6zCtvwhG?=
 =?us-ascii?Q?sWxygBwe5ldGFrLYt0MfYHQ9dlu7ONp92Gx+N5dAUY9KXJQXPMYevbqlcvmc?=
 =?us-ascii?Q?DnuNGM3oyXqyC/c+kst+kZnN6tOjb15pNIS66JEw6Lo2g94F+0wFboRp1Js5?=
 =?us-ascii?Q?El2MsKpcFJvT6UuAKJlLp/xJBQbsr6dwUuojee1UBen/gfRypw8RpUKCa5AT?=
 =?us-ascii?Q?pvt8C2ob2CUkQcfGAQ21+SInorELl7PJD3wLfhoLFgNK1H2bpCM9Bz+hq4qG?=
 =?us-ascii?Q?JRSgv6T/YlQovgSROrN7lOxFH5gjo8aSufL38xkpoeBHiT6dc5n4JQj95gNY?=
 =?us-ascii?Q?VVxW1lF+dLK3uXvi4T/PfEZOW1Efre0taLMSLvx5fuyaJ+91GHRkRbmN7WL3?=
 =?us-ascii?Q?KNPQRsMpZtBfwXpSjD5YmRA95umjRd7+im7peXz4SHJmL32XidItiJqyUWUG?=
 =?us-ascii?Q?vqGvM5pXvGp1ubZyGgJQrJio3Sk2tVOsRqzuPzeMjCw54c3gH7BDIiom0DCr?=
 =?us-ascii?Q?JKx6OFOg5lr1SqtZ8i58gOmbjLItmEGF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bzWSHA6fG9zk2J6Yf8mLl0qd6I5bqrqrGThJmieYcyzsSA9PziD5qjq1pCX7?=
 =?us-ascii?Q?cr/kZEPAIHR9DWjnpKGTY2QUW9UInCwUqJPcnAR+kFwjzQ9/S8+4d+E4tIJe?=
 =?us-ascii?Q?ae1qcSIGLC8wXtS0yyiTTpGBGfD1nE0W54X0SdDQBxdosX8mLfs46QqepThi?=
 =?us-ascii?Q?pbO+mdf9v+lbW7tsTkubmfGNODXhNnpHvU+XGVmBJDUbEuHP7D1DgrPWvgDK?=
 =?us-ascii?Q?nFdbQOyxmg4pG/RG8KmCLcRqx4hS35UroPCOKUl9Xm7ZOIj0kd/79n6/nBH4?=
 =?us-ascii?Q?A2q7wTz6XoBosAgHjgV6xj6cIahZKeD0JoTuxWY3Nj9rTuBnWtMFGFNzpPsu?=
 =?us-ascii?Q?H8Doq53qReEKfjL1m5Uv/wqV4llPl6dIM8yti3AJTUENyuRrHzWrof1EhhWO?=
 =?us-ascii?Q?DJ9V5J3e3+wtEC1FNFuQSkaggpyinYqRExQx4bKUh/xHB412s7f8glYLJ/6Q?=
 =?us-ascii?Q?a3iw1NFf3gah212N4j1wzrEOpQHmJ78q1HyFM+WyQ5ZinP5s9bP0OlTJfO0Q?=
 =?us-ascii?Q?52AJNaOY2cXuTuU4aprdRtq1TKCg4qmWHGBxjvRBslzAI7+EdoXvbo5ictSa?=
 =?us-ascii?Q?VOWKO5elAKcZANzsSh231ws7FLrMvQDgdSP7jJaUcm5LfdEu8ZX5+3GreXgB?=
 =?us-ascii?Q?oLXk9Llr/0GH5fl3KXqiOPE//UEpwmH8npzfAKf3uTmsdjjgkPQdt5C0FHjo?=
 =?us-ascii?Q?DLFPxYdU4X+DbBfQSa/p/q2Q8W91/ashZnpfq7PJNdSJWhVkZ9vlEM0HGlNi?=
 =?us-ascii?Q?Gn3npXkJ49RUoH8GsYNUa1sb5DCXdwbWPswIhOYvMgImjRBthSyyPhzjCYna?=
 =?us-ascii?Q?65PQmi6KNwsW7T+OW01QRYcBytYJV1K7wFCA1NbVg+NtrxkKh0sUzMXtNQYS?=
 =?us-ascii?Q?9g3Y0Fs4SsWj6XHVQTXbEmqq5i9ExLk/p7FjnkxqOoir72TBzwQYAydMsk+Y?=
 =?us-ascii?Q?sKhzlbQSx9PXjZkd6fw4T8VtRaaZBpiA/CG/1hSiIh3RpbhADCM0N7lTuZGV?=
 =?us-ascii?Q?JVJ0swaw2q8HGVi0geXXAszolVc9AuH1csR4Q9KqjY+9uUUcC3HiEkqeMJ7E?=
 =?us-ascii?Q?DucpUREOlUsphUYCuxSvQ+NqVZRfjcJXBmvm/tFYBQOq3uJA/G6sYSpDA/g/?=
 =?us-ascii?Q?/2jFJB3uZhpwfFCpUFnd49W/S1bRkEqQJ+Egv/RKt+3iyOx0RCDNOtkCJGf9?=
 =?us-ascii?Q?+VvQjec0pu6W8soGqvxRnePH9EnQSCPvLLRFszRs/lfbYr20ArESH1hZL1+t?=
 =?us-ascii?Q?pm7jmICFW5RCIBxp8bvzBi2BVDskw7dQtNeDKhnRBeFVSCr9RTKwN2pe8Abd?=
 =?us-ascii?Q?Y2ZkDOX6OzyTHkqgQVWdqZRZMXx+QIS8+w02e8WYK6QDXuUVpkZLzUzVAsEI?=
 =?us-ascii?Q?PyP8sSXUto7IJYCL989g5JTn6Og5Yndmj4iWfSmjv9/DBYXdaJEndeXXmGdC?=
 =?us-ascii?Q?6bkpCMSPBEgLKr2H2A0kG7e4OglUhzJj1EPmOmaM+z1PavxxPA+qwciYTxw8?=
 =?us-ascii?Q?t7xgQ+IzS29ar+Ncp6FiFNT60MYx0p+7vtUytFKy6L23oa346a19MnEM+EDY?=
 =?us-ascii?Q?qgcOmPHzazmN/1v3+Oo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5798617b-61fb-4f1c-4d35-08dd549d5d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 06:35:00.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5qSaDKyoD7judPys/7uFbA6YUk9v2UqlwK0X+4ZKqWE8JqcKA3BRGlBypGuz4sxumuXBKuLG/9m2lsLcbR98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Manivannan Sadhasivam,

Could you please provide an update on this patch.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Monday, February 17, 2025 12:57 PM
> To: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5N=
C
> Root Port controller
>
> The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> incorporate the Coherency and PCIe Gen5 Module, specifically the
> Next-Generation Compact Module (CPM5NC).
>
> The integrated CPM5NC block, along with the built-in bridge, can function
> as a PCIe Root Port & supports the PCIe Gen5 protocol with data transfer
> rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> configuration.
>
> Bridge errors are managed using a specific interrupt line designed for
> CPM5N. Intx interrupt support is not available.
>
> Currently in this commit platform specific Bridge errors support is not
> added.
>
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> - Update commit message.
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 48 ++++++++++++++++--------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 81e8bfae53d0..9b241c665f0a 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -84,6 +84,7 @@ enum xilinx_cpm_version {
>       CPM,
>       CPM5,
>       CPM5_HOST1,
> +     CPM5NC_HOST,
>  };
>
>  /**
> @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
>  {
>       const struct xilinx_cpm_variant *variant =3D port->variant;
>
> +     if (variant->version !=3D CPM5NC_HOST)
> +             return;
> +
>       if (cpm_pcie_link_up(port))
>               dev_info(port->dev, "PCIe Link is UP\n");
>       else
> @@ -493,18 +497,16 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
>                  XILINX_CPM_PCIE_REG_IDR);
>
>       /*
> -      * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> -      * CPM SLCR block.
> +      * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to CPM
> SLCR block.
>        */
>       writel(variant->ir_misc_value,
>              port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>
> -     if (variant->ir_enable) {
> +     if (variant->ir_enable)
>               writel(XILINX_CPM_PCIE_IR_LOCAL,
>                      port->cpm_base + variant->ir_enable);
> -     }
>
> -     /* Set Bridge enable bit */
> +             /* Set Bridge enable bit */
>       pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
>                  XILINX_CPM_PCIE_REG_RPSC_BEN,
>                  XILINX_CPM_PCIE_REG_RPSC);
> @@ -578,16 +580,18 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
>
>       port->dev =3D dev;
>
> -     err =3D xilinx_cpm_pcie_init_irq_domain(port);
> -     if (err)
> -             return err;
> +     port->variant =3D of_device_get_match_data(dev);
> +
> +     if (port->variant->version !=3D CPM5NC_HOST) {
> +             err =3D xilinx_cpm_pcie_init_irq_domain(port);
> +             if (err)
> +                     return err;
> +     }
>
>       bus =3D resource_list_first_type(&bridge->windows,
> IORESOURCE_BUS);
>       if (!bus)
>               return -ENODEV;
>
> -     port->variant =3D of_device_get_match_data(dev);
> -
>       err =3D xilinx_cpm_pcie_parse_dt(port, bus->res);
>       if (err) {
>               dev_err(dev, "Parsing DT failed\n");
> @@ -596,10 +600,12 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
>
>       xilinx_cpm_pcie_init_port(port);
>
> -     err =3D xilinx_cpm_setup_irq(port);
> -     if (err) {
> -             dev_err(dev, "Failed to set up interrupts\n");
> -             goto err_setup_irq;
> +     if (port->variant->version !=3D CPM5NC_HOST) {
> +             err =3D xilinx_cpm_setup_irq(port);
> +             if (err) {
> +                     dev_err(dev, "Failed to set up interrupts\n");
> +                     goto err_setup_irq;
> +             }
>       }
>
>       bridge->sysdata =3D port->cfg;
> @@ -612,11 +618,13 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
>       return 0;
>
>  err_host_bridge:
> -     xilinx_cpm_free_interrupts(port);
> +     if (port->variant->version !=3D CPM5NC_HOST)
> +             xilinx_cpm_free_interrupts(port);
>  err_setup_irq:
>       pci_ecam_free(port->cfg);
>  err_parse_dt:
> -     xilinx_cpm_free_irq_domains(port);
> +     if (port->variant->version !=3D CPM5NC_HOST)
> +             xilinx_cpm_free_irq_domains(port);
>       return err;
>  }
>
> @@ -639,6 +647,10 @@ static const struct xilinx_cpm_variant cpm5_host1 =
=3D
> {
>       .ir_enable =3D XILINX_CPM_PCIE1_IR_ENABLE,
>  };
>
> +static const struct xilinx_cpm_variant cpm5n_host =3D {
> +     .version =3D CPM5NC_HOST,
> +};
> +
>  static const struct of_device_id xilinx_cpm_pcie_of_match[] =3D {
>       {
>               .compatible =3D "xlnx,versal-cpm-host-1.00",
> @@ -652,6 +664,10 @@ static const struct of_device_id
> xilinx_cpm_pcie_of_match[] =3D {
>               .compatible =3D "xlnx,versal-cpm5-host1",
>               .data =3D &cpm5_host1,
>       },
> +     {
> +             .compatible =3D "xlnx,versal-cpm5nc-host",
> +             .data =3D &cpm5n_host,
> +     },
>       {}
>  };
>
> --
> 2.43.0


