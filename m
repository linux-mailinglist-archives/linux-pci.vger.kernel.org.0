Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B8650AB2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 12:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiLSL1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Dec 2022 06:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiLSL1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2022 06:27:10 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA62CA1BE;
        Mon, 19 Dec 2022 03:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671449227; x=1702985227;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D2ev+6Z2MPOmqLV65pE/6E+3DZ+3LuAjynL18/4X1Lw=;
  b=LyAQ+K8bIAe6JsmmQ/Spv+qZZdqmaTbgUNXuWXuaaWynXF7JOo52OpFf
   bW3OTtc8tiOIqs91TfBIcuMq9Dcyijlc16C5l4J7hx+DNcq1HkY8iwO4o
   bcOjnEjfEC+qt7j3EjdgYjiqLurHMYv9yrk/NN5WsFiftG7JIOFqOcnh/
   mnRzXYCBobpdJbmHSJgrJrM96BQPK3IUCxwfVrj2TjO0YGYfeycu6gqui
   M42j/kDFZ5BNh+cpoHp/zrxP+TAhWxxtWdbZLLGPQYf5i3G+jjeBu45rY
   XqDisBL6YIHuKsjwGqTp2uWGTDIQWylP+2bLmCh+nbtj1juiVCeFBhwUx
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,255,1665417600"; 
   d="scan'208";a="331084652"
Received: from mail-dm3nam02lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2022 19:27:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmtpFD6HBHe/xKzlKux/y8KS+d2bgRSFX/2yH63m/7i8MHxyt6iiifoW/1dCDbEbeb+l1AEebj6iaSlahsIkOm2CwkT2sqyT2C5HwxYzts8es/3z02wx4t66P6beKccpxuMhxOTGSOjY7sXTzU3yLdWCi8sDNQzFwJkAA1vzA09g9soVNUN4OTcUIxURmJatgA42R3DhKEOVurbxnHHwV/0xbZZECajNlDM0T1pjomBvYhOQjl9TcZakq4A5RrQr6pWZQTfi/mRPqV9J3ahliPl+7vY3b7o6sFK2BY0S516YISoaiOUB0RgptegdB79vT3hx1RH0fa2VTBZP+wikqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2ev+6Z2MPOmqLV65pE/6E+3DZ+3LuAjynL18/4X1Lw=;
 b=HqtI1+O4POZmJ0XkcqLOYSMQSoIhiywTm4+qWTHN+lOtuWzXhqym6TWCIog5sb20sXk4IB1uQNpvHbB3ultdHyAN7TIHP+gW19TLogBtreaO+/ZjT5IMK/WjmN8KkuJczL7FH7E/tQ35heSS28bp3U65dduCgEfnXBTNm3fsZOgfbS8spGPtbQJplWw/Pe+JvfUV+U6OJTY4ZAhmIkGjBmvSejWVH4EhBeBBLqBFpASaEdP0F0upSk15Lfz1DOS5te8hKhQK5zNxHJ0c4KuJh6V3cVkGoyVkj40dajusblaBYrKRaKOGnjucqVPCWpWY6oAngl7qU/DT0B0KMkDuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2ev+6Z2MPOmqLV65pE/6E+3DZ+3LuAjynL18/4X1Lw=;
 b=wNcbCLoEvICpdz3QpEpF3qhJKvZ+hh5xiSI1tntwG87XRjdqKLlp9OFSZ2basXloASFVVGgxXmCvLmAQkde2Nxhi+l8sAsXP76yhQen3TV7oLhYf/t26S0cHiB+YC4/rSx5PKbpDOZFYb0iKinI0O8SwINTgrNshU9rEaI53wkk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7850.namprd04.prod.outlook.com (2603:10b6:510:ee::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Mon, 19 Dec 2022 11:27:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::e5db:3a3e:7571:6871%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 11:27:03 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index: AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoCAABbgAIACmtiAgAA6YwCANDpNAIABKGaAgABB0ACA73lBgA==
Date:   Mon, 19 Dec 2022 11:27:03 +0000
Message-ID: <20221219112703.rlqdo33ncgmuowfm@shindev>
References: <20220719045036.h273puvs3cibafix@shindev>
 <20220719223127.GA1585747@bhelgaas> <20220720022700.yrprhniwsgtwpbnp@shindev>
In-Reply-To: <20220720022700.yrprhniwsgtwpbnp@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7850:EE_
x-ms-office365-filtering-correlation-id: 183f13d4-7665-4615-6203-08dae1b3f41d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+fvE9bg1iVXSx36LhsJHZDPC90CBRctmnRnVNP6QbpARtblTV46ANgMnfDXYK3tS6yADuS23xywIsp1CG1s3TT5klyFHd0GlTHadpLT/mJXNsQbhv0SdJJ/GM/EbYq1OVQ3mB/bDZm1OzyYqqWM0QWX9cVMR1B8nBrZM0FRDnkhJNvAjWx9V//fqdRn9eD54lLCzZja+z4Agv6W8iOGFMhAj7sUJ3ip5X90PwD0blT3GdjepfvXD0Dp0U/+l9gPqQK4s56Z2XxreC87WdN2ZXE0vsnlU8dL2T5BEWU0mdyZytmZXl7PdCtQQnCktu2JvpR2WpMFCvvsm/a03Qx/t3kIEh9CNxYFqcC1kn/0eQv38w3jCVPvTMKr+p186gjnJjzEZQcH6N8yIr/2/Z3Ow7CK2CApWiX//iantiE4CquIDz/+9qOGDcYPE671iFcaEcWQJizqsqXJ6NMBYjSRomyLJgM6vIEeIPeiFfxGRM1J6YfceQ5yzUuJdiKGLCu1Cg5ZfmNiEPk9xjTjaQqDnpUYQWabwmBV+FxVH2BYTpPvcpREExplDwKV5qZy6Yx2BwogB4/Bsmi5U7/AbLLVfkfHiGfY/bNKLFR4zsff2anRz54QstQ84g+R33jIHLBQvz7A0ew58/qdDf3Nhfkte3MyLvOFcPW/ERQREl79WX+czyZxVXKLKrIXriA+/Tiyy6PupQ3qDWt5ySKTCe30Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(478600001)(6486002)(71200400001)(6506007)(86362001)(186003)(6512007)(9686003)(6916009)(66556008)(26005)(316002)(66476007)(66946007)(66446008)(64756008)(91956017)(54906003)(76116006)(33716001)(38100700002)(41300700001)(8676002)(4326008)(1076003)(83380400001)(82960400001)(2906002)(44832011)(122000001)(4744005)(8936002)(7416002)(38070700005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/UnmiS0WM6mC4Jj6TLHAnlsyoJtmgL1uCU9ovO2pWP97Krmgij7cWVlJYldm?=
 =?us-ascii?Q?MyxKQUWIivf3MHy8EeWN25l5SMLw+CCQ6x3NYnzCSGCY9u7EnulNw0mxmNc1?=
 =?us-ascii?Q?kN7aUdLzLTcpmSbu2Qz87jmm2Z/TOhNybn+U0PDAgy4OPfHMR24sD95ySzfG?=
 =?us-ascii?Q?5f1Lb73fDvJB+JsUn2knOlVxWtoOyhXe9MugjBs0joloes+LDZM+DbAsrWUO?=
 =?us-ascii?Q?GNnoStuD/8DwZF6LwDAbiWosxnFbxedFulMS0FV+zp1TxqyOrbGhc34XG3xO?=
 =?us-ascii?Q?9X/QkiHqFqcTIUfvd5cIaQG5XeNKfP/SsPR+0BVOstna0j7RWBGJ75eED53w?=
 =?us-ascii?Q?iJ3aNwuseaHjtbLH8lhv8l2dCSVNWoqqt9h+Ly3Q2sxZ4BLzZ4NvzBmNOwEC?=
 =?us-ascii?Q?YhPYozdV3w2nWwzi+hbDN2N7S00sXmaDfFi75cLHyYp3NA1+8gGjH9L26TKO?=
 =?us-ascii?Q?COpnzVEn6q19RMAG8ZYmNkHy8TlcQDZJM9h/btZQ7CA1hTDmngmH3SJYx/6g?=
 =?us-ascii?Q?27jFp8o2Og/un2LNGTQMTL9tQ207V9+CbEg9vNLf+MC6k79JCtk0MjnYYxoE?=
 =?us-ascii?Q?XqY+P0IfRf4FmgKnce0gxDG0VDHLyJd1U0yvC/9HXtVL/plFVjrRCu14o7VS?=
 =?us-ascii?Q?QMb6XIDQufCG65UbDjQV5fAYWlNG0Ij/riHfMydHF8BWiw2yNhn9wZgZr1U1?=
 =?us-ascii?Q?CEKhg2te0sWHlzgFOa+tD9sJMqG2vbkflwYAgqALJ5wWZKP6M4yNCJAtpmGM?=
 =?us-ascii?Q?JAICKs9nMYO6T8IiHsfmOdyPrw9GP7jHiWCliBsYqsII44TD0geMEl0OIWPM?=
 =?us-ascii?Q?K4n5CM990vDKEPIf+tQxLwJGMUm/FNWYtfcmVvnQ1epIz5LfelXg/ELqb1+P?=
 =?us-ascii?Q?CQUZQh3ywxozW4ma3rxr/HexVaKt141qu+RzXtmslFYYaDV+gkOZGmNuNuTr?=
 =?us-ascii?Q?wnyQjfx0JiAiJC1CZBjc3BqNq2ORtg7tXSbWhULtoaY7NWLlrtzBkGavKHfN?=
 =?us-ascii?Q?fg1s56RFWHOktEDjq+guKJI+BPlYlzE1gZf1uZt2Nbf38jdET4votKD4WEI8?=
 =?us-ascii?Q?gMyu6r9T1giHwHmhwydn/L2OywP7cMS3a/AhY4eLPWuZxTLb6hzkRtRySeHC?=
 =?us-ascii?Q?eU2Ar6QJ63JZt1aywg5kZjW4z0kJrsywaFeDDtygQ9VVCvM0uG71YjnnyDwm?=
 =?us-ascii?Q?3B1YxBtP0/ikADnR21tJtaDFfE9nk/tckx/lIYUmkMVRYa10C9QUInETJA7s?=
 =?us-ascii?Q?+8hSSx13FF3t47d9jDL2ZRjHuD2bmkH08XduH9seIqzqsGuPcXowybL5uGUX?=
 =?us-ascii?Q?r/zbr40TIrYRXlzT73oKpg4EdLWL6mVjPId+DQ8AT0v92htpJTF+lK90M2tt?=
 =?us-ascii?Q?5F31jEwcBzBYRQIn1fM77msKoCT/fYrlYk9ear3fVr/F87z1TKSsWI8djmbS?=
 =?us-ascii?Q?acxIQMoTlax4jes5EB0MjUPjJ95wWSKF+nT0YD16T4mjfPvgs1guFEbb3daT?=
 =?us-ascii?Q?U3mfUSb6h7QoNaap0GS7Flgz48xJVqqVxg9ItQNFAiL+GCA9zjGOIuUQdVUD?=
 =?us-ascii?Q?ve5y5Z2vr5MfBnOOspiloiy9QVlEZZQo5nkVPzUaLHi84SnlYmpaXknyxpHJ?=
 =?us-ascii?Q?mAfW25NFmXzGGoVXNP24+AI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <968472721C74E24498DD1AAC8EBE0769@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f13d4-7665-4615-6203-08dae1b3f41d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 11:27:03.6682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoNCqE1x1tMMf+jdLsJ7LhVCJjLa6c5br4FNcEy6waC3eBhwQXfLyMgl0YRUVpUvuHx2w9HUCXuVGjxXb3c9E7j2VgpcPFynNBbaRdRbynw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7850
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn, FYI. This lockdep warning disappeared with kernel version v6.1. I
bisected and found the commit 2d7f9f8c1815 ("kernfs: Improve kernfs_drain()=
 and
always call on removal.") avoided the issue. This commit touches kernfs_dra=
in()
and __kernfs_remove(), and modifies the condition to lock kernfs_rwsem. I t=
hink
it explains why the lockdep disappeared. No longer need to work on this iss=
ue :)

--=20
Shin'ichiro Kawasaki=
