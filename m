Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBF926B11D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 00:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgIOWZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 18:25:01 -0400
Received: from mx0a-00273201.pphosted.com ([208.84.65.16]:60704 "EHLO
        mx0a-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727565AbgIOQWn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 12:22:43 -0400
Received: from pps.filterd (m0108158.ppops.net [127.0.0.1])
        by mx0a-00273201.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FF7AGi010564;
        Tue, 15 Sep 2020 08:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=PPS1017;
 bh=pKRQ7lERDxus16oHsM5Fuq9fR6ddWRdNjQx0Lc3U1kc=;
 b=m5s00040m8GUJAE+z9fWvv78QCnq4ER9hrmXe7NmMiEL0WpjvNdtDuXFM0nHOACO5vbj
 Tnijo+vTGsDzAYjgWiiNHWNPWZTbl71HbSBBbbFhvQAcYJFQw1uYLZaFYMIwGoXA+6U4
 ySt9an/K228mtTHZA+y8UHNfCGOFSJ94vlUVM4i4gMa08DqNw1mrNpcWt2W3UYGnHVZx
 nsO+JKQlLkhTD/4t/85lCNhRqc4WTY/uOtzwD/63/GmReM8CKKDekQpEZW0A06luln4/
 suw3UQ7uk9CnHwrllIHMKS9L6JwMcGxeWD2xfq/8J9On6yXKrIisRMD32fPpcu1LPYQU 8g== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0a-00273201.pphosted.com with ESMTP id 33gt1rn0sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaYTSkl8YAtHvccjuNqxLuAYOZqk7xxDlngOKpPwYmk4x9SfIw7/HuJCFL89msRcAg0iWsvlSDkVSgKxZIpLckDE+WZPH4S5HWB3yKKJSdawRxjgEf8y/PpOLC1NoHRbfuxBWdxvZ4L8rUoUsKeSN1K4VKNo1JPv4od2eFvJhTisLQwThIvZ9paAhTp08/+wdwGzmdf0ZcUpba/CVzINWAgLNx/Pkuoz8rGBWLFmMFAY9y6qX8R32ObPO4sEwdnDR3IjW/uRqQrhTlUxNWI9lZzuYw4gCzHMaXaj2v+iSJ1YuwZoG6DGxIxedpSC2G6/UA3kdGPDaW5xOpTQApX8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKRQ7lERDxus16oHsM5Fuq9fR6ddWRdNjQx0Lc3U1kc=;
 b=nV8cA2ExiiJGT3nQ5x1qW1sRBNhfWN/PE7Ch5DaTeUBMeu/ff/JbUyz6WMXQxC5mmsalnMOBBQJfH579f1fPQKcWJggaTy20pPQJUf65ED/OvLMw+MDpaE276eGRfnuH7dSMv+ZzPhoVLbhR3VLIsqbqEAP0IjaGvj97VFa9S6r5FwHcocIhW5WnQyjd/3sIShsVIb+nUAKu0HK1ord3ejJUbeEsCH3qHRChJoOoVrCD1ILw9DRto5oQbUBRiSslXS3jB6c7SdyO2rwj8AzkIbfnk0iO0stJO9OZMUT0HIBRtaLJL4fp4vpZtFqTLYtLh8c0rKAyWxP644Oc38rwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKRQ7lERDxus16oHsM5Fuq9fR6ddWRdNjQx0Lc3U1kc=;
 b=WJaEODXKtqyjgvdk3mW9mt7Mw45+EUZfQyeilVGSjU6zazciZkNXk00YdDTuBTW/Arlgb23ZPed/nbSP+UH6S5KxvTvUjZzpCYZXV4tctg2SxCxIFNF5v+Ak+YTWla98JvVjHsd5S5bq73WZI1iVux0jZHVAuuglbS6YduajM+4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=juniper.net;
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (2603:10b6:a03:19::16)
 by BYAPR05MB5589.namprd05.prod.outlook.com (2603:10b6:a03:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.9; Tue, 15 Sep
 2020 15:12:02 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::e4a2:9674:56bb:b13f]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::e4a2:9674:56bb:b13f%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 15:12:02 +0000
From:   Ming Qiao <mqiao@juniper.net>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ming Qiao <mqiao@juniper.net>, Rajat Jain <rajatja@google.com>
Subject: [PATCH 3/3] PCI: Add quirks for Juniper ASICs to fix PCIe gen
Date:   Tue, 15 Sep 2020 08:11:03 -0700
Message-Id: <20200915151103.7086-3-mqiao@juniper.net>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20200915151103.7086-1-mqiao@juniper.net>
References: <20200915151103.7086-1-mqiao@juniper.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To BYAPR05MB5592.namprd05.prod.outlook.com
 (2603:10b6:a03:19::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from qnc-ubm16-mqiao.juniper.net (66.129.224.68) by BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 15:12:00 +0000
X-Mailer: git-send-email 2.10.0
X-Originating-IP: [66.129.224.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae4727c0-8340-4145-d4a9-08d85989b2a4
X-MS-TrafficTypeDiagnostic: BYAPR05MB5589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB5589FCFE7C82814A8E45E35AAF200@BYAPR05MB5589.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKsJMe94nvO4/OXB4Oiq17VvM0Ub/2XPiAmUcyq6RDSFvEx+mmWTeswNHyNd7HLdhd78cCU5IeXrSJZ6PhZPDR58IZ7y2Dj33AgAcBkd+MQWwnGklCBbJyb9Zr8lWPnJ5xeOuKH0bySK4RalSxxlaUGBpU1Itq81tHoGrZXUcJDJRBN/m2919qVc1mw3hC/Abhz7zcJyU/a5E0k8dfIC7f4Edb7G1/cuOJFXTM/dHT7WBfOoOoB8MSrgJFw0SVBLwQJti0VJYoLBFGGq2VRSe/OLl4IA4bqagAtVSTVrb7H07qFvyTH5WXPTFhDxo6lh6XQHMkD9vm92w6aoXo4u0N2WB+NfRJfpXhPc6nw4AKZRNUv6+xdUHhvvFQzhb+aF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5592.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(52116002)(478600001)(7696005)(54906003)(316002)(6486002)(26005)(186003)(4326008)(2616005)(956004)(16526019)(1076003)(86362001)(8676002)(2906002)(36756003)(66556008)(66476007)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zhWcqFa1IhSciujgQPMKEkEcfZl17Noi3DHtAOaT+YNPwiiY4EBXBo+XChguH8QRME+0VJYzUsDLvYDldAi1TKIrlWZdIC3DEbJrErxGG8R5hgALJKM8n2J6Oq3FpsBhayL5IjbxkihUtiG3BrjpiiQKkesk7Xnn0bZ5h9//X/l+nqVa7aEmSmK1CKjkysT8k+WD/CFf9hA8u2T3BVn5nzpjgkP7CZDdvERzoboWw7h81bmko7JydqxAwaLWMKWytCy6h/kfOlCzTXQsxWTuUc9VwgLwLMXCUFk/ME40vqBPDapnnltmio9ECUQoRwjy2b/bgzbeSwcn0KaOSXoY48pfA77ejo76HQn6pmu0rQ4JVFvhgVa82JoqpWqsP4s7118IuSJv6z/hsVI46i5+QR8fOdWoB6S5idcbWSPJp5aVaDk6KwyNALhZ4eurwmO+RwnCR5DX3kO1LEWqFHVQBsnTlmyJlYbsFbZuoKwr3ppyGIQQqfCyPi/mF81oahnf/bxTHY0EcRf/ADymxLA4oN2CY02CVHOfUPpHe/NyRjNW//+H0+XImLnNaS0edxZ5Fw1XGylrVTPI/YxWrn4OmVI4SgJ6Ir0QjvwRfrb0KXz1Ggaj9r0XNX7gVq10z+y0Mf3Y6ula9xe369dN7DyE2A==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4727c0-8340-4145-d4a9-08d85989b2a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5592.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 15:12:01.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZtaROUCsQ3pB79c0z4u7PZG3n4Mlgpz2aK+9x4njOD8dSOzsGpEun9QMINeFqBH12GcG5pB+UPZ8hZVCIhhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5589
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the Juniper ASICs report incorrect PCIe gen type for the PCIe
link to the root port. Make the root port to ignore these fields.
        
Signed-off-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Ming Qiao <mqiao@juniper.net>
---
 drivers/pci/quirks.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 04dd490..0a28a09 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5658,6 +5658,45 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A9, quirk_jnx_fpga);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00AA, quirk_jnx_fpga);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x0505, quirk_jnx_fpga);
 
+static struct dmi_system_id jnx_asic_pci_bug_affected_platforms[] = {
+	{
+	.ident = "Juniper Networks PTX MLC Card",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Juniper Networks Inc."),
+		DMI_MATCH(DMI_BOARD_NAME, "0C0A")
+		},
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(dmi, jnx_asic_pci_bug_affected_platforms);
+
+#define INTEL_DEBUG_REG		0x8F8
+#define INTEL_DEBUG_REG_IGNORE_GEN	BIT(3)
+
+/*
+ * Some Juniper ASICs have an issue where they report incorrect gen type
+ * (Gen-1 / Gen-2) for the PCIe link to the root port.
+ * This workaround needs to be applied to each Intel root port which connects
+ * to such juniper ASIC. It causes the root port to ignore the incorrect
+ * fields.
+ */
+static void fixup_jnx_intel_root_port(struct pci_dev *dev)
+{
+	struct pci_dev *root;
+	u32 tmp32;
+	int ret;
+
+	root = pcie_find_root_port(dev);
+	if (!root || root->vendor != PCI_VENDOR_ID_INTEL)
+		return;
+
+	ret = pci_read_config_dword(root, INTEL_DEBUG_REG, &tmp32);
+	tmp32 |= INTEL_DEBUG_REG_IGNORE_GEN;
+	ret |= pci_write_config_dword(root, INTEL_DEBUG_REG, tmp32);
+	if (ret)
+		dev_err(&root->dev, "Failed on root port quirk. CONFIG_PCI_MMCONFIG not selected?\n");
+}
+
 /*
  * PCI class reported by some Juniper ASICs is not correct.
  * Change it to NETWORK.
@@ -5665,6 +5704,9 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x0505, quirk_jnx_fpga);
 static void quirk_jnx_asic(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_NETWORK_OTHER << 8;
+
+	if (dmi_check_system(jnx_asic_pci_bug_affected_platforms))
+		fixup_jnx_intel_root_port(dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x003C, quirk_jnx_asic);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x003D, quirk_jnx_asic);
-- 
2.10.0

