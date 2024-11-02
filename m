Return-Path: <linux-pci+bounces-15831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8309B9F73
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20021C21446
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29017D340;
	Sat,  2 Nov 2024 11:41:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B251189BA0
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547694; cv=none; b=XOSalGqrqsMgw8zWypOlcHmpgPeoWVtj+U/kR0uklLDBp+lz89wtZ4cAfXEY2Xqis/as9Ta1qIakju/cpWIlsgW3WMrQKIXZ47Tr2dca6iGxLXr1t5z7PTPn1n9v3w1xs3WNnfTj1qG6TXPavI1RGJjP0zC0K9Km641ZDcFb3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547694; c=relaxed/simple;
	bh=vNZbDRe8qfenIVw0hS6LaBWAXp54nkMDy20l8mPDUro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+XKKdUT0GXEGyySdAnAtOSF16tSkArY/28Ks0sTHiXXzMIARkHLZXvdrXa7rgDPt8g0l+OTGovhAxAr5vwqP326rVsUMdrxb1dgKqceV/nxJm+CwIFZpymttl3rR7IA2DwBytJxikUQL4k2SwbvH+A8ZARy/CGl70JhtnYmhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2127150a12.2
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 04:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547692; x=1731152492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4U8Kh30FyN7eoX+zkoMluqTH3jvSWetrwTEWzFLHHA=;
        b=IbkNFWk9t767JwLdhbmaxxAdO4A+/vAh8SAB3G4tgDvvpOxBXvEGmwCf8GwYKBqwgO
         twIX/XFH4Sye71zcxe5Gke7T3QVnCW5tXUBY4cjkxDotUz1OXe1gikns2Zp9qVHPQDbp
         62jex5L1wLJgx6hgrIeJAORsZ8EtODp70+GtUjezR1MoOghSItAGMCslAMVCLrY7awgr
         6y3QrEHOc1Glj2HwgQ/HzIDVjbLuQ6BjfLjyk/NNOXo+pzG6bWWv4ihPGNUftU2qyQK3
         Hws8oNH+Iul8JvJWqjAIrBByaRW/7FgC68tqMChAvdZ9zR8wmAc8tL/FZFEEBenIZEk6
         Oa6g==
X-Forwarded-Encrypted: i=1; AJvYcCXP/4wAxxGO09MEf+bXKLBsYOMNfR/7waIfTS81cRP4mpUrSRplbE0pR7kMINFgWmmPpolcyw4fziE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAgomig+f9G4OjNzH7elT93S3jIjlk5qPs5Fq2gp+eDVNrC4f
	K/OOsXdQ8y/fmXlOkL3Tx8qZzEXuC3TPzy38g+vhJmfpn5kQrR8H
X-Google-Smtp-Source: AGHT+IGtKAQRstfq/Xu/OZfm27T6suGJnqMq4CTnHSkloBctIGzwfAwAFjrcG9AUq3BvA9uLPgsU+g==
X-Received: by 2002:a17:90b:1c0b:b0:2e0:b65b:6b4d with SMTP id 98e67ed59e1d1-2e93c3057e7mr11531171a91.41.1730547692356;
        Sat, 02 Nov 2024 04:41:32 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa2606dsm6294648a91.20.2024.11.02.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:41:31 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:41:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <20241102114130.GC2260768@rocinante>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017132052.4014605-6-cassel@kernel.org>

Hello,

> Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.

[1/1] PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()
      https://git.kernel.org/pci/pci/c/f68da9a67173

	Krzysztof

