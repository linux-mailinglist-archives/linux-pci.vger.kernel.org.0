Return-Path: <linux-pci+bounces-42061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 461A5C85C79
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 16:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10E614E1605
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470317C211;
	Tue, 25 Nov 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="Uk52x5S1"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E337328614;
	Tue, 25 Nov 2025 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084620; cv=fail; b=SLsO0oNkBhPA/NAaBJvgJ4sLB/z6Jx1zfFeZ+8LmZ+L1eDjnL9gLMRAYiKgqM5yhqlk2g5GA7e+DYrxB0QRB/A52BKFqZa7+GkzqUrwgf8ffaBujf+9Xxnx+Kau4dCdt3KIDBHN3GYYbl+DlXldI/DWK7mnjnBrJtr/CvpeNN5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084620; c=relaxed/simple;
	bh=Z8VoSk76OTk+KY5aD4BEOQMLN+A2/Y8X90d0oAJGqF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMn91gcYj9VGGxjG44ulNOcHklEf+76szaTlrjxHtfafOMbXnzeAcM6Lt7cCdFF9XHPVtPKy53KgNaUZ8rRQ233FnDFTsP3QctFyzxpacCG2DKw78ib4iM6eIlrz5XoeeYGb2t71C2zAvc94FPhY9pLEr+sDNYH5J15gILlv9eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=Uk52x5S1; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1764084618; x=1795620618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z8VoSk76OTk+KY5aD4BEOQMLN+A2/Y8X90d0oAJGqF8=;
  b=Uk52x5S1Lak9yK2Oc1yh69t+jXSkq52jldzgigZOZi2i5NosYCYqWz4S
   M+LeQACTpDsgNvglCbyalSiYnOlCgnfYNy/G+uaAYfNIRxfKwmUqeUO1Q
   miV9A/eALY/ws8E1qj0HYYmb4VML39GLHoaKxjSp+A+C4g0q0jHuOcX3x
   mshQA1TWJcvKNqa1yfUdZl4ONyxWc6bI9C+giU+iGMoOnRx+X/ShlP+WI
   6iLc+BWNdiLJdVk6fwOLYN/kJ6MQwiIagl3YCT3kW/2RpSiri5ljOR8Ax
   OetKscN5xyQfdGmBo08kWIvD638zr4jSRAa0Sutjqje/6L/kfEU3k3o1n
   A==;
X-CSE-ConnectionGUID: xr7tNGO1QJWiFpkD+NrVbg==
X-CSE-MsgGUID: YXAJUyIZTL28xfjXU50JXA==
Received: from mail-westusazon11020135.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.135])
  by ob1.hc6817-7.iphmx.com with ESMTP; 25 Nov 2025 07:30:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uo+/vGHQ6ltlwtgN2dQpw7aYLzwxT2tP6PC/GKItlozDbGf/yKcOGZgZ3FNzyGJzIIgEKEHVGG2LK5f9plUTIPsTHAPxe241HYkYvqmKhOZIrIXyjb5ie6c3NAHxZ52Idfh+V/CnN7CMkKpTpMuapFMph20bmHzefLUG9JeSsL/Lh8dLjF+CgsNZiFHpnZEiZhnuLXO6FFWFQQhvh7JNiONkQ17zI+jKpmXqXRLdms1+bQD7I8q/LNlOQtb60TJ9jqx+wyX/gwY4WK24+uXkr2gVtTGHtevbKUeRXY7NyW2AnsCyyFOJwUCZnbL2aAnfxtD+rErkudZ8qQRumIHyoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8VoSk76OTk+KY5aD4BEOQMLN+A2/Y8X90d0oAJGqF8=;
 b=yqeYszqbR7Gw7yvyklJ5OOrsloCZq9PboO9rMSqDraS+SSSal38KtOcMyhLFtFXoc7cr4LKSRPF+BUzSeOQ47sBsCTQMhJohx00nGz6PDDa+O4o/KON5CxDj2SaUAKmSX0S/YQPX38vsBPUyszqyrT2SGZXM8x4W8zJo41mrMMNyiBd4uL6C+46+DkLjSF7eBT+fkiJeYvQBo8k2Jq8bq6dPn+Lfn+enMFzPB/n/bJSMBZ+B+uvfYM0C+8PlMRmR4jnSdHm/ZoLyhbdaptQElGGY0P6cXWRPD9GM2Mbes/QqeYxUMMu0Q4FFeel/BmnzdH+SOObB/+ziX2DF49DWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from BY5PR16MB3396.namprd16.prod.outlook.com (2603:10b6:a03:1a8::16)
 by SA1PR16MB6906.namprd16.prod.outlook.com (2603:10b6:806:4b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 15:30:15 +0000
Received: from BY5PR16MB3396.namprd16.prod.outlook.com
 ([fe80::ce1d:a612:979e:7256]) by BY5PR16MB3396.namprd16.prod.outlook.com
 ([fe80::ce1d:a612:979e:7256%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 15:30:15 +0000
From: Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>, Jeffrey Lien <Jeff.Lien@sandisk.com>,
	Avinash M N <Avinash.M.N@sandisk.com>
Subject: RE: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
Thread-Topic: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
Thread-Index: AQHcXZ2AAo6K85GYzEyyY+ONpfkjlrUC24CAgACpxEA=
Date: Tue, 25 Nov 2025 15:30:15 +0000
Message-ID:
 <BY5PR16MB339612035106C16822855A5A92D1A@BY5PR16MB3396.namprd16.prod.outlook.com>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
 <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
In-Reply-To: <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR16MB3396:EE_|SA1PR16MB6906:EE_
x-ms-office365-filtering-correlation-id: 2086c65c-2794-4d70-80f7-08de2c37883d
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TERjaEdTNGNmakFOR2RPdzlnN3Z4N2xMa2EyQ2VmNTVkNXVTTzN6WERnRU54?=
 =?utf-8?B?VTBTYTFPMnkrZUxPZHNGcndDTlQ5RE1teXpWY2NsV3VZQjV4SkU2aGZUNDRK?=
 =?utf-8?B?VHZndk53VVRNdFR3RVdtZ2pVVjhXZ09oc0JXSTNxWWY4SGQ4Uzh2WFFxRjdJ?=
 =?utf-8?B?U3dRMjlwdU1hWnpmU3hKelh0R3Y1aXRrdFhMWlMrVFFqVFZqQzhvRDJudFFa?=
 =?utf-8?B?ZlVqWGZocS95aldDLy94NHNBa3ZLOVZjTG9hR2RhN3BGa0gxbHdMUHNNMXho?=
 =?utf-8?B?azVkYmt6UldMVTduM0pBa2MyVjRiNnBCRDF4SjBjS25ZdEpmR3FLYm04bVFr?=
 =?utf-8?B?bFpKR3l5TUxGUzRjYUZxSHFzUWw5WHRCenJZZzBKYnRoOW16U2d2UmcxU1pZ?=
 =?utf-8?B?ZW5ETE16alFGa2xkSm1rOHpFaWl5TDZWZlk4eXJVWHNSZE9xRHlGbVN6bDNI?=
 =?utf-8?B?cndVODd4cTlSM2JEdk1zaCt6ZGZRTnZ0WnNrUWVqMmx5dS9BUVZQN0FmaTZs?=
 =?utf-8?B?dk5saHVGQVpvOEtFNm5ObWlZZDJTcm9BUlE2M1FPRUp1VVJPMmJQTnFTUkha?=
 =?utf-8?B?WG5yRUtMM2lObTg5eWIvanJFNDI4TytYUHlaOXdFanNjVkt5TDQraGc2Vmlq?=
 =?utf-8?B?M0JGbjFhTktUQnRuMEFNcEUzdzBqMmhPZkQxaW5xdkJhdVJWcjVEZC9OdUpu?=
 =?utf-8?B?Nk9oSjlmYjRxOUZNWkdONHpjOG9VZm9OdVJmY1FMcEdYbUdFMkhObkFHcXlp?=
 =?utf-8?B?NDRLVmxLT1VRbUMxc09mN0NJdVZwZDhkU3gzZk1vMnVqZ0tKNEljanNTMWht?=
 =?utf-8?B?a1kzWGVKanNCZzFjR1FSQ2pyNXl5Q0o5UEt6UFZVSW42QVg5WjE2T0ltMVNS?=
 =?utf-8?B?S2RUS21hVittVFU5VTN6YjNCM3ZJQ0Rqck9CNjNtblZJc0xYU2c0aVNQU3h6?=
 =?utf-8?B?bExMeThnaEJhRVcwbUorMmRHZG9hbk9SOU5qUlZkdE1ZYlVwS3NkaU54MWt2?=
 =?utf-8?B?eDdvaDdFRzJrRHVkQk1yMUxQT3dFYXkzcEhIbUdreG1TNlZQa1kvRDEyYlhV?=
 =?utf-8?B?WEhrUUxtNFRRdUZOeEpVWmxReWRtd1lSdW4weC91clRiWC9qOUQ1anhEVXJI?=
 =?utf-8?B?RGttQ3VVM2NjQ0J4Snpndm1PSzgvcFE1SlYrVkFuZDBreW1sd0Mrak40dXR0?=
 =?utf-8?B?NHB4SEhrV3JDcVY5ajIwYXdXZk8rOUF4UDM5RUQ1aDdjRGdTYlFOWHdpTG9G?=
 =?utf-8?B?cFh3Y1kzNU5aeFhHNEhQNGFGRlIxSGJrcFRzaFh0TzZJSlpPOGxGYzFpRzRW?=
 =?utf-8?B?U3EzbGhVYUpHVmY2UkgzVUFJdnc0ZnRIaE1tQTVQMDYwbFFTS20xbWdEWXEy?=
 =?utf-8?B?VTYvbFp4Z2FrUnB4SGJScFR6N3p3RVBzMmJ0SVF4TEJ2MDFGcWxnVHQ0akll?=
 =?utf-8?B?SS9rOXp5SFN0Nklmb0xpcFlmNitjbFVrd2w1bk1yaVN6Yk5GUlpSVmh0YUlh?=
 =?utf-8?B?R05wSHlKVVE3Z3RoRFRacG9Jczc5OFVJVHY2VlpaZkR3VWltaDB0a2lOZW1U?=
 =?utf-8?B?czMvRk9nL1I1ZGkwUStpczFkSWVyamlqNUVqdUd6aWZCZFAyaHlJNzNnd3d0?=
 =?utf-8?B?MjMyZVFXcTdoQlp2NER4dzZuUTc3bFl4VmRXYWdjU1liZjVnbTE4RlQ0Y0xW?=
 =?utf-8?B?OFE4aVk3cmxndzZQVnNWeDdYb3V0UkdtdGVaYzZKZUNZZjVSWDZMUkpYT2NB?=
 =?utf-8?B?MUVBbVpQc0J2eFcwU25WL3BoOWZTMzBkejE0NGpxMjJ4dDYrU0NuSVdDRG1I?=
 =?utf-8?B?M0RpamFXdC9maXlsdHhZSWxpRW9BdDdPSzI5b1pacDVpSC9NTHN0dVFtc3pw?=
 =?utf-8?B?TVllVUErbkozdmVVRytEZ2NrSVVNbm5QQVZVNVV2ZzZjbXU4S3UrTFlTMDA0?=
 =?utf-8?B?MTlINUVRZHpaSm1JblFJalQxOVg2NU0rcldCRU91MHNZWnJXL0lCaXkxWWFF?=
 =?utf-8?B?c3VSZGhjZ3dKSHVBeTkwcUhiaE9URld2ODJwNm1qS1FZYm94NnkwNEFCdnVU?=
 =?utf-8?Q?V/utGw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR16MB3396.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alNSUWJ0bVFhUXQxWWlDZXlveHdLOUsyenFZcHo2TUVwMUswMmNBeTVaazJa?=
 =?utf-8?B?ZHJNWlB6ay9iMUxHMVovT1lUL1dRdHY2ZVk2ZTdzZDNuOFRqb3pDUXZBd3F2?=
 =?utf-8?B?aXZ6MWU3QVo3L2ZNMksxYVRlZ0orZFNmRHY2UTJvcUJrUUt5VGU4MVFVdVFM?=
 =?utf-8?B?b0ZITUJVOFF4MDBkUDNqY1ZlNG1VdENaT0hUdVVUUzY5M3RTSk1ldHhpRmRl?=
 =?utf-8?B?MFpXYm9OZUFPc0RNb1R3MS9rZ215V1c0YWJxTmp1RVRpTTBWaSt0OGZpbExh?=
 =?utf-8?B?YmlKb1RXZ0p2dW12eTd2ZklvSDF0ODgwMnlFN0NtdHZNM3gxVG9WbEozK2JU?=
 =?utf-8?B?U1lYblRZaVFQQTh4Y005OUdyczJXekV1V0tVQ1cvb3hsOStyWFRwN3lTWHBI?=
 =?utf-8?B?QVJzblZxUkhPR2RlcXlHS0VCT0xlZFNSQ2Vkc1cvekl1UzA3QmhRbHpCTjdi?=
 =?utf-8?B?MlU0b2craGxwY3pSZmN0QUcxTU5pVzV1Ym5Yb0dxSmNTNkdqNktpUmpIKzJs?=
 =?utf-8?B?bStGU3lHTHpXNzBwTU13NGhMc1N3OUh1R2hhOXQyMzM3aHJIbGd5aWMvZjFp?=
 =?utf-8?B?elF4T3FpWFhsOWN1aGs3MXJsZmJKZ1cyVHV4OVd2U3N2T200a2FVOEp6Qk5O?=
 =?utf-8?B?MjdYbFVPZFpjL1Y2ZzJlYkE0cUJXRHI0Nml2NGhDd3JCZUl4ZmhzVXJlTUtu?=
 =?utf-8?B?WW1ZZ2txd1ZTbXQvWlVPUTVvMWxHZ3I2UkxjTEs4N0xta1hQZWFBeGVpRFIz?=
 =?utf-8?B?bnc0Ny9ObTBMdlBkMU5TSHhGYlFZcEo4dTFDZk9IN3hPcHFJbzh5bTJsVklz?=
 =?utf-8?B?U3hOc1FBUGJ5N0R2SmFlM0liZzMvWFZKUGoyNVhXeCtmVGJYKzdxelFOWndE?=
 =?utf-8?B?MkFXVThqUVdsU0VDaHEwc1RUbzdwejZib1BLS2V1OTh4RTBRZ1dtSEx1ZGpi?=
 =?utf-8?B?Rkg3QldBZENnblY0YW9WYWFJQWFneXFtOXRLQVRxbVlqSlg4WGJtMVFqZXZ3?=
 =?utf-8?B?ZkJuM01VT3hIR1BvVkxIQ2MwRm8rYzRmL1VlZ1BHV2l1OVdzeW44RkswaVcx?=
 =?utf-8?B?ajUyUzFCR2ZxQTZCOEV2ei80bVNOK1AxSVdNbWdqSDlySXVXMTd0S0tWbDVY?=
 =?utf-8?B?QlpCSXhZYjF3K0ZTQTNyMWhVS2RlY1E1OWhGNm5JWXUwQ2RBNXVSTllMVFlM?=
 =?utf-8?B?VWhSTGNaQ1J1VXJhTUJHclBqb2lFU3BRRHY0QWQxV1VGTGUwbm9OWEFtMjF5?=
 =?utf-8?B?UktYOEZDVjNjWnFFQ3d0WFlJZTFpVVVaS3hRdDdQN1h1eHFIRTZ2R0drTWJN?=
 =?utf-8?B?Wms2alFjVUVKN0FXejJHZ0tqN0pXMFJZMU4rRUQ3NnBqQUR1NmRrbmVvLy9D?=
 =?utf-8?B?WTNETzdkSVZjTU5iZzZKbDRUaGEvbVVpZXlJL1kwOXlnZ1RNcUdDcFVzdStN?=
 =?utf-8?B?M0ptZ1AzSVR5b2dNS1pJK3JDdkI2eGRBdkpFRmRLOFpOZlhBNVNWOFNEMHpv?=
 =?utf-8?B?KzNhUi9ialg3c2dISFlVR2tKa21NdzNaZjkxZlBoMktQU1RCTjB4WVpvNzIv?=
 =?utf-8?B?UTcvSXRZN2x0RHBzK2hzSTZPUEpWSnVGLzNFeWo0cHBpQ0lpNkMzTGsxVGZH?=
 =?utf-8?B?Nmt6TDJtTUZwQjVwdnZWdlRXYXNmQXhxTkVJbHl0M3p5ak5LOVI1Q3VMU28x?=
 =?utf-8?B?TnpDZEJlZlR3NnlEZnZ1dDdQZW4rTGV2ME04Yk9hdWw0SmtsNEZIeG9lTm5M?=
 =?utf-8?B?VENWeWtxWENiTHFoSWYzQXY5RWxjQXRqUVNYNlhocTV0a2dWbHBlUHVKUFp3?=
 =?utf-8?B?dkpHaXRlOHJvMDVBcDFXVi9laHNPUEVVV052K2FXQ3hXdkR2dFo0czlNMmJY?=
 =?utf-8?B?R2QvY3ZCS1JjcDF0d3UxbG9pYUFMMGt2OXh4UWMyTW90dTNGbVB4cFZTaDR2?=
 =?utf-8?B?anJwaFdjeXJMdWk2UERCa0xZaUphWWZWOW52aFZ0Vm11RWxXNkFKdjZ3YmZO?=
 =?utf-8?B?bkNDNDlyREd6NlBLekJ0eEpRU1lkeDM4clhNbHhsSzVkdzIrYnBWUllmbmxF?=
 =?utf-8?B?blBFRFp4clErblhEN1JGTGJEMTNjZ2k5RWIxSWdFWEdmR2p2dno5all5QXZ1?=
 =?utf-8?B?WmZJaE9iS1NCdWhoeEdTUmxsY3lUOFlLaHFORFdKMDU2SVkvOHVHZFdLdGk1?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qE9p6XzNPuUdOL/nmKgu5igcYRCZA3BtSVG4EGR98f3dlwDzDwdSSqYvaZN1XVnSnfAv4gTig0kUfkVSwaGoZwVyyjBMGqwgNUh9S0W4nvoQeZaahI53VksZVosI9PcZayWBn2chsA8iu+aXeSKm0TLwTgMkdJ0IQ8FxNs7Y2+AQrYR3B06COYkDOQzhG/etS2YD8EZ+hlVKnvP29OAkx3lnRptnQJB7d20p2ONU6H4GGUFxCtDGGhkmjZF5zxU33qrOgK+DrfnvL33J4A0c9DaH1+8LZOa1B/OLBFoep3BrwGnnsbhr6Ywo5clbHkcfpoz7IvC1Lk6hO8z2qdotHDzywBh1aBoWglvOREpjsjKFFNbEBz897+gqKX0/diOqHB2BuqZmFkVp6U9gi30/iiY0fcPQJhxqjOSYNKvVfwphTWh+uSZe6Y4TtiS5U/SAmUuP5mqm7FumscaJDSt8xZbd9GDYbWZ+n32dvGFmfdw7yvXyV1TqamognRfoh4gbu25C9GYvupVl3owiGcbL33fQdfq9BnMI33FyhQYfvmX9u9OY2T7DuF9/VCd8VIP8YBgqc4ORnujf4Yl9rr75e+fYMvkQ7KQPhSn9Yes4ns2uIAH8xy4HC71FcJ5jU7JdQTDUIBjxAqA+TeG+Krj2kg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR16MB3396.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2086c65c-2794-4d70-80f7-08de2c37883d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 15:30:15.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKRfUkNq62QGvb7W3S9rVoByRJ28tFbpJrwf/tVaxxPHZvH8zG9XdG5n0Ta/jq5xFJranULtUSCTXsXhue3oQWWz1gPcZBehYgZC3xsT/Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB6906

T24gTW9uLCBOb3YgMjQsIDIwMjUgYXQgMDU6NTM6MDdQTSAtMDYwMCwgQmpvcm4gSGVsZ2FhcyB3
cm90ZToNCj4gPiBbK2NjIEFsZXhleSwgSmVmZnJleSwgQXZpbmFzaF0NCj4gPg0KPiA+IE9uIFRo
dSwgTm92IDIwLCAyMDI1IGF0IDA5OjQyOjUzUE0gKzA1MzAsIE1hbml2YW5uYW4gU2FkaGFzaXZh
bSB3cm90ZToNCj4gPiA+IFRoZSBTYW5kaXNrIFNONzQwIE5WTWUgU1NEcyBjYXVzZSBiZWxvdyBB
RVIgZXJyb3JzIG9uIHRoZSB1cHN0cmVhbSANCj4gPiA+IFJvb3QgUG9ydCBvZiBQQ0llIGNvbnRy
b2xsZXIgaW4gTWljcm9zb2Z0IFN1cmZhY2UgTGFwdG9wIDcsIHdoZW4gDQo+ID4gPiBBU1BNIEwx
IGlzDQo+ID4gPiBlbmFibGVkOg0KPiA+ID4NCj4gPiA+ICAgcGNpZXBvcnQgMDAwNjowMDowMC4w
OiBBRVI6IENvcnJlY3RhYmxlIGVycm9yIG1lc3NhZ2UgcmVjZWl2ZWQgZnJvbSAwMDA2OjAxOjAw
LjANCj4gPiA+ICAgbnZtZSAwMDA2OjAxOjAwLjA6IFBDSWUgQnVzIEVycm9yOiBzZXZlcml0eT1D
b3JyZWN0YWJsZSwgdHlwZT1QaHlzaWNhbCBMYXllciwgKFJlY2VpdmVyIElEKQ0KPiA+ID4gICBu
dm1lIDAwMDY6MDE6MDAuMDogICBkZXZpY2UgWzE1Yjc6NTAxNV0gZXJyb3Igc3RhdHVzL21hc2s9
MDAwMDAwMDEvMDAwMGUwMDANCj4gPiA+ICAgbnZtZSAwMDA2OjAxOjAwLjA6ICAgIFsgMF0gUnhF
cnINCj4gPg0KPiA+IERvIHdlIGhhdmUgYW55IGluZm9ybWF0aW9uIGFib3V0IHdoZXRoZXIgdGhp
cyBlcnJvciBoYXBwZW5zIHdpdGggdGhlDQo+ID4gU043NDAgb24gcGxhdGZvcm1zIG90aGVyIHRo
YW4gdGhlIFN1cmZhY2UgTGFwdG9wIDc/ICBPciB3aGV0aGVyIGl0IA0KPiA+IGhhcHBlbnMgb24g
dGhlIFN1cmZhY2Ugd2l0aCBvdGhlciBlbmRwb2ludHM/DQo+ID4NCg0KPiBUaGlzIGRldmljZSBj
b21lcyBwcmUgaW5zdGFsbGVkIHdpdGggdGhlIFN1cmZhY2UgTGFwdG9wIDcgSSBiZWxpZXZlLiBJ
dCBpcyBub3QgdmVyeSBjb252ZW5pZW50IHRvIHJlcGxhY2UgdGhlIE5WTWUgaW4gYSBsYXB0b3Ag
Zm9yIHRlc3RpbmcuDQoNCj4gPiBJJ20gYSBsaXR0bGUgaGVzaXRhbnQgYWJvdXQgcXVpcmtpbmcg
ZGV2aWNlcyBhbmQgY2xhaW1pbmcgdGhleSBhcmUgDQo+ID4gZGVmZWN0aXZlIHdpdGhvdXQgYSBz
b2xpZCByb290IGNhdXNlLg0KPiA+DQoNCj4gVGhlcmUgYXJlIGEgY291cGxlIG9mIHBvaW50cyB0
aGF0IG1hZGUgbWUgY29udmluY2UgbXlzZWxmOg0KDQo+ICogT3RoZXIgWDFFIGxhcHRvcHMgYXJl
IHdvcmtpbmcgZmluZSB3aXRoIEFTUE0gTDEuDQo+ICogVGhpcyBsYXB0b3AgaGFzIFdDTjc4NXgg
V2lGaS9CVCBjb21ibyBjYXJkIGNvbm5lY3RlZCB0byB0aGUgb3RoZXIgY29udHJvbGxlciBpbnN0
YW5jZSBhbmQgTDEgaXMgd29ya2luZyBmaW5lIGZvciBpdC4NCj4gKiBUaGVyZSBpcyBubyBrbm93
biBpc3N1ZSB3aXRoIEFTUE0gTDEgaW4gWDFFIGNoaXBzZXRzLg0KDQo+IEJlY2F1c2Ugb2YgdGhl
c2UsIEkgd2FzIHNvIGNlcnRhaW4gdGhhdCB0aGUgTlZNZSBpcyB0aGUgZmF1bHQgaGVyZS4NCg0K
PiA+IFNhbmRpc2sgZm9sa3MsIGRvIHlvdSBoYXZlIGFueSBpbnNpZ2h0IGludG8gdGhpcz8gIEFu
eSBrbm93biBlcnJhdGEgb3IgDQo+ID4gcG9zc2liaWxpdHkgb2YgbG9va2luZyBpbnRvIHRoaXMg
d2l0aCBhbiBhbmFseXplcj8NCj4gPg0KDQo+IEkgZG9uJ3QgdGhpbmsgS29ucmFkIGhhcyBhY2Nl
c3MgdG8gdGhlIGFuYWx5emVyLCBuZWl0aGVyIGFueSBvZiB1cy4NCg0KPiBJZiB5b3UgYXJlIHN0
aWxsIGhlc2l0YW50LCBJJ2Qgc3VnZ2VzdCBhZGRpbmcgdGhlIHBsYXRmb3JtIGNoZWNrIHNvIHRo
YXQgdGhpcyBxdWlyayBpcyBvbmx5IGxpbWl0ZWQgdG8gdGhlIFN1cmZhY2UgTGFwdG9wIDc6DQoN
CldlIGF0IFNhbmRpc2sgYXJlIGN1cnJlbnRseSBjaGVja2luZyBhbmQgZG91YmxlLWNoZWNraW5n
IHRoZSBpc3N1ZSBvbiBzZXZlcmFsIHBsYXRmb3JtcyBhbmQgd2l0aCBzZXZlcmFsIGRldmljZXMu
DQpXZSBoYXZlbid0IHJlYWNoZWQgZmluYWwgY29uY2x1c2lvbnMgeWV0LCBidXQgd2hhdCdzIGNs
ZWFyIGlzIHRoYXQgcXVpcmtpbmcgb3V0IFNONzQwIHVuY29uZGl0aW9uYWxseSwgZm9yIGFsbCBw
bGF0Zm9ybXMsDQppcyBkZWZpbml0ZWx5IGFuIG92ZXJraWxsLiBUaGUgZGV2aWNlIHBlcmZvcm1z
IG5vcm1hbGx5IG9uIHZhc3QgbWFqb3JpdHkgb2YgcGxhdGZvcm1zLiBBcHBseWluZyB0aGUgcXVp
cmsgZm9yIHRoZSBjb21iaW5hdGlvbg0Kb2YgU043NDAgYW5kIFN1cmZhY2UgTGFwdG9wIDcsIGFz
IHlvdSBzdWdnZXN0ZWQsIGlzIGRlZmluaXRlbHkgYSBiZXR0ZXIgY2hvaWNlLiBTdGlsbCwgd2Un
ZCBsaWtlIHRvIGNoZWNrIGEgZmV3IG1vcmUNCnBsYXRmb3JtIC8gZGV2aWNlIGNvbWJpbmF0aW9u
cyBzbyB3ZSBjb3ZlciBldmVyeXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgY292ZXJlZCB3aGlsZSBz
cGFyaW5nIHRoZSByZXN0IG9mIGNvbWJpbmF0aW9ucy4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL3F1aXJrcy5jIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMgaW5kZXggYWRjNTQ1MzNkZjdmLi4x
NjU1NzU3YmE2NmEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYw0KKysrIGIvZHJp
dmVycy9wY2kvcXVpcmtzLmMNCkBAIC0yOSw2ICsyOSw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2t0
aW1lLmg+DQogI2luY2x1ZGUgPGxpbnV4L21tLmg+DQogI2luY2x1ZGUgPGxpbnV4L252bWUuaD4N
CisjaW5jbHVkZSA8bGludXgvb2YuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGF0YS94
ODYvYXBwbGUuaD4gICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+ICAjaW5jbHVkZSA8bGlu
dXgvc2l6ZXMuaD4gQEAgLTI1MjcsMTUgKzI1MjgsMTkgQEAgREVDTEFSRV9QQ0lfRklYVVBfSEVB
REVSKFBDSV9WRU5ET1JfSURfRlJFRVNDQUxFLCAweDA0NTEsIHF1aXJrX2Rpc2FibGVfYXNwbV9s
MHMgIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQQ0lfVkVORE9SX0lEX1BBU0VNSSwgMHhhMDAy
LCBxdWlya19kaXNhYmxlX2FzcG1fbDBzX2wxKTsgIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUihQ
Q0lfVkVORE9SX0lEX0hVQVdFSSwgMHgxMTA1LCBxdWlya19kaXNhYmxlX2FzcG1fbDBzX2wxKTsN
Cg0KKy8qDQorICogU2FuZGlzayBTTjc0MCBOVk1lIFNTRHMgaW4gTWljcm9zb2Z0IFN1cmZhY2Ug
TGFwdG9wIDcgY2F1c2UgQUVSIA0KK3RpbWVvdXQNCisgKiBlcnJvcnMgb24gdGhlIHVwc3RyZWFt
IFBDSWUgUm9vdCBQb3J0IHdoZW4gQVNQTSBMMSBpcyBlbmFibGVkLg0KKyAqLw0KIHN0YXRpYyB2
b2lkIHF1aXJrX2Rpc2FibGVfYXNwbV9sMShzdHJ1Y3QgcGNpX2RldiAqZGV2KSAgew0KLSAgICAg
ICBwY2llX2FzcG1fcmVtb3ZlX2NhcChkZXYsIFBDSV9FWFBfTE5LQ0FQX0FTUE1fTDEpOw0KKyAg
ICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnJvb3QgX19mcmVlKGRldmljZV9ub2RlKSA9IG9mX2Zp
bmRfbm9kZV9ieV9wYXRoKCIvIik7DQorICAgICAgIGNvbnN0IGNoYXIgKm1vZGVsID0gb2ZfZ2V0
X3Byb3BlcnR5KHJvb3QsICJjb21wYXRpYmxlIiwgTlVMTCk7DQorDQorICAgICAgIGlmICghc3Ry
Y21wKG1vZGVsLCAibWljcm9zb2Z0LHJvbXVsdXMxMyIpKQ0KKyAgICAgICAgICAgICAgIHBjaWVf
YXNwbV9yZW1vdmVfY2FwKGRldiwgUENJX0VYUF9MTktDQVBfQVNQTV9MMSk7DQogfQ0KDQotLyoN
Ci0gKiBTYW5kaXNrIFNONzQwIE5WTWUgU1NEcyBjYXVzZSBBRVIgdGltZW91dCBlcnJvcnMgb24g
dGhlIHVwc3RyZWFtIFBDSWUgUm9vdA0KLSAqIFBvcnQgd2hlbiBBU1BNIEwxIGlzIGVuYWJsZWQu
DQotICovDQogREVDTEFSRV9QQ0lfRklYVVBfSEVBREVSKDB4MTViNywgMHg1MDE1LCBxdWlya19k
aXNhYmxlX2FzcG1fbDEpOw0KDQogLyoNCg0KVGhpcyBjaGVjayBpcyBzaW1pbGFyIHRvIHRoZSBE
TUkgY2hlY2tzIHdlIGhhdmUgY3VycmVudGx5IG5vbi1EVCBwbGF0Zm9ybXMuDQpJbmZhY3QsIHdl
IGhhdmUgYWxzbyB1c2UgdGhlIERNSSBjaGVja3Mgb24gdGhpcyBsYXB0b3AgYXMgaXQgY29tZXMg
d2l0aCBTTUJJT1MuDQoNCk5vdGU6IEknbSBub3Qgc3VyZSBpZiBLb25yYWQncyBsYXB0byBpcyBi
YXNlZCBvbiAibWljcm9zb2Z0LHJvbXVsdXMxMyIgb3IgIm1pY3Jvc29mdCxyb211bHVzMTUiLg0K
DQotIE1hbmkNCg0KLS0NCuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprg
rr/grrXgrq7gr40NCg==

