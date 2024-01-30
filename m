Return-Path: <linux-pci+bounces-2808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E78427D5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475801F23381
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA66D1D1;
	Tue, 30 Jan 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeZ3AuoP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22385C7C;
	Tue, 30 Jan 2024 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627977; cv=none; b=IOXni3TUs+m9ogns8TTjkrG4SqRMNnFPTvZLceGc0zqU0TGGMsWWmr8swyeJTOoZ7quwAxl8fdHzCgrvxjZbU7i8TCNOIQr+vKMVPwNGm+e1sEwmozZw71TYTeZCLVCPCA0/lJbTUiR18bnH0P4lqb0zGvp8w9u6ryD6hwRo4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627977; c=relaxed/simple;
	bh=jPo6hyN6XhHYnljaQLnlP7oqLr70pQ2Jj+eWhTrA6zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDtqpuJQPqSTvFy6L1vStBC4uw9nUswDYWY7vAb9j3jviDRmcyo7KnLXwWmF578VtFArLAHePqMjssip7XwuZIcGVCYKlqsjjJQ7mg5WOi6C5NbyNfnFEySKfZzWQMqBi7VFmECcCOV1LIWpCjv4FVUSPeiIcIV1FsLQ/c1VSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeZ3AuoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB1DC43394;
	Tue, 30 Jan 2024 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627977;
	bh=jPo6hyN6XhHYnljaQLnlP7oqLr70pQ2Jj+eWhTrA6zQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeZ3AuoP0++uHYH1IylQRWG0HSkcfz9zMErCpgNZlOw4JrqPoo5ukCXKC6EVkt9sD
	 mTOsAqV1Qw1O3SMuQ9XrhG3wcxZ/iveBhDP5yPxjpF/81swPJNmreEdf0PCs5aUXmI
	 YsidSpMeGXcke4YqPG48aZUMBeNkMSzhpv75A+YEEJT5poAAadKksYTXYYs2f6RvPN
	 /E8enk2yfdRMzYyJST+ZF/pyXLbk7aLitBchMgJBv6TvUJPQG8mBEmwAFJd/6GCrDC
	 F9qSBo2zFv+4Vn6PC1v7I90dpHyVlrXvG+IC4WVGstJ2AT18dFe2QNBy2AVV4BRcLQ
	 a5Dg4ETfrzHJQ==
Date: Tue, 30 Jan 2024 09:19:34 -0600
From: Rob Herring <robh@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-pci@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Mason Huo <mason.huo@starfivetech.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v14,RESEND 19/22] dt-bindings: PCI: Add StarFive JH7110
 PCIe controller
Message-ID: <20240130151934.GA1636501-robh@kernel.org>
References: <20240129010142.3732-1-minda.chen@starfivetech.com>
 <20240129010142.3732-4-minda.chen@starfivetech.com>
 <170656679886.3057.12378312489853176077.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <170656679886.3057.12378312489853176077.robh@kernel.org>

On Mon, Jan 29, 2024 at 04:21:12PM -0600, Rob Herring wrote:
>=20
> On Mon, 29 Jan 2024 09:01:39 +0800, Minda Chen wrote:
> > Add StarFive JH7110 SoC PCIe controller dt-bindings. JH7110 using PLDA
> > XpressRICH PCIe host controller IP.
> >=20
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/pci/starfive,jh7110-pcie.yaml    | 120 ++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh71=
10-pcie.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/starfive,jh7110-pcie.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/pc=
i/plda,xpressrich3-axi-common.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/starfive,jh7110-pcie.example.dtb: pcie@940000000: False schema does not =
allow {'compatible': ['starfive,jh7110-pcie'], 'reg': [[9, 1073741824, 0, 2=
68435456], [0, 721420288, 0, 16777216]], 'reg-names': ['cfg', 'apb'], '#add=
ress-cells': [[3]], '#size-cells': [[2]], '#interrupt-cells': [[1]], 'devic=
e_type': ['pci'], 'ranges': [[2181038080, 0, 805306368, 0, 805306368, 0, 13=
4217728], [3271557120, 9, 0, 9, 0, 0, 1073741824]], 'starfive,stg-syscon': =
[[4294967295]], 'bus-range': [[0, 255]], 'interrupts': [[56]], 'interrupt-m=
ap-mask': [[0, 0, 0, 7]], 'interrupt-map': [[0, 0, 0, 1, 2, 1], [0, 0, 0, 2=
, 2, 2], [0, 0, 0, 3, 2, 3], [0, 0, 0, 4, 2, 4]], 'msi-controller': True, '=
clocks': [[4294967295, 86], [4294967295, 10], [4294967295, 8], [4294967295,=
 9]], 'clock-names': ['noc', 'tl', 'axi_mst0', 'apb'], 'resets': [[42949672=
95, 11], [4294967295, 12], [4294967295, 13], [4294967295, 14], [4294967295,=
 15], [4294967295, 16]], 'perst-gpios': [[4294967295, 26, 1]], 'phys': [[42=
94967295]], 'interrupt-controller': {'#address-cells': [[0]], '#interrupt-c=
ells': [[1]], 'interrupt-controller': True, 'phandle': [[2]]}, '$nodename':=
 ['pcie@940000000']}
> 	from schema $id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.=
yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/starfive,jh7110-pcie.example.dtb: pcie@940000000: Unevaluated properties=
 are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus=
-range', 'device_type', 'interrupt-controller', 'interrupt-map', 'interrupt=
-map-mask', 'interrupts', 'msi-controller', 'ranges', 'reg', 'reg-names' we=
re unexpected)
> 	from schema $id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.=
yaml#

These are probably due to only patches 16-22 showing up in lore.

Rob

