Return-Path: <linux-pci+bounces-13705-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D190698CB8B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 05:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39B81C21BCC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 03:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BF28E7;
	Wed,  2 Oct 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKkZLQ7c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A21DF60
	for <linux-pci@vger.kernel.org>; Wed,  2 Oct 2024 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840180; cv=none; b=h3nGP9FIAZzilXJ2x/4YVT53EVyhehUfUB64GQZUUrle0greJbis05/TXoLHCqBFvR2Z4WcNzLcbEQ4Lm+wtv3WailvhoCHOfHOI/+orfkgd0FIlw3MXDlv220ztVb+cn8y85xIW2FZpAI3N+TvphhJIHxnJilLlTLFYRgcxd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840180; c=relaxed/simple;
	bh=av2Zb5PMB6fQe4PCUNTCIeI91KPfoH514yjPHhk8h4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6NIclM1cVVptiGvUqb2okg1KFewaQG6rPrdpI1FWXKdyD/llJVwiW2DsGZuB2CEIM9RuX+sdckNiNundVt5MPMGlWfMDv1HNyJnk5FRWCohj6i0d5dq1j+PbRAJs8Tv3UzR9/kogS7xXjX/eTHBAPSJp5JiZGAWJXH8GwNGXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RKkZLQ7c; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5090da61040so1344874e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727840177; x=1728444977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwiLVnc0Ymap70LQ2v/RfJC1Ad9ePUxHXG7oryVkvlE=;
        b=RKkZLQ7c18WMURCu2/LVcMelmtmcdjkCiMAeG6KJyPlv92Zsv/Vm4KDZM85T+rzXzO
         qnzSatjUgb8/C9G1iTfD3ZGjoqipS1tLk+cnQKxS7R5hrdvutx2dIf6IOiMC20aSX0/q
         zRSL+ErCnaWxDi9ogNBJleJ7GdTKIsCfs2Pkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840177; x=1728444977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwiLVnc0Ymap70LQ2v/RfJC1Ad9ePUxHXG7oryVkvlE=;
        b=hJCQxUbBTpLGc+Z+XOpntumA2qoiXpiqGQDn6e6eeY0jxIu1R2vZEdQTA/+SB1sxwM
         pEsZ4dFk7Rn7SJcclXyeEV0e9Jqmrvk5PgTFlu93vey0nt9tHtKXuuGAOCWTAn4xmB6i
         n6QCfR2TuIoOfNHZvU1wwz+oUW6U7CBSBO1wJrCqUmmAqZnSPSfN1ECe/a6SDMIbVEtb
         RTjeAqqJts30Up18zJRNIXCgn/O/3ldV+BdtUIUWDfbcXKH0qEFerzhJkBA2en47Vpxy
         OL1lDY63Menxs4vbrLtMyYCmMWKWNBxjwKZrTa2kNv9gwR/41sGISyVWQcmpgSzr/NKr
         joXg==
X-Forwarded-Encrypted: i=1; AJvYcCVMuMTUGavnJ5z21JkZDryNhbDEVh7NqVWBknhumgnJNvKd0ISthYb0GSeApakhJ1ijTWN4uWk/5NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6qn5wsFTFqwxECJvgUCIuC0M0D5A7cgQBCTJ9SsiQ6bK3nVP
	KXxKUuX/vGQHuc/aI31DMWEvTuuknGJvnqBr4SzyovmdoCCcNcoYsa6EIPG+Q52ZKZ0aPNTUFw1
	MsA==
X-Google-Smtp-Source: AGHT+IH0O6kfO6VgsGxpP4WYeLdpz1jD7K6py8odLL3zc0Mav5QNFB28RMYaIQ0sowANztdQbI4rxQ==
X-Received: by 2002:a05:6122:4589:b0:50c:4bcf:2727 with SMTP id 71dfb90a1353d-50c57d74de8mr2195125e0c.0.1727840177197;
        Tue, 01 Oct 2024 20:36:17 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50ac01cb31fsm604107e0c.14.2024.10.01.20.36.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 20:36:16 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84f1ac129c7so263547241.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Oct 2024 20:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7whf4bhb9dIQ+Z/Hn+jpxB75Rs+TeamZc61addyXLilTtGRsMPin6sLJCmFTrCcP25yR8rS1R93I=@vger.kernel.org
X-Received: by 2002:a05:6102:32cc:b0:49b:e3fd:b6d0 with SMTP id
 ada2fe7eead31-4a3e68264a4mr2070117137.5.1727840175839; Tue, 01 Oct 2024
 20:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925110044.3678055-3-fshao@chromium.org> <20241001195325.GA222000@bhelgaas>
In-Reply-To: <20241001195325.GA222000@bhelgaas>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 2 Oct 2024 11:35:38 +0800
X-Gmail-Original-Message-ID: <CAC=S1niCc5usY4SJ7wqtKAfcUqyTBf3fhRmkk4Sdnr3x2zsuVA@mail.gmail.com>
Message-ID: <CAC=S1niCc5usY4SJ7wqtKAfcUqyTBf3fhRmkk4Sdnr3x2zsuVA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: PCI: mediatek-gen3: Allow exact number
 of clocks only
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:53=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Wed, Sep 25, 2024 at 06:57:46PM +0800, Fei Shao wrote:
> > In MediaTek PCIe gen3 bindings, "clocks" accepts a range of 1-6 clocks
> > across all SoCs. But in practice, each SoC requires a particular number
> > of clocks as defined in "clock-names", and the length of "clocks" and
> > "clock-names" can be inconsistent with current bindings.
> >
> > For example:
> > - MT8188, MT8192 and MT8195 all require 6 clocks, while the bindings
> >   accept 4-6 clocks.
> > - MT7986 requires 4 clocks, while the bindings accept 4-6 clocks.
> >
> > Update minItems and maxItems properties for individual SoCs as needed t=
o
> > only accept the correct number of clocks.
> >
> > Fixes: c6abd0eadec6 ("dt-bindings: PCI: mediatek-gen3: Add support for =
Airoha EN7581")
> > Signed-off-by: Fei Shao <fshao@chromium.org>
>
> It looks like most changes to this file have been merged via the PCI
> tree.  I don't see dependencies on this in the rest of the series, so
> I'm happy to take this via PCI if it makes sense.  Or if you prefer
> that this be merged with the rest of the series, that's fine and you
> can add my:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Let me know if I should pick this one up.
>

Yes please, thank you!

Regards,
Fei



> > ---
> >
> >  .../devicetree/bindings/pci/mediatek-pcie-gen3.yaml          | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.y=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 898c1be2d6a4..f05aab2b1add 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -149,7 +149,7 @@ allOf:
> >      then:
> >        properties:
> >          clocks:
> > -          minItems: 4
> > +          minItems: 6
> >
> >          clock-names:
> >            items:
> > @@ -178,7 +178,7 @@ allOf:
> >      then:
> >        properties:
> >          clocks:
> > -          minItems: 4
> > +          minItems: 6
> >
> >          clock-names:
> >            items:
> > @@ -207,6 +207,7 @@ allOf:
> >        properties:
> >          clocks:
> >            minItems: 4
> > +          maxItems: 4
> >
> >          clock-names:
> >            items:
> > --
> > 2.46.0.792.g87dc391469-goog
> >

