Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF5277088C
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjHDTGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjHDTF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 15:05:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ACA4EE4;
        Fri,  4 Aug 2023 12:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk8pDlgA0PpMetumtgxUXZ2jPPONLDtjMfdxF3XcsJDtYymw4y/E7sRJD3ceft7TDdJ1W6dFeoVjx27WjGMZ4vA/TI2Og2iAM106itV43yw+ABHyNccSBKUH+21YD0O34PiUUJifmMiR98LDSDjBgogh3NLTtqBfsc4sKhsdRXQsrMDqXSVk9pwTXU0RiLGhfpn7+EYdGl3VN82sMYdtk1D59yxwwlGh/kF6dcdQdq8yt+2E0YAPAjeIwWLZO7kqlLl/hIsIfdfyXBXXwQ7goqii3/NHvvXtBZ8+2ZsjwUJlosLLpJXuDZ/HuE0gKy2yGkh2tNO3lJIKj1G1otCmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz06TYZ+DxUDkKEaSEnC5VSJPPQcA8ZH+7RWZuWEuQM=;
 b=S2/vUS1ye5HSzbIBdC/cr1p/jBG9wVkbpr5ESaE3yrkfJLn+MYP23cVcOnEAC/hqZNscHe+44vCdxJ8oz+YEj0THLuJgujnRzNExjsFoksOg5WdURrgHow3llEZmk8sbBbiUfJ9IS9THLXizLG/eddjGsnAFzb0O5THDB/n1QDYilxDNQXxU8/idRR/0CkuFOsSlMpcY7m5VS0GM3TITq3MA2Mi4wCB93k9QNEEJnCNbuOcv6GZGyKYpKyN09waeZCxojLCK1qbWnHsMA9VQZPAndcTlIvPlcQSB7mnMZ+XV4B23PRvhZr2vTqnvWWEDAaPETkded58T33BpK87org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz06TYZ+DxUDkKEaSEnC5VSJPPQcA8ZH+7RWZuWEuQM=;
 b=cUxyR+wUgF0TtVDz9zkL2TJaeaemI0jjQxo9qtxU6sU1gLSi3GJJ3Ho6Ark+udiogo1X1zmcbHUZxFyy5rsRRJh79rV3L69HxH0g2MX3oVlxNc/OZCLgx9BKFDdQsIyizEiwh0EwzyK752T9m+5tXjGpg84g1QSl/8eKZd1Hdz0=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 19:05:32 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 19:05:31 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Thread-Topic: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Thread-Index: AQHZxgC0Rv/C4y9Z90yNvq9wBSG5NK/YyrOAgAD1rFA=
Date:   Fri, 4 Aug 2023 19:05:30 +0000
Message-ID: <SN7PR12MB72014E79448FE6C7A47718E28B09A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230803115016.4266-1-thippeswamy.havalige@amd.com>
 <20230803165549.GA102529@bhelgaas>
In-Reply-To: <20230803165549.GA102529@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|MW4PR12MB5668:EE_
x-ms-office365-filtering-correlation-id: f2a51f2e-4b02-441b-f029-08db951dc5f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6gfvGmLsk+9kL8XUfC6lMAyfskMc8Nc8xRuvAAozl4K6gZ1tAaQ+Q8Dmrkq4atidlUltxMY2OMIFXWvYSo1s58u3q+eC7EvciTjjJi5rww/ZDHf8+GF92RNXkl/j3RgSB5QlHLxAKJ4hU7iWc509fqGeSwxFxsehmxbA9ynTOUes48OfynXiPJhOkowfBhwFqJJfee1OQsnsG17/1Feoqc8AQMlyqIXRekTUo2mHTduRA/t9e4PkI2KHzh1UaAQ1ZwHgmBpWGF6DgPQu2DxFF+i2swrVLiJx41se8tP2lPDWWNntuoDZBjbZWMhGPMvT7+nqhjamjtBL1da1SQluWP0jcR6iTmtH/nTmPKHqlhb0KufZOkNQ4uT+Yqy7eM8Zz5Wrrz0yXto0Xk6eUp6WgFPhcaTP0GcjVD8LlsL1K+zAyi2A2+D+bOo0cTora+/OoBBuaGEzTA+inUroWPBdbA7sQodVqw8GoKJ6I6QFTtOnDUZNnXyE6UOwzxZAbrtLTBTvBVSrOOY4zpVGUnmG1+RbFS72zqBOKPm2EQTq3WHTcX8bSTGNO//kPPmatbCD81/I2ZBsuvH4LWGcdZR9TFB5kLzCvUZ48mN/yogLO2KNr0KIxIWnl3yRK6A1j3+/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(1800799003)(186006)(8936002)(8676002)(83380400001)(6506007)(26005)(53546011)(66556008)(4326008)(2906002)(6916009)(52536014)(66946007)(64756008)(5660300002)(66476007)(66446008)(316002)(76116006)(7696005)(71200400001)(9686003)(478600001)(54906003)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CGY6+iNtpSXkOLKOxm6+ExzgU7H9TFjpqM9MCPSP/gs9cq622sYN6sRj248q?=
 =?us-ascii?Q?WmgVGe7e7KftDbGIJ7l2oC6Pkkun9mXDFh+3sC9EA9proxOC552yGfQpG+Te?=
 =?us-ascii?Q?BbCb3XV9XLsgOdT16iAgUwxrTj0b8Ro3mc5TUTrplKw2q68+2a9EDkj/CQId?=
 =?us-ascii?Q?6RYNNCfACvT7gDu5/zOBrEEV/hh2Z54DwctP2GN0sWqbl6FGQ9AnOasscQBA?=
 =?us-ascii?Q?bZK2F1DxJCrHwFVTeIJMXXueft0vTgLX7Z5WTPi6k1n12Ez+qy+kMwOX58CY?=
 =?us-ascii?Q?IejHxOyN+kX7y/lcb7L1hDojFETnrIlaQfeCG0zOkfy7XP3Mnlp3mCuv3SM4?=
 =?us-ascii?Q?gefTph+darBQV/cZa6+LXj1H3kC44fMNG+6XMOjRQMr/I/TKU7SZx3ptPZCG?=
 =?us-ascii?Q?51jkBozV1XjOJxWvp2S5N0b7NLh/gScMmPWuuYIyofUImU6h1y1ye1t5BCoB?=
 =?us-ascii?Q?+X/3pj/TH998TKBrgCtxrgqYEtac06qCOnToOoV5GXHud9z7O7N6dJnOSsND?=
 =?us-ascii?Q?QjU7nOPmDi3KEje16QxltXAP48/CcZ/7QBStbo85eXfNe8qgxWic6e4fDbpF?=
 =?us-ascii?Q?+3VnrU1bQk+LPuHbvE+lJTnxDDRChXSTA6cjOItYijwfrsX3Omju7EdCZZVV?=
 =?us-ascii?Q?ROLFyPxq6MBEZQ2Pm5T7Z2Jv5+55sna4COx3FQeFQDrJPILYDMbU6qPfoBJ7?=
 =?us-ascii?Q?HUXMIjFVIu+Smn/vI97XjS1/wRX15sq+ve1vKqSL+mlLd2SeTY2+4vOLD6lr?=
 =?us-ascii?Q?whchmLxCh7ucT0tjEfP3xQj3Hc0LlyGPAZz3JfOc7IsUhQuUy/Ed4xx0rjWP?=
 =?us-ascii?Q?NgDzS3gsOsWdzKGHUT0daPp6iFU8q4RFA/Od9Fp9Vzoayn7LgxsbyXgKiL0k?=
 =?us-ascii?Q?hZsMg7rKLW0bus6aSKPbfjs6uOxH1hl6ylAlfyvKhzYf/2Q+ZTZ+60tNp5xl?=
 =?us-ascii?Q?xXb71J4feY5Ls9jBJ8MmpkujgrcAjxvu+j3+7OMIciqGPGGPRiyg983BXriL?=
 =?us-ascii?Q?9lj8D/MUG45caUu/1/Bb/VdLNY56u15RGIxCYdzPjQ/rteQJyKTys2bX3XQD?=
 =?us-ascii?Q?LlDnxXVygZlIsBCuFoTFQx1UqHBM/L7kRNKQECPZA5SLa5XSKVt7nCbrLUIL?=
 =?us-ascii?Q?GfDkfWAawPwoMu7ulZQsv6cWtmp8uUKVrspWeC6dnqfqX2+vCX4tkB2wbszW?=
 =?us-ascii?Q?1sPu14SM2lHXftCMEqPoXA3tuQVNqnnYem7HoLFlrLAkKsZ1pr43Fk4NTYyK?=
 =?us-ascii?Q?tVSi2oN4N+ZvI2UHkAOCVPFg4tq4DuneBvV18jXDJkLimiVDABs/CCcI6RlD?=
 =?us-ascii?Q?lSiuK6DfALMdrw8zHD3fFjNxseziB0gg8vrZ74nQYAlbHxToQZ1ik9cNJ9sc?=
 =?us-ascii?Q?tEm2lT0UkrtmSGSe3Mymdt3TwRSaJFx+CFOG5AgOaPPPTwpS0N00EcmFaDZ4?=
 =?us-ascii?Q?URAy6iJMDvB0rmJu8J1hGvWZs3KTyEnBp6DQK5kbc2Q1PLVHZfd0QOiby5y7?=
 =?us-ascii?Q?rLowm7s0xRtLOHC/rvSQEtXUWl4+0N+AQdMtBH/PRXMEECW4XCaAHUgLnq1p?=
 =?us-ascii?Q?emu8lCjLdaR2i4NEKTk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a51f2e-4b02-441b-f029-08db951dc5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 19:05:31.0151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4WSJpCZQ4SDWzZ/Q5ah634aSIUqXmHfsUMTsAV2dRon5CtbckqTL/YWv9g1iy3n0Upl+bYcptusOzU0eRD7+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, August 3, 2023 10:26 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org;
> krzysztof.kozlowski@linaro.org; lpieralisi@kernel.org; Gogada, Bharat Kum=
ar
> <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updatin=
g
> ecam default value.
>=20
> On Thu, Aug 03, 2023 at 05:20:16PM +0530, Thippeswamy Havalige wrote:
> > Remove reduntant code.
> > Change NWL_ECAM_VALUE_DEFAULT to 16 to support maximum 256
> buses.
>=20
> Remove period from subject line.
>=20
> Please mention the most important part first in the subject -- the
> ECAM change sounds more important than removing redundant code.
>=20
> s/ecam/ECAM/
> s/reduntant/redundant/
>=20
> Please elaborate on why this code is redundant.  What makes it
> redundant?  Apparently the bus number registers default to the correct
> values or some other software programs them?


 - Yes, The  Primary,Secondary and sub-ordinate bus number registers  are p=
rogrammed/updated as part of linux enumeration so updating these registers =
are redundant.

> I don't see the point of the struct nwl_pcie.ecam_value member.  It is
> set once and never updated, so we could just use
> NWL_ECAM_VALUE_DEFAULT instead.
-Agreed, I ll update it in next patch.=20


> "ECAM_VALUE" is not a very informative name.  I don't know what an
> "ECAM value" would be.  How is the value 16 related to a maximum of
> 256 buses?  We only need 8 bits to address 256 buses, so it must be
> something else.  The bus number appears at bits 20-27
> (PCIE_ECAM_BUS_SHIFT) in a standard ECAM address, so probably not the
> bit location?
Yes, Agreed I'll modify ECAM_VALUE as ECAM_SIZE here and it is not related =
to a maximum 256 buses.
> Does this fix a problem?

- Yes, It is fixing a problem. Our controller is expecting ECAM size to be =
programmed by software.  By programming "NWL_ECAM_VALUE_DEFAULT  12" contro=
ller can access upto 16MB ECAM region which is used to detect 16 buses so b=
y updating "NWL_ECAM_VALUE_DEFAULT " to 16 controller can access upto 256 M=
b ECAM region to detect 256 buses.

2^(ecam_size_offset+ecam_size)=20

Here (ecam_size_offset=3D12 and ecam_size=3D16) --> 256Mb

> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 176686b..6d40543 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -126,7 +126,7 @@
> >  #define E_ECAM_CR_ENABLE		BIT(0)
> >  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
> >  #define E_ECAM_SIZE_SHIFT		16
> > -#define NWL_ECAM_VALUE_DEFAULT		12
> > +#define NWL_ECAM_VALUE_DEFAULT		16
> >
> >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> >  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> > @@ -683,15 +683,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> *pcie)
> >  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
> >  			  E_ECAM_BASE_HI);
> >
> > -	/* Get bus range */
> > -	ecam_val =3D nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> > -	pcie->last_busno =3D (ecam_val & E_ECAM_SIZE_LOC) >>
> E_ECAM_SIZE_SHIFT;
> > -	/* Write primary, secondary and subordinate bus numbers */
> > -	ecam_val =3D first_busno;
> > -	ecam_val |=3D (first_busno + 1) << 8;
> > -	ecam_val |=3D (pcie->last_busno << E_ECAM_SIZE_SHIFT);
> > -	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
>=20
> "ecam_val" looks like it's supposed to be the 32-bit value containing
> PCI_PRIMARY_BUS (low 8 bits, from the pointless "first_busno" that is
> always 0), PCI_SECONDARY_BUS (bits 8-15, always bus 1),
> PCI_SUBORDINATE_BUS (bits 16-23, totally unrelated to
> E_ECAM_SIZE_SHIFT although E_ECAM_SIZE_SHIFT happens to be the correct
> value (16)), and PCI_SEC_LATENCY_TIMER (not applicable for PCIe).
>=20
> So I guess the assumption is that these registers already contain the
> correct values?
>=20
> It looks like previously PCI_SUBORDINATE_BUS (i.e., pcie->last_busno)
> was 12, since we wrote NWL_ECAM_VALUE_DEFAULT to E_ECAM_CONTROL
> and
> then read it back?
>=20
> And now pcie->last_busno is competely unused?
>=20
> This all seems not quite baked.  Am I missing something?
>=20
> Bjorn
