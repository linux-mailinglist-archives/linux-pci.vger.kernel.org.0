Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC22696E0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 22:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgINUn3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 16:43:29 -0400
Received: from mail-eopbgr690043.outbound.protection.outlook.com ([40.107.69.43]:52289
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgINUn0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 16:43:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3imx1Fa0vgpdwEGR0IlplK0UDnVLCvhNr0kVRSOQ9UNWAsOesXm0spAGmlTB1gA2niQMh1apuiuLnz7vKsMuFP+lgeV30JfFkhhl0ORqj3Kn1CjkzJlrqpXud6O9wPv+gjfZXOE1ii6ep3CA+Uf7Mpup9suHLspLRMFKQNgokK5xysfUetoWKTTF9dWTA4rL/YPFMlYeL5Hs1FlAiGN8brcfu1Ymr3MhMfhGT9i6VMKBccuOV44r+juWcsfoGx5nyMwYzgBnk7v55wvO1fCx0+Ut/WoXkNWS4gsC/2lapzxf0OMGdGdAIrtGGqHi2glY55FSE7fTkwzJcSjUBxdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGvNj3XM07EI1Qu2dRSUQiX6UldLo8O4mmENzSrutpA=;
 b=VMVlc8qcdny0Sy5G2l3KtfKMg4ihI2qI1oyyYtGbzoSmrN34QiVa6kamfNlThfU5lUjN51IEAgEovO0xBBUhbBcxfxzVdgORYpzbzRtrPX2aMCiCWfjGK61DDTW9aL2jUj/fZcmvEJXF1nAj9IKYMLoU+Cfwz0ZVJfEDM/tRwmmejOaxQgx8ftSK4EFCc77oKTxb7v09dk1vDz3g1XV52ZJQoUE2cEm+limfX1xzFXqE9zR5IrxoqG4BClaAfAGQKWsDNco0bNARUZU8ECX3Q+BAd/49jqvwGUUsRHi9pX7KYFhiig2DVBW9puYED0JEWuGZOA/0I39gqOaFaDlAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGvNj3XM07EI1Qu2dRSUQiX6UldLo8O4mmENzSrutpA=;
 b=aTu3P7ZWDIqdmyP2yLStVR2gTcbknnHNGWJ1NWywmWw6Ads6I8f1wqoTdP3crfQLFvvhleyP1r9QayzOBlc3XtiF4VOzsmeIem/tp1HuvOHIEv+rryz9UcpHQnyPUHP6Sel3xlXu9IBkdHmshYfEqeZZqyun7fKQDGNWWA0UFO8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2369.namprd12.prod.outlook.com (2603:10b6:207:40::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 20:43:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 20:43:22 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Huacai Chen <chenhc@lemote.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: RE: [PATCH 2/2] PCI/portdrv: Don't disable pci device during shutdown
Thread-Topic: [PATCH 2/2] PCI/portdrv: Don't disable pci device during
 shutdown
Thread-Index: AQHWieeYTme8ceTGdke4kZNvw6I+JqlomPcw
Date:   Mon, 14 Sep 2020 20:43:22 +0000
Message-ID: <MN2PR12MB44888AF1CC4B2D9EF0F2A2BCF7230@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1599818977-25425-2-git-send-email-chenhc@lemote.com>
 <20200913160437.GA1188602@bjorn-Precision-5520>
In-Reply-To: <20200913160437.GA1188602@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T20:43:18Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ec0baa29-3bfe-4890-8728-00003b34d4ca;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-14T20:43:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 097e0f61-4abe-42d1-bff4-00006e0f8757
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-14T20:43:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 5ea970d8-aef7-4153-b9cf-00000bbd85c8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83f3692e-5c78-4d5c-f0ea-08d858eed262
x-ms-traffictypediagnostic: BL0PR12MB2369:
x-microsoft-antispam-prvs: <BL0PR12MB236925A3E156F8EBF28E1430F7230@BL0PR12MB2369.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOqkIgmq13AEcvpvx1Y1fRKBbGCli0Bebfo/H3fFh0Iozutbm/t9O1KxpzET/DSfPpPrkcGCnam47MTGVZ1MyVEEu7NNi0Pg9SXGDAPTaIYvMe5sMV7pM+fFAoiHxU6L0YfvrVS7RlDov9BgdmYT6kM1Lbnh9v0m8ljaq60AOBrgdIr+itqDy6z+/fOdDh2F6MJLV8d1qNh68TM0liFTU8EGfp0hK9kAcRcgqOpQF6lahfJb8SZ15EDkCLGQ1jZp71XozBkKmMpGOCEi5MlvSSxzqC9McTo7Faqs+s9HGWqnHCWr9+DfZR5aqj3HrwDWZ/DcazIywwugz6zmtHmmirJTHSmp/rCqPW8OBFCy/Cvh2RF9dYngQRbJRFN2YVNNld1QK67fuFqfS3nXfe+rPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(52536014)(966005)(2906002)(5660300002)(66446008)(83380400001)(33656002)(6506007)(83080400001)(53546011)(186003)(8936002)(54906003)(66556008)(64756008)(86362001)(55016002)(66946007)(4326008)(110136005)(66476007)(26005)(478600001)(316002)(7696005)(76116006)(45080400002)(9686003)(8676002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QKkqYyPYogdiOkT+Rjzzl701G+D5yi9/gGiQBuSsBuwJJyEojT95hiO3qPpa+JAYePI9hIb6PmBaiJSZUFeiu/0ocmnrR3sGWtemMqeKd8lOuagPm03zNhL/N4hKCQDdWevi9qnm23oLqWDznY8DQ+M6WB7RemWmWQY795sTGrSmRBx0vATFL9Hv3EcQTq0g6qKOdQcAL8orm3LGapRSPn9+qI1f5ikZAKyVcnDJw8b7caOLnudAUlLuP/ho8f28p6p9wn3s6D5fXkZIXoVRSKDD0oMZ5EQvIV4y4/DzVGvJnfs8khSXigO1m0Wk1Ia+UdRaJR81p3qklDA60vmrak0gK3z+EtcrESO+7968KnSCNNca/T2Khm2dHbuOOZiyR81kjUsYyH+hwMFliYMhnes+XZ7gCTEZ5LamxlKdfFKCKGHAM31nI9iQTdszZRBXi0lr4EIRtGJHeMBA84BkffdnkPR6yS102H4eDa7mPbGMVj7abPO8ojoKpAmRPFXPU7KlCdAjB+onofDuq8UoPv8pDrobi38Unfqs2TtWY+SBk18FNzSEHGg98ytwEyYlBrXDNokJec6aJ+daHMPyfNuK6KwIKQVXifIaNqn5o6hbluOXVmG8sxBKIiPxN0p1WWk1xUkE4pwYRO572QCOEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f3692e-5c78-4d5c-f0ea-08d858eed262
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 20:43:22.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wvbif5mYT34SlGLB05ld+7n2D86YqXIQiw4sLFo7zqji4TRwEwoXsgWq5vH8txBAEyg6+V5ZX4LeIrn5oG3lwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2369
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Sunday, September 13, 2020 12:05 PM
> To: Huacai Chen <chenhc@lemote.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-pci@vger.kernel.org; Huacai Chen
> <chenhuacai@gmail.com>; Jiaxun Yang <jiaxun.yang@flygoat.com>; Tiezhu
> Yang <yangtiezhu@loongson.cn>
> Subject: Re: [PATCH 2/2] PCI/portdrv: Don't disable pci device during
> shutdown
>=20
> On Fri, Sep 11, 2020 at 06:09:37PM +0800, Huacai Chen wrote:
> > Don't call pci_disable_device() in pcie_port_device_remove() during
> > the portdrv's shutdown. This can avoid some poweroff/reboot failures.
> >
> > The poweroff/reboot failures can easily reproduce on Loongson platforms=
.
> > I think this is not a Loongson-specific problem, instead, is a problem
> > related to some specific PCI hosts. On some x86 platforms,
> > radeon/amdgpu devices can cause the same problem, and commit
> > faefba95c9e8ca3a523831c2e
> > ("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.
> >
> > Radeon driver is more difficult than amdgpu due to its confusing
> > symbol names, and I have maintained an out-of-tree patch for a long tim=
e
> [1].
> > Recently, we found more and more devices can cause the same problem,
> > and it is very difficult to modify all problematic drivers as
> > radeon/amdgpu does. So, I think modify the PCIe port driver is a
> > simple and effective way.
>=20
> This needs to explain in more detail what the failure is and how this pat=
ch
> fixes it.
>=20
> The main thing pci_disable_device() does is turn off bus mastering, so I
> assume this has to do with DMA during shutdown or reboot.  This change is=
 in
> portdrv, so it affects PCIe Root Ports and Switch Ports, which of course =
are
> type 1 (bridge) devices.  Clearing PCI_COMMAND_MASTER on bridges
> prevents them from forwarding memory or I/O requests in the upstream
> direction, i.e., it prevents DMA from devices below the bridge.
>=20
> But if the problem is DMA, the same problem may occur with Root Complex
> Integrated Endpoints or conventional PCI devices, since portdrv may not b=
e
> involved in those topologies.

I'm not sure I understand what the point of this patch is.  Isn't the whole=
 point of the shutdown callback to cleanly tear down whatever tasks are hap=
pening on the device?  It could be DMA or stuff happening on the device its=
elf (e.g., microcontrollers on the devices, etc.).  Most of the complicatio=
ns in GPU drivers are due to the lifetime issues between drm and other subs=
ystems.

Alex

>=20
> > [1]
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> >
> ub.com%2Fchenhuacai%2Flinux%2Fcommit%2F6612f9c1fc290d42a14618ce9a
> 7d030
> >
> 14d8ebb1a&amp;data=3D02%7C01%7Calexander.deucher%40amd.com%7C1cc
> 5cca01b5
> >
> 74485a0aa08d857feb88e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C
> 0%7C637
> >
> 356098841869775&amp;sdata=3DHJmniTV2jJLEiOh3UCFpqPuGeq38y6crax2ahZa
> 5Eqc%
> > 3D&amp;reserved=3D0
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  drivers/pci/pcie/portdrv_core.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv_core.c
> > b/drivers/pci/pcie/portdrv_core.c index 50a9522..1991aca 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev
> *dev)
> > {
> >  	device_for_each_child(&dev->dev, NULL, remove_iter);
> >  	pci_free_irq_vectors(dev);
> > -	pci_disable_device(dev);
> >  }
> >
> >  /**
> > --
> > 2.7.0
> >
