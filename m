Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F411638563
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 09:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKYInM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 03:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKYInK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 03:43:10 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80128.outbound.protection.outlook.com [40.107.8.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9977B12AA8;
        Fri, 25 Nov 2022 00:43:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOrHHzJzRgOp9VfX/GuU5W9JI5y6+Y5eZs7xODMyVKMeOiVFv2YovJpR/dqQy+yromJ2mOqR/ATsZUixp19vB0jpS7wlGTqrcnqgDTqYRzNab5WmXK3LfULAH4zxK9vKZXh513Wnvu39NEho5CnR4Wt9286nuQUfUmlvgiPM72vK3rTG7LbtJJDlda06phw/+W0+Dyoo/6qOhpZwYH0n3Xb6gh5XixbpABoeANvbqcvkz5Ob/db45tNNvXQQRiUnrTlvrwOU+/iYfsH9aEqYs5QYoUZFhxXDcrpZy3YCy+n5fnS2OXDjdZ3OI6ci3t0j1uOairBHGXswsJ6ol6N5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szc0ADDpXLu83B/wbfyhqxouDWjSlxJ8OFja7hxlBOM=;
 b=Zl9dLtvCY+t/kpOpYzpcusdGV5EFxPfZbrXQkypSs3rbvVzXxjLt0n/z8UdnQCt/Ufi7bi91ocIhM/vCZ8F4eFLE7sU51Cnf/QsD7PzEED8YYVBK4GIT+OCk2dPqHuUEIvdwr1+ylhANC4pc7ifZ39jpjfaMHntqm1+9F9fjzfovEhAIgDzX2eFlBe9FRTpB+le6ZS1S2KQPVAj58f4KthH0G5T3nTOhzUfYNuIGnH0Lc8LENhNWEWLo8EeMyFB+5zZ0jSr/ybL8a862+j4aAUYAGQ509SSaudFH4XA3gT5E/fQ26znevNpq8bqhE/mArKJ6IxkKS9oVGRGprXJCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szc0ADDpXLu83B/wbfyhqxouDWjSlxJ8OFja7hxlBOM=;
 b=bft9vRNr99POebvf3xPAIqnSRnjHkutXheWRSEA+XpiMI+Snzz813Z9RarcWUBQQpfjgwe+ECsFs7hHnE8TKbjDuJPFDEJcgKZZyUZP8ywrdgIRVLA/z84iI4YfG8HT6DeNDSxsFxJwQjvnHu1K+vf9civiMu2JR6bHzB2bLX4w=
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB8P190MB0681.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:126::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 08:43:06 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 08:43:06 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>,
        Raz Adashi <raza@marvell.com>, Yuval Shaia <yshaia@marvell.com>
Subject: Re: [PATCH v2 2/3] PCI: armada8k: Add AC5 SoC support
Thread-Topic: [PATCH v2 2/3] PCI: armada8k: Add AC5 SoC support
Thread-Index: AQHZAAzjcfQU8p7QjEyDUSaQnJgyba5OKkSAgAEoLUg=
Date:   Fri, 25 Nov 2022 08:43:06 +0000
Message-ID: <VI1P190MB03173DB0A16402C8AB670D91950E9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
References: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
        <20221124135829.2551873-3-vadym.kochan@plvision.eu>
 <20221124155817.5f372417@windsurf>
In-Reply-To: <20221124155817.5f372417@windsurf>
Accept-Language: uk-UA, en-US
Content-Language: uk-UA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1P190MB0317:EE_|DB8P190MB0681:EE_
x-ms-office365-filtering-correlation-id: 49c83c81-0562-48ee-3b90-08dacec112b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LU9fI4DqkTLVpMTnAf/v7W5ZdYXw4vqLWJGuqdcRpqVHyfMRegIOYmrMeyOCw/+5T+oPrVX+lfDSfE9dGBBiIn/EYl4P9WkQvT3q1mG7X6W+Iujo39ZeAe/QVSWc585NzRU/tIzQQirdZSSB+2S3PQ10U9fgzF0lMRi6zUR9BUq2UZo0nNjaXb1uR6dpDDOLqj9/HUi6N6nguDXFRp4XP//PZFOO1Y1vnsqRXPgiGGbC0IMN61pN7I5sX8Y9W5zqwGJZTgRHRZBsrvNzXe3DwlkVnHvagaHSA7fPURzCFB0QHBF2o8JgOTrowHv4ysuT00Ml53buUhTaiFNXPOgP7wLjcsjW3n6g2TcH2YLiGNHSX2gAf2mwQnkEw8qIucQOnJJfM05D4zix4IqKMuV/gP24ZSSXOMfCiIl+/VPy44XpvO/8sGpBQegYW0GUolp1cJe8gJSseETku61TLwB0mSDhszbNAioUkm/lJ8Hfwv8L6DdJZlPEK0u6d3OdLJNbEPMACjlTCTfeLNQfzU1Q6gI1QB9sdIgT5nVpo+UQzm5gdMtxFLnCH96qPrawvyN9DN5+bG8bCKOAo+JOIMJSq3BsH13PlLltJgoL9mVBA9EE+PVeh1EVM3lM9uQEB6Pa8NvSwQghRS7OOXrH6dkmh42J45TE1Xw2Jtomp1ZF0SftE1fVkdZBrAPNOcjMpEGDGe7S9r/j4OyLlrUCpQnqNhi7ZGZzvNNiKqo2R1kXlRhMKKqDQBzv4KE09MXMCpjq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(39830400003)(396003)(34036004)(451199015)(86362001)(122000001)(26005)(38100700002)(52536014)(38070700005)(2906002)(41320700001)(5660300002)(9686003)(7696005)(6916009)(8936002)(186003)(54906003)(33656002)(4744005)(44832011)(7416002)(508600001)(66946007)(55016003)(71200400001)(66476007)(66556008)(41300700001)(316002)(76116006)(8676002)(91956017)(6506007)(64756008)(4326008)(66446008)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?wjBTjkCSVZh1BRyoWHsXKdbYwQUmz4EiHTnLEfmJV/wsF06rYyo4nQKKC6?=
 =?iso-8859-2?Q?aZVQ+ZtgDUO6XJhmZw5NUTRhmxxxHl9UKXTGipZw0LNXlV3phe38uBkad9?=
 =?iso-8859-2?Q?6QOrVESDPX67KbnWPghrJP2iePXyoaERDbJlal4O4y1dHT0hTP03DY6Dg8?=
 =?iso-8859-2?Q?zHJH51nTQhTfJtMnk9sVnNg3zUFIzS7Z6PCt9jIEHpTMy36TUD9ShTsmgL?=
 =?iso-8859-2?Q?ontdo1OGM5Ko+jZbvGP8luCp7X+2EfQfnXrTPpnpgb+kMIdK8hYSHdGroT?=
 =?iso-8859-2?Q?CwKXhUkUSIxyQzhQlf/vDXcyPxDVOzoS/8GGhkeE2N6ZdltglUuHFNb+aF?=
 =?iso-8859-2?Q?Tw1Z77xCDmtyGbYCkazNnlW99uQ0KLzz1zFVbqFpRL7xb2DE8JlmLeIOVL?=
 =?iso-8859-2?Q?lLohavbE2iuRVBU1tUdzT+W9F2iDW+A/pLWVe9p1G3eReTujZ6B3n2DTxr?=
 =?iso-8859-2?Q?z0N4LeRsj9pWIN28c/3S1nLggWomVCegsCeRTOSr0MDUYXZVdbflFCPuIy?=
 =?iso-8859-2?Q?0kL0Ih4sYnqGNh4ksDapCHliS+KUZl/OutPweG1v01Rg85Xp62Uzwc73Bk?=
 =?iso-8859-2?Q?Ut6NTRE741CcoMUJwy3HNj9uh5XzMHH5vUwVkpRKvSI2jE1Tas+0/pPBoa?=
 =?iso-8859-2?Q?z7CMVfxpjxEnEnm00nDPVdnUysZnKSXFCY1F7xQ1gpFIqiBg+qAt910NQ2?=
 =?iso-8859-2?Q?3CA4HOpWbAVa1HxTCyc6YyF38yk79jQtSsyRrAChOepdi82xCq6rW3jp5i?=
 =?iso-8859-2?Q?S7qGazfhJQlnhDRxyKMUesjUUuy7Yr7JwiXUxMuHLeFMs3/LOfCP3rGrAJ?=
 =?iso-8859-2?Q?youbzKvlxuIHmjnpX5v7ntYZVhvLpMvZaNY5NtJiLSfAX/rFDvklPz35Dr?=
 =?iso-8859-2?Q?6Y2Wx7amgsxlrYvzcnd5BaoOa0AyJAkKx0CVR9hNJrjnxpQk3Mj1q7sZ7H?=
 =?iso-8859-2?Q?nqKrxuEcjpXuw04vuqbwxk2sV6WT2fieEX1qAJP0bwlanv8KueRiNTA3Hn?=
 =?iso-8859-2?Q?pdOFm0VIEW6FWTaUczLmUy4CGSbUFnNI1+0mkPJyM2OOg38XI1LRVczVkO?=
 =?iso-8859-2?Q?iNKmvoc2qwBmBFUIKISYuiXg8JMIkmKMkUl2mBt5bYRa1EYTVsiYVOcb7Z?=
 =?iso-8859-2?Q?6zyNvNYKiBZ8427jcfOHeC4jXK0DH7SnQKJ+edq6YCH2cC/SXc0hsoIm8I?=
 =?iso-8859-2?Q?OD3EIFLf/YT7ZI9wYje2pr13LE08bsLZgROwl0pASvViLoJudkHnRNZLtZ?=
 =?iso-8859-2?Q?Hc1NZX4+xPUEJpu+O+e3eXVxrWNN4afKO9uQt7+81DPWwEYYDjKFb7qvbM?=
 =?iso-8859-2?Q?H8j6BDbEf2AlS17VtbVoFGWk98k51tl1jXieI41uNoARH0ZM7HZAzba2WB?=
 =?iso-8859-2?Q?CfPJfVB7xhUNJgK7gRMKLDe0jEuzvFVbenKMSOpoplSM9aUF+WNxj/EATQ?=
 =?iso-8859-2?Q?q6f1s7B/ikYMzRwW03o6nqoAhlc3hrRGP4ONvKgrC39sMDiMSGm1BSWY7a?=
 =?iso-8859-2?Q?FzA7MplEPgB4mcocNe12pPZsLYAcYenn5vubgv3WowlpmNkQMdFOWGerLH?=
 =?iso-8859-2?Q?Efns6M7pSdabbBdVP27oLztm6D2bqYMrRKp6tBa/g6x9ITV3LCMfHqExBa?=
 =?iso-8859-2?Q?j2f3zU4BBrVkHzGc0MZ9VA6IG+xm+yncX/?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c83c81-0562-48ee-3b90-08dacec112b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 08:43:06.3623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sgaugey60Fzo1QQEgXOQis+5DrTfflfS+NH5t9osI4edCkSygcBmCe5fl7qQcY6qbknEjPZpmnH+N4t4mdH8QcB6FOazKcbEShBRbqaPLDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,=0A=
=0A=
> On Thu, 24 Nov 2022 15:58:27 +0200=0A=
> Vadym Kochan <vadym.kochan@plvision.eu> wrote:=0A=
>=0A=
>> -static int armada8k_pcie_start_link(struct dw_pcie *pci)=0A=
>> -{=0A=
>> -     u32 reg;=0A=
>> -=0A=
>> -     /* Start LTSSM */=0A=
>> -     reg =3D dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);=0A=
>> -     reg |=3D PCIE_APP_LTSSM_EN;=0A=
>> -     dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);=0A=
>> -=0A=
>> -     return 0;=0A=
>> -}=0A=
>=0A=
>So this code is going away, but I don't see it being re-added anywhere.=0A=
>I don't think anything in the code you are adding that sets the=0A=
>LTSSM_EN bit in PCIE_GLOBAL_CONTROL_REG. Am I missing something?=0A=
>=0A=
>Thomas=0A=
>--=0A=
>Thomas Petazzoni, co-owner and CEO, Bootlin=0A=
>Embedded Linux and Kernel engineering and training=0A=
>https://bootlin.com=0A=
=0A=
There is a reply from the Marvell:=0A=
=0A=
[quote]=0A=
this is not needed, as by the time Linux is loaded, link has already been e=
stablished (by boot loaders)=0A=
=0A=
So this code is not needed.=0A=
[/quote]=0A=
=0A=
Thanks,=
