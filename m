Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7852696BB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgINUeR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 16:34:17 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:13249
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbgINUeG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 16:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNvi6ApD6bNNmehKExQaxdsvmEqDH2D3JS6upkqxdkcEk5DTscXEPZADF1QUfx0sIALoajvUG4oAYP3VLTNdoSG11GxBpZmF6EpxgBDgfPsAXjPhk9yf5ZtXfuugRD9PCRVB1ESvluaYLFOKDss/aLU+b10H0TtgcPwx4R35Ius2SD45VsAlrv+4ZiUHgUCacflVoZ67zDxmZ3f/0SGoj7dZtK2CUpWeQk8nQG+dn2Sf149p8vgjNQlcRrNnrd5KguCHM29XbYhyDX1cMLd92c6O9/b5gHYVqUJRvrBF+Mlzde3erNuecUclO9cfCsfl6Rld/GJqOPXCHSnY0phd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=976VPVqbDQVwlTh/T2FBaShp5C+a9/tD1N/10lqGLYE=;
 b=Au/xHUWWn7TuF4l0n9ajLjFNYzr1/k5yyBF3uTqa8Xcrg6VYlkadfUxyAK2ZTur2O5/KcUI+7mzNXzfjb3xWKyR/wBQaZG66gSG5Yd/N4jmBzTOBibzxleGcfxDWJt5AxIXueNzFg+oHFytxxSBBH+vuwK8SoxZidVixSFR18nFjSrAmThKJJXybMleyi9w3M9siHh7xMZOCUkbivb1jvbRJmEgDcX8qqdzRyxjbogiDW0oRP28KiPEQKB36AMIx6MH3u8Xsv4ZAeaX7oFgztycCKl7ou9hxxdJo7+MSLHL/mUEW1+GUfV/i9BqAnMq4yC7579Q4GbGg34LuUgGcww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=976VPVqbDQVwlTh/T2FBaShp5C+a9/tD1N/10lqGLYE=;
 b=PMzFxkMfGU+SU4wx6geyA+BPzUm8IEqf6UPn8QaCuuC8XN20fbQG7VkdBGNg8vRW6Zse6ITYYitN1VvP/oWu5UMMcJC+amoGFJsZCF34RqhBHNi1epsKJLHjHZMrH7jiUJAMybPM/yD0kmiXUGHv55lg/3ZeQS1utjPSjpWi5rw=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 20:34:03 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%6]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 20:34:03 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
CC:     Huacai Chen <chenhc@lemote.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: RE: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
 pcie_portdriver
Thread-Topic: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
 pcie_portdriver
Thread-Index: AQHWiYr0b6bHeTGyH0aeDQg7BoeWJalmteqAgAHib/A=
Date:   Mon, 14 Sep 2020 20:34:03 +0000
Message-ID: <MN2PR12MB44881AF114C47613285A083BF7230@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200913050129.GA10736@wunner.de>
 <20200913154235.GA1188391@bjorn-Precision-5520>
In-Reply-To: <20200913154235.GA1188391@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T20:33:56Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9246b23b-3468-4912-bef4-000000d02ae9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-14T20:33:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d2bf12e0-b1fa-43af-9b5a-000005d1ca49
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-14T20:33:58Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c80bf86c-561b-46c5-9226-00000c3e07cb
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09a0f8b9-970f-4993-3b6c-08d858ed8506
x-ms-traffictypediagnostic: MN2PR12MB4078:
x-microsoft-antispam-prvs: <MN2PR12MB40784DCCC634B64C49D2C139F7230@MN2PR12MB4078.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KEY+MuSlegksWzpsTP0zUcooqQuOgUuMqIBpg7NPfDbjmRQlVe5bkdVyS2X9gCFOoKWIQFM7EKhuDHufkkap83kx/a3CDG9eUHVOBBtd2K/FSWoopduoj+Nsu3nUZTDzuPA7AkkzaWao3doL0PDQaKVW65CfwDmh6F/V9b2REP5/96auvleY9DNrf1oD/4+KB1Z35xRPZh/6lT0OoHZLs7S7dYPnx6ZvXhhPHn9egpUr3zpV9HtMJyUxc1YREvMwyvMsbnVmNxjfhOC7qYYsEDb47pXXEqpJEl7sityj0jhoVLM6QDas4ZL6NeN/1y0UHfFuZr0795ezRHmBEtSeUch8n4/nD7Me3pWYdTVeKpc1ZZVpmCtZxJXELiEuYevn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(316002)(6506007)(9686003)(55016002)(33656002)(64756008)(66556008)(66476007)(8936002)(53546011)(26005)(66946007)(66446008)(86362001)(2906002)(5660300002)(76116006)(8676002)(54906003)(4326008)(83380400001)(186003)(110136005)(71200400001)(478600001)(52536014)(7696005)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vnGqFnHMTkxXh5jiYu/jlUdA8ykOXjh242TniSwaCdZnYNlzK8wABuwDTHSgDc2ZVpxiR/1Xf4hn1haKN9WkxmqmPUNyFDOE9M3EwC99f5ZUSt0qWjgYjkHV1JnIYQtYED6wsCbyz/b5JNns6udulL27O8jqMitVzE6VBh2AHir3Iiz2pEFKmvgvLBOXCrnAmH53vvh3qIcF1rrLJutoqs575KYCW1ZCfS6ZHspHwLVWZOK23sqVNPIZJZ2beJ1uXQ3u3JJkmtx5kobGfyCDeuxzT0bhFLxhqkbK3DdUV+pOkCkGuS2jXoTuHZ59FtL3Fhz9EIncVm3YoYhqb2dScflHTP1O4RHs0MBZ3upiQu43rCPFDD1PFNSMA+EOa2KPumnNHl/wYdudM+AG0dIq8+9+PvXqoPujZG9jBNIjOjprGh4Zx4GJpEBW5qnMRV7lAm5ZzXTr/nwP2sOwxsc4KbLrppvwTxwZ+PQptU17HiHh32Krgzma2fGJCWpn6QlCtAgWhYnqDFmS6aYm7IP7kkDYqTX6XsylIHcS0o2EApR6RxqPwk+Scyou4ZumUyS5O1q75SLPzeH38KOD2l/i/fkrZgJGkhGl0rvuOZmpfX2kDBXQAm0ateUrHrVhfxw8XLaCiNVIfvgh9cl/+jwIbw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a0f8b9-970f-4993-3b6c-08d858ed8506
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 20:34:03.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +boap6SP4Gms2jau3vs/B9iUBV5vqvH590t3sm50C+BcK7N+tp8K4bU3b6xUD0EHmTrmRDsnRsRrkH5vsit+uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Sunday, September 13, 2020 11:43 AM
> To: Lukas Wunner <lukas@wunner.de>
> Cc: Huacai Chen <chenhc@lemote.com>; Bjorn Helgaas
> <bhelgaas@google.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-pci@vger.kernel.org; Huacai Chen
> <chenhuacai@gmail.com>; Jiaxun Yang <jiaxun.yang@flygoat.com>
> Subject: Re: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in
> pcie_portdriver
>=20
> On Sun, Sep 13, 2020 at 07:01:29AM +0200, Lukas Wunner wrote:
> > On Fri, Sep 11, 2020 at 06:09:36PM +0800, Huacai Chen wrote:
> > > As Bjorn Helgaas said, portdrv can only be built statically (not as
> > > a module), so the .remove() method in pcie_portdriver is useless. So
> > > just remove it.
> >
> > No, PCIe switches (containing upstream and downstream PCIe ports) can
> > be hot-plugged and hot-removed at runtime.  Every Thunderbolt device
> > contains a PCIe switch and is hot-pluggable.  We do want to clean up a
> > hot-removed PCIe port properly.
>=20
> Right, sorry, I was thinking only of driver unbinding, not of device remo=
val.
> Sorry to have wasted your time.
>=20

FWIW, our newer GPUs have both upstream and downstream ports that are part =
of the device.

Slightly off topic, but does the current pm code handle these cases correct=
ly?  ACPI related power handling doesn't seem to work correctly for these d=
evices in laptops where the GPU power control is handled by ACPI.

Alex

> > > --- a/drivers/pci/pcie/portdrv_pci.c
> > > +++ b/drivers/pci/pcie/portdrv_pci.c
> > > @@ -134,7 +134,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev=
,
> > >  	return 0;
> > >  }
> > >
> > > -static void pcie_portdrv_remove(struct pci_dev *dev)
> > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > >  {
> > >  	if (pci_bridge_d3_possible(dev)) {
> > >  		pm_runtime_forbid(&dev->dev);
> > > @@ -210,8 +210,7 @@ static struct pci_driver pcie_portdriver =3D {
> > >  	.id_table	=3D &port_pci_ids[0],
> > >
> > >  	.probe		=3D pcie_portdrv_probe,
> > > -	.remove		=3D pcie_portdrv_remove,
> > > -	.shutdown	=3D pcie_portdrv_remove,
> > > +	.shutdown	=3D pcie_portdrv_shutdown,
> > >
> > >  	.err_handler	=3D &pcie_portdrv_err_handler,
