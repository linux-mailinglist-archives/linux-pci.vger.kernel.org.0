Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E8F7786DA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 07:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHKFHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHKFHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 01:07:13 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F1E4B;
        Thu, 10 Aug 2023 22:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUcK/dsDVfQmUklvr220fLTOkuXdJaRE+v5NF2eLCJvCTkpa5jSo9yDJtImLHweb2B2DM4s2T8gERJAMhPoqI9QDcfgnUY1lpAmQVYzcZo/PwPoyKMrjY+AepJPrg8XpZcAkLLeW6yGsIi6ffUsOxfr2IkuvuODk/lMx+1E/G51ifd15LbqBiFvFuLBvA2+aC/BUBXB9+iSTevB463XBqP8KZgUBV0gobcosYgz3vGFTYbWiguKqXvZn1zULYZBpxCo4wSoUMl6VHiqbQMJvXc6RopLsWbUrZM+at1bQVGV1xpCD3xwVCzWNVHk1B5+4LNaIMgpafHIU9oUvLGWnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLQbB2cQ6EYKqeJmEURzCnI5WCiAluPjeuGmZ7xjyTo=;
 b=M/1IaaMTc6/c3EsZ4+Rm7HZno560PxiZuso4hTQoPtGKk+VelyW1wtqwJfDz0TmolMNot9KzaGoYOEG6B7lAA0Iko3FH0CJ/ReW3sEMSh0BhlGmwSyoNlLSxB0KD19qDWOHHEPP/yaoBOwiuOGBfTFtv953XP/QHVGMBEM43RSUyHjgg7w5JBf22N2REtfpl5FzOYXz4zrOBqL6x/BjXeis4j5mJK1flT+ZAD5MpVfZaByAEKOlT2RkcY5FSgMjjqxVhntXGUdBDctuAqb8KyPEadyKqsawJyGl1JuYZILFgqzeQ51c3EeadKozqSXFMCz6zOauxHcSdWX7pKWjKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLQbB2cQ6EYKqeJmEURzCnI5WCiAluPjeuGmZ7xjyTo=;
 b=AoaIwoSc607/MjisUn52Hu8BKHPS9YxtCAQtY0v4CaYrpCmMx3X60UDt5bvxkyZCn9QymeqwABhnxJYrCYAfeyxs0E57F7rPxV1dB0r4rS15HO8evlB73lDYzeM+UteRiFD21H6RCfaP9C4Y9oP+YVCzi367pIIi+aSkNkisKFI=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 05:07:09 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 05:07:09 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 2/2] PCI: xilinx-nwl: Increase ECAM size to accommodate
 256 buses
Thread-Topic: [PATCH v3 2/2] PCI: xilinx-nwl: Increase ECAM size to
 accommodate 256 buses
Thread-Index: AQHZy4UqZRJ+Ba1xWUmqHNwmw/CTN6/kCQCAgACCVLA=
Date:   Fri, 11 Aug 2023 05:07:09 +0000
Message-ID: <SN7PR12MB7201F56A30348C2E861C72D58B10A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
 <20230810122002.133531-4-thippeswamy.havalige@amd.com>
 <20230810211709.GA1192858-robh@kernel.org>
In-Reply-To: <20230810211709.GA1192858-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS7PR12MB6262:EE_
x-ms-office365-filtering-correlation-id: de4af62f-f32d-4e51-c798-08db9a28d082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8PaLuLewu+p1kEaj41uDvQprAbN71VkG9U//1mVS8Ekvtjkf9aJ4VjRkPp6b4KAD+BKbhw+basdRZ7LLuqrFxdHJEMc7eFIBiAcophqvjNi15ohd8otQqwEFAllvKv03dUNzVBO/uaYQGFct9DQ/TLweIIz1W05PNP8S6SibYqDT9DtP2bLjSApc4qKvYOAavEMTLalBpoewMU0eD5Qc5bVuRvl/3iwC2XdhzOzzg0giasmbEf+ctNOyoIQlj9hK14d4Z/Satkl8nqi5jFab434biVhbsap0n3CA6HeDgDNaUCY/jpDbmLW1v+atCBLmsVaKp8g+9A0McUeQrNJPAKjEcCsTTpIvXRuGKHaLm1ldw5iuNuUFTnqsUU/XLFb0oxLNtlqIrEwT5O+U8w3+22E1Ha0958Rigg09xSSWaWT3cMI0JVneGxnHa13Ivlhn1v7O6US7h5rF7QaSmwIGeDOznvJmk12bi5sBcqgUHtVJObwXu2U7CUEx2JLwu4Ueokl+1Teqlz7DfUJQUeX1ABbhfw8Bunhg8WH0X9bJjCPTiSQdmVralSZeXYvG/9kZ6GOloGVMvdgqeM21Stx4+3NKt9HhE6o3wund34x7zTyqREdQvYSrEO9PWGF+ykH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(186006)(1800799006)(54906003)(66556008)(33656002)(71200400001)(478600001)(6506007)(26005)(66946007)(6916009)(53546011)(64756008)(76116006)(66476007)(66446008)(9686003)(2906002)(4326008)(7696005)(316002)(8676002)(38100700002)(122000001)(5660300002)(52536014)(38070700005)(8936002)(86362001)(83380400001)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VodbVu9ccoZEz+ssqdtMy0bJ0sMwWjAebOYsHjElf3tYP6DcMy2nacyspBVm?=
 =?us-ascii?Q?4hK52cH86+o2OB0e1Yvsyfa+0FRp2RjjyO5pmqXQZzgkBaNIyn9p9aC0jVRf?=
 =?us-ascii?Q?I9PDL8oT4hKlXtvfowR36NmwATs7lmvIPji9gnhQGY0N/Ei6xTGHZHvKL/IT?=
 =?us-ascii?Q?f1WU4QMWDl5MKoXKu7Wjbb/B5pzS+jOu6zWUGmzwzBMPIjsCXAKexy4PFeuH?=
 =?us-ascii?Q?UdzUM1xApkxBGQzQf0YnfQ0a0wV/1MyI8URXoghFI2Jp3DxYwiCC/eE3P2qU?=
 =?us-ascii?Q?LxMAoowsi3nh1G7vFL6hrbNsraHZJZuEs+GWB40Wqear+5bRIQ/UTGXLWOYg?=
 =?us-ascii?Q?HU/w7ZhV4xVY/RQAvAyRflJBGSmz0Q2PKEDEYPxlfjo2EdG8bGwDYDcHgFDZ?=
 =?us-ascii?Q?/tfRbK7h1m4JvOUcRHgBULAP/OUJtow2UEyTIKSM9tIl3qp9Lx3D9KFomTpc?=
 =?us-ascii?Q?d4Kfq1rZZ0hKbxpbmulShzsTbgLXfT4DC6dJuVI67xWs/+hUHu3nzeGZQGz+?=
 =?us-ascii?Q?p47TjySHn8mg1e7utvdbVxggiAis+rx6r1HmmEYefjgpHdC/SH/akviOzy+n?=
 =?us-ascii?Q?1Khgba43Gci7QS9cHHX9268272uq9Bqete9LzQhcE3lr4QbsfiVrV35e9xkL?=
 =?us-ascii?Q?hB62EiLJFD+KIKpocsanyAP/Ko7jLEqSMPXKcGQbyjJljt0vgpLUQCGB5ZLG?=
 =?us-ascii?Q?K4GtVntR0Avr1cbJlPgPMAsMNlVjEhM7Uvi3UjQ10JfCTqLEWS/L7G/Wv1Ee?=
 =?us-ascii?Q?lUVq3CZ/cqMBKSgxudLg1b6aTGKuCCkPo2gBrsI314nY55y4tjYGGmP8pTFE?=
 =?us-ascii?Q?AupbsutrCaF4ePMdBzOebBIe5TEzo0rCm1QhXtbpMb0ILXV3Fou5g72So4il?=
 =?us-ascii?Q?OIR3NAGIaUcZ4fYG1Fqeh/meGTUZgeJd6t4/x0xu1qjaKFqv8COarraIbDxw?=
 =?us-ascii?Q?0vTtpXsepR6xN2WcIJvyZ4V/yR/N4OhG/k4xB26sIDDkdjwpsyc50FKI63v/?=
 =?us-ascii?Q?5xeZE28GtvPVsvjXfNlVRBl0VVexnUwvov9l2LgRT5isHcasr/XCcmlCgKAw?=
 =?us-ascii?Q?3rZiBknSAkyUev1QfYTkhoSq3euuCVGGJDUubOc9Onq0oygibKf2mJXCHJpj?=
 =?us-ascii?Q?cRlLAHb9G4hNAOthDfRYpmEhVJaH9Lnh7NaY6reU3FFC+/hja8n0woqYIHDH?=
 =?us-ascii?Q?MokojHsw8I60GXkByBgJuJYhCeJX2F4/1XJZ8wBxXq5MAvtpyXA5W9hbotPU?=
 =?us-ascii?Q?CXR1Q4VIITD9KtyMSYDEXX4Ur4KUlJeEzwsyGmkGZ+ZsNI7L729kTE2ApkhC?=
 =?us-ascii?Q?jeZv1iuQbNVL2Q/9P4VZNybtFSQhtVMfmMiQOsoFrlfcDueyt/fMtU5COY+W?=
 =?us-ascii?Q?3JI7Xaqq5LXYg59HKuQome5LTUL8LhSltGqslh7aKvOqLqyz25pAW2Gk8woX?=
 =?us-ascii?Q?/MLMHx6S/C6/0m9iWGUpOwexgAWTN7h5Az3zRYXeP76p9qmgIRofeNUsGD75?=
 =?us-ascii?Q?GzFf4b3aM/Zs3WE66k7X7aCiDhEXaSIhSzwALvKhcNypSsW8WRFE3unNd4oD?=
 =?us-ascii?Q?EBPd+QRatMlTdi+tPaw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4af62f-f32d-4e51-c798-08db9a28d082
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 05:07:09.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KKazsBvLvD5PjjTAWWC9YC/v7bCTJXi8NJBYljL0yFFoWKX9ii77yW+B3kyFWYGmQvuBwLPSdeIIiwV9AcY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, August 11, 2023 2:47 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-kernel@vger.kernel.org; bhelgaas@google.com;
> krzysztof.kozlowski@linaro.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; conor+dt@kernel.org; lpieralisi@kernel.org;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3 2/2] PCI: xilinx-nwl: Increase ECAM size to
> accommodate 256 buses
>=20
> On Thu, Aug 10, 2023 at 05:50:02PM +0530, Thippeswamy Havalige wrote:
> > Our controller is expecting ECAM size to be programmed by software. By
> > programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to
> > 16MB ECAM region which is used to detect 16 buses, so by updating
> > "NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to
> > 256MB ECAM region to detect 256 buses.
>=20
> What happens when your DT has the smaller size and the kernel configures
> the larger size? Seems like you could have an ABI issue.
- Here we are enabling hardware to support maximum buses. In this case kern=
el can enumerate up to device tree exposed ECAM size.=20
We will not face any issue.
> >
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > ---
> > changes in v3:
> > - Remove unnecessary period at end of subject line.
> > changes in v2:
> > - Update this changes in a seperate patch.
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index d8a3a08be1d5..b51501921d3b 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -126,7 +126,7 @@
> >  #define E_ECAM_CR_ENABLE		BIT(0)
> >  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
> >  #define E_ECAM_SIZE_SHIFT		16
> > -#define NWL_ECAM_VALUE_DEFAULT		12
> > +#define NWL_ECAM_VALUE_DEFAULT		16
 - Agreed, ll fix it in next patch.
> Not really a meaningful name. It doesn't explain what '16' means.
>=20
> >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> >  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> > @@ -165,7 +165,6 @@ struct nwl_pcie {
> >  	u32 ecam_size;
> >  	int irq_intx;
> >  	int irq_misc;
> > -	u32 ecam_value;
> >  	struct nwl_msi msi;
> >  	struct irq_domain *legacy_irq_domain;
> >  	struct clk *clk;
> > @@ -674,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pc=
ie)
> >  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
> >
> >  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> > -			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> > +			  (NWL_ECAM_VALUE_DEFAULT <<
> E_ECAM_SIZE_SHIFT),
> >  			  E_ECAM_CONTROL);
> >
> >  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
> > @@ -782,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device
> *pdev)
> >  	pcie =3D pci_host_bridge_priv(bridge);
> >
> >  	pcie->dev =3D dev;
> > -	pcie->ecam_value =3D NWL_ECAM_VALUE_DEFAULT;
> >
> >  	err =3D nwl_pcie_parse_dt(pcie, pdev);
> >  	if (err) {
> > --
> > 2.17.1
> >
