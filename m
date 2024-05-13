Return-Path: <linux-pci+bounces-7414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13658C3C4F
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 09:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DBB280E7E
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD83146A91;
	Mon, 13 May 2024 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6AshVJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288D146A64;
	Mon, 13 May 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586461; cv=fail; b=Qlcz9Kh4t8QDZFcaKjdCq/YA1tXkgbb+DXLrx556KNMd/ktkDjYZsp50LroZ30bymcGXkCq2/7oizY2a+/I+P81eDnWfXYL6/t0yULHd2Zo11h10y+fWzxJQdjne8IfRgdR7p5Gx660bR+15ZZMi6xfRQgmr80pzVYUqI6s7amE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586461; c=relaxed/simple;
	bh=dKAZdFH5MH33AhCYF2jQ+kz+OeMz3jv3JyZyEsNwQyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qMWag6Hb3uolqhcdnxA6ePXNNWpdNz8b0/d8kT7F8OrNGC1+EvMa+kIi3iFoZkWrVhiQzsap47VCqShL5hR0z0jAM+Dcc9W6vxK/LaUwLH/MDiweo+jZuSXu6rm7rFWE0Iht6rqbAQ6yCLWZGIriPKPFdPvTaQm5JnbMLTvUvb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6AshVJD; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVHcVOvrByKPubIYVfFSrPICZ0cUrGTOhA/jOWISEhQS5D1ja3UI54LA07trYzyxMNXmPddnVjqneF2wyaiydxjc7uLPzTD3351MnBIUuLJ/I7MFiQI4fUyX3MSylE3nM0fVbgrFhEbc73IJNUdDlDsGJygnxY5t32TxTucLB5iOA2AGS5xw0z11hIhmPW73So2RJSy7vUWR5kaJ9bUnwlYlNAAV7YmkVVsBrgkWN4IRho3jSgJLRsXVm0qEbbtV73weZiOorUQm6iswMY96uSEIw8RpU7ByoA2ZPMuK13JR5o/zftJ/cQxiMQZ4ToQH3PzZqlpK0ZP4m6C7xr6M+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKAZdFH5MH33AhCYF2jQ+kz+OeMz3jv3JyZyEsNwQyQ=;
 b=jo2itbIAwdJK6EMr2Ye7FWgcC+Rhai1lpKqV2lMcn484VRLVZ6XDNr5DtENEfYysWCXTMqRef+7OjuShJyAbuXBBqoSNvVhQIOuhx5jHfKwC/TtgcvxJsTX5WlXSlnoGW1uhTvJfjDjPPSRfLvXGKkyZwhVF6CAJry5KCtF2mrtoeJjhNVpri9Dw1+7nJ/rBcPc57KI6R5HUTc6dZiNBdJ7E2JbPUrmB+i7rd4Y31rOdd/ee0cnS3PgNhzL9Yj/u+MCycSFFn0XgOF4ldYJgJDKSBaYFrxLfsTWWoHcCRshHMRDURsVNY4oKoN0EipP7Z9/eEbRGOblBP/UaMEKaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKAZdFH5MH33AhCYF2jQ+kz+OeMz3jv3JyZyEsNwQyQ=;
 b=n6AshVJDdslCqDm3OVUOY/UksMlGm32EUa7dgyFTg79jXcvjhAmZWw+PjUegJqenoYLMCZy573jqaYiug1d5IO7ZagZ/q9/hRkLBm1sL+YHfgtJZq36UeO8Z8TK6bK9ojtpD0yCNfQe7c89Z0E1lwY59Zp7f3CWjZCumDQcgVcI=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:47:34 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 07:47:34 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen,
 Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi
 from irq
Thread-Topic: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get
 gsi from irq
Thread-Index: AQHakgrPZQMiHHEzE0Gs/TUOGsHh17GQJ2yAgACnAgCABKJfgA==
Date: Mon, 13 May 2024 07:47:34 +0000
Message-ID:
 <BL1PR12MB5849496A5B3148D162787961E7E22@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
 <20240419033616.607889-4-Jiqian.Chen@amd.com>
 <79666084-fc2f-4637-8f0b-3846285601b8@suse.com>
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB58493D17E23751A06FC931DDE7E72@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.7544.049)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SA1PR12MB6773:EE_
x-ms-office365-filtering-correlation-id: 1705d6a4-68c6-433c-87ac-08dc7320f3da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjFldDkvSE5KWjlOVmFOSWVWK2U5eE4vakdhcmYyQ2NYdVRsc0Y5SEJTb0hw?=
 =?utf-8?B?Y2VyQVN1eUp2djI4Y3lhQjlRajgxMnAvZ2o3UW9vUmRSZ2RseVF5S0dJL2Vi?=
 =?utf-8?B?NXlBRGFWTGxNVjhOQkloZ1A3UFBYY3ppTHVad2Z6ckRlTVBHNkNvS3NsOUdG?=
 =?utf-8?B?Y2RUV1FsWVFpNWR0OUIrY0JvTCt3bDVrRnhWaGo0ZTNIK2MxVUFyQ0grVWcx?=
 =?utf-8?B?WTFlR3NFSTdlbHNsazFaeUZrNHVnWFJhR0tTWkQyRm9LbjNpcnZXUXhzUEdO?=
 =?utf-8?B?NkovN2J2K09ZVXpqS1BXNkxFQ1RzNnM2d3p1SjJHQlpIMXhJK0FzTU1HTXk4?=
 =?utf-8?B?ZXFYVk9WVkdoeHFTOGgrMXpSS21tSXoyVHEycEJ1OTIwVk0rc3JleklKRTUr?=
 =?utf-8?B?U2kwMUdoQ1NmNTB6MlhybEJtVjVHSEtSUFVaSE8veE14eTRzK2hPTTV1c1Vl?=
 =?utf-8?B?WmVEaDVtSGxRQnI1SGZsTGZMNzR1eTA0VmJUcjRTbFNJUFpqM1ducXFsVmxY?=
 =?utf-8?B?MnpmZm13TzZxREhSZERJVnRJaExMZ09kanhTUWhodGtacDVDU0tYZTFld1pr?=
 =?utf-8?B?THJmcnk1d3dWaTZvTVQ2RjNEbTAxcEYwa1JHY1l3UHdXWVdWcHArQzBtZ2ZQ?=
 =?utf-8?B?Q0o1S3MxYXdkZGJhMHdTYVFjY1ZXUHoxamJiTUFYcGxLbllhK3ZwSEthR2NZ?=
 =?utf-8?B?M2h0bnorVFBLNUtWMXZpSFd0VU1Bblh0ZWhZRWJWUGllZ0h5RTFuV1V3OWlY?=
 =?utf-8?B?Z3VVQUhBZFhYYVVpbHNhL0VmUlFNNlA4eFlMc01CKzdiOFNJc1NHQktwRURN?=
 =?utf-8?B?eGlZbTRVV3ZDdFRvYmN4WE5Ub0tpUmpXVzZGTDJBWVBtdC9pb1RXQzRrWnN4?=
 =?utf-8?B?bkp5a09GbkhLbGNLeTFLM1JTSDlWMVRlOEFhWXh5akhXbSsyak1zMEpoYzJo?=
 =?utf-8?B?ZWpzdUoyODBqYXlVVElaWWV0M0hyaER4NjR0bkJTWVJNcUxLUnFNdVl6L0Ix?=
 =?utf-8?B?TXdYNHY5QVFGK1dnamI5a21mdkFkeTl2RU5CUXMyc3AxZ3RpWGUzdGNtSmRk?=
 =?utf-8?B?UllQNk14Qzd0ak02OWVzV09ldmNmMVFjTUM0ajlFR2NBMkRGTG5TREVwOXFj?=
 =?utf-8?B?blZCUlVsZ1J5OGIvWGtCOXluMVdycGZSNjYwWXc2c0Y3aWdhRjZGSmd2Y2Zj?=
 =?utf-8?B?REw4M2pjZjhReGZSRTZXc2szUWJrZmZJbTlUeW1Nd294Si9EQUlFUS9nVlR0?=
 =?utf-8?B?ZEdlQ0Zya054YTYwelcySDhjNXBCWWU2RHRJVzhUejVhQi9KMllMSVVzN2w4?=
 =?utf-8?B?a2RETC9QTDN1ZkNjbXk4VGkzemY2UDdhQzY0L2RQdDZBcnB2QmtNU1owaThU?=
 =?utf-8?B?aHBvcTlzKzJCR3ZWalo3Y1J0T2FBV0wvclJmM25SM1hQZWtNekVZZEN2QVJV?=
 =?utf-8?B?RmZyRUhqb1pldGhLNW9QamZjSmExa09TenlwYVRlNjRvazVscVR4WVBwczN0?=
 =?utf-8?B?VytkVFdCMTAxQW1uNjdUdlN2RnhuZ1pkb0pzS1UrYU1ydkdNUDdBMEJjOHNa?=
 =?utf-8?B?VGtJUmZBeHBTVGNheFZJMVpOVW1CSGZqc3Irb0JFNDM3UEVkUEtiZHBITWxG?=
 =?utf-8?B?Zkg1dmU5VUNudVRpSmdITzBFS04zT0MwUHpiR0NtMUpRV3JQRjZFWmNPWDkz?=
 =?utf-8?B?MGNRa0tmSEt0SUlrMEx3Nzdjc3RyTVgzN3Q1T2JHd2tvTWNacFVUQ1RuVmNG?=
 =?utf-8?B?alNRMVAwM0NNZzNpaDRBci9ZTjRXRGE5OEVEaDdnOFVRVnBiMk5uR1FVa0NP?=
 =?utf-8?B?M0VhT2lvSHIwd3I5T1huUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDA4VTFWdzBlOG1uNk5hVXgxMFhBbDVVWFp5VGMreStCYmNTYStKelk2V2Jr?=
 =?utf-8?B?Y3hrRFNLUzhFNE9FVnNsTlUyR2VzYnRJS244M3RaejZuaDdMZlFpempBR1Y3?=
 =?utf-8?B?R2NUU05DT3dvMDZDZDNNVHo5RG80c1FTLzVVR3Fvb1VkUW1XQlBITkJTeGNC?=
 =?utf-8?B?ZlhyOXZtNnY3K1hLNDhWZEhPNzZKSVIxR3JIV1REaWNabzBFa1FDMzJKbzBa?=
 =?utf-8?B?ZHBFWWFXeGJoOHgxc01SSXBYVk12ZEU4NlIxSHIwTkhBRTRFK1BjeHI0REdj?=
 =?utf-8?B?bHlxdFRKSTZOeTNrTkhjUEx3SFNOWFh5NHE0aUVCaW1BMERDTzJYcW00amdj?=
 =?utf-8?B?cWFwRmozK3Arem5ucWhGYW5IazI5U1lZWjNkR0VHZkV5S2hBajRqaEdROGE1?=
 =?utf-8?B?UFF2UDNhYWorWWRGRmROM0p0c1ducXJMUDdaZHZRSmt4ZTl1dkdYZnB3YStB?=
 =?utf-8?B?d3l6UGx1T3dLTGhMN0cyY2NXREUyUHBVUEVDem9kVE1MV0taaGo3VWpkOS9B?=
 =?utf-8?B?SSt1S21kNlEzL1hmTnh2N3Q2b0JuSFc0N3FDa3p2cHV4YWNoWnVQeEliUWJr?=
 =?utf-8?B?ellnT0tqUmY2Rk10R3didmNwOVFwVVF5MEprTldLRGFKNkhGc3BlemNvY1cr?=
 =?utf-8?B?YmFRMFQySG5DSFNidHJicE1KZFdRWGNKOHhUZmY2REN2U0RhTW82RDdCWWFR?=
 =?utf-8?B?OHdFdGtZYTdCQVFjdmVLUWZaV2Z5WjdHWXFrbVMyUXMvRHk4SnZUdHJEa3l3?=
 =?utf-8?B?ZlNYNGgvb0hsM1dFZzM5NFJWZXV2R0V3em94OWRSbUIwaE9naWV6dytJb3Vo?=
 =?utf-8?B?bmNZc0VackZQUmRleWhiYS82TGxpSGpjVzJrOGNxZ2VTUFBRblZmZWpxZDZj?=
 =?utf-8?B?cE5DSDZVbUlwVnF5NXJYNW5zY1VVZHJveVRITGlTeHZ2SXFOR004WElWM0ty?=
 =?utf-8?B?VXdJeThFVndSMk9pdkp1TFJZa2F3Um9SVDR1U2JWZThVQndGY0NvNkgybExo?=
 =?utf-8?B?OHNldktxMjA2Y0RmVUxyVTJTOXZod1dDdjR5TS9FZ0RQSmJaRzZPbS9NS3Za?=
 =?utf-8?B?MjVPU3NvODJHUzBEMkxvcmJxTklxbWhXaGVKTkZkdTRIR1VJdm4wM1dBMzFa?=
 =?utf-8?B?TGd6RXlKR3ArTnZUZ3ViNThZWmh3alUzRXpURHUzSmI4cllXMGRtSFE3OVM4?=
 =?utf-8?B?NjNndkJkbVlzSXdsaUY1bVNRb1N6Z2lydTBmRytXSFhNNVRsTENJMHRzVU5u?=
 =?utf-8?B?a29SNER2cVQyRXdtSkFZZDBtc0wvYWxDcHZyN2IxM0FRRFdjcC83Sk1qUkpW?=
 =?utf-8?B?NGxvNHJBczQ0M1R2L1dFWk14cnRQamlKdUlhbS9mbjZ6dTRoZHpLYnpyQktS?=
 =?utf-8?B?R1FZWlp6bkhGd2JhL3hZWVZKQ29rT0UwbkRwQUs4K0s3RU1SUVYwSUxxQTFX?=
 =?utf-8?B?TC9aS0EzSXoxd3dRQTVYUWFJQnhFUjF3MzBzL3lsbmJxM2pzS3JkTFd1VzEx?=
 =?utf-8?B?S3g3ZWYwNFRyUmFMbFpWdzhWdVhnbGk2ZTRPZ1JSOWZIMk16bzBibkJUZzJk?=
 =?utf-8?B?Z0ZnN0VRdzNhM0hVYVZtT2RVNVRjTGcvbFZ4VHFOWmloQ0EvN0FNeG5OMHpw?=
 =?utf-8?B?TVdNcjR1Z3lNTWpVbU1ubDlUVHUrN0xLTHZOc1dvaGs2L3d3cTFTNFc3dnls?=
 =?utf-8?B?S2F2bkg1cUZ4dFE0RlRXV0ZWay9lNFZkSkxoWFhIWitPM2k4Y0k3MStkKzI3?=
 =?utf-8?B?N0dTd1VXVm5LdWhpeXlzMy9KWjNiQjB6b216bXRKRWppMVR6TS9oVlY5QTUy?=
 =?utf-8?B?d1oyOS9DeVBEZmdtY3pabkZXODVPbm5mZGxocS92Wmk3UTlmMHJZS0tKSXd6?=
 =?utf-8?B?aWJaelhhS1FodmN4Y0c4NTFLV0VTUE1UU25RUkVjOExqanpYcWZxNmEzaVNW?=
 =?utf-8?B?WXhid0FHMzk2SkdVUml1a3VsRHp6K3VQeXhmYkJtRjJtcEJUeUtSWHJhWThK?=
 =?utf-8?B?aVpGMzJqcngwYzJwV29QNk1Ea0V5cEh0bnFRTTNnRldNL0cxcklkT215U3lF?=
 =?utf-8?B?S2tZL09tSkJyVkF1eFNtWU95SGdWd2xpRG1aNFdWSXJWZHUyTlZLK0IwTmVN?=
 =?utf-8?Q?3I8g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03006C5E38003B48906FB0CB42D3B4DF@amdcloud.onmicrosoft.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1705d6a4-68c6-433c-87ac-08dc7320f3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:47:34.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JK3D2SNKURFIpBu8puvMt/EMzLiDfCbXP72V/duqL5a5NbnCHaZABBcWhYtMqDSUjtudlpcoAjTvJQPqWeOmMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6773

SGksDQpPbiAyMDI0LzUvMTAgMTc6MDYsIENoZW4sIEppcWlhbiB3cm90ZToNCj4gSGksDQo+IA0K
PiBPbiAyMDI0LzUvMTAgMTQ6NDYsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+PiBPbiAxOS4wNC4y
NCAwNTozNiwgSmlxaWFuIENoZW4gd3JvdGU6DQo+Pj4gSW4gUFZIIGRvbTAsIGl0IHVzZXMgdGhl
IGxpbnV4IGxvY2FsIGludGVycnVwdCBtZWNoYW5pc20sDQo+Pj4gd2hlbiBpdCBhbGxvY3MgaXJx
IGZvciBhIGdzaSwgaXQgaXMgZHluYW1pYywgYW5kIGZvbGxvdw0KPj4+IHRoZSBwcmluY2lwbGUg
b2YgYXBwbHlpbmcgZmlyc3QsIGRpc3RyaWJ1dGluZyBmaXJzdC4gQW5kDQo+Pj4gdGhlIGlycSBu
dW1iZXIgaXMgYWxsb2NlZCBmcm9tIHNtYWxsIHRvIGxhcmdlLCBidXQgdGhlDQo+Pj4gYXBwbHlp
bmcgZ3NpIG51bWJlciBpcyBub3QsIG1heSBnc2kgMzggY29tZXMgYmVmb3JlIGdzaSAyOCwNCj4+
PiBpdCBjYXVzZXMgdGhlIGlycSBudW1iZXIgaXMgbm90IGVxdWFsIHdpdGggdGhlIGdzaSBudW1i
ZXIuDQo+Pj4gQW5kIHdoZW4gcGFzc3Rocm91Z2ggYSBkZXZpY2UsIFFFTVUgd2lsbCB1c2UgZGV2
aWNlJ3MgZ3NpDQo+Pj4gbnVtYmVyIHRvIGRvIHBpcnEgbWFwcGluZywgYnV0IHRoZSBnc2kgbnVt
YmVyIGlzIGdvdCBmcm9tDQo+Pj4gZmlsZSAvc3lzL2J1cy9wY2kvZGV2aWNlcy88c2JkZj4vaXJx
LCBpcnEhPSBnc2ksIHNvIGl0IHdpbGwNCj4+PiBmYWlsIHdoZW4gbWFwcGluZy4NCj4+PiBBbmQg
aW4gY3VycmVudCBsaW51eCBjb2RlcywgdGhlcmUgaXMgbm8gbWV0aG9kIHRvIHRyYW5zbGF0ZQ0K
Pj4+IGlycSB0byBnc2kgZm9yIHVzZXJzcGFjZS4NCj4+Pg0KPj4+IEZvciBhYm92ZSBwdXJwb3Nl
LCByZWNvcmQgdGhlIHJlbGF0aW9uc2hpcCBvZiBnc2kgYW5kIGlycQ0KPj4+IHdoZW4gUFZIIGRv
bTAgZG8gYWNwaV9yZWdpc3Rlcl9nc2lfaW9hcGljIGZvciBkZXZpY2VzIGFuZA0KPj4+IGFkZHMg
YSBuZXcgc3lzY2FsbCBpbnRvIHByaXZjbWQgdG8gbGV0IHVzZXJzcGFjZSBjYW4gZ2V0DQo+Pj4g
dGhhdCB0cmFuc2xhdGlvbiB3aGVuIHRoZXkgaGF2ZSBhIG5lZWQuDQo+Pj4NCj4+PiBDby1kZXZl
bG9wZWQtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgYXJj
aC94ODYvaW5jbHVkZS9hc20vYXBpYy5owqDCoMKgwqDCoCB8wqAgOCArKysrKysrDQo+Pj4gwqAg
YXJjaC94ODYvaW5jbHVkZS9hc20veGVuL3BjaS5owqDCoCB8wqAgNSArKysrDQo+Pj4gwqAgYXJj
aC94ODYva2VybmVsL2FjcGkvYm9vdC5jwqDCoMKgwqDCoCB8wqAgMiArLQ0KPj4+IMKgIGFyY2gv
eDg2L3BjaS94ZW4uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyMSArKysrKysrKysr
KysrKysrKw0KPj4+IMKgIGRyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgMzkgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+PiDCoCBkcml2ZXJzL3hlbi9wcml2Y21k
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkgKysrKysrKysrKysrKysrKw0KPj4+IMKgIGlu
Y2x1ZGUvdWFwaS94ZW4vcHJpdmNtZC5owqDCoMKgwqDCoMKgIHzCoCA3ICsrKysrKw0KPj4+IMKg
IGluY2x1ZGUveGVuL2V2ZW50cy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA1ICsrKysN
Cj4+PiDCoCA4IGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vYXBpYy5oDQo+Pj4gaW5kZXggOWQxNTliNzcxZGM4Li5kZDQxMzky
NTA4OTUgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oDQo+Pj4g
KysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oDQo+Pj4gQEAgLTE2OSw2ICsxNjksOSBA
QCBleHRlcm4gYm9vbCBhcGljX25lZWRzX3BpdCh2b2lkKTsNCj4+PiDCoCDCoCBleHRlcm4gdm9p
ZCBhcGljX3NlbmRfSVBJX2FsbGJ1dHNlbGYodW5zaWduZWQgaW50IHZlY3Rvcik7DQo+Pj4gwqAg
K2V4dGVybiBpbnQgYWNwaV9yZWdpc3Rlcl9nc2lfaW9hcGljKHN0cnVjdCBkZXZpY2UgKmRldiwg
dTMyIGdzaSwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50
IHRyaWdnZXIsIGludCBwb2xhcml0eSk7DQo+Pj4gKw0KPj4+IMKgICNlbHNlIC8qICFDT05GSUdf
WDg2X0xPQ0FMX0FQSUMgKi8NCj4+PiDCoCBzdGF0aWMgaW5saW5lIHZvaWQgbGFwaWNfc2h1dGRv
d24odm9pZCkgeyB9DQo+Pj4gwqAgI2RlZmluZSBsb2NhbF9hcGljX3RpbWVyX2MyX29rwqDCoMKg
wqDCoMKgwqAgMQ0KPj4+IEBAIC0xODMsNiArMTg2LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBh
cGljX2ludHJfbW9kZV9pbml0KHZvaWQpIHsgfQ0KPj4+IMKgIHN0YXRpYyBpbmxpbmUgdm9pZCBs
YXBpY19hc3NpZ25fc3lzdGVtX3ZlY3RvcnModm9pZCkgeyB9DQo+Pj4gwqAgc3RhdGljIGlubGlu
ZSB2b2lkIGxhcGljX2Fzc2lnbl9sZWdhY3lfdmVjdG9yKHVuc2lnbmVkIGludCBpLCBib29sIHIp
IHsgfQ0KPj4+IMKgIHN0YXRpYyBpbmxpbmUgYm9vbCBhcGljX25lZWRzX3BpdCh2b2lkKSB7IHJl
dHVybiB0cnVlOyB9DQo+Pj4gK3N0YXRpYyBpbmxpbmUgaW50IGFjcGlfcmVnaXN0ZXJfZ3NpX2lv
YXBpYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBnc2ksDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCB0cmlnZ2VyLCBpbnQgcG9sYXJpdHkpDQo+Pj4gK3sN
Cj4+PiArwqDCoMKgIHJldHVybiAoaW50KWdzaTsNCj4+PiArfQ0KPj4+IMKgICNlbmRpZiAvKiAh
Q09ORklHX1g4Nl9MT0NBTF9BUElDICovDQo+Pj4gwqAgwqAgI2lmZGVmIENPTkZJR19YODZfWDJB
UElDDQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9wY2kuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3hlbi9wY2kuaA0KPj4+IGluZGV4IDkwMTViODg4ZWRkNi4uYWE4
ZGVkNjFmYzJkIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9wY2ku
aA0KPj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9wY2kuaA0KPj4+IEBAIC01LDYg
KzUsNyBAQA0KPj4+IMKgICNpZiBkZWZpbmVkKENPTkZJR19QQ0lfWEVOKQ0KPj4+IMKgIGV4dGVy
biBpbnQgX19pbml0IHBjaV94ZW5faW5pdCh2b2lkKTsNCj4+PiDCoCBleHRlcm4gaW50IF9faW5p
dCBwY2lfeGVuX2h2bV9pbml0KHZvaWQpOw0KPj4+ICtleHRlcm4gaW50IF9faW5pdCBwY2lfeGVu
X3B2aF9pbml0KHZvaWQpOw0KPj4+IMKgICNkZWZpbmUgcGNpX3hlbiAxDQo+Pj4gwqAgI2Vsc2UN
Cj4+PiDCoCAjZGVmaW5lIHBjaV94ZW4gMA0KPj4+IEBAIC0xMyw2ICsxNCwxMCBAQCBzdGF0aWMg
aW5saW5lIGludCBwY2lfeGVuX2h2bV9pbml0KHZvaWQpDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKg
wqAgcmV0dXJuIC0xOw0KPj4+IMKgIH0NCj4+PiArc3RhdGljIGlubGluZSBpbnQgcGNpX3hlbl9w
dmhfaW5pdCh2b2lkKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoCByZXR1cm4gLTE7DQo+Pj4gK30NCj4+
PiDCoCAjZW5kaWYNCj4+PiDCoCAjaWZkZWYgQ09ORklHX1hFTl9QVl9ET00wDQo+Pj4gwqAgaW50
IF9faW5pdCBwY2lfeGVuX2luaXRpYWxfZG9tYWluKHZvaWQpOw0KPj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMN
Cj4+PiBpbmRleCA4NWEzY2UyYTM2NjYuLjcyYzczNDU4YzA4MyAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvYWNwaS9ib290LmMNCj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvYWNw
aS9ib290LmMNCj4+PiBAQCAtNzQ5LDcgKzc0OSw3IEBAIHN0YXRpYyBpbnQgYWNwaV9yZWdpc3Rl
cl9nc2lfcGljKHN0cnVjdCBkZXZpY2UgKmRldiwgdTMyIGdzaSwNCj4+PiDCoCB9DQo+Pj4gwqAg
wqAgI2lmZGVmIENPTkZJR19YODZfTE9DQUxfQVBJQw0KPj4+IC1zdGF0aWMgaW50IGFjcGlfcmVn
aXN0ZXJfZ3NpX2lvYXBpYyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiBnc2ksDQo+Pj4gK2ludCBh
Y3BpX3JlZ2lzdGVyX2dzaV9pb2FwaWMoc3RydWN0IGRldmljZSAqZGV2LCB1MzIgZ3NpLA0KPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgdHJpZ2dlciwg
aW50IHBvbGFyaXR5KQ0KPj4+IMKgIHsNCj4+PiDCoMKgwqDCoMKgIGludCBpcnEgPSBnc2k7DQo+
Pj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3BjaS94ZW4uYyBiL2FyY2gveDg2L3BjaS94ZW4uYw0K
Pj4+IGluZGV4IDY1MmNkNTNlNzdmNi4uZjA1NmFiNWMwYTA2IDEwMDY0NA0KPj4+IC0tLSBhL2Fy
Y2gveDg2L3BjaS94ZW4uYw0KPj4+ICsrKyBiL2FyY2gveDg2L3BjaS94ZW4uYw0KPj4+IEBAIC0x
MTQsNiArMTE0LDIxIEBAIHN0YXRpYyBpbnQgYWNwaV9yZWdpc3Rlcl9nc2lfeGVuX2h2bShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHUzMiBnc2ksDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZhbHNlIC8qIG5vIG1hcHBpbmcgb2YgR1NJIHRvIFBJUlEgKi8pOw0KPj4+IMKg
IH0NCj4+PiDCoCArc3RhdGljIGludCBhY3BpX3JlZ2lzdGVyX2dzaV94ZW5fcHZoKHN0cnVjdCBk
ZXZpY2UgKmRldiwgdTMyIGdzaSwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW50IHRyaWdnZXIsIGludCBwb2xhcml0eSkNCj4+PiArew0KPj4+ICvCoMKgwqAg
aW50IGlycTsNCj4+PiArDQo+Pj4gK8KgwqDCoCBpcnEgPSBhY3BpX3JlZ2lzdGVyX2dzaV9pb2Fw
aWMoZGV2LCBnc2ksIHRyaWdnZXIsIHBvbGFyaXR5KTsNCj4+PiArwqDCoMKgIGlmIChpcnEgPCAw
KQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gaXJxOw0KPj4+ICsNCj4+PiArwqDCoMKgIGlm
ICh4ZW5fcHZoX2FkZF9nc2lfaXJxX21hcChnc2ksIGlycSkgPT0gLUVFWElTVCkNCj4+PiArwqDC
oMKgwqDCoMKgwqAgcHJpbnRrKEtFUk5fSU5GTyAiQWxyZWFkeSBtYXAgdGhlIEdTSSA6JXUgYW5k
IElSUTogJWRcbiIsIGdzaSwgaXJxKTsNCj4+PiArDQo+Pj4gK8KgwqDCoCByZXR1cm4gaXJxOw0K
Pj4+ICt9DQo+Pj4gKw0KPj4+IMKgICNpZmRlZiBDT05GSUdfWEVOX1BWX0RPTTANCj4+PiDCoCBz
dGF0aWMgaW50IHhlbl9yZWdpc3Rlcl9nc2kodTMyIGdzaSwgaW50IHRyaWdnZXJpbmcsIGludCBw
b2xhcml0eSkNCj4+PiDCoCB7DQo+Pj4gQEAgLTU1OCw2ICs1NzMsMTIgQEAgaW50IF9faW5pdCBw
Y2lfeGVuX2h2bV9pbml0KHZvaWQpDQo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+PiDCoCB9
DQo+Pj4gwqAgK2ludCBfX2luaXQgcGNpX3hlbl9wdmhfaW5pdCh2b2lkKQ0KPj4+ICt7DQo+Pj4g
K8KgwqDCoCBfX2FjcGlfcmVnaXN0ZXJfZ3NpID0gYWNwaV9yZWdpc3Rlcl9nc2lfeGVuX3B2aDsN
Cj4+DQo+PiBObyBzdXBwb3J0IGZvciB1bnJlZ2lzdGVyaW5nIHRoZSBnc2kgYWdhaW4/DQo+IF9f
YWNwaV91bnJlZ2lzdGVyX2dzaSBpcyBzZXQgaW4gZnVuY3Rpb24gYWNwaV9zZXRfaXJxX21vZGVs
X2lvYXBpYy4NCj4gTWF5YmUgSSBuZWVkIHRvIHVzZSBhIG5ldyBmdW5jdGlvbiB0byBjYWxsIGFj
cGlfdW5yZWdpc3Rlcl9nc2lfaW9hcGljIGFuZCByZW1vdmUgdGhlIG1hcHBpbmcgb2YgaXJxIGFu
ZCBnc2kgZnJvbSB4ZW5faXJxX2xpc3RfaGVhZCA/DQpXaGVuIEkgdHJpZWQgdG8gc3VwcG9ydCB1
bnJlZ2lzdGVyaW5nIHRoZSBnc2kgYW5kIHJlbW92aW5nIHRoZSBtYXBwaW5nIGR1cmluZyBkaXNh
YmxlIGRldmljZSwNCkkgZW5jb3VudGVyZWQgdGhhdCBhZnRlciBydW5uaW5nICJ4bCBwY2ktYXNz
aWduYWJsZS1hZGQgMDM6MDAuMCIsIGNhbGxzdGFjayBwY2lzdHViX2luaXRfZGV2aWNlLT54ZW5f
cGNpYmtfcmVzZXRfZGV2aWNlLT5wY2lfZGlzYWJsZV9kZXZpY2UtPnBjaWJpb3NfZGlzYWJsZV9k
ZXZpY2UtPmFjcGlfcGNpX2lycV9kaXNhYmxlLT5fX2FjcGlfdW5yZWdpc3Rlcl9nc2kNCnJlbW92
ZWQgdGhlIG1hcHBpbmcsIGFmdGVyIHRoYXQgd2hlbiB1c2VyIHNwYWNlIGNhbGxlZCB4ZW5fZ3Np
X2Zyb21faXJxIHRvIGdldCBnc2ksIGl0IGZhaWxlZC4NCg0KVG8gY292ZXIgYWJvdmUgY2FzZSwg
SSB3YW50IHRvIGNoYW5nZSB0aGUgaW1wbGVtZW50YXRpb24gb2YgeGVuX2dzaV9mcm9tX2lycSB0
byBwYXNzIHNiZGYgdG8gZ2V0IHRoZSBnc2kgaW5zdGVhZCBvZiBwYXNzaW5nIGlycSwNCkJlY2F1
c2UgdGhlIHNiZGYgYW5kIGdzaSBvZiBhIGRldmljZSBpcyB1bmlxdWUgYW5kIHdpaWwgbm90IGJl
IGNoYW5nZWQgZXZlbiBkZXZpY2UgaXMgZGlzYWJsZWQgb3IgcmUtZW5hYmxlZC4NCg0KRG8geW91
IHRoaW5rIHRoaXMga2luZCBvZiBjaGFuZ2UgaXMgYWNjZXB0YWJsZT8NCg0KPiANCj4+DQo+Pj4g
K8KgwqDCoCByZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+DQo+PiBKdWVyZ2VuDQo+IA0KDQot
LSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

