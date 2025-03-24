Return-Path: <linux-pci+bounces-24505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621DA6D6F3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2757D1890094
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C4C25D8E7;
	Mon, 24 Mar 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dAhepsfH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="D2onjeUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627714EC46;
	Mon, 24 Mar 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807397; cv=fail; b=gkW9k3TWlFkRiKDForDKFgsngoQkECOL8iB+QONQV0exXuV3nlG+Ph0/ZKCl8jZfEDw5R16xAf3MJslvNVFQgSHsZb2OCmsGmY7S5UVD+UAK5E5zxWjBKgwd4fvo/vRiN/Mg7qB5aeD19+U6dHNla6Iuu9dxl3YZrCsO5qD9JDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807397; c=relaxed/simple;
	bh=T9UkI/FpgiDA1VFOe1y/NPq2cvj4ohpRDGgcL+55Ls0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JwORyNecMq/nzyTstUgCeu6HUb2IH1SnBWOELRDLPFxstkWlDFLvF5vtr7rHSYU09sP4H6FpanfqiXXqNvErYN24zJpRgsfl/BqIYXpqViWo+mdD33owfOn3eY3fvXRv1uFaU614JaKt5mzjLRFdMvNkRjTjZQ6AQ2GVjFqwdnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=dAhepsfH; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=D2onjeUe; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NNbOFl017664;
	Mon, 24 Mar 2025 02:09:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=q75OSdbcGoikEa81a2N1P8tSy2e7X9WlZUbm6z/nOBQ=; b=dAhepsfH8Cev
	rCzsMj6CpssC4x6Tu0tHgzzJSAzUhEYkOe/EdJi9dH14L0DYeZ5SD4IIzP0uv4xj
	Pk4SmJjMWCkXHAGVrKEPRkbZRPuyzOw+6qfonoein/wMySkVK36r7RFMILRmSzet
	5tN5my3nwYqkLskUv2NSKj40rrChpwRhMVG6bRzD8wCUjXAQPllUPV32SzjlcyGJ
	daSaZlAZLTW1G4h0WjovQFhqGpeIpbJJRw1Ywyg0pbOHBiijFs8WRRx+h0AWLM9p
	PK07mTK7CBlNd1IhG7WkjKvYCjPeu1JfMCmq6pTuecbavV5KqdqxK3gy+RrOlFu/
	mKBqUPHKLA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012034.outbound.protection.outlook.com [40.93.6.34])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrswn117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqrgg4AB/PbaJU63VLuZ5KkeXFy0GJVLnq0edPT/VL/FHiyHsqairTbEvh2DCIEx4DcNOVxF+5yKNtnjrKp9RvgyxXUNP1rD1ndk78hdfz7U8Jm4Al5Q/b2LeHFCO+YbQ1CbLyc5QnpNUnPxnOvS9bYi1bF9BcuAKBXmu+qGfZ8H4qRvv2Pj73CrEx2K+g24dKg+E/IsLS5fiPvXhubMVGa2UmlINDGMgri33zLEav8uqeipcjE/mfkWTzn5H3ykndv6gwwmuulzqtIULCMAy767shmJpgnMb1jKXlJ2eu4pOlvkSZ7Wp+TC7b7g9Y3XbQFMwAgzyg44tff15RZNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q75OSdbcGoikEa81a2N1P8tSy2e7X9WlZUbm6z/nOBQ=;
 b=RselZ+SofClJ+9PKhW3iFopEMMOsS9P9YtA4fAjX/kCbbTxMHtjSjihGiiZLcx0Nv5GgoenYJcBldWgaR6EH0kAsPEUu6cVzIJrKvZ+J/jQpqR8sARlW7hgaaBNrkQN3vaeHofNqpBZQ+iZIIqyJkZhOR1XUyzxvqkBcAoNLIjb80Pa2NvRD8mJ65XOUraxVP3u2AydpdakxHa4b1mMwrMA3kykFuLvnUwDmkP4kUYZTlRFZSXbdQ+7SHbxhgNa4GD12zJuMhVnqCB24uM6HXj2KvNQdEogNEVSaMyf+2sLtXojgxnkSwz15AoS+nb1WAKhiCdmPel0EpABhfT1aTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q75OSdbcGoikEa81a2N1P8tSy2e7X9WlZUbm6z/nOBQ=;
 b=D2onjeUePFQwbnlcNuhWdbHQW5Q0LQ0exHY2d0Vh3MKwJZzKEa1B7SFaha06XHZizd8sxknuOj7cnpSh4EfrUj/TshpesGXhDhsTU8l1lzrVTA9S7tyRG35T4/BFNSc68JA4hiWwQ2LZo7c2Y1ZtzH3CpjmiytuQ1FVZVOJLNLQ=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:09:47 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:09:47 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 4/6] PCI: cadence: Add support for PCIe Endpoint HPA
 controller
Thread-Topic: [PATCH 4/6] PCI: cadence: Add support for PCIe Endpoint HPA
 controller
Thread-Index: AQHbnJYyn1BXAu4YTkKWzmkFpRrs/bOB/fuw
Date: Mon, 24 Mar 2025 09:09:47 +0000
Message-ID:
 <CH2PPF4D26F8E1CEC407C3DE045202E6F6FA2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082437.2566239-1-mpillai@cadence.com>
In-Reply-To: <20250324082437.2566239-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iOWJjMDY5YS0wODhmLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYjliYzA2OWMtMDg4Zi0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSIxNTI3MiIgdD0iMTMzODcy?=
 =?us-ascii?Q?ODA5ODQ4MDM4NzYyIiBoPSJ4c0hwZUN5by9WMU5JSEJVY0xtZ0QyMnFnMWc9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUJxWlJOOG5KemJBU3l3UHhiMFhQanRMTEEvRnZSYytPMEpBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQVVBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQUJRQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH7PR07MB11228:EE_
x-ms-office365-filtering-correlation-id: 7a9e9b19-5a97-4e32-2a64-08dd6ab3a008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ijkqXKMPt3WvRPIASaRMtsyf1hLHmpk3wtRTN06cuKDJz8FpADhzHALJnhFc?=
 =?us-ascii?Q?QDX4ZPiT7bSf13jBNmiTt/m39d7OYKdzPZZuYY2SX/e7hBsJuDFYegbeh6CH?=
 =?us-ascii?Q?UybMFM36Ugkk/QGoC3lNaH2nGFbVULBC2ebysWvuqfk38K+d4SNVympNwWQt?=
 =?us-ascii?Q?jxLrtJ+CsTdQc2BndLNyVfez3QNWCrg4qb/Wc2vpKQBTesEfiKHwqV0jdcoj?=
 =?us-ascii?Q?z0YUel+RBCY1ESNYhg/D1+0CFW+nBw4RNEEHmRXOdOxuvv+53cIpq1WKcgwi?=
 =?us-ascii?Q?70AmpRW/mY8LBymlIcbxVVPZuk0JZnzlrTwKPubxuIvddlrOj3NTv8lazL3H?=
 =?us-ascii?Q?BvNQ3L+7XGrngfB9ZqDntw1GqhgCdOCaldCup1EMv138p/8E8b+2uIqBUSQ1?=
 =?us-ascii?Q?M3TiD3ootRgzRQpw7nSnclN626NHDNFORKo7Bsf3tMoS/PPDa4CUxcVKeOtI?=
 =?us-ascii?Q?IpSqFoP6GcqjVtlW1nDX2v3lFoI6OEmERD2kwvl7aOyrkYbhcR5uBb9sd72C?=
 =?us-ascii?Q?ZtWfamCdMS5Zf+FN4YCLiBbn2lUEXbDxhvEPV6IqG/UVrq73usJHIM6z11Ey?=
 =?us-ascii?Q?S/8d0rzC3Itk+vOhO86KS0xBRKEIbxw6i7+h5ioWpjaQ4lXEXbXTj+TC9yyC?=
 =?us-ascii?Q?KpbVd5wXBkP/x8U1+LDDPSjTqRyxiUrcShFkWqQhrZ8n0sqA6Qx4fC7VfIA1?=
 =?us-ascii?Q?fK0KiePhM1J/bE1MG4p5cJEoxYV2xs2u3fw9gzFmn5xzRom7RAMlgAfJzXDS?=
 =?us-ascii?Q?NN6wkAoZwXo/OmwTZrKp1cyq1ZH54xUROsz6Ylb3kCmKF6TYFDnu0gCnIiFf?=
 =?us-ascii?Q?/QG5wMZA0y3oweCGctvxH0ebBO+WyItkKRYkNBfiVYUIBjotUxVoE9DWEuJu?=
 =?us-ascii?Q?tRRtkZ3ZBgnSThfn+VSiuKcmy96RUqSE+QeWXA7l3qLT8tSJBnt5wK7fYG2k?=
 =?us-ascii?Q?XR1/G0Ho3QjeRMMVMLlsqfl9Lc9ZpdD34g1dcaxtupSVy7oQNTxpWhzoNQk/?=
 =?us-ascii?Q?a3oPX0MJSOV/5VF5FXy5TxAs/WwTT1O1fOjyaH4ml5aaHZsHb2EwwuBgTvsJ?=
 =?us-ascii?Q?eDhYzQRQYpfaWG6sWIWwFSGmcQMvbn9XjdXPQu3n2WUCULGoiiU9XnsVTmJH?=
 =?us-ascii?Q?fIkQOAQNd0zHC7jL2bXGdXni16LMtB4iwrmt5EUQhnecVhi5eiTAdBYkQRcr?=
 =?us-ascii?Q?4qk1Hp4bUgM820haAH5CpMsdDl1styPaK9z7c9Z2irrHPQRlqtu3sDvOwowZ?=
 =?us-ascii?Q?Xx2fCOyYcJy8YOZqn8UObCEtRl5JF999ftmPZu7QA9d2zvjL+Wdeebw2POo4?=
 =?us-ascii?Q?blDE1440CrObJdHF2fOp5ELjwax9M6ki1uIXXBx205uRqHvCZAlIKqZLRb9C?=
 =?us-ascii?Q?9Zw1OcsJ6O6Ur41N2mJK3Hslrm4/hX+tIzF7Z0m2jrwK2Vz/fjJNGbDqDX9E?=
 =?us-ascii?Q?ILmLsoxSQCKeUNxDJ/flODcXOFYl7h15?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HIVezPJvwTMjtPsZyJMQAiAWU3OPNZbxclWiHbRwaiucUQr3i71My6WLYmF9?=
 =?us-ascii?Q?poJtuit0ob8VgRXBoksZR+2Fa1stf3OFH4CvvceV6m3TeSL2tIINJas5V2kd?=
 =?us-ascii?Q?qgvzssNuYmUysrc+gQWXjqgZTufKhVP1F4rw04J9yiDq7YaJXMHUXu640ZfR?=
 =?us-ascii?Q?tlf2ylS7wq5fzkFnk/drgqkcx2CWI9jHJ7Nq/3nW/GLvSmBpcEeW20XB28Ai?=
 =?us-ascii?Q?2quHkmBf94rRXD1Bamv2L9MTUaSfrf1J7CTg6axTExqDKxk2H00eLLtR6Acm?=
 =?us-ascii?Q?cqQVM0/x/3OfJsZl/Ntj/JIoLoP//6b+G6Xh2lzgkdKOoIHlXR5r6Ek1RtA0?=
 =?us-ascii?Q?N19KXaJUyG88dFZJ3tPUwGT+zvoDEnubu6xNY2TM17+gSmKe+m7Q5TPnqLbq?=
 =?us-ascii?Q?3OBgUQRIBXmvmMDcrP+iZbrtyfTFgtO/WgrZYn6X/jIs7tCTVDM2xDjiNGfp?=
 =?us-ascii?Q?rnCkXFHMnDkGxiBU8K1MWEjWFQIn7VCyRCtUjr9gemfi8JBd8HvYR1w2irwF?=
 =?us-ascii?Q?aTW4TMxZccr8MIgrymceitSB6+yFpa/0/0Dn+VAK/EEN5Nx1h3+Bb9ajHux6?=
 =?us-ascii?Q?aHO8I1l1Psy/5KRiwtduYHa5W6g1S0V1gRay55++mhUzJ2FI/+q30tR0iynr?=
 =?us-ascii?Q?SZJRqODFa0Jjgm4SrodkNIe2sif+yi/PyUfbWq9uq9v6n5AVEyHb9fBgiTcP?=
 =?us-ascii?Q?Po1NC3924jabKePDdK7rryezVSrXBfYwWsNvZEfI9zTHf6J/BqiRBRg/uJrA?=
 =?us-ascii?Q?S5kCBG0K9bgvMANNQLfYex4OnMmM2FwEWkApLm4ibN1ALmYwC11X2O+FrL5A?=
 =?us-ascii?Q?1K5qHUo1ZrYKGrOH5Y6/n9Y4FPfOfoH2DBFtqv+EVxZrBJtK/+oGzOG/yAif?=
 =?us-ascii?Q?K6rHoFJ80TLswoprES6WIDHWepcj3/dqHYblZFUPBhujWZhTZ8qm0JUKuFfE?=
 =?us-ascii?Q?FKEWAcMt8M6y5+2AtKuk3fRw8S78SMLYau+dk7C6d53gxJ7I13vvPXYTsxuN?=
 =?us-ascii?Q?yScyrwahJYrPU35iSO5qK8CMgdNJG8eYytb12D1mNA01TvBCnEiiamElqWRC?=
 =?us-ascii?Q?zr/Zz1ZlEjqKINCyfYcKkF20roqGX9QNfkTrPRw3P4f8PFWxFzP0/CIgaSFw?=
 =?us-ascii?Q?n2LK0t0GIWm8yp0bgm7lpXiMk/KRvlxKMfFkcrkvT9mV9UYpFEYymI2VhDaH?=
 =?us-ascii?Q?YE9pu8w6pAtzmSCHUQpPWXWrLYUdWYVDQSg/PT7wt9GyR0/17v1tE77P5lrE?=
 =?us-ascii?Q?ILNlCUGeo4U6mVZGcC2qpWDxwmJyc9rV37gTKcQvAhSAq/ubsSenK2vIimgM?=
 =?us-ascii?Q?w8NP1L5qW7/TZ+1CuErXfBKaYKV88sM2a8BLW4vUTrDN2b+vFhWJCM8ik63U?=
 =?us-ascii?Q?v/ZS2gcfMQZjyrsm4Yap6TabWdPySqZHo06CJdaTLB/55+4mGYbxrokPkCbR?=
 =?us-ascii?Q?DByJslOFMuqzy8YUeSZrpsEbGVpoB7/bDOdUsAM49kyney4TPwrLNMzqdb0v?=
 =?us-ascii?Q?uB53HidaX4ndCuVZljA3OsTBGcFknM10SQys+KnVl106E4Y1nfuW6WE1tHF9?=
 =?us-ascii?Q?2WWmTsYWST6usZ/x3w6HSsP9UdU5sewOF/NhvY/t?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9e9b19-5a97-4e32-2a64-08dd6ab3a008
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:09:47.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3Mmi+S7db7R70LVJlQ6LkOAjRdh7DgWT7wdkfmU5q/kGHEk05ktXMvAWrW8bd9iMrDcMsJfDHkj5cQ4NelPgr1iOwr/tf2SZqUW0eKfvsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Proofpoint-GUID: ANZBPfCQaBTj64CakIvETh1YwGiXmlKo
X-Proofpoint-ORIG-GUID: ANZBPfCQaBTj64CakIvETh1YwGiXmlKo
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e1215c cx=c_pps a=jgLrbg7RBTw9j6qPRKhXvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=n7m9l1-mCJkT1szWuNkA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240066

Add support for the second generation(HPA) Cadence PCIe endpoint
controller by adding the required functions based on the HPA registers
and register bit definitions

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 149 +++++++++++++++++-
 1 file changed, 141 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..ec2cd2d63105 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -93,7 +93,10 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 =
fn, u8 vfn,
 	 * for 64bit values.
 	 */
 	sz =3D 1ULL << fls64(sz - 1);
-	aperture =3D ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
+	/*
+	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
+	 */
+	aperture =3D ilog2(sz) - 7;
=20
 	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
@@ -121,7 +124,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8=
 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
-	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		cfg =3D cdns_pcie_readl(pcie, reg);
@@ -158,7 +161,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc,=
 u8 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
-	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
@@ -569,7 +572,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
+	if (pcie->is_hpa)
+		cdns_pcie_writel(pcie, CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc->function_num_m=
ap);
+	else
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
=20
 	/*
 	 * Next function field in ARI_CAP_AND_CTR register for last function
@@ -606,6 +612,113 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	return 0;
 }
=20
+static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				    struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf =3D &ep->epf[fn];
+	struct cdns_pcie *pcie =3D &ep->pcie;
+	dma_addr_t bar_phys =3D epf_bar->phys_addr;
+	enum pci_barno bar =3D epf_bar->barno;
+	int flags =3D epf_bar->flags;
+	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
+	u64 sz;
+
+	/*
+	 * BAR size is 2^(aperture + 7)
+	 */
+	sz =3D max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	sz =3D 1ULL << fls64(sz - 1);
+	/*
+	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
+	 */
+	aperture =3D ilog2(sz) - 7;
+
+	if ((flags & PCI_BASE_ADDRESS_SPACE) =3D=3D PCI_BASE_ADDRESS_SPACE_IO) {
+		ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS;
+	} else {
+		bool is_prefetch =3D !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
+		bool is_64bits =3D !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
+
+		if (is_64bits && (bar & 1))
+			return -EINVAL;
+
+		if (is_64bits && is_prefetch)
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
+		else if (is_prefetch)
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
+		else if (is_64bits)
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS;
+		else
+			ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS;
+	}
+
+	addr0 =3D lower_32_bits(bar_phys);
+	addr1 =3D upper_32_bits(bar_phys);
+
+	if (vfn =3D=3D 1)
+		reg =3D CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg =3D CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
+		cfg =3D cdns_pcie_readl(pcie, reg);
+		cfg &=3D ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |=3D (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, aperture) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
+		cdns_pcie_writel(pcie, reg, cfg);
+	}
+
+	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), ad=
dr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), ad=
dr1);
+
+	if (vfn > 0)
+		epf =3D &epf->epf[vfn - 1];
+	epf->epf_bar[bar] =3D epf_bar;
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				       struct pci_epf_bar *epf_bar)
+{
+	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
+	struct cdns_pcie_epf *epf =3D &ep->epf[fn];
+	struct cdns_pcie *pcie =3D &ep->pcie;
+	enum pci_barno bar =3D epf_bar->barno;
+	u32 reg, cfg, b, ctrl;
+
+	if (vfn =3D=3D 1)
+		reg =3D CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn);
+	else
+		reg =3D CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn);
+	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+
+	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
+		ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+		cfg =3D cdns_pcie_readl(pcie, reg);
+		cfg &=3D ~(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b) |
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b));
+		cfg |=3D CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl);
+		cdns_pcie_writel(pcie, reg, cfg);
+	}
+
+	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0)=
;
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0)=
;
+
+	if (vfn > 0)
+		epf =3D &epf->epf[vfn - 1];
+	epf->epf_bar[bar] =3D NULL;
+}
+
 static const struct pci_epc_features cdns_pcie_epc_vf_features =3D {
 	.linkup_notifier =3D false,
 	.msi_capable =3D true,
@@ -645,6 +758,21 @@ static const struct pci_epc_ops cdns_pcie_epc_ops =3D =
{
 	.get_features	=3D cdns_pcie_ep_get_features,
 };
=20
+static const struct pci_epc_ops cdns_pcie_hpa_epc_ops =3D {
+	.write_header	=3D cdns_pcie_ep_write_header,
+	.set_bar	=3D cdns_pcie_hpa_ep_set_bar,
+	.clear_bar	=3D cdns_pcie_hpa_ep_clear_bar,
+	.map_addr	=3D cdns_pcie_ep_map_addr,
+	.unmap_addr	=3D cdns_pcie_ep_unmap_addr,
+	.set_msi	=3D cdns_pcie_ep_set_msi,
+	.get_msi	=3D cdns_pcie_ep_get_msi,
+	.set_msix	=3D cdns_pcie_ep_set_msix,
+	.get_msix	=3D cdns_pcie_ep_get_msix,
+	.raise_irq	=3D cdns_pcie_ep_raise_irq,
+	.map_msi_irq	=3D cdns_pcie_ep_map_msi_irq,
+	.start		=3D cdns_pcie_ep_start,
+	.get_features	=3D cdns_pcie_ep_get_features,
+};
=20
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
@@ -682,10 +810,15 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	if (!ep->ob_addr)
 		return -ENOMEM;
=20
-	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
-
-	epc =3D devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	if (pcie->is_hpa) {
+		epc =3D devm_pci_epc_create(dev, &cdns_pcie_hpa_epc_ops);
+	} else {
+		/*
+		 * Disable all but function 0 (anyway BIT(0) is hardwired to 1)
+		 */
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
+		epc =3D devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
+	}
 	if (IS_ERR(epc)) {
 		dev_err(dev, "failed to create epc device\n");
 		return PTR_ERR(epc);
--=20
2.27.0


