Return-Path: <linux-pci+bounces-5476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA6893A3F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EA2281EB6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Apr 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F5171C1;
	Mon,  1 Apr 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCnufNMV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E41854;
	Mon,  1 Apr 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968021; cv=fail; b=DDmxZbW6BnM88K3oOdJsxYDc1gUxSCKBzmnjeqykEByP49yGuvtFukgJsFV8ATXON4XZ6L4exIJR4G1SMgJvYlGnbxl13bMjEOa27E8zCnGl9faWOllwRG0szbHRMhan6hnkizdU4mUzm3lhh82Owc2gxw96wysl6izY9CLqOUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968021; c=relaxed/simple;
	bh=rUT207YYuJo5B2yrZJGMiaxQBllVpll9IUouFgrrgRY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dgOxjUAhhAx5jyiY5c1AjEwc7Mn7xUSGXhAEsgNbmdyp/BLM3zZoKiB0AU/MccPOEd/B33bfcRcI0suI38lGyLuOGw9UtaOjkWgV7Gy4UjlUrAqkfVU475LJGunDgRbVKEiQpqJOrkDDuco3blxYPVim/TYbwQKQok/omuzTG6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCnufNMV; arc=fail smtp.client-ip=40.107.243.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WugyfQDMnIxiqeP9Lxag84IXC6hJAumgUK3Y/2QHYmarUSeaQJtzCFr+tcjVxAGPh2d3440AbqE3XWkqPFL1gGV8xgZAelW1Rr+BjlUWPAAQ4W/c9blT6zAWrCCzNXhi051Y5Ty0rshOLcz6HlFG49i3zyV537OsIr+liM1ZRUeYAZQVzOMf3klkbxcJpyNnp2TzbVneyPX/5Q1nb7mB+DxGg8gXnLAwI81g3KEnaeUROU0vk3ydmf3c3YkTjlSpOAdhaWhMD3/Sf1Qk/vOlEvlpki+9bwIkc8TztNFZ0VqN7vqEVhEBFfYl4JWowrbcZ6g5VyxPYX7lBV44lKfPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUT207YYuJo5B2yrZJGMiaxQBllVpll9IUouFgrrgRY=;
 b=k+DLgPvrRKm9jPw5hU0PM6pqR6BiGUmUXXk8SNTj5VJyyvDvemL2aUVmcYNmPlHtA7uQI3xIscqA6tYBjAhvBnXfzPOm1qc89VF+1pKjoUBBbhGE6RTf3OnZttKgSEj6vlTx/0Fu7kyZ+PPAHdzyZZRUIuvqq6HNIIr6/0xbw7Vctp8nJ2Rq0vXx+pdRSBah4j4g7wkfUNmyINsRV5uLcMkivhrMj5mEayEDBI+jA8vLfxeecIiL0w1by0FB8hX0ZoWjCrJbL41qD0K71HG1NYm13NgQShYhY6TjdQcu0X/VSG69asVzH0pz3gomXCudAnAd53oMkPsb/RGdwD1pkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUT207YYuJo5B2yrZJGMiaxQBllVpll9IUouFgrrgRY=;
 b=XCnufNMVt9ouL1ONbRfCraylBjXVeaxzw2QgU3FEbZY/BmDZjvXqZelDb4e3zpFGCXRt7RYXpK7M5tRPj52PgmRayN0f7LrrXsER+eKHF0adKkfuIhUDHOJfEJNHAeQwnq63EC+g4tzxCusJpihdsn130jihNbpnPlIDJ1DXsb2iltD65BcYykkQi7Kdnvdc74dT1X42GZHKCQtHZmlEe8+Z7QcpS7w38M13Z0saM5wagfA9RpFiifchfC0IKDPoRac/p/PjvxdswHq1bB7rgThE+R8sUqyS+DGRO/S4f8apMrb34Z8WKU+Toq5sryNs2l/NvUJ5Mzk6jSzA9dZxVA==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 10:40:15 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::c19e:4e13:c3bd:191d%7]) with mapi id 15.20.7409.039; Mon, 1 Apr 2024
 10:40:15 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Manikanta
 Maddireddy <mmaddireddy@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Krishna Thota <kthota@nvidia.com>
Subject: [Query] ACS enablement in the DT based boot flow
Thread-Topic: [Query] ACS enablement in the DT based boot flow
Thread-Index: AQHahA4m9EX0XlmRMUW/x7Mi6fvvrw==
Date: Mon, 1 Apr 2024 10:40:15 +0000
Message-ID:
 <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
undefined: 3546482
drawingcanvaselements: []
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6674:EE_|SA0PR12MB4416:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QJMPWpwlHqjiebbClTMEY57oDdkzl4b3Lle8F1ekFQ7uPnyapGj+sO4pFCKgpA6R18yF44fkZCx+Pz5qp/bm79r+OwY1Q6b6gjO9qgnyzSW+oVvL03oRjJ9+cuZm1yz4J4cuUz8vkg2OVrYEl4McUDumdQ6y2MagfQ4X5VYezXDA/4bH8vmUOBCbPxI4WMpbLk+GMLE61904l7tcYQAMUm05+jV4ZedAs1U8Ys1If37NtxuhOv7H6SpAmsZ/JNotnRT9P6Ufa2z3zD1B3R/YSCu+3wanH9i91q5z3I4vGynTEA02EqfDXE8vPw28SrAIrebf1FQWrHjbxvFby5Inyh2iCFV/YVW7oOVY/MI/Zqb0tAIpnFYISWXtbUlAyo2ATVArOhEsTgmtNihI1oq0MtnJ9zLCYS0z1SaH4xF1kLfx8QKbe0VXlqKTWdqpoPixhPIm2DWC1ddYTbCmWisRCH+7z6WnE3nXp6V3ZTBaQl6QAOWwfzthNE5H+NkVIGOutgyhXeu4jRz6Hy9e4NJ8kDVoS3vzmBN+mRaH9BufWJ8QeB3p/dNUBwrXey/0QL6Qvd+ZxFE6oBwtW+MT9up1eJbpxJtzWqSdNJLzrQplSssM5ndsMwkFJ8dkJ/YkgcaXjXSqXF8YcqouepAUd25ye1itzwx/LnrWL+U8rpuAnJo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?oSa/HL3SC+bS5Nw5E3HdlTQ76kxdjQZinNuDQNfn8TpSK6kDfHTLDBsOEk?=
 =?iso-8859-2?Q?s9Jtf0XPbAW9RxRLFtrwMqNunM5VgOiYfJQaBH7i/Kta/A7Yr/l99WCQEh?=
 =?iso-8859-2?Q?lcpMyXnoBpi2Yas4t7uWcdaNIqaVgwsJ4MYGAd1mifFjhIITEuLlPjsGid?=
 =?iso-8859-2?Q?iIF0FzvHpOFKHZZpSy+dAPtem5vgj4VdTrMsJ/EGCx0xMTQXRzAwYl4WBz?=
 =?iso-8859-2?Q?D02rnl0Jy/r6bsnIUQ/KUb4kNFCWegQ0kdaZ0vpADyIMuoBlt2eYWvrNzS?=
 =?iso-8859-2?Q?wfLo+L2UhuyKhMPXssMGzTx1ldxK3qb0ub8EqdHEkRzFIty/JjHR9U9sal?=
 =?iso-8859-2?Q?lLoYoft9vuYnZ3t6U4D3g1wGfAZkujQNAKlG4kCH1MIytUzZCoDwy0xalC?=
 =?iso-8859-2?Q?Y0Sv6nn38VRwNxBzoUn5xe87KazcCYgyaAz2D7qPXBYeYELBTuT5hzupt6?=
 =?iso-8859-2?Q?RC76APmU4sbjjrxvaGn4OaMp88H1/cqGXb+vj2FpYU5JZGcMrCedY6Qh5u?=
 =?iso-8859-2?Q?oIMV48Gxz0Oel/7NJUd02YtsJfoeUSXxhA6x6jgEdqbfBhj9AeyTQKCtRt?=
 =?iso-8859-2?Q?f8ogjbdJX5CL43VjRGqpAqk0nBqbBPshGNVbbSrWphncb+Jvl/YD/q0dvZ?=
 =?iso-8859-2?Q?VMZ96Aw6hL1c9B+YLxp53Fpjt9kD2tMogeRp7KkDx05WxLirJSzKssj1nk?=
 =?iso-8859-2?Q?jPAsbMtHHtzIUr7xKut9G7GxQPz5uDPS0/6XjYorxMPTZFmNazx+DxleiX?=
 =?iso-8859-2?Q?KfjMdoEx7Afc25OydNDml9jUcrAu6/cLgI+ZEuHxPqsyLZJ8iT+QR4y3Ba?=
 =?iso-8859-2?Q?mbxSD+UOyUoCP7xVbDYi162Aps7tVxD4KsK2x1sICnoupAbFUc/iokAyhG?=
 =?iso-8859-2?Q?Cs0j3z14ug4ejCR7W3o0XHloev67Rk8txgaIac0TQu3WBBUj7Mh/nIFuM1?=
 =?iso-8859-2?Q?GacHOCHBTGADXUk47SGJM0o9gCtImiakIbvSwgE4ZB3MaZuzxpnwwvA8gM?=
 =?iso-8859-2?Q?uYyqpg60Ni1h4XBe316HW4TJSQ/oRDCGA20Af8p8j9LecEUbbGv29LOcvm?=
 =?iso-8859-2?Q?30q87hfCNN4BBUaho07ea9w8v7Xe1TCEfNCItS8Tspo67M580M6dEpdWtq?=
 =?iso-8859-2?Q?6YEHrVaMlDtUhKAYnBfOgcjIVGu8yjxmg6mcRkoOLv9/uw8FC782MCuHDX?=
 =?iso-8859-2?Q?2kBwvtOeuI7B7OPLodLMKriJvQ/5KCgbdKWyL83+OLFbYCCw5nS60+ku7R?=
 =?iso-8859-2?Q?+JCkgXT5Hh+uJzFqcJJGm8NDnTV5H1xZuX2KdjWKNiGyDbM7t5dDVHu5Z8?=
 =?iso-8859-2?Q?5rIDgjW4zv8mhtCNvaYl3xW1JhKsQS+Q4I2y81x5tXMOVJGFyl/EAwADI/?=
 =?iso-8859-2?Q?r+FPsxgTrnJADwcHEwPSU6FdkjKeUMvPVMx4NVFPBW8o4zqIx8smus2lrZ?=
 =?iso-8859-2?Q?e/PlXiet9gVe4gmb37bNtfJAIjjEe2D0PRojHJx19EuWcftN8gkRReafR3?=
 =?iso-8859-2?Q?cBRcPbcwVqMryvkJZpnddR/ZHdPZDa+sQTwAYbuE54uwlAh4ElWSFpZojH?=
 =?iso-8859-2?Q?oVA3zIuACBcbWaeu6jAQbHjlDZJ1khZMewqQHQmkZDEuxW+WS3EwEmSD/M?=
 =?iso-8859-2?Q?YPGJ8OyKD41ec=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6155b26-31dc-43a2-1c7a-08dc52381dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 10:40:15.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zr3LQrvcBwVrOZJvoDvbpXCF+LVGSp/NJo6QQ0WHpyltJg3h25FYdRX8EF41I/6f42kmEPPP3D0w6MPzrBWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416

Hi folks,=0A=
ACS (Access Control Services) is configured for a PCI device through pci_en=
able_acs().=0A=
The first thing pci_enable_acs() checks for is whether the global flag 'pci=
_acs_enable' is set or not.=0A=
The global flag 'pci_acs_enable' is set by the function pci_request_acs().=
=0A=
=0A=
pci_enable_acs() function is called whenever a new PCI device is added to t=
he system=0A=
=0A=
 pci_enable_acs+0x4c/0x2a4=0A=
 pci_acs_init+0x38/0x60=0A=
 pci_device_add+0x1a0/0x670=0A=
 pci_scan_single_device+0xc4/0x100=0A=
 pci_scan_slot+0x6c/0x1e0=0A=
 pci_scan_child_bus_extend+0x48/0x2e0=0A=
 pci_scan_root_bus_bridge+0x64/0xf0=0A=
 pci_host_probe+0x18/0xd0=0A=
=0A=
In the case of a system that boots using device-tree blob, pci_request_acs(=
) is called when the=0A=
device driver binds with the respective device=0A=
=0A=
of_iommu_configure+0xf4/0x230=0A=
of_dma_configure_id+0x110/0x340=0A=
pci_dma_configure+0x54/0x120=0A=
really_probe+0x80/0x3e0=0A=
__driver_probe_device+0x88/0x1c0=0A=
driver_probe_device+0x3c/0x140=0A=
__device_attach_driver+0xe8/0x1e0=0A=
bus_for_each_drv+0x78/0xf0=0A=
__device_attach+0x104/0x1e0=0A=
device_attach+0x14/0x30=0A=
pci_bus_add_device+0x50/0xd0=0A=
pci_bus_add_devices+0x38/0x90=0A=
pci_host_probe+0x40/0xd0=0A=
=0A=
Since the device addition always happens first followed by the driver bindi=
ng, this flow effectively=0A=
makes sure that ACS never gets enabled.=0A=
=0A=
Ideally, I would expect the pci_request_acs() get called (probably by the O=
F framework itself) before=0A=
calling pci_enable_acs().=0A=
=0A=
This happens in the ACPI flow where pci_request_acs() is called during IORT=
 node=0A=
initialization (i.e. iort_init_platform_devices() function).=0A=
=0A=
Is this understanding correct? If yes, would it make sense to call pci_requ=
est_acs() during=0A=
OF initialization (similar to IORT initialization in ACPI flow)?=0A=
=0A=
Thanks,=0A=
Vidya Sagar=

