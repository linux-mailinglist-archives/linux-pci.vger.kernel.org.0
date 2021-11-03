Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D8A443D0F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 07:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhKCG2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 02:28:25 -0400
Received: from mail-eopbgr1320108.outbound.protection.outlook.com ([40.107.132.108]:6213
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhKCG2Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 02:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyOvTx2DmGk8DVtyHewJb+N8d1pOSX82R9Le+nZ2PNUPIsszqOtVsDIqYFCTkVheNvqrer5toMVrh8uqa++GOEWZZCNkNAD7v3FpODaboYRS3DBzcod8bRSbDBXzMt1WiNk+/ikxcNtDbRs6PskDVPgS2vkCl3NfGqNrcFpsk+C9gNVgZFaAA/PciG998job1DQ+M0teb+OCxdkt6mkI9Ox+cm/a2BjuqHTd62HN/o7gYiFm7oOMcSgfJzqYogCu3ZjM2dd5KkSadFeWBfnenTwCZs7PhaV0XT6n8ehHRylwYyS87FvFK9/OqllfMDqc/jnT2fUS2KV7Lq3twx2SBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaYYQ53ZhRjbnFzlYWjQSYCqj29qonNI8BP8RQa62nM=;
 b=R1MxJMA7a998qRuRn0BPVZyQXoLplBa/ERPCIIoAjUrlaNfnf+ObaEDavgoxvm38qvr3VBOfeYN5G3Tcc90pEzPvuTV9ww42tkAID03PaQqy8dIA+IgpJAqqIwRpebM+88ww5T2a+PHA+A01wV1wxW86B2KdjIyMivqeag7RDkYRf+kWqKWIakCF4Y5cE61sfYD9Uk9NcH2ZrG5kGNpQPnqw//VK2224CS1XMh0L1oOEKS04py7OGOl/sYoMMH8jhpnbWPNcD5IgV+XIGcBEKSrIFjN071MIC3PJYq51OS9Z/ZfwcwobYcvPXU5lsyjx2CyAiEOsVC5OrvTw3FeylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaYYQ53ZhRjbnFzlYWjQSYCqj29qonNI8BP8RQa62nM=;
 b=odkMOLFgZJSb7XI0I/Df5W4MPLXR5szv/dy5WyZnAOkTDUu6IH9VzP2hAzNCUz8FeRkVSh2Q0P5d3hAMEOS4NdFli4Dj0Rfhiv/zHYvQQb07GUJssd7Rao+bn8RfJOTnhVvhKPS78UDYXtnzKJXZ6kktwf1hKVyIkg2392vSeBE=
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com (2603:1096:404:a4::10)
 by TYZPR06MB4175.apcprd06.prod.outlook.com (2603:1096:400:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 06:25:46 +0000
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::f000:f0e8:c838:1c8a]) by TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::f000:f0e8:c838:1c8a%3]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 06:25:46 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] PCI: kirin: Fix of_node_put() issue in pcie-kirin
Date:   Wed,  3 Nov 2021 02:25:18 -0400
Message-Id: <20211103062518.25695-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0212.apcprd02.prod.outlook.com
 (2603:1096:201:20::24) To TY2PR06MB3374.apcprd06.prod.outlook.com
 (2603:1096:404:a4::10)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR02CA0212.apcprd02.prod.outlook.com (2603:1096:201:20::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 06:25:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b8b9536-cc10-4004-942f-08d99e92c53e
X-MS-TrafficTypeDiagnostic: TYZPR06MB4175:
X-Microsoft-Antispam-PRVS: <TYZPR06MB4175F9C93F83D4DC65F9FAACAB8C9@TYZPR06MB4175.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOQOA3Kptct3BssnHKi711aCjrWsowlel/aCBYlyJlNfFkpyIhkC2lY8OD2bD78/CwdUFptH1srIv17yyyT5Rahc76SH4eVvju7wrXAsIWMQt89C+GoBe/uuIyDyc5ZsEiAK2HessCon3MYIqBX46bDUDUDDu+6vz3oHSj/uU1cMa+nDIug4keG4OdFxezS+G5JqkdKbiQzGiXnw/MF5/Z8PjrPWbqbc1gOlzDUIade3ldO9k/zT+zUVif8/zgal4HUc8pWxNN4551tSP/U7ca4RPKX/jl0emA9S/mRs0qU4SHtND7tBedzoicgloBVIX5y8VED5T7kg346NGOqldyomNExT8WX0Z9peY7i0E5aGunQem+PygFFrW08Tk8Tc631CQtWH8GbjpuKvrg3RJs5Yupyecxxjy6e2hgTFz2mOduXxGPY7vIkQkvt1e5hOoQ4ONLDWU1pjZmYJFkOJ2C4M+erDYaWOYizWiylqEcnaj+n2l3wSCV8ViQdXUL3CNrr3EqA0T+Maa/f+NkoF83lmKP/6T7bbKlXwbDd1qvhw7GEDsdXFP/Tl/4iiudt2O91FncvyVoTEBUHJJABfN8RFmAzNrwxsxfRka3sVq7duPa5NngpFJ195m0XeGi4iqG5E3s4huiiRdKhwhvw9ny5yYqZ5MhaT7g+e/cGvkOc0ysNkcNudpy/UwHgR07Vx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3374.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(83380400001)(66556008)(110136005)(2906002)(316002)(66476007)(66946007)(508600001)(8936002)(2616005)(956004)(107886003)(6506007)(4326008)(86362001)(8676002)(52116002)(4744005)(6512007)(1076003)(38100700002)(186003)(38350700002)(6486002)(26005)(5660300002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TjbUw0wgUIFDQTkUiDFjlQFjkSNZEPOMjaDm+us16pvmRz4B10FKz+a6W2l7?=
 =?us-ascii?Q?60h37gGfahgZDXLTT4xvRz8/4UpA3Duqs4i/qrhRhpOc6bxI9VpM2hDtBeYz?=
 =?us-ascii?Q?9Fg56GxdZlHLw+q/bOpiG3MlYKYWbejC3U95sZ7NptAC0Uls5J63QByzMCqc?=
 =?us-ascii?Q?QIaUclRJV42yWfJ8eV0oTbnjDPfWtilkfxIARF9aOiobWV88CXqIJ9VJSsCl?=
 =?us-ascii?Q?wUPyPM6YizbR6bzCfRfdSS0e+qKaw6L2E4Fq/XsgTJZp3DH5e8ef6bJPMYXn?=
 =?us-ascii?Q?p8zMuyx0CW4H4uW2ExQPChcUPIc2xEOZ7wKOzt3sNzyeqzxZb6V/ap/ImXnW?=
 =?us-ascii?Q?u5LuOsYyKvtIDHBIVrw5RzW6XSQoELIZmV4SjBFu3pS80RAGdO64e2AZaYCz?=
 =?us-ascii?Q?It62hh0mdf8zZRezsoDG+NPL0hjrtfJrt4qlMlXFgknVCJHOyGaDfRfY66G6?=
 =?us-ascii?Q?E20iGffSNEyeLHTVoGxbTdCkDaZSWphYPnzUXMZC/0OppTyBPpQ7gWggoSQE?=
 =?us-ascii?Q?cyNR9BqQraVOKO56PSyoSUxAYVWlv7DsGavTt7qPTz15WI4RA4Hvq13MWtCS?=
 =?us-ascii?Q?FRfI98FYP5W+VUsdqG8GvCQi9BNXUJNcFp9YiN1gr0VsNKkgW+DIq6SqWICf?=
 =?us-ascii?Q?3mekNQI+8ETH/Y7F53FcuICz4x0np5mdmkhEoEl9/fH6DDhN9VW3TC5FXVye?=
 =?us-ascii?Q?sJQfb0oBhF0MzV3Hj87ntlqdEevZ2ih2DkGyC9+uW5Q0JA+TbbIrCg0k6cV3?=
 =?us-ascii?Q?1cfzSVanNDTrhMbPmtVnAfnpFIvqqQs537liIMn8/CxZq7DmqFdSN3AXSkdc?=
 =?us-ascii?Q?eJl2YjvpbfE445q+Hkn/ShTx5dExV4pSHh5o9XnfOltqsUkZuYzQRm/fg8Sh?=
 =?us-ascii?Q?jLe96q5vtHAx+TTZEXSz6yXrGMo0oQPF+mB28TydY3W07rnjQ3XEbvizmnw9?=
 =?us-ascii?Q?JKeLX2tuZCiODi6/tSGpT6Y9VRXq3IYgp5B5s/SXuida2d18z4Dx15oGQwFs?=
 =?us-ascii?Q?9ttAf54NTpbEDwJkVqZFOG0ymJbvjlmOU356tVXmYrEabU1bIyxp0ooVWqEP?=
 =?us-ascii?Q?1yujL/RuOhzFVGuSHW62J0vE4ttT7hcItXOpiWknDfivkEwm5rcojDNbqWq1?=
 =?us-ascii?Q?fXrFxIy74+6GS3gpujK4LI9qAfRzUqnr+Ru+cRs5e8E4Fk0zC8v99D+Dfh/c?=
 =?us-ascii?Q?i/4VvrLJEIVLSFxu+zMtyDQN8IA2UEDebN1HPN9NzS7hKGKbOE7HbThcBx3a?=
 =?us-ascii?Q?9RyjWKMiMU3FrN01otMvB9F0VWIThQINqAIaS3zzvhThf+2uNGCoOm/t2tzv?=
 =?us-ascii?Q?dnk+Cw8uNo3h1eOzbW6P7h5jaxg7LSvJ1zo3fVpB4Bajj1QLCYJFDvN31TCG?=
 =?us-ascii?Q?1cGvmndiWE2EnCi12DCQ7FSjwfZbcYXHcEYfyG0LmxyFhWyvSXZF0Zw7AG+R?=
 =?us-ascii?Q?a0upGqPud+87SDdI04ri9ojIKbTP5O3qIrBbYXouFZ6mxHdted7xa2EW6IKP?=
 =?us-ascii?Q?nD72W6vfHEfgzmYSKqzc/2vlSB+NyaGb1GKvP+rBYu7eUyoU7g+qx/pbN6MO?=
 =?us-ascii?Q?EhY4qcixuYlHuAgQMyTTyohADvr4G3+Dmo7yDzMwbd0KbASbD2R/I7dfMHSw?=
 =?us-ascii?Q?vohISqinYO1wEHmYh2pKD34=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b9536-cc10-4004-942f-08d99e92c53e
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3374.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:25:46.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rivxcW18U3Ah6wV7+ReSmce/UQc9NKEsQY0k+p9EO+ASnEsZWaOEOVWWM5IHfz7ukJV65Jl+feJcqnCkzGXsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4175
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix following coccicheck warning:
./drivers/pci/controller/dwc/pcie-kirin.c:414:2-34: WARNING: Function
for_each_available_child_of_node should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter. Replace return by goto here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 06017e826832..23a2c076ce53 100644
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
-- 
2.20.1

