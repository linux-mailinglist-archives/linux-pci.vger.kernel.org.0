Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972BF2882DC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 08:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731120AbgJIGno (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 02:43:44 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:10309
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbgJIGnn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 02:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3D4tJGhmAksZjd5EzvJsFFVBficjppRiblVOr61+msFzTVIIwnAyiyBebk4eqhfZYasbhFV3XkOrvdjNAN3HklDODBwgKdJQthgORVxwrdLfEHO7TajozH20XhQq0I0OJoW4fIJaKjxAna+IbeLEc1v3krng2aYzZCQSFs9cG0XcrE7/Bl/cI8C5jWURv8A6LOeYd46jdajstDjZgMCWcMEVIRxBNbC8G2g7RegU2gIdorCQuYGMHXWw1ZMtatogtTrJgWj+SsjGQX/Qm7di5hVOXDbkqkK03kyoy5Kv4RvFN8UUkMO+1NR52ZFcC+vx64dTBh6IczaCKrGXDazSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMv2KCGB5LuSyCYNjvXkxUsl/D6L8sSQYG6wyWbXloI=;
 b=HKIZAHwxX9RpWyDYht2loZjEcoJe7woQdOID1BBVN/kAXCD9fUXhrDYFDVNwd7Ms2N2E2eXP+54a4qwKCuXXjXfV+ibB82jeK38fcktj35po5bwOsGViv5ytkj7ttp6avzHTjG58VJ5625Co6f2LRGQl2smg1Ym31dlK4bOqjqlt6HRta/0OXfZf1VGULzfmrpx2CvAcfcr8Svl6OVImzJHbG+DXOHEvdyalp6mmUXIL0ItXNEtemuyrWyLJW7nEQ39ooYIhVcEmNH8QEEI3Gv3paWnUfMpxquOYg8bdVyjTLzspRYOsOSiVz+4CqcOvdt0yl3FLJwenKNWFZrb2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMv2KCGB5LuSyCYNjvXkxUsl/D6L8sSQYG6wyWbXloI=;
 b=Bsb8kMefgfYPhlL3++/i7C1wElI6MbYCyUnMPSoJh+fgz0YajykYcWvrgJBQCux0n1XV0L+V166umzQFOXb2XxYgUB6MlNIVxwUgEJDYMYAZheAnTCZ/xHxRQbPqGbXAtiz4H3F90AOCLTwol0JImdWES1v1JO2BLJ3yniQT26I=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB3036.namprd03.prod.outlook.com (2603:10b6:3:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 06:43:41 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 06:43:41 +0000
Date:   Fri, 9 Oct 2020 14:41:39 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is
 disabled
Message-ID: <20201009144139.22071390@xhacker.debian>
In-Reply-To: <20201009144029.62f327a9@xhacker.debian>
References: <20201009144029.62f327a9@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:404:14::28) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR03CA0016.apcprd03.prod.outlook.com (2603:1096:404:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Fri, 9 Oct 2020 06:43:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13da336-4c0a-49bf-457b-08d86c1ea8e2
X-MS-TrafficTypeDiagnostic: DM5PR03MB3036:
X-Microsoft-Antispam-PRVS: <DM5PR03MB30361839A4B72F1DD516883BED080@DM5PR03MB3036.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgUKOVLWWh54wN8tZ/CoSwwFva2cCj7Jm/meOMW7nVatsHvJmUWLBRP+PkWKBdaMqXdHIJSvMXHzvvh8nz8YBpBAqA/go5zp/Vmn1rp4Gb8wbFQHBaIOo6pWF0x+5I/55jpMC6hQbf1NgSlqtmKLnpv8OXFQIG9m4F9m5BKRuAHEdJZDmbMM9JB3NLqP+AXs3wgiOiwj55PWRV6+hcR/yTrWX+gwafqQWbyNeuCxzkl4+dmg2tCeH4bS3YgInwMVfaKw8ltjrDasaTLzq4Erf8UGWZYHvkAbq7wr7C6Ci1x9n2QWDfrRw/EpR6kyb5h1X5oOnw9hzb4+aRmbcUWF5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(5660300002)(66946007)(8676002)(66476007)(66556008)(55016002)(9686003)(2906002)(7416002)(110136005)(86362001)(83380400001)(4744005)(956004)(1076003)(26005)(6506007)(316002)(7696005)(52116002)(4326008)(478600001)(186003)(16526019)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Vx1Vr40Hfvo2g/JDGSPtzwWIGZbRiMFdwmlAMz0o5wkJyv5AtypA3EDf+9iScDGuQ/Erwhnrz9fy8CH3hYgQnsRVeJ0m85Sa/tApiflcBDkR/F7GIGoo1Wnc4WyNyDcPjB+2xuC+P6WZk+bwQIxEHFT3qV7T5jIHbMBLNxvAB6XHRh+T66+pFWJb5vH1rfX7tE3kay5utMVPSq4fRwTE+MD7BOHby5U9g/kuYgYhBuZdcPNxfa2wzoYuVGYgw3P7Xa+ZTeJYJlQV2v+zdgsWQaa4MfalfJx2FzW5nST7ei5AfbK/QLvXuFcPKK7x2zm+QlSgAXvOZMx1Seknek8Vmy1jlPOkRekqHbGtX/gxTUt8U9NX8146LTvSgykMdJb9DSCvQU8ewwuF8m2nTvT+EWTlu5kOGa3rsvXZt44QLwFt2mE9gFOxSHojA9MXFjarQ6JDHS/P5Jg5IIKdbKPA+y7Zd5WZwFeSfByPm7KPb0f+22gPxOMAKF1c/yyvSFiI9PQLL1oIQUPcPAw8QE+Xfm0Z2BjBBRfpxR3tcZChtUg8w5eZP8VhViwdxJjIpcjlocKfmLWmChZwfDUQqIytXo1xRCT+bFwsuh58sHYdZi+svsEWsGq6XM4J9BLlHHqOATu8ht0laYTUdayjooXxvQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13da336-4c0a-49bf-457b-08d86c1ea8e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 06:43:41.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GTPnfpthhHPsE9mQoOvisCvsqIfpt/tS+A+VxFFnzGCbhA/q1cQax5kR0/S8T4W+E7WbTsmTEAn27eGHRZCyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3036
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
and PCIE_MSI_INTR0_ENABLE registers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 317ff512f8df..d3e9ea11ce9e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -528,7 +528,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	if (!pp->ops->msi_host_init) {
+	if (pci_msi_enabled() && !pp->ops->msi_host_init) {
 		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 		/* Initialize IRQ Status array */
-- 
2.28.0

