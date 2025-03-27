Return-Path: <linux-pci+bounces-24839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798A0A73050
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D521B602EE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD41FF7C5;
	Thu, 27 Mar 2025 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Rmno0zb3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="f9ajVwZR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05AB213256
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743075707; cv=fail; b=HRhQ0iVzsrD5DvKY9omzX/481vspeoM20MWOYF/749Mk2PdSPZNUVHKSJMe4L77nHN2x6PGEPRyI2KVPdj9Pap4N9JJGa45ZtlwlAxjEwp74adnV9/21exndqBtvJXMM9i5xUc8PNwOI9nksQGn30p6WQoyNU+k3Nfq2FltdcCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743075707; c=relaxed/simple;
	bh=1j+eJPiofCxVu9wZw7N/Fea5o86+Cm6nIqKhb67w0WU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IqrxrUE6JkUlEVFsFN4EEKRh1B8e+7xqks2QqvWcKZgauOExA4hE3aW4Ugx339pJwghvVtx7nj6qsPuLuw96prQWgchuOMomiJJYi/hCcYMRq7WTJILcpopz5/ivCIy//sKEIJUD6RVdlFSkY4v+TKJ8CEl2HQQ2EJWU6URZfao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Rmno0zb3; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=f9ajVwZR; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R7cdBu031588;
	Thu, 27 Mar 2025 04:41:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=sDk1wm50m9EsdrAdNXxbQ+3Vr0oPmn4b3Zj4pDjVCBM=; b=Rmno0zb3mFLr
	ST3GJBe15na7D/NVOUA8S4TsXWE6vteorlWvRSE7Gz5is8/qRuCbDpds0WFtQ+G5
	il99o5LpdLz5nYK38A7uHBS/kVfRfWcb2s2fbwezzRQhf6vRKQgdoDpp13Lu68jB
	HPHkkEIdvaGlMWR7Ty5PjH1x99AT4mDNZ+CncT26O+EujyRrJNar60GP5EonUexw
	3q16F0e5FUz0fIOqQxDpXOcOoL8A14an5tMnXHIy6VoAKlRbQG6JHvzViiQYUGDj
	dHkC6PY9hzxwZoCTXRzlOE05lmh3deDYFAvb1bkLUKX99jOuRFnpcm9BQq98hXPq
	BLK8ThWL1Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45hsrwmxwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJKNH4tGYv5DcgMQ+g+EsaXcCa0AAyJt6N/rlUiGN1g42Vs/afi1uC1C+NP/y3hPurDE/sOfvHhRSONRuNM5JAIMYgW64kKQNgII4r8S5TLLT/ZFVG+bRZiJbH/i8LKs5Y2IPDF/eknps40J5HvoLn5ozX1kBH5JSYg89/FKY6SeNFzUVFTp9bxa4qoVqdBU+12uB7CwSjhpzwZRDh+RJHbcevTwHXxDoAQz52mNhLAOZwE0DClN2zDx7e4kZoVW6vQNVQpNG11EuvCYa6pCJ6eFzRURyPqFNVCS5B8prSij0qnumcGLU6Gkzv0lkhOxp9dE+JiRcXHdC6gSlvRnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDk1wm50m9EsdrAdNXxbQ+3Vr0oPmn4b3Zj4pDjVCBM=;
 b=KOwXnu8v+mSEMQihD4azDI6uDm3MuDd7kEx6d5WrKdEhrm57J2i661/wR4qKTEJmLZpl6OrsB9uGtfE8/m3elp9Kj7QN8hTaZPkaU4JSMkatSYOsXYr1AWST4dmIZTCjggR76SSI1YLD1jAgagMVG7cwcBIc/gFUq6syuBbyQpgv5rQoBdbwEECHQRgRIVSgzr34r56r5OvKTsWprs3/heHzxQgKqKbIz7ll+vnQ30jkl1u9bIoeyor7U10aEmR/5Ws0LNF0qG4RfGIGIh6PiCr9qloFjmgcUbcXFR8tb0gCHbwEmAn9lhTUrQK6nGsMr1duaiIcGKXvm1+rpfRjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDk1wm50m9EsdrAdNXxbQ+3Vr0oPmn4b3Zj4pDjVCBM=;
 b=f9ajVwZRTMbx334l1j8VrnRCgimcjtUx1xxe8YEtoZduZS8hJDxR10G2V0finKEYB1+kxV3abi0vyXrlOALgGQjY35m2ncy8PWEcZ7yh9jrTtdTXCDBZoBMTxh31m0re/zZl/7lK0PoJ22+Wmnr8FCHNLi+4CKakuGhpjoIY4Lw=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by MN2PR07MB7294.namprd07.prod.outlook.com
 (2603:10b6:208:1db::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:41:36 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:41:36 +0000
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
	<linux-pci@vger.kernel.org>
Subject: [PATCH 5/7] PCI: cadence: Update the PCIe controller register address
 offsets
Thread-Topic: [PATCH 5/7] PCI: cadence: Update the PCIe controller register
 address offsets
Thread-Index: AQHbnwkqx9vVVGnw20encWgJa+x1hLOG3B3g
Date: Thu, 27 Mar 2025 11:41:36 +0000
Message-ID:
 <CH2PPF4D26F8E1C900A703D6DA18E55E02FA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250327111222.2948127-1-mpillai@cadence.com>
In-Reply-To: <20250327111222.2948127-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy02ZTNhNGFmYi0wYjAwLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcNmUzYTRhZmQtMGIwMC0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIxODkyNiIgdD0iMTMzODc1?=
 =?us-ascii?Q?NDkyOTM1NzA0OTU1IiBoPSJhQXlrLzRCZEZHRmsrbDREZnVLY1VLbCtpZlU9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUI3SVpBd0RaL2JBU0JHU3orZHE3a0FJRVpMUDUycnVRQUpBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFDT0JRQUEvZ1VBQUpJQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQXg5YU81UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR1FBYmdCZkFIWUFhQUJrQUd3QVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUhN?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWJ3QnVBSFFBWlFC?=
 =?us-ascii?Q?dUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJRQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFGQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQUFGQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUZBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|MN2PR07MB7294:EE_
x-ms-office365-filtering-correlation-id: 30d1b7ec-6eff-4ddd-1d3d-08dd6d2454a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1e6+KevoF8wjeskRKpFlqKk/XQbgFNybBAaPAIuj5SK3Virjak0Ac5qU0eqF?=
 =?us-ascii?Q?zv4jMJTo5tpaCWjCrG1lu8EwDZgSxZmLMFndqf/+p3oG9/n6H8km6jPQ88VA?=
 =?us-ascii?Q?3cL2Hnf43NsPE6nXyO7rKDJvDYIb+4Vk24OmqhkyGFpl1iCd2FgvbuF6ah/q?=
 =?us-ascii?Q?Odojd8l0Kpm5ZHEQqRF9TDINyuN3PbtHkWDV564WL8ddEqv6ND+0+tkgJLJo?=
 =?us-ascii?Q?yh1/MXlpxlX2OEwYB4UPvxvVA5Zys2d+Fy1Wbo0ii6ln4hPnn6fzx5ZOXxht?=
 =?us-ascii?Q?nBnrpFhCPkBRoQyFUVISoKek/uygTIaLjgb1g+E0GaAqka7j68Guim/DE95A?=
 =?us-ascii?Q?BDhxh5RKt1uiySszZLijFrgJmdt/OCUfvTFNx8PUrTQW4OBkbQjd0ZacFyBL?=
 =?us-ascii?Q?/vQ9FpPeyZ9ixA5AVcuseMn2ZtJKIANi2+8QsrjZFGBXB+QN0UE5RyevZEAD?=
 =?us-ascii?Q?jFXaedo3vlqkGWO2PwtGt4lv9S22O9AcNmNOENw59j0am/nyEZVkrfqWuOc5?=
 =?us-ascii?Q?4ponH6LwkfYmKBdkvtLwQYV4x2H3Jr1bZ6Au214/uo2o6ItzxuHygLhvtpZn?=
 =?us-ascii?Q?quqF2TMWdy9tSef0slw6btdpJVsbZkkWF7+rcPrK2EUWDHYn82HAO+EBetsM?=
 =?us-ascii?Q?j5X9H9Gz+RU17Ry7LFl6sgaVDmKk/SpMHGFJcUczKF/ym3rrY0ZIBnQUkkoR?=
 =?us-ascii?Q?00cUNwqWZLcLNLcgtXBEd3THNwQsuyjYTrjqBmzNkMaSvANc7fHCSyVKuHaG?=
 =?us-ascii?Q?NxX6SiRRWha5fZ0dZ2H4KoJNXctFXUAuUIG5Dhr6m3se5n67FkFvLxHjZxbu?=
 =?us-ascii?Q?2P6jIAZ6zBSox81TTo7nxUKMxe0c39B881b5JwKQufZIOyMENVYpAv7OhRga?=
 =?us-ascii?Q?Hq3FgAkAVqlPEZ4975yvZtJ3Y5KruLNaplXNa8znocw4wunF3b3lVZd6Y2EX?=
 =?us-ascii?Q?P5G4i0T+xTUKBBXcuAeHkqlM9L2i92L+afORrCbinqhjFdih1UsUN08b+fqi?=
 =?us-ascii?Q?Y9KHIIHsBIGVFl6DCGco6OvOblUrSbDVwQkyajDBRpxi3Iw7O4VdZx6/crd+?=
 =?us-ascii?Q?rm0lgLMaBVHLMEojFcLEVWei6wtuZySjXq/ucmWp09EFw3Bo5UJBPf/g2n+8?=
 =?us-ascii?Q?9iLVXQFxvmhxqGeTt0J7p4D9PaipQVXg4uFKZ6RGtDvoUIbbfA4gPGf3+Vmo?=
 =?us-ascii?Q?a/Su+P5z7kVkv1vezv7I6bX8gCQy1c6OEbsP3GfK4L+yDiFVHziSkzWcD2zU?=
 =?us-ascii?Q?YQqtAiiPNO+ILs3hluaVuVMgYTrSQhVrXOwrXTntdI7zV4F+6WGmB0Nq4S7H?=
 =?us-ascii?Q?YDa5WmNHzJfIU8uSNpkItGqPlZns6nVlLmuWqXdXX+Tt+sgJVuXFrbJHwam2?=
 =?us-ascii?Q?+PL1sfx9APtduVe0t9b8SReF54b8gOK/3xUTffKIAax+8QEpKenEO5bUVFDQ?=
 =?us-ascii?Q?e0zmnGZ7CI+3G+BcQ6xsbsg8j6JZNwxt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MnSrjTRPZIo7NBwG+zCUU7Gaq7IFfJEARObjKL/dAwRVXTRxHacNE38tQbA7?=
 =?us-ascii?Q?yhSEbPcJTuYA4vKKwX1mVRwkMZYVwk/+IDEv3B2iZE5bGZsLo543B1I2Olz2?=
 =?us-ascii?Q?vAkfs4EsfdbY9tqdrg9UDd+BWZWnkCETAdrhkcP9E41Bp0qmlt2tJU2UBSr0?=
 =?us-ascii?Q?wzsP4DxR6jBV5MGBrdubc3bUUgscPyeZvKdB48sFa7xqFC6ZSRxkxPLh9Skt?=
 =?us-ascii?Q?Y32bw67GBWpcd/3HccYHCKpyHla6MUH0CHcUrbpX4CPbRulfva0IJGzoUU1/?=
 =?us-ascii?Q?MC9+KLxEzEdE5qkjmt7ovU/8wryIt89f8IL0bhSCiZzPtgg9q/LxiNmzeKbZ?=
 =?us-ascii?Q?cpSkb9Scd3COzNKgx6DsIYBYJnITbyFXBDmMGFn9gIsYxmSzU6nkGgqBz5NO?=
 =?us-ascii?Q?NQt67pQqB07Y4fKo4zsRzufpngDnvwAJHIcC3zAc3/NBN3sm2XpOLenEC8cw?=
 =?us-ascii?Q?vh3vaz0F3GJSWvCrK1NykTnFXHE6PgdRkjAtXW+51nrM4MvW7hDev2EjQnJm?=
 =?us-ascii?Q?ORrC6gkPDrYH8vKDe5Fi+G2h+A5fC2IUHUG2+fCfZVAiE34YhVAo46brA7TI?=
 =?us-ascii?Q?3XV08PwOOBV+blORGgWj0HClOM+yRf2SacprP1RR+iKxYeAJAoiQ7PtmJxtG?=
 =?us-ascii?Q?z2GgXb4WtTsRGZvLPsh6yecag49hbiqwYVu3lbqsQSlOAp/Yo2ifP1a/ziRa?=
 =?us-ascii?Q?5VZuScjPhAmTSumhy5dmsGYiHThW7YHDS7GQRryqB2DfGJ/FXnxL81hguGaO?=
 =?us-ascii?Q?ChFTjGckIhXhUgKGW+xstfKDQZ5d/mhs93Sv08nPJUFq5KFo6DDC3L34jMUG?=
 =?us-ascii?Q?rdBga9mb5Hgi71YFvsy9o6xplkmzZoMWydkV1fxtBJFE1rbIEl2eJSW9d4PP?=
 =?us-ascii?Q?ZIA0ijOwHZsBipG3lTqahZ4hv02hQFLOO9GXqkaOaHFRWEp36suUPNA/uoo0?=
 =?us-ascii?Q?DaFNTFfE8BgZzcVprIOP7xBnQSKZme2mKTVIjarRfhDdD0f/8nZ/J7yn28kF?=
 =?us-ascii?Q?lCMxJ/0qLM4XKTDYBz0pkQmNrwwp/pIxPNjs9zD70TZvZ4e3l595YuBQVFMy?=
 =?us-ascii?Q?GW2wlIiYvX2kAGpnUQb3RKaMqFrOsyI+WEmEn/+BVWsYScWVxzmzu1YJRF+1?=
 =?us-ascii?Q?zNXzc4tcE71h0YJaOEo1uwN8OsUfso3BsSAC9qsaS+Wbl/RIgV+3iNJquJv7?=
 =?us-ascii?Q?9FEs+WMzgvXYRwKY6PiKN+LOUvr3aGSR32cyt6Bpg8nl0DgeG+WI06xdw/q7?=
 =?us-ascii?Q?KRr+53wWy0idFmbJnhfXstLii3fgkpTguqxt+usHwYfRTkEgNOP8GAfwmBmU?=
 =?us-ascii?Q?PAjyNz7X1oDuWyIg2im+Y0gyX5aqg/MB2HgvWsGH59sfy70P8Vt4RdenOUps?=
 =?us-ascii?Q?sNvSbcKc3EPVWUel1g05ykJOGbwoX+ziCtAATzY+svUtWzxhufwrh4NXhqQg?=
 =?us-ascii?Q?vBmJ+wZnJ6q7Rqu/oB4SIJF/ME2OH+AQWbrOp6K+8JzZ7Okd7pePz5T98s+A?=
 =?us-ascii?Q?l+iEdHqjZpICUW66XIG0OxBnwQypiXr9zImGbHicRXN7NinqRLzmjpOCySen?=
 =?us-ascii?Q?u2LuEfAtQzdNyVR1evrOQr/mlxOfy3GmKkLOh3Rc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d1b7ec-6eff-4ddd-1d3d-08dd6d2454a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:41:36.2037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghdkz7Fsl+ynLhiy/sUemODihF0XXgQCsIkL8keJoBhSe8bSFnl8nqqeWx+5RbV5s4LBAAxkuNGEBp+Td5EGp7pq4iLwKnPNinf7JEKa1SY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7294
X-Authority-Analysis: v=2.4 cv=ZLbXmW7b c=1 sm=1 tr=0 ts=67e53972 cx=c_pps a=+1/HLBYLL4tv2yjlBWnClw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=S0Y8YsWl6OhCg7AuG1wA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: vUO9CDnzE3C-bGtKzuW1-Hj4y4y7YAD3
X-Proofpoint-ORIG-GUID: vUO9CDnzE3C-bGtKzuW1-Hj4y4y7YAD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270080

Update the address offsets by removing the register bank offsets as
register bank offset will be passed to the read and write functions

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence.h | 75 +++++++++++--------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/co=
ntroller/cadence/pcie-cadence.h
index 69c59c10808e..cb3dd6738450 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -234,7 +234,7 @@
  */
 #define CDNS_PCIE_HPA_RP_BASE			0x0
=20
-#define CDNS_PCIE_HPA_LM_ID			0x1420
+#define CDNS_PCIE_HPA_LM_ID			(CDNS_PCIE_HPA_IP_REG_BANK + 0x1420)
=20
 /*
  * Endpoint Function BARs(HPA) Configuration Registers
@@ -242,13 +242,17 @@
 #define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
 	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
 			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
-#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
-#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) + 0x04)
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)))
+#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)) + 0x04)
 #define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
 	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
 			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
-#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) + 0x08)
-#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) + 0x0C)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x08)
+#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x0C)
 #define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
 	(GENMASK(9, 4) << ((f) * 10))
 #define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
@@ -261,12 +265,12 @@
 /*
  * Endpoint Function Configuration Register
  */
-#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		0x02c0
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		(CDNS_PCIE_HPA_IP_REG_BANK + 0x02c0)
=20
 /*
  * Root Complex BAR Configuration Register
  */
-#define CDNS_PCIE_HPA_LM_RC_BAR_CFG 0x14
+#define CDNS_PCIE_HPA_LM_RC_BAR_CFG (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + =
0x14)
 #define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
 #define CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
 	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
@@ -308,7 +312,7 @@
 #define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
 		(((aperture) - 7) << ((bar) * 10))
=20
-#define CDNS_PCIE_HPA_LM_PTM_CTRL		0x0520
+#define CDNS_PCIE_HPA_LM_PTM_CTRL		(CDNS_PCIE_HPA_IP_REG_BANK + 0x0520)
 #define CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
=20
 /*
@@ -319,7 +323,8 @@
 /*
  * Region r Outbound AXI to PCIe Address Translation Register 0
  */
-#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r)            (0x1010 + ((r) =
& 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1010 + ((r) & 0x1F) * 0x0080)
 #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
 #define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
 	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
@@ -333,13 +338,15 @@
 /*
  * Region r Outbound AXI to PCIe Address Translation Register 1
  */
-#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) (0x1014 + ((r) & 0x1F) * 0=
x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1014 + ((r) & 0x1F) * 0x0080)
=20
 /*
  * Region r Outbound PCIe Descriptor Register 0
  */
-#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r)              (0x1008 + ((r) & =
0x1F) * 0x0080)
-#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK       GENMASK(28, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1008 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
 	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
@@ -354,57 +361,63 @@
 /*
  * Region r Outbound PCIe Descriptor Register 1
  */
-#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r)          (0x100C + ((r) & 0x1F=
) * 0x0080)
-#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK    GENMASK(31, 24)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x100C + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
 	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
-#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK  GENMASK(23, 16)
+#define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
 #define CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
 	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
=20
-#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r)            (0x1018 + ((r) & 0x=
1F) * 0x0080)
-#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS    BIT(26)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1018 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
 #define CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
=20
 /*
  * Region r AXI Region Base Address Register 0
  */
-#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r)          (0x1000 + ((r) & =
0x1F) * 0x0080)
-#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK  GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1000 + ((r) & 0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
 #define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
 	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
=20
 /*
  * Region r AXI Region Base Address Register 1
  */
-#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r)          (0x1004 + ((r) & =
0x1F) * 0x0080)
+#define CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1004 + ((r) & 0x1F) * 0x0080)
=20
 /*
  * Root Port BAR Inbound PCIe to AXI Address Translation Register
  */
-#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar)             (((bar) * 0x0008=
))
-#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK       GENMASK(5, 0)
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar) \
+	(CDNS_PCIE_HPA_AXI_MASTER + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
 #define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
 	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
-#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar)             (0x04 + ((bar) *=
 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar) \
+	(CDNS_PCIE_HPA_AXI_MASTER + 0x04 + ((bar) * 0x0008))
=20
 /*
  * AXI link down register
  */
-#define CDNS_PCIE_HPA_AT_LINKDOWN 0x04
+#define CDNS_PCIE_HPA_AT_LINKDOWN (CDNS_PCIE_HPA_AXI_SLAVE + 0x04)
=20
 /*
  * Physical Layer Configuration Register 0
  * This register contains the parameters required for functional setup
  * of Physical Layer.
  */
-#define CDNS_PCIE_HPA_PHY_LAYER_CFG0     0x0400
+#define CDNS_PCIE_HPA_PHY_LAYER_CFG0     (CDNS_PCIE_HPA_IP_REG_BANK + 0x04=
00)
 #define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
 #define CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
 	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
 #define CDNS_PCIE_HPA_LINK_TRNG_EN_MASK  GENMASK(27, 27)
=20
-#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0   0x0420
+#define CDNS_PCIE_HPA_PHY_DBG_STS_REG0   (CDNS_PCIE_HPA_IP_REG_BANK + 0x04=
20)
=20
 #define CDNS_PCIE_HPA_RP_MAX_IB     0x3
 #define CDNS_PCIE_HPA_MAX_OB        15
@@ -412,8 +425,10 @@
 /*
  * Endpoint Function BAR Inbound PCIe to AXI Address Translation Register(=
HPA)
  */
-#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar)   (((fn) * 0x0040) =
+ ((bar) * 0x0008))
-#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar)   (0x4 + ((fn) * 0x=
0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + ((fn) * 0x0040) + ((bar) * 0x0008))
+#define CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + 0x4 + ((fn) * 0x0040) + ((bar) * 0x=
0008))
=20
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED =3D -1,
@@ -488,7 +503,6 @@ enum cdns_pcie_reg_bank {
 	REG_BANK_AXI_HLS,
 	REG_BANK_AXI_RAS,
 	REG_BANK_AXI_DTI,
-	REG_BANKS_MAX,
 };
=20
 struct cdns_pcie_ops {
@@ -636,7 +650,7 @@ struct cdns_pcie_ep {
=20
 static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum cdns_p=
cie_reg_bank bank)
 {
-	u32 offset;
+	u32 offset =3D 0x0;
=20
 	switch (bank) {
 	case REG_BANK_IP_REG:
@@ -668,7 +682,6 @@ static inline u32 cdns_reg_bank_to_off(struct cdns_pcie=
 *pcie, enum cdns_pcie_re
 	};
 	return offset;
 }
-
 /* Register access */
 static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 v=
alue)
 {
--=20
2.27.0


