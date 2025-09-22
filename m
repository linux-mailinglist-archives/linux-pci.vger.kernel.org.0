Return-Path: <linux-pci+bounces-36655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89355B906F7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E18D3ADDD5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481952EC54B;
	Mon, 22 Sep 2025 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ7BKWwU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCB3305946
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541010; cv=none; b=ZBHX0p0zM1wHs6ULd1kjdQF/YIrrZMUF7xVbux2RE5ZTPpnaEsQe9W20uTCPrJVrJVmMHWjt/DaJxr4HQM+55SC0we/Y54XG61RcnXQfYjL3lRm3rb6N4Vuaalv9O7Cz4TFnm7LECpBOdnCIFIVMugK0Lfx9m26Opxw4dAJDlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541010; c=relaxed/simple;
	bh=4RDEXWIJRxsJNLyBGMGssIQ4Y0yIdH9PwLW2hS74sLI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTxt/jUQ+VVZ3UlSzhup7/AGzM+G0hBoDF33dR4jRVhYthVHgKFouthkLBaDm/mZ7Hu+2fPLUioAfGvEU4lqISlJRbGIOTDA5Vs3SouEciyLmieaPjNX4K8xE0v/XF5x7iw8c1HVqCdXKU1i8V72wPpjea9YjZvDxgV57aI1fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ7BKWwU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45f31adf368so30157635e9.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758541007; x=1759145807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oAYqFXyWYf/ovOGnjUFnZWmVgk9QvSIoobQEOgia090=;
        b=EQ7BKWwU7ecPdlbRnwpEp2DWp8/5QWRG3GSy6IL54BN0oERYJugQ/d+lVXNAEwYeTk
         mC45aahKZhGWb2QYUxsW6Xxf19dSM0RQF06Odi6J1mQBfhfwKxloEZRJMZmZTLrzk7DW
         YfSoTvcpO+cjt00z1ZxMxvAh1WdC2HWhZQxm/8A9Q5cDSzezGLs1d04J9xvPQg0weN2q
         RADg8TXDvOM/L3qiI9Pgfzj1Jtn7V4zyeLD1guRGvvCWv2Q19kkc0n/yZ2kCqdc+2sDI
         19sPEKHtXLlXFkIXapGiewdkhwFi8URX1ayK5rmz2fIN/QbDIqMn9PaBSrnilaHGePf1
         11EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541007; x=1759145807;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAYqFXyWYf/ovOGnjUFnZWmVgk9QvSIoobQEOgia090=;
        b=X79voun47931O50nxOiU0L0KXfiTdHMgL6uKCcpPpwXdWhjXwR6d/1X0AuvtTgu4fl
         2h9SkllUdQ9yxMH29eUJ0mD4jWDI0JBENQH0IkGPUFeQ3V4+xiOyBGydbg9aAmueJtR1
         IfCBdbbJJbuMNzfMz/PV0SKAaO+1gAol5zWo0R3uU/Dwhtj3136jpzjXK3pa6E2m3szh
         Aufdn0+RQunccKcKmJnRC/s67KMLY2RKnuRrnhNjc7s2pVIa1HFyCeo5S9pnEuAShdWC
         +B902+x6vtyed1Z6QCqw8gBqLA/qonD+k6rVBfR6Lm9N6pj+yTI2aSNHpYkIF582wnKt
         VZAA==
X-Forwarded-Encrypted: i=1; AJvYcCVQfvtXL3va2HeKt2DphuV6TmlqdC90n0PbK38UCJpm/CCXmvO9fgv5QVgbmZmnKEUGjjeUCbvsUZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhPTJPQX900VREw0rIILtHirwVPdXuBSQtsi6VQlKunj7uLTB
	7UHjskNqa+P7zJp605NJoieDPQ9r+IFle14GFJUwAGE3DHGWiBGaNy1R
X-Gm-Gg: ASbGncu3rhg21z3ul5EUrbIioSaXIa4saLAP+O48ASrqxcBMLLQqyOEMAcSY/iqTekV
	2J4Gb/nbSPBY6PXB+7Zs022opIra8SEoL91EkXJ4/qQ973QGqOM/NSmVg7kdrP0SL0Wn5Ls5gZc
	nRcBPICL6fjtx2zsQh6ZIgNe4/5x5hsZhUy5vilkmzoT5gDF2bdhJxENfhh2g2rh2SGAmSqeC+B
	HGytcW2nYHHHY84MVt/CSN1frhJltpBgdmF+0FeQ+U/OkF2JkP2t11QrzbACm41T1H+wR2hYao8
	XJO/kI2I7d+irN/j/PBoyRWYrdum9kJlxfgdzLpueHN7m2O1CX1bNKNVJiiP4eh+H+sX2Ziw1KQ
	FsKiBVG0ScR7rEOrA8ChCd78dZP9T/K4mYdWNo11LMdKq6bULuyg2jmF5qUSlShcDVbCWyQ==
X-Google-Smtp-Source: AGHT+IFxQTXNVAZvfC1AemnurHgjd7bW6AIxc0GLyxTk076fV2qzgcWwb7RLdq+XPS4PWKkuqKxXTg==
X-Received: by 2002:a05:600c:a48:b0:45d:d19c:32fc with SMTP id 5b1f17b1804b1-467e78caa13mr132278155e9.10.1758541006439;
        Mon, 22 Sep 2025 04:36:46 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f326133a8sm132690315e9.6.2025.09.22.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 04:36:45 -0700 (PDT)
Message-ID: <68d134ce.050a0220.375eef.da87@mx.google.com>
X-Google-Original-Message-ID: <aNE0yMvIzvPc3W_O@Ansuel-XPS.>
Date: Mon, 22 Sep 2025 13:36:40 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 Airoha AN7583
References: <20250920092612.21464-1-ansuelsmth@gmail.com>
 <40efb310-e63b-47ea-b62b-cc3d614c47b4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40efb310-e63b-47ea-b62b-cc3d614c47b4@collabora.com>

On Mon, Sep 22, 2025 at 01:34:06PM +0200, AngeloGioacchino Del Regno wrote:
> Il 20/09/25 11:25, Christian Marangi ha scritto:
> > Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
> > binding.
> > 
> > This differ from the Airoha EN7581 SoC by the fact that only one Gen3
> > PCIe controller is present on the SoC.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 0278845701ce..3f556d1327a6 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -59,6 +59,7 @@ properties:
> >         - const: mediatek,mt8192-pcie
> >         - const: mediatek,mt8196-pcie
> 
> "an" comes before "en", please move it here.
> 
> Also, for consistency with all of the other compatibles, this should be just
> "airoha,an7583-pcie": please rename it.
>

Thanks for the review. The "gen3" wasn't added randomly. On AN7583 they
put both gen2 and gen3 PCIe. One line is gen3, the other gen2. So either
we differenciate for gen2 or we add the gen3 tag.

I decided to add it here to follow the naming pattern with
mediatek-pcie-gen3.

If you have better idea on this, I'm all open.

> >         - const: airoha,en7581-pcie
> > +      - const: airoha,an7583-pcie-gen3
> 
> 
> 
> >     reg:
> >       maxItems: 1
> > @@ -298,6 +299,26 @@ allOf:
> >               - const: phy-lane1
> >               - const: phy-lane2
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: airoha,an7583-pcie-gen3
> 
> same for this if block, please put it before en7583.
> 
> Everything else looks good.
> 
> Cheers,
> Angelo
> 
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 1
> > +
> > +        clock-names:
> > +          items:
> > +            - const: sys-ck
> > +
> > +        resets:
> > +          minItems: 1
> > +
> > +        reset-names:
> > +          items:
> > +            - const: phy-lane0
> > +
> >   unevaluatedProperties: false
> >   examples:
> 
> 
> 

-- 
	Ansuel

