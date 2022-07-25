Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B7257F8DB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 06:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiGYEl7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 00:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYEl7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 00:41:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75333DFA9;
        Sun, 24 Jul 2022 21:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxTVYFpiXH/vVwJLGCnEsbQczVtDBzVod2ttWl7rG4NsHR5iul34EwQY7+BGaNq5APx5DSBEQJpIrxLBQ/peOTqIzHFQ5BtougqvJENUmFN3HeziC8MXXcqpc6ew7/hJRCmUHlzfoeTp8nFjhCfWT/NV0fC47Ze6f4ItIdaRQljweWlmgB5/JpOpu80IaCu1MfwhW+2sFTnuCoTSK1SYpVDq44dH+tf+bVnF0eGwz0SG9oo89JPa8nVsqipktXw3zN/yqWH3QRobbDU0LfUYvqyf/0T+G08nxCINgpv+HXbYLBtEWx0lL4vr1dKnBzhmiHhpdp0usnIeI3Cj8oJq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4FuuLu3AP0KYy8ax7GqTJMWLHqkhvxHRbjAuM3FR88=;
 b=in1trQYc9jn3SHezN3lNFruhYx6xMjWTlDGR9tyhDUxriThpomBkWpvqSymCvxrYyKJkWU75lLMBheiLnklVeGuqVxIbOM9d/ghX5yCfNGaZyItTZRuJo0D9A5gdfz1FNjRivx+fz/pB6PD2dRBVDzdupV8kFiwBIiYzXE7S6QHDFIH0dwwdcDhP2Xw78+Ozv9yVjKV+Q35p4KDJ0a0rs9iuxmJVXOsL538K9Wpoaa4eiCFlnSgsi9H86MJdg8zXx+J9yHrW01APzaHJaAGraAumG4tNm/wVu1/VOCz6d0CZ+WQjnStxU5sTDWOf1ZrV06XIaO4nmQBve4dlgbGviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4FuuLu3AP0KYy8ax7GqTJMWLHqkhvxHRbjAuM3FR88=;
 b=rZlodXheoWGu/xFQqbiv1fDmFPid9Kk2ARJbad4aQLLWU2dbqcCGG1BYEUf6VUsJ3YfVyWd/J9Nr24hexj+jROxA8w031qH13pmYaBITOpoKTqIT7EqYCJMN7VM231xOSUlVlVn2f7a7ya8+M5PbhKIYTp7cVJ7ww4ac0ebKz5c=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by CY4PR1201MB0071.namprd12.prod.outlook.com (2603:10b6:910:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 04:41:55 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639%9]) with mapi id 15.20.5458.019; Mon, 25 Jul 2022
 04:41:54 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>
Subject: RE: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Topic: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Index: AQHYkF3x8YswtN9DtEuLQU3s9u3ckq2K4JmAgAPASLA=
Date:   Mon, 25 Jul 2022 04:41:54 +0000
Message-ID: <MW3PR12MB4411E1D8389270BDFFB6DC60BA959@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
 <20220722192431.GA1923712@bhelgaas>
In-Reply-To: <20220722192431.GA1923712@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31939a8c-5fba-4a34-795a-08da6df80021
x-ms-traffictypediagnostic: CY4PR1201MB0071:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9doDWVCmN8smEPos4JYeW/fYEI7zaRG+Y/EJhsFizI5dHWaVZaoP/6MrDjlRbkAPNcMMebchTWg90oL+0P4au5yOqzosXVPInqNrLJEQQICcKxa43TU21kPg40NBl3MfgrPlXxOeCqB/lWn4m75wC48x7UfkV5h2iPYWnXM7sk0nsPl8rf8lJpJTQPHRHoFM70l9DMuDgwOR00ab7tdyL/zOeor4m/2kM/0/b3HdM5BiGO7qIjJyryeLr0IABJiClfnM9JKEM0EZoSea1t2DBXH/lqhCCFhQ33XbfAccgLIGjvultiHmXJLp4mm3+Nyi40hEOLEZ762O+/0qE/5AutTN2V2J9PyVOuK6CXiwtVYaKOrzzQsqJ2d72vBusMqMYo+c44GIrT7IhleAgzOsLs6Yq4keRTynPNxEer3rI/eulRuDSrKy8vn3Z2iIIPn5hjsPNt7rBxVE9Ja0K6rlA2WCGeMwiTHP/3joC7TPiN+Sfr4qDCuDsUnHGvXjhffOCjMqSiwo+QYTKmSprWMM9tgmOb0/Pv0awRYG8SnAv1/vOc2CgOYcWbQ09OjHFeetdg/JdXMxJnkNhmPz2x1MSupUO/roZnXaucBzQLj64sL4Odj6rgebZYb37bZzCeCK/hOhzaqdN++D7ePUeqbNLsMwJSbANzB3knRIzwRzMzQYjpoCVVpa2MuxSe1t3OU75miKbPkvHb7bOrMU0HGn56QZD016/m233a99GBOb403qquPBnEDpglYTNcqWfKZmPOTKWSdI4uYIhnmExyz4dGmGWLuI8phHq8q2SnmqytviAb1iYNNNUFBmxn8cGl/R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(122000001)(186003)(55016003)(38070700005)(38100700002)(66946007)(76116006)(64756008)(4326008)(66446008)(8676002)(66556008)(316002)(66476007)(110136005)(54906003)(6506007)(7696005)(55236004)(71200400001)(33656002)(41300700001)(2906002)(86362001)(9686003)(26005)(107886003)(83380400001)(5660300002)(52536014)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OzAcrg3j71nNW04W44lSPeCvvA87fx6dUJaccRJNUQQc7VA3FLyFSMb32siV?=
 =?us-ascii?Q?v/hxPzhnLD2pQjFZ8owhIZ7JLzOX9Ejvt0T0KepvQK0k/J7zvtiBpBFH+F9X?=
 =?us-ascii?Q?zup4p3r9WxIdnc+nE9IFqcLeGzJsyzak4lsLnHzxS7SwGgK1mvcGhCOsfwSl?=
 =?us-ascii?Q?amFWJ3y9LNUWok3h/b5r5U4G1LsgJ98yFBUbBv+OcuNdLNLSdEqWtp24ulyu?=
 =?us-ascii?Q?YqW3Xako9rqc/m3dhzitgznIEQfI2kkm9RrLo7KYrL1n4HETWz0HfMnu2owl?=
 =?us-ascii?Q?txQTEeJopgUv0sXIr/0lBEEzLTHxdfl3hussc1lExJQYer4TzkJ9QPuiSEPH?=
 =?us-ascii?Q?VxzhUexCxWd2Yl64El+anfQdWyZ28SCCZAsROPHTaqIiU9MGfuEQe6h2ItEs?=
 =?us-ascii?Q?G0H1KmuxaELjut3uH9Y2/wXAf95vNtmZotyqjvVfOPUuTT7heA+z1zFpSknt?=
 =?us-ascii?Q?hy5ePdMzQLoUUvLTVexFtOJtZPkKfhimLihbkGSKGTwpVPTUYSl3HDWrF37S?=
 =?us-ascii?Q?qVfLTtp36rTALYSBkJ1el8JyZXaAiF/lDEqqKbgKEB19Y15yObTzrwYbzXU8?=
 =?us-ascii?Q?AI6rdk+IO/9L07Pn9ijoyMy/uGAx30w2wr2/aBdWvpTrbXarRt79Ba+aVF0G?=
 =?us-ascii?Q?gxwXTfwDJ9xYrRKEV83hP1BjxDwJoekAYCoLh0PccwV1hjWTqj/DdyU5+e2/?=
 =?us-ascii?Q?JUqf7uJeFjgiYrMN2u+pzCzhsXnbwNIZ94qMbfjFrLJLELpqM2ZWoVOws5lZ?=
 =?us-ascii?Q?bzmcMLhc1d/5cnM2Ez/UmD/5awhbC6uO/Baeuo0Lx2QPo7uKukO7zkvdf+bP?=
 =?us-ascii?Q?MHKmkhA3m0078Lckl1hU9OuHFkWL1oGe6Oud4+q4Wm83NPQY2xIFzNr/f91a?=
 =?us-ascii?Q?y13hW5oM8nn9zXxm+1JjFvuxptT1dON61SwD5ylwTSjTLMROjrYAxbgJglRu?=
 =?us-ascii?Q?xS0oCpTr/xXeiaE3uJ2TN4aJzGeuOb/Kr+T++OMS5V93+Z1RPk8wCBa5krc7?=
 =?us-ascii?Q?VZbWfForhLKv9IdAiBj32JdTffWvpU2NplYWEO73z0QZp2xh0C5qN1KsluCK?=
 =?us-ascii?Q?aAsnVDfc7+Md0STrH8RKqR9v2lzEFIxsL5JHJNoO7KNCVzYCZlk2nt+IryXy?=
 =?us-ascii?Q?jZgfsrybsLdUW2b13eJ9G3kMfp+BzIqvedBwZaRGKeRgZGTrLiDVyNnOaPJb?=
 =?us-ascii?Q?sjalFTtjiQEaH8t1gi94UKcx5NOVdHekoIfvrcs+R0TFW5kEieATYDq2+8So?=
 =?us-ascii?Q?SUWSCtMqrifdV5WoIuf0SqjvpR2Zr4wIkbMbfxXpi5D7GChDV77ZpvCgkzTD?=
 =?us-ascii?Q?rGOuxYnT+34bZY+3nfmX3Lww6LUNnEC1fS2pLrpClScqHmo1mVLMD+mwkv/+?=
 =?us-ascii?Q?VM5AK9DjlSj7+HN2FNQM/Uc5Y0Xt7GPuzm3fqicmK3XpRMHQ8js2mxZaCt20?=
 =?us-ascii?Q?NlMadgP6f3Tja7AJf6osMmRnOYyb62bXP73MOAkDwGxpz4v/GyKt+7aD0t7j?=
 =?us-ascii?Q?pzEuQawE2JJJT7H2yx55Lb68gZfinbC2LFhfLYVbPppGWZzLomeYrQoGxaMe?=
 =?us-ascii?Q?Y7irZEcRl5V4bh5OP5o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31939a8c-5fba-4a34-795a-08da6df80021
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 04:41:54.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIxXSblRABBurU5gu6yyi3/lAXEeFj9PiX8RBgoNA4//p7Z/YFdn/lkz2JEKkvanf8TuMie41joGXWz2JA8rrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn.=20

> On Tue, Jul 05, 2022 at 04:26:44PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functioning at Gen5 speed.
> >
> > Xilinx Versal CPM5 has few changes with existing CPM block.
> > - CPM5 has dedicated register space for control and status registers.
> > - CPM5 legacy interrupt handling needs additional register bit
> >   to enable and handle legacy interrupts.
> >
> > Changes in v6:
> > - Added of_device_get_match_data to identify CPM version.
> > - Used enum values to differentiate CPM version.
> >
> > Bharat Kumar Gogada (2):
> >   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
> >   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
> >
> >  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++-
> >  drivers/pci/controller/pcie-xilinx-cpm.c      | 64 ++++++++++++++++++-
> >  2 files changed, 98 insertions(+), 4 deletions(-)
>=20
> Applied to pci/ctrl/xilinx-cpm for v5.20, thanks!
>=20
> I tweaked the driver patch to test:
>=20
>   if (port->variant->version =3D=3D CPM5)
>=20
> instead of just:
>=20
>   if (port->variant->version)
>=20
> so it doesn't depend on the enum values.
