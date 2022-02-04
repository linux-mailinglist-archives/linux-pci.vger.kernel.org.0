Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB24A9F46
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 19:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377643AbiBDShD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 13:37:03 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:7815
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377578AbiBDSg5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 13:36:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuThBcNSMHXgxX5o/x4DInRajdu4+JRdRJf/ClDlsqJYGjPQo5fDLZNO5BXdlL9bg6EUhZ3RM8aASpUi1WjioUgNZ7qgZjr2VrgLCFfcYKrMsPXOOX9iYRA4Nvz3WWZDhwTMMjRq67pCVaYHfgtVkXlW0eMVN4ENPeSlx0LBWALIJ2R409AF4cABJiYTOb/ckDxEGrIDc+NT/pquVtCF9mS6MKC9UhJS/Wa6eq1SqsmiaeW/IKR4NrK1tgsr7ZtPA7Bn4mh5N1GQQtJBIni2pcOEa6BK1ZuFpcyGY/7yTf5WsD/Ze34mlKFaBL0sdrz5dh9wAGe/+LESjYZ0gnFUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0OHNYXkviAC7mH2HlkqzXP+1ZyGQdRGgVv+us+IPq8=;
 b=g/mMEycKH2G9l2gzuDaOaRGlkUpoWf8fc2DOUwrmdhfQn1MSl8B6a3AJ2i6BQfEGJ4TMFbvsEQCGTUO/hDaKeqHYMkPk3HifXQaZjuzdFq9f0V7TX9DEEQTsS7pAScCdB5T/h766LlwUWnbxT379yTdRlkOElICLlQuGwESAwy9AEBIEbsPmfDvUAAqZhaVN7GaZxhDkEoqPNBMuf16K641R3zh2ayj4C0+MzhBTZF/s+GLlPyZVYnL7iwQJ6Ilb9fJxqKJrqLlL23ZRoEtfOy8WxsYqXH/fAMKaVIGUkADJ8rRYq4amw6jrfS6Gr/rGgl6p4egin19ULR8X+8mkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0OHNYXkviAC7mH2HlkqzXP+1ZyGQdRGgVv+us+IPq8=;
 b=gIdb92YLqbH9s6Gs21Oim3lbcJt8FmsDpjFyfQYWWqhYKDJIBWzbTACtd463tt3/syYeEACpsVfs6kcUVcuo/N8iEBcDslCSv7U5BxBkNbauySAvGJbYQaAzfh4C+CGYaQP/yWQcfsJEMOvIYTwTJWzvF7bv9EsLe2S8w7EgFEI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB3742.namprd12.prod.outlook.com (2603:10b6:208:16a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:36:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 18:36:56 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
CC:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: RE: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Thread-Topic: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Thread-Index: AQHYGfUZ8uN1dYeam0W687TAa8QHVqyDuD8w
Date:   Fri, 4 Feb 2022 18:36:55 +0000
Message-ID: <BL1PR12MB51448980EDF4ED5CAF1BE64BF7299@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
In-Reply-To: <20220204182820.130339-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-04T18:36:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=003d7b25-ccdc-493e-8529-c27875d0bf9d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-02-04T18:36:52Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a6238ea4-2aa3-4d9a-a97c-63a08eb2fde6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b2c0500-6c2b-4db6-abc8-08d9e80d5228
x-ms-traffictypediagnostic: MN2PR12MB3742:EE_
x-microsoft-antispam-prvs: <MN2PR12MB37422955883343250A0B1D2CF7299@MN2PR12MB3742.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KW4DLvP7ohNkOPVkkHeXDeEg9bYETlFcHqDlj/Uy/zdPaUSSGjC0sC3g4AQ12+7svnX2LNLaAo2ogEuxSrVSSP6lTPl+gWlMCJW3y4QVKmHiNfPOQ1dMTliJ4MkWr9oF+6IsQYqo1f+L9tW18k6DsXO8nRyp07ibkrv1HZOThIUxznYlXqDeCs0Xn2GGxiOiUnVAxlXNnXRSbRfCJm10AyKQkRfHTxZqwdboogFNsI9P1FQjSr+9QpYOZrQeoVuf/Qws7L69p86VNlKX4dmcKeM60aY8XJgnejCTD6wyl77v35MGglnA+PWt4O6PmLMavKXDh1gzkv6IqOJZYa57lsi9Jy+f5kAg5OFc5PWf7AV/hWFzKBNpWJT0swvivR790k0uSw4biVrVt1a6gYl1mr3UF20PNDoqzdhXXSeO5lmwluATkIUSqMREyS8v+yI9yJqqz3F9KETkX0jLRwucfVWCvCKt8tgkHQdWXC1Uunv9mAf4qGcQLiXuM+rXySPq47Vr77MY8nB5eVDroCkXrSBXPWt5/+PkhBXKtHEWOoyFkMZCLNBhXoCRaE/6x+ciMUj+SC41iqLs0CuAgwSoKRPnu2rAce1t73TWXEvJwGLCEQf/LSQFWEGpOG10ZS5l3ff0FHzJA7y8+UEohtCOjH2w+U0IcAExoDjZvP0JG6LxvL9FninST6RuNMRH1KAbuWSB9JR/GYOMJKl/v8YcEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(110136005)(26005)(186003)(122000001)(38100700002)(54906003)(8936002)(64756008)(66446008)(8676002)(4326008)(66556008)(66476007)(6506007)(7696005)(86362001)(316002)(53546011)(52536014)(76116006)(66946007)(2906002)(33656002)(71200400001)(5660300002)(83380400001)(55016003)(508600001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Mo4g0NqDm2GIuIdbRzcN2Qbjl93CGEA5b2/BuRIgEmTAsq1RsYf2e1CirWD?=
 =?us-ascii?Q?8CgHejubRUwM3lNB5Xbsr0JMqDm7OVbVB24sBorOfpK0M8oSP2eRqr+Xo4+w?=
 =?us-ascii?Q?/TgyT3Nb6Wgk2/FqPjkRJXD30L0/XDkbymZb159RghFWlFJlq3eu6x4pTc3F?=
 =?us-ascii?Q?NMuHyjr7hjmSlYrDQEenO1rO8VpAl5Yl7HBkZkRuO2Qhb+359J3/QWN+pBM9?=
 =?us-ascii?Q?sCJEDTM0useU2CKWQ2cavr6+P5GwZSBR33F1KqlaijAKP/m3RvY287zk9jMn?=
 =?us-ascii?Q?QCzntIttjKEyP1X0kSk9Sm0DL2Od+jjmn6exu+yPjNvBgSKUp4JQJrvlUqJd?=
 =?us-ascii?Q?+kNAv/K97cX7383NvpqW7hI7WboylLiaeArhRKHokir+ope+HqByRQDtA92s?=
 =?us-ascii?Q?7N/Xdrxvyu7RT6QJAp1NCF0LG6/bbSl4DMs9r+CLoIBVqh9v/8D/oa4iWu+S?=
 =?us-ascii?Q?67xQRML4isYjusICt0dm0XO8fmBwiJ0xd33SZL9WKoClc0ouvuVFyMvMd1Cx?=
 =?us-ascii?Q?rXC7kFrLUPgtvBCbp2uv+todZvwnSYMsZGeaVV2LDtlfdC+Jzl3aU1p88X9U?=
 =?us-ascii?Q?WzL7+6K7KNAU31AOKzVPIqW6c4dbnXPSxljVTFiZ7/ezTzrD/U0wVoNMK6wp?=
 =?us-ascii?Q?jg9+1LF7M4fEJTtGo9t4X+hoUK4jW9ZTRBcd7To/gB8PWXlI+p2hGRthSlzJ?=
 =?us-ascii?Q?GBIjBByOojRQpag0GP1UR8UlUqvnouP8vXwC+gyJdMTVS6zoHi5bFSE8VQRD?=
 =?us-ascii?Q?0gK4DYRNLDm5QdbhoC0nkJWz5MYp/Sy4hBPIm8Tp3ZGrJHUfKBoWBH7jMQW9?=
 =?us-ascii?Q?WJKuSnTTQ2dnAeo605TiSnyXeID59yi06WFExcMNJi6DwqXC21PsvMLpo76j?=
 =?us-ascii?Q?tG28dlMk+hkanVNNGig2ligiFilVGiMusEhEjS+AqOeoH+f0F+8faUCL3y5y?=
 =?us-ascii?Q?qRxZgLg/SOXSr5AFVQeD/aaFJvvG+Nc7xuJl/8va6RduSivP8idHQ2vYUoLW?=
 =?us-ascii?Q?gXOwux/FGC8zk3l/qm2Hnr4hcmZhVwNDHCXgqvLLIYSH2jhcv2mtjqH3exv/?=
 =?us-ascii?Q?wbAC5yIk8Xc5f2QthYPp6l53c9xbuMp3fdzK93Wg5xRWl0AAyU5h0dnuaMpC?=
 =?us-ascii?Q?ffcvHHp/oNWldfeAXcTwj+JoaShzNOT8O0o+GKMbx23SGG3GEGd6XKdoSZBS?=
 =?us-ascii?Q?FkEwXjn4BQ3sCGkcjYXLLuMEgZkH/Fk0rRhMGzrsRCCPbRa4ANwaNJIk8ntY?=
 =?us-ascii?Q?o1NR0RlrvHq3w8MODH4jnRB2iYichHWrR9+OGvI84vF7kVMePWEDMLpwBvQc?=
 =?us-ascii?Q?18YrQWqNxnf2Vs3qX+X9nseY769pdb63n6aj9gBPI8N9T6h1/nWj5D6vV9Kl?=
 =?us-ascii?Q?/oonNdJRCXsROlBnYtQ6jIzSQO/F0aGOmCTUA2dPgoqcpOxtSE4+XOrZvcnJ?=
 =?us-ascii?Q?fOSYpnseB9/2T0vDLTHN6yIAS9M21CUvpIiK0bu/pN6Ku08ozoTwLkY2mtgk?=
 =?us-ascii?Q?5EBtfzXQSgvNftmeoXMM12/mC/LfxCwpi5mgb5O4UVSaOBiX3QNek/oqEiLq?=
 =?us-ascii?Q?P/DcEhfKqKmeYou7t9bXuaHbHzGURkOiKylteMyoKVl4hRjH8EYJB8dO3hRo?=
 =?us-ascii?Q?aCaaF3A0bhHhbPN4dgDBbcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2c0500-6c2b-4db6-abc8-08d9e80d5228
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 18:36:55.8845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDlyzG3W06mvlOkTQ6+mY5Bap1K4eqSJbPquZ+0mbEYM8eDdUDqbqiiN3QmWnETaICWnf1+KD6/EjDEE6us2bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3742
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, February 4, 2022 1:28 PM
> To: Bjorn Helgaas <bhelgaas@google.com>; Andreas Noever
> <andreas.noever@gmail.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; open list:PCI SUBSYSTEM <linux-
> pci@vger.kernel.org>; open list:THUNDERBOLT DRIVER <linux-
> usb@vger.kernel.org>
> Cc: Michael Jamet <michael.jamet@intel.com>; Yehezkel Bernat
> <YehezkelShB@gmail.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
>=20
> Various drivers in the kernel use `pci_is_thunderbolt_attached` to design=
ate
> behaving differently from a device that is internally in the machine. Thi=
s
> function relies upon the `is_thunderbolt` designation which checks for a
> specific capability only set on Intel controllers.
>=20
> Non-Intel USB4 designs should also match this designation so that they ca=
n
> be treated the same regardless of the host they're connected to.
>=20
> Mario Limonciello (2):
>   thunderbolt: move definition of PCI_CLASS_SERIAL_USB_USB4
>   pci: mark USB4 devices as "is_thunderbolt"

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>=20
>  drivers/pci/probe.c       | 4 ++--
>  drivers/thunderbolt/nhi.h | 2 --
>  include/linux/pci_ids.h   | 1 +
>  3 files changed, 3 insertions(+), 4 deletions(-)
>=20
> --
> 2.34.1
