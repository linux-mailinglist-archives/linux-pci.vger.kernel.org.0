Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4551F6571F7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Dec 2022 03:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiL1CCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Dec 2022 21:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1CCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Dec 2022 21:02:30 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60709ED
        for <linux-pci@vger.kernel.org>; Tue, 27 Dec 2022 18:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfOR2PIRK7BET/sTOrLWA5DHqIWoOyNWCqKNkRGp23FVDvdqWbTA07Z2rZvSYaYEIaImvwEr7u23Lxj0x4wc4CM5KwLcoiuccdtpqEsgSF7LSJW28Nhz8v8RsyEoLsadjFBxxOOr49Zh1/p+GGC1yBRAp/ODi1YrYvp1D/lzIRrl89eJ3ftNNKYDVEJzQQF0ST9bSQ1+FLRKqqjuVXHonPTB1e+41JF8fobPIAtw8m/8W2X/4O/kp0MQf7rRmLr25T33ToZDIKz90VXPyUjQkwez3snAxI+WEChptSfeOnAVOjbhS3ghf5kWlwRTWtq89kVnVxEqi0E1b+vwybG+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSn3hnH2ibEj8yJ0szhUzEf2Mj5H/xkslN+bkEXKU4w=;
 b=oTG1cJRm1swYITSIZtQ37yLKEeOUUDAbHYmT/m3q/r+V+vzoF0Dh/lCcsZgujwjLpVfUILacoPg6OVKgdJZxgcImnf5cE6UDyZUZhkIYinU0MVVepDehwYxEQ6bNrI9LKLOUUpksLZx+VEmKSjEhIKfSxEc+X1SdlOOQLJhzKuYEjjggXykqE74oG55RMu3AuOgaiQfVm3WfrdOmgHvyOF9PRrkhvmm1W44uw0MQI8XXXf0y/5VAkitEatTjSVvLKYZTkV5Jg/Xw0sDiQsg3BY8RPd+Ra+JzyKcOB04JcigRFIIwr0X7Wk4W6ONROb9jgQeKtIzYB26dtd3aF0C+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSn3hnH2ibEj8yJ0szhUzEf2Mj5H/xkslN+bkEXKU4w=;
 b=OuRoZPfSDe1fWaWXUDqK0tCsjK9FAgZDWjRYFWC/W2yT8uprzQvVoZ2fAB0JX2kRhFvUkIglGcYvGA9pENbXYuVSwfB8mTayxj8V4vgttBLrPJST29CywkqcCX6SfUsu2e4FyHECQVMrr2fQNgqswNCgZgR8IN39xpH6isN/rc4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Wed, 28 Dec 2022 02:02:27 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::8263:6a57:7f81:faff%7]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 02:02:27 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhang, Hawking" <Hawking.Zhang@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>, Stefan Roese <sr@denx.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/3] drm/amd/pm/smu11: BACO is supported when it's in BACO
 state
Thread-Topic: [PATCH 1/3] drm/amd/pm/smu11: BACO is supported when it's in
 BACO state
Thread-Index: AQHY/t0CY2fDXZ02rkKSdrWBGMTTIa6CQvSAgAB+7pA=
Date:   Wed, 28 Dec 2022 02:02:27 +0000
Message-ID: <DM5PR12MB2469B28E540185356A376326F1F29@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20221123014307.263178-1-guchun.chen@amd.com>
 <20221227182339.GA452254@bhelgaas>
In-Reply-To: <20221227182339.GA452254@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: ebee0991-268e-47a2-9166-08dae87791d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zetolX48YH2Uifs6PNeuLb4JWgmzCu350um59aleopLsMeJAh7n2zbgyWk0bSF/SAcj8d3B8SLLqOzyuVE+XworBm2jJ48ip/xP+auUM1zD4rYaHm/dpAGGEXK33hwoJftJx/FIh38dJPtXJ+PMmstSqmAhhuVWxSnXKapLNwEvUBqC2BPS3BD1FzpNxGuQtTKLCH0weKorjNtAVV9EZ+M/00/UD61oOv0rUwYwcA84QCU+3bW4t+SBzn8/DIwjxFDBXi6fHj9oQNBirZ+9sLs5qblis67lb6BV2ZxDDZAsNEKvOHwyckNC9NBBZjCiU0i4Y/2W8HTc9tYm1weHprf16Sv8eXHscoIWBOYquArOh7AnLWC8sOm0YLIdxb27f1bKhT2tmoEEZAMDrsffvwS8np3B15rrgw8Mm3vOOO7fZF7fbmIfNyxwZnjdOGA9sVnmJ4ONdwKNbvz0ddDAgAi0vIq80Jr050aYc+SfdkHLEwYNcsMcMo3Rfjr8unY7xU9AynAnB0FaSurNKrgiPdyliSAqEL2v9k1CMvugMW93fEnVOO94GSHLfKVQ/hA9ONDHMmwCS9LFAzHX1Kz42FB3mMgBCiyOrzQpdi5J57tV1UDG6H2iW0799DA9Tezu8GvOkdm9HAZcxLelJAfGwtjkWh+dMbbghlqH7esF0pFfJZfYYNJu1TnTfsmitUMvNwzqyMV2IRhsw+ttbG8Bn3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199015)(478600001)(122000001)(6506007)(53546011)(71200400001)(41300700001)(86362001)(38100700002)(7696005)(26005)(9686003)(52536014)(186003)(38070700005)(54906003)(6916009)(8936002)(33656002)(66946007)(66476007)(2906002)(316002)(66556008)(66446008)(55016003)(4326008)(83380400001)(5660300002)(76116006)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wJ+wJMSCGghVWWsg/a3Jo+R3aGLvvEDZGOadZti3yPTiXIRZvTpaRKe2Jek7?=
 =?us-ascii?Q?7wWS78Bh/SS/LaqCJqC6TaqW2SjjIiMOpzZQSolEf21iSGkbiU2v/FZPYmDV?=
 =?us-ascii?Q?induOKCuFuXQAHuaXuzOsupe+RsgNXnKeQnGDBaGRdNFQkIV2oWbrDxrPpP1?=
 =?us-ascii?Q?3+TYt1IehnjIRm1fT8ll9xamke3oZokDmqPj4TFa6niDWk3fFrKnioV++Egk?=
 =?us-ascii?Q?iuYOn+7F8mLkCrnReU1x0qGwhOaEn0DNWTxsUuLS5qxOAIgTkiM8gvOg60pA?=
 =?us-ascii?Q?lJ57epdjYs3ivLybOXqtfd+yGSbqsbVRhXthJ36Spg+L2GGuuk+ubr45RRgs?=
 =?us-ascii?Q?wf9ZTq4EMrLHeTm+rm6fJDvvpka2gwxdBl4b9HR1607V/M+8jdcd81N+Tlf2?=
 =?us-ascii?Q?VsHwnj6kQdirAlCf4ryohapyABBeZR1J8qlPIjHgfi9LvriNPWn1SD18vKpW?=
 =?us-ascii?Q?drNiray6tyrTjVQYdtsI5cKm/PADw3hyFAY+F4b16Fu4oWRvd+jVmchxKBM0?=
 =?us-ascii?Q?n+omwdhij5DxCvwZGhV8N5z89VPHTl8B3LR/B5iwFPlIILBfLftRoDG00MZy?=
 =?us-ascii?Q?AJfJxT2P9ZhWUfcAgSdkq4gixfHcT92e//+NKV5ySzPquFJozTNjescLW/Ou?=
 =?us-ascii?Q?pkTCFMJRPb/VvfDQwPexoqqE+h8RR8CgXuDTtM/s7VngiYVPJLtxn/9AyY/O?=
 =?us-ascii?Q?Igtw71P6pWqZr1jU4ZZE99JKjja+xDJautP2WL/XtqdJyNQG53T2IHQynRdL?=
 =?us-ascii?Q?xlzthsSd8wxoQaZ1Lkq8nOiu8BRiNauwrHE33+ksgeazUUsIOniqG3gdnq4Z?=
 =?us-ascii?Q?uUL1gofwiTvFA6NFfN62VnQJS3RZSqqgDMkdOnYMoiTTPM2SvESO7sjHe6Rn?=
 =?us-ascii?Q?ilWwIUXneDosEvR3zhydjeaKDeiHL2wbnHKdK20vNG239BJ4MnrS8T3/+S3a?=
 =?us-ascii?Q?OFoXQ8kulkRJIjHDsUm5ih3PREorFNfkpJG3ggFX5ZhJVAEFlpROAV53cvI5?=
 =?us-ascii?Q?HHPCfG6JfxlcadWLFfgG3h8tS3JRbndhWU3AkN276aNP7tSjirQLJE/Jpx1k?=
 =?us-ascii?Q?zRjJ7OHJ4Hinv2BCqYOMnpS/A5qGgg6wr/wzpC72SB30pVJP0YvdacmAJXdn?=
 =?us-ascii?Q?gqGD5ZhbmigA4jZfcWYL7hHK1VWhZIjETOMe7zKYjWOmsYvwkBNmWpLz4nw2?=
 =?us-ascii?Q?7kmrKrCMpuBVjKSQ1vuvG9QRdTRt+EVDea7KmfhdeG6yZEZYow8API90Lphq?=
 =?us-ascii?Q?XsoLBmlRB2ME9frTycTuf/umidyX6qCdU+YiPLp/Jaj+cCfMzHLi2f2ECpvJ?=
 =?us-ascii?Q?/iPLOeTH+SdY9aV89CzE/azHvsK5klv+ajh44kmXB9OeueVo0TXpS2BP6d3a?=
 =?us-ascii?Q?c7U1DVAWT/aK4GiVGT4DQekQJMZMtDAs9LF0MuUmoK8C7nsVK/8E8e+O3JkY?=
 =?us-ascii?Q?eCxTD7Fw1BasyaxKRhaD3Nr2jPQOxy7kDYga5YdQV6A/ICLI3Ew6y7+PX5lT?=
 =?us-ascii?Q?VNdokBs0yBuTZ6r+QkYHi+ne/Lm/354gPOX6YgbuTV4Cl1oweKyVS797zOtZ?=
 =?us-ascii?Q?8VjZ/gTTLBgQvc87940=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebee0991-268e-47a2-9166-08dae87791d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2022 02:02:27.1100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSlKagyw4wz1x1Lva6ITijnn0NQVJGlZvSUKVXVqb/5kxiNoZpYyDBvQN/cegUqSAnMp+KK8eE9mYCzL6AQKug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your comments.

Exactly, this patch actually fixes an amdgpu driver issue, however it's onl=
y exposed by 8795e182b02d. Without it, it was running well over the past.

Regarding the question, I will provide a similar change in smu13 later on.

Regards,
Guchun

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Wednesday, December 28, 2022 2:24 AM
To: Chen, Guchun <Guchun.Chen@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; Quan, Evan <Evan.Quan@amd.com>; Stefan Roese <sr@denx.de>; linux-pci=
@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/amd/pm/smu11: BACO is supported when it's in B=
ACO state

[+cc Stefan, linux-pci]

On Wed, Nov 23, 2022 at 09:43:07AM +0800, Guchun Chen wrote:
> Return true early if ASIC is in BACO state already, no need to talk to=20
> SMU. It can fix the issue that driver was not calling BACO exit at all=20
> in runtime pm resume, and a timing issue leading to a PCI AER error=20
> happened eventually.

This sounds suspiciously racy.

> Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in=20
> get_port_device_capability()")

To clarify, this patch avoids a driver problem, not a problem with 8795e182=
b02d.

See question below.

> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c=20
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 70b560737687..ad5f6a15a1d7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1588,6 +1588,10 @@ bool smu_v11_0_baco_is_support(struct smu_context =
*smu)
>  	if (amdgpu_sriov_vf(smu->adev) || !smu_baco->platform_support)
>  		return false;
> =20
> +	/* return true if ASIC is in BACO state already */
> +	if (smu_v11_0_baco_get_state(smu) =3D=3D SMU_BACO_STATE_ENTER)
> +		return true;

smu_v13_0_baco_is_support() is essentially identical to smu_v11_0_baco_is_s=
upport().  Does it need a similar change?

>  	/* Arcturus does not support this bit mask */
>  	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
>  	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
> --
> 2.25.1
>=20
