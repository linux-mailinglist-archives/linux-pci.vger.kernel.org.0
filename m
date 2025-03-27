Return-Path: <linux-pci+bounces-24869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AADA7379D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733C71688A5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09E1AA1E0;
	Thu, 27 Mar 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CatRF5bt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE791A28D
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094872; cv=none; b=SyZct+lBt6LfX0xY3VBQchvH/Qzk2dU9JcO5AKpSbWP081HDwaeWUnHdMS8NdLxjLG3t8l0LBDIqA0fNdYw+SF0l8WISv7JIolL7MfkxQED0QAz8RbyW/XwOQE7G+8R04A0l5OGJeI+OPNmuiNNxR8AJkwJEpblDl2yst3ZShXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094872; c=relaxed/simple;
	bh=90Oqr8LPETJCgzlxDfWErsEUt1o4ENjdoCUxT37hAlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIk1hSeyYyyw3QF80H+HlQznt46nl7nGXcVhX81W7+yre1N8oFZ3wAa82dDIc3qqmqHx03z8r9rt6K9xsWIQoYH8qebBVJdLiN0Ucc1wo3tyBeNoB5G6+xF9nP7jssk8rYlG79/l2BTfP79OBoGvY6DV2bR0tUPkq/PeGO70AaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CatRF5bt; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22398e09e39so29051225ad.3
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743094870; x=1743699670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9Om66rj99/DALJuBXsg77rBt0HogaVaFZqpEHuMUIc=;
        b=CatRF5btAHU6DVFEkcm4+Y1ouhN+5KRXaNDXfHCaJHfIhQxfrPRUGopyLhp88kbNFm
         aVWQZkMnJb02gRkhjeUAMa8xdBMbtPkONQ1zlp7yCB/d0YolUVuB2N79A2mRTJUhHk6e
         oySiEm5XWpPmXHVgo68Y/WRN9F5HGIiIHgGg+f1F62tBa2XXA/NrLH0YAuc38D7Z89b7
         oBjYEjd0R1utXle4APEEJgn96R9OXKTI+UfU6TM4dBTeGY+bbrCMoasMcXDMUgdGf+wK
         KoHhkcxXsbWv6Xkea6tk0r8lCWz/iazQEoJzDzhAhFEuiDEBzb+E0UjjB8Fgol5UCWue
         X5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743094870; x=1743699670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9Om66rj99/DALJuBXsg77rBt0HogaVaFZqpEHuMUIc=;
        b=lA8kYLAjs56qjdXSyA5PCJCUPFa0l9DtPpVdAB0a0njwapPr6MKGTocWcVBtPXI4E0
         oGPk/N3QyGYDknZrAgy5kpHajRT0DpIQ3p2gv0Emue2cV9ObEfbLc5VpfdO7Ca4B2L9L
         QodgPRb4eoAAZW/IbDm31f+N4JjTfkP9MNwampGsLYVc08TlmhJQzvVMW9R0GMGaFUZ8
         +Eij+loJhag92IKoD/lF0wCrLWx0HouzmgWoD3Nl+87cgRJxL19q67zEQd5z8WN7E8CF
         cS9GljSNaTR3bfqILBE7TXod6bY9/K4bnVYhbJEVYoVADGyGZ6QcO0jh0qpL8EwjzmMd
         nRTA==
X-Forwarded-Encrypted: i=1; AJvYcCV5rYxkgCKmZ4/srOvVu6VVZeiFvZs9Ecy1bYlxPFLhmAzfT0LLW7roK7bwCJKs4oKM+Wnz88EzkBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesKQ3WnmcWG9aQegBH1NLTpRzBLlbhA0a1p3pYFYT0A1d66HB
	PylkyXS3MK3r8rhL+GfHFN/uhrZ5oar/cnO4Qb/MD5e/ufJJBwOFi0adqHs4mw==
X-Gm-Gg: ASbGncuCSdYcIUJsXe5JEqs0+M9DC7rmv4yPPFI/Esv3Z8vxHvdSjXPzBeSJubLJ1tD
	W+jdFtiVIim8dioHjVQMWawGYFeWQScV8/2FRG61FwW/6pG+F6LnWNi33NxSQdv+g9a/0zSQtuA
	rbCZizP4cVFl0wqRaoerXPH83gVPY1VnlQrSTXncfgF92MkS1Pm9ObmemqxMx4cm4R+mqCP9f+V
	mKGICzgrz2ZtJflZsE+ubXbhGSbtHuju/UOddVRQ8D2F3yRgia6qg3khUPu8lU1bLO3IXclqkiB
	E/SaWrvwgdLjQlvfMznvP4pvO/M/cQXf/6Fdq9D6h5nPoiECkxO7nG0=
X-Google-Smtp-Source: AGHT+IEVdHVK7JF7u8j+EUGnNoxibuaKXvJexJszG0yV+dnakw5BqGXTpJg0+X0nED7L5VQvd0YN0g==
X-Received: by 2002:a05:6a00:2382:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-73960e0b5f1mr6804772b3a.4.1743094869370;
        Thu, 27 Mar 2025 10:01:09 -0700 (PDT)
Received: from thinkpad ([120.60.71.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109d241sm30123b3a.129.2025.03.27.10.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 10:01:08 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:31:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v6 5/5] MAINTAINERS: Add entry for PCI host controller helpers
Message-ID: <qbqkt53c27zwaetm7faqleqypy7yuxjfdcbukd3vd6t4p3tiwq@jtrk4524wsjr>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-6-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250323164852.430546-6-18255117159@163.com>

On Mon, Mar 24, 2025 at 12:48:52AM +0800, Hans Zhang wrote:
> Add maintenance entry for the newly introduced PCI host controller helper
> functions. These functions provide common infrastructure for capability
> scanning and other shared operations across PCI host controller drivers.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e94bec401e..9b3236704b83 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18119,6 +18119,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
>  F:	drivers/pci/controller/pci-ixp4xx.c
>  
> +PCI DRIVER FOR HELPER FUNCTIONS
> +M:	Hans Zhang <18255117159@163.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/controller/pci-host-helpers.c

I don't see much value in maintaining this file separately as these helpers are
not going to evolve much, thus not needing separate maintenance.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

