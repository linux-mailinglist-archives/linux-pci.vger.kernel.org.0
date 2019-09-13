Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A4AB22B1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfIMOyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 10:54:49 -0400
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:53231
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388225AbfIMOyt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 10:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTTJHrLOkeXXBM+p5Yz/34hoFaEnxgEWDmJC4Lh6fE6PkV46fzoD2h6Mb8yvB2rnrOfkfe3oEqoW2lVZd4PeVisBNiujmNBI0NsZ+cBuC/8H9UC35ed+ibPBw9f5rvbk0L6mIu6SKsXDRtmGsvNV1UI0bRTjMuwCixT+7F5TJvBtN02M0L9et4KbNnOgkuXG+8gVUfOjfqjjBZ7HMeSZ1ZIzIXsrWE6S2FpX8V4/KSjNP2YjXTbAyGOPZMqG8OTttAFRcXv5j5oSVe4EWKcpO0ASu9DEGo1LmmAXigwLC9wi9vmE0fqeH/ocZKPfXlL+QJ5xoLbyl3dKQHJu+51sKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2kC0I3Kti8vkjZ0KOACEGnnBmnGr1q9JfW2Styb5J8=;
 b=KSOqvCjlwKqH8mCwUVWDadIj8sKf9XQVMcXEZZ2WzKElQFHBf7xy2qsSj/KzvDGELSsM/uaJLYlUBUrG5J9iFR8hQ9yQwVPDXqM2n1rFbs0UrfpdohxFth6z/dkJw28v0uq4O/Z5Ioe0SJZ1eGPpEPBSxTBHLEYdYeHws0Z8NtvRxge3ygvKWsIza8lRQj9prxnbdZdBcNssIye/1rZTPo4sZiocYLOJweNzuNKypEaLXj9DyTGhBYeqQtzBIovqdJ0nZrpIjsokFDNfJaA56Ypv7eJR+mUi0tU3f1bN7pxkrvaiDeYu1tXUQGIO9xUshVd5SGOuCRb15WmDZc9HSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2kC0I3Kti8vkjZ0KOACEGnnBmnGr1q9JfW2Styb5J8=;
 b=mSeVGj1n+e9NTEvVhhTkSAjw2cCAee3yTWil9Z/g5cJjRM8YV2YkS575BqplQ4AOEAeiThqIpXuJXew8iL3Ns6b/pBWdsAOfMid7IhhVTjX950Oe+JSLuEG1pOHY0+jH0a1UKonf37PlD5+Vu9e4HHxrghJQG4ygbnrnTUXrgHU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4448.eurprd05.prod.outlook.com (52.133.13.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.20; Fri, 13 Sep 2019 14:54:32 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 14:54:32 +0000
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
Subject: Re: [RFC V1 5/7] x86/ims: Introduce x86_ims_ops
Thread-Topic: [RFC V1 5/7] x86/ims: Introduce x86_ims_ops
Thread-Index: AQHVadCkfyl/W5/j50OrxTgjCXPOsacpsqWA
Date:   Fri, 13 Sep 2019 14:54:32 +0000
Message-ID: <20190913145427.GD5310@mellanox.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <1568338328-22458-6-git-send-email-megha.dey@linux.intel.com>
In-Reply-To: <1568338328-22458-6-git-send-email-megha.dey@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cec94c82-bb23-4696-944c-08d7385a4936
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4448;
x-ms-traffictypediagnostic: VI1PR05MB4448:
x-microsoft-antispam-prvs: <VI1PR05MB444800F3647F7F5918356B95CFB30@VI1PR05MB4448.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(476003)(2616005)(2906002)(186003)(6436002)(229853002)(66446008)(64756008)(102836004)(66556008)(66476007)(446003)(6246003)(26005)(6486002)(11346002)(8676002)(6916009)(6512007)(5660300002)(6116002)(33656002)(86362001)(99286004)(81166006)(7736002)(8936002)(81156014)(76176011)(305945005)(36756003)(386003)(6506007)(1076003)(71200400001)(316002)(54906003)(71190400001)(53936002)(3846002)(7416002)(66946007)(52116002)(486006)(14454004)(4326008)(25786009)(478600001)(14444005)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4448;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nQdEHbx/93CWOyxkFq6iVl1dhLgEcBJ800n8x96B4C7IbyhqkydOF5wrppu9GG6ibvj2VRQeMlF/4raxfphLPuYr5eqBoF7yw7WhUu/edjeP+CbiGLePY9d+bWgR7X4tN7c/f/WEUnnENhVm1TmbqPStmGkvlWXQZY+7Wz6Gcq9x0prqCrFVdaQjwsZTag+P6ZYv+j5SipbKV7gablOpNqIVTZziNSBMbANlqYy98pJcfB6h/MEiueEaOkXSuQctp1m8VKrFedzWGtLngvF4ETCXTX57sQcAADJr46hgX8Ysm1dP1elhUnXJf28a0UCtZ5smfXIZqBCK+8UFYFva3lqfaKA6ZXjnTqHSrUBmODYPEpCSxkU/DXIxBVucT7QAbTH4YnJ6CNw5VUzzlMmmzw95OmnqPUNBRSa2wlw1gx4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <02143F9BCF3490478FA6A227D9649F62@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec94c82-bb23-4696-944c-08d7385a4936
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 14:54:32.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ED0cfn+7M6sgw2IvzfmiyFYWTJ4OASyw9/RwbWyByDOGQLp4DxbFjwerX8Q5WDcJRRHexMf9+F5dsXbYuZgBcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4448
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:06PM -0700, Megha Dey wrote:
> This patch introduces an x86 specific indirect mechanism to setup the
> interrupt message storage. The IMS specific functions (setup, teardown,
> restore) become function pointers in an x86_ims_ops struct, that
> defaults to their implementations in ims.c and ims-msi.c.
>=20
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
>  arch/x86/include/asm/pci.h      |  4 ++++
>  arch/x86/include/asm/x86_init.h | 10 ++++++++++
>  arch/x86/kernel/apic/ims.c      | 18 ++++++++++++++++++
>  arch/x86/kernel/x86_init.c      | 23 +++++++++++++++++++++++
>  drivers/base/ims-msi.c          | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/msi.h             |  6 ++++++
>  6 files changed, 95 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index e662f98..2ef513f 100644
> +++ b/arch/x86/include/asm/pci.h
> @@ -114,6 +114,10 @@ struct msi_desc;
>  int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void native_teardown_msi_irq(unsigned int irq);
>  void native_restore_msi_irqs(struct pci_dev *dev);
> +#ifdef CONFIG_MSI_IMS
> +int native_setup_ims_irqs(struct device *dev, int nvec);
> +#endif
> +
>  #else
>  #define native_setup_msi_irqs		NULL
>  #define native_teardown_msi_irq		NULL
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_i=
nit.h
> index ac09341..9c2cbbb 100644
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -287,6 +287,15 @@ struct x86_msi_ops {
>  	void (*restore_msi_irqs)(struct pci_dev *dev);
>  };
> =20
> +struct device;
> +
> +struct x86_ims_ops {
> +	int (*setup_ims_irqs)(struct device *dev, int nvec);
> +	void (*teardown_ims_irq)(unsigned int irq);
> +	void (*teardown_ims_irqs)(struct device *dev);
> +	void (*restore_ims_irqs)(struct device *dev);
> +};

This looks alot like the generic struct msi_controller..

Jason
