Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597DA70D2BB
	for <lists+linux-pci@lfdr.de>; Tue, 23 May 2023 06:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjEWEMU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 May 2023 00:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEWEMT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 May 2023 00:12:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6EC5
        for <linux-pci@vger.kernel.org>; Mon, 22 May 2023 21:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke4n8jX98xrZQLpS8O5HIfJlDzb+etZ6OGTqgpVv3QufhqjiBYIi6xEOBIpAlJH/kNM0FiFYJUH37WnWY2vvpv9AKtYYlm8Ca926LQGs8HQD5CbeP0Od2Sqckyj1EBhFjWV3K3Yo45907jVHcz4I7hBo3lZKEEkUG6ZdVcigboRip/MD3qbQbJQPWAjqEf7gL4s4IqBtBZvHQL66HEKCX6yEF+X3a60VN1DIUfOPjBbMLnlkgmjf867aZZjZZy5EoTlLCHpnsG8L7ZGq9LdOuvAKkHUFUhlncvgLf49ZKLzx6PxtnvTYdhZ/2hEbMcrKtSKMNAf2ZYM0emgWWyH/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4vLSTYu9ZDrDV4UVQjukVapkRCmL2DtBqeV1Dg8DCw=;
 b=P9wgTQf43Bz7+dGosvMc/n7I/zZF+LXlZDi8dXBwo33NHSYF1bXU+cv6wyjzEB7ZhoLJw+igpJQ8TgSDYPTvZRmYsUECPjQka9Jmk0FEtHCdw9FVHghXlMrh0oczEomQWaFbd/HTbdysRJQODi9TO2qiS60+a4WwRdHid0GJQAhblPyf5R0ZDQjR625AMAjX6MX7ffR/tPjngqkkiJJS3gumbu4GlKfqByXOvfmwh/mYxiFaTVIbe+aP9DlQDfks/Adt3rGq2qDqTy1VfE0/3iFfgYhkDBelCSuMIFcTVh1qokgQudz7j7bGWfR4vZYWJEbKZx1mxS/t0ithnRNDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4vLSTYu9ZDrDV4UVQjukVapkRCmL2DtBqeV1Dg8DCw=;
 b=T8UmYPytZ2njPszTlW6Pys1IZjQvsv7B0pWvSe1TLyGnvL5J/vqHBwmHX+YM8PHbySIfkiJdzH9qqHjka7ff0r+fCphhUnFq4zp76hiOtQvWebdMPD6V6NtGy062SP89mQRBN9zzJvi7pIR/Wx0qc1FUxXR3J75xhdKXT1N8M7w=
Received: from DM6PR12MB3196.namprd12.prod.outlook.com (2603:10b6:5:187::27)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 04:12:14 +0000
Received: from DM6PR12MB3196.namprd12.prod.outlook.com
 ([fe80::e201:255d:55da:b24a]) by DM6PR12MB3196.namprd12.prod.outlook.com
 ([fe80::e201:255d:55da:b24a%6]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 04:12:14 +0000
From:   "Zhang, Morris" <Shiwu.Zhang@amd.com>
To:     "Zhang, Morris" <Shiwu.Zhang@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH] drm/amdgpu: add the accelerator pcie class
Thread-Topic: [PATCH] drm/amdgpu: add the accelerator pcie class
Thread-Index: AQHZjSt1Op30JxNeQkeB2DwUuotY4q9nPWiQ
Date:   Tue, 23 May 2023 04:12:14 +0000
Message-ID: <DM6PR12MB319668C72B12A25EBE1E21E2F9409@DM6PR12MB3196.namprd12.prod.outlook.com>
References: <20230523040232.21756-1-shiwu.zhang@amd.com>
In-Reply-To: <20230523040232.21756-1-shiwu.zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=64ef7473-23dd-49be-bae6-7c989e930af4;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-23T04:05:56Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3196:EE_|CH3PR12MB8851:EE_
x-ms-office365-filtering-correlation-id: ab3e50fb-64e8-493b-8d54-08db5b43e3ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JFn3L8mKmmSu0Ysb2wZia4KUBy/mWEIRLgsO4NS+KS3RuVBZ0meGye2XYIbkiXla0D2c9WcTGiu6Wx78r4yNNHdNKfX+HwwnL0/j7cCkdZZnfEpe9GRBlbanjkFQqV0hklUk9bIPB9bSxfoeqim4w4ctawUsjQTvjPIXbv6vn05CzXsfVHNF1j1U/2nbfx5y7LO4O+/epOlgArwwTYkQ++W7RGXMpWoZC1oIEx365TGb4hcwCPkZlF/X7qxnoyKsCd+Crf8RR1QBYz6sb10+NhjdYGfwgb6RuloWyk+lADAG2c7FOTgY795JfoVKDfV7QHnZg7dGDablefchj2NbdHrSipYSXjQAIFn4zHQ3DOiUVS7CweYZ75KNR0TOP2QCX6N92jyA8UcfjPXwrxNz1BHVba4zUQIcoJLXS++5l8KqOy7ikbKbQ3i85rIcpnubDzaAJ+2GTUH1AgK5OYUJSpoqysA6oe1QZvsUrj2fU56rSOlfnoNF2owUMxVGzApVyw+hseX/Wzh73vm9H+a7U/HNNvxaY8TsEFxYyCEQ5OWbkotaGw+6JTZQ4xDKyaj5kJCkaLWMKvC7RQ7zPjgUB0BPohs5bMRkJcDATcbwWyBu7gx5Jnaw+8c1f8hLhrk3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3196.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(52536014)(5660300002)(8676002)(8936002)(86362001)(6506007)(33656002)(26005)(53546011)(9686003)(83380400001)(2906002)(186003)(55016003)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(122000001)(71200400001)(316002)(110136005)(478600001)(38100700002)(38070700005)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZdQREt71bHh+Ej1SGqjPXFJLzFlu3S/v9T9CdWXXXvQJUPY743CSiutBZYC9?=
 =?us-ascii?Q?qLAWxODdht/t6WpSGwrjppra1edTlVA39BkqI0U0qiMKPQ230/zJmeFs1jiQ?=
 =?us-ascii?Q?7LptajecGjzZU4NH4cHsYhJOGjlmQHTW0p6IS+R40vFHQfM7GITjq1/ChBCc?=
 =?us-ascii?Q?D5bcJfXMa+LszTiGVojEGHu3MgKtDXpPU0k4bhXY13tBQ1taAvjG3oKMWRBP?=
 =?us-ascii?Q?X8YMFBt++EqUPraoA8NSTxJDxK9KsFaE5b1wtP2K0OIqGexA5zzA+vUX5qNI?=
 =?us-ascii?Q?wLn8+K0P6oEVOD5ooMNddnLqOSVe/ewCB0zFWDNncT/qv2BCU96rrW69Sec5?=
 =?us-ascii?Q?W/IL42isvTi4OceRQlXZQLjT5cvjc33Vlynj8wYB0lBDQFck/rlINBK2beZc?=
 =?us-ascii?Q?5g04Sme7ATIi87VC/fKfgXo6z5MvZdFEHXSJGSjA435kNX0jGESYobj6HOn0?=
 =?us-ascii?Q?sw8WdcqkcAhTGrRy4cTVHbQKtKNguhZDgp9mdkir0aNe9nJ35iOPb5EYrpGz?=
 =?us-ascii?Q?X/vto6ldnBLVYbCkl1FrHeR8zNlijzPCe746g5i42hq5yEQzc4mKNH8hRC0R?=
 =?us-ascii?Q?LOWbP7iIPZ+z4YKcApc2Z642T/NcK3Xpn10git2rpJQGLBDzg9Sk/ejkn3Te?=
 =?us-ascii?Q?95v2hUMuuO+MxU4UfmyIY+iew2Cd4t9ggN2PNHljYeTnFFZSWxqQCEmb9aBE?=
 =?us-ascii?Q?op82OT52UuqKaX/ZgN1lVlnPYq8pLToG+5Cjwwg6ioJtKCdxGyE0c+O+3amf?=
 =?us-ascii?Q?s78sCOwP9ThNYcVicKrvjji4vY7wAWIbx92+pFHHp+dWbcKCXaykAZYQEC8c?=
 =?us-ascii?Q?zcrH9Fd4Tcdq2D9/K4TsgKD9smQchutvBskcv+6NKXAHAOwnfWADWz7AXulH?=
 =?us-ascii?Q?nQ7n2at4sns/HCPLXbtFwhHC2vHKV7De+9PGCw1axc7T7Z+C+ZHsha6VWxPV?=
 =?us-ascii?Q?0BZtJvNHf6FRAMb5Z13xeg4kH8sC1MafMVbzXSTS6G4s/hz8UGuSZxTYu789?=
 =?us-ascii?Q?wGLgwh9WvWVApEFSJOxxvfKKmZ76nphg+Duj8tF1Zd9f2ihZbG0N+EbUCfvm?=
 =?us-ascii?Q?mgiyB4ySBz0cKn8X8IpvW6UbDEoZ5mM+dpPn/p7UIOlfU1nTQl/0lZeZfQvd?=
 =?us-ascii?Q?fGLAMTlufM7DerrHQxFHXIw9+j5r3Oz2d/guJh/DCHgWFh28Q5DAMykPJ3oG?=
 =?us-ascii?Q?CRUTKwBs6W51Y8R+JBxvM/u55UZglETgSuiqsjeLYxFu4LEP2jv2a54Hf1E/?=
 =?us-ascii?Q?LmRb4Nq+rhz144lz1uHYcDObefl8Nye+MYRUqeEN0hVlY02+LF9Ht7JY7EyM?=
 =?us-ascii?Q?l4UOH/nNV6G9z/0FeibTOV7lw+aGO4A38ek2jg6DI5yo8NmvNl2Sp/vXpefy?=
 =?us-ascii?Q?dgtwU42nC7NeZ74eKBBRo+IaBbi1YzqvecuPoGm7YTbbAsJS8+YEPbPxk7am?=
 =?us-ascii?Q?YFeaQ3J0gAOrqM+CldZ5JJ0OOpFiGbSRz2dbeqDilmkcbCUqmc6gj9YYeJry?=
 =?us-ascii?Q?Bof29Y/ArfrVpc/Jl/UvcWJchqptZ5jNMTZI9xuaAsl6AciKDrwAXi09WMff?=
 =?us-ascii?Q?/h6BZcQ7/MFPSAxeDZ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3196.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3e50fb-64e8-493b-8d54-08db5b43e3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 04:12:14.7681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18bUSHjzDxlHEFl6PG4i47FBD8U/qKEb2Dv2aT7cQUa6d23wHAZCOd3dfFmBpryg15uNVqPi3rhkpprf4qsqMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - General]

Hi Bjorn,

Can we merge the below change through amdgpu tree ?  Thanks!

--Brs,
Morris Zhang
MLSE Linux  ML SRDC
Ext. 25147

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu
> Zhang
> Sent: Tuesday, May 23, 2023 12:03 PM
> To: amd-gfx@lists.freedesktop.org; linux-pci@vger.kernel.org;
> bhelgaas@google.com
> Subject: [PATCH] drm/amdgpu: add the accelerator pcie class
>
> v2: add the base class id for accelerator (lijo)
>
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> Acked-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++++
>  include/linux/pci_ids.h                 | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3d91e123f9bd..5d652e6f0b1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2042,6 +2042,11 @@ static const struct pci_device_id pciidlist[] =3D =
{
>         .class_mask =3D 0xffffff,
>         .driver_data =3D CHIP_IP_DISCOVERY },
>
> +     { PCI_DEVICE(0x1002, PCI_ANY_ID),
> +       .class =3D PCI_CLASS_ACCELERATOR_PROCESSING << 8,
> +       .class_mask =3D 0xffffff,
> +       .driver_data =3D CHIP_IP_DISCOVERY },
> +
>       {0, 0, 0}
>  };
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> b362d90eb9b0..4918ff26a987 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -151,6 +151,9 @@
>  #define PCI_CLASS_SP_DPIO            0x1100
>  #define PCI_CLASS_SP_OTHER           0x1180
>
> +#define PCI_BASE_CLASS_ACCELERATOR   0x12
> +#define PCI_CLASS_ACCELERATOR_PROCESSING     0x1200
> +
>  #define PCI_CLASS_OTHERS             0xff
>
>  /* Vendors and devices.  Sort key: vendor first, device next. */
> --
> 2.17.1

