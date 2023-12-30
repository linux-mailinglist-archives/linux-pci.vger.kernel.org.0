Return-Path: <linux-pci+bounces-1565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3282060D
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 13:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B2E1F217E4
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 12:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36586D6E6;
	Sat, 30 Dec 2023 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xbBZT45E"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332028489
	for <linux-pci@vger.kernel.org>; Sat, 30 Dec 2023 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsnv73lJU66GRqclUYOEEjy5hOYPdA+FAn/LSBYHzIZUbWr9sVMoMjEYa/A5kZCv6LAmiw7s2KH0gOGZlOUq+MG87IBGWizBgDnmkbK9xDx1Hsg9GyIVOgjqJRkQHEJ4nrYSaN0frZ4bW9XL/zHFqkY45ALRAfCcA+3zyETp8W4T9VePkggA/c9twOeuwC7iJYF/qLpRpi4uzJxIq8whhebHPOZhsac+9e2aB3508xxYvoyYaSatR22e8pwhpeELYmIS0CxU7mO7Ejc5afQaEcDg2OqdG4zsfio3ipn/w2dwxYV8whxhJ4WLClDGJrm/f4HM4x2g7itd+jCl7KqJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Au4EtjrNN56WpK64SwNXyjjY3hujXEVv95HFqjYbpI=;
 b=m536KPiotUJyPn+dHzP5yRye7XH7zYezysFBrBMltKzm36BuYcwY9wDz6ikN0XJZCG/x12NwAOteQ1E8AmXiRs82KvaHN8gQigMl/rEw529hvp0YhipnpzmfKxWE6QAFgxwMjUBjv2pt91gdLmNIAvYDzc11GPXT6LFOokbRGbCitU8La4dFmSk1NRNoSNHrPecG61CR/B9nPSFBRhjNBH7MhtDfPyvjwUsHXxQRoLxQn60x55zHntKIoXYzH4UTFRogpdH2dn/65+OmPFkBrFpsPb9u/eR69oFxo6I69GrrAJghG0c5ar+qLnwCpAnZhcyjso5SWPB2y9CEIF0ZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Au4EtjrNN56WpK64SwNXyjjY3hujXEVv95HFqjYbpI=;
 b=xbBZT45EOYpqNrF1blRwRBTpYDbdmKm7wFWqcw9/DPwYfsBkNfP6Ggl7W4abMxkGtY7POqemO0p26qnn52zWhgf02PbaoCPaMf9MMxRRwkD1e99XmEFbBH9Qm6RjTjZEUc9kM4kuGma/sOSOmLFa5e3Eh5NHGF/IvyA/EB7cMYE=
Received: from DS7PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:3b8::16)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 12:42:57 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::73) by DS7PR03CA0011.outlook.office365.com
 (2603:10b6:5:3b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21 via Frontend
 Transport; Sat, 30 Dec 2023 12:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Sat, 30 Dec 2023 12:42:57 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 30 Dec
 2023 06:42:54 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <linux-pci@vger.kernel.org>, =?UTF-8?q?Martin=20Mare=C5=A1?= <mj@ucw.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH pciutils 0/2] lspci: Adding TDISP, IDE
Date: Sat, 30 Dec 2023 23:42:37 +1100
Message-ID: <20231230124239.310927-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 24184e3b-cf54-4d1d-ee33-08dc0934d988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KcU1K2EL7ddPrHUm5czjZdzHXlTiO00a7JGDo9SVSEESzL3fM8Djs9c6mDhtqQwh3IvL7e6zw/YvG3TePSX9Ua/XQBL2Ynay04oQ7ZoIDeIPul2Nh9pyHUhaqHP4QL2R5jXikDziBZoCxh9ny2FDTJqIlBltsQpBRK0erm9wOHqjTFQPppci01cgd6zihEMFwwmTkAIXd4l8TZay2L4JQeHKHv5mtF7hrV1gnL5DfrR/U33fjZx2PqegtoQcJNseHfpRm7RgvGXDwvPX/iT5vgXEaHyFCzSPYjRy0BCST7hX0vm1wuozs91EMlOpd9BzZlegyBfY+6VCUIDZUMEtZ4xkqiyw9V+eS/Q4oPk/ek19q8xjIia699dYnh7tc3dDIYAL8bz0mRP3+zJGZYunv2lYOL6oSXg5qtFKM8Oq4X1SURoOWJVGpf8iYs8VkaxRK6BapJbAaOZEhB3XPcW3M4qkBFcxY5kIr8Sp6EJKch+X7bey6FRIXeABk71tsB04mJu6fqFATgnSY7D6JdicgTMAYNvOcX8Hfxo0vHvOewrsR2gpzKtuliNp0X224Q8op0lkV8JCNKMVdTPFAly499bBc8zhYXxhP5QL1+zdo0iuFkI5l7zQXsla9O3MtB39EVp9Vh11zq2xEb9HXptVQiOueZF/bx5zFz62ffLY/4tAxQ9ApZdECTrWzxnXjvZ81gtoEIyF6xG4tHQCisNw6LaDM2q1MpJGbWMljt8gAIPHs0NeEjy6K5MQ408MYavffdbF44c7U33EilDSRGmh7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(82740400003)(356005)(5660300002)(4744005)(70586007)(16526019)(336012)(426003)(6200100001)(2906002)(2616005)(26005)(1076003)(54906003)(37006003)(70206006)(316002)(6862004)(4326008)(6666004)(478600001)(8676002)(8936002)(36860700001)(41300700001)(47076005)(83380400001)(40480700001)(40460700003)(36756003)(7049001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 12:42:57.1565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24184e3b-cf54-4d1d-ee33-08dc0934d988
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417

Here is a couple of patches for TDISP/IDE capable PCIe devices.
IDE enables PCIe link encryption and TDISP enables secure pass-through
of PCI devices into confidentional virtual machines running under
Linux KVM on supported hardware.


This is based on sha1
a997ef1 Martin Mares "Rename aux fields in structs pci_access and pci_dev to backend_data".

Please comment. Thanks.

ps. vim was set up as:
set expandtab
set tabstop=2
set shiftwidth=2
set cinoptions=:0,l1,t0,g0,(2,{2,>4
which hopefully works here :)

Alexey Kardashevskiy (2):
  lspci: Add TEE-IO extended capability bit
  pciutils: Add decode support for IDE Extended Capability

 lib/header.h |  62 ++++++++
 ls-caps.c    |   1 +
 ls-ecaps.c   | 162 ++++++++++++++++++++
 3 files changed, 225 insertions(+)

-- 
2.41.0


