Return-Path: <linux-pci+bounces-39087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B010BFF7FE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 157634F2FDE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4282C11E1;
	Thu, 23 Oct 2025 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DJvcUg4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010051.outbound.protection.outlook.com [52.101.228.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D02C11C2;
	Thu, 23 Oct 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203896; cv=fail; b=WzdPspPs16uBFyVVl7hBVRKDquKtfmuU6rUs6tqd48YMsYx9PvSJzgqxjYyN+6n3t6PAlke7EvxMGRRUT8yIyLasXDkKcNyEpr+nt6y1kSy0irEfDnp1O03jEFcS9/OE37Q0/0NfsRpH2UW2birBWAS1t/mG0mC2pMev2PCZrH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203896; c=relaxed/simple;
	bh=OAVQdonGsyUEh/LUFYX1vxmAz5FLoMXRqx8ZVjE7qAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGrd8i2l8bkdqs5qP1rzN70hzwagjwRscvJyGYH4ZdX1B7MDWpZMaYLNssjZCBGBM5VHEKmX9vokwN9PxOly9TQcxhXFLJ5TvKCh1A954151vAvon28Qsl92MIW/o4aEW1J8s4HJ5OzpFUEwE93/jK7UuqhRVBHH3hSA5lFy1Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DJvcUg4t; arc=fail smtp.client-ip=52.101.228.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fv0QdRDjOsZS1I9CRXrdFJtE8G/HzgiSRnmIpwwLjJTTmwRrP5EEDq9Z1RnRWI2n5n3VSYtfDsYnO53NN18EA2lNEUVLucoztC0Iq0xlE0GPMez3hM0EKyZstjOKNV1d86fPhC+rY8Iafpkm4ysE7MJ8sO8+T7456FnhfdcJXzQhUixDJ11lGAjYQs/Zbj+HWpd+1E47MdB2U/qn+DWaUjFNLiak9NGAZpfgfUEMzqQFIaTHd6FJbVASCZFDGoQEkpMRytXQ7dlytjJuDCVEBhrpU7B/QA5+tX+KDtjwiHbIeNHosS2XoB4fvqrnEvBxnxc8fSwJY3HRRNHrlVcmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMVNGnvaj/bGDEAuVTWZhNzX51dKhCnnlSWQj0Iz93A=;
 b=BaIa/sQfSKKlImnfO8R1VgoFQDh3vXdcYoQu6W10Cgb5sVCGYr8uIgicy4iph7gMXDcyVaWni3ia3fi3IUS6J0EIfJPG1mu2LPXNVRS+SiymkjPx2jqQ1tGGnP8fIl+SEmDWbIXlCyyTqSWvHGwy6TtfYm3Lj7euqRU3TdPpGioJ4QGYbNWb552+iIMpaL9WG7oXXDaQXImCW/nISGSHn3//NOm/w7IvUpjdtKFNKP07aGjFHeyrts24v9iIYHSmwsBn67O3sKg84xufSm+l0mcSCtysGFaLb+OmJnqy78H+pjKBWbZQjeesOQeojGUAU55Hq9YMDScIONX4TzOPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMVNGnvaj/bGDEAuVTWZhNzX51dKhCnnlSWQj0Iz93A=;
 b=DJvcUg4t70HGt7u03ZM15TnXzwJ1iOOF4O1RCTdWB95Xi/5OMUGQ8ilYl6ZIG+uKZUlE73tH6z8oFO5ovvCrUhpQWvElQfxJhaKgS84nqonNK45/zMoQ/exC10LkphtXaaatkOLW+ySdFT/UMK5mr/rawIQJ2UlX9C/qPwtnYC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:18:11 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:18:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de
Subject: [PATCH 1/6] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR
Date: Thu, 23 Oct 2025 16:17:52 +0900
Message-ID: <20251023071757.901181-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071757.901181-1-den@valinux.co.jp>
References: <20251023071757.901181-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:405:372::18) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 38231ec4-e249-4c5d-8099-08de120452cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bqrgoSV6sSqh/5mPdGIB8wSy9uhNybqvuvnMNphH0wAokgQx49JHgkNNVlxc?=
 =?us-ascii?Q?qykbmogfzKMvdWzoQCzygddwjVL5756h6nJPW2qS1OnttHOws0c/pSi0/llN?=
 =?us-ascii?Q?cvEEJX+O3YlYrhiX4HmVV7/2F+ceE164Gj81P40r4H2zLhkFp7OaqZXCb64o?=
 =?us-ascii?Q?Os0dAthyJgZiMVOTabA/NL116OMJ6+ANehTLk2aLScXPg0xn/a+PZnZRqn8L?=
 =?us-ascii?Q?VCNHkIk+04hzk9Tsb1gxRv7/K7xa+A5DTjuwkX+0KtJD6CQnmfvid14k8E0s?=
 =?us-ascii?Q?sYwK/cS1g7+XO3vTkhddWRFt+ormp/DDDAdm/6eZEmn5wD2o2ROwndSwrxVj?=
 =?us-ascii?Q?Zng2jOeoV1yoacbaMjueRy/oUfyLgGlCAy2DJNPkDdKEiuja4t++AsfqmaS1?=
 =?us-ascii?Q?YHONo7fedMDFwTaCW5NvB/Rz+jRHqUrHzfa8ckOSHxgZ/Z1en2rwKPwwtawT?=
 =?us-ascii?Q?lbEU3QiObDIPF6cUwaYzsO9goS7dAeDn3S0NhTrQ/+eur7CzzkkN6yQYtk5n?=
 =?us-ascii?Q?GbDyjgP09FvJYGNEXXrj9iAJV7kU+yXMn0UbIL2yATGbjnuC03WjKLsYmdvY?=
 =?us-ascii?Q?4cZxk2ZbiR2/Dv4daPlNRWIIAaGA/QerCw7d8+u23OhHMLScF0XpTuuLca64?=
 =?us-ascii?Q?NvC2HFO+i5UKyJt/25Q+ZY4IolO3IYhT99DVQ2X5Gbplj35xsZZ9VGKPfrVl?=
 =?us-ascii?Q?3/P2WFL78gEn1X8O9bgvLuqOz3ZkBrr4t8H1Cr081WbrgHX0CVQC3UBLVN15?=
 =?us-ascii?Q?sfsD0YTmeWum7mVC8WRIMW2ikXWVcGvWfRz+e9NUtrcOtUZAJLY5FgQuwmpQ?=
 =?us-ascii?Q?WiDre+wQagHdtYzyIjoxwX4kM4fgL4a3Y5wlY43HNZxidIRBFYRiBLaScVRE?=
 =?us-ascii?Q?iZRoM36rlgpdqO5SgCm5/odGDtpVvBdgvsUCQfXKxsiwb92uTBaQszj4SDda?=
 =?us-ascii?Q?cw7MlU3j6/5ArV84Ri0ds/RotfGLiD8qkf0NU5CLb9GDpQ+zRtWuM5ELIRrT?=
 =?us-ascii?Q?kT2iwdHJZeOBDmwBdB7a+Klq8gbeCYi1jMKuE3vQf6sNPsRkJBtz3wunoPEf?=
 =?us-ascii?Q?Q3q8ecrlcwogXV7r2jpsxQNzfGBU+H8NHPjTGayipdJF6+PSSoMfJjf0+/io?=
 =?us-ascii?Q?2WlwfP3LkrEC7tw7ZDpQqpKvTXn8M5NaEZR9tl9cD1wTyPWzmGeNdqpzyCze?=
 =?us-ascii?Q?WmA7D07NT4z08Xq8EuTqRNrCUvsM5wGaZkSuv+8xSXeisAw3xBUyfD6EJ1VQ?=
 =?us-ascii?Q?sjd/UAUIzDrf6KCLmeEorZq7ZgHlMTh9d6LGfznrsNnOgOkNAMKUdPpwoCVI?=
 =?us-ascii?Q?0HAW+ogriEHmdJJOOeSuVXZhHD2WrhWn7Z3MMnUJpyKPiU6CV98SAI/p6Yzo?=
 =?us-ascii?Q?vt/+TBfGA+IxZybo0fsg+KuapIMTzmYVjd4o0qTKN6g5H5rcj8+c9ABFoy79?=
 =?us-ascii?Q?sHJlJHxMhAY4Xo17JoTlW83yP/0ELv6K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zQtdqnDhMVM0YykU+T5piZXnowpA8ZSHJnCOz/coungHD0lxb0vFrP+StRX?=
 =?us-ascii?Q?y77JpgCCN/+N3n4It4IKkfV1I09C+9hsvKCz3T2rq4OUYQZ1qZ9LgTQBZ1sZ?=
 =?us-ascii?Q?uSDkF8RPWxY89mPNSQC4EzlCNiG4R815+OudY+ttJnvwGefM4fWovt5F+2A5?=
 =?us-ascii?Q?dyQrx3hRfYta6BBlnd1RiMNosatmjLp4wsynMMDqFESF4Un7zKDOtTOkZ8Af?=
 =?us-ascii?Q?D2DGfjBlv3nRK8nTugbVZPpZuRKSSgF57NaRyi+4jQWeviDs5bm2z4Ei4rah?=
 =?us-ascii?Q?xKg8SDeAhxQEZ6trbTKGQWRS8hNu2wncQnf/3MKb8og4ntB7PAS21GUPo7Jr?=
 =?us-ascii?Q?+J+YAQm7j5NZqMqJ1Oiks2j6aGkK22bLvRjkUXtOduz06kwwKOzpGCMXAAsz?=
 =?us-ascii?Q?XwsOi9i9Cyo7auFcegN3kPqUPM4LxzrclE2wz5a2JVi+EOabH/BzSpvVjO/M?=
 =?us-ascii?Q?6s3XehWuidLWD/eXlDJ5G1ml3luEfKs6qrJ/P9WTw0BJ8Sv+b13D6oMWlHeB?=
 =?us-ascii?Q?ue2HHFlWrSqBNyDH8QH8rmopIlwZP5J1HCS7hCMi4vQ94SkFHLaPFH1+tSzJ?=
 =?us-ascii?Q?e1eNcaeQEdk7EwNGyo4eoWZCU7dAAvUZ/v7uIZN/4xW20Aajy3SYOaR5iQdq?=
 =?us-ascii?Q?8M+GoJrqbJ2Nx1C/rMRmgsmRLuOl/mhjurest1fgurGiBVNejY8G6F4SQMTW?=
 =?us-ascii?Q?6erWNnYIEm0i+e42JwI1EurMTFHb035G/X/R9QWLCvZYiEt4jto1ekOE/O3q?=
 =?us-ascii?Q?0cCgtq5p0l45PnjoV3owDi+c3HjVW+kp8aG/bn7ow+8vl/xBzbXEYeusCql4?=
 =?us-ascii?Q?WJQu3l0nS3ap1BDsv3oLD8O5jQGK8wGzgC0H7VgFe6urpzovsQP4O924DKs0?=
 =?us-ascii?Q?ZrsNK32YrW41wyeFf5EcbUBtLWkWYvKj8bvkkWADqygW3k55SBqaNCUM8M9W?=
 =?us-ascii?Q?dEldjZCd89QncEkNacyDKCAKq9FNJOVqvCXzOINSpMle+doSJjYagf/PZox9?=
 =?us-ascii?Q?TFf+sR5HTkLKEeMiiOerJmx2GCkhSZ+XGSJrPD73YL4cfgDTu/2aGc9hUUSO?=
 =?us-ascii?Q?oK20xGPWwEvOGGTALztN2MAYzZWZZ9QEhuTcJi46NwMeFbiLmSF6HuAiFrAb?=
 =?us-ascii?Q?a6j01NglJQgoyFynzETTncU6hezs+dAE84eqUYJdKwzkRPJ9F8zVDi2avPrE?=
 =?us-ascii?Q?EqddpEF/vup39DBrn/hgLt2BXJHF0UU2zyI0Feil37zrF2V2r6k4ZIFEtAM9?=
 =?us-ascii?Q?u78Gd05dSKmLssleXeS1amda3QRTJiQhXOLOUAIRQFQZEC1BDSELhR4HSTZM?=
 =?us-ascii?Q?zTTGmNpjHZvEWU1d5mwDqAmq0ATXIYVoRBVT8qay/PiFsS6zeAKMM00Hx+jX?=
 =?us-ascii?Q?H40iRCQaFxPMOmmkbjyHFMwpNqCQuxsKMa9QaVmd7la2y0J8l6LeVAYi8M7R?=
 =?us-ascii?Q?e6A89SZEe5K2J2jiFtZ0wk00wVwvtpQwsL5iAwb7IEWqzZcUq28L1gmm7rB0?=
 =?us-ascii?Q?4vYzT9KrzxekvZzVwDPtA4NXHxXUwy5e+2o7RMkjrSY+gM8Rxfl+kesw5IxS?=
 =?us-ascii?Q?+CA977k9r8+20iLk4H/W+CJ3nkZf+JN0yfXf0rl0nACD8VqYG9PuHxadAcaX?=
 =?us-ascii?Q?1OuZWTqXpRuVpp/oYKZPeBc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 38231ec4-e249-4c5d-8099-08de120452cd
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:18:11.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXGoCPjEd3sKzNTIkmFkYf5fO69LKmZ6zwHiw7uF3Btqkygm2O4Rg42obrVtHVoTnbnt0Xqmr8cPdgeFs9yZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

When BAR_PEER_SPAD equals BAR_CONFIG, the module teardown path ends up
calling pci_iounmap() on the same iomem with some offset, which is
unnecessary and triggers a kernel warning like the following:

  Trying to vunmap() nonexistent vm area (0000000069a5ffe8)
  WARNING: mm/vmalloc.c:3470 at vunmap+0x58/0x68, CPU#5: modprobe/2937
  [...]
  Call trace:
   vunmap+0x58/0x68 (P)
   iounmap+0x34/0x48
   pci_iounmap+0x2c/0x40
   ntb_epf_pci_remove+0x44/0x80 [ntb_hw_epf]
   pci_device_remove+0x48/0xf8
   device_remove+0x50/0x88
   device_release_driver_internal+0x1c8/0x228
   driver_detach+0x50/0xb0
   bus_remove_driver+0x74/0x100
   driver_unregister+0x34/0x68
   pci_unregister_driver+0x34/0xa0
   ntb_epf_pci_driver_exit+0x14/0xfe0 [ntb_hw_epf]
  [...]

Fix it by unmapping only once and only the base mapping when the two
windows share the same BAR.

Cc: <stable@vger.kernel.org>
Fixes: e75d5ae8ab88 ("NTB: epf: Allow more flexibility in the memory BAR map method")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..9935da48a52e 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -646,7 +646,8 @@ static void ntb_epf_deinit_pci(struct ntb_epf_dev *ndev)
 	struct pci_dev *pdev = ndev->ntb.pdev;
 
 	pci_iounmap(pdev, ndev->ctrl_reg);
-	pci_iounmap(pdev, ndev->peer_spad_reg);
+	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG])
+		pci_iounmap(pdev, ndev->peer_spad_reg);
 	pci_iounmap(pdev, ndev->db_reg);
 
 	pci_release_regions(pdev);
-- 
2.48.1


