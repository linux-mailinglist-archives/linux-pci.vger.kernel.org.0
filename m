Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00740354F3A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbhDFI6r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 04:58:47 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:51430
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244677AbhDFI6q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 04:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH24pxBXpUyGlPTbGA9Un8SuYo9hyZ4OGX0V8nRjspoKa8ZqulA15IbMO/QXbQOUZiyhhSgZbTltaSmc8sFMs0HBdK2uu8AURV57nY5CxNMj0QD7ZxsU52O4xEQMSHJkYCXbQolwdQYbidpfoswb1tdyrsLjKNjqbT3YOhQf7fcTm2cHEQkDMOVrT5QSoFP6NVczPhAq5ZqCpnVPzQXnDLO0yQyqaE5w2HSQJJV5H8OsGl5ltlZlTweqZ6fek/HuVQmL+RBULfFm13gVtJ7Ag2IWc0Jwpd2rizefkbOux0i38yplC7WquQ/DYljAZfRggmEF7gfFslhcmkjD728yZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8oPtZG3/KEuNv1kq4QTPIQiUVJpZ5+MpjdtlBX0vT0=;
 b=KMm5rztjkbRh767o0ZRJPXK2f4DiK6hxlu5SDdFbJn1cAMFm872yhjLt0kEbpmYB+ayCHn6wwp3OKk11EgBLIPqZ2C3af9NglbR5x/pYCufdGHz1mRyG/mVMgiwBNs/CyNrG4GUoYfTVxL4Lzwd0H601vU9vaZKPqGbHbyrxm11tjb08FqHEypKbL3bXFUADOt/v2Hqnv/MxGu5pLCPwvOaGJBGIvXUCPNkkbwIbQcPj9WAc0LWJQae30NoqseIXywg00KnjTmITa2vQjwcUX8abNt4aPYOUvPUdEPR35VPc2D6RduOu9kRJBBP1Yrztat6qHDu/Np60gpcswFx7Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8oPtZG3/KEuNv1kq4QTPIQiUVJpZ5+MpjdtlBX0vT0=;
 b=L6a1mlBbn+iOMvVc9+2kcGH6spDs5kNsiUw9l66YnjlkPAV+H0PHgnqnr5ML+sRoeB7DbFkALiMnv9bUKKnYBZ0MGZNSv61aRgI7Q9C1nGNXvlRdmXtpu4ldOE3R7V8s6lybyMOOsJwLCqdKBrv49TpUHZB9TnonyI2vxoTjkDY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3275.eurprd04.prod.outlook.com (2603:10a6:7:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 08:58:35 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 08:58:35 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv4 2/6] dt-bindings: pci: layerscape-pci: Add a optional property big-endian
Date:   Tue,  6 Apr 2021 17:04:45 +0800
Message-Id: <20210406090449.36352-3-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
References: <20210406090449.36352-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Tue, 6 Apr 2021 08:58:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef60c421-7691-4cb1-a2ef-08d8f8da2925
X-MS-TrafficTypeDiagnostic: HE1PR04MB3275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR04MB32752E300BB9AFA11C52EBBF84769@HE1PR04MB3275.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moCVaNw4jKZ+6+b8BLiDE6t0jjoeIKDHzm/oxNwTtshqziBnkXs582puf79jXbnsSHe8Gk3LokG6yG2054WiM0VKeLCRjmQEMhRb6tT8hR0Jv3xnmJU1JDPOxeXkJEOtLravDnD+ORAxXwd9gD/OR0++Pw7vLDw2WC24a7yneeG3xQuNwc3+goPTRKobx3eBTDYec55tOUfI3qidteu7+lKitmTZarCV76s1ff1RuyMlahnO0Y2SqrjY4+2wkXuxB4lhPApbOy3SJoxs+T+wZOI34IfroE5/o0E0bCDlHxUFeCs3eNTPXUmkCrOZKZ/DDOvhkKyRQh/fr+ZExKegwmzyalT+sl9aR/zcNNCHef8sewwZt0N9jJaU4jsp5tPYq8k08B80kVGr71PLuBQPp0aDnDat1E7e4gP6y2uMCTT0LXQGZ11mgf4khtpjU3Iddo6Lh1386xhByDA6dSd4Dk2JmeL+pZ0j3sSctp/l9LRwwHB1YRK5GOhX/3QgHeflHHqJhSxxOR7V6go9iA8pWGpuuQmoOPV8oWtUuOEjsXoAR7MMOAxW9njSHRUUODoWI+/ENoqQ2MQbnK5lL9iEbXyRhtGkfHkz/Y7GPo4F5dXwo/kAzPNN3B+NzqobICedlPdDiq1fSD/oJBjKrXJnIChg7XbzDW++PUhOcRzQ7a28w6UIdYh3A7PrbdVFglezoRrDnGiU0ee+dhfoASBwwTNTlHaajEFWM4PaDutx2s8itslpu1KXE8JjZR5Np2xy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(6506007)(38100700001)(8936002)(316002)(921005)(2906002)(66476007)(478600001)(36756003)(6512007)(5660300002)(6486002)(1076003)(8676002)(52116002)(69590400012)(4326008)(26005)(6666004)(186003)(66556008)(83380400001)(66946007)(86362001)(2616005)(16526019)(956004)(38350700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l+OhUyXaYyDrimQjf9MsWAM78NBSCkSxSLXykpQsokKsBniFCLW38qk2qULg?=
 =?us-ascii?Q?HG0V2BkTrsTwFtD37zkUdXQTjQJ4bxZy/r9r1jfMnHkRbfi930aG5EqTmI/e?=
 =?us-ascii?Q?3Q8/UWMCVkn6kcbXrDPsg+mpGPuchi/3ttAnqZxdIsXNqCKFGMdlIiywwi58?=
 =?us-ascii?Q?b4uSzT67/DOMP5fZ+NQghTGxKK9XtBunhf7W/kHW9CD3PfV6Uo9ToxvrQ61Q?=
 =?us-ascii?Q?65C0YbfQAWDhBbr5n7wT4L7druqQ1y5E+MIq+zU0C/p4pVtGehEjZqxIk9rc?=
 =?us-ascii?Q?KL7edI6lH64ZrZYZwzEZIUMQFcdg0Wz8zqXtxSZ100at6EQApP5S9A0l/9TV?=
 =?us-ascii?Q?5V96xV+y390k0Auopez+6OtkZ95tPbirUxtbKOct4AqlzE445gmPtymPKXXI?=
 =?us-ascii?Q?owbUtc3/AGwaBqVPIQTHEbv1uqfFeS4I5rt2SrJQ4XJMRKWJXbgotyTgCUjN?=
 =?us-ascii?Q?9jk9Yv/GsP+Q6Aj1dWab8bOJTeia/oEb5qyE82mBZ+VMVIkpX8vwv/GHQ1iO?=
 =?us-ascii?Q?ABaW+IULbXGzoT2C0FYQ2d2pg8qWVufTsXF6jDSIv2DMY9/8b1M7tGs0G5La?=
 =?us-ascii?Q?1mQ2/Ac6u7uKbBP5CNjYc5jwsIPhY6lp8KTy7pAXkaYetvSxQHR3XNmojxS9?=
 =?us-ascii?Q?ZrCrbevLJirHI1IfSuXPKcV+9tgpqI9LCZnBD5Hsdn1ALddXAWhQsVRjlF7S?=
 =?us-ascii?Q?DkdTKEcpd8m8FgHsYAOLrGYvwoFkBxEq9S7N2JwnMxlrWfvDtWX63Hcv0pST?=
 =?us-ascii?Q?RRbpKPxW1KNo1Bm8AeKJi7jgpuVNZjGslQPQ2CQc3SckDRgqrkv0y63FgkKT?=
 =?us-ascii?Q?4PquDTqi0X2FalgNQZ18PKRQm2S9sbVG24CwVrVMCN3I5jy8xju6DoL+PnZi?=
 =?us-ascii?Q?2OKSjKoCQZmOeC8E4v7+Lq9872IbKGxAaZnE1HrWQQVhiGEjpDqrsDsHGnin?=
 =?us-ascii?Q?H73fmRDSVOB5HTRfLVSOR4rj0pv19xsw3FLD/Ax7qmtlAVYeWYpjqrhQy+1S?=
 =?us-ascii?Q?diBddxizEu0Z3Yaq3Bs2+gs1UISrUd1qmFK8ql+SH9E20aoeIF8/pYpd7YWQ?=
 =?us-ascii?Q?SXsNTPWtjZLQ13fmpvNfaKE34ZontBlNenJWB79eWHX38S+BQMCEWzpjvxDd?=
 =?us-ascii?Q?d6bkEw3CadJgFydMzEhUUzlYIxLfLclS9mO9AFIlM9XEz7h+19Im/MZhn37u?=
 =?us-ascii?Q?HCPG1dmWjpoaJt9F+4uETRgx8c+/Pkaiasu1uEB80dX23n+new10zcE0xL99?=
 =?us-ascii?Q?1dtf6WnAEdNv45s9WLdYeToxgaMm4MM0p/ju1+6KYWZUciEsen7WKhMtZ5rd?=
 =?us-ascii?Q?6U6pxplcgPtg5sI2o376DiJ+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef60c421-7691-4cb1-a2ef-08d8f8da2925
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:58:35.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20lRYIw89fMfvX8OKNmJxaeyKKiC4dNlQJuNgCq4R4/uJ4pzYwSClx3pF0fVAgzAtrC59FZZ8pzMfbp5tLleug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3275
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This property is to indicate the endianness when accessing the
PEX_LUT and PF register block, so if these registers are
implemented in big-endian, specify this property.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V4:
 - Rebased against the latest code base

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 6d898dd4a8e2..d633c1fabdb4 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -40,6 +40,10 @@ Required properties:
   of the data transferred from/to the IP block. This can avoid the software
   cache flush/invalid actions, and improve the performance significantly.
 
+Optional properties:
+- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
+  this property.
+
 Example:
 
 	pcie@3400000 {
-- 
2.17.1

