Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625F1B6DA7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXF7X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 01:59:23 -0400
Received: from mail-eopbgr1400134.outbound.protection.outlook.com ([40.107.140.134]:28032
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbgDXF7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 01:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDT+/q9L1FhYffozgcBVGx2H6QSyATBnRLNiQAPMxVOcQEcvwmMut8R7jJXPt01p1Q2OpLQ5+ORnzaa7AjHzDpBQjJnxWAEdlWvhNJnvx70SbecZ6w9LpV+ePPZbetGrWzx1rtFiAgukSy+11hcCUCHNYO5nn6uTfr4aGs+RYALgZ5ndbUqWtF9A6EOffL5Sm4zgMjtrGZE3uTcqEpNqUTt2rdlKjW/XgBqrNpv1QzIw7+nNDAUzboDfaMqYNZ4gNwwl5X1VFeJHzzbzGteLtTRVv1cnt1j7NdQhzSQcIurCUQ+ZRLjKcm336XdTC/bC4vEnzq/KPpRiNQWuBmt3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZZxxa6immi4mv/IvUWenKq/ezACII7CJDUmxA63oaA=;
 b=nmS7lshE88Dz4Li3ZJ8ON1dEbpJFzAxnIUYvGMATeRf4auMu5FHvOlQXIEgT3+BiFz+SWLJnKgXSCtHiqJBAW/dLJ4fRdR3Uj+xz01F5HvtYJbGoiYiR1Co7nS0+ZFze7Y/xMVZXYFU7ulxVx21iDu78aidln2lYH8YEtBuQ2FdyV/5OS2WbEuAJHuVvhWOJzKLn+0fcG7Kne0bTBcnqQ6SVtiMYuCqZXztsj/7CY5VAlYgOZjbAR4FBmkflPQ+jmSsTv219iZalegzC27dRXPM71P/bXCfJqzQ7W6xYeBLFuPIrlJXkenwljPFRMFy5ZCBxAiXw+59BdOUctk+/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZZxxa6immi4mv/IvUWenKq/ezACII7CJDUmxA63oaA=;
 b=Oa+Us3dhOeKnzjz682JMc/9ZAPZkpBdVoah/mP+DmWw6Wx0A+v0VfqjMl2l/hIQJFdsCn7QQ8oBwMDOm/xdZG1bd7ftSXDvnpvyFvYe4+M3cPUrU1g65SBniMa2ritwKhnXV2B3G8D3fej5CZSLy9FXQCSlVI0uycfOJODuTdeQ=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB5340.jpnprd01.prod.outlook.com (20.180.231.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27; Fri, 24 Apr 2020 05:59:19 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 05:59:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v9 4/8] PCI: endpoint: Pass page size as argument to
 pci_epc_mem_init()
Thread-Topic: [PATCH v9 4/8] PCI: endpoint: Pass page size as argument to
 pci_epc_mem_init()
Thread-Index: AQHWGZzBHIsfM0fVvE+5ZLsD6I1PCaiHx42A
Date:   Fri, 24 Apr 2020 05:59:19 +0000
Message-ID: <TYAPR01MB4544F40FDAFF814BCDAD8FEBD8D00@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1587666159-6035-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587666159-6035-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587666159-6035-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4882f41-de69-4de0-03b0-08d7e814a142
x-ms-traffictypediagnostic: TYAPR01MB5340:|TYAPR01MB5340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5340FDBBE6205F0D8F1970CFD8D00@TYAPR01MB5340.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(66446008)(7696005)(7416002)(71200400001)(26005)(316002)(8936002)(4744005)(478600001)(6506007)(52536014)(2906002)(81156014)(186003)(8676002)(55236004)(9686003)(5660300002)(4326008)(55016002)(110136005)(33656002)(54906003)(66946007)(76116006)(66556008)(64756008)(107886003)(86362001)(66476007)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tZc1aA8DG6BeRgYcddR6rZ+UHaAoG+pmkuPjGImNE1LMhNWNS4jDdq+NugtKb9Ebx3BhD1qPp/Qr/UP1j0UsFnxLPnlG/VVu0GR2rw5t41XE2HUqNvhMFmTldV/c738ReqPPPMhwK4RE1+z3IklTL0OR6BwEPm9qkYcB8MAZcqut13vxYDmSsQFNnBIoz4VwZGZJJku/UpeTDFb9M4cI0NpLs6SRk1sD6geMg7tufNf8OXH3oOfdvs/A3JYR9jLO/kFZA/5sshJD0Pg0MwowQK/yRqfgY4Hdjg0GqfK94uLUhZFltwSyhjEbFB9pvHFT0sHSUlT6ypNvrkAq9/YDR2apnvzjEZXM4WBxJ1V40KPZmYlbtucJ0/+RK1sVyXma3uCMLqNU7VhmQxTYdNzVLcBAGVYjh2XPYHNXXJIvqoHisKsuWd7xYpOrdEisSfIS1f+Aw5b6Lu5O5rW43nUP3MSZhihsWj4+aLohvo1Pmys=
x-ms-exchange-antispam-messagedata: LMGV+15cOCN2e56Guxk928fNiV/KpNaKt85Bq5bukKAgjlXa6iJOUJ3ynkJsnN06bfrgswjTgnM33IuVn0rsoLftdFHANYo3PArZghvz13/dSprMyXRLPec/rBQ9kKTjQVGUPFh/2YSapn7POI/fpA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4882f41-de69-4de0-03b0-08d7e814a142
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 05:59:19.6483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMSUow1EIBztTrdZBjiKkzX1vpBYs2hLSGYxLfRhIt6jH6axJHdR60316S8c85erpgQ1lE0K9PpDoMMBCXm/snHu3uBKgquKVS9uvAgzmimisY5SqPykGU+n8OnZaaCw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5340
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar-san,

> From: Lad Prabhakar, Sent: Friday, April 24, 2020 3:23 AM
>=20
> pci_epc_mem_init() internally used page size equal to *PAGE_SIZE* to
> manage the address space so instead just pass the page size as a
> argument to pci_epc_mem_init().
>=20
> Also make pci_epc_mem_init() as a C function instead of a macro function
> in preparation for adding support for pci-epc-mem core to handle multiple
> windows.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

