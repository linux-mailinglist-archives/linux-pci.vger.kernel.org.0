Return-Path: <linux-pci+bounces-36211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4768B5876E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B5F7A21A4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9C42C11EC;
	Mon, 15 Sep 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DDTHU8Uu"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EF2C11E2;
	Mon, 15 Sep 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975011; cv=fail; b=Qx3CzvNw+goCrQwzj/JxvGTtVM3Q2gL3dHeqfDoUXZVdgvrvhvyIO2HwWB33AVxlsdvK8/bLKAYsNXm2tb8D6bgiPH8esdPsU/A4QaJVsVwVnSjvlpg8NtTq38aRWpPoIzFfWAhBPR2oXj2wvLIAf8rNRkg7gbhjmK4pGwLfOL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975011; c=relaxed/simple;
	bh=nB3siptYVPJSuKSLYozqqi4fWc/srEnpTRmYzkDj4ik=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LatPCXZYU+tn6UgSdZrbC4cRAyHVECtRak8kq5cElt5gPed4InrDhXc6g31R26qmD21MmnwgFjYeR6rOIj10EVAdbbmFA/K7glQCjqQV/ih9OYVCcFLr5ssZ+/EYiADaQgE4L6IpOatEad+buKnSOtWqdy9jb4QHdKlpByO35JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DDTHU8Uu; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pECJ8V3cZuIAXxaoYMAdokIPiutF3wNsPIvrDQ88/Lf+vzS/PegwgcHNqRS91qnrN6sepeMCDZhZhqanVehNFkHmf7noqpMfO4hS/zfAeet0tQCqSqgYkgs6K/c7eyaD800qPocF7D4kP9dKLeTp3fDHpplJwlXvNUr7dHHS1ZT94DlWRcdAn40a5rfsd+e3uy3VnfuxCPrUa/C2pTEy/sy/uSBcR7flivTPNraKULS68qAuNzyftmEL4h20cyw9jY8NQ7b145h3te+YjqZcdwcmUUyKfdxd2yP6EfsCEkhu+zsFs/3GlejeabVnb+D39kuUjSNqPoQQ7VGRxEGfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vG6WDTAx+ApF7BPHpES9nyhotZaSHUY0mfputaAS7QQ=;
 b=PB+El+kyJezTIc4m2Qa8/S9pMupNQuphNMmSjm2aXc4Ykc/T7dZ0MHMRWDYvOGbiWNA50Q/4JEhWrfJHazajfzZDK4Bo08h0tcnYTqqtbVL7nL/I6KMzw82Tju0FcZdvb3c+gCcJZ+/1SmvEYsXRFTHCD2QeE7dnu+lhu+n37D0bVCfJBiRKSwuEsRdKxjTljWCL6xbgt4/Yws3yOnvPL9EBUfplgCXNWFvbF1W4TbzGSP56FS76R7ntbRrp/Nx3hGF7MSxDPpvaNChwRtXe/XSLK2Jxv4Psa7qisv4uQb6gPHSG6Tu4fhkNOtbt5jrFl6+Enrxvpn2kFVzhRIoxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vG6WDTAx+ApF7BPHpES9nyhotZaSHUY0mfputaAS7QQ=;
 b=DDTHU8UuGbHQ0Pif6D//TyVR2O0ZrqgO/briiXiLQNkTQLPVOUHI5To9Me06+Lf3RpumVbnxKmbprjNR9A9eA5PQXzInhlZhp0II9fhhJoSFt1IkHmlqobTU8ukCc5vy2fGW8WUPspz3asm+pUrbrO4mgENxzuJIGLf9xQcwUI+0XjoBxG4jx9Xh1+xEXb2bMqPD2C2p9pgg/w6tArnrPT6XidvZB90Ew3OIPg4+a51zkyvj0HdL8NU7e+vyGeShpYgRC63G8My24HrtTqLlBkl5ogeqM54etESJ+D+J/IwpaLBgTXackSjGYaDfFjbdwwxX81iTBcmzSk6U0ljIWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 22:23:18 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 22:23:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Sep 2025 18:22:45 -0400
Subject: [PATCH v2 2/3] PCI: endpoint: Add API pci_epf_set_inbound_space()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-vntb_msi_doorbell-v2-2-ca71605e3444@nxp.com>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
In-Reply-To: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757974988; l=5006;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nB3siptYVPJSuKSLYozqqi4fWc/srEnpTRmYzkDj4ik=;
 b=Bfq03KaTjIHYlFtGzZJdI5hhAEsZkuhu34w/EDrpqYGE90aiwWy1VpbJZ+KGv43Xp03zl5dA+
 tmzcrdiSv9XAgwlWcZ9zvgt8X6gmn+i9Dt4MrTkV/CRmjNX66uAJbg6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 196a4fd8-911f-46b9-062f-08ddf4a678ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0h6RGFrdndzdnFwV2h5MGdZU2NIZDA4K2FaNGdlQXBjS0NrRm5FYXdJNnZw?=
 =?utf-8?B?aHRTanJrd0tObXoxc3FXTkUwcVlTNXE1Q0FJZnV4MHhabWdFRGxnUDdkZGFm?=
 =?utf-8?B?YUprRHhwazc1ZHY5bERpaVNKb0oxbmc1OUxRTkN2YUhrS0ZyNWx6cFgrSWJq?=
 =?utf-8?B?OXgrMjlySitROURINVVrNElEWktmdDcyZjJFVkFFeXpNYTlVTURDaHBwaExE?=
 =?utf-8?B?SGdDVjdsYVhIcE1YWDQrd0Q4RUtUS0xlZ09acXJQMkNpbmY2QjE3WDRQdlp3?=
 =?utf-8?B?bExDcWtBb1IxRFlxZC9GQ0QxdjhlM2c4dlRwcUdEUmpFM0dicnNpWGpYZXh5?=
 =?utf-8?B?U0RjLzhRVlZicEw4aE9HTTh1NFQvQm9LTEVjTXR5cVhOMkZtQkhqRjRtZ01p?=
 =?utf-8?B?UTYzV2p2YU9VN05mMEZpL0dJVUZmSFd2QzRjeEZ2U1A0WEJkaXdvS0JHY3lM?=
 =?utf-8?B?Wm9oNDhkbk9QYmxQZ3MvQzJuK1pDeWNldklnRXNnWVg0TmtoK0djeGZjd3I4?=
 =?utf-8?B?ditNK25ZK2pCVGJ2Qm5nNnR1YkQzc0hQZHBwc2tXZXE2UXNxU08rdUtmMW50?=
 =?utf-8?B?Wm9rNnA4WjFkZDFsdDYyakZMMGxocDhXKzAxcGVmQ1NheEpCRmVjN1d1d0ZX?=
 =?utf-8?B?SXJlZTRoZ3Y5S1gxL3FUYVdVTkpNRmIzU29Kd0ovSWQvZjUyai96eWQrZm1U?=
 =?utf-8?B?NWtSV1gvNkRUVExOeTBjK1k0ZUpTdFZFY3lVbU04RHJKVlhoVE40RnJiTTlv?=
 =?utf-8?B?Z1YyUlJKeGUxeU0vZHlXWUpjSWUwZEkrTUZHczFmcnhUcHp6M2FsRWVKaTBG?=
 =?utf-8?B?K0U5c2JiVVFSdjVJWXJXN0szcmdBVUI5YS9MY01OZTJ1SFJxRW85K29KcWJU?=
 =?utf-8?B?bHJuT2xYVDFhMVo3YzdzbE5jV0NzczRPajFxb2MwOStDbisycHkxYkI5N3Rn?=
 =?utf-8?B?cmNhUjBnRkJtVVhzQUFuVktXcHNLWU5PSVdoTnliQzZhRDlzZ3d5bnFLQ29r?=
 =?utf-8?B?R01kankwenExQnhlZlNLanpBL0hTazZaa2ZVSUZlWUlnUHkzb0FLam1mL1Zh?=
 =?utf-8?B?UlB0VHFpTXNIWTF3Tytadk9ONlRvbE56WTlMV3NvNDk4Vlk3QkMwbHI0emk3?=
 =?utf-8?B?VXdXZEIzcU5kQ2RJZXoyNVorUFczalRBUERkNGY1Ym9iQUJxanNkRGdwNE1t?=
 =?utf-8?B?M1I0UlJiazZiNjJkL2hFeEdLdWtTY3VxME1IWkcyKytnQW9LN3ovdExXM1Js?=
 =?utf-8?B?dStZOHdHeHp0S0RoY0ZNOHZ0cmdDbTlkMGYrdmh0VXZyUFc1K0NxaXg4Wit5?=
 =?utf-8?B?SWxBMzFXWTFvMjB2Y0N2RitzOGs2bVNCZUxBT0NSKytpbG40MFp2NjY2SktF?=
 =?utf-8?B?YXV1ekhCdTk3NU95YnQvY1pPSFBvcGk2UmVob01vYStVclJRS0NKSGRaRXpu?=
 =?utf-8?B?aHhWd2cwRDRRY1pBVzhsZUNNTTVzb2R0b2pBa1VpaHFjaldsZWk5clRnK3E2?=
 =?utf-8?B?RTRIOUs5cElTYVM4WmMvcXFoTVlXZ29PVjJiL28yMTNWYjF0empvbHc5OWJR?=
 =?utf-8?B?RXhTRFdZcU4zOFNONnlxQitQMytDMnNIajV3dzkycW84T3FlNFFGQ29naFVL?=
 =?utf-8?B?M3Fsb3VnSFZXTHlCUHFXTVpabjI1dzU4TTMrR0dBOEJmNnNML2h4RnR5S1Zm?=
 =?utf-8?B?SzZqdlFzazRGcGE0TStTL0dVdHBPbVhRaHNZRTBrNUxKeWR1NUNZbG1RSFhT?=
 =?utf-8?B?VHV4TFB2QjJ6eGpCMytnamtnMXN2Zk8wWER6bC9yTjEranhQQjVtQzh4QjND?=
 =?utf-8?B?NWx3eXh3WGovVGdNY0tZdm8va1ZnR3VwMXBBam54U3lQcnJONVQvM1Y1NElY?=
 =?utf-8?B?Z3lFWlcraDM4cHZPc1JhMGQxSEMxRTdvQi9aRDBEVWhwTnVQMEt5NXNldkhU?=
 =?utf-8?B?R2IxN2h2QnR5d2hNK1NrV1ErZWlYUnlKTUs0ZXhnWDE3M1Bmb0QyWGUzNFJV?=
 =?utf-8?B?cXRodEUzZ2tBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtGSVI4U1FjZ0dKTGVBdU9CUDZCQmVpa0RLUnB0cEFUNGdUV1JqbzdMc3Mx?=
 =?utf-8?B?dFZMT1JMdUQ1OWxwM3ZHQ3MyR2RvaUVFMkVCRlZXaHFlcXpkT0dncjlwVUpk?=
 =?utf-8?B?dktHc2JUb3RJZmpBT2M2VmxEbHhtbTl0SGkrc2lJV0RMZ2F1VkRYQUd0eDBJ?=
 =?utf-8?B?OEVKRWFqSWd5aHZKYkZ0d29EaFJOdHR6TFp6VHpJSWFudlE5bzJHM2ZRM0tU?=
 =?utf-8?B?Y2JpL2NNNGVOdGdRWVBuNFVFMlZ6LzYvNWQrZVVlY2pkWStTNTIrSUFuQzZX?=
 =?utf-8?B?Y3lHc3hVU3VtWHZqM2NwVTlWSjROT2FocHFudGtEOCs5YUlwbGQ4ck9OSnpM?=
 =?utf-8?B?VW1oNW04cDBaMUUwWjBLU0VBUFkvdlRxaUNwTVlBMTFxamhLUUJsQjZvcUFx?=
 =?utf-8?B?N0lSSkRyWm5sbU1FUDRRTjIyNXF0cFpCYzkyTmVEY05HdG1YcE4xRk9XSGEz?=
 =?utf-8?B?R21YcXZSNFVsNlFDeXEwRk82ODJ5ZFJGYXQxZVdxb3R2RFNxUGtMRml3YTBZ?=
 =?utf-8?B?bDJnNHJDOGl2UjZROFd5UFB4L1gyalRpOVBjbFdieDVTTWM3SXdBeHBzQmhz?=
 =?utf-8?B?SHMyVE1zOCs0K041NDF0Y0JOc0Q1bUNYQjFCNlFBVCtGZ1lHQXpIZE9kMWpi?=
 =?utf-8?B?cHU1akhKdStSL0JHNktldEYvWWMvOW5OQ2JrdUhRUWl0TmpNVCtCNk5Db2pI?=
 =?utf-8?B?cW9GdG9PRTRQbFdBbmlKS0JVTklQMDYwVUxOTzlGeEdMOFFuWS9pbXVzeXlB?=
 =?utf-8?B?OHlkd2lQTGQxT1lTWFhTNExRL1VYcEEvNlRBV0d5d1IzUzlCUDFrOUMrOWNy?=
 =?utf-8?B?MHRPQlRuS24rTTd1dmpxZ0RmOW5sbDFucEhwUzFvSlZxM25wRkd6T1hHWHVo?=
 =?utf-8?B?aG1xSXdSNVQwSXdjSWNoSFVRUXRXTEcyUkZ3djFrS2dxaTF4RGVTU2VuK1Jy?=
 =?utf-8?B?QnoxV3pSbENIOVdxN3RybU5Ma0tBUHl2SUJhd0dyRTFDNXdaVUozTXNhUGNa?=
 =?utf-8?B?QWdGK1A5L0YxMnlQbjEwYXVYQlhaRk8wL0hLY0dOR2NleUZPU241bFN5S0xk?=
 =?utf-8?B?d0oySHVwM3hIcksxNTV0K240Q3hhR2p5UngyY3lWdjZNOWVmMlhXNFNzRUJn?=
 =?utf-8?B?d3I5bkIrOE01RGhad0tqZHhmQ2t4VFg3OHFTMGNOOTRGV1lTUFVaei8wSnZV?=
 =?utf-8?B?UUdoRkxQMnkwWWV2N0ZIak45ZEI0VDJaVkVMWFJaRTBsQUpHcDQyUVR4cDl3?=
 =?utf-8?B?ZUNlWTVDWEd6RmdmTGxxL3NFNzF6NTQzNG8rTGJHbXBKVGllZ1lFN2VGT0Fq?=
 =?utf-8?B?ZGkvZU8xYWp6alhqUFUxVnM2bzE4VkYzZ0o4NUoxSFBIWDYxYW1zeEQxbVJN?=
 =?utf-8?B?ZFhtMGJGVlpjVDl0eDI3QmlJLy9rNjBOOFJRUXFHUVliNjNIRHI0amE2czUv?=
 =?utf-8?B?Tlc2WFpsNi94UmJyR202WXlEUTl2TWlPVGZIQWJQWTJwMzlraWoyV1UzZWpV?=
 =?utf-8?B?TXI4ZlRrNkNGcTFOeG9taHRZWTh4cEhXMFdHR3htRGdSN0FmbWxGbCtJeUZ3?=
 =?utf-8?B?Zmw5ZUxvVzBVbDFwM1JQcUY2UittR0lFRld3TVZVeFgrSkNURUh6WnhsVSth?=
 =?utf-8?B?cDNOZnFsaVQzK0QzTWZIbmg5TloxMWNMbEJVWDE2QnhacVFOekt1TDhwNGI1?=
 =?utf-8?B?NCtCVzg3S3lqQ0d2Nm1LSFltYVp6T1o3QVltZytON1lseU90M0ZzWnhXV2p6?=
 =?utf-8?B?NVpEME5wK0JoK1YySE1qQWI0eHdRbGZEeEtEQjR0N0loSFRxRndFSGR2cUJB?=
 =?utf-8?B?cnlwUXd6Q0ZPTTlaMG12cWxrb2ZhQ0RFWEoyOXNRT3FyVDc3c0NMWkJyNkwy?=
 =?utf-8?B?RUpEZURtU1JRcnpLNzRqbittRVozeE5sVmtBRWl2VzJIQ012TDdnWUFGVHNj?=
 =?utf-8?B?NHoxa0szS25YYmpmc1lHTC9pei9rOEtocDBkZ1FlMWRkUVhxd0ljaXRURzBi?=
 =?utf-8?B?QkFYTWdWZHVXWG1aeXZ3cmJrVkk4TENhdmw4RTJ6LzhMVVlST1d6ZFVXanRz?=
 =?utf-8?B?VTJTTURRSVVhODQzK2dBbkpIeWx1eDlMQ3F5VjRhZzlaTXpGNGpvb1duaVVJ?=
 =?utf-8?Q?hvEu6eH+4m0Ww70U5h9a5yNSo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196a4fd8-911f-46b9-062f-08ddf4a678ce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 22:23:18.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+zQqW3O2w0A3vWHXXZM1L3CWAt2tp9eM+iDM8mRipzorEszZpmAALyAH9Knq2dWkjGqLQ5T/i8tcg5RRSsUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Add pci_epf_set_inbound_space() to allow setting any physical address as
inbound memory space, such as an MSI message base address.

Since PCI BAR size must be a power of two, the input MMIO range
[inbound_addr, inbound_addr + size) is mapped by finding n such that
[base, base + 2^n) covers the range. The base address is also required
to be aligned to 2^n.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- add new API pci_epf_set_inbound_space()
- fix bits 8 * size_of(dma_addr_t);
---
 drivers/pci/endpoint/pci-epf-core.c | 86 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  6 +++
 2 files changed, 92 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 4281067d4a62da6fbf6c2fb807b0f1b5afd1f45b..cd10e8619d03c7e2ffe48e437b0aecf0e8a499f4 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -344,6 +344,92 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
 
+/**
+ * pci_epf_set_inbound_space() - set MMIO for the PCI EPF register space
+ * @epf: the EPF device to whom allocate the memory
+ * @size: the size of the memory that has to be allocated
+ * @bar: the BAR number corresponding to the allocated register space
+ * @epc_features: the features provided by the EPC specific to this EPF
+ * @type: Identifies if the allocation is for primary EPC or secondary EPC
+ * @inbound_addr: Any physical address space such as MSI message address that
+ *		work as inbound address space. from_memory need be false.
+ *
+ * Invoke to allocate memory for the PCI EPF register space.
+ * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
+ * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
+ */
+int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type,
+			      dma_addr_t inbound_addr)
+{
+	size_t aligned_size, align = epc_features->align;
+	struct pci_epf_bar *epf_bar;
+	struct pci_epc *epc;
+	dma_addr_t up;
+	int pos;
+
+	if (!size)
+		return -EINVAL;
+
+	up = inbound_addr + size - 1;
+
+	/*
+	 *  Bits:		15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
+	 *  Inbound_addr:	U  U  U  U  U  U  0 X X X X X X X X X
+	 *  Up:			U  U  U  U  U  U  1 X X X X X X X X X
+	 *
+	 *  U means address bits have not change in Range [Inbound_Addr, Up]
+	 *  X means bit 0 or 1.
+	 *
+	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
+	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
+	 *  [Inbound_Addr, Up] range.
+	 */
+	for (pos = 8 * sizeof(dma_addr_t) - 1; pos > 0; pos--)
+		if ((up ^ inbound_addr) & BIT_ULL(pos))
+			break;
+
+	if (pos == 8 * sizeof(dma_addr_t) - 1)
+		return -EINVAL;
+
+	size = pci_epf_get_bar_required_size(epf, BIT_ULL(pos + 1), bar,
+					     epc_features, type);
+
+	if (size == 0)
+		return -EINVAL;
+
+	/*
+	 * Allocate enough memory to accommodate the iATU alignment
+	 * requirement.  In most cases, this will be the same as .size but
+	 * it might be different if, for example, the fixed size of a BAR
+	 * is smaller than align.
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
+
+	if (type == PRIMARY_INTERFACE) {
+		epc = epf->epc;
+		epf_bar = epf->bar;
+	} else {
+		epc = epf->sec_epc;
+		epf_bar = epf->sec_epc_bar;
+	}
+
+	epf_bar[bar].phys_addr = ALIGN_DOWN(inbound_addr, aligned_size);
+	epf_bar[bar].addr = NULL;
+	epf_bar[bar].size = size;
+	epf_bar[bar].aligned_size = aligned_size;
+	epf_bar[bar].barno = bar;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_set_inbound_space);
+
 static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 {
 	struct config_group *group, *tmp;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 2e85504ba2baf93827224884ca19ae2bd0e6906b..11c08209c27c3f523cca18a1ae8f1352b8b0c24a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -242,6 +242,12 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
 
+int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type,
+			      dma_addr_t inbound_addr);
+
 int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
 			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);

-- 
2.34.1


