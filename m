Return-Path: <linux-pci+bounces-27969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8CABBCDE
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588D53BED64
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF762749FC;
	Mon, 19 May 2025 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVC9g5+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853AF2750FA;
	Mon, 19 May 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655041; cv=none; b=iOBwelZusfzwExdz2bN/uHqCAeFr3M9gGP2DhHSkic3CC0eUmokPydpXWUcTg7yClMkaOzd+EnxSFfPjPTnbrm+aFfqLTA4xhw6rFGskEV78PoxWYb/HKjN0zLI/PnNZwqBcbueIi4kvgF71fGDhbk4b1iBAKXlxw+B9EPm+GJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655041; c=relaxed/simple;
	bh=MwH0W3o9aFeqh/fMQ2QtF4mamhL6Gz4btfQV+sSYBk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl+6TuTtHFXU05D5cDvBHBbdaK+dREKK1XifydYkSTZ+tXM5wBszhmaJQ8QoITWNFjuFtsl2P7IEJWih/MjsLNRC+QwMQEsOIRWqqjoJ465le2YF6k2wAFZG/dZ3ImIXdUWK8nbvuxCJ+WNkwP9dCdHm3nefn6Fjchp99OXR2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVC9g5+T; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8ce89468cso15172036d6.3;
        Mon, 19 May 2025 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747655037; x=1748259837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdHsq5COThnaz/kT2PepDjGRRqibq5HBjdI+te70JDw=;
        b=NVC9g5+TKPXsNrAT5x/QqgOEHw6u+Dp9B2AmXjPDpfI+14e50GkbuEI4Oh12yk6vAa
         CeLbdG1fA8V4MpWg/wQgVZOZPNNUiZ+RikguogvLAzY+wfB0WEewR4lS8XJDgLJoN6fx
         qJOhWu3e6rYHybjRnFEgtoT/8/JcSjA5+DN/zdT5V5qxsTdr+1OlRRLK3u587NGWH0za
         7aauFK/R/ul0YsZlhfz/xuOwtPtg9Paja7WvOY7yhjk4D+fHbqYFbzdRBkegsFbfhFiu
         zqvP+KbNgVooNFE93i2b/bV6imOMy1VrsAru63fogc2ZFavolE4fcqaaRODiAHUJ989s
         RyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747655037; x=1748259837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdHsq5COThnaz/kT2PepDjGRRqibq5HBjdI+te70JDw=;
        b=NNJn8/BAWpFo1FGJyLIHDdIZjElr1N0Fs/pFMm5uKMMzhWvdXKOIlZw/pCIt3d+CkZ
         FKFVDObwLd7e7fn8FJPzaWt5koMXRtUCNlbVHNYnMlzmyj4o5TDgLDPUztEizs+xawC6
         G2MgTtRFvEOKPRyCpkIURYmpVFiaB2lKk8VuKOsOUVrjvP+apoRtL5TbTxlh9TnNqibB
         3Mpcz+gXrx9gUgDvl9fkhlUPkdBfrxjqUkb3xE9CDXoLww6VqkNUDE4dO+LfpZyoU6Fv
         dD35F67Xl8HDOEryeBmrrGF0i/IwdSQXbD1DfI6D3JPwN03pxtPMtmSOoiQ9+RygEDa3
         R96g==
X-Forwarded-Encrypted: i=1; AJvYcCW0ue0ixcGU+J47bsUL7J9OXx4jUI2NVxv/2MkR80oIA9kdEtxAgmmVLHEdvQN2rK+bW6i5ZEFenSLvc6ak@vger.kernel.org, AJvYcCXOO1cZ6JPpPDcg+hWo/FD6CuOu9qLG2wTZwDa4PqTyirR4b/B6BxURF8yvovOPjnE9nXOBdkbIjd75@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7vJhKFpD2Wuf29xiK1yNzGUwru/lUghaHnwQJPRXuEWxMWDY
	Td0vQwt76DM+a6ZOybwgQo2yq8FvHiVcRECAr7+jzh9x+LD78gPS194H
X-Gm-Gg: ASbGnctSoxnXJQkXLoYwnRGgwZc2IznGZbG3Y024hwqAA4bHi3b2C+1lbcu5oL8v+KT
	Hiogy18gSL6zQEx22ayiYSccVZFgVP914EkzVRep9L42TQOyoDz2vuRVSOJM3rnkr9j4sgTnCv7
	gX3hGt8lbSvuLaTyOuYvHnP7e1hvB9/3Sbs7/ea3bbs/3gaoH+FrVCwngzpUwgaroaU5U6xwd3P
	oIzpygMRw44Rx/qORmBK7Unlx/ZTHFYFFBrA7ik7jleoE/ph9uNP0nK+VODQyG8pTQTZRaseOPB
	m0+ic9es/8mk9Zh1++2IppTgIpqg8KKG/PFYHg==
X-Google-Smtp-Source: AGHT+IHzi+wH4LTGbbgm7Y4TjS58PZ5Nah+7v2/J250yJ8XpMnfpx1miscgVUqmQCndfLGxyKsFvKA==
X-Received: by 2002:a05:6214:2344:b0:6f0:e2d3:66bb with SMTP id 6a1803df08f44-6f8b0887e10mr173576876d6.43.1747655037154;
        Mon, 19 May 2025 04:43:57 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b097a0absm55522516d6.100.2025.05.19.04.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 04:43:56 -0700 (PDT)
Date: Mon, 19 May 2025 19:43:17 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Niklas Cassel <cassel@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Shradha Todi <shradha.t@samsung.com>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 0/2] riscv: sophgo Add PCIe support to Sophgo SG2044
 SoC
Message-ID: <77tip2z2mmuucsi4ackwubfdbyzgg2soaosmvbyrfl3iwrmmp3@icjunp4bsske>
References: <20250504004420.202685-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504004420.202685-1-inochiama@gmail.com>

On Sun, May 04, 2025 at 08:44:17AM +0800, Inochi Amaoto wrote:
> Sophgo's SG2044 SoC uses Synopsys Designware PCIe core
> to implement RC mode.
> 
> For legacy interrupt, the PCIe controller on SG2044 implement
> its own legacy interrupt controller. For MSI/MSI-X, it use an
> external interrupt controller to handle.
> 
> The external MSI interrupt controller patch can be found on [1].
> As SG2044 needs a mirror change to support the way to send MSI
> message and different irq number.
> 
> [1] https://lore.kernel.org/all/20250413224922.69719-1-inochiama@gmail.com
> 
> Changed from v2:
> - https://lore.kernel.org/all/20250304071239.352486-1-inochiama@gmail.com
> 1. patch 1: remove "|+" for description
> 2. patch 1: apply Rob's tag
> 3. patch 2: remove empty irq_eoi and use handle_level_irq as the right
> 	    irq handle function.
> 
> Changed from v1:
> - https://lore.kernel.org/all/20250221013758.370936-1-inochiama@gmail.com
> 1. patch 1: remove dma-coherent property
> 2. patch 2: remove unused reset
> 3. patch 2: fix Kconfig menu title and reorder the entry
> 4. patch 2: use FIELD_GET/FIELD_PREP to simplify the code.
> 5. patch 2: rename the irq handle function to match the irq_chip name
> 
> Inochi Amaoto (2):
>   dt-bindings: pci: Add Sophgo SG2044 PCIe host
>   PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
> 
>  .../bindings/pci/sophgo,sg2044-pcie.yaml      | 122 +++++++++
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-dw-sophgo.c   | 258 ++++++++++++++++++
>  4 files changed, 391 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2044-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-dw-sophgo.c
> 
> --
> 2.49.0
> 

It is a long time for this series without any comment, I wonder
that this patch could be picked for 6.16?

Regard,
Inochi

