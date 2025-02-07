Return-Path: <linux-pci+bounces-20875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B2A2BFAF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF973A51B9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060B13C9A3;
	Fri,  7 Feb 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="k78GM0P9";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jU0Xtxj1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8F1DDA31;
	Fri,  7 Feb 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921318; cv=fail; b=FcEND1GRgCHjRgCLkVnCp1kP0ib7MkQU+9W464Yk+FNKJJJ2mH+V4nrfJDMhI7H92jutPlUb6LFDO1hJnX23ldxMDGdCXYn6ryh3L6MvGC2hpi2WrW1MGtWFM3kopr5h6T0ZNbeeJAADk0qk5+KU6aQr9gHqBfY7AORZn0hpOMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921318; c=relaxed/simple;
	bh=W8cKGTsSehbp/n7p51IbEWANMRZm8+8DyheFtLhDu0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A+5G5Ps+iKOrhXivG3Py4Ik4bIzpeQNzcRJ0zoJt3OXlvAMPsYDQXETdYfPzzhFoJGolp5eh/0ZP/GUVzG/t5TxA77T2QuBq9lE9YNZ0Wax8vWThW0nQ89Zffm1RNBQqau50w5Ob3YaVg8/8DG5zmidOYWDmvV/kgFvj4deygrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=k78GM0P9; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=jU0Xtxj1; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5177R2b7026937;
	Fri, 7 Feb 2025 01:41:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=5Jzm1mxjm0S3JXM++UkoMQ69Kbf/9QnVHnJIXd+Xho0=; b=k78GM0P9rwbe
	7LH2pmEcSdQxIEYgt3m+XRpxcq1SM/yesxgdS2BT/bobNKKVPvVhiBFbYVhJwmP+
	wK+xmfD4XiXFa6HN1zlRLMlEFVEiVQDk8TjQoNoMNPo5cX5U8UObmezwaUMuSNyY
	m2ImNNcG59/1HbMICxqGKfgEtbrCb5yfS2VwVbPbqsBwV9/wBz31Lk3ZoMTTXUUb
	4Mw5ZeChcX3gByeUe78/mjWZ9IJEm96QB1GRkGgeK23HNoYNgq9sDry4R6D0SJjV
	w1D1B8i02LHc53hkMt2Qi+cNwjLf/4LrMLsBZeTm9YKFHPeRTyMST7Fr+zED0FHz
	4PcW0C86+Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44ndt0rm5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 01:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbe/JNQYLs/jqCBk0MlMcZUgXFXdVlPijacpYHKm571c4u6GoL8eNEhx2MuU5QNfj7GYyenEOlbg6AsMyC4NV/CyAMQJxATcDtgRaaQvGN0ZgMiOssh2whfeDTh+7q0XkXJBubb4QX1SfAuGBI9HalCeSOiTxKZtrRz9a9cInu5eeAUKWt7qCJzDOp/2EQHREjRCnlIgLYGa74VjZH6HvL6TwwTHzrerlQLusQkdwNQK1MFCpvqCvScauE5+8Ju8y5ECnPclY+TimwU6EYpgHnvzfSxs7cQZ83yX9ELkbQQjQDNpp0T/E5Vi+SyYZpwUhsWnPB5p7R0WMhQ0I9s3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jzm1mxjm0S3JXM++UkoMQ69Kbf/9QnVHnJIXd+Xho0=;
 b=KUWmrapB9himoPShxXQKGeAql5EqHGelLxbyCwopQEDmB/1QlpYj4Q0s4ZrmAQ4JwRFqEFZEhBjb6xQurnFw5z9/xDZUwtKy0rT61y9vlZUkDP8JO5pn1TtiUMfiwdjJHRiYZ1Rt9lZU2CZUnWpWAdBKE/0n0hlSFdJ0Bkt3E+b8XZL++ZuJrXYqGgBfrVH/bKSiAzNqfIdIAzViM8IpxpEOeiJS2WLAVCG42gnM1/12W2AaofhVyTV7rHygoMMIhXbDX7mn1svut+csgLS8eBklyIXUynq+mueLFqVeU4H22Ivi1BZRYPQrSN1Rgyo5H4D54lK9ynbAeq6n5JFJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jzm1mxjm0S3JXM++UkoMQ69Kbf/9QnVHnJIXd+Xho0=;
 b=jU0Xtxj186CkHEFxbuqXAustdTTvU8SSTpxm9IrHXNm8WfF/jb8zugoF8KB+0IGv5ObRx9Jfs7o+83BI+EacARwdQndFEZLRA4vZANdVxQQ+5aD/cAPkFw8XTbLyLiLl+srWdHlKitUvO9oQk5B7zww+hUlQqSm/YmIa4sDMxaI=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BL3PR07MB8817.namprd07.prod.outlook.com
 (2603:10b6:208:350::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 09:41:46 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%7]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 09:41:46 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [RFC 2/3] PCI: cadence: Add support for PCIe Endpoint HPA controller
Thread-Topic: [RFC 2/3] PCI: cadence: Add support for PCIe Endpoint HPA
 controller
Thread-Index: AQHbeUJuDpjhayRluEOMJR4sHBEYfbM7liow
Date: Fri, 7 Feb 2025 09:41:45 +0000
Message-ID:
 <CH2PPF4D26F8E1C1B4ED6433FFC2E3234B0A2F12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250207092645.3140461-1-mpillai@cadence.com>
 <20250207092645.3140461-3-mpillai@cadence.com>
In-Reply-To: <20250207092645.3140461-3-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iYjI4ZDk3ZS1lNTM3LTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYmIyOGQ5ODAtZTUzNy0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI0NTMxMCIgdD0iMTMzODMz?=
 =?us-ascii?Q?OTQ5MDA3NzUzMjE0IiBoPSJFOGVyUnFjbTFqRDRsVjM3TkdTQmVRRG5qWTQ9?=
 =?us-ascii?Q?IiBpZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dV?=
 =?us-ascii?Q?QUFLWUlBQUQrcjM1OVJIbmJBZGFDSllqOWZxU2oxb0lsaVAxK3BLTUtBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBc0JnQUFuQVlBQUFvQ0FBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBUUFCQUFBQWhGVjh5UUFBQUFBQUFBQUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QmpBR0VBWkFCbEFHNEFZd0JsQUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhR?=
 =?us-ascii?Q?QWFRQmhBR3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVpBQnVBRjhBZGdC?=
 =?us-ascii?Q?b0FHUUFiQUJmQUdzQVpRQjVBSGNBYndCeUFHUUFjd0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFDZUFBQUFZd0J2QUc0QWRBQmxBRzRBZEFCZkFHMEFZUUIw?=
 =?us-ascii?Q?QUdNQWFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUI5QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRB?=
 =?us-ascii?Q?QUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFB?=
 =?us-ascii?Q?QW5nQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3QmtBR1VBWHdCakFIQUFjQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBV3dB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3QnZBSFVB?=
 =?us-ascii?Q?Y2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY3dBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUNBQUFBQUFBQUFBQUFBQUFC?=
 =?us-ascii?Q?QUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFa?=
 =?us-ascii?Q?QUJsQUY4QVpnQnZBSElBZEFCeUFHRUFiZ0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFB?=
 =?us-ascii?Q?QUFBbmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JxQUdFQWRn?=
 =?us-ascii?Q?QmhBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFI?=
 =?us-ascii?Q?VUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFIQUFlUUIwQUdnQWJ3QnVBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?RzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBY2dCMUFHSUFlUUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFDZ0lBQUFBQUFBQWNBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFlOXhzbzY2d25TS1IzbzZMM1RJcm9IQUFBQUFFQUFBQUFBQUFBY2Ew?=
 =?us-ascii?Q?WEEyRHEwMFdITDB4TXZhY296eVlBQUFBQkFBQUFIZ0FBQUFBQUFBQmpBRzhB?=
 =?us-ascii?Q?WkFCbEFGOEFZd0J2QUd3QWJ3QnVBQUFBcEFFQUFBb0FBQUF5QUFBQUFBQUFB?=
 =?us-ascii?Q?R01BWVFCa0FHVUFiZ0JqQUdVQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRB?=
 =?us-ascii?Q?QnBBR0VBYkFBQUFDd0FBQUFBQUFBQVl3QmtBRzRBWHdCMkFHZ0FaQUJzQUY4?=
 =?us-ascii?Q?QWF3QmxBSGtBZHdCdkFISUFaQUJ6QUFBQUpBQUFBSDBBQUFCakFHOEFiZ0Iw?=
 =?us-ascii?Q?QUdVQWJnQjBBRjhBYlFCaEFIUUFZd0JvQUFBQUpnQUFBQUFBQUFCekFHOEFk?=
 =?us-ascii?Q?UUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFZUUJ6QUcwQUFBQW1BQUFBV3dBQUFI?=
 =?us-ascii?Q?TUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhBQWNBQUFBQ1FBQUFB?=
 =?us-ascii?Q?Q0FBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdNQWN3QUFBQzRB?=
 =?us-ascii?Q?QUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdZQWJ3QnlB?=
 =?us-ascii?Q?SFFBY2dCaEFHNEFBQUFvQUFBQUFBQUFBSE1BYndCMUFISUFZd0JsQUdNQWJ3?=
 =?us-ascii?Q?QmtBR1VBWHdCcUFHRUFkZ0JoQUFBQUxBQUFBQUFBQUFCekFHOEFkUUJ5QUdN?=
 =?us-ascii?Q?QVpRQmpBRzhBWkFCbEFGOEFjQUI1QUhRQWFBQnZBRzRBQUFBb0FBQUFBQUFB?=
 =?us-ascii?Q?QUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QnlBSFVBWWdCNUFBQUEi?=
 =?us-ascii?Q?Lz48L21ldGE+?=
x-dg-rorf: true
x-dg-tag-bcast: {7FF4CCB8-0673-4548-995C-62232765B6C0}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BL3PR07MB8817:EE_
x-ms-office365-filtering-correlation-id: 8b5630f4-4fb0-490a-7ad2-08dd475ba313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X5fJ10RSvyQc9mzlYObTTtcKvUM6NSY/jvkCBqd2e1qNPqNkXvZPJGClNKdE?=
 =?us-ascii?Q?WTnpVqekrfnwNQvlcWcj5WKKTW5JSTBo9vOo5P/LRSyrahLSzSrgvLvvHgEl?=
 =?us-ascii?Q?u90hzrdzuBJdQ4R73zdqeB4YnfYNuNlDfQu01efbO/lK1/pD4hIcf2O8+nPc?=
 =?us-ascii?Q?p2yCVeqU1PTVdTD0Tw2IEE7XmQmaIswdzPuPMDXPL+7AaO9Hpcm4WE6t6udQ?=
 =?us-ascii?Q?ekjKfRh+Vmm8uS25BeuZDCuOULoDXY1lVM30z+USOrydEvoUkokXYgjCeIUz?=
 =?us-ascii?Q?7dNPtTqi4rK7JYGf5nE0XlcpQ1oyaHqrxSszE7vOonp8+JO9WQpKgqN+ef9O?=
 =?us-ascii?Q?LsoOeY2DW+z71XOHE9mjM/JJYSfo3p1DsvmIa+IwhXElWEZGN3oOKL8C+7Ih?=
 =?us-ascii?Q?8qs/Z8fL6jmUFt0awBvqTFPZqQVvfob3qu7a0O3flEDSpYWAOXMKO9CEwELN?=
 =?us-ascii?Q?Uy/nR+1C9U6OMzskGZ6zIZD0uQ2l7ukxveXyidt59F/+xuT+OgqN5W8EzKFF?=
 =?us-ascii?Q?o7hg5HOfYeRPTzvizb6+DfPShloB7lGCQLyDnzlpi7Tt821uoE/lzYJR3Dug?=
 =?us-ascii?Q?zbTjywcHT2KRsE+jvkW++JiiRNIkCMhAURV4BKKMknV8ItjKhwbwtSfaO+DR?=
 =?us-ascii?Q?KYwpLbTFUKinkL8VE5CzCZDC54mZlXrYaGhWlMJjOuBnEnzVNw5GjUaTzWHW?=
 =?us-ascii?Q?VF/7gtzMSXXi/q2yEpd+fbD+Bfj+6sPFSyLTsD/Jbi1XmlhGETMs6E5ipKej?=
 =?us-ascii?Q?i2lQo1sCWKFygGL3W/HqoA+Az9KyM+sJCBaJhK3D9fFrTFLEu0hJjlCZ6nJd?=
 =?us-ascii?Q?BG3/gWVxC1ShxiNfAgMWTgKZurFFAxZL8+vTRZW6e6kgHtFx28Et2yA+BSxk?=
 =?us-ascii?Q?8Wts5YiXiRlUUphUC86NHDmHxuoAMwxcnqkrRzzTKkO+rFdkJ/v9WrIqRTBc?=
 =?us-ascii?Q?AQRFzRskmSC6zTNmkNBslLP778s3FfG6OGzkxQKv4YtZUviwwDkF9vhwuTcK?=
 =?us-ascii?Q?2859juhRfJ5A2DgrNoeTT8/7L022C2miLX6XjrM0Y2DpcPFgb9tOqL5MddFI?=
 =?us-ascii?Q?qfeDVB+oskSoNzZKYAQn9HfgaHbsCAyGnhVTREyrW9Dguda9oS8ZtZ7fkjl0?=
 =?us-ascii?Q?92thjEGbUOU1nIZyRhZqHfgQEVCtTVYis/kRbPH8lzxKko+64/DfYQGYGrk5?=
 =?us-ascii?Q?j9Nl99PQL7WR24a8JRf9NeiyDF9tUcijBY8YNq1NPCPav6ofO7jDEXi8EWlr?=
 =?us-ascii?Q?ldaXkvycaRfKBmPvvHOynOQ8627iFDlWkGLozkMLV9z/jFd7x1sGZRmRt2JB?=
 =?us-ascii?Q?WrmRG/APbrInzr+k+VoH9HqaFnHHUxbUN0AIA4+FV3ba6ZZCreMR8ZXbQf6w?=
 =?us-ascii?Q?qRz4bddxHihBS2GFQj9Zkal6BFrdtWe5Pv2ivpVaK+5FGcxFhs1m9v3gxejz?=
 =?us-ascii?Q?Izvnu3KB3u1sxzZz5pjtKPx6oLvQr4bF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PXFZnW6d3tJ9RLHrXKJ2za+0E4vDs4x0fc1qUOQ1YdJoiSpLCGbgsiT/YK6k?=
 =?us-ascii?Q?1mMEQC+QLcu/w/y/xz/b9ibhhC/SOYQDal1EWEd9ZZ6y9QYaJYTc+AzbjokB?=
 =?us-ascii?Q?yobfhMmSSMVzpCNkiGvE4xi3ekbFquRaARA3VkFHEsF8oIfLoRooV+ysumQH?=
 =?us-ascii?Q?eQjKF4xIIGrLna3vZ2tqAkRRMaOE6uQuVKIWnXfbwsemPf9FqiLp/u3IMw7i?=
 =?us-ascii?Q?kLcKx2nAo2D4gGRciC1zJQAVcYZpgz9y1g2GCcH1gdQ9Sr3m1oZOjbElBzoz?=
 =?us-ascii?Q?EKUyhQCS4FGfKGzgdh9Mdurlf69wqsqP3r3GKC0i1aEeQT82yv0mWvMNC5E+?=
 =?us-ascii?Q?qFc7qF1O2oEosmIjKiGd7v2McxYr56iGf+6YpVq+cLBlNA4Wf3tU+l9p8r3G?=
 =?us-ascii?Q?mxiGh0JoIWQ4cIGaqU/tYhdGvzVufqK2Mcv+HWkdFdtleXZs2u+Xhz4FLEbB?=
 =?us-ascii?Q?0ylOGnDUFn0pck6nlPN3j8fUzH58g9A8bVlx8avTmgKBmP/lhMuKiAmcXXeP?=
 =?us-ascii?Q?JwMKVQ4cm5ohkoRlWEutSUMtwm0e7DNb4bA1j8Lv+j/8F9ghOeQHpAadCSX7?=
 =?us-ascii?Q?VucPRGnckPbbBOvpvJvhtuMjuBuMKlpcpRAkgAzcpYNDFiPpJA76yNfIZlcS?=
 =?us-ascii?Q?F+/dK6mENmayth2fVa6nNlJgls2we6lHnRhStfDmRN+UKgU0aAC61w6zkabE?=
 =?us-ascii?Q?e88NrBE/mZTaJstY7TKxcPABiMccE2LE0QUkl/2ZIMnT8R/ourcLgGJgopbE?=
 =?us-ascii?Q?EVLpReJ8h9VESEeoJED+vGBtCInbKiPrBizXRe56RWRXm2HBL8lAIhVHsAA9?=
 =?us-ascii?Q?nOGq5WRyVx7pmIu2+vBlOOIAwyz9YlRuEkT5tASO891rbP4btPe7Kq5Dga4z?=
 =?us-ascii?Q?DTp7NMy1CjtrvcppviPbCWr6Gop6Lgm9A/YTDcjxIpEMkfkNZg9jv0u8mHjf?=
 =?us-ascii?Q?ia9qOhmeSVFMXfWcu/PRrWtcqn6gNJj4yDuKrOJnOQeexzOrBzPCn0PBvI9I?=
 =?us-ascii?Q?dWZrRN/jj71K7N03sTXaoTKTh3HZZekPM2CCANAjzMblFOQBjdKIBd3cReld?=
 =?us-ascii?Q?FctnMFsAcUu2tVrAp4ZxkpThLmU1iSjYBP9edTBrbK8M+4/aAx+f4GevZ8Yz?=
 =?us-ascii?Q?BxHEvVA26nEydnJPGui4wljQNyniLLj4MLUdCbNxox5eYtKiGFVDdtbB4uGp?=
 =?us-ascii?Q?gvp0uxmezSrkPCKhyP1b2JSJkfNCgA6Oius/1BSyqC83tHdJ9+4TKkE7gzc6?=
 =?us-ascii?Q?2rV/OIL12p466ufYL0kHBwQRiDU4nwZOnj6R2zBXXk5omG/NS1vBm4UrSzHX?=
 =?us-ascii?Q?+AYIGLuijixZTgU+xROeivDmCPfbYslQPbuUMDJv/jZmHNOWJkxgYo3fmH1N?=
 =?us-ascii?Q?oOs2H+AmNhQ1/DKgrXLA/hRteJCb8fM7Wl0thwiUgeoTzr6Y2nY36TVjMN6K?=
 =?us-ascii?Q?d43C07xdyihprUMDKNxUCV1STcSvpPEKfOP1Z4nos6syzzM1yA7SfFlj8jbC?=
 =?us-ascii?Q?R5XJoPTnxB1bzE/kbWVqW5lP4/YAjYZx6D8CG0MTFnLEaKeEOGfLGrX+icgQ?=
 =?us-ascii?Q?+uLe5c3UVIwMCcqrvW1cKYfsaklO4Ym2t4/+IGDz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5630f4-4fb0-490a-7ad2-08dd475ba313
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 09:41:45.9913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wa+fdsEKc5jVlXfYB9aGRJLy2Z1nyH85kPx6/PfDYEdPSh/hbEAAv6dvS/ir7Wl3yB9BeLNAlK3PU728tjnj+xYyPr73sVerEVk7QP59z/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8817
X-Proofpoint-ORIG-GUID: VRacR2n7WPbN3e4yNZzuy15TiFumntjF
X-Authority-Analysis: v=2.4 cv=ZJ0tmW7b c=1 sm=1 tr=0 ts=67a5d55b cx=c_pps a=K1+iGLXgNHoxMcL4Lb8acQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=aBq_wrnhfgAA:10
 a=Zpq2whiEiuAA:10 a=Br2UW1UjAAAA:8 a=u77rZ1vYNVD7zGrFyLEA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: VRacR2n7WPbN3e4yNZzuy15TiFumntjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_04,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070073


Add support for the second generation PCIe controller by adding the require=
d callback function and updating the register addresses and register bit de=
finitions.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../pci/controller/cadence/pcie-cadence-ep.c  | 144 ++++++++-
 .../controller/cadence/pcie-cadence-host.c    |  12 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 277 ++++++++++++++++++
 3 files changed, 420 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci=
/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..c911963b6e06 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -121,7 +121,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8=
 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
-	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		cfg =3D cdns_pcie_readl(pcie, reg);
@@ -158,7 +158,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc,=
 u8 fn, u8 vfn,
 		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
 	else
 		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
-	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
+	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
=20
 	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
 		ctrl =3D CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
@@ -569,7 +569,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
 	 * and can't be disabled anyway.
 	 */
-	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
+	if (pcie->is_hpa)
+		cdns_pcie_writel(pcie, CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc->function_num_m=
ap);
+	else
+		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG,=20
+epc->function_num_map);
=20
 	/*
 	 * Next function field in ARI_CAP_AND_CTR register for last function @@ -=
606,6 +609,113 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
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
+	aperture =3D ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),=20
+addr1);
+
+	if (vfn > 0)
+		epf =3D &epf->epf[vfn - 1];
+	epf->epf_bar[bar] =3D epf_bar;
+
+	return 0;
+}
+
+static void cdns_pcie_hpa_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
+				       struct pci_epf_bar *epf_bar) {
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
+	cdns_pcie_writel(pcie, CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar),=20
+0);
+
+	if (vfn > 0)
+		epf =3D &epf->epf[vfn - 1];
+	epf->epf_bar[bar] =3D NULL;
+}
+
 static const struct pci_epc_features cdns_pcie_epc_vf_features =3D {
 	.linkup_notifier =3D false,
 	.msi_capable =3D true,
@@ -645,6 +755,21 @@ static const struct pci_epc_ops cdns_pcie_epc_ops =3D =
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
 int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)  { @@ -682,10 +807,15 @@ i=
nt cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
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
 	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc); diff --=
git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controlle=
r/cadence/pcie-cadence.h
index fecb64ec9581..63284d741fc5 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -218,6 +218,217 @@
 	 (((delay) << CDNS_PCIE_DETECT_QUIET_MIN_DELAY_SHIFT) & \
 	 CDNS_PCIE_DETECT_QUIET_MIN_DELAY_MASK)
=20
+/*
+ * High Performance Architecture(HPA) PCIe controller register  */
+#define	CDNS_PCIE_HPA_IP_REG_BANK		0x01000000
+#define	CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK	0x01003C00
+#define	CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON	0x02020000
+/*
+ * Address Translation Registers(HPA)
+ */
+#define CDNS_PCIE_HPA_AXI_SLAVE			0x03000000
+#define CDNS_PCIE_HPA_AXI_MASTER		0x03002000
+/*
+ * Root port register base address
+ */
+#define CDNS_PCIE_HPA_RP_BASE			0x0
+
+#define	CDNS_PCIE_HPA_LM_ID			(CDNS_PCIE_HPA_IP_REG_BANK + 0x1420)
+
+/*
+ * Endpoint Function BARs(HPA) Configuration Registers  */
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)))
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK  + (0x4000 * (pfn)) + 0x04)
+#define	CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
+	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
+			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
+#define	CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x08)
+#define	CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) \
+	(CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + (0x4000 * (vfn)) + 0x0C)
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
+	(GENMASK(9, 4) << ((f) * 10))
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
+	(((a) << (4 + ((b) * 10))) & (CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTU=
RE_MASK(b)))
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
+	(GENMASK(3, 0) << ((f) * 10))
+#define	CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
+	(((c) << ((b) * 10)) &=20
+(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
+
+/*
+ * Endpoint Function Configuration Register  */
+#define CDNS_PCIE_HPA_LM_EP_FUNC_CFG		(CDNS_PCIE_HPA_IP_REG_BANK + 0x02c0)
+
+/*
+ * Root Complex BAR Configuration Register  */
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG (CDNS_PCIE_HPA_IP_CFG_CTRL_REG_BANK + =
0x14)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK     GENMASK(9, 4)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_APERTURE_MASK, a)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK         GENMASK(3, 0)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL_MASK, c)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK     GENMASK(19, 14)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE(a) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_APERTURE_MASK, a)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK         GENMASK(13, 10)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(c) \
+	FIELD_PREP(CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL_MASK, c)
+
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE	BIT(20)
+//#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_32BITS	0
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS	BIT(21)
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE		BIT(22)
+//#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_16BITS		0
+#define	CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS		BIT(23)
+
+/* BAR control values applicable to both Endpoint Function and Root Comple=
x */
+#define	CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED			0x0
+#define	CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS			0x3
+#define	CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS		0x1
+#define	CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x9
+#define	CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS		0x5
+#define	CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0xD
+
+#define HPA_LM_RC_BAR_CFG_CTRL_DISABLED(bar)                \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_IO_32BITS(bar)               \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_IO_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_32BITS << ((bar) * 10)) #define=20
+HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar)              \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_MEM_64BITS << ((bar) * 10)) #define=20
+HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) \
+		(CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS << ((bar) * 10))
+#define HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture)           \
+		(((aperture) - 7) << ((bar) * 10))
+
+#define	CDNS_PCIE_HPA_LM_PTM_CTRL		(CDNS_PCIE_HPA_IP_REG_BANK + 0x0520)
+#define	CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN	BIT(17)
+
+/*
+ * Root Port Registers PCI config space(HPA) for root port function  */
+#define	CDNS_PCIE_HPA_RP_CAP_OFFSET	0xC0
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 0  */
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1010 + ((r) & 0x1F) * 0x0080)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS_MASK, ((nbits) - 1)=
)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK    GENMASK(23, 16)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN_MASK, devfn)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK      GENMASK(31, 24)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS_MASK, bus)
+
+/*
+ * Region r Outbound AXI to PCIe Address Translation Register 1  */
+#define	CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1014 + ((r) & 0x1F) * 0x0080)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 0  */
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1008 + ((r) & 0x1F) * 0x0080)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK         GENMASK(28, 24)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x0)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO   \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x2)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x4)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x5)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_NORMAL_MSG  \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MASK, 0x10)
+
+/*
+ * Region r Outbound PCIe Descriptor Register 1  */
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x100C + ((r) & 0x1F) * 0x0080)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK  GENMASK(31, 24)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(bus) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS_MASK, bus)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK    GENMASK(23, 16)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(devfn) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK, devfn)
+
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1018 + ((r) & 0x1F) * 0x0080)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS BIT(26)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN BIT(25)
+
+/*
+ * Region r AXI Region Base Address Register 0  */
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1000 + ((r) & 0x1F) * 0x0080)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK    GENMASK(5, 0)
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS_MASK, ((nbits) -=20
+1))
+
+/*
+ * Region r AXI Region Base Address Register 1  */
+#define	CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(r) \
+	(CDNS_PCIE_HPA_AXI_SLAVE + 0x1004 + ((r) & 0x1F) * 0x0080)
+
+/*
+ * Root Port BAR Inbound PCIe to AXI Address Translation Register  */
+#define	CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar) \
+	(CDNS_PCIE_HPA_AXI_MASTER + ((bar) * 0x0008))
+#define	CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK        GENMASK(5, 0)
+#define	CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(nbits) \
+	FIELD_PREP(CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS_MASK, ((nbits) - 1))
+#define	CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar) \
+	(CDNS_PCIE_HPA_AXI_MASTER + 0x04 + ((bar) * 0x0008))
+
+/*
+ * AXI link down register
+ */
+#define	CDNS_PCIE_HPA_AT_LINKDOWN (CDNS_PCIE_HPA_AXI_SLAVE + 0x04)
+
+/*
+ * Physical Layer Configuration Register 0
+ * This register contains the parameters required for functional setup
+ * of Physical Layer.
+ */
+#define	CDNS_PCIE_HPA_PHY_LAYER_CFG0   (CDNS_PCIE_HPA_IP_REG_BANK + 0x0400=
)
+#define	CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK  GENMASK(26, 24)
+#define	CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY(delay) \
+	FIELD_PREP(CDNS_PCIE_HPA_DETECT_QUIET_MIN_DELAY_MASK, delay)
+
+#define	CDNS_PCIE_HPA_RP_MAX_IB     0x3
+#define	CDNS_PCIE_HPA_MAX_OB        15
+
+/*
+ * Endpoint Function BAR Inbound PCIe to AXI Address Translation=20
+Register(HPA)  */
+#define	CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar) \
+	(CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + ((fn) * 0x0040) + ((bar) * 0x0008))
+#define	CDNS_PCIE_HPA_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar) \
+	(CDNS_PCIE_HPA_IP_AXI_MASTER_COMMON + 0x4 + ((fn) * 0x0040) + ((bar) *=20
+0x0008))
+
 enum cdns_pcie_rp_bar {
 	RP_BAR_UNDEFINED =3D -1,
 	RP_BAR0,
@@ -249,6 +460,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
=20
 struct cdns_pcie;
+struct cdns_pcie_rc;
=20
 enum cdns_pcie_msg_code {
 	MSG_CODE_ASSERT_INTA	=3D 0x20,
@@ -286,6 +498,20 @@ struct cdns_pcie_ops {
 	void	(*stop_link)(struct cdns_pcie *pcie);
 	bool	(*link_up)(struct cdns_pcie *pcie);
 	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
+	int	(*cdns_pcie_host_init_root_port)(struct cdns_pcie_rc *rc);
+	int	(*cdns_pcie_host_bar_ib_config)(struct cdns_pcie_rc *rc,
+						enum cdns_pcie_rp_bar bar,
+						u64 cpu_addr, u64 size,
+						unsigned long flags);
+	int	(*cdns_pcie_host_init_address_translation)(struct cdns_pcie_rc *rc);
+	void	(*cdns_pcie_detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
+	void	(*cdns_pcie_set_outbound_region)(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+						 u32 r, bool is_io, u64 cpu_addr,
+						 u64 pci_addr, size_t size);
+	void	(*cdns_pcie_set_outbound_region_for_normal_msg)(struct cdns_pcie *pc=
ie,
+								u8 busnr, u8 fn, u32 r,
+								u64 cpu_addr);
+	void	(*cdns_pcie_reset_outbound_region)(struct cdns_pcie *pcie, u32 r);
 };
=20
 /**
@@ -526,6 +752,22 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc);  int=
 cdns_pcie_host_setup(struct cdns_pcie_rc *rc);  void __iomem *cdns_pci_map=
_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where);
+int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc); int=20
+cdns_pcie_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				 enum cdns_pcie_rp_bar bar,
+				 u64 cpu_addr, u64 size,
+				 unsigned long flags);
+int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc);=20
+int cdns_pcie_host_init(struct cdns_pcie_rc *rc); void __iomem=20
+*cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int devfn, int=20
+where); int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc);=20
+int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
+				     enum cdns_pcie_rp_bar bar,
+				     u64 cpu_addr, u64 size,
+				     unsigned long flags);
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc=20
+*rc); int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc);
+
 #else
 static inline int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)  { @@=
 -547,6 +789,34 @@ static inline void __iomem *cdns_pci_map_bus(struct pci_=
bus *bus, unsigned int d  {
 	return NULL;
 }
+
+void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int=20
+devfn, int where) {
+	return NULL;
+}
+
+int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc) {
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
+int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc=20
+*rc) {
+	return 0;
+}
+
+int cdns_pcie_hpa_host_init(struct cdns_pcie_rc *rc) {
+	return 0;
+}
 #endif
=20
 #ifdef CONFIG_PCIE_CADENCE_EP
@@ -572,6 +842,13 @@ void cdns_pcie_reset_outbound_region(struct cdns_pcie =
*pcie, u32 r);  void cdns_pcie_disable_phy(struct cdns_pcie *pcie);  int cd=
ns_pcie_enable_phy(struct cdns_pcie *pcie);  int cdns_pcie_init_phy(struct =
device *dev, struct cdns_pcie *pcie);
+void cdns_pcie_hpa_detect_quiet_min_delay_set(struct cdns_pcie *pcie);=20
+void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u=
8 fn,
+				       u32 r, bool is_io, u64 cpu_addr, u64 pci_addr, size_t size);=20
+void cdns_pcie_hpa_set_outbound_region_for_normal_msg(struct cdns_pcie *pc=
ie,
+						      u8 busnr, u8 fn, u32 r, u64 cpu_addr); void=20
+cdns_pcie_hpa_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
+
 extern const struct dev_pm_ops cdns_pcie_pm_ops;
=20
 #endif /* _PCIE_CADENCE_H */
--
2.27.0


