Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84B15B841
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgBMEKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:41 -0500
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:3891
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729690AbgBMEKl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVU7IF++v71W/FCrWA7kkZsSoFf8aed1WJhTfK46kwmLaIASIHFMFOSU8vJVSk1GzI7eojwP/ecdcCt1cEhE8Tn9ylNGZ0DG3dFDgFcJ+FWxisrbxVTJlmWpt7EDPATMYDptLB/9Fz/wxj/mvuZoZ6R4+KnJWCpJSdzYeSPwjxYXRi6TdOq5RxS76Y38nSfCeCo9m3HuSpPgOtLCxRlAwtXNBRpeo9lMSXeL/j0fUaPexrB0nYQly6tZOE7mNobScaaX6bmHCasGWqyyFjVTPWdynbHumHo+FD/nT/81vFNQa8XOmWoj24HPvTHv2ZC+j4Aobm9TK0ymjWOnQcfkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQnIDnfOs60ArrYlrKIzHN+uSDql2UkyyPESNRwFojE=;
 b=efQdDA/r95Uuq2OVXkILC/vaF31kyMCw4X/MreGmhEZ/ygYekdFXf/+ioN9YJ1upt/mf8ZD5k1ioo6/5pm1FoqZvZUss8v2p3/Sp/FHxNAZ4ipseWtbsSSa39k4epbwvkUelqwut8dcEFaO1B/mi2Mz4QkYeRoHtMGpp1kiDsP8SjkinAqyhpbqqe6UnH/mCSNKZDeYdzkNjX/oa/72Lyvp5jeO8+WuK0xAhJiFdFI/R5Ci2ggqcMO7x7u2adI1tv6+nT9HxHoOpprwcM8zwpqtn9IuWcFhTpLfqS05Dv2JxjGJ8PDxMfVWVUGYfIwsZMUqoYvUh7jy+ISKFV2UW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQnIDnfOs60ArrYlrKIzHN+uSDql2UkyyPESNRwFojE=;
 b=HdkUPSbvPJqwkKJgXdZREu3rXA3fp1ssoxaH64PawxJIqQ9lwqncl5nghiel9LUr8neZ+O7ADkjZTM6fKykmwrON6uXgBx9hsu0ZkkWnBXvNhzpKQ+ietCs11yogzaeFMpwgrYnYkaypZIJohDxvF9jX3Wia+503o+p8qLvM/a0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:31 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:31 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 08/13] PCI: mobiveil: Add 8-bit and 16-bit CSR register accessors
Date:   Thu, 13 Feb 2020 12:06:39 +0800
Message-Id: <20200213040644.45858-9-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d09c559-c19e-4f7f-7721-08d7b03aaa73
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB70848BB3EBDBB4F60454D44C841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcgiLdgvxP0GOS7YKBLGFLB9cD19juJNuo5Fg728Sf2DeM2Wz1rYBg3cMllGbH8uDUXF6DhtGgGhuf+99mMZ7DyLQ7grVyrFiWkQNTSsbg18gTOGm0FCyCAmOnWDKTCxTjesdxKl22555FlRyM2P7hc6+5Anz/3r2TfOL5nd/PrAr0mqSy7y84HBnY/FazfjZzEekj/kjV5f9xQH0BieYM/m42UP8/dkxyQ8WHolNHRuFstZkhWBbqKiX25nx8UDHRB/bsywSSE4pIH1ZnjHCGPkHkpLAEzP8mYqCcVk/7LUCUteuQOxk8ImiewXnOEnzgkCwHuAm/JNPicxrvMqTv2p0++s7TLAO5rt+RPqofHhBFbhLw+UKimjgIDw1QfLbx1bjZk3lePZvT7Rm939juGcxrPe1qDZ4nJe/ZrpBmmqw2V+emOqCEQpfsSgu2iX7iKG8S9WBWX0VLn2jV/y5USU5mPUHqEBU4Dh4e7SlKVYkQudMeE8riOshqOd2RINbOvGLDPr6Xd4fbS07sniH1EfRNSkPv3Oq7sOOuuq3pTdK1qh248HAyk8dvw4c9jztwIkeX+7bN6+iRdxJs6RCg==
X-MS-Exchange-AntiSpam-MessageData: Fg+fpVWyux/+koORdJ8RUL6Qu/hVdWlRKZhX5u5yoCqOsmatU4KMvkZTak7wsrmQPeiUCu8lGAnA6g9ilbUA0EYb4cECPa7o1Qds8JsBBLIE8ae7/kZD2aFV9c88iNt7MZgRD9s+3tWN+Qx6Oc1vrg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d09c559-c19e-4f7f-7721-08d7b03aaa73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:31.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzzevv2IFGiJB7ZIsqg3+2V2NteDbsIU0hsHJtYOXhFlibMFufmZ+bKp8fUJsJnjonwfSa+ttv2wM+C5xVhfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

There are some 8-bit and 16-bit registers in PCIe configuration
space, so add these accessors accordingly.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V10:
 - Changed the return types to reflect the size of the access.

 .../pci/controller/mobiveil/pcie-mobiveil.h   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 623c5f0c4441..72c62b4d8f7b 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -182,10 +182,33 @@ static inline u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
 	return mobiveil_csr_read(pcie, off, 0x4);
 }
 
+static inline u16 mobiveil_csr_readw(struct mobiveil_pcie *pcie, u32 off)
+{
+	return mobiveil_csr_read(pcie, off, 0x2);
+}
+
+static inline u8 mobiveil_csr_readb(struct mobiveil_pcie *pcie, u32 off)
+{
+	return mobiveil_csr_read(pcie, off, 0x1);
+}
+
+
 static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val,
 				       u32 off)
 {
 	mobiveil_csr_write(pcie, val, off, 0x4);
 }
 
+static inline void mobiveil_csr_writew(struct mobiveil_pcie *pcie, u16 val,
+				       u32 off)
+{
+	mobiveil_csr_write(pcie, val, off, 0x2);
+}
+
+static inline void mobiveil_csr_writeb(struct mobiveil_pcie *pcie, u8 val,
+				       u32 off)
+{
+	mobiveil_csr_write(pcie, val, off, 0x1);
+}
+
 #endif /* _PCIE_MOBIVEIL_H */
-- 
2.17.1

