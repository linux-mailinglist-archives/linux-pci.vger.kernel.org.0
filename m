Return-Path: <linux-pci+bounces-32996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A4B13528
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3308B16A8C6
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276BD19ADBA;
	Mon, 28 Jul 2025 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="idPFfDjk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1800.securemx.jp [210.130.202.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10682C18A;
	Mon, 28 Jul 2025 06:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.159
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685822; cv=fail; b=OQrqd8dtm9qq1IKIUzwnrRpVQvHSG3CcJIohh5y/YpX3SgRV3kBF1tUidkRcCCOZeCK5j4kQoV0CXtEXoJJEVs14Y76ag4DUhjTL2Q7d48jsG3BnXKoNm88fI2yswRhmQjfbYb3otANNxTyDm7/Z0d+KRgp+82/YPqD7pB4hGW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685822; c=relaxed/simple;
	bh=DWKaBXUt7zDXUtbDu6oSoOgx6gTQdxz8LYUTat4Bhts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWhc2hFEOZXge/jzxkuXAjAKiCOs/0MdugsdhznLtvsnZFyXakRo1clWKlNTTt85xxloOttiIkww6Fl/9zcvW2QdonQ+3pkq7TzXpOC3KtGvqRX7eLBpE2ydtn1pibLseobBdqhcNLEk0ivviq2iwBNkogjdXGoehf5lHnLpUd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=idPFfDjk; arc=fail smtp.client-ip=210.130.202.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1800) id 56S5d7Ro1785090; Mon, 28 Jul 2025 14:39:07 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1753681110;x=1754890710;bh=DWKaBXUt7zDXUtbDu6oSoOgx6gTQdxz8LYUTat4
	Bhts=;b=idPFfDjkp0eoNweBtjTR3dJv2RQF2Yvd6VZy+L3QltK758CsYa3i/VC47HuYMu8bzcjuS
	0iFXHLuHUE2jFJZMwZCyKdg9oQqMSwlk9sM2PqDYdwt4GeFfIuFkL7VHC5HFS7UDBhgM68ufW3qQL
	/Y4X9iX3jJI3b+RcLQ4WusETFP+s7daz+fWLuewgT2bcRsEzKc9ovD0hl3z1Z+e/q+g/81yaWhO6A
	1+RdDXd/I9X7hMqyf5rFvjDX+3q/GFwuStDsHvLVVWIxxLn7nSlXNdh5FNh9M7GyOsYhFyxs/sy7u
	kEv87RGwg+qTi5L9IBZktcsOVYnn6vSpSLQEO4bAlg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56S5cTbX226634; Mon, 28 Jul 2025 14:38:29 +0900
X-Iguazu-Qid: 2yAbRDIdy6MTg7ph6D
X-Iguazu-QSIG: v=2; s=0; t=1753681109; q=2yAbRDIdy6MTg7ph6D; m=GJ+dZSO/tOlujPndteSADcEzCgnsqgSXt/RujxNg1J8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 56S5cSBp486790
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 14:38:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkao38c4iFnxt9EUGLRhd8o2XlEyMBp+jLyVGIdXvHvbE1AtJ0js1quDixVS//wsxNCkWDOt1TN1oRdJXbKha08a4dryQHw09m7OGWOyEMAMLQbRschk67UcjhdJnl23ePVL98JR2cxkPSPPu+qVCGlsFwmhXmVzbrVIV+FljNxMsaIvzfLQYB76sX83ldWnFznlZf9Y/A8esPutbmSJJDvBjy6Qsa7fjLeS+wyMofBZkUKuRgrCwVqF9YggnOhSXFf4B0O+6wFyv+bZTPq4yVGGH98EA2PZuBc+trkM7w90n8cVSq4xdeLz/nuU62QCbhQo4SBWtBxMDZgfVCiUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWKaBXUt7zDXUtbDu6oSoOgx6gTQdxz8LYUTat4Bhts=;
 b=uPT+VT36SBrJPLV1T7fd4yRoljdR+h5HgdtyVs75Mj89dcjPx2zchpFHoqY35DaL+H8nQfrqOwxk/IbUvLmLLscPodAXPBz4OXpPQiiFwIa1PpcFexaBqVhJjZFJa5dC2eSewlUT/Fbfj7QyL6V9akEWA5fbLc0hmFNAIW/YQtVw7PhWD5mzAVd9wW4JAAi4o37gh610YSgYs5mc3yH45hNO5yzORsr0yUFYGxCCCQUOszqgVZ9YHPj/rBNkQnHk7uhU6ffKb5yE3zTKyXWRNOkr6EUJjGaAIK8kr0cpp96mAz4WvIwjQMPK9ZgSQ7TBaXtyVbcqsHwUlvpS+f3FCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <bhelgaas@google.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Thread-Topic: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Thread-Index: AQHb3Kr5i8C+P9vwEUaoXxVDSYttMbRHLc+w
Date: Mon, 28 Jul 2025 05:38:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481875AD0293961D0DB8738E925AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
 <20250613-tmpv-v1-1-4023aa386d17@nxp.com>
In-Reply-To: <20250613-tmpv-v1-1-4023aa386d17@nxp.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSOPR01MB12313:EE_
x-ms-office365-filtering-correlation-id: d68d33b4-e5d8-4bf1-cc0e-08ddcd98f958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OVJJWXZaUnFNdXlZdnJKMU1WdFIxelhzNk9MTGZDWVFSaTVJdXlsYUdJV1ll?=
 =?utf-8?B?a1dWNkYyZDBsYlFZaFRKaFdSZ1BsR2NQOFQrK1hGVWZkY1VLQy91V3lvNGtO?=
 =?utf-8?B?bDNEU0VYeGJnSmhrbXlRcDhTL1Qyc3dzRGU2cjcwL2QvdVFHcElBZlI1Z003?=
 =?utf-8?B?c0xYVlRrN2ppcHBreDZIODF5VmNKczJrTnhQaGFOR1ZtQnhzNE1mVW9qOEh0?=
 =?utf-8?B?TXVOZWJRZUIzTER1UXJ5Y0dBcC91cVMvN3V1Q0JQWlZSL1RvY3JMOFV4RzNG?=
 =?utf-8?B?bW9mNlg3OHFHS0tMYlE5dTlFeERtMStWVlJWSFVhbkpBY1pzSytMVnRVRENI?=
 =?utf-8?B?dWxqRFpKeVRHek80a2lyVnJaRURBMUlaRzVjSVRjMHo0Uk9TdHZmWVJ6YnNG?=
 =?utf-8?B?ZjRiNG9wditGYzF2VEswdUI5SFZVVyt1Y21jQnZMM0FPREZCN20wUUJDbTRX?=
 =?utf-8?B?ZjBrUzF4ZDdCVzNpZU1GcFkwbEpueFd4WTU2QTFxTWpuUlJjaVZqRVY2b2xT?=
 =?utf-8?B?emc4RktNSE5uTmxkUW9HNmJrcUFnTjZvTm9ReU9tY0tia05qTUNIVlFKYk5T?=
 =?utf-8?B?R2ljMVB2QTJJZFdyVFV5dWhtWVdIVENXb1FGanZZRk5GdVEwQzJoa21NNzNw?=
 =?utf-8?B?QklRQVh6dUxGYzcyZjY3dTFJdkVmVVNRZDcrcjlPejVvdnpWdGJVT29Vc3Bp?=
 =?utf-8?B?emJhNGVWWVRKbVdHM3g0azh0NGFSZlYxV09Wd0F1U291MHQxbW85cFEwUncz?=
 =?utf-8?B?M1JkK2cwRGRyRWRlUmFKdzRDWDRFNCt4cldzWHZRWGtnWTZtckllSjJBYzdC?=
 =?utf-8?B?YU1zUVBQRkVDcmJuaDRjT01HTGNNcTFKSHVCNkN5alVsa2I3ak8rNHljZi9y?=
 =?utf-8?B?d0wzQUppRVR2U2pkWmlObHhucGlIRkZ1OHdKc0xBanF2NUxFby96TkdGSy9s?=
 =?utf-8?B?emZseGNCUmlzaGZ1ekZ1dE1DRmZESGhSUXdTb1J3ZUtIMmpXaEphUkpBUUZT?=
 =?utf-8?B?SkZ3bG5UMHVKMlpUWnhnQk1RbzVnWkYyR2ZpSGtsb1FNbXQxVHlUcW1Dc0Yy?=
 =?utf-8?B?Q0doUW1FU0lrdzZ6ZUppbHdlZGdLOWt2b3g2Vm53aG14REs1VzFtRVVObko0?=
 =?utf-8?B?WnhUUmMxN284c2s1em5oRmxzM1J5NmcwK2JrWk4zcnRKZnRTQXc5ZUI4Z3RT?=
 =?utf-8?B?eGJxZVBkMk9NMGtPWGdQRlZkVDBDRU5iRGd5RlFaa1FmVGFjQkxYQ09oTWIz?=
 =?utf-8?B?SDUvUkZTOVRSZjJONm5aMFhkQTRvbW52UDdhVytwZk9JUmREVVdhZDA4Y0ZD?=
 =?utf-8?B?SFBpWnlQL2JaMzNBNjdXQlYzV3JFN205T29OMERjbk8xVGx5OHE0cjZFaUtV?=
 =?utf-8?B?aThpZm9UL2R5dWdqaEZRcmk3YUdsOFA4WktyR0lqaXFVTHl2ZXdGRndkQmhP?=
 =?utf-8?B?SVo0cmNyQ0RXcHR0T0g4YWdWamM0SjFzRlhxSnhxSWZYTHRzTFpTTUFMV2Y1?=
 =?utf-8?B?dGVZN216aHkwNzRYcENDQTRRZDVxWWhQMlB2eWszdTVMMWl1WEpNaXVKTEQw?=
 =?utf-8?B?NnhFY0pPWkR5a1dXNXF4Tnp5WFhxMEFyUUVSeDRVME44TGltOTAvZkdWVDlZ?=
 =?utf-8?B?MVdCaGErUWFRZ25FdmxiUHBGVkV0NnM4Tm9HdEtuNUc2MWNlUVhhZWtSZ2hy?=
 =?utf-8?B?NXhVeDRmM0YvSzk3L0ZuaUs3NXEvSkN3NXVSNG5UczMxTW1MczVxV2pFOEVQ?=
 =?utf-8?B?YXZFRDcyZ1NSMGVqdFRJYTdBMUJrT0N3b1JicVZESUJtbVc5VmRmWXBLMHRZ?=
 =?utf-8?B?RXozWWVZV2o2Nmt3NFBhcGR3Q09EbkZyN3YzWStLdHlpeW1HbFJhSG8zL0d6?=
 =?utf-8?B?d3VpVExneFdYSTd6ZjVaakRLbjJ6akVQbnN0blF5QVFCSFNWZ05HMzRGQXg3?=
 =?utf-8?B?REdicnlMM1h5MkdmSHRkeGtLYVhHcm5EejJwQVNNcVJCZnFRWkxsR2tXNjVh?=
 =?utf-8?B?dVVkSmR5TGRBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RHIwUXpORzhaS1RhK1g4REZYbk4xVjgwbTF1YVFCOTVFMWhtQ1o5eTE0QXMw?=
 =?utf-8?B?NHZCN3BUbGFrYlVUcHBnYnA2SjBkSTYrdmp1RDI0U3BMOEJBNEpjdlRXV3Rh?=
 =?utf-8?B?dkRkMWMwZ1AvdVlnR1JHbXVUVmpFd1VsYWJtYjF1cEQwU1ZMY203dlpCM3VN?=
 =?utf-8?B?Sm1MWjNaTWhBMzVzMkFMcXFKUXZHOXlWbDR6NTd1SUFTQ1VobVpQdFFiNFVs?=
 =?utf-8?B?ZFljZkpsZnh5SGdMS2lIcGRWdWFrVFA4amF6ek9TaXBWVU5NLzJmOFZtaXdW?=
 =?utf-8?B?NE5BMXA4N3Z3dDBFQi8yaG9LUTBrenVWdVhZV2dmYmFrZ29aY3FuQ3hSOFUw?=
 =?utf-8?B?SXBBb0VzNkszdEhqSkdXWXQ4LzBEKy9DQVNBMTRvNjEyc2dFM0ZHOSttRGN6?=
 =?utf-8?B?N0hZVm1nMHZxRHhVdStkUFhuemUxaDBHOHl1YlM2eEFCcFVwNlhydVJlS0Q0?=
 =?utf-8?B?RHJFeWs0S1lUSzBSdUhjV2MyYlhlbE4xa21zOHIwR1lTM2tvaXd6SW0zaVlH?=
 =?utf-8?B?ZHZLNmpiVklrMzNkcUprU2tIYXdQa2NYQ1hQeVA1ZHV6WGlGVXJJdGhCbmdH?=
 =?utf-8?B?VjlQeFArRnBXS2FjajV0YW5qcDVCL3J0bVladjJqeWdZcE5iVFNvRGVVWnVp?=
 =?utf-8?B?dHNtaHBHLzNDeDVTZnZkUnVxajBsbDlHdHVCTXRNRFRma0JtVnhyMzZNWndl?=
 =?utf-8?B?cEM2bXhieXZHVlkyR1cvNnluLzlpUGxGSzRsTmxiZzRCV2xMU1hNeWx0Mzl3?=
 =?utf-8?B?UFhtRmE2cklGSElSYkZaRVZDbnVmZjM5RnYrU29LYzVRaEdhUlhFSGNPUnhq?=
 =?utf-8?B?RWxybGUxL21uUjYzYkhZblpCUW9VWVNVbk5teFRESlU3QzZ0a3FPZGFwWDNY?=
 =?utf-8?B?MmhlYWQ1cUpwTGdBaHM5eVAybVBiZ2hyTjAvNkd5Zzl1bWtJTzU5Z1Q5Z2dj?=
 =?utf-8?B?dG44SXdzNUtWTTQzQ2NzSWJaVVhmZXVtTTFkMm5mQ3JVcDZIWllSWmJPSjBv?=
 =?utf-8?B?QXdNNTkzclhRS2JCVEMrcjlpYXIyeU1NWTRZUEZ6OWJ2eElYdlVVSG1DaUtx?=
 =?utf-8?B?a0RyTHo5WCtYQVdpMmR5RC9NQmhnUFdJU3dFNTNneFJCSGFoMmlrdVdGSkdL?=
 =?utf-8?B?bENzU2ZqR1drU3BJNFBLdUZHYzZ2dm1VTGRFdGg3V3hleVJadWhTQW1YRVBm?=
 =?utf-8?B?dkNMNXBwS0x2ejdLcWd3V05qSDM0SEovS1RJaDVjNFM1T2JyZVNwYlJXS0pL?=
 =?utf-8?B?MThLcms1UzRlNVR1amhMcFgzVjZuQ0txMmZMa21lcy92RnIvMU5VNStxVWxV?=
 =?utf-8?B?TmZNVlA2OE0wMVltVncwTVFFcURRR29kcCtoMTBUVFdjVUlvVFR1SXp1ZGYy?=
 =?utf-8?B?MmtXejdTNFhMOXBHY3FiSUJWZkhCK2VGZVdLTDllbEk1amdlTmtYdGplUUZD?=
 =?utf-8?B?WXFqSHdTTUtrR1hkdlVpUXIzT3NYd3JJK3lSRUV3a2dQSktERTBFbU1nbndY?=
 =?utf-8?B?WlZjVmRQc2xUb3UyYzB5WlRTeHdNRFZxMTdxeDRGaGs2eERFY2JFOExXMXlx?=
 =?utf-8?B?SjRyWk9NMU83RFZtbGNhcXUzS1dMZTFCVW1ETnRKNExISjBWQndtT1Zxb1Vw?=
 =?utf-8?B?ZGtwQWRPdlpTYWh4K3NtR3hjKzJwNTBFUitEQWRMbFREREF3cHRrWHZ2ZGpK?=
 =?utf-8?B?WjB5Y2hOK2tWa2FNTzRSZXAvU1dzOFllMHBHNXJFMUJ5c1pGeG1FTUlKTjV1?=
 =?utf-8?B?UEZoNVVFZi9uT0pFSnorSGMxV1EwdHFrM29LTlkyNjFQRWtrcTFpVTlMR1NU?=
 =?utf-8?B?QTNLL2V1b1hNZkVTM0JSbSs1RDR0WXl3dDJLRDVROEZrVlRyVHNsRTdUWFFm?=
 =?utf-8?B?cHRpNldSSFRzR2Z1SVRRQ2Vtb0FONWJyUCs0ajErRzkvMEZsOW5DaTdyN0FD?=
 =?utf-8?B?bU5HVXdvQVNrUzBCb2MyRy9kTWNyWlRyRW8xOXU4dHdwaU1nS2o3UWVCN0tW?=
 =?utf-8?B?NlJKMnB4OFU0VjBrRUt1UVVUbUp4bXZ4MUNkcTdEeDNnUk94NTJocTh0Zk04?=
 =?utf-8?B?eG9XS2pzMzlySGFqcFJLckM3aUM1VjZKei9FUC8rd3o0UnlqaHlWaVRuMkNZ?=
 =?utf-8?B?UVNkQ1MrWklma0dwTGp6MGVTeXlHQlAxb1VsSXZYTERWbHlUdGcwRzg5SjNv?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68d33b4-e5d8-4bf1-cc0e-08ddcd98f958
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 05:38:25.8414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scN+dzzjYQ6gmFs3YpWD6CYXepC0etqHC2VsJ4fozyubDqPtoQUa7YozCkJtRIHzaU/kmYiwhP97bENfcWaeQoAk6iQ6BE+RQ4831kFw8XCliqJhR5VwTTlaT97P68nn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12313

SGkgRnJhbmssDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaCwgYW5kIHNvcnJ5IHJlcGx5IHdhcyB0
b28gbGF0ZS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMTQsIDIwMjUgNjoz
MyBBTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvKTvvKnvvLTv
vKPil4vvvKPvvLDvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
K2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBM
b3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IFdp
bGN6ecWEc2tpIDxrd2lsY3p5bnNraUBrZXJuZWwub3JnPjsgTWFuaXZhbm5hbiBTYWRoYXNpdmFt
DQo+IDxtYW5pQGtlcm5lbC5vcmc+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29t
Pg0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgRnJhbmsgTGkNCj4gPEZyYW5rLkxpQG54cC5jb20+DQo+IFN1
YmplY3Q6IFtQQVRDSCBSRlQgMS8yXSBhcm02NDogZHRzOiB0b3NoaWJhOiBVcGRhdGUgU29DIGFu
ZCBQQ0llIHJhbmdlcyB0bw0KPiByZWZsZWN0IGhhcmR3YXJlIGJlaGF2aW9yDQo+IA0KPiB0bXB2
NzcwOCB0cmltIGFkZHJlc3MgYml0WzMxOjMwXSBpbiB0bXB2NzcwOCBiZWZvcmUgcGFzc2luZyB0
byB0aGUgUENJZQ0KPiBjb250cm9sbGVyLiBTbyBhZGQgYSAncmFuZ2VzJyBlbnRyeSB1bmRlciB0
aGUgcGFyZW50IGJ1cyAnc29jJyB0byBtYXAgYWRkcmVzcyAweDANCj4gdG8gMHg0MDAwMDAwMC4N
Cj4gDQo+IFVwZGF0ZSB0aGUgUENJZSBub2RlJ3MgJ2NvbmZpZycgYW5kICdyYW5nZXMnIHByb3Bl
cnRpZXMgdG8gdXNlIHRoZSByZWFsIHVwc3RyZWFtDQo+IGJ1cyBhZGRyZXNzLg0KPiANCj4gRW5z
dXJlIHRoZXJlIGlzIG5vIGZ1bmN0aW9uYWwgaW1wYWN0IG9uIHRoZSBmaW5hbCBhZGRyZXNzIHRy
YW5zbGF0aW9uIHJlc3VsdC4NCj4gDQo+IFByZXBhcmUgZm9yIHRoZSByZW1vdmFsIG9mIHRoZSBk
cml2ZXLigJlzIGNwdV9hZGRyX2ZpeHVwKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBM
aSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hp
YmEvdG1wdjc3MDguZHRzaSB8IDE2ICsrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvdG9zaGliYS90bXB2NzcwOC5kdHNpDQo+IGIvYXJjaC9hcm02NC9i
b290L2R0cy90b3NoaWJhL3RtcHY3NzA4LmR0c2kNCj4gaW5kZXggMzk4MDZmMGFlNTEzMy4uMmEx
OGFhOTNkNDcyMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy90b3NoaWJhL3Rt
cHY3NzA4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy90b3NoaWJhL3RtcHY3NzA4
LmR0c2kNCj4gQEAgLTE0Nyw3ICsxNDcsMTUgQEAgc29jIHsNCj4gIAkJI3NpemUtY2VsbHMgPSA8
Mj47DQo+ICAJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQo+ICAJCWludGVycnVwdC1wYXJl
bnQgPSA8JmdpYz47DQo+IC0JCXJhbmdlczsNCj4gKwkJcmFuZ2VzID0gLyogcmVnaXN0ZXIgMTox
IG1hcCAqLw0KPiArCQkJIDwweDAgMHgyNDAwMDAwMCAweDAgMHgyNDAwMDAwMCAweDAgMHgxMDAw
MDAwMD4sDQo+ICsJCQkgLyoNCj4gKwkJCSAgKiBidXMgZmFicmljIG1hc2sgYWRkcmVzcyBiaXQg
MzAgYW5kIDMxIHRvIDANCj4gKwkJCSAgKiBiZWZvcmUgc2VuZCB0byBQQ0llIGNvbnRyb2xsZXIu
DQo+ICsJCQkgICoNCj4gKwkJCSAgKiBQQ0llIG1hcCBhZGRyZXNzIDAgdG8gY3B1J3MgMHg0MDAw
MDAwMA0KPiArCQkJICAqLw0KPiArCQkJIDwweDAgMHgwMDAwMDAwMCAweDAgMHg0MDAwMDAwMCAw
eDAgMHg0MDAwMDAwMD47DQo+IA0KPiAgCQlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDI0MDAx
MDAwIHsNCj4gIAkJCWNvbXBhdGlibGUgPSAiYXJtLGdpYy00MDAiOw0KPiBAQCAtNDgxLDcgKzQ4
OSw3IEBAIHB3bTogcHdtQDI0MWMwMDAwIHsNCj4gIAkJcGNpZTogcGNpZUAyODQwMDAwMCB7DQo+
ICAJCQljb21wYXRpYmxlID0gInRvc2hpYmEsdmlzY29udGktcGNpZSI7DQo+ICAJCQlyZWcgPSA8
MHgwIDB4Mjg0MDAwMDAgMHgwIDB4MDA0MDAwMDA+LA0KPiAtCQkJICAgICAgPDB4MCAweDcwMDAw
MDAwIDB4MCAweDEwMDAwMDAwPiwNCj4gKwkJCSAgICAgIDwweDAgMHgzMDAwMDAwMCAweDAgMHgx
MDAwMDAwMD4sDQoNCklmIG15IHVuZGVyc3RhbmRpbmcgaXMgY29ycmVjdCwgdGhpcyBzZXR0aW5n
IGNvbmZsaWN0cyB3aXRoIHRoZSBhZGRyZXNzIHNwYWNlIHRoaXMgcGF0Y2ggY2hhbmdlZA0KcmFu
Z2VzIGFib3ZlLiBUaGVyZWZvcmUsIGl0IGRvZXMgbm90IHdvcmsuDQoNCjB4MjQwMDAwMDAgKyAw
eDEwMDAwMDAwID4gMHgzMDAwMDAwMA0KDQpCeSByZWR1Y2luZyAweDEwMDAwMDAwIHRvIDB4YzAw
MDAwMCwgaXQgd2lsbCBmaXQgd2l0aGluIHRoZSAweDMwMDAwMDAwIHJhbmdlLiAgDQpBbmQgYnkg
YWRkaW5nIHRoZSBmb2xsb3dpbmcgdG8gdGhlIGRyaXZlcjoNCmBgYCAgDQpwY2ktPnVzZV9wYXJl
bnRfZHRfcmFuZ2VzID0gdHJ1ZTsgIA0KYGBgDQoNCnRoZSBQQ0llIHdpbGwgd29yaywgYnV0IHRo
aXMgc2V0dGluZyBwcmV2ZW50cyBhY2Nlc3MgdG8gZGV2aWNlcyBsb2NhdGVkIGFmdGVyIDB4MzAw
MDAwMDAuDQpJcyB0aGVyZSBhbnkgb3RoZXIgRFQgbWV0aG9kIHRvIGF2b2lkIHRoaXM/DQoNCkJl
c3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==


