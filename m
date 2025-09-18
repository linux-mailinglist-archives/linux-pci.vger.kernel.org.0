Return-Path: <linux-pci+bounces-36404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48966B830D9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 07:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21C6467302
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAFA2D73A7;
	Thu, 18 Sep 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vM+QcwdY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2D2D6E7D
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174967; cv=none; b=iXGP6Kqbec9Zcue2u9laWqIqDyPHxL6Ps0DHh0s23U1HZc0zs1fHOsD75ULqEN/8asxzDzT5oHEh7gtGEHZhSrxBEjuxl1R+lK+e9zJSFUBLobwdAr8ok+syiTRS7UvRqGrhs1dj34VKisvRnK+jh2CoKllC2I4zFhkfIo3RSN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174967; c=relaxed/simple;
	bh=MtvCNWiMVnsL+fP/NF0hiCxoJi0DUaViJhCKPmRyngw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABWr2xQWOA+pm5KHVkPpxexXr+qylcQCZ+JofCkLZZtzHDmjtcDnC/HRiXEVZHvA4xBJj1ocV4UHf4g5SfPTE1kw61EgyGQTfgu90cUBoA9dLzhYUitfINSi3yWmk1VGOllQCwRy8ZCNzOzbrWBCYLUJm2IQp5s9Xka1ytfbfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vM+QcwdY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62f0411577aso1062753a12.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 22:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758174964; x=1758779764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crkj1xqggaMTh9oPYxb0RXj1qaPHLThFfXIKjj2cn5I=;
        b=vM+QcwdY2P+3Maa1johRsRZg1Txz8wupuAtxuUSLM9/5RmqY6LdGIXaPpDo70JB7LL
         m7LI4TKxYVFrV7/v+vFAQsTAxX3BtBENUFtnkGIMIr/GyLmb1yb2foeK1EW5jN+qemRZ
         xb3LXEpb/aRzmEQZHPL/jZe6rEe263ShoL+Cn1bMgS6aJt3MLRhWYxVYfk+VwqthzZpF
         RUuL2V7yWHTj1a1FMi5mbKPp+mHsIK40cRLsKJmEDxclSMvkCvPauFZtLhY5fzgN51Sa
         jd3zlLDDDHO6/ezMwcJzcK9L/g9IZtNhiLTv0pXFfNvPG27J3whJ4W2MoiNe0Xalhnl2
         /lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174964; x=1758779764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crkj1xqggaMTh9oPYxb0RXj1qaPHLThFfXIKjj2cn5I=;
        b=AKOT9XWVEhIfPFUjKCFWJ5YB0orWBsfqHuYLXTIuX3NBT+SxXL5cnvWZy6Xy4JPFHT
         esqloysgzxFHNW5d8PcaRT7lV4iT0FO87+YtzuPB7awRPMAoaVtw98+TjcFe2GkP7fft
         qMg7AHLsVVRv3GeCFENyYvYwWDsMI8XtXilsxq4UF5hAIW/qZ0/OLn9oGH6gA18MFK1G
         6S5+u76KCqxpTSHxfVWPez+DAGocZvw4zVvaECbHoul7oeexvKuPDt6OP6I3EuXE8VCf
         BcCj4zAFG9rrtyYZHBJCmjexBoeppjC/6pnOs+/y9peLTxPwvgQ7Er0agjFX4eovkCWj
         Yj0g==
X-Forwarded-Encrypted: i=1; AJvYcCV0nwPfMBFSrS7zFdmYR1LyQGWBEId+j17P8YMFHFo4orS3bSD6f0DZdaHKE+nzJibbdB1oD9TrFzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHC5dET2g1ROU2bJywh39/FYI3GdrJD7Pbd/H4Y0BgSPxvp8y
	6dv+uRuBT9dxnRL2UPyg4IVR1IVFtSlz8SukEpxFoB5/lKUPq31nuh4uSQDV62YYjcDvdn6J9Z9
	/562hrQeegCXlFebfDeU03NtcLsEKTpl6US/oyKMHQw==
X-Gm-Gg: ASbGncuHqkq/Dr+FxJ7enZNFQNtISPymyp/33I2JM9grHhB1d4jNpIsEAoBaUIlMX8a
	8eQ8vj+LNk+KkiMANxbTRarTjg+6uHkcTt+KfMaa3jouy2DruWwVM3+UZILpIhEbaUK022nb9wX
	JA5wX+9lp+oRthN5KfC7ZDAkyocaPI5qalMnhd5fhX3T5xzoftnBk0yDx3GU+QNQP3oW1mrx4mW
	yjfBc+JMm6W76gXdJ68HKBKcSmvfkqTAbmdlmcPi8GQVoesyjnX+EI=
X-Google-Smtp-Source: AGHT+IGR7nTIOBAlrh93nycdh2C4wP1m8EWpmRWv6aiZAFrIZWDDf8XTFM9Ow/5GHA8Zx6KHRGOD1LFlVtecDyn67Xg=
X-Received: by 2002:a05:6402:1d52:b0:62f:4be5:2268 with SMTP id
 4fb4d7f45d1cf-62f84231d4dmr4414232a12.19.1758174963640; Wed, 17 Sep 2025
 22:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-2-vincent.guittot@linaro.org> <20250917211825.GA1874549@bhelgaas>
In-Reply-To: <20250917211825.GA1874549@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 18 Sep 2025 07:55:50 +0200
X-Gm-Features: AS18NWDMnG99kNALQoafVcWPwrQuqGOxmbLVsuUCgARppc3AjZboY6ARustWRK0
Message-ID: <CAKfTPtC6bGYCoUuMZSX=kx0uR1XS1rHKzY99tkTQa-hUigmpPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 23:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Suggest following convention for subject lines (run "git log --oneline
> Documentation/devicetree/bindings/pci/"), e.g.,
>
>   dt-bindings: PCI: s32g: Add NXP PCIe controller

okay

>
> On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > Describe the PCIe controller available on the S32G platforms.
>
> > +        pcie0: pcie@40400000 {
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            dma-coherent;
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> > +                   * at the end of the outbound memory map
> > +                   */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > +                              "config", "addr_space";
>
> Looks like an indentation error.  Shouldn't "reg-names" and subsequent
> properties be aligned under "reg"?

yeah, that's a mistake.

>
> > +                  #address-cells = <3>;
> > +                  #size-cells = <2>;
> > +                  device_type = "pci";
> > +                  ranges =
> > +                  /* downstream I/O, 64KB and aligned naturally just
> > +                   * before the config space to minimize fragmentation
> > +                   */
> > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > +                  /* non-prefetchable memory, with best case size and
> > +                  * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > +
> > +                  nxp,phy-mode = "crns";
>
> If "nxp,phy-mode" goes with "phys", should it be adjacent to it?

yes, this , phys and num-lane should be together

>
> > +                  bus-range = <0x0 0xff>;
> > +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > +                  interrupt-names = "link_req_stat", "dma", "msi",
> > +                                    "phy_link_down", "phy_link_up", "misc",
> > +                                    "pcs", "tlp_req_no_comp";
> > +                  #interrupt-cells = <1>;
> > +                  interrupt-map-mask = <0 0 0 0x7>;
> > +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> > +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> > +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> > +                                  <0 0 0 4 &gic 0 0 0 131 4>;
> > +                  msi-parent = <&gic>;
> > +
> > +                  num-lanes = <2>;
> > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > +        };
> > +    };

