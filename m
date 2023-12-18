Return-Path: <linux-pci+bounces-1132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B788163FE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 02:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146C9B21266
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 01:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0021FA3;
	Mon, 18 Dec 2023 01:17:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E154440E
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 01:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35da160de2bso16177185ab.1
        for <linux-pci@vger.kernel.org>; Sun, 17 Dec 2023 17:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862237; x=1703467037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDKZUx5HtNyZoTQVTDUN0xYo5LjMA876jFL0bA6k76c=;
        b=wthe1ueinJMq6iIDvU+8Y5KaNogRyNiIRgUhg/Cuhp2GrucIJiSzVahVGrkKIPA/Jc
         bRbUheMWHdftGkygFhF0ynFranxFDbBFMpWNAsvAI6jFTG0sY2O/QbiCoj5NHUsL2P8Q
         C8Vb3OFsjsA1w32nMivOB9b/tmJkXy35DUHwHshTgAX+OwkxZHE3umLB8VLLJuciYnLI
         GZGCPStOPgtFW3HK9GMbnYbIWrmqmVMgaO2PcNb3ZFRydMt/TjgZwA/GDU2spxu45Y/s
         Cid8TNXtVQyVDYNjKELhGqun0vjCXIMIkoUp4o24hhFgj8WYV5rRrqbVezaDZqpXspKa
         iAjg==
X-Gm-Message-State: AOJu0Yw0s9CxDrnWYa39FMUBy7RGHBrliYyYzncW/gG06RGy7VmhufC4
	AjYi9Esy4QKUfjfsCqToPnY=
X-Google-Smtp-Source: AGHT+IHOnm2Y3FaoZ4W11I0e8vUwHa1CFBCFJQ4zcmymxGQkJqdRTbe5W/Aw5rM60EyywYKsqQWWdA==
X-Received: by 2002:a05:6e02:2188:b0:35d:59a2:1275 with SMTP id j8-20020a056e02218800b0035d59a21275mr24704445ila.33.1702862237559;
        Sun, 17 Dec 2023 17:17:17 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001d3a16d98d3sm2514095plb.253.2023.12.17.17.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 17:17:16 -0800 (PST)
Date: Mon, 18 Dec 2023 10:17:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <nks@flawful.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Message-ID: <20231218011715.GB88933@rocinante>
References: <20231128132231.2221614-1-nks@flawful.org>
 <ZXrR6n7MQIpAaVPx@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXrR6n7MQIpAaVPx@x1-carbon>

Hello,

> > Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> > correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> > support iATUs which require a specific alignment.
> > 
> > However, this support cannot have been properly tested.
> > 
> > The whole point is for the iATU to map an address that is aligned,
> > using dw_pcie_ep_map_addr(), and then let the writel() write to
> > ep->msi_mem + aligned_offset.
> > 
> > Thus, modify the address that is mapped such that it is aligned.
> > With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> > dw_pcie_ep_raise_msi_irq().
[...]
> 
> Gentle ping...

Applied, so it should make it to 6.8.  Apologies for the delay.

	Krzysztof

