Return-Path: <linux-pci+bounces-20874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C27A2BFA6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F92216A782
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE691DE4E9;
	Fri,  7 Feb 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ol4/EeOA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="brGHC0NP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA831DE4E3;
	Fri,  7 Feb 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921249; cv=fail; b=iUUJx1GWA9kM3J9nmj7+I4CDqega/z2F96yL1illjrSfXg7mgGQ2Jn+zPBOqHaDMUWFBm9Oa9Jp2MMAf4hcg9IIVAHjTeLFy3NW9GR2Fdar4aP9ShQ0EUNRXhnYa8jl3bbmirBAF0dtyT4t4z3hn779vyUQiffS8YbSwV/PnNvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921249; c=relaxed/simple;
	bh=67oJym94rmCVZ4suBb6Zoqny50SnbZXsisG3WbD5AiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DgRcuUM5VDQZUJE/q2+ztG12nsu2tInwbPX3wWloH9yyrh85VIBxySYZ/TT7/4XIDyxYYUBthWzymbiN+L1D3QGh0XVslzgnxvC9c8jQ2AfGL5h2XwC1vZqeGB7tYePqY9rHJpgYqqxWJQpmEBHiovtUUECuH4hxMLlxP4z/R8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ol4/EeOA; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=brGHC0NP; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51781AWV027036;
	Fri, 7 Feb 2025 01:40:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=0jCYPLa/SDkSVsBwNhjp/PjPQhgzOOqYnq4yllaiV2c=; b=ol4/EeOAjbNM
	jiavcJ8UgOevvTG1+zPa+oyZbsBiUlwQG7WvF5xjWZ0e9WJF1pqS++DYtMwPwx3z
	cvkmBk1oIR5LJfTCMRcAtb5koEV3wPnudflphmBWPDsJZGSZ3WZ/vAztiF6p/Y6O
	sXyfiu+9lN6JBZppFq4M6iVadbxBeiqSbWWdpRlGQkk+8ADH6uGWoO2ZFs9KQHQo
	FR9W6hggBKXA7zPUpgEXoVlO5MXUDA8WvYEySuTMbrtcg2ZSKCF0y6KMl9+m5LVN
	ZKoE6rTnxP2z/Bs5f14ucofuCz1WWKsFLwDRhaqEFJbM3XgkadZyV+VouFBBNCyi
	prwEkajCpw==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010002.outbound.protection.outlook.com [40.93.6.2])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44ndt0rm16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 01:40:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPABh0045HIUgYpPReyh2QswZAIYjjp0jyBU/y8XGcZabURpZ/PB4SA5XlkouoFoUg8ObXcVN762mbvTBsgXb9xJh4/i3AMGpGfXI4uU5cMM219w6lPQ+hird3Z8rFKWD1A9aU8eMyAsq5RJ8SlPc3pPyzb8CIwg4EYkk1w44SOsQWIWW1NY79lfEXOoEa7Z72yC2sNj7MB2TeVop615jv+zIpT0wIQBsbTPWpv3e7sMw2UpZizDaFkd7cZSQCbhCE8Jz5HsoH7GWw9r+lGKf/IA9ZpIy6s2g7zXoVLxZqa7WPaThzOqitKQOHI4vooFRtafchEc7jSSjqtRPxxKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jCYPLa/SDkSVsBwNhjp/PjPQhgzOOqYnq4yllaiV2c=;
 b=h06ral6vVgpkcOAtVvq017co0ZhGeeXQZk4Q5qfXXpDEAeayzA9cjJi8HuHutw6FSsuNpHVaZAv2dB7gweDvugC0BOkfbcu2vUuX6hBaweiIeMIn6CcM4HVcrzJXgy/+eePALRj59s0jEmADMdUJiRySDeXVcVy/JDMf1YThXi/EjHN1dCPGaYw6aZXaNGyDQv7jhE5lJuD4PjCnBa8DRP4blIOmHzcnsOg5ZjyxZuQiEu/MDE5EtaZdf25XfuOwD4RKhNtaS5fBScdfYECnB+IQD2UO95GwcaJg5oRJP7896mDy4/b0Vyah5O/+SYg0vhQWBpv4r0PXeeYO0d6jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jCYPLa/SDkSVsBwNhjp/PjPQhgzOOqYnq4yllaiV2c=;
 b=brGHC0NPdgtv8M+znlaRiGJoy0hkUEjPJ+C8f5E0EAIF0d4xk4dEEj+lqwF1JbU7HKxW7HgnjQckuzCsSYWbTFM+wARxHt+9KiNbysvUeAlEHL3uU1xTu3LM9NDmIIv/Y/75YfKyoKc6DpDOQmkfmrA4/QreC92HHlXscUC5nRk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BL3PR07MB8817.namprd07.prod.outlook.com
 (2603:10b6:208:350::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 09:40:35 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%7]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 09:40:35 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [RFC 1/3] PCI: cadence: Add architecture information for PCIe
 controller
Thread-Topic: [RFC 1/3] PCI: cadence: Add architecture information for PCIe
 controller
Thread-Index: AQHbeUJv0R6G3CvWD0iCxp9Vq80oNbM7lcKA
Date: Fri, 7 Feb 2025 09:40:34 +0000
Message-ID:
 <CH2PPF4D26F8E1C021640F924EF26D4CAD4A2F12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250207092645.3140461-1-mpillai@cadence.com>
 <20250207092645.3140461-2-mpillai@cadence.com>
In-Reply-To: <20250207092645.3140461-2-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05MmMwZGJkOS1lNTM3LTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcOTJjMGRiZGItZTUzNy0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI0NTY4IiB0PSIxMzM4MzM5?=
 =?us-ascii?Q?NDgzMjk4NDk0MzMiIGg9ImN2SXdGZXlTWC9Kcm5uNGlRamdSNGRPTjk2Yz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUdBSUFBQlpzaFpWUkhuYkFUMkk3RlFsRlQ1RFBZanNWQ1VWUGtNS0FBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUFzQmdBQW5BWUFBTVFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFRQUJBQUFBaEZWOHlRQUFBQUFBQUFBQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?akFHRUFaQUJsQUc0QVl3QmxBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFB?=
 =?us-ascii?Q?YVFCaEFHd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BWkFCdUFGOEFkZ0Jv?=
 =?us-ascii?Q?QUdRQWJBQmZBR3NBWlFCNUFIY0Fid0J5QUdRQWN3QUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBB?=
 =?us-ascii?Q?R01BYUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQWRBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVlRQnpBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?bmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhBQWNBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFIVUFj?=
 =?us-ascii?Q?Z0JqQUdVQVl3QnZBR1FBWlFCZkFHTUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJB?=
 =?us-ascii?Q?QUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpB?=
 =?us-ascii?Q?QmxBRjhBWmdCdkFISUFkQUJ5QUdFQWJnQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFB?=
 =?us-ascii?Q?QUFuZ0FBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QnFBR0VBZGdC?=
 =?us-ascii?Q?aEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhV?=
 =?us-ascii?Q?QWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhBQWVRQjBBR2dBYndCdUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFH?=
 =?us-ascii?Q?OEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQXhBRUFBQUFBQUFBSUFBQUFBQUFBQUFn?=
 =?us-ascii?Q?QUFBQUFBQUFBQ0FBQUFBQUFBQUNrQVFBQUNnQUFBRElBQUFBQUFBQUFZd0Jo?=
 =?us-ascii?Q?QUdRQVpRQnVBR01BWlFCZkFHTUFid0J1QUdZQWFRQmtBR1VBYmdCMEFHa0FZ?=
 =?us-ascii?Q?UUJzQUFBQUxBQUFBQUFBQUFCakFHUUFiZ0JmQUhZQWFBQmtBR3dBWHdCckFH?=
 =?us-ascii?Q?VUFlUUIzQUc4QWNnQmtBSE1BQUFBa0FBQUFIUUFBQUdNQWJ3QnVBSFFBWlFC?=
 =?us-ascii?Q?dUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBbUFBQUFBQUFBQUhNQWJ3QjFBSElB?=
 =?us-ascii?Q?WXdCbEFHTUFid0JrQUdVQVh3QmhBSE1BYlFBQUFDWUFBQUFBQUFBQWN3QnZB?=
 =?us-ascii?Q?SFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY0FCd0FBQUFKQUFBQUFBQUFB?=
 =?us-ascii?Q?QnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCekFBQUFMZ0FBQUFB?=
 =?us-ascii?Q?QUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWmdCdkFISUFkQUJ5?=
 =?us-ascii?Q?QUdFQWJnQUFBQ2dBQUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFa?=
 =?us-ascii?Q?UUJmQUdvQVlRQjJBR0VBQUFBc0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFH?=
 =?us-ascii?Q?TUFid0JrQUdVQVh3QndBSGtBZEFCb0FHOEFiZ0FBQUNnQUFBQUFBQUFBY3dC?=
 =?us-ascii?Q?dkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFISUFkUUJpQUhrQUFBQT0iLz48?=
 =?us-ascii?Q?L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BL3PR07MB8817:EE_
x-ms-office365-filtering-correlation-id: 2a5bd27f-c37f-4468-d6d5-08dd475b78c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?A34SfGzj35kIr9ep4jTgmxj1GfWjnwYFaOYnCwy7Ja21XR6pU/d3sbKjKYQt?=
 =?us-ascii?Q?pwSfxduRsbwKutAaGrjGoDGcVLQN88vhJit5HyQLKFNCO0767Pg8x+0o641h?=
 =?us-ascii?Q?BU13LVoBCMHJj+jByd4Qer92POuEYURspf++dKhg6fYlMBsEOah+1y5muiJ6?=
 =?us-ascii?Q?ezomlIMu//bKuY2CULQIgwZ34+JHYVL08LvNdQaPpbaPjx9yB6WDEot/POFS?=
 =?us-ascii?Q?FR4lFXJYTwNtL5DEAG+k63HUBY08UV9JHQP/esSZyeI3d6ARaLzTW6Vwxcby?=
 =?us-ascii?Q?HiI27/7WhYwgQ15psBvE6qX7nmh3ULovj+MZHZrWgpluKm7yzU7qp6cvRl6Q?=
 =?us-ascii?Q?YeBcNgOtucxhWJ5V5jZZvP1JCm+6nHgs8ng9RksC4K3H3c88HyfdGAPoBV9Y?=
 =?us-ascii?Q?r4nlwLZ7T5dzW3SGGPYs7+tpPzs++NHmLpnylidFC+jGVLYPcUxHAC+7Qygi?=
 =?us-ascii?Q?SOb2f+PXTDxHuITl/2zRSeLFo08ZXV2Aaq+vFN/kt6r0S1ERRTconsF3XFuW?=
 =?us-ascii?Q?Te/iuA8drUqF9Qg9Wozg+/gwwTIvSl660S+O11+NAoUBYqV0CfUy2dKObeVV?=
 =?us-ascii?Q?TcUe9mWXxuKuuy8ig3Mgi3eQiwPrZv9+eu97rvBwmA1HMaNoxnrCOIzA3mIP?=
 =?us-ascii?Q?UYY5D3qQ3Sg8p6DuU3Bz9yZzURd8qfIAhOmn+CR7wnkYHUa1vNDeeALpow+S?=
 =?us-ascii?Q?a1VOGDREOU6uHzBkTAPjoJwpp8ZV30lFOyatkBD1e45rwQGbECYjGlLRzhLD?=
 =?us-ascii?Q?Kf2mTfiClv0TArvyTc9yDqWFb+sdyvAJrlsiYxFJka7yk6IuZD+hgl4+ryFx?=
 =?us-ascii?Q?A9Z/BkeqbIb9gIYYWagv5fqTsxatBfJbqFsHzQjCYuBbcdAYU8L4EJtQy+tU?=
 =?us-ascii?Q?ANfyAoYBdbJuLfJs7q66Ht4HHjZqXpLig0r/XNG3evsJRTDNM8Vx5iGsgUlT?=
 =?us-ascii?Q?pszIfkAW0Rk5w9lOUm8AKXSZ07R8UyVh4SqNjUg1bYWDqeJaOSjcO+SnxJSa?=
 =?us-ascii?Q?AorVpQ4hfV+5SbHLUjI0CISFzHXpUejbzYwbbHTP6gmsXh9CBvH8jET/FOMU?=
 =?us-ascii?Q?fOzdvrVKDHzC81j4za0YoHjnAMeZdhobk2mxuavqbCEfcFRqT7Be4kFbiStM?=
 =?us-ascii?Q?Q+v3He4ZZMtpvL+Qm+kW7iW6/2JPFd+kkKlbllS/V8urpfncL88tMQM+3/U7?=
 =?us-ascii?Q?2Cmew9g65ChmUa1FF4ulbCmrh9UckflfmOc2hlBitAseCzL55MaWFkSpkYcW?=
 =?us-ascii?Q?KivI1Chbvi5iDYgpbcj2LEBLoVMU4XpN0Qu0KTAGzA6wIKrW0Ol1ZrAAF1sV?=
 =?us-ascii?Q?OFiTYKl//MQwDuyzl/rgPwRu67c2kytIzve+HMrS+zp5DaEPpzKSzSOQ2J+G?=
 =?us-ascii?Q?yL1KBFSwkIeQAWVTP4YoZId7VuoQOqu+hDwJGmJRIOaxz1v95XW7qo0qm6OE?=
 =?us-ascii?Q?8w4RYgfQY2UnYdYJ5Fo3/M2RhDUJJ3kz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HYNnP7G0lINxR++Jdkko92owt81eapDLsMhp/TkNekqNNv0a4JCb3/Fw3wl3?=
 =?us-ascii?Q?TzEOMATZNpspC9+LKzUQMVQcvfr8Rxt5UjMr0jz28YDqjGBnkYKgb/H0Zu1b?=
 =?us-ascii?Q?KF0MzGou6ER/E6KUDtLQLhgZ/cSoOG+rBbIuN81sQpJL2dJdssv3yveo+FWT?=
 =?us-ascii?Q?Nm3HUsxrgxgBHhGqC15pnZpi+wDIJ5He1gzmtXQZQGU6WyPv0b9FCNff818n?=
 =?us-ascii?Q?JTPjRMWUDXF1joj61mHXsoapSQYdJQCzloHVtUDAtal9efL5dYfSY+NK6mPs?=
 =?us-ascii?Q?SVAR0qXMP2G0qBLQNl0E6g2PvCYZEDryaa/3fuXZK1M8b2tHwuc0ryxmaYYz?=
 =?us-ascii?Q?epvWVDTr68J/jzFHAoI937sib4/9DfvpJRFOduP3vMDPymMVZ1zreOo9euFM?=
 =?us-ascii?Q?TzJgUjq/VVOK8LdihjxgeQgqGwIC1GL/sAmX0Ix22enIW2zqqlNijFEhrGtD?=
 =?us-ascii?Q?8eoYgX49fBHIV84iIy0GP9W5rS2LTGmVaALFLOEf4oO8fgUszyKg1veMzRq9?=
 =?us-ascii?Q?wtugDi9L/Sh8xW8EdSp6+HJEMiOUezbB+9T0X0l4JdiQe7GSqBRMUSuHCDjB?=
 =?us-ascii?Q?U04wIX2kNB6tUYvM7EczyllgxanChp9hhcz9/VJXU2rRYEo7vvadvZZg6qyX?=
 =?us-ascii?Q?wsvPiEQ7/c84Pr979WIiLWFFfnB7EqxlcRkw7m0/dB+6y8wWfDVS2mpKdaRi?=
 =?us-ascii?Q?1C8+QRBqCinfZSsQz7yRJQ2/GCKOWDtt3BnPMenkDww0opgF2SPWw1seoo42?=
 =?us-ascii?Q?2yxJpls6hLZsQqwifNcle18dCBVP0XmSCrCMCpQRGpDK4YTQ/pY9XRddEWqV?=
 =?us-ascii?Q?1/fdjsQcYLYMStyNcZoaMNstwSZYT2270Jt2TcaVmXERU915tDPSfAkXItic?=
 =?us-ascii?Q?/WdXdNtpxdKbeqEKp64pyYG3lqGA0PEKKs/3dUSfmXtBGgQHtCfJDE3G+HUy?=
 =?us-ascii?Q?tO+L3jqIhOMrzeRX602kSTNRUv95/L2Dk0n19UEbcmUOdV+5L8T1yhfWBJjV?=
 =?us-ascii?Q?IJtWAD40aP4ZcFukTaJw96PGZ6kX9OcihqojUeTG7j8wfSsAio0CWPDKpekL?=
 =?us-ascii?Q?lyy4VtmoX2egM7VEBUnhsM5oui+BXMy0Q4MXLMo1N3SUaCUY3etrb6A91HvT?=
 =?us-ascii?Q?jcc8V1nWkOLKuKKFtjebJ7HjrUjGCveIGWa9NZ6FD3l67huFz1hXQLz/CszZ?=
 =?us-ascii?Q?3m8g1nzvgM/jGQtfmJZw0rc5f5QcGtG3WXRVZKEepDL2phpFim7vgCYzHNsb?=
 =?us-ascii?Q?iyytQ5Z6lPWEJh/RtM1jXwBWWPnoyTgm2NJoftu70Z8QLW6mcN9SMxF28DSr?=
 =?us-ascii?Q?i+P0zU+RhbdQakJuamFDmHvMVwFOc8k4x8/yo/oxidAcezpN8KRsIG7xFkXm?=
 =?us-ascii?Q?w9FVJn8w35o6l76oF5XUMShWvVxWYKsnYAptxQt84fDbqFmKJpaFWyxBTGDq?=
 =?us-ascii?Q?mDPFlpOxinPSSukSapPs6SXRnyImsK8Vdq3jjLZa4MCszh4x1Nubvj/UXJdy?=
 =?us-ascii?Q?jOS03kpRdAFv/79ja3+q23xfo3Gm80yNIQPeQJAjVEVGkpID68spl13J0HZs?=
 =?us-ascii?Q?FDKXO8kaPiNwMf4oX6v/vBwm7z+yN1vDhfcn4ZyK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5bd27f-c37f-4468-d6d5-08dd475b78c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:40:35.0084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZrO71I6I3oSB1H2WUwaYe/IcvwVJLP7jTgjceACbmjek1lutdVgX1oT/ByGvD025dHVLY9C+f8nhwvjSotvZOkp0F7dQ918IoYXX0T669E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8817
X-Proofpoint-ORIG-GUID: eRy4kNs44brgDhghahrfVf9Dwm9RgM1g
X-Authority-Analysis: v=2.4 cv=ZJ0tmW7b c=1 sm=1 tr=0 ts=67a5d515 cx=c_pps a=joY0rRILPjs92yFVhGOM/w==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=IaFNTQcsxjruqrN0RNYA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: eRy4kNs44brgDhghahrfVf9Dwm9RgM1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_04,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070073


Add is_hpa boolean to struct cdns_pcie, to support presence of next generat=
ion - HPA(High performance architecture) PCIe controllers.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 5 +++++
 drivers/pci/controller/cadence/pcie-cadence.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..98ffd184be93 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -42,11 +42,13 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
 	const struct cdns_plat_pcie_of_data *data;
 	struct cdns_plat_pcie *cdns_plat_pcie;
 	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
 	struct cdns_pcie_rc *rc;
 	int phy_count;
 	bool is_rc;
+	bool is_hpa;
 	int ret;
=20
 	data =3D of_device_get_match_data(dev);
@@ -55,6 +57,8 @@ static int cdns_plat_pcie_probe(struct platform_device *p=
dev)
=20
 	is_rc =3D data->is_rc;
=20
+	is_hpa =3D of_property_read_bool(np, "hpa");
+
 	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
 	cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL)=
;
 	if (!cdns_plat_pcie)
@@ -72,6 +76,7 @@ static int cdns_plat_pcie_probe(struct platform_device *p=
dev)
 		rc =3D pci_host_bridge_priv(bridge);
 		rc->pcie.dev =3D dev;
 		rc->pcie.ops =3D &cdns_plat_ops;
+		rc->pcie.is_hpa =3D is_hpa;
 		cdns_plat_pcie->pcie =3D &rc->pcie;
=20
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie); diff --git a/driv=
ers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/=
pcie-cadence.h
index f5eeff834ec1..fecb64ec9581 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -305,6 +305,7 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	struct device		*dev;
 	bool			is_rc;
+	bool			is_hpa;
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
--
2.27.0


