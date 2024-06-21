Return-Path: <linux-pci+bounces-9092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED67912E02
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B521C209EF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8A179203;
	Fri, 21 Jun 2024 19:39:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754F184A32;
	Fri, 21 Jun 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998781; cv=none; b=UNyNYYAc2lQAJnJmhtfR9vJvoNggwH6RBHdRcYLZzHbsb4revED8vlrVQU65stgfnc5QqXRfKjXgSnICacO4g7ZudJgzYZatwl0vAPQggHHwoWGjQpd+H+nfIRNJup1Z55RqsViTqnpJdaN4QDugDJJZlIhthDZGix1lwmNhFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998781; c=relaxed/simple;
	bh=U6BFQW2Bf2YvjNS9Cqv8gtXGEtkdb6Mqkyc1F3FIQlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ9LYbAMSK9St4hVCPrTkhky4lskmb+Gd+p5/MUFDl2v+Erzv0pjIR8xhLQXoH39OmYko4wTNgSUC/jnQGV2BiBEmFp0m0rP5KKgU4XCHFWbAF7olIidNukisvFf/qLVHk5vG/6jIh9wzpyF1QBiUNgLzqdHaB3kBWrRFRGZy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7062c11d0d1so2162792b3a.1;
        Fri, 21 Jun 2024 12:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998780; x=1719603580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qcjCj1d5K3iJ5YuAuheFrJXPu/KrnBD3KZXSkLcbok=;
        b=eYpMbFXHBUAE6HjcHhrLA9hEXpNu9RR4jvMpondOkMQ+c/9FMHGpuWYeY3EQg4ApTF
         IzySB9gOgZ3iXUPOo1cgzQ5b6h8xTPCTkeiXUXC4XPTzSjtoSdZiTL37EGKSWt84ww+k
         sTIPHd39U8nGz4zIwOqVBq+pKyFHs8tk/v3ZKjwG5kiczlL2JJBoz+nARGupRVIoPOWR
         4jDQFefpFCuAzNRnl1UB59HNZyw4AT7Od19aFE/VQap7w/t3aAIdoYFkwoK9GfxV1gxr
         wMcXXY3GQP6WXbEv3IX96styF0z3mMWFy+/WLYYPKJy+j2ZTOyacPDPaNB0lC4iOqktH
         S97A==
X-Forwarded-Encrypted: i=1; AJvYcCU2SIwVv6Ys5dK+yqIGG2w8z5vKbbLrMcoDp8ZQD3Mxbgk/7gdgzRHv0yq/lvxXt6caMI2zL6BQ7V/yqxJvMpwkFOD1wLfsdDAnZoei6u9gEQzZOtFa0HEdD7CESeX4oRHf3UxpKQ==
X-Gm-Message-State: AOJu0YyxUpgvNBO/KBxcl+/7DTKFCmMtloNiPS1R8gouG0VitbykIjmN
	2FajQwmtBpPmzx33/UVfXyDL3ZtQ6+4dEDZxtGojKwhUAJ2et6EG
X-Google-Smtp-Source: AGHT+IEYUbVQCtzTwul6T6G76wz0/njvH+sWwE8HKvA6iwxYKKzfFD1GGcxnU3GSiWtOY/JWO+LNFA==
X-Received: by 2002:a05:6a20:651e:b0:1b4:b4af:6047 with SMTP id adf61e73a8af0-1bcbb55fe74mr8085989637.33.1718998779547;
        Fri, 21 Jun 2024 12:39:39 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651085891sm1789309b3a.3.2024.06.21.12.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:39:39 -0700 (PDT)
Date: Sat, 22 Jun 2024 04:39:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <20240621193937.GB3008482@rocinante>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
 <Zm_tGknJe5Ttj9mC@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm_tGknJe5Ttj9mC@ryzen.lan>

Hello,

[...]
> If there is anything more I can do to get this picked up, please tell me.

Looks good! As such...

Applied to dt-bindings, thank you!

[01/06] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific reg-name
        https://git.kernel.org/pci/pci/c/3b287269ab60

[02/06] dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific interrupt-names
        https://git.kernel.org/pci/pci/c/b96353773d24

[03/06] dt-bindings: PCI: snps,dw-pcie-ep: Add tx_int{a,b,c,d} legacy IRQs
        https://git.kernel.org/pci/pci/c/6f308c017c27

[04/06] dt-bindings: PCI: rockchip-dw-pcie: Prepare for Endpoint mode support
        https://git.kernel.org/pci/pci/c/9b0b9b588c00

[05/06] dt-bindings: PCI: rockchip-dw-pcie: Fix description of legacy IRQ
        https://git.kernel.org/pci/pci/c/5f262f67cbc5

[06/06] dt-bindings: rockchip: Add DesignWare based PCIe Endpoint controller
        https://git.kernel.org/pci/pci/c/ff36edde817e

Applied to controller/rockchip, thank you!

[01/04] PCI: dw-rockchip: Fix weird indentation
        https://git.kernel.org/pci/pci/c/e7e8872191af

[02/04] PCI: dw-rockchip: Add rockchip_pcie_get_ltssm() helper
        https://git.kernel.org/pci/pci/c/cbb2d4ae3fdc

[03/04] PCI: dw-rockchip: Add endpoint mode support
        https://git.kernel.org/pci/pci/c/67fe449bcd85

[04/04] PCI: dw-rockchip: Refactor the driver to prepare for EP mode
        https://git.kernel.org/pci/pci/c/ecdc98a3a912

Applied to endpoint, thank you!

[1/1] misc: pci_endpoint_test: Add support for Rockchip rk3588
      https://git.kernel.org/pci/pci/c/657463e393d1

	Krzysztof

