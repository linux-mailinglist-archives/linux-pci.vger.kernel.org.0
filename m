Return-Path: <linux-pci+bounces-45215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB069D3B82B
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4201300D420
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852422EFD91;
	Mon, 19 Jan 2026 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fLyobqDq"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30562E8B9F;
	Mon, 19 Jan 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854243; cv=fail; b=dqx/K9IC7o0GY9J9DGzetG3wq1RuNxwujppkzM6q7xZqc1ojez21WH+7kVWtlYTbmbJrzrA4JqBXxhElAVunDEQPTKm/YJ+880ICck8QdOR3KEfJp0DxtkiMx4gn/lpg6Dwj72ZLCXzTkyzC7f2SSugvTmc73+ZwCzAPkrXQYGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854243; c=relaxed/simple;
	bh=Mgg5rRqyZwHP2sTo/X4MvWcFkp3NIcgILNd3twNdYuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enI69LTaMjFU/gdXszpOk0ZoUySw1f2j2ZXeBV9QvqGa6tZG8KVnNM8rPqAxWTQ8NrO2H+Ja9Qy/CZ50UxQ8JqkGcXp/XpZ/zTvMsoBa4FwqnQ+NLMY9K1euNZSrz9LWN2IhU1ZxPq0Aqw6a4v1KTnxx5W6s3ty98krDYsh0yEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fLyobqDq; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9LKHt8qVueFHkvTbtCK+qq6KWC1KHsJlpc/Io7KAQAI/23VqAIsbOkPx03btaYrXSSBpQQjq3kU5QzHe3dnbEM41dlYo3KjUTt1jwIDgHdZfnA15nr27RVE/1BFGFp4Z44Aq3xhLPYce+F6Q6D7nk1lnRS/Wid4hsPIoFxCZulS5tfXpnlrqpmX/9oQnppa1ut6e3BeNAjLH7LajRxUdXvgIHUCySDHYZpWSLZGCGaM0A6XqfYKWtdxgsVtbQa6V7dzB7+4f9hZduxBt8e9htLvLInY/bRT9lLu4dJEjUVQQFHB3KGjGDz3/bPTaDpB39Mh6OXoPEybCfX6YHtrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WESaqIq8dHbYW0/RrreUMYYjBhW5WCK172vSILfzis=;
 b=hCNWxP41dXe+UBkrwOtlY8ggcCMAOYNtpwQXE0KFYpFnVAcUaUMdQy+G0LJZtrmOdKbigYro9b0HjJwENf9N0UmBFk3ZpDm2EKEvWXwVmzB2bEUUejdLP+SBaRGsLDJLPVTrBjfByzlT/TUQjQq+IjejOu595Kx/2HznhDY4mIyDqmtzfg3AlpXhU/n00JV825q7TTPvr4zL7SE9BXfCJAtW6rINHlIlbYt0qAyLGKho7O5mIkLMS2rEPgP0d6UJ6Vti7L/9nNVK6vWFkyMXYcg0i+Rim59WL/n++n88gxsG12DRXJOsJ8qtZFKQxa9kvkAKBp3nrLuTbaHBTM/UTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WESaqIq8dHbYW0/RrreUMYYjBhW5WCK172vSILfzis=;
 b=fLyobqDq08EMvwqFLO9QbEJX22R9DLtWmozzDDg0Y4CZT90RYJMn6vnoh+KfCYZi4b+kadXd9qQuzjB3JxR+JOUGwCFTV+vFx7tAgQyIBaUvA2za5hGAmcRC1r4XgTkohPaVyHDxsS5tHFLaUlRoJi2qfL9k7NGl3tzuOaBUnjTQ8oADiC1ISeWXZyNs9kr7DPdR7FaNNiFdXSXSfIUMiRq2cDVw+e8jDjtrSwO1MimdT1YvkUCte5laLh9C+2T3XzooAtes6Hg+eMW8iJYquvjM+LQHhjEtPANFkwxX+/4nzoc9Ii1cHzg53+C5h1VxXLngy+95mDuN18gHWqnWFA==
Received: from SA0PR12CA0028.namprd12.prod.outlook.com (2603:10b6:806:6f::33)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 20:23:54 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::ec) by SA0PR12CA0028.outlook.office365.com
 (2603:10b6:806:6f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 20:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 20:23:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:32 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:32 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 12:23:26 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v10 5/5] sample: rust: pci: add tests for config space routines
Date: Mon, 19 Jan 2026 22:22:47 +0200
Message-ID: <20260119202250.870588-6-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119202250.870588-1-zhiw@nvidia.com>
References: <20260119202250.870588-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8bc618-f80e-4f3f-dea8-08de5798aa8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YfRuvRVg8wjDTty5u5NzT886RPsIFkth1ETHKOva+WevuvEAyP3N3Jy0/jp?=
 =?us-ascii?Q?6+cOGx1OW5xWsJRjQst+szbqH/OONDyFn5Q+lVTxHkf+vowNleSXOt3YK3gM?=
 =?us-ascii?Q?a5choCGmI+ShlhOXWm9dN1Edj4UnaRmf9vs/IecCMRL7b6aWJo5ghTj5+uPN?=
 =?us-ascii?Q?WWNYf5Y1404mJCQl+bZwtFqbhUDa0c9lLqrne12c+kT9/dGxf3bMoDqTN+Cz?=
 =?us-ascii?Q?XSUdHM8sMFAiEKo8zAikz3Q5B6saG42EQ7Qy7BHTt555iMwUKT4jcZn/Hg5K?=
 =?us-ascii?Q?QBUCrIY6i7qbc0tn81+rtLaF+p/Tu8iovcFeNEGONMQsAeO+g/iCjPrt+Bem?=
 =?us-ascii?Q?K8XsqXdvk+SOALQ5nB67BBNRmaZgjFbwai4ds8aGQQD+19GGgci04L1jy+Mv?=
 =?us-ascii?Q?VDIqFWZsIXwKH3oxa4N3Ojb74BG54t6/ngeqRE9rXWdus9a2PHhXnthkqRIN?=
 =?us-ascii?Q?CYhJpviuA+YZTvs6JOmiL7XKZZ7HmdLQXvyVELLI4BBrR69vmJ2EtAgwcoVx?=
 =?us-ascii?Q?gSsdNY59UNY/JaDF3E85gVdktgRqPujaYE+YgbWoDpuxdnccXNQ90Nr7X9C4?=
 =?us-ascii?Q?hJIMeUCeoEQG/UdCVTZvh5Mq70PszWCda6W2SL0xI6hurVEVDJuMBrPs6XyG?=
 =?us-ascii?Q?huhpJAPATQmW+xzwJ31G97VKUN5qZHi8IQeQu76hpkAMWeeW+wI1aqa8CH87?=
 =?us-ascii?Q?ds4VviI/MkW+1XLmY6ZDM/ZcK6IPZT5h/XUvWHGuoXcVnLA4+wS/0E82K1Xt?=
 =?us-ascii?Q?MtT400cM3EXdUfhL3ekQyJTXqjhwPg8jggkQis2wkdyVEBk70BwDXauLKGM2?=
 =?us-ascii?Q?NlAC+EruPy0aDWUikKF2HjVvEAwEg53nkMcfoj8H72KPce6blJFnuPccZgKz?=
 =?us-ascii?Q?r+1r4wLyMKE/fskGM/oTpRXXlmte+UHn5t1H51fLETT10E6O4AZSmXz5jZJR?=
 =?us-ascii?Q?yMc25T4mrtmrWmwx308uJNVYjLv3PUoo9iwGrGfqoyUfv5la6DiWhdLZ6o4R?=
 =?us-ascii?Q?OqJC3HSIC/nE+wMuPd6OdiMM08ySlXwpgOOXmUSwc9rBd716qmpiCSTr40cJ?=
 =?us-ascii?Q?GcWdV3IzXvOl1CyE7OcLFMn08YsiOxuuD1uG2BGQu79gslgCv1duoVJpJxS7?=
 =?us-ascii?Q?OlSBkgtmnzRd0Db3JfD3amzOfnlIvIa5SuG2tPMXNsP092H0CAbC733g7DZW?=
 =?us-ascii?Q?UHhRpt+wek4Iok8W2XkDYD6tTGrItCVSgK1hO2A85qvUGaaddYO/KLEIzuMQ?=
 =?us-ascii?Q?i8xaL4PZOue3KmixN6PXqQ4XFD1sheOSC5MzFshPOpSOUCFX7H8hs0MT2LLW?=
 =?us-ascii?Q?nwrwwTbCiqWVutwZhxaimFsrFlKfMLL/A605JhnfBj30G7WRo21kefOBVW7Y?=
 =?us-ascii?Q?AQxaVhN8LrXjymrX0KowiNGhI3VEcogTNmvdTEX7pLtzpWypYyeQe8N7Nppm?=
 =?us-ascii?Q?GpJSPHglrsRiXipeN0E5je+XyFfWmR2UWn/tT5xOF1uSkqR+tK1B5k2sHRwu?=
 =?us-ascii?Q?ltgkoi2WqC9sGVlHBBYeaAEAYF5Wpj4lYg/Vrd594WDB7gTom53ErMX/SznC?=
 =?us-ascii?Q?tODLHEdoNHWjUR9TlZfEospp8wLTFfZw5TAVzCc+F11qXkp//Xx8Xh6ITgvv?=
 =?us-ascii?Q?E0Ta0wWCAOnfNwvGzHzf5KYPXcz1hB4KLBMfr/2TGSMqj3T1SneKWQ7nDsoB?=
 =?us-ascii?Q?X/DC/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:23:53.9647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8bc618-f80e-4f3f-dea8-08de5798aa8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637

Add tests exercising the PCI configuration space helpers.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 38c949efce38..1bc5bd1a8df5 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -5,6 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
+    device::Bound,
     device::Core,
     devres::Devres,
     io::Io,
@@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
 
         Ok(bar.read32(Regs::COUNT))
     }
+
+    fn config_space(pdev: &pci::Device<Bound>) -> Result {
+        let config = pdev.config_space()?;
+
+        // TODO: use the register!() macro for defining PCI configuration space registers once it
+        // has been move out of nova-core.
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read8 rev ID: {:x}\n",
+            config.read8(0x8)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read16 vendor ID: {:x}\n",
+            config.read16(0)
+        );
+
+        dev_info!(
+            pdev.as_ref(),
+            "pci-testdev config space read32 BAR 0: {:x}\n",
+            config.read32(0x10)
+        );
+
+        Ok(())
+    }
 }
 
 impl pci::Driver for SampleDriver {
@@ -96,6 +123,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
                         "pci-testdev data-match count: {}\n",
                         Self::testdev(info, bar)?
                     );
+                    Self::config_space(pdev)?;
                 },
                 pdev: pdev.into(),
             }))
-- 
2.51.0


