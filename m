Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5426B1A1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgIOWdw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 18:33:52 -0400
Received: from mx0a-00273201.pphosted.com ([208.84.65.16]:10666 "EHLO
        mx0a-00273201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727539AbgIOQQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 12:16:38 -0400
Received: from pps.filterd (m0108159.ppops.net [127.0.0.1])
        by mx0a-00273201.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08FF7lhN012243;
        Tue, 15 Sep 2020 08:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=PPS1017;
 bh=LDRzk7HMzzwKyNBvHWFAOlGNLQqg6m8IfDYhepVfGGM=;
 b=J4bI2csYh7Is10auY6YJd+gnOhVTtIAtwenCvqcCou5d9OTElJpDyyEFZcQ5eWv1mQIM
 lIY6vI6oQh1y4YL3rpiWxfEAIkvLQxqB/92F4xrO08sc5bARyAJ/aYGi1sSVRTie70eK
 b0uB8giViRKSqPwpv7JbVd+ojdesQ7brjEarM1kQqvGrMELA7yI+CklhEyEa2BdJU/uU
 sMDPS6/xAmlYzDuvtkwTkZIuoqQ0O+CFzCjJ9xBRK2dYtrpoTVgHuNZFL4KuWNIQVUZu
 10t+NOe+T9cbLNAzON9j49KbTyCxM9d3aF+MnMZjO/iRSUGB1+tuyqdXaZmKAma0KKzI jA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0a-00273201.pphosted.com with ESMTP id 33gv9wvvkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Sep 2020 08:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLTXWI/jYKYCVKhH8mO1/Dy6lR1ct194RCjG9aiC1iswKv2FnKHnXxxAZdMfoauJ3uewwp7/2Cx6fJBwXOuCR7rSTZjjv7IC8wMubsd30aC/YvO81ZANAGN0C8MALyEqpp+ZYX7CgqQ74Qichz1wLkZmswODgBtCmYTu4QXx3Aln3Mo0bP6txAxWnHzuHBsoIXuVcEtPb8zY7qBm2LvE3ZoOSeyC8aYCClnBckDH/9A/R/Zrx/2w/HFi0yXtDjpMuC2dQcGotaUBR3j1nr5dCAqZxy3LVF70TjdbgKF2kgT50yUEWRTqFBLaP8PP/H/gJEhk8H9Im9v0Uo+euCCClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDRzk7HMzzwKyNBvHWFAOlGNLQqg6m8IfDYhepVfGGM=;
 b=P3aKzLGgE0WXNFplWKQaF60xe1sK5QtB9LseXrsqHdpPXGIrDxoMPqm0DOqE72XTHUsTwBtpw0a/USN/8Rexo9fvBIIKnuXtjgypYDPH40cr1TZvs+8o6f7VL2EM2vk77/1QUobNveZWpyjxCGFDt9SXpG6x7Gz8l/aeFDdXlnigx57lbuoQ9mBu9tfvTtAeExWS4vjyNMRapGqHjWMYRp6E4SsFfNMc7K8ujc2OuWLdffgzeS7vs4GhABgXc/vSHLhEjAc7jj3YoDxWJFj9D3Tv5hI52vD37W61hIHAbJ/MpXmnyrBaY/BD0Ajy1fvO29dCj4JkeCCKaBP4LrWz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=juniper.net; dmarc=pass action=none header.from=juniper.net;
 dkim=pass header.d=juniper.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDRzk7HMzzwKyNBvHWFAOlGNLQqg6m8IfDYhepVfGGM=;
 b=Ivk/8u2xnTaU4r02bxim7K0KKTBvI/tyi1eC9RyX5KX9wkR0PpgxAUS0OW0aXPihubm04NZwjyUWKNDD6efQ3axU4y9kj7WZjLAMjtbktHaASO4zg2qzCcr0jg2qshfegDQIiRnjicjsW24hiGVS3lI86wIKLDZ63kx7QkD3neU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=juniper.net;
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (2603:10b6:a03:19::16)
 by BYAPR05MB5589.namprd05.prod.outlook.com (2603:10b6:a03:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.9; Tue, 15 Sep
 2020 15:11:51 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::e4a2:9674:56bb:b13f]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::e4a2:9674:56bb:b13f%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 15:11:51 +0000
From:   Ming Qiao <mqiao@juniper.net>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ming Qiao <mqiao@juniper.net>, Debjit Ghosh <dghosh@juniper.net>,
        Santhanakrishnan Balraj <sbalraj@juniper.net>,
        Rajat Jain <rajatja@google.com>
Subject: [PATCH 2/3] PCI: Add quirks for Juniper ASICs to set class code
Date:   Tue, 15 Sep 2020 08:11:02 -0700
Message-Id: <20200915151103.7086-2-mqiao@juniper.net>
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
Received: from qnc-ubm16-mqiao.juniper.net (66.129.224.68) by BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 15:11:49 +0000
X-Mailer: git-send-email 2.10.0
X-Originating-IP: [66.129.224.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b9ee923-1a3c-462e-2c1d-08d85989ac64
X-MS-TrafficTypeDiagnostic: BYAPR05MB5589:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB558902E12DCD5AA8EFCBFB39AF200@BYAPR05MB5589.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyRvjjqF4XjmuzW8doQ+38A6ByUzFrM0gKbMGZJY+P8aSgJIn+7GMzJjNzC9K75WmiHUEv1X4H/W0Yw2l8L4P8Q+pdUr+vH/GCQgX6n5EV3HXbuEKhrJmWVJWLnqqtcAJRZ1u5pqHhYqSn3QZN/HmD96khGWHRT+CRxiT6UMb2JTSHs92YXWeex7390b+TYsQkkik3zT7CcZ72IFQRLVwdqAaLPFuytR5O0QIrApow4vyM3dK8lpGryzYYdbBPsw2mFLuGDwBnQ44r8XcAXbrmoZqgJXy54BPg779G3c/rG/GAp627zhdOgmvwUKlC232WjX8ffJJD8xn+D0UayqQ0QC5hDtGBJJl+lq4aKCYuhytUo6uGZ2OA5yIE1Uyhx4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5592.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(83380400001)(52116002)(478600001)(7696005)(54906003)(316002)(6486002)(26005)(186003)(4326008)(2616005)(956004)(16526019)(6666004)(1076003)(86362001)(8676002)(2906002)(36756003)(66556008)(66476007)(66946007)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: OiZUO2KwydCT7LH0MjjwN4OnRN/m6K+o+cHLe7EQ0T8lgd3LNnL78KAWxRwUpn2kWefDt/MnzKRXVi5KdMqBi0BwwxqUy6vGE290+c3aVzdvFiXddR7r2Gq8rSc5ohN3RGGryc+eLWeCw86/ZrNLfJvlU119BpAMGmL8N94NTy8pBgxVZSSd4avR8PhuhLLIrImgcIvOxSyANPZJYC4qPlc4LTjZPhtUdp/ThI7Bd6PwsVyiO5zf5qjfQL7WiDFjM7Ekl0MXfDGarip9ne/zHHHjDGYNh9d/wExiLuKMjvQf0k/0mCd2x6pF0fQSjIV7V1tXHq/mu0uniDpvzgfTuJ9GrAZEjGNYg19+Bl+qkY3IMg+6deQCqf8LvimPAyrXO6tVsn3UbT6NeLoYLm5KI07dLzBwwZBXTpEAJH8kv1cr3tol5diYqXlUZ0MCdISxfzbGSh2tvEDGUZkvRBiT3i+Tls1sSpRqEvqu6Vw+oqAlsz7H/DBTBpZM2cNUt1WQzDNI+bExBZXDCWun/3geHlFmbN1Hqou6kDtcZRFlKAqPfP+M0A5ojfO4OybSQOeWkxvD5m6R2pRGrYbvFVDZ6YB6ubfOaKIZK/GHyEPcVmB0PT5VDL7al8i2CBpGUloWGYJ/UXKL1mxP0Rwv8q1NLg==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9ee923-1a3c-462e-2c1d-08d85989ac64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5592.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 15:11:51.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+zKCbFfVvVByBxBHjLL6wzYI8hNcK7wG0FheJHSYpazKLmiYXHji/Q87txMeqDMptvZVhXWJkuGwtt2AbutoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5589
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-15_11:2020-09-15,2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 mlxscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the Juniper ASICs do not report correct PCI class ID, which
would confuse kernel APIs accessing the specific class of devices.
Change them to PCI_CLASS_NETWORK_OTHER << 8.
        
Signed-off-by: Debjit Ghosh <dghosh@juniper.net>
Signed-off-by: Santhanakrishnan Balraj <sbalraj@juniper.net>
Signed-off-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Ming Qiao <mqiao@juniper.net>
---
 drivers/pci/quirks.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 61344d2..04dd490 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5657,3 +5657,22 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A8, quirk_jnx_fpga);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00A9, quirk_jnx_fpga);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00AA, quirk_jnx_fpga);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, 0x0505, quirk_jnx_fpga);
+
+/*
+ * PCI class reported by some Juniper ASICs is not correct.
+ * Change it to NETWORK.
+ */
+static void quirk_jnx_asic(struct pci_dev *dev)
+{
+	dev->class = PCI_CLASS_NETWORK_OTHER << 8;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x003C, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x003D, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x003E, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0055, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x005E, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x005F, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x008E, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x008D, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x0090, quirk_jnx_asic);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JUNIPER, 0x00B2, quirk_jnx_asic);
-- 
2.10.0

