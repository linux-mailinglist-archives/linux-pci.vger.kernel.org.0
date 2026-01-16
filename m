Return-Path: <linux-pci+bounces-45029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC0D2F607
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF81530B452F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7133131B832;
	Fri, 16 Jan 2026 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmSpXJEd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SxtIr/kt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643E30B524;
	Fri, 16 Jan 2026 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558258; cv=fail; b=NNN6GECj8kVhJ1KGzcfUK9xm5NJvsCevfMJznX5ncgjGtr2aOq3IdjeTRypceW+Ndi5dmU12HyNQSC/J5zIpgfyDPkLv4vlLxvbRzagFMORWGUwnZb3c3RajLwffVDe5lrsNDikl64yPaTXngOenMNNcuwCr9TASHsiCIYW8c6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558258; c=relaxed/simple;
	bh=bjZ5zA5nt4OUgLuNdlDFHtR5KOHDMlNdioXCZgcqeOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QgaAmXad3fCYog4xieB0Xa93xAh0dUGshGiqVcgvcab5aMD7OpLqTdiY6gITHI8D+WmcPY2j8mWcZXV/AdZBGk56vH6A61jIQSoL1L/IXoBJfIO78N0ryyaGlZDk//B/gVta6i0Ch0idTSV7PjjZjagBjFihiUEU7AhmwpRGM+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmSpXJEd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SxtIr/kt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNmnW1910955;
	Fri, 16 Jan 2026 10:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bjZ5zA5nt4OUgLuNdlDFHtR5KOHDMlNdioXCZgcqeOk=; b=
	FmSpXJEdgitYtOaE1Kh7qNwF9gWo/9HyGkkZ5fT8LcHy5Xt+qilPz3Kwb9Fj0t55
	jOdIwJQO63MqEaGOewnom9er6kgrptvmeQWiCpmhDtuNZPmIN+4EdaLGGwvEv+VV
	Z+7873PqDaBUrxA+qaIHDabACxq1Z4xW6cKFCGnoEMqcqr/Cqd/1enwReNjOLW5v
	f8bwoppkLu2Nw3uINraGdUEw57vfnFGOi80JfPh7QEumbZxQ2fyWie+I6aiORQvX
	nnz/oqu3bMUIApjlJSwYgvWbcnaeG75qpZCzZfDGYKmjTUQxc3k2X4v8oEbG085+
	sSSbP3KD/p2VAYZIFmV5bA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkh7nsv7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 10:10:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G7wgxF000463;
	Fri, 16 Jan 2026 10:10:47 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7ggukh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 10:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz050Rhla3o01TVWdfU25eu1CKc07CuaVoHlYl9zJqm/xz239zrTed2btjGWC6hUGQ6GK9lXAqrtCqdjdAGcssGZKmbEQNiXQlHvzv0QbPXmZ95TlKKXsKT/Ve+0FQlIjP5WJskwUZGLDxvyxTUWBmZaUuK81Bb1tzVRYitCwiLBCuw826e2yMstbkf7NirOuPxbGiZfC51ZJN6xArsBwF35SOJ07P3oTgvIb0H60+iPRIzvEZTjL74904B0RJ396cAw5u6uPePVdyIS26xmP6B97EeEIoYs3F416tM2rh9H+xUxmJ4E4z1PDxeN0jWdmYaVEsqTzGV/xbrT8YvYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjZ5zA5nt4OUgLuNdlDFHtR5KOHDMlNdioXCZgcqeOk=;
 b=XBbAJ1tTS/cOA96WJBdGe0mnPNWEKD4zTzsslLtUX5M/ELMMIOTACq1fGy+Y4r0cQAxLmXKIVWRpdCthUZGRXOkpC2nbXZNMhNb2WdwUHyt6l7A+X8nUmMabcpXC0lxJQ8M4Zjzf4yL2F6H1JMD3zzCxBGlWiCFQV31+XWmnLNA29V7khSzZzG6eNIb/3qR1uXmJk5CkxASXUU1bKO8i4k5nRPKZtKUFC6fEJz5n1CQ/5ekNgO7S2Fxg8xLSe6MJJSuEUAiQmkcLTa8tuMQZ14AuOcQ5frKAc7wRW3JwWFaJeASrQC85wmT/MFalngvcd/NjjEdmgRIp2jwcLv+YsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjZ5zA5nt4OUgLuNdlDFHtR5KOHDMlNdioXCZgcqeOk=;
 b=SxtIr/kt3MFfIXUnyyO9BY5XTfZqDcAhZItrGVWrWul1Rbw18b3nmH13XjTPTcek/O89twMHkSWokneRF8xC2u8BT+T0RXfg87SLS31Q8gencg8QCm9lTezOSbHBkMpeyC1BtKHUocibOIxcFEazFfLQr9v/2xm1irepgusg6HE=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 10:10:44 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9520.006; Fri, 16 Jan 2026
 10:10:43 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Thread-Topic: [PATCH] PCI/ACPI: Confine program_hpx_type2 to the AER bits
Thread-Index: AQHchLA3J+2ji9rVEUKT1oas/t+7tLVQyAGAgAKYzoCAACNhAIABEyKA
Date: Fri, 16 Jan 2026 10:10:43 +0000
Message-ID: <A6A85012-A9E5-46D8-8BB5-EEC20898B6C6@oracle.com>
References: <20260115174548.GA873328@bhelgaas>
In-Reply-To: <20260115174548.GA873328@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SJ0PR10MB6399:EE_
x-ms-office365-filtering-correlation-id: 1b4bd166-5b1d-49d1-1f2b-08de54e7828c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2Z1ZmVuZlVqTzdrVTJycHFUMFpnK3ZZbU1TTGFwNE94UUltV2IyRDNIVjN5?=
 =?utf-8?B?TDlSQU5zR1dmMWYyYTNFS1ZjeTgwZHQrTnU0ak8yVUFCejdkVmRrK004S2I1?=
 =?utf-8?B?MGp1UDJMeEZwRkRjb0ljR3M2MzRnakZ3bnQ1bVZsbm1uNE9zZUhVckd6K29v?=
 =?utf-8?B?WWxnajg1V0ZPa3FBVjU4eTI0RnFKMytVcjkwMnVSeE5wcVVGYUdma1VSMGhH?=
 =?utf-8?B?enJMWlFLVnZPUXptVlJueEIxbUI2SEJ4VzZjM21tZjFDQ1dLYVlRNTg2aitM?=
 =?utf-8?B?bkxwNWFiNVI3aUM0dGl2ZE1qNTRGaEdMb09wNVlqQnJBSEVndVd0azEzRUtE?=
 =?utf-8?B?SjBuTHNZOSsrVkJkaHIzQklMMVFnTjdMMTlBY1BwTmxCSVZDcDFzanBhZWxZ?=
 =?utf-8?B?bDZSOVE0RllNcnloeEY0c3F6SzRiNjE3NDJUYlpSWm8rMlFjK3JpMEhEWHBK?=
 =?utf-8?B?ZG9ONHp3R2d6QUZyWEd5WnpIM2U0eGRCYmswbytGMVpsMFhkVjlsOFVIL25k?=
 =?utf-8?B?NGpxN2l2MHB0elFidktOdkhocHZZZ3NsVzNSQWRpVWdHbHl5cUpzU1VMQjNa?=
 =?utf-8?B?akpWNS9UcWU3RTZJVHI3U2JXWFo1NFYxcmpwbDNWNC9xSCtNckNmdkdWZ0Q1?=
 =?utf-8?B?QnYxYkFpeHFIRm1FY01ITFBETlhKQ1RDK05KdjM4RGM1ZjViS0U1Lzg3dXBY?=
 =?utf-8?B?OFcvcmRRY1NQNWZqNDdNaHdxWFQwek1vazVSZTVYS2pRLy9ZWFJ1UHFPZjhu?=
 =?utf-8?B?KzZ6U1RZb0dVK05TYjBUa2duNzE0c2VxdmNMK3AzZW43S3FtODVUOTZtL2hy?=
 =?utf-8?B?S29zcys0SWg0QWJCRjVlaXJTU0lXV25oNlpvd3FaZDZrLy95Y2E3UjcxSnJF?=
 =?utf-8?B?N295ejZJNW1rVDhmZmFoV0RmcUs1WVY3MFdKYWdLcjE3cit2cHBSU081ZzhX?=
 =?utf-8?B?eE5hajBuaFM5YkNVYmRwQlgrdlpKTzR2dFcybXNjQ2lBRXRYL0llTmZ2MnNK?=
 =?utf-8?B?amdaV0phL25GQTdadTV2bzA1NWdmdEdFMVd6cU1SWHJmVCtmR2t0SUNWVHFw?=
 =?utf-8?B?enkxQW52WDlBK0ZwZ3VqWmhnWjN5TFExMjZCODAyN3RGNHdwR3NFcnViUFN6?=
 =?utf-8?B?YUgwWGh5bG16bjVEdVhZdHpTamJIaDVUeUNNRFN1RmIyZmpkVVhBRXZTWmFh?=
 =?utf-8?B?U0lqN0VydnlmM205RldTWVhIdjZsTFR0dU9RNEtZYjVJVmpCeXpLUzd4eDNB?=
 =?utf-8?B?b1laNUdDeTJqNUJVZ253cHhpU1B0bVFNUWRzWVAyNno3RTdkRGRmTEV3SFJq?=
 =?utf-8?B?blhIOEJwQVZwNHN2SUE0WksyanAwM0VGSHlFVDNzdnVxMUFsdll4TjhDYXJJ?=
 =?utf-8?B?dEFleTBQSWNkMUhGWTQ1VS9mak9VYkdrc3pCaG45emZsMjhKdVAzUVVpc3Nz?=
 =?utf-8?B?UlFMK1FlNUpUc25HYXdndlRCN0xBTjJzZ2hPb2daT2ZyMjFoVVdhOFc2czdx?=
 =?utf-8?B?TUFGQTZubHNlMXpxSzE4NElndDh0QndLTGJpZHV5Z2RIbXArbVpOTzRrQjR6?=
 =?utf-8?B?eHkxZ1dkWWxTV3l4YWxyN01LdjBXZmRDUE41cDI4Wm01d25wN1RPL3ZQRE12?=
 =?utf-8?B?czgvQ2lTTXhiQ1FXdlRFVDlkVURTdkUvTUxxeHcvVzNJTVBRWFNsbWFuSG91?=
 =?utf-8?B?bmdpeXVPWDVXaytZV1NRV1V6eWh6bTJvenovdjB1SDU4NlpUWjdjNktldHZl?=
 =?utf-8?B?WlpxQVdLQnA4VHA5R3NYTjJSSVY5K2dQRVNUM2tmV2JBNG9YTWZoT0ZPWFZs?=
 =?utf-8?B?QWRlZGdEcnFyZFVuU05MV0VUeWZpOGQ1Zk80MTVjMTdENm1CUWp1Q256bFk4?=
 =?utf-8?B?eXNDNXVtS1ppRnNyZnQvV3FtT3VZaTZFMjV4bnlsMkZkcHVIS2dNTDJkZWRU?=
 =?utf-8?B?YkFRVEk5QVBEZVZyM3hIODUwelVWS2VDK1lybmcxQnFGbFdMUXIrQ0VQZGpS?=
 =?utf-8?B?d3RXLy9iMzMrTm5vUFZNcUEveTdPTGwyS3pQYzVlV25WNEFxbE5Ia0cvdXR0?=
 =?utf-8?B?V3FVdVBVaUdGM01RSWx6ZGhLMHNCL01lWWt5SmNqNXUrOE1mMVk3eURZU0hB?=
 =?utf-8?B?SHdxYU42TEcweEVtblVlN1J2dWVLS1pXa2tpSkMySkdvOURpa2ZxMHljMVA2?=
 =?utf-8?Q?NIdpBetBm3WIz9M06NcjIMw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akVJQ0FBeUd0bVQ2MDJscGtyRS9EOHpTWS92dUlJTVRyRUxaQ3drbko1a2pi?=
 =?utf-8?B?MG85dnJjRGZLcWREVDZxZFBsTnpLTXlNRFRVN2NzYWNhTTlGQUVEYnpmT2tL?=
 =?utf-8?B?YUNsMndMb3F4Mk1yTVFOYmV0eFB0aDlpR1FjYnB6dW40ZTIvQW1pZDlJV09l?=
 =?utf-8?B?WWhBVkF4bW04T0l4R1Nua05xR0N2L0pUZ1MvS0swVERuVEl4RFBIK2M2Mjgw?=
 =?utf-8?B?WGRJSnVNRWNmeHN4dTN1bGJFeFUzNkx4czV5T1Zrak9KdnkwdlNPUVJSQWVT?=
 =?utf-8?B?U0xJdjZ2azdGTjJzZk9CM2Yxc3VhZWt5bHUyakJJcENDKzRSOS92dzhncS9m?=
 =?utf-8?B?STVVbVZKZlNtaVNTZmJqVmF5ZVVDWmFWbm93TDF5TEVXSVJIOEdVZWNHekZX?=
 =?utf-8?B?MldXSENrMmVPbmV1T24zd0ltYmlSUFd3OGhYNjg3N21JYjdXNkI5MFVUY3VT?=
 =?utf-8?B?VnoyNkxJUjdEUWVxSFJhQUJ4d1o1UFo4bnBjdTdwUjBGbG1UUlFjNURETW9M?=
 =?utf-8?B?NzdveVUxTXpTSVpVT3M1N3AyWTU5MmZRdzFWZzYvK3BoTGIybjlWQ2JqOHAz?=
 =?utf-8?B?UkQ1NHBlOVo1TUp0TDlMb0NJcFI5VytKSEJ4aWUyKys0dThTS3JUcDBjNWRt?=
 =?utf-8?B?Y3EwdnNWeUNSZW1sR2Vmd25sbGpSWDF1T0tpOU5KZStlSzIwYVc3dFh5YVRT?=
 =?utf-8?B?TlU0WXpXcDNjcmZEMkFzeG5XRUNHYjRxNGgvWXR3cWQ3cDVqZEozejBiQ2ls?=
 =?utf-8?B?aFNURm1QS1hYWVBJSHFEcHd4bi9FTmdzajk3YVphcW5hcnA1eU9BeUpvVzkx?=
 =?utf-8?B?YlY2bEJod2tiODhVeWlmSWY2VFAvTjJsVmlPNDYxQ2lyVEgvbWJ5Q1IrR0Qr?=
 =?utf-8?B?eTBXRDBEODRieG9yc1F0SC9CeUNpTnRUSzNQSGthVStERk1vbDZoa2FKS1Jk?=
 =?utf-8?B?NHV3QUtGazZxU3FZNERKRE52eGsvbldVU1dCVzJtYStVU2NUNGZPai9YMkJq?=
 =?utf-8?B?bFF3QXBxMXN0QmIzLytEOGpOZlhObjJha2l2N2ZxSHFhSXoxVUdCMFAyWmN2?=
 =?utf-8?B?N2tiQU1OeldPWHBoZ1pnY3c5b0dKZ2FhUERQMTN3d2F1QW9wYlFtdEpVQ05q?=
 =?utf-8?B?aUcwcnFvY1BOdm5TWktqcUJVNU92dmo5UkRHOFZxR08xMlFoMkhUajhSN3Rx?=
 =?utf-8?B?Q0xYdjZzNDNsRFZCVW9qZE8rWlNSTkg0VU80MmVwcFo5a0Q1QS9BS2xlc0Ur?=
 =?utf-8?B?aUFHZitvd0M5QU5rRFRyVk1Dc0tvTTFqbnhGMWtOUDQxV2NlQVY1RVRCaWha?=
 =?utf-8?B?Ujd2RzMxODVjbVhmajV5VlI3TURqcXhmOTNGNVpYRzhYTXVqSmY3QVpOL2RQ?=
 =?utf-8?B?NDN6WVJzVjZDaTlmNmJtd1VGVlJlY0d1T1Y5UmM3SGdXRlJIaTVMTzlOMXhY?=
 =?utf-8?B?d1lTMzUzdFRjdkZLZkNPME51b0JzTzFyckR4a2o2cENMV2ExZXhiVTcrZDB6?=
 =?utf-8?B?VUhuU29yaFZ4amtUMU0rMitFT2pFcmhhd3ptSys3elNvKzkzbHZrdEF1MGpr?=
 =?utf-8?B?bXk3OXRLUktXMU9Yb2psa1Jxa2JaMWIycHlSUW4yU2x0c05MUmg1Y3RTNW1M?=
 =?utf-8?B?eU1jUTRRTzNWdTFIYXZka1ZoSy8wRC9UaVVyRStwNnZhanVtRVJxeVdLdG10?=
 =?utf-8?B?Y2haNjVTTWh5dU44VXFab3F0WjNLRU5JRUFZQ3pCazFuaWNGNXBTcldvTG5N?=
 =?utf-8?B?SlAxVUYySEJGQ1RTNEYra2UvbXVUc040ZEhOSHJXTmJuT2ZVT2JEaGkxK1Zr?=
 =?utf-8?B?NkJ4NHRxVXhsRU8yTFVGaUQzSkRKL2l5TG1Ra2pZVnpWbWVVOEdhNkFDN3ps?=
 =?utf-8?B?QVFibXNXQVFGdTRtOC9Ccy9EUXhTWE9EVEdGSUFuT25IcE9uUTV1Y3ZGRGFB?=
 =?utf-8?B?TmVwNThXcU1RcE1rcjJXRGFYTnVCWm1HMzhJTWRDZ1lNUGlQL0VBRFdURGVr?=
 =?utf-8?B?aHZFbjBRc3dMVWEramVNZ2xyNVB6VEczUXdYS2dlM3RLK1hlcktHSmxFQXhh?=
 =?utf-8?B?dTdQeERLK1kyMGpkTDFoZ2hNanJqOFBNNVBZd0Y5NW80SUdTT3JSV1k0aXUv?=
 =?utf-8?B?dnQrcGtVd2Q2L3dNOUU2UjFMTEhTV3BUaE1xL2plTWlRUVpqblM0Uis0b2Fu?=
 =?utf-8?B?UzRGK2lxcTZ2UFJJc1Y1ZzlVRXlnWllVbHBuNWVGSnlqNG9EdUJWaXRwYWdU?=
 =?utf-8?B?eU8wSXpiZm03NythVHNpNHA3T1dTcVZNYTBMSGdXUGQyMEF6MEtMZXZQOUFJ?=
 =?utf-8?B?NjQwQXpVTmJ0aXc0cTlyMk5LVnNTY1NiL0tLNnh3czI3SHRlUVg4Zno3bTBJ?=
 =?utf-8?Q?6HxD5x+wHQ/Suiww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31FF5B458AE734E8C2F7AD178C57904@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NIC6qoObgVrCseESFxIP2KdK2F0MB+YDm4T6kyBbk3gplktcZg+5NWHSoLHRLKn+JTTFyfOLcJ2XwVTZ818Fq8EJXenpHTGb/4mnV+obWpeJTrZzcjjEG/itcHHMe9pqcY+9LRf1NyWFb1E21hK0tYUuvDvliJsGhKczhO80LWlKVDsVrGNwLsLh40IHTVfdUbVjCdXdBrGf2KOCgA3iEA88oJQvJ9+0lYUbqVrFNp/i381H5+B7lAqV3uSyvvbLqmwK6RZiGBKGItfbwRyXdrJNJtpsBmYGxUVk4zi2pcc+2MTFX4i7ldNnFv2EoeP3pF+3VLNOmRfiAGzfIKDdFkd4glf0T74ebI3IDDQL6/kDLMs8RAlybmRKdJtADrZLXaGB78WRS64sCWCVIWlAgU2zVdVh+i+wXZUx2Y0zIsUl478spe2oNdjCM9+VeG8ER1aqwTDw0AlP39W70nsLAvzCp5aB+Ylsu6sqHP2+QSbBppaBLokckY7ScaadIjlOJSEVTz4EDgzZ5YqjETqyBE7Sp21BVS2AXqPfrTC92QNu+wd0xtLLRkjBk+WMyj0V9ZT7VyVtQLQ6ObUAUV/AMA6vAAUq7cVYCuP3wr4aols=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4bd166-5b1d-49d1-1f2b-08de54e7828c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 10:10:43.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiK2RdlzCRS/1zrRnGiTgAfYK8DET6VRNMZCkQbUCazEX9crwaRIMLiOemRfomuLWPPZgo/oUrOXyn38nTJoaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160075
X-Proofpoint-GUID: IVCdC5MdJM7dnR260erx2fbm2nMksPO2
X-Authority-Analysis: v=2.4 cv=X7Bf6WTe c=1 sm=1 tr=0 ts=696a0ea8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=b1QlAQtRAvjKpo53x3sA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA3NiBTYWx0ZWRfX20aJN31KytXt
 sDLw4SH9vsMe1kM0Ss10RG2Tf1LP3y4d/AjhyyH7UK6xDUtb9qMjT+OpClRyOtMh3L2G9J8CKBS
 +ZNfaQK6kjYLR7a0j1PPbkbhWVBLTvS4PdgXD6bgIYgaMEQZd+mrF43kEPY8OETgbkjwSJ5uiv6
 TCbibo8/2UqdhUUWe3fs2hn84mbVnH1ihUk13+57B6QsNnG9GUUUeeaG7n8vVr0Gog7X0fdFDy3
 dWtcgAH5ROob51pUkR9WQbIF6iG5ViJ/wb1vMjDkepXUP6bqJCma42IumPBUBXXEUcsa32RW1FO
 /0CWxkZqY0V/6fO4BththNBIGTC/wN4YoYhtw2pMOmypsqAxnvj8VZknm/tAjpyeul+eS28NL1e
 cK1vMyDiz9qPZYVY1nQnjJki6TVcBMN04HgpG6ARs0AZtD42FbDZIWzG5uhOuWybza0nXwb7Wd/
 ESt0CHcyV049Ps9sQqJddVFtzWvwwbTOagPdf/fw=
X-Proofpoint-ORIG-GUID: IVCdC5MdJM7dnR260erx2fbm2nMksPO2

PiBPbiBUaHUsIEphbiAxNSwgMjAyNiBhdCAwMzozOToyMVBNICswMDAwLCBIYWFrb24gQnVnZ2Ug
d3JvdGU6DQo+PiBUaGFua3MgZm9yIHRoZSByZXZpZXcsIEJqw7hybiENCj4+IC4uLg0KPiANCj4+
Pj4gKyBocHgtPnBjaV9leHBfZGV2Y3RsX29yICY9IH4oUENJX0VYUF9ERVZDVExfUkVMQVhfRU4g
ICB8DQo+Pj4+ICsgICAgIFBDSV9FWFBfREVWQ1RMX1BBWUxPQUQgICAgfA0KPj4+PiArICAgICBQ
Q0lfRVhQX0RFVkNUTF9FWFRfVEFHICAgIHwNCj4+Pj4gKyAgICAgUENJX0VYUF9ERVZDVExfUEhB
TlRPTSAgICB8DQo+Pj4+ICsgICAgIFBDSV9FWFBfREVWQ1RMX0FVWF9QTUUgICAgfA0KPj4+PiAr
ICAgICBQQ0lfRVhQX0RFVkNUTF9OT1NOT09QX0VOIHwNCj4+Pj4gKyAgICAgUENJX0VYUF9ERVZD
VExfUkVBRFJRICAgICB8DQo+Pj4+ICsgICAgIFBDSV9FWFBfREVWQ1RMX0JDUl9GTFIpOw0KPj4+
PiANCj4+PiBJbnN0ZWFkIG9mIGxpc3RpbmcgdGhlIGJpdHMgd2UgKmRvbid0KiB3YW50IHRvIHRv
dWNoLCBJIHRoaW5rIHdlDQo+Pj4gc2hvdWxkIGV4cGxpY2l0bHkgKmluY2x1ZGUqIENFUkUsIE5G
RVJFLCBGRVJFLCBVUlJFLiAgTWF5YmUgd2Ugc2hvdWxkDQo+Pj4gbW92ZSB0aGUgUENJX0VYUF9B
RVJfRkxBR1MgI2RlZmluZSB0byBkcml2ZXJzL3BjaS9wY2kuaCBzbyB3ZSBjb3VsZA0KPj4+IHVz
ZSBpdCBkaXJlY3RseSwgZS5nLiwNCj4+PiANCj4+PiBocHgtPnBjaV9leHBfZGV2Y3RsX2FuZCB8
PSB+UENJX0VYUF9BRVJfRkxBR1M7DQo+Pj4gaHB4LT5wY2lfZXhwX2RldmN0bF9vciAmPSBQQ0lf
RVhQX0FFUl9GTEFHUzsNCj4+IA0KPj4gR29vZCBpZGVhLiBCdXQgd2hhdCBhYm91dCBtb3Zpbmcg
aXQgdG8gaW5jbHVkZS91YXBpL2xpbnV4L3BjaV9yZWdzLmgNCj4+IGFuZCBhbHNvIHJlbmFtZSBp
dCBmcm9tIFBDSV9FWFBfQUVSX0ZMQUdTIHRvIFBDSV9FWFBfREVWQ1RMX0FFUiwgdG8NCj4+IG1h
dGNoIHRoZSBjb252ZW50aW9uIGZvciBERVZDVEwgaW4gcGNpX3JlZ3MuaD8NCj4gDQo+IEkgc3Vn
Z2VzdGVkIGRyaXZlcnMvcGNpL3BjaS5oIGJlY2F1c2UgKHNvIGZhcikgdGhlIG9ubHkgbmVlZCBm
b3INCj4gUENJX0VYUF9BRVJfRkxBR1MgaXMgaW4gZHJpdmVycy9wY2ksIGFuZCB0aGF0IHNldCBv
ZiBmbGFncyBzZWVtcyBsaWtlDQo+IGFuIE9TIHBvbGljeS4gIE1vc3Qgb2YgcGNpX3JlZ3MuaCBp
cyBiYXNpY2FsbHkgdHJhbnNsYXRpbmcgdGhlIFBDSQ0KPiBzcGVjIGludG8gI2RlZmluZXMsIHdp
dGhvdXQgYW55IHJlYWwgdXNhZ2Ugb3IgcG9saWN5IHBhcnRzLiAgSSdtIG5vdA0KPiBzdXJlIHdo
ZXRoZXIgUENJX0VYUF9BRVJfRkxBR1Mgd291bGQgYmUgdXNlZnVsIHRvIHVzZXJzcGFjZS4NCg0K
V2VsbC4gTXkgdGhpbmtpbmcgd2FzIHRoYXQgc2luY2UgUENJX0VYUF9ERVZDVExfe0NFUkUsTkZF
UkUsRkVSRSxVUlJFfSBpcyBhbHJlYWR5IHByZXNlbnQgaW4gcGNpX3JlZ3MuaCwgdGhlIE9SIG9m
IHRoZW0gd29uJ3QgaHVydCBhbmQgd2UgZ2FpbiBjb25zaXN0ZW5jeSBpbiBuYW1pbmc6DQoNCkBA
IC01MDUsNiArNTA1LDcgQEANCiAjZGVmaW5lICBQQ0lfRVhQX0RFVkNBUF9GTFIgICAgIDB4MTAw
MDAwMDAgLyogRnVuY3Rpb24gTGV2ZWwgUmVzZXQgKi8NCiAjZGVmaW5lICBQQ0lfRVhQX0RFVkNB
UF9URUUgICAgIDB4NDAwMDAwMDAgLyogVEVFIEkvTyAoVERJU1ApIFN1cHBvcnQgKi8NCiAjZGVm
aW5lIFBDSV9FWFBfREVWQ1RMICAgICAgICAgMHgwOCAgICAvKiBEZXZpY2UgQ29udHJvbCAqLw0K
KyNkZWZpbmUgIFBDSV9FWFBfREVWQ1RMX0FFUiAgICAweDAwMGYgIC8qIEFFUiBGbGFncyAqLw0K
ICNkZWZpbmUgIFBDSV9FWFBfREVWQ1RMX0NFUkUgICAweDAwMDEgIC8qIENvcnJlY3RhYmxlIEVy
cm9yIFJlcG9ydGluZyBFbi4gKi8NCiAjZGVmaW5lICBQQ0lfRVhQX0RFVkNUTF9ORkVSRSAgMHgw
MDAyICAvKiBOb24tRmF0YWwgRXJyb3IgUmVwb3J0aW5nIEVuYWJsZSAqLw0KICNkZWZpbmUgIFBD
SV9FWFBfREVWQ1RMX0ZFUkUgICAweDAwMDQgIC8qIEZhdGFsIEVycm9yIFJlcG9ydGluZyBFbmFi
bGUgKi8NCg0KSSBhbSBmaW5lIGVpdGhlciB3YXkuDQoNCj4+Pj4gaWYgKHBjaWVfY2FwX2hhc19s
bmtjdGwoZGV2KSkgew0KPj4+PiArIHUxNiBsbmtjdGw7DQo+Pj4+IA0KPj4+PiAtIC8qDQo+Pj4+
IC0gICogSWYgdGhlIFJvb3QgUG9ydCBzdXBwb3J0cyBSZWFkIENvbXBsZXRpb24gQm91bmRhcnkg
b2YNCj4+Pj4gLSAgKiAxMjgsIHNldCBSQ0IgdG8gMTI4LiAgT3RoZXJ3aXNlLCBjbGVhciBpdC4N
Cj4+Pj4gLSAgKi8NCj4+Pj4gLSBocHgtPnBjaV9leHBfbG5rY3RsX2FuZCB8PSBQQ0lfRVhQX0xO
S0NUTF9SQ0I7DQo+Pj4+IC0gaHB4LT5wY2lfZXhwX2xua2N0bF9vciAmPSB+UENJX0VYUF9MTktD
VExfUkNCOw0KPj4+PiAtIGlmIChwY2llX3Jvb3RfcmNiX3NldChkZXYpKQ0KPj4+PiAtIGhweC0+
cGNpX2V4cF9sbmtjdGxfb3IgfD0gUENJX0VYUF9MTktDVExfUkNCOw0KPj4+PiAtDQo+Pj4+IC0g
cGNpZV9jYXBhYmlsaXR5X2NsZWFyX2FuZF9zZXRfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLA0K
Pj4+PiAtIH5ocHgtPnBjaV9leHBfbG5rY3RsX2FuZCwgaHB4LT5wY2lfZXhwX2xua2N0bF9vcik7
DQo+Pj4+ICsgcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChkZXYsIFBDSV9FWFBfTE5LQ1RMLCAm
bG5rY3RsKTsNCj4+Pj4gKyBpZiAobG5rY3RsKQ0KPj4+PiArIHBjaV93YXJuKGRldiwgIlNvbWUg
Yml0cyBpbiBQQ0llIExpbmsgQ29udHJvbCBhcmUgc2V0OiAweCUwNHhcbiIsDQo+Pj4+ICsgIGxu
a2N0bCk7DQo+Pj4+IA0KPj4+IFNvcnJ5LCBJIHdhc24ndCBjbGVhciBhYm91dCB0aGlzLiAgSSBt
ZWFudCB0aGF0IHdlIGNvdWxkIGxvZyB0aGUNCj4+PiBMTktDVEwgQU5EL09SIHZhbHVlcyBmcm9t
IF9IUFgsIG5vdCB0aGUgdmFsdWVzIGZyb20gUENJX0VYUF9MTktDVEwNCj4+PiBpdHNlbGYuICBU
aGVyZSB3aWxsIGRlZmluaXRlbHkgYmUgYml0cyBzZXQgaW4gUENJX0VYUF9MTktDVEwgaW4gbm9y
bWFsDQo+Pj4gb3BlcmF0aW9uLCB3aGljaCBpcyBwZXJmZWN0bHkgZmluZS4NCj4+PiANCj4+PiBC
dXQgaWYgcGNpX2V4cF9sbmtjdGxfYW5kIG9yIHBjaV9leHBfbG5rY3RsX29yIGFyZSBub24temVy
bywgdGhlDQo+Pj4gcGxhdGZvcm0gaXMgdGVsbGluZyB1cyB0byBkbyBzb21ldGhpbmcsIGFuZCB3
ZSdyZSBpZ25vcmluZyBpdC4NCj4+PiAqVGhhdCdzKiB3aGF0IEkgdGhpbmsgd2UgbWlnaHQgd2Fu
dCB0byBrbm93IGFib3V0LiAgcGNpX2luZm8oKSBpcw0KPj4+IHByb2JhYmx5IHN1ZmZpY2llbnQ7
IHRoZSB1c2VyIGRvZXNuJ3QgbmVlZCB0byAqZG8qIGFueXRoaW5nIHdpdGggaXQsIEkNCj4+PiBq
dXN0IHdhbnQgaXQgaW4gY2FzZSB3ZSBuZWVkIHRvIGRlYnVnIGFuIGlzc3VlLg0KPj4gDQo+PiBN
eSBiYWQsIFllcywgdGhhdCBtYWtlcyBtb3JlIHNlbnNlIHRvIG1lLiBBbmQsIHlvdSdyZSBPSyB3
aXRoDQo+PiByZW1vdmluZyB0aGUgUkNCIHR3ZWFraW5nIGFzIHdlbGw/DQo+IA0KPiBHb29kIHF1
ZXN0aW9uLiAgTXkgaG9wZSBpcyB0aGF0IHRoZSBjb2RlIGhlcmUgaXMganVzdCB0byBtYWtlIHN1
cmUNCj4gdGhhdCB3ZSBkb24ndCAqY2xlYXIqIFBDSV9FWFBfTE5LQ1RMX1JDQiB3aGVuIHdlIHdh
bnQgaXQgc2V0IGJ1dCBhDQo+IHR5cGUgMiByZWNvcmQgbWlnaHQgY2xlYXIgaXQgYnkgbWlzdGFr
ZS4NCg0KQ29tbWl0IGU0MjAxMGQ4MjA3ZiAoIlBDSTogU2V0IFJlYWQgQ29tcGxldGlvbiBCb3Vu
ZGFyeSB0byAxMjggaWZmIFJvb3QgUG9ydCBzdXBwb3J0cyBpdCAoX0hQWCkiKSBmaXhlcyB0aGUg
Im9wcG9zaXRlIiBjYXNlLCB3aGVyZSBfSFBYIHNldHMgdGhlIFJDQiBldmVuIHRob3VnaCB0aGUg
UkMgZG9lcyBub3Qgc3VwcG9ydCBpdC4gVGhhdCBjb21taXQgcmVtb3ZlcyBhbnkgUkNCIHNldHRp
bmcgZnJvbSB0aGUgdHlwZSAyIHJlY29yZCBmcm9tIHRoZSBlcXVhdGlvbiwgYW5kIHNldHMgUkNC
IGlmIHRoZSBSQyBoYXMgdGhlIGJpdCBzZXQuIEFuZCB0byBtZSwgdGhhdCBzZWVtcyB0byBiZSB0
aGUgY29ycmVjdCBiZWhhdmlvdXIuDQoNCj4gV2Ugc2hvdWxkIGF1ZGl0IFBDSV9FWFBfTE5LQ1RM
X1JDQiB1c2FnZSB0byBiZSBzdXJlIHRoYXQgaWYgd2UgcmVtb3ZlDQo+IHRoaXMgY29kZSwgUENJ
X0VYUF9MTktDVExfUkNCIHdpbGwgc3RpbGwgYmUgc2V0IHdoZW5ldmVyIGl0IG5lZWRzIHRvDQo+
IGJlIHNldC4gIElmIHdlIHJlbHkgb24gdGhlIGV4aXN0ZW5jZSBvZiBhbiBfSFBYIHR5cGUgMiBy
ZWNvcmQgZm9yIGl0DQo+IHRvIGJlIHNldCwgdGhhdCB3b3VsZCBiZSBjb21wbGV0ZWx5IHdyb25n
Lg0KDQpJJ2wga2VlcCB0aGUgUkNCIHR3ZWFraW5nIGFzIGlzIGFuZCBhZGQgdGhlIHBjaV9pbmZv
KCkgbG9nZ2luZyBpZiB0aGUgdHlwZSAyIHJlY29yZCBhdHRlbXB0cyB0byBjaGFuZ2UgYW55IGJp
dHMgaW4gdGhlIExpbmsgQ29udHJvbCByZWdpc3Rlci4NCg0KDQpUaHhzLCBIw6Vrb24NCg0K

