Return-Path: <linux-pci+bounces-36463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A94B88474
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 09:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CB31C878EF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6B2EAB94;
	Fri, 19 Sep 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oDwfs2lU"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011027.outbound.protection.outlook.com [52.101.125.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA92E8882;
	Fri, 19 Sep 2025 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268408; cv=fail; b=IQZYD+0xFFYoDUuElGUIXxPw00pSXAbJEUhy7+AjELa9H7a8/ueDg5ZIRaYqEvoasYd4HFy/PQh58HKeJcrUa+lPX7r6Qe3IclV6zcPvs2YzPqoWHcVeVsJmEfnaqzVmnrLXIXjxIr98RWhEG2KFeLK2cgBdtgGruDOIvOb/q6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268408; c=relaxed/simple;
	bh=Ry1i6/YIf89ykLpfnsb30YpY+/obOOPAlzbu2Oz7PEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l9mOc/mFY9UwxMy3F/hmLB6Iah5WwjRmlPXypNmccfBHMOagUhLIvYlkV9ViuErOElwkUCIVYHEEAHdRALEUgP/elko6dTMPhcSOiujwVQ5/tbyJ2eSy0DLWBJ8xqX9+YfB522Bi398/Yn3z256sVOStBn34K/s/Pm5ArmZqWt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=oDwfs2lU; arc=fail smtp.client-ip=52.101.125.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQDnB2OTfKJz3mhD1DE3+N2IhWoYMrgDGrsLXd7+3fBk4iCQSXdbPGSjzJPydS4e3dfaoMaKLzf253bT7h9umgp2I5D4rSVEbO96lfl7Yeh7tAufpmjqau5FW9HH2uaUXmJcqgk3QP0XP9Ry0nEqJM9kAj7SDAa2dXyvorTMmy0x3FAPuI/4xfiSzDGd0yQRHN2z2oEjxtKRrQe3ZUqt/RIPp2X0E0zJk0AmUNB3QGEjtmIdZ7C3SLeMwqWGryqov6RQm95UjxHmxM9uIwSYLEl1+epYdOhg76Et5AezSVN5yHoP5OpYbdIevTgg3wVE/G35nwIvxDo0exiHOQP5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry1i6/YIf89ykLpfnsb30YpY+/obOOPAlzbu2Oz7PEQ=;
 b=S9Zv0BWeXkCGC1koT14V4hd5G0xedm1ksyYcX5bnpCzCdBLedD2l0VxazhKnRjd0abDWpGFmpGIl3keFLbUlNJT57jRoMzSy9wArU60bH8N8n51xBHL6vUfQAaDVWFrgE+8C0Rlj1CUekHTJ34Q+CCDFdQvdufEXzW45oQc9+6PNtpcpdGrSmCMdGMvc932Ry7FzQYV9FOBnfO7jdASj+rH3dQEH9MWAXkpF31XV/S5kTQjW4kpdH+ZZvFyMfGNZjPPZHLc873nPaps58jyv5WewsSpxHwMB9/hQLq1elNErmYQXC9reM/4W669n0b3auH6ql8i2MMeoooSpz/oVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry1i6/YIf89ykLpfnsb30YpY+/obOOPAlzbu2Oz7PEQ=;
 b=oDwfs2lU6PAJtXEdzZcbUrSI4Pnnzo8uftrj0wrlmXURp/aQpj/7WOX0vC56XMexrwBNcuRH2txoTwmo5lP7WV39zpjE7MLO95LuAHYNJ/mWk2tMrRmX30AhpJrDao5EJFeQ0i2dcaOcmE8a2uTniDg5Z2HAAm98qHR21gyjTDQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11583.jpnprd01.prod.outlook.com (2603:1096:604:241::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:53:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 07:53:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, geert <geert@linux-m68k.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, magnus.damm <magnus.damm@gmail.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, wsa+renesas
	<wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Topic: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Index: AQHcI+D54xmUZ411IEKyJIJvW9uYWbSYsAwAgAAKvQCAAAN3AIABauEAgAACKLA=
Date: Fri, 19 Sep 2025 07:53:21 +0000
Message-ID:
 <TY3PR01MB11346D854714038C5FE8C37118611A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
 <c2fc5f6b-0e7c-464e-89a6-35dc76177d18@tuxon.dev>
 <CAMuHMdWeHoUe-=7TDetnDQbLQsKGf4pDGpSdz3xEVLs_Rst9qQ@mail.gmail.com>
 <0a20c765-ff72-4c03-af84-dff3f4850fa4@tuxon.dev>
In-Reply-To: <0a20c765-ff72-4c03-af84-dff3f4850fa4@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11583:EE_
x-ms-office365-filtering-correlation-id: 7ab30210-6303-4c68-1972-08ddf7519a57
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFhTQnhmZTZsZTFaV1NBUFRxSjZxTEtsclM3OGkrVC82ZmFVUWRKSkJyRVNp?=
 =?utf-8?B?MlVPSmdoMVZjUjM2ajhSOEhMaUVzdFNrOWVGdldsU0ZzUVNiVFJBZWl3QlB1?=
 =?utf-8?B?SVpnN3BQVERWNE9ncnVMVThxSWczc3hyeTJuSEhicHpxcWtZb2d2WERzQUd0?=
 =?utf-8?B?TVVScFFDQmRzWFNkQVVob3djZDVsRVc1KzlQWmswendSREdNN0sxYTcrZUVt?=
 =?utf-8?B?SGs2Y0dLcVJORWJHeGlJS3JkelR2cGJQQ0VQblhSRGhaS21lNjd3UzBhNzNy?=
 =?utf-8?B?Q3Z4UVFSTUFoSmNiNyt2OTlJLzZwNDlCRDNoVU9pSTI0RzlxdWpoRE1JdElC?=
 =?utf-8?B?WVAydExwSGRwTG1DY1pseUxYYlNYb0hGQnJkQUpEb0xkZFNpeHN6cW4zMjdk?=
 =?utf-8?B?SWJsVDl6UnU4LzdmeU9sTGJFSGtLMFgzanVNVXp1TWtPYU5SUGNQNWY0OWZu?=
 =?utf-8?B?dk9CaUNCQk9ueUVoVWg5Q0lUMzVRWm00ajVJbGoxejNZcytEeUJZQ0c4Y3dq?=
 =?utf-8?B?TGNkZ3lYRytyNXcwUHB2aGtEZjYrWDhSSm5rdjNUZXNQM3Y2bUdmTmsyMEtm?=
 =?utf-8?B?S0RBbXhHazRySjdWRVB0NElYN1FYdVRSTm9GOU1rU1FVWXhDMDMwTkZzbXIx?=
 =?utf-8?B?eUdDZzZpd0IvK2Eya2dCcFlwYzArQkQ1WHRnc0RGRWNySVc1WXZxRElTK05u?=
 =?utf-8?B?WWxsU2NqOGJOaXNOY20xL1BFUWtBTmpvQ2hESGNoS3hlajVHQ2JId0ZOOFB3?=
 =?utf-8?B?KzRiUGVVdDI4bG9OMXVJRjQrdWw0ampiMVpQdkM1M2I3clY5S29WMjhIdm5u?=
 =?utf-8?B?REx5cmxPTXBlZUJPTUR6RWVmQlhNdUlIQjYrN05jTWZ6SUR2Yy94YVN2TXJh?=
 =?utf-8?B?OFhHYXdXUER2Yi9JUmdLZ1pWMUwycStuNGwwUWx5TVNTRldBTzFwbUNSR0k3?=
 =?utf-8?B?ME9CN1BIMEdER0E1ZFFRNi9hTjVrdmQrak9xNERMSTA3Q0Rkem1VT2U5UTVk?=
 =?utf-8?B?dW9PZUVkQXBMVnczRGRRUjhlRnZEaWNoeWZUazhLSGtMeVdrY2lQWkRDQWx4?=
 =?utf-8?B?bm9Ua1pvMzV5NWpjcEs3QzI4Q3piOFF1SVN3azhITGpnTDNtSjhoT0xkUjJw?=
 =?utf-8?B?NWhCbkZEQU5aSUtsckV2alZLdUZGazh0M09pWmRac0NGS281T0hWSlhvSTdw?=
 =?utf-8?B?VHB3WDFoc1RkYU1peU5Kc0xHczUyVWdqb1NTWkRBbTAwU0JLMWZyaWxUNVkz?=
 =?utf-8?B?U001WXFoR25MYVBhU2h2QVBlVk41L1ovRmlpbXJ0enNYQzA2T3MvVmRQSnJD?=
 =?utf-8?B?WTB5WkZkWWY1UzJGcEhaemRENVhBUXQ3QnNwRmQ5Vk9Rem5XWXViczByV2V1?=
 =?utf-8?B?RWk3ZnpGUW1iR2JyRG5MeUhad2UwTU5kMFR6WFlYMzZZRjJxcW1LRUQ2eUtH?=
 =?utf-8?B?Y3VFZ3BmZkJEQ29WVE9kRlJuL0FaNHNZWWt1cks4V3FFWGEvcm45N2JVdlpP?=
 =?utf-8?B?NzF2TUNOMlNaQ2l1UWJvT2ZMM0tvWjNTaUV6UHN5ZEhmaXNjRHNOSnNwUW40?=
 =?utf-8?B?S21XdVRydkJ3bkNjeHphUnkwdVFabHhXTzdITGViRmJudmsvQ0VJYzVacFVO?=
 =?utf-8?B?ZWErTlZRRk1KUlpib21YWXh2RXlGZ1FhZVl1TmJVZXVvcGhCTWJBQWZSUytz?=
 =?utf-8?B?eXRRUm40Umo3dHlUdkx2N0dnNnFGVzVmeW55VkZEbWljeGl5UTRwN0djYWdS?=
 =?utf-8?B?anlnNWN1T2s2U3cxOFRMbGRndkJHb3EzcjV2YjI3cndhRGZBVjdxaTJraEpv?=
 =?utf-8?B?OEJlKzZsOEJ3WjRxaVpwRGhoTEg5Q2tuNHpybEs4R3RDeFpzQXY4N0xpY3J0?=
 =?utf-8?B?c3BmUDZnTEt5UDErRTVhMWJYc2dGYTlKZkV4QVJRVlRPcGQ4UitqQ0NlTGtl?=
 =?utf-8?B?VjhIenQvazNIaGZBQXBIZ3B1SVhiYmtycjBiY2R6R0xFZHBSQnNua3BwVTdq?=
 =?utf-8?B?MGxoRUdRU0dRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVE0cjAwRWpxK1ZXNXFvUnp6MHJWdEVDRXBmTGpEdFZnSDhKYUNhQ3FPcHAx?=
 =?utf-8?B?d043cWNKUGM3a3FXd3BSSkM0QVQwUE9XRk5nWW1zb2p0Z2dRTzFYOFVPQnNV?=
 =?utf-8?B?c3pSd0pxTkJNRnNXMHFENGk4N0o3Sk9jS3Z3VnFQTnhadFd5dVBEaGlSY2hr?=
 =?utf-8?B?UnJ5Z1RkMVZwa3UwUGFvS29kWVl2Ym1TUDRpMXNmL252ZnVDQS9PenFuMzFy?=
 =?utf-8?B?STFScENuVEFzVW9GUDlScFBYT2dLbkVBeGFVUEFMdmcyMHkyN3daVzdra0w0?=
 =?utf-8?B?N1hjanl0dEdzWkZvUDFhL0l2M0ZVOXNpS1RhVWk5L3dzMWxKOWVOSmhac2o5?=
 =?utf-8?B?blYxSDlqaUlaWHd2UzU5MXU1MWhnMVBCTjNSdm9nWlhJV214TkZWd1pYcFcz?=
 =?utf-8?B?eDRzTE8xS2xXRW9mZWQrOGNxYjFMQjBhOFc2cmVzQ29TQTVEd3FKL0haSlVY?=
 =?utf-8?B?eHkvQzFKUERXMGpPT0FjYmZvS2RaV3NvWWtjenVHcEdPVUN4QUY4RVJEcVlW?=
 =?utf-8?B?VFliYmRpQldQaVpvRURQc3h1Z3JrOU5sL0trMExVclJlVGhuMldZZXZ0NEdL?=
 =?utf-8?B?NFg0Q0N3bjZDM09uSWFVWkdjZ3lUR3dhRzdaRktveU1kdzRVUGsvZEtXM2hO?=
 =?utf-8?B?T3BaRE9iZU9WNmR2ZUltV1lYWm4zWEFXcjFyKzRvYWZQa0xaRlBSclRQRUhp?=
 =?utf-8?B?YnhtQ2VEenB3Q1RBY1RXT2pPdHZjV1JFLy9salh0dC8xaU4xSDgzaFNoV3lO?=
 =?utf-8?B?NjBYdTMzeDR4OUdKVHdjUmRqbE9jQ1NGbDBnNXIra1h3czc4QTMwUkM3bmtK?=
 =?utf-8?B?by9MRW1hMDdNRTNTRDJ6NThxUnNldnVINHl5NzU4Tm0xaUdMcEFON1EwVzQ5?=
 =?utf-8?B?T2RRYkR1UzAzR09uK0M1bGo2NzlTS2YwSEpmd1NJUFkzNjZpS0s3V1BjUXcy?=
 =?utf-8?B?aDgreFRUT1M2aGhQUnFRNDhiOEt3YVNNK0Y0MHZ6d0xrOE1BRzBqQ0pZTzJR?=
 =?utf-8?B?Wm4wRURGNy9jZDBoUTE4ZzFod3dHVENGLzBONzduS2FVS1dsN0IxNHBFaUZn?=
 =?utf-8?B?QjcwTS9odHZQSUZCN2x4MEpaVTBmenRlUk1CN0I3aXZtS05XdnJpMXRrbkNs?=
 =?utf-8?B?MDJPMG9CY3lrZlpnZ0hFTDk1R09kYzh2UnJQc1UwZ1FERGsrNUdMcnJ0Mzd3?=
 =?utf-8?B?Y21vcmlOTUE3cTlaZTRIVmRXSnM2RWQvSkJqc1N3Ny90UkZGT01YWFpYZFc2?=
 =?utf-8?B?RmJkcG5qSTlyZ1hDVVR2eGNiMmVBNi90RUc3TlJqUFQwMUtTdWNGM2hHMjF2?=
 =?utf-8?B?eWpacW5uc3VCS2x6dVE0RFQ5VWpUZ3BucVpIRGZxcVBHVzJ1bldtd3dlZDdh?=
 =?utf-8?B?bytia3lpRzZGTUNqYlczclNsNzlQVFF0TlA5UXFkZXpSNjUxVzZqR0tlcXFL?=
 =?utf-8?B?VEY5VHFtUnlyNXhWMldOQVNqbTBHNUQ1dTA2VG1lbVQvN3lyemFNREFyamdk?=
 =?utf-8?B?RjBsM3B2czNGSzRJTXNkVXNwUklFRURyWWlVVUd2dG5IeU9ZSDlNQlIrajQ5?=
 =?utf-8?B?Q3JSbU01WHdBMjJjald2bVowcXE4V3ZpNy9zWG1QOFhHaDFkWDhUbG9yNVJL?=
 =?utf-8?B?cGVBM2tVaEpjQnh3MjNvVGxBc3BSSHhqRlpzc0Zya0VMejl0eEtHa05YTXpX?=
 =?utf-8?B?RG9qTXpwN1N5SnhBcUo5QUFXN1Q0amM2aEZjQjN6R2VrVG83TkFRYXZVNXV2?=
 =?utf-8?B?dGZ4VmJjTVhsazU2cUU3M3NobzcrRXJvQ1MxV2QvU3A2ejh5SHl6RVNFQm5h?=
 =?utf-8?B?eVorc3htdlNFOGJ0VlFoaTd0cW5GYVlQMUZWL3Q1TVVMS2o1dUttK1JFSkRE?=
 =?utf-8?B?N1dLV0hZaEtzRFhWRHNRUXdRSldhQVhZcFNIbDUrNjBTcVIxdWF4ZENxelp6?=
 =?utf-8?B?WDF1dVZoOFpCcEJHNjBST04wSnhVQ0lQOGx2dVJVQzFibHlDSlFmbEgrZEhs?=
 =?utf-8?B?Qm8zaGZkV3hrZ1l0dUVtdmY1dHUxakQwdk5TN29tV0JpRTExbXBpZno4NXc5?=
 =?utf-8?B?akJSeDkwK0p4eDNvOUdLbyt3aVIrVzlmeDhOOENOckpMVTQvZzgrQkYwTGcw?=
 =?utf-8?B?K3pyemFJcXQ1anpFRE1ISlZ6bjF4Z09QUHJwZUlWSEUzdldaNEZDQjBQa29t?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab30210-6303-4c68-1972-08ddf7519a57
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 07:53:21.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTHMerPEJuAB1zOZmejxyCZzNtyR9wQJ/MLZflYuVYlqLgXEiTs5Lwpva9j5yrZ8yNW1I0qrCmwNfC7NxKrp5xj7Pt5ikBvmeEkOH6hRKYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11583

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMTkgU2VwdGVtYmVyIDIwMjUgMDg6
MzkNCj4gVG86IGdlZXJ0IDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gQ2M6IGJoZWxnYWFzQGdv
b2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsg
bWFuaUBrZXJuZWwub3JnOw0KPiByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsg
Y29ub3IrZHRAa2VybmVsLm9yZzsgbWFnbnVzLmRhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47
DQo+IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LXJlbmVzYXMtc29jQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENsYXVkaXUgQmV6bmVhDQo+IDxj
bGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT47IHdzYStyZW5lc2FzIDx3c2ErcmVuZXNh
c0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCA0LzZdIGFy
bTY0OiBkdHM6IHJlbmVzYXM6IHJ6ZzNzLXNtYXJjLXNvbTogVXBkYXRlIGRtYS1yYW5nZXMgZm9y
IFBDSWUNCj4gDQo+IEhpLCBHZWVydCwNCj4gDQo+IE9uIDkvMTgvMjUgMTM6MDAsIEdlZXJ0IFV5
dHRlcmhvZXZlbiB3cm90ZToNCj4gPiBIaSBDbGF1ZGl1LA0KPiA+DQo+ID4gT24gVGh1LCAxOCBT
ZXB0IDIwMjUgYXQgMTE6NDcsIENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5k
ZXY+IHdyb3RlOg0KPiA+PiBPbiA5LzE4LzI1IDEyOjA5LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+ID4+PiBPbiBGcmksIDEyIFNlcHQgMjAyNSBhdCAxNDoyNCwgQ2xhdWRpdSA8Y2xhdWRp
dS5iZXpuZWFAdHV4b24uZGV2PiB3cm90ZToNCj4gPj4+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+Pj4NCj4gPj4+PiBUaGUgZmly
c3QgMTI4TUIgb2YgbWVtb3J5IGlzIHJlc2VydmVkIG9uIHRoaXMgYm9hcmQgZm9yIHNlY3VyZSBh
cmVhLg0KPiA+Pj4+IFNlY3VyZSBhcmVhIGlzIGEgUkFNIHJlZ2lvbiB1c2VkIGJ5IGZpcm13YXJl
LiBUaGUNCj4gPj4+PiByemczcy1zbWFyYy1zb20uZHRzaSBtZW1vcnkgbm9kZSAobWVtb3J5QDQ4
MDAwMDAwKSBleGNsdWRlcyB0aGUgc2VjdXJlIGFyZWEuDQo+ID4+Pj4gVXBkYXRlIHRoZSBQQ0ll
IGRtYS1yYW5nZXMgcHJvcGVydHkgdG8gcmVmbGVjdCB0aGlzLg0KPiA+Pj4+DQo+ID4+Pj4gVGVz
dGVkLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tPg0K
PiA+Pj4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBi
cC5yZW5lc2FzLmNvbT4NCj4gPj4+DQo+ID4+PiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+ID4+
Pg0KPiA+Pj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yemczcy1zbWFyYy1z
b20uZHRzaQ0KPiA+Pj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yemczcy1z
bWFyYy1zb20uZHRzaQ0KPiA+Pj4+IEBAIC0yMTQsNiArMjE0LDE2IEBAICZzZGhpMiB7DQo+ID4+
Pj4gIH07DQo+ID4+Pj4gICNlbmRpZg0KPiA+Pj4+DQo+ID4+Pj4gKyZwY2llIHsNCj4gPj4+PiAr
ICAgICAgIC8qIEZpcnN0IDEyOE1CIGlzIHJlc2VydmVkIGZvciBzZWN1cmUgYXJlYS4gKi8NCj4g
Pj4+DQo+ID4+PiBEbyB5b3UgcmVhbGx5IGhhdmUgdG8gdGFrZSB0aGF0IGludG8gYWNjb3VudCBo
ZXJlPyAgSSBiZWxpZXZlIHRoYXQNCj4gPj4+IDEyOCBNaUIgcmVnaW9uIHdpbGwgbmV2ZXIgYmUg
dXNlZCBhbnl3YXksIGFzIGl0IGlzIGV4Y2x1ZGVkIGZyb20gdGhlDQo+ID4+PiBtZW1vcnkgbWFw
IChzZWUgbWVtb3J5QDQ4MDAwMDAwKS4NCj4gPj4+DQo+ID4+Pj4gKyAgICAgICBkbWEtcmFuZ2Vz
ID0gPDB4NDIwMDAwMDAgMCAweDQ4MDAwMDAwIDAgMHg0ODAwMDAwMCAweDANCj4gPj4+PiArIDB4
MzgwMDAwMDA+Ow0KPiA+Pj4NCj4gPj4+IEhlbmNlIHNob3VsZG4ndCB5b3UgYWRkDQo+ID4+Pg0K
PiA+Pj4gICAgIGRtYS1yYW5nZXMgPSA8MHg0MjAwMDAwMCAwIDB4NDgwMDAwMDAgMCAweDQ4MDAw
MDAwIDB4MA0KPiA+Pj4gMHgzODAwMDAwMD47DQo+ID4NCj4gPiBPb3BzLCBJIHJlYWxseSBtZWFu
dCAoZm9yZ290IHRvIGVkaXQgYWZ0ZXIgY29weWluZyBpdCk6DQo+ID4NCj4gPiAgICAgZG1hLXJh
bmdlcyA9IDwweDQyMDAwMDAwIDAgMHg0MDAwMDAwMCAwIDB4NDAwMDAwMDAgMHgwDQo+ID4gMHg0
MDAwMDAwMD47DQo+ID4NCj4gPj4+DQo+ID4+PiB0byB0aGUgcGNpZSBub2RlIGluIGFyY2gvYXJt
NjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOGcwNDVzMzMuZHRzaQ0KPiA+Pj4gaW5zdGVhZCwgbGlr
ZSBpcyBkb25lIGZvciBhbGwgb3RoZXIgUmVuZXNhcyBTb0NzIHRoYXQgaGF2ZSBQQ0llPw0KPiA+
Pg0KPiA+PiBJIGNob3NlIHRvIGFkZCBpdCBoZXJlIGFzIHRoZSByemczcy1zbWFyYy1zb20uZHRz
aSBpcyB0aGUgb25lIHRoYXQNCj4gPj4gZGVmaW5lcyB0aGUgYXZhaWxhYmxlIG1lbW9yeSBmb3Ig
Ym9hcmQsIGFzIHRoZSBhdmFpbGFibGUgbWVtb3J5IGlzDQo+ID4+IHNvbWV0aGluZyBib2FyZCBk
ZXBlbmRlbnQuDQo+ID4NCj4gPiBCdXQgSU1ITyBpdCBpcyBpbmRlcGVuZGVudCBmcm9tIHRoZSBh
bW91bnQgb2YgbWVtb3J5IG9uIHRoZSBib2FyZC4NCj4gPiBPbiBvdGhlciBTb0NzLCBpdCBoYXMg
YSBjb21tZW50Og0KPiA+DQo+ID4gICAgICAvKiBNYXAgYWxsIHBvc3NpYmxlIEREUiBhcyBpbmJv
dW5kIHJhbmdlcyAqLw0KPiA+DQo+ID4+DQo+ID4+IElmIHlvdSBjb25zaWRlciBpdCBpcyBiZXR0
ZXIgdG8gaGF2ZSBpdCBpbiB0aGUgU29DIGZpbGUsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gPg0K
PiA+IEhlbmNlIHllcyBwbGVhc2UuDQo+ID4NCj4gPiBIb3dldmVyLCBJIG1pc3NlZCB5b3UgYWxy
ZWFkeSBoYXZlOg0KPiA+DQo+ID4gICAgIC8qIE1hcCBhbGwgcG9zc2libGUgRFJBTSByYW5nZXMg
KDQgR0IpLiAqLw0KPiA+ICAgICBkbWEtcmFuZ2VzID0gPDB4NDIwMDAwMDAgMCAweDQwMDAwMDAw
IDAgMHg0MDAwMDAwMCAweDEgMHgwPjsNCj4gPg0KPiA+IGluIHI5YTA4ZzA0NS5kdHNpLCBzbyBs
aWZlJ3MgZ29vZC4NCj4gPg0KPiA+ICsNCj4gPj4+PiArfTsNCj4gPj4+PiArDQo+ID4+Pj4gKyZw
Y2llX3BvcnQwIHsNCj4gPj4+PiArICAgICAgIGNsb2NrcyA9IDwmdmVyc2EzIDU+Ow0KPiA+Pj4+
ICsgICAgICAgY2xvY2stbmFtZXMgPSAicmVmIjsNCj4gPj4+PiArfTsNCj4gPj4+DQo+ID4+PiBU
aGlzIGlzIG5vdCByZWxhdGVkLg0KPiA+Pg0KPiA+PiBBaCwgcmlnaHQhIENvdWxkIHlvdSBwbGVh
c2UgbGV0IG1lIGtub3cgaWYgeW91IHByZWZlciB0byBoYXZlIGFub3RoZXINCj4gPj4gcGF0Y2gg
b3IgdG8gdXBkYXRlIHRoZSBwYXRjaCBkZXNjcmlwdGlvbj8NCj4gPg0KPiA+IEdpdmVuIHRoZSBk
bWEtcmFuZ2VzIGNoYW5nZXMgaXMgSU1ITyBub3QgbmVlZGVkLA0KPiANCj4gSSBrZXB0IGl0IGhl
cmUgYXMgdGhlIGRyaXZlciBjb25maWd1cmVzIHRoZSBQQ0llIHJlZ2lzdGVycyBmb3IgdGhlIGlu
Ym91bmQgd2luZG93cyB3aXRoIHRoZSB2YWx1ZXMNCj4gcGFzc2VkIHRob3VnaCB0aGUgZG1hLXJh
bmdlcy4gVGhpcyBpcyBkb25lIHRocm91Z2gNCj4gcnpnM3NfcGNpZV9zZXRfaW5ib3VuZF93aW5k
b3dzKCkgLT4gcnpnM3NfcGNpZV9zZXRfaW5ib3VuZF93aW5kb3coKS4gVGhlIGNvbnRyb2xsZXIg
d2lsbCBiZSBhd2FyZSB0aGF0DQo+IHRoZSBzZWN1cmUgYXJlYSB6b25lIGlzIHNvbWV0aGluZyB2
YWxpZCB0byB3b3JrIHdpdGguIEluIHRoYXQgY2FzZSwgaWYgbXkgdW5kZXJzdGFuZGluZyBvZiBQ
Q0llIHdpbmRvd3MNCj4gaXMgcmlnaHQsIEkgYWRkZWQgdGhpcyBpbiB0aGUgaWRlYSB0aGF0IGFu
IGVuZHBvaW50IChhIG1hbGljaW91cyBvbmU/KSBjb3VsZCBETUEgaW50by9mcm9tIHNlY3VyZSBh
cmVhDQo+IGlmIHdlIGRvbid0IGV4Y2x1ZGUgaXQgaGVyZT8NCg0KVGhhdCBpcyBhbiBpbnRlcmVz
dGluZyBpc3N1ZS4gVGhlIGVuZHBvaW50IChtYWxpY2lvdXMgb25lKSBzaG91bGQgZ2V0IERBVEEg
YWJvcnQgaW4gdGhhdCBjYXNlLg0KDQpDaGVlcnMsDQpCaWp1DQogIA0K

