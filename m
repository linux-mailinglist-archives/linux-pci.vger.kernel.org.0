Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A64306DC8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 07:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhA1GpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 01:45:07 -0500
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:48128
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231211AbhA1GpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 01:45:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azfRie/FIs+ckO9yV5MK0QliTEby/gw6X3TwYto98mF4t1lYqJ1FsZ+DPf4ZbYEC8QCT8g87bEmGJYNomeGlChyylbByoz8jLZTjM8JMonPwSrc16aFjSMdMjl1hCjOd5AibP3vqJmGSDwmIzMQDmnEmLW+ClyjJtGsAY6p9SvVpIUGB4FVbkmXTw5iklapb5Tnhbnbdr5Kp/lHD9rT+GRCHvCUSTft55nViA8qfQYQ4Gv6DrdUv6+6dfworOurf73OhEBOww1V+nx94OK2esKGb8x6hFP/Q9aucMiUzxAr7PH0h/VTgyr3JT24dWuc/Lua4A7/ovBuSr45e9wigrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6guOfkqRXwrZnb9jdTIWPkgocpd4yaeBDVVEWnltpkc=;
 b=Cp6lHULiugfS2J/Kd0gB4quEfy8TNTN4Bju0yFALBl5bV6aIjEKADTH+szdsFHn3C/BPB7lezMKABQhGGllBNXez8MqQ/iuxrHuurSa6NV9qgZiMK4CCwM8KGPWCK1W62Bz1do9jzaSQyXwgoSBvaJE8Roqf3z7hqd9OUd0n63k2gGGmiTCPaxdiZJtwGgqXjEFRE6w5+2tTaD2F9dH42kV0yqJqN2qhC6j1Jrt8wOh9ZO1Da6mRu3w6bp1E0ZQ5yx2F3bUVLW6OEA/h/G16jlw5vlC4u8MrdE9yNFD4U5m2bX70mqUELRQXLHXJReR0JgkTBdj902O3iMxGpruyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6guOfkqRXwrZnb9jdTIWPkgocpd4yaeBDVVEWnltpkc=;
 b=aFNbfqqf4dQCV/+HwkHO+zgeAW7VXso+7U9KurKrGS+qHT+Nuzn/hclPFof8QSVbOtH6EHA/3ZV82ZzFEGBVfnylaxa0JkqALtTmGMEt4yESc/yE2HXAXacvz1jvgbE3gupUR2w0tYZrqWXUIKUquHbx1NBnZwLMoUsS57IFYS0=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN6PR03MB2563.namprd03.prod.outlook.com (2603:10b6:404:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 06:44:00 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::f80a:407e:46ca:e6ce]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::f80a:407e:46ca:e6ce%5]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 06:44:00 +0000
Date:   Thu, 28 Jan 2021 14:43:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: dwc: al: Remove useless dw_pcie_ops
Message-ID: <20210128144324.2fa8577c@xhacker.debian>
In-Reply-To: <20210128144208.343052f7@xhacker.debian>
References: <20210128144208.343052f7@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR08CA0033.namprd08.prod.outlook.com (2603:10b6:a03:100::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 06:43:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d330cb6-623d-44e2-d377-08d8c358180b
X-MS-TrafficTypeDiagnostic: BN6PR03MB2563:
X-Microsoft-Antispam-PRVS: <BN6PR03MB25635D35142C747562FD3A06EDBA9@BN6PR03MB2563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apVslLzrI2c2LDLjSbKLpgCQEK1AgNU4tKyOSMp+FNtsIPP01wC/K+XSLfF+LrG6b2kIY2GXlXwK2xbIHVPwTC+/0MDOUDd9rQJaZIRgZ3Q/3cOVJbbzLn5BEyIJeL9XciXQkJH1CBllx9f+UESWso1pdI61WBMr7wUBBZSjiTUQQ2GQvQRVOy++Sz/GzIzRoPLFjF4jGLpz/w+UmqjJDSVLmedFHBHzTFtuoPsv8/41zMvhaC0E4VMyj5i4B9WehFlSsi7fMJ5acUCkUPqTtcDML5UEq3aPvjfscTHwKo0g8mpzeydLBVP+9ktFBuQuV1NErTpyDAl9xuvWGZuopiwkVZY797glB9X9GSHPmumHtHAP6c0aKMWd2adxaDg1uDxEfYhgSGq7zmQVIwE6qtcOvw+vOzihgGGMfyAgJ5+ZwJodsFo4ISfadKh/qCrRz784QtHkueT+24oGKcPZtDIMjMC/Luux294LVnNb6IzFw98ETN+WZ1SfRPOezsd3fDOoHzAHYgzaBSTWz0LeiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(8936002)(956004)(110136005)(83380400001)(66946007)(4326008)(9686003)(66556008)(55016002)(7696005)(66476007)(5660300002)(316002)(8676002)(16526019)(1076003)(6506007)(86362001)(2906002)(478600001)(4744005)(26005)(52116002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bvqrJ+0yXlkGjly1DTMQAns0/1MFSjuurwBTGW6u1FR23cvnYYVt/cJeMQFv?=
 =?us-ascii?Q?I/kAq5Myyb3pCq/+2wPeim+Z2mFCEwlRVjGhuHrwp3czUR8HQRgAlBz7i/T4?=
 =?us-ascii?Q?+WUiI4+zC3uUEAINktLDMs2Pd+heX0d3Xl6DIVrsJzTFaO5aK2hE+Hdx6DEJ?=
 =?us-ascii?Q?WCZ2zkiODmtPR40UVk1p0fxlE0S7cZ9pLJEZY82xZv1fyZkuxPmPg4L/fPew?=
 =?us-ascii?Q?lUVbVNvWOfLXJ4EXNGfStDJhSltwTf2chfECoiXqSit1cSBsf+E3vdH0G0oL?=
 =?us-ascii?Q?czEJvQEEQFYIoBJgz6CsAdgZgZqUkM5acqzs15rInprOBJZVEzYKM5hyKPNa?=
 =?us-ascii?Q?p+SIUB+nAj9ku9qi8GJH899zvpcK8Z00R/o0aQ8OVoE8gviL5Tlovvz0zJ2G?=
 =?us-ascii?Q?VRUMylv93H5tZbUQLVlDAgTRphOrKtWIYiw5spA/dQG0vDp76xdlldSFq+FP?=
 =?us-ascii?Q?5rWabXEzoRYE8Dewiq72wt4LDrXEvHMRAqDfigytYJ14D3fsbOsqZMYn1pJb?=
 =?us-ascii?Q?VdqEq5ZtkJFc8y1nfPpVxMugRMl3grhgZ1V/gzUpKRqw+LzRXJPi25Qb8sZF?=
 =?us-ascii?Q?qoSMs2VaOSxqYNoH9cWWXuSIucxB4QqzbLi3IPZE0Z34O+ljTNEn/m4q3HKd?=
 =?us-ascii?Q?nJozCXes4vDPPvik6toFMM0a8HHAzeFweaw0mHfSf4FVx1mHrI0R7FKy8ENx?=
 =?us-ascii?Q?uELzsQOnGUcMelyl246QQhUM2oSWFz6hjwD6MWaNDwLxw6MF4BjtasSkpgB1?=
 =?us-ascii?Q?LtOwrhhN94VUbwsCI0mb7t577+0Ap2AwEpgNbdU27Q7VuZZeRKXJqkbJ8E3i?=
 =?us-ascii?Q?jlfUEUbN944xYSRuOAnTfruZqllzqRE4XjO8cuGWWEVIQbGsinCLumW5Trca?=
 =?us-ascii?Q?BFgJehwTCL59+xIynQi4MjOeabJaC+CQksohmPICmWRCqe/od5hTToqs2F9q?=
 =?us-ascii?Q?R0YW5h7Kd+icZhMhzORnkUy5ha/W3j9ony0TfccCYbD2XWePdOznXOmlLdpm?=
 =?us-ascii?Q?eldhesulbc/hgC+Of1Ya12Rrt2o9wlJAjd3dSd81mUnYfPczEhp1R6i+qyQr?=
 =?us-ascii?Q?HEYP90DL?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d330cb6-623d-44e2-d377-08d8c358180b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 06:44:00.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMytBXPITxLkCZfFYi96LtXFPgE06wKWqYjzJU8d+B/3haXyOuXfzvmRZn5IfVMyKCmqqh+y6r6LUvjDTbECIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2563
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have removed the dw_pcie_ops always exists assumption in dwc
core driver, we can remove the useless dw_pcie_ops now.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Jonathan Chocron <jonnyc@amazon.com>
---
 drivers/pci/controller/dwc/pcie-al.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index abf37aa68e51..e8afa50129a8 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -314,9 +314,6 @@ static const struct dw_pcie_host_ops al_pcie_host_ops = {
 	.host_init = al_pcie_host_init,
 };
 
-static const struct dw_pcie_ops dw_pcie_ops = {
-};
-
 static int al_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -334,7 +331,6 @@ static int al_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 	pci->pp.ops = &al_pcie_host_ops;
 
 	al_pcie->pci = pci;
-- 
2.30.0

