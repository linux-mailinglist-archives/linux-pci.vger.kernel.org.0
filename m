Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7027D6160A1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 11:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKBKMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBKMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 06:12:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D287240AD;
        Wed,  2 Nov 2022 03:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLfKu2svmYqMu6ecQ97GBchdi/2bw25MH7SY3BWQW+BS8ePkeeVJKL7L1IPed68bfCVKViPSQA9eJBV/gOlhyEMi/8W1BljWDS7oGNWwtHaW6gFvfmCj4XqRpo+Jb+RFwL/CIpzv8guyE8dS6crW6FjyAh39euTqd23e2d3REmEXiZAKHhB4tfKtExAvF8NEONLEVG+Bpmo343hj7O7NGSD3pC7ta+5XQ+hajb0ISPw37frDQcYp3Lu12KyMB6Ts2Gx1Xg4dIlcvMqyn5rRW8wkU9ttcCcpF4rZrbx3c+tuM6s2ndO+/yr+qwAxM1EnD/XXSgbDQP0lCd3sIfjkOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtueYnfmYeZFRtUgBzFnoJuriN8/XRqaJYeHb6Y08OI=;
 b=FbQNtcjOz6ZRkdgFWEWVMTWzACZeixp9BMCopa9tBTRmjVAvcp71Z3aJ04r4v27ypa80eDDtPP/gaC1mHaLsGAJ3ZEr3yKxfnqifyNLUZNkhBHoH9cDw04RHWfsj6KM8ysPTFX4yrvAVc02YSugI+zjShchdZzIuZn3XMrl6Fe3Y229iG0jD55mIRBuOfBscUDfQCfym9QcTHa989gDj6eRRzALwpqT3ynWwaNKEjAAZpricAAzeA4X72g61hSdorvDcfjxaiCqQEiHh1y3x079U2HJVfMwqOy5GhPbQZrWArTFEzC+DZ0Jo/92OyBej+AKrwMaafL1z66tna28iTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtueYnfmYeZFRtUgBzFnoJuriN8/XRqaJYeHb6Y08OI=;
 b=uAOumIR+Dmqk4lGL85ixSOaMSpq1YBTml1Dby7HQsoNiQk98QMLtGbRaLPbFO7hMeibVvVj2gaIyHgyqCX/PtQzaqrp2GEGcGtiDy/UdSkU1GsHwjDbjK/1Ft0hbaxcOgjdoVUJRrGe+aM6LckgAMa+dXy1gnxpYo+/iJI8hDt4=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 10:11:56 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::4b4:ce67:45a5:8578%12]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 10:11:56 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Thread-Topic: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
 schemas of Xilinx NWL PCIe Root Port Bridge
Thread-Index: AQHY7bHIoNpmBC8xCE6+Irf4+WDxP64p9mYAgAF0uuA=
Date:   Wed, 2 Nov 2022 10:11:56 +0000
Message-ID: <CY4PR1201MB0135FD6B87190F439FF103C38B399@CY4PR1201MB0135.namprd12.prod.outlook.com>
References: <20221101052049.3946283-1-thippeswamy.havalige@amd.com>
 <20221101052049.3946283-2-thippeswamy.havalige@amd.com>
 <166730310310.897892.15492131590720845659.robh@kernel.org>
In-Reply-To: <166730310310.897892.15492131590720845659.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR1201MB0135:EE_|DM6PR12MB4579:EE_
x-ms-office365-filtering-correlation-id: d09aa9ae-ce13-4a5e-a6bd-08dabcbaac0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: swhpkad8SS1urPB+pnYIJkA+EgMLxbert0vsPzEqL+mV0zC5vUf713+RQ2xCmephIFq8TZAFgCRXvFU1VCu+RY5FUJOREpYWQ8XiSVamuLP0ZFCZ8sxMoL+VACqaBllt4XDQmM7IHjahfjCJY4sLtz7Gk0VKQADT0ELYowsY9AHfxHX84c1Fzt15C4e0NHF10Xc+r92DxcPYogeEU0SlfNlC/xyB1og51Y74p8CJLsAOrNifsT4cL+pmGmgkc2KWUB1xeGFeJjXBrzR5ee+ux9/RTOsaUQKzhuX+l2N7SitWK8Lra1NNxBjEeQ3vh4U7gRIwXzcfjkLIk7Gl0VNPJ4iM5nWLRCU0pIPlrUy/BmJ5304VFWGQelE4G/ZnaFu1hmofNzV3+S28RJfBI5HrEiqErqsONYruHTKdEc3B6wsjYLho2vUkrsI0/18GMouaLUt4HVhZXBwabTc5EUfheXLv22TuURKBpOZ17CMUS34RJK8BmkQblAXvOqxKJ4QVX8MaQNk8fjsHINF/6014HUZMm3V/VWJrrd6qSbQi/PwK31c+GFHTXoCl/zEDqupRSlnJ4UwIofk/gwWmEtgrDqWHfHwz5JjUQEtI71eLdkH30Bf1R3yvboVfIX3b9iFMBZjhaFNUqPWQt1soUNHeWqn43WmgEvdwYpjlhAAtHYPJhwT0ATAqhMLczTM8L3MOzlaYmZAe8mzhSmRkQOBzhiqx+zacS/r99zO6IC5NxV2oAqbEid17iAzPhPyZzrd1e9Ls9dHV8lmK7p2A5/Sf9EGpzqognIkvqf57dOH/cBc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(52536014)(8936002)(5660300002)(9686003)(71200400001)(41300700001)(26005)(38070700005)(186003)(83380400001)(2906002)(55016003)(478600001)(966005)(38100700002)(122000001)(6916009)(54906003)(4326008)(64756008)(6506007)(66556008)(66446008)(7696005)(76116006)(8676002)(53546011)(66946007)(66476007)(316002)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ePMoVknc+lm/ctWZOxa5ZSc9D4CvsRsxepKxWf3YvOc58kAWJvZWf7WS4fBl?=
 =?us-ascii?Q?WJQzAgbIXW0HSGMHicXkrxNpv7ImUs8yOGIaN77MFKBt2GZSsyPam1bTHyxx?=
 =?us-ascii?Q?8m+FXG96s7N3P0Lm4skx30jcIYuRp6HaRAQB6rD+7gox1H7+FTacBrjFSv4/?=
 =?us-ascii?Q?cti2yXA9x4dw76jNmR0EuXDU171sLK9vyK2H0flFK2BuQ4Sp+DuIe0e3AI1P?=
 =?us-ascii?Q?HBK1Us6/8hSMRnaw2mNVFA6olpeg3b6qJi+Yxz0l9gpFWcN2YyzNp02SDe3w?=
 =?us-ascii?Q?IS0cTk/frBjE6W8uKP98l4iAGFMLZ8SBB0iZ7WbrNjFy0mghwuzgwuGBrsAc?=
 =?us-ascii?Q?35DhBpjM7PzAD77AL2Q1EyGbbsgJIjhkVH6sNDo+LVYjivaC5ZPHcIFgdGHp?=
 =?us-ascii?Q?TXAcSsY78Ia7rvTSO3mKfLnBVdtcxkbIkW4luYNQH3VrWYKex344QBT65I8K?=
 =?us-ascii?Q?0bC+M2++RI8Nme+Axwi8ue1x7zAGbPqvPRFz8+OnT0+xsRB28hPJNHYSwZ+a?=
 =?us-ascii?Q?59EGnOmtkzkp+rTDR8VHCbjFTABhfegxJu/QqAhKsAYcC6R/v2A4a6TZ8fBc?=
 =?us-ascii?Q?aL53LHZU01VNIln9263JqvBvTDhxKC7Qy38OiJG3Rj5VrxZ473nMK7+MAcBI?=
 =?us-ascii?Q?0p/ljLQKFRhuHj2xGgv0Z1d5IB/z9jWTPwVhBRVXrWL4hmuTwjQ5WvOKsu8U?=
 =?us-ascii?Q?n8umD67HkDKj7cMR4ShHWu2iJDNJYTKMetytd/0OcOgMp6SiY9sBIAhVWHpf?=
 =?us-ascii?Q?GwM30xDnIz1SDyYODNLRQ+RL3O9er1cRHdvmZCWpaQ2TSho+ARKccQLt8+58?=
 =?us-ascii?Q?pCFz6elPfshQedsGA6w7pWmJ4X25tfuTA1yHDgQ5JeDsoNpvKu4xIT2rvJgy?=
 =?us-ascii?Q?izLoZqIInuXB3GuIy/eg8+RN/Tc7Fc9asU2XILyMdIY/yRTS9Zr0nb19SohW?=
 =?us-ascii?Q?N0NiMiVEMB8Nbibbpbbh5tDsbyA9mRjDWRkfi5qfAliid+WS34Dhswh0gmuu?=
 =?us-ascii?Q?iSAGwO4JRV+U+vlVeyg6vMG9V+FirKf8QlcRbr+Z5ZuKBiJahBv/sfMPzwye?=
 =?us-ascii?Q?9AppgeD/Hzm8fQAyqClpqNwQg1/TnIoPGyPObXHGYbP1gm2gVSl5D9HJbPAH?=
 =?us-ascii?Q?yMurXk7psyCea9i41bYFWwzGP/dPg/IcU+fhN2uXPwyHFjcWkBTr44XjbHZV?=
 =?us-ascii?Q?nAZiRRvI9W03DtMOBwvdXkWf8PZo1X9kF7PdNUPjeh7QmvqanLGDSu+xQmsn?=
 =?us-ascii?Q?qp1ndsPuMn/7gUsgm4i+EQIsjZmEFSziOMEH39WYUKmiVdNZoxCuqO8o6/KF?=
 =?us-ascii?Q?oS9W5MLeobEEc+RPpUDvtNhSSIv/XQAtTRTRKiKz4mSPUSz5ss0MmGqVcE8t?=
 =?us-ascii?Q?uNmQb+yyTdmuceSycNHc0htNadXX8D1Lrfe8K3jyCLZcjxXs+jrhihbyCNay?=
 =?us-ascii?Q?PQD6plZ3theyioo5qmGIi7z8WfD4+Q084W/TCrW6OxvkNIiZ237kgiK5BDqt?=
 =?us-ascii?Q?wqQ0oSvzMBN2FLQJ3mO+OF/7Q7yYQlTzxUX5ZyVv39UjPPcgMk+NDasVccU1?=
 =?us-ascii?Q?Xmkvrfv0wq2jGhZCYO8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09aa9ae-ce13-4a5e-a6bd-08dabcbaac0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 10:11:56.2367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoWDSKW5aMq+yeatfD24ojp3s2yCHpJtf8QivHTT+42K1++5ZsB/FEQs0tCsO7NkbPkEE2r2xutBNkQLnfE/cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Accepted the review comments and ll update the patch and send those again.

Regards,
Thippeswamy H
> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, November 1, 2022 5:26 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: robh+dt@kernel.org; bhelgaas@google.com; michals@xilinx.com;
> krzysztof.kozlowski@linaro.org; linux-kernel@vger.kernel.org; Yeleswarapu=
,
> Nagaradhesh <nagaradhesh.yeleswarapu@amd.com>; linux-
> pci@vger.kernel.org; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; devicetree@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: xilinx-nwl: Convert to YAML
> schemas of Xilinx NWL PCIe Root Port Bridge
>=20
>=20
> On Tue, 01 Nov 2022 10:50:49 +0530, Thippeswamy Havalige wrote:
> > Convert to YAML schemas for Xilinx NWL PCIe Root Port Bridge dt
> > binding.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> >  .../bindings/pci/xilinx-nwl-pcie.txt          |  73 ----------
> >  .../bindings/pci/xlnx,nwl-pcie.yaml           | 137 ++++++++++++++++++
> >  2 files changed, 137 insertions(+), 73 deletions(-)  delete mode
> > 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> >
>=20
> Running 'make dtbs_check' with the schema in this patch gives the followi=
ng
> warnings. Consider if they are expected or the schema is incorrect. These
> may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>=20
> Full log is available here: https://patchwork.ozlabs.org/patch/
>=20
>=20
> pcie@fd0e0000: Unevaluated properties are not allowed ('iommus', 'power-
> domains' were unexpected)
> 	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
> 	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

