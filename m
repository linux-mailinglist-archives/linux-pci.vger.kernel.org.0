Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3056B8A0
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jul 2022 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiGHLe1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 07:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiGHLeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 07:34:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652F8904E2;
        Fri,  8 Jul 2022 04:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JA+uLvelUygy/vQUME1NapjDJ+AJsetqS/EmE9R8VDKFZv7iiyGY5f2UsljqdrrOBFjCQHZbZWT+sMFLmOv3R8GeyZnsZSsKr8m0Gp0KLDUldB8HrPGEdBlSPJOjQf9yZSommky+l8ZyvuY60k4/+xRszm5+Nhtjn5NOd7087ktFfpMNvvMPtmPgSwvmOVIlZskM+4CyQb94eWwUA/sB33bejSaBeZrENp9wn5RcUv89vXPJEytAg42/K7Uu4818XZc57H3ey8bfNSVad+wCeDGozbPQnMjhfZUEiCN3MuF7QUUDGNq2EdXRuNqH/+dcW95YLrE6bOjWl0eTlMTQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53ho6A6hHU9EwbaBnTLWI8JEsFTVR/d3YJg7OyH4wzE=;
 b=epmWlVKKg9xUow+upHJnWMFSuMfG85XW8zCjgl6cnKRIRlOblrt9U94ls3oyRklVmG7NuXQgRikY+WMwGjKdOpxB/qCZTuSakc3PmbzstHLE1Z5fcCRJ2PCYRM5b8kdYevKNccF3MmKCOUdKmS4Nt1PvNH4v6W0qR8dQUSwYU2R6iAkVQikISjeX5UCte4LfzVOWtnz6r15XNOCanbKN4NxcUVcvoaateTKkhdoi6XA1cPxcx56Gzic0gtV5tCtaU47W6+v1ymPKQzXHM92mhDR2mSTas9qKcUxAXQXsCvT0pnL6gcfAvjik95T0w1olCnRF8+pdYx3V/NQoojDBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53ho6A6hHU9EwbaBnTLWI8JEsFTVR/d3YJg7OyH4wzE=;
 b=dVMgWUdpvgO/jv5L/V3h1wvkSXMIUKB63SZHf43XFtpeXVrXIcmRF9uMVf1mxrGpCJ8pZAT/BaVeU4PwVdz/k/LRBT5A1dHd2sZ5SJTP0z73e3BFNgUjLfWW63XlutGq8kZTC6iCUh6sdkkcwIpyjh0LsKAQGzWbUXhiPJ0YFfI=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSAPR01MB4772.jpnprd01.prod.outlook.com
 (2603:1096:604:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 11:34:14 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b596:754d:e595:bb2d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 11:34:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>
Subject: RE: [PATCH v3 00/13] treewide: PCI: renesas: Add R-Car Gen4 PCIe
 support
Thread-Topic: [PATCH v3 00/13] treewide: PCI: renesas: Add R-Car Gen4 PCIe
 support
Thread-Index: AQHYjSg/rpLWI1DEsEaZsQajRSMLyK10YIvQ
Date:   Fri, 8 Jul 2022 11:34:14 +0000
Message-ID: <TYBPR01MB53417EFE0A6DC5AF3D54A0F3D8829@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50cdd548-196a-4bbf-0719-08da60d5c933
x-ms-traffictypediagnostic: OSAPR01MB4772:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZzEv+T7X/n3u1+bpmppn5n3ZNSjNZB2KFoJgRCa7pq4TzfUdjBQOs9PD+dEDE+ceTEy69XPnU7EGSb5mcSIh31n/jZM9S4Pr4DK3tPiz3vKoRchhEfO3FckyZ7poSl+HfRsaLio8JHYKP6SNf6VJBaps0OCOxJ0GAK8nQgExLhfgM2IYXKlfhY0KtSNwfNxNIhS1UNy9YGypx3Bl7mH/AgaJh37bZpXJz0DviIM/zmxcj5wergdd+Ke30BkcqEh029fBTghn9EZUMs8TvKjLEqdUXw0gISLZEIDjEFqg5kTs2DN1sFhX8xDdXzLRsjLXedtV8/rgfz496THztGZHMs2fuzoj0wt4TZmKMOUg4czBN9o8PIBble5Dm2aCdhkulNFwIG9NlEOjzYNZV6KoPSUO6ZqkwXbW1uHAgsMAUUi188yYx+vfDKC2J2gDJZuZQ9X2PvwfiT+OBrgqYbVt4xhDj8D/YSB57LKh3g6MNTP4/Op4VGcSD60xFYAGgK6qfV22omLil0uaUSA7Ja0fXf87tcnm82TBszmQLw2bt6HJGF3eycLaDKAMs9xCkZoguYj1eN16n9XWtfiUR4grDc8vSgzkVxNscJIlzsvlmOKh3oAuHBFSaEJPgDaCptwGbG4z+zB6sZPFKBQUahCZCcB3fS6njVd6cjh61HXGFxwJ95Wc6EcGAvX/hOev4iVyZ/uJP/a1oYGlZ3q4MCemYZ1CFeoLa5siQkmXBBebQKM0U7Wtq4e3McM66lWhJfjqk7foDY/T10b5p/G/E1ScPwlhSmWf1I1rDONF4flMYckJQNGvDo/Wa455vJqv3ek+NUml0tvvIFtOSVqqKe/0q+PkhriyUhncB7syZhVVM56zz5Yf/0zcpk299Mpv+tI7NhfBVRBjV+6fIQCSpZ7PQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(66476007)(76116006)(316002)(66946007)(66556008)(8676002)(4326008)(66446008)(64756008)(8936002)(5660300002)(6862004)(52536014)(478600001)(38070700005)(86362001)(9686003)(966005)(122000001)(6506007)(7696005)(186003)(71200400001)(41300700001)(2906002)(38100700002)(4744005)(55016003)(7416002)(6200100001)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WnajW5zQSjH29JPgbCR0MWPlHzF4FfsTVVoIGGbdRg5g+8ABANysNOWeeiz2?=
 =?us-ascii?Q?JXRHaZaHY/TWGVNGKkDBS4cpdZTINezt0qwoa2TvDFBRKigh4uAGn6ItJIe/?=
 =?us-ascii?Q?o5l1Ss9PGoE5LwG5B4J9OoB/UxhWlCquTwtuzeK9K7x6Jb0TvtS500KI3GF/?=
 =?us-ascii?Q?RoJ/b7WwIRS9sPL1mnF2cf83Q6shcJIGXGF3j7+pOm5VCsth/BTEmPtG5v7C?=
 =?us-ascii?Q?RZpy6Fwp4Dk01h0Wu3ozheBHVlej8t05IRZo6OSe1ldstRgk+dKqV15GRcYs?=
 =?us-ascii?Q?w9AHm2Zks05on15kRvWRmdY2iOaWPCvSJM4jWVwobP9jI0FkSoRJkva9q3s7?=
 =?us-ascii?Q?iSk8rnPixxVLX0+SNBhu0Lhg8mYwlD2HzOgaBbsmhYNZENo6shmaMZ1V65C9?=
 =?us-ascii?Q?u1UbFg1Gn4PRJBVPfG1aK+aqMxW0PsDfgg1M5gt1BUQfisGgWpjy0BJf7V2G?=
 =?us-ascii?Q?XEmF8p0N+dX3br7i2cVdwERrCBRrHF3CXxw5nRAPEGfKx9xDUlTzxxdkj0pi?=
 =?us-ascii?Q?WnJJnK2TAm5jJSfQgVC4/hz/Qe4NN8qEeQGNDWlmAPAbQXpJLE9cAUVKqPJZ?=
 =?us-ascii?Q?I8kW+fkf604AOW6lSP5HoRkR1+Mh4BGXQxm+73BeXOPEq53avcRmWEdzETV1?=
 =?us-ascii?Q?3UboxSFF5fJGGu2AL9OnDNJcA4xCmOf2f2frZ7n2OAl7pch0dubv6bIks1/w?=
 =?us-ascii?Q?bXVdbs+r9ldZ+9hVMtfmM6V0vswxnrDbRtn4+5UgfIDIEdADvn7Wy9DXaQmO?=
 =?us-ascii?Q?QLI8m7juGYvuhBqzV+p604fJ90vv+J5aJuMGNvgQHtdTvmFXTK9D3gCH39Vy?=
 =?us-ascii?Q?NDq5e3xkRzQ8cAlhwwoK/P2yepXBoxiW6NLfIWOcDAnxMWjitKcJrwgk3yPs?=
 =?us-ascii?Q?w4n4tLIGdUD9ZKPwQfy501BCsW1jxo0qYpwvYkw3V2a/4czCoXAdw9SwCEVl?=
 =?us-ascii?Q?YeoMklyHNTGOoKSYlYgvBQjpNidXK3Ch6gRmagTnLFmd91N1Ct9GsX9w0B6I?=
 =?us-ascii?Q?jNuPRsgaX93NH+iFX7HAwOo0Vo/SfH4VzPF5N26k3MmWWJ8cqia5gfOCFSXx?=
 =?us-ascii?Q?+cl/LUGymqiFIFHwqxnrXMGEuByfl0+5KZTGrHPvzg/GF56tkpB9Zu8mp9px?=
 =?us-ascii?Q?QYK0ERxkz8HmkvD9iTm2ckVKB4xkH//ZyZuR2WiKmJzRXlIVv7zQYILQ1Qex?=
 =?us-ascii?Q?9JFYilU8BdkA43ZNKWnasVQXDmS0gFTwJl7GujejV6JPmgsrIbwJ6Vthtv+A?=
 =?us-ascii?Q?2fOmAyFXV0hgCSZhTBAoeWtw35KQzyxrTw2r8ef/3mafuquII7SA49/BSlKm?=
 =?us-ascii?Q?fj+bP429846KiMHL714wEym+PjlmtHc376HnTt69rW7RrHKPvfpkGSAnOGIH?=
 =?us-ascii?Q?YbHx6IbYacyvCAlywKixT5kPGihrG2SUJuvZKVRGFBwovP4eahGWpSVvcXqx?=
 =?us-ascii?Q?UTdUZVlygYbZg9k/OLE2zkQ69eu0TeOJtbaVSLGr3I3NOkVqIVChjU3XzkR6?=
 =?us-ascii?Q?7GStSixJRDJGPo3HpfwZrsTri7xJwoIB7TTMcYODyTecTdZjX7NCfuby1+ZE?=
 =?us-ascii?Q?XJd9ZYYxXEqmFkoPWGouiB9Rwgf1oV9azJLYomFiB+i++vLLe1woCrFH/Vkw?=
 =?us-ascii?Q?acDfP5030Ty3pC9twt7o51d+wdmaqQqd1e8sR35Vf/QFJJi2E30KlmDbl0HM?=
 =?us-ascii?Q?2PD9og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cdd548-196a-4bbf-0719-08da60d5c933
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 11:34:14.5742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iZ/ImaikXLgAr/BwwtTyH3U+nqJKaIwYyWDZZid1c4Zp8AJC1tQ3AQbFBCDij21lmGLu1iJIXs39MjbNO21WipIIg/MNLVq/MYw0ED9KhMFKbXbeGPL9sAoRe846IpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4772
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> From: Yoshihiro Shimoda, Sent: Friday, July 1, 2022 5:54 PM
>=20
> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.

I realized that Linux-next has some patches for dwc common code.
Also, in-the-middle patches for dec common codes exist on the Linux-pci ML:

[RESEND,v4,00/15] PCI: dwc: Add hw version and dma-ranges support
https://patchwork.kernel.org/project/linux-pci/list/?series=3D653624

[v3,00/17] PCI: dwc: Add generic resources and Baikal-T1 support
https://patchwork.kernel.org/project/linux-pci/list/?series=3D649194&state=
=3D*

[v3,00/24] dmaengine: dw-edma: Add RP/EP local DMA controllers support
https://patchwork.kernel.org/project/linux-dmaengine/list/?series=3D649204

So, I'll rebase this patch series on them.

Best regards,
Yoshihiro Shimoda

