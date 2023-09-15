Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165FB7A1AC8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjIOJia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 05:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjIOJiU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 05:38:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2124.outbound.protection.outlook.com [40.107.114.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE10270E;
        Fri, 15 Sep 2023 02:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCjMPfFTZPwWQCaFcWXayzgUI1hs/N+bZusoBVfnNao9PGqn0Flx67elyr1H9zdmqzYV0kgm/ohZKndmKogpom27pM63Fmtxf62k8MyQPp48VcVoScrIsD6K7UooC2z5/gnTkZEkovaJRrZkFA0xxLy0OtFXOqo1l6h0aRxCtLt2pDTKgDWuO+XSvnJaDNTYVsBhyHSQUvi6Q2GGlLZ5j7UYpCMCDWXDZ4Z7RkWkv2ffUavcwaULB2EnoHbKNP4MBoN/RGFsZMjB5qAWRhSe/6YWBXSv93gd2pnM14uKs+6dLocihtzEFukaS3RSOHp/rrOwXMdeQJkHfTuP+Aglpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jajXXPi2RPeeJrnJfYTRCUu9/hVf/Xuk5xxm0WWBSzI=;
 b=D0tNSsKHyhFIYtj90EpBKYSd0fxtuKeYG8q59dBvzLVj+WBYSrbJpII9MOhKup7DGNktQCF4KslTxKmGAUqIL0UQvppPXxQfaLob2U6jE7VOI3pCME49sGSHiQBkMq+Rw9+rdxolM5VqupkyAm0S6Nr2YOJTG31FWtclliK7ErvrKuaAq78uf03mDDDVnah1gnTMtDKl1dVGT8+/JJXpjPtBRpiCHA9QfrV54nZybH1nfP4pjP0FSx5NnX7Ep84gIKrqSkHesP6UUA+dQoDAjsRM5rjWroPmIHs+aDo4TW8HrVevbhM/jKlRA/DgRMHjAQ5wXLwYZK9LY+HAL+desA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jajXXPi2RPeeJrnJfYTRCUu9/hVf/Xuk5xxm0WWBSzI=;
 b=iVrfFy52MYgVnvLAUjZ6ZMv1r37Q9mD1Bw+riFbDuLH9kZeHxXsDqeS5XHdhXZnqMB2IOf5oqv4XqsLQXZ30ex2b+ky9Gt+uRe93fyZPiXWluNk9SrR6CMr9oj8Gz9Jwx34VsACdhro52rKcGwZuAvKSXQB+WxIcc1gNH5DJ0uk=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB9608.jpnprd01.prod.outlook.com
 (2603:1096:400:19b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 09:37:59 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 09:37:59 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Topic: [PATCH v20 16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host
 support
Thread-Index: AQHZ1zcPesbymzM/EkSeMq7i4076ZrAaqwsAgAEW/UA=
Date:   Fri, 15 Sep 2023 09:37:59 +0000
Message-ID: <TYBPR01MB534155F5DDF8006909DB0EA2D8F6A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230825093219.2685912-17-yoshihiro.shimoda.uh@renesas.com>
 <20230914165852.GA37731@bhelgaas>
In-Reply-To: <20230914165852.GA37731@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB9608:EE_
x-ms-office365-filtering-correlation-id: 5cff200f-05d2-4742-745a-08dbb5cf72ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: czGuspz7qnwQy1nmMqGmo5eqCZALwHJFHahocyjlJNrEFRWivELtq3q6y69/ZsoO7Egpd588no0DEjJKVAbivJm8kubykQkTkDlTB1Alr5N3i4f+u8Nb8RJVI2HUezcRlVZk/CDvItGkeWAqEQV2VSoGEw7yQ0Ajrj+itX6avVSDC1tABaSyL3iJHHHFVLpt4w73uMx4/qnGGE96blYCXpnxOLk6ofDW0q8U4gTM1scvdXKME0bDA2ySPxFvOa6/7Ag7mwOQaLtrJGebPMf2P70vxG5beqNv1xZNPhHBWMvRvm0wXQy3uE0lUKudfnj9uz8BT0Y7LBxUDSxbxN2KPgjDJCAPY11pmbDBPinTr1+lYRCZBi3UYG5FOvqNU2AjC0cf6HkBAEmaJfESn/w73C7FFpgWZdwYeUB0fkOjgBlAjtG3qw8lDy8sMRpOAeb6V7sQqTyGxjC8F4FExYieyfnT+UtuUPlwrWNT09TIMJHZpiBQkwFmxUir8g2+eBZcaKc6GiPdY/ZTAbOIPCcToHXQPx2BbyyL30dEEx8oLeRBQR+3RapEMzxO6iAbwoWtXjUJnQoiVVpSmR1vcDhJxGzS5z95MqD0g/5Oc7imv+B+T/+npWxVRIWlZ3qTOi4M
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199024)(1800799009)(186009)(122000001)(38070700005)(38100700002)(33656002)(86362001)(55016003)(9686003)(478600001)(7416002)(4744005)(2906002)(8676002)(8936002)(52536014)(4326008)(41300700001)(7696005)(5660300002)(71200400001)(6506007)(316002)(66556008)(6916009)(66946007)(64756008)(54906003)(66446008)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UeY/TuCioPfakeqjawiwHWQm2YktICTFpnWsLOnOUgbTIReoRt7C52IylovX?=
 =?us-ascii?Q?57/9ckoNwMkq1ul+RNqRbsHBdnBGk4Iwd7fHmf31KO1v9Dn4ZtT5WIC7TqAL?=
 =?us-ascii?Q?ehCDykU69BJcODlF02tIMn1PWmuc8UoTQk+7PBsnkqcxR792ibkf0mlRdsyX?=
 =?us-ascii?Q?TNlhwYNnDcE0DvMWpWh9+spZa5xXFJNbJfKw0Nomw0h4F32GqoeM31uEeBYe?=
 =?us-ascii?Q?QyWf6vkTjABvWzHOq9E33xfgL15lDMQlzxKM8LW9coaT+3rsuSUOCBZIgUzD?=
 =?us-ascii?Q?vRb1HCOcv7vb0Xo7ORoN4FMjaxR8HYYCF+q69l8A2Dug6dXNEubCDmCrPKJU?=
 =?us-ascii?Q?ShIl3ovnpE2++qKrE5DtOKmiNQGTO61czy9eCrwO/k/vH/JMThMYWKmlFKZ6?=
 =?us-ascii?Q?NDPuogT6FC4zHpMmZSLL+KRr1Ac1CoIubSyORDHistQ94I3f84FPzrvM0+eH?=
 =?us-ascii?Q?btal4kw3vUViJYGpLeDJbvrUTWhzWXhR8Wq62X6HtFYgnrMDXvLtfnibEHwz?=
 =?us-ascii?Q?9yg7U4yaFirWrDFbjXMhqUTRa70+hzeTjshJNF0A5ORA9yvXtwP3PEKQipdv?=
 =?us-ascii?Q?CpxlKAvARJW41rC1kWIwBcp8fw7U9bO8Hg1cwBXr5D/StF9sDkKjhCujZCBk?=
 =?us-ascii?Q?ZFgRMAlVZ+AkvPbI/+wPPuBcjtLSC2jHK2tobVVHGMLzdGQA/xkX7yDyS1Uv?=
 =?us-ascii?Q?AO6UszpIqfMJznsCOKVPKOCKAHJUkaa2dUb7tWFR90NLrWkPUqhAv1G40OwU?=
 =?us-ascii?Q?3yP4oiq37/VndmHF9gkivyqe5C0zcknSd4yOZVPjVq4NtN7PbBX82kiGiPR6?=
 =?us-ascii?Q?0y/c9F3Umv5QrRrQsLKemTQnBAJcXTlp762Ua/zZXNwZ03XxLNq6CWkQfagC?=
 =?us-ascii?Q?vNoytB+AJC5XmisehdGezU9W1o58INRhDa7Ri9AvM/fiU3ysBAyDTLV6sWFL?=
 =?us-ascii?Q?YTIvW3oTYj+amrBwoe4O9b2v1VzZwShoFCAo+gfyel3Q2ozdkfXFRQlmaw7F?=
 =?us-ascii?Q?DROlEiynwyBlrEJBKX5U33Ge3ctgMjoQ+/6olLrbOKu8nt3/ynK2uSp9Ak5c?=
 =?us-ascii?Q?2rvnwT4HfImdug1CHVNMutkAj3N2D0EleZpAdY0wfITnMN/Jydt0g0CTGoH3?=
 =?us-ascii?Q?8e+2Hl4SEUSm9AS1AljHSU63telk32F0rkwkDyci7UXVh1e0tCqhI+UHmFal?=
 =?us-ascii?Q?PZC2PwlL+4h74aUkOVpWalDkfQVGW4KQt108+m71cgtnSzf1AsruuGnHTnDb?=
 =?us-ascii?Q?WAK509aOrVdlxIgZDwsC1JGLNGFxUwc6vy+ewZ8rv5LCbHF4cwB7RsXU2BP1?=
 =?us-ascii?Q?aLRTGZwMwcjtUKo4FBIJZwq1EhI5msjcP/ynmlPW8rD2W66M0fFeEyBFGikT?=
 =?us-ascii?Q?nZBvRt026iADQsBUXwDlDcqL93q6iTPGgZj/7YIbeBxCkxHBCCnMTDqPVT5r?=
 =?us-ascii?Q?3UHX8Z8zKJujOvPzxrJdK+oQIpaeUlXhMTmNsYGchbtlk/950kjfq2qOpHyc?=
 =?us-ascii?Q?cG1VfLVjzcGBpHksvcDKzSKN0B/16t2flmkLXxUevEm6mksVwAxOMEDlYVhS?=
 =?us-ascii?Q?3zhIhPQIUCiGypvY/LIBh+w5it58SqzgCyzgLpQ6EO0vOYRjN/UikmCpgeXF?=
 =?us-ascii?Q?VoUNdNLCGjx2rFgY/hHPWVd4BmC3hznKtduPOmlncEOByDzdAMwxp06/CT7G?=
 =?us-ascii?Q?+IGL5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cff200f-05d2-4742-745a-08dbb5cf72ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 09:37:59.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUYRbyjPEbBgpCT3fjJC78LWzu1xQjWiRkyruhq+Sd7+8nwewUyFskVUEdSQ2Sb1uL10UPqXxkBrAw7nGmg5ZW2f3T6Ab7raBknvrzdpeGDwk2/oGwS+fSdDjpRdXKnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Friday, September 15, 2023 1:59 AM
>=20
> On Fri, Aug 25, 2023 at 06:32:16PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe, but this controller has vendor-specific
> > registers so that requires initialization code like mode setting
> > and retraining and so on.
>=20
> > +config PCIE_RCAR_GEN4
> > +	tristate "Renesas R-Car Gen4 PCIe Host controller"
>=20
> The config prompt that matches the other drivers would be:
>=20
>   tristate "Renesas R-Car Gen4 PCIe controller (host mode)"
>=20
> Similarly for the endpoint driver.

I got it. I'll fix them.

Best regards,
Yoshihiro Shimoda

