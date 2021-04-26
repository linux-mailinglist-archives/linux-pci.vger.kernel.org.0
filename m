Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5E36B648
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhDZP7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 11:59:40 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53944 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233829AbhDZP7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 11:59:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QFnZVM025635;
        Mon, 26 Apr 2021 08:58:37 -0700
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by mx0a-0016f401.pphosted.com with ESMTP id 385hfr2ec6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 08:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8T8hA5JnTicvHWP2+a8Pd1Kb06UdQIhuBjb8T2UrGbb+dTlXV1cen8KPdz5jzey65vbK+yoyA/ZLjEku9AU2v2nleTSUn55ViLND7XzSMeIX3+l/WfQLJ7SWTNdOmgahDOjvAQACJ3s3SVzmarv2Nz+wriCR3iUGvBKqxpmlXMSMJXMIkxw3rpj5zd0Q33XKBzWZ8REu0DXCHp07aldLexNe5YjzKtmq/v9XZAXcRxQi7YmEFVXet9iP+cOz6SDm29mtq6s10w4cOSlbb5QgsBXWW+cnuhJiF7NKpJ5SfafiD3G+Fgw24Gpi5UrTbt8T85IsAMLTEG++Mbped4ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noImEgONdxYQDRew3rq0wGkBbup88pNrDwDCf/g1LC0=;
 b=Ouo9VodpzxllDKDUoX8gQIBcocbkMMx779VWP8n5XCWgaOeLmww+QWlTNNmrhu4bCEai6iXy3h+55L1K/2f4AtE8BTeR4wzv8Yv9mcrvUXe8+nDV6c/KzNGebT0H1tS3RAk5U/dYKBGCElvji3h0ayUct6eNQYjnUxiumRKvTUJKiY7xYe3WKO07X0YmtcuaGtufyS4M43JiYaXW68KbVMWDe7r9+fw1sL6KgxUuqYupxJxYgMRwBG0WKdKnk2viBsZdDWBLNYv6ZmiNtLfe3WPzoofuBOLLiZ7B/o1gMaTRrATBKpkC4q/7tbndlyUL3N79YJEb3bKAh8SMYiqlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noImEgONdxYQDRew3rq0wGkBbup88pNrDwDCf/g1LC0=;
 b=ZJjTus52XCK+hbrwynQp42wJwxYlhiEvg4rVChKlMkrWAFZpSBnCK/kSvx5G8x2GMeqNCOf+S4ECwSIN/C+SeiVEQCkqm3V1Ob9K7qA5Xx9BSkpLpD+kCifPeFMaTr/ANQLnsY73+y7TEfQlOHBsMemlUxI31WoFuVI+pEFlYsQ=
Received: from MW2PR18MB2217.namprd18.prod.outlook.com (2603:10b6:907:7::33)
 by MWHPR18MB1197.namprd18.prod.outlook.com (2603:10b6:320:2a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 15:58:33 +0000
Received: from MW2PR18MB2217.namprd18.prod.outlook.com
 ([fe80::3811:5dde:7523:bb7d]) by MW2PR18MB2217.namprd18.prod.outlook.com
 ([fe80::3811:5dde:7523:bb7d%3]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 15:58:33 +0000
From:   Ben Peled <bpeled@marvell.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Ofer Heifetz <oferh@marvell.com>
Subject: =?Windows-1252?Q?RE:_[EXT]_Re:_[=94PATCH=94_3/5]_dt-bindings:_pci:_add_sy?=
 =?Windows-1252?Q?stem_controller_and_MAC_reset_bit_to_Armada_7K/8K_contro?=
 =?Windows-1252?Q?ller_bindings?=
Thread-Topic: =?Windows-1252?Q?[EXT]_Re:_[=94PATCH=94_3/5]_dt-bindings:_pci:_add_system?=
 =?Windows-1252?Q?_controller_and_MAC_reset_bit_to_Armada_7K/8K_controller?=
 =?Windows-1252?Q?_bindings?=
Thread-Index: AQHXL7DzV9BZSTgeukWdZ8fOex8fi6qyjtKAgBR6YcA=
Date:   Mon, 26 Apr 2021 15:58:33 +0000
Message-ID: <MW2PR18MB2217D165D4E0435888525310C2429@MW2PR18MB2217.namprd18.prod.outlook.com>
References: <1618241456-27200-1-git-send-email-bpeled@marvell.com>
 <1618241456-27200-4-git-send-email-bpeled@marvell.com>
 <20210413151013.GA1683364@robh.at.kernel.org>
In-Reply-To: <20210413151013.GA1683364@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [62.67.24.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4ccfa77-2a75-4897-8191-08d908cc250e
x-ms-traffictypediagnostic: MWHPR18MB1197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR18MB1197137BEA1AE0955FC6664BC2429@MWHPR18MB1197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZbJoIc3KanlmOjbonomFEcvo/0hwibZTwztwQWw0Cm3TVPqozpqQDS8WClU9wV/xI8BrT5R1DG6Inl1YhIIoD6Y08BrHu74piG0fkYUoBFWl108e9pcWOkz+aikpKSftgYlDlUhHtZVOmjPU36SWMrb+cqafip1hJBd29zLa5uPvXNPSm7MZGv/xbWN88hpb0+7YXQaIkhKIoKnHc5lWUeeoXAeAYVnnMjOaPV/aH+L9RPw+viY2hXVW4MDQAx8hOEelZ5EyGUmniQBHRQ9Qq3ofEznnj7y2iF/TCChzRtmFg4WuoxEwne3mylBeU3q1bN7w7peiC6UHE5mp4p5uTGP74Cfq+D+r6BrxGYK2gJTUUVPDnJO86EL0nZMeonfRfKB1sv0tuf6mSlSfQF/ANBxCyYhUg7KjV1JhHXQ5/rMJNKAID33Nqiew2jQ+CwF57inAhoqDMhwBch140h2/W9cmtcasQpDuJT/rTHbnRIJwKnkPEwiTRzbDkQcSekJtHVAqZTE5mIsLH0K+pePYrb4XbzI0FgDlSIzWdLsjP6WyGsc3O/X7EwScSRpTyjBOUrwD1eztt3x2fu27KWQW/dCkGLXggIPWYjpZCQB3No4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR18MB2217.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(71200400001)(66446008)(316002)(76116006)(83380400001)(66946007)(4744005)(478600001)(122000001)(66476007)(38100700002)(6506007)(52536014)(7696005)(64756008)(86362001)(2906002)(33656002)(54906003)(55016002)(9686003)(8936002)(26005)(6916009)(7416002)(107886003)(186003)(66556008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?bbwaH7f1v0ruhmTlnc4FF0sHCm8eClCfZMXG3/6Y1tmj6yzxs6grewLH?=
 =?Windows-1252?Q?VH9Rl2m6YiYt6Ewv+sycZfLQazzrz+Bn0w72LlTkB8nTy9oLVq2uYQSb?=
 =?Windows-1252?Q?f2r+jGqE/wvt7lBT+OY6N5wiuDG19bQprPOW/YlrQQlM9BxxCJl4ckRC?=
 =?Windows-1252?Q?2dR4LBI/HS8nEdTdd+vTI3+QKVqG7NK/0WiwT+VlTD2Am9q2qa5xkSW1?=
 =?Windows-1252?Q?hHd6FUH4UmFzJqyZTvDSP/re4GND6kyceRxGzcx5MzYPkJLlty6ZQGwZ?=
 =?Windows-1252?Q?8WX+39Fg1Bq4RrFc9x9Xj33bk733PR0ovq5hAzFtm0QLAQZIDYEjYS4B?=
 =?Windows-1252?Q?OZYgfwIoCcExRXVzqCAkgC96cr9nbDDqokSSvAo0hFXkEb8QshKlwuFf?=
 =?Windows-1252?Q?yLAJbcWZiRxtoV7n6nfnu66MoT7iWxospRxHQn6e4RBuKoI3LFf5eIOS?=
 =?Windows-1252?Q?e3w7g4NRQ6b5r/w7AZrC9lycztGh6/7gIiDt0AnFWkU509eID+dzOI6j?=
 =?Windows-1252?Q?6fJ0rD8wjjO/hEyE6yckD6j0hAHVk+kuX82RSJzRy8IcHWN3l0Hijjz2?=
 =?Windows-1252?Q?m9nYm03PmASPwXooJB8jQqpA9mKJfXgFiAWlabQWVa/ZqveFgJCT7kyC?=
 =?Windows-1252?Q?JxDPahEGQv/La1leZzquVv1VfS0h0wTXJw5Z58o5glti+u0hl+goqE74?=
 =?Windows-1252?Q?66egCdpQddg1VHBekXNvcHU5qTG117QlI87/ONFtyQf5jgMgHhTEoJyN?=
 =?Windows-1252?Q?mDG7C9pp0R2pNKhqQYnwkIZN9kcnkZHXIUiOIEHBuW5bxYtkTWR35vDj?=
 =?Windows-1252?Q?l59iyYKfQOy82Rdl+TXDhFDBFLX7CR83G6QHBsl9FmxWOSYqHFoRC1wB?=
 =?Windows-1252?Q?cligRJw3Fvc0XmWeRx0Cg5JCklPfD6A1zx9gIxoSc1ArxeKDT/z3vJwE?=
 =?Windows-1252?Q?k7FlczlmQHQMKoBhyF8q0t221ZpC4PQycZ+D2NcoVE+Z1dhlKrVZNSS7?=
 =?Windows-1252?Q?8DgiLbrVZWpt3psXijs4XtluYms7qbv73quoClZ5oBptL4IKLijD79tA?=
 =?Windows-1252?Q?3OkIhMiTmXjm/SM0kPtZpDOKc3sFFdmCTesfm/R6Te5nTHUhs/GCV3/y?=
 =?Windows-1252?Q?3+/fvUrR6qjMkg/ltHNv21KCAKHPJfbOSNHTWTjnjEe2lyQHVzLuRzz+?=
 =?Windows-1252?Q?fHeUJjOq5Bwru9H58H7ObZEcL+eaO3BOuCumELTEfy8tzoAhmhCZRiMH?=
 =?Windows-1252?Q?Bi1BMOLJURgRxAwr8Q5p5nWpEI5w/2cVxL4xWu+Jfb6+qxJv/p8D6o27?=
 =?Windows-1252?Q?OTexttO2O/cOIWlm8Uf0CSp0CXoVeVJPGUh+HaakzV9N+Cju+6oavVuL?=
 =?Windows-1252?Q?tev7JDvDJ9avalyZvrBAzhR3+SJnSrhYg80=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR18MB2217.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ccfa77-2a75-4897-8191-08d908cc250e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 15:58:33.4995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vG1PaudPrXFhvVq6K5zIfL/zcwTtyzn4RgE16+qbuGbTbco0oC1JyQ0ULFcs/is2tL3ycBa+RE1iGpZKJwvPLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB1197
X-Proofpoint-ORIG-GUID: _3x5YMFMCYQt-zZnzSfbUA_kv1LA_QEF
X-Proofpoint-GUID: _3x5YMFMCYQt-zZnzSfbUA_kv1LA_QEF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_08:2021-04-26,2021-04-26 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,
Sorry I missed it.

> > diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> > b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> > index 7a813d0..2696e79 100644
> > --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> > @@ -24,6 +24,10 @@ Optional properties:
> >  - phy-names: names of the PHYs corresponding to the number of lanes.
> >  	Must be "cp0-pcie0-x4-lane0-phy", "cp0-pcie0-x4-lane1-phy" for
> >  	2 PHYs.
> > +- marvell,system-controller: address of system controller needed
> > +	in order to reset MAC used by link-down handle
> > +- marvell,mac-reset-bit-mask: MAC reset bit of system controller
> > +	needed in order to reset MAC used by link-down handle
>=20
> Seems like this should use the reset controller binding instead.
>=20
> If not, this can be a single property with a phandle plus arg.
>=20
> Rob

I will fix it v3.
Thanks
