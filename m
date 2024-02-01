Return-Path: <linux-pci+bounces-2905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D184511F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8B21F22000
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DABF3B7AA;
	Thu,  1 Feb 2024 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fgWFEyWf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50E28288D;
	Thu,  1 Feb 2024 06:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767375; cv=fail; b=uh9+DhlUP5CTdgvhTg/uTujSWizMDG4D54wC7OGl6yG1qWX3NLAQLfYll7wrxtcTzv0oRYqaxqnYmXiUtbKdmwnlqgbev9sDNuS1Vi2RleB8StxP1qAemwEeJNZ5iI0mvpfrmz895ftIwTqgjSaoSj238ORWw7iwc6WzufwDRyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767375; c=relaxed/simple;
	bh=T5ucevCSj4v4d8IsBMBYDZsBpr94lZ6aHONVPAA1Buk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P0xDVrPkiyPN0/OUxDp/RQgQMU6c2y8UOE/5L41Lusqf3UzcbWLs0xmIzrN5WojxzA93zP7pr+fbgerjd3K7i3UGSLrZYAUSCj4BoJsdO2AXQNRZjRCqu/uuqwrYUFJ0OZzOpDzjh0NsWlQV82EjMPnC0ST9Np+rqKdgClkiVfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fgWFEyWf; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRbNGUG4PZ23lRmEWxCMuHw8rFM+8CdrAXeIW0eRiWodnpjoiHSAauIM5WRhg/Ib3qoXMZI6MuhIuwk/oAa7jHFhWGkWRVOYeC7k7xsJ2CWXiX6J1FiKL9oXYcB7C1GCcvJyEL/Fajm2ky4SaneWOxbwwi9kwIOIHdLoWfA3pa/AKhlnaQuLckBKSrJLtDk2uzdeK0Zm9GhHOPBEkbh8F9DIEd2jzVNGyoPZZxUP1muGVqy38n1CcsxMHMSGaNLJb02QWFSbsovLUp9VhHR8XV9ah8cleoTOTNU0oqprBdmVTjZ517KQPbT/TklmfFuE4MWMwMNY+XIHkuaxDUZPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I12sMEcBoUeAmv0mGLCQRDfx0D2f4a+gqFgqFcyBof8=;
 b=a2al6qg70PyKP8FpHgrk9ZnUoddss+h6L8lCfPxaFYyUsAbtp7AeZPq99u6zPbUEaJ9izFct2wYvMdE/CdZNTQVczM6WbNR4+h8JfPGA6qjQ9kLpvYGG/2bV+QmL0bc1YqKEYkb2Ab1cJoCTpZOxg0OoFkr2GI3/deCNPJkSK2V8J5qgVxVNjzoUIuUi/jn0sBeFEDgZYiplUAVzS53lvtT+pHCdQoBmxNuVYAVRex8pMaFsCcAsw7NgB8HkVzZDIAz9xDbavybFXbmjMK0Az9qCcFFRsTLI+9vZnY2QkVbyOXKBJDMTKfeLvrSKhRy4Kr51nwMq/w0rW9v4rb+p1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I12sMEcBoUeAmv0mGLCQRDfx0D2f4a+gqFgqFcyBof8=;
 b=fgWFEyWfzGzkd3nwU5sDeXp7FkRbUvstEECA4CJTRH557mVLidUtln8eBjL09fT9yHmv7Sl6mfh5UsdJPvqcAQ4p25hIpzr4QmpMLdMIdJycEewZgLeBxWBBGP19mX/LruaVq569I6cetYDmVgxXiSH1qeiwtJdyjKpwQ1ILQcM=
Received: from DM6PR07CA0116.namprd07.prod.outlook.com (2603:10b6:5:330::13)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 06:02:49 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::19) by DM6PR07CA0116.outlook.office365.com
 (2603:10b6:5:330::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 06:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 1 Feb 2024 06:02:49 +0000
Received: from aiemdee.2.ozlabs.ru (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 00:02:45 -0600
From: Alexey Kardashevskiy <aik@amd.com>
To: <linux-pci@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Lukas Wunner
	<lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH kernel 0/4] pci/doe/ide: Capabilities, protocols
Date: Thu, 1 Feb 2024 17:02:24 +1100
Message-ID: <20240201060228.3070928-1-aik@amd.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbec881-edae-47c7-ec2b-08dc22eb6b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OmtBHwIcY+E6YqODZFBLpJiY5QI9DqbKLD8+o1X2Yk9iCdcv+7YCUP/Gq6ps/h9+Cx0l8NUlgdGedcLO8ALuqskVqZQ0LaqwLDt/Ss2einNBnOiN0OA3c+EH+kI32jUvYCRAn3En7klt2z7vKE+j5dxuShq0KhjqtM3W48EikYngUAgGFaXEtba97tlSBTbKbI8v3lENzOYRU7cDqPVeCVWfwqaJmOpRVUpERvC6MGTZSfWCkjU3zLin3hTQyf6MnDijJt2/CbEYY7JnA3EpbNMjbKehkjBbqAdWBgubX3KEj4LXKp/k6jBNa3plQJVQHN+NxvQnyGIFqBIVh6RfIuz7oiqoOH3AkNQ2PVpxG4QBOVdyGAWaJqPX+9b7gyNAwX+110etvn9tRCwF5oaEaQSNSrYfWqDsA8Xi7O9O2UNDS4FHrgm8AGqZay/1FnFq7YBbuAcVlqgd3Oqfb4lAY9igy5vQSjwrGfKpAOerlbsU69+n93FZUtSJnyT4GIGKm/h+GBG4OqJew1cIrdfP/X3xxNCjbUvYG5aLaYNW1MMcRAFXQ33oYkeYTPBdHN1LYhaBqwnFXkS7RfLMk59HY+I49QIdz88mH4TkGYvdfmW/s7znUVNfyme7THavUHIf3qVnATu2ZFq6KFMfDIsBvfOXrguWwk1IVgXmdCngIX2Nz1T2dwd6a6iMxDqdGPwARQ2+0Y0n2afElrdby1FyAcHf+sNKcmTD865zRqi3sqtRPklQg+xgl3VUmVd5mdecIIMtPnWH7SAZlGDArJYrQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(4744005)(426003)(2906002)(2616005)(1076003)(26005)(36860700001)(16526019)(82740400003)(336012)(5660300002)(47076005)(54906003)(70206006)(70586007)(8936002)(6666004)(4326008)(8676002)(316002)(478600001)(6916009)(83380400001)(81166007)(40480700001)(356005)(40460700003)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 06:02:49.0709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbec881-edae-47c7-ec2b-08dc22eb6b3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

Here are 4 small independent patches defining new PCIe caps and bits and
protocols, I am using them with my test device so they are real :)


Please comment. Thanks.



Alexey Kardashevskiy (4):
  pci/doe: Define protocol types and make those public
  pci/doe: Support discovery version
  pci: Define TEE-IO bit in PCIe device capabilities
  pci: Define Integrity and Data Encryption (IDE) extended capability

 include/linux/pci-doe.h       |  4 ++++
 include/uapi/linux/pci_regs.h |  5 ++++-
 drivers/pci/doe.c             | 13 ++++++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

-- 
2.41.0


