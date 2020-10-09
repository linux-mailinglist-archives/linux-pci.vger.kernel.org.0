Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5ED228834B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgJIHLX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 03:11:23 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com ([40.107.244.56]:24065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgJIHLX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 03:11:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3aslKBkO05TzhlV1SbhfW9jPvmmPW5P8Z2ulv6gh3bMRWAKCqhO842u4834W/naQjr7trOdhtlL0/eUNi/7ykCM7zShSRHqaNN2Ce0Ml7F/oQD5UR+0jPx08D1mGoPvs7x4VQOoOnC3MmLuflX8+VpKhXTDePtjRWS8UdwijwS/fo8nqzisUHSSjl5F30r5s7LcSDRCleHr9B0CJ9EqvlLWZdfc1ytUxDQ/gcTW5CQs7AIc9K1/QEB9Spsegy9Mt56v7xZlGCv03ghdZ+xnijAgalxDFx6qmJhL/qZvDDYiz49n20Zplg0P5eTW4+K1zV3RDgSgQhFZfeUfGPUbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyQq/YTxFtswYbloVZLQpJI86ujnpork1c5A81ajv5o=;
 b=fryP9KlrAqAuAhxdoK9iZQ13R7FQsZPJZNefqjVrFEbERwB2Jt2QHUe4fGDI5qowbQgeu3cBGxk68hi0HGLsqWOQBCOadSHV/Qz5nDeBVw3vmKYvVLvpzr2YM5nXQwbQVJ4hyMzWgN/TzvhGMGqkwyxjBJSLsdFk93BIIP0+FxBhhONfR2pZreXHGf9iviljyCNWqqAs8tYqSvvVmAJWpSQwvsqHDL0Z9kZ7lyyG8YfkywVckfK3kaN3GEPdVUFXDIAX461FoT/wBOZTvMnM8hi9EcyobSMwYeIPL+FFY/+bdRj4kFPAIzXuuoAdXbH+5cmWcwG9/e60qT79726iwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyQq/YTxFtswYbloVZLQpJI86ujnpork1c5A81ajv5o=;
 b=XCfGjND2CEr2nw5WrnRn3nh2Kr4wL5wlhPdSyFmS/oBdidZMCFa91DTJTH0O57sILKbCQe73CjAZrpD4TqJ97NsuCzo8pInkQ1YhZ/bMY9yVl2p/b/hQPVQqWHXW6PGw9kuelKLYMckaHHDjOe1jBLDYRMWfFbolRVUYpFgfS+Q=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB3995.namprd03.prod.outlook.com (2603:10b6:5:8::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Fri, 9 Oct 2020 07:11:20 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 07:11:20 +0000
Date:   Fri, 9 Oct 2020 15:10:06 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20201009151006.38b3811b@xhacker.debian>
In-Reply-To: <20201008113614.GA1226@e121166-lin.cambridge.arm.com>
References: <20200930091205.792d6c7c@xhacker.debian>
        <20201008113614.GA1226@e121166-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:404:42::34) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:404:42::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 07:11:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb01eb6-5be2-46d8-ec08-08d86c2285bd
X-MS-TrafficTypeDiagnostic: DM6PR03MB3995:
X-Microsoft-Antispam-PRVS: <DM6PR03MB399531CBE38F922BF84B6339ED080@DM6PR03MB3995.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Id0ICP0wgNFnAz/UOtPh2FtdLqZ7L4oMJ522zXw/X73LTupbbTHe+Q6Oo9I4DVBiM6QnHMPrfzTUEp1LkAPXQglKJ59yONj7+ySXO4po/UPetIhx/8BrOhV24FbNycn/KPwnJUj75Zep/0BWcJf/uRt/YXWF7H0xjLPPX9GotI8RXGEw/MUznokFHJeH3ZrN/oFCg3/Y2kRHi7l2MxPot5jPrxLWQt8+2c6zpHEBVX6XpJcKh/vy9G9nOAVagL1i0PjIG9q0wPZGO/a1RYZo+nrrHtSsOd5AuCaKH/ebWaigXkjH8ZWBcQAAnvwChmEJpJZzZF3/s6j2RO92otWnaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(8676002)(7696005)(8936002)(6666004)(1076003)(2906002)(86362001)(6506007)(4326008)(66476007)(66946007)(478600001)(66556008)(9686003)(55016002)(6916009)(16526019)(186003)(52116002)(7416002)(316002)(5660300002)(956004)(26005)(83380400001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: f0RxDefU5zkD6g0AscrulYFPaQPX+I6QVUlIH4PbDFVKnbe8TDT1ACsNPuqx6dz6Q5z9JVe2JUpYEWsgCr8hHKH2ogFf4DHs71pcR5akggfPSbArLei86CGmDSvQ0fkKPg0JbvagSu17YezWG6kTSfMNOQ6alWoDt+KrHTCCopO5qvLxDU/zqyCcIkIKN2BtBucAvNA47OwnYCDkORjZ3wrZadIZ1y3BhlZ+CckNuJgYY9zNGfQbOeTwNWQu3FSoorj8k0dhWEOr+zwbl8SBGBRuBd4jl6vXq+s7Q7WceZSZfvi6r9PiZshPaffJA04aB8gjLLHQDcHb/o7VC9hAM9XUYVY4PU29rTQzh9jKxBNZ/gksyfl2mFnk35r2VJoMgGBcjgvkNWlQfkNzNDLIxNZ82Kg/kmogxHZAhNr8tmNhvMLA7Oo1gwSnq3xMKw5mTyjkRZrW2wguRHZP1Pr3CRQHABBAjw4yhDCKPqiJVsvx/d1/7ONiThOi9rC4HZLQYLl0h9XJ1dPx7/Hi9GykK510cCKwDNsVwoURS1wSCmPIZlz9aW7NuAMsQRLeMqqYWjnhB+IIaix6FdePas4P22kBvyok6L3wEzkUQz1vfqix+hnlXcgk8Ul0KHT4UFr0JSzX4StOBYj2cSAL8a3Bvg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb01eb6-5be2-46d8-ec08-08d86c2285bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 07:11:20.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AizmQlaAINyJ5vm5Nu7RLJNz6rSKD5s4FqSUmEq0pr3Edt2h3cU+K3YgTi/u6RwezPSWY/FuIz9cPAg91F+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3995
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Oct 2020 12:36:14 +0100 Lorenzo Pieralisi wrote:

> 
> On Wed, Sep 30, 2020 at 09:12:05AM +0800, Jisheng Zhang wrote:
> > Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming if MSI is
> > disabled, another to use an address in the driver data for MSI address,
> > to fix the MSI page leakage during suspend/resume.
> >
> > Since v4:
> >   - fix pci-dra7xx.c
> >
> > Since v3:
> >   - add Acked-by tag
> >   - change patch2 commit msg to make it clear
> >   - map the MSI msg with dma_map_single_attrs() for some platforms
> >     which either has seperate addrs for dma and phy or has mem access
> >     limitation for the PCIe.
> >
> > Since v2:
> >   - add Acked-by tag
> >   - use an address in the driver data for MSI address. Thank Ard and Rob
> >     for pointing out this correct direction.
> >   - Since the MSI page has gone, the leak issue doesn't exist anymore,
> >     remove unnecessary patches.
> >   - Remove dw_pcie_free_msi rename and the last patch. They could be
> >     targeted to next. So will send out patches in a separate series.
> >
> > Since v1:
> >   - add proper error handling patches.
> >   - solve the msi page leakage by moving dw_pcie_msi_init() from each
> >     users to designware host
> >
> >
> > Jisheng Zhang (2):
> >   PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
> >   PCI: dwc: Fix MSI page leakage in suspend/resume
> >
> >  drivers/pci/controller/dwc/pci-dra7xx.c       | 18 +++++++++-
> >  .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++----------
> >  drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
> >  3 files changed, 35 insertions(+), 19 deletions(-)  
> 
> Hi,
> 
> can you rebase this series against my pci/dwc branch please ?
> 

Done in v6.

Thanks
