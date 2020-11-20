Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E992BA8D6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgKTLSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 06:18:17 -0500
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:28513
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728412AbgKTLSQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 06:18:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4UVhHSUc+t3ZcaSRb9nP7zWSHjXeEH74kVhwsK+M7V62jnoi2VoB6b5ZV/QSWaG8o1Waf3pBU8JsXmojtFpMQpbbvN2KPZTavblzqXaG8/cJYgVE1yPQEpcpNH/Wau1cuwP0feDf2UuiNPy2dYOXQnlUVBkSiCmC84c3WF5jK3Pcw2fQlvJGRK/iSubSV1RBuqIeRIFqILa8okcMNzpIfqf0PQK61pWzqTiWUDAuV/kyWHy0+jWlf5t4KwgwudGC4ocH+qF7Y9u6sMlazg2O4WxyhXZAtpfve8UZ+NMN+Rd1UtU45Sjf/vMpNZLl6lOuuBS1EkOUZae735Gzs1uig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir2Nk+yJ2QTEJ607sevnjl87Yc2uD8iEZ5mqcb4v5Ww=;
 b=TQddZIL1iu+8N0n91hIshom2aCipbbIUTraNYj8VaDqHO2pmaaxNF4cXlQJkgZ+oLkZSncJQ1jRwaow4eNJ/dzG/s6et6GHRkZSHXHfXFnDPQ5SKU5P5xVo0oS9EKpfAN6XhUFiXPYHxgxhjgaVIBnxepCmT4k6Y2zyP/sEweeG65Tch0eRx8C2+AMyVWacXzVaTw66CzWO5eQ11ZNP4EYwrsJzmo53hBNpaTMb5Hz0KcofVx9fAiSv2x+R2B5xs6bsZtj6+ve9Jnw5kFk+gGRRJ6IFjT53k2mSlF+8bEGnK8C5MOv0kYnMlCuUinKTzfotvS41VLrQRXBFcLXzm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir2Nk+yJ2QTEJ607sevnjl87Yc2uD8iEZ5mqcb4v5Ww=;
 b=c6RBf+FDMfEJHa7APaY7C/HowDxvWzdMZ5DHedZb2rknTkwWeOIWPOjQf48rlolWLpzruNj0P9xXsnRwOWndRaf/uHvcGwePVJthC19n6c0WeT8oSEhCH66J/J3IgVgb3kw3gDXvXjU1hpP71vXuBYldIrQ4/a8nj5qHqOsU9nw=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN6PR03MB3808.namprd03.prod.outlook.com (2603:10b6:805:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 11:18:14 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 11:18:14 +0000
Date:   Fri, 20 Nov 2020 19:17:20 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next v2 2/2] PCI: dwc: al: Remove useless dw_pcie_ops
Message-ID: <20201120191720.5a2320cf@xhacker.debian>
In-Reply-To: <20201120191611.7b84a86b@xhacker.debian>
References: <20201120191611.7b84a86b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 11:18:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 218c0286-cd38-4d45-9db5-08d88d45f8fe
X-MS-TrafficTypeDiagnostic: SN6PR03MB3808:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3808109BAD0A24682447B2E6EDFF0@SN6PR03MB3808.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFe1Yd0VG+eTv7ZTJa8K1DjTd5ylbyT+5R3uduXAu9CCK9OXa4vPp+13ueaUjp3x6DLvZt7DrJrf+vW7k741803koS8mevEaheGZIrq42GyVg4hyQ4P/7lGxtMTHOo8PwsOqP5ti6kWXc7meytJe4xl+WsDfswUstqubgvMA6JSnG36D7B3VLAopmEp7RrXwVEgJ56v5yd32GsrJLdixPgLD8MnVNq75oN2H/r5UBnzSTxpU2SHj/NtrAxEbUBRTSGRaMyzQYE2X1VpCTog7D1GY+nd0QgLBSOCtoKaM7sf2VFpO+VFKRxDQl0HsYXaB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(9686003)(66946007)(4744005)(8936002)(316002)(186003)(478600001)(4326008)(26005)(5660300002)(55016002)(16526019)(8676002)(2906002)(6666004)(6506007)(86362001)(83380400001)(66476007)(66556008)(52116002)(956004)(110136005)(7696005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n12azcA5YPBHFUtsamMRjILcJP+4Su1yX6NEzrecK9LSOV0FR4RPvot8MujVUWY7LXyDtkY+KeVnhJaByxUCCDcBtPejZG7NRryGhvLdu3v0svqHJ2P5F7DfcOAJVmglefOP1Q0hx+3FgRJMCyHRNT+TSueiNSEeJc9s0X8jntKpk9EDmfKF9wHl84TGpIOYOIAxhZIO0JWm46BxH+/CKWyZcva35Rbo1mFUbyWuU0DVtNLfAN9g1UPd2X3TZ7e+y/uP/9w85a2O8ubVnyggfUJWUSVriKB+oPWt4i1Slj8J4MgY7Bwghpp0Z982Wh7gMps/fBlKkHY9ear3e3XVBV22RndmxUP4oOamGG4V4cGg3qx12Du3mwglOo73S77LqP7T5fS60RGXB4y1+jITzeb/Wevc0QUNLub9aqWzpr7nMcKQPyKM4v9ukXQZXZAdVzvlVmiwWc3H0KBbgL++cViNlPQ6z+fQx40YX1HtkQuLNGriQkRWwtgTgfZFFNJCEM9FvjhmZ0xl3irwDIDksr2v8+yGxJSK+fgk9amAlxqKQhrMQMONWTrzqXqAsL+/ZkfG7lswPKwWbID8HHfajIQmMYeUZ5Jk312nNdw4AYdhWHzup2oUCPuiFSOmlSB1KuIgaAN90A7MsgVqWHnfJw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218c0286-cd38-4d45-9db5-08d88d45f8fe
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 11:18:14.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoakXZMV/YuDb7/3OrUv24EaFu2sWe6aMUhvfI6pAZitYWdWugpLMIlos46mClRhqfKetHiQyIY7xiwTBjykxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3808
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have removed the dw_pcie_ops always exists assumption in dwc
core driver, we can remove the useless dw_pcie_ops now.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-al.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index 7ac8a37d9ce0..36977c48a7ae 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -322,9 +322,6 @@ static const struct dw_pcie_host_ops al_pcie_host_ops = {
 	.host_init = al_pcie_host_init,
 };
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-};
-
 static int al_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -342,7 +339,6 @@ static int al_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &al_pcie_host_ops;
 
 	al_pcie->pci = pci;
-- 
2.29.2

