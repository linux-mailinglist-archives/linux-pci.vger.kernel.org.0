Return-Path: <linux-pci+bounces-8673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F33289056A1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 17:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CA41F221D9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D091649DB;
	Wed, 12 Jun 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eotqKHMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2060.outbound.protection.outlook.com [40.92.99.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3928F1CABD;
	Wed, 12 Jun 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205373; cv=fail; b=IwtYqI83iZTOb5QsR537/ZXTfojLQIm5P2pfkYTKsJcB2RbFHOd//HW360YD6hVAp2p269olE2nodf9gF3YBp1z+PEuWj5ZAt2lWH9vpST8BVJM9uWEW+ujvDC7LPiJGKOfwZRPTQspzHduQ0MXU7uoA9FbllYhiYXwU1cv6F6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205373; c=relaxed/simple;
	bh=15nvu5EMtSH6A8ao6TKLqbG751p1jZSI/M3fHVNiaqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qh39E2u9cAk3yf4oyQ8OXXrXJ3BU7U/Uu8u051M2Kd1IbQkLifCcxktg1dG2Cf+lxvYw22z14JCaiGmsAFrPGfjids4yqlmw3zyf6Ldvy6kTNs9qP6oN8Qj84gp0mDsmn+WteymqWNLnEu2sQwqa/aMFuBMKm2wP8u51iqGC4zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eotqKHMR; arc=fail smtp.client-ip=40.92.99.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9CYpc9t0ZzHA3t2tDEZbQyw1eZjHnAeBMe05cy48Kpm9jP29UA3RBd8s9iYVKKpuIWAatcFyD++3dRG/hY+TRaZdKT6kQkfuKgjYeMfhmandqeRHSiqqNufkm1MdYdrA4lGbJL679Rr7mD7e9shsXNhmETuRZoA6PmBPgKJFVoVXtpTFKoslO8Z8mUcy5cgg7BqIlhIyLvdrOTN0hF5oNLVWTp3e4ntAB+awwP6ZrdGOY82oGzEtZiaOOf7y7gf5WQ8mw5JUKmH+sJwiOF89MAFMXvaHTPSpoqFMSDOjhb+BlrFQ0HTLXshotAEZWiCYuUhOAToI0zwBiH2riEGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOGI2APK/nTtY+w3Ys9bffwNYJbAhu/uklKVO0t+cdw=;
 b=Glz/qgZ9RBZ7fMpqt/m5TL88tU3GgtMc/j5XTFkM1ojTalhiW9uRmREzYMQWsJNdCgBkgnC2P3C7Rj8N+Zbel6htckBS6BIQ96qETrLCIoVgT88DUEM6vVwS87+1vg4/S1mkfeIB8wSO7N3kMXVLv8nbMB8idVhWhsOB150OPCSILhGIMw4DeLggBBwZbT6lCYRkNQkbaUHeQ4uBASQD607orXiesAwVldzn0o+HwvOwmxn0I+sVTDCNImmxp4oPnp+lMeeqEPDrGcVJQYVaLIo+h24SChwgqKtCyZZPQdCGFwN7pyl3u3JGruCh2ZvgcpA02erEVhXghiL2/p0/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOGI2APK/nTtY+w3Ys9bffwNYJbAhu/uklKVO0t+cdw=;
 b=eotqKHMRXqr74A2D7iKBW0mDICHZMYe8Dtd4FJteM5DO+DmG8AbHXHrZj2V1T/GCFm/DOcNQzOW1Oal+6cICWjFvLBaQeLckurxYrTp80rhS4hymNq+SlTDzo7lQ+UuLqvMfMC/zTpga3ACL1Uke/hSOruWwLA8AoUOF1Agi6ozvFkk0hMYCc3zPjIBkJ6fkeafzimUPxCSHS/mmhg+9nshGdSgJd9awb06Ve/uZvod3l1EWe5e2rwbX+byWx6jG//bHlxUlpGRsEG2abglmSErZzmkbdVR/HrK+5J9KBXbEMLXlVcXhNfLRRq+O34CmlPIyXvQ741Oog+iYDdynxg==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by TYRP286MB4456.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:138::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 15:16:08 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899%4]) with mapi id 15.20.7677.021; Wed, 12 Jun 2024
 15:16:08 +0000
From: Songyang Li <leesongyang@outlook.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	leesongyang@outlook.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH]  PCI: Cancel compilation restrictions on function pcie_clear_device_status
Date: Wed, 12 Jun 2024 23:15:43 +0800
Message-ID:
 <TY3P286MB275469F17C8C5389C18313BBB4C02@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611223418.GA1005201@bhelgaas>
References: <20240611223418.GA1005201@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [JcYT2i7ghaodVwwcSSxPPURFddolOkqr]
X-ClientProxiedBy: OSTP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::16) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240612151543.26894-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|TYRP286MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ccfc9e-cdfe-4c17-c149-08dc8af29543
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199021|3412199018|440099021|1710799020;
X-Microsoft-Antispam-Message-Info:
	EMMYripY4xMcz+s771T5Ng9LyPQwV+eOe7tUuKXUIbTlbZZ4P6VLCMsSi74B7e0eA7xuCE8Fy56MOe2RAGKiDwP4sODoeKG4/Jl+xnR3ciHrCWpMex9dn1lQZlCr2T4e+de7TXXvTGVrERlNZKSj7ALyi44sVoGQVUwRzTpEn+ZG1R9W8Yp22c2flCgVSrbYI0WQEizsULVPHIjqxbrwmM9obfpIAya/ddAILE9ngywdZwtVBas+kF7JjknwD8qwFYgeoNWp8C3kuRw6cCnkELcaLa/SGUw2VQpv3ImEPj7p4pqV20l64lZjSqJLaRnsDeiaYNK4rpL5d9pl8F9IThIIY/U5jOIwh4RiCGfhHJycL2zwyCMHbwppLpO0Csg+04qUNRMRZ8Oho436A79rvN1ooWv383mB9j3+ZOwOFIyiJ3qGTMGp/uDkehxD6Eijp9i6z/rI8adScZI0x57G3KW/tjuR7q9nZgz4yI39kGAxjKTY0o9wZIA+eXbopbMc6tHiFQFXc9vX7pXnVQetmr3Esm4N6tSJZSecOX0jwpXru0ZeutJrviZgPERuTOowOsgmfRncEVxNZzpS+SsFA85ANoZn0nlHpAFmUBhUGylJU1bvYUpyWSNAmVVp+Dqj
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5OMjJDiXfS8b8NN5FRg9n+XDOLLTT34yVLM81CsvTysJiZtZm+nZSMWesk7?=
 =?us-ascii?Q?Jp+aWlkuPhsJjtq8jOVzjg2NhnXa6LxtTuj87GTGAqoKVKy9QOThU12Opn3b?=
 =?us-ascii?Q?anq0aTFAgmzGvIGQBuDDMu3IOJdmIKynKysnq4wixifltOrW1llrDBRTOeaj?=
 =?us-ascii?Q?w+Qy+AnCrD1266EtikfH9tSFRrfmqTlfPEjCkonsp+DJId3Nk2epRr56LdbM?=
 =?us-ascii?Q?MNe7TWTkMD59465tdBT9r1jxSZCyzoKtftsKrQACW8GRZn6Sob3vpAeOwtz/?=
 =?us-ascii?Q?3mgZNnARWeGvr/o/BWxSzKmZvzbzqvf+HOedBK6LUH7DDB1GZpnEA5ZFBg0k?=
 =?us-ascii?Q?OF4nke3LMiMG9AnhM99gxc7L8dhn1KHbyEp0gPkhMiF8PNe7FutLse93O32H?=
 =?us-ascii?Q?/r4loZMh1Uq856jWzwrVUPAizqLFMhsAEIF78tPkWK/RRg+68e4jaVXkAAny?=
 =?us-ascii?Q?SYTBTSNivfzq3qSM0huwrGBFyda7+1tlVSgSIQGKMUaA/+U5yEd8+T2pa07c?=
 =?us-ascii?Q?lnIQkCjdmpzyNzvd0hrp4Wot7Zeb5c2hGnXHojLZs5fxB64+KAUccySHkJtK?=
 =?us-ascii?Q?oQT/u7NibDL4UAnkkPqchRR6VY7epd2m5eQuNX2f++up/PTxICQ+lzaycBeI?=
 =?us-ascii?Q?Iqij1034aPpyWs5YKgcSvDzVaJ5bBS9Mgk2DCRF08wIzkNl4yewLMuGNSQ72?=
 =?us-ascii?Q?2Tk7fl1bnzD4zJAS0vCZEx2f68OpjxDz4Bfb3JY43oIqKyAvPShXzFCYfAtS?=
 =?us-ascii?Q?Wg2lDwDdbEmtKkm9xnTYLHICcn2FcYu0ZfhTEk8aIx/uFvaMNZD6Q0b3l8F1?=
 =?us-ascii?Q?gaTEpyvNr6J/ZSqXjp1rNWuut+lIE4KpfSh7CADbLY6bYtkj1q0kzpSs5BJ9?=
 =?us-ascii?Q?72pGRLjQCma2cCx5RzAgzx7ToZj1wvdlfnz7nN3uPl2MTgX2GN08kjFA/UBy?=
 =?us-ascii?Q?q0UjCfhGmuTii6SJNUZD1dUlvzh9Ar+Ds3xN9nlTFi/DiX+4ocgRWe7ip5u4?=
 =?us-ascii?Q?B2JlikwlufNT54isP4ZT5KcD1NEx+f4zpp8ENH68czj+jvSXb7mXPuvxmeun?=
 =?us-ascii?Q?k2gvoF1UKMz5anFD+JQ40CeokPGlGLtcowLvaEB4Io+cU8p6o9errjR3UhFy?=
 =?us-ascii?Q?YHPSLRDjvJXe5vLej4p0wt8ccczKP36EzXM3JKNa0J7EIJe4Ty2GkVR/SifW?=
 =?us-ascii?Q?kx1kxqiQATDiI5Q2TtUvpj3jN9c1uEHAiu6m6thuA/9vXSj1AU7k54LX4+M?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ccfc9e-cdfe-4c17-c149-08dc8af29543
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:16:08.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4456

On Tue, 11 Jun 2024 17:34:18 -0500, Bjorn Helgaas wrote:
> Unindent this.

> Add "()" after function names.

> Please explain what this patch does and why we want it.  I can see
> from the patch that it makes it so pcie_clear_device_status() is
> always compiled, but the commit log should say that and should say why
> we need that.

Thank you for reminding to add "()" after function pcie_clear_device_status.
The following is a revised patch,and it explains why we need that.
Thanks,

Songyang Li

From 3c1340522565a44ef25d2045e5bee2c0bdb72b32 Mon Sep 17 00:00:00 2001
From: Songyang Li <leesongyang@outlook.com>
Date: Wed, 12 Jun 2024 22:29:51 +0800
Subject: [PATCH] PCI: Cancel compilation restrictions on function
 pcie_clear_device_status()

Some PCIe devices do not have AER capabilities, but they have
device status registers. The PCIe device status register and
AER register are independent PCIe capabilities, so it is
unreasonable to use CONFIG_PCIEAER for compilation control of
pcie_clear_device_status(), although which is currently only
used in the "aer.c", "edr.c", and "err.c". Some operating system
configurations do not enable the AER feature, but still expect to
use the device status register for simple RAS. In this case,
pcie_clear_device_status() can be used to clear the device status
regs, so this patch can meet the requirements of this scenario.

Signed-off-by: Songyang Li <leesongyang@outlook.com>
---
 drivers/pci/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 drivers/pci/pci.c

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
old mode 100644
new mode 100755
index 35fb1f17a589..e6de55be4c45
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2263,7 +2263,12 @@ int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 }
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
-#ifdef CONFIG_PCIEAER
+/**
+ * pcie_clear_device_status - Clear device status.
+ * @dev: the PCI device.
+ *
+ * Clear the device status for the PCI device.
+ */
 void pcie_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
@@ -2271,7 +2276,6 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
-#endif
 
 /**
  * pcie_clear_root_pme_status - Clear root port PME interrupt status.
-- 
2.34.1


