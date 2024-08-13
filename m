Return-Path: <linux-pci+bounces-11615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FC094FF1E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A791C20CAE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903AA78C6C;
	Tue, 13 Aug 2024 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pr0qV2IS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A83DBBF;
	Tue, 13 Aug 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535662; cv=fail; b=B9ctIbV661Rad4hq8Eusq2cD06PYtDW+i3UxD8UPYCzJItWJ6plM5NYcnV3ph7Na0KLIMhAXAhPUq0kIRvHRs1c2bs4b0EnFaqS6wQhSIU6VjmsUIUB2/dfu/yOM0rBlTf8emV2JP21Y1tFg7/XmwvgsXMhLXS3yAKHRigBT87M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535662; c=relaxed/simple;
	bh=vHgQWojI7wHta6iaAjatoGp0A34HLpPifbSQSRqgdrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0ELFP19eaC4epu/+MtIBLDBqfUKH2XePj6MBjHd7O9oDcdURwCCGeGk3RBvNqpqH7xSHI945KSBDEfXF1m8j9lk+HMhbZBMaWS+Gx4tjjayhqaN89TYdI/LqflkWOdk1EdDshTaRw3CPK6IotN5Z/lyL7J/goYpY2/tRpXPtqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pr0qV2IS; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEeAOZFuTcCfoAtYKPnXrnIExTlY6thzy5L140o9N10+vUcDxJtrIzRc+NFh5PnKQeNyQCLwthySsHUuDnDcrh1PYfi+nF7tPILrHyfvAoEWge1oyvgH3vMEfR1SHE7UZIC0Fn1eMIv6zAz5BzNfBOjZ4aS9llaXDjx4GoYGl/nc0lQfimEyMfg4cp/s+uo95pOffxgovNxyYUUU3/LOOrxxVrCcFRSyo+CzqISHhCPgRpJYrtBfU5gD9QxhQ2Pg7trkZBgIS3YMQ5tN/+f0z2VsUqmOF3vza4DsVeJfJU8ptn1OT6XSpq6FilPzsyP+dAv7jsCu25KR2VF2a/4mVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHgQWojI7wHta6iaAjatoGp0A34HLpPifbSQSRqgdrI=;
 b=Es8Mgl1e8x06m06SJhPj9JCzSNo23sgjHhrSitPsi6F+Jf3h0qGrD04UgNdw9J7zVmZo7kCrj4cgSyzj7pjPBqXujUVoC5RfVf+70a7TiBXhYwi5R3XDhAhG9nVb0PYZX4PCaavCAYNoLl2ONkzph5ik1YMQFrU30jj3s99/RGYBy2duUn4th0HDZzPyg+fZ+N+czI01IP/X71JggdpSwLVWQqoMBxo18Q3WwEJdjfhNLroHCACmfAhpminCjlCNLUqo0Q+IB6SWCMKvpNcscqavL0bgPkgtYglsewTcpdSUYSOQmBVvVAqGUHcycSngd/OQqHOt9K2qiv/+ZVHCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHgQWojI7wHta6iaAjatoGp0A34HLpPifbSQSRqgdrI=;
 b=Pr0qV2ISCtvtiNbFOaqSybRm+O3X46r8/8PLi6o0T7naL9c3g2TRI0UHZxMhiVqQwHDLJd7EcEx4JXQWspyZjNR/40LE5scu5eRe9vIFutyovGO0PUXS4pB2xlVlchBWQGFXoCN8WAoSGb34qFHpHYIGvmSQXCttgFIVMNbVF02SK4rJRXJh880YpZMA1edf5rWR8p+xBe3olbyiw3+eE+w52W0RL55noscDbmuwltliJ/2p0LRKu2krQZbF72A994lDTsMHfG6q1u1LI2JvewBAJxvglNXe1OFJ4aPXrBj4j/bnHH3gC7jqM6T9KOccWsdUqm1pIG/Xnwoa6YcUUw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 07:54:17 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 07:54:17 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for
 i.MX8MQ PCIe EP
Thread-Topic: [PATCH v4 2/4] dts: arm64: imx8mq: Add dbi2 and atu reg for
 i.MX8MQ PCIe EP
Thread-Index: AQHa4V1AF4QWrwqa4U6h4a6bVSqOB7IklGMAgABUxPA=
Date: Tue, 13 Aug 2024 07:54:16 +0000
Message-ID:
 <AS8PR04MB8676E570AC307F540F1CAFB98C862@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1722218205-10683-1-git-send-email-hongxing.zhu@nxp.com>
 <1722218205-10683-3-git-send-email-hongxing.zhu@nxp.com>
 <ZrrJ9hfs2ycJgq8W@dragon>
In-Reply-To: <ZrrJ9hfs2ycJgq8W@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GVXPR04MB10248:EE_
x-ms-office365-filtering-correlation-id: 25f0039d-9293-49e6-1524-08dcbb6d21b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dy85Z0RKNHJEa2RwcU9jdHhHLzA3UGhKNDJicUg4Nk53V3VFNFVxV3d2cGcv?=
 =?gb2312?B?SlNPVGJnUFRoRWNSNUdmSFA4dzMvNWVXT0F2dTNpeUttMjdIL0hNMFgvK3Jo?=
 =?gb2312?B?RVNXUXhXWTdUMW5rdFFTcVJteG9XRVUxQlJsbnFxMWhLekRIOGNCUkhvVFZt?=
 =?gb2312?B?enhjem1GWGVhWGpCQVhCeXNXRmR4RmhqdHNWK09WNWVGSjNidTV6RU5kZXJP?=
 =?gb2312?B?SUdRUDRzWUs5RXFoaUhzNFdJMUxON1R3TmtxN3dGMGFrT2k4akVld3lCc2dP?=
 =?gb2312?B?NkFlUWZCa0t4RmdMeUZteG1lSGRyWmIzdmowUHBDU0tDSUZ4R3ZtbktDVmMr?=
 =?gb2312?B?ckMwL3hka2VOOHdMbjhQUFM2bkFJMUJKNkNhVm1yblMyeVRrR0tsYmEyZm1X?=
 =?gb2312?B?UnlDbzArQm5GeXc0U0lZWjVJd2JGRWlWNnc1Rk5Na2NxbGhHVU16UlQ1TzlI?=
 =?gb2312?B?Rno1YlZCZGppUDc1SzlQNjFSQzdmRDEra253U2cxU3d2SXdOQmczS2RmQnlu?=
 =?gb2312?B?WGVaZzhFU1ZGaFdISStFNVVuYzdiMXBQOEZCYWpMNm1Ebjk4bUNMWE1GTmFO?=
 =?gb2312?B?SjNpeFlLSWhRODdLdTFiNTRkbWg3bFhQb3BWVWI2L0pNMVVWN2JzYmZ6U2t5?=
 =?gb2312?B?S3dyaGp2dE5PZXV3MEswUVVaZ1hFNC9uTHNsQ3JoalhlUEhGd0xCQWxhWTJv?=
 =?gb2312?B?TmhwMDRldGx2NlVnMXN6Y2cxRFFCM0l1UnRSZXRtalJ4YlJnQ1hudW04ZzMv?=
 =?gb2312?B?UWdNcHZhZFh4dS9DempSSk9EZXc3NFJZSUdQNW5aZXhlbmh0aU9CTkxKcUxR?=
 =?gb2312?B?b3A4Vko1dWFteUx6TWhsTmY5Q1loQlVEQnpjTmkzbVhNbjFlK1JiL3pmeUJq?=
 =?gb2312?B?bDMycEdwSXo0UWxVYk1ia0ZwNGtFcjY4amhyZ3llbmlPSCtMdjhxUW81VUFK?=
 =?gb2312?B?WGs4NmNZeG9VYk5oaXZmSGs5b1h6VEpjNVZ1V2dvTTljNDRQcEVJWTVMTmxu?=
 =?gb2312?B?M3Z3TnNnM3hTZjY0TUp1RERWYmc2YW5yRVNNYVlGb2RNRXVNNC9rZ1krV3g5?=
 =?gb2312?B?ZTVma0hucEJwTUowenBUWTlnNmY3SlhNMy92OFkvcDhaQ1B5bFJpSkNIblNC?=
 =?gb2312?B?NFBWWFl1UWRtZHZvWHJHdmFwTHRZL0Q3VlZEUHNyTXZ5bHVtTkhqTDliVXUx?=
 =?gb2312?B?WDA5YkdETmwzNmdHU1NxOXRVU2VyZkk3MzdEVzJQMkVOZytUTkF2WDE0K2Jo?=
 =?gb2312?B?Z3Nmd0lKNEdoYjVhVHhUU21MR1pUeGttbnBsL205Mlhxdnp1bnpuOFNXaGhq?=
 =?gb2312?B?OTlwTTF3Z0c2MHJZRHFGa01KLzlIQWJ4K1Nac1hJZ2ZDcEk4MHhrY0lBSm0w?=
 =?gb2312?B?cjhZRmpGdm5KcGVhZTl5SVptalZHd2ROMmhvY2dxRnhjNllsY3JHekRBeC91?=
 =?gb2312?B?V3FITnVHMXk2aks5bThlbE4vdDA2UWUwdlVDNk4wdjNVRW15VlVIMFU2M3ha?=
 =?gb2312?B?QjZaWU5KTlQwQWo1RUdVVmYyVlB2NWRZdUxlVHU4R1NsY3UvdlhJbDN5Y0Q3?=
 =?gb2312?B?NFdrdlZTTlhQWjFQWHpKemdJQ3pkNzQ2cmc4QjlWRDVibnNlbmlOWkxrcXEr?=
 =?gb2312?B?ODVGV2NIZzV2bzRTOUV5YlR2SnFFRVhEVGNTM01wZWQwWUhPaXdxQ1FwWTFl?=
 =?gb2312?B?bHl2UUlUUHNFbGxxcnRMaGI4a01ZazdoL3dQMjRNZTZsRGsvMnl1K01hTXJz?=
 =?gb2312?B?aEo3aWsxSXY3b2hoMjVWUHR3NnRaMzl5a2dEZHZCTzVrK0Ixb2dLNGR4Smov?=
 =?gb2312?B?R1JxQ0wxbWtvcUd4Q1k5WUp1aUJGL3JGVS9EZlJsQVVSeG1nT0dWVWJGeTJ5?=
 =?gb2312?B?SldUUEFsMG5hZjQ5eFRYMVNsaUw1djFtZ3Jnd1hpbWR0OFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?NmROQkhmMEdrVUMwUjlaaTVJK2pjaFRJczgwWjMrMnhQVWNzQ1FzT09Renl5?=
 =?gb2312?B?TlJIT3NVWU90SFhLWnZDUXhXR1lYcXpCTmtxK1cvLzhkOFY1TmZmOE1xZ1o5?=
 =?gb2312?B?VnpGYk9rcVZqV0VSNHcvUnNuN1lLSFo2K2FNQnBreE5aRTdLL1VhaDI1WU1m?=
 =?gb2312?B?eVFBTklQN01LRXIvWGtiOURZd3dHUTZBM3Jod2dSbXNrandMcXJXajA5Vmtu?=
 =?gb2312?B?QmsxMnN5SmtiY3Y3M3lXeTZKSHRMWFE3NTZDSEYzZ21RVEZsam0yaUNuWm9v?=
 =?gb2312?B?K1dVTHFnMG1KTjJ0Q2t2QVc5M2t5cFZmOXpzRmgwb0IzVWNLeGx6eVF0YzJx?=
 =?gb2312?B?b3daVzR3dlpDQll6eEJTWE5OQzVHNzQ5d2RWeXFwYlVUbG1Ud3dsbkcwdERn?=
 =?gb2312?B?anhXZjhReWgvbGVyU3NmOVhwNEJWYmtZc3Bqanh2Ky9RZCtqRmxMQkMrWktQ?=
 =?gb2312?B?R2h4OGJremF1WGFwZUJtOXQ4bjVLdFRzNWZUVU53V1NRNjdCdWliTXh6RXlO?=
 =?gb2312?B?dXdiZTR5cHp0NVJid0VQVFUrT2ljWmFzeVJJZ1ZMaVlsK25XZ1RqbmdDMXFx?=
 =?gb2312?B?TzZnUllVamNnbS8xK1NWUHRiOFZoOVVvS0tYQkVyTTMwUHkxbURVdUZIZjFE?=
 =?gb2312?B?TzFXa3NxYzJaUjYreVdFbC85Zi8yVVB4cWxQelpmRDJYZmw3bU8weWJvMWxK?=
 =?gb2312?B?TUpCZU5CUEJpYmJCdmJ6N2h3bVJiQjgzVW5xbEN6WHcrcXF1Y0xWc293RENV?=
 =?gb2312?B?dUFXclpLL3hmOWJuNzhhcGJUVU9oVFFCUmtNaTlHTFNRcmIrc3ozeGgvY0ZY?=
 =?gb2312?B?MzB5MEg1QzNuNTRyYk1jRlhlQlozWEp3NjJGTEluZEs5eEhOMzJXeGtUbEw5?=
 =?gb2312?B?NGVmVGw5Sit5QUZQOE5Rc0NPUkJiK2lFazFNZm9BQnZQeGtzbkd6S0dDWG1I?=
 =?gb2312?B?TTBhUElLV3BxNm8vRU9VbVE0bDBZbkRqUWxtVkNvcEVDN2dQYVBHYUtDZmNn?=
 =?gb2312?B?V1pSY3ZzSzFRTUJCcTM0OVhTY0FPNEFrZzBBVlp0YUVYbWd4Vk5jdVE0K3h4?=
 =?gb2312?B?SG04Tk9QSm5Ca09aMHRpc0Z6b0k1U0h0Y3V6Z1lQb1pZRUlQVVNNbTR2NUJD?=
 =?gb2312?B?OEtKRG5aV1FsTDZ4aDRJdndZcnRvaEplZ0ZxaTFxUTVEUmowRmlhOW01ZC85?=
 =?gb2312?B?aGEzbUcxVUY0cTJzbXNjUjJaSDBHV3E4d1pTRnZCTWxEZDU0U2wydC96SE5z?=
 =?gb2312?B?cVZleHNOUk5KdGV0cTdwUnJ6U0NzcWJveXlueFBkMXEyU3NRWjM0NDBOZjZt?=
 =?gb2312?B?ck53U3dvU3JYV1prd0liNW5kSXJucDV5Q3pKaDVHVnkwSjFnOVErRktxM2hU?=
 =?gb2312?B?MFhiRHduOGxkUGp5Wk10UEF4MHBVNkcxZS9Db21XVVdtc2w0d0NrR2hwN1pw?=
 =?gb2312?B?NWxjUDlNRERwWkNSd09sejZTZ1l4bEFPajRpdTdOMjdBVmNud3hhKy9peU9j?=
 =?gb2312?B?WW5ZZW96SEQ4UXRMc0JNQXg1aExwdW9Za3JzenFIWmRzbUc5MTZzZHVOWDgx?=
 =?gb2312?B?Q2JWR0VnVk9yNHBJT2NpeXp1Ny9SRjZXazVpeVdVSmVMM0dVT3NLTm5hT0Rx?=
 =?gb2312?B?QWdEY21YRTlLZGhydTZla0JucTY2NVZjc1ZqaWFKSEdFRll2STE4TlM1SWIw?=
 =?gb2312?B?RG96WEQveU1URnlvaW15QnZudCtzd3dqTDExMGVaN0FocHVrWHFrSk4yZHkw?=
 =?gb2312?B?YmtOcElUb3dUQ0VQUHE5QmZVSmZCV25IV2thbTBZTTZkVmh6NW9MSkhTWUNH?=
 =?gb2312?B?UVpxU0RpcW1KSnF0bUFOWjFqcGF5TjVOekI5UytnMExYZ0xFZnQxM3RrZWc2?=
 =?gb2312?B?T0c3N21ZbXNuaTRCL3hhaU55WFdRYXE5Z1hXcDdnaFNJUnF2V3VwaHQ0SHN6?=
 =?gb2312?B?OVBXR1YxMUxYQlFRVWFiZTZuSHNxaTQwZXVxTlBzOGo1b2FlSlhUODdPTURB?=
 =?gb2312?B?QjZ4cTFSellqc0VmckVNVHV1SVhQNWJZWk5jMmhTU2pDM2VDK3J5ZTdYTEM3?=
 =?gb2312?B?aVhXb3RDOFE0VzFuSzZnSjVwbzJpQ1NNY3NaaG1rb3YrZk43cFNvMWxIUUtB?=
 =?gb2312?Q?nzLLEAuLWyr4E7jzwiZcMIIBf?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f0039d-9293-49e6-1524-08dcbb6d21b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 07:54:17.0168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+TTeWpPYnZYrou4oY9mQyOP0UG2+uOaEvaLN3QDJR9RPGSV2l5jEBNCsIy5l4JichnEGHH2Bp8ZIBD+zBiyBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
MkB5ZWFoLm5ldD4NCj4gU2VudDogMjAyNMTqONTCMTPI1SAxMDo1MQ0KPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsga3J6aytk
dEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyLzRd
IGR0czogYXJtNjQ6IGlteDhtcTogQWRkIGRiaTIgYW5kIGF0dSByZWcgZm9yDQo+IGkuTVg4TVEg
UENJZSBFUA0KPiANCj4gT24gTW9uLCBKdWwgMjksIDIwMjQgYXQgMDk6NTY6NDNBTSArMDgwMCwg
UmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gQWRkIGRiaTIgYW5kIGlhdHUgcmVnIGZvciBpLk1YOE1R
IFBDSWUgRVAuDQo+ID4NCj4gPiBGb3IgaS5NWDhNIFBDSWUgRVAsIHRoZSBkYmkyIGFuZCBhdHUg
YWRkcmVzc2VzIGFyZSBwcmUtZGVmaW5lZCBpbiB0aGUNCj4gPiBkcml2ZXIuIFRoaXMgbWV0aG9k
IGlzIG5vdCBnb29kLg0KPiA+DQo+ID4gSW4gY29tbWl0IGI3ZDY3YzYxMzBlZSAoIlBDSTogaW14
NjogQWRkIGlNWDk1IEVuZHBvaW50IChFUCkgc3VwcG9ydCIpLA0KPiA+IEZyYW5rIHN1Z2dlc3Rz
IHRvIGZldGNoIHRoZSBkYmkyIGFuZCBhdHUgZnJvbSBEVCBkaXJlY3RseS4gVGhpcyBjb21taXQN
Cj4gPiBpcyBwcmVwYXJhdGlvbiB0byBkbyB0aGF0IGZvciBpLk1YOE1RIFBDSWUgRVAuDQo+ID4N
Cj4gPiBUaGVzZSBjaGFuZ2VzIHdvdWxkbid0IGJyZWFrIGRyaXZlciBmdW5jdGlvbi4gV2hlbiAi
ZGJpMiIgYW5kICJhdHUiDQo+ID4gcHJvcGVydGllcyBhcmUgcHJlc2VudCwgaS5NWCBQQ0llIGRy
aXZlciB3b3VsZCBmZXRjaCB0aGUgYWNjb3JkaW5nDQo+ID4gYmFzZSBhZGRyZXNzZXMgZnJvbSBE
VCBkaXJlY3RseS4gSWYgb25seSB0d28gcmVnIHByb3BlcnRpZXMgYXJlDQo+ID4gcHJvdmlkZWQs
IGkuTVggUENJZSBkcml2ZXIgd291bGQgZmFsbCBiYWNrIHRvIHRoZSBvbGQgbWV0aG9kLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gDQo+ICJhcm02
NDogZHRzOiAuLi4iIGZvciBzdWJqZWN0IHByZWZpeC4NClNvcnJ5LCB3b3VsZCBiZSBjb3JyZWN0
IGluIHY1Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBTaGF3bg0KDQo=

