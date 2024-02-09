Return-Path: <linux-pci+bounces-3277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCEC84F1CD
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C01C22811
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A6E664B7;
	Fri,  9 Feb 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyxwCu+G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43A664B5
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468978; cv=none; b=IpgnhYowbKJx/XHfI/h3hZv/2IN1/l+NTvNkrxSHTAK3wNhCfilcex76paTQs/zJLx/5TcDqNBkmhi9llzh0VinLPAX0ghVw3RLg7R7OD/pHgFfR/19/IkNZ1n/69g84Otsuyjbzr1dTam9qRArR+8Q9diVEFalvgzOHuvgTQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468978; c=relaxed/simple;
	bh=Tsk3+SWBU2wtfCviD1D0EIgRdEZr+tyO/cWXmkE5rdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU9aoljKQ/UiaT2EL6HDhAJ/4k3u+wtFSblrIE93q18tLPoiaxrTb9zVU4sAqYPUN3Q9pK61ZmU+bxnz0Lo1PzsDsYQum0oQoNb9tJ1cvV9TVVOxueKx3QrAnSJibQHELJ8T2oSTc57YXQdECRIWpE7qEzTGDPTzr8xc8FCaEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YyxwCu+G; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso168689b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Feb 2024 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468976; x=1708073776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3lo5xA9QhcQnRR0TlF3RgqNJRfAbqwqu9OwhqreO4As=;
        b=YyxwCu+GBUaC4A1qvR/zkHQB+N01lCm7KwX6grdgQdUk6ecDmnfEfMbFceuHPQwXq7
         IgmsE/Eu6y3SfSbfPUkXP+Kpm8qWpjjomWu/bS9KyvVffRuCnO4shUFY8CZXLQY1HDzM
         9eMJqOWWv/U9kaoPQO4xNhGQfY03IGan00CXfqD96Nx3NoDz/+zb/WGe1OEENkUBYFA2
         O/8i2gWx7w7L0l4l8bfjL7s0WH4iSZUt1ME4N51GRuMmZVGIh0TP1aCkKEkFSRRfLKEZ
         Yw73erWaAFEhpaaUbfpIy5HgzIFUb7jwsbUTjPPZ+l6IkQar0bB6exUEPYOdM+pq1goJ
         RXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468976; x=1708073776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lo5xA9QhcQnRR0TlF3RgqNJRfAbqwqu9OwhqreO4As=;
        b=Fv2vzfY+qnyvNx7Y6SbarvJumomgPAVQk9w+mPvb9MQ/63SrgC3Rw0DBAY35LgLa9W
         QoDlduq04rFNrAcQOCrtewGjxQyrkHC+D5DdXjNyhRwVPYKj8gl+1Ai/5iB12U7cUgYq
         TOxxV6z5UZv7xIikRnJaWtq7cHxyqGZqDsaQswKfQcOL5kHyuNRghu//Y9ssDUZKY9zt
         gtG34SQMNegGP3/iNBQIX12LonXOj8BHkQKQkm+7gvxc3BAt6F7ui+8WtyMjRPBhjwVH
         FgloweeYsc/1Fu40k4QK1OdNR/DgYYxFZN4t3b1v1Me8g++G5Zf/FVUCXifDus+TwIoS
         qKQg==
X-Gm-Message-State: AOJu0YxLhgHIP8+YK2BT3zuyTdMnQ2mrVCavX8bQuQWy6q1/fQ89kjjd
	HHw9Ur7nNIsws/+2VjSv+5de6oAysNEkPt6QFHGw2zax+tuPsi+uUzV2v1QExA==
X-Google-Smtp-Source: AGHT+IEXsA9uACLUeyN8xPmf8XG/8zUXkMIT0ahSD4Po+zfV0lmB1Kjq8X5WYnzQm7sT8g8xordHFA==
X-Received: by 2002:a05:6a00:92a2:b0:6e0:50cb:5f0a with SMTP id jw34-20020a056a0092a200b006e050cb5f0amr523099pfb.12.1707468975686;
        Fri, 09 Feb 2024 00:56:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJAz69nCCB+96fo5TstLe7LOYwqTtw/dUxesoLLYPclY9CaH4H9q4NKLFKzwHuTTt7xbQGNcVpz+J53U8mdgNPqbAMRL/yv0INmsubL/Ys2DA9uf7Fn0VYHS8TuBoOIEHvGV7062M7CytL6NMHTfBPSf9xn6+ylhrJw8KJDqMZBOAHTn9iU+2QU/Bz9PSn3DF0ySFGTV6G6Kxf2L5JZTDCIQ==
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00199000b006e0427b57e8sm1134443pfl.4.2024.02.09.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:56:15 -0800 (PST)
Date: Fri, 9 Feb 2024 14:26:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Step down as PCI ENDPOINT maintainer
Message-ID: <20240209085611.GG12035@thinkpad>
References: <20240129165933.33428-1-lpieralisi@kernel.org>
 <20240131150116.GA585251@bhelgaas>
 <Zb2RVNkL+AkvqXWq@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zb2RVNkL+AkvqXWq@lizhi-Precision-Tower-5810>

On Fri, Feb 02, 2024 at 08:05:24PM -0500, Frank Li wrote:
> On Wed, Jan 31, 2024 at 09:01:16AM -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 29, 2024 at 05:59:33PM +0100, Lorenzo Pieralisi wrote:
> > > The PCI endpoint subsystem is evolving at a rate I
> > > cannot keep up with, therefore I am standing down as
> > > a maintainer handing over to Manivannan (currently
> > > reviewer for this code) and Krzysztof who are doing
> > > an excellent job on the matter - they don't need my
> > > help any longer.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: Krzysztof Wilczyński <kw@linux.com>
> > 
> > Applied with Mani's ack to for-linus for v6.8, thanks!
> 
> One question:
> 
> who will pick up endpoint patches? 
> 

I will pick them.

- Mani

> Frank
> 
> > 
> > > ---
> > >  MAINTAINERS | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8d1052fa6a69..a40cfcd1c65e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16856,9 +16856,8 @@ F:	Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > >  F:	drivers/pci/controller/pcie-xilinx-cpm.c
> > >  
> > >  PCI ENDPOINT SUBSYSTEM
> > > -M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >  M:	Krzysztof Wilczyński <kw@linux.com>
> > > -R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >  R:	Kishon Vijay Abraham I <kishon@kernel.org>
> > >  L:	linux-pci@vger.kernel.org
> > >  S:	Supported
> > > -- 
> > > 2.34.1
> > > 

-- 
மணிவண்ணன் சதாசிவம்

