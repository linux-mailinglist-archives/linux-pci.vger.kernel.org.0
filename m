Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F517D7523
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjJYUHL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYUHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:07:10 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BBE12A;
        Wed, 25 Oct 2023 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698264427; x=1729800427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3kcO/NhTgLAUDKCVbrsZsrWdOzZ7cKfHNnIFKi2c/Dc=;
  b=amdCJvwzV8EhlO29LKmqsrYEl1yHtvZ/Dgv3Gr8joQkMnsaAkqSeYgNV
   zilS53rfu9pL9c5FXAxssz+I+gkXZ5bhL4esXxsJLvh+yb59Y/Lud3J8t
   flX7m+3gDD1MPvPwyaMYYBB1o77rfIUbCSn9w1KZhaN83PJOOfKNsScvY
   /YeLSa1cFnVFzJVsRiiRLINdzOIJrlmNxA1GhNa3LM59DwrtxwKB2sWxp
   GPLVZD9LtB+UfDp4xWW0HAqYQWFqrVo8PHX7Mxl0ldsQ50Sn81I55MXvF
   RCZxfCRLQqOtZ2dj1/mL/Hvvn7ax9+sZlkO3+CtdlskUp2e+yM2MEYNsf
   w==;
X-CSE-ConnectionGUID: t0+Z+b1XQ7aoA0B62bvP/Q==
X-CSE-MsgGUID: Yy5g0OYhSTS2V84PVUH9JA==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="623592"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2023 04:07:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxifzgHQEVA1A1ZfxgmSAnPtqjLt187eZhPEc4ilgwoMWHWLy6nDJ2mn6qUCuLSfEYD17bmtBc7613wGafS1kHvveIlEHt8UJ5klMEo3ZOyC/uqGsadFb1B2JoVzj8C0ZszxEJkgoecyHl3H66D5QetDBWGoexN8uN2gBHMbIMk8cNE5wEgNe5DN53ZOq0Yuv9X+TrG3BClkF/Q0s2Fp/ktAbTgWY0U/jxz268PX1I77RqREnwEHvoXBIq3lrXGHt8qjgYg216LQukL33awYDKz9lhvaDdfLkUJ70wtLYaUbF2f96iyVjcV9KHMJJscVVd9anGUomSDtzz8C/ZjVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYT0SRoEWVmaJ7xzjQs7GGtWI2KXo2Fsr3HPU247HwI=;
 b=D14Fs6mcqqDiYEtv4MtrNryrefY7e5nxCjflwpRaDFb4vuW6ti9pfKd6658zTbZch5EWyzQXxK6bNdYrH6kEfVjlrBV+LC0Ap28ZrclRrcp5smYskuxxjjIASW0gsELmvzXxEaxhX33ODL9Zu96JiQ6zlsa40ipsFXUUQle/fCKzDyjXH/mqwN5vvNVWcjgX7Miw7VUac8yQfhxzbCbk6mdo0A4aMwNkJ6r+7N9YM5BA4Hn5rSeDXmcYa1X2f7/ZCElDV9Z+/nuT10hheAseV5uxP9uvQyC77M6Sfs++6F0xj/ik2d+N/Qz9JaNAcceHC/+Miwdyr241q8lorddmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYT0SRoEWVmaJ7xzjQs7GGtWI2KXo2Fsr3HPU247HwI=;
 b=GFMD6P9zMNZW9s7Nc1JaSJow0i5Am+jSYEvByre5rAcs5aFrpXvVmZd+o9V0m/eWm9oKua+GwlIRul7Om2DlI6OI2tU75sJyPogKtCBrBDPUiL8ykRww3rxUj9PSY9EGunS7kGoOLtTzdmkkamGTECJbLwrjYVI5RlL/+iTfZcY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM8PR04MB8056.namprd04.prod.outlook.com (2603:10b6:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Wed, 25 Oct 2023 20:07:03 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 20:07:03 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma
 properties
Thread-Topic: [PATCH v2 3/4] dt-bindings: PCI: dwc: rockchip: Add dma
 properties
Thread-Index: AQHaBoyNd+UCFjyqgU2gBHlMOd/MHbBZIasAgAHO3gA=
Date:   Wed, 25 Oct 2023 20:07:03 +0000
Message-ID: <ZTl1ZsHvk3DDHWsm@x1-carbon>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-4-nks@flawful.org>
 <20231024-glacial-subpar-6eeff54fbb85@spud>
In-Reply-To: <20231024-glacial-subpar-6eeff54fbb85@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM8PR04MB8056:EE_
x-ms-office365-filtering-correlation-id: 0f44cf07-7640-4635-ea3a-08dbd595f46e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4zm6XPigxdq8yIQdMr/2T5SQ81Eovmpl26hQe7ux4EGdc8PpX2axZD4qMNkq9ruMoTW9wQKypqalZxm5bTMmZ0+85hevE1SrxjUjcq6NsJssdaSNVembK0/EoDe04U6XQ+uj2x/tEk0nnhaDXz39B5Q5Y/HT2XckSlwPS97DrPpPthzMohOW+d1R3z3cVCEqZ6lbPHSAcXWYoY7QNIMipzEkxtZ6WGF/ECMzXwCNjgIaYVdWfEG53u15d8tylgDNv+PDesTWwJD3bUyM9RoZZb3s3UzcgoqZev5qbEghTnfl52t1V7QWKfKCLJqBc9V6yFwOftT+/xs5O62QsXTbH9OEjxCl6/dNY+iHNGQQKn/vr1Eamn3araiHdnsxk5h6IEFC7tfCY+4zDNYUgbrQh1OccVJg4vUJrXPDPwxZ7hil84ICKjRCT4vVEkp2Red546mXnoCbbLmkLoPFGnc72ZQ/GImt8SGg1ogLCDXGsmqRF1xU6GAssc3IYkM6AJmlk9Krg5nTKBhHwMRfIJAD94RLUKnVvzn/9pXffQ5ff+/Jn3uPNLtlmz4TvKYPwn4hnw+LBrIrlzP+lyUfLn6AH1XK/G/mDhn3m/DRDS5gS/oYBC7rWtWLUKytm8tVGvi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(83380400001)(71200400001)(4326008)(8936002)(122000001)(2906002)(8676002)(7416002)(6486002)(82960400001)(9686003)(5660300002)(41300700001)(6512007)(6506007)(6916009)(316002)(91956017)(478600001)(26005)(38070700009)(86362001)(76116006)(54906003)(66946007)(64756008)(38100700002)(66446008)(66556008)(66476007)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?q8A49jL5VQLL77p0MM+TIXb/Voa/t8mi74Mjm3lNxu6oUQANtXhZTCFK76?=
 =?iso-8859-2?Q?baSYWOBB827icmoXqcoq6sVViIeyrUJbT63+xz5gb7qEwUOftmzuJ0OvCt?=
 =?iso-8859-2?Q?ElGNXgPunEqpt9SJlvPgpAApDe4EN2/zvO3E+h0//OOSpy+vuluWqioeeE?=
 =?iso-8859-2?Q?Zu2XmB9ZA9mNDDGIjjdmRUJ6PXgIwNg01LMDtsv6yke9lfGOyOHBNb2eU+?=
 =?iso-8859-2?Q?suIsDNDIlV9E+JvY05RO+VAG9g+BULG+SePBP+SIXgzjOafFZsIn6Dv2ph?=
 =?iso-8859-2?Q?fmvKXq8cgDDYgp2E0baB2MbS3pDq4O2yJ4jq1M9c5zCleiYwTu6TPzW9tT?=
 =?iso-8859-2?Q?g6oitDdJCoYNE7aLNiejtHu/R9gWT2c5/5bcwpqPdqIWpxwCRjWmzdfs47?=
 =?iso-8859-2?Q?QmcQobM4aY48mhP7Hn1qyLTI2TZ4kllwtjtODQtrdpDfwHwdSUM4CFSksv?=
 =?iso-8859-2?Q?1qNx1B2NwdawL+7A6djf0TbwPO4+EsyBD0P4iqPO4Qk9D2TB3Y3hJgBY8q?=
 =?iso-8859-2?Q?xsIllJr2QMh/Gn6RscGRPy7et8wOjA0VTBAbcnvwnQTRFTaUiwNiXdnYrO?=
 =?iso-8859-2?Q?WqTLf/ECAerGMdwNXoTQcS3dM0QGQrluQ6+9JFrozYz8c/rY0ZHudTGttq?=
 =?iso-8859-2?Q?XAkbACQcK0O06jC/dup95I7rC61+8bsrB8vbIfmfuqoQO6+wAVQPZH4z0+?=
 =?iso-8859-2?Q?C170KcF1tNf6su6J2fv45o2igyvgDFgSlJLOJtSFiB8873tuEDwDRFCHhX?=
 =?iso-8859-2?Q?l2u/MjsPE811OjPXSQuYQx/bLMZ0JFCGWcXqTd88+Ol40X8F2MLJ8LGRb2?=
 =?iso-8859-2?Q?L/HLFGnSFE8KAJxLiacE259n5j8wObgVj4dAOMRaycyjDpixau/pVGMj7c?=
 =?iso-8859-2?Q?Cxw2KFzQvO6LFar2tiSYFN66RlQWNzLhmNfK5zBGelLfG34EV4mqdTBx6P?=
 =?iso-8859-2?Q?T6Kwck3ZqJ6VFfDNGhXEErM0y7Z9wTJktqpkbdEtb2iWHmhCWj2Hka1XcG?=
 =?iso-8859-2?Q?VfVf3x8qXco+wLA2kcsAK1lMm1gZsaQbLFtu87YBpy+Q0sMMdxo3otQDTU?=
 =?iso-8859-2?Q?e/8LY7qExo0RholNbAytkuyRLYehVExUCXDpy4CItwgF0xzcGWW0CDkele?=
 =?iso-8859-2?Q?U3ts9tP087N9GOnQPAZpgvbGyNaVEV06cTJIi/zsi+DF+BF+DZN9A3G76b?=
 =?iso-8859-2?Q?feOIr3kWcP6WgF9QXXgQgO1JNFHouYbAtGe5pdFd3Tnh4eYNu4Vm4puJ9o?=
 =?iso-8859-2?Q?zjzwXmuBP643iZS7WtqjF3cISlsLw+f6asyeToj1dTtyo/a40lkEQTeYsc?=
 =?iso-8859-2?Q?iLG1rLZ+RRbpvSgSO8wgHR3p9n8DItSTcP4y82hIcomiOD9xkBjmtTAXZs?=
 =?iso-8859-2?Q?0zugEz+BCt3b5OM8n1q7z8FUQCAC6kI1LbuKSe/9ypBOT1Xc3W4m6goWMs?=
 =?iso-8859-2?Q?+jAWDf22uxvkQ0eoUhGTNhCKk7IHdzLLq/kZ4QXzkBo0GtGiNBYDIv6Hup?=
 =?iso-8859-2?Q?Jan6PsFZdfJKsQbd1NjU2rEUWRYZTgO+0LWbltno4ryPJSurDbyZdvZuyy?=
 =?iso-8859-2?Q?Me0rkjHXB5XhWLw5P3hB0tRamCt0YYYmWdZinuRCnciLFg9TqJnGUnmivu?=
 =?iso-8859-2?Q?6wOqaVM85uzmjsY3h4eiKalTjqfRvhQFJJHSOWkWdtE5rovsDzblprPQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <9E0D7D041433044FB2615C1FBD1BE483@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?3neZKicrfllqMneJyuOkNtLNCAhzVeAAU3aCnOQG+HjrJOoktbZ6FaxOqU?=
 =?iso-8859-2?Q?7yz+a79F6GHJHW9xoLLDoxbR3k7HZ06ODzCE6ZooOJlDmrKmtegiEeRB30?=
 =?iso-8859-2?Q?THCYarhwnDyHiK4U5tkbekkSRnJonXjObmJY6fkk0xeGGuvZeLwjf6evs8?=
 =?iso-8859-2?Q?MT1rpOERxe21of7ArYkCHpD3Ekne/fhYeHTw04wm8bBv0rQswbQUYanqKJ?=
 =?iso-8859-2?Q?JSI+9DQlruRIa0HmklGqMjMjQMTJefhX+TXmRDIYlkl1tSIjj9DUEEcawC?=
 =?iso-8859-2?Q?+uM3AVzh+S8IUAyiIzSMABFRe2YVZi+XhXSTJUbvmYGv/+Izhrkj7MhEkg?=
 =?iso-8859-2?Q?lIkfP54pJTvmqQTvf2QthxcMlUaDlP0LdbMeNVzXhChXpTQSZELyQJZjzh?=
 =?iso-8859-2?Q?XQu+sbuoM1lzFeJK2j+MiX7sEvotD2GmKrX46oCLTx0SjPBtRAEC255H5q?=
 =?iso-8859-2?Q?jI1s4ld8FHKTxrfKhYyEEziWDeHM6GAb4W+hWirYevSbbEo5lQ64RUPa9O?=
 =?iso-8859-2?Q?1UvIsONJLq6HoO3BjaqoXXOjhqyAIvuZ0zhN2BqB94LRuV8a5Ar2/S7uuj?=
 =?iso-8859-2?Q?ExqJm08KpHN7igkA3GDdPagJWGWzByFc3wTtMCWMoObD04O0TNoouDePaf?=
 =?iso-8859-2?Q?4pnNCn7MU8ej0X++2+v8ZcbnugHAWn1/10musF5hE9R5rHagZOtupstQ3O?=
 =?iso-8859-2?Q?CfExMKhaP2JRV1FqC10QgAJ+wkaArhSI2h1zUve3Q0hxHJjgnHFSEDc8sS?=
 =?iso-8859-2?Q?9I9hRnhquUm+/4VroadWm3gZGTaMThzxQDgS7EEnEyG4VWcUTmqAYcTe1J?=
 =?iso-8859-2?Q?Bijm/jr/y14ggy6p7a0/NNRo1+PI+ohOIrJS2cNkH3Ianul/qwk9IQfuDB?=
 =?iso-8859-2?Q?eT//t4CxuianO4IPEJmZsnBrQh72CS1z9+c/VkIrAOOD3OKELwaeLNfGG0?=
 =?iso-8859-2?Q?i4+exRzakAf7CrSo94KcfGArTQ3cWGD869wiI+5HBaSIGU9RP1LGGdA3rA?=
 =?iso-8859-2?Q?/ByQEG61YeBtV5kuwXKuCAclgKLyBxUGpdIhU7639ecXHByxWhRS/7nwZT?=
 =?iso-8859-2?Q?CFFyq6XBJ6lZGv81piOUTEZuesAY8C5kFE7t0dYm9Hc1j3QYhfUcxMjny2?=
 =?iso-8859-2?Q?P76dJdlg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f44cf07-7640-4635-ea3a-08dbd595f46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 20:07:03.0743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /taf93JJYDg8JwfIyjToWNBeR/y+r/t7ngz0hUXLcD+JWkUrICmKBwsRUk9j157iLSxjCkCSGepH+pQlQjNX+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8056
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Conor,

On Tue, Oct 24, 2023 at 05:30:22PM +0100, Conor Dooley wrote:
> On Tue, Oct 24, 2023 at 05:10:10PM +0200, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > using:
> >=20
> > allOf:
> >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> >=20
> > and snps,dw-pcie.yaml does have the dma properties defined, in order to=
 be
> > able to use these properties, while still making sure 'make CHECK_DTBS=
=3Dy'
> > pass, we need to add these properties to rockchip-dw-pcie.yaml.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  .../bindings/pci/rockchip-dw-pcie.yaml        | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yam=
l b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index 229f8608c535..633f8e0e884f 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -35,6 +35,7 @@ properties:
> >        - description: Rockchip designed configuration registers
> >        - description: Config registers
> >        - description: iATU registers
> > +      - description: eDMA registers
>=20
> Same here, is this just for one of the two supported models, or for
> both?

For the 3 controllers found in rk3568, this range exists for all
(all of the controllers were synthesized with the eDMA controller).

For the 5 controllers found in rk3588, this range exists for only one of th=
em
(only one of the controllers was synthesized with the eDMA controller).


> >    interrupt-names:
> > +    minItems: 5
> >      items:
> >        - const: sys
> >        - const: pmc
> >        - const: msg
> >        - const: legacy
> >        - const: err
> > +      - const: dma0
> > +      - const: dma1
> > +      - const: dma2
> > +      - const: dma3

While all the PCIe controllers on the rk3568 have the embedded DMA controll=
er
as part of the PCIe controller, they don't have separate IRQs for the eDMA.
(They will need to use the combined "sys" irq, so the driver will need to r=
ead
an additional register to see that it was an eDMA irq.)

For the rk3588, only one of the 5 PCIe controllers have the eDMA, and that
controller also has dedicated IRQs for the eDMA.
(It should also be able to use the combined "sys" irq, but that would be le=
ss
efficient, and AFAICT, the driver currently only works with dedicated IRQs.=
)


Kind regards,
Niklas=
