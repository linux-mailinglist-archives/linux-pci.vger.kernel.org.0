Return-Path: <linux-pci+bounces-40073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07628C292BC
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8ABE4E433F
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0323D7DA;
	Sun,  2 Nov 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WyWcUoNs";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="3ExGPkZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98335971;
	Sun,  2 Nov 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101948; cv=fail; b=n/uYq5Nds5tadsZZb9JpXq6iSK0kNYCu1/eZ4dUhXbbEKyrmoASyJd5KTq3wzJ2ds8Gq552/8FFUwLxOj+E2X7IpOjrULYv/STONHM0nx2NL5Zd8OpUyoQQv+JtClP6NDjDwIJMi6bwgZddlPyUHq7C/veoP573MhVjzN/8W8IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101948; c=relaxed/simple;
	bh=4B9ATP9sX3O4NIA/k9NykphK3O96O5w2YMqeV10ugH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBxmtrc+2u1ck86sH38RUHFsVUgJVTE+xSqktCxcCTCbuxxdgWnNbOzivcfH5MMenxkbgk2N526MNRTKuicu3a/nEXnOioGp8H6K+USXZAEXq6BJZ2X5GnH0+MOtRgH+YdewV+0bY6q8DXbRuTlIhRkuX9fE5GTUrT32SDd6yic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=WyWcUoNs; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=3ExGPkZh; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A27AcZn1417378;
	Sun, 2 Nov 2025 07:53:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=4B9ATP9sX3O4NIA/k9NykphK3O96O5w2YMqeV10ugH4=; b=WyWcUoNs0exM
	WZUxfu4Qn/QOk201QHEnvfY6TWGqBBaMf6ryRhXL5F0Rkpr8sv4ALWuuDaTw77NX
	eVj2S/2QNMf5l563/0rZim0PfloXk2G01XyQ6kttcu680UQpFBp3xtnLa4pKGdL3
	AtDXywLVghdH6AXlAR7tCoJ9madi5HJ4L6HHBJ27FXfZeIiyiBDjfPSvu8Wfg3ws
	fVOIjb8wids8OebbOZNJx1g5+CvAdMAWILL6mdFCJLlCBaOD9u0HGtcRJLtno63m
	MXUcVSylUiK9AJoDMxG2gSErSTEtSBG0qTDC9vDPdnoVyFdngfwKU/GtLlJcvm3u
	tE34Psp/vw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4a5dsxcx8q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 07:53:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQDT37ZjyEO5VUX9N+Jmi/pA1HMaF17qipWKSRMW5RPpzU0SpSWKYDo98aKnvbbulDOdihXiN6ua8XUjiyG/r/KdYEeP25eGLS5ryKeKz8hR9qsIbqD+ZyQ7la6pUfrgFMI9bR9bvy5jEyTlXqsGdwSYSUGKbWrbzXuLRtC3TQA23CLgjTwy3ANXMr9SgSuWyRxglzsvdurDGEhlR7cm/ECkgWPfftOUttL7NWZzBF5SiahfBdDqQ9HdinYfQRWZmCRMWghT9bOdFDqTX44BdL+L5PLquZHG9WN0higPuPGlcOK0qVhZxmz62Bdh8OUNHycGD6javXg3GMmqb8uhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B9ATP9sX3O4NIA/k9NykphK3O96O5w2YMqeV10ugH4=;
 b=HuJWF2fLTztfvdr3TWymsdA5SfEJaVBpa4wQQbGuLTP152QaxFC0FI3pKuPHQDN04okUFLy/QDtKXl025omLyHcs5aeN+1/fvrUAWduWM1Us4JFqYztb4z/efhWt60hJDlLP6PFJr3wf+c3CbnYK6SDqCjlKP/w1IOQJtiDTm70Q04G1nEsjbYcRnPE+URCoMUdFoZMW7ZVkI1cYWeOg1MjYbAmLFfZqcXKPUPOtNvZS5Zn4frMTgjpTgOFauj1RjPCSLWfZ8x/j9WFsQ6NjVU+7eysqE5zBLMXs1/1XqqnIgq7EhIzMQL3utMJSfM3VF2omKOgIg3CsjEu2LhD3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B9ATP9sX3O4NIA/k9NykphK3O96O5w2YMqeV10ugH4=;
 b=3ExGPkZh+oA6xHAyeIi40opnH08FvqxXyDUbylZSRceo1pHGi2ftLS1UIvNsHPTGkOBFrPvONjrp68vbrK+1zdGaEm+6xCEZTmuvXrbpqpw6s57DbuW86ftH9RirEdVVqbU1dewp6BZYvhuzQgX9XIVM8sFYOjr07AwqSLDDoq8=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by LV9PR07MB11710.namprd07.prod.outlook.com
 (2603:10b6:408:366::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 15:53:02 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::94fb:f289:aeea:1d35]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::94fb:f289:aeea:1d35%5]) with mapi id 15.20.9275.015; Sun, 2 Nov 2025
 15:53:02 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "fugang.duan@cixtech.com"
	<fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com"
	<guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com" <cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Thread-Topic: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Thread-Index:
 AQHcQXoWEUMpe7PTXEWbAr9PiY4tfLTcCaEAgALQoSCAABkOAIAAAYcggACdO4CAAAuzgA==
Date: Sun, 2 Nov 2025 15:53:01 +0000
Message-ID:
 <CH2PPF4D26F8E1CB5EFC6AC9818A065A519A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-5-hans.zhang@cixtech.com>
 <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
 <CH2PPF4D26F8E1CFC4FF273AA07E283BBF3A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <2aanerkp7c4qd4mukz6oaxafe22assjyah2kdbdmyuich5hzha@k6hlzvarixxo>
 <CH2PPF4D26F8E1C0BE70D4B6BB9B3A334D9A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <jmxdju5aon3biunji6rplxmapb6j7ozet37olxtcknznqekw7p@a3bj7glbxc4n>
In-Reply-To: <jmxdju5aon3biunji6rplxmapb6j7ozet37olxtcknznqekw7p@a3bj7glbxc4n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|LV9PR07MB11710:EE_
x-ms-office365-filtering-correlation-id: a6e22294-fae0-4171-800f-08de1a27e74c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1N2bU9vcnRuMGJDdVJxT3pXM09RbnpPTklXQW55QVVkblhNR0dSQVN1bUVJ?=
 =?utf-8?B?MXArUnNnYlhrRWhuUzVSdGVLSDh6NEE1cldjTXZjczBxUTBJa01XZkYwT0Zm?=
 =?utf-8?B?bk5NSlBBaW83dDlFbVV1N3FsRWlEeUhEVWFTcG9uQXFseUtwTEIvTnpXZmho?=
 =?utf-8?B?LzdjQk9IQWp1NG5RcHlENWNqclloTjA4ZVBtYUJJYzNFbThkL2E3Zi9ONTlC?=
 =?utf-8?B?TElaME5TSjV4TUE0Y2lwcEE2UzNGUjFYN215anpBRUZIYWlPaGdxSlQyclJn?=
 =?utf-8?B?bTZ2R3dCZUVhWm1SaDZNM3kvemNNZTVwMGJXNHJoSC9VZnN6amtwK0RnQXZv?=
 =?utf-8?B?MlArMUw0M0s2L0FrcTdNQzYyUTB6dC9JYitKaW95Uy9iNldGZ3BrUlNGdXl1?=
 =?utf-8?B?SjFXakRXL2t1YlNCanVsdml5QkdKSXloV3VCalNlV21TejdaRWJranN0WmJo?=
 =?utf-8?B?Y3Mwa3g2bXd3Mk56dHlJbUJmbEhrWU9GUzQzaVRsUE4rV3FSOVA1dUN4bEZQ?=
 =?utf-8?B?VHRURGtkMDBESjFYTThpYURZQjVSOFRWUloyUjNtVUF1dU9MU3RsZzhjUHBs?=
 =?utf-8?B?clprcmNPUHBWT3N2VjJNcjVhWEM0NHZabTU4dHdyekQvQkI1TWsvU2lRQUdm?=
 =?utf-8?B?bFZ4K1VTM2dhUGxpYk1TdkZwRjIwU3RIVEFxVnFrT1VZOTI3SloxaFlrWXNv?=
 =?utf-8?B?eDNQNlVaaUE1MktVTFVIRm5sdkFUZDJlamx6MTZVSTVhSWQ0ODh2WkQ3RCtp?=
 =?utf-8?B?eVROWjJmdnhoM1FqMjY2ZG05SGxEb0NVbG4yUTU0ZXB6VXNDNlFjQWRNSENC?=
 =?utf-8?B?VDcrSlB1SzdmV245UEpIU0JOaS9wR2xGZnhHakFzSHpQaUNMSXRxdVpBVFRo?=
 =?utf-8?B?QytJakZTd0dYVFhoYmNjZktzZmlFbEcwaWJnMXYzUWVTWHllUGl4ZWFjYU84?=
 =?utf-8?B?ZXVseVlaUzYwR09VcHpWbXVDZnJCd3FzTjRIU0ZMODlDZ0JxK3RudG5IRkNM?=
 =?utf-8?B?dEpKTkU3RUphR21XcmplRnVxRG9RUVpzemlqM3pTVy92RmdVbGFYaHZwaW9X?=
 =?utf-8?B?UEc1MjhwQ3NOUVNVd1RBNzBneXNiaGpweWJYdmZXRkJNMmxYcDJaRFFiMVBJ?=
 =?utf-8?B?b1BCZUliTkIzdTRkdlFNVDYzcGljd3JPcjhrWFFDd3hXajl0cHRJbDE3bmZB?=
 =?utf-8?B?VVljeElheWt1dU9FWWxXVGtUVFpGclZaM0tTd2FhRGZ6N01URTJSUXFUSHQ3?=
 =?utf-8?B?dHR4YzMzcVZRb0srR25FRThSdEVjN3diNE9ZWE9iS2ZRblRyanJxc3p6V3BF?=
 =?utf-8?B?QzQ0R0tkeWk0bkowNUs0Zm5pUkRERlRmVE5XUXFoYXNaN01vL3RmZGlZQ0tF?=
 =?utf-8?B?TzBFRzhmN1Qwb1hFWHZPZ211UTdoRzFDdlorSGVYMUU1VlN5UitnWkg2L2pr?=
 =?utf-8?B?SmpVOUc1M3JYSEdneTlqeU05MU1LQzR4NEtvOGczaGw5b21URkZBejF1OGFP?=
 =?utf-8?B?cERMN1N2NmozQ2haaHBxaFQ2bWx3dXBWQksvUklxNHJaTWE4SGRHMDEyNDJS?=
 =?utf-8?B?VEtQL1NSem8wczM1MmEyR1VHQjVId0IvN01NNUwvdXkyQTU2ZEloa1lKOHJP?=
 =?utf-8?B?YWZCMElxeGpMRmhrTkwyZFRwM3V1NHRWUEVoYStKaUplQUZIWnlGenVuOERu?=
 =?utf-8?B?Tnp4VUxhVHp3MlFrUXJlaS9aNC9NcUZsS2pmMWRLWXVKSGxaTHVWaWl5b0pa?=
 =?utf-8?B?QU1MSjk1T042bm1mSlVtTmdxbUlDcHZzbENTV3VLZ3NDbnVXSW45NUZkUmNy?=
 =?utf-8?B?dDUxc2lnK0V5QnZxWjhQekV5d0JJT2h5UFdpdVl6SXlDeFd3dnU4SmVzL2d0?=
 =?utf-8?B?aHppVmxLcjFzdUk2Rk5iNk5pTnNzejJObWhYUWkwOHRIMlhNZ25zTVZNKzJj?=
 =?utf-8?B?Qy9aendOZHpHWjVpVk0zYVlzZ0ZHQjlLOEwycjUyK1lSQzVQdUNhaTJ4eXlR?=
 =?utf-8?B?N3FkNXdnY1BnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXF6YnVGR0VWalhtUVlMZWp6ek4yamhQQjNyME5PTHo4bTNmNUFicUdmMWxo?=
 =?utf-8?B?Unk5Mzd5ZkFJeE8veTNDNGVMZmdsSG1CRk55SzNueEQ0a1lVMXNjOC80S0dS?=
 =?utf-8?B?b1VBaGIyTlJ0ZSs1TldnbWprR2hpVGRxbUpWRHJQcnFXWkZzT3pha2NPdVhw?=
 =?utf-8?B?LzJYWWU0eXpjaW84bzRKblhOVnhyL1hCQXNyRkJmRVZBV1BlQlhIYTVLdmYw?=
 =?utf-8?B?YU10WEJaT2lndlBTeHZTaTdTQmxLMmc4bGFDMEZUTk5HOWNZRnRQbDJGbVE4?=
 =?utf-8?B?ZHNNNnJGbVZsQWZBajd6STFzbjk1eXhsQjd0ZnU4V2FSamxudG5Rd3IyMC9E?=
 =?utf-8?B?MVpxeEVNcllzSDViOXNjVldldE1BVU1xV2QwSEk4WTA5U2tYS2lYRXBKanVp?=
 =?utf-8?B?dmJNN0o0UnRuZ1k1SEdLTldXTVZ2ckpmeUdYSVozVGEydWE5Zmpsa3gzckpm?=
 =?utf-8?B?dzNiTDVzekVSWGR4SFdtMTJXSkMwOC9vbThvb0ZzRHJXNlpCckFzS1BweHI1?=
 =?utf-8?B?VVdnWEU2ZENBVEFseER2dXRGV2c4d2ZKUUFDS29rTEJRWlI3VVRDNlh4SW9L?=
 =?utf-8?B?aFE3QkxaSVRheVdSZWQwR1o0eWJOR0NaU2RkU2JiekhXTkdUSE5CQlp0YTVs?=
 =?utf-8?B?ZDlRRm1QdE1Ha0hqUHJyNmtXMTZTSjRJZTBTeUl0dUUrZ1gzNmxqb3ZReFlN?=
 =?utf-8?B?RDBObWtzMy9pb2V2aVo3MFVZd3pMRGlzRkdPUHZ5Q2xNSXlyZDRkbWd0SXFW?=
 =?utf-8?B?TXNUK0Y3RUNUek5sUGNGL3B3aDZidmQxSWJLK2x5UmM1Z2hvYVRnSlhGRkFO?=
 =?utf-8?B?d0xSaFhiR2VubTBUeWRJWWdVbHFRL2luc1V1YzJHNWlOazBDVy91anJ5bFdY?=
 =?utf-8?B?UmNqVzViY3NiSVlwV0IvWGFSMjdLMTA3anYzd3hHY2c0L0hUdndPYXN1VHFn?=
 =?utf-8?B?bnJtQkUrZmU2RHlUQ1M1blRoaTdKZHVaQ2NLUDRXRk8yVWFkTzg2Qkhod1g4?=
 =?utf-8?B?WjhqSzlBOHIxWERmZG1RVjZnR29hVzhOckRaSFI1ZTFOUnp1dTZWYXpIaEpW?=
 =?utf-8?B?c3FYcWhMUGZuZnY4ZFBIa29zc2ZuYnhiODhnNldRWHZFKzJnTjdERk5YYWtM?=
 =?utf-8?B?SHhramVYempjdkpRVUVWYnFwYUxONzgrazZoSDFuSjREVWN0Tk1STTBaZ0ZG?=
 =?utf-8?B?dDVCcG9qR2RpTW9jazdsSEl2TWNqMU0vWlQ4Yk15MnRiVEVVTCtackxYc051?=
 =?utf-8?B?NkhJT3lxU0tHRnNXeEVmcGhJUU5PTHpCNXZTL1htbGlsNjlnRkxKZHJOUml0?=
 =?utf-8?B?K1VNOWVVN2VTN0h5YnNKd3VuVmtZeWF1a3ZHSUlmS291KzdzcWE0QzBuaHFB?=
 =?utf-8?B?ZWc5eVI1VmdNZ1RwMGd0UFdDVTBlcjhTVHF6V3ZFejV5VWQ0YnZTb3h1cFVL?=
 =?utf-8?B?ZTlJWGR5dlhHUVBIUjFLcjNrZTE3QlZHdlVvalFCd0dONXJvN1NwYzdkdXMz?=
 =?utf-8?B?UlVRZzBhT2FheCtXUTdMekZlYmVXODh2aWR2NEV3TFRzSlltRG4wZXcyWUxo?=
 =?utf-8?B?TGY1NkY3S25zNi93S0F0bXJiMlUvZlJGdkJUUXFlZkJmaEpnVG9xNExEMDJY?=
 =?utf-8?B?SkZFbEdJTHBheENYa3ZyakxSL09kVC9SL3Nnbm9rdWZvUzJpVEdURC9FSjMy?=
 =?utf-8?B?S2E0VmFWblJIR3E0c3JwaWM5QjVBY0VpTkVrUHFzeUNIdndCU3ZsbDZYNERK?=
 =?utf-8?B?TWE5UFRnMDJQVzcyeDZBM3YrRklJd1BTd1FIK2hTcUV2SzEvWVJIQ1FHUkZS?=
 =?utf-8?B?OVZJeEd6dHNXSnhYYzFRUC9RbHVyeXc0UXJPLzVpT1Q0R0g3WkRlQm4zVW5E?=
 =?utf-8?B?TzNIUUU0UmpCb0hGdHAzd3ZYblI2RG4yOVZnUEIrNEVWWkQ5ZHFiOW41Yk9L?=
 =?utf-8?B?Y3JhaXVGSHdvZlk3TzdkNk1FS2pVcWRGU2dJSEgwangyVndrV3lWcm4rZEhG?=
 =?utf-8?B?bUZ3WFBIUjJHSy9venFhVVlBMnhYQzVFR3MvWVl5djJQVTFDKzdDSGVPMXEw?=
 =?utf-8?B?b0gwVThnWkFxWWcvakJqVmF5YTJEVVFLUHZHaUhiS2lLT2tIOEorSUlOQXNl?=
 =?utf-8?Q?YTCxX5ph5MjG0lUKbkHhlfR0m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e22294-fae0-4171-800f-08de1a27e74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2025 15:53:01.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmrxIw1wGsKf/KJZisZN6vDZ24yuY4NguETD95colOOG2T0foN4iBDIWiFm/sibmM6eGcqgeqv93oA8umeEUcWPgeLo5JkqFcvMdtseOpeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR07MB11710
X-Proofpoint-ORIG-GUID: o64s8CA0KpQDPW-VrwnE8USvC-_tBeYw
X-Proofpoint-GUID: o64s8CA0KpQDPW-VrwnE8USvC-_tBeYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE0NyBTYWx0ZWRfX0BsMJzqDt1k1
 8GQe8qPF8r7rLFaqnBbg4NiIDIeeS9Po06rlJ3OqCMV1ut9T/R4GvwkcqU0V5/R7kMapV9j1LIx
 NNmfcZDHG4bvMdT1Y7X1w/w4h68V1oTGYitrUyDY1/zq5QcVbdKQNfkXyEVKTV2aZqqyDuityvz
 1jlgzEpGwaFLx4//u1KGtRbogsaWorOqCow/bqvlXy4zqrXX8dhvp09lvuxrdLCfxFljRtdSNdn
 x+uV6YRN9gRqDVPdc3Tyh6ngLNhTrZEAkP0PZmA9SYwArDd/j1/i8XV1HgeXNZwtkMZVCQKvD2N
 wdVXDTstNrMZVwvrD/iXwaVVYYGzbcIZeRihPHhb3JcZRfR8jTgV5/Aidw4kGE+cKEQ7O/4RTp5
 NP84yKPkmdxtKvRhDm3Vem5tVmfu+Q==
X-Authority-Analysis: v=2.4 cv=VOrQXtPX c=1 sm=1 tr=0 ts=69077e60 cx=c_pps
 a=XSpaKd7YU/jha2kVJ1iHgQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=OLL_FvSJAAAA:8 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=TAThrSAKAAAA:8
 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=TJPbuVHWeBvPvIvRlwAA:9 a=QEXdDO2ut3YA:10
 a=9AiCCrjk5qwA:10 a=oIrB72frpwYPwTMnlWqB:22 a=WmXOPjafLNExVIMTj843:22
 a=8BaDVV8zVhUtoWX9exhy:22 a=TPcZfFuj8SYsoCJAFAiX:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511020147

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaUBrZXJuZWwub3JnPg0KPlNlbnQ6IFN1bmRheSwgTm92ZW1iZXIgMiwgMjAyNSA4
OjM4IFBNDQo+VG86IE1hbmlrYW5kYW4gS2FydW5ha2FyYW4gUGlsbGFpIDxtcGlsbGFpQGNhZGVu
Y2UuY29tPg0KPkNjOiBoYW5zLnpoYW5nQGNpeHRlY2guY29tOyBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBoZWxnYWFzQGtlcm5lbC5vcmc7DQo+bHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5j
b207IHJvYmhAa2VybmVsLm9yZzsNCj5rd2lsY3p5bnNraUBrZXJuZWwub3JnOyBrcnprK2R0QGtl
cm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+ZnVnYW5nLmR1YW5AY2l4dGVjaC5jb207
IGd1b3lpbi5jaGVuQGNpeHRlY2guY29tOw0KPnBldGVyLmNoZW5AY2l4dGVjaC5jb207IGNpeC1r
ZXJuZWwtdXBzdHJlYW1AY2l4dGVjaC5jb207IGxpbnV4LQ0KPnBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMDQvMTBdIFBDSTogY2FkZW5jZTogQWRkIHN1cHBv
cnQgZm9yIEhpZ2ggUGVyZg0KPkFyY2hpdGVjdHVyZSAoSFBBKSBjb250cm9sbGVyDQo+DQo+RVhU
RVJOQUwgTUFJTA0KPg0KPg0KPk9uIFN1biwgTm92IDAyLCAyMDI1IGF0IDA1OjUxOjA1QU0gKzAw
MDAsIE1hbmlrYW5kYW4gS2FydW5ha2FyYW4gUGlsbGFpDQo+d3JvdGU6DQo+PiBIaSBNYW5pLA0K
Pj4NCj4+IFBscyBmaW5kIG15IGNvbW1lbnRzIGJlbG93Lg0KPj4NCj4+ID4+ID4+ICsJCQl2YWx1
ZSB8PQ0KPj4gPj4gPkhQQV9MTV9SQ19CQVJfQ0ZHX0NUUkxfUFJFRl9NRU1fNjRCSVRTKGJhcik7
DQo+PiA+PiA+PiArCX0gZWxzZSB7DQo+PiA+PiA+PiArCQl2YWx1ZSB8PQ0KPkhQQV9MTV9SQ19C
QVJfQ0ZHX0NUUkxfTUVNXzMyQklUUyhiYXIpOw0KPj4gPj4gPj4gKwkJaWYgKChmbGFncyAmIElP
UkVTT1VSQ0VfUFJFRkVUQ0gpKQ0KPj4gPj4gPj4gKwkJCXZhbHVlIHw9DQo+PiA+PiA+SFBBX0xN
X1JDX0JBUl9DRkdfQ1RSTF9QUkVGX01FTV8zMkJJVFMoYmFyKTsNCj4+ID4+ID4+ICsJfQ0KPj4g
Pj4gPj4gKw0KPj4gPj4gPj4gKwl2YWx1ZSB8PSBIUEFfTE1fUkNfQkFSX0NGR19BUEVSVFVSRShi
YXIsIGFwZXJ0dXJlKTsNCj4+ID4+ID4+ICsJY2Ruc19wY2llX2hwYV93cml0ZWwocGNpZSwgUkVH
X0JBTktfSVBfQ0ZHX0NUUkxfUkVHLA0KPj4gPj4gPkNETlNfUENJRV9IUEFfTE1fUkNfQkFSX0NG
RywgdmFsdWUpOw0KPj4gPj4gPj4gKw0KPj4gPj4gPj4gKwlyZXR1cm4gMDsNCj4+ID4+ID4+ICt9
DQo+PiA+PiA+PiArDQo+PiA+PiA+PiArc3RhdGljIGludCBjZG5zX3BjaWVfaHBhX2hvc3RfYmFy
X2NvbmZpZyhzdHJ1Y3QgY2Ruc19wY2llX3JjICpyYywNCj4+ID4+ID4+ICsJCQkJCSBzdHJ1Y3Qg
cmVzb3VyY2VfZW50cnkgKmVudHJ5KQ0KPj4gPj4gPg0KPj4gPj4gPlRoaXMgYW5kIG90aGVyIGZ1
bmN0aW9ucyBhcmUgYWxtb3N0IHNhbWUgYXMgaW4gJ3BjaWUtY2FkZW5jZS1ob3N0Jy4gV2h5DQo+
PiA+ZG9uJ3QNCj4+ID4+ID55b3UgcmV1c2UgdGhlbSBpbiBhIGNvbW1vbiBsaWJyYXJ5Pw0KPj4g
Pj4NCj4+ID4+IFRoZSBmdW5jdGlvbiBjZG5zX3BjaWVfaHBhX2hvc3RfYmFyX2NvbmZpZygpIGNh
bGxzIGZ1bmN0aW9ucw0KPj4gPmNkbnNfcGNpZV9ocGFfaG9zdF9iYXJfaWJfY29uZmlnKCkNCj4+
ID4+IHdoaWNoIGlzIG5vdCBjb21tb24uIEFsbCBmdW5jdGlvbnMgdGhhdCBhcmUgY29tbW9uIGJl
dHdlZW4gdGhlIHR3bw0KPj4gPmFyY2hpdGVjdHVyZSBhcmUgbW92ZWQgdG8gdGhlDQo+PiA+PiBj
b21tb24gbGlicmFyeSBmaWxlIGJhc2VkIG9uIGVhcmxpZXIgY29tbWVudHMuDQo+PiA+Pg0KPj4g
Pg0KPj4gPlRoaXMgaXMgbm90IGEgZ29vZCByZWFzb24gdG8gZHVwbGljYXRlIHRoZSB3aG9sZSBm
dW5jdGlvbi4gWW91IGNvdWxkIGp1c3QNCj5tYWtlDQo+PiA+dGhlIGNvbW1vbiBmdW5jdGlvbiBh
Y2NlcHQgdGhlIGNhbGxiYWNrIGliX2NvbmZpZygpIGFuZCBwYXNzIGVpdGhlcg0KPj4gPmNkbnNf
cGNpZV9ob3N0X2Jhcl9pYl9jb25maWcoKSBvciBjZG5zX3BjaWVfaHBhX2hvc3RfYmFyX2liX2Nv
bmZpZygpLg0KPj4gPg0KPj4gPlRoaXMgcGF0dGVybiBjb3VsZCBiZSBkb25lIGZvciBvdGhlciBm
dW5jdGlvbnMgYXMgd2VsbC4gUGxlYXNlIGF1ZGl0IGFsbCBvZg0KPnRoZW0NCj4+ID5hbmQgbW92
ZSB0aGVtIHRvIGNvbW1vbiBsaWJyYXJ5LiBDdXJyZW50bHksIEkgY291bGQgc2VlIGEgbG90IG9m
DQo+ZHVwbGljYXRpb25zDQo+PiA+dGhhdCBjb3VsZCBiZSBhdm9pZGVkLg0KPj4NCj4+IFRoZSB2
ZXJ5IGZpcnN0IHBhdGNoICBmb3IgdGhpcyBmZWF0dXJlIGluY2x1ZGVkIGFuIG9wcyBzdHJ1Y3Qg
IHdoaWNoIHdhcw0KPnJlZ2lzdGVyZWQgKHZlcnkgc2ltaWxhciB0byBhIGNhbGxiYWNrKS4gQXJl
IGFyZSBhc2tpbmcgbWUgdG8gYWdhaW4gaW1wbGVtZW50DQo+dGhlIHNhbWUgZGVzaWduIHdoaWNo
IHdhcyBlYXJsaWVyIHJlamVjdGVkID8NCj4+DQo+DQo+WW91IGRpZG4ndCBwcm92aWRlIGFueSBs
aW5rIHRvIHRoZSBkaXNjdXNzaW9uLCBzbyBob3cgY2FuIEkgZGVjaWRlIHdpdGhvdXQNCj5sb29r
aW5nIGludG8gaXQ/DQoNCmh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzLy9kZXZpY2V0cmVl
L21zZzgxNDI3Ni5odG1sIA0KDQpQYXRjaCB2NSAtIDUvNSBoYXMgdGhlIGNvbW1lbnRzIG9uIGNh
bGxiYWNrLg0KDQo+DQo+PiBTZWNvbmRseSBleGNlcHQgdGhlIG5hbWVzIG9mIHRoZSBmdW5jdGlv
bnMsIHRoZSByZWdpc3RlcnMgYW5kIHRoZWlyIG9mZnNldA0KPndyaXR0ZW4gYW5kIHRoZSBzZXF1
ZW5jZSBhbHNvIGNoYW5nZXMgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbnMuDQo+Pg0KPg0KPkkgZG9u
J3QgdGhpbmsgc28uIEZyb20gYSBxdWljayBsb29rLCBhdCBsZWFzdCBjZG5zX3BjaWVfaHBhX2hv
c3RfYmFyX2NvbmZpZygpLA0KPmNkbnNfcGNpZV9ocGFfaG9zdF9tYXBfZG1hX3JhbmdlcygpIGFy
ZSBtb3N0bHkgc2ltaWxhci4gWW91IGNhbiBrZWVwIHRoZQ0KPmZ1bmN0aW9ucyBoYXZpbmcgZGlm
ZmVyZW50IHJlZ2lzdGVyIGNvbmZpZ3VyYXRpb25zLCBidXQgc2hvdWxkIHRyeSB0byBtb3ZlDQo+
b3RoZXJzLg0KPg0KPi0gTWFuaQ0KPg0KPi0tDQo+4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+N
IOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

