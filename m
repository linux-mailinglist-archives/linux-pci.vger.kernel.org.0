Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE9F442623
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 04:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhKBDrm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 23:47:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:50412 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232122AbhKBDrl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 23:47:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="317376799"
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="317376799"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 20:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,201,1631602800"; 
   d="scan'208";a="727921437"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 01 Nov 2021 20:45:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 1 Nov 2021 20:45:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 1 Nov 2021 20:45:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 1 Nov 2021 20:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R20FDPs6LbNFWH+bptMxSlnYcZwRxgQoVEUIGkv2YkR69TwQf7/B7UPC5fA+Pbz9j4CqePHS1i4otvcc0OzFv99H9WNBtBBKTOjGlT0rnEeC7tEmxtxQGEyRvSDjxsqpC347Dq/CAS4b5RUjhLfj8kiC/tx5f02vE31F/1nDmcXz2SMIMWqkfbu9Klw/tW4TWVjHcaK/2J38xGrSl5yVhv9wFaSsi1tW1ZMj3m5vkw5qhFGR/Hmwem1u9sPIX8lsJwPUS4TmSTXkHGtA0eti0U/OD6BDDos+TyHEjfBJidxTuOyKAIAi4qUzd/XuOmUAvgwvW2F3VCH3KlpwCzIS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wg5vSMit00Cu9fGhr8IM9UfZEPqz4XC4zjTz5hwwCUY=;
 b=SrPMobm3Xp06yp3EvvkpS5vRgLN0CWdt5QeRNJDdu1tzDiei78pZtYfYUtelekFgbpkrzedfLQJ0R26/tW0QfSXQujN7aGQaw3T1+kesZJOut2MqNL3IAJ3kRqhI3qfxXx18qesxA1UbE+TkfynKeWuFioVYUD+FjRlSOLxA9ihFHr8eR6lZgiJG7IjUjxdvo4aigrhw07aA4RRZQvIFZyGUbAkiHQ/DlN6+ubEx+DR2InpxkN4CChRYTj7tjKu0eMdyssWxc02FplGDGUQ0y/bJsV44y2NXd66VHelUuu2YaEtUWovC6SJEfUR/St0cVwfhGwiMizq0uAa1MPkqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wg5vSMit00Cu9fGhr8IM9UfZEPqz4XC4zjTz5hwwCUY=;
 b=yvJD23KARyxxN94atgkFjSpUfXfD1UCGOu1SWUabK4aBpAAkGRNTrT497NbaWoOlnKXsV1WyXe5bhP/UfR8QeCeTARJl4siSbrWKq+jcbJ8pwrHS7p7x6OFwy9Rn7gnL9imDb3rUr9ZyOQ92YI+a9Wotd1w+UOjdbiPkobmboUw=
Received: from DM8PR11MB5702.namprd11.prod.outlook.com (2603:10b6:8:21::10) by
 DM6PR11MB3548.namprd11.prod.outlook.com (2603:10b6:5:143::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Tue, 2 Nov 2021 03:45:00 +0000
Received: from DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::fd7c:d68:3904:f2b3]) by DM8PR11MB5702.namprd11.prod.outlook.com
 ([fe80::fd7c:d68:3904:f2b3%9]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 03:45:00 +0000
From:   "Bao, Joseph" <joseph.bao@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: HW power fault defect cause system hang on kernel 5.4.y
Thread-Topic: HW power fault defect cause system hang on kernel 5.4.y
Thread-Index: AdfPm0b60GGT2vlORua28HBxsdiYnQ==
Date:   Tue, 2 Nov 2021 03:45:00 +0000
Message-ID: <DM8PR11MB5702255A6A92F735D90A4446868B9@DM8PR11MB5702.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b17a209-b130-4f2e-903a-08d99db32562
x-ms-traffictypediagnostic: DM6PR11MB3548:
x-microsoft-antispam-prvs: <DM6PR11MB3548CB8370DFEC9C04C399EA868B9@DM6PR11MB3548.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfBndFL3XrWTf5ytt0enJqjdvoVIbD687NiERVQb5ekVQS80s4UwoFL7IoYUKlshiOweaQTQ/+h/ANfdR1wglhchMic0nrFi6j680tSlu1LgouwFv3Y6lvmXw2AoBYsmU0apInXmlW+Wh7DMUaBuj91+KnBxK5Ys8//dqJnd1AE2NvUrEJCW6ALE+aYTbQQvvfEqCnW+3RSqorAkOvZAcPsKyUrQjxM8xXDB6/I9hPKnJ9NthPAy4EJ7+K1Pt8Gx19LimmxMWvWmBZC6pcBAGy//FcMQELKM5wK0yLhZaA5ZdYTmkvXnboxhk/lS6kD555yi7FEQh0VVQecUeJW/IsepcVmSXQEMnK4lIno8snpcIbcDdX4oflBwwt9KREo4PKCJcuwMMMj7JBVO1tKxdrk58kmta0gJ9EoHucjvqR5+cE3Kq6hFuyFdQhg2IR7XOBS1qNvn8HpUdECvtDuAbszV0xa4HVMC1FHMBk9kzqD34O529tWq+V6OCBoGmhslf4mPJyXjEWzZjkJIwTOnOt1StVTDQEn2mD5KSf/ebRusvYKc1n2oMSBX6m93IoE6ytDoQbjtp0a1l1DjG27o/2eTqyyDxWcY1OsdI0T2+I5qANTQQ4mTjd9FYcD7firvmEnnVdIdkqoyMsPed4Rmp7T3akk8aNc35W73JgKvZ7nRTOFGLCIMFJ9eRby3NNbAh/I4EEckA/7zLaatUporJCXygJWlScyUAx3vNnaoJzpU7VnC8BXzqDb/tg72MFUxsysyUCAgaRGzHYbsvlS4IZg34d8K1wra3H6z506Nc74r62uqLJqmqu3zPdzTRzzvkYqTavn1394a99HX6REV4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5702.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66476007)(76116006)(38100700002)(110136005)(66946007)(82960400001)(33656002)(122000001)(186003)(5660300002)(7696005)(2906002)(6506007)(55016002)(66556008)(83380400001)(64756008)(316002)(52536014)(38070700005)(66446008)(966005)(26005)(71200400001)(8676002)(86362001)(508600001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/VCg1Nu6OxGcFrAvv1CtcOyLtdndg/PgxmlnUA5VUE+HOWZKUo8CojMnn38d?=
 =?us-ascii?Q?QMfpwIP3HZ7b9ERSO9/x5EfhCDdVttLsuEg14pqEXJVdNONVRZ+4+j25xbY7?=
 =?us-ascii?Q?jNOHTxaNtuw88NUgfr7FhjPTXjSM/FPBbAe87tiQgpO/V5ykqknKeZ6E9IFM?=
 =?us-ascii?Q?cJghXEA5buzcb+x08CjO+r/H9AKTjVuowBWJ+/h6XULut0uHOK/63WWDM9hA?=
 =?us-ascii?Q?cFgelDb/OqekOpLJ3PG6qIdMzm0C8lfqTqFsqySY8R3dMKaSL0okF+yhZUnb?=
 =?us-ascii?Q?DmwyVflIZf+554BG8HmTW1trJKGx8do0Pcm9358uRbC8V8VdKsqERaUmdqAE?=
 =?us-ascii?Q?BRaHhuqj+3qnl0mgVG33bAZtfq6z4o3hfrPJLSlMOlvhRsFIub3Udwyb/+X8?=
 =?us-ascii?Q?bV9vhYGAxTU/iDNxc+PrVsDVX+MqV+H/4X7Y+H6prM14mFIf82F5pyhhRlsz?=
 =?us-ascii?Q?CsZ9ox9EocW7//3xIyzLjv8E7MNJisl3DW5ZUnyVzVqGEc5YQH9IuPDQa/Dr?=
 =?us-ascii?Q?H/D0Hb66sKAPdjYbJZIi0gSDRL0+ewToAJoucPt7Qa1W1aCcDAjNWTxW1mT0?=
 =?us-ascii?Q?st3bc1KgsRPrcxv6RyhvdPLEV/4QQLBSvtfgHO0k1BHm/efvV2j0laD9lgkB?=
 =?us-ascii?Q?jHAQtBoXjKl/YbY3vuUoFgnTHRAQq+QHgle7UTsCsc39COIqZMtSJozPS/cr?=
 =?us-ascii?Q?w/OSoExIyiOvK+ywNvqor3Qp1lCTkR6FxQRAqlCkS4ZXjQapGYaTZD+4EvjR?=
 =?us-ascii?Q?G724+BZzOQqNRPgZ01IHNZAbo5hKvYkh+n31+2u/XhdMnzcyYsULgbRIPnV2?=
 =?us-ascii?Q?oEtVCuco6eZ84gIplKjrqMWs/CWtmkF8EX+iNb5i/2ZUqzXf7GdufESvYGf3?=
 =?us-ascii?Q?G1U2jgkoQh6WLtuBmc38KoF/LFTZHPJJqSr6rSpsNNqIaE4GAOZya6n7nItq?=
 =?us-ascii?Q?NQckc4oEv1oSTU0t8vvbCh7a1JER2VbfeoHp5U20+wXbWnZ0PZQifNA6voHd?=
 =?us-ascii?Q?Ncr/e9jhfCfmNU+wxMkUe3ZFqMa3wqFRBcFNtmIjnPLREqT+zeKDjemJkw77?=
 =?us-ascii?Q?oz3YgrXC+Y1M45MmngQgGiziMkV+MTJWONp2EhQ4UHtuxgilibm3XP3RdlBa?=
 =?us-ascii?Q?7ek1Ly+KeXGCtklhvHyQOFHLOPc4qOVPwXXWp5GX6NGK20dThkE9+dNMjsFh?=
 =?us-ascii?Q?M6DvGPPcuABfF3RDUP08vD9p6cR900SWH6IaFvApzn+1qGU1yIUnbIhthSJl?=
 =?us-ascii?Q?diOeANTpT9Ih8f4GtsUh6N9gOWaAyIWjd/4wWGv+OAlMRmNuXSqNvX7i/KkY?=
 =?us-ascii?Q?MTzIU1CmDjdCUEnN8wOVmK8PS94ZqCIshnogiBLSBX7AEYReNx+A+Q1Yx9Oc?=
 =?us-ascii?Q?JfZvVwu2/HfuMBP7t5OaU0FkpHklkohGo6852kdLOOekkY+iEcnn8HLs2p+8?=
 =?us-ascii?Q?Y5bNvzGYxfTCbr5k922If784S2Miqo8hfW4duWTdyFdVWhI9hl7BX2mhPXLG?=
 =?us-ascii?Q?HmgQZed0trShcbWRaE2NsemFa/oP0gxOUgbz3in7pI+6XPJhmrHHONTgZLty?=
 =?us-ascii?Q?4BJob88sImf9fvSm6xdI8aPSLFa6LeyohwwNDfXtRJ3U95nTtbrimuh8cVZ7?=
 =?us-ascii?Q?W7n8bjGquafiFp3rVsfJkrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5702.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b17a209-b130-4f2e-903a-08d99db32562
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 03:45:00.0523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3KxYcdGdMrtuuI8D5YRCaq0aOIbt1OKby0WHdC5YV/ev67r3p8bl3SigMgyhEpv1/To25RYKCV9t7hI19OPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3548
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, dear kernel developer,

Recently we encounter system hang (dead spinlock) when move to kernel linux=
-5.4.y.=20

Finally, we use bisect to locate the suspicious commit https://git.kernel.o=
rg/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=3Dlinux-5.4.y&id=3D4=
667358dab9cc07da044d5bc087065545b1000df.

Our system has some HW defect, which will wrongly set PCI_EXP_SLTSTA_PFD hi=
gh, and this commit will lead to infinite loop jumping to read_status (no c=
hance to clear status PCI_EXP_SLTSTA_PFD bit since ctrl is not updated), I =
know this is our HW defect, but this commit makes kernel trapped in this is=
r function and leads to kernel hang (then the user could not get useful inf=
ormation to show what's wrong), which I think is not expected behavior, so =
I would like to report to you for discussion.

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_=
hpc.c
index 356786a3b7f4b..88b996764ff95 100644
--- a/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/drivers/pci/hotplug/pciehp_hpc.c?h=3Dlinux-5.4.y&id=3Dca767cf0152d18fc299c=
de85b18d1f46ac21e1ba
+++ b/https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/drivers/pci/hotplug/pciehp_hpc.c?h=3Dlinux-5.4.y&id=3D4667358dab9cc07da044=
d5bc087065545b1000df
@@ -529,7 +529,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	struct controller *ctrl =3D (struct controller *)dev_id;
 	struct pci_dev *pdev =3D ctrl_dev(ctrl);
 	struct device *parent =3D pdev->dev.parent;
-	u16 status, events;
+	u16 status, events =3D 0;
=20
 	/*
 	 * Interrupts only occur in D3hot or shallower and only if enabled
@@ -554,6 +554,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		}
 	}
=20
+read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
 	if (status =3D=3D (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
@@ -566,24 +567,37 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * Slot Status contains plain status bits as well as event
 	 * notification bits; right now we only want the event bits.
 	 */
-	events =3D status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
-			   PCI_EXP_SLTSTA_DLLSC);
+	status &=3D PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
+		  PCI_EXP_SLTSTA_DLLSC;
=20
 	/*
 	 * If we've already reported a power fault, don't report it again
 	 * until we've done something to handle it.
 	 */
 	if (ctrl->power_fault_detected)
-		events &=3D ~PCI_EXP_SLTSTA_PFD;
+		status &=3D ~PCI_EXP_SLTSTA_PFD;
=20
+	events |=3D status;
 	if (!events) {
 		if (parent)
 			pm_runtime_put(parent);
 		return IRQ_NONE;
 	}
=20
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+	if (status) {
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+
+		/*
+		 * In MSI mode, all event bits must be zero before the port
+		 * will send a new interrupt (PCIe Base Spec r5.0 sec 6.7.3.4).
+		 * So re-read the Slot Status register in case a bit was set
+		 * between read and write.
+		 */
+		if (pci_dev_msi_enabled(pdev) && !pciehp_poll_mode)
+			goto read_status;
+	}
+
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 	if (parent)
 		pm_runtime_put(parent);


Regards
Joseph

