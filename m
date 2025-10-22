Return-Path: <linux-pci+bounces-38982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AFCBFB4C2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DD619C01B2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993D3128AC;
	Wed, 22 Oct 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kl1GQ+rn"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B0287504;
	Wed, 22 Oct 2025 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127576; cv=fail; b=C+ls2DzaWedvb8F1GaPVS7Efl/alWqZj7cXQlaFnsw4pCik5FCsScxYIMZK97JjZzvKEuxfHtnie5bYj6HvpC8G3Dznwh7Qj1fDCQXcloRLEuSZF2+u1SQUUGyLydiTcg0mtZpCKX795QL1dKQpQ3uJibUCoHQsbfXekHuZmYcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127576; c=relaxed/simple;
	bh=feb6S+zRJWvO47fBHfk3gJfu/EA2k2c8OI7q/zhcbFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HykPQ84a67GfbIZBqIyqIUYy506wVzRkTefdCDorMglrE5O1FHuAIH+sKG+Jnw3M/YJ8VeSqIMYxdT/uqwHDI7K8P3csqIVFmEtwHqmLEz51PZypVMC9pMhWMkcQMshtZq5di/6OnMNhTOhonOy/lkQGBl4gUy6BMWPPlufh19Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kl1GQ+rn; arc=fail smtp.client-ip=40.93.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2xzRnM73nOJf+qDp8MpvDNzWf/OYAP/E1eDaN9ikVgHPQ0NjNjQXSoQHFJDbq/Hees+saAxx18ZX/075yFnlQjtG7ezEPMkJSUFwzNrIOPVbqzsMuhltfYrs0SfMfaKdJ1XaThHygfEoQE9KGUZOKG8izVlvEs4lVPGL1E+SV306/WO0rETUkgM19V+5Cr19RORG2m9U/O3Ki+SwkKG00D4mIbgIM/0MM8B2etO3XhnPqObxslEXjhVKekU/8/6gvIbewS0pmlmzeZQunxvmUp76Abe8yMmVnyXOg0PgjE6vayzXkpTakk2y5xzp/D5nYVVW5F7BI3YGf8r/3wDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feb6S+zRJWvO47fBHfk3gJfu/EA2k2c8OI7q/zhcbFQ=;
 b=OW+3S8VO9qhtDWCiSpMOhnrjjf16bCP9sRLOFGBQd2mT1hSg2h2xmwe40GVZyOHCWuJHIACbHPffOECMT64xRTZNXNC6iVeSmm9g4AkPy8sWQ6Q4w5A+37N0/aAEhwwDFsbbrLXawNDKvgKVIhe2ldGSu8zQun9O5DLbsAEGdpxkAHJIhR6Y2NSfcTs8XblNyZwKr0OjzvZSxG80991L//29L7wF1mj/iVJKhPcCnPZpwFvwWxg/fR9isoss0xSeB0qRT7dXT+AsVKJXon7emaUOs8Uw+e++F+8PhSlDeI5JjqOFCaqjxQtQpaXFIAYxRzSwnHLS83lYoEJpkrUIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feb6S+zRJWvO47fBHfk3gJfu/EA2k2c8OI7q/zhcbFQ=;
 b=Kl1GQ+rnpZ1v6wqLETXB5U09FBo/APmP5zwqPzJRA7xJaPYuwdVj4U4u0f8N/Vn7K4oSDHBX+S6vBOm422+c4jleSGHH4udi5zw7F4xw/SuSIdgWzGdc3+97IjuSKjt1PABSaK9n+5JEToG2RpWuFjXzsNJf/jWfo8Vp41KjrSY=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 10:06:10 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 10:06:09 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "mani@kernel.org" <mani@kernel.org>, Stefan Roese
	<stefan.roese@mailbox.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
	<ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: RE: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Index:
 AQHcKoFZBALFGa/Kqki5vrSD8b1UILTNCbqAgAAGd4CAABdpAIAAHYKAgAAJCICAAJ+fgIAAMSWAgAAAawCAAAItMA==
Date: Wed, 22 Oct 2025 10:06:09 +0000
Message-ID:
 <SN7PR12MB72014496D67C73076124E77D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <SN7PR12MB72017ACEC56064C19C1B62938BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
In-Reply-To:
 <SN7PR12MB72017ACEC56064C19C1B62938BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T09:56:42.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ5PPF75EAF8F39:EE_
x-ms-office365-filtering-correlation-id: 8af6f5aa-4dd6-4567-81d5-08de11529fcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tml1RXVpMTNKemVkU1ZoMGZscDh5Q1haZnhEN0ZqTFNidVZhOWRsdlU2TlRB?=
 =?utf-8?B?ZUZZdWt5dEc3UXdCaFRQTlRvWExNNFpRamZrbHJBZEcwOG9SZXR6SE1rc3ow?=
 =?utf-8?B?LzFQRzBZbDNVZDFVSEllTVhmSkZLM0pnekNrSlRhMm5RYjhONlFXQ3JmUDNz?=
 =?utf-8?B?M0RrNFRORGcyR2o5U09SbVNrS3I4anpCYllSTXBONXNsdmpKTkgwZXFQQjFE?=
 =?utf-8?B?Ky9oVHNZWTc0U1RDK2xaeGNRT2QydjZjSDFkTENpM1UvOGNMREFMSVpoMm8z?=
 =?utf-8?B?eHRPRkNDelQ5R0tqcXZUMG11QWtlR0R2UHVmVUs3T1ZKVnNPUFIrZHNMOS9j?=
 =?utf-8?B?ZHN1WE9FNm9DZitQWjZ6VXV3eG14c0EwU1NpclVqUkxYbHlNNzZSK2UwMEtP?=
 =?utf-8?B?M3QzN0dRN2kzaTZSUFBDeE85NTY5a3pkd3FUL1BZWmhSMGxVR0cxZVlvZ3dk?=
 =?utf-8?B?QWtQNGVNOVpYWnNtelRnV3YzeDJjc21qWFdCNENrVGVuazY0MDFsOUFvUHFJ?=
 =?utf-8?B?WDBzZVJyNy83VGFrcHJvNXJBV3Q5S2lGR2JjYWJzdzkxSHByYzV4VUhIU1A2?=
 =?utf-8?B?NTNqQkJLaWFpTmo0bC9zaFVpbXBOREM4WU5VVytERVJWbW44NjhPdHJ1THVw?=
 =?utf-8?B?N1BlUlhZQ09QOWtLRVB4Yno4UU5QalJpRDE4WHlEQ2g4U09hbWNxRjFIdnMw?=
 =?utf-8?B?YTRkakdYNU1oTHNSRkFpZUNpTzlUckpaRlZ1TTdUcFdzQlNyZnUwL3NnS1Vt?=
 =?utf-8?B?OTl1OTBZQVZKMkgwV3JmVmFtbjk1UzkyV0ZjazAvajVzaXpSbjBnamJMSGY5?=
 =?utf-8?B?K0hJOG9FQ1pFRW9sdGhWVWlyZkNDRlRmeUtaZXNTZ2JwVXJLZlorTnJ1TkVy?=
 =?utf-8?B?U0tyWmhTVmltUEhsMllPbTF6aVR0SmNtWmxJc3pibDNpV0VXUncyelVsTVZY?=
 =?utf-8?B?ZzA1dmxiTUwvSUMzN29QUHUrbTlPN0pEY2lPT1JrZThLeW5yS1Jzc3QySlF6?=
 =?utf-8?B?QlRtZE9tYmxtaDN3cy85dE1yRFM3YXFSSE5TRXNLdTJqRGhmR1dEVjZUUGR4?=
 =?utf-8?B?OHBydkNuTlo4cUtrUHlaaWRxQ2RKWHgzNkRLVWJjcDFobEMyWEl4b3NNVUFq?=
 =?utf-8?B?dkV2Ym9NS1czRkRoOTlSSGpyTUREVmpzQUpqZHRsNkg0Tng5M2MraGd3c2pn?=
 =?utf-8?B?WEJoK2Rmd2YxTjJoRzNYeHRsa1FpbFhmOGpTMjlaSzZtczJyNHBFQ1dqNzh3?=
 =?utf-8?B?cjBsaURrOG5qQnk0TnB1N0VrSko5am0xR3VvaytLOFV4UktrTVUvVlBYdkxn?=
 =?utf-8?B?RVRuR0FIQlZTQkgzV2g1VjR0TllxYit6VW9sRWN5NTBQM3NwVS8vLzB6N1V3?=
 =?utf-8?B?YVc4SmFGbGV0SElqNWZCZWxSRU5NcVh3eC82cTFKNGNjcmRqZDVsbTczNGUv?=
 =?utf-8?B?UXZmdWdRWHNPSG40SWdiU28wUjJHMTErc2xZZU0ySE1XRUp3WGVqZW43alFr?=
 =?utf-8?B?bGpsUUhKeHovekJDYjZ1RTBubG8xTzlZcVNGcVRGOEhrdVlTSkRSMWpoWE1a?=
 =?utf-8?B?WlJQUFk3Q3JMOHpjVVVsUHpIOVUzTGNoNEs5bG5ueTNicXp6SEZURm5CMytr?=
 =?utf-8?B?VVh5VmJtWFE1UXd2RFB2RmRubHBuWE4zZFhadWR6N25CVkJtRTUvekVTdE9Z?=
 =?utf-8?B?UWZTclNxc21iSG5qeExueTVKdEtPZUU2MVB2M01xQVNvQm9ueHJPSVAvMjhJ?=
 =?utf-8?B?L25VdjNoQ2pOYkNHSVgxS09XQnJoMDdCVXJMMmloVGRQY3FvUzMwdm40S1N1?=
 =?utf-8?B?TXVUaURMZUZnT2txQXQ4YndhcUkrNDhOUnZZYWtYWGxrY2J6VHdZSTFpOVVi?=
 =?utf-8?B?NUg3VFFYbUFrTVFETjljc2ZwQjdNSk9IT0FXOFUyeFJFZXRvakJEbUVaNEtn?=
 =?utf-8?B?RVphYlUvLzZrN0ZTdHBjWjdtQXFmRWwxejI1ZUJUR3R4T2lwVVRUaFNjUlcv?=
 =?utf-8?B?RGFYUGZKQ2VMWHVlTFhWeTJaa2xYK0gwQ2IxTTcxNXhETWYwdndXRzkxK0Vm?=
 =?utf-8?Q?pquTyZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1BSbE41SzViNXF2dGU1SXJ0aWZTNWdid2tJaHBvSFFxZkhPWldnUUQzZlhv?=
 =?utf-8?B?QTYra05UL0FMMVhlTE1UdTdIWmVNRnJGblZCR1RHTHJWTjhjL0xRT3ptY21a?=
 =?utf-8?B?VkNnQmhVaWVXY2kxcHFCQklsL3Y5aXRGb3ZEcGtOemVHL1pmblp5VXBQTDVV?=
 =?utf-8?B?MzVFMlM3WEdCYzlLRGVibzVyZERvdzQ5QXo1bUwyN3F6cThOWU43QUU0WGxt?=
 =?utf-8?B?MW1VbFRUQ2I5VTRCREhudmtvblZXSXBMbFRLNnRlOXJkTjJlU2hPMmVGYmQw?=
 =?utf-8?B?NTNYck9GYWQ0NXpxWHhzVG4rVy9MR3hNSUhmN1ZQVWtzYTVxS3ZRUXpGaDJ5?=
 =?utf-8?B?V3I0YjMybTYvQVF0d2ZGU2hhVmZtZmRWY21KUE4rNjNxY0JoM3ZnY3FQNWZZ?=
 =?utf-8?B?ZTJPTGtKL2dXQk1MUTFzaXk2MHNJTXlXcURDaXlDNHFsODMwdEZNaTBodjI2?=
 =?utf-8?B?QUZrL091ZzVjWTl3cFh0RWkrTjJ5Yk84amtBYk9JUGJDcHY0eTN5K2ZqUU1o?=
 =?utf-8?B?SFMrZmZFRzh5RXI4cXNvQ0JCeEVZakQ3RHNQUjN0dk9Xakxkc21ibTQ3NWpU?=
 =?utf-8?B?WHU5UWZsc0lEUkxNUVNNekZtdFlzb2hJdW12L1o0VFgrL2gzUkxJVU50UjRi?=
 =?utf-8?B?bEFBUDFvSnZDNSs3MTVFQUg5RzZBMk9tS09vcGQwa1lwZXAwS1c3Y1k1R00r?=
 =?utf-8?B?blJBalJBcGJsRyt3bU1Kc0YyS0xRZFpWa2NmbWxIclFkUGRsbWZ2c29jZVhD?=
 =?utf-8?B?WDJRVFF3clpBWTFHTk1kSjdHWGd4RzFoSUE4SWpoWXgxWWZCd3RDSXBxUGhW?=
 =?utf-8?B?am5WTnpRZGRXaW9aK3NJLzRGOEV1T1hRNmRURmNXeVpzZkQ0enNWeGtkS1Q4?=
 =?utf-8?B?YXdQQXNDREd1ck8yYysrZDExdG4rendGbUZlOFFwb3BUNkI1ZkdKQ1ROaTNt?=
 =?utf-8?B?UFpHYzc5UnpuKzdqTTNzZ3FLNGg5eWd4QnB6QmtHSGJpODJCbURHSDNkK3pj?=
 =?utf-8?B?V2dGSFBVa3N3UDZtcnlrNzErL0wxNmszcW1qUkdLelhtTEVQaGdscDFqRUdL?=
 =?utf-8?B?M04xRmRUVWxzRTJpeW9uZUFNMjdnSFBncHFPSitZN2JQZzBXR25JYlV3MzE4?=
 =?utf-8?B?N3NQeHgvVW1MdGNrcTdOZ2c0SnRRZ2pGWkowUFpvQ3dYdUxVb0dqOFlMN3Zi?=
 =?utf-8?B?bFZoWTNPSjVTTXFtKzB5QUNkcmhCNnJuZXkvaG5EakFWNng3RlBpSUxValhW?=
 =?utf-8?B?TTYraFJCYVNpUW04R0pnQlplbW9vc2pHcTkrcWdwbjdGM0RSaXozVlBRejFs?=
 =?utf-8?B?NGZuNEFNYnV1bERJU0xRSGIvczJ6NXlDeWxxSHY0WkQycE5jOEhKcjBnY3Fx?=
 =?utf-8?B?NjgrRy9MZHVWN1pYcjBzWjdLcFM1TWxNNGRWSTA0a2M5clR2WGZDdnVSUnZo?=
 =?utf-8?B?a2RWQ0pIY0Vld0FMZjA1TnRXS3A5UGZlMkNLbmtRL0RtQUNJRkRzM0RYZVBt?=
 =?utf-8?B?eEFnL1VDOU8vYmN4bm4zbS80Vk5wR1YyaWJ6TlFXRjZ2ZnVBbTB5OHVDUFNZ?=
 =?utf-8?B?Rks1bHVzOUgvWUNxYUIzUVlFNHlNZ0VKUFFkaVV6Rkk3LzVQWHVBdWhlSXFH?=
 =?utf-8?B?ZFc1SCs2UkRVa2cra2Jqa21qMVpvRTFNMGtpd1dNWjlFdFZOUzNWUFhKZURj?=
 =?utf-8?B?cUF6dkQvaVhOTVhtM0hNNlErWkVuemN0OFJYeVFtMlNzVXpIU2xlSjMyWDNI?=
 =?utf-8?B?Q0xMVHFqTC9XTUdPZXo5ZjJSRXNsVlpoMmRYWC9DNjhrbmo5QjFGaXlMRTlL?=
 =?utf-8?B?dGJLUExFVjBtSThTekpHdlV2S2JWS1RVVzRRcVlEUkVuNjlsa01kUzJSeTM0?=
 =?utf-8?B?N1drdjlrSXlMNTVtMTNzYkMxTjAyRFpsTVh1SmpOK2dGN0hwUFBVZGJ2cmUw?=
 =?utf-8?B?QlJXSVRBNTVYWkozUmtyMHpoemZveXJOWTdhTGpGVEljWDV3MGdueTloYWdH?=
 =?utf-8?B?b0NobXdQZjNaOCtDVlhUazdPcW9Kck5CcERNR2JZdlRNRUFqYkhLSlI5WXRL?=
 =?utf-8?B?SSs5Mi9lNWYvNmp2RWNYQ1FCbHFzRUxoU2poTEF1QW05OHRNaE0raEZVWVRv?=
 =?utf-8?Q?bm1I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af6f5aa-4dd6-4567-81d5-08de11529fcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 10:06:09.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaOlpK4BmO23Wkalcl6Wk0icadxFxwdLnR5I//hpzApELEs/KftBVjXSmx2TZTX2OCUEq4JCif2fgZS0bTZ6Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXZh
bGlnZSwgVGhpcHBlc3dhbXkNCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIyLCAyMDI1IDM6
MzQgUE0NCj4gVG86ICdtYW5pQGtlcm5lbC5vcmcnIDxtYW5pQGtlcm5lbC5vcmc+OyBTdGVmYW4g
Um9lc2UNCj4gPHN0ZWZhbi5yb2VzZUBtYWlsYm94Lm9yZz4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMg
PGhlbGdhYXNAa2VybmVsLm9yZz47IEJhbmRpLCBSYXZpIEt1bWFyDQo+IDxyYXZpYkBhbWF6b24u
Y29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC0N
Cj4gcGNpQHZnZXIua2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgcm9iaEBrZXJu
ZWwub3JnOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IFNlYW4gQW5kZXJzb24NCj4gPHNlYW4uYW5k
ZXJzb25AbGludXguZGV2PjsgWWVsZXN3YXJhcHUsIE5hZ2FyYWRoZXNoDQo+IDxuYWdhcmFkaGVz
aC55ZWxlc3dhcmFwdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyXSBQQ0k6IHhp
bGlueC14ZG1hOiBFbmFibGUgSU5UeCBpbnRlcnJ1cHRzDQo+DQo+IEhpIE1hbmksDQo+DQo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBtYW5pQGtlcm5lbC5vcmcgPG1h
bmlAa2VybmVsLm9yZz4NCj4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjIsIDIwMjUgMzoy
NSBQTQ0KPiA+IFRvOiBTdGVmYW4gUm9lc2UgPHN0ZWZhbi5yb2VzZUBtYWlsYm94Lm9yZz4NCj4g
PiBDYzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgQmFuZGksIFJhdmkgS3Vt
YXINCj4gPiA8cmF2aWJAYW1hem9uLmNvbT47IEhhdmFsaWdlLCBUaGlwcGVzd2FteQ0KPiA+IDx0
aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiA+
IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4ga3dp
bGN6eW5za2lAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsDQo+ID4g
PG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtYXJtLSBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJu
ZWwub3JnOyBTZWFuIEFuZGVyc29uDQo+ID4gPHNlYW4uYW5kZXJzb25AbGludXguZGV2Pg0KPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogeGlsaW54LXhkbWE6IEVuYWJsZSBJTlR4IGlu
dGVycnVwdHMNCj4gPg0KPiA+IE9uIFdlZCwgT2N0IDIyLCAyMDI1IGF0IDA4OjU5OjE5QU0gKzAy
MDAsIFN0ZWZhbiBSb2VzZSB3cm90ZToNCj4gPiA+IEhpIEJqb3JuLA0KPiA+ID4gSGkgUmF2aSwN
Cj4gPiA+DQo+ID4gPiBPbiAxMC8yMS8yNSAyMzoyOCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4g
PiA+ID4gT24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMDg6NTU6NDFQTSArMDAwMCwgQmFuZGksIFJh
dmkgS3VtYXIgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBUdWUsIE9jdCAyMSwgMjAyNSBhdCAwNTo0
NjoxN1BNICswMDAwLCBCYW5kaSwgUmF2aSBLdW1hcg0KPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiBPbiBPY3QgMjEsIDIwMjUsIGF0IDEwOjIz4oCvQU0sIEJqb3JuIEhlbGdhYXMNCj4gPiA+ID4g
PiA+ID4gPiA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+
IE9uIFNhdCwgU2VwIDIwLCAyMDI1IGF0IDEwOjUyOjMyUE0gKzAwMDAsIFJhdmkgS3VtYXIgQmFu
ZGkNCj4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+IFRoZSBwY2llLXhpbGlueC1kbWEtcGwg
ZHJpdmVyIGRvZXMgbm90IGVuYWJsZSBJTlR4DQo+ID4gPiA+ID4gPiA+ID4gPiBpbnRlcnJ1cHRz
IGFmdGVyIGluaXRpYWxpemluZyB0aGUgcG9ydCwgcHJldmVudGluZyBJTlR4DQo+ID4gPiA+ID4g
PiA+ID4gPiBpbnRlcnJ1cHRzIGZyb20gUENJZSBlbmRwb2ludHMgZnJvbSBmbG93aW5nIHRocm91
Z2ggdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiBYaWxpbnggWERNQSByb290IHBvcnQgYnJpZGdlLiBU
aGlzIGlzc3VlIGFmZmVjdHMga2VybmVsDQo+ID4gPiA+ID4gPiA+ID4gPiA2LjYuMCBhbmQNCj4g
PiBsYXRlciB2ZXJzaW9ucy4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBU
aGlzIHBhdGNoIGFsbG93cyBJTlR4IGludGVycnVwdHMgZ2VuZXJhdGVkIGJ5IFBDSWUNCj4gPiA+
ID4gPiA+ID4gPiA+IGVuZHBvaW50cyB0byBmbG93IHRocm91Z2ggdGhlIHJvb3QgcG9ydC4gVGVz
dGVkIHRoZSBmaXgNCj4gPiA+ID4gPiA+ID4gPiA+IG9uIGEgYm9hcmQgd2l0aCB0d28gZW5kcG9p
bnRzIGdlbmVyYXRpbmcgSU5UeCBpbnRlcnJ1cHRzLg0KPiA+ID4gPiA+ID4gPiA+ID4gSW50ZXJy
dXB0cyBhcmUgcHJvcGVybHkgZGV0ZWN0ZWQgYW5kIHNlcnZpY2VkLiBUaGUNCj4gPiA+ID4gPiA+
ID4gPiA+IC9wcm9jL2ludGVycnVwdHMgb3V0cHV0DQo+ID4gPiA+ID4gPiA+ID4gPiBzaG93czoN
Cj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBbLi4uXQ0KPiA+ID4gPiA+ID4g
PiA+ID4gMzI6ICAgICAgICAzMjAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxNiBMZXZl
bCAgICAgNDAwMDAwMDAwLmF4aS0NCj4gPiBwY2llLCBhemRydg0KPiA+ID4gPiA+ID4gPiA+ID4g
NTI6ICAgICAgICA0NzAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxNiBMZXZlbCAgICAg
NTAwMDAwMDAwLmF4aS0NCj4gPiBwY2llLCBhemRydg0KPiA+ID4gPiA+ID4gPiA+ID4gWy4uLl0N
Cj4gPiA+DQo+ID4gPiBGaXJzdCBhIGNvbW1lbnQgb24gdGhpcyBJUlEgbG9nZ2luZzoNCj4gPiA+
DQo+ID4gPiBUaGVzZSBsaW5lcyBkbyBOT1QgcmVmZXIgdG8gdGhlIElOVHggSVJRKHMpIGJ1dCB0
aGUgY29udHJvbGxlcg0KPiA+ID4gaW50ZXJuYWwgImV2ZW50cyIgKGVycm9ycyBldGMpLiBQbGVh
c2Ugc2VlIHRoaXMgbG9nIGZvciBJTlR4IG9uIG15DQo+ID4gPiBWZXJzYWwgcGxhdGZvcm0gd2l0
aCBwY2lfaXJxZF9pbnR4X3hsYXRlIGFkZGVkOg0KPiA+ID4NCj4gPiA+ICAyNDogICAgICAgICAg
MCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgICAwIExldmVsICAgICBMSU5LX0RPV04NCj4g
PiA+ICAyNTogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgICAzIExldmVs
ICAgICBIT1RfUkVTRVQNCj4gPiA+ICAyNjogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6
UkMtRXZlbnQgICA4IExldmVsICAgICBDRkdfVElNRU9VVA0KPiA+ID4gIDI3OiAgICAgICAgICAw
ICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgIDkgTGV2ZWwgICAgIENPUlJFQ1RBQkxFDQo+
ID4gPiAgMjg6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxMCBMZXZl
bCAgICAgTk9ORkFUQUwNCj4gPiA+ICAyOTogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6
UkMtRXZlbnQgIDExIExldmVsICAgICBGQVRBTA0KPiA+ID4gIDMwOiAgICAgICAgICAwICAgICAg
ICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjAgTGV2ZWwgICAgIFNMVl9VTlNVUFANCj4gPiA+ICAz
MTogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDIxIExldmVsICAgICBT
TFZfVU5FWFANCj4gPiA+ICAzMjogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZl
bnQgIDIyIExldmVsICAgICBTTFZfQ09NUEwNCj4gPiA+ICAzMzogICAgICAgICAgMCAgICAgICAg
ICAwICBwbF9kbWE6UkMtRXZlbnQgIDIzIExldmVsICAgICBTTFZfRVJSUA0KPiA+ID4gIDM0OiAg
ICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjQgTGV2ZWwgICAgIFNMVl9D
TVBBQlQNCj4gPiA+ICAzNTogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQg
IDI1IExldmVsICAgICBTTFZfSUxMQlVSDQo+ID4gPiAgMzY6ICAgICAgICAgIDAgICAgICAgICAg
MCAgcGxfZG1hOlJDLUV2ZW50ICAyNiBMZXZlbCAgICAgTVNUX0RFQ0VSUg0KPiA+ID4gIDM3OiAg
ICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjcgTGV2ZWwgICAgIE1TVF9T
TFZFUlINCj4gPiA+ICAzODogICAgICAgICA5NCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQg
IDE2IExldmVsICAgICA4NDAwMDAwMC5heGktcGNpZQ0KPiA+ID4gIDM5OiAgICAgICAgIDk0ICAg
ICAgICAgIDAgIHBsX2RtYTpJTlR4ICAgMCBMZXZlbCAgICAgbnZtZTBxMCwgbnZtZTBxMQ0KPiA+
ID4NCj4gPiA+IFRoZSBsYXN0IGxpbmUgc2hvd3MgdGhlIElOVHggSVJRcyBoZXJlICgncGxfZG1h
OklOVHgnIHZzICdwbF9kbWE6UkMtDQo+ID4gPiBFdmVudCcpLg0KPiA+ID4NCj4gPiA+IE1vcmUg
YmVsb3cuLi4NCj4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gQ2hh
bmdlcyBzaW5jZSB2MTo6DQo+ID4gPiA+ID4gPiA+ID4gPiAtIEZpeGVkIGNvbW1pdCBtZXNzYWdl
IHBlciByZXZpZXdlcidzIGNvbW1lbnRzDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gRml4ZXM6IDhkNzg2MTQ5ZDc4YyAoIlBDSTogeGlsaW54LXhkbWE6IEFkZCBYaWxpbngg
WERNQQ0KPiA+ID4gPiA+ID4gPiA+ID4gUm9vdCBQb3J0IGRyaXZlciIpDQo+ID4gPiA+ID4gPiA+
ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogUmF2aSBLdW1hciBCYW5kaSA8cmF2aWJAYW1hem9uLmNvbT4NCj4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEhpIFJhdmksIG9idmlvdXNseSB5b3UgdGVzdGVkIHRoaXMs
IGJ1dCBJIGRvbid0IGtub3cgaG93DQo+ID4gPiA+ID4gPiA+ID4gdG8gcmVjb25jaWxlIHRoaXMg
d2l0aCBTdGVmYW4ncyBJTlR4IGZpeCBhdA0KPiA+ID4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNTEwMjExNTQzMjIuOTczNjQwLTEtc3RlZmFuLnINCj4gPiA+ID4gPiA+
ID4gPiBvZQ0KPiA+ID4gPiA+ID4gPiA+IHNlQG1haWxib3gub3JnDQo+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiBEb2VzIFN0ZWZhbidzIGZpeCBuZWVkIHRvIGJlIHNxdWFzaGVkIGlu
dG8gdGhpcyBwYXRjaD8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gU3VyZSwgd2UgY2Fu
IHNxdWFzaCBTdGVmYW7igJlzIGZpeCBpbnRvIHRoaXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gSSBrbm93IHdlICpjYW4qIHNxdWFzaCB0aGVtLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
IEkgd2FudCB0byBrbm93IHdoeSB0aGluZ3Mgd29ya2VkIGZvciB5b3UgYW5kIFN0ZWZhbiB3aGVu
IHRoZXkNCj4gPiA+ID4gPiA+ICp3ZXJlbid0KiBzcXVhc2hlZDoNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiAgIC0gV2h5IGRpZCBJTlR4IHdvcmsgZm9yIHlvdSBldmVuIHdpdGhvdXQgU3RlZmFu
J3MgcGF0Y2guICBEaWQgeW91DQo+ID4gPiA+ID4gPiAgICAgZ2V0IElOVHggaW50ZXJydXB0cyBi
dXQgbm90IHRoZSByaWdodCBvbmVzLCBlLmcuLCBkaWQgdGhlIGRldmljZQ0KPiA+ID4gPiA+ID4g
ICAgIHNpZ25hbCBJTlRBIGJ1dCBpdCB3YXMgcmVjZWl2ZWQgYXMgSU5UQj8NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEkgc2F3IHRoYXQgaW50ZXJydXB0cyB3ZXJlIGJlaW5nIGdlbmVyYXRlZCBieSB0
aGUgZW5kcG9pbnQNCj4gPiA+ID4gPiBkZXZpY2UsIGJ1dCBJIGRpZG7igJl0IHNwZWNpZmljYWxs
eSBjaGVjayBpZiB0aGV5IHdlcmUgY29ycmVjdGx5DQo+ID4gPiA+ID4gdHJhbnNsYXRlZCBpbiB0
aGUgY29udHJvbGxlci4gSSBub3RpY2VkIHRoYXQgdGhlIG5ldyBkcml2ZXINCj4gPiA+ID4gPiB3
YXNuJ3QgZXhwbGljaXRseSBlbmFibGluZyB0aGUgaW50ZXJydXB0cywgc28gbXkgZmlyc3QgYXBw
cm9hY2gNCj4gPiA+ID4gPiB3YXMgdG8gZW5hYmxlIHRoZW0sIHdoaWNoIGhlbHBlZCB0aGUgaW50
ZXJydXB0cyBmbG93IHRocm91Z2guDQo+ID4gPiA+DQo+ID4gPiA+IE9LLCBJJ2xsIGFzc3VtZSB0
aGUgaW50ZXJydXB0cyBoYXBwZW5lZCBidXQgdGhlIGRyaXZlciBtaWdodCBub3QNCj4gPiA+ID4g
aGF2ZSBiZWVuIGFibGUgdG8gaGFuZGxlIHRoZW0gY29ycmVjdGx5LCBlLmcuLCBpdCB3YXMgcHJl
cGFyZWQgZm9yDQo+ID4gPiA+IElOVEEgYnV0IGdvdCBJTlRCIG9yIHNpbWlsYXIuDQo+ID4gPiA+
DQo+ID4gPiA+ID4gPiAgIC0gV2h5IGRpZCBTdGVmYW4ncyBwYXRjaCB3b3JrIGZvciBoaW0gZXZl
biB3aXRob3V0IHlvdXIgcGF0Y2guICBIb3cNCj4gPiA+ID4gPiA+ICAgICBjb3VsZCBTdGVmYW4n
cyBJTlR4IHdvcmsgd2l0aG91dCB0aGUgQ1NSIHdyaXRlcyB0byBlbmFibGUNCj4gPiA+ID4gPiA+
ICAgICBpbnRlcnJ1cHRzPw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSdtIG5vdCBlbnRpcmVseSBz
dXJlIGlmIHRoZXJlIGFyZSBhbnkgb3RoZXIgZGVwZW5kZW5jaWVzIGluIHRoZQ0KPiA+ID4gPiA+
IEZQR0EgYml0c3RyZWFtLiBJJ2xsIGludmVzdGlnYXRlIGZ1cnRoZXIgYW5kIGdldCBiYWNrIHRv
IHlvdS4NCj4gPiA+ID4NCj4gPiA+ID4gU3RlZmFuIGNsYXJpZmllZCBpbiBhIHByaXZhdGUgbWVz
c2FnZSB0aGF0IGhlIGhhZCBhcHBsaWVkIHlvdXINCj4gPiA+ID4gcGF0Y2ggZmlyc3QsIHNvIHRo
aXMgbXlzdGVyeSBpcyBzb2x2ZWQuDQo+ID4gPg0KPiA+ID4gWWVzLiBJIGFwcGxpZWQgUmF2aSdz
IHBhdGNoIGZpcnN0IGFuZCBzdGlsbCBnb3Qgbm8gSU5UeCBkZWxpdmVyZWQgdG8NCj4gPiA+IHRo
ZSBudm1lIGRyaXZlci4gVGhhdCdzIHdoYXQgbWUgdHJpZ2dlcmVkIHRvIGRpZyBkZWVwZXIgaGVy
ZSBhbmQNCj4gPiA+IHJlc3VsdGVkIGluIHRoaXMgdjIgcGF0Y2ggd2l0aCBwY2lfaXJxZF9pbnR4
X3hsYXRlIGFkZGVkLg0KDQoNClhsYXRlIHNob3VsZCBub3QgYmUgYWRkZWQgaW5zdGVhZCBvZiBp
dCBkdCBuZWVkcyB0byBiZSB1cGRhdGVkIGFzIGJlbG93Lg0KDQo+ID4gPg0KPiA+ID4gQlRXOg0K
PiA+ID4gSSByZS10ZXN0ZWQganVzdCBub3cgdy9vIFJhdmkncyBwYXRjaCBhbmQgdGhlIElOVHgg
d29ya2VkLiBTdGlsbCBJDQo+ID4gPiB0aGluayBSYXZpJ3MgcGF0Y2ggaXMgdmFsaWQgYW5kIHNo
b3VsZCBiZSBhcHBsaWVkLi4uDQo+ID4NCj4gPiBIb3cgY29tZSBJTlR4IGlzIHdvcmtpbmcgd2l0
aG91dCB0aGUgcGF0Y2ggZnJvbSBSYXZpIHdoaWNoIGVuYWJsZWQNCj4gPiBJTlR4IHJvdXRpbmcg
aW4gdGhlIGNvbnRyb2xsZXI/IFdhcyBpdCBlbmFibGVkIGJ5IGRlZmF1bHQgaW4gdGhlIGhhcmR3
YXJlPw0KPg0KPiBDYW4geW91IHBsZWFzZSBjcm9zcy1jaGVjayB0aGUgaW50ZXJydXB0LW1hcCBw
cm9wZXJ0eSBpbiB0aGUgZGV2aWNlIHRyZWU/DQo+IEN1cnJlbnRseSwgdGhlIGRyaXZlciBpc27i
gJl0IHRyYW5zbGF0aW5nIChwY2lfaXJxZF9pbnR4X3hsYXRlKSB0aGUgSU5UeCBudW1iZXIuDQo+
DQo+IEhlcmXigJlzIHJlcXVpcmVkIERUIHByb3BlcnR5Og0KPg0KPiBpbnRlcnJ1cHQtbWFwID0g
PDAgMCAwIDEgJnBjaWVfaW50Y18wIDA+LA0KPiAgICAgICAgICAgICAgICAgPDAgMCAwIDIgJnBj
aWVfaW50Y18wIDE+LA0KPiAgICAgICAgICAgICAgICAgPDAgMCAwIDMgJnBjaWVfaW50Y18wIDI+
LA0KPiAgICAgICAgICAgICAgICAgPDAgMCAwIDQgJnBjaWVfaW50Y18wIDM+Ow0KPiA+DQo+ID4g
LSBNYW5pDQo+ID4NCj4gPiAtLQ0KPiA+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprg
rqTgrr7grprgrr/grrXgrq7gr40NCg==

