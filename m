Return-Path: <linux-pci+bounces-7601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A165C8C84FB
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E022821ED
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACA39AEA;
	Fri, 17 May 2024 10:41:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E093BBD6;
	Fri, 17 May 2024 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715942491; cv=none; b=ITlZ6vHYSXsJGkkKRvn4ArNZuwzkJ+8Y59DNhOO7Qkf840PagJYR1jHFG8Ee18loQMoPUIlXXGh9BoOP83C2KLE9UsTI9HG7xwlLTbPzoFfo7eMbC2quGgh2+of1a7kZmjoqu7JX8Rh2G4ZhUOTXuHPPda7b3oKDCx0+Wq1h/6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715942491; c=relaxed/simple;
	bh=k3G9L96yDt5S3vX+qLFsoaeZaw/80iveTPwMckiRdjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRGW5nSAJ/XEIsyIWzxhdPsubOaJyHhczXh+BJQRaCmFbmRkpGVPzkOuQemg56YtLqiNwXYZGuT3Xzwh9n8PptGEATCrlDigCScKU9uZwodflUo2GY5lLTxrySDsLg4xocXzR1b+VPjTitBX1f/JuDJ9OQJmJ9xhoPCV0P2eOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b2733389f9so662135eaf.1;
        Fri, 17 May 2024 03:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715942489; x=1716547289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ep6WjZ/XECenrwVHNZ6CdFGyjtlB5or+xofNQVT1ak=;
        b=PzWYfdf83hT2gBixdJijrHJgZUu0NL9U4wppwYHCmIOf5ajCjRj/uRtoAwu/CxeZPS
         xfxHWLoiXz7qDtFcuV1xPOgduXLjRS8ci1njhTIn43M3l+UoDlzBsqFp9wyA2qda+uHP
         69J6tf92Zi3LDRQ8IGEOEt4+ZFVuDjQG6lDSy6z2j76HvZNp0j9qondWaQUJGtYJ4LGU
         y92Lc+jyQLO+RB1bvzFxDEMwARLcOi0GjqWduG3UfuF3JQzeZOQFt2dMFP/kV/HfbnR5
         yZo3id1I6IwQOg3gVTxlznqDolqv2ubjKWqQeXR0nIE5yPIQmGVBT2R4Axvy7hOSQ+I4
         tmVw==
X-Forwarded-Encrypted: i=1; AJvYcCW1T5Jzzi5YWeDpa9AzrJn0UoNm3ltKj+OFo81AGoIkY1mPuC0bZLsOCD2H5YIdVxA+G07zl0q0ivPAkKEQO2GgblP7mIn7MfStxt1R36VK/xUOBD2E3g8SI8V96B4+tifkI8F6EKnzDP0qJJiGf7B2coX80YL/r0f/+pbsaMg0M4JFafkxWHz0BXtgDH9TidhCrWVoZN7W/VM7R0jNuvlVXOHikxadvWQaOqypo+27h1Ko6kL46NgJGDi69bSBn+YmZubvEw==
X-Gm-Message-State: AOJu0YzJn/pyqDE9JfprPMbEAzv6Tt5i6XpTSVqWdcDhx0Q2fWrKkrkS
	2rkmdAGuPyGxjXIddfsmapxmgw5tm8Kj5YcRsqbZ9cFFY8bpeIbw
X-Google-Smtp-Source: AGHT+IHryVBDZpZ02HKgPHTEO7zKqNKHDK8Mg2XTift9Qc3NF8SYMoDnU3GekdswLqk1/o4nC69OcQ==
X-Received: by 2002:a05:6358:c005:b0:18a:78c2:7ccf with SMTP id e5c5f4694b2df-193bb628645mr2477851655d.13.1715942489450;
        Fri, 17 May 2024 03:41:29 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-658764fda40sm3257811a12.5.2024.05.17.03.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:41:28 -0700 (PDT)
Date: Fri, 17 May 2024 19:41:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: cdns,cdns-pcie-host: drop
 redundant msi-parent and pci-bus.yaml
Message-ID: <20240517104125.GJ202520@rocinante>
References: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413151617.35630-1-krzysztof.kozlowski@linaro.org>

Hello,

> The binding reference common cdns-pcie-host.yaml, which already defines
> msi-parent and has a reference to pci-bus.yaml schema.  Drop redundant
> pieces here to make it a bit smaller.

Applied to dt-bindings, thank you!

[01/04] dt-bindings: PCI: cdns,cdns-pcie-host: Drop redundant msi-parent and pci-bus.yaml
        https://git.kernel.org/pci/pci/c/51ef0538d4e1
[02/04] dt-bindings: PCI: mediatek,mt7621: Add missing child node reg
        https://git.kernel.org/pci/pci/c/36fbed38549c
[03/04] dt-bindings: PCI: host-bridges: Switch from deprecated pci-bus.yaml
        https://git.kernel.org/pci/pci/c/5db62b7d3c37
[04/04] dt-bindings: PCI: mediatek,mt7621-pcie: Switch from deprecated pci-bus.yaml
        https://git.kernel.org/pci/pci/c/d3fa4be9033b

	Krzysztof

