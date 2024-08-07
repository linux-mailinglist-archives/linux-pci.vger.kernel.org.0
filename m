Return-Path: <linux-pci+bounces-11426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD594A5A6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FDD283D9C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88401C823D;
	Wed,  7 Aug 2024 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LkMztfYY"
X-Original-To: linux-pci@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2149.outbound.protection.outlook.com [40.92.63.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E85B1DE850;
	Wed,  7 Aug 2024 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026894; cv=fail; b=AHJAHzy5xtdkopWRvn0RWi/0C20KzUxDt6yvhn7v14KwYkJTxrEsc/qLWZS10sDOyyXmKBdihHcYlonRzi7JcANQyeTbEBzpJjMuHMwzJRlWg2FkXNm1P7sLZlsBOarFPp9PRuQjQ0NK8d7B7Wa1a/H3cLkBDQzInYKEzAceogA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026894; c=relaxed/simple;
	bh=gObhk9HOoBUNhrxYszi1Bqyh6mG1w1UWwTkyhWVnTpY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IttyV8z47uem2Lsl6xlVmQUHlePii1Gyv2QJYt3aOUkXHNWe1yaXl/R+5y7dWi0FLXpXAVG48Kj9/UKmLMGf397BcP8IqVi8P6unCMc2JqK4ryj/Gr/DHK4TskjOkbeoEzz/rvUqCjZuJioIdcCC6P+EfyHvQOXD4BffcZjCwEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LkMztfYY; arc=fail smtp.client-ip=40.92.63.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y78YFkOHNft7wkvYRS0oppNkjRPZRA5hVJ9h4TliICm6nZ3k3f+r19Qma/p28VOFADwSgCHJnp+4JenJjvMmwOJvQ8XzSbD09tGFq8Ou1y8akXLAnPUJkTzamV7CJx3yPQvEgbR3O3zpM5Qs4neCVFB9l7gwqdCvyE657f7R/pk1KQPEs8m8QqHZ5xDhwQN/VIWmo+S/LpVflJlGqd8BW7nTfc3gX81FXLxCZnwPmmum9zzH0h10W9li3EaxsBdnxN4MbnbCly8wOBKKBoOKOz7yHkeIFwNKw+pJXBPZdSlv1mAujqnfWKPE25LpI+e1d0JzJjPjwgKy0LXO7PW4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc64NMqjVqFVtD2kwzA5vBtoGZO7hh1ntoQlX942Le8=;
 b=PeptpU0H88asgjQuzHc+Yj0imrXcq4ussXcZLHLOtqz6uG7jidmQW70m0bHZ9/HFuUVe/Xn8NGh/mZFO/HWLyjGakKuRO+B8Ztnu3OZfmUq257k8Wf11cTT7hkuX8wNg95FhCxfPHKK8c5u4XubrYSfZTNuMyRpStScHCIqbqMccKWA7E2oS8KmI0rVomK1uUQ96uS+qJUjunpG/+5G2Gs8TCegUwWjArJhNUbFw9syQi4XZrvfoLWnsvd034Whqcr2uuaYzp5gbPdPBI56WuViVXejBCGg+O8CucxOrJf6z99OUj7LRKUzNDVnL+hZk1sYnjeqQtIo8kIk/mpjpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc64NMqjVqFVtD2kwzA5vBtoGZO7hh1ntoQlX942Le8=;
 b=LkMztfYYgUhmHaZPAm13QmAbarN9eCh54IVQE7PLwUyWU/AT6FgjNIegjZLnfDNOkhV9TDKbkj6yeQEH/acuLp+gItMLS0S0fHrY8KwzdeAEwIAoyzSX8/5cShrKq+NJPKEGig04nvNIgfEGYXS9yJmo7lOIXKGBZ2BBLnbFiNe6jV1/E4pMD7lVVEY7/lge0n/hRqh/z05iomoPx7d0FMC4yBuM0FBCc6xlQugMc4CKcEyGR7fDGR+2LH8t4pA/PWKTo92RvTphe6mMgM1yKJoKDReKh6AUV0IrtZFTPKePPBC1Xrgr53NQiJe/1EedbW76Tie2PI2l2BXd2QFxcg==
Received: from SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::13)
 by SY0P300MB0482.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 10:34:48 +0000
Received: from SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM
 ([fe80::e2eb:8ff3:d300:b6ad]) by SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM
 ([fe80::e2eb:8ff3:d300:b6ad%7]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 10:34:48 +0000
From: Ian <4dark@outlook.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Ding <4dark@outlook.com>
Subject: [PATCH] PCI: Adjust pci_sysfs_init() to device_initcall
Date: Wed,  7 Aug 2024 18:34:34 +0800
Message-ID:
 <SY0P300MB04687548090B73E40AF97D8897B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OtbyeTUW71tGr391ImJ8Dvo8mbB3NCy/]
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::13)
X-Microsoft-Original-Message-ID: <20240807103434.1400-1-4dark@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0468:EE_|SY0P300MB0482:EE_
X-MS-Office365-Filtering-Correlation-Id: f989046a-949a-49b1-d356-08dcb6cc8f96
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicBN3jMkX1QgqrETGOe1DjntLB/hVfvRsee/vLFGE9nFn31mjCGhhRi/Ry5MPrk12VrQOQbNL2bt0CSS0Dn5qL8988Nlb8bPCkXbFbhv3hT5ntNr4oL37L6ZeaAu9xpOicqMZH4lj0kaYDFI9SVLE9JyVdp45zSjK3n0MVw8hw3qIREnZd1Eq6iiGl3gtgms1fuy4xDBVf2vvOosOg7PQzikE8irKBtwp/HPShXrheKH7z1S+6e6O7wjV8VVWh4nZKyn6Wx2YoBt7f6mvvEUfd5uoHB52BoHAPyG7T9nnZdXdqo//2pm1sbd3VQ7xdZFG0nc6jUnFNcGx6lbng1MXGh2VpthSnP+9Db81mEMR6WNpbejijJJ0/mQy6+2g/HokDsdIOA+KLgHn/1tslxGFja8YJ/yKN3aExVeMu/2n46xmBoIx/HIOfWHVB5lhiv6nFYDagpe9sy955U8xzqJELBbaxJgE+CWEOVRwrDuK919uVnM9KSOxpgHClQvpAAqat9++Dvu1sHgu3XbkPoqwBas9kDB1hMF9980z/ebUvZSP6mU6ChGXUMbmVP7vz/L/z0gWsXsEKnF7Gqq9QLN1kuZNUhHV176humP9cO3jm7/MD4RqsGInhriCulPpNxcmQF537kBVcuk4+rY34eLHH9M9xBMzT9wd79s0PYiADn0zbTBpTMrq78pS01tw7qbq8/oSl1wXYQHJREVjyktI4OxP/3IH3wFd7dXIXO6oqDmjA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	SkxqCeZEc7Om/UFWH7IoBY9HtsNr6WsrluLHWYtOiKctgW38RfAYL/oeTV5oCF6KUiKonBd5u+fMUCsoOsoHTNZAGShRkhk05DDWgckgLofGrMTeT4e1rzPqdRR2PTjQu0x6FnOeO3mRJNZt7kofmgf7Emu/FVn9kumbGoSoqtVty1ZyRM83zw144zSOWb3xCGkKRGecl9+hkEjHkGh5n5YkafidO150xFlv2ODsiLJiFzPg4qnj858JNIdONV4t/LgkLU1lEI8xUkjon2TcPIcEDJ2cr8Prx/zVLlL0R0sfY4p1+LAC6GtVpZfBL/1gjbWGRLDD8+bqx5J4ed0LcRJTTiOD9lAaJH+QIFRyOt8v79N+J5p7gQkY2S3/uVBwCmVDQB5TyWElfwSQVFn4O+BahbEsw0vqfTgtAin5tuH+VviE/VklaO3Gdtn/757heaVyzLa+bjqgX8hWhJlMcJahSWgvr8tS1jpf/58l+xDTMx9vY/hxeLDMZrSqpfdYhZqB6rshOy0Qni+FGLQxxHrqVvUU92taRwTmPsZTMuQf14T+ncDecXnIdghAGaTgT41qNj10g1wHIIoHA52jYeR4S4dTfUQW2o5lWHH1+v9+2/UGi4Fz63rwVs2cAo7iGn7pLYe/d8YlCrCw1tqVIyut8Yu4D/7KPu1gjswhzghkvlIN6H4KKo2tbfxOweby9GUXX9rlr5GAzOSebopRxQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPa+TTnJKEnojaIlSCGRPFa/0r7DbqRcFADdl99MRUW/sejmjsOoVAorFAsu?=
 =?us-ascii?Q?GfI3k2N2YYAvV1eZzteQPD6HBb62JZ2jMxlboh6IOvi7tUvo7cS0sZ2Z/wO0?=
 =?us-ascii?Q?2v0ORB0Vr/r2S+FyFk17Np2eL5mI0mt0dZ3bu7Zd2jMVPKVQ3EO/o13v8DgC?=
 =?us-ascii?Q?qaN5RrSJe21NxGtaVf1mk+vIEvH0ndQIXSrQYDTHsC+KjJ/1qtKq2OGZrA9t?=
 =?us-ascii?Q?SkdW4ITaxGEoMP+AE/H8U9CL2FR8L2IrLSZz5HOLZqh22BXE4JpxabHFE68v?=
 =?us-ascii?Q?pfe2EJwNLLbwvO0giqZBVeWLCHoy2riRJAS/OG++RKzEftJDaxXyubFlRYlV?=
 =?us-ascii?Q?8s466w7PvotZTkGFujNJeF77ZsvjnLtr1jLaT1ubzY3HN82RvnRrx98IHuIM?=
 =?us-ascii?Q?W2r9lyaOgsiNiJpiJfuzJD0enNSEuRwhoHHF048JvMWJN0iyvo8HXm3dNsIW?=
 =?us-ascii?Q?TcXBwtkWS9/IWVoDLwkJgu/+/B/fySxu5HIJZ0OB6P0FpGNFQf55Vw8YfUve?=
 =?us-ascii?Q?UEtjvwAnY5yOns6ijqBQWhJnolMfn1dYQaLqIVG076XA45kMggA57lfy9dzs?=
 =?us-ascii?Q?WjamNmlhMDx47JJIBOTSQOX1kFzxvKjxPk+FkLt8tiI5BMMHSbFIUPqlSiYW?=
 =?us-ascii?Q?bX9q1YepwuKX/bnpItd9T8vQXS3t1Ao+xyumCnOTfFIPAkDVoSCLAaMOrwvq?=
 =?us-ascii?Q?o1Fhg0BohEJEXMxIMMauOhDS1xcnWtDAQS1ekVkuv8hhYP0zClaAThU6buG+?=
 =?us-ascii?Q?4BHpDEx9Vu2i9SD0gRgjBV4YAX+92J6sYTYZXrcBEGxGHTzNZCSYOGmoqykC?=
 =?us-ascii?Q?7XutS/3ZKwNppirq6qhxr6iXgXQgPsoUMIob5s/of5PIcYcTugsRaJrlYA47?=
 =?us-ascii?Q?Odo2IyUg/QO/U9AawKyZBx16FcFFTlMpLH5psIgC82bQtc5xIGlS+kjC5Q8f?=
 =?us-ascii?Q?awKO2cwo4TOoXtk1PtKNokbUfLtqPqtAZe2ucbJMeM+/nwHJrfxwei/Uy0LO?=
 =?us-ascii?Q?MGw9KyU1hlILcSYfCuyj2Ib47dlRs9nQLhOnUZnvLkXcZ1xXq5qymjZyHAud?=
 =?us-ascii?Q?Kz8QAt/BizEvv0+IppMlQNNv4hM/72y12d+EUatAtqSSuoA1fdO1kua3noiR?=
 =?us-ascii?Q?0uBzceYHFwBHE6fVgYZszL3mTS9yzi8jHaU5+nFiI9WGFki68AfO2y0i52zM?=
 =?us-ascii?Q?Gg6PMJjL6lfsu3YE2cD/vb3t3WO5DBdF3p9nGIeuaF6nQxmjNJRiUKlDM54?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f989046a-949a-49b1-d356-08dcb6cc8f96
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:34:48.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0482

From: Ian Ding <4dark@outlook.com>

When the controller driver uses async probe
(.probe_type = PROBE_PREFER_ASYNCHRONOUS), pci_host_probe() is not
guaranteed to run before pci_sysfs_init(), kernel may call
pci_create_sysfs_dev_files() twice in pci_sysfs_init() and
pci_host_probe() -> pci_bus_add_device(), and dump stack:

    sysfs: cannot create duplicate filename

Signed-off-by: Ian Ding <4dark@outlook.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index dd0d9d9bc..bef25fecb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1534,7 +1534,7 @@ static int __init pci_sysfs_init(void)
 
 	return 0;
 }
-late_initcall(pci_sysfs_init);
+device_initcall(pci_sysfs_init);
 
 static struct attribute *pci_dev_dev_attrs[] = {
 	&dev_attr_boot_vga.attr,
-- 
2.25.1


