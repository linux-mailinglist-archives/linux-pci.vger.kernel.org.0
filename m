Return-Path: <linux-pci+bounces-23443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F7A5CAAE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F525189B9B5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D7A25EFBA;
	Tue, 11 Mar 2025 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BOZEZoyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2EB25E833;
	Tue, 11 Mar 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710070; cv=fail; b=dngwQPJQFqoOhldDllw2c9SDpeVisjoTrHQ6WIdHfUa8RZfsjcm+ZPHZJR4kcMZZ+6ca1JYjKxyN8eH7nEVtgPQL2TSBKHOMxDQcCjUrt/PotmWbL02XC6f5FtWDnVtar7DAPyFXO+cQdW0xv+pgb3YtpeF0XaHE8wxNUUSgXCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710070; c=relaxed/simple;
	bh=TNiYMGVC3NHjW+UxW0y2c8Wrp+eihpFuzd/lPnbAhhI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5LEO881LoFx7wYHSaX1+0meNd3Zzy0WQCVk/ydINr2d4iqk+WvHcDNtcjH7ukj1Lm9PEPeMiDDI+lcp165oXh+O1B+xbUVVtmYOpi3sMBHjFLYc3k94yWaoS7FCXDSXTfyrikbzYwarAPDTiTQ8WBj+RcCq5bcEDIE+2m5PC3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BOZEZoyT; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7RQsnO+RLY2tyum+Cdccn29EfsH1IoK7IiKaGAQfN++3+6Dder4T73yLo9/ykdQ4QhOFlhRzY+OA62TUEbsMAASWNPL8JyrorZCdWlXuTcR0oqNy5cwxKCghd09+eJ9xsNcl30pAQJKPTpDdHMpXihywmDfDHLo58+VX2ZIE3fguAhTGKCE42cnUTz5lgJfN9MKZZRkoAqAEx4XM7NCPL7XvAQgT14uL38Q/db9LuizN2qMMvX1BiKgvb+7M2F5yAEopFlGG1g9VHvYMMkw/YmrYwT+0YBMePgkWotx8tPCCWAWsVZc8sBCdq7vlCtCudfJkSyOsG9n+HAVCcwZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk464NwXSKnl4SIKPUvR9mzPvDOdgSXybDHjtYPLg5Y=;
 b=K0KV1tFU0AODfIMPzIctrQZIGsLSUHskHC/UrfGUMvgSLMd7WoEfnvTurZrXHDziKrRLZ1yqyjOb9cRBnXXHFcOtcBOAyk/YIkbofVrJvvdYWDAMgzWJvV6qxfNLquyUjzf9wi0xs3iOMu/NpILKYzGwnrFIHSAqIc3U43W/+87b0VbAkVlJAriFYJATUTqeHq9WXAPvW9+iAkKVX+fy/arMB8tGtqvqC1ujQmICWeEeEN54VmW+1WKAGfwPuRFXtsO1vPgkBKWUBTsSh8/7a5TZNAQXl0j8wDPe+0ka/Jdn1quKbiQbM5g2ZDYKpHPuTzJP0GanyA0OOFYt9KRnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk464NwXSKnl4SIKPUvR9mzPvDOdgSXybDHjtYPLg5Y=;
 b=BOZEZoyTS1KiFw0wzAU+TrOnLovnvXc265aZE8eydr0uBhF4RvPsEBY4LbynojyhIBM/JJEeFNQOSB6kZTVALHcMQ1QNCIzBBLcmlOZMru5ClEGbjWVGBXcDrDDy63oKQGdJYRFTYQ3T5WmJ7AFmk3baUtEZxHFk5S2tYhC83Xk=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:21:06 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:21:06 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 3/3] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH v5 3/3] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Thread-Index: AQHbhtPeEUPAR7AKo0iR5vshusHgCrNssBiAgAF/bwCAAAW4sA==
Date: Tue, 11 Mar 2025 16:21:06 +0000
Message-ID:
 <SN7PR12MB72013B1079A490505A285FD58BD12@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250310170717.GA556500@bhelgaas>
 <20250311155938.GA629931@bhelgaas>
In-Reply-To: <20250311155938.GA629931@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3d39f31f-c72c-4457-85e6-01a0cb1b2e5a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-11T16:20:06Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA1PR12MB8519:EE_
x-ms-office365-filtering-correlation-id: 19bfc1b9-05d8-4d3c-89fd-08dd60b8b9dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x5HAQjOdow3yCpM4wCMOTBPn7VTwBKC9SxuuGDjYuzADsP9d5OZXdIr1JMhj?=
 =?us-ascii?Q?ZBy0AYgqJ9e5873MiktI4dRbzxwoPNyh9yqQW2WKo0ZN0fysIMGWCg6l48Tc?=
 =?us-ascii?Q?Dds/Vs8CpUiagxLa5uF9krmpGmN2wdu9nvzOUw+dClc3i1K6gc+KXSOC6og8?=
 =?us-ascii?Q?A6tD18AXwZyorga84Xg/+53bTe6/XSyzRUc1h7XtPEvy/lXRvZIQreZBnCGx?=
 =?us-ascii?Q?6iPg82QuAGuAs04IiB+SjqTc6/JhyjpoQK83uAI8gbo33R3TRc5WpSIZJBq7?=
 =?us-ascii?Q?8pOS895OSzzQOLvvo95eE2A+2kw+nByGAPa0vxpYsymvOEsl2nazT9zMCMFG?=
 =?us-ascii?Q?+6HwsDw1ALyHRUGRJzWeclBAHQ9CGDU4kxqIUgR6jXYpQZ6gir1ZtNcZdmxS?=
 =?us-ascii?Q?V9vid9B63TKUAb1PKGtbMprBHJsDP8zJy+KUd9bbqhADsV0Ym2ghX7pVHwzq?=
 =?us-ascii?Q?0JXri9oircXO1iWBxZqK+8i2zGfKAIaKgdUBUxEPKLQaEdJWhZTQfb3tmVDB?=
 =?us-ascii?Q?yEzXKqVcMbw97VZOcaPHLZHKxg2iP2XtkPDKJmc0yntqif42+wneLKzaQoc6?=
 =?us-ascii?Q?SI3v9jAyrEsznFRtwSuujQJBBrj8k3N5hfeuultsPAxD4HBkfTPlkF/pHyr+?=
 =?us-ascii?Q?5JGUZKmHzKgWRPkG7w4W58tP/OHbBms/gw/d/BYdrCDlrHLAFKbas15Q0E96?=
 =?us-ascii?Q?+q3U8p6REb8swG9gvS9CiMDvisz371GaEds3RKVSdCm/SBqvpQ+brVezXZBn?=
 =?us-ascii?Q?gn8ayCQbk3PqYQkttiAV8YGEVLigIi3xZe36IBzGiMACYj29v7VJmTYBB82Q?=
 =?us-ascii?Q?5Ilx+aB05LPEbkafsh9Bwf0TKmn666QZnasluNEdgS3M/DXsaOIiQAxfNkr7?=
 =?us-ascii?Q?WiC0fIe0hKNHV46AIf28bL4qrLb0F289/GYhWZvwMyp2jru8mi29xATmr7m+?=
 =?us-ascii?Q?zIcgIaBf/HxRvjjiP7Z92gG8HjztpRB+o4sK/9nwY8HuTqa2mcKkYZ7ZpixW?=
 =?us-ascii?Q?ufCKYd0fE54dcrUerO25FIlIgCiIK4FYZnnwPZa7mcO8zMH/u0lf49aeOeco?=
 =?us-ascii?Q?5EE/y28GLpOUnSRB4WsiA6SIU5RtKGNLkYEmeko+6e+N7H0Xj96WxWD4sxgD?=
 =?us-ascii?Q?bd6MOnk2coCB4Z3aqoxzet/io0L6/1KJ08YuPE3kxKyyr5NgDdcU1b3b4bsE?=
 =?us-ascii?Q?kFIiNk37OwWXzIqai0pOsYHgU7hxHJGkC1pXSn7JlhjdSzvT5N/kGUiZgg7P?=
 =?us-ascii?Q?6VdLPi8XVJBeuqaxdL9NG2YRjKJW58v5cN82cR0Y7oA11DeEEy3Q38bWHDhB?=
 =?us-ascii?Q?FAYebM26FgkkLMc20CKzYMdmUHp/MddmunK9loR25KnvDCP2i79YYULq/f/U?=
 =?us-ascii?Q?HD3jxIuPfkXavjj8KMFiNKkSnKTakTAbRX8cASyX6Ng2Adat0aWsqppuI34h?=
 =?us-ascii?Q?TpECQwSpYRTni5qqUzLCK1Ef37ur59ZR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FqPLMicnjsOXwYEfBZtHmVThSuwCXfIN+H4AvWVbLGVYkG7qwCJf8t7HM8S5?=
 =?us-ascii?Q?DDQavhgGfyD9tmtGo6jGGhVHxCPwBMcsNtsmJksPaXYCS4bw4oiZOY9Urfs5?=
 =?us-ascii?Q?00HlB6Hn/qz3Q+4kIuBkSSLJk0gCkkpQwaEtgYwDmVEBgbOgyqvMkriEPVCr?=
 =?us-ascii?Q?uONyPoc29iNMGYMvOeZs/6hm7XtQWjg79PyjMlG/07Y+UAiSX29HE0N956MR?=
 =?us-ascii?Q?Yn9BpB2N8+lsoRCYrCAUrB5vcYV8QTmyLlC0Bg10btVUQrbbb/9raLxBTIcV?=
 =?us-ascii?Q?V878/catlFD7YXUN0zRgpzBKjjfYaMC0RJX5uVOnIxK/xvN2bLITVPa9zyUT?=
 =?us-ascii?Q?RjjBmNkOfjGd3OCxi80B4HhMocaqCbv8B+b/PZWeACY3+jvn83/0PpiWXNaj?=
 =?us-ascii?Q?UKZqnqprxB/ukUqns3zjfX8ZGxSJCSiobA8gwu54W8nV6MR5S4KHm0qn6xfv?=
 =?us-ascii?Q?r9s/qqECN4eYk+HL5ab+lorz9xoMC/YNvwq3DST5UGxb9wOxbnI1EzTCnvlW?=
 =?us-ascii?Q?/7KVtjh0QJFuvLqjH8zK7QeDfcTB+/uB2LmuR105ho2bQD8WOs/KbMG7JKJG?=
 =?us-ascii?Q?ZJdJw27qwyG6kOHzdE43BLW8qP/b1kYwNJ7NlGOzjcAwgD9pzkG5ktzy6mOn?=
 =?us-ascii?Q?ew0gUvWtIOGo9MYPqPBnKePofVQDSy3yAXGeWeZxKpwgLkFp6yfA8kJdkvFw?=
 =?us-ascii?Q?Y+M5TsDJFTNgMQVgoYQkea1cOgkyuUbAF1KlwoU2VvnigE27LU8GEbdoh48d?=
 =?us-ascii?Q?X7+Y0PPJPSi/4dd+pNXOkdLPLgMQQ9/0IKuI6j7NqYC/5eeqAEpSiptC5XoY?=
 =?us-ascii?Q?uyreLhGIfC8Ysxyxbih0AodJkl2tfz1sLieo8dNXoHcGXQiiNOmfZKV/y8/c?=
 =?us-ascii?Q?VL7GB7AtoGJs6mcHWUGqZ1O8ovJxgQN+G83ujnMyuQbMuP3F9fN/D5GxRNgC?=
 =?us-ascii?Q?9ylEq6aMSrd7cRFv9xG2rPwfck3Q7r/HsOLavl6KJCAyBs/B8vvYyVc0s0A/?=
 =?us-ascii?Q?iWZhYHGdVPsql1IaepDN23ukMQlxBWaLK6zpjzGWFHuLLIxSewX6U7ZSRHce?=
 =?us-ascii?Q?dgkQpQJXlmUSwXSYRL10r3HH0KDWse/1d/vS8BVPvtZ66+S2g36ylC7ZfZvx?=
 =?us-ascii?Q?q4qIOc7Yn+967m4FKmFXxNCupOZOkeq3GeTwyeoRG6hhkdNUvbq3Pth17Vj9?=
 =?us-ascii?Q?NnpsuRHsrwVmxWPSslppodzdeMXdyCpzB6Fr4HYT40DBPT+ltbyaFDo9KJX8?=
 =?us-ascii?Q?Y51RD5tMol91nIfhXjWuv4Tdi0wHPoK7t57pPRBzCEn7RNcXHlj++X3w9mxs?=
 =?us-ascii?Q?MRWBbszbwN2dVsJdtOW4tZHgXPPiGQHg9Y/zM0WxJGvv4qWk+/ijHuPwoeeC?=
 =?us-ascii?Q?6XYTPEnwqIXHv9JGIQh8aacKWgxrCfoJAwOZ6pXrXhzNfTgKhEw7Xdq3AdWF?=
 =?us-ascii?Q?mGYon0ZbcpTOUa6gddXeVx3e0Na67kYCwO+28bJ9C1IXlU1AIEaUGJ6mscdD?=
 =?us-ascii?Q?5KpOWcy5v9fkO2ahBgIH0IBMi33nWExNBa8BlsP9BChPtY49IKv3qNCZEwNq?=
 =?us-ascii?Q?/6VvBMLDcLpnzkxnmB0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bfc1b9-05d8-4d3c-89fd-08dd60b8b9dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 16:21:06.4634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBMJ3rQVPjWBOOCsEWgUO+9MwUbMAq9LsLrEhVQLhxu+s+M5w9D8O1gHE0zXii7o5vNMbEZYyP9IBjko3VtxOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, March 11, 2025 9:30 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v5 3/3] PCI: xilinx-cpm: Add support for Versal Net C=
PM5NC
> Root Port controller
>
> On Mon, Mar 10, 2025 at 12:07:17PM -0500, Bjorn Helgaas wrote:
> > On Mon, Feb 24, 2025 at 09:20:24PM +0530, Thippeswamy Havalige wrote:
> > > The Versal Net ACAP (Adaptive Compute Acceleration Platform) devices
> > > incorporate the Coherency and PCIe Gen5 Module, specifically the
> > > Next-Generation Compact Module (CPM5NC).
> > >
> > > The integrated CPM5NC block, along with the built-in bridge, can func=
tion
> > > as a PCIe Root Port & supports the PCIe Gen5 protocol with data trans=
fer
> > > rates of up to 32 GT/s, capable of supporting up to a x16 lane-width
> > > configuration.
> > >
> > > Bridge errors are managed using a specific interrupt line designed fo=
r
> > > CPM5N. INTx interrupt support is not available.
> > >
> > > Currently in this commit platform specific Bridge errors support is n=
ot
> > > added.
> >
> > > @@ -478,6 +479,9 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
> > >  {
> > >   const struct xilinx_cpm_variant *variant =3D port->variant;
> > >
> > > + if (variant->version !=3D CPM5NC_HOST)
> > > +         return;
> >
> > You're adding support for CPM5NC_HOST, but this changes the behavior
> > for all the NON-CPM5NC_HOST devices, which looks like a typo.
> >
> > Should it be "variant->version =3D=3D CPM5NC_HOST" instead?
>
> Thanks for your patch that fixes this part.
>
> > Also, this makes it look like CPM5NC_HOST doesn't support any
> > interrupts at all.  No INTx, no MSI, no MSI-X.  Is that true?  If so,
> > what good is a host controller where interrupts don't work?
>
> Does this controller support interrupts?

Yes, CPM5NC controller supports MSI & MSI-X via gic-its.

Regards,
Thippeswamy H

