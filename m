Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96E95EA670
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiIZMp2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiIZMpI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 08:45:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2E122A53;
        Mon, 26 Sep 2022 04:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPk/bUeD+cAy4VJnsR9rjA2TiXxfijD8rXdgSx9qHXneTe5En0ymq6vpMW7lHJE+qK5ZxmRZb9sklDz5DviIyOcrOHlxVpvNbR1OFuHvWfdyDmOOfc1Acge3TjTLIRdqGFD6uXvD55QpQZ79Bi031QeSQ5zy7ksfo2TV9O1tiRHfiMjlGqh2f3LXMtsd0qddXnxx4dhbpU01uyLNZjatsYqzrv9I9G+xTcdQWbcwYrkPKmTBPxXeZy/9oM4BSJh8tkVyFjzoYwpfedfBo8FLEIBTfN3Owaejaesqen80grYD3orX67L4YReFzDGlp3tcFMM3gmk1fcxpQJaaEypgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5eze5+YQWrios3rmHq1T6wZRccDM2AX/gMN4BMlYSc=;
 b=GNDvkgt28yk8vZhQX6RvsfHKB7pndaHnE6Cqp6j5b2Fse4viHep3v+SRkj4hHOgEbHWx6ktugi4SS8o4z7fw2fq40mwPnTn0zWuNcTEqL5csKA+t4HpVNpSDxa9UHofweieMOonvQ4YHt0yEOVgUOqcjOcIlPAJHKAQYb7GNgiVhhvtkJw0f60jmA/QnlF8/nHEF3R9/qZRSr3C1/v0LG4JLkTF8EglTVi7xIOK9d1AhHjHnOTM00TfLs83EvB9OnKs0GrOAqF2FMGozMUqd4kR0ovdvS4P23aHM80xNzoSvCvsaj6RUYHx3v+ty20/jQRAwZlhbeUHUbKDZYiE76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5eze5+YQWrios3rmHq1T6wZRccDM2AX/gMN4BMlYSc=;
 b=d8rd0ELZQyzeZPc4pJ9MSNl6cPIrb8A+BXuX/xRZIy08iA+OqlMPqov1u3/POTSkT76mvlnCfbqOZrCrCtgmCqLQRyoFURASMe9gG/GvbtiwvG0N9063cv+wN3PNlfFhmu9FtddVoq4SjcL6Kl4JSetq+I+7WV6xXrHSEkC/FIItEWj69lLofAlLXI921P/Wx5t2+ei35dmz/l+fJMJQ3RL7urJW2XOdE+oPN6GQfKoITlQCfGwZ385EutHEEkqZ1aUlxW6QnP3R7nZdb4WksMOfnnKEntzPZ48RCbo+TYWyIzSQxzEBVB6HqQWAAYkyjTLR9Q9JmLhbmE1nqZIZgQ==
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 11:10:36 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::95) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 11:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:10:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:10:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:10:24 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:10:21 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 0/2] Disable PTM for endpoint mode
Date:   Mon, 26 Sep 2022 16:40:15 +0530
Message-ID: <20220926111017.12655-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8706f26f-e741-4227-a760-08da9fafbcf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0d2oCeeCidAk6RqyEkbnmbn46uIRE6nrrBtWNzGOlHE234LskQZbheYsD/8B/f5NoJM1EjeA/MZq3Xm4lTwbs5HlnKXzgDtQAOz6lqLWu+e7pu5c4dXD/3AG5t0cs4ytJN4gNbyMIgU5RbomaefahC4clpwFweW1dhsEFmw+9oMi8GT068BJQtpOocnc11UiY38K7ke7Ac9Krnc4SGDu6d+UiZACYP/QdeTmZWrXQmx3Jt4hBQRuOBqGN2Yxq2S307izWmcg+9MSUV5gJSlziqFMZgkH70aP7DM15l5n0gOTQMJSGILWTQ9ED+RUk7DOekpy7l6LE9gK89pcMpdaP07Bg3lX/HTbMbLVTAuEHyL+E8Uofpgy/HHuQGPtT33a8G/J++Lb9lSlRFzjeH3JBxL4do4frVNqBKXS1zLwtvrMqPFI7Nwpr2kbh/rzB7LQc+YppA1N9c73ozJ971YK9tvkAT+et6ZA70SodXKOlDnlItIkaZDT5VEuWc8fqGYciAETs9dJEoxUDBNy/BVWPLQlnfybyUuHau7Xl88vYxnv3r8OBjrOIUa3G/GuAr9nZgv4t42ObreNfd0BtenHHjVpZy1j4IOeG0fzeXy2D0C+SEJXbRHcW63xSgkc7wbc81NCHw8pydL6KNH4RP5XUv2uj683TcZTRyosETlpS9019T6AvmfzVR1FcXEGgFHhApNaHKn9P74k6oGq4se8onKKU2R1rJ+BpgvL6yRkENgGoE8DZFqcydKdyNa1wEbUVUmwOyIv0xo7XaWBE3HbFQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(316002)(54906003)(356005)(40480700001)(7636003)(110136005)(40460700003)(8936002)(5660300002)(4744005)(36756003)(86362001)(8676002)(4326008)(70206006)(70586007)(2906002)(41300700001)(2616005)(26005)(82310400005)(426003)(47076005)(186003)(1076003)(336012)(6666004)(478600001)(7696005)(36860700001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:10:36.3849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8706f26f-e741-4227-a760-08da9fafbcf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains patches to disable PTM for endpoint mode
as the PCIe compliance tool requires the PTM be disabled for the endpoint
mode.

V2:
* Addressed review comments from Jingoo Han

Vidya Sagar (2):
  PCI: Add PCI_PTM_CAP_RES macro
  PCI: designware-ep: Disable PTM capabilities for EP mode

 .../pci/controller/dwc/pcie-designware-ep.c    | 18 ++++++++++++++++++
 include/uapi/linux/pci_regs.h                  |  1 +
 2 files changed, 19 insertions(+)

-- 
2.17.1

