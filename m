Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B027DDA0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 03:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgI3BQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 21:16:44 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:41185
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728931AbgI3BQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 21:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSei3e70z/SC7UdcBPu5bTBQ9j092kXgM6BNibrNqIM40GFwzhT/ffISGvOLvriueBRV8rS30p+UlvpSBclPr/sQ/LalnRKEwS+hDEUDAlAho02wiYGTVP8dGmKmk7awB7CLvy+YPiOaoAVebUzc2qOUThl7lzaUcYhjuIkluAD4r4fINpsJkohteaR+/09v8UvzCNuPouXTwXE/kZGyZlIkRHKkSAyKsrW+d+KeLEgEsviGwfqy+W6pD65SBWvG0uiECeiEVg9JvWOwAS/O223yVoEsHT3/F3ndWCNgtUeS1uIKXiGN0qHjaRwN6TBcU0ebgWCSlK0FzP1n4LOMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ1mg79nd2coqgMKTnUBB7fmiA8/KnEIFzlWy2mhIWQ=;
 b=Re0Z5WTi2fZAlXiWRdLuR+pFuo5yWH3jdL+nGYuU+uKeu6JqI0vZHm42I2iXWedCRizRMQydCeKIMKUaRf5QeX1/54tDZ4PtE3V4Rh39bsj3q25NYYcLqjbauaTxR6PEHGK/B/uWBcWrb/qUpEbmcgS0oWHaUqrf3T1hAGkFGMlQVzosAzGKPHEo7qILGZV4EXvdwApKXVu/fVpKjSBAl4f8vgZt4lPELVzRwZDrf2lEt6aiDjmck46B5AV80s42qkQRwFxvvRQ7WKCnouLEjR9yRLZQmrm8Hw+mfpU95antOJWrobrpiaXIytyFiZEa2iYMAAvWEFhTBNRrO6tr4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ1mg79nd2coqgMKTnUBB7fmiA8/KnEIFzlWy2mhIWQ=;
 b=PT27d+LEUM1T9qqjnp2Y66q0/xt54YL9sG8TNc1hDRAiGioK7VfqRansLecWV+X2zpU3uIv28fgwupA2X18RoaJAThMViioYaz3qmWQ0xhGCKqWVl4k6+6BptBBV2+bI5A+TtX+yKtz0h45Gnvmnt6OAsZ/VflucDTnIet1Cis8=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5145.namprd03.prod.outlook.com (2603:10b6:5:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 01:16:40 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 01:16:40 +0000
Date:   Wed, 30 Sep 2020 09:12:05 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20200930091205.792d6c7c@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18 via Frontend Transport; Wed, 30 Sep 2020 01:16:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892c29ee-563a-4ff2-3f40-08d864de7c53
X-MS-TrafficTypeDiagnostic: DM6PR03MB5145:
X-Microsoft-Antispam-PRVS: <DM6PR03MB514550FA133BFC3F6C4EC766ED330@DM6PR03MB5145.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IS9N0I/16SHJUF3RN+AS0OIJoJAnyis8mdBVB+kvzbZM+PybQmFn7bT7k3kPLbdbHFD/0OkwyQdSm+zemjk6gklziUgBWcwc5U04zRK6N8d5VUFx2vOFoP8sZwNKlE2LmUmDyyCEqbMm4M0K0hTvtuOE615oNgMP5/k8JNIFbXZUgX3IS0gbG+xkXGDIKcWE23PwR4YylPOZPs1zIUcQA9OfD8l+dtJ9qdhYE7ORe8ye7tTHcswkCMJ5cSW9GfAHW+Z3zAVs/wh7iKBp33wOiOeyY2FgqrjgOJbm8dimx8Efq2m/P8Wb9Z6HG1dJGlbsiYC5ZmZBHNZzfuE/L5jlqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(956004)(55016002)(5660300002)(6666004)(8676002)(498600001)(4326008)(8936002)(83380400001)(110136005)(66946007)(66556008)(66476007)(86362001)(1076003)(7416002)(186003)(7696005)(9686003)(2906002)(16526019)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d8HFMUcbO6XojAUV5tw3iAQEK9J4oTerlldNMyXS4cMObuAVYqrt2t2DpQRlW412p0TX/KUm1Nc6BkaytoGjzRLzAxicQQpE8q6zK6aORpsock5Pjf4yg6evTFUqKgOU7UsFQ2ihBWHNMaQL1OQuhC7JYD7ZA2NWwl2hh57YE9uFDMIqRQ+iAFh4ocn+NrixwsfB8sHZHCqVG57PknPt1HlSgo/B1tHJYIU1Q49zEgmD2JxMQ5LhUv2aAtB0ij8ZtPZKrekYMn64f+N9mfJtjwwku6XvFNSe8JTjtF7kgNv2F34lZk9EavGACexCRU07CWvaezZGCXwsjl0zfOZdGw3/apnb6S3AlK0VJ4kA7nI3Vn216EV9M+zGAgwqqfMiSZRDtCvUKGyWvg0rSKA2KKpBazqj3/N/ck1prIWmmqmh3OZfeDlI8ta5VZKVTxZXvvm1n31x7VKvFyRp7Uzo4J3YIiPUERCizD9gaux6xj8O/t5fLdEya90M9DhAJnVRHNKAwHn7rSKDfzfo69GH4IdusXM/mG/6B+8dSpy9yFgQ0RMcFUiRr1XINMxI8yeqq8gm23oRXa2TUbIFCpEKM1xTfaweCbkOtAE2ThYO7WWwRmlxZMH1Vo1sW3qZ8Gwwr5GURMGw2YHf7+Td1leNYQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892c29ee-563a-4ff2-3f40-08d864de7c53
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 01:16:40.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAjP/Px5EBvV4AdRVuaRSk5UG89Lt8cwJud+6zYg043J9XGPDVsbLDBiN5cEGcD4MYmI7B/aXGWzG+lxU5RvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5145
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming if MSI is
disabled, another to use an address in the driver data for MSI address,
to fix the MSI page leakage during suspend/resume.

Since v4:
  - fix pci-dra7xx.c

Since v3:
  - add Acked-by tag
  - change patch2 commit msg to make it clear
  - map the MSI msg with dma_map_single_attrs() for some platforms
    which either has seperate addrs for dma and phy or has mem access
    limitation for the PCIe.

Since v2:
  - add Acked-by tag
  - use an address in the driver data for MSI address. Thank Ard and Rob
    for pointing out this correct direction.
  - Since the MSI page has gone, the leak issue doesn't exist anymore,
    remove unnecessary patches.
  - Remove dw_pcie_free_msi rename and the last patch. They could be
    targeted to next. So will send out patches in a separate series.

Since v1:
  - add proper error handling patches.
  - solve the msi page leakage by moving dw_pcie_msi_init() from each
    users to designware host


Jisheng Zhang (2):
  PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
  PCI: dwc: Fix MSI page leakage in suspend/resume

 drivers/pci/controller/dwc/pci-dra7xx.c       | 18 +++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.28.0

