Return-Path: <linux-pci+bounces-23446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB8A5CC5A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D392189CEEA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD8254879;
	Tue, 11 Mar 2025 17:39:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D98C1D514A
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714761; cv=none; b=CaQlXclJC5+I67wRd9VJypNwnTmeFAwBNKJKDUrEK8WZTZ1Awqs0brh97WyOXn/iD6scHzQJ/tMqXUhyWL1TZNPCSJd2/9NE8XjF8s/oWRimRoSst7zgw+bxNwXrNNlQQN/0KulGr79/eVwMtaYpfhwjvX8A55/W8bL9v+cNxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714761; c=relaxed/simple;
	bh=cU19KBEohon51lJrlMA6nYRu8o1JhUZRBfIUbL/vpPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chlZK55yWfFfSIFg16qsV/bRuMGk1qb0rgH/kilJ+JMPcA44QKuVEgP3Y8+VoCnirCVoBzDM8g5clCu201KVauRHTvv6F+Z72qT6TiPEZ0MKBQqLbWP59leSnGXdExj9Gd4pdFuWP6WtsCMWCflaTfN5kBgj/Kup5eScyo5i1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22337bc9ac3so111684075ad.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 10:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714759; x=1742319559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJPhCqOA/x8C7+uwqlrf0fJMOjg+toTeNzwmc6kfiEE=;
        b=r5TVVKyuAsHoPoY7jUamefq/SDKvuxy8o9y/QBR+D/x/5VmJg6AIQx+Ch+tk2gX0Rw
         9IEL+B7GLvybR/lEBr5w6l7OEK0P4DKu7UneFDCL8t63H0BfNboXxKiqaQPUUZXtH3NY
         l+tgRv/WC4fBR2S8r667WcosTidhz9+pA10lJs5ieJg7LCCV8AMJaN6KlcbDDzy+/gjI
         SeqAvQXhCjhF/OCUQmM4vo7gwz1hKv46qFNx5SzC7xUsgXkzrEwJ2DE0l+PFJMfZXEnF
         1Oy3hzyytLNmQJUSO9jJE7whM1p5LRJrgapncPPgg5vAGASQnQz6r64JXdE9QXtkLkBg
         Gzsw==
X-Forwarded-Encrypted: i=1; AJvYcCWruvVEviUZSywA5+dLlnzhPGhdhVyFO32lbY/1lLM3m0/Vt9OyPw1AuOFdHw5C5CSI7sSmSCvNFsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmaE6iW0Q30qzPa300JUrvB7gGDBdMKTmZQdau+vi38TiiI+2
	SgbyHdciO4pPHf+KCjvOTedmMdMPVB7Wjro0lgQrNI5TXK03tw1W
X-Gm-Gg: ASbGncsMpCNewlIAa8KD1BfnYGimonby8WBm+AJvae+PLfpijC3TVPZd/5MWzKaV/r2
	KMrp1uuSWSaadvCsLkKkIcq/UvQ55FU416odtQFGo0Ykwfn7kswctAXc9qn/4lPo0JKkAlfxc4g
	DvMMXFKPakzloV/rXix8Wn0GdtR7PSScH9SmpG3yv4wRe9gdjDse4rZda52R4uCXHNoXDXkTiSc
	gxnHC4abus5JJbJUTahCdRqE5D68OznP31ZyMYYb7v3VtmrT0jtJLaIRcYvdtLsGkgqg1CXQoAe
	zssn4MwYBL8ofC0Ncp6BnpGctCzwwFFPrQAEznpREbMGQi9v3wu9cFwtV/kPrqblkpkPO7OsK1s
	AOH4=
X-Google-Smtp-Source: AGHT+IHmkmW5YLt+panPYkV7ekm3RJZ9cmgQ2u7tF6hqN6YJIhhpS9OXTrPzB4mw8w1OTZEBxQ6XWg==
X-Received: by 2002:a05:6a00:1395:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-736eb8a2cfemr6649510b3a.24.1741714758797;
        Tue, 11 Mar 2025 10:39:18 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736abe02bdasm8989497b3a.31.2025.03.11.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:39:18 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:39:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/2] PCI: dw-rockchip: hide broken ATS cap in EP-mode
Message-ID: <20250311173916.GA2673952@rocinante>
References: <20250310094826.842681-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310094826.842681-4-cassel@kernel.org>

Hello,

> Hello there,
> 
> Address Translation Services (ATS) is broken on rk3588 when running the
> PCIe controller in Endpoint Mode.
> 
> This causes IOTLB invalidation timeout errors on the host side when using
> and rk3588 in Endpoint Mode, and you are unable to run pci_endpoint_test.
> 
> Solve this by hiding the ATS capability.
> With this, we do not get any IOTLB invalidation timeouts, and we can run
> pci_endpoint_test successfully.

Applied to controller/dwc, thank you!

	Krzysztof

