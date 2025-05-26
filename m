Return-Path: <linux-pci+bounces-28394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F1AC377B
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 02:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92293170D27
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 00:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870D62260C;
	Mon, 26 May 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V5LTurbb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JMhRRvik"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D2367;
	Mon, 26 May 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748220474; cv=fail; b=NebXW93jUd+NSdUgLsT9nJqlWPNP/SKDsmyXm2NbBbNvQROB9VcgZ0MBVQcEXb1h8eJb2fcHw1vipQZGZX41MFN55qUrnsDcDVF7cp/wuCI2s9jgJs6kin6Srp5ROvjxQHlY45Pn9SnIUnn4Jzglm844IXzYOCp0qyCS520SJFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748220474; c=relaxed/simple;
	bh=HK2tuQC2DuamkPMnSF0IKvYZKPG7n1eVqYiLgcLJSBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSz/s7nWvi1OBNceGaObjESpT0quLneQkB/jfkcaMMEGCvB9SF8/LeIUMqKPEs4TXqRfuvd/o0wfo2uMH75e1LLcs6IlJFDMlsuMpgdQLbTZ6SZK3fPtftSeECBuQ2aqzLwb5IQY3KbU+yUPRz8+EB3dktConEqPJAZXESWxzuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V5LTurbb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JMhRRvik; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748220472; x=1779756472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HK2tuQC2DuamkPMnSF0IKvYZKPG7n1eVqYiLgcLJSBE=;
  b=V5LTurbbVY54TaOB63ACA65ItfzX/zz59RN/N4lizHjeH3mfe6F6uCYS
   /5WhakAYQESOA0h9WilTr1erLaK3IxzGwASoNV/w66WPku8Db89ZaY1Vn
   sWXR9Gb5lBF6fEgs3nF2f/8b60xnhOy4l57RoYEOw/hT9+Ty9KYAYlPog
   OdqbNLb7fWRaZduIyChcrzJYfr2ue8Ss5+uBlv8mbnMOOAqewUR2LW3KT
   z+IqpUg5V+213jL/ixORmObZRehwb20DVNFbaTOJwjBR6YxP1slhpfT4B
   sy9JoZg6xBRes6sNk22+LIpcCI/a/NBfLFaQb0Z1M0aQoMGw2NLofDOCd
   g==;
X-CSE-ConnectionGUID: V/+o3c3BTc2cCSCLW0LbsQ==
X-CSE-MsgGUID: fsxVCPISTWqXpwk+0esRNQ==
X-IronPort-AV: E=Sophos;i="6.15,314,1739808000"; 
   d="scan'208";a="87980271"
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.67])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2025 08:47:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJop6vDDIoxdobA94NjPtORceJ5rjKIBjsY0TZD3fpxT2sa/binoI7ruT9L9xY1/JcHONGAg4JbMvEpSwKiERL8N/0SBHuCl6DXkHlK3O6GlRsKS/q5XK8s5TNXsZk9wYiK+rX9R/ykiigWdclOHRCv7XY9n+JFAYkAgZx6u5U/WGWTgAwEWxCpnNtqYw8e9tkQ1N6jepQME9u+fMqFletINL1BygLGJ5UpKFic/nQhJ/61POypkrYBX/Q7zoONNUWCduUc4+t3fks/ueyOx+UKOC5Ek/46oByZL7vQ5LLwk40SJSjMRoUu83qxBvfeHEyr8XqdHoYC9A3xR9QIqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK2tuQC2DuamkPMnSF0IKvYZKPG7n1eVqYiLgcLJSBE=;
 b=pYVQtZeubnIkSG2MaFGXsGjKBz/XK/itkVMTSUropgnSXu/tqT7bovvecPxitMC1BDRieTH9i3Z2h8BI/sHW/KF4pHWjKK48JfU0i5w6JO8h3MfDjWKnE1bC/1rmL3JppF1cWe3G45MEBqzMJ0vDp7BSFYJJ7yCXq01n2CVVSNioXSTVSZgdnmaXatjgsQG5lNF8fhChunZy5GzbefaS50WVAAEhxKdC/kSfy3MOWV2JF3JTH5jwQay4nW/HeQHEjTr7pDgE9V+UUD6r52S/Oo7nflqulDtMPtYKz9ReorQmzPd4RnVe5gR8puU94+vZmA39Wjg57F38e7Wx7gCXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK2tuQC2DuamkPMnSF0IKvYZKPG7n1eVqYiLgcLJSBE=;
 b=JMhRRviksNf+COeqnpDiBSjRcHKra3WfwxlYfw5XRfTPm3FCO7IW9UNWqJgfn7xfP8weKmTi404LDjya8m5QmcIfTHc2nCYR8NUZn8c+VFxWH9pudfXuC7/Zn1u3ZJtZEYUj+d4TErH6DdGKPWkcFUMw5ja1q0QK1WYOqef7lLw=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by BY5PR04MB6899.namprd04.prod.outlook.com (2603:10b6:a03:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 26 May
 2025 00:47:43 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%5]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 00:47:43 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: Slot reset fixes
Thread-Topic: [PATCH 0/2] PCI: Slot reset fixes
Thread-Index: AQHbzN0d0tAfVwiqN0yoLeXwUHRh8LPkFdgA
Date: Mon, 26 May 2025 00:47:43 +0000
Message-ID: <392b4454bd965db1717776635ad2a0dcd6ec7463.camel@wdc.com>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|BY5PR04MB6899:EE_
x-ms-office365-filtering-correlation-id: 677f7e56-d25b-4a06-0c1c-08dd9beeecb5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2ZJN0ZjZlgyOThTWkZueVNEd1FOYmV0YmJ3NXNmUk03YndCWVh3YXlNNXJQ?=
 =?utf-8?B?UldFQVRHYXUwN1ZUNzgwMFJjYk5uck5tYnVnQzdvRXZyWHZZSUJBdWJpWm1T?=
 =?utf-8?B?akhSdFB0RUlpdkZyb3ljbUM1ZTlUWmRvcjdGOFcvd1ovTmVwelBVdmZ5RkFy?=
 =?utf-8?B?d2wrR3p4MWJoSVRYeTdlME92NlBNR1lLWEdQUloycDM0OEFTMks2d09BTjd4?=
 =?utf-8?B?K2NMTUVidDdoaDZydjdwNWg5aVZxRkZXMHgyaFpudCtXZzMydnREdTV5bVJT?=
 =?utf-8?B?SFRSVnB3aWVOdTQ0VTJPNmNjQnNTSWhHRitvcDc0VHdXamxkVFdOOHo5RHZF?=
 =?utf-8?B?Z0Z2VUUrOXRTZ1h0dDNucGQvTjJMSWZpek54azJROGN5YWV4MkZpUmZvalUz?=
 =?utf-8?B?K0VFU3BtMTVieGkybkpycWVrRVBQWCt0cCtuRk54QnFCdEtPd0Q1STFGMk1q?=
 =?utf-8?B?ZnVSYkJJNGJ6VTYvWFMvcE1wL0s3Y2N3MzhYTEgyTnJZNnl0emoyWXBkaFBZ?=
 =?utf-8?B?THRrYXNxbEUwSlE5Znk1aGFaR1ZxMjErN0RmUzRXZnB3YnNiWHVnNDZsMUVu?=
 =?utf-8?B?WlZTVzRzMHZZcXdhSVhid0tpeDl5Y3JKRHNTd29GWm14a3l4d0h5dG9ZSWRv?=
 =?utf-8?B?ZDZneEhLRC9IQjFsbDdSeFdsRHNmR1pESXhCUlUzT2NvNUpucjg4dm5Sa20w?=
 =?utf-8?B?aEtzTW53R3RXZnZsM0krNDA4S3pGc1Znd0dOTnQzVEtkT2NJQkdabml1NERV?=
 =?utf-8?B?eFVKZGQ4TDhacGhickJ6alNzSnVOOUZ6UDZEWTh2Q0Z1bVdQV05QdXhoZlhQ?=
 =?utf-8?B?d1BieGt4TnY5QlI0dFdKTDVjZ1lLQmE4NHFXVkRhVXVRaFlGaWRpWURuTEVn?=
 =?utf-8?B?MUU3cnVIN2Nuc2hrclF0Wk9hRUlkZkgxUlJpSUxMNTF6MFltbyt4NGF4eEtl?=
 =?utf-8?B?N0gzZ1FhQVE3eTZqVXFKL0VIRzV1ZXQxU0NhWmt0U3FPNjVGSEdodlBTMWMw?=
 =?utf-8?B?N2RMamIwNG04STF5U3hHamd5M1lGYkJGSGc0RFhiaGFyWlVvdTUxdHVsM3ZU?=
 =?utf-8?B?YklMczVqYVJXMTFXWkFOZm1hMVJ5UExMVFQ4T2N4bkhTTUE1NitnUGVwQXBF?=
 =?utf-8?B?MHFsZ1VzeHNMQlp2NUs2SXdMZ2kweXBmSVp6MUU1OU5EWlNudVpmbXF1T2xF?=
 =?utf-8?B?OHJQcTJNdVJ0UFRLQTVCRWYzWUdSZGs2Ti80UU9LQlFmWHpnUDFLbmhGR1JR?=
 =?utf-8?B?OVE2QndCek5NZmdwUVRGc3JqWDdQUFQrMUt6Wk9yMnN5eEhhSDVlU2pNdmxF?=
 =?utf-8?B?emFWQWFCYms3K2p3RUE4TG9tMGthWkdUTXZQM1dlVmVQTDkxQzk1cDNMc3Vm?=
 =?utf-8?B?d1V1WnhSaExPZzdJRkhvRzkrR29WSUZKVjFadldESGxNWWlocU5rUm80WDNm?=
 =?utf-8?B?dW1Gc01QUkRRNHcrNzdDNm9tTHUxakZwOHB6Z1l0YUZUK201WXNPWDRqUjRT?=
 =?utf-8?B?M3hBdUpyYS9haUgzb1A2dzFpOTZaWXIwUS8vVmxpWHg4dks4MWIxckNDbDlj?=
 =?utf-8?B?NWQvM0xuclJQOUFsS2R1OVdQQUtlcyt3dVZFWFRiSGhKZVlxenJacVN1NVpz?=
 =?utf-8?B?ZTlPMDhTMkZPVHJIQlZ5dzV5WjZxY0tna09LcjBtQkxLRVVUWmd6N2t2RUZp?=
 =?utf-8?B?Z3dXU0VpTWJkdnJhZWRxb0Q5TnBXMDJkQmdHQy8xemZCZ1QvWjdkOWlUelMv?=
 =?utf-8?B?bjA2YnlIMnpVbFBkaUNGUkdwSE5GelRtMU11UTdna1RwMFBEcy84cFI4MUow?=
 =?utf-8?B?YUJLOEd2VmxxYjVQVmJ5NkNnMGc5TlZqWUtmdDNLQlExa285aFErOERramR5?=
 =?utf-8?B?WXRKWWZKdzYySC84dndRZnR5dXpDeTJsSjJKT0tzODdBMXdBWFl4QXpDR0s0?=
 =?utf-8?B?dk5nQk5MZGwyN2xiTklQZkdJNjVzZ1JxYnd2cXU5YzRDbUhTQ3Bwb0VwWU9R?=
 =?utf-8?B?N3l3WDR6YzFBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YndGZ292TTB5empsRGkzQUJqbXdwZ3dqbmcrSXBBSVVTTkh0NGdibU1GeDhD?=
 =?utf-8?B?ZVhvTzBxaXdPY1hsbVBwMVBpc1dobXl2dFAzSzFGbEtqdngzVEtZTTM3M3Vm?=
 =?utf-8?B?a0Zaa0dwVktYR0N5YVMxMjE2N040d1RBdHRtOHRoNjdQLzJDcEtpMzMrVE42?=
 =?utf-8?B?U25pVTlDNFZ5cmNGZlVoNU1NbnR0UEUrVXI2WUtLckMyUEhDVFprOGkzUE52?=
 =?utf-8?B?OGtQUlZMclgyTDRnVEFTQTRhWjEzUkltTEJMTkRjUWpmMmM4SmVPSzlyaWdr?=
 =?utf-8?B?K2dTaUl4THE0ZVhGYU40UUx0WU82YzhDOE85OE80OWNNa1M0dUtzWUJLRks5?=
 =?utf-8?B?TkltaUZlK3gzajBvNEpDZjFZcnVaQ1l1T3BFM3picEdIWEJNeE8rT0NsZ21a?=
 =?utf-8?B?YXY0cGFsU1R5OUhud0IrTmtPQzE4MFhIZi95WWI3UTBHN01Hb3B5YmI1cGpT?=
 =?utf-8?B?MEdJaFVwaDl5R2IxdlJlejN0UlBnTDBOVFplUzMxK2VIaGJJamM4SmFrSFBQ?=
 =?utf-8?B?OXJ6VzJESnN3dEFvOXRjRkh3OHd5NXN4MytBaytCNllGb1I0UC80UjQxR09M?=
 =?utf-8?B?eGJEejBRK05ETlBDajJRbHl2Y1JTcjRxWTVwbWxPUmp5UjAvQVEwd3dVVlQv?=
 =?utf-8?B?QnhVcFAyeGxyMUxWdWRKUU1iS0huNmlGVGljeHIrcThYWjV5dEp1UVJtSFVJ?=
 =?utf-8?B?TGx2YURpZzNQWVNnZzM5WExzc25xbTVxY2I4U1FGMVVkMWQ2N3BXUUM5QWtY?=
 =?utf-8?B?eXhKUDZGWk5WTW5KM09XejYwNXhHSzBURlIyeDNiSWhVNEc5WlkrRkc1djg4?=
 =?utf-8?B?U3NYM3FxM1BkOXNFTTFaZlEvVndvSVZnZEtndE5sYnZUaEMxNE5OUGhxNWt3?=
 =?utf-8?B?b2cwbllYNm1YWDJJYzAzS25TVys5OGh2TzVOTEZBa0Fwd1RTMkNUK256Y3d6?=
 =?utf-8?B?N2JkTE5RMUVmNDlwYkpkQjc0UlF6UTU0OUUyeThvOTduN1BsVm5VM3pvTTR6?=
 =?utf-8?B?MmFwb0FDTlJDWEVZWWo5cTJyeDRyaDFSY3JyN2tuK0JNN2xxaWhKSGdNaUlD?=
 =?utf-8?B?ZUlFR0tLWkZKRmVqWkE5V0MyTjhTU3l2cWV6QmxnaG13d1YxemhWcDFkTFFV?=
 =?utf-8?B?YUtNU0lmdnl0L2VFb2ZHNjlRalFlV3ZqQVBXdEp5OW5BaHVyKzRJSWhqVXdX?=
 =?utf-8?B?UVlJR2lzMnErOWI3Mm5kZGE5SW1WYVRMSlBoZUg3aDE1V0N5amo3djVXKzlD?=
 =?utf-8?B?SmViS0JQanQ0N1Q1T0NDV2cyS3c4K3ZnUjVqWHZPckljTzhPS1JsTTUwekhJ?=
 =?utf-8?B?SW1SU1k3SlFFaXJLMzErcWZzL3dnbU83VWtDQjlueW9XanFxcjhSZVJGeTFJ?=
 =?utf-8?B?SitJQVZrcG1IMk44RmNRY2tyK2dFV3hOdWd0NzRTcVN1Sk4zYW8wVE5Rb0Fu?=
 =?utf-8?B?TUM0WUcyeE9uRjMyN292eHNsM29kUXVzK3RnT2NTWkpwY2FuYmNDM3JyMHhZ?=
 =?utf-8?B?NEJmcElWeFJhZDlJQmw4L1djcFBKbndiUUFrUFBTL3BBRmNpS0ErZUFWcW5N?=
 =?utf-8?B?R0owaXZrdEQ1dnJFL1lYd25xVmtOMEpJaGtuSlFpbmV0TitUMU1DdkxUQmp6?=
 =?utf-8?B?Lys0R0FKTkhLTXB5dmlSL21OTE9sSDVZNTBEeHduQUJVeUs4NEc0UFRXOEw3?=
 =?utf-8?B?QTBkN2pNeUZYZFp6cWxsUnVVejROOVJvTVAxaTRNOVI0U2hoWUo1SXp5c3Ev?=
 =?utf-8?B?cEt0R2tKSjdTaTNOWDV6Q3ZvSElPakdsZmpha3BEb0pOTWFKeFZRZ0VZeVhk?=
 =?utf-8?B?L0d6ODl2eW9RRVo1V3JDeGRyR0VCOVV2cU5zNlM2ZGszNEQrZE9RVnVDTita?=
 =?utf-8?B?cnNqU2kvOHp5ME9EaHY0U3BFam5xZW0zNVhXZC9jS1hObXM2MHZIeDN0cTRn?=
 =?utf-8?B?MXZsKzh2ckRCQ09rTVdqcFl4YmQ1OTZJeG5GOVNiVURXNkN2bWtVbnBZWHRI?=
 =?utf-8?B?Z0RaMHh4Tm1iWEdaMmVDSUR0ZmRGcVZ6RDRSSDFSUTRWcGZCTEVhUWhZMUhk?=
 =?utf-8?B?MW5KNkxHdTBUTnVkcTZ3NjZNOERreXFhWWNqckQ4eWtjWjhVSGEyVGhQQWlY?=
 =?utf-8?B?dmxBNFRUczhzcW5ZdHJNZy8vZ2R2c24vMHRReFp4TGdqV01QNUcrNW1iTmpi?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E58D103BC09828428EBC3451DEB69F65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XcOAff3epjF219q9P1fMo7D+zNwEcGO7HL5+s/cYxGx1Htba0Z7mozqD57qMCaZGKEDIARL34M8+0LleIabnfLkwvWyBl8PG/Juo4iIBf49r+2L1tAsQF9TEZc4yvpDTX/2YDTzHzwSlb7bee63ToKz6HVzLnppFOy0oCb8l1YYBTu6TWq+tIotR9oWAhy0B4zGMN7rr4MFBDp/Jlm0YHz2y3ASivkJ+xrrEkfEyaTj1WAvkoD3OjeszVv/SCXgP3kiUzqJQopCDxKkeDrLQmzDXXJTzfDYWSZ8P7PzaNq7oPR4MRZY+DaDnNMSPvKEmdLuoGAGZdyqpyQeDgD5wa+0/n9ADb/3LgC6mPoaIj2a/tXbX5fJ7O2pardTUrkLpjo1xAjkzU/NDex+pGe7c8dQqQPt//8EDxSURcrH0bK8IdrIAOVg1bQP6pzjGey3bWWKDHl2cJy5G1Mt09A4sMEYG/Y0usBGb5nJIOw2uiPak/UU9pT+BsUKMVc3UgPfFRCSNCyEIiza3Wgw6Sh4NKJ8olgQ9OXfpVvXuh4M9zv25lEes7R71pYVzyQ+cXdo1qDcq4OOsspmPFerjY1in0L0fay6B4fThgnEocHVzO+NIHbuAHYtH330arFHBuPgk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f7e56-d25b-4a06-0c1c-08dd9beeecb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 00:47:43.2199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDtCQG2cp4qb/pVWh/aEj5/Qy8xaPbhJ7UJttBfSkxSW3DXQMmjrtmx8LvYLdoa8wB6XTRyzGS+jfC40PXIing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6899

T24gU3VuLCAyMDI1LTA1LTI1IGF0IDAwOjIzICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6DQo+IEhpLA0KPiANCj4gVGhpcyBzZXJpZXMgZml4ZXMgdGhlIGlzc3VlcyByZXBvcnRl
ZCBmb3IgdGhlIHNsb3QgcmVzZXQgZmVhdHVyZQ0KPiBtZXJnZWQgZm9yDQo+IHY2LjE2Lg0KPiAN
Cj4gVGhpcyBzZXJpZXMgaXMgb24gdG9wIG9mIGR3LXJvY2tjaGlwIGJyYW5jaCB3aGVyZSB0aGUg
c2xvdCByZXNldA0KPiBwYXRjaGVzIGFyZQ0KPiBtZXJnZWQuIFRoZSBwYXRjaGVzIGluIHRoaXMg
c2VyaWVzIGNhbiBiZSBzcXVhc2hlZCBpbnRvIHRoZQ0KPiByZXNwZWN0aXZlIGNvbW1pdHMNCj4g
c2luY2UgdGhleSBhcmUgbm90IG1lcmdlZCBpbnRvIG1haW5saW5lLg0KPiANCj4gLSBNYW5pDQo+
IA0KPiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gKDIpOg0KPiDCoCBQQ0k6IFNhdmUgYW5kIHJlc3Rv
cmUgcm9vdCBwb3J0IGNvbmZpZyBzcGFjZSBpbg0KPiDCoMKgwqAgcGNpYmlvc19yZXNldF9zZWNv
bmRhcnlfYnVzKCkNCj4gwqAgUENJOiBSZW5hbWUgaG9zdF9icmlkZ2U6OnJlc2V0X3Nsb3QoKSB0
bw0KPiDCoMKgwqAgaG9zdF9icmlkZ2U6OnJlc2V0X3Jvb3RfcG9ydCgpDQo+IA0KPiDCoGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZHctcm9ja2NoaXAuYyB8wqAgOCArKysrLS0tLQ0K
PiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jwqDCoMKgwqDCoMKgwqAg
fMKgIDggKysrKy0tLS0NCj4gwqBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1v
bi5jwqDCoMKgwqDCoCB8IDIwICsrKysrKysrKy0tLS0tLS0tDQo+IC0tDQo+IMKgZHJpdmVycy9w
Y2kvcGNpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDE1ICsrKysrKysrKysrLS0tDQo+IMKgaW5jbHVkZS9saW51eC9wY2kuaMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0N
Cj4gwqA1IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0K
SGV5IE1hbmksDQoNCkkgdGVzdGVkIHRoaXMgc2VyaWVzIHdpdGggdGhlIFJvY2s1QiBSQyA8LT4g
Um9jazVCIEVQLiBBcyBleHBlY3RlZCwgYnVzDQpyZXNldHMgbm93IHdvcmsgYXMgaW50ZW5kZWQu
IEZlZWwgZnJlZSB0byB1c2U6DQoNClRlc3RlZC1ieTogV2lsZnJlZCBNYWxsYXdhIDx3aWxmcmVk
Lm1hbGxhd2FAd2RjLmNvbT4NCg0KQ2hlZXJzLA0KV2lsZnJlZA0K

