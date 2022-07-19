Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3C57A60F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiGSSGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 14:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGSSGr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 14:06:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE00448E9C;
        Tue, 19 Jul 2022 11:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iU3QdchkEUU6nHBvyUsFQb97VeCuAcL/1eOgouZe8T9EqiHSYmq9y4W7RUF6bBQH46jXMJ4K0YlBUr09QD63W2bIwBwV9MJKvQ2kWX23ZupB2tzQCDdvHnReIykFrWFCrfkQZIQDXhaegSHhcOTMnbc7sSGkDHot6OJGCkKa+vvH2/vCh9BCfFJlMBHBffikgBbcAb3E2sxp7v1HSrAOiB9R7zt9z9AfE8t1fFDGrgj0mw/30HmgFyKAsjzJ7Vq1SUCuNCf5O37L5Phinuw9PMRDDUhwmRqUsutZ/7b9wCwoG/z7JTYEBhBeYCtV+99hOBiqDhcwBl3XTS1F5WvlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHPfKJpnwHrAlIY2id26HRqOG2Wv3JTpG9MuIyWwViM=;
 b=O/upCMDvNA9zpQP3AR3ildoKxXNjNOLneGWTd3YJU0rLIEqPdS7Ykrqv88HVbo8UutoTWiAH5w5FRrYK6a8JzNiwKzRCOCRh4RbhxNlXK9ZWjueTV4Xi+Zw8GZuynoJKfAaUnmBsJELm271ZNbC+Cz3N36T2DfpKj7hDM6IJIbez/Aam7DZpZ/E4nqEpSPeosFD6VLuUk+0Icdeut8TTjAHKZwSBMagQ0Eq/SPnZIFmhj18VVLBgiYPTf/4Pt+oK5PzzXY1zzDBJl+b5dP4A8QtV4h9Rt+/HAKWPM1jcyCBpfkhAt+T+r0nWtuQRPo9rrc3imaSIpsmjNL5/w+S19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHPfKJpnwHrAlIY2id26HRqOG2Wv3JTpG9MuIyWwViM=;
 b=EmBL20pJ3+An21a/7CFRqMdrkwvt460ac0Q9cw93cLZ9ZWyN0onnzBsbhYD2NY0vIv01RdmpZGgTZh3aQASb7bg/V4668TKresL8QTwMYEQ4v6J2pUu5RbESid+QK2e+45uhe1ShbUzU+11UWWKcRN7hxEEpUB14T9eolFy8H4M=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by BYAPR12MB3064.namprd12.prod.outlook.com (2603:10b6:a03:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Tue, 19 Jul
 2022 18:06:42 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 18:06:42 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>
Subject: RE: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Topic: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Index: AQHYkF3x8YswtN9DtEuLQU3s9u3ckq2GE9AA
Date:   Tue, 19 Jul 2022 18:06:42 +0000
Message-ID: <MW3PR12MB4411B1735832905C337CAD00BA8F9@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a74446e-37f5-4c71-ab20-08da69b16f81
x-ms-traffictypediagnostic: BYAPR12MB3064:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjgdVq0BNILxhV/TAczRIhLnvplgO7jnB7uswLLY9NmqeX/AA00IBk5M3KLGQZZ+ARxlrv81tWDIzSvUmTqmxUQcjZ9F9KoJWt8AunaUqtpHlTOi3ru0oa9gUs0IiUncggIdPjJth8kBuN3yCI/OI1g5Xse4tL1eewjsh5hG8jdGMG8OE2Edo1jta0/DyYm/bZmbNWH+/HF5bprdVYMJ7NKaBKQb5CU+9xuYsxMTw/UqZ6en3gBhqwfUrZY66vwgI+DREJgDlrJ9r4Knu6dJUEk0FvcCAE462U5JvQMA+4ZpuNk41bxIStXVtRQyYIMts9vBDbMs6kzyNo8qfeKw2HH4ew9EO5Ru3qr0b0/sRjaVSSbKYWE6lmDfL8iIQwfEYyVPRLGE1Dwh25Zt9YD/S3Vy0Aj8/B2spW290LETf3JbYD9uISbXoU2j3yLPoVSUmedpt6/0yH9Ek0SA85v7VGOSld4hBZaWUom2jtBn9aqTxHAc73o2jtWJZr9uTxRrohtdoDE7G/AXfeivfJb9igmUFGk96OKabcvr2Pt/847GVGmtCSpJfSrNtETYVsBKIgV8iqX/U2Lk6tIxQs4ya9ZJb26kXuNloeOxa3WL0gN4xjMLKhAHDYmhUJbCpHrkqFvjz8yBGWN9G/Zx0tNOD1fV7g6CCuJyE0uETcaQmqQ/su2fE8wPjmRBIvsNGJuCIIkAwRbQxAk/pqNa9uASmjiF4ulF5Z6OFGekehCQKDZLLIcBOnAgvjZe+iyaeiFKbdMFQuV59dd2+7lwwVb0mepySN+LNcwnGjWbkHXeTamHMyL9XYnwkOjcN+x2IyoN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(54906003)(66446008)(53546011)(110136005)(9686003)(55236004)(6506007)(478600001)(26005)(86362001)(64756008)(71200400001)(7696005)(41300700001)(2906002)(52536014)(66556008)(55016003)(8676002)(66946007)(4326008)(8936002)(5660300002)(316002)(66476007)(122000001)(186003)(33656002)(38100700002)(38070700005)(107886003)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvj5qcwQGJYzSvEz2tbGXX4XT9ClUnBLCzX9IHKFtomJglFDXxjz5z/VJzNw?=
 =?us-ascii?Q?dgnYRmXi9s/V4Q/TSTbLLOz0Bz9ok3CUwXzoKRbqGO83B6rppXMkQntF+BVG?=
 =?us-ascii?Q?kP3/GS7SKvU7NSPcg5N4u1ebe6qhlElAvVikNOXYqKNG1KjrizQyGynVt6tA?=
 =?us-ascii?Q?q9ptD3h22lVfTM1VLgwmIeE4l53hrv0bNtm7sRoLG61Jo6Csuksuv+tZqRzt?=
 =?us-ascii?Q?lQS+QzPMUZkNqpsV21cvoQyhJOqkKYGOlJRo3b2ukKV4m9yzsPnn3o2Pvvre?=
 =?us-ascii?Q?/eafDaK0Ee/mhT/fGL+v9ZZPWgF0+zJkh+XcRzGQoiGXylQRYqYd2j9z1NB4?=
 =?us-ascii?Q?WW79yoaM9jWen90lFuY0+zqPvMooMArUnb9q6XRCTX7xBp/Mckp0aIOvnsh9?=
 =?us-ascii?Q?PZ5xyBXClJO3R8ZarWkXFDKJvKoJeg7Vzq2iCDhPZ5bf/NfaGchGcCEXwJfb?=
 =?us-ascii?Q?6HPkz6AcJHmxDb3S71AjArHyVt9UO5RPTNNGSbaJ2FBL4ZmgeHr0X1EZ1mBZ?=
 =?us-ascii?Q?AqmMLBmOtJihc5S4sypg+0K53zDw0gNcrOJyOm56Srfkpw9qMJeCmH0sUIqK?=
 =?us-ascii?Q?OaZ9JAQr4go56DagfigkhZnIN20snJy7NL2Cw7mOZk2W2Bv1y8a0r+yy7wor?=
 =?us-ascii?Q?7tJ0sSWhlw7YUErwVnFqo4PbSpt9nAaIQyR2M/tJV8dNdt85PbP+1ftd6/uL?=
 =?us-ascii?Q?BZkDK99KcqPdzM+t6nWEf75F1Pk7e9VmG2gLGYAGRcJ+urInjiTigws6tz/H?=
 =?us-ascii?Q?knvDFN6xCCuV0XlZY6TD4CXH5mMen7rdTJyhWbp1ojVGe0fVwck6tgqRXSMq?=
 =?us-ascii?Q?oFf/okpNqFwjRNJIo0fGwLRRnyN2wV0KZXcR5zSge/YSfulU8eAFAzZwfd4t?=
 =?us-ascii?Q?QMoGHktEMrqVSmtEqbBM6Rvc0aOBb/el5ZEe2vrwL4uBxeW3bxXMar9nuAT5?=
 =?us-ascii?Q?OQ4BVu+mMhTRdl4yjAwgwX4KrVXgvamEsKPPPNMw5zJwzi2o14lxsqqco9yq?=
 =?us-ascii?Q?zozi4YJ1ssLIiFoA4XCZiad9wRts+yGzo1YB4q6iOcqL4NzJlMg9XcrglteT?=
 =?us-ascii?Q?/z2IK6KnjcL8Oq2s5UmcjGfXCFoXkiNrMecKpz/S0Awsu7BIFTDI4vpi8LpG?=
 =?us-ascii?Q?R1v2o2iER2bHb+ahtZKIAWmP9BgqZXo/iVosoIXlt/qOhrzsUjLjyR1HWKQk?=
 =?us-ascii?Q?j3oBBePuu99t+QyO+I0fnD5rRPEBGNSjunM5F5r3mtMp1CNgeBaacSe9aKYF?=
 =?us-ascii?Q?96J/9qDC58lrSITEgE/j5KFd/Uo/zFOl+dJSk27KGlWmeNNjZERWk8vonhK+?=
 =?us-ascii?Q?ffmOKifc2SsJvTjzkHZt6px3Nz9Cc8T9fTTfSYDwScd02P5tHNl90ySphJJZ?=
 =?us-ascii?Q?zNJKomOVnIbfUs+9GNVksyxTPv+1mOlHdxROVHzYVkt18I+xTvCnHMTZDtsc?=
 =?us-ascii?Q?9VxNWD2pjXwTjhEW+ihFX4blzLt6RttKWZhD+DutVENlMhXBr8RyMz4ATrJv?=
 =?us-ascii?Q?GD4RAsbbp6MWsUfOu4eqCedwYfs/5jbec3mwpGfe91yI30iXoaOdou9wD8fB?=
 =?us-ascii?Q?wHyexD5A+G7bTW9idLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a74446e-37f5-4c71-ab20-08da69b16f81
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 18:06:42.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdC822D0buMiMbCHpZ0nCpPJzpypQ26RVgbcA9B8xsp7xn0Z3gZMVpzBXGFoIh67Xr4EmPLtImQs22n4ZzCFzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping!

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Tuesday, July 5, 2022 4:27 PM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: bhelgaas@google.com; michals@xilinx.com; Bharat Kumar Gogada
> <bharat.kumar.gogada@xilinx.com>
> Subject: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
>=20
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functioning at Gen5 speed.
>=20
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additional register bit
>   to enable and handle legacy interrupts.
>=20
> Changes in v6:
> - Added of_device_get_match_data to identify CPM version.
> - Used enum values to differentiate CPM version.
>=20
> Bharat Kumar Gogada (2):
>   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
>   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port
>=20
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++-
>  drivers/pci/controller/pcie-xilinx-cpm.c      | 64 ++++++++++++++++++-
>  2 files changed, 98 insertions(+), 4 deletions(-)
>=20
> --
> 2.17.1

