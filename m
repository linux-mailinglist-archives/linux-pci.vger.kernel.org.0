Return-Path: <linux-pci+bounces-28412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9A2AC42C2
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125B73A57C6
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA51E48A;
	Mon, 26 May 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jffqJnH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A933594A
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748275453; cv=none; b=HAhLFupn844K9LHMrKOSrZVzgyXqKyTvdnvspKRnlzEjH6gZ3B2vKJNyNvN1s6fIknrt3YeE0DzyCOrdMWPFLFa0g8Jboo7fIJFETH9FvBwqs6CUQsPg5xsOGWsnjE9tuG3yzVGHPE2HYn5Mqnmc/l1VIjVcmW+cgacNWQcbDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748275453; c=relaxed/simple;
	bh=q4UffFyDswm8nMzHDFCTY7t6jCR0+naYSV5NUMtPht8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+f0G7McinWIjUIg3tTpRzbLqgcpQ1IoujKF8vaxpEPEJ/DRaZRw9I0TqyzioyzcahY5mmVuusjkZ6Sn8yk5xFUDS1J6JnoGn1itH7VUoa4EnqBcDc9mWlXckrYMU8u4tucQ76XvSz0i16Cb1zDMb7H32OeJhmHmXXbU7N66sDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jffqJnH; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74019695377so1465417b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748275451; x=1748880251; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TkO0Al1qkogxtsptnkzwoi/d2g3/Fd1fNDxMLZ5tpBM=;
        b=3jffqJnHu3AvLdW95nyISd3PHQwV7GeGfUtr9Gl0A2q96SspEQkzVOTLZp/8gA4vlr
         +3or1Sg5MeoO4tkxzgGrxjaydn5RxEiJCt+2dahNPfm8L9sVn9NBdBvcA2w6K24qQSOM
         bsU5os9j3wP2fcy04tl4Wo+u3lvlbDwwidYoGeLaeuBlmNjYwENCO1nis5ZRI7B0kCH3
         LHtraje4EjhyWuz8MEpnG6b9BqT5L5kWNJTp1FRd+0wnfBVhCxeNRdYjNHRFESv880ci
         RYz5slzCDdj/gw/5viF86TLmkfT1Me11YCRWb3kEIUl5QElynDnB+romZtQo27wWxv81
         u6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748275451; x=1748880251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TkO0Al1qkogxtsptnkzwoi/d2g3/Fd1fNDxMLZ5tpBM=;
        b=Rz325OsPIb7LzD+laQJtGULbglkfYk7a1obXP0+xhDK3rzVHghi3kLSdgLQl0ehyh3
         0sIEaHA/7XgqykGrlwqTGhJr6iuRcHvZVWHW0AXyjaJdtByzlTQYtonD6YWZGGoJTy2C
         WZ2H9M27VqwpQsT+h2TzthpYrNamdh1CIP7K0oCQ/oNYn1D1z2QlBpja/QqRvi2s7xR9
         xp2XsrmOlYbA04eT5L4/b1v9YvPlpkVrvsdSlxmKKvJq6FJ6fYTvf6t6MN/U42FcDXJF
         BAMBbu0oIcpAWCyflYt0US8iWPnKDMsvs2GAw6RHWdJUiy39wA57QBbXVzk0IqTuRy+f
         OQzA==
X-Forwarded-Encrypted: i=1; AJvYcCVhNzf6K8N9B7muqw3UEmQwF+9H2s5fKC3W50R/wAKzJrxqSTaO0llsZ/mfOQ2NTbneEV/oeGgCi6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRaxAOssq573qz9X0ziD1GWruKf0BLvy0C6qAZnGzXJQN0nrkc
	YRhXWX5JdO23xRetcvrMW7V6h5Wr4o6K9cMLS+qNYamWYUuru+WYeE94knzdWfmLJg==
X-Gm-Gg: ASbGncvwZPVgAFuR31kpk/Y9/uFGwfnokwp0YzEiJYln96DL1vskExrjm91/VPp0shl
	TDvSR8mPO1L/xPqIFvWi/nMmy6b80dhz6GlvmRdYDa5aqsFxlNoDs+xanDicSKpDMPisPeii+dZ
	O69vwt19KUeoEVgEk4kyZSLK6BQ5cChIdGiZCQDSdDH1OT1RwP+sRKdZRsMiXb/FaVknzwslRbM
	LC0p62ATh028JMqwHOWA5Ff3UdVOhsPV8wdoXjZ6TQp9mz4QXUzgF/k6Pf/qQ2B/yAve0Ttn6W+
	Kg42NC3hoJnRMUo1iPKVKs3nNEcb7L9J5Ep1037QOX3sA8xUpjdeUTW2rvCTGcPfR+he3scQ4Gc
	rwW/tErSfuBKxuRgRTvESuEuCqC4Zow==
X-Google-Smtp-Source: AGHT+IHlek8zylvWet1iDp9a9eAHjVC/8ezfzMlqkk0r3BP8Db/tZ9PzSYr9wCuQ6CzjhEoXww//aA==
X-Received: by 2002:a05:6a00:4646:b0:742:ae7e:7da8 with SMTP id d2e1a72fcca58-745fdfcc5e9mr13997882b3a.8.1748275451195;
        Mon, 26 May 2025 09:04:11 -0700 (PDT)
Received: from google.com (243.106.81.34.bc.googleusercontent.com. [34.81.106.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a987150bsm17745308b3a.136.2025.05.26.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 09:04:10 -0700 (PDT)
Date: Mon, 26 May 2025 16:04:04 +0000
From: Samiksha Garg <samikshagarg@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, ajayagarwal@google.com, maurora@google.com,
	linux-pci@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
Message-ID: <aDSQ9EuzlHiv6HTH@google.com>
References: <20250526104241.1676625-1-samikshagarg@google.com>
 <bddr5afnyppbtpajk3wsymwnxrdvyyradxwqf2kkiahwat63av@h2kttx5blizv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bddr5afnyppbtpajk3wsymwnxrdvyyradxwqf2kkiahwat63av@h2kttx5blizv>

Hi Mani,
Thanks for your response. I can see that pci-keystone driver already calls this function.
Does it not mean that there is already an upstream user?

Thanks,
Samiksha

On Mon, May 26, 2025 at 04:50:11PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 26, 2025 at 10:42:40AM +0000, Samiksha Garg wrote:
> > Some vendor drivers need to write their own `msi_init` while
> > still utilizing `dw_pcie_allocate_domains` method to allocate
> > IRQ domains. Export the function for this purpose.
> > 
> 
> NAK. Symbols should have atleast one upstream user to be exported. We do not
> export symbols for random vendor drivers, sorry.
> 
> - Mani
> 
> > Signed-off-by: Samiksha Garg <samikshagarg@google.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index ecc33f6789e3..5b949547f917 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -249,6 +249,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
> >  
> >  static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
> >  {
> > -- 
> > 2.49.0.1151.ga128411c76-goog
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

