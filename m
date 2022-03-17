Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685A24DCC1A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 18:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiCQRKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiCQRKt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 13:10:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2045.outbound.protection.outlook.com [40.107.101.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDBC210443;
        Thu, 17 Mar 2022 10:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMAwvNkArkjeqnQvwI/2PVRG7qn0rAbCKEcR3OLJhMtz84zTPHOt6ZRQh/YVA2UWxzjMmHoUHToGMQoS2746ttml4jmrrAbmOzailp7EeLXoE41PclnVilHz3GAe7nYcbbfWo9kClG7na0KcbQaaDGnk8KtrMgXGAaIVnSlGs0lC0XJYruDgFeJej2xRC7pUxsDroZGEyuCQsIN83TGzYupZX8J3pPtA3U6lvrizE9bmyOEbtasaz+B+f6iNZA8KqikUTLCyUdFdCvfdr5JRJ739E1UXkaVf0mTlEmQMn0cEAUcPOAYzJsoyXuPRHuwh4j3dvXOUT83Dr99mUpoBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niPBBfZmvyREtnGDbLUkUheiiHG1UxP9Hhaxc1gVyX4=;
 b=Eth6Id2CKOFX+xkBnKlsc0sIJ+x+X1vLlHAjhczMZqMo4u4f6YI/iozuSC1kI4z3GSKHD2sRzpkKuqOX9D3nAHWnM60wKkO3mi3uKqDV07ZQ7p80mI4NzCdobNPNcjSiRGc3gdaDo0RzXaANNKPFIdMIiJDWYZ79smoTYZYQGlUDVB9rFpVQLZNNGTB/6h28esfMXSYwBuJTqJCn5lIl1N+xAc5i8xM0KSk+vWzoctflk0F+UA/Bi5TNHooIsgHm4Ku/+SXScuYy/KDy6R2FkNMA/arV+6yUFFAs3KA6MXq6n421CVbXdCjs9ayFZ90FrxPe8RgvJVSXf1xJuy2TRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niPBBfZmvyREtnGDbLUkUheiiHG1UxP9Hhaxc1gVyX4=;
 b=maVkjMt/WCaQJcvXv4t2tFpm1MsRfTuoO9Vh3ARPrrl2jv88d8Eh04l+UmZEaqMM0tAPLPzoYGifZy0oZh/7py7NYvtQGlCkqBUFxPQZCjvW+apryoaim26JJ/qMLLq+pN33mlVr4REE3KIryKhMcTJy/xZ2p/YrUQG/ECNQpKM=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 17:09:25 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 17:09:25 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Thread-Topic: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Thread-Index: AQHYOhp64mDBz0dixEuTVKpvZlnwUazDzQWA
Date:   Thu, 17 Mar 2022 17:09:25 +0000
Message-ID: <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
In-Reply-To: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-17T17:05:57Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3841583d-c068-40ec-8aff-6eddf12732e4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-17T17:09:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 49b5742b-79ea-4c65-9e45-2efb02389772
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b97c8f44-9fa6-4cc5-b0fb-08da0838e39f
x-ms-traffictypediagnostic: DM6PR12MB3180:EE_
x-microsoft-antispam-prvs: <DM6PR12MB31805F1945B16275A9334C3FE2129@DM6PR12MB3180.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pi8kmAmYcHZrxiDKcEFh8ePTQHnm7Dn0TKsny8GpDlojAyUTSa0gG0ae9AoXLor03DVhPeKPuewVv1v9UqpN+JDKwPSaQDy3NwS5Ib14sV7kG8jY+JTh49dUFz2o+4q92xhr3XWqRfjjooT1k5wPgKpeXwPF+ivsdy2W6c8jlViYTDXPGTmT2i2d8zIcEtVAppX/bWMB8yZhf1+HkL2IfUJtvvvK0ZLcBjFAJGVkgo2oFmR59v31cHuLfW3+VPf3dLqnfsvGcZFrHFW9TiqKlgNLC2drQrhzgnKhlm6K+UVeqGh4ag5RqCOdxMBMSldaPUhIotavuoebHVpnLslaB0TYA/itx/5UAkQ31LwywRhHwNgd3UKFaF2hP43BK2vvZUYMafPA4RqZt8iIPmCKtiAyErU5zagKpbu6C4dUdwQ1UFw2DbPc0n/oHRpQ+t8Kma6PbbNEdcShXPElYnCqrySUJvdmFzYxIUJwuYRlngcg7Fs0/SxIcvtp20HaFMoSQ9CfQCjigXgJs4IQa78PsNHMw0GzLHmBNlLdovQpruB95aOZGO0oIpZpHNbovR99mPyzoaPYRlz7OZ5mEioWePnHJlzryrv6jd718AChDIVYY2OzSzYlLGdXsj0kEeZkneEDfgxtzztcRCNO6Wif//mG8lutblVlWR7zaaHCz6wnepzka4uKeiMX5si0GtwKIZypLZO5lYDFzVp2bCwwYvGO3+sYUNvNPrRpz+Tjt1/faWDuVasJBlG+bYGGXTP3Vrz268/3ssFUjsOGr9W4EE6rtCy14rrCbKSxW1x8gr0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5157.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(508600001)(6506007)(54906003)(110136005)(316002)(7696005)(33656002)(66946007)(55016003)(76116006)(83380400001)(66476007)(64756008)(66556008)(66446008)(45080400002)(8676002)(4326008)(966005)(122000001)(86362001)(2906002)(71200400001)(8936002)(53546011)(52536014)(38100700002)(5660300002)(186003)(26005)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SQamahXRLZwn7/ocevsL7wiO4FaVSkhFmPuHXZUVuAW7guqfqv+17sAxek4A?=
 =?us-ascii?Q?OsIpZjJKFlF3xZ6Z/OoVipo5Q0QI+bXgO97dQ6tW6tBGF8b9J/4cOe3pyoac?=
 =?us-ascii?Q?+ji1WiEpZTFoinMqQeaVDAqMREFrFfmxDMirquR7Jvc4n97ZPe/vi6L258nk?=
 =?us-ascii?Q?nSem9frMJSrJen8kj8y00gw157Jbn8ZjD02TFvNudVFVmO8yWTEGEnvV9Fic?=
 =?us-ascii?Q?YIZc/OZbhQk2CFYo8R0DIZfceJVYLBKo0HTNSOUY3rgziFbD2Qdq/P3f68oy?=
 =?us-ascii?Q?ndxMWFoau77xQru877QaMOYnSjRrjYepao12/JfxHAKkAeh9FEOOY5hVsaGq?=
 =?us-ascii?Q?HEZUjufvXVlsYJknQQWrURK1xf+9fgMU3BgPo7jpE0PtnAGSi4U6s+UFPjq1?=
 =?us-ascii?Q?U7ugbjmigwHZryOTzvScg5+oD675tiCll9EP1+w0noz5/bT3QiIRQRUy2DWg?=
 =?us-ascii?Q?S2+xzPWuiD7epMKNc66C46nyccRvtbla9DqA/5WyHjNf5o7CpAYFKe+wAnyX?=
 =?us-ascii?Q?q62Et9SvuXkIPC49TUIgJs19AHUX0qEK00Bo4M5f90RdI2s+gKYllKf6RrLT?=
 =?us-ascii?Q?Tm+clSmjbUsbd9IfsE+TItScrnXw/DupY2uSNbWmkvygH83wwc9dhpmgrXjk?=
 =?us-ascii?Q?ArcZ8CO9qeWi8hIfaU4lqymc88ryLVWOp6fmuflwUQZArk887XUQx6dcOzmK?=
 =?us-ascii?Q?YBq6zx0xVgKkVfH+cM7YpRJBeQa2hOV71v+EvHaE8wPPILb8/yPPg2AA4Q5H?=
 =?us-ascii?Q?wDIgTJCW9K+qpyJiRtO9Xuo/WGhwiDuFqDMHhJMVq9ugQ35NXn/SETz2RkuD?=
 =?us-ascii?Q?B1OSDu3Ur8CSsxMzoiBIcw2LvGT1labGf4NlFoDm/91x5sCnhGtO1Ap1ZU5b?=
 =?us-ascii?Q?e/98uZHicSLYApkyBKGHrWfLG1mLekmfeDl0N2v5qy+WTOk7FfZ3e/0ZIAav?=
 =?us-ascii?Q?naLKNF5DVN+bXOmLm/mxsVXj6V9vrRRuhy4TK4NZE7ek0tgK+82rx4VeeRNT?=
 =?us-ascii?Q?tJfMLi2ov4hGGqraIdsNn7h1bqAemYbRFmBpRks0YPKfmSPupA8KoBji9EB6?=
 =?us-ascii?Q?+87fYe2QvYjDAQ3YFDDYSN/Aw7DeOoheZzF/5BMfPCA9AnWXVoFTopnrLD/2?=
 =?us-ascii?Q?i6dGZabA6ZMsI0Nh0xYILtfIVVVtTsAbuHHziOcyXhriLxiLIoVToyts9NBD?=
 =?us-ascii?Q?GsNyPJXRmPeTI77hInTO6vZnI3/5bnwQugsV3w1vhr9nZEKXk3G656vA3t0b?=
 =?us-ascii?Q?j9R/17kX9M2B9IEdOzhjFnE2YhUA7mP2bt0asdealJOpes63klns0lhM0DH3?=
 =?us-ascii?Q?ejslAyfn7rKxJoLqZ+FcC9JsASTudcZZYTny4uBf/rXiUBISu0tBbqqJlR9O?=
 =?us-ascii?Q?i113HNvOvI7G44hLDu4v6YVJrrgnE4D088SNhVBOePRqmBM1Igc2OLsLEFWd?=
 =?us-ascii?Q?jBnvXao/7BkTpXlUn5DvhARAG0YyqJSY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97c8f44-9fa6-4cc5-b0fb-08da0838e39f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 17:09:25.5493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yd3/zpa44HPasz04eb84FK4C4KFXVSUaHDqm/yjJgvZ9OqWaNtFAtiDNtBkOFw80oaHHMU02Yx1Hg2XIHbNvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]



> -----Original Message-----
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Thursday, March 17, 2022 11:17
> To: andreas.noever@gmail.com; michael.jamet@intel.com;
> mika.westerberg@linux.intel.com; YehezkelShB@gmail.com
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org; Limonciello,
> Mario <Mario.Limonciello@amd.com>
> Subject: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
>=20
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
> shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. What
> actually matters is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
>=20
> Avoid false positives by looking as close as possible to the same PCI
> topology that the IOMMU layer will consider once a Thunderbolt endpoint
> appears. Crucially, we can't assume that IOMMU translation being enabled
> for any reason is sufficient on its own; full (expensive) DMA protection
> will still only be imposed on untrusted devices.
>=20
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> This supersedes my previous attempt just trying to replace
> iommu_present() at [1], further to the original discussion at [2].
>=20
> [1]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-
> iommu%2FBL1PR12MB515799C0BE396377DBBEF055E2119%40BL1PR12MB515
> 7.namprd12.prod.outlook.com%2FT%2F&amp;data=3D04%7C01%7Cmario.limo
> nciello%40amd.com%7C14f5afbba9624b4d0ef508da08319b2a%7C3dd8961fe4
> 884e608e11a82d994e183d%7C0%7C0%7C637831306409535091%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D9xJ9bNT3pR3YhqOOqiJtGv94ln2
> IJSvrXllbPZjTI6M%3D&amp;reserved=3D0
> [2]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-iommu%2F202203160844.lKviWR1Q-
> lkp%40intel.com%2FT%2F&amp;data=3D04%7C01%7Cmario.limonciello%40amd
> .com%7C14f5afbba9624b4d0ef508da08319b2a%7C3dd8961fe4884e608e11a8
> 2d994e183d%7C0%7C0%7C637831306409535091%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> 0%3D%7C3000&amp;sdata=3DwSbpjpPQk8ulX8ifOTt%2BNMdO5svwQceQthyca
> txzScI%3D&amp;reserved=3D0
>=20
>  drivers/thunderbolt/domain.c | 12 +++---------
>  drivers/thunderbolt/nhi.c    | 35
> +++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 40 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..d5c825e84ac8 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>=20
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct
> device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) &&
> dmar_platform_optin());
> +	struct tb *tb =3D container_of(dev, struct tb, dev);
> +
> +	return sprintf(buf, "%d\n", tb->nhi->iommu_dma_protection);
>  }
>  static DEVICE_ATTR_RO(iommu_dma_protection);
>=20
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index c73da0532be4..e12c2e266741 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> @@ -1102,6 +1103,39 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>  		nhi->quirks |=3D QUIRK_AUTO_CLEAR_INT;
>  }
>=20
> +static void nhi_check_iommu(struct tb_nhi *nhi)
> +{
> +	struct pci_dev *pdev;
> +	bool port_ok =3D false;
> +
> +	/*
> +	 * Check for sibling devices that look like they should be our
> +	 * tunnelled ports. We can reasonably assume that if an IOMMU is
> +	 * managing the bridge it will manage any future devices beyond it
> +	 * too. If firmware has described a port as external-facing as
> +	 * expected then we can trust the IOMMU layer to enforce isolation;
> +	 * otherwise even if translation is enabled for existing devices it
> +	 * may potentially be overridden for a future tunnelled endpoint.
> +	 */
> +	for_each_pci_bridge(pdev, nhi->pdev->bus) {
> +		if (!pci_is_pcie(pdev) ||
> +		    !(pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +		      pci_pcie_type(pdev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
> +			continue;
> +

Unfortunately I don't think this logic holds for the topology I see.

Here is the NHI on a system I have here:
$ lspci -vvv -s 64:00.5
64:00.5 USB controller: Advanced Micro Devices, Inc. [AMD] Device 162e (pro=
g-if 40)
        Subsystem: Advanced Micro Devices, Inc. [AMD] Device 162e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 42
        Region 0: Memory at b0500000 (64-bit, non-prefetchable) [size=3D512=
K]
        Capabilities: <access denied>
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt

The links it makes (from those _DSD) are:
$ ls /sys/bus/pci/drivers/thunderbolt/0000\:64\:00.5/ | grep consumer
consumer:pci:0000:00:03.1
consumer:pci:0000:64:00.3

$ lspci -s 64:00.3
64:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Device 15d6
$ lspci -s 00:03.1
00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 14cd

Looking at the topology the PCIE root port for tunneling (00:03.1) isn't ac=
tually on the same bridge.
$ lspci -t
-[0000:00]-+-00.0
           +-00.2
           +-01.0
           +-01.2-[01]----00.0
           +-02.0
           +-02.4-[02]----00.0
           +-03.0
           +-03.1-[03-32]--
           +-04.0
           +-04.1-[33-62]--
           +-08.0
           +-08.1-[63]--+-00.0
           |            +-00.1
           |            +-00.2
           |            +-00.3
           |            +-00.4
           |            +-00.5
           |            +-00.6
           |            \-00.7
           +-08.3-[64]--+-00.0
           |            +-00.3
           |            +-00.4
           |            +-00.5
           |            \-00.6
           +-14.0
           +-14.3
           +-18.0
           +-18.1
           +-18.2
           +-18.3
           +-18.4
           +-18.5
           +-18.6
           \-18.7

How about in this function to have two cases:
* the one that looks at links
* and if no links then the logic you have in place?

> +		if (!device_iommu_mapped(&pdev->dev))
> +			return;
> +
> +		if (!pdev->untrusted) {
> +			dev_info(&nhi->pdev->dev,
> +				 "Assuming unreliable Kernel DMA
> protection\n");
> +			return;
> +		}
> +		port_ok =3D true;
> +	}
> +	nhi->iommu_dma_protection =3D port_ok;
> +}
> +
>  static int nhi_init_msi(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *pdev =3D nhi->pdev;
> @@ -1219,6 +1253,7 @@ static int nhi_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>  		return -ENOMEM;
>=20
>  	nhi_check_quirks(nhi);
> +	nhi_check_iommu(nhi);
>=20
>  	res =3D nhi_init_msi(nhi);
>  	if (res) {
> diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
> index 124e13cb1469..7a8ad984e651 100644
> --- a/include/linux/thunderbolt.h
> +++ b/include/linux/thunderbolt.h
> @@ -465,6 +465,7 @@ static inline struct tb_xdomain
> *tb_service_parent(struct tb_service *svc)
>   * @msix_ida: Used to allocate MSI-X vectors for rings
>   * @going_away: The host controller device is about to disappear so when
>   *		this flag is set, avoid touching the hardware anymore.
> + * @iommu_dma_protection: An IOMMU will isolate external-facing ports.
>   * @interrupt_work: Work scheduled to handle ring interrupt when no
>   *		    MSI-X is used.
>   * @hop_count: Number of rings (end point hops) supported by NHI.
> @@ -479,6 +480,7 @@ struct tb_nhi {
>  	struct tb_ring **rx_rings;
>  	struct ida msix_ida;
>  	bool going_away;
> +	bool iommu_dma_protection;
>  	struct work_struct interrupt_work;
>  	u32 hop_count;
>  	unsigned long quirks;
> --
> 2.28.0.dirty
