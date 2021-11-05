Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558E4445DCB
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 03:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhKECKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 22:10:19 -0400
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:16663
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230168AbhKECKS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 22:10:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKw4tu8o/IiBHFiKw6XUbnixKrNqB2HlsIhinACHgLxD7KGuqISQy82S30Yur/t1XAQPF/bB2L95H0a+A/hKsekt+BNoroBs1ISYO3Ce2Gl/vzA0G3a8z6aWDgonr7RqYvpbacek0Or9EFUqQi5NwThjk0YpruAPuyK7Ck4+mvVvwWWKwv685grB7dhqJCoVklRj9VR2QjKalCRvfkP7GlBjQel0AZhvNm4/ll5o/o6JXEvshk2XSeeQYm+mLhkIKO8rE5nmHcPkU//E+vVb7NfDwq9fwXQT1hzoDmzaQpqEs18jxVWuYO055+AE43+wB5gcYXTizqwJ9VA279RhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBEOJqWbsOHc7axYwnf8KhtFpVCbpRdANSnCnBn7raY=;
 b=LC3YoI5GeUV75y/ggwEDF5BBX9onFMOVXMbXCodRKpCR1rty34tnvR+dQVBpG5n6ReWVimW/wSmspW3Z0LYjIanq041q8RhyNXZxyfh6q3L5EAEGsI5aEnN2AnCZSl5OHDTLUflqRpkHdyp6BylR0kUZiwDQS63vXbBVa/kBe7QH/xATJ4GqkevhaVKxWfdaNYjSBM6C0fXTUi4oUlcbTfHp1cdHZNfWHOVC6Y/RCSCtTH5hVaRTX8Yhvw+GCMXEhXnTy9y+pXGB5Y1Ti0cbf9te+6H7mG2kmWaYoU1StRJ1lkTQ5iZOd6Zda3JcnMPi0uFjWWkgPPHtRxv1P+ywvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBEOJqWbsOHc7axYwnf8KhtFpVCbpRdANSnCnBn7raY=;
 b=jNv/CMz1AmE+KtPzrIJ1MS62c7wfB/ZYHceBlTMYTJ7Zh7unxeA20ifKD26jwwtfOdAlm8J88fzHDlgP7/mc1MUyJ9vQSSkLcQBQMpu48fX8rbbbVcVGwt0DM0qlfe8hYccsIuuORPJO4J+ykzD10bbg7NdLkZSXTI1Nk28hJzE=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3452.apcprd06.prod.outlook.com (2603:1096:4:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Fri, 5 Nov 2021 02:07:34 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 02:07:34 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, mchehab+huawei@kernel.org,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH v2] PCI: kirin: Fix of_node_put() issue in pcie-kirin
Date:   Thu,  4 Nov 2021 22:07:11 -0400
Message-Id: <20211105020711.32572-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:3:1::13) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by SG2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:3:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 02:07:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f026f3e-9daa-4af9-d32f-08d9a0010826
X-MS-TrafficTypeDiagnostic: SG2PR06MB3452:
X-Microsoft-Antispam-PRVS: <SG2PR06MB345255A0A7CFA27512B9BC57AB8E9@SG2PR06MB3452.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tp69ovwnI6N014PAcenIO/rH29gZ4thqiXf8Wg+zEEcHtmVq0B+OAwe/gjacwqiEcdS7PEe5yxZDuMC4Ya78PPtM6pZkEAfrRQvh6pcx15ebM2qKCNA1IcPZGHhMf6QjDC5SnfN4jjAQ7StKDyAeIYrMQB8/y/ymfrWrfBqzI+0ANvjsVjsg1PyKyz0G3To6wZ4z2oZfO6jgagxzV/xIMqgGbwBA7KYEPM5chqpV4AMwaGBrgY+/lDbuxD2zYpaDFN/V6jMK4yq5eCA8TC0Z51PAlzjJ3yYMh4b8TGjzWb+lYBh4hunozm6LsFhOF18OhGjODxUvnO3QXQVuil0CLSsyFtJEjsQy+D9KUv0y5lxEKTiqhSOw6SK0TCi2ZTe3ClL5Pa2m8TusmAtd7hiBWjanhNpCJOZXH2/fnn58f9LFxxxIu6bVhEGmBRJ/bRxgCe0EI2N6dj8JDt+y2RK0DuoVxNltz8Exb5+Sb9MB0Fnogem+8cGkVIS+RGWUDi6FMtEyV70VokouBfE+ml2CusZZAxlo2TAb4Yy3Q4lkp1rQ92I9regVn3GrMCXZody7C2yzia2ubrL5t1TJGtKtFDJ7rth800vxBQd/b3MngYy/O30oh0aSvtAlh42iFoq3kESU8pLYnvAttCpPhQpSJ2OWAP8TD/47vKnO6xyBLumyCkpHv4Y7ZqSZH8HiC1U7rPWlz6rqr5VK65FLTsPt3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6486002)(508600001)(7416002)(8676002)(6666004)(186003)(83380400001)(5660300002)(110136005)(52116002)(2616005)(956004)(36756003)(86362001)(316002)(2906002)(66476007)(66556008)(38100700002)(38350700002)(6512007)(26005)(66946007)(4326008)(107886003)(1076003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3i8EeGvsmNIwieigmuWH/qO1jXKvAnMm445cCl0R0BRhW2t+Z6y7Yx75KtOC?=
 =?us-ascii?Q?lykf9NyGV82FKOAGVDHYM/hfSavg9UV7lCK03fUdfmhCTQeguNSEZBYPJLrV?=
 =?us-ascii?Q?ZreUTNbG1O4CnDhUiyGXUGw+dxV6V7nqEjGGmgnWT9SJtchRuNalt+ShKvYe?=
 =?us-ascii?Q?bFLB/FTRgXMNxa07Xrr1hS+zpK8LZdg4wLpwzJSyZsYDi30F99R+3oLB4gCH?=
 =?us-ascii?Q?OeYl1/OwTno46X+3sWChzNYqnZPR6EtQQ3kHkOhkot/pKYu6S1iN1dcYBmLU?=
 =?us-ascii?Q?uX27eZ7fLC9oD3/6rC79NlenEJm0loZBUCobQI/VQjfehtLpsSnpFl+nd3ky?=
 =?us-ascii?Q?+UrIART/OLHBgtjzBglIeCIK7dFS4SEVAGLXJfxsTWaW2tK+R6JBE4doPj24?=
 =?us-ascii?Q?LWExmZFWa69drlw8A0rYNUF1ap0SHTKkQihrKVRLh5j1jocenMnzBCMH22HS?=
 =?us-ascii?Q?B46vdgNaAqR095x6husVS8XVryRgupulo9D1F2xKjT+b0FafoFJlCRgH18pL?=
 =?us-ascii?Q?YbCFV8VpYxDtjj+zapHJHEg7CmV6GKhcxNywxLEzAWu1NQsx9oC9QEET9LzQ?=
 =?us-ascii?Q?caXIMoCrI7eQgAkpLnG1WBJt0WhbbbplDyV1cHo4k2qCziSNq1nUDn8YD0o8?=
 =?us-ascii?Q?Mfx7zebP3mypYurGmvhY0FrwZpkTIo+WnUsFTHXFYFcQn+RuNqOBGviYJK8t?=
 =?us-ascii?Q?Tth3wfGsRo4VWgubbmUFd++X7w8N+EHRSfBEhVbTaBvgDgLb82SWZkGdLpR0?=
 =?us-ascii?Q?FkML8cJqS/HsEcCKKDdEeNYnVDEv0j1+edsYpoE6D68VxVpFtjUHUOBhBk93?=
 =?us-ascii?Q?r4mq6eb4nXMmT34EYOCqVfiveonTIGuqzjR+gfs9hlkQTkd+J6bVlmDuEOcx?=
 =?us-ascii?Q?BDgELPTVlk6xgQKatGUjhDteJWAEiNbV7nFkgsG+JkQoDA6SQ0FcmPku/QIq?=
 =?us-ascii?Q?cfho0tp0ePX1fGO13GOgm+KWWykjn5UJkvi1aBHseV5/4bgeXG++5bOAIGe+?=
 =?us-ascii?Q?sl1z5JkPU5BcLMU4uKD9ARyYn+epE6mhu0Fv0tz4R08WQjRrjiOkkOC/VYZ1?=
 =?us-ascii?Q?4eokye7z9HMwfUUZHevi3tm8jG/cxNkfSsp/XBS47HjOd5fNGUrkS5iOFY/b?=
 =?us-ascii?Q?7YTRp4kGspjeLOXijVgy66RbEEv+OGtUWs97E688FmTkeE9Xk8/C1rqIoThJ?=
 =?us-ascii?Q?5s8kzlhJKQt/7D7mNCu7V8vebDgGtPYU50h/6OmeYa7byTQV7Xjb6eyUlln6?=
 =?us-ascii?Q?hPREzlt5HQhSvn2EH4oLzGRXh9B1Xl1b556nW61AXKV4ggsAXJRexDfjfZsM?=
 =?us-ascii?Q?95/A4xYGIWQXKNbCc1b/mTkURXTNrO9YFKRuskUyTyut7gNf7zCi7GuVucX/?=
 =?us-ascii?Q?abumF5jLZszOGBd155Xbo/2zAvG0+GecOmiMzpN5axgoBhBOokqUCcnkCBk8?=
 =?us-ascii?Q?UxoGGKvXynmK6BCbXlHXtKb3ivPNqw5yOXlJ4z5wEDpGNsWTj9ss+H4tMyAB?=
 =?us-ascii?Q?WTyfuKfwFDX7S2TBWhIYrg3v0Gy6nMVdPGAFVaDUraoqZyfSWYmUq88msNYu?=
 =?us-ascii?Q?7t4atZEZk3w+bzaTExToPR8/3tBLiEQRgOIpP7wfbMrGCjMcfiuv93yUYQSt?=
 =?us-ascii?Q?lPI2p1vN2T3YWfysr8bf7aU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f026f3e-9daa-4af9-d32f-08d9a0010826
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 02:07:34.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sclEvZDBvZlyjz0/FFKYAEnc2FalfMnyti1FnZo2XEnyQQKUd6xIbPIbpHQ38eG0g5TlCmI9OzFBVmWMHt2MhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3452
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix following coccicheck warning:
./drivers/pci/controller/dwc/pcie-kirin.c:414:2-34: WARNING: Function
for_each_available_child_of_node should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter. Replace return by goto here and add a missing
of_node_put for parent.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 06017e826832..b72a12bac49d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -422,7 +422,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			pcie->num_slots++;
 			if (pcie->num_slots > MAX_PCI_SLOTS) {
 				dev_err(dev, "Too many PCI slots!\n");
-				return -EINVAL;
+				ret = -EINVAL;
+				goto put_node;
 			}
 
 			ret = of_pci_get_devfn(child);
@@ -446,6 +447,7 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 	return 0;
 
 put_node:
+	of_node_put(parent);
 	of_node_put(child);
 	return ret;
 }
-- 
2.20.1

