Return-Path: <linux-pci+bounces-16512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A89C5157
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 10:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A361F21D0F
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72920A5FA;
	Tue, 12 Nov 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVznGSXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C115204932;
	Tue, 12 Nov 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402031; cv=fail; b=GCMPjKEzfNo3lgg7RK+BN7UJDPJE2mmghyTVL0UZa9ZrzyHwdv+fjwYuFSQYQ3AVfejMaqisudJO3kW7aWr62pcSUzJ+MelGayY8q1MtP+4KLdrc4tOEcuRR7fYpFQg6ez+M27O+0W+X+KdVuMRtQxcHbe+YsrpE/kqSCWi2qYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402031; c=relaxed/simple;
	bh=8ENUyyIs6NyV89GLUgt1dkNJshT7jCt9jxS6w/megXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dy5LE58ta1ApfPdGEqqaOxjMEbe07pPawN98ZVwCIoAvnOiGpxLZ+Zw3zdA2N2foyZ4fBgZ3FIVqevrQFi03gIutMowmosQ+qvO4VSPsSqBoIeky+RN4dCAMqIwNY2HXo/A4VsnWhtsM/WvqiIQouoaDzmNNltWBOaVLx/gjlMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVznGSXm; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+5UXXKhQuv+S8C9SseIEtlGbinsbC0yazGamkgZg1Ny0YeEzVGI5B5Plks8KIJrnkP04CNe5BNOwf2MN2Fp+M1P0hDDdxvMdAbpU1jx73cp89YsfD2MmJGGEo035txcJsumefDvdtAbad9Tp3ZFVNS9zm1FGFkYehfVrnJn3bh7HLIgy0zjTOMjQ5kzLJFQ7K0IFt0/BVjkMKOcB4EfrCdq64oJBXHvUvlg/hp7fHYmQntH3LsVRTGGUrqkP+E+fNKWTIHZ9p8Roz6rM+WtO71QffF5yNXzXiD6EOREyN6uFb3W80nAz8UENQLkMn+h1q2nYtVQ2UsYeb2n3qeYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ENUyyIs6NyV89GLUgt1dkNJshT7jCt9jxS6w/megXc=;
 b=gMRM//YSKmugnoVrWDdmwJYc6UAn3TFCL3ZUb00VPnvGapl4LAOXq8LvwGNYpXpcpnY8ZuZtvilLg8Ax2pEyyWMRqT59RNPf1lIV2lLjvjSKsiQk/i4fMXlaUib6pnecs8RuTafhNjMR177pP2P2tsKCEMBu3LBEDhKkXunhQyKZXh01jbS0Mt1IkHiY8kvgnW9stOTqGDiz1KBNrY/LHHWsIbcoXNf1HBeMQSvQHL8cNWXnsbJ545OUDeS0STiD+4oL3GpBSqOeE+0TA0OQX1LGZWVPdx3dJGWafm04QAbQEKlJ2ucDaw1kKbo78CBcrjXVb8bv82OuUM7M0kVKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ENUyyIs6NyV89GLUgt1dkNJshT7jCt9jxS6w/megXc=;
 b=ZVznGSXmMZaeqGsrdBY7jAd6+MwIqBgmaBhUHaaRC0gxnVZ7kCxwu3f9dmNtpyKCm0aKyqwRrP91m6loF9+x6aSxIh95nmeIaQKySUzsgTN97/RDWqRrjVDkud0VEnHTefdtukqluOvLGt0CFzQCMS8PkD9mSyFKKW2UaHDxIGnGi7PdcfbY1Q27RiQ6UpmhZAR14zvTzYo5ICGWFaj3ebQLg/6XeZI94A35Xwwn0c90wqo3uUMlFHTh+IFXQVFG0XnDQ+kGkSrkfcs4AOQ6brfbMgRipYUCOkd7bGbKWHkFPY8YqHYRuuJkA72dJWxsZCyzwoF+sg3q6kz+QhCiyA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8924.eurprd04.prod.outlook.com (2603:10a6:20b:40b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 09:00:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:00:24 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
	<helgaas@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Topic: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Thread-Index:
 AQHbMO/ydVggfwMlw0SMjZ6nwDplE7KrqksAgADc9oCAAyCsAIABv/DAgAAstACAALQigIABFqPA
Date: Tue, 12 Nov 2024 09:00:24 +0000
Message-ID:
 <AS8PR04MB86761D45F67FC31602F45ABB8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241108002425.GA1631063@bhelgaas>
 <b5f56ec9-9b5f-5369-52ed-bcf0c8012dbb@quicinc.com>
 <DU2PR04MB8677ECC185DFF1E2B62B05858C582@DU2PR04MB8677.eurprd04.prod.outlook.com>
 <20241111053322.bh6qhoigqdxui65l@thinkpad>
 <ZzIuPYAXUVWUMs9+@lizhi-Precision-Tower-5810>
In-Reply-To: <ZzIuPYAXUVWUMs9+@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM9PR04MB8924:EE_
x-ms-office365-filtering-correlation-id: 3e94d7ed-fe83-4133-e9c9-08dd02f87240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEFaeG03dGh0Z1ROVE5mdXkyUkcrQjBLbXpsZ1RKMGhFdnJVWW9kMEtsREtq?=
 =?utf-8?B?YjdkYjdGOEdRVHhvMWpNWFpIVGtuRWxLbW5hTmJ0elFUeXRhb2ZtaUc1Tk9T?=
 =?utf-8?B?cUkrb1ZiYjMvdVZKQmVmM3ZHNTBieGYybkliZERiZmxoNlIxNWhra2hMZ2VK?=
 =?utf-8?B?QndzUU1uMFFCL0pRNDRtVGw3ZnFLdGpXRXZwUUxRNGV1cGl1NTlNelY0UWNn?=
 =?utf-8?B?alNLTmtVTlV3YmpBU3pvUzVBTGRkelBNLytUMUNRc0tkNnAvTTlIVWJjVVYy?=
 =?utf-8?B?eDdVN1JkMXNvbzA4SWN4ZWlRaWZ6Q2xOU2tRSG51SFV1VG5IRjJnMUVpM0lP?=
 =?utf-8?B?Qk02cnVTdEVxdXovQ3ZYTUNoTUZOcWJYYlpxSVJsSE9mT1Ewa2paTlk5cjZz?=
 =?utf-8?B?Q3R4SmlkeUx3dGRZc044UmdOSmM0cGVRNVhHQmdyQy83Sm9DWU9tSEN5Q3I2?=
 =?utf-8?B?Ym93Q1dzNVc5YUdLZ2RsN0xpdlBxVmZtMXA4MWNacGdsQ2twc0JQVUp4T2xE?=
 =?utf-8?B?NHNlZ2U0YTRVbjVjZ05tVDZXWU1kdjZ0TE9UbGVCcDVvV1V2N0VoeENVa0JB?=
 =?utf-8?B?Q3pubHpva2dRK2xQa3Y0RTE0R2pVSlAvNG15aTdsNFhkMWpLRmxBeW0vaGYx?=
 =?utf-8?B?R0RjV3VGQ1E5NW5kNGdDZEJGOFhTeHQxVFBuT09UOG9WUXByYUt4eGpEQjN3?=
 =?utf-8?B?Sjh6dGEvakNUcFlGcUs1NlJEbDIxYmxWVkZXUlA2U3gzUmNxZHpqWlg3cVBo?=
 =?utf-8?B?UndRa1F3KytnaEZKemhEZ1JnTlZPa0hPVkFGMEtGWHNObjRoSU1DQkkreHEz?=
 =?utf-8?B?VSt0S2xsQmdwZVFPQmxLUmcrY1pOM0hmclIxR0tVK3VrMTViSVovdkIyeVF4?=
 =?utf-8?B?ZWl3ZXRabEF1YzhLZE04TWhDNzB5T3B6V2g0QlNMMUNJZFVQcVJ0S0FKWHRs?=
 =?utf-8?B?cTJYSklPK0t2aC9yWmhzT2RmdnY0QjA5eWN4U2ZsdDNBRVhjVlJac0pFZFo4?=
 =?utf-8?B?R0FpYlJjK09oaXNneVJYbklGdzhtd0gvRm4xVFdqWC84V2d5cEVscmxmNElU?=
 =?utf-8?B?QXBuV2NINnRUczNFeHZtZFVaRlJweUh3K3lLN0dMSXY0SXVEQmpqM1FsWVlz?=
 =?utf-8?B?NGVWbFNtaG1LT1N6aiszcmhiZVVkUW0xK0ZBQTZ1c3ZGeVhMSGlMU1U1aUQz?=
 =?utf-8?B?ZlhMQ01CWVg4WnZFdTFIeVJmZ2RmaHk2Q1BNRUhoQkIxemxKRmhMc0g1SmxT?=
 =?utf-8?B?ZmRqcFRjT2tQVm1Fenk4MkdBenRza09rNWJGWCsxbTFFOEFnWW9mRjhtR2d2?=
 =?utf-8?B?TjhZMFBwOUNLUFpTb291MU9aT3ZObmwrekVYa21BYVN0dTNKTm5wNTAvUlJE?=
 =?utf-8?B?bUxtQWVrNHViQit3T1llblJSMWVQYWwvMk9UcXBLcmFVWmszcTJONFhMdmlz?=
 =?utf-8?B?NE9TZlQ4MEdLSjBPVDNaUUU3Rkc3SDhBVll0cTA2VExNZ3dNWk96dlptTFlJ?=
 =?utf-8?B?QlQ0cUo4TDRPRlgyRVZnUk1IUlBOcVlJUmNxbjlXWXNOblNINm1WTXkxY3Az?=
 =?utf-8?B?NXZZd0E0RTJZOW5HcG1oOUZVT05iVXNRbDJTUjl5OTJuODVMYXpCb2lsUjJq?=
 =?utf-8?B?d0t4bW5FYkxSbzFVMGk1SUNZbWJpaTN0RU1GR3lTRTZPMFMxL0p2bFFySWhS?=
 =?utf-8?B?K080VFdvdzA1NnV6R2d3ZXhLYWdIalFJMHZKTFhQSTFyZGJacFZlYUFWUWt6?=
 =?utf-8?B?WW5XblU4dFRsSDdWaVpJenNPV0Z6R2EzQUEyTk8zV29GaTdqdHZuTnBUREVW?=
 =?utf-8?Q?FYmtcSVzwABA5tfHWoWc2mdhppNU+TG2NH428=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aERUVG12cWVzUTlPSHFsRXFaWGhlazVaWEpzaVBhY2FsenowNFZvUkdtMzFa?=
 =?utf-8?B?NllOSE5lbm1JUDB0ZGZHWEN2NGlkZVFkRGJGMzNxRFdtUGEvbmdPcTljZ0Jk?=
 =?utf-8?B?V0RTVVNlS2R5NS9ES1BNNkREa3lObVFOeExsVTNzbGVISE55Wk1NQldmd1dD?=
 =?utf-8?B?NkVQNy9HRHNVVFEwOTY5OWlQZzY2Z2RvSjdXL2lDTnk3TUg5czFGTjlwODdG?=
 =?utf-8?B?UUVlOUUrdzA0TjF5VDRrNHY2WXVERmhjNU04NkNnWUZ3NG1HYXAvbWcxYldJ?=
 =?utf-8?B?dmJjUHBDc2J1bU54bzNrOWNJVUVGQnlGbUJ2YmgwWWQ4SXFRSXhVOHlsc2Ix?=
 =?utf-8?B?Y0EzNFlLL0s2WC9oYVRHN2lEblpPWDJ2TGg0NzhWZnRCNVdVKzVid3kyRDhn?=
 =?utf-8?B?QTZpM1RGWCt5Y21nVnQvVjhWL3phTkx3bzM0Rk5jcVRRSVd0ZGc3ZzZVNFJx?=
 =?utf-8?B?bnBTTjY2MmZPY3NjWld5aE9WTERDdUhvQW9ZQ1V0TjU0cU9xWUhhMXcrdHpR?=
 =?utf-8?B?QnFpUkR0QXV0Rnd5cG9leUl1MTlaeTNYdmJIUVpwVVViZm5RKzFYWU9lZjBh?=
 =?utf-8?B?QkNYQkJUTk1ybFk0L29nT3FSM0k5aEozVDc2SFd5MEUxYStiZDk2RnZGd2RQ?=
 =?utf-8?B?QWtUODNvOFAxRFozak9Uc0Naek4vRWZtb3dKaGtpK2c0ZFl5TGlXRk16M2lP?=
 =?utf-8?B?TVNKZjNCVGo1Mk11Rk13dlR1NSs1VSsrY2dvc2s4SVE1VzlUY1pzRFNPNmdN?=
 =?utf-8?B?dUlIMG5DQUU1Tmx1QXNSNmJUSHFUVTlESjlGd3BHcXVXRXVQMWM3MUpTMkVr?=
 =?utf-8?B?aVpPUnV4SUI4eDMwVWxqSVVnbUZVeFVmRVhRMWN6Tkx1YzBaeGpvN1Zwdm81?=
 =?utf-8?B?Q0Z3NTBtT3RDRTNIeU9RaHR3UjltbVI5TzhVMWtkcDlhaVdzWm90NTRldENx?=
 =?utf-8?B?Z0hXRmxyQ0lWK09GaXpQVmJzbDBiakYrRlRSa01nZnNhR3R2eFJ6T3lIdWVD?=
 =?utf-8?B?MFZwVjVXZTk5M2o4aWtZR3FMWXRXbGxoR0p3QVV0eVlrNU5Dc2hzRlBpL3VF?=
 =?utf-8?B?VTNuUmxaN01tUC9TcklITXRpZGRCMXlqMWdOdXpqcm96eFMxekJscmhRbDUw?=
 =?utf-8?B?cFhENWcvY1B5aGhmRWpMOWJjRDJkekQyZnJLNU1FMFEyN21YSmpTSHlvSEIz?=
 =?utf-8?B?dmo1QSt0MXR2K0h6TzNqQndYdUZFRzRPcUV0c0hnSkFpYjBLT0s3OXFSWlEx?=
 =?utf-8?B?azgvSnFocWhCNnpxZDBjZXNNSHJ1RDRMaXg1TkkreEJvQldFVUFYQzkwRHFm?=
 =?utf-8?B?dnpjTWJhS3A2cnZ5UE45L0cwZG9qRWVnc1JGbzdIaGRnaWdSMHpqSitYbkdM?=
 =?utf-8?B?TTc1MUVlRC9ab1FDdzdvdU92OVR3S2JsczUybkhJZkRHUzg2MVlRT2V1UWkw?=
 =?utf-8?B?WEc2cGVveUdnUHZoRC9hdWFUdk5VMnpHQXZqNHdhemRMejhQY2p0N2hIZ2pt?=
 =?utf-8?B?dU1xditWaUsza3ZsU1g0eHorT1dYTWFFTnJIcjNQV2g1NFpXRG9wK3FDMDdZ?=
 =?utf-8?B?WCtCSHhsa3VGZHpzOVNickYrTHdmd1V6dmJtUllSTW85bll6Ylg3aWZ3bG5E?=
 =?utf-8?B?NG1OV1hkNVRoSTM0eVcyRHpyYUhLZDA4SWtrTWQ0dUlIS0NEV1c3N3FGcmFp?=
 =?utf-8?B?NEloVE42WnlZKytPMXI1dHhaNTFuR1FPYk1sOUNsRVJyRzBIbTRsZ3lEZ09E?=
 =?utf-8?B?eFg0ZzRHbER0R1VoY1lmaG8vbUN3eGdoVDlDZjdQeFA3ZnlXUWVINW8rUHdm?=
 =?utf-8?B?TEtlRzhvNHpudVEyVnVmdmFZb1Q1S2hhUFN5cEY4cG9VNDN4TUNvN00rWHRk?=
 =?utf-8?B?WlExTW1aUk5SU1VXVlF4VE9ycXpicDM3SndvQ1JXWnFoVEJxVGZvWEpsV1Bi?=
 =?utf-8?B?UXlZNXo0aTdmeU14OW0zL1ZlbXE1NmxvcWtBSXpWSWU5VUtWcEpLY1lyRWtt?=
 =?utf-8?B?RGkrMGJrWmtGZitEMUhOYWFDN1ZYVUVWMkFXWWo2TmN3M0JIaTNKMktIM3ht?=
 =?utf-8?B?RzhtNmpremRtNnkzcWJxU1VoUnR0dUxrMHg2RWlrTm03eEpzNERVWUdLM096?=
 =?utf-8?Q?bM7TqEwAYLxe8I7yUVnlS7Mio?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e94d7ed-fe83-4133-e9c9-08dd02f87240
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 09:00:24.8179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZowlEMK/uvuSTFhUgMToISGLq9wx/Wezub4n29oXxQpYzgdFCZVhIir8lFh893ytM+vjjSPf4Jngz4Xa1ROYeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8924

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEx5pyIMTLml6UgMDoxOA0KPiBUbzogTWFuaXZhbm5h
biBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gQ2M6IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBLcmlzaG5hIENoYWl0YW55YSBDaHVu
ZHJ1DQo+IDxxdWljX2tyaWNoYWlAcXVpY2luYy5jb20+OyBCam9ybiBIZWxnYWFzIDxoZWxnYWFz
QGtlcm5lbC5vcmc+Ow0KPiBqaW5nb29oYW4xQGdtYWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNv
bTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9y
ZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIFBDSTogZHdjOiBDbGVhbiB1cCBzb21lIHVubmVjZXNzYXJ5
IGNvZGVzIGluDQo+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpDQo+IA0KPiBPbiBNb24sIE5vdiAx
MSwgMjAyNCBhdCAxMTowMzoyMkFNICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6
DQo+ID4gT24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMDM6Mjk6MThBTSArMDAwMCwgSG9uZ3hpbmcg
Wmh1IHdyb3RlOg0KPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBG
cm9tOiBLcmlzaG5hIENoYWl0YW55YSBDaHVuZHJ1IDxxdWljX2tyaWNoYWlAcXVpY2luYy5jb20+
DQo+ID4gPiA+IFNlbnQ6IDIwMjTlubQxMeaciDEw5pelIDg6MTANCj4gPiA+ID4gVG86IEJqb3Ju
IEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz47IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA+
ID4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4gPiA+IENjOiBIb25n
eGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+
ID4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGlu
dXguY29tOw0KPiA+ID4gPiByb2JoQGtlcm5lbC5vcmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAu
Y29tPjsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gPiA+ID4ga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIFBDSTogZHdjOiBDbGVh
biB1cCBzb21lIHVubmVjZXNzYXJ5IGNvZGVzDQo+ID4gPiA+IGluDQo+ID4gPiA+IGR3X3BjaWVf
c3VzcGVuZF9ub2lycSgpDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE9uIDEx
LzgvMjAyNCA1OjU0IEFNLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwg
Tm92IDA3LCAyMDI0IGF0IDExOjEzOjM0QU0gKzAwMDAsIE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0K
PiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPj4gT24gVGh1LCBOb3YgMDcsIDIwMjQgYXQgMDQ6NDQ6
NTVQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+ID4+PiBCZWZvcmUgc2VuZGlu
ZyBQTUVfVFVSTl9PRkYsIGRvbid0IHRlc3QgdGhlIExUU1NNIHN0YXQuIFNpbmNlDQo+ID4gPiA+
ID4+PiBpdCdzIHNhZmUgdG8gc2VuZCBQTUVfVFVSTl9PRkYgbWVzc2FnZSByZWdhcmRsZXNzIG9m
IHdoZXRoZXINCj4gPiA+ID4gPj4+IHRoZSBsaW5rIGlzIHVwIG9yIGRvd24uIFNvLCB0aGVyZSB3
b3VsZCBiZSBubyBuZWVkIHRvIHRlc3QgdGhlDQo+ID4gPiA+ID4+PiBMVFNTTSBzdGF0IGJlZm9y
ZSBzZW5kaW5nIFBNRV9UVVJOX09GRiBtZXNzYWdlLg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBX
aGF0IGlzIHRoZSBpbmNlbnRpdmUgdG8gc2VuZCBQTUVfVHVybl9PZmYgd2hlbiBsaW5rIGlzIG5v
dCB1cD8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZXJlJ3Mgbm8gbmVlZCB0byBzZW5kIFBNRV9U
dXJuX09mZiB3aGVuIGxpbmsgaXMgbm90IHVwLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQnV0IGEg
bGluay11cCBjaGVjayBpcyBpbmhlcmVudGx5IHJhY3kgYmVjYXVzZSB0aGUgbGluayBtYXkgZ28N
Cj4gPiA+ID4gPiBkb3duIGJldHdlZW4gdGhlIGNoZWNrIGFuZCB0aGUgUE1FX1R1cm5fT2ZmLiAg
U2luY2UgaXQncw0KPiA+ID4gPiA+IGltcG9zc2libGUgZm9yIHNvZnR3YXJlIHRvIGd1YXJhbnRl
ZSB0aGUgbGluayBpcyB1cCwgdGhlIFJvb3QNCj4gPiA+ID4gPiBQb3J0IHNob3VsZCBiZSBhYmxl
IHRvIHRvbGVyYXRlIGF0dGVtcHRzIHRvIHNlbmQgUE1FX1R1cm5fT2ZmIHdoZW4NCj4gdGhlIGxp
bmsgaXMgZG93bi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIElNTyB0aGVyZSdzIG5vIG5lZWQg
dG8gY2hlY2sgd2hldGhlciB0aGUgbGluayBpcyB1cCwgYW5kDQo+ID4gPiA+ID4gY2hlY2tpbmcg
Z2l2ZXMgdGhlIG1pc2xlYWRpbmcgaW1wcmVzc2lvbiB0aGF0ICJ3ZSBrbm93IHRoZSBsaW5rDQo+
ID4gPiA+ID4gaXMgdXAgYW5kIHRoZXJlZm9yZSBzZW5kaW5nIFBNRV9UdXJuX09mZiBpcyBzYWZl
LiINCj4gPiA+ID4gPg0KPiA+ID4gPiBIaSBCam9ybiwNCj4gPiA+ID4NCj4gPiA+ID4gSSBhZ3Jl
ZSB0aGF0IGxpbmstdXAgY2hlY2sgaXMgcmFjeSBidXQgb25jZSBsaW5rIGlzIHVwIGFuZCBsaW5r
DQo+ID4gPiA+IGhhcyBnb25lIGRvd24gZHVlIHRvIHNvbWUgcmVhc29uIHRoZSBsdHNzbSBzdGF0
ZSB3aWxsIG5vdCBtb3ZlDQo+ID4gPiA+IGRldGVjdCBxdWlldCBvciBkZXRlY3QgYWN0LCBpdCB3
aWxsIGdvIHRvIHByZSBkZXRlY3QgcXVpZXQgKGkuZSB2YWx1ZSAwZiAweDUpLg0KPiA+ID4gPiB3
ZSBjYW4gYXNzdW1lIGlmIHRoZSBsaW5rIGlzIHVwIExUU1NNIHN0YXRlIHdpbGwgZ3JlYXRlciB0
aGFuDQo+ID4gPiA+IGRldGVjdCBhY3QgZXZlbiBpZiB0aGUgbGluayB3YXMgZG93bi4NCj4gPiA+
ID4NCj4gPiA+ID4gLSBLcmlzaG5hIENoYWl0YW55YS4NCj4gPiA+ID4gPj4+IFJlbW92ZSB0aGUg
TDIgcG9sbCB0b28sIGFmdGVyIHRoZSBQTUVfVFVSTl9PRkYgbWVzc2FnZSBpcyBzZW50DQo+IG91
dC4NCj4gPiA+ID4gPj4+IEJlY2F1c2UgdGhlIHJlLWluaXRpYWxpemF0aW9uIHdvdWxkIGJlIGRv
bmUgaW4NCj4gPiA+ID4gPj4+IGR3X3BjaWVfcmVzdW1lX25vaXJxKCkuDQo+ID4gPiA+ID4+DQo+
ID4gPiA+ID4+IEFzIEtyaXNobmEgZXhwbGFpbmVkLCBob3N0IG5lZWRzIHRvIHdhaXQgdW50aWwg
dGhlIGVuZHBvaW50DQo+ID4gPiA+ID4+IGFja3MgdGhlIG1lc3NhZ2UgKGp1c3QgdG8gZ2l2ZSBp
dCBzb21lIHRpbWUgdG8gZG8gY2xlYW51cHMpLg0KPiA+ID4gPiA+PiBUaGVuIG9ubHkgdGhlIGhv
c3QgY2FuIGluaXRpYXRlIEQzQ29sZC4gSXQgbWF0dGVycyB3aGVuIHRoZSBkZXZpY2UNCj4gc3Vw
cG9ydHMgTDIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgaW1wb3J0YW50IHRoaW5nIGhlcmUg
aXMgdG8gYmUgY2xlYXIgYWJvdXQgdGhlICpyZWFzb24qIHRvDQo+ID4gPiA+ID4gcG9sbCBmb3IN
Cj4gPiA+ID4gPiBMMiBhbmQgdGhlICpldmVudCogdGhhdCBtdXN0IHdhaXQgZm9yIEwyLg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gSSBkb24ndCBoYXZlIGFueSBEZXNpZ25XYXJlIHNwZWNzLCBidXQg
d2hlbg0KPiA+ID4gPiA+IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpIHdhaXRzIGZvciBEV19QQ0lF
X0xUU1NNX0wyX0lETEUsIEkgdGhpbmsNCj4gPiA+ID4gPiB3aGF0IHdlJ3JlIGRvaW5nIGlzIHdh
aXRpbmcgZm9yIHRoZSBsaW5rIHRvIGJlIGluIHRoZSBMMi9MMw0KPiA+ID4gPiA+IFJlYWR5IHBz
ZXVkby1zdGF0ZSAoUENJZSByNi4wLCBzZWMgNS4yLCBmaWcgNS0xKS4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEwyIGFuZCBMMyBhcmUgc3RhdGVzIHdoZXJlIG1haW4gcG93ZXIgdG8gdGhlIGRvd25z
dHJlYW0NCj4gPiA+ID4gPiBjb21wb25lbnQgaXMgb2ZmLCBpLmUuLCB0aGUgY29tcG9uZW50IGlz
IGluIEQzY29sZCAocjYuMCwgc2VjDQo+ID4gPiA+ID4gNS4zLjIpLCBzbyB0aGVyZSBpcyBubyBs
aW5rIGluIHRob3NlIHN0YXRlcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBQTUVfVHVybl9P
ZmYgaGFuZHNoYWtlIGlzIHBhcnQgb2YgdGhlIHByb2Nlc3MgdG8gcHV0IHRoZQ0KPiA+ID4gPiA+
IGRvd25zdHJlYW0gY29tcG9uZW50IGluIEQzY29sZC4gIEkgdGhpbmsgdGhlIHJlYXNvbiBmb3Ig
dGhpcw0KPiA+ID4gPiA+IGhhbmRzaGFrZSBpcyB0byBhbGxvdyBhbiBvcmRlcmx5IHNodXRkb3du
IG9mIHRoYXQgY29tcG9uZW50DQo+ID4gPiA+ID4gYmVmb3JlIG1haW4gcG93ZXIgaXMgcmVtb3Zl
ZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoZW4gdGhlIGRvd25zdHJlYW0gY29tcG9uZW50IHJl
Y2VpdmVzIFBNRV9UdXJuX09mZiwgaXQgd2lsbA0KPiA+ID4gPiA+IHN0b3Agc2NoZWR1bGluZyBu
ZXcgVExQcywgYnV0IGl0IG1heSBhbHJlYWR5IGhhdmUgVExQcyBzY2hlZHVsZWQNCj4gPiA+ID4g
PiBidXQgbm90IHlldCBzZW50LiAgSWYgcG93ZXIgd2VyZSByZW1vdmVkIGltbWVkaWF0ZWx5LCB0
aGV5IHdvdWxkDQo+ID4gPiA+ID4gYmUgbG9zdC4gIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0
aGUgbGluayB3aWxsIG5vdCBlbnRlciBMMi9MMw0KPiA+ID4gPiA+IFJlYWR5IHVudGlsIHRoZSBj
b21wb25lbnRzIG9uIGJvdGggZW5kcyBoYXZlIGNvbXBsZXRlZCB3aGF0ZXZlcg0KPiA+ID4gPiA+
IG5lZWRzIHRvIGJlIGRvbmUgd2l0aCB0aG9zZSBUTFBzLiAgKFRoaXMgaXMgYmFzZWQgb24gdGhl
IEwyL0wzDQo+ID4gPiA+ID4gZGlzY3Vzc2lvbiBpbiB0aGUgTWluZHNoYXJlIFBDSWUgYm9vazsg
SSBoYXZlbid0IGZvdW5kIGNsZWFyDQo+ID4gPiA+ID4gc3BlYyBjaXRhdGlvbnMgZm9yIGFsbCBv
ZiBpdC4pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIHRoaW5rIHdhaXRpbmcgZm9yIEwyL0wzIFJl
YWR5IGlzIHRvIGtlZXAgdXMgZnJvbSB0dXJuaW5nIG9mZg0KPiA+ID4gPiA+IG1haW4gcG93ZXIg
d2hlbiB0aGUgY29tcG9uZW50cyBhcmUgc3RpbGwgdHJ5aW5nIHRvIGRpc3Bvc2Ugb2YgdGhvc2UN
Cj4gVExQcy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIEkgdGhpbmsgZXZlcnkgY29udHJvbGxl
ciB0aGF0IHR1cm5zIG9mZiBtYWluIHBvd2VyIG5lZWRzIHRvDQo+ID4gPiA+ID4gd2FpdCBmb3Ig
TDIvTDMgUmVhZHkuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGVyZSdzIGFsc28gYSByZXF1aXJl
bWVudCB0aGF0IHNvZnR3YXJlIHdhaXQgYXQgbGVhc3QgMTAwIG5zDQo+ID4gPiA+ID4gYWZ0ZXIN
Cj4gPiA+ID4gPiBMMi9MMyBSZWFkeSBiZWZvcmUgdHVybmluZyBvZmYgcmVmY2xvY2sgYW5kIG1h
aW4gcG93ZXIgKHNlYw0KPiA+ID4gPiA+IDUuMy4zLjIuMSkuDQo+ID4gPiBUaGFua3MgZm9yIHRo
ZSBjb21tZW50cy4NCj4gPiA+IFNvLCB0aGUgTDIgcG9sbCBpcyBiZXR0ZXIga2VwdCwgc2luY2Ug
UENJZSByNi4wLCBzZWMgNS4zLjMuMi4xIGFsc28NCj4gPiA+IHJlY29tbWVuZHMgIDFtcyB0byAx
MG1zIHRpbWVvdXQgdG8gY2hlY2sgTDIgcmVhZHkgb3Igbm90Lg0KPiA+ID4gVGhlIHYyIG9mIHRo
aXMgcGF0Y2ggd291bGQgb25seSByZW1vdmUgdGhlIExUU1NNIHN0YXQgY2hlY2sgd2hlbg0KPiA+
ID4gaXNzdWUgIHRoZSBQTUVfVFVSTl9PRkYgbWVzc2FnZSBpZiB0aGVyZSBhcmUgbm8gZnVydGhl
ciBjb21tZW50cy4NCj4gPiA+DQo+ID4NCj4gPiBJZiB5b3UgdW5jb25kaXRpb25hbGx5IHNlbmQg
UE1FX1R1cm5fT2ZmIG1lc3NhZ2UsIHRoZW4geW91J2QgZW5kIHVwDQo+ID4gcG9sbGluZyBmb3IN
Cj4gPiBMMjMgUmVhZHksIHdoaWNoIG1heSByZXN1bHQgaW4gYSB0aW1lb3V0IGFuZCB1c2VycyB3
aWxsIHNlZSB0aGUgZXJyb3INCj4gbWVzc2FnZS4NCj4gPiBUaGlzIGlzIG15IGNvbmNlcm4uDQo+
IA0KPiBZZXMsIG1heSB3ZSBjYW4gY2hlY2sgaWYgZW50cnkgTDIgb3IgbGluayBkb3duLCBzbyBu
byBzdWNoIG1lc3NhZ2UgcHJpbnQgZm9yDQo+IGxpbmsgZG93biBjYXNlLg0KPg0KQXQgdGhlIEwy
L0wzIFJlYWR5IHdhaXQgbW9tZW50LCB0aGUgbGluayBzaG91bGQgYmUgc3RpbGwgdXAgc3RhdCwg
cmlnaHQ/DQpCZWZvcmUgZHVtcCB0aGUgZXJyb3IgbWVzc2FnZSwgaG93IGFib3V0IHRvIGNoZWNr
IGxpbmsgaXMgdXAgb3Igbm90IGxpa2UgdGhpczoNCiAgICAgICAgICAgICAgICByZXQgPSByZWFk
X3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLCB2YWwgPT0gRFdfUENJRV9MVFNT
TV9MMl9JRExFLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSUVf
UE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQotICAgICAg
ICAgICAgICAgaWYgKHJldCkgew0KKyAgICAgICAgICAgICAgIGlmIChyZXQgJiYgZHdfcGNpZV9s
aW5rX3VwKHBjaSkpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIocGNpLT5kZXYs
ICJUaW1lb3V0IHdhaXRpbmcgZm9yIEwyIGVudHJ5ISBMVFNTTTogMHgleFxuIiwgdmFsKTsNCiAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICAgICAgICAgICAgICAgfQ0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gRnJhbmsNCj4gDQo+ID4NCj4gPiAtIE1hbmkN
Cj4gPg0KPiA+IC0tDQo+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCu
muCuv+CuteCuruCvjQ0K

