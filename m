Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1151112A56B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2019 02:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLYBec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Dec 2019 20:34:32 -0500
Received: from mail-bjbon0152.outbound.protection.partner.outlook.cn ([42.159.36.152]:13574
        "EHLO cn01-BJB-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfLYBeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Dec 2019 20:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=panyiai.partner.onmschina.cn; s=selector1-panyiai-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwhscmczH9CiUwHjjIet7Qro/v8pC+1o4OFxe39v/oI=;
 b=NvtpiOpNbkXfHIadiiX5gaUCn45PKol/j8hTYpVCUu0qLNZFel5WHiq1EyOnXncaB0lzs6jeizXD0NpbPloOf4RcJzzZ1ZyoCTY6dKRF6T2obk4RTS6A9MNfBjm4xs5uLYoKri3QOE3IrnxG7LfuB/LuD/rGhice5GaPM/6nZ48=
Received: from BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn (10.43.32.81) by
 BJXPR01MB0278.CHNPR01.prod.partner.outlook.cn (10.41.52.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.20; Wed, 25 Dec 2019 01:34:26 +0000
Received: from BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn ([10.43.32.81])
 by BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn ([10.43.32.81]) with mapi id
 15.20.2559.017; Wed, 25 Dec 2019 01:34:26 +0000
From:   Renjun Wang <rwang@panyi.ai>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: PROBLEM: pci_alloc_irq_vectors function request 32 MSI interrupts
 vectors, but return 1 in KVM virtual machine.
Thread-Topic: PROBLEM: pci_alloc_irq_vectors function request 32 MSI
 interrupts vectors, but return 1 in KVM virtual machine.
Thread-Index: AQHVusNDElPM46dTzEOgovdUi3IOYQ==
Date:   Wed, 25 Dec 2019 01:34:26 +0000
Message-ID: <BJXPR01MB053429F1D6CD8E31B55D9D80DE280@BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=rwang@panyi.ai; 
x-originating-ip: [182.150.24.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d08633a9-a670-40ec-d86f-08d788da93f8
x-ms-traffictypediagnostic: BJXPR01MB0278:
x-microsoft-antispam-prvs: <BJXPR01MB0278B563AE7D4BED78AE54A7DE280@BJXPR01MB0278.CHNPR01.prod.partner.outlook.cn>
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39830400003)(366004)(376002)(53754006)(199004)(189003)(328002)(329002)(76116006)(7736002)(66476007)(66556008)(66946007)(63696004)(7696005)(66066001)(6916009)(305945005)(55016002)(9686003)(6306002)(5640700003)(2906002)(2501003)(95416001)(6116002)(3846002)(8676002)(71190400001)(8936002)(81156014)(4744005)(71200400001)(2351001)(33656002)(64756008)(66446008)(26005)(86362001)(478600001)(102836004)(966005)(476003)(316002)(486006)(14454004)(186003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BJXPR01MB0278;H:BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:1;
received-spf: None (protection.outlook.com: panyi.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4uC0nU2+10nh3+lDnHN4d7SpaYpezhrcgPLNCLxXmtITmONAGdH+pn0lflRk+YUKD/RLrtMw+okmWT3g+gF+H97HBWNdv+PGPv1kQXm0gIsN1VC7yAkMgrbk9phRzKpZyLNQzeCwdf9FqHOXgYPZlgkYkVWZIVQlH+O9RBhpHYSK5xtb3t2+ydKhffj5leVG5Ye+07g4gieLVggPgBls5FzrcIwQJVg5k9ZYBC1d3/t4YXuOOO3+K7vAnKTIjkfueeDj/L/nM4frIrMMh3nY9b+tNaPw/mJi4smjsbWjfuMnSh6DupogK6uZnzR7pT7gm73NAhfZ+PFz0xQFPV2HqYCaX6madIy7AvMyMBuJhGJVJL3uPMTUeSO/nAvDPd3oyg7++MBdUzoiuocJo/PnjCPzBm5ju4fBzJLY14CulrRRsPHFpI6MUGQZmOGLEns5xz3NN68jXsx0M72ZasjajIbqDVrhHIs2LzYYVLGEpkyYBmFrA7rRRzOEYifEd8M+nzifqgApUvSaw7J8VaDv3gCiNS7Qcs29ZkFqMAbUqSM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: panyi.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: d08633a9-a670-40ec-d86f-08d788da93f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 01:34:26.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ce39a546-bdfb-4992-b21b-9a56b068e472
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pklZ6jifd4DYN46rfX3t+MBeiDiQxPxAtH3mamK4oHnCeq4X2ZfcXVsHm/zxG5Kw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0278
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all:
I have a question about PCI which troubled me for a few weeks.
I have a virtual machine with ubuntu 16.4.03=A0 on KVM platform. There is a=
 PCIe device(Xilinx PCIe IP) plugged in the host machine.
On the ubuntu operation system, I am developing the pcie driver. When I use=
 pci_alloc_irq_vectors() function to allocate 32 msi vectors, but return 1.
The command=A0 `lspci -vvv` output shows=A0
MSI: Enable+ Count=3D1/32 Maskable+ 64bit+


there is a similar case https://stackoverflow.com/questions/49821599/multip=
le-msi-vectors-linux-pci-alloc-irq-vectors-return-one-while-the-devi.
But not working for KVM virtual machine.


I do not known why the function=A0 pci_alloc_irq_vectors() returns one ?


Best regards.
