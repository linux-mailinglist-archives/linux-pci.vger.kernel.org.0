Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC04B2826
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 15:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbiBKOm0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 09:42:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350978AbiBKOmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 09:42:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11A1D9
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 06:42:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHHQDdDjdPJ9ZT/F8AFGkRGb8nyhiQ4mzH59Yl60XJB8UI89pjXxfE8+pFdPwpdxfGkI0gVd7wspCQeYQAJcpukfRmRGBpiclDq6u+zoBbj/XzoTdLnLA6LGY7bGwWJhhqLlfbXOFtO1waRf9RC/p6oke5+r4x/i9tNJQXSqQzeyHQ2Wwv00pVVXu2Z60fGEjYgkcmX2H5Is4vdrV/UHQ8IdFKf+trQzmnD+RR9DNMg4JX2ZfXgCyyep1RuD9BW0gem0+kiW0fxtnb1vRC0EfxccciQZLBcbzLUv1mYQwfjqBtlOYzrHhMclmReriPKu8Q+ku+SnqmmMtyZ24B32SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyA6BC1FTX+v6Ilt53pezDvHnqifKEUOqaZVTGToAOI=;
 b=PDZCJRtS5b/ZQVIkCFJ7dYdaj6g8MT4gqdweFU0wy0/ukShegS4PwfGQVMx9Tmsswk6ol4RwUSkcFD/1M/zRVU7xHRL10xtyct3XFzKE42ki4sMoSGb4Mmx2p0EYgLllLBpPG/HiBCacMDJUwIJW2mV6tJ63xvW6m2LYDsb1dY/TadFQd6nMxRGfhEsb3EHn8Xh6bzpoMhSmrVBn0S9A3FbZuALWugIiwktj+8RAflkNWUGdY6TwegFOX3zsIcqrDYE+8+Z+guDwpYBhygTJ5t+RaJruY33xh2BG9fnhUnP5R88HUrkNe/DxQ9ys/5DZp5V6083BfFMoUvjBPaLemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyA6BC1FTX+v6Ilt53pezDvHnqifKEUOqaZVTGToAOI=;
 b=MDDzDMPL3B6W029jNN2ArDikRfID3NFcgHLDnq+ZMI0Cg90rJJzH9rLq7Dx4tIxp/Bg5bzXvIkaZzra3gu29gV5z9Ij+G0NlR142wgjwX4BISV5/hNEmcvSscPPVaWCnq1ia02yeTlpZbezYct1yisShPK36s5s7cJEGmvZo1zg=
Received: from MN2PR12MB2926.namprd12.prod.outlook.com (2603:10b6:208:10a::13)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 14:42:22 +0000
Received: from MN2PR12MB2926.namprd12.prod.outlook.com
 ([fe80::9bc:c78e:4d52:2bf7]) by MN2PR12MB2926.namprd12.prod.outlook.com
 ([fe80::9bc:c78e:4d52:2bf7%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 14:42:22 +0000
From:   "Kumar1, Rahul" <Rahul.Kumar1@amd.com>
To:     Lukas Wunner <lukas@wunner.de>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Thread-Topic: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Thread-Index: AQHYHe7NoripXS4z/k6cIS9tep+oqKyMUXkAgADxaACAAA4TAIABGu4Q
Date:   Fri, 11 Feb 2022 14:42:21 +0000
Message-ID: <MN2PR12MB2926BBA4DCD4D7ECCA453577C0309@MN2PR12MB2926.namprd12.prod.outlook.com>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
 <20220210062308.GB929@wunner.de>
 <6da46e96-8d71-3159-d4e1-0c744fb357ba@amd.com>
 <20220210213732.GA25592@wunner.de>
In-Reply-To: <20220210213732.GA25592@wunner.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-11T14:30:11Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=17b04055-c671-4129-92c0-08e63130c3ec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-11T14:42:19Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: f13f9376-ebe7-4f19-a8c7-7d4c995c9bc4
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4b383de-8f4d-4121-79fe-08d9ed6cb65e
x-ms-traffictypediagnostic: DM6PR12MB4201:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4201EC6FF71DA6EF219A4F09C0309@DM6PR12MB4201.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWcgWfIcMnIfOTohTcP8mwVova015jdosOud6tiqbynaDEmg991cEvPsMnLvQdCZE9MJhN21vPavBuCnw5sB7CK85dwwztP2OnIjhQJaFs2bUW+G/xWnRCYvj3YiH8NWIr2e13gDG3gDBA8FNDGSx1Cy0rnfaeFwJBf4+WBlCbnwDwx9gjcvw+mmbaufw44tGOKR2iZSEDFizKpkHYtuioL47HGf7Vy+vm6Cq0NKnouYUpBHdGXAitJBGW7Vq/qFE5FdpBb7rgwgL+1Wjq7lWwfe8Bk1GAxfZfAu/Ug3FCPHsp74QPsHhNaGO5DVLl7fbTSV6cX/8XWWZ1jzJdne6Ly81/t0tRPhGQvlDrLYn1XNZc2oDOlP8dNJDAKInDyg7RY03nsbgVgxP/gExX2WP19+NlUAWYMqpeWtUsRjc+EdLAEWcykQOXsGIvcBViCKp79ggxBjv53coel8dUTdAXHWLX4zBhpFR86+hU/5ASj8tauCA5safb7GIv1xiMlvGPZxgJ4lPxLjg39m2MSS9UoEu136PUFkIpQUYaT1fMKiKtX9lvgW1G2NP7wETyxmao/3oqzvrIc1JR7YkvpHc3p6MzBfWyffrXUom19yYcEtxE2eGcTFbtyCghLl+NItTODZP5fb7CILzHmu4vqjFPg7vB98RyenI4r1XBjtYXrl9Sc9Ud77K4AXtyVrnv6++wLYtl0TW4Y3Uju8TZt6JUbBfDMGLIsXQL7iAFZxw1QG5PK1xv54is+EfSUgCy+lIi6EkYS1/ghD3oGeNw9vAjahR96AO2VwyXqneHdEoMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB2926.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(83380400001)(53546011)(7696005)(9686003)(5660300002)(186003)(6506007)(55016003)(966005)(2906002)(52536014)(8936002)(110136005)(38070700005)(54906003)(6636002)(508600001)(71200400001)(316002)(122000001)(4326008)(8676002)(86362001)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(33656002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bPjR687EjMPZ0ElZt3D0U4mUEgV5K3MW7Gbaz4UMioeTmTIt7FtWTVevEM/v?=
 =?us-ascii?Q?6YiKFSBD1+uuNTLVTaahFokyOwuyJeSLXeD26dV3Bj/CkODZN1Bfn3qeXUhd?=
 =?us-ascii?Q?SM/lwSEGRoFflnfdPjb7IBWzroKZZrBYBZhVrW3vkzuPq0Tm2WZDxXrBlZ/l?=
 =?us-ascii?Q?MF4eEuKMrz+ZKmCOhtB/AlYYAC722/VS6ve4LazlumE2sG1sSTIFrHpj3ZHX?=
 =?us-ascii?Q?RNbv0Z7xxaj8AJUzQ9BKv4mPMk/KS//N01CFWxirAZcsAcpt9SJ9lolUSE7P?=
 =?us-ascii?Q?6vLWEMrZtNYThz5rlzWBHavA8dtENl3TleGJE65Y1RkkEy+r4D8AgVsZf28s?=
 =?us-ascii?Q?+VuMUsKB9T+5oxznLX4Qosp3WCl60vaPeUE7JgUUeKAyTmNT/AjE78r6odq8?=
 =?us-ascii?Q?HqWgxWsSTJJTTvwIrFXWZltSyUg6ApRGWxFfeSESTcXr7IMeFQ5OBsNJL/NS?=
 =?us-ascii?Q?eP30r+kREHrvR/3fms00i6b74sMgG9QIbNLN7WP+Bt1shUMEctYgpkQ3cx8i?=
 =?us-ascii?Q?32+fyIjlSl1BoQd4rpCU+oGqq1ZOx2BhsnIAYF2QFRdIVNgkH+oy5Gd0HHsG?=
 =?us-ascii?Q?Fpi0r9xTTbuPRxz1jFU3vsnuykoSloyJIAi4d/QLNr1ZrRNuWnq4j783fAWL?=
 =?us-ascii?Q?nKZOI1Hwn8ZL835uAzIWqe/TS0zESGcQGJovXh+Gj5pG1/AVJbrg4hCgzT3C?=
 =?us-ascii?Q?qwl/Z87WMxDKJRiN+6ERHRLpee3yM40k9NLLDYIXlaExPWBAWmAK/otst4kl?=
 =?us-ascii?Q?P+GQTbYTPmCBTKvrabtwm84tJEuejbbOKaIVTdsQKwfOuNZz67g+vvBel2iD?=
 =?us-ascii?Q?VRRnYKMt6Bz2HXpsKDDhjNLUfDlDZ3g0XvqusT5M3IpPRIRFCTJg/9o+pyng?=
 =?us-ascii?Q?PNZzCDKASLwMZW4QlW3c0mIZv5LEL8QyAUVD2cLcDhe8RsyOMMJY1WK3NVM+?=
 =?us-ascii?Q?sRqu+zHyH4jQgKkkeDeDgbn//CqIXJAIwc7vNJdnEs1EZGPn+/KnHkjX39Kd?=
 =?us-ascii?Q?gG/EGdp1D8J4nx6ysui0CCY+UFGUuKSkc0bcn2ULsnA8iUEp5BmW1xKCJ84b?=
 =?us-ascii?Q?ec3JKagG/C3H4O73maPFaiPfTxkeKEFlWfmy27E17AKh7xXjcVDnF8Yi3mlV?=
 =?us-ascii?Q?984kkMKa19EncT5tabOL+OK0vF1Ev6yP/uN49c3fdtucjoAy1DDSsNNFXagG?=
 =?us-ascii?Q?XLMrrFnM9kxymhTEYjoeV3Yk6j1wAonOSAUlEXRGqGIhhEC5I6T3Gt0F0Hjg?=
 =?us-ascii?Q?1uJFCA5nLmKT8IRzrBd0uFKQW0LnEGKpPh2BDnp+luarG+3fbB7WTYgntf6Z?=
 =?us-ascii?Q?rZFnsmPPf9H2i1sOnL/xzNpcenltxlFPQUQiy/dnFS8BE7gtoDWcfnM1EVVp?=
 =?us-ascii?Q?1j2vYn9azXlTPl5DH/eHUs1scFEgKo2w+TuOczE2V0H1zNlO5+6Hzo0/a6O3?=
 =?us-ascii?Q?x8ulVx+glQiHoQ7Ci+czBS5F8mS90drFCSG93KSxSZoNYXsenRnXpJgPfMa3?=
 =?us-ascii?Q?pcOHB4mJMl9qOsYQai9JRtlr0ryq/i21Eqg7hRQ90eFJdqAwFDHC60/g96DN?=
 =?us-ascii?Q?anX0XV6g0vSMyRlLOh31ZYQh17mQTwtdPFHx3SaVUtk87LPMEXCGZ0qcsdP+?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2926.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b383de-8f4d-4121-79fe-08d9ed6cb65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 14:42:21.9969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FP+oGfaqkzHzMMEWtoGw6vsDj3IMUACUuS5LRI9EVmUDrxxbGpttFYbsJZX2wSwP7nAVJ2GcSEikUa+W2daUpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only]


Hi Lucas,

We can some changes we can see in lspci from working to non-working case. B=
elow are changes
Link Speed =3D  8GT/s  -> 2.5GT/s.
DLActive+   ->     DLActive-
BWMgmt+   -> BWMgmt+
PresDet+ -> PresDet+
EqualizationComplete+ -> EqualizationComplete+


Also when we do reset via sysfs, we don't see this issue.

I have created bug here https://bugzilla.kernel.org/show_bug.cgi?id=3D21559=
0


Thanks
Rahul
-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Friday, February 11, 2022 3:08 AM
To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Cc: linux-pci@vger.kernel.org; helgaas@kernel.org; Antonovitch, Anatoli <An=
atoli.Antonovitch@amd.com>; Kumar1, Rahul <Rahul.Kumar1@amd.com>; Deucher, =
Alexander <Alexander.Deucher@amd.com>
Subject: Re: Question about deadlock between AER and pceihp interrupts duri=
ng resume from S3 with unplugged device

On Thu, Feb 10, 2022 at 03:47:10PM -0500, Andrey Grodzovsky wrote:
> So the patches indeed helped resolving the deadlock but when we try=20
> again to hotplug back there is a link status failure
>=20
> pcieport 0000:00:01.1: pciehp: Slot(0): Card present pcieport=20
> 0000:00:01.1: Data Link Layer Link Active not set in 1000 msec=20
> pcieport 0000:00:01.1: pciehp: Failed to check link status
>=20
> and more detailed  bellow,
> we are trying to debug but again, you might have a quick insight

Well, the link doesn't come up.  Is the Link Disable bit in the Link Contro=
l Register set for some reason?  Perhaps some ACPI method fiddled with it?

Compare the output of lspci -vv before and after the system sleep transitio=
n, do you see anything suspicious?

If you reset the slot via sysfs, does the link come back up?

You may want to open a bug over at bugzilla.kernel.org and attach the full =
dmesg output which didn't reach the list, as well as lspci output.

Did you apply only my deadlock fix or also Kai-Heng Feng's AER disablement =
patch?

Thanks,

Lukas
