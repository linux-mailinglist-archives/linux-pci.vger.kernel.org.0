Return-Path: <linux-pci+bounces-42977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1ECB7745
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 01:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A2DD3015EF7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 00:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2B119E7D1;
	Fri, 12 Dec 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pdvMN3ig"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E24A01;
	Fri, 12 Dec 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499470; cv=fail; b=Pl4ezJ8AEuENwmsqCYwWE4CwOP01YW/Wfx8AEICW7f3NxJAXEK2yR1fAGQpsWa5WbeWMEBvxiuYVyBHQ9DS7pQmxmdz610b5tLHHMDiXeFb+2iCipx57Dr4pT1lidbbA5+yCObaBzCHPFZ4w70tiRPqMP4/FU3YBeMEkYjmdFqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499470; c=relaxed/simple;
	bh=NTWFHZdihoI5HdCqaVET1rUQHlbuLsanUYSyRpXfbtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GCAnND/72p5BZ4QGuvTF9Y8HwFOMXC1h0KfdfLiNCZzOh0bFRKYnkAQjpSOmDzZlJkhFy6XrscklEJcop/MKYAJ0JnO7robaghxOdm9z8G7Iy0xu61SZIuxNnzXdSdZCC3AnH5MF1vwqVqgLFatpprphVP/cn0w1pPomQI/e6Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pdvMN3ig; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhutxqekx+pJp7ZmrCCjK+RrqQkgaGJYy12gtrdht6owAA/PeQuZzMDiS0DYU55L/Z5XlSQ//NpaSEx6O0DhFY5j+nYHPr6bA0Wm3K9i5XueL2wAmRJ6LeJCP+8ebP7eTdZaT9ZoWDhdH7eToXUhNkVXGMZRy6sCYaNjnZqE/1eonh5btpOj/zhHR8Z7fbWC41C2DsibPg7ukJ9jnCrRgMPWntTFTNEY18n41cd/wqX/JXnfEd3GtB03O/MviQv0Uzr16O7l/2zQgX8oklIS0Yc9sVlEAJpyP0fdA+2Y9B+6kEstUUoIPHTHO3ujNOBEalr/OLqRPAjHiDTEbSx2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTWFHZdihoI5HdCqaVET1rUQHlbuLsanUYSyRpXfbtI=;
 b=QZnbUz3MAsg4lFT9e+tiEgatoQU6bOAb1iWyq/sqeMA1h+6paxWMbJipBF7zn5bPTZD5YC2srv+34lgVsrPXYuI6ikBHlsgemq0XEqTlmsZo8oxyLQZ2nKtCqLwYS4lPRNiobn2SwV/fvriUFwcE5V+FSvwOUTx5K/JezULJGgqIgrWeRbgkaDvU2PeKyUvSQ4wW7i744LGiAcTrr4PAGDCmc5zGXIaHnv5eGrQSBWwFdIQkZ6TRGTdfUfqgRr4yCjwtKBbIRXfj9XQKQgANaP00rjVrgu1RImI5fCeZuUCc7VXI8T2OD2vrCLnGIhj4JLAc8HAO/rKIGbQV8fcaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTWFHZdihoI5HdCqaVET1rUQHlbuLsanUYSyRpXfbtI=;
 b=pdvMN3ig6NrmAXrFRYiFV6xF+U9qD3+0tk0f37nKqLgJyCN8HXMdsNdw357kd8jwA0kODiPF3mjciGe/1g0rgCK8vpUlIcOo0QA1yZOO+mzZwksaLVsF4r1VObUuJZfylapIdn0zHSbhPI7N1NaokIHVz/b79v3qT8dSSxqEGdo8mX4ECi7+B+xKmObse0+paEsMz2AV0A//rHK3XA9A7l6j6zBGNDvNfbYIbEx1XDUas+8DuHQID2YTujdVvw6FSLtSZm41RHH4/EVgeiN76C7iPfVxP5+8CNd69KbsAsgvo4OFqaVNOdE3sWfO/JZq41zaWxyfwgHMk+BnvHOx3A==
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 00:29:51 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 00:29:50 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
CC: Zhi Wang <zhiw@nvidia.com>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"dakr@kernel.org" <dakr@kernel.org>, "aliceryhl@google.com"
	<aliceryhl@google.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "ojeda@kernel.org"
	<ojeda@kernel.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "gary@garyguo.net"
	<gary@garyguo.net>, "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
	"lossin@kernel.org" <lossin@kernel.org>, "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"markus.probst@posteo.de" <markus.probst@posteo.de>, "helgaas@kernel.org"
	<helgaas@kernel.org>, Neo Jia <cjia@nvidia.com>, "alex@shazbot.org"
	<alex@shazbot.org>, Surath Mitra <smitra@nvidia.com>, Ankit Agrawal
	<ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Kirti Wankhede
	<kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>, "zhiwang@kernel.org"
	<zhiwang@kernel.org>
Subject: Re: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
Thread-Topic: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
Thread-Index: AQHcZq3HpdYIM6R3LUqn4UkIOuqAAbUVdjWAgAPfaACAAs93AIABBsWAgAADpiU=
Date: Fri, 12 Dec 2025 00:29:50 +0000
Message-ID: <E490B392-0BEF-46D0-93D5-A3023FC0D64F@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-5-zhiw@nvidia.com>
 <9cf6135e-43c4-4c31-acf5-03fbe32e2bae@nvidia.com>
 <20251209154114.09cf245b@inno-ThinkPad-X280>
 <20251211083618.GA2144309@joelbox2>
 <8f8e1944-5315-4657-9ddc-7e6c65c6ac00@nvidia.com>
In-Reply-To: <8f8e1944-5315-4657-9ddc-7e6c65c6ac00@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8056:EE_|BY5PR12MB4290:EE_
x-ms-office365-filtering-correlation-id: e5ecab2b-b366-44e7-22c9-08de3915901c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlN2SEtjVU90UDlZSnl2NUZpem5QMmc3K3k4N2I3UkQwa0tqSzd3QW1xUVFM?=
 =?utf-8?B?QWExRGMvSFdiWmhqcWFDM05ocTJFTTB6WkhtcHk2Nmlva045MFoyT0FpVXBY?=
 =?utf-8?B?WFFMc01vKzJUWiswYnVKU0dBSVhMVG9WODRJaTBEWnFtazRFN3FqUzBsZWtO?=
 =?utf-8?B?N1Y3byt2L09nTXRxN1FULzVha3JNMWlTUDc1Z0ZpaXBMK1ZmNzBPUUtPS3Jp?=
 =?utf-8?B?VzVCdmp0am1kUlU4TVQzNzJzRG96K3h0MTRzaWRnb1J0TnAzNlFQR1ZITzFH?=
 =?utf-8?B?Z29RdS8xZUxuSExSNXJTTkEwazk5YUFhUGdrQlBJbzl2WDFxeExnVmZka29v?=
 =?utf-8?B?SFNrancyR0pWL09jV3dvNlgvazVRRmV4ZVdmcnFvOGpMaGxybzhaZW0vcGdI?=
 =?utf-8?B?aVhzOC9vYlN6T3RleGRwaHFWbmpWaXNsaU5DL2NUNmxHdEt4SmhLR1U5TjFz?=
 =?utf-8?B?T0d1WWcxTVJrOVl3YUwvU2lKZ1p2SVdENGNKa2lrOEtscHYycDNlUDEzdGJX?=
 =?utf-8?B?dEx3SEM1bXVHdVVSMERYajdZa0hZZ0czWVlETjlSOVhsNEtWdEhpR1FoQ21P?=
 =?utf-8?B?SEt4YVpnMjhLZmxOamIyNXFOTHhNb1VzVHRORll3R2VINGl6VkJHU3RCNVVQ?=
 =?utf-8?B?WGY1MlMxbEVLRWUyRGEzSUtKandXN0RpbzlwM2tTYk0yUWt5ZFJ3REgyWGds?=
 =?utf-8?B?YkdHdllOWW5FMlpQYTNLYU9nWm9oQURhd3phYnVBOUFOa0E1RE9NNkJIcGVM?=
 =?utf-8?B?aW1hYW44RFZsbytmMms2Mm5HV2ZXWnZXVXNBY2huUWNoNjg4Y3dLUXhyVUxu?=
 =?utf-8?B?eTlrVXU5NUp3WkFkOVl5RHVoNEdRVC8vdmFGQVI4WVVkYjBKelMycXpLbXU2?=
 =?utf-8?B?djlhblFDTjM1R092NVBVazFEYzBWeGtYK2w0d1RxelhpZG92aDdRMUlKTkhu?=
 =?utf-8?B?aEVMbDVoOWVwS2ZrSk5IdFJ3VzNyUW11QldGd3llSWUyN3hTR0l3RzIvaFVh?=
 =?utf-8?B?L24yUG84S2ZhdFd6WVYxbmxKNU1Ba21jOFhWYmJZUUlKOHo2TFRwN2x5OFNi?=
 =?utf-8?B?K1RJRGZzMWg3MG1HV0xqZjZxc1VZTGNNbTF3UUpHRmh6QXFpOEdjN3RjYUtX?=
 =?utf-8?B?R1cxaDdwaXVNZkhJZ0prVXZJMXRUM2JncWh6dldOc3dmbVZOb3ROTlJQbzZD?=
 =?utf-8?B?TWZOcWlZd2w3b0FmaWh5S056dmVrUE9uaXR3dW9OcDhBbkJ0dkVvQVFRcmdm?=
 =?utf-8?B?UTFzNWRLMklENzNzM3VGNzdDTWlTOWRNY0JJMXBvZVRtbFkzZUltbXZrVGFP?=
 =?utf-8?B?dWtWOFJPVWthbVRnZ3hUclpVeHBjWHg3QmpsNVJWTy9Bdk95eU1SckxxY1pl?=
 =?utf-8?B?NHdzMDNncEpiRGlKWFIrd3o0b3oremtEK015TnQ0aFZqeUo1WWRTdEJPWC9Q?=
 =?utf-8?B?cEJqS29NVEREN3VkRE52eFBGYzExV2g4VnQ1YXlwMTY2ZzAzK3hrTXBOMm1h?=
 =?utf-8?B?VDdqZHR5YzROcUlKZEw4STkxZ1c1TVFvcVVoLzE4K2FIQ0x1NUFnSVREVExG?=
 =?utf-8?B?eEdrZ1VrbSsvZDVaT1k1d0Vldm5tcXFhcWVZcjVZdEZOQkRGRjFCWG0zc1Jz?=
 =?utf-8?B?TGQ1ZGhKdFF5ZVlhS0lWdjBGZ3A5SjZSS3N4OUFTbm1tQzhuM2Z6bDVnaTRN?=
 =?utf-8?B?UGNZWXdwclFuRGRIWFhQMENSOHZFdUZueVhDcjFCZHBKMENLMEROKzFJdUg3?=
 =?utf-8?B?NzJzTVpLWEMxdjkzSDF3aGtZMEtYRGVJcTNaZFZRUSs3aDNVOHNtaGtHY0FF?=
 =?utf-8?B?Y2hqNTJYNmovYXI2R1FGR21yN21nNXJMSjB2WTNFQU55bzZqaFFhcUM2WDQx?=
 =?utf-8?B?RGdkR3pEaWhTV1kzdDhJWlRXdlFvUVgzSTIyYkpWaVJUTUlwMHJZVElpekd3?=
 =?utf-8?B?U2NVdzA5VXluNHFsaWpOQ2Z5em94dUlGbXhNbXVxd0kxT214V1U0VjQrSnpq?=
 =?utf-8?B?Q1RGS2N4NENXYUxiS2hqOFVVTUNvd0Nta3ZtVmZiQVRmNnNyTWtjMjZkcmhD?=
 =?utf-8?Q?Zz9aGx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mi9qSnRKU0lvck1yeWdxSDJTeDk5bCtQYnNCOW5OSnRTT1AzS09wdHBMNTly?=
 =?utf-8?B?YSttZzh6enZsYjBOK3dyR0dEQy84VytxV0hWQUFLcW1oc1VFRGdXZTZNVHdl?=
 =?utf-8?B?bTFhTC9WMTcvRUdvT2RmZzhLc2JBaFUyKzNmdzR3cHdXcUVlUmhEbDIwdEpF?=
 =?utf-8?B?TE1sd1cvaXAyZ09XSWJ1eW1laWlrNVQ5R1ArOUIwVk40TzFnZkRacDRvVzM3?=
 =?utf-8?B?ZXhHNDFQRlBobXE4blAvM2pjOTd5UlVZNUpBWHM4TXYyQXJ2dDYxRytFSEt2?=
 =?utf-8?B?N2wrVW1rVWFLQkdBa01hKzR1L016bXJtYnRsdTJyMDRTWkJFQ3BZKzJ6ait6?=
 =?utf-8?B?b2pqdWFKSUxVOVFodlVZSlRPSGhSZ2ZWNDEzQXVsRG96cDYwVHJTVzdVWUFy?=
 =?utf-8?B?ZFZiS2Q1Y0lZSy9qS2Zpb0cvR0hMZ1ZSTDJvV2k1WWlZTlhaNVpManVWQ2ts?=
 =?utf-8?B?QlJCMnhSS29uanlaV2plSGV4R2kxOTdoUkxzbU9HTzhXOUsyc29VaCt3enhJ?=
 =?utf-8?B?OE9RZndBUEV4Z0R2UG9GVDhPR01Ubm5DM0o3bTh2bW5GcXRqY3M5RzZFS1lo?=
 =?utf-8?B?bHFtWnBrajFPQUdEWHgrOWNPMG53RDh5dUZZRDVWT0FWNGIwdEtNenNQQ2J0?=
 =?utf-8?B?NlhqTGt0MVdsYkNWNzgzNStoYktJTUtUZHhkWTVTT3NiR3RkQmRuTjY0NndC?=
 =?utf-8?B?QTUwN083RGpHV2pMbTVHZXlXVmQraEJqTmxlRWhUMHFKem95Z2lQV1B3WTJ1?=
 =?utf-8?B?UjgvQWcrS3EwQzhZc1VZT1FQbXUvUjdCKzFCQm9jR0NCUVRSMDY5MTBTRXgz?=
 =?utf-8?B?Wlc4RmdGU2QvMEoxUXJiczRjK2V0dWpxN095VGFuOTArRW5tVEdTYlh4RHZh?=
 =?utf-8?B?eWh6V2ovTUF4OUt2LzU3RmlaN3hSTWVCVFJSaWRDLzJlSFY3QVliVkFEaUpy?=
 =?utf-8?B?Z0NJYkJ2dUtXTXU5YlVyL1laeVF4SXUvbXZrMUZyZksvemdBeHd0MXczeWhR?=
 =?utf-8?B?QnN3MHo3TlVRQWZuSHF4ZTdVcklpK0tjR3VTM3dRdE9RSnZWaXJyT1J4MjRB?=
 =?utf-8?B?MysrQ0ZWRWhyTXZ1djhhbnIyNjZVd0prVG1GWithNzJwcTBzTXpITVI5bzhr?=
 =?utf-8?B?bStGMC9wa2Q1WFA1NzRFdDhDY0RWQkhHaHYvQjVwcGVleVI5Nk81WERGdXpy?=
 =?utf-8?B?MjN2QnJMSVNZY3YyUXVMRG90cEU1RUJ3SWZwUkh6aVdvRFFBdGxnQk5CWHR3?=
 =?utf-8?B?NW95aGVPQkY4WkExWWM2cENNNm5OV2FpZXJBeCszWFZET0xlMlVIaTBzcFds?=
 =?utf-8?B?TWJwQ0tBenR6cXZDelZ3OVZiQmplUEZ2UENCWkJXWDBtNnNjeEJETHptZWtp?=
 =?utf-8?B?M1l4Zm1YeEcyd1ZsaXpMQUxFTFFNNGdKRnl5cDBBOE95QWdCamhoM3ZZN2FO?=
 =?utf-8?B?UzEyTTg1LzNjVTNsMkEvR0xNZk1ZZFI5S0xFeG5CZVc4aTZ4WUVyREhza0xx?=
 =?utf-8?B?azc2d1JwV0sxYXlNZ0hZZVkvVmUxMzFORjFNVk4xVGptTCtMcThUNlFVNjlp?=
 =?utf-8?B?em5BMGxqaUVwRm52MmxmMlNBYXRxbjgxc3RXbm00WUN3WUwxc1VNSFJSdGky?=
 =?utf-8?B?OTJZRnNQc3lYK014clNBWUVTcE9qUEo5USt2eU5kc2lnelhjMjBsOEVwSGxq?=
 =?utf-8?B?aGZvRFR6M1ZudWZDajA4OFZqVG5VeTkxUTJIWlRpR2piSFNtT1EzQmtaVU56?=
 =?utf-8?B?UVQ0Ri9SeVRDMmJSTEJJcktHQmVjRDZGWTN0MityTloxV3BJaXVXUVR4NEtF?=
 =?utf-8?B?NFQ0VDBNVVc5U2pxMUVYelhRK3UrQ1lyWGN4bmNSM0JXenlWbmk5VWc5MFBH?=
 =?utf-8?B?c3RVU3BlTmZiSkgwek1WZ09SUHAvVk1nbXZNbFJ0N052MG9xcFF0MXRZVURz?=
 =?utf-8?B?ZkNVTS8vN25PRTlNbks1OWxqejBnSkJqREUzNWkvTW1oTktsUEJFQ2R6RmtM?=
 =?utf-8?B?RnpBNGIyS2pKTEhOd0drNHBZR1RFa1N2c2pWN3ZRYUdXU3o3SHBrNk1teE9Q?=
 =?utf-8?B?Q2sxMjY3am92K2ZNSlRBQzRlNkpvOXR1MFJZK1N0bmt0VVFLQk11OGlmcUN1?=
 =?utf-8?Q?C3gWoSdbiLIXW8mUvpASV/Xco?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ecab2b-b366-44e7-22c9-08de3915901c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 00:29:50.7974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAxNkOiONw96/RclMh26MbjTrsjnHV77zhPDXEWTPy86kCz/pMCFgSICq1byHwprSxCtBYX2FRfT59suX4Vw6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

DQoNCj4gT24gRGVjIDEyLCAyMDI1LCBhdCA5OjE34oCvQU0sIEpvaG4gSHViYmFyZCA8amh1YmJh
cmRAbnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiAxMi8xMS8yNSA1OjM2IFBNLCBKb2Vs
IEZlcm5hbmRlcyB3cm90ZToNCj4+IEhpIFpoaSwNCj4+PiBPbiBUdWUsIERlYyAwOSwgMjAyNSBh
dCAwMzo0MToxNFBNICswMjAwLCBaaGkgV2FuZyB3cm90ZToNCj4+PiBPbiBTYXQsIDYgRGVjIDIw
MjUgMjE6MzI6NTEgLTA1MDANCj4+PiBKb2VsIEZlcm5hbmRlcyA8am9lbGFnbmVsZkBudmlkaWEu
Y29tPiB3cm90ZToNCj4+IFsuLl0NCj4+Pj4+IDB4MDAwMDAwMDQpOyArDQo+Pj4+PiArICAgICAg
ICAgICAgbGV0IHZhbCA9IGJhci5yZWFkMzIoMHg4ODAwMCArIDB4YmZjKTsNCj4+Pj4+ICsgICAg
ICAgICAgICBpbmZvLmI2NGJpdEJhcjIgPSB1ODo6ZnJvbSgodmFsICYgMHgwMDAwMDAwNikgPT0N
Cj4+Pj4+IDB4MDAwMDAwMDQpOw0KPj4+PiANCj4+Pj4gUGxlYXNlIG5vIG1hZ2ljIG51bWJlcnMs
IHBsZWFzZSB1c2UgcHJvcGVyIG5hbWVkIGNvbnN0YW50cyB3aXRoDQo+Pj4+IGRvY3VtZW50YXRp
b24gY29tbWVudHMgZXhwbGFpbmluZyB0aGUgdmFsdWVzLg0KPj4+PiANCj4+Pj4gQWxzbyBCQVIg
cmVhZHMgaGVyZSBuZWVkIHByb3BlciByZWdpc3RlciBtYWNybyBkZWZpbml0aW9ucy9hY2Nlc3Mu
DQo+Pj4+IA0KPj4+IA0KPj4+IFRoYXQgaXMgdHJ1ZS4gOikgQnV0IHRoaXMgaXMgYmVjYXVzZSB0
aGVyZSBpcyBubyByZWdpc3RlciBkZWZpbml0aW9uIGluDQo+Pj4gdGhlIE9wZW5STSBjb2RlL25v
biBPcGVuUk0gY29kZSBhcyB3ZWxsLiBJIGhhdmUgbm8gaWRlYSBhYm91dCB0aGUgbmFtZQ0KPj4+
IGFuZCBiaXQgZGVmaW5pdGlvbnMgb2YgdGhpcyByZWdpc3Rlci4NCj4+PiANCj4+PiBTdXBwb3Nl
IEkgd2lsbCBoYXZlIHRvIGZpbmQgc29tZSBjbHVlcyBmcm9tIHNvbWUgZm9sa3MgdGhlbiBkb2N1
bWVudA0KPj4+IHRoZW0gaGVyZSB3aGVuIGdvaW5nIHRvIHBhdGNoZXMgcmVxdWVzdCBmb3IgbWVy
Z2VkLiA6KQ0KPj4gSSB0aGluayB0aGVzZSBtYWdpYyBudW1iZXJzIGFyZSBQQ0llIGNvbmZpZyBz
cGFjZSByZWxhdGVkLiBJIGZvdW5kIGEgY291cGxlIG9mIHJlZmVyZW5jZXMgWzFdIFsyXSBbM10N
Cj4+IFsxXQ0KPj4gSW4gT3BlbiBHUFUgZG9jcywgSSBzZWUgMHgwMDA4ODAwMCBpcyBOVl9QQ0ZH
IGJ1dCB0aGlzIGlzIG9uIFR1cmluZywgbGV0cw0KPj4gY29uZmlybSB3aGF0IGl0IGlzIG9uIG90
aGVyIGFyY2hpdGVjdHVyZXMgKGlmIG5vdCBjb21tb24sIHNob3VsZCBpdCBnbw0KPj4gdGhyb3Vn
aCBhIEhBTD8pLg0KPiANCj4gSXQgY2hhbmdlZCBvbiBIb3BwZXIuIE15IEhvcHBlci9CbGFja3dl
bGwgc2VyaWVzIGhhbmRsZXMgdGhpcy4NCg0KR3JlYXQsIHRoYW5rcyBmb3IgY29uZmlybWluZywg
Sm9obi4gWmhpLCB5b3Ugc2hvdWxkIHByb2JhYmx5IHJlYmFzZSBvbiB0aGUgc2VyaWVzIGZyb20g
Sm9obiB0aGVuLg0KDQp0aGFua3MsDQoNCiAtIEpvZWwNCg0KDQoNCj4gDQo+IHRoYW5rcywNCj4g
Sm9obiBIdWJiYXJkDQo+IA0KPj4gaHR0cHM6Ly9naXRodWIuY29tL05WSURJQS9vcGVuLWdwdS1r
ZXJuZWwtbW9kdWxlcy9ibG9iL2E1YmZiMTBlNzVhNDA0NmM1ZDk5MWM2NWY0OWI1ZDI5MTUxZTY4
Y2Yvc3JjL2NvbW1vbi9pbmMvc3dyZWYvcHVibGlzaGVkL3R1cmluZy90dTEwMi9kZXZfbnZfeHZl
LmgjTDQNCj4+IGFuZCAweGJmNCBpcyBTUklPViBjYXBhYmlsaXR5IGhlYWRlcnMsIHBlciB0aGUg
c2FtZSBoZWFkZXIgZmlsZToNCj4+IE5WX1hWRV9TUklPVl9DQVBfSERSMTANCj4+IEFsc28gdGhl
IGJpdCBkZWZpbml0aW9uIGlzIG5vdCBkb2N1bWVudGVkIGluIHRoYXQgcHVibGljIGhlYWRlciwg
YnV0IEkgZmluZA0KPj4gZnJvbSBpbnRlcm5hbCBzb3VyY2VzIHRoYXQgd2hhdCB5b3UncmUgdHJ5
aW5nIHRvIGRvIHdpdGggdGhlICImIDB4NiIgaXMNCj4+IGRldGVybWluZSB3aGV0aGVyIHRoZSBW
RiBCQVIgaXMgY2FwYWJsZSBvZiA2NC1iaXQgYWRkcmVzc2luZzoNCj4+ICBCaXRzIFsyOjFdIGlz
IFZGX0JBUjFfQURSX1RZUEUgYW5kID0gMiBtZWFucyB0aGUgQkFSIGlzIGNhcGFibGUgb2YgNjQt
Yml0DQo+PiAgYWRkcmVzc2luZywgYW5kID0gMCBtZWFucyAzMi1iaXQuDQo+PiBJIHdvbmRlciBp
ZiB0aGUgZm9ybWF0IG9mIHRoZXNlIGNhcGFiaWxpdHkgaGVhZGVycyBhcmUgcHJlc2VudCBpbiB0
aGUgUENJDQo+PiBzcGVjaWZpY2F0aW9uPyBJdCBpcyB3b3J0aCBjaGVja2luZywgSSBmaW5kIHNv
bWUgdmVyeSBzaW1pbGFyIG1lbnRpb25zIG9mIHRoZQ0KPj4gdmFsdWUgMiBiZWluZyA2NC1iaXQg
aW4gaHR0cHM6Ly93aWtpLm9zZGV2Lm9yZy9QQ0kgYXMgd2VsbC4NCj4+IFsyXQ0KPj4gSW4gTm91
dmVhdSBJIGZvdW5kIHRoZSAweDg4MDAwDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25v
dXZlYXVfcmVnLmggKzY4NA0KPj4gV2l0aCBhIGJ1bmNoIG9mIGlkcyBhbmQgc3VjaCB3aGljaCBp
cyB0eXBpY2FsIG9mIHdoYXQgaXMgaW4gY29uZmlnIHNwYWNlOg0KPj4gIyAgICBkZWZpbmUgTlY1
MF9QQlVTX1BDSV9JRCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDA4ODAwMA0K
Pj4gIyAgICAgICAgZGVmaW5lIE5WNTBfUEJVU19QQ0lfSURfVkVORE9SX0lEICAgICAgICAgICAg
ICAgICAgMHgwMDAwZmZmZg0KPj4gIyAgICAgICAgZGVmaW5lIE5WNTBfUEJVU19QQ0lfSURfVkVO
RE9SX0lEX19TSElGVCAgICAgICAgICAgICAgICAgICAgMA0KPj4gIyAgICAgICAgZGVmaW5lIE5W
NTBfUEJVU19QQ0lfSURfREVWSUNFX0lEICAgICAgICAgICAgICAgICAgMHhmZmZmMDAwMA0KPj4g
IyAgICAgICAgZGVmaW5lIE5WNTBfUEJVU19QQ0lfSURfREVWSUNFX0lEX19TSElGVCAgICAgICAg
ICAgICAgICAgICAxNg0KPj4gUGVyaGFwcyB0aGlzIGlzIHNvbWV0aGluZyBwZGV2LmNvbmZpZ19y
ZWFkX2R3b3JkKCkgc2hvdWxkIGJlIGdpdmluZz8NCj4+IFszXSBUaGlzIG9uZSBJIGFtIG5vdCBz
dXJlIG9mZiwgYnV0IHRoZSBsaW5rDQo+PiBodHRwczovL2Vudnl0b29scy5yZWFkdGhlZG9jcy5p
by9lbi9sYXRlc3QvaHcvYnVzL3BjaS5odG1sIHNheXMgdGhhdCBvbiBOVjQwKw0KPj4gY2FyZHMs
IGFsbCAweDEwMDAgYnl0ZXMgb2YgUENJRSBjb25maWcgc3BhY2UgYXJlIG1hcHBlZCB0byBNTUlP
IHJlZ2lzdGVyDQo+PiBzcGFjZSBhdCBhZGRyZXNzZXMgMHg4ODAwMC0weDg4ZmZmLiBUaGlzIG1h
dGNoZXMgZXhhY3RseSB0aGUgbWFnaWMgbnVtYmVyIGluDQo+PiB5b3VyIHBhdGNoLg0KPj4gQWxz
bywgSSB3b25kZXIgaWYgd2UgbmVlZCB0byBkZXRlcm1pbmUgaWYgdGhlIEJBUnMgY2FuIGJlIDY0
LWJpdCBhZGRyZXNzZWQsIGRvDQo+PiB3ZSBoYXZlIHJlcXVpcmVtZW50cyBmb3IgQkFSIHNpemVz
ID4gNEdCIGZvciB2R1BVIGFuZCBpZiBub3QsIGRvIHdlIG5lZWQgdG8NCj4+IGRldGVybWluZSB0
aGUgQkFSIHNpemUgYWRkcmVzc2FiaWxpdHk/DQo+PiBBbHNvLCBzaG91bGRuJ3QgdGhlIFBDSSBj
b3JlIHN1YnN5c3RlbSBiZSBhdXRvbWF0aWNhbGx5IGRldGVybWluaW5nIGlmIHRoZQ0KPj4gQkFS
cyBhcmUgNjQtYml0IGFkZHJlc3NhYmxlPyBOb3Qgc3VyZSBpZiB0aGF0IGJlbG9uZ3MgaW4gdGhl
IGRyaXZlci4gSXQgd291bGQNCj4+IGJlIGdvb2QgdG8gdW5kZXJzdGFuZCBob3cgdGhpcyBpcyBz
dXBwb3NlZCB0byB3b3JrLg0KPj4gdGhhbmtzLA0KPj4gIC0gSm9lbA0KPiANCg==

