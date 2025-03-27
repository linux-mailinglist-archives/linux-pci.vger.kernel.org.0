Return-Path: <linux-pci+bounces-24835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA93A72F13
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92439188B911
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D1020D514;
	Thu, 27 Mar 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sUzMxPyn";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Jql75Ip4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074B1FF7BC;
	Thu, 27 Mar 2025 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074795; cv=fail; b=p9vcOxtvTdgeUlEv6D1+wK0fnb+V2DEgBFHvZCBx7ej4AXZfAhOkMaqgoT/ejQuXZXkRuQjmy6Q8N3cIvBchhC+UhMADRl/ZqZltyszyWg6fBO6ZRnKZbrUjdXct8aGv1GtWYEzyHRwh4FCqbuAxa+r8iYwRGlkCcxXjos+8Dgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074795; c=relaxed/simple;
	bh=Jh1sY725FJOox4qWrmu/+aSeXIQuzrG0w6JaZy6vKpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZurqsZXgT+c3hDPcSi1U6PdQUpxaWRL3DVAmyB/sLGEwq75TdjRkn4SMJyLIp5oTzWuVj6sWyVJAVaohcHXk2WaF+mKc7WPIs8oVeuH10CEud1iRh6CXfNquZfL9+J3t7AZiH1H9KjKpgnm3WbXhtv2G/hkCrz6ntH/4O6UtUSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=sUzMxPyn; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=Jql75Ip4; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7q1NR021632;
	Thu, 27 Mar 2025 04:26:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=usbjVg2oukNi5CLtVLP0b6Ax1dEm0pSoXksX7x1+tf0=; b=sUzMxPynS7+u
	kF2LvZ1O1kxdE2pPWHF0sAgBNfc76O4Z1AyO27s2N8MBNpuUpTe66PmMXJ4vHhoI
	m5viJdPaMHrFnpZ6LcBOZkx1c6HgwZL+rVLNOeNTSKzIG7pwYRDbDgh67HUJVpbw
	OLnuNIsy+iM3ObApubq6B5HftljuDk29RAjdpI//NlhX/IYb4VLkYPU85zzBA2Mu
	DShpxmR6/4XDVziRgP3QBSKaeo5XnGQM7G+mWKSf2gVyLTXOMxaTuQUxlmMXdiCv
	tLeyPBQruoKVh/4btZYHmpNgB9i5/keEh4HYc2QVIoKhvNwTrRgDCT6mgP2A5sME
	zvuISeGIWw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrsx50td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4d6zsodiiLqr25LOlXGBciHTjS85BjAb2jLy5IATWp4Y//o330H/fOa4zoUrdZc1L6UDBR6PNhQdN7uaTKEpNrhjb4SNh0IGKg2ar5ooDNVKZBfaF2Be1s6Oj7krOoYhf2Zo+plyFD/y9d/aXSSldBCw8xWclx/J+gsqTEE5d39TeQBxgO7jgrapG6LHzSyn4Lvzo/NWIc3bWJ7o0i97QNNU/iD3IoW5tzuVr3so+sWwW11umwSpaEE/OBOnBXHIk3FgVm/63f9eJdHCnxvE3Xuf9C6isp5+PCaA6tUN7M2lfDm1PMZAHJRXXZwSatPznUES7kfutoqXQ2A15kQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usbjVg2oukNi5CLtVLP0b6Ax1dEm0pSoXksX7x1+tf0=;
 b=QiGe5ejKfyLirqZms35G9m6xzcY+o+n+JgRIe7oxUEWCiuF4NrfTAERnkoFi+lIVk0S3fRpoL3UAY0lCAbkXNHiIumIWj5BxUdGpTPcrSSVYmd/meTMv2g5+DHks6CBvAT2ZOWjRFdYsI3vTLL0L5v7fGISK7xc1TEpj+y9AkZ82RqK2TgFGmJ7YV6EVzH9c0picl+lSdJV3KPWjBtX5ZgW/HvCQ8GsaAK2LPTbhXUI0fhAQnAQgkfuELASN6CtQRQDoG4tJXk1TCTfyu8nC6nFTuIwhUAlm9JXol7758TzuVxueeB66piBEaYI059ik1YY5G4rGOTqg1StYioQShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usbjVg2oukNi5CLtVLP0b6Ax1dEm0pSoXksX7x1+tf0=;
 b=Jql75Ip4f0nN/+Sus5HcpwqMWUQCBINkNXTADcZ+kS6usCNd44I/t+l7gaqCHdwX14Iis8cqtpHFcgGOqLG+Es3jy0N1nv4FFs25L/fJTGIs6KZ759+c5BYQmaIok17l3STMj9cYemojxVE/hiGoOzgEPeoPFscvE2q0X7voK5I=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BLAPR07MB7793.namprd07.prod.outlook.com
 (2603:10b6:208:29b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 27 Mar
 2025 11:26:22 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:26:21 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] PCI: cadence: Add header support for PCIe next generation
 controllers
Thread-Topic: [PATCH 2/7] PCI: cadence: Add header support for PCIe next
 generation controllers
Thread-Index: AQHbnwkCpgh5QvQSuU67PmiD5J2SNrOG17lg
Date: Thu, 27 Mar 2025 11:26:21 +0000
Message-ID:
 <CH2PPF4D26F8E1CE94EC3F4A0D6B9849818A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111127.2947944-1-mpillai@cadence.com>
In-Reply-To: <20250327111127.2947944-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00YzIwZjAyMS0wYWZlLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcNGMyMGYwMjMtMGFmZS0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIzOTk4MiIgdD0iMTMzODc1?=
 =?us-ascii?Q?NDgzNzczODUyODM4IiBoPSJxSktIT0JSclQyYzVjSWl6ZmRmSlV5UksxZVE9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFOWUhBQUNtWEhrT0M1L2JBWEFSNi9MOVhqUUdjQkhyOHYxZU5BWUpBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFDT0JRQUEvZ1VBQU5nQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQXg5YU81UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR1FBYmdCZkFIWUFhQUJrQUd3QVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUhN?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWJ3QnVBSFFBWlFC?=
 =?us-ascii?Q?dUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQWRBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJm?=
 =?us-ascii?Q?QUdFQWN3QnRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZd0J3QUhBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFGOEFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQXdB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBR1lBYndCeUFIUUFjZ0JoQUc0QUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFa?=
 =?us-ascii?Q?QUJsQUY4QWFnQmhBSFlBWVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?us-ascii?Q?QUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0J3QUhrQWRB?=
 =?us-ascii?Q?Qm9BRzhBYmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFISUFkUUJpQUhrQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQU5nQkFBQUFBQUFBSEFBQUFBRUFBQUFBQUFBQWswT2cxZ0FmVkU2eUE1UkpVYmVvaXh3QUFBQUJBQUFBQUFBQUFPVTFnSUtWZElWQm0zRkRyWU9PeU9JbUFBQUFBUUFBQUI0QUFBQUFBQUFBWXdCdkFHUUFaUUJmQUdNQWJ3QnNBRzhBYmdBQUFISUJBQUFKQUFBQUxBQUFBQUFBQUFCakFHUUFiZ0JmQUhZQWFBQmtBR3dBWHdCckFHVUFlUUIzQUc4QWNnQmtBSE1BQUFBa0FBQUFkQUFBQUdNQWJ3QnVBSFFBWlFCdUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBbUFBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QmhBSE1BYlFBQUFDWUFBQUJmQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY0FCd0FBQUFKQUFBQUFNQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCekFBQUFMZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWmdCdkFISUFkQUJ5QUdFQWJnQUFBQ2dBQUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdvQVlRQjJBR0VBQUFBc0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QndBSGtBZEFCb0FHOEFiZ0FBQUNnQUFBQUFBQUFBY3dCdkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFISUFkUUJpQUhrQUFBQT0iLz48L21ldGE+
x-dg-rorf: true
x-dg-tag-bcast: {7FF4CCB8-0673-4548-995C-62232765B6C0}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BLAPR07MB7793:EE_
x-ms-office365-filtering-correlation-id: 66a33e2f-7c80-4f01-fae1-08dd6d223392
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tSsCcOsgBbF0EuUw07SPd0cUYSR3nBHT2Xy//ctDPianzOKpAiPoGHCgr90d?=
 =?us-ascii?Q?2Z1iOo01zJkANT1pA8ZLBIgXN959zp2wew1SGNKsf9NQlmfmLT5o4E7wgxkU?=
 =?us-ascii?Q?L0YlFr69a9pMvRZPYyQGnvRdDh1o5BSwXVO38/Jrd2Z5onS1sH9ZaTU6qGt0?=
 =?us-ascii?Q?uAPLb9Av8q24Feapnu535zSzwMDgh8g+xRoNACU4Lr2ndoCbhQ7z/5vcCGHv?=
 =?us-ascii?Q?zDuunOCTTtNgjmS1kjjwpwqqPGTFCyQRWtyx8XyD1gD/hqOsoGFyiRg1VUpX?=
 =?us-ascii?Q?k/C0y0rEKkheidHP7E7gigYYkSIGSo/hmn1pDb+iuiAz+Jz250DR1NAfuSKP?=
 =?us-ascii?Q?AePgAb1DrIeiiVOQyRDVVANWeq7crEUgWdjh/hAYKxVTwEJqYShECkKH4GgH?=
 =?us-ascii?Q?lW7Pq3CT8R+tU7FYAwlGUpLomFyhV4pRdGFHB0GIDVnC2LM7mpEefAjwGByx?=
 =?us-ascii?Q?cSTGcThlE6QBC20L1+6JPJy4bxQzOKXS004aSC6JYVBovJvag2TPe7v3Mfzl?=
 =?us-ascii?Q?foY/5FfW0fcoCcfYQZ0DL45NHrauyXAB4+51qh/3K2LP9FKnJbxetQeE1fKm?=
 =?us-ascii?Q?xnqpWStQh4paxYdXrpecf2DlbvzT4sGG5LGS9LB4Vhs36QtPGNqfS2tfMMha?=
 =?us-ascii?Q?w3UU/A1fpcXT+H/heT+hxeIW7Pvg/rjXpn6u+QkaBCz19B+84Dl80xISEc+X?=
 =?us-ascii?Q?eGEmWwCo3c1SgU61JETx8rYXc5QfuDNL3pYfg6jECNxrUT7azc8HVRdYEtdp?=
 =?us-ascii?Q?hWNlU/Q2XdQdMCLd4ec8eT53yXaP+jAgOQftW+iG2Ol9fzQhIGpt0XHkT7j9?=
 =?us-ascii?Q?gjwyV1gVjEExoTvk7GHAOa7rRx3OzkcgTiw2YQ1/xFIW1wO0Qo9mvJ73ImoJ?=
 =?us-ascii?Q?JwSfvqPm4TA15kIMYMFOieQE/r8uRSNKm23AtragOg1usAzhP5VZZbc3Omcz?=
 =?us-ascii?Q?EE5sZsyhsl4liOlJkA4rCC7RhPlq0ZuyYy0vgMHKckuTAlJ6u7briOpF7y2n?=
 =?us-ascii?Q?slr5hTo+5v33H4uAJyufiq1sAT/06YYHEd06Haiq8YMQYXNUkpSQUJ9uaC15?=
 =?us-ascii?Q?kafShYn3cevBVHEaLx/XfdB+vX2ZojcKwHJpgkbdL0ZlFA2emG/EL4r7v6kA?=
 =?us-ascii?Q?wqzdtvGvSCsv+Z0GK/F6AmVcsChV9dXnuIFdgAwETAL+b3iAnLVOd5JuSkKU?=
 =?us-ascii?Q?cuGWtSGkKoukXtynQe3i/YvKEBXMY7UfkE/ArV+hPAxp1SaDti8qnd9iUaEp?=
 =?us-ascii?Q?4M924whwKiFNYQUOCdOXZ9oPLWxTRtzia2olX7WhwJGj9uELpivIiIFwxrgg?=
 =?us-ascii?Q?O2Eh+G7iDIg0PefZmuF6RPIu2FEOisHRwf3vVDc4Y5lQ0mcjtIqp90LQIy1L?=
 =?us-ascii?Q?iH0xjZ93vKQoWBeXWDY/mxJFQ+m5mIVvr6Wo8rUMeibOAgGgv7X9tRBeZ2jj?=
 =?us-ascii?Q?YVRU993lg8VNKLVEO/oxkm/ImOtKDWxc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0yOcxEOBySOQSXoR/BxAq7eQhMyCLHDCeOmA0jnk4GEEN93U73C6XvU3CtpA?=
 =?us-ascii?Q?ODW8BirNbHwoRyRGtIi6mr8qYJnB98rvKj8Px5pBogoOMppCHKKASQNMq2Yq?=
 =?us-ascii?Q?ODFN3OVfw4pXk8l6gmfdHH1/+W4U71OrOSA2sReaMFP/Zwbaur2Iqon9omYa?=
 =?us-ascii?Q?B4yjjuuMi2PbLW2h9+Yc92IWGpHkGd30f7zKtuRVetLbrbie1V2xDQptJICF?=
 =?us-ascii?Q?gr4XATM+Jj+d8fNGPTsFu1r4p2Fkfm4Fw2XnvJebvB1sDYYi47TtNnsI8x1t?=
 =?us-ascii?Q?Jw8fprmO9/xDWQNPlampsNPm/LCJN0j0YW6rKSJOp4atR3otFdyvFsY7/Oad?=
 =?us-ascii?Q?RDrrteMiqhIFLDZnkcWg9VqBMXdpPCuDR37QZhjAjHDAER1PCR3HKnHAPs4o?=
 =?us-ascii?Q?opA24tZF3NmPr27DVxJoZDWKTcK1at4no22UlVtyu4gmVeRu/Lw/UQSXBJA5?=
 =?us-ascii?Q?q1zWD2LmgDshygWi+95XyJzuCATOoq4yC97q5+PbVoFuHdpiHIgqQ98hI3+e?=
 =?us-ascii?Q?uEoYYxG+i9nrjSm1tyEzWjNLUH/SUD+TtrCOv/GZOsImhdeh56BGiycxvutD?=
 =?us-ascii?Q?z+03ZMlnrwDz0zJxGwiLB8h8PaWtNCk7TS6xgQr0H5hGKBv8Fv+CmIGoFF3i?=
 =?us-ascii?Q?FxvdD8ra7/dio1w7ZXwSJy7myw/wRzz0oEe1NMk5I7tBOVpGCCgEwdv2EXIw?=
 =?us-ascii?Q?JFuFo/HQgo5L1OIAQ/B6pxlc+BanigMF9EafUCTko1H/l7S1UBVNBhTXpS4k?=
 =?us-ascii?Q?26dcO+TTjQestdtODOuD6Uc5BsGAAGGRtV+ZbAGQgO0LFOcG8uQn4hIzq13/?=
 =?us-ascii?Q?guMJHWQVa5w6NQSPwWj0f9ECu9ejaWEVxpRPNemnlrzyffXgOWT6p6sTaV89?=
 =?us-ascii?Q?V7J57bWpyxsOoAQUFBKNGJJytEbtD5b/irS28IjKKnH+IP8/nBZ09+bNJSbq?=
 =?us-ascii?Q?eilRjDtpB3+aSqS3Neda34Ck78AOyggKyiEvULnfjOo4Ad2Ir5u2eXbrG08l?=
 =?us-ascii?Q?5nxi5W0ooPedsi7SBJC/pJnyNwSgQz8ROlikVFokmYR4mKDScGdavSMujEJd?=
 =?us-ascii?Q?Ip8wZ8bGSDRJZY0dffslcojDxnVUExVG0DcmM83FbOp6oTnprlXpFdwtqO2l?=
 =?us-ascii?Q?zmKz6R+UsjH99ruJD9UZsEih6f2gFx1McgDqMY/UVI8f+aahV8dWbVO/bffj?=
 =?us-ascii?Q?eahplRh0nxie3n3y+MouM1pfZinbU8W7va63gdMR3OUyBmS9TOucAaPRAO3/?=
 =?us-ascii?Q?p8mpk2t08YbgqfFaXx0Y5WUdGPTOsVBJvUjfJhdq6iqMz+0SLzkLL7VXm5Mz?=
 =?us-ascii?Q?rqD/yD323Ptp8jpx+X56sfh72SsFoJl91vdLcUOGUts0vpGzhIm6V0CED3Jb?=
 =?us-ascii?Q?EEW3XQByHxlCBMEX//FWyIYlQpOeOCXsb390iZIXCvOGQhEWztaiJmoMnbO0?=
 =?us-ascii?Q?VA9gvy0srPMrgMjGnGhBCGwx02dB5VJjLS1RRa/eqv3hoBwbtqzwZaAl2Gn9?=
 =?us-ascii?Q?gN4lpl/wS+XoWGvzMFJe4eqap7t/hnlADH8F/DYVvHVpiwQjh6GXJDPBa6qH?=
 =?us-ascii?Q?46DyKJkjjzWXSn/39NrOLLmjfBmnNP5i8bQYNCSz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a33e2f-7c80-4f01-fae1-08dd6d223392
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:26:21.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6c2a5wlpyPMMsR46esQpB0pcWfBWn91/FW1cFQgXN2FbUw6lqyY2K46VOvSC/7q14+cLOutSozwHWwe8o1ri699iOlvjceHxAKzfQHRWWyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7793
X-Proofpoint-GUID: AZh0qAZkt2FP3gCzsGavZUI7gA3-kZSa
X-Proofpoint-ORIG-GUID: AZh0qAZkt2FP3gCzsGavZUI7gA3-kZSa
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e535e0 cx=c_pps a=K1+iGLXgNHoxMcL4Lb8acQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=gbwXESoOiLeZs7cBM1EA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270078

Add the required definitions for register addresses and register bits
for the next generation Cadence PCIe controllers - High performance
rchitecture(HPA) controllers. Define register access functions for
SoC platforms with different base address

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../controller/cadence/pcie-cadence-host.c    |  12 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 365 +++++++++++++++++-
 2 files changed, 370 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/p=
ci/controller/cadence/pcie-cadence-host.c
index 8af95e9da7ce..1e2df49e40c6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -175,7 +175,7 @@ static int cdns_pcie_host_start_link(struct cdns_pcie_r=
c *rc)
 	return ret;
 }
=20
-static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	u32 value, ctrl;
@@ -215,10 +215,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_=
pcie_rc *rc)
 	return 0;
 }
=20
-static int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
-					enum cdns_pcie_rp_bar bar,
-					u64 cpu_addr, u64 size,
-					unsigned long flags)
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags)
 {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	u32 addr0, addr1, aperture, value;
@@ -428,7 +428,7 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pc=
ie_rc *rc)
 	return 0;
 }
=20
-static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc=
)
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie =3D &rc->pcie;
 	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/co=
ntroller/cadence/pcie-cadence.h
index f5eeff834ec1..69c59c10808e 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -218,6 +218,203 @@
 	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
 	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
=20
+/*
+ * High Performance Architecture(HPA) PCIe controller register
+ */
+#define CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
+#define CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
+#define CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x01020000
+/*
+ * Address Translation Registers(HPA)
+ */
+#define CDNS_PCIE_HPA_AXI_SLAVE                 0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER                0x03002000
+/*
+ * Root port register base address
+ */
+#define CDNS_PCIE_HPA_RP_BASE			0x0
+
+#define CDNS_PCIE_HPA_LM_ID			0x1420
+
+/*
+ * Endpoint Function BARs(HPA) Configuration Registers
+ */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0C)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(9, 4) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTU=
RE_MASK(b)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)=
))
+
+/*
+ * Endpoint Function Configuration Register
+ */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02c0
+
+/*
+ * Root Complex BAR Configuration Register
+ */
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG 0x14
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE BIT(20)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS BIT(21)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE           BIT(22)
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS           BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Comple=
x */
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED              0x0
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS             0x3
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS            0x1
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS   0x9
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS            0x5
+#define CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS   0xD
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
+		(((aperture) - 7) << ((bar) * 10))
+
+#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
+#define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Root Port Registers PCI config space(HPA) for root port function
+ */
+#define CDNS_PCIE_HPA_RP_CAP_OFFSET	0xC0
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r)            (0x1010 + ((r) =
& 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) (0x1014 + ((r) & 0x1F) * 0=
x0080)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)              (0x1008 + ((r) & =
0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK       GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)          (0x100C + ((r) & 0x1F=
) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK    GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK  GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r)            (0x1018 + ((r) & 0x=
1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS    BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/*
+ * Region r AXI Region Base Address Register 0
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r)          (0x1000 + ((r) & =
0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK  GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
+
+/*
+ * Region r AXI Region Base Address Register 1
+ */
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r)          (0x1004 + ((r) & =
0x1F) * 0x0080)
+
+/*
+ * Root Port BAR Inbound PCIe to AXI Address Translation Register
+ */
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar)             (((bar) * 0x0008=
))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK       GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar)             (0x04 + ((bar) *=
 0x0008))
+
+/*
+ * AXI link down register
+ */
+#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0     0x0400
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+#define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
+
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0   0x0420
+
+#define CDNS_PCIE_HPA_RP_MAX_IB     0x3
+#define CDNS_PCIE_HPA_MAX_OB        15
+
+/*
+ * Endpoint Function BAR Inbound PCIe to AXI Address Translation Register(=
HPA)
+ */
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar)   (((fn) * 0x0040) =
+ ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar)   (0x4 + ((fn) * 0x=
0040) + ((bar) * 0x0008))
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED =3D -1,
 	RP_BAR0,
@@ -249,6 +446,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
=20
 struct cdns_pcie;
+struct cdns_pcie_rc;
=20
 enum cdns_pcie_msg_code {
 	MSG_CODE_ASSERT_INTA	=3D 0x20,
@@ -281,11 +479,59 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
=20
+enum cdns_pcie_reg_bank {
+	REG_BANK_IP_REG,
+	REG_BANK_IP_CFG_CTRL_REG,
+	REG_BANK_AXI_MASTER_COMMON,
+	REG_BANK_AXI_MASTER,
+	REG_BANK_AXI_SLAVE,
+	REG_BANK_AXI_HLS,
+	REG_BANK_AXI_RAS,
+	REG_BANK_AXI_DTI,
+	REG_BANKS_MAX,
+};
+
 struct cdns_pcie_ops {
 	int	(*start_link)(struct cdns_pcie *pcie);
 	void	(*stop_link)(struct cdns_pcie *pcie);
 	bool	(*link_up)(struct cdns_pcie *pcie);
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
+	int	(*pcie_host_init_root_port)(struct cdns_pcie_rc *rc);
+	int	(*pcie_host_bar_ib_config)(struct cdns_pcie_rc *rc,
+					   enum cdns_pcie_rp_bar bar,
+					   u64 cpu_addr, u64 size,
+					   unsigned long flags);
+	int	(*pcie_host_init_address_translation)(struct cdns_pcie_rc *rc);
+	void	(*pcie_detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
+	void	(*pcie_set_outbound_region)(struct cdns_pcie *pcie, u8 busnr, u8 fn,
+					    u32 r, bool is_io, u64 cpu_addr,
+					    u64 pci_addr, size_t size);
+	void	(*pcie_set_outbound_region_for_normal_msg)(struct cdns_pcie *pcie,
+							   u8 busnr, u8 fn, u32 r,
+							   u64 cpu_addr);
+	void	(*pcie_reset_outbound_region)(struct cdns_pcie *pcie, u32 r);
+};
+
+/**
+ * struct cdns_pcie_reg_offset - Register bank offset for a platform
+ * @ip_reg_bank_off - ip register bank start offset
+ * @iP_cfg_ctrl_reg_off - ip config contrl register start offset
+ * @axi_mstr_common_off - AXI master common register start
+ * @axi_slave_off - AXI skave offset start
+ * @axi_master_off - AXI master offset start
+ * @axi_hls_off - AXI HLS offset start
+ * @axi_ras_off - AXI RAS offset
+ * @axi_dti_off - AXI DTI offset
+ */
+struct cdns_pcie_reg_offset {
+	u32  ip_reg_bank_off;
+	u32  ip_cfg_ctrl_reg_off;
+	u32  axi_mstr_common_off;
+	u32  axi_slave_off;
+	u32  axi_master_off;
+	u32  axi_hls_off;
+	u32  axi_ras_off;
+	u32  axi_dti_off;
 };
=20
 /**
@@ -305,10 +551,12 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	struct device		*dev;
 	bool			is_rc;
+	bool			is_hpa;
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
 	const struct cdns_pcie_ops *ops;
+	struct cdns_pcie_reg_offset cdns_pcie_reg_offsets;
 };
=20
 /**
@@ -386,6 +634,40 @@ struct cdns_pcie_ep {
 	unsigned int		quirk_disable_flr:1;
 };
=20
+static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_p=
cie_reg_bank bank)
+{
+	u32 offset;
+
+	switch (bank) {
+	case REG_BANK_IP_REG:
+		offset =3D pcie->cdns_pcie_reg_offsets.ip_reg_bank_off;
+		break;
+	case REG_BANK_IP_CFG_CTRL_REG:
+		offset =3D pcie->cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off;
+		break;
+	case REG_BANK_AXI_MASTER_COMMON:
+		offset =3D pcie->cdns_pcie_reg_offsets.axi_mstr_common_off;
+		break;
+	case REG_BANK_AXI_MASTER:
+		offset =3D pcie->cdns_pcie_reg_offsets.axi_master_off;
+		break;
+	case REG_BANK_AXI_SLAVE:
+		offset =3D pcie->cdns_pcie_reg_offsets.axi_slave_off;
+		break;
+	case REG_BANK_AXI_HLS:
+		offset =3D pcie->cdns_pcie_reg_offsets.axi_hls_off;
+		break;
+	case REG_BANK_AXI_RAS:
+		offset =3D pcie->cdns_pcie_reg_offsets.axi_ras_off;
+		break;
+	case REG_BANK_AXI_DTI:
+		offset =3D pcie->cdns_pcie_reg_offsets.axi_dti_off;
+		break;
+	default:
+		break;
+	};
+	return offset;
+}
=20
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 v=
alue)
@@ -398,6 +680,27 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pc=
ie, u32 reg)
 	return readl(pcie->reg_base + reg);
 }
=20
+static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
+					enum cdns_pcie_reg_bank bank,
+					u32 reg,
+					u32 value)
+{
+	u32 offset =3D  cdns_reg_bank_to_off(pcie, bank);
+
+	reg +=3D offset;
+	writel(value, pcie->reg_base + reg);
+}
+
+static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
+				      enum cdns_pcie_reg_bank bank,
+				      u32 reg)
+{
+	u32 offset =3D  cdns_reg_bank_to_off(pcie, bank);
+
+	reg +=3D offset;
+	return readl(pcie->reg_base + reg);
+}
+
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr =3D PTR_ALIGN_DOWN(addr, 0x4);
@@ -444,6 +747,8 @@ static inline void cdns_pcie_rp_writeb(struct cdns_pcie=
 *pcie,
 {
 	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
=20
+	if (pcie->is_hpa)
+		addr =3D pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
 	cdns_pcie_write_sz(addr, 0x1, value);
 }
=20
@@ -452,6 +757,8 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie=
 *pcie,
 {
 	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
=20
+	if (pcie->is_hpa)
+		addr =3D pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
 	cdns_pcie_write_sz(addr, 0x2, value);
 }
=20
@@ -459,6 +766,8 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *=
pcie, u32 reg)
 {
 	void __iomem *addr =3D pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
=20
+	if (pcie->is_hpa)
+		addr =3D pcie->reg_base + CDNS_PCIE_HPA_RP_BASE + reg;
 	return cdns_pcie_read_sz(addr, 0x2);
 }
=20
@@ -525,6 +834,22 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
 int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
 void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags);
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);
+int cdns_pcie_host_init(struct cdns_pcie_rc *rc);
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn=
, int where);
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags);
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc);
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
+
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 {
@@ -546,6 +871,34 @@ static inline void __iomem *cdns_pci_map_bus(struct pc=
i_bus *bus, unsigned int d
 {
 	return NULL;
 }
+
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn=
, int where)
+{
+	return NULL;
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags)
+{
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
 #endif
=20
 #ifdef CONFIG_PCIE_CADENCE_EP
@@ -556,7 +909,10 @@ static inline int cdns_pcie_ep_setup(struct cdns_pcie_=
ep *ep)
 	return 0;
 }
 #endif
-
+bool cdns_pcie_linkup(struct cdns_pcie *pcie);
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
+int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
=20
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn=
,
@@ -571,6 +927,13 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie =
*pcie, u32 r);
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
 int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+				       u32 r, bool is_io, u64 cpu_addr, u64 pci_addr, size_t size);
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pc=
ie,
+						      u8 busnr, u8 fn, u32 r, u64 cpu_addr);
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
=20
 #endif /* _PCIE_CADENCE_H */
--=20
2.27.0


