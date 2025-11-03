Return-Path: <linux-pci+bounces-40090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAFC2AAC9
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CED1892D8C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51EA2DCC03;
	Mon,  3 Nov 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ii2ujkNT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E4230D14;
	Mon,  3 Nov 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160562; cv=none; b=jnEL9/nL8yffjTEfl/o+/vdC4qIGhpw8MAh2hFmiKWUWI+euLPZ+k7xFmx++exfRA5N6ngPgpEz1LAC+GO6FQLjOrSjUxSmTWLp+Jkj5eXngIxFjV/ZGuYbqs7qmRcaN7K27kE0R0awcD430scVf8uMPYDFaGQ9HijAWO3CTbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160562; c=relaxed/simple;
	bh=+lVqh0EqEGBAN2HBGhu/dy5nfBGrzUuJUyxQhs2ZQtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldYAarm8qF/7kK//iBzDWoh+fc7oz9wK4MX0vyEuEIfE/+oS3YIxYpFoD+CPMGKpca83ByakNwdiMVJ1BR/GXuGQscGKxZ8cTyhLYxl9xwM/VtYvG6YM9/CodZUmguTN/DfBTavG1Fr+4iIU+VQ6o6vrPxntnZE7OQkQ+t8u7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ii2ujkNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588EBC4CEE7;
	Mon,  3 Nov 2025 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762160562;
	bh=+lVqh0EqEGBAN2HBGhu/dy5nfBGrzUuJUyxQhs2ZQtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ii2ujkNTRKTBWlKUJOt2wSdWPa0b37g8zuxVCTwg97ZDKz4Hwk2n1NMgQThMOn++F
	 lIxZ3y21EXZq+Jzj0qwS38HpaJzAYa0N7mBOeV9wAfY+OaZslSNewBsMJX9Vo/TKom
	 3IBTObS7gNLboum8ADakLjIZBRBN90N33Ic3tri4lzBJeqVJm0Or4M8LrTCtHejORv
	 p8W5tIZoHFet7NynGi8L5Eqg5RI7iv661rq70fBl/5fLZCFjM0NnUf16cWqjRWUEvY
	 AlRbAGUy9FMdfj8pbV0+BB6IdB9VyGz5cU2E4YrDWAaERPEtN/I5FMFbXw1s32QQDK
	 YXLDzG/ZlVBFw==
Date: Mon, 3 Nov 2025 14:32:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, 
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	inochiama@gmail.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: EIC7700: Add Eswin PCIe host
 controller
Message-ID: <urkbwcgmi4n7owlf4pu7hy5aeg4h7pgsecmie7tpfjhl3v64oh@zuuhr3b4wytz>
References: <20251030082900.1304-1-zhangsenchuan@eswincomputing.com>
 <20251030083057.1324-1-zhangsenchuan@eswincomputing.com>
 <20251103-gentle-precise-bloodhound-ef7136@kuoka>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103-gentle-precise-bloodhound-ef7136@kuoka>

On Mon, Nov 03, 2025 at 09:48:02AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Oct 30, 2025 at 04:30:57PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > 
> > Add Device Tree binding documentation for the Eswin EIC7700 PCIe
> > controller module, the PCIe controller enables the core to correctly
> > initialize and manage the PCIe bus and connected devices.
> > 
> > Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> > Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> > Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > ---
> >  .../bindings/pci/eswin,eic7700-pcie.yaml      | 166 ++++++++++++++++++
> >  .../bindings/pci/snps,dw-pcie-common.yaml     |   2 +-
> >  2 files changed, 167 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> > new file mode 100644
> > index 000000000000..e6c05e3a093a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> > @@ -0,0 +1,166 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/eswin,eic7700-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Eswin EIC7700 PCIe host controller
> > +
> > +maintainers:
> > +  - Yu Ning <ningyu@eswincomputing.com>
> > +  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > +  - Yanghui Ou <ouyanghui@eswincomputing.com>
> > +
> > +description:
> > +  The PCIe controller on EIC7700 SoC.
> > +
> > +properties:
> > +  compatible:
> > +    const: eswin,eic7700-pcie
> > +
> > +  reg:
> > +    maxItems: 3
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: config
> > +      - const: mgmt
> 
> That's deprecated. Read its description. That's just elbi.
> 
> > +
> > +  ranges:
> > +    maxItems: 3
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msi
> > +      - const: inta
> > +      - const: intb
> > +      - const: intc
> > +      - const: intd
> 
> Thse are legacy signals. Why are you using legacy?
> 

Why not? These INTx signals are still supported by many host platforms/devices.
These are not individual out-of-band signals, but just in-band messages. It is
perfectly fine for a host controller to support them.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

