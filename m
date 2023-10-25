Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79367D7512
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjJYUCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYUCk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 16:02:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F74B12A;
        Wed, 25 Oct 2023 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698264157; x=1729800157;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wtPpaLhxvAhcdXvXXkbDHUis5DOzOKJTdPn4HCRkqNA=;
  b=mRSaNt7D2q/fiHXOJL57kir9/1OChcmJUGCuMWni6boWCo9uzXIyPA6s
   aINUwzJlkxAZdCZ0aPVnSJ9ALn1F7VECUp9Fxfd1UUbpu0yeFgkjQsNsP
   qvcSH/J15Iz3D3KoN6s2/LKwjkFjzrwRya/vcgTB/hpAbKoxQ6pNGrzXq
   wQ9+INnv8SdTZTbzZkxjS0H1lztFEeS+yGoEXsV1fk5vfnBab1qS/yQG2
   1fF5kwsldZFH5RsbDg/OrhdnTYppMUEFxS2uXkGXARUjJGDPfCfCWfTvq
   uUZQ3HzfCm3iyBJDMMJtmUBP+ClbZW6Ahh1VGv6fDObFRUogYlCdG1EZr
   w==;
X-CSE-ConnectionGUID: lTdDOzPaSA+OhnIxGryl6w==
X-CSE-MsgGUID: LoVQihXFQdS14eDH81VgMQ==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="597560"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2023 04:02:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5PwxJyJQiYzvX/dULNmYQey/OBZsVSsKezHm/xaVTbX/7rnnGCee8w9QmsTqS1j+/huB2ry8ePq1031x8YAz4TKpyKAxDmPZ6RSv2QJpQ5aVmKKrMFV71ddBcN6svPoIVlwHVvOsr8SPYK7j7KgSbSJ6NVkUuOGtdvo+G/F+2kBSZHuyY0BOSNvyigCBG4axSrckptZLO0EaqBJ/jLMTPW3YRRlx4WcPPmN/r1wgmZD/LDeP9WTyH+qObW8muxe+0/cgSym2wLBvN3pussoCf3hp4OBXrXuw49JnjcuUCiIiZeF7P/PCvXP800Plg/UO22DKskwtUb8xTU6v1Mz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJTvOUfAzL8EYQj44B3GOAi92EKlw9L3KWIiCqb9irg=;
 b=JKO5VCEaQmoyqv4iMugxBRfz6hchJ/Jr4aRia8SiAWN8qmmuYjIw1UkHWcvYgJEjLPoQGqTSi8qYTuU18bePwNUJfDE4EdicpK8kzXU1LQDbiRrYqThySilpuwTf1eCbOyh7ofxLj+So5ilm1mnvdEJ0kgoX1aiXFzSXXWjpuiZuJc6Y0IAp07RWI+Y5W2I2ll4e3UdPzSQsqR7jJ9HhaknIk/hIE3BB5Y3GcEqI6Te3pgEEU+hNJQbz+0+D3reo6a7WfKI/gQsUQUEipLj7vvFxIry8p00kx6pKV5pmlJ5Gg/K74y4GWt9mQJpLfZSaBXDsA+q918GcA7kocxqnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJTvOUfAzL8EYQj44B3GOAi92EKlw9L3KWIiCqb9irg=;
 b=HXK/0tsz2DZH6AsJrftR5uDNPRoL4JhWOYXA/URdzITFTv/0VSIFqKovACRm8pgjs0ToJ7IMdT1Khcfk3BrRob2YxRAobP2jyTajRYEx0tcoySGdL2tSKkHnOr9JSvvfwglqX+c8+iQeHm1kGOBGgpMm+cWSw3mr4gt9OJdPim8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7647.namprd04.prod.outlook.com (2603:10b6:a03:32f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 20:02:32 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 20:02:32 +0000
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
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Thread-Topic: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
Thread-Index: AQHaBoxoQTs0JHhg8kWC9n402P+JBrBZIWsAgAHN24A=
Date:   Wed, 25 Oct 2023 20:02:32 +0000
Message-ID: <ZTl0VwdFYt9kqxtp@x1-carbon>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-2-nks@flawful.org>
 <20231024-zoology-preteen-5627e1125ae0@spud>
In-Reply-To: <20231024-zoology-preteen-5627e1125ae0@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7647:EE_
x-ms-office365-filtering-correlation-id: 80e71944-3017-4b81-4c81-08dbd5955331
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+EGmi4csEzR1OZ9hSrNXh9Vbq8DyAlLd3Z5podNN4UAKP8nFwKku1S8UfUQup9cDD+y/JHrQhcgnyVcly9XYLRpBPB4gyV/MV6aKTMb06+Lv6xDwxQzdJu9H7qyChruqjWs1MjEV0jcWXWagIAP+jZECS//ZJJIV6FpT4U8mD8Sv580FRZafdpUUd9PGZCTPCB3YDprEwcwLDcJ22JzziKz0Ylq6j6K4h7QikMPxPVN7axrwSJSby1PcNmz0luB0pWYc2hW+0/DH3xsEnoX0+DCoQq+bY5DwnG9inqMN0zsEvl+nji4XdRLAZbyaar73ku0GbC7hCyGB8W8V8mZXlmrXxdqNp7ERig5RTG3ybFFR7CnaPUS9fQD/nTvyFgwvAs2YWYsJsiRc+N3hC4JiZBSp/bLb9zQube2daqyl2gJ32+YVKc3KWyX5uS3sOr8OPgxPRzug8ss+c81JjNfA3yRKUtEJDhnaopVBc32tIFLk52pBNZFG8trE5V4Cb06RV34947rYceEpmwYbyVdsUC29fdsiIX3bCFIvbbnNt67lgZR+jKh/wD+yDFEwoT4FsXkpQGEVTntsAU7R3l2uhINWuvEA3pOTsPrfXRcfMI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(38070700009)(33716001)(38100700002)(2906002)(41300700001)(5660300002)(86362001)(8936002)(8676002)(7416002)(4326008)(6916009)(54906003)(71200400001)(6506007)(66446008)(478600001)(76116006)(64756008)(82960400001)(122000001)(91956017)(66946007)(316002)(66556008)(66476007)(6486002)(83380400001)(9686003)(966005)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?70KH8GFbYe9ledh6PTsaCW4IW5X7YzIrVa/ybPe/xFIvizgpqwYpBSxoH1?=
 =?iso-8859-2?Q?xFFm71Lq6CtP5aXtFJ1xLlNLCm/tYSR3IG9AgZVxDDu9Y3RJ+iUfckvzzi?=
 =?iso-8859-2?Q?Af7qB3ui/PdJpfe/XCWGB6KVqVQa0iOwxKAU0JiP67f3mCPbF6t2nRiBtc?=
 =?iso-8859-2?Q?hDGQuviI2/pKo4XmM0wMw2CXkkNo7ieeTym2JsIzfjCSZVu2UHERFqoAjc?=
 =?iso-8859-2?Q?WLi6UGGV8ODhMHwFZOvKx7soCyMTuzGslzOxEAHTSQcJEjj3K4gG3+F/tC?=
 =?iso-8859-2?Q?+VR07oZm2hxNO/Qch/gofKiT1/ewidmIta0NePgBdLml6uGdFb/e8jcn5u?=
 =?iso-8859-2?Q?jNFT6CdQdQ4GwN7GL3T0AY6HjSh1k5FLmhj/2hqQwO0zTo1yyVMkH8l5Ev?=
 =?iso-8859-2?Q?TLhrCOgbNoSSLk0XgXL+rip6W6W9u91TKgSp7pmVZqmyQlQbdM21XaJHq1?=
 =?iso-8859-2?Q?oNOo7P721EtOfHc9IbXjTjnyH2IENPE1aFIEGfQnFb/ly6qJRQv/NmwH9c?=
 =?iso-8859-2?Q?HpyAuaqxFst8Wi5T2xMkSCJWHdOT6rbK2TSXMbVcTLWc4H9iWfW1dDTWOd?=
 =?iso-8859-2?Q?HxK7obWuiQvdUtdxNJucw6FoyQ6fRLwNplzNjH00kegLZ1cVCLcTO4u8UN?=
 =?iso-8859-2?Q?tUhEwmVX4igFWe4vttuYax1ENnEu5HzfF7Ux9OE12+x1rtUZzmzmpiwavv?=
 =?iso-8859-2?Q?Jf80DsXrnfKaZ0fowQL2LMCHwWa8ciDQQ6rFeF6yPfNTNWhxMlxnvu9UvT?=
 =?iso-8859-2?Q?bZbI59xAGyZiVgXZDzVRjCshczlMLhNDu44ohgXLqQ1I2Y7/4urlZlC5de?=
 =?iso-8859-2?Q?eX1ndxu0xbK3O9BcXfOeLXN3YIvNzN0wvgnMw3RDdiQP61gRHObAJV8HSF?=
 =?iso-8859-2?Q?mBp2SCi7y26miHi6qVow2F6Np84sDjw+j0t4MlQUQRCDhcO+KDXqnn0VmS?=
 =?iso-8859-2?Q?xMBZVT1DzkoeB06VGPQu8HOlRkkrWaJiKo1QK/Uc7blZoaCuI0lNer7bB5?=
 =?iso-8859-2?Q?wrgcwNle07iuijuR4p/xI0R0Bmzg6D+Guw/boTsR58id+ZoE6WmdBizOUk?=
 =?iso-8859-2?Q?6yHVJljFR4az3zZGRRQsTZNaTeM91zlftPg1D1nJDtmmEIZwgK/lgRvlA9?=
 =?iso-8859-2?Q?BmSpi7wOwhM4V+tylmFbionBp0su6F0WeNYEfDDpBjOj6e7OW0166nH0G0?=
 =?iso-8859-2?Q?u/8ekLLyrUbjdSF7MeVwWXGW4QDZ9FVZTPHuHm8shlpI1uVSh1fLEXlf6w?=
 =?iso-8859-2?Q?l6GDRuBZ/c8Bysz7dh6UEtD3tbPRa5Ca/h2ibC1BIazOe0MsePsFfu/hA+?=
 =?iso-8859-2?Q?1T5dcqFWXf9srIn2uPzGwc3wUTyE0NaCvRspvC725x7pk411SGcn9OKVds?=
 =?iso-8859-2?Q?QpHg/jkp6Ag363HFLpC9WvfMQ54NcLsfejAjbXfcQEwlQV0kWmJMwT6pAS?=
 =?iso-8859-2?Q?y1RUHFsQ9GiILfDrQuheG4NgP0BmKEqhRkJ75uJuvS0CasUlTIYPE3M3CK?=
 =?iso-8859-2?Q?Ew11rIAUammiyDPEtfQ98TDq0q1HzHELFmGDghOW7CcQKyvn05Yv/18zSp?=
 =?iso-8859-2?Q?pida4/7kxy/I9LPfJXKGbedRaDiIVowli7HeOKZP4bLfqXoEEB1T+2u9HN?=
 =?iso-8859-2?Q?O4Vx19dLGUWh4ArL0jksDHtkyyG7N9j4U2I9mAvTCYhTVlCrznv3Pk5w?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <C8414AA5996C42488B193E89ED0393CD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?b1MdL3u4i02xVREDhZWVQUf5qphB52LINnb8bYjw9y/3Jox0qYOoNIzJWR?=
 =?iso-8859-2?Q?L+kMKKkFlD3803WFM1ACjuz2kA35ZRaCJUIszCkzF5AZVoyMSnIh0loyPG?=
 =?iso-8859-2?Q?Kuy0toOfv1hdcgFNnFptszSnBZlR8ipGm+XQzIHRvBYLX0NFYpviuTawwl?=
 =?iso-8859-2?Q?8246bjRZGjWxyydahEM9Nj3tDhMlkXGTf4xcimmlryIq2x6dmi6kBw6Y0W?=
 =?iso-8859-2?Q?Rupvmf3VQAer2mSQq3SQNuPie7vki3F9vJrSAGPnrAzmDFbXUrks8vBp91?=
 =?iso-8859-2?Q?DFoBzALcbrnblWeWhH+hu7vixf7jbmM0tGVYLFSN2S3dL1asoeV+qExoP1?=
 =?iso-8859-2?Q?6QUiLqK6nfIv5fwookRYAuErXzTzY1bkWCGy0Spq+jhnc8uiv2e1t8p7Ld?=
 =?iso-8859-2?Q?BpgcVvZlgn47zRgpLKZwpV5yJRZCI5Rb2KkXQ7Mp/Z6IRJ7CzWLFdKrG5g?=
 =?iso-8859-2?Q?iVnTf66uwpSGZVz/CpFMdek6c/6e2l7OeIurxJvwt28IWoEAVPKLA7Fn1X?=
 =?iso-8859-2?Q?yqeouHxYgU/zKAj0co4nJGAuWDMaBh8M+fUHSfbw9uSMvNIPqybRnbmikh?=
 =?iso-8859-2?Q?T7snt1b4ARxWTp6TjsgLEVCk40C9sRku7eHjIMnxXL1nx9aLEgIO7zVCgH?=
 =?iso-8859-2?Q?/qWBlxfBPf6uldCn8Of0ZQjGSQe8TuFOXjCmFTAEqiJ74Jgi8F07AlMePU?=
 =?iso-8859-2?Q?am88M7TXbpOD5LdGDENn8Jg8YnVLVzQG01Tag5VOPup/0BgfIeY1sjvzV1?=
 =?iso-8859-2?Q?itXAcCjht+6gJw/E+Cyaex3jgt4Qqupqm/o5b+Ciny7r7nZfsnUqGTygmF?=
 =?iso-8859-2?Q?7N8aHarSKraqlT6cPU9F1Ph6bny/MdHlZmXWyOhE1F5Crwrsup7qNRR8X+?=
 =?iso-8859-2?Q?JgD5bV2TBwo4/Ad4bIuXP8xK7JRUEDZ14Yw/dgAnXjyaG8+6xOF9nWXYlg?=
 =?iso-8859-2?Q?Mvd4NAhDD1oR09CjYujW82rw1ntCPUfBFGs8vZhMp1HeTGuKx3ieBkaNwK?=
 =?iso-8859-2?Q?YUjVYfFuwAGQ8Su260K5gz8S2TbeUh6C79VjHvPrEEEGBbeTpE275Powzt?=
 =?iso-8859-2?Q?g8PrQc2gopmlHTJesKVUjBNwO6BWrwN3v92z1NPL5wZ0SPS/RVJGgJ1NVC?=
 =?iso-8859-2?Q?piUCXK2g=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e71944-3017-4b81-4c81-08dbd5955331
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 20:02:32.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfoWsYVB8WOcfqk2gAeKehdd9TqXdsF0SyUPLA85RaCdaF1w6WZaXaVqld3i1VoBgQS7O161ofqjRYcDAPXpPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7647
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Conor,

On Tue, Oct 24, 2023 at 05:29:28PM +0100, Conor Dooley wrote:
> On Tue, Oct 24, 2023 at 05:10:08PM +0200, Niklas Cassel wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > using:
> >=20
> > allOf:
> >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> >=20
> > and snps,dw-pcie.yaml does have the atu property defined, in order to b=
e
> > able to use this property, while still making sure 'make CHECK_DTBS=3Dy=
'
> > pass, we need to add this property to rockchip-dw-pcie.yaml.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yam=
l b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index 1ae8dcfa072c..229f8608c535 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -29,16 +29,20 @@ properties:
> >            - const: rockchip,rk3568-pcie
> > =20
> >    reg:
> > +    minItems: 3
> >      items:
> >        - description: Data Bus Interface (DBI) registers
> >        - description: Rockchip designed configuration registers
> >        - description: Config registers
> > +      - description: iATU registers
>=20
> Is this extra register only for the ..88 or for the ..68 and for the
> ..88 models?

Looking at the rk3568 Technical Reference Manual (TRM):
https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part=
2%20V1.1-20210301.pdf

The iATU register register range exists for all 3 PCIe controllers
found on the rk3568.

This register range is currently not defined in the rk3568.dtsi, so the dri=
ver
will currently use the default register offset (which is correct), but with
the driver fallback register size that is only big enough to cover 8 inboun=
d
and 8 outbound iATUs (internal Address Translation Units).

According to the TRM, all three PCIe controllers found on the rk3568 have
16 inbound iATUs and 16 outbound iATUs, so if someone wants to be able to
make use of all the iATUs on the rk3568, they will need to add "atu" to
rk3568.dtsi.

I don't have the board, so I can't test, but I could add a patch that adds
the "atu" range for the controllers in rk3568, if that makes things easier.


Kind regards,
Niklas=
