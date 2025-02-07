Return-Path: <linux-pci+bounces-20873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3007AA2BFA4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396663A4939
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762031DE2D6;
	Fri,  7 Feb 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Zwh28Q+u";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="McYTTNjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B21DE2D7;
	Fri,  7 Feb 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921173; cv=fail; b=RS8PlQosLejGQhex7ooLtppegKKN0ukRZWQ4A2ecyV9pGnksUZz5IeiTg11hNuiD8a1LJupS1o+6OtW4ARTwbcU3lpQN0su4/SYNFL0rLZ5hJ1YuBc2G1Bqt4eOauaM8nnmbbpZP5GiGfVZVK63wXGlq3e/QFEA5HX3y6HvfgqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921173; c=relaxed/simple;
	bh=dlCL8N2XPnVAgqITtDDurM/nP+vP69lL+ffH+5H8oc4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLTaSzx+DZyQReXq4DoWmHMEGwbUrim7Ux7IP/ALl02tuFzM5DrldXEwZbTpqiC78kmpHPJBMhhlUDHTTJAwy3Ekrd12DCUcAK7MxPaIPSfu1yPV9rG+y+4wA+Z1J63exnHS+Se7cRxcAETOPnJHDTiWLSxzsewh/ScOtkQKZgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Zwh28Q+u; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=McYTTNjj; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5177R2ac026937;
	Fri, 7 Feb 2025 01:39:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=amlH6Ivlc8Z97yj4NquaIjzB7iFdncOi84E9KW2SR3I=; b=Zwh28Q+usnQj
	SY9FMCXKefSMqDAVi3FGs6C0CFcwc2Hk0Wp28qm2YHXpBs80dY/s0scSJf760aRR
	YnGskPRyNx4MTPANmEvCynMCnv/w3AW7+fudYR/bi9wF8YrR6ZuK45bBI95sYs79
	PMczxR+odec1r8ftUjGM8pnzzP5pZdcmz+aT4TFzJAN7l2XqIj8ZxJYJYGKRAVac
	n6iqJAG+6zvz1cJOI9rOso8ht+MuCujddnwV31nhyV+bDJpE6nBuBR5PKB3DEhUV
	iwMiyCmZWn+AAZlW0RBhe1VHWjQq57yvsudAJMWpC7nh9oys5TiB5t3PZsdrw5mB
	9n8/hx2nJw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44ndt0rkw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 01:39:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm81HT7GbdIuIW0nFewwO/VG9EPLZ3YyjpRmUtVb4VfTvonVwl7UvGAIgjEbHRv1btLi7H4dPPgBe/zTuKwVCFEMAmlnypot3P6lH5D5K3J0+rOk96tBa6C+ukiVVgVrFxZtN83dG0pisg1Jm5pgTfmxqsRGJqiQjzEQS92+BsX+Jzb+r2bhH1BsVNn1N7fOUM2/HslDxEmLmfyqB6ssMuXdPSYB9blRRnKv30xFKAfzDr2meoRwUfQgzIlGy5oynXtSj/kXdg6ldtBQM5KwLtV9V0HSd5ysVEZwF9ypbhWsReQfXR/j2pRLFcWuX6lweNln74HOiJPx0eQ4gAZhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amlH6Ivlc8Z97yj4NquaIjzB7iFdncOi84E9KW2SR3I=;
 b=r1A7ZOHRoEtEO181s/cU7p2I4JwkiJsqpSS0UwNsJBu7g6JC71Ekbps8WFELnTi6qGrxf8guKLRQwuQ7WLkL7K2QAtP678yXg/QiYWjFj0E/Ux3WAvMul0xmLTAUhl1XzVyVlivy9EmL++UwqmrPqNPUuyqSCORW2vim2PIH6OQNcAqMnnmn/kY+ck1mx0v2kpL6Q0al86VS9cML17N1cDE9Y24LyHe0G3OxoEs09puIP8C+5f9583jOe807+ujfSBwhaqqWpDqNjpGceiZWr/vSWvqB6SSBlpnYBHO0DGkzPWS17y2dwP4MS6MVlFyDYjUlnzGUVylRH8hztYo6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amlH6Ivlc8Z97yj4NquaIjzB7iFdncOi84E9KW2SR3I=;
 b=McYTTNjjHMkUthvSgNncNioUgb4MV3x+UurNlV8gkWolGbT4DQUGKsCawM1j0TabDpTzKSzDsMPONr4XtBwEd0E58F3pQe5Ut+Hvm3ItRrs+EWFxS+tnDncfvgBbhiwLGbgb+PfUpB0/IoczJdnOG2FBfjPo8LuyqFw6UhWDfPE=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BL3PR07MB8817.namprd07.prod.outlook.com
 (2603:10b6:208:350::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 09:39:02 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%7]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 09:39:01 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [RFC 0/3] PCI: cadence: Add support for next gen PCIe controller  
Thread-Topic: [RFC 0/3] PCI: cadence: Add support for next gen PCIe controller  
Thread-Index: AQHbeUJri4S0Jn2SIEqje5Ov+lG4lLM7lJMg
Date: Fri, 7 Feb 2025 09:39:01 +0000
Message-ID:
 <CH2PPF4D26F8E1CB87C28EE79BE36320C63A2F12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250207092645.3140461-1-mpillai@cadence.com>
In-Reply-To: <20250207092645.3140461-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy01YWQzYTNhOC1lNTM3LTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcNWFkM2EzYWEtZTUzNy0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIzMjc4IiB0PSIxMzM4MzM5?=
 =?us-ascii?Q?NDczOTE3MDYyNDkiIGg9IkF2UEEwVDZzSDFpZ3YyM21ML0xwNTk5bHd3MD0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUdBSUFBQ0p4Q3NkUkhuYkFTY3FEbDhjWnpoaUp5b09YeHhuT0dJS0FBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
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
 =?us-ascii?Q?VUFlUUIzQUc4QWNnQmtBSE1BQUFBa0FBQUFBQUFBQUdNQWJ3QnVBSFFBWlFC?=
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
x-ms-office365-filtering-correlation-id: aa45cc39-c515-4c14-f647-08dd475b40ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mrm3H0XFIImKE8aFHxCz8Y12oTvAwstwdDTBpwwtZZYj+YTVkXZcPO63cen3?=
 =?us-ascii?Q?BXrNbHDdQ0s0MVPql+KgLC7W4v00cr4qtmR/Io5W9ZHq5Y2rJdbxgTvlI38h?=
 =?us-ascii?Q?SeDxb3un975FcUy8LCMw1OPSWdPODLTlyoiVSKnw0io7BpcUWMsPQsIj2kfq?=
 =?us-ascii?Q?YCbYUH8kQo4iug1ymZS5DmWwGoGeUbFnGdDIPmKx7NLNWoKtWVNFrZQWCp0P?=
 =?us-ascii?Q?Ne3BfbKk56Mq7LxN96hht/jjBTwKLuGz+vy915gGdKzDi+YyAVgmhkfjrRXM?=
 =?us-ascii?Q?wd1h0nMDnNnbfomr7uHre+gGDukUX61RJqZYY1IL/gdgJpt2EoRXT6QNx7pn?=
 =?us-ascii?Q?Yt9yayrxckxx4N1y2PvONV47IFzdDvPOAOMAzFFTTyBhc2uCQlnSvF8A3Yv2?=
 =?us-ascii?Q?RA5rtOChxUcQ4q3zRvtT1Ev3ju4k46JRFvTXTT9a9OpzS5xv6d3DK1eP4Kvx?=
 =?us-ascii?Q?DZF8IZ3ps8byxr0yA8bFE5U0wtgshfX7j04V+26C+9YRDOoYb6/45oQL9Xuf?=
 =?us-ascii?Q?/vx91K4E1KcnHCli9j3HXdUsmF8HBp0K/Y2H0UAYwoyHgPBV0VdVoKTS0OkW?=
 =?us-ascii?Q?2lmz9NhbwbQvPGtMWNU1uRxiwSV+GITP05BoWAstqzujafbrXszePFYn6sN7?=
 =?us-ascii?Q?y272EZxOldaljISYWk12yRhgTLYXHtkBUtIwXBWRF99lAbnnE6DgFE1vOj0N?=
 =?us-ascii?Q?bTD3hlEPjGAcKqylys62tyBF+POPJJ2pB9w8lpFXbBIMA55HBFlx+ar5HzKx?=
 =?us-ascii?Q?5jSBfpKEcpL8Bq20vsvWp/l6uHVG9ataX0IPr8hd9hRdV4dcpPy+Vsl01MYs?=
 =?us-ascii?Q?UYhkpmFL8sMckQKRAUdaYebMEqN1eEwxu0WFM+f7/6LYriY5/PNPfnQfBnVe?=
 =?us-ascii?Q?8WN6RxWzD3kQqBOoIGmFUWpp5Q1cqx4w1kN99/qjvZcauz3oDdhlTCl4E8Tz?=
 =?us-ascii?Q?+4woxQxYykSrYpIG6iGBmm1ZVTaUQ1LMZG+wD/p0IFwl1kV+5Ih1zCnFYkJp?=
 =?us-ascii?Q?QO6h+Gxj1Nk0XX3VApza4vAO1ak+k4QYDhtfJGLcOPYdJGlAW/+0TylXRTWq?=
 =?us-ascii?Q?xv7EbOpGtAse/ugIol079R2nxdALtvFdV/i0fx92+GbujHZoOYYYwUmaW6pX?=
 =?us-ascii?Q?51pCk0fhQUVTo/RoOGBDkvcYMDLWA+WGsw68h+52MbqItVmFoa6orSDH+CeM?=
 =?us-ascii?Q?xYGCLy0gp888b4BW1DGNqpqkTf/IlLiHGzW1TdqMuMZ7Tl5L6JFV7kZvrDen?=
 =?us-ascii?Q?sUzc0+OKdBsdYWS1hMUAm4P5rcQzXSlkDy0aB6MTjIJtrl22XKVM4l7hk0WK?=
 =?us-ascii?Q?sFxRt1t+XblRZfsItKcESsSrCYVrZL1HytxYLmqF8qkuZ/dTmuaX5VeKsWr/?=
 =?us-ascii?Q?EW5cwpF9WMC5poTmtSvK3vddtCA6Ir4GgBN31+s7EgKglNM6bOwBQH3Q7eOe?=
 =?us-ascii?Q?+3CYJ8tKiqlYjNWHquM6iW09kx5+dh5e?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Br4OTwgY9m+waoIHtVMlOeC2gSCs5mlwHpP2auqTfrzqeGyaYae8nQW06Yhe?=
 =?us-ascii?Q?iRhLg9v2FwmRmxcnfy94oyTR0h4ndRvNwlOjxHaAEhGPtmZQGSJBE2AlwMFE?=
 =?us-ascii?Q?exA24xTHpVovRLv6DYp2fSy/rZxAOL7z601GNAOwyP4o/PutzIpb2lREhb59?=
 =?us-ascii?Q?h4onMbqCyWy1kMoLLA3NIhDUOpnvFfNij8AqF1lN94nXyPINDutuse0QD9eG?=
 =?us-ascii?Q?fcg+EGkfVfpxhDSXD6sbWCp2tyWmFilRb6CxzMaHRIPxuACdYZFYzAtyM2MP?=
 =?us-ascii?Q?p+YRxHvUcvKzscXFaENu+1WCNVi3GJIMRNOqCdR7dgSwNDYOKJfz8iOgiHrv?=
 =?us-ascii?Q?7NQQ2ePsUe9WcClOaIP0MDL4rjPPxAR9sHsI8sDWwqBAlwmIhEC3r9H3QiKZ?=
 =?us-ascii?Q?8Eq6qAmz90bpdRmjVVEi5t0B8KTkCueDfRcoqi7UsDNce+MqQf5ULZ3KZZt3?=
 =?us-ascii?Q?hI4RKB9xRLdKclFGvwie/UKZxplIdoWuAhT8ZpxMOAzuIOWvqZiUCcMHqaQt?=
 =?us-ascii?Q?SMqUNEY3PdYfVCb/obBVXb2GRJrLnM3bA9ESUcMAd3j121LkVIeiXFoIfESP?=
 =?us-ascii?Q?k/3DQIHuz7jjkyXpSLl7oVSTFub/+W8fhZcMipeOPYCYDwJp55fkMpWs69ye?=
 =?us-ascii?Q?A/0jbmKdw4O5T56Nuk2V+CfAr5tUhZPyJHXgDck+CC7JciN64aCtoshJxeDh?=
 =?us-ascii?Q?ODut8UeJpVtvKb4Gbfcjp+wOyDFER+wnDYRi2b5+La8rEwSZ5M4/18XRm7T/?=
 =?us-ascii?Q?YvXpx+ZfMHrpQh/8KLYdB8SRXEYmLIxhLpE2nuBvhvmYsPtPKiOWSL/8S5BH?=
 =?us-ascii?Q?eq6sBw1Q6ozXttn1u4NT43zSd2/8XwnyvKeL7S75hkBoD/Znii86KvM2RgEe?=
 =?us-ascii?Q?NqRpxsXiAoCyiCcTjMT2qArtg+dcVmjuF7myNdAhJKXZ9qGEXoDMDqbaJqu0?=
 =?us-ascii?Q?EFW5VEyyiRaGAReK39BliMele4SBrYn/KyxekN45mBi2P7C+V8AwGo2YfGEk?=
 =?us-ascii?Q?npk19OjFl8oz06Mx7C4vAPeP++JXzsF6gnYRvuiEGyTQZxURGa3BItRKLJGT?=
 =?us-ascii?Q?iv2f5SRFFH4hcPzKhS1MYPZDbJCIxLBiyV1JRfZL8dDOYvNKvkOAWoJN1QH7?=
 =?us-ascii?Q?MtpOhrbsfKzL/E214cmxznaQYzrFX9AdY74yxoOrMHqwDrx9LiLQ/MYvpfrn?=
 =?us-ascii?Q?DpezfWPzhJcnHatI/mUT1PZfdoJnGjlYpAt6ZvGKxS9R6gbd5t4fx56jEjBY?=
 =?us-ascii?Q?qx3+KHQfAFlswUBDthwcEguAlygRyyXSLtA2M+BeGEB5MDFX2qg5+1hQ4AiO?=
 =?us-ascii?Q?s4YZeQmTTwA7wbiFVc1XHvvAbJ9FI8hIppI2d+OlISj7KufAmTvb7dloK7f+?=
 =?us-ascii?Q?pTxuf8XeVIPPe+d4Bz19WGRrJWMedcg2KAUs9UoKGcSaxaq+cYf2QMkdgIYt?=
 =?us-ascii?Q?L9Lnf3GNLdo1w0bYKIc9AYeSmMUCA7uVZT+AOkIp0axLdI6bk3+wCgqaoWRs?=
 =?us-ascii?Q?efosQYmbzcAWbimTwuVNgu02Ee7qdKWcc8jqF9HRg5x3F8Y5IQ5WJr5M+gcQ?=
 =?us-ascii?Q?nIeBIvv8lFxai4RvG1yCW0RNOjJn1rP54ItFfytC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa45cc39-c515-4c14-f647-08dd475b40ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:39:01.3165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03PiFWonaS9isds6LYKGcidRdjSp7UpOwGbfjzcNUxxwD1tPJKfKL9RHSGNtRdX07hEPy3zn2xHEw8VecJPAqdfZb9Z2mlGaOxDLW9BTXJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8817
X-Proofpoint-ORIG-GUID: KzBytgorpHiUjV8tFpw0b9IDhPsYuA4-
X-Authority-Analysis: v=2.4 cv=ZJ0tmW7b c=1 sm=1 tr=0 ts=67a5d4ba cx=c_pps a=4/dVwHrG2xlZHl48ITU9gw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=zwo5VoJo5cvcngmvQfIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: KzBytgorpHiUjV8tFpw0b9IDhPsYuA4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_04,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=916 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070073

Enhances the exiting Cadence PCIe controller drivers to support second
generation PCIe controller also referred as HPA(High Performance
Architecture) controllers.=20

Comments from the earlier patch submission on the same enhancements are=20
taken into consideration.

[RFC 1/3] PCI: cadence: Add architecture information for PCIe controller
Adds the boolean flag for checks to know the architecture.
[RFC 2/3] PCI: cadence: Add support for PCIe Endpoint HPA controller
Adds the necessary register definitions, register offsets and architecture
specific functions for Endpoint functionality
[RFC 3/3] PCI: cadence:  Add callback functions for Root Port and EP  HPA
Add and register all the required callback for platform and invoke the
registered ops callback in the driver.

The changes are not tested on a hardware platform and hence submitting
them as RFC to get review comments.

Manikandan K Pillai (3):
  PCI: cadence: Add architecture information for PCIe controller
  PCI: cadence: Add support for PCIe Endpoint HPA controller
  PCI: cadence: Add callback functions for Root Port and EP  HPA
    controllers

 .../pci/controller/cadence/pcie-cadence-ep.c  | 158 +++++++++-
 .../controller/cadence/pcie-cadence-host.c    | 249 ++++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  26 ++
 drivers/pci/controller/cadence/pcie-cadence.c | 154 +++++++++-
 drivers/pci/controller/cadence/pcie-cadence.h | 278 ++++++++++++++++++
 5 files changed, 831 insertions(+), 34 deletions(-)

--=20
2.27.0


