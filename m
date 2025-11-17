Return-Path: <linux-pci+bounces-41373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076CC6329D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26D4D4EAB8A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6E2326924;
	Mon, 17 Nov 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CEueWkIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E360322A00;
	Mon, 17 Nov 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371378; cv=fail; b=OOHyRuu3kqgwwdqklwkaQBx11++jFHsOzGgNhAlw+BE/wJm+GEHmfxFXZmClgzxr6ZSi54Z/Y2mzFd73Psn24Lh1nQ2bCR8a8MuODH3gu2OVSW2NV4bSNZCktRLLwl06zR1jHe5OLKvDjVWiETFM5u40Uv/ixuAPabIt6r3IFI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371378; c=relaxed/simple;
	bh=g0tcIudFXigUKnEaERzDetaXUI3jOqZ58lsgdLqjjYA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDJ7RV4mvoJXDB6FsfYPEBT6OrVR8r3qg+mv9EI8xO/AP7KHcdSV6m1X1n7tZJQw1aFyA3CbZlpP8GhOFr2uccemAAwJHcVrMNER6QUHv9R1c3NzksHH91+5ZZDDS2kafKJ1p4JxSuwGdU3lrJ8BTfIKNhjhkDde46LoVi1gAwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CEueWkIu; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DagQ787yWsZg04O2dNjAynSue5tA/Q8YXaKJ5b070C0pQPBm+3gd8ajW1OSiUwy0RbBwptEawqp9O3N4puvRRtIBRfefhAS1BmlRpmO7KOH9GTzuvtr+x0/qTCj3niCva2Y6y1fq7HslpHx3kSoRgSOz60OY7dhFtEBc/+EjI9ptmAjSPjz3KYg7lPNKnc/ZWETGJFikySksjPc5/mfg0GwSo9R5bpP2PyJmWOKVWkG/AmW2selMHkjrQUfo2VrWsatmdan8GcQ/bq4mqsbG9JOr2xPsF52VOhgZt+C/kh4uJATXNhXCDhP55160niEBnwhSOnfR2TyyNQugTQQ/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZsPPNjNU3zxqvYUeiesR5K/f2Dm3oWhMaWmc6Zxdic=;
 b=tlAfgzg7Xdi+Q3ha6vSL8Gwu026XMBrKpiMGATEE6Qy382pZa6IfcOE0mJYzO9NvLE3ha3MKos1bPirM/dTCIDb5H/NpRn8lvn9y+YMqoAVeAqeIHh7xhb8DHTAHk2c5zTi/vy+t5qFf+0x155JBoL8J1DQ3u0C8COE4mtT8RY0vIc752hSokMA3d315Q/RWFX+mxhBmR8LhN9tg64WvSVdhM9Yy3Yt5DkETA63zvYH6XOhI2lGO1iIME+19A8PWK+tWM3+WSieiepBShV5IbuJQ4kllx/39ORJirqkF0JAwIzUf5oz2eg2Qs0LV87SZR69sv6LnjBCAKpL7F8Wtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZsPPNjNU3zxqvYUeiesR5K/f2Dm3oWhMaWmc6Zxdic=;
 b=CEueWkIudHPUFHNZwQ/VVVZv8HJIV4A7yKL0YB2u0CKc8woavU8iPnnhhadOYv45aok2pWi0PW9Bm6pHxdisOkdoH5QjFT+5tiGxXsIdyjrhHIgw779ko1p+zR0TFjVMF+u6Xl/PD/85iceIPwQ3nun+/qXzdiYyqi3erfbd0lY=
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 09:22:52 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::5b) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 09:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 09:22:52 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 03:22:46 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 03:22:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 03:22:46 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AH9MhNO2247971;
	Mon, 17 Nov 2025 03:22:43 -0600
Message-ID: <8ac2ed36a85f854a54ee1d05599891632087869d.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, Rob Herring <robh@kernel.org>, <bhelgaas@google.com>,
	"Chen Wang" <unicorn_wang@outlook.com>, Kishon Vijay Abraham I
	<kishon@kernel.org>, <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>
Date: Mon, 17 Nov 2025 14:53:00 +0530
In-Reply-To: <37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
	 <084b804f-2999-4f8d-8372-43cfbf0c0d28@app.fastmail.com>
	 <250d2b94d5785e70530200e00c1f0f46fde4311b.camel@ti.com>
	 <201b9ad1-3ebd-4992-acdd-925d2e357d22@app.fastmail.com>
	 <7eaa4d917f7639913838abd4fd64ae8fe73a8cfc.camel@ti.com>
	 <37f6f8ce-12b2-44ee-a94c-f21b29c98821@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CO1PR10MB4673:EE_
X-MS-Office365-Filtering-Correlation-Id: 945134fc-81cc-4adf-1020-08de25bae25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|32650700017|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXNSWkYyNTZ4aUhwQnNOcXpNZjdJOWhxc1FSbkdGdkpwcEgxNTRmMFNMQ1FI?=
 =?utf-8?B?M0N6eE4xeVB6VmtpVHlyaDRrNGRlaWhkdWNRdkExbVQzSFJqSFMwTFU0dUR1?=
 =?utf-8?B?T0ViaHVNS0NzNktIdVZ3WHJ6WlNSaXYzYTVVc21Kb3RTTzN4TUw5Mkh6ZUxE?=
 =?utf-8?B?UXNqV1k2cmxsa04zV3hndkNDOEFOcERYYzFjWFAvdEZPdWNKcXdtVEpXcnpz?=
 =?utf-8?B?T1dVNVNDUEJGdk9wYjI3TWdrdElpUHYwOWpzdVFYQjhXSDJpclhtU1M1REVK?=
 =?utf-8?B?UUcyL2VIVzI5eXFsZWI5RGpsRmRhMUFYV2dsMkNrVXpVZFVqTXdIdlVkNXlL?=
 =?utf-8?B?NEYxS3N3QTh1MWNXU1NZS0JERmt6UTFWdlBqMldzVnNNZ3JCM2VORWZleFRV?=
 =?utf-8?B?bWdtc3RqUFpxYW1rWlpVL2lKWEE5UEdWNUFUVlR5c1VKSVRkWWZxUzhVaEl3?=
 =?utf-8?B?cVZXQjlLeFFTWElUY1NaaUJXaERoSzhBRmNHSzFqbHQzV1ltRWJDaERId3hS?=
 =?utf-8?B?MU94c1VFR3YyNWljZDB3bXhQZlM5SFR6VnhPMFpoTE9MKzlkNTJyS3JsSDAw?=
 =?utf-8?B?OVMreWNpTVZsYUxNUkVwNUFFVzBGd0JrUXd0ZEE0NFJiaDJ5OFpZckx0Rmtq?=
 =?utf-8?B?R0RQM2VzS0pXZW1NQjVHVGFXR0p3MEMrNGo4UWdqYW9JQ0owc045M3NST2xZ?=
 =?utf-8?B?bzhBNlVmZmJ2Z2Z0a2NiazNKUTdGOHRxdXBaaUpzNm9lTUhOT1BOZGxmbEtG?=
 =?utf-8?B?MGFDL1o3SjEyNXMwNHIzbVl4eVRPKytTUGcyK1pidmg4cXNZTkhFVjhZdWlD?=
 =?utf-8?B?NEYzOU5uTTllb1ZqNXAyVUtEcWhZTUU4cUF4RWVoRlJpZWdiM21vNVcxZU9C?=
 =?utf-8?B?T21UVnZIbnl3ZERucnl0WXBmK2ZsTDczajh2RUFESXFEbE05T2o1RTg3YmZI?=
 =?utf-8?B?M1ZvUHRMMGlCMDJLd3FoR1Z1YW5rRENCbC82QWpqN2cxZVdhVzRxVFluK2lY?=
 =?utf-8?B?djNTVHJDMlNVNjcwNGtGYUtNRXJER2k1OVVidkxHdXJ0bG11eDY5VTVSbDZH?=
 =?utf-8?B?R0Y1UHhOYVdZOWYvWTFXZ3pKNXlZZ0p6U0pIZXVzakI4bVVyWDFMYk9EOXFm?=
 =?utf-8?B?V1N3RHhIY1RkYnNoaEdkOUZoUXdYNnNoZ2J6dVpqNzUrMEtZaTNYL0g1Tkl3?=
 =?utf-8?B?Z1JHMGsrbUdNN2VtWG5MSzFrWVUvQ2RZZjc0Q2E0eDY2UjNTYjZEcjNVTGxR?=
 =?utf-8?B?SmlJT2hlUjlxbVFSNytLaVFzOEJ2a25wUjUxUHNNbjhUSWhMVFhTUk9jVkVW?=
 =?utf-8?B?ZUZHUDRRWStnUmFJeVBwRmFwODJQYkUwVWw2TTByK084Tzk5RWtCdkpjblox?=
 =?utf-8?B?UWRZVnFNbEE4Z1RnSnRrekZLU0NaSUtPUEpaeDRXM0JTTnVKbThaTjJGUHIy?=
 =?utf-8?B?QzhCWU94RTNCYVAvcjdvcU1hcmJWSDJ0dE5rNnVRSWorS3AxRFRYQ0Z2NHlF?=
 =?utf-8?B?MndmTlVYenlNaS9FZG1leFJYTXpZVTJvNjVkelkyTzkwOUhETHhCMjRGZjc3?=
 =?utf-8?B?NUxtMmZnWlRqd2xxeTUvSXBKUU5UZng5RkRzQnJTOTg2Z3Vzell5dnR4Kzlk?=
 =?utf-8?B?citueFdOd0d2Z213MGVDM3l2MkVtY05RekkzNDl3cXE3eDV4eWU3clhvQ0tM?=
 =?utf-8?B?MklPRUVVbTZESTVXajVCYUcvNWxKUTFpRmw3TnNCTVdxYmE4enRlTi95aEhN?=
 =?utf-8?B?OVU2SjZJVE5WYlBXZGprN2I1R2x0c2cvV2NTdWQ1RzllUDlKbGxtWTQ1ZTFO?=
 =?utf-8?B?N2RxdTVRUEVqV2V2SlArSHJGSjZaYWRWSTkzbFZ3aFN6N05SQUtUSXFMZWov?=
 =?utf-8?B?MFpxWGROMmdCdEM1OURnUXpTbE1uQlI2MXVjL2RIMUxvdGE2Nm12T2ZZL2Zm?=
 =?utf-8?B?UHg1d2RLQkpFRDVTSzR1Wjg3WFVOUm85NTV0MThXVi9GRWFwSGxwcitOZCs5?=
 =?utf-8?B?bDJlVDVIUUVwbThJbjYzTzlQOW5sK0dGTVdDeEFvVDd3NHQrbmlrZGNyc1Vh?=
 =?utf-8?B?Z2hObVVObjRwS3NLNlZPcDNaakdkVUcrRWZJZm04OTBVZnNxTXkwbkpYSS9Z?=
 =?utf-8?Q?SDFc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(32650700017)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:22:52.3842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945134fc-81cc-4adf-1020-08de25bae25f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4673

On Mon, 2025-11-17 at 10:06 +0100, Arnd Bergmann wrote:
> On Mon, Nov 17, 2025, at 07:05, Siddharth Vadapalli wrote:
> > On Fri, 2025-11-14 at 08:03 +0100, Arnd Bergmann wrote:
> > > On Fri, Nov 14, 2025, at 06:47, Siddharth Vadapalli wrote:
>=20
> > I understand that the solution should be fixing the pci-j721e.c driver
> > rather than updating Kconfig or Makefile. Thank you for the feedback. I
> > will update the pci-j721e.c driver to handle the case that is triggerin=
g
> > the build error.
>=20
> Ok, thanks!
>=20
> I think a single if(IS_ENABLED(CONFIG_PCI_J721E_HOST)) check
> is probably enough to avoid the link failure
>=20
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -669,7 +669,8 @@ static void j721e_pcie_remove(struct platform_device =
*pdev)
>         struct cdns_pcie_ep *ep;
>         struct cdns_pcie_rc *rc;
> =20
> -       if (pcie->mode =3D=3D PCI_MODE_RC) {
> +       if (IS_ENABLED(CONFIG_PCI_J721E_HOST) &&
> +           pcie->mode =3D=3D PCI_MODE_RC) {
>                 rc =3D container_of(cdns_pcie, struct cdns_pcie_rc, pcie)=
;
>                 cdns_pcie_host_disable(rc);
>=20
>=20
> but you may want to split it up further to get better dead
> code elimination and prevent similar bugs from reappearing when
> another call gets added without this type of check.
>=20
> If you split j721e_pcie_driver into a host and an ep driver
> structure with their own probe/remove callbacks, you can
> move the IS_ENABLED() check all the way into module_init()
> function.

Thank you for the suggestion :)

Would it work if I send a quick fix for `cdns_pcie_host_disable` using
IS_ENABLED in the existing driver implementation and then send the
refactoring series later? This is to resolve the build error quickly until
the refactoring series is ready.

On the other hand, if it should be fixed the right way by refactoring, I
will not post the temporary fix. Please let me know.

Regards,
Siddharth.

