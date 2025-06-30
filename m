Return-Path: <linux-pci+bounces-31119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C436BAEEA21
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 00:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E33F17BC89
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC622356BA;
	Mon, 30 Jun 2025 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKTnWNwD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231B21C161;
	Mon, 30 Jun 2025 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322274; cv=none; b=BpjJWXeQS1Kym7naGX8grHnid5QmRbYcfbVhOf69biJfkMz4Xs+Bl9+8Luot5x2HvM5xE6lS690Ei9tCkZTDsMKu2rS00X48uLMHvbgEHKmIIxCHxM2ze6uWFK4mBej/h8sja0W2c7bhUk8L6M8cZEIDK0I25OMlxwpiQa6M7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322274; c=relaxed/simple;
	bh=Gw4w+JlfU8ZSipHyP2abRxrCX6poC9T1o7K49sJWZcs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G4C7i17H6+MAl1u9tfC7YqiFIuxON8C0pvwIhZ8HfmYozmr/UISnwFuDoLPESJVXCQZ22yokLyWSvyW5pIkSrBm5rSmXmAdEXPKBqYI8sgtnRmCJp57O6Z+S/G0oBPivBbsOIW9JU4OY48XOE57wRjPI9NhinqXtkMRbrrnHHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKTnWNwD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a818ed5b51so11064971cf.1;
        Mon, 30 Jun 2025 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751322272; x=1751927072; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nOqcQ9E+8drflPFHAs4vSUWLT7BoxqpED98LP9u+w/s=;
        b=DKTnWNwDCcMPhwWQFx0kicuuvIVPtpAYlBZ2OomfNsfyoMxCoCwU0GN+6hJoS7zpgm
         tNW/6wsXkVxeoOc41iH1tfWGQqNMKn8zGIx3Lpo31d+kuFTHYI+p92vKhkTOsjISBVSM
         zNmcfDz653CANHsY5qrFKUvetnnM1a+KXuj4Ie6B63Nn6BdoDMXAuSeqI01qbt60/4Ar
         rCzO9OaAFitjW/7ky+yDFVdLpHsd6U1ph+H4YZIJnlRRWYj2ZPR/DOZ+uBvxwOKDvwme
         goEmDSAeYAkrDIzk6IttxYXNhp/ubqUHGAqrd8BB63OxDIVlXyPEM3z8d3fwRB+RaHEU
         86qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751322272; x=1751927072;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOqcQ9E+8drflPFHAs4vSUWLT7BoxqpED98LP9u+w/s=;
        b=jRnbdl7YWdDB5mMC4hHY0CUoVhf81sP95Wbv1/rut0JGpYBY1RZJfI1fDgC9S8nUGC
         JhaQ9gTWRw9fm+XokrSZaImLlpaHpyxj20QFih9KyA19tDO3PbTc0UJfrzVcbJ9Tmrhp
         RAWBi9oK7MYXjvwcEPVFAiyVw6z1WNhV7WHwUfeyr2MaRwSrrkxXBPc7DJdCpEgaoVSy
         9bnPf5SHBfc1hW4mAxsqtCLVO9RD8WWOFdGLsXmM99ITkDIMSs8r9bESNlVzm9BQxz0o
         SWY4hIeuBimdana87HvBQ71DTk+Ralk2x0R3WL6D+EjGzBbCoVQ3uqdzjQpjdKKL8avw
         xUHg==
X-Forwarded-Encrypted: i=1; AJvYcCVBN6d/dRYbQlLlp86LOFuJqXwmxdlp1NVN78Uja15ZtwN375GRaZBPtUwTYmrgtarEGgNvZk7dDh3M@vger.kernel.org, AJvYcCXjd90dGoJwLJ8/5Xw6J51zW0iaem8PaXU4R1C8LJNk+IzLgtkvG+uU0Acow0L/ceDKBWcEuGGuOqEkClg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEr8Or0jw/DdhX4LSwlBa1JlkmCY0Pm/kJYfK5bl6yAZrr2s4
	vlCAl9dX5KxUHDrT2wbKGpXd/TzEcSnN8mcA8UFrO/h2mReRAbgTITa2
X-Gm-Gg: ASbGncsDyC8F7pf6o5MPI7Wj1cRJfC7rrcdmNk3aOiElmjTx360YkpLUgn/pvZAXKVo
	+JBZUvBDXYX+ziuhuZMAOUQ2FRZ/r7P5Y3xi/nH2aSSjxMQAHNcEU7x3x6OdIXYJuON8ATWox47
	CSSrLNv7Y1WshVE4vcIkza4lfJRcc69RnXvTvSrYvRJ7VeH7ryCPpZFCHoprnMKmxX6nAitdy1C
	Yalmlg+cNZBxbMJmYhia1wSn1ijBtSURsGRQnsKPKE5CKzwv+lsnKSyK/JGXuViJGWoDMRT1dw6
	XEtgQZO8WRofDieZr0Wdp1M6SVKbhrS+Tk3IjPEKuVW6MUQjohtqiJdKEbOY
X-Google-Smtp-Source: AGHT+IHQqj4onXTfLWFSXWgdbcEMH4oCP6peKWldHaIP1cBl7zoluZL5kjSP1aRSbi/hl5ifZScA2g==
X-Received: by 2002:a05:622a:2305:b0:4a6:ef9c:eaf6 with SMTP id d75a77b69052e-4a7fcbdc53amr248768291cf.41.1751322271627;
        Mon, 30 Jun 2025 15:24:31 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771b8854sm74755966d6.37.2025.06.30.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:24:31 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:24:15 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v9 0/4] PCI: rockchip: Improve driver quality
Message-ID: <cover.1751322015.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During a 30-day debugging-run fighting quirky PCIe devices on RK3399
some quality improvements began to take form and after feedback from
community they reached more polished state.

This will ensure maximum chance of retraining to 5.0GT/s, on all four
lanes and fix async strobe TEST_WRITE disablement. On top of this,
standard PCIe defines are now used to reference registers from offset
at Capabilities Register.

Unfortunately, it seems Rockchip-IP PCIe is unable to handle 16-bit
register writes and there's risk of corrupting state of RW1C registers,
an issue raised by Bjorn Helgaas. There's little I could do to fix that,
so on this issue the situation remains the same.

---
V8 -> V9: modify third patch to better reflect authorship by Valmantas
V7 -> V8: add Valmantas Paliksa Signed-off-by to third patch
V6 -> V7: drop RFC tag as per Heiko Stuebner's reminder, update cover
letter
V5 -> V6: reflow to 75 cols, use 5.0GTs instead of Gen2 nomenclature,
clarify strobe write adjustment and remove PHY_CFG_RD_MASK
V4 -> V5: fix build failure, reflow commit messages and also convert
registers for EP operation, all suggested by Ilpo
V3 -> V4: fix setting-up of TLS in Link Control and Status Register 2,
also adjust commit titles
V2 -> V3: correctly clean-up with standard PCIe defines as per Bjorn's
suggestion
V1 -> V2: use standard PCIe defines as suggested by Bjorn

Geraldo Nascimento (3):
  PCI: rockchip: Use standard PCIe defines
  PCI: rockchip: Set Target Link Speed before retraining
  phy: rockchip-pcie: Properly disable TEST_WRITE strobe signal

Valmantas Paliksa (1):
  phy: rockchip-pcie: Enable all four lanes if required

 drivers/pci/controller/pcie-rockchip-ep.c   |  4 +-
 drivers/pci/controller/pcie-rockchip-host.c | 48 +++++++++++----------
 drivers/pci/controller/pcie-rockchip.h      | 12 +-----
 drivers/phy/rockchip/phy-rockchip-pcie.c    | 15 +++----
 4 files changed, 36 insertions(+), 43 deletions(-)

-- 
2.49.0


