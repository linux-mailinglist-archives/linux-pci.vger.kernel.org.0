Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628347CBC9D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbjJQHop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjJQHon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:44:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FBA95;
        Tue, 17 Oct 2023 00:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUqakudbFl2Qb+DCT4GweEEX2wEofOPze8PW423VWl6kaPH9hD84dVXC0+0BC/mrVhYWvtzfTiAnABvLvruKNTnPDiUEX1Zcq2F8chS+ATCINtimG1mnUYXj5VG3Ub2v2XrtirwxrOfnpER+eeGAHp3DX6lQViL4bGxyriGE+j26WJq2cf62NQENmtV1evAie2H59IE8N0+wCq0H6ejNz4sDaTBVEiTies3q3RV0Ht5u4n/5Opw1DA+m4FA8kf16V3NB3vcFGHnFPuiCRXxaVmzRG6w/IuVZcyXMyT+0kVtgeu84PqEXA8033XiwPRzBvFaSoaMnpfvfmam4709PSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ySBn8rgWCnhaBR3SuwY+BznTeAwRhbcFy4gg/uvGpk=;
 b=ipdNCWReu1kxM4kfO/I/EaRINwOSa8EH2C44qMGsLjBHHMkbs3x835YlsrLFieKMTkoUva23YFjLouaabdQaPsYcw78wTJKqtfIhRhicRa5D9dHlZbYrYdpcVSOyyLTfxR6NY/s40N8QANAksMc1XgbLFMXo7wX38QGXGzU32Vtj6LFAXDa0ogQ55My91Fz+2tbhZJXjdm/9+GSb6NqGsVOylGjpO41wgNzvYfffxT3DGCEAfzXgdyW4Wq6KiHCAi4MvtofglveoCzodF6RvdnVhkkvWZ1lXpeKxVSnCFwX/fQR40SNZdsC8hTh5vrNhxWi5Ief/KdW/1Ns9ShacyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ySBn8rgWCnhaBR3SuwY+BznTeAwRhbcFy4gg/uvGpk=;
 b=W3oE10QDk1D+IImh8he1PxBtBk+B6ae9YYh2t67quPmwb2yaa1bkbVGjbUTD/L9xjM4ItEGYVoLPIemz35muSK7YIqacOADTsWncmB3VRX0+9dVOJ7/PkHMbN3NKy+Aw9tV/GCXM33opS9bpjzO16seVmvFZVSiuLTkc/XM+Vwwhtwtl3/2Qv0JoSG3+o1ibGDIi7q0wrJoj0HLpBmNi/4KbSoodOieSJ6bwehCdXWMl1MVgVNSmUEvuBpOFRFJm5dcbD1qn9MsaKq+Up2/FkBxW/UT9NeEa6KHSZn6SjbkvDzasw9x06OUQ+ivEKxHaJLIzA2aJ+ZHBv4njAcHj1w==
Received: from BL1PR13CA0144.namprd13.prod.outlook.com (2603:10b6:208:2bb::29)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:44:38 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::e3) by BL1PR13CA0144.outlook.office365.com
 (2603:10b6:208:2bb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Tue, 17 Oct 2023 07:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:44:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:44:23 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:44:19 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <edumazet@google.com>, <bhelgaas@google.com>,
        <alex.williamson@redhat.com>, <lukas@wunner.de>,
        <petrm@nvidia.com>, <jiri@nvidia.com>, <mlxsw@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [RFC PATCH net-next 12/12] selftests: mlxsw: Add PCI reset test
Date:   Tue, 17 Oct 2023 10:42:57 +0300
Message-ID: <20231017074257.3389177-13-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017074257.3389177-1-idosch@nvidia.com>
References: <20231017074257.3389177-1-idosch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d58036d-dafa-4f8f-2019-08dbcee4ea4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UXhb02n1HGrsDI8PGxz8mZdX7G1+W140PvAfQCZRazoEDKjg+6wTt1W7RE/Ht3e7ZiZ2SB6Ultic2eXFUPwJISwSFQyoQ7v5iD9GJ3eb94QGf94n7PdznGZrRjk8ukISGMOcqDfxRdqmTmXHFlVkIzwQCtkiUiDXhoMsZgWz7Q6DSyuzfur5OyQooOitL5t6/5t3YJSPB9zQVFqbU0MWrVV0AmoXFCYKWAl0vW8QY/tR+SQhUutad2eTsGR9IAVJB5AHLUc4mnLL+JftGOox4GXfEdGJqgakzTJvug++z2RkphZI6thQvr7NKlQkD/Ji1rooZWQI6VsHixQ57PeF9cgqey7TUB1OqAcoVwLa2yx9rdqJBwGABiQK/tKDzWVr8A1p066tZ2GXMpHRhkvEQjMTELZ/x6O8QXdCnDis+3YZVOtYrsUPjcAXnDwv+A8m/rwCZL4WCb6chUu1XRUOncyJHFowEKh1d+BaI/0409EkFP26hoCzl7j2jCFvlStUkzDd7GZU5gB0CRB9WZ6/wGh+/CyfoV1GTP127/9MEf7Lcwv9nkWCIuyfYDcA6P1L7+itGgRov4bvehLcGhcISjIXOMpZKy9hIH39D65UOveeZG/05bV7ebBKazQLQMlWJQvZY45BZO78Krmt2Ti3eMmYZVdLGv7jRgTQk6iyNklGrRWX0rLw9NzT+W0sG83FhX0ThOB/fVeGI5rdqaAbe9N+kqgmhnwGr70i/ZZF7ZkrrUiMIVyuq58jRv7pGBU
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(478600001)(70586007)(70206006)(110136005)(54906003)(6666004)(26005)(16526019)(107886003)(1076003)(336012)(316002)(426003)(2616005)(8936002)(2906002)(4326008)(8676002)(5660300002)(41300700001)(36756003)(86362001)(7636003)(47076005)(36860700001)(83380400001)(356005)(82740400003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:44:37.9879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d58036d-dafa-4f8f-2019-08dbcee4ea4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Test that PCI reset works correctly by verifying that only the expected
reset methods are supported and that after issuing the reset the ifindex
of the port changes.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/pci_reset.sh  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh

diff --git a/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh b/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
new file mode 100755
index 000000000000..2ea22806d530
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/mlxsw/pci_reset.sh
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test that PCI reset works correctly by verifying that only the expected reset
+# methods are supported and that after issuing the reset the ifindex of the
+# port changes.
+
+lib_dir=$(dirname $0)/../../../net/forwarding
+
+ALL_TESTS="
+	pci_reset_test
+"
+NUM_NETIFS=1
+source $lib_dir/lib.sh
+source $lib_dir/devlink_lib.sh
+
+pci_reset_test()
+{
+	RET=0
+
+	local bus=$(echo $DEVLINK_DEV | cut -d '/' -f 1)
+	local bdf=$(echo $DEVLINK_DEV | cut -d '/' -f 2)
+
+	if [ $bus != "pci" ]; then
+		check_err 1 "devlink device is not a PCI device"
+		log_test "pci reset"
+		return
+	fi
+
+	if [ ! -f /sys/bus/pci/devices/$bdf/reset_method ]; then
+		check_err 1 "reset is not supported"
+		log_test "pci reset"
+		return
+	fi
+
+	[[ $(cat /sys/bus/pci/devices/$bdf/reset_method) == "device_specific bus" ]]
+	check_err $? "only \"device_specific\" and \"bus\" reset methods should be supported"
+
+	local ifindex_pre=$(ip -j link show dev $swp1 | jq '.[]["ifindex"]')
+
+	echo 1 > /sys/bus/pci/devices/$bdf/reset
+	check_err $? "reset failed"
+
+	# Wait for udev to rename newly created netdev.
+	udevadm settle
+
+	local ifindex_post=$(ip -j link show dev $swp1 | jq '.[]["ifindex"]')
+
+	[[ $ifindex_pre != $ifindex_post ]]
+	check_err $? "reset not performed"
+
+	log_test "pci reset"
+}
+
+swp1=${NETIFS[p1]}
+tests_run
+
+exit $EXIT_STATUS
-- 
2.40.1

