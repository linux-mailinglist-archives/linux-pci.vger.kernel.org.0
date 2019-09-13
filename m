Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6630AB2262
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfIMOlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 10:41:01 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:29157
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfIMOlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 10:41:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsURLkkZGbH81mu3kObiXQ4IqGEwy0ypYqX01kAE/mVufsDCl5M9nuixqLrOsUqO1MEECd4o+kqcpBO/qhpSlpvxEB112uSjMkwaH7GoKha/MSYk/f/Uuq7QNgdCnq9N31tD0QwyOZxoaJ2dcW/7F+HKf4zMkgvFuZ7GOlWeecP935nvJlNb1WVeXrhPeVHbM5vILTbCvJk+xlth/RUm404RvXQajBPdlOu4rMyt9l/1teqwRtwzaRrpn7hrLsy5jI/nHnSZMb+IeU+e7HEQH2y/PsolZFpF4Ixna3wSjGrXx850XF8x3gLLRPyhykHQBVgDez5LzFRyA5jbbmo80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVKX5kikkU8nSuHUIzzRQVzdeHj2IFR0hDT6opZyvlI=;
 b=G+W4l0yOfKJVmI3n6Iq9Qj13UhAJq9tnwOVvgf7y1YP1lcQm7rJRZh8ld1Le2174qyvBc9dwKXN1n2VJPeHO+3xb5Wg4VMbugZIT7YI1AmeOWNPKMtIXD0uobO8fayP/S4xc4Aw7BhwQO9J8mKjhxdoQwaG9q437tC3E/n9+iuxIp6FuJh6bBihYPjLmPedzQOM8+zYFtKO1R8TxZSnsp5paYV9hMye/Wp9olRmhfYi4BkgqCuBPGuxhr84YlSS502cDz5TGoB9T7tkbcIl1BrSH80b8p/ngi8lYWOJrWK68F30F/XfhuA6RDz30CRmmjXynPoWlt00HPtBAyT42Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVKX5kikkU8nSuHUIzzRQVzdeHj2IFR0hDT6opZyvlI=;
 b=sggu1AbpZz1h04RRBfgZR7dWFI2bgb2psyBDtqzAAG7jQQ/4ompSeqKEIWALwfOP+HCGgTKXUZw1WOf/Lx4TUgNtAZmFq0HUBNReeHdP+nt6RGCJG1Rg0Br0MoByAqMgV/8ZYLV/lrzhIpWvDiql4thhe3AgRr86d3G1r9IFAi4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4128.eurprd05.prod.outlook.com (10.171.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 14:40:57 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 14:40:57 +0000
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
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>
Subject: Re: [RFC V1 1/7] genirq/msi: Differentiate between various MSI based
 interrupts
Thread-Topic: [RFC V1 1/7] genirq/msi: Differentiate between various MSI based
 interrupts
Thread-Index: AQHVadCjjc8A7kc+WEGRJTQeCDtLDacprtmA
Date:   Fri, 13 Sep 2019 14:40:56 +0000
Message-ID: <20190913144051.GA5310@mellanox.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <1568338328-22458-2-git-send-email-megha.dey@linux.intel.com>
In-Reply-To: <1568338328-22458-2-git-send-email-megha.dey@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81718b4c-5ff8-409b-a80c-08d738586319
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4128;
x-ms-traffictypediagnostic: VI1PR05MB4128:
x-microsoft-antispam-prvs: <VI1PR05MB4128676CBA5C6CCCDC06785ECFB30@VI1PR05MB4128.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(66476007)(64756008)(6116002)(66446008)(66946007)(53936002)(6436002)(6916009)(256004)(6512007)(33656002)(486006)(4326008)(71200400001)(71190400001)(11346002)(446003)(52116002)(66066001)(476003)(2616005)(3846002)(76176011)(66556008)(99286004)(2906002)(6486002)(229853002)(102836004)(7416002)(26005)(6506007)(86362001)(186003)(478600001)(6246003)(54906003)(4744005)(25786009)(316002)(305945005)(7736002)(8676002)(386003)(8936002)(5660300002)(81156014)(36756003)(14454004)(1076003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4128;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6OPY942mmeg+19svHb28Zfcp+95R1LpTTCQbjTFwGADae9wdRf5qy3t63MTlAnq0cCC92E1UDJ4fxMY0rZVq+hzvasfwXw0+Ihs5em2uyL/Z4mlh40ZpgIF49P28lyR19UcqI/l3hIwT2nbFfX8SWxBHk4EUGP3dezzSI+kBSNMjwT0DYCe+Dwz2KQ2ioCHviH2FfFxUo/1AB8iGzNJ6kMszp1OeBHd91DWmlOXxMiY5XliPkfz+BkFD/VsZxGKF98+q1mLiUI9b6YjEGZdaWsVdD4+p0S8GELVXycHvmv1UwYLqr5yElC4FMnpWZPueNmY+OTObytyPxmXyDTKhiOlvMSos3bKQn+nNxtPXPRzP5T8beeYNA9ZQEyK+lZ9t0hY0oEsxPD1v/o4ngWvnMV5Volbmg8PuoLO+6bRohME=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D3EA76433FE9C40A4E0C966D104C796@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81718b4c-5ff8-409b-a80c-08d738586319
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 14:40:56.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgDnovW2Qwgyg70kgsonBdqM3VWRqK5YuG7Z618KNR9xMfC8Pny/aemepnz0R3l6bHZjnfi7Ma4LxtMSuU6Oqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4128
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:02PM -0700, Megha Dey wrote:
> Since a device can support both MSI-X and IMS interrupts simultaneously,
> do away with is_msix and introduce a new enum msi_desc_tag to
> differentiate between the various types of msi_descs.

It would be clearer if this commit message explaind that this is a
cleanup creating a normal tagged union:

struct msi_desc {
 [..]
        union {
       =20
Where the tag says which of the elements in the union is filled in

> +enum msi_desc_tags {
> +	IRQ_MSI_TAG_MSI,
> +	IRQ_MSI_TAG_MSIX,
> +	IRQ_MSI_TAG_IMS,

And don't add IMS to the enum until you add a IMS member to the union.

Jason
