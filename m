Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2981CB22A2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbfIMOwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 10:52:55 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:44951
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388958AbfIMOwy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 10:52:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnhsSmPL6cXZNxMOB5w5a4kaN1+VXbq1FoEQkhrfjlXYdy8wSZeH7GITJk+VK2l/FxNEa/AJqRf47rsDtNwD0h8ilW9dxrVrlP7rxNb7WDaYKRKVuzzSmbDIJMn1cFV3HjxafVrYM1Pk2Sw0SuC1eVaX6gTuL2WMKezaFxABkx4BPnZOdxuqtC0rQvSecUFDEPRlJlUtoleawmwDXbnDdU6ZUPkzs2Qd37rXHEwWL/445pLNK3jcME6ImyuNz//oiaBBtX2CGsFy8hyLlDXktr2nTA3/neIoEqG9GMVbqEvM0eRvLjMMJhzuY8WIl/0pp4e8onKZmcPISAVyl6udaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnGl74LM4PQ39t/LFSAGGzbDl+4XS2kP9uk8XpHvbzc=;
 b=BkT63IjuSfOu5cKBb2aZ9Uybii225oLuMdnRpS2bXTO53nVC/qI0E/8CBQl7SUf6P8e8pPAzFcsB96lYmCSq6jD8Q3ZERCUzXENlbCQHpTzBnt6XiERHwUqF3W6N8rThLubIoQDHABA/ENydxY0iXLeVu4DdGRAFh5Q0LCluqR3Qz9wFKPxpfrp8mVKuPgLiuClDiatzZQ/EhnRJS3T6QmFXEaJWzSw3+vpbxmaRjLMWIYV440K/bOB2H5mwkjUfWptJ5eymD4OWRHKo1m/Wer9tKRL9kmSpZ5Nn5p2Iow0SXHQfJ/C6xX1NFez1FhLhTr++TINNKSyIgscITJNivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnGl74LM4PQ39t/LFSAGGzbDl+4XS2kP9uk8XpHvbzc=;
 b=q40UxEqMK+LNSAdZrT2RS0Li1J4FVszpseVmEV0HqUlHpmb3bbkltL2jL+8o7+FF6kZp9U2u1z4nI4bkKQ/+37cp9My1AlxbJ28KdEvlBCmytO1JceLCojM6UBvrpKFuC37y87SBxmJLwwPKN3VmnAeNGf+I7guAhMX3Bqr/3+M=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4448.eurprd05.prod.outlook.com (52.133.13.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Fri, 13 Sep 2019 14:52:38 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 14:52:37 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Megha Dey <megha.dey@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [RFC V1 3/7] x86/ims: Add support for a new IMS irq domain
Thread-Topic: [RFC V1 3/7] x86/ims: Add support for a new IMS irq domain
Thread-Index: AQHVadClUz/vrQQQW0ib64vsXzDG6qcpshwA
Date:   Fri, 13 Sep 2019 14:52:37 +0000
Message-ID: <20190913145232.GC5310@mellanox.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <1568338328-22458-4-git-send-email-megha.dey@linux.intel.com>
In-Reply-To: <1568338328-22458-4-git-send-email-megha.dey@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 761066ce-a088-4977-21e9-08d7385a04e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4448;
x-ms-traffictypediagnostic: VI1PR05MB4448:
x-microsoft-antispam-prvs: <VI1PR05MB4448340596841C8B487A7015CFB30@VI1PR05MB4448.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(476003)(2616005)(2906002)(186003)(6436002)(229853002)(66446008)(64756008)(102836004)(66556008)(66476007)(446003)(6246003)(26005)(6486002)(11346002)(8676002)(6916009)(6512007)(5660300002)(6116002)(33656002)(86362001)(99286004)(81166006)(7736002)(8936002)(81156014)(76176011)(305945005)(36756003)(386003)(6506007)(1076003)(71200400001)(316002)(54906003)(71190400001)(53936002)(3846002)(7416002)(66946007)(52116002)(486006)(14454004)(4326008)(25786009)(478600001)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4448;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KeiNvBkZqBp9fGSXJeN8EGXHENgQVfdioQrXoLS71al4nWuJTS4sWloFpGFAq0sX7pGzEPSP/1UJf2O3b+rsK/MximKh50q5YR1dFCvAzn5ZOmkwYfPGm/pAiiDmIE0OgQvDWQXkpZqlH6XrIRPsOIC3CyI04K1vkB10iwqYOe4xHR+haV0kl1yjZlYgOPp/R1nseoxsX8eTAxGDirpTak2naUYAAlk+Zh+hOJuQuKdprAASgCgKZgWF58Rmo1JvXmxNCE149FkWO6YNt86Ik3VHV3kKlM9Dx764ncG0Hkyr8MzoQ/BpmQwp6c3cmCT+khOWCQ9HOM1CBRD4wN4lGgQsq6z3msLmplqKr8TrX+s1YmhFBdx6qgB9/BIglFyL2+fC330hLB4GNoU5wTIKvk6F/QxIkDZzdTHAE/P7U4s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8A2BCE3FCE369E41BC7378386C801B4A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761066ce-a088-4977-21e9-08d7385a04e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 14:52:37.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjf8qimURpmACq4Dc3NujsaX65kf1PGIP89i5EJMc6ME4OkQD5qSnBxYSiJ/UwrH+Oqup6wuM/TeQcA3QuqSQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4448
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:04PM -0700, Megha Dey wrote:
> +/*
> + * Determine if a dev is mdev or not. Return NULL if not mdev device.
> + * Return mdev's parent dev if success.
> + */
> +static inline struct device *mdev_to_parent(struct device *dev)
> +{
> +	struct device *ret =3D NULL;
> +	struct device *(*fn)(struct device *dev);
> +	struct bus_type *bus =3D symbol_get(mdev_bus_type);
> +
> +	if (bus && dev->bus =3D=3D bus) {
> +		fn =3D symbol_get(mdev_dev_to_parent_dev);
> +		ret =3D fn(dev);
> +		symbol_put(mdev_dev_to_parent_dev);
> +		symbol_put(mdev_bus_type);
> +	}

Yuk, arch code should not have special knowledge about vfio-mdev, and
in any case the above way to get it is really gross.

> +static struct msi_domain_ops dev_ims_domain_ops =3D {
> +	.get_hwirq	=3D msi_get_hwirq,
> +	.msi_prepare	=3D dev_ims_prepare,
> +};
> +
> +static struct irq_chip dev_ims_ir_controller =3D {
> +	.name			=3D "IR-DEV-IMS",
> +	.irq_unmask		=3D dev_ims_unmask_irq,
> +	.irq_mask		=3D dev_ims_mask_irq,
> +	.irq_ack		=3D irq_chip_ack_parent,
> +	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
> +	.irq_set_vcpu_affinity	=3D irq_chip_set_vcpu_affinity_parent,
> +	.flags			=3D IRQCHIP_SKIP_SET_WAKE,
> +	.irq_write_msi_msg	=3D dev_ims_write_msg,
> +};

It seems really weird to wrapper an irq_chip like this, if the caller
is supposed to provide the functions more or less directly why not
have the caller create and own the irq chip? Is something in the way
of this? It looked like the platform version of this did the same API appro=
ach..

Jason
