Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3186F7D9C26
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbjJ0OvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 10:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0OvT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 10:51:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B36C4;
        Fri, 27 Oct 2023 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698418277; x=1729954277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pgqlyzh4LntIOW8GCiZ9OjH7ZfpK+EJNvINIo29MYWQ=;
  b=SNz5YOEeZUWA6a9QgF7LmsAEoBL2hVFtLJUr3ys2ixHop62JQXSeQOkS
   2RKRzvS65qvxxWM2jjOMBy52NflbmlgESTNDyjXZ8ODELizNWOd5YmoEF
   MsO9vtzsJ0e5zJivqs2yPepSWexTbr+qkFt3YF4V5Mqqm8hMkMXJS8Fen
   gARgn7xcWV+KhXmX+0nKHNndu7xYyVIKSdslHlvBpObZpY5eNTl1l12Y2
   2hnxrV43n1HXo5l42fxGrY/VzicH7IRfoM4ZV6KhHPA1mA/6PuMhNfWjt
   WJs7LFsD35NV1EZSh/me3kgnbgxD33mvQZA7NwZLEh8qKft5Gv5OZViMS
   Q==;
X-CSE-ConnectionGUID: kdZfpXYLQ22AUN5k1gSn/g==
X-CSE-MsgGUID: ILlZw3p1Rh6BAyeA0fUs6A==
X-IronPort-AV: E=Sophos;i="6.03,256,1694707200"; 
   d="scan'208";a="789393"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2023 22:51:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBPZlHc5OQPNYA2gayDfZheRivtTeERZHPb/Ze6Ys9fuTbxUOzGR5jV/4gzlBMKMsgLH3zOfXPQiHgzdIa+aUfKOG7iC8RYNofxKHIxnMHsh2S3gHSlAIf2BR0YTywlmmtIh5dW5KrrcfKctit6fRkKqXWdoXN4lLgfX1bC09mMcWothvTGmDW5yNpElbY04olCL0rZ7KYorWAnzxkIBcTLZedpe/Y05JfPDj+Xo7dgPjTGR+PDKu0Cf0Zk4c1Fmg5Sb21h4Si5pkyIVAmqTQhaRJrqAYiRSloYam/dP/qdA7MLVjBNpLzVR4H9GUd5RNIjFip+cDRnMfjgxtigl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9l2yCjkAheumblya9Wn+QvEHnzD/BtSG5lJFxypRWNI=;
 b=m3fnl0v6svnI9irw0fibbgZ04k9mr+uOSR8tY3POUF8Viin3RO6S27Qdk4SRuEkHqW26rpaNwJ+9MSt6IZt7Z57RPTT8MWN5KY4Fjv1y5f3ukNECcqTetCFU9YgW39xJbNtXBkouQhXjOCQbPOu7RybnCQFe2ndwgxjSG2V/nj8SZbJqpEgEzW3VlhmtBwBUZJ4IG5AL0fLjkcslka3xNAhK+7RNfFYuWRIlGHLXg2Vg2VG5HwtBNdzv7YYeQKeDvY1exnP/6KJo2LGpL0SR9e9QDGVMW/1dfu84CE6QKQgPd2orAMUvlqwk2oMcf47xrjjy5KnK5ktqRrbsRpl1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l2yCjkAheumblya9Wn+QvEHnzD/BtSG5lJFxypRWNI=;
 b=gbj1LroC2wemIn1Q4NezEIAL+VIPcCtGs+Afaq/A4UaqvbKjXPzXDV3J0bFs7M6C1J7diaVn2x3AmWy/Uk5m7pZzzyfPh6wDMlOJa4zrbPiWjm/rQ5xZPmqzEpzvqu/HuTr8UC4Og/CEaDRSdzcSkB5/C8CYOT5/NJDglL111XA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6597.namprd04.prod.outlook.com (2603:10b6:a03:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 14:51:06 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::47df:9a7c:5674:2ca6%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 14:51:06 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Thread-Index: AQHaBoyNd+UCFjyqgU2gBHlMOd/MHbBcJXcAgAGXdYA=
Date:   Fri, 27 Oct 2023 14:51:06 +0000
Message-ID: <ZTvOWRF75igxyxAl@x1-carbon>
References: <20231024151014.240695-1-nks@flawful.org>
 <20231024151014.240695-4-nks@flawful.org>
 <4tzz7e5mznunyar6d675lzn4jdshqvik4flyronb7sjwhc4deh@qwikilvdyosc>
In-Reply-To: <4tzz7e5mznunyar6d675lzn4jdshqvik4flyronb7sjwhc4deh@qwikilvdyosc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6597:EE_
x-ms-office365-filtering-correlation-id: 67dba90a-d126-448c-fb4a-08dbd6fc2652
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AOPuOH5MXASikQ1/BZ80Sli3D7+yVfzBdNMZwd/nJ6zPGdCc2JrweyIiyQa5HW955wJKNL2mhO5x4moWWFhftuBS5aJEbIRNG3HcGgy/Fmt5/VQQ9I2MycOikRL4ATGQ54Q0AOU3r0Qv3VGzAyeGBisG6VtpCxERAua0mHh9QxoFj4mU/huiRJuMBYeNKGBr4NlhnLq1Bn5pc4Xa379rmUOHF3ndlggAXx3JfZFWagNT2b7Hgc2XaiZd472RjX7M4TmRIQb6FtAnNXG0wuPqEmhXimW8sAqaK5N1Y3FkRdZ1RWzFnPaWgzbmCoRFKNPgY7f6pyir/gfqr8FZYqJp3cFPpxASItr4E2RQDqYjqXLM65N6mlQoZA7IowOXUrTA+NmNTFtKH6wuiwH2MEYavbS5a2KMZvjHpA3D7ZICz8vJVuYqqhKdeY2iqOVAACiR9MLZ+vjA+smSt0SQCfsZfR6nrCYvNQa1cZgP+1X8qWdONhfk7a/L4Bj1KMKp2a8VeixZPB9dzoQbqkQWArjDBEZJgodCzGfp1AgQXPqmzYKOJg9mlJH/42pTwvhN/Dm9ETKleXqu1adI14lRNR64eO+Wfww4hKISJ0sIkcdy8ZwofHXPTbkd/Ua2dYDcnHug
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(122000001)(83380400001)(26005)(478600001)(6506007)(82960400001)(71200400001)(33716001)(6512007)(9686003)(38070700009)(66946007)(66476007)(91956017)(76116006)(66446008)(64756008)(54906003)(6916009)(66556008)(316002)(38100700002)(41300700001)(86362001)(7416002)(2906002)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?2ma2URgJ+Q4juOEykMSlUGeb9chvOvm37D4Izo1mgFw+0B52VyUiGuikoi?=
 =?iso-8859-2?Q?I0O8pLQ9QNbQR/PBgjr/bLxm+tznz86Tzhc+cO4MC4W+EQ6NVOZebWD30b?=
 =?iso-8859-2?Q?qaoaMvkOWCrmxUAzuZptSX3CswNwydzBP2OufPHs0BQ+tyyNiRQFMPuEdw?=
 =?iso-8859-2?Q?4DrcAEmcPlvdasMGyVrap+7aPICXMMVRMzLz4//Z5whN4ntRSnkl0JTrIG?=
 =?iso-8859-2?Q?PFJ2SmltJ5Ow4MfPbCvKOu3SbQnHGNqUB7HQ859LO3yBxrHX4YBI3FFMvj?=
 =?iso-8859-2?Q?C2JIgzlhgenh7ALedokWl1HIbsSGY9ZUl+hV9E1Q8wG9U6E4O8lf5VHGyJ?=
 =?iso-8859-2?Q?VQBoOQoCMrDdNvE65CKB48vQR9gmQMe9y3j0nA97TRw1DlBVpaHikRdm6c?=
 =?iso-8859-2?Q?5dfEzc872nnMI/FcWqLvM7SZW8nQT4ME5n3Jy9QcgkFLW+0aVqC16p7kR3?=
 =?iso-8859-2?Q?xK3smG7zIALTRc1QpHgfDqMh46BH/G6waxkjPUKRKqcWtn/BSM5zMYXB74?=
 =?iso-8859-2?Q?nrk0A6IswLjIagtrnzZ/52WqG5YLiNP+6U/J203gLThQFaIbyGGY6OZ0gh?=
 =?iso-8859-2?Q?P5W6Unxc8R0llHd68d+KQGEwUarPk0UUVQK42/BlMLf7a5bUTVmnjg73qt?=
 =?iso-8859-2?Q?0xFJ1JmBsnDSgVBKp15iodGS5plLd5brDk/lu71sYYxrOZ6ieClg2g1ytn?=
 =?iso-8859-2?Q?2QONIeQEFqBZhPecOk0NxKBAD4Cay+zD8od+xg8IVhPs0za8DDRQF+ZbFz?=
 =?iso-8859-2?Q?sArBmAgJVjWtWIGbPU9dSqH7zpU1s4OXKcfwlaDshG0YtLqY+wHt5i6N03?=
 =?iso-8859-2?Q?Xfkb+9Qn+OGuhJ2FnlgN4mRNXRfx4//IPhEpVRm0q0KlJRTUlP2D/IicOX?=
 =?iso-8859-2?Q?3CeS2/iezP528yAaxl+EA0ttxqFq2amHuX+9CZouXpPkynYkRB5whqnh0y?=
 =?iso-8859-2?Q?SXwBrmE520zftqV10PHW3WNs3F5TMR6YDpLJnx4gsIxWnfBJoWPWLykEcl?=
 =?iso-8859-2?Q?Ns+UtPHGYhLljOmgRE6Yx/xz/zIbWDnaXCaK7Sy7w4lbNiqV5hwloiYrym?=
 =?iso-8859-2?Q?clG6hEIS5JiUsytW3EMfwubx2XI28FoKJ4ePB8HgveRI61vTQw44yuZHpk?=
 =?iso-8859-2?Q?KUmtmBbG/8O/K+gj4QcS4uMRm+Q/+65anw9TLdXdVqTdJKQhACg5uoDJx1?=
 =?iso-8859-2?Q?cKTKIxB0r5UTWJL7JT49D4BtXu7r8yRFlTB6zF1E9t+JUNMFJcmTHdM4dm?=
 =?iso-8859-2?Q?f0OpxNjDadvUUl91rrecy+UXm1/QyXfBG+D3a636Ug7tsZNFnilret9aYP?=
 =?iso-8859-2?Q?cXs68DrQhhWSXGEBaqnbHxn2Z9n/0PbJ523YSAi+VJnbNXvsykOlVLKfax?=
 =?iso-8859-2?Q?ZeCNpCRAm4fTb1KQ0DolgckkwpirQ0O49W2qSPOuI2CSeTDXmlpX98phre?=
 =?iso-8859-2?Q?ujRlCgOJEXrNXvGZNh63IQE5fTXCT3el4LE/Xl/rw9FDRb2C6XkGhpNSrQ?=
 =?iso-8859-2?Q?w19exdBOeUZlVrI0R3kdJA287PADMyczHMibQlyZuZwpsIxP3ci5diT9oo?=
 =?iso-8859-2?Q?9gExXGBvjzGApTVmcU+G2bntWszjwFwJUHCcBZDiGUQBdPlVIfgR9Fzw+K?=
 =?iso-8859-2?Q?E4XRB435fLJtIh2UMwgvxCJKO1ahkIuFSlPcj9xAzP0RuqtrvxksntKQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <51A81C7F5C88364188E891478E0531DD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-2?Q?gt3HuiZJCoYHbVselh94JeIYCVn5UXZQMJDRROzNkF0vISvlGpjQ41e+sk?=
 =?iso-8859-2?Q?Dkc+lt92n0FE8nyyUqok1fIj7RffmZKvWjIMGvwU6h74vBMRrus/AdfXMo?=
 =?iso-8859-2?Q?GqOXZUDB2Q9nRUkPuVkHrIFPJLHt1siFjJwMgBTHcnqEY1oSAUkR8YwGRK?=
 =?iso-8859-2?Q?RbxLjRsRPvtfdaKyVAcL/K5VzddPxd0hutm23af8oWldbw5P+umTrxDxRM?=
 =?iso-8859-2?Q?1HzS9gBHYf2SBrV5Rjs1nPsKM/xaZWrsQvfmQG3J0Bshfh6oEL3gVPNTdp?=
 =?iso-8859-2?Q?4uoqF+FS0PWJL4LRQXV6LBSE2BV6GId7buCsoFsRFbB9moXrrtu5fwu0Wh?=
 =?iso-8859-2?Q?8Nxofmjmrq1OgfTalmwhNVMgZDTij6joFIf3keTq327Nl6G2GTivI4RS+u?=
 =?iso-8859-2?Q?6TerRlv8v7hI/pkHC0VialU81/DBXDghiJGWIIfC9s7FKR164Fxe8FZg34?=
 =?iso-8859-2?Q?msBh3gEOQiZEoFJZc6pGliLwzgtdn6vJ4nSuWCcehO+A5R/KGywo4iWdqq?=
 =?iso-8859-2?Q?sXKLscjK/Dk0M7nRf6gcg2Ou3LioM71ZcNCGgEx/5i5awwGXKB/8MbU3eI?=
 =?iso-8859-2?Q?sQp1fNBqFl3hieGyP9/ipE3jHM2WFdwuxv9REcTI87B1jon+LhoPRcAeOL?=
 =?iso-8859-2?Q?iMTPY8DD4GAOtfnI17ChVbHQt8irGjwDFBLS5bw3cl0aWmZ0A8qIsvFSCV?=
 =?iso-8859-2?Q?Tk0lvfd2WEQ6gc2/ShaSrAANrA0no+sSKxsZzWXcAKMLqqNkENEmA+hbZQ?=
 =?iso-8859-2?Q?mxftC/S4u/Z3WVRB1eRFa8hiRmBD+AamSUVsNMjhvFwvZrsiPgjWLv6Ip+?=
 =?iso-8859-2?Q?Nwgf/QLIkUcgZprYCNkv/dGXCbLUeqPbfwkn6BW9SGMWsaBrOTjvMOGmGp?=
 =?iso-8859-2?Q?o0M+L4ZDpSKptIMviPFx56o+dXtwRAaXJubV8PmjJ0oGuerxVFtqEe2LAp?=
 =?iso-8859-2?Q?6pPBf9M7dM/IzLw4HF4ur/AvO8hDQefF5m4fl7YQcDTTST+iAFdY5ulnCv?=
 =?iso-8859-2?Q?fsUScIggYTanQ9zIu+Jx6qQjB1cLrCBkOvQ5Ln/Q/P3ttalJAGKhRIFPjR?=
 =?iso-8859-2?Q?X8grzFRg7qTbZOxivKHitTbw+hwILhhxfHOabQ7PJD6S8bLYWyCkfvO5Xk?=
 =?iso-8859-2?Q?nNdU94LqNhebg5ibrIr6xeK8lvkEc=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dba90a-d126-448c-fb4a-08dbd6fc2652
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 14:51:06.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XI+EyYqN7DOpjtG/RaOUOuukhYpI/jAnir2t+iOLl9VDMAaNhaO0/b8WzrMANlMTGfwP+cODtZqZj9kyOdyjmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6597
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26, 2023 at 05:32:44PM +0300, Serge Semin wrote:
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
> > =20
> >    reg-names:
> >      minItems: 3
> > @@ -43,6 +44,7 @@ properties:
> >        - const: apb
> >        - const: config
> >        - const: atu
> > +      - const: dma
> > =20
> >    clocks:
> >      minItems: 5
> > @@ -65,6 +67,7 @@ properties:
> >        - const: pipe
> > =20
> >    interrupts:
> > +    minItems: 5
> >      items:
> >        - description:
> >            Combined system interrupt, which is used to signal the follo=
wing
> > @@ -88,14 +91,31 @@ properties:
> >            interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
> >            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_e=
rr_rx,
> >            nf_err_rx, f_err_rx, radm_qoverflow
>=20
> > +      - description:
> > +          Indicates that the eDMA Tx/Rx transfer is complete or that a=
n
> > +          error has occurred on the corresponding channel.
> > +      - description:
> > +          Indicates that the eDMA Tx/Rx transfer is complete or that a=
n
> > +          error has occurred on the corresponding channel.
> > +      - description:
> > +          Indicates that the eDMA Tx/Rx transfer is complete or that a=
n
> > +          error has occurred on the corresponding channel.
> > +      - description:
> > +          Indicates that the eDMA Tx/Rx transfer is complete or that a=
n
> > +          error has occurred on the corresponding channel.
>=20
> They aren't identical. Some IRQs indicate events on the write eDMA
> channels, some - read eDMA channels. The respective channel ID would
> be also useful to have in the description.

Hello Serge,

As you know, the IRQs for the write channels have to be specified
before the IRQs for the read channels in "interrupts".

So for rk3588, it will be:
dma0: wr0
dma1: wr1
dma2: rd0
dma3: rd1

However, e.g. rk3568 only has one channel for reads and one for writes.
(Now this SoC doesn't have dedicated IRQs for the eDMA, but let's pretend
that it did.)

So for rk3568, it would then instead be:
dma0: wr0
dma1: rd0
dma2: <unused>
dma3: <unused>

So I would rather not add read/write or channel number to the descriptions,
as both the channel number and read/write will depend on how the eDMA in th=
e
specific controller was synthesized. So I'd rather have no description rath=
er
than a description that will be wrong for all rockchip SoCs other than rk35=
88.


Kind regards,
Niklas=
