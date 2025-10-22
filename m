Return-Path: <linux-pci+bounces-38983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87334BFB514
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34E924FC293
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD53164B1;
	Wed, 22 Oct 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kjmtljRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFDDF59;
	Wed, 22 Oct 2025 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127730; cv=fail; b=FNGlU+3Spj8UMikwhQ9i3BC6UxWyGrVyE7IzGJbKxLOzIbO5mnI3zSBLKA1XJKyj6vLUWmWzSJBja6ccrtLvZ1JX8wkDcmeBuG0OYOXp7hA1WyiK9JoVc1+T3Zlq54DYXEDO2NwpEecp+UgWi1G63b6qurkpRH5zGTSfqvjUi2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127730; c=relaxed/simple;
	bh=NVGLR5DUNrebiQt/5PIwrGhyBnjVnqdKPAJNHw1v8E8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N1lAkx3MAsCA87Z7ArPYjGrADMz0L6iom+PWhXXBx97/B+AciBnl2gFMeKcgcXcAGE7aZVAMvEOX21F6XtexZ1bfpJgB6lvigGPlgCdwD/e/8kdJ/rJBUETTFr7/As6UbR41l9DqAYIBcqF29FpiVV4+fmM2saXXPYAxl+9FE8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kjmtljRC; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaDrqVwnPe5XDvmQDWiRVTcE/o49KJsGMN3SCAdqNlVgMZo6kTeo3C/qMlgBpYvmrVmuyF4bXDIYQAyDvSSaMZbrNPxSYLxpjTCJA+RLeKSjP7uN4z8SGnDW7RHI8VO/JtHOGdySIy3+ReHYgpBt9o1H6xvwOrnWEXK65Pqd8qNJrJMuvYxEcjxhkxyI1blNqqhrEk5rKB1l29ojSpJfhUnbb/IKzbdvtL6bH8ytCOd9Tln2h9Ut0Uf461oGnsP6fNPYfWvIoNQwqKh6BQocA34lJ0qzVGYQ62rEfo8shlAYpqbsGOwUv7oYGlgvhphkTzHsIxBgmxS4ej2QsJ87IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVGLR5DUNrebiQt/5PIwrGhyBnjVnqdKPAJNHw1v8E8=;
 b=EJ0Ye/yu7RO7sl4GNh5kU2mRWtHtLT/ak3XTHwNWm0jMeOiIerCUoy8Mgd1aoEl6NXbTWNqTgYIxO5vtQ0RxPLpZiH2V7qG4l4+UIPDQ/1GOMJDvsmeMuKPscgnu5luACnoe4hKmgBj9doF04b4tXo0XduO5rt/D4Q8XZgi3TYG8ui4Fren8xkknqvCCcc482GY0ZMqzSC2D54fc6LprxM0nkNwl0XK0xdPv+JB2P4J3YfYHNYnJJJvDBrfdA+S5J9a5xxkoevs+I5Fh3KvlXgu06aSvHyfSy2OuTo2xwqdLUK9xxxzQZqVUcRhlGMxlCRXTvr3lmOrVOv6F3blwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVGLR5DUNrebiQt/5PIwrGhyBnjVnqdKPAJNHw1v8E8=;
 b=kjmtljRCfg/WEnsAXb1j5IbZBIvy3dTugjCD+cuSVLRX9wBSmiWUgB29ydgvUfzsDso6eIgNoKVU3P71zUGNs8rp8QgpHJHJNOBToVOGBheqe6K+HewoRDLYewd1I1rm3joUmt5y65w2toZLOZloMLiWzF96BnqM+k4Y2dDkTeo=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 10:08:45 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 10:08:44 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Stefan Roese <stefan.roese@mailbox.org>, "mani@kernel.org"
	<mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
	<ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>
Subject: RE: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Index:
 AQHcKoFZBALFGa/Kqki5vrSD8b1UILTNCbqAgAAGd4CAABdpAIAAHYKAgAAJCICAAJ+fgIAAMSWAgAABJACAAAIPwA==
Date: Wed, 22 Oct 2025 10:08:44 +0000
Message-ID:
 <SN7PR12MB7201CF621AF0A38AA905799D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
In-Reply-To: <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T10:06:39.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ5PPF75EAF8F39:EE_
x-ms-office365-filtering-correlation-id: efbdd1d4-22c6-4f9e-5767-08de1152fbe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b1pxUjR3UkFrNVpmY0F6TVFoYytYMWxmeW1qMlZtQ3c4Z3EwdnJaUmhNaVMw?=
 =?utf-8?B?OVNKUlgvTGNOMFFYTTFGc3dmcnoxcWlveWRFalBHNUFyT2FoRldNMmlxWDlU?=
 =?utf-8?B?OTRjN0p1eENnVjlnWmVFVmNmSERCZEhoRERFWkxQSjY1OXVlWjBmWE1CaW5Q?=
 =?utf-8?B?SC9BczZiOGVLaWhrcTBTaklZZ25XTXR2VlFHWmZQK2pFb3RIWUh3QzNUVHNl?=
 =?utf-8?B?bko5MTdmM3E1alNpektMSzhEUXkvdGRUYWpmL2FZbUdMMFBPTUlKTFdLR1R2?=
 =?utf-8?B?RnE2a0orcXNvUmNWaHkzZHB2U2pNVURhWGZsWjdZOW5QUnFuMG9DUXdQSFVT?=
 =?utf-8?B?QkxHOGZDMUdzUng5N0ZMVG1MWU1lbDNGVVVJMXREUkVYbnZNSWpheElFSmdC?=
 =?utf-8?B?WDNIVjYvRHQydXpYeTV4N0d1TXZFTUlKVUJqRCtKaWRxRitLNkVqQmFweVhB?=
 =?utf-8?B?bmFkdDM0MWQyWUNweWFXQ3JsNFUrcEQ0MGFnQWVaSVR2WWRFN2MzTmhoMWhG?=
 =?utf-8?B?WUgxclVndWVVbHFZWWI3SHdFakR1MEwyZDdxZjZIbFVOdFg2MmxGVDN3S1hm?=
 =?utf-8?B?WHV4OXRMaHl3Ykg5RVpzM1h0akRnMk9Uc1cyaW1nREZaVEpoSEQwOXQ3NlRV?=
 =?utf-8?B?S3FEaTM5enptUEttVzlpakhXTFZ6cW8wWlNqenRDUllkMlZJckxJWmZaK0Mz?=
 =?utf-8?B?MzREOGk5ZXdVTHdtUXlSUGEyMkVYbml2QWd5V2p1WTdPck5Fd1o1R241YTdZ?=
 =?utf-8?B?dHNTWWQ5YWZhVUpkZDNybXo2QTQ4RDRkejdhVFJ6aGhRZGlhb1BmRXVqd0VO?=
 =?utf-8?B?aGw4RW0wN3ZKT0paSERnM1lVM2dDSzRzSmxOZnpqY2RhUnY0dDlnV01wTm5H?=
 =?utf-8?B?Q2w1L0Q0NzNuTUFXc3huQVJMczdLOTV1VS9NVEREVitOMkE0OTR0S0FpKzkv?=
 =?utf-8?B?eFNpbE5qcHJXa0UzM1doY3lOSVdpWnhEYzY2dm03NjdIcW1UaUZCNnNDREdU?=
 =?utf-8?B?aVZCQ1NNczhERjA2cEM4YS90S0JVbkFvZmZ4ZWtaOFNQUmM5UWt0UUNqbjZT?=
 =?utf-8?B?K0o5RjAzb0RvdjVEdmhGK29DTTQrbjlCRit3UFpEVnF2Mko4dW1GZ29iSmh5?=
 =?utf-8?B?RGs5VEY0Z2Z4K29CdG9OWFpOaTQwSndIMjhlaDE5VVF6RzNSMzRKVXlIQ1g3?=
 =?utf-8?B?KzkyTndvcHVuNFFMb1d0MXk2SExjUlpYY254c213cE41U0dqVGZxWEV2MEtv?=
 =?utf-8?B?MTduZTAxamNFdGlPZTZaa0Ztc1liVnN0Z3U4U2hOQlZtVkh3TTZHdGw5TU9w?=
 =?utf-8?B?OVFFb1psSXlLOXhkbGNDSWIvdXU1RkU1TTZ2d21PSVFObDJDVlkxVWJMM2VL?=
 =?utf-8?B?WFA2Z2xrdzVYVEF5LzIrVjAzQmkrZlpSSjFjaDVJVTJLTC9HL2ZlN3pZcGhZ?=
 =?utf-8?B?QngyMXhLQTBMTEVOYXE2dXdBOEtrdm1YODJ4MUNXR0swbldseThsdjVGMXdX?=
 =?utf-8?B?TENSc3hoQVRWNmozMFFsZ1dycGpVNjNnMW1TV1ZwRkpLcXJOQUhaaWRrRXpp?=
 =?utf-8?B?a1lrdDNiZCtxLy95MGRpaFNFVHhwVG53MnUrcVAyY05jSHNPOTR0Zk94WGVK?=
 =?utf-8?B?TTBnWWplSFNDVk4wcGx3ck9kdjV4QUlaSGdHZ1RnUFdQZE1zQW5NcTlGUEh3?=
 =?utf-8?B?QW0vWklVZGM3b1kyRk92UHBraGtyNUdhbFJCTVhXb2MwU0dRc3h4eTZ0bEx6?=
 =?utf-8?B?WFg1LzZKdnY3dEl3QnNockVtVVB6TlM4VVo1eHo0K0h0VFZxa2tqNHA4Z3Zo?=
 =?utf-8?B?MkhGMytLR0dQZlFuaFVUY213d09sd3A1Y2JnT3phNTNFZFFQUGtFbGxRSE1w?=
 =?utf-8?B?alZiQ3lGRUcxM1lUYm1iZTRuWnN2MUkwNGRPcGp3VE9Ddk9TcWk5L0NSblpF?=
 =?utf-8?B?WnhTeXJLem9ocmwyMUhFbkRzN09OeWlBUktjWTN1UnV5aDRnNndNbGRNZXlR?=
 =?utf-8?B?K0o5ajVrSkUrdFREU0UvK1IyQmFGRXhvMzRYWG1Pa2dtdW1Ub21xWGtGT0hw?=
 =?utf-8?Q?0Rgebi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2QrSkJsalVzN1phZnVQNTFYckVaVkl4TEdId3R4Tm5Mdzc1VnRDam1oSzNx?=
 =?utf-8?B?dzRtc0JhU1cxWkRxOUMwa3FsSkxuWmI3b3RnblVvZS9VK01OMG5MVGZXdzhh?=
 =?utf-8?B?UmNtWm96U3ZwY0RicDhDSkVOK2QrczRYQTNCNlpBbnRESE5ReHltR1hvZk4x?=
 =?utf-8?B?c3oweVFLOXQ2cmE5dUMwQ2ovdkxSQ2dERzlGNmlKSjducTRna3dqdEJtRm5I?=
 =?utf-8?B?WHhIQU5PQXA5VTBhWG9FV0dRNzJ4UFFjRnJpblo5MzZqdlJ6RElJYmJiM1lX?=
 =?utf-8?B?MmFzOTZLSzFQd090dWVNcU1wQ0dKcUpGWFRwcEV4VzBKQkEyL1lVdjJiLzZZ?=
 =?utf-8?B?RTlwQ2dRT1g2cE84SUV0cFpXWFVoRTYrTWFNRlUyYU5FdGJiakJETzMveDNT?=
 =?utf-8?B?d2Uxc2ZGK2s2bGI0Rjg2N0VvQk1VaTZYckNSN3kxYVBhTnlXckMveVlCaStu?=
 =?utf-8?B?Z25ERmlUb0w3dmZHNmFKWDN1R2FRakVTOTJTQVd1K3NpZWpPZ3JCVE12blpV?=
 =?utf-8?B?em43eGlHS1l1SXhtR1dzR1lkMDFqNnlUSkJYT2I2TVJwbmMzZ01iTUJrWm9K?=
 =?utf-8?B?ajBIOVhyNkczYjBjY1A1MGlzSWUreDZGOXpkY0dwNmtuODRDbUFlTWNmUW1s?=
 =?utf-8?B?MW4rdjdpNGJIcmxsaHZQL1BuVVVETENFanJDbWxTY3dMZFlYTDM3R1pOUHJN?=
 =?utf-8?B?dGZxdVBBanJWUWtVeC92eFVXc3A5Q1U4bjJDWUtCSUd4Yk0zS1VrOW9FNU0x?=
 =?utf-8?B?UkVWaGgxNWs5RmIzVE5qVERmS0M1cXlDblltZlhmbTV3VlZmemhmOExqOEZF?=
 =?utf-8?B?eGs4ZWtjeDlJeTJmK0t4OXJiQzBPcTVIODhocXMwaFp3UHdmZDZkbExFSk40?=
 =?utf-8?B?YzFXRzNPeU90RnRxR3BSSzAzbS80dDNlVjBQV0tJVFZCV2dxTytLZFZnbGRz?=
 =?utf-8?B?RkY5WmhBaXFWVUt3bU1IL1BpeUdGanl0VVFWcys4R3l6WUhjRU9RTXpINHFM?=
 =?utf-8?B?NlhsV29MSTdvc0FmY0JFRFJYc2hmaDkzYUpMalZUVmlrT0hudFMrelQ5RUxG?=
 =?utf-8?B?N2Y5UWhNY3RqT21wQUwyOEZ2V2JMRlRqcmlDNFpYa2Z6THpjcmRleTlIV01Q?=
 =?utf-8?B?ZWtOUWJ3N05icFo0c1J1ck10QXAzUGt5WW9kN0l6RmtZb3NKc28reVVxUDRp?=
 =?utf-8?B?Nm9zRGdHeHNGbUFBK0UyZUNoQlJmeElDVndTenZubTZ3VDN0K1ViNEFFMk1N?=
 =?utf-8?B?OWx4M1BwVkNWd1crMmJUbk9KN0d1UTgvbkp1Ry92eDh5bklvRHFCRnRGZ2Jz?=
 =?utf-8?B?MStYQ0RrZEZKZDRTRHJvTHRFVHZ3bDdxTkhPVGx2RFRCcCs0R0VnRWlFdVNH?=
 =?utf-8?B?Z3E5Ky9UeWJEZThMQkU2V3M0ZEdDZkVPYmxoMlUxQ2ZDSDVsU1BzUVBZOVhH?=
 =?utf-8?B?L0QyUHpONEo2Tk1qRUphMXZIcCtuQVZQelNKTTRMV1I4R0dUTllGN0R5bVhr?=
 =?utf-8?B?RDIwMnI1WURSY0Z1cEJMZzQ2LzZTZGZ0SUJoZTdXTGRDekY3amw2ai9mVlk2?=
 =?utf-8?B?K0JVTE5WOEVOeW0vTnVBdkxnUGQ2YXBxNmk0a3RJeTdYRTMzeXBwMmxsVGor?=
 =?utf-8?B?ajlxOFZPRUpBSHBCb2V1dHdQeTJBZXVJZmJ6RjRsWmtCUloxc1pqUnhmZW0v?=
 =?utf-8?B?VmV0SUZIbWR6dG1GY0hGcGRjbXdpSWJTZ3JuVDMyMXZQT2daN3ZBOHpzYlBq?=
 =?utf-8?B?bmNTcnRTNTMrVkswYlNkTm05dG1CTGxwZWFTanN5bWtGUVVRRG01Tkcxemov?=
 =?utf-8?B?cmRMMzhZSGt2VFJ5ck9TSGlsYTM3c1gxRUFBdUxIakVTRTVFN2J4TmhISTUw?=
 =?utf-8?B?U1FncUJGR3lJbVpFWWxMRmEvcDJ5a2NjV1RWYmdsNzJFZnRVYkE2elpGYWhs?=
 =?utf-8?B?MDlJM1BrNVJiMXN3aVg3TjJsL1A1cTlvOTQ4ZXFRbkpRMzh2UktwU1lNZXF4?=
 =?utf-8?B?YTUvU2pMR3pvaEdDMmdVdzRwbEI3VzZlWnNyVjRkVHQra0hoQW5FdW1Ydy9j?=
 =?utf-8?B?bVdQNVpDQ2pWNlg2bGMxL3dkczExZlJCL1FNeE8vV1NxeDErS21GTEFDaWx3?=
 =?utf-8?Q?Joc4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efbdd1d4-22c6-4f9e-5767-08de1152fbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 10:08:44.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MWr+UBh2E4DMLarxxi3R8Twq70qAC7HJHT8AJMsc9rj8es0mXgv/L4/3bHtDyimBaovkyBXL7cS3myWjhGbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgU3RlZmFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN0
ZWZhbiBSb2VzZSA8c3RlZmFuLnJvZXNlQG1haWxib3gub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IE9jdG9iZXIgMjIsIDIwMjUgMzoyOSBQTQ0KPiBUbzogbWFuaUBrZXJuZWwub3JnDQo+IENjOiBC
am9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBCYW5kaSwgUmF2aSBLdW1hcg0KPiA8
cmF2aWJAYW1hem9uLmNvbT47IEhhdmFsaWdlLCBUaGlwcGVzd2FteQ0KPiA8dGhpcHBlc3dhbXku
aGF2YWxpZ2VAYW1kLmNvbT47IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9y
ZzsNCj4gcm9iaEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNv
bT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7IFNlYW4gQW5kZXJz
b24gPHNlYW4uYW5kZXJzb25AbGludXguZGV2Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQ
Q0k6IHhpbGlueC14ZG1hOiBFbmFibGUgSU5UeCBpbnRlcnJ1cHRzDQo+DQo+IE9uIDEwLzIyLzI1
IDExOjU1LCBtYW5pQGtlcm5lbC5vcmcgd3JvdGU6DQo+ID4gT24gV2VkLCBPY3QgMjIsIDIwMjUg
YXQgMDg6NTk6MTlBTSArMDIwMCwgU3RlZmFuIFJvZXNlIHdyb3RlOg0KPiA+PiBIaSBCam9ybiwN
Cj4gPj4gSGkgUmF2aSwNCj4gPj4NCj4gPj4gT24gMTAvMjEvMjUgMjM6MjgsIEJqb3JuIEhlbGdh
YXMgd3JvdGU6DQo+ID4+PiBPbiBUdWUsIE9jdCAyMSwgMjAyNSBhdCAwODo1NTo0MVBNICswMDAw
LCBCYW5kaSwgUmF2aSBLdW1hciB3cm90ZToNCj4gPj4+Pj4gT24gVHVlLCBPY3QgMjEsIDIwMjUg
YXQgMDU6NDY6MTdQTSArMDAwMCwgQmFuZGksIFJhdmkgS3VtYXIgd3JvdGU6DQo+ID4+Pj4+Pj4g
T24gT2N0IDIxLCAyMDI1LCBhdCAxMDoyM+KAr0FNLCBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtl
cm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+Pj4+Pj4+IE9uIFNhdCwgU2VwIDIwLCAyMDI1IGF0IDEw
OjUyOjMyUE0gKzAwMDAsIFJhdmkgS3VtYXIgQmFuZGkNCj4gd3JvdGU6DQo+ID4+Pj4+Pj4+IFRo
ZSBwY2llLXhpbGlueC1kbWEtcGwgZHJpdmVyIGRvZXMgbm90IGVuYWJsZSBJTlR4IGludGVycnVw
dHMNCj4gPj4+Pj4+Pj4gYWZ0ZXIgaW5pdGlhbGl6aW5nIHRoZSBwb3J0LCBwcmV2ZW50aW5nIElO
VHggaW50ZXJydXB0cyBmcm9tDQo+ID4+Pj4+Pj4+IFBDSWUgZW5kcG9pbnRzIGZyb20gZmxvd2lu
ZyB0aHJvdWdoIHRoZSBYaWxpbnggWERNQSByb290IHBvcnQNCj4gPj4+Pj4+Pj4gYnJpZGdlLiBU
aGlzIGlzc3VlIGFmZmVjdHMga2VybmVsIDYuNi4wIGFuZCBsYXRlciB2ZXJzaW9ucy4NCj4gPj4+
Pj4+Pj4NCj4gPj4+Pj4+Pj4gVGhpcyBwYXRjaCBhbGxvd3MgSU5UeCBpbnRlcnJ1cHRzIGdlbmVy
YXRlZCBieSBQQ0llIGVuZHBvaW50cw0KPiA+Pj4+Pj4+PiB0byBmbG93IHRocm91Z2ggdGhlIHJv
b3QgcG9ydC4gVGVzdGVkIHRoZSBmaXggb24gYSBib2FyZCB3aXRoDQo+ID4+Pj4+Pj4+IHR3byBl
bmRwb2ludHMgZ2VuZXJhdGluZyBJTlR4IGludGVycnVwdHMuIEludGVycnVwdHMgYXJlDQo+ID4+
Pj4+Pj4+IHByb3Blcmx5IGRldGVjdGVkIGFuZCBzZXJ2aWNlZC4gVGhlIC9wcm9jL2ludGVycnVw
dHMgb3V0cHV0DQo+ID4+Pj4+Pj4+IHNob3dzOg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBbLi4u
XQ0KPiA+Pj4+Pj4+PiAzMjogICAgICAgIDMyMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQg
IDE2IExldmVsICAgICA0MDAwMDAwMDAuYXhpLXBjaWUsDQo+IGF6ZHJ2DQo+ID4+Pj4+Pj4+IDUy
OiAgICAgICAgNDcwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAgIDUw
MDAwMDAwMC5heGktcGNpZSwNCj4gYXpkcnYNCj4gPj4+Pj4+Pj4gWy4uLl0NCj4gPj4NCj4gPj4g
Rmlyc3QgYSBjb21tZW50IG9uIHRoaXMgSVJRIGxvZ2dpbmc6DQo+ID4+DQo+ID4+IFRoZXNlIGxp
bmVzIGRvIE5PVCByZWZlciB0byB0aGUgSU5UeCBJUlEocykgYnV0IHRoZSBjb250cm9sbGVyDQo+
ID4+IGludGVybmFsICJldmVudHMiIChlcnJvcnMgZXRjKS4gUGxlYXNlIHNlZSB0aGlzIGxvZyBm
b3IgSU5UeCBvbiBteQ0KPiA+PiBWZXJzYWwgcGxhdGZvcm0gd2l0aCBwY2lfaXJxZF9pbnR4X3hs
YXRlIGFkZGVkOg0KPiA+Pg0KPiA+PiAgIDI0OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2Rt
YTpSQy1FdmVudCAgIDAgTGV2ZWwgICAgIExJTktfRE9XTg0KPiA+PiAgIDI1OiAgICAgICAgICAw
ICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgIDMgTGV2ZWwgICAgIEhPVF9SRVNFVA0KPiA+
PiAgIDI2OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgIDggTGV2ZWwg
ICAgIENGR19USU1FT1VUDQo+ID4+ICAgMjc6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1h
OlJDLUV2ZW50ICAgOSBMZXZlbCAgICAgQ09SUkVDVEFCTEUNCj4gPj4gICAyODogICAgICAgICAg
MCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDEwIExldmVsICAgICBOT05GQVRBTA0KPiA+
PiAgIDI5OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTEgTGV2ZWwg
ICAgIEZBVEFMDQo+ID4+ICAgMzA6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2
ZW50ICAyMCBMZXZlbCAgICAgU0xWX1VOU1VQUA0KPiA+PiAgIDMxOiAgICAgICAgICAwICAgICAg
ICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjEgTGV2ZWwgICAgIFNMVl9VTkVYUA0KPiA+PiAgIDMy
OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjIgTGV2ZWwgICAgIFNM
Vl9DT01QTA0KPiA+PiAgIDMzOiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVu
dCAgMjMgTGV2ZWwgICAgIFNMVl9FUlJQDQo+ID4+ICAgMzQ6ICAgICAgICAgIDAgICAgICAgICAg
MCAgcGxfZG1hOlJDLUV2ZW50ICAyNCBMZXZlbCAgICAgU0xWX0NNUEFCVA0KPiA+PiAgIDM1OiAg
ICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjUgTGV2ZWwgICAgIFNMVl9J
TExCVVINCj4gPj4gICAzNjogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQg
IDI2IExldmVsICAgICBNU1RfREVDRVJSDQo+ID4+ICAgMzc6ICAgICAgICAgIDAgICAgICAgICAg
MCAgcGxfZG1hOlJDLUV2ZW50ICAyNyBMZXZlbCAgICAgTVNUX1NMVkVSUg0KPiA+PiAgIDM4OiAg
ICAgICAgIDk0ICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAgIDg0MDAw
MDAwLmF4aS1wY2llDQo+ID4+ICAgMzk6ICAgICAgICAgOTQgICAgICAgICAgMCAgcGxfZG1hOklO
VHggICAwIExldmVsICAgICBudm1lMHEwLCBudm1lMHExDQo+ID4+DQo+ID4+IFRoZSBsYXN0IGxp
bmUgc2hvd3MgdGhlIElOVHggSVJRcyBoZXJlICgncGxfZG1hOklOVHgnIHZzICdwbF9kbWE6UkMt
DQo+ID4+IEV2ZW50JykuDQo+ID4+DQo+ID4+IE1vcmUgYmVsb3cuLi4NCj4gPj4NCj4gPj4+Pj4+
Pj4NCj4gPj4+Pj4+Pj4gQ2hhbmdlcyBzaW5jZSB2MTo6DQo+ID4+Pj4+Pj4+IC0gRml4ZWQgY29t
bWl0IG1lc3NhZ2UgcGVyIHJldmlld2VyJ3MgY29tbWVudHMNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4gRml4ZXM6IDhkNzg2MTQ5ZDc4YyAoIlBDSTogeGlsaW54LXhkbWE6IEFkZCBYaWxpbnggWERN
QSBSb290DQo+ID4+Pj4+Pj4+IFBvcnQgZHJpdmVyIikNCj4gPj4+Pj4+Pj4gQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUmF2aSBLdW1hciBCYW5k
aSA8cmF2aWJAYW1hem9uLmNvbT4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IEhpIFJhdmksIG9idmlv
dXNseSB5b3UgdGVzdGVkIHRoaXMsIGJ1dCBJIGRvbid0IGtub3cgaG93IHRvDQo+ID4+Pj4+Pj4g
cmVjb25jaWxlIHRoaXMgd2l0aCBTdGVmYW4ncyBJTlR4IGZpeCBhdA0KPiA+Pj4+Pj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEwMjExNTQzMjIuOTczNjQwLTEtDQo+IHN0ZWZhbi5y
b2VzZUBtDQo+ID4+Pj4+Pj4gYWlsYm94Lm9yZw0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gRG9lcyBT
dGVmYW4ncyBmaXggbmVlZCB0byBiZSBzcXVhc2hlZCBpbnRvIHRoaXMgcGF0Y2g/DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gU3VyZSwgd2UgY2FuIHNxdWFzaCBTdGVmYW7igJlzIGZpeCBpbnRvIHRoaXMu
DQo+ID4+Pj4+DQo+ID4+Pj4+IEkga25vdyB3ZSAqY2FuKiBzcXVhc2ggdGhlbS4NCj4gPj4+Pj4N
Cj4gPj4+Pj4gSSB3YW50IHRvIGtub3cgd2h5IHRoaW5ncyB3b3JrZWQgZm9yIHlvdSBhbmQgU3Rl
ZmFuIHdoZW4gdGhleQ0KPiA+Pj4+PiAqd2VyZW4ndCogc3F1YXNoZWQ6DQo+ID4+Pj4+DQo+ID4+
Pj4+ICAgIC0gV2h5IGRpZCBJTlR4IHdvcmsgZm9yIHlvdSBldmVuIHdpdGhvdXQgU3RlZmFuJ3Mg
cGF0Y2guICBEaWQgeW91DQo+ID4+Pj4+ICAgICAgZ2V0IElOVHggaW50ZXJydXB0cyBidXQgbm90
IHRoZSByaWdodCBvbmVzLCBlLmcuLCBkaWQgdGhlIGRldmljZQ0KPiA+Pj4+PiAgICAgIHNpZ25h
bCBJTlRBIGJ1dCBpdCB3YXMgcmVjZWl2ZWQgYXMgSU5UQj8NCj4gPj4+Pg0KPiA+Pj4+IEkgc2F3
IHRoYXQgaW50ZXJydXB0cyB3ZXJlIGJlaW5nIGdlbmVyYXRlZCBieSB0aGUgZW5kcG9pbnQgZGV2
aWNlLA0KPiA+Pj4+IGJ1dCBJIGRpZG7igJl0IHNwZWNpZmljYWxseSBjaGVjayBpZiB0aGV5IHdl
cmUgY29ycmVjdGx5IHRyYW5zbGF0ZWQNCj4gPj4+PiBpbiB0aGUgY29udHJvbGxlci4gSSBub3Rp
Y2VkIHRoYXQgdGhlIG5ldyBkcml2ZXIgd2Fzbid0IGV4cGxpY2l0bHkNCj4gPj4+PiBlbmFibGlu
ZyB0aGUgaW50ZXJydXB0cywgc28gbXkgZmlyc3QgYXBwcm9hY2ggd2FzIHRvIGVuYWJsZSB0aGVt
LA0KPiA+Pj4+IHdoaWNoIGhlbHBlZCB0aGUgaW50ZXJydXB0cyBmbG93IHRocm91Z2guDQo+ID4+
Pg0KPiA+Pj4gT0ssIEknbGwgYXNzdW1lIHRoZSBpbnRlcnJ1cHRzIGhhcHBlbmVkIGJ1dCB0aGUg
ZHJpdmVyIG1pZ2h0IG5vdA0KPiA+Pj4gaGF2ZSBiZWVuIGFibGUgdG8gaGFuZGxlIHRoZW0gY29y
cmVjdGx5LCBlLmcuLCBpdCB3YXMgcHJlcGFyZWQgZm9yDQo+ID4+PiBJTlRBIGJ1dCBnb3QgSU5U
QiBvciBzaW1pbGFyLg0KPiA+Pj4NCj4gPj4+Pj4gICAgLSBXaHkgZGlkIFN0ZWZhbidzIHBhdGNo
IHdvcmsgZm9yIGhpbSBldmVuIHdpdGhvdXQgeW91ciBwYXRjaC4gIEhvdw0KPiA+Pj4+PiAgICAg
IGNvdWxkIFN0ZWZhbidzIElOVHggd29yayB3aXRob3V0IHRoZSBDU1Igd3JpdGVzIHRvIGVuYWJs
ZQ0KPiA+Pj4+PiAgICAgIGludGVycnVwdHM/DQo+ID4+Pj4NCj4gPj4+PiBJJ20gbm90IGVudGly
ZWx5IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBvdGhlciBkZXBlbmRlbmNpZXMgaW4gdGhlDQo+ID4+
Pj4gRlBHQSBiaXRzdHJlYW0uIEknbGwgaW52ZXN0aWdhdGUgZnVydGhlciBhbmQgZ2V0IGJhY2sg
dG8geW91Lg0KPiA+Pj4NCj4gPj4+IFN0ZWZhbiBjbGFyaWZpZWQgaW4gYSBwcml2YXRlIG1lc3Nh
Z2UgdGhhdCBoZSBoYWQgYXBwbGllZCB5b3VyIHBhdGNoDQo+ID4+PiBmaXJzdCwgc28gdGhpcyBt
eXN0ZXJ5IGlzIHNvbHZlZC4NCj4gPj4NCj4gPj4gWWVzLiBJIGFwcGxpZWQgUmF2aSdzIHBhdGNo
IGZpcnN0IGFuZCBzdGlsbCBnb3Qgbm8gSU5UeCBkZWxpdmVyZWQgdG8NCj4gPj4gdGhlIG52bWUg
ZHJpdmVyLiBUaGF0J3Mgd2hhdCBtZSB0cmlnZ2VyZWQgdG8gZGlnIGRlZXBlciBoZXJlIGFuZA0K
PiA+PiByZXN1bHRlZCBpbiB0aGlzIHYyIHBhdGNoIHdpdGggcGNpX2lycWRfaW50eF94bGF0ZSBh
ZGRlZC4NCj4gPj4NCj4gPj4gQlRXOg0KPiA+PiBJIHJlLXRlc3RlZCBqdXN0IG5vdyB3L28gUmF2
aSdzIHBhdGNoIGFuZCB0aGUgSU5UeCB3b3JrZWQuIFN0aWxsIEkNCj4gPj4gdGhpbmsgUmF2aSdz
IHBhdGNoIGlzIHZhbGlkIGFuZCBzaG91bGQgYmUgYXBwbGllZC4uLg0KPiA+DQo+ID4gSG93IGNv
bWUgSU5UeCBpcyB3b3JraW5nIHdpdGhvdXQgdGhlIHBhdGNoIGZyb20gUmF2aSB3aGljaCBlbmFi
bGVkDQo+ID4gSU5UeCByb3V0aW5nIGluIHRoZSBjb250cm9sbGVyPyBXYXMgaXQgZW5hYmxlZCBi
eSBkZWZhdWx0IGluIHRoZSBoYXJkd2FyZT8NCj4NCj4gWWVzLCB0aGlzIGlzIG15IGJlc3QgZ3Vl
c3MgcmlnaHQgbm93LiBJIGNvdWxkIGRvdWJsZS1jaGVjayBoZXJlLCBidXQgSU1ITyBpdA0KPiBt
YWtlcyBzZW5zZSB0byBlbmFibGUgaXQgIm1hbnVhbGx5IiBhcyBkb25lIHdpdGggUmF2aSdzIHBh
dGNoIHRvIG5vdCByZWx5IG9uDQo+IHRoaXMgZGVmYXVsdCBzZXR1cCBhdCBhbGwuDQpIYXJkd2Fy
ZSBkb2Vzbid0IGVuYWJsZSB0aGlzIGJpdHMgYnkgZGVmYXVsdCwgSU5UeCBkaWRuJ3Qgd29yayBz
aW5jZSB0aGVyZSBpcyBhIG1pc3MgbWF0Y2ggaW4gdGhlIERUIHByb3BlcnR5IHdoaWNoIGRvZXNu
J3QgcmVxdWlyZSBwY2lfaXJxZF9pbnR4X3hsYXRlLg0KDQppbnRlcnJ1cHQtbWFwID0gPDAgMCAw
IDEgJnBjaWVfaW50Y18wIDA+LA0KPDAgMCAwIDIgJnBjaWVfaW50Y18wIDE+LA0KPDAgMCAwIDMg
JnBjaWVfaW50Y18wIDI+LA0KPDAgMCAwIDQgJnBjaWVfaW50Y18wIDM+Ow0KDQo+DQo+IFRoYW5r
cywNCj4gU3RlZmFuDQoNCg==

