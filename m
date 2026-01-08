Return-Path: <linux-pci+bounces-44252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D38D00FC7
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 05:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C47DF30275B9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 04:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF841299A8F;
	Thu,  8 Jan 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="obsYePvZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701B299949;
	Thu,  8 Jan 2026 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847321; cv=fail; b=m1Yvek2jaO2Q1vh0gwPgF45roEZQucI41E53g3z8+3ZxnwDhwDcXSS02khn0KXaXwoH6TMyy+rBpi0pB7aIZAUNKXaRiL7KQRO3cPfIiILrRNFJ2oqBUBew5kOdpcrXdbQERZeUQfcRkSIDj4qbn3W4u7ZPn5ZbLK7kG3/cBe18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847321; c=relaxed/simple;
	bh=dib5nD5PhWyatgleAGjNwP5Q7ghCRpRC5zsy/cfM/Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KbYq+eUABTUXSctNG1tQvPfKvhzjm+WpOREqUdXQhVAFAN0wMDhywqFuNFjv4Ee0C4ZjYsHQXtKzi3Xw75ERQCpuUnVZRj2Gk2VpiCxVluC9n2mL/K6+pMXEgmWmG/dNiSO02J6Pt3A5dtxujMGTVb8Y9d9BAuzQsBtg7koq8LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=obsYePvZ; arc=fail smtp.client-ip=52.101.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exkD17clxwKSJvDamPt5SMCGR27SupewVSGNcbs+EswJSCc0zhy6gJmyOfAOv8/ayD07OtdHri5OxQhOMp4mqJz0XVGsSW7Ql39ahGw+XHtTi5lIlOA6hGCJP1S09PGDGA7TjzFJybg8ClR6DLMVx+TM9+OusUed2HmQ4n0PRJXEigEFbsgx74RvW5hhkqP6l2huGjtOvYOIhMv2JlaKIyvUR1V53MTdmQ8lVJ1DiGKIdG+qWcqpVrDQaHtIgX7v72PUknRXbzz3ZbNYIjz1PsXWS+HnMCmQymYM6iD8TWR/crRv7WkJ+G0Ltl09NND3pk2IdJHEgKJLHWgU/3VsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC8iKsW2LQbAWC0sMLS0a89/T1dojsvk8x+hBDidKyc=;
 b=sSEX3QDObsMFEOxgbYJ6t9XoGzmYD47GrC1pDC+1jvHEGUZlO2GdzDc2bsXsChmJaY3QCRS7ULgBIDc3CVfZdwhPwyHHzQtHeFKxywyA9Kqp1mPUzDql0xQctam82mkBCiHdPXK030i7koCmUvOl+sKhi2ireN1mGCiESyuqLQGAFw+05jjZCnEmMBvQx1z5o5mFtyywJ3nEBtC0LrAsY0HnDZCLmDMEpAVt3pxiDwF3Gy9RuiSbgm7oKxsftg17mRB4OO+Aubom9RF3PCQgX38/4kubwTVTTI8MXzLAY8tzuwT/ItZ3SOKDJ+8XN7/e+Kw14jvymg0VftoRMZK8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC8iKsW2LQbAWC0sMLS0a89/T1dojsvk8x+hBDidKyc=;
 b=obsYePvZEAZvrk6ZF/i9IVSI8dktXvsBaoCRDbdBxBemDi3C23HU4/CxuPjqNZDbq7x6lPLGL6MHV2sOzpH9uzEKbIOayaUwy+A3gQHwfPkBYjePDJUoM2Fx3op5Std4DCrkIV+EXSOPYSDjLCuInrHqvxNAAoxBL6sRxqbMOP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3545.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:394::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 04:41:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 04:41:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] PCI: endpoint: Add BAR subrange mapping support
Date: Thu,  8 Jan 2026 13:41:47 +0900
Message-ID: <20260108044148.2352800-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260108044148.2352800-1-den@valinux.co.jp>
References: <20260108044148.2352800-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3545:EE_
X-MS-Office365-Filtering-Correlation-Id: a0271bc6-2fdf-4d19-58b1-08de4e703f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5Bscl2z/LkTi2x4yiv++MmF8JGTM0vDQ5SBrKM/J5hRlUMsh5uoZ4NyKg18?=
 =?us-ascii?Q?55+kqKCpVFgZtEdtuR9zLoYcxoO+q4HC+S1n/NzFSFOpH+8LE0CtDpOV88N/?=
 =?us-ascii?Q?bFYH3l642N1KqKPoxQLwAQ0O34TGdjIjHC0vIde5L99TG7ztXoSVYtPWQ6qu?=
 =?us-ascii?Q?pkYg4bPqF3nkafwRI6hIwrU22uXNRfpm35ZnfiMHTtm3TEjQwvvUGvHX1k3L?=
 =?us-ascii?Q?j3f6/nX3rZFaYi/kFcuWQ990F8vpXxtgGotUpfA32J26T39OnQG4Y8aYCWcq?=
 =?us-ascii?Q?yGhj/tCZVhKU8dIvD/xGRJtcJl/1VPCRSpDJPT0OBpq6RIzMU6DnxNE8X3A+?=
 =?us-ascii?Q?QfXOjSadL84ITeu07DKIT2ooiQL7FVk0ihWz7HU2T/GLtr/c48XY1w/vMVF6?=
 =?us-ascii?Q?BbxEohbWkbXNBR/LTJa0ZHg7URXvNNaXYtm9Dng5e/ZMXCneBHO1Jrsi4lR1?=
 =?us-ascii?Q?/ruqLjblEGM30n1uFAkix3W4dvj6hPhlQkI+AvzvM2oPEy6drzYqe3qzG8f6?=
 =?us-ascii?Q?DrJwv18u1g78JJSlAuJFMWZt8tLSYD/feR1kn27X5+8strTgIBhDfkEim+4C?=
 =?us-ascii?Q?Y7K8r/EpV946VOkY0zIP5/ZDdpHCyrjqGkocYn7v8o06ftDF7n+d0nOvtjzC?=
 =?us-ascii?Q?P2FGhPS3JTdR8wdKJAmCtFkqd16BIN1faBDzw41+kqpRJTaHg3/m/rhhrJv5?=
 =?us-ascii?Q?sgKGbhUv+QW5qzLi90BU+LajWxkYa9mUmZpjRsMC7lVu6rcg2pbwUrJ4Tcft?=
 =?us-ascii?Q?TuYji7vk7xzV8hqBzBy6o3PXZTl82ypjUE2FVUAy7YotIHbQwAOkNVG1hqbZ?=
 =?us-ascii?Q?fCzOUpYFdpPPn+aHualjagYOV6YRm4mRJt2E0xUkFH2kZtthfKKSQhWii3EA?=
 =?us-ascii?Q?Jdiyb15HLxThphF2S4MMMGLjWaYA24NczgJwK5GF2fo4U9J88DAuC/TND47k?=
 =?us-ascii?Q?upoyzFFpH35O6QIq4vxnDHGQZ+1VyGfEcekstxZ+YCrqQ2WYnQ9YS0en6hxu?=
 =?us-ascii?Q?5fUW4L9JMunzAtWdjXsQWPCFs3a0WjmsvjmwKfDH+h0Uhz6dyOYKJY4Euez5?=
 =?us-ascii?Q?6J7ZO4HY3lp67dfsD99D42aI9cwVTGHqXfnUt6/hqxlO46bWNO2KyWpAbEYB?=
 =?us-ascii?Q?R48NC2d1NjqmV9DIlfZwW1eia3Y/1MKtFeAW1YxNAts6/0T0LzpepXphTl/g?=
 =?us-ascii?Q?LEXVYd6EEu28Ij1CY8C6JNzGdEHTS9B1B3WZeaTeTlmObApBQk4i7v9F7fa2?=
 =?us-ascii?Q?Dv6lFZ90ZUmhVV7kvNgw3mrEMHoV3PLPVTAy1Fxb8uc+vligymNaLYHZFfvw?=
 =?us-ascii?Q?zgozXSO5uNo03FU4o0auwGhPOsCRpy6pxe0er8+t2aLHrW3bVl2MQTMRCG18?=
 =?us-ascii?Q?vtGPTCXxXUutp5amtnTf8smox9TMmycItuHBYw54Z5dis0hlhRVZGOtS4mW0?=
 =?us-ascii?Q?TX46ybR1sJowY9CQdGxyoTLyqmD7rPcN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mBZJNRv2mteafNU7dAFFujJYpovYnFZfBJOLns8j96C3uBcPbAuHm/KmMKFt?=
 =?us-ascii?Q?Fdsq+J6eBcl9N3ySLZquzH5IN+cx5Yfm90YGx/Fz4yOfUvCUmFjix5JD4aCo?=
 =?us-ascii?Q?JQBCge8qBGTlLZtbdqt+9M+uixuQGyxpN+OGJjPob7Jn2qDqs++SP/7REQnY?=
 =?us-ascii?Q?WijfxpKqYpjuSsVihDUkPhY97Faqgtw+Ory/UAzJJR6ZTIz5eOH6vmOXFMyY?=
 =?us-ascii?Q?3My7opHbhNtrGgDxERbi3xURMM/1ivC2n+T+JUMwJI6rDP4WjHBoxFei9HKk?=
 =?us-ascii?Q?vR7MDvAh5SOrZUIE3GpY3Ce1c44xxd+VLPaAKTuxpVgNfLkbGvXp0Hwt6BGM?=
 =?us-ascii?Q?4k/5J5ncs9sIhY6TczR9nzCQk831Q3fFsfPw4Iw5Bg/4IDI3ZHSLhwSSiaes?=
 =?us-ascii?Q?cwlkjz/KEjYQlJ+QmpIkNJDh4S4DlebdF19k4DJdb57Ah5PKVVjhchOS4aD0?=
 =?us-ascii?Q?MQ8eMtni4yEhgPHsL1O+TPiddYtBaIqNsnlZteztc+8CwRr2Utq+nzTr0sRf?=
 =?us-ascii?Q?ZfrSzavfWzqCEPtMWZBkb5iMMqgVaHnH8Nu5F5IQpq5j46mKUi3/sDkf5j4E?=
 =?us-ascii?Q?QxV74syoMIs4D/kfCceJsb5es3WttoBCC1viHsHPp/xAAxhhjFPsNayDllN8?=
 =?us-ascii?Q?YCczxBLocfAod329HPeJwZAfx1ktalcOp3U0KC+qzi3y7c9L2gRgqhanN1Vf?=
 =?us-ascii?Q?TSZAZb4yYx2Jc+Q9/lkkli3/HpIqCS1iJBDM4aqmxFPvEhtmcH+KRcCB+vTA?=
 =?us-ascii?Q?OkYWAgFsLYLB/+LKHZbgd6yaKsiThRQKQABPxPe3ssnM/wfmKWxOMlKvR2Wi?=
 =?us-ascii?Q?rrqet4lA3KTx2wACam/lkehQgQqDy/MBrzS+6Z4eGtVIuWO/xFxiBhwyRVWs?=
 =?us-ascii?Q?n2FeOdCV4V3VPEXNhg4LR6/lelQtIQf2Ufc9Ev8TEDX94o6xH4OgY3lABzZu?=
 =?us-ascii?Q?eYwCZ4DdPu70F4MQJNmGP8fP/SHvU8BUSsY7byh7LjoLh34mQn+sVCQuvSDK?=
 =?us-ascii?Q?9Pt8OoBAiVfeAP7ZV5o2cnkoByxWGqTMoWlnf6BWLGaEpqbmTNEkus2+fZsH?=
 =?us-ascii?Q?33PMidNqdZCSkG7vZQTC+1PAR/XivuywD3rqNMhQCJ9AQSHE5/Mot85gWMdy?=
 =?us-ascii?Q?hxghe1qFc1hWx85OQoJed47FhchCPuo8q8BPvtN9PfxRnRvMh1DsiIQzNjze?=
 =?us-ascii?Q?vm0D1s7Yvd4b/Tww/22GGm85rVAnLwj+r1iNC/trDk+Lsh2GCuYeRyJ4Kj5F?=
 =?us-ascii?Q?yEBALjEhqv+vHUWwOP42Bt+/dGHdfyX5yfL6x1yKF+amvwV94XOIFTJ3p/1z?=
 =?us-ascii?Q?p1KSAEoliPj7xTbrXgeOq2mXKueKd+6E8yGb1l2QEtmzw+ntAz6J50sLyRCQ?=
 =?us-ascii?Q?swG+dmJdl3fCyrsedZO3KotRXcy8YcYRZ72kVOiY65labqe2cx+gyhOCXCUL?=
 =?us-ascii?Q?dhw31PBqHsoPYoT9FYNyk0J5dqbS9LaFAPvOkPM12NN/CK1wUPefr84KS/6h?=
 =?us-ascii?Q?tUyYgOuq1DtlXNcZxjeqkGUNG/m37INSqJfl5sv1Odbrzek3W8L4fIFpncAt?=
 =?us-ascii?Q?0+RRM8L7cRamKVyi3Ii2qktNG4Fdo+bdf5W73KC1ScuIFx0kBSUkWWZI3vN0?=
 =?us-ascii?Q?FnNNp7XDnuPo5A9xB9NcOiNkoh/rRakDtRIghcDnRXzc3w7DPPR+hIXJf4Df?=
 =?us-ascii?Q?A/MzYzvsoAuCy0XhiBO6RCnYW9ttGosnpzNc1fDNSVwcT6tJDYDPtpi9KSnj?=
 =?us-ascii?Q?SIZQ5jE2E7vKjwdTSnUHQ5EXDoBpsRnSPF8+UhkLIAy7iygrKq+X?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0271bc6-2fdf-4d19-58b1-08de4e703f0c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:41:53.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OvFMfTogAGz3rCAj2y/TNMXSVQqn9Rs1RKvapSdoinY77w/2xf2g2n1j9kpVHVo71HZgIvGDtCfQiF1zQ+NCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3545

Extend the PCI endpoint core to support mapping subranges within a BAR.
Introduce a new 'submap' field and a 'use_submap' flag in struct
pci_epf_bar so an endpoint function driver can request inbound mappings
that fully cover the BAR.

The submap array describes the complete BAR layout (no overlaps and no
gaps are allowed to avoid exposing untranslated address ranges). This
provides the generic infrastructure needed to map multiple logical
regions into a single BAR at different offsets, without assuming a
controller-specific inbound address translation mechanism. Also, the
array must be sorted in ascending order by offset.

No controller-specific implementation is added in this commit.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epf.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 48f68c4dcfa5..91f2e3489cda 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,28 @@ struct pci_epf_driver {
 
 #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
 
+/**
+ * struct pci_epf_bar_submap - BAR subrange for inbound mapping
+ * @phys_addr: target physical/DMA address for this subrange
+ * @size: the size of the subrange to be mapped
+ * @offset: byte offset within the BAR base
+ *
+ * When pci_epf_bar.use_submap is set, pci_epf_bar.submap describes the
+ * complete BAR layout. This allows an EPC driver to program multiple
+ * inbound translation windows for a single BAR when supported by the
+ * controller.
+ *
+ * Note that the subranges:
+ * - must be non-overlapping
+ * - must exactly cover the BAR (i.e. no holes)
+ * - must be sorted (in ascending order by offset)
+ */
+struct pci_epf_bar_submap {
+	dma_addr_t	phys_addr;
+	size_t		size;
+	size_t		offset;
+};
+
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
@@ -119,6 +141,10 @@ struct pci_epf_driver {
  *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
+ * @use_submap: set true to request subrange mappings within this BAR
+ * @num_submap: number of entries in @submap
+ * @submap: array of subrange descriptors allocated by the caller. See
+ *          struct pci_epf_bar_submap for the restrictions in detail.
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -127,6 +153,11 @@ struct pci_epf_bar {
 	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
+
+	/* Optional sub-range mapping */
+	bool		use_submap;
+	unsigned int	num_submap;
+	struct pci_epf_bar_submap	*submap;
 };
 
 /**
-- 
2.51.0


