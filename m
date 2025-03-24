Return-Path: <linux-pci+bounces-24506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FCA6D6F8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F78918929AB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7326AD24;
	Mon, 24 Mar 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ICWOzxTT";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dz72jsgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87E14EC46;
	Mon, 24 Mar 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807416; cv=fail; b=VvUBulesbEKcfuehwl8Yb9Jzeh9Gto6OcaFQKEHWXsbkdGBjGe8p7an/UWe29o6nBOMz+UZ5ocCNDzpgjnIV/1memWfCeWGNm2mw+Y9ew31zlU5m7iJT5VSyvZKe96nvjTRoIm0aIsNyQ9ZEF7nNbB+RA6PHHvk7SSMlHzHvlOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807416; c=relaxed/simple;
	bh=gBrk9qz/w2RrHePtUOIGVPs9jPnzD83vbI/6+NQ9v/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F9Uh/WhFby0z63MkshVxAVHmS/qVfglS8xYayj9kPFh5x62aoNXSy1lAYD50zQtWsxx3O7weIG0UPkxHzONMhdzNflLEF7zyh2fJ7fcP1TQW+yL8iGQs5mZH/j6oUWgP9++fhjECBLeet8JhvFAN021qHlgvnAuRGUZiIPlOXQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ICWOzxTT; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=dz72jsgS; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NKjFKS030480;
	Mon, 24 Mar 2025 02:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=dOOoO2DFlD/l1oIbsCP2MMli2TqMWeNDe53x9yk0DJE=; b=ICWOzxTTU0ji
	Socjk9SEyUlJ2JRF7mAeHgQ9ycp5ZB1o1fe6s6s1Os24FNPxynNmnu6JKjhJuJhS
	CIAk2LV1b80VMCUi4uW/bDwbO51Uiqkpz0AZGCb/D4XDjDD7Uf75YT1eJ6Kp2X++
	JUpSDKSigcxR76RTFmHaFAYH2r6b4lmfmTqwvSY+P7vhfZ1IWfry4MifBSgVB9H2
	0CNOTLzSCoxa7Y6hMvLheRxgAz6iJkjYVyJiJYGmthR5njmyOVMsKuHlW6M3cvlO
	vhbgpA9mGS9U5UecLZ2JW+XzBwIz7D0sJRjNsgrAhtPWTEYS0wC4dsTCGrlIn9nN
	BlXolVnyFQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010007.outbound.protection.outlook.com [40.93.11.7])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45hrswn123-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 02:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJjNYGLvjYaQOQkkcZ/58CsWMUpiQRKlQFAfRfEHivjQczmlaiMvoC1ke9lr9LusFFVd2a4sp8MUJAvrrJcsiiwKtYKiV+Hiq1u6Uv+DAT6J5pJFx8n0enfaUe+mMcaJaqGUyJjk1QrKMmUOKUzwp+RKXjjW2Qvz6v75Gs9zP/5nTBlH6/EG+2UK8DWuJu7L9nM+SPYpDO82RHOlryy3mpLpw+dZ5tQHNno28ahTDuH393k9zuY85Htm5tCGQKfBix/6XF23QZXu77GCfqe+N1bGbnDiEgDgoMFtUKpwgozKAgcAv9XfDCJm3kY2n6pAA+sLlXuUL9XCq9Ri72Xl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOOoO2DFlD/l1oIbsCP2MMli2TqMWeNDe53x9yk0DJE=;
 b=bf+Nb1ErW1jB4YdQrmIqmr2qV84Rn66n5QdxPC1MGaB6iBU1XrkbyY4tvcgcBvr9sIGR++H23LOYU8j69MQctcQmzI7M8JZcm5TzbSe2X1mJ3UGCQg1Llq/G/gNXAMnFrX8rCTSsxlHkl4WjbQdmMCJ74ngSBpHC2aFEGkY5tkvatP9Y7JvtlKOtWWAnShbO8z3PyzqfJ1onUdBS9KRUTfrMd3t52JizYA+QJI9MTRYlaMHR2A6ubyRGqWdWfAgCR6TEEUbURkxh5nospZriLvgM9zXoQwtHw/8ySSlaO0WvluQaps9kTIqPzDE9jIqyZ9pl8UA6u3PiUHuApH3c1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOOoO2DFlD/l1oIbsCP2MMli2TqMWeNDe53x9yk0DJE=;
 b=dz72jsgS/8Jc+/y5jXF+roec2VqdzD9w+V8psaNdiGDgVGL8I/OVG2/5g/DwQqZ68+RuByqdsc8vYrHnC9sNVkTWK0Yd9YOysUJATpkgBIQgY7J99UnWJeETFEZaSb9hcMcRJgcWBFHCGxUxYv9A5gHO04zLt7Apky+TsEiYBoE=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH7PR07MB11228.namprd07.prod.outlook.com
 (2603:10b6:610:252::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:10:04 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::9297:ebfa:5612:26f0%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:10:04 +0000
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
Subject: [PATCH 5/6] PCI: cadence: Add callback functions for Root Port and EP
 controllers
Thread-Topic: [PATCH 5/6] PCI: cadence: Add callback functions for Root Port
 and EP controllers
Thread-Index: AQHbnJY91+61rbs4MU2mn8JrYhyZR7OB/ikg
Date: Mon, 24 Mar 2025 09:10:04 +0000
Message-ID:
 <CH2PPF4D26F8E1C9CD00041B7BA962FADB8A2A42@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250324082450.2566294-1-mpillai@cadence.com>
In-Reply-To: <20250324082450.2566294-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jMmM4ZjMyYS0wODhmLTExZjAtYTM2?=
 =?us-ascii?Q?Yy1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYzJjOGYzMmMtMDg4Zi0xMWYwLWEz?=
 =?us-ascii?Q?NmMtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI0ODI2NiIgdD0iMTMzODcy?=
 =?us-ascii?Q?ODA5OTk5ODIwMzgyIiBoPSI3aVZxck0rbGRBZFlha0dPY2RVVDlNdjdiMGs9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFKQUhBQUJlWmgrRm5KemJBVmkweXhBdEpKZWRXTFRMRUMwa2w1MEpBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQTNBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUpJQkFBQUFBQUFBQ0FBQUFBQUFBQUFJQUFBQUFBQUFBQWdBQUFBQUFBQUFjZ0VBQUFrQUFBQXNBQUFBQUFBQUFHTUFaQUJ1QUY4QWRnQm9BR1FBYkFCZkFHc0FaUUI1QUhjQWJ3QnlBR1FBY3dBQUFDUUFBQURjQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBBR01BYUFBQUFDWUFBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR0VBY3dCdEFBQUFKZ0FBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCd0FIQUFBQUFrQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFITUFBQUF1QUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCbUFHOEFjZ0IwQUhJQVlRQnVBQUFBS0FBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QWFnQmhBSFlBWVFBQUFDd0FBQUFBQUFBQWN3QnZBSFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBSEFBZVFCMEFHZ0Fid0J1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQT09Ii8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH7PR07MB11228:EE_
x-ms-office365-filtering-correlation-id: 8e950964-6b87-45dc-4443-08dd6ab3aa17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vw6SvJBgIUkSaZuYv9k0kZKVPxbZ8sI0+DVI1Zl06NS+cdF9SR2t+qUXcBge?=
 =?us-ascii?Q?pd4A9LFzIj/qV7h9ft6IvRjrWFROrHOHfrSSMPhIZ9ek40sXcsbW55X9g8cU?=
 =?us-ascii?Q?rGl/8GUgOlBV8XbcbgAWh/BF7VN3A1lc9HyX09tNJ3i48BDpUPvYQOWvVJGb?=
 =?us-ascii?Q?glradadpggk0kcXKJF5ZqRZ2V8NFKT9AeV8xb2dY+04Rou87H/Z3CLeToQUo?=
 =?us-ascii?Q?M5dp9TqlBU2AW3yXWCx/gLAH4Qy8664zNdJOVrP8boH2TkJwBwsRTblfKG7r?=
 =?us-ascii?Q?wyXOelndF2h7YcnAK2Tom/e2bQgfoN9pl6nCSonyEHxp2RFFctLhpsDC9Oa0?=
 =?us-ascii?Q?DxCxjNfsbbYPuJXRxPjzDkrBpjsBUQ8T/QuCZN0hYaPIKd4L8MzzIspmdYuz?=
 =?us-ascii?Q?w8LJ1ZwZaIw1nv3Drptva7Fh6teBBYg21RCk2jCL/bauDv5+/eV57mZKMaNh?=
 =?us-ascii?Q?pgt4Qf8pdWFJeYalCFnRa4F1LEpvqmTnEcNZ1LcuaHPMOhFlSXyIEIXgYIGY?=
 =?us-ascii?Q?WMdGDpbGbfVMV8lZZJ+l87Hx4CGQS/gmFpylomjU61uEXoUdJpyOTXHcmObx?=
 =?us-ascii?Q?XaSwKFt2oWt5FTofLvBXtr3vNiNolETp1NKmoHJk/QTBaYemDOJQiQt2JSmf?=
 =?us-ascii?Q?2YnIjtYoPCk+P6rZLcYWguDjAnBjYJBvhvqUfH0XlHwfB0HWsagr6XUvLAP6?=
 =?us-ascii?Q?Vnc7emiaaAcuYAcFC6jAstXjESk/6tB5hV24DRJQxZxfgI0V4f4DD+rwlZtq?=
 =?us-ascii?Q?q1u+/5JnKQW8k9SMAl7OPYOzA1d8wwQwW+lsFaxNgknPH8Off1cuHf8JENwY?=
 =?us-ascii?Q?HZa0mOdie3dPSgt9eQrEWJvleVLe2Pzz0/xBURPzopIH6PQ/CtHmPblGixtE?=
 =?us-ascii?Q?aeUjYkQCaYMKkUCUiUuEgDIc+tW9HzZeVUP55mTGiugw77C0oV5/CAQFahA4?=
 =?us-ascii?Q?RFqcEne31DJmosG+bkTWQu873XMBBw3KgL25eeerWHiMzafSpnUQ5ZTJ4wF0?=
 =?us-ascii?Q?o6LGp9eZlSag0N+VVcg337ttuPTI95kzCZV4v6rFxZ3IQ6+EINUJAS20TumA?=
 =?us-ascii?Q?nGfHXETajer94U6HTjD2572fJBxfxPZqMFdnpcBDZQ3rbboLoyPemxVtCN3y?=
 =?us-ascii?Q?o8+eiqlsK4PAYR5VLvgVX+B52gP7DlK2ND5N/oj7iKJ6clB+FIrbJm/vhOP9?=
 =?us-ascii?Q?SybmXhJQQ4qbKdxKwhrGRsdZd5gytU2+0Rd+lJKu7KD6/rYFZkbCodR8PN91?=
 =?us-ascii?Q?jLoTcc1ZzCZP/0vs1tAuy7W/X+BRSIQhr9opUwP2p9PjJLRNVSXjRDj5LOWp?=
 =?us-ascii?Q?LQY4lr/8Rk98EFdWJN5gexMgEYULXT4KLRbMmHENaq9aIvFSkzMTucxUx3nf?=
 =?us-ascii?Q?2JbgC7838B+ZWlzFixX13G5jKdWDF+juRufIgvwQCjKT21CBjh3Uo8Ow9Co1?=
 =?us-ascii?Q?QVvS4XVm8dsknJAckgWUVYKGptuIeow6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rBxRTtQmh+TIBJzpVpJaqZfL0Z3HQlYLSZX8Y4c1kELFNyT1H02+dBxk5yDn?=
 =?us-ascii?Q?HNS0sf13b4UYqQ9XKVHUvj0tkai/lquVEvuddQJHz9GPNssPccJIesPGwMje?=
 =?us-ascii?Q?Tk8bfjLyy4AEceQSvkx3g/7a6of56olJl0ackJimY2m71x6MdO6AL84WJfTp?=
 =?us-ascii?Q?oG1S6zjD/ZY4TQA9MNlHN3m67IHulO2SfoXBf2LDylMX4QGoFLZa905dcvB2?=
 =?us-ascii?Q?IM5IqV1MJqQ4aFriMyhFo5yMjatd1a7i1D8qdpXBWKSM46TfmFHbM2ODfZBC?=
 =?us-ascii?Q?4qn09GrVQGqdGwpyk732JLc2LutmCfiv/8KX93CczZMFsK5vGKhclwbCUU5H?=
 =?us-ascii?Q?4eE8L79FfvosyZ/LnFbSqf5HAELjQPJA5y8lek3uZ9zpJ+q9PJJ1AG0tJiIx?=
 =?us-ascii?Q?MajfeM/eL43a9+z6TttU6UCbBwfzvL3gZqGxuiNqx5Vpjz23DJVg4WmV5FyD?=
 =?us-ascii?Q?aUKfRUkRAWklnFKh/H1wKQPp9cUHgbqlop5YEhL7E4GDmYEzHll+qL74YVF2?=
 =?us-ascii?Q?ZGI11NLOkbPqqSFSGMpBvHks8MWDdJohe7asln1E2d1DQXQKs6ZQuYnFB34Z?=
 =?us-ascii?Q?k81Xn6yis1qqHKZJFtAN4/pkmmYvSNjasKEPmMPzMSfVmu5FADCHUnkPH3W+?=
 =?us-ascii?Q?uOkfp4rapdrIRdUHcbUg71/NQsiQwnOANjTUvbVDKqk6njD+rzYSR8Ol/CGD?=
 =?us-ascii?Q?ResF84DoPmptliP1fsWqCCqsM39NU1aMjVeAxdGPd4cG0SU8zeJprOnEvB2y?=
 =?us-ascii?Q?8jGqo1GAh/cq99RY8Jj7uIdnanBzfsxhrq0qc18N9LorO8Q2F4A+WWpy8EeL?=
 =?us-ascii?Q?XiYiJsA2K6y05tggmhKVraLvltmjiA4NbXtZ5815//aaHEDjhxEFTVPKHPpx?=
 =?us-ascii?Q?NoTPlFAFCYoY1GlCtx+MVD1ILSTVRwUzXPLtk9iJLgoFGB5jO8rKhqA8tj7c?=
 =?us-ascii?Q?RF7lexc4H29qZZjyQUDR7oh9/CuseBwy2cBwN1Of1LUdYjE/eDqZrvXl39PO?=
 =?us-ascii?Q?F2Sw3knYsmOJr3S/vpafqPGeVHnaot+vily3hYAVZWxUAz6uAl2WitecEkbt?=
 =?us-ascii?Q?DmU8YLXBWjVv+DPqC4GpbMAjZ0VqJwxvZCWcwW2QLOs7dHNb/rdSAgqcig9o?=
 =?us-ascii?Q?ENRzl+hIddZcoeLSkixJFGEowJ6EwGxq/LEItjQN6yAPqd1FOIv5OS9TeGM3?=
 =?us-ascii?Q?fseww8ZjAmtly08A7eWEQD/ZpR4ZxVVc4+zAxWTUrk7QWANaBiywmSSyYTou?=
 =?us-ascii?Q?spLSHA2JNGJZr+L9inmE3QN7IzIjYXXvB/trSIXjf1CSSUDUOFTJvfMOQl31?=
 =?us-ascii?Q?qnqBwmg/W4XAGU85xX4Dm+/5sAdZ/T1yiCrcWMAFl14uA9SZtN3c0bcDR2mo?=
 =?us-ascii?Q?GcUii5+zvccvy7GDY3tg5P3pe+UZqmy5WzNw7mgeTZJKJvaQk0xi9A5WUTNk?=
 =?us-ascii?Q?SsPSN+BAJYduqQee2dW4pGAB4WcL/Rj4SrnbxGeUfcqyaSmSgZGuTtn3liAB?=
 =?us-ascii?Q?u2yrro7DkeWCCOj0RZugOC4oKqnSQipELbJdoenoTDqd6Maab+hPZJJcN7GS?=
 =?us-ascii?Q?n/o2kfKd+OqgaUG2fgNk48rtF753Heu2BYIXRSIv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e950964-6b87-45dc-4443-08dd6ab3aa17
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:10:04.1488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpilSstmngmPU5r026L2qJCRZcVk3AkzNc06mIuTaUKUjUX6RWbLba3USkKNU1rcAhwFMzEgYZWK9gH9mbbpPI/Yglrg1GyEJQD6rEG6Jhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR07MB11228
X-Proofpoint-GUID: ZsWEooV3xADgx7zQXdE04ClVXkLoU5Ck
X-Proofpoint-ORIG-GUID: ZsWEooV3xADgx7zQXdE04ClVXkLoU5Ck
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=67e1216e cx=c_pps a=kylQlKNaLH8A8Uw3zR316Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=-9qQUsueos1K6KzwvpYA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240066

Add support for the second generation PCIe controller by adding
the required callback functions. Update the common functions for
endpoint and Root port modes. The relevant callback functions for the
probed generation of PCIe controller is invoked through the callback
functions registered

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  |  30 +--
 .../controller/cadence/pcie-cadence-host.c    | 245 ++++++++++++++++--
 .../controller/cadence/pcie-cadence-plat.c    |  25 ++
 drivers/pci/controller/cadence/pcie-cadence.c | 195 +++++++++++++-
 4 files changed, 462 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index ec2cd2d63105..fa788cd0ed22 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -195,7 +195,7 @@ static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u=
8 fn, u8 vfn,
 	}
=20
 	fn =3D cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
-	cdns_pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr, size=
);
+	pcie->ops->pcie_set_outbound_region(pcie, 0, fn, r, false, addr, pci_addr=
, size);
=20
 	set_bit(r, &ep->ob_region_map);
 	ep->ob_addr[r] =3D addr;
@@ -217,7 +217,7 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc=
, u8 fn, u8 vfn,
 	if (r =3D=3D ep->max_regions - 1)
 		return;
=20
-	cdns_pcie_reset_outbound_region(pcie, r);
+	pcie->ops->pcie_reset_outbound_region(pcie, r);
=20
 	ep->ob_addr[r] =3D 0;
 	clear_bit(r, &ep->ob_region_map);
@@ -332,8 +332,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_e=
p *ep, u8 fn, u8 intx,
 	if (unlikely(ep->irq_pci_addr !=3D CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn !=3D fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
-							     ep->irq_phys_addr);
+		pcie->ops->pcie_set_outbound_region_for_normal_msg(pcie, 0, fn, 0,
+								   ep->irq_phys_addr);
 		ep->irq_pci_addr =3D CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn =3D fn;
 	}
@@ -415,11 +415,11 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie=
_ep *ep, u8 fn, u8 vfn,
 	if (unlikely(ep->irq_pci_addr !=3D (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn !=3D fn)) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
-					      false,
-					      ep->irq_phys_addr,
-					      pci_addr & ~pci_addr_mask,
-					      pci_addr_mask + 1);
+		pcie->ops->pcie_set_outbound_region(pcie, 0, fn, 0,
+						    false,
+						    ep->irq_phys_addr,
+						    pci_addr & ~pci_addr_mask,
+						    pci_addr_mask + 1);
 		ep->irq_pci_addr =3D (pci_addr & ~pci_addr_mask);
 		ep->irq_pci_fn =3D fn;
 	}
@@ -518,11 +518,11 @@ static int cdns_pcie_ep_send_msix_irq(struct cdns_pci=
e_ep *ep, u8 fn, u8 vfn,
 	if (ep->irq_pci_addr !=3D (msg_addr & ~pci_addr_mask) ||
 	    ep->irq_pci_fn !=3D fn) {
 		/* First region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, 0, fn, 0,
-					      false,
-					      ep->irq_phys_addr,
-					      msg_addr & ~pci_addr_mask,
-					      pci_addr_mask + 1);
+		pcie->ops->pcie_set_outbound_region(pcie, 0, fn, 0,
+						    false,
+						    ep->irq_phys_addr,
+						    msg_addr & ~pci_addr_mask,
+						    pci_addr_mask + 1);
 		ep->irq_pci_addr =3D (msg_addr & ~pci_addr_mask);
 		ep->irq_pci_fn =3D fn;
 	}
@@ -872,7 +872,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	set_bit(0, &ep->ob_region_map);
=20
 	if (ep->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
+		pcie->ops->pcie_detect_quiet_min_delay_set(&ep->pcie);
=20
 	spin_lock_init(&ep->lock);
=20
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/p=
ci/controller/cadence/pcie-cadence-host.c
index 1e2df49e40c6..c682bf03f75a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -73,12 +73,76 @@ void __iomem *cdns_pci_map_bus(struct pci_bus *bus, uns=
igned int devfn,
 	return rc->cfg_base + (where & 0xfff);
 }
=20
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn=
,
+				   int where)
+{
+	struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
+	struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	unsigned int busn =3D bus->number;
+	u32 addr0, desc0, desc1, ctrl0;
+
+	if (pci_is_root_bus(bus)) {
+		/*
+		 * Only the root port (devfn =3D=3D 0) is connected to this bus.
+		 * All other PCI devices are behind some bridge hence on another
+		 * bus.
+		 */
+		if (devfn)
+			return NULL;
+
+		return pcie->reg_base + (where & 0xfff);
+	}
+
+	/*
+	 * Clear AXI link-down status
+	 */
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_LINKDOWN,
+			 cdns_pcie_readl(pcie, CDNS_PCIE_HPA_AT_LINKDOWN) & GENMASK(0, 0));
+
+	desc1 =3D 0;
+	ctrl0 =3D 0;
+	/*
+	 * Update Output registers for AXI region 0.
+	 */
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
+		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), addr0);
+
+	desc1 =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
+	desc1 &=3D ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
+	desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+	ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	/*
+	 * The bus number was already set once for all in desc1 by
+	 * cdns_pcie_host_init_address_translation().
+	 */
+	if (busn =3D=3D bridge->busnr + 1)
+		desc0 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
+	else
+		desc0 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
+
+	return rc->cfg_base + (where & 0xfff);
+}
+
 static struct pci_ops cdns_pcie_host_ops =3D {
 	.map_bus	=3D cdns_pci_map_bus,
 	.read		=3D pci_generic_config_read,
 	.write		=3D pci_generic_config_write,
 };
=20
+static struct pci_ops cdns_pcie_hpa_host_ops =3D {
+	.map_bus	=3D cdns_pci_hpa_map_bus,
+	.read           =3D pci_generic_config_read,
+	.write		=3D pci_generic_config_write,
+};
+
 static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
 {
 	u32 pcie_cap_off =3D CDNS_PCIE_RP_CAP_OFFSET;
@@ -340,8 +404,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_r=
c *rc,
 		 */
 		bar =3D cdns_pcie_host_find_min_bar(rc, size);
 		if (bar !=3D RP_BAR_UNDEFINED) {
-			ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
-							   size, flags);
+			ret =3D pcie->ops->pcie_host_bar_ib_config(rc, bar, cpu_addr,
+								 size, flags);
 			if (ret)
 				dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -366,8 +430,8 @@ static int cdns_pcie_host_bar_config(struct cdns_pcie_r=
c *rc,
 		}
=20
 		winsize =3D bar_max_size[bar];
-		ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
-						   flags);
+		ret =3D pcie->ops->pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
+							 flags);
 		if (ret) {
 			dev_err(dev, "IB BAR: %d config failed\n", bar);
 			return ret;
@@ -408,8 +472,8 @@ static int cdns_pcie_host_map_dma_ranges(struct cdns_pc=
ie_rc *rc)
 	if (list_empty(&bridge->dma_ranges)) {
 		of_property_read_u32(np, "cdns,no-bar-match-nbits",
 				     &no_bar_nbits);
-		err =3D cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
-						   (u64)1 << no_bar_nbits, 0);
+		err =3D pcie->ops->pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
+							 (u64)1 << no_bar_nbits, 0);
 		if (err)
 			dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
 		return err;
@@ -467,17 +531,160 @@ int cdns_pcie_host_init_address_translation(struct c=
dns_pcie_rc *rc)
 		u64 pci_addr =3D res->start - entry->offset;
=20
 		if (resource_type(res) =3D=3D IORESOURCE_IO)
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
+							    true,
+							    pci_pio_to_address(res->start),
+							    pci_addr,
+							    resource_size(res));
+		else
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
+							    false,
+							    res->start,
+							    pci_addr,
+							    resource_size(res));
+
+		r++;
+	}
+
+	return cdns_pcie_host_map_dma_ranges(rc);
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	u32 value, ctrl;
+	u32 id;
+
+	/*
+	 * Set the root complex BAR configuration register:
+	 * - disable both BAR0 and BAR1.
+	 * - enable Prefetchable Memory Base and Limit registers in type 1
+	 *   config space (64 bits).
+	 * - enable IO Base and Limit registers in type 1 config
+	 *   space (32 bits).
+	 */
+
+	ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
+	value =3D CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
+		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	/* Set root port configuration space */
+	if (rc->vendor_id !=3D 0xffff) {
+		id =3D CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
+			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
+	}
+
+	if (rc->device_id !=3D 0xffff)
+		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
+
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
+	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
+	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags)
+{
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	u32 addr0, addr1, aperture, value;
+
+	if (!rc->avail_ib_bar[bar])
+		return -EBUSY;
+
+	rc->avail_ib_bar[bar] =3D false;
+
+	aperture =3D ilog2(size);
+	addr0 =3D CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar), addr1);
+
+	if (bar =3D=3D RP_NO_BAR)
+		return 0;
+
+	value =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_LM_RC_BAR_CFG);
+	value &=3D ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
+		   HPA_LM_RC_BAR_CFG_APERTURE(bar, bar_aperture_mask[bar] + 2));
+	if (size + cpu_addr >=3D SZ_4G) {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |=3D HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
+		value |=3D HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
+	} else {
+		if (!(flags & IORESOURCE_PREFETCH))
+			value |=3D HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
+		value |=3D HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
+	}
+
+	value |=3D HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
+
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc)
+{
+	struct cdns_pcie *pcie =3D &rc->pcie;
+	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc);
+	struct resource *cfg_res =3D rc->cfg_res;
+	struct resource_entry *entry;
+	u64 cpu_addr =3D cfg_res->start;
+	u32 addr0, addr1, desc1;
+	int r, busnr =3D 0;
+
+	entry =3D resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
+	if (entry)
+		busnr =3D entry->res->start;
+
+	/*
+	 * Reserve region 0 for PCI configure space accesses:
+	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated dynamically by
+	 * cdns_pci_map_bus(), other region registers are set here once for all.
+	 */
+	addr1 =3D 0;
+	desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0), addr1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
+
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), addr1);
+
+	r =3D 1;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res =3D entry->res;
+		u64 pci_addr =3D res->start - entry->offset;
+
+		if (resource_type(res) =3D=3D IORESOURCE_IO)
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
 						      true,
 						      pci_pio_to_address(res->start),
 						      pci_addr,
 						      resource_size(res));
 		else
-			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
-						      false,
-						      res->start,
-						      pci_addr,
-						      resource_size(res));
+			pcie->ops->pcie_set_outbound_region(pcie, busnr, 0, r,
+							    false,
+							    res->start,
+							    pci_addr,
+							    resource_size(res));
=20
 		r++;
 	}
@@ -489,11 +696,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
 {
 	int err;
=20
-	err =3D cdns_pcie_host_init_root_port(rc);
+	err =3D rc->pcie.ops->pcie_host_init_root_port(rc);
 	if (err)
 		return err;
=20
-	return cdns_pcie_host_init_address_translation(rc);
+	return rc->pcie.ops->pcie_host_init_address_translation(rc);
 }
=20
 int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
@@ -503,7 +710,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
 	int ret;
=20
 	if (rc->quirk_detect_quiet_flag)
-		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
+		pcie->ops->pcie_detect_quiet_min_delay_set(&rc->pcie);
=20
 	cdns_pcie_host_enable_ptm_response(pcie);
=20
@@ -567,8 +774,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 	if (ret)
 		return ret;
=20
-	if (!bridge->ops)
-		bridge->ops =3D &cdns_pcie_host_ops;
+	if (!bridge->ops) {
+		if (pcie->is_hpa)
+			bridge->ops =3D &cdns_pcie_hpa_host_ops;
+		else
+			bridge->ops =3D &cdns_pcie_host_ops;
+	}
=20
 	ret =3D pci_host_probe(bridge);
 	if (ret < 0)
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index 98ffd184be93..e5c0fcafb2ea 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -34,7 +34,31 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie *pc=
ie, u64 cpu_addr)
 }
=20
 static const struct cdns_pcie_ops cdns_plat_ops =3D {
+	.link_up =3D cdns_pcie_linkup,
 	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
+	.pcie_host_init_root_port =3D cdns_pcie_host_init_root_port,
+	.pcie_host_bar_ib_config =3D cdns_pcie_host_bar_ib_config,
+	.pcie_host_init_address_translation =3D cdns_pcie_host_init_address_trans=
lation,
+	.pcie_detect_quiet_min_delay_set =3D cdns_pcie_detect_quiet_min_delay_set=
,
+	.pcie_set_outbound_region =3D cdns_pcie_set_outbound_region,
+	.pcie_set_outbound_region_for_normal_msg =3D
+						cdns_pcie_set_outbound_region_for_normal_msg,
+	.pcie_reset_outbound_region =3D cdns_pcie_reset_outbound_region,
+};
+
+static const struct cdns_pcie_ops cdns_hpa_plat_ops =3D {
+	.start_link =3D cdns_pcie_hpa_startlink,
+	.stop_link =3D cdns_pcie_hpa_stop_link,
+	.link_up =3D cdns_pcie_hpa_linkup,
+	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
+	.pcie_host_init_root_port =3D cdns_pcie_hpa_host_init_root_port,
+	.pcie_host_bar_ib_config =3D cdns_pcie_hpa_host_bar_ib_config,
+	.pcie_host_init_address_translation =3D cdns_pcie_hpa_host_init_address_t=
ranslation,
+	.pcie_detect_quiet_min_delay_set =3D cdns_pcie_hpa_detect_quiet_min_delay=
_set,
+	.pcie_set_outbound_region =3D cdns_pcie_hpa_set_outbound_region,
+	.pcie_set_outbound_region_for_normal_msg =3D
+						cdns_pcie_hpa_set_outbound_region_for_normal_msg,
+	.pcie_reset_outbound_region =3D cdns_pcie_hpa_reset_outbound_region,
 };
=20
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
@@ -104,6 +128,7 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
=20
 		ep->pcie.dev =3D dev;
 		ep->pcie.ops =3D &cdns_plat_ops;
+		ep->pcie.is_hpa =3D is_hpa;
 		cdns_plat_pcie->pcie =3D &ep->pcie;
=20
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/co=
ntroller/cadence/pcie-cadence.c
index 204e045aed8c..983b9f1819cc 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.c
+++ b/drivers/pci/controller/cadence/pcie-cadence.c
@@ -5,9 +5,49 @@
=20
 #include <linux/kernel.h>
 #include <linux/of.h>
-
 #include "pcie-cadence.h"
=20
+bool cdns_pcie_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	else
+		return false;
+}
+
+bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
+	if (pl_reg_val & GENMASK(0, 0))
+		return true;
+	else
+		return false;
+}
+
+int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	pl_reg_val |=3D CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
+	return 1;
+}
+
+void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie)
+{
+	u32 pl_reg_val;
+
+	pl_reg_val =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0);
+	pl_reg_val &=3D ~CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
+}
+
 void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
 {
 	u32 delay =3D 0x3;
@@ -147,6 +187,159 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie=
 *pcie, u32 r)
 	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_CPU_ADDR1(r), 0);
 }
=20
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie)
+{
+	u32 delay =3D 0x3;
+	u32 ltssm_control_cap;
+
+	/*
+	 * Set the LTSSM Detect Quiet state min. delay to 2ms.
+	 */
+	ltssm_control_cap =3D cdns_pcie_readl(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0)=
;
+	ltssm_control_cap =3D ((ltssm_control_cap &
+			    ~CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK) |
+			    CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay));
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_PHY_LAYER_CFG0, ltssm_control_cap);
+}
+
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+				       u32 r, bool is_io,
+				       u64 cpu_addr, u64 pci_addr, size_t size)
+{
+	/*
+	 * roundup_pow_of_two() returns an unsigned long, which is not suited
+	 * for 64bit values.
+	 */
+	u64 sz =3D 1ULL << fls64(size - 1);
+	int nbits =3D ilog2(sz);
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	if (nbits < 8)
+		nbits =3D 8;
+
+	/*
+	 * Set the PCI address
+	 */
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
+		(lower_32_bits(pci_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(pci_addr);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), addr1);
+
+	/*
+	 * Set the PCIe header descriptor
+	 */
+	if (is_io)
+		desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
+	else
+		desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
+	desc1 =3D 0;
+
+	/*
+	 * Whatever Bit [26] is set or not inside DESC0 register of the outbound
+	 * PCIe descriptor, the PCI function number must be set into
+	 * Bits [31:24] of DESC1 anyway.
+	 *
+	 * In Root Complex mode, the function number is always 0 but in Endpoint
+	 * mode, the PCIe controller may support more than one function. This
+	 * function number needs to be set properly into the outbound PCIe
+	 * descriptor.
+	 *
+	 * Besides, setting Bit [26] is mandatory when in Root Complex mode:
+	 * then the driver must provide the bus, resp. device, number in
+	 * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the function
+	 * number, the device number is always 0 in Root Complex mode.
+	 *
+	 * However when in Endpoint mode, we can clear Bit [26] of DESC0, hence
+	 * the PCIe controller will use the captured values for the bus and
+	 * device numbers.
+	 */
+	if (pcie->is_rc) {
+		/* The device and function numbers are always 0. */
+		desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		/*
+		 * Use captured values for bus and device numbers but still
+		 * need to set the function number.
+		 */
+		desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+
+	/*
+	 * Set the CPU address
+	 */
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pc=
ie,
+						      u8 busnr, u8 fn,
+						      u32 r, u64 cpu_addr)
+{
+	u32 addr0, addr1, desc0, desc1, ctrl0;
+
+	desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG;
+	desc1 =3D 0;
+
+	/*
+	 * See cdns_pcie_set_outbound_region() comments above.
+	 */
+	if (pcie->is_rc) {
+		desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr) |
+			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
+		ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
+			CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
+	} else {
+		desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
+	}
+
+	/*
+	 * Set the CPU address
+	 */
+	if (pcie->ops->cpu_addr_fixup)
+		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
+
+	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
+		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
+	addr1 =3D upper_32_bits(cpu_addr);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), addr0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), addr1);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r), ctrl0);
+}
+
+void cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r)
+{
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r), 0);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), 0);
+
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r), 0);
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r), 0);
+}
+
 void cdns_pcie_disable_phy(struct cdns_pcie *pcie)
 {
 	int i =3D pcie->phy_count;
--=20
2.27.0


