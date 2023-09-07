Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341457974FE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 17:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjIGPmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 11:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbjIGP2d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 11:28:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20701.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::701])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11593170E;
        Thu,  7 Sep 2023 08:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGDx3YDd5PuGhKtduZs7NRi4yHXW8kMr5Maub7WwTzygw2/OM5KBzlUcACxVqJVH/uAxx799CHo8CbQNqusTFwZnnrM2BHM+PAxp2tOOon1EpuF1dSnhhAMertCVKECwJAf8faPYn1XGkIN7ONs27aEZsopSuDfxYVjrkHQDXK5Qyz/eHrE/e7GKncHzR+uNkaCDYWEg2UqSxPYQBHHFn5gmNVjQq/0NkEw6waMtRVKCXLq1PWu4HaBZMHIEteTxKqrpu6tMztNUYRpawAuMItZGKI94YVOBEyQqdBTMBC2CJk/iukmeaNmLrG2UQ7KEJq3q314Qf+157eW4lDgUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPJ3BPVmE6qZ91tK/ezBfIlq7mrgEETiWghah5e6no8=;
 b=MKiDAiju5mJ9udNqbz7hMmSxhspFqPYBENiAP/eb0r9S3sxdaYy6QX/V/pdidcFPjfmwdG96C8kBzLZR4AMSODIcnqmc1U3Iyopl/PcPwAeK8ySbqdjQ0KgnhrEBAp0t9RR8C04JgBXqNvj6HpExf1m1pPbYO1b07pNPNjCxC4cHI0VlJnrWLMO13J+p5bp7+Hn7Feriwz/taQBIHsqafO8rbn6Zljqb/S3/LRR2PiYPn0cQzfR7Cc0h7ptAPoNfw9TiGF2zzzB5uj1ux9PUyOvt2HYnuU7R7rzh1+Hj/sN0iJDbNVd02zMDBpaE/kah806b4BhJEPLynT8GHADzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPJ3BPVmE6qZ91tK/ezBfIlq7mrgEETiWghah5e6no8=;
 b=RugcbUiiDVOgJPcnFUskeF3oyJ6g4fgMe7tTUGroFyvjAnGdZyoNLw3CtBjHqqHjcUsYDTq3WaJCbRT1yVgkNmCatv7A2X29ncU6ScnwVV/BD4Apla7dpRt+mNOAIlPggM3j6BWCkfnNE1m/mWKZwOX9bl7GjWmW7g8St1MJsZ0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10457.jpnprd01.prod.outlook.com
 (2603:1096:400:2f9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:30:06 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 11:30:06 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Thread-Topic: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Thread-Index: AQHZ3Naplycjp7NP70OsPUeoiqAJOLALp6CAgAOZ2hA=
Date:   Thu, 7 Sep 2023 11:30:06 +0000
Message-ID: <TYBPR01MB53418F2DE6F7C871164763D9D8EEA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
 <20230905042259.GB1102453@rocinante>
In-Reply-To: <20230905042259.GB1102453@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10457:EE_
x-ms-office365-filtering-correlation-id: 1d93150f-174b-4580-419c-08dbaf95c911
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P98ZadpUH55tubz/AL10tafkHMC40JSoZd63+gw2Qb3AKZhvc4IpuhabLnpHcwCzL0fBW+pHx9x65LniRBtvnwB2m7sZCGOv2O/uqbF79WN/OIUdOqxlkBjFcAfIqRebnRU7T+fxXRAJFwnB3NDk7bauX8EwKRYln4nQkMfvkMiq1pmbQTJ2hwHAdeeQ14HYPAziCBVsXagov33V0xmRIORiGzumLHbNRL0p6mZCi44bU7iSzjE+GjMzIv0Bx6ChOQbvreDq82Wxlb1xplhgLE84J2TT17DevQEcrcpM/4mqRhdGVyaFsCrs6nLxNnlbqzZEdv8pUBtvFX2ldhWQYeX7fnCt8Afz8CxFVzXQvPhHEnCF4Y+0f3qZZjCKnNHhnhkUINq+eT5R5+FnQDdto5SvSBP5c4wVz9oQklWMLptCT9VkM7fkvk7r9xqjQz4culOJNbHG3alSOp7+uTiH/OX/fNoWM8Hbx+ihU2tyFZtmGd/Lpsd5QO9ncYvNLnUC4JONTMh2vC2walHt+H/a9dpzGkrqUgOROtu1EQ+kx62n8xH7YWyLt1ROuRuAe0KwTP+/VqOtEzwTmQDpURYsmbvXEk36y0IyXEz27e1dZgauLxlBHGg/6OvVr93ErDLWsW9YSEkjoiN/v78wJAtxYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(6506007)(7696005)(9686003)(55016003)(122000001)(6916009)(66946007)(54906003)(64756008)(38100700002)(38070700005)(52536014)(76116006)(66446008)(66476007)(66556008)(5660300002)(7416002)(316002)(33656002)(41300700001)(86362001)(4326008)(8676002)(8936002)(2906002)(71200400001)(966005)(4744005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?1vDFe+8UebJy9K9to5UNLbITSOQSMoxJq2XQVNQ5RN4zYhg6w63AE3B7P6?=
 =?iso-8859-2?Q?QO0njh17yperDxJhclXSScxJ54b1fkG6UnvgJoJIPfRxcu8rrUODdP9WOx?=
 =?iso-8859-2?Q?B3dhcjLGTXsInDx9KOWYRwRgSEpuBowM81oMdExciCQ/CoZu+u52r4c0tD?=
 =?iso-8859-2?Q?F5ibmPwDzn+Tq1a6HUrjwYmLfjFgS2mUpOfItJpc5hNfAJUQTmEGBzP/18?=
 =?iso-8859-2?Q?w3aDrtDEfPcQLhKFbRWoTIMuCiQL9bHjGwEGgFZsqTWHW6nh4dlfl7zV9O?=
 =?iso-8859-2?Q?X6xcfe8lYrjp5jYH8xO6bGPR15lpyS5sSZnlInADzJkVbDZZABeoYAnW5e?=
 =?iso-8859-2?Q?6MxBe49laIiarW4Lm1FWFqnAMB7RMgDZaMSLpanvF5UVLQAibjyqtaFOpf?=
 =?iso-8859-2?Q?gSzNSS9Gxi7fRXauvMJ3ztof0B8MSXQszspzu/E2wYRDQa1bvY1HtW/yA3?=
 =?iso-8859-2?Q?r5jYkE9JkYk7+5NsVt2l4Mqo7eejPls4uvMjDLjH5cXHHs9JIOBFUOAtgA?=
 =?iso-8859-2?Q?pZFR+gbEagDmOdhIVccDi7ovqVhI7eTrlU/bFRKg5c4k+lPL6VdZjkLYeH?=
 =?iso-8859-2?Q?0kZGbpauuIyk7uCSXlp9M+1OWjmLboMyeiUaBmR45chLPt5n9HZNTcCNbU?=
 =?iso-8859-2?Q?MDsy1NnmQu1QsZ01e6g+IrIg/Fu+8rRMisorSVKI7rDto9V+4iKRu+vZqT?=
 =?iso-8859-2?Q?GJP/4vxXOK03BA1ZdVoARVmMbnqPAES1Bh/xDIjd6koxfEpYcwgpfT+m8k?=
 =?iso-8859-2?Q?q+jh35v9b63Wi7PhUyvr8hr5bQdJKjC9ex/09m+fM1tjujam3yydGC7WNp?=
 =?iso-8859-2?Q?x21hMnyamkVOQo8CezqbNz2AmxM8/Xtw2cxm+BQMu/lLrue1lM+WmqSl0T?=
 =?iso-8859-2?Q?hn9SK66OiEupAEPD0jJ+mAHFslJ+YqVCG8OL9MqKN2fju1wUrJ27T75/+D?=
 =?iso-8859-2?Q?Kd45bNpRz7xB7ukzzcc9CYAsVZW8ymrcqWdrE5kiJsn+clebMUIIch8pSn?=
 =?iso-8859-2?Q?18c51Vf9KeIrb5dkWojxanI9cPnW2BV+T0i0lz2f6+/GYhU0FiUTLQHetY?=
 =?iso-8859-2?Q?R/UUlFLkreOhuvTWwd+VQeoQBBA5HZxzVzQQXgLfS2vmnC+tjWKU1kjkzl?=
 =?iso-8859-2?Q?Ng4P1kkIscQ0tX/l4gcnbFnOEO5xA+FHkLJH8ndLt9CJgi2ge6Ib/RmkG8?=
 =?iso-8859-2?Q?nR9z7RggCt0zd+Uhue00WaKjv9An0Ak+kn6pMuGThqNvFvoqULsORTiZ/g?=
 =?iso-8859-2?Q?HSquaSM2SnKPa3Z8ifYdW7ZXvaSchNiCUm1BNabbSIJT1QUMFxvqLnjbUQ?=
 =?iso-8859-2?Q?7l04iUMIWQtAc6xsOIa2IocjQrOsBGl0QDV8MWPfHpedUmI0BvIVzHyj4S?=
 =?iso-8859-2?Q?4NPlwjQ4ontoSqC8YT/AAagLIaojlOA5rlF8go9aAW2FL0ywTYGeXXNYgj?=
 =?iso-8859-2?Q?Fidft3RXzaq9ZABTrg7T9G+375KEW7Em9r9GtejCIv9+vd15LG8bfPCLUi?=
 =?iso-8859-2?Q?iwhd9x9pa5NNI2HuV/8SZlEFwKhBOmM+qigsPyTVQM8mUkkwN47DxEdlLX?=
 =?iso-8859-2?Q?2QhHdSJhTR7E8kVlh8L/nLz1hYUKrE9JSAKOWn43a1PILFXx1MvuMRa2WL?=
 =?iso-8859-2?Q?/915JgZuKxc9Zr8kYDMc1x7X23jG1rIcAtuQvseJabFFZsAdYYvQb5LfN5?=
 =?iso-8859-2?Q?VMql3wVHEu0SAT74k/xy/WM6BCcbIhcJSvkdrueEIic595ypPSpr8DxGWq?=
 =?iso-8859-2?Q?IhJA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d93150f-174b-4580-419c-08dbaf95c911
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 11:30:06.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUKy7cDMOfgWfwafwIh0ee4wxqoOxEALEdtTK+haW9yuavAmGVdJr/a2laTb3gm4tlDk6X3dcR2hCH9I7rtiv/fk/EW3kmS+RnOnoeJv4M94VZ08q5BIx3EMifMYoGuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10457
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Krzysztof-san,

> From: Krzysztof Wilczy=F1ski, Sent: Tuesday, September 5, 2023 1:23 PM
>=20
> Hello,
>=20
> > This patch series is based on pci.git / controller/rcar branch
> > to fix dt-bindings doc patches. Krzysztof mentioned that the paches
> > will be squashed everything later [1].
>=20
> Applied and squashed against prior patches:
>=20
>  - https://git.kernel.org/pci/pci/c/554931ed3795
>  - https://git.kernel.org/pci/pci/c/d828097a0bef
>  - https://git.kernel.org/pci/pci/c/c1ff8c2d1a8c

Thank you for your support! The controller/rcar branch looks good to me.
However, I realized that the controller/rcar branch cannot be merged into
the main branch now because conflict happened. In this case, should I send
fix patches again like this time?

Best regards,
Yoshihiro Shimoda
