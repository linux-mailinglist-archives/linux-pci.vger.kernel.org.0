Return-Path: <linux-pci+bounces-25896-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85EA890E9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 02:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A5A17CA05
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 00:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F966A8D2;
	Tue, 15 Apr 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+Wyy6N6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB51BC4E;
	Tue, 15 Apr 2025 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744678395; cv=none; b=AEIxvzZTA14E319U/6po69NzYfVRuFx6jFj5t+r4IGh0nYegwpLFGu3grBlQR3xUBc8YulaHpnMnpFacCnH4k5RsXMcrwS6qw0T7zinihBZQ13wZJz29rjS4Pc67v/qsaIpqfFiYBuYH4UVePG+uB8qX44kkk+xAx39NEvavJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744678395; c=relaxed/simple;
	bh=rpcRVsmZpP1OTfgBK0pVQa/BNowodj/ZTEugq8lgEHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQiDQ8HeOH+PBKj+6job69ofammYPLpGR0n0AXXIamB8lJ4wADwYHRwSRmcISyFbnwzHArHqdwWSy9zwPW8deYUi0gWOy9xTWOvJqZKQDmWJuQH724FCXnY8v6nAr5LTV8e6AWHQaOntk/8hOj7bifjUs0sKLM64qmXcZgIc/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+Wyy6N6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDBC4CEEA;
	Tue, 15 Apr 2025 00:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744678394;
	bh=rpcRVsmZpP1OTfgBK0pVQa/BNowodj/ZTEugq8lgEHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n+Wyy6N6IcDOdsdf//4vJ3ol8RWOp12oQ0G4XNvCV3m29Z1NziZjpmYtNGIf0DPvV
	 S0OTCHeej+biO7N7WtGMkqwWR58/fapqmPuTPH3N+ehV7JTlV3tZxh0IlvFHOmh4Ys
	 1CR+dmOOt9jK/0K4vHulpPH+cEkd0qIrAZAhidNS1UXV5gtX/RrBGLA939nw5GNs+z
	 HFQS1RNNM/nvucPHUThM2tBk8h427ROKjepMQLWMyJtSNHRIYpdGq9l+zEvzqWYTnX
	 Mu/sqH5SnOy0VhOcy40W57MktIAGWg+HnacS/hZE/4JbuVbt3r+c8p0yuQ1upyN0Eq
	 J9fk2szY0WcSw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so8779683a12.2;
        Mon, 14 Apr 2025 17:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEQBoOjy8SylhkDWdbD0ZEjyrtjsq6OFSrLSNXGTeMK4cpYCA9dOXRwAODuzNlLF2H2uBUZi8KCHVDfanB@vger.kernel.org, AJvYcCWsxlVzm93TLCJeyWcI7c601ZUBoliMKT4e5sqXDxLkO/t+dezhVOUoiDwKNLpfGBduJxJOW8UwqtKx@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEEfXmgxfNGXEjd50EKmDyFL0PvlVC2Rgvcveh4zTGLja6YHj
	OPxcZEmby02UJ1Ml4eDQk1nxSZCP1jTjvoDDbSuyKWse8da7jgO5UKgajxhPm0osLDj1Z3JxuPI
	mjZ5uMInQqNXHhQM6FEj5rNS25Q==
X-Google-Smtp-Source: AGHT+IHmZnqswUI6HY4X7lhwWG4IXdrIAQ98ELXwpAIik5dZKiLq3R4+YKd0t7tRwsYVN1y86TzHYWW3TmgHsiWOsdY=
X-Received: by 2002:a17:906:f585:b0:ac7:3912:5ea8 with SMTP id
 a640c23a62f3a-acad371af0amr1293247866b.61.1744678392821; Mon, 14 Apr 2025
 17:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414214135.1680076-1-robh@kernel.org> <174466977142.1877467.9140482106900041765.robh@kernel.org>
In-Reply-To: <174466977142.1877467.9140482106900041765.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 14 Apr 2025 19:53:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK40++GbHbsXc2M2Q=wDv86=41kQrp=VJ-1nfMQN6rXng@mail.gmail.com>
X-Gm-Features: ATxdqUGgBWF_RyIbWCm1WwHPzqKVexIxZ_OM52tDjGnbjYrGcxtLD8az7H9x9DA
Message-ID: <CAL_JsqK40++GbHbsXc2M2Q=wDv86=41kQrp=VJ-1nfMQN6rXng@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Convert marvell,armada8k-pcie to schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, 
	linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 5:29=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Mon, 14 Apr 2025 16:41:33 -0500, Rob Herring (Arm) wrote:
> > Convert the marvell,armada8k-pcie binding to DT schema. The binding
> > uses different names for reg, clocks, and phys which have to be added
> > to the common Synopsys DWC binding.
> >
> > The "marvell,reset-gpio" property was not documented. Mark it deprecate=
d
> > as the "reset-gpios" property can be used instead. The "msi-parent"
> > property was also not documented.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  .../bindings/pci/marvell,armada8k-pcie.yaml   | 100 ++++++++++++++++++
> >  .../devicetree/bindings/pci/pci-armada8k.txt  |  48 ---------
> >  .../bindings/pci/snps,dw-pcie-common.yaml     |   3 +-
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
> >  MAINTAINERS                                   |   2 +-
> >  5 files changed, 106 insertions(+), 51 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/marvell,armad=
a8k-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.=
txt
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/marvell,armada8k-pcie.example.dtb: pcie@f2600000 (marvell,armada8k-pcie)=
: interrupts: [[0], [32], [4]] is too long
>         from schema $id: http://devicetree.org/schemas/pci/marvell,armada=
8k-pcie.yaml#

This is a bug in dtschema which I've now fixed.

Rob

