Return-Path: <linux-pci+bounces-12755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2CD96C0D8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7154284AF2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72B21DAC5D;
	Wed,  4 Sep 2024 14:37:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2B1DA61C;
	Wed,  4 Sep 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460658; cv=none; b=UOzb1Y9EPcbzcHoaPw+Drn3O1hKUX7pwiTezTsDj3sEbxUjqbXHqwX8ynPVvwhlt/KZQZMaOF6bxOv5M6JTOj9gqtdz7MrKYioGSQAkUtlVBgT3fSiSpkglYxKsJYx/c1+gv+8iL0qq8kpWTuk9Dm8OG2MqBEULUj+HbnukDeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460658; c=relaxed/simple;
	bh=8FBaJR3/i5iho+H6LO/jm9p/DpWHmVIC7QJH1el3y2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwSXqGUeCOet9R08gllCDHBzriZ/eQb9qInx5j+0yX1SjaplI+PY+Upn6xvx1NZYazOEAJgRH4ILaoCPEAgyTMpigF2ZMGRh/aMkttkWXnHBgiYA1SKdX3/apf2tEht8/cIMRce0g2d9QtEFyfHNenNBW5am+SF28GHfxmqFqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso5013844a12.1;
        Wed, 04 Sep 2024 07:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460657; x=1726065457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeTNdvUSWx7HJEOyqeFtoigbheBAm0ccbTjqgX0Hr8w=;
        b=l8Pe/765z+pbH8NoRXbf2DA9X6A6sbz5pmwBtMu/8/gFq248DmVAmHqJeBVwnkco7Y
         UO8JeyFhScwQLozP4Ye43ffbB4zvqWPppDhqdTwyg2gDeXINmRGo8AHsHHcGkdDw1pUA
         yxcQBNCNTVu7RBwjY7l3yaiV4IIM336y96Tqzr+ML9eovVKm0l/VxtEw/+OGMFan0y5t
         J4SSK/jQl1W6GRuZ1fWfDwMrcN/YCADhYkFQtGGdseoJiC4oEXCCBFHlS/74hFDb6ZdF
         w86yaSGR65gK1GLlM8kRnkqmBemjweSn8Wxl4TOjXZHNPrLjfJ+nY0Vg9+mlttQx5xdX
         rD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV/hjxxZLzhzUfr4oUOuxjOCwFYeEyzFvS5xhm/2m8MR8e8y2cnH1gcumKTGr87QASK1iEhPm/gmZ+Wkzf@vger.kernel.org, AJvYcCVYPaBH8bRslE57uY/HH+TgFxax5Oveiyeu1oxKLUQfSH1LBq9HKuRCpTX/xrmyIypWsHabtKTpa22KILxPE1rW2lM=@vger.kernel.org, AJvYcCWHmfnn59rvlsxTNq91fo2XuTImyYRX9MEb2VmnzUQ8YcFw9MLAw+fhPS5y452/4fvUYoNyvI3OicEG@vger.kernel.org, AJvYcCX0QN6McTMZ7WGaQBhQX9QpByJT7rV/B248xCWSPsTDqe6h5xehLNGN/VNbTROJy4laq3T+vn5VHNeC@vger.kernel.org
X-Gm-Message-State: AOJu0YxgmVcbpYtyxcTrzAhb7XmScm2GNhVTehLOW+Oq+s42nVHQzq8R
	fQGl8OFhISvwUypk3EZPecq7lFhSMDcJmbTL+iFaZNEmyb5G/oRD
X-Google-Smtp-Source: AGHT+IGFm3a6nIytISSTxdeWLXJD9PZzc11mSxiB8yoFNa+9OMf68AqsNjBgX2pnazA24lTCn9MZ5g==
X-Received: by 2002:a05:6a20:d80b:b0:1ca:ccd0:1bf6 with SMTP id adf61e73a8af0-1cce0ffe3cemr20844080637.8.1725460656582;
        Wed, 04 Sep 2024 07:37:36 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8c61asm1526789a12.25.2024.09.04.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:37:35 -0700 (PDT)
Date: Wed, 4 Sep 2024 23:37:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: hisilicon,kirin-pcie: add
 top-level constraints
Message-ID: <20240904143734.GA3032973@rocinante>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>

Hello,

> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.

Applied to dt-bindings, thank you!

[01/03] dt-bindings: PCI: hisilicon,kirin-pcie: Add top-level constraints
        https://git.kernel.org/pci/pci/c/ac44be2155cd

[02/03] dt-bindings: PCI: renesas,pci-rcar-gen2: Add top-level constraints
        https://git.kernel.org/pci/pci/c/c62a0b8fe8bf

[03/03] dt-bindings: PCI: socionext,uniphier-pcie-ep: Add top-level constraints
        https://git.kernel.org/pci/pci/c/a5c1bf7e9a46

	Krzysztof

