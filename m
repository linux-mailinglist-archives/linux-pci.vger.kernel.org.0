Return-Path: <linux-pci+bounces-7371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F48C2F00
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 04:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C20283223
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 02:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31752225A2;
	Sat, 11 May 2024 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a6d26LlN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C41B966;
	Sat, 11 May 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393775; cv=fail; b=l/Btj6QxPksBiaKEUrPoeDCCQrjFcNARqZQ6/w2zb+/jApa+yXBXwcsfrxiZJKxqw7GhRj/ExoROAS522ykCl8rsqsHB/ugbH8XveKfxo1ifiX7jR0UsEGkAp0U2f3zENB94zVRYYRXOi03XaiOO/Jv27TehenbwK4vKh/AMw3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393775; c=relaxed/simple;
	bh=I0428Ijj/UEPn6TKWG5i49LAwCZg7A4VDslimAPxVGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N12XidCLOQUzdxEmaZcHSC4fw5CUBi7gz5pxTAgUNPBDos8zqWUiLFOeZVW/q2z6CMGnEzW4f+h1xyOoTekLqy9RHJg1LFi0XzVZC9IDEg0S7BYwKSgLBRvbS1pA8Ot01+ML24Lf08rEtDoHJOTaISPWy2QMQczi7dWb0uqpB6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a6d26LlN; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6zng0vRYgHAQc4tkRtV9jCJ8FzCWb6t9J3ErKhz7yYiLfMHMVXFIk3aHvAamBAR6Ra+DaWXhTimhOUlUR5zyUEVSXLVMAjRCdgc1o/PIshQO+Z5hNkmOX8AOR+wEA9ox4BAajtm+ZQCtuBNiLIppWrDep1Rvb7bt/qQth9fJWoSxG4l2RHBEC0ow7FC5Faf7MheMJkYU29ygRTUtE18suoQRX6KpskSjmIRHaj5JSkl74vQb+lnh2tJky9UangCrHEjL87U/0GQcuy+nwNzuMP6eIyI6xAY6eoK3hTBb22O99dh+Jrjs4ccKb7w8hEA5V/hVSCcGlbbU1l4OhzePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0428Ijj/UEPn6TKWG5i49LAwCZg7A4VDslimAPxVGk=;
 b=LP5XWpBD4T0mCBG0xABBDSerDnCQx/3R+6c9T4bZr7dWoF4Htvq2MfmXI4yjXNwCCZKhp0WUTItMnVur5QfHO5fQB7fqS0TC3b7svQaOjOxZmRYqdfZuYKrRLRkY+wniLT3mr7CBlliJXSvtk43sEl2i7sUiCPlHI3bnGBzXGzYFJgIypE//2hx0ptlHxRO0rxzGqE1kmv1ffjGyR7Q/FUWqMcDVmNnViB/wXMRI7Pmqzpdg76mtjdynQbXyXSCK4U4y6iZojw8W0F2GOnKio6YsRIX9by1EtD8qTraP7a6xoqDy1osoXvkTz0tvjIigd0pLVh+EYULK3YS2hCAzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0428Ijj/UEPn6TKWG5i49LAwCZg7A4VDslimAPxVGk=;
 b=a6d26LlNhjmUOKtEQbzSqEg2AGx5hQfS5SGzJSWDdcHYXSVb8js2uTc0IypN09HQLbM4auI9HGedDPtw2zH0rXhJQJjC1p6whDJ/WALr683Y0Kh3ps4S9h89tOFXhoOSkhrVsk2tDVpF2mB2OLsD72p8ksR5SY+qr8NR6JKzcEg=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Sat, 11 May
 2024 02:16:07 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7544.047; Sat, 11 May 2024
 02:16:07 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
Thread-Topic: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get
 gsi from irq
Thread-Index:
 AQHakgrPZQMiHHEzE0Gs/TUOGsHh17GQJ2yAgACnAgD//41hgIAAiXAA//9+YoCAAIdwAP//iviAAC/BN4A=
Date: Sat, 11 May 2024 02:16:07 +0000
Message-ID:
 <BL1PR12MB5849B13B1BC7EAFA6207C57DE7E02@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <c30ebad2-1ad3-4b58-afaf-e6dc32c091fc@suse.com>
 <BL1PR12MB58491D2210091DF9607A354AE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <d0b5e7d5-3503-49be-9fa3-4b79c62059ca@suse.com>
 <BL1PR12MB5849F1DE8B4A3538C79CE5D3E7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
 <0aac68ac-cf40-4c3d-ac02-95b9a37aaa11@suse.com>
In-Reply-To: <0aac68ac-cf40-4c3d-ac02-95b9a37aaa11@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5754.namprd12.prod.outlook.com
 (15.20.7587.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SN7PR12MB7449:EE_
x-ms-office365-filtering-correlation-id: 5351b627-e5bb-41a0-c6d0-08dc7160512d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2YzK2xJT3Ewd09lOTdadFRid1J4RlRoRXphRGk0UVlHbW1mbGNCaXJ2cXE0?=
 =?utf-8?B?VFNIdGtKZjdpTVBuTE8rSXBvRm5LWU43ZTZUZ1NIVGp5VDZSOU56SVhEVmFi?=
 =?utf-8?B?MndKWVI5YmMwd2xwZUNDY1B0S2ZDWlpqT0NSWU1OV1l5LzlETk9aV3ZYNW9u?=
 =?utf-8?B?ZHRheW14Yy9OdGFoT1hGVjJUVzExdFlJUHVMMzBjNDlaWFZTMjJsekNQejMv?=
 =?utf-8?B?MmhzRUdUVVdqT1JCSHJvZ0UwQ3hyOUNRMDFwTXlGODRTNjIrVWIyNEhWcFBG?=
 =?utf-8?B?TXZsTkJSTUhsd1dGMUVFUWJZMll6TktJd3FHTU00L25hL2ZyNnB4cGt3ekpo?=
 =?utf-8?B?SDk5Qmg1OVlQRUM0MFZ0QzVLZWo1N3JPbGhKU2tPdmZKd1hRYlhva3RBS1JH?=
 =?utf-8?B?WlVVaWswN2JIRFd0dkxHbm1ScXFxMDV0c01MMDh6UlY4SHQzZTJ2anUwcmtF?=
 =?utf-8?B?eWpPdGxlVDYrZk5zS0tzYUkxU0V5S2V5WjlBVEhYRVVxQ1hQNEpMWmZaOElZ?=
 =?utf-8?B?bTBzYXVjL1lNaVBGeHlyNVdyYStkc0hBY2FRdE05VkhQM2ZIV01Fa1pOblMv?=
 =?utf-8?B?ZjNMTzJGVkI0YVFXeHNUVWVEdnZMZlYxSVVPekVod0c3UnZWakhMWFdIMVFp?=
 =?utf-8?B?QXlDUHUxNzFDMEJLN1c5ZURVNTRCckxoRzBGQ0dkaHhMdXJFVVpDYVJFZlE2?=
 =?utf-8?B?dXZVQVdkMXdpYktPdGQ5MnBjcTFxckJLWW1aT0JFZ3JDYjVZY0JlSTF5cFp2?=
 =?utf-8?B?djZVMHB5NmlwYWpnejdiVkVTUjBrMlRWcTB3VTZLNkxMSGJyVjBmTDFacSs1?=
 =?utf-8?B?NnhaOHRjUDlUZW5tZlN1S01EN2RKc2JZQnNDOXRvOUQ0ZSt3TWZvYVRINEo0?=
 =?utf-8?B?dzhweG9FaUttanUzQ1Z5MzNkbDhYTFpOemZyb0ZwakpEYmtheDNVMHg1c3pE?=
 =?utf-8?B?dlRQd2Rlc2piTEpzazJJMEJrNnlTcjVvZGJpMDB3V2lGbXUxdzE4OHVMczhD?=
 =?utf-8?B?aGFTK1RvSWdYc0hCK3hFMFVOVDFjbktRaWY5RW1LSWtiaXBoOWZlaVhZazdM?=
 =?utf-8?B?alBlbkZjblc5Z1p1QUQ5VWI4bWxRbm9kdFU3L3pEQ1M1NVVROFVKbkRXbHpn?=
 =?utf-8?B?d3N3eEh1ejBiR3UwdUZHc1h6WDJROFlWUzBFbDRVQ0dRMzMxM0FMR2loNWln?=
 =?utf-8?B?UTVRdVJWWDZDMjJMdWhHcXR3VkJZYmozYUgySitFN2pCOUtlRDVqc05GMDh4?=
 =?utf-8?B?ZVBvbDFkR1RBenVZN0ZQd3pGRlpVZEdRbVRuQTFIak5TUlZWbVJBNngzb3Zl?=
 =?utf-8?B?Qnk1U0txcXZGd0UzRDFicmg5SHR2aWM3V2hoWk5PZG84Tnd1TXQ1L3BiMjVE?=
 =?utf-8?B?c0hoWHMrek9LZXNEb1lPNXh3eUgvdU1zcGpVMnM2cXNlM3ptTGJKWHI5SnFp?=
 =?utf-8?B?NHpSbDNrVG82Vmd4NENvN29SQzd0a0ZGZHduZm02YTMyQ1I3NSsvNWRZWnhX?=
 =?utf-8?B?VEg2TEhubG9TL2FoQlFoeXpRdnpKd01xTkt1Sm5YcHZkQTc3dStsTUpnS0lh?=
 =?utf-8?B?SG95MUlBc1Q5UzNFdTFIczRaL2VDUFJzU09MdCtiYkVDaWdXVEJLTmdxTzlr?=
 =?utf-8?B?ZzhWbzZPM1BHNGVqUVFJRjF3NFJ4dTZGNVdJS3paaURCUFRYamdQL1YxUUdE?=
 =?utf-8?B?Z2REbDU0N0RBZW5GN1NvNXprV2ZoUmlqa0NPZnZGRkZRR1lmR25BTzdmaEt6?=
 =?utf-8?B?WGtmV1RtY01HMmJzUWs5b0h2NkZYSzJPN0J4TTdOZ0hKVFY4VlBkck1yV1pD?=
 =?utf-8?B?cjZ4UWM5cTNOS2ZzeERZdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmxXekNxVEJYK3BjY0hsYUgreXhUbGVtTmdLQ28rbjc1MGE1eWo3eFlSZnBT?=
 =?utf-8?B?TFUyM0ZVaTF4Skx3OXpCS3NHQkZnZS9PdUt4a282ZEZnMEh6a3g3bVpmcDZs?=
 =?utf-8?B?aW9Ndm1WQkFuT05Jelh1MklvdlVwRmM4OTBqN1NZU2dYOWV6RmpxU2FwTjdM?=
 =?utf-8?B?cUxXaVJKVDdLZHRNNlg2Nk5KdWR3TzBEaHJCaXdLS3BQNHUzOVY3amFFcW9i?=
 =?utf-8?B?WHd4NkprQTRsUXJDdWlFR09wWjdtZ0FJcmVNYzlwb0FPeFlCeEw0RHlCb2NP?=
 =?utf-8?B?VFNPZmsxRGFIL3pjRU9ERmQ5VDk3NFBPYUYrdTNrUFI4V3pBamY1QUZEMHF1?=
 =?utf-8?B?S3hNbGk3dDFlZDZxQ04rWDVCbWZjQ1RYOUZJTyt0RGVyM2Izb1B4ejRyekxC?=
 =?utf-8?B?MzNkRnJmU21HcnYyZDhmdGZTdE1HRGdDVHBEMC9sWU85Tml5eXBaNnJnb1hX?=
 =?utf-8?B?TWplVkx6MDY2RURmMDNzRjlTT1lmNmdsTzBTUE8vYXpUdXZWQldybHhRQVFP?=
 =?utf-8?B?NWlnTTRhUy9sMzZNOEtUb2oyeFZnNU9iUnJsSHdjb3NNaG1SRkRSTURPa3Ba?=
 =?utf-8?B?cjVRTmlrYzZUVGZqQitSZGhvQnRib0FPdVhKY1VSbHNCUXBSUEFaWGNvOGpQ?=
 =?utf-8?B?VE1hWXJxQ0FVL2h4S21wYnoxcWlaQStpN0ViVldWMnM0SThKSFZpMnZkUlFj?=
 =?utf-8?B?VHhjRzdkdHVnZGw1ejErTjhYK3AyMlEyVEpuWmpDLzYrTkRIYjRpTmxZTmpx?=
 =?utf-8?B?Z0I4YUx6bmNKU3RBU0JaV0pycVlJeHhoeHVwMSsrcHhFeU9abjZkdFE4ZmhE?=
 =?utf-8?B?NXZTKzh4QTk1WXlZdzZRSTVVLzZaaVZuYjVoNGJmalBXdU9zTjFTZUVsdEpS?=
 =?utf-8?B?QWl5a3BqcVVQVkVUVUp2alhWdnphb0JuNDYzVUgwajQvd1phU29Gd1dHcU4x?=
 =?utf-8?B?UWp1akdkRDNud1N1TEFaejhORlBrSzFEQk53UmpqeDNlc2loVTNjTFMzOVp6?=
 =?utf-8?B?UVVjSzFZWGxDTTBuYUZTQkdocHlERkhPcyt6NWhaMTNUZUtxM1Flb3NXRnVI?=
 =?utf-8?B?NWpyNk41dkdPRktrOE1UVjZieWVDbXJsd3YzWG8rRys4L2Npd0phL0dVYk5v?=
 =?utf-8?B?RlF0SjloNEpnVmhncm5XQWN5bVJFRWgwV3BBbWxOQnE5NTFRUWtvOE4vK3Jn?=
 =?utf-8?B?aGRuQ3BDMnNGTS80dStqcHJzSndlREd2Nyt1bERDRXdRVGp6VFAxV0FDQ05U?=
 =?utf-8?B?T2Rmcm9xQzJESEhSd3M1anB1SjR6TjVGSmlWaXNwTGlTTGcxNGVUbmFTZ09P?=
 =?utf-8?B?TUNKdmFCUDVROHM1R1IraDNnekpMcnA4NDRmQm5rODcxQzVaTFNqUzliYlFu?=
 =?utf-8?B?V2ZqMUw3OUJqQ21FK3lCZG9hYmFYWWxPNmM3VDEyaDJoSHo4bGVPa21RZHdP?=
 =?utf-8?B?TEJMS2k1djNNMDhEaXM0Nkwvd08wTDRLbDJZSTBlRGNjNmlMQUl1QW5PaWlM?=
 =?utf-8?B?RCtkK05IdFJHRUdLb1FmSFlRbTAvYmpSV3RJeE14cWJLcVhWQzdhWGVXWXph?=
 =?utf-8?B?aWdyTUpEUmwxU2tZRVVtUEZUUThPK3JaUktVTEtUV04vcGpsTGhpUXRSWVV0?=
 =?utf-8?B?KzRPSjBKVldmQjMycVVRQThPYXZqcHRGSktiR01DcXorcVV2TEZ4VFQ3dTRp?=
 =?utf-8?B?eGw5N2pJRWhQVkdvVDhDUUNlOHp3Mkhtb0FwZmZZWmIrdEM1WlgxMkNSMW15?=
 =?utf-8?B?ZFFKcUhURmNFeW9FNXRMKzV2Rzcvd0pzMUEyQWtzcEtod1ZwTnVHNEI3cUhN?=
 =?utf-8?B?aXJXZ1R6MHJwakVCb05xZEl3c0U4VzhzUS93eEJqV24yTlBXVW1Gc25RUW5H?=
 =?utf-8?B?SGh1L2lrNEFRWmdKcUd4cGlzVGc0T3JRcXJOL3UxM3BNanIwUTRNRVE1eVdl?=
 =?utf-8?B?YjR6RHE2bDNUUzYrZVRpSmVDcWVlZWhLaXBZdEZJa2FpMm52am1WK2VrWm41?=
 =?utf-8?B?MnVSbzZaL2tKZXBORm0zdDl3MmQ4RWZMOGJtTDhkcjNjazBSTkt6VmJZKzFa?=
 =?utf-8?B?OElDcEFSTDVKQU1PbFlsaFluU3lBSTRrOFkwZmc3MEJGZFYyQi9sbXlvdG1i?=
 =?utf-8?Q?wu4Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC6BE08C21267F45A1048F77C5C991F6@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5351b627-e5bb-41a0-c6d0-08dc7160512d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 02:16:07.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnuotWuZ5u7AN8z5Bw/GmMZJsz1Qd2F05kxZpiwVBk9RbxH3Yh8bzAmUoLfC/KMm2DLW+DztYZDsJdk5bMCyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

T24gMjAyNC81LzEwIDE5OjI3LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPiBPbiAxMC4wNS4yNCAx
MjozMiwgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4gT24gMjAyNC81LzEwIDE4OjIxLCBKw7xyZ2Vu
IEdyb8OfIHdyb3RlOg0KPj4+IE9uIDEwLjA1LjI0IDEyOjEzLCBDaGVuLCBKaXFpYW4gd3JvdGU6
DQo+Pj4+IE9uIDIwMjQvNS8xMCAxNzo1MywgSsO8cmdlbiBHcm/DnyB3cm90ZToNCj4+Pj4+IE9u
IDEwLjA1LjI0IDExOjA2LCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+Pj4+Pj4gSGksDQo+Pj4+Pj4N
Cj4+Pj4+PiBPbiAyMDI0LzUvMTAgMTQ6NDYsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+Pj4+Pj4+
IE9uIDE5LjA0LjI0IDA1OjM2LCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+Pj4+Pj4+ICsNCj4+Pj4+
Pj4+ICvCoMKgwqAgaW5mby0+dHlwZSA9IElSUVRfUElSUTsNCj4+Pj4+PiBJIGFtIGNvbnNpZGVy
aW5nIHdoZXRoZXIgSSBuZWVkIHRvIHVzZSBhIG5ldyB0eXBlKGxpa2UgSVJRVF9HU0kpIGhlcmUg
dG8gZGlzdGluZ3Vpc2ggd2l0aCBJUlFUX1BJUlEsIGJlY2F1c2UgZnVuY3Rpb24gcmVzdG9yZV9w
aXJxcyB3aWxsIHByb2Nlc3MgYWxsIElSUVRfUElSUS4NCj4+Pj4+DQo+Pj4+PiByZXN0b3JlX3Bp
cnFzKCkgYWxyZWFkeSBjb25zaWRlcnMgZ3NpID09IDAgdG8gYmUgbm90IEdTSSByZWxhdGVkLiBJ
c24ndCB0aGlzDQo+Pj4+PiBlbm91Z2g/DQo+Pj4+IE5vLCBpdCBpcyBub3QgZW5vdWdoLg0KPj4+
PiB4ZW5fcHZoX2FkZF9nc2lfaXJxX21hcCBhZGRzIHRoZSBtYXBwaW5nIG9mIGdzaSBhbmQgaXJx
LCBidXQgdGhlIHZhbHVlIG9mIGdzaSBpcyBub3QgMCwNCj4+Pj4gb25jZSByZXN0b3JlX3BpcnFz
IGlzIGNhbGxlZCwgaXQgd2lsbCBkbyBQSFlTREVWT1BfbWFwX3BpcnEgZm9yIHRoYXQgZ3NpLCBi
dXQgaW4gcHZoIGRvbTAsIHdlIHNob3VsZG4ndCBkbyBQSFlTREVWT1BfbWFwX3BpcnEuDQo+Pj4N
Cj4+PiBPa2F5LCB0aGVuIGFkZCBhIG5ldyBmbGFnIHRvIGluZm8tPnUucGlycS5mbGFncyBmb3Ig
dGhhdCBwdXJwb3NlPw0KPj4gSSBmZWVsIGxpa2UgYWRkaW5nICJuZXcgZmxhZyB0byBpbmZvLT51
LnBpcnEuZmxhZ3MiIGlzIG5vdCBhcyBnb29kIGFzIGFkZGluZyAiIG5ldyB0eXBlIHRvIGluZm8t
PnR5cGUiLg0KPj4gQmVjYXVzZSBpbiByZXN0b3JlX3BpcnFzLCBpdCBjb25zaWRlcnMgIiBpbmZv
LT50eXBlICE9IElSUVRfUElSUSIsIGlmIGFkZGluZyAiIG5ldyBmbGFnIHRvIGluZm8tPnUucGly
cS5mbGFncyIsIHdlIG5lZWQgdG8gYWRkIGEgbmV3IGNvbmRpdGlvbiBpbiByZXN0b3JlX3BpcnFz
Lg0KPj4gQW5kIGFjdHVhbGx5IHRoaXMgbWFwcGluZyhnc2kgYW5kIGlycSBvZiBwdmgpIGRvZXNu
J3QgaGF2ZSBwaXJxLCBzbyBpdCBpcyBub3Qgc3VpdGFibGUgdG8gYWRkIHRvIHUucGlycS5mbGFn
cy4NCj4gDQo+IERvZXMgdGhpcyBtZWFuIHRoZXJlIGlzIG5vIG90aGVyIElSUVRfUElSUSByZWxh
dGVkIGFjdGl2aXR5IHJlbGV2YW50IGZvciB0aG9zZSBHU0lzL0lSUXM/DQpZZXMsIEkgdGhpbmsg
c28uDQo+IEluIHRoYXQgY2FzZSBJIGFncmVlIHRvIGFkZCBJUlFUX0dTSS4NClRoYW5rIHlvdSEN
Cj4gDQo+IA0KPiBKdWVyZ2VuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

