Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7633ACDD2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 16:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhFROs5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 10:48:57 -0400
Received: from mail-bn8nam11on2076.outbound.protection.outlook.com ([40.107.236.76]:44896
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234671AbhFROsw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 10:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY86Luqst1uq/OAu6N0r+SqgdjdRYK90wHmycJeqrBQOb6s8QKZkOM4azeodtUEz+90T0eHaNEWPFDwyaJjrXlKxGRUKItpiKHWif9WuW50+DjZmAEt8lyrZSKzuqOl+HpqTNTrX6uStjkEIIX4GAUWMVdaOoKCuJyQePSKQ3jDan3POrWffzrDpAxtvRpuCH5sPxogsH89MSiLW6SIkQvPtLoudYHGILNUjsr9pCg8WyJJmE/3Aoo4CHO8hbJTvxyxWErCFa2dJ7e9BCjjtN8nyFYNMUrCXXsi/6sIF0igSP4QBY0v0xwRFnetb4J68qSPi2ETZxnI/4sXx9hPF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zROoHAjpFnrm+yoHi9PFgbBemRym0th1xoYVetRG0s=;
 b=Vdfpgmdh+kCrOl8QCZfWretBssaxT3WN8E/Q0DrmJeU544pQCK/xjSScMJKTIYhWwJi4nF0zbAm06dsa4Yed0aSQli4uaCUYZ+fvyTLvYJphFRo/R3mAdXbeTwCPtRZ/Pz5gojjA+UB1NfLrwtp9RhkOUJ8nIPu1AXG+gwkyaCeqipgB0Z1xzwfFsmXXjRdiuM0LNb/7f1buDfmpj3Tj+W8rOQ4uPXADgzZN3I9RlunA1kaDedp/Sa+y3Fx4vmv0hyPPPcYqyHdZYdr+N17qhdHL4T3Uf5ywexwGgyykdXU0xSoumwQsPlMeJMqfjTAfzVolUB8v6T/nYyNhG2DdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zROoHAjpFnrm+yoHi9PFgbBemRym0th1xoYVetRG0s=;
 b=gdJAcjrO/0WUhqvmNUi1A+P7kIIpRmrNeVahJcwecvEcRvD1gIfaw/Pvk+MzutwdbJX35eMppcNqDtmrJg50cndL2VQSttQwRKOHSXsaOfzoZRNmZl2bU5yOk7aFD66N29WLjUK7zuzqUAqwlqxvKX3tSPPe8Hn/Lhyzp7Y4BlsBPOD2MSvH+6OhQ53mSJa7GMG3YtVs2oKWdWxjEM1SXDBHiINo7kWE3F+94csbDYo26JSUF6GHjU/y7KH6RBVp8qEqnn6lBqYadET886FMNQEhpbouBPP19ygq5TaP3f9Jq7IBwygg2cRy8kd4O4DlEbdUOanOiEy19ttiF7UEeg==
Received: from MWHPR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:301:4a::14) by SA0PR12MB4397.namprd12.prod.outlook.com
 (2603:10b6:806:93::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Fri, 18 Jun
 2021 14:46:41 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::ee) by MWHPR1201CA0004.outlook.office365.com
 (2603:10b6:301:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Fri, 18 Jun 2021 14:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 14:46:40 +0000
Received: from localhost (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 14:46:40 +0000
Date:   Fri, 18 Jun 2021 16:48:29 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>, <linux-pci@vger.kernel.org>
Subject: Re: [pci:for-linus] BUILD SUCCESS WITH WARNING
 15ac366c3d20ce1e08173f1de393a8ce95a1facf
Message-ID: <YMyyPZSPMamYtgO6@orome.fritz.box>
References: <20210618131304.GA3182065@bjorn-Precision-5520>
 <1991f432-3c32-32da-997d-e1dec12df0c5@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34RWHYItB/hd2wtN"
Content-Disposition: inline
In-Reply-To: <1991f432-3c32-32da-997d-e1dec12df0c5@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55beefdb-15a3-4617-bf90-08d93267e252
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:
X-Microsoft-Antispam-PRVS: <SA0PR12MB439726A1F9CCCEE2962DD7A1CF0D9@SA0PR12MB4397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBhMROiryBXN0kMyJ6C01I78M2J2ChpCzGCBSWMJsFxmBP+tGXynQcXCItQeHfCJCTF32nR7cfIA7SVjoEuWKmTzMYlsRYpOAl++rDcpGWnZKg+q2+3J6zQ94+GTLJQhs8G+NwQC7FqU/2F6aIJfZlmlQweNxsXdLGLH/UfYIj0jcav3LvOhsEmM3L8S+Ax72S2y53nSJ9VAMeZ9TIUWuJ5x6ava9ycGoGDxq4gBLeHGilyWixDkKw1GtrcSMPIhLIZyLjKnKXGoyt3CoHcA5dfF4r2JsOUhb1kOcwa50/swAwLYkFmklr+TpY1bwcGtVEgdpsdhCyWQUel7k8ZtEnVzbz9IfVbXfIwNeRY7+Jzp4YOqQELf2d9PrddiTWGT2HrqBAr/PfkXiDUkzgD92naz7aHYDRDxWuwc2pezFJw0f4bym09XH1vsNM3HX7CRYK+z4Fwc4GE/wUsa2RtXzmjCWLeXaErFRKp/P7HLtt0RuT879agKVRBEU5ovJsX93WAa2qcsdT7nLHlJ6jZqB/Iwu+tiqZhzqDbutoVwUvG95NVbyqGj+l98mb1rFQiyNwal8iSL/C9WHvM3D9fmglb05sFLOzfWTy7gffUGkztQeHbvKTk4AzUlHzlxkg+6v/5vtw2YUcTvvl6wPBCiRbpRmBD8jMwXg7tnmPx+w17IgqnDOiulALm2hW+kEnCe5lbCQPI0pTfeM1rTbrdTJ19wuPUhNLTqKBwPVqYl+dMQftBQ9uk/6RON2bXUeUQaeyv5Q/PzCfdC2Ns0I+CYSRFUzPjd8TBHDTyMImSsPCkr8IC+2B/MowC/KXkNjBzKYI9TZWUUKEXnM9lrDDV5PTWZUojcUW8A9lalse/kbmE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(26005)(21480400003)(36906005)(426003)(336012)(82740400003)(316002)(82310400003)(54906003)(2906002)(6636002)(16526019)(5660300002)(7636003)(9686003)(47076005)(70586007)(6666004)(86362001)(8676002)(53546011)(44144004)(356005)(478600001)(6862004)(4326008)(36860700001)(966005)(70206006)(186003)(83380400001)(8936002)(2700100001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 14:46:40.8540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55beefdb-15a3-4617-bf90-08d93267e252
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--34RWHYItB/hd2wtN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 03:03:24PM +0100, Jon Hunter wrote:
> Hi Bjorn,
>=20
> On 18/06/2021 14:13, Bjorn Helgaas wrote:
> > [+to Jon, +cc Thierry]
> >=20
> > On Fri, Jun 18, 2021 at 06:34:20PM +0800, kernel test robot wrote:
> >> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/p=
ci.git for-linus
> >> branch HEAD: 15ac366c3d20ce1e08173f1de393a8ce95a1facf  PCI: aardvark: =
Fix kernel panic during PIO transfer
> >>
> >> possible Warning in current branch:
> >>
> >> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: warning: Shifting =
signed 32-bit value by 31 bits is undefined behaviour. See condition at lin=
e 1826. [shiftTooManyBitsSigned]
> >=20
> > This looks like a legit warning, but I think the only commit that
> > could be related is this one:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commi=
t/?h=3Dfor-linus&id=3D99ab5996278379a02d5a84c4a7ac33a2ebfdb29e
> >=20
> > which doesn't touch that code.
> >=20
> > It does *move* some code, so maybe this was an existing warning that
> > moved enough that the robot thought it was new?
>=20
>=20
> I guessing that this is now happening because we are now compiling the
> bulk of the code in the driver. However, yes looks like it has been
> there for a while.=20
>=20
> I wonder if the '(1 << irq)' is being treated as a signed type.
>=20
> > How can we reproduce this to make sure we fix it?
>=20
> I was able to reproduce it by ...
>=20
> $ cppcheck --force --enable=3Dall drivers/pci/controller/dwc/pcie-tegra19=
4.c=20
> Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
>=20
> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability: Shifting=
 signed 32-bit value by 31 bits is implementation-defined behaviour. See co=
ndition at line 1826. [shiftTooManyBitsSigned]
>  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>                       ^
> drivers/pci/controller/dwc/pcie-tegra194.c:1826:19: note: Assuming that c=
ondition 'irq>31' is not redundant
>  if (unlikely(irq > 31))
>                   ^
> drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: note: Shift
>  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
>=20
>=20
> I was able to fix this by ...
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/con=
troller/dwc/pcie-tegra194.c
> index 8fc08336f76e..05d6a8da190b 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra=
_pcie_dw *pcie, u16 irq)
>         if (unlikely(irq > 31))
>                 return -EINVAL;
> =20
> -       appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
> +       appl_writel(pcie, (BIT(1) << irq), APPL_MSI_CTRL_1);
> =20
>         return 0;
>  }
>=20
> I can send this as a patch.

I think that's not the same anymore. The equivalent would rather be:

	appl_writel(pcie, (BIT(0) << irq), APPL_MSI_CTRL_1);

But I think this can be achieved more easily by doing this:

	appl_writel(pcie, 1UL << irq, APPL_MSI_CTRL_1);

Which is what BIT(0) would effectively end up doing. Actually, this
sounds like it should really have been this all along:

	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);

Which should also get rid of that warning.

Thierry

--34RWHYItB/hd2wtN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDMsjoACgkQ3SOs138+
s6E+GhAAtGOp2/lszj45XrM1iVgMaF9Cyd5TN8a0qpW461Rjnkq7P58gea1nybJW
NWek1+eQJ8RadHQZU/ooNEBRBsqGGZZZYIEBdc3E+gxCdr0VD5ry/sr2p+xyL5Mz
00VT058xItsfsej9kRtUUxpaOtTc0U3EjrbRez6PDrbNaL8onARxVub7nH2AGhz5
17SkCQ79TEaoPguJaju/dXHw/+VgFXDNlgJxSFt7pQdy+wA2Jbk4Q+WYTgCwSYgt
bix+DDnmlXNYdMRNYfLJXyMyWgAxg/LNMFJmsWAUTd+LalCr5vho2Dcvr0NpixsH
KR2sNhuMIp5hcQX6Bh3BQ2PgTTFZqQqdyhhWy4A+wK2du1E3EIMIfAjgvZRAbvty
X5sQm2/EgGYtqFHgQ5zqTB+QuaMRCSal5YFl1m5ZsCbwBOOxGHg4M7PLVxjSNx7M
IaGySrf7swNE2dGJxZLZPlY83BSHwSzeeaxhLLKnjMnHQyQP6o4bR6PBZE6r2eWo
Y33BpFGmJz5srdD67DkA31Cig75TixvUa9lUWWlXlnMwljRBFWQyK0UizeyEaLQL
VTAVjyyi31IQd5sUO+JDJ39iNhdzJE0Yy4ayKIg6oSdMmFlK7gbkI3CDc2YGHVT8
bXFOh0wYrHETifWGCPDVPtTULanr3BS4gihisT7iakYDEIzuee8=
=qIgN
-----END PGP SIGNATURE-----

--34RWHYItB/hd2wtN--
