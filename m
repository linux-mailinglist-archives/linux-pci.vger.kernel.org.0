Return-Path: <linux-pci+bounces-25125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FDBA788F7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED248188F8B7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D48230BC7;
	Wed,  2 Apr 2025 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ks9adzlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CC233153
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579759; cv=none; b=bA7qieLbU8Dg56uIfL53SvuAnMO7PIxHJyy+Qg821a9qRYSfLESPKr9D1ZhLu+fPtk/wye44MhHngRxwL7b6tseCWL1f6hDExd4PqbGkGk99HDYgFjeQFMofK8cwfoHlUNAO9T0KJrjpstcfkdq1GxVCMot6hT3MRJLaA0aJ5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579759; c=relaxed/simple;
	bh=TpRhkR2cFz32n8h3AkysvVUllLEQTqLqKNerftuUn9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq63WGEeOSnnO8COp5mR0MHhXaBcFC2Mb3U0x1SsBGjIGaXsYnIeQJQemQqIM/XKzYW0KRfLo7VC1Si6FqV6bVZ/7HzphtM/zhW7h92SlZwKUrsiJDO6/MLOYCqlCxmIMfK+Dc0HkQmsBc6gLVD77r8dLvBdzDX/l8yyF76IYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ks9adzlA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso8206178a91.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743579757; x=1744184557; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMgOlHQPYSJ8f1ofF0OIpUWs9t8sgZk8UpYIpDkgg7c=;
        b=Ks9adzlA4ECiWHnCJ2/PfDJeruhKlm7kRtPElAZyF8k8Ng3UEujokGqyqiWp0GxjoW
         v93HZFkI7lsY7GytGNqtiagQiHjLDZc4fqc6iIC4pBkMG8bYkRZW+IwxUf5zpSYaKOSU
         97D0d+g6axvpf2X9retsdRqJqLrJwToyiKNKPAdB7eJdqjRHncrQUFIZiOlIxIJOTzRw
         Jl/aj5w5cCvcp7IQKA/JzGPlwWr20paWUpq8Uj2QlvXQ21qbVyKsSfqfqdVI16g4/Isi
         RkiFfTHlHP8AWscsOmdq7Gtz7mNrl9r3EWaEbLAWfVhQHiEzikPW5ug8+BxQuV2xcca3
         qPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743579757; x=1744184557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMgOlHQPYSJ8f1ofF0OIpUWs9t8sgZk8UpYIpDkgg7c=;
        b=vArTr9okKzGmYYgeNt73BARxVX4750bK4gsz9i2FFWCucUjLFeNLYWij2aZhDhFT2B
         ZRfiEksyVzgYDQuN9qzTuo862fr8cDgGNY/tGgZNZneqYo0vEd/oCZtr+MJ7BYDbnL3T
         Mo6jDHxCsAQqciySegAF9YOEMoVQx3Mxwj+uLHUiy37ocjLJvf5RQF/DQfj75sR9F76o
         2M0okRxKu6SMcF0j9yI9Gc86+JlwypxIR+3087gOPAv6yLh9smvSy93khFkydpWPSxTG
         e6FeZXZ9/fIyV0n0ZBT2It67LwMymEFL1iYXGD7FjR+vBxGKRue6hEgXJUlm+gJ+rwl1
         kToA==
X-Forwarded-Encrypted: i=1; AJvYcCUcPDjEICE0PpRA8pcJoQ+anWnA97593QkP9aA+B0lbmdDNafpHTmN+3kQBuJCujdZXSt3ChMxsXoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzteVWRVeDZwMbUKtghKQc/aGLmjhKECBV1HLl84WDxDSma9pd+
	avmVY1pJPV32qBf9pc1XfMSNGJzpTFVMhGxhceRGHuEb5JlB3I/tCuZpAkuJRQ==
X-Gm-Gg: ASbGncvyzg/InwfNGYYG9haSdkb72RfLvWE78IwrGdAy96/7LLbSnlaZckIi29WiKgq
	+oubPnfvPbqkg9TXd+i7gqXPbGqASqNWVLEoRaQCmHU9aV7x8fDIKy8lc2TJBf4U7QLjgjTglrg
	4DsKEdoduJFgyq6JDJ5cQ71/bke/tqkX+YNW7ZcdAgdEMpbNzFUqZVmeyDPJChI2NRgsvJcs/oQ
	g0pAevNLV0J/M3Cq/CHzN1kD31PgqkUEI08jYPue1H2Euk/T+Jq28mnxd7L7ceo59/VyZd3g0oR
	3MYGBAjYg06y3JmweXgKvlQfFnSFxc9YU4BXyGJKAv2qb1zXiSV2EAaC
X-Google-Smtp-Source: AGHT+IFYu9EOA8L4Ct9XfnVjkp7ku32+Ki/Do8zouDY8YGf/vNZgqtc/Kys6Zyyr5hh4usOgGKknMQ==
X-Received: by 2002:a17:90b:1e11:b0:2f7:4cce:ae37 with SMTP id 98e67ed59e1d1-305320b0883mr23177471a91.18.1743579757150;
        Wed, 02 Apr 2025 00:42:37 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f880acasm887941a91.22.2025.04.02.00.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:42:36 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:12:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: xilinx-pcie: Add reset-gpios
 for PERST#
Message-ID: <nihqpqh42pue4hmvjpbk3bk2ogzxbsvlyexfa5diweajgwynwm@kmi6wa4pjth2>
References: <20250325071832.21229-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.7424060c-f116-40af-8bb3-d789f371b07a@emailsignatures365.codetwo.com>
 <20250325071832.21229-2-mike.looijmans@topic.nl>
 <20250325-victorious-silky-firefly-2a3cec@krzk-bin>
 <cad53d39-26f8-49fa-9fb2-94261e74cced@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cad53d39-26f8-49fa-9fb2-94261e74cced@topic.nl>

On Wed, Mar 26, 2025 at 12:57:44PM +0100, Mike Looijmans wrote:
> On 25-03-2025 09:17, Krzysztof Kozlowski wrote:
> > On Tue, Mar 25, 2025 at 08:18:26AM +0100, Mike Looijmans wrote:
> > > Introduce optional `reset-gpios` property to enable GPIO-based control
> > > of the PCIe root port PERST# signal, as described in pci.txt.
> > Drop pci.txt, we don't use TXT bindings anymore.
> > 
> > > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > > ---
> > > 
> > > Changes in v2:
> > > Add binding for reset-gpios
> > So what was in v1? Empty patch?
> 
> Feedback on v1 was that I had to add bindings documentation...
> 
> 
> > >   .../devicetree/bindings/pci/xlnx,axi-pcie-host.yaml          | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> > > index fb87b960a250..2b0fabdd5e16 100644
> > > --- a/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
> > > @@ -28,6 +28,9 @@ properties:
> > >             ranges for the PCI memory regions (I/O space region is not
> > >             supported by hardware)
> > > +  reset-gpios:
> > > +    maxItems: 1
> > Why do you need it? It's already there, in PCI schemas, isn't it?
> > 
> > Why is this patch needed?
> 
> Apparently not needed then, sorry for the noise.
> 

That's my bad. I missed that this property is defined in the common schema.
Another source of confusion if you keep schemas in two different places.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

