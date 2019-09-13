Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0AB2284
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbfIMOuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 10:50:08 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:52246
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388704AbfIMOuI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 10:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBm9EGwTIljPsLVMpngBTbTAsjJmH+2XCyk8L7J1PCcjcYAbGy6fx33H/WbV3B685G9L9TFeBIV7WpwkFpqn+uDjqBvrBUbvqJDyQDB2LnpQQOTuIFDR5/YBW/3kZp9WONvxA5IRgRN9JDNxDG5oHDqKLEgAu/cyqKT+1+yR8L1BvL3I7FDjp1LGXQqxgsqpc+ClOIDksUfOP9N8cAWDdfiAKmzjJC438zAT9AfinaFcc3V0uRgxpgUFKDj1XtH+05pzyKD2dqx1TcFBsVHFwEDmAaTROQvs+dlmpQxPgJolsMviLCS76Wyrlb5aY356nCJHAtQ6mAVxjvKzJ0xjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs6Twr0TMVYu6cbaOulpZ41+/1RpFqrC4bVhoE/h3M4=;
 b=Ha6YRNd4imOXZaONUHLU+VYWCkP0I6ZfcIGcME/ciFJXP4kM+NKSttUARwpqBS4mwrvUI25BgtFxkH2Lsr2LTLWHWmb9oJBtm4rLGCMK1pqDYi9+Fr1/h7wDpOIMUNLAXAeH3fV0/9qWAZq43IpoQokbigMQJrBT7TM0l1g/CHnGjrjFJ97NH8BW8vwl1EifMpjl5JFskRdZ05M/FK0qm8l20DZrQ5qBKa0l66BycLQsGuRjfgJPqRdp4c9ceDvewKq/IHFYUJgXJq5JUu97ONqUnzqfoaMCFM2BzBF9GHynhc56tNI1qBKjlr/p+yDLsTFWGjZ6UESTHpfzZCFy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs6Twr0TMVYu6cbaOulpZ41+/1RpFqrC4bVhoE/h3M4=;
 b=egbUYVJtqWkGsak+VBjFQZ0qYNiUJjA6MrKbiYtR5QUGvgTKDNC2cYp89M6C/WkyirtZfJ4WAQIVGTIljpVP94t5YiNvwAT0jV5HTKVvpqZg7m+0lMx1FkEfDz6zb6YgbwTAnwx5SvIvblH+MVEyew3MRG/1GlC3hzfAaKdmQZ8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4128.eurprd05.prod.outlook.com (10.171.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 14:50:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 14:50:03 +0000
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
Subject: Re: [RFC V1 2/7] drivers/base: Introduce callbacks for IMS interrupt
 domain
Thread-Topic: [RFC V1 2/7] drivers/base: Introduce callbacks for IMS interrupt
 domain
Thread-Index: AQHVadCjtpoaSeeDPUmnY03B0M+Gi6cpsWSA
Date:   Fri, 13 Sep 2019 14:50:03 +0000
Message-ID: <20190913144957.GB5310@mellanox.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <1568338328-22458-3-git-send-email-megha.dey@linux.intel.com>
In-Reply-To: <1568338328-22458-3-git-send-email-megha.dey@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f868815d-dbff-45fa-3889-08d73859a8d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4128;
x-ms-traffictypediagnostic: VI1PR05MB4128:
x-microsoft-antispam-prvs: <VI1PR05MB41282A93CE7693F15E8CC530CFB30@VI1PR05MB4128.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(66476007)(64756008)(6116002)(66446008)(66946007)(53936002)(6436002)(6916009)(256004)(6512007)(33656002)(486006)(4326008)(71200400001)(71190400001)(11346002)(446003)(52116002)(66066001)(476003)(2616005)(3846002)(76176011)(66556008)(99286004)(2906002)(6486002)(229853002)(102836004)(7416002)(26005)(6506007)(86362001)(186003)(478600001)(6246003)(54906003)(25786009)(316002)(305945005)(7736002)(8676002)(386003)(8936002)(5660300002)(81156014)(36756003)(14454004)(1076003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4128;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BwLs0NE2dRXTVpFz3wj9FyLihtpWukHKHTtlDZAJl2SS3dZFGFd37kssYkJsctjcM281MIoFtBttxQAj93yzfV3NgasDPf0qfQ4UyYg+mDBTbvhWFlMEDr3aIvHZYjvzCktsagEg8CVoLWRB2QKy+fbhZWi9nWAsivKc8MpZWf6Gu/91YSXmBdNa1EXGA0wnzqlhMl66MGrqNBGPTzseFuVFN3SKAxfTR7/W1SV5vEx54DZ7lVDhbBSGjsHNN+0sjuTTc/DGMUeaor9r+Ri0txKU8okKXL6fMwoxRunCM9jM3U/Zq+gsmxhi54un9VLUta7aJ6U2VHt6s3qJQvZgZrBqgV2YQarJnm1XjpTVXj2syRvcMgCaShTDUuhKYqc+Xhd55yRu6fTpss5UxEWLV7+4nVOLodBoOk1ePK3jUB8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84249D392BFF2640B5D61544F3308566@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f868815d-dbff-45fa-3889-08d73859a8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 14:50:03.3649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+YJOsxUFHp9togYxk9MBCIShQDFk4RjvX76fv/M2Wl5cY3FysUIECIqE5ar5wTBSlINIID/G3XefouxxOsR9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:03PM -0700, Megha Dey wrote:
> This patch serves as a preparatory patch to introduce a new IMS
> (Interrupt Message Store) domain. It consists of APIs which would
> be used as callbacks to the IRQ chip associated with the IMS domain.
>=20
> The APIs introduced in this patch are:
> dev_ims_mask_irq - Generic irq chip callback to mask IMS interrupts
> dev_ims_unmask_irq - Generic irq chip callback to unmask IMS interrupts
> dev_ims_domain_write_msg - Helper to write MSI message to Device IMS
>=20
> It also introduces IMS specific structures namely:
> dev_ims_ops - Callbacks for IMS domain ops
> dev_ims_desc - Device specific IMS msi descriptor data
> dev_ims_priv_data - Internal data structure containing a unique devid
> and a pointer to the IMS domain ops
>=20
> Lastly, it adds a new config option MSI_IMS which must be enabled by
> any driver who would want to use the IMS infrastructure.
>=20
> Since IMS is not PCI compliant (like platform-msi), most of the code is
> similar to platform-msi.c.

It is very unclear what driver facing API is being proposed here
without a driver code example.

> TODO: Conclude if ims-msi.c and platform-msi.c can be merged.

Wow, the commit message for platform-msi.c explains that it is doing
*exactly* the same thing as ims - at least as far as the driver is
concerned.

Clearly the ims idea already exists and the driver facing API should
be harmonized and enhanced to support both PCI and platform devices.

It would also make sense if the arch facing API was harmonized between
ARM and x86 as well. Would updating x86 to use the new generic
msi_domains ARM is using be needed?

Jason
