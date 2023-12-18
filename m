Return-Path: <linux-pci+bounces-1131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6D8163F6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 02:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975751C20AD6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 01:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B21FA5;
	Mon, 18 Dec 2023 01:12:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456C1FA3
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so22361a12.1
        for <linux-pci@vger.kernel.org>; Sun, 17 Dec 2023 17:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861963; x=1703466763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hWkLoex7DroTJkqm73l8UsmW5BK+pcVcZ7tlH6K36o=;
        b=TRVYCcQPKVit3pnnL7Lh6DZl5NsrvYhl70Ey1HC1WrwVBs+RSNq9g40Vf7u7QMs8xJ
         w1kx5+osIM9a8y/9gxs/6boqDCIuLC2VpVmjhM32Lsv1hCIouA5TOSXGiD+jKU/NiG0S
         zpB+p9gfqk2hDp/8RD6s2uXruJUacm173/TxrMiANRNJRM0ZKRy1HU+Rr/2l5JNc1N43
         umtZ6RcETTj6aasutgrJ6AdCN5aVZI77UEdiKucMDzQnKvruo79Pf8A1+FhxcwRtW6Cf
         HARbQ7S10yJtMMxtDcBBqASEqCq+QKLrroSeENyVrlUEP46j54Y1fdgXOGTH0LK5kAIa
         aCTQ==
X-Gm-Message-State: AOJu0YyljmTKup0Tw570m6BFuXAaEjvbV3BUzVUM3Xc9IpwC8eMauGky
	eJ5gYnoHSZ9eQKLEGyJzf0nmTbv3voHBCQ==
X-Google-Smtp-Source: AGHT+IF2PkoJuTl5NCAZ1QYikGd8hQ3bQnzXyERjplOs1sHZirS/nADfMHn8VScUyeTYPkY3pqRBog==
X-Received: by 2002:a17:903:124b:b0:1d3:340c:76d with SMTP id u11-20020a170903124b00b001d3340c076dmr5699591plh.114.1702861962939;
        Sun, 17 Dec 2023 17:12:42 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b001d0c0848977sm17756160plg.49.2023.12.17.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 17:12:42 -0800 (PST)
Date: Mon, 18 Dec 2023 10:12:40 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <nks@flawful.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Message-ID: <20231218011240.GA88933@rocinante>
References: <20231128132231.2221614-1-nks@flawful.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128132231.2221614-1-nks@flawful.org>

Hello,

> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> support iATUs which require a specific alignment.
> 
> However, this support cannot have been properly tested.
> 
> The whole point is for the iATU to map an address that is aligned,
> using dw_pcie_ep_map_addr(), and then let the writel() write to
> ep->msi_mem + aligned_offset.
> 
> Thus, modify the address that is mapped such that it is aligned.
> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> dw_pcie_ep_raise_msi_irq().


Applied to controller/dwc, thank you!

[1/1] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
      https://git.kernel.org/pci/pci/c/2217fffcd63f

	Krzysztof

