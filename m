Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B114AD40D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 09:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352094AbiBHIxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 03:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiBHIxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 03:53:49 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D5C03FEC5;
        Tue,  8 Feb 2022 00:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2R2/LUK+p0JFMfo4UXbi1ki529jBIt8FOn97OuZK0NXng1szviIOzYg2Cnc8DtXh9Q0YBbL28sKGL89U/4YPbIvzN6QT4uQVgzsOYcoJxORpDkRgawAfSbBAmZO8MEaVkAugaFT/ZvE6fMiQCmb3fkn4VISloJgcgIsTkQtOA+Pc2+KiSwFme7F5A5tNKMEoZ9LbvEgw/EJMdWY2kOy7sZsw4GGwo95+dD5AuShD17T6uUoNoFL5hz6TNgNXW7aFTgPVORIwXKQQHFwPHAVFjsYNLeXkTb5kG3zEwFJnPQkKH0c/NLiGoqkj3oNQ46BC1udhklIJ7ODhQQB8URsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xJJTmNIU8ibC9zo+Sp+PfieBiapLvGxYsdfRVMRXPo=;
 b=kRzV8csoa393U4nwdfJaRju9x7hD8Ja+pMPBvn0lXfQ+8Uaa2tuWan3mW/Yr2jVifktQiJ448+ZAcDSkCxFdI3r76Qg0IWwV2Acgk0KmIbh07/vWc8f5D/oC/Xoijnjaw3Lm/0hAwTQcBHCPeWGZhUOZtLCH3wloz5MoCkGn16g8jlhQI+9HOCOz5ny9DIwgurRNjfea1LdIPd21ynZkBPsMruWPiRyki/uePfxzEyb1Fk4IYNwCZ4Q1tbll7CUMc+mXXuwtQ979YeiUquNy3Vg+qbTIevI/nygFbOEfTGjUCMoaUswjje/n5jfS6Kx83jg8iRLidklSQWojutelgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xJJTmNIU8ibC9zo+Sp+PfieBiapLvGxYsdfRVMRXPo=;
 b=tw+iRZcQ8mPHNL/q5PSKLp8J8eYEnicnD4K9ZiWa7zjs8cEN1UeLwn3FsZBfLpwm/qoeuUNkODcx5OH42yEuD0cCqzGQrnx9nZhd5L4thg5OZ0MLxpz64WPsnblhkNPOjlWf8b9SjFF7SSkg2A6uy5G/xXncv+NEF+suGa12bJ6zer5PCwB3vswE7VgxK3zeITeFG55bjrD/hrk60NwzJPtS5V80SoGbP8j+i1sREWeULAQCppjfsZubblROat5Dpydtry8+lNUIQEHs1GLDh4ae13fwI7BkdN9vfROLwjrqVtO93O6QoSYF3bsFoKtHIPNHPT3MxZKGGw5XY5kxlQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB3838.apcprd06.prod.outlook.com (2603:1096:4:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 08:53:38 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::d069:2ca1:99cb:b937]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::d069:2ca1:99cb:b937%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 08:53:37 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Tao Ren <rentao.bupt@gmail.com>, BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH] usb: ehci: add pci device support for Aspeed platforms
Thread-Topic: [PATCH] usb: ehci: add pci device support for Aspeed platforms
Thread-Index: AQHYHLU/wak6DMtWCU2KemAPJzVaSayJRCQAgAALm1CAAAZMgIAAAwMw
Date:   Tue, 8 Feb 2022 08:53:37 +0000
Message-ID: <HK0PR06MB32021B3CDD6F04614E471234802D9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220208062927.3527137-1-neal_liu@aspeedtech.com>
 <YgId0AhvRAmIcEA0@kroah.com>
 <HK0PR06MB32026A17E53EB76DB898A399802D9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <YgIs1fIu9nzuCKeA@kroah.com>
In-Reply-To: <YgIs1fIu9nzuCKeA@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0c38cab-3057-4beb-c93d-08d9eae07f3d
x-ms-traffictypediagnostic: SG2PR06MB3838:EE_
x-microsoft-antispam-prvs: <SG2PR06MB3838B173FFCC8C3413511875802D9@SG2PR06MB3838.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tf1tuU2xmoKBSdRvs90VlKuqsvwzv+xu0bPDVBZdckkzy7huyD3mFYvS5Iu8IU+F3GQ7xgyLX1fQn6sXSI1x0Wer/wK/weBQDewPSVZrlD6NwEVbdKCy5j0+LbtbrxqM7dV/PQVLo+ZaXtuRognEIaEL9syJm39qOUd2h2WtDSPDMSOrnA5Cu6OqPLnLpNPAaTkS8Iu9ctBaR8bp6h+pDNV9WDwr87YB0i6vUI/AchqSJCOd9Kb6eE0v5fGOYZ9pll51IYXPvlOXC+v6ai9SKlBADaHubHF/crf2hb7ym0bOpsCVu7Q6oEsqfNyuIaJgBEptBftneevDHOwXLOfpZZa+2ytDpk648W6ygfLs29kAalE2kWzVl7UVq+EQKk2Fj/Ap3x8qWRrRetQqJAd/SiEuIKT20UQP8RYY+LnML/Ixc8l5Zbi0DQ+kWwWCx+gC8W4YmDQWXnI+9CHlghe0sKPs+LEZ0Kg/F9F6+v4ae+dyMzmIr0FMkE+XEenq7Pn6ktMuk8iHg9SE7kWHshTI32xMMqL6etzyMpvGzBK7+k9zfkpspbdBDsCgX69DQ/Ur816XvDag/We06ZXLvPqvSD51P1gPA7ZP86MH8bgk4fodW9HAvw5I7HfNqDr8OXgVKJ6EnDqiZT8/P//EvGGIMl/NU1ChOtqhJ/4+rnvzWvX1UZYutV9DjCfeWYeb3iT+PgeIr1hVdenAi+FpNO3hdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(39840400004)(366004)(396003)(136003)(5660300002)(66476007)(64756008)(66946007)(66446008)(66556008)(83380400001)(8936002)(8676002)(4326008)(71200400001)(508600001)(316002)(6506007)(7696005)(9686003)(53546011)(54906003)(33656002)(26005)(6916009)(76116006)(38100700002)(2906002)(55016003)(86362001)(122000001)(186003)(52536014)(38070700005)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vCpdDJcHHwu3DMvR6I5Te3QmZJGb1xzdP6SMZWvWmSg3Y2j8ZQp33G4kWppz?=
 =?us-ascii?Q?djLpbiZGYa1OylnurNdGFuXkcvLhaU7RvakiW1eZqMyBetxt6cnmQBy0Ezj9?=
 =?us-ascii?Q?KXLQPGGQuiOcGXhgoTOpM/PGXnipm+wzKj4EICHqqaEN/JU2GGWYs7SEKVaI?=
 =?us-ascii?Q?YruqfB5Ho/aBWDHhlEr3bNHAscSR7LW6H28jmfDn+cz71fDCK2BUJHF55RSg?=
 =?us-ascii?Q?6GgA8YvkQdee6M5JFYUUt0J8QWAQh8C/DUiR9PRddWdlH7yJw+YxbYXF8ded?=
 =?us-ascii?Q?r87GVA/oFSPEpGLmtg/az8chPE4XFUnyQwvcbhcPub67Wl4RFNwZhy4Df7nx?=
 =?us-ascii?Q?Tu4++H6Q0qlnFOJ7QGG8bfbzu5oNGMWwS7VhJGQ7mOFL/zfkzT3uonQgxIdT?=
 =?us-ascii?Q?hkrbIoYjNwDMpR7nkXokI37PVP61sL8MqgVQjDds2390zT7+toizQliGZdm5?=
 =?us-ascii?Q?U0tIgDP/onUk3ODUopQGHylak61wT9yWzisr6LqMj2oGyr4TxWpUfrF5CC+0?=
 =?us-ascii?Q?qMEqAS88h1Ad7u6iMFLHgS8dSQt7WkK/KnqZ3DQfrAZXFXN+kT6Aq6Xlw1Hs?=
 =?us-ascii?Q?C8a82CdFW+5L0Kvltzf4gMhVvj06bifH/ARk586yWRvSOsS3YO5BDbgFcbPG?=
 =?us-ascii?Q?aQvaB3cbonzAOeiBs7BkBR+qEQGcWwJFM9tzoBCnYTxKS5d4G51cOcYLHsb5?=
 =?us-ascii?Q?1bCenanXDZIlh7Kjk65o1kWQ91ml9vYsz5zzMpVdUL6ctTSkr5L3z/LHNosJ?=
 =?us-ascii?Q?UTB/SsqJKA0GAQx3BfCHSTe3zuuNXQfaEdfA5mLyJ41batsxO9gexiV7xWY1?=
 =?us-ascii?Q?TTHTqjx+uqFO6/GmgymecmbQ1F5fbDiQUHMrMkMGE5l0MCPezbv35XgZaNl7?=
 =?us-ascii?Q?TE0zKq/Z4dfQLwIKHgInq5CTNtJXnUhtLWV2XSq9/p37Q/E8hjx8++hV9T+G?=
 =?us-ascii?Q?1N+lQUEQQVBAnk+sVowfECeiTsJghg9967xvhWOwZhY/GJf0NzND2Nb53Lpt?=
 =?us-ascii?Q?lIRsFbEjmEQ3BAxtTQ6gsLqlgCofH3nl0Rwl+7CtcVkx7Z5dr3N+DsAedgDh?=
 =?us-ascii?Q?fh1OfzoOGSCWJwv59S2cHDhNCoaFEcFbM0mg+fDDDfZVhyQiyWMlML7TMQWb?=
 =?us-ascii?Q?jVhlTxzDRQAA8cSlGpgr3X7spXZsG0dLAtK+xRW8zRf8PdvuDQixVVvN+h/Y?=
 =?us-ascii?Q?nnho2mASrK+uN49WvZAl79PAxKotiPXo/8y/tXd3l+TdGTNIQCcQ06oszp+H?=
 =?us-ascii?Q?x7JvxtUZkgi/dyJu0B7h7iuXrRxLQR5BnHkdhRjWGohwNfmtfecyDvEFbcjY?=
 =?us-ascii?Q?lqXGtXwnwX9L0W9BULDX0SCYIZYywjS7pBb97mkirQvh5WfNbmnFvCmUcqUe?=
 =?us-ascii?Q?xS0QAWm5i1Hf0FZqAMdUudPHCHf9zWQzbAGs40GTX86eoyLeQOC+4cNvTYBu?=
 =?us-ascii?Q?gI8UrrBf8wPUJE6JrTjfGitGBeA9iTzDhIrATdDcbT74XW+8MYw/WQXv6zIR?=
 =?us-ascii?Q?bMHeOdUhv42M1lJDA8NrOOtdSB2JYtWm8WW0oFZKD4Ia85UOJYwtZFTKuqE8?=
 =?us-ascii?Q?FpHfCv6VlrZtr3ZDhPMgx3T8oSmTTuOLhaVMiIhNXCyDEAJLfB/oesdJLpp0?=
 =?us-ascii?Q?pWpqUzXMmmHp95PzTtykXdM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c38cab-3057-4beb-c93d-08d9eae07f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 08:53:37.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PH5cJGEyQcH90A8IeQfWjndQhZ/eR1/WnwDubUjY44uf0Wz4ASgzS/1iZJnQGl3l2OL6m93RoL9xH/bypA3TUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3838
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, February 8, 2022 4:42 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; Tao Ren
> <rentao.bupt@gmail.com>; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH] usb: ehci: add pci device support for Aspeed platfor=
ms
>=20
> On Tue, Feb 08, 2022 at 08:20:07AM +0000, Neal Liu wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, February 8, 2022 3:38 PM
> > > To: Neal Liu <neal_liu@aspeedtech.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>; Bjorn Helgaas
> > > <bhelgaas@google.com>; linux-usb@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; Tao Ren
> > > <rentao.bupt@gmail.com>; BMC-SW <BMC-SW@aspeedtech.com>
> > > Subject: Re: [PATCH] usb: ehci: add pci device support for Aspeed
> > > platforms
> > >
> > > On Tue, Feb 08, 2022 at 02:29:27PM +0800, Neal Liu wrote:
> > > > Enable Aspeed quirks in commit 7f2d73788d90 ("usb: ehci:
> > > > handshake CMD_RUN instead of STS_HALT") to support Aspeed ehci-pci
> > > > device.
> > > >
> > > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > > ---
> > > >  drivers/usb/host/ehci-pci.c | 6 ++++++
> > > >  include/linux/pci_ids.h     | 3 +++
> > > >  2 files changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/host/ehci-pci.c
> > > > b/drivers/usb/host/ehci-pci.c index e87cf3a00fa4..a91b25d216ae
> > > > 100644
> > > > --- a/drivers/usb/host/ehci-pci.c
> > > > +++ b/drivers/usb/host/ehci-pci.c
> > > > @@ -222,6 +222,12 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
> > > >  			ehci->has_synopsys_hc_bug =3D 1;
> > > >  		}
> > > >  		break;
> > > > +	case PCI_VENDOR_ID_ASPEED:
> > > > +		if (pdev->device =3D=3D PCI_DEVICE_ID_ASPEED_EHCI) {
> > > > +			ehci_info(ehci, "applying Aspeed HC workaround\n");
> > > > +			ehci->is_aspeed =3D 1;
> > > > +		}
> > > > +		break;
> > > >  	}
> > > >
> > > >  	/* optional debug port, normally in the first BAR */ diff --git
> > > > a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> > > > aad54c666407..410b395fe56c 100644
> > > > --- a/include/linux/pci_ids.h
> > > > +++ b/include/linux/pci_ids.h
> > > > @@ -3096,4 +3096,7 @@
> > > >
> > > >  #define PCI_VENDOR_ID_NCUBE		0x10ff
> > > >
> > > > +#define PCI_VENDOR_ID_ASPEED		0x1a03
> > > > +#define PCI_DEVICE_ID_ASPEED_EHCI	0x2603
> > >
> > > Please read the top of this file, this does not need to be added here=
.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Are you suggesting to hard code vendor/device ID in driver instead?
>=20
> Or put the define in the ehci-pci.c file like other drivers do.  Only add=
 to the
> pci_ids.h file if your define is needed in multiple drivers, otherwise it=
 is a
> merge nightmare.
>=20
> thanks,
>=20
> greg k-h

Okay, I'll revise it. Thanks for your suggestion.

-Neal
