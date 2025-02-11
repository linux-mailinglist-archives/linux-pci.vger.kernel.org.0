Return-Path: <linux-pci+bounces-21144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F97A304FB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 08:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7A77A05F4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E41D5178;
	Tue, 11 Feb 2025 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tG22peeL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05B41EE017
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260623; cv=none; b=MY3yWHgdtH3ukXVGw2gnHP0ugARtxUcFAmTrQZPZn0+fE7HGzHNaJij5g0LW5cjoOXnaJyiHi2VZkrdS5dCaJ5MUUzZaPBC0cx9NEwaXcLuC3Dci2qYFNferEbgzn+tUgMMDClLxIkaSr3KhENjzUtg+rhN9I5pXclywtpLJt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260623; c=relaxed/simple;
	bh=LPHXYTKv2FXtI9uRbobiagdTnkUoyv995uInBQLR3VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlFOc2ztGynRjPhzcr9YeEwQGY2wY4lqr5WDDe0I59uZ2r3mXjpvwqOpKvWbwZJsSkL1e6nlzipX5D8WhBom8B7Y9UeHW20m8oOnaZ0a9oy7gn8DBxrie0hUbFLjcLf1nS82OQFLCYr/hdeesPULHOUjG7275bNOtKs8gFX3Lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tG22peeL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f44e7eae4so85526165ad.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 23:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739260621; x=1739865421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hknP+sL6YosA4WrUY/AIGIujFV5L86o/UxguNR/EyII=;
        b=tG22peeLslb5C+ZUHD+oNov/fTowuslGGYDtdgpWRqs8k53ARe1H5wAZxC+6L+hipt
         v++KGJRateeXdS+GCaBnwVVM48+NDvoPhRYgEuNfFwYTfh4DxdX65w8ZISbDy+RwPqrQ
         oafiOFB3V6pqQ9RFv/EfYHfrg1LN3AcefVM/N0jApLzV1BFgV5/DynSWdIoNvL0IX+x0
         9JBWlNWBJdFled4TRyDMNEbmvanz2hqER5Ndx2oFncK7I8KxKVxPdN7WdpEsTeC9bq+T
         wPdPmu+k7kWO0LA+kUfJnZa2HqPVsCMWMc1D190Hl+yqB/2nWV18QZiIayCVbsrGWbFP
         GGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260621; x=1739865421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hknP+sL6YosA4WrUY/AIGIujFV5L86o/UxguNR/EyII=;
        b=GLtvh5TrPTOkHvtPV7UtSKrnzI5O/3OIWf0ES6ykeY17waZRBLQwbjJtp7rkoynmeo
         VKAmi4qUzABOW8HiFk70Z0N3ONcSzf5zYNKN2pJI1/cUHQ8SMsZUUTNqGQETIOY0I061
         4vPriwIVL/K/9Pst1hlyYAoFlFTVBFCxXZlAHAKXh/soZ4B7FfSFNLUVz6HGuAkTir8Y
         EmeCV1Rs6pXI7bHyFfjl4t1n3EgIJDV9cFBHznEcbSXV4UY15IMkxXcZkvTfCRWBVGiT
         9tf0j2iD4bo1qcbiiGqJht+JSMrmt785KNq+iZKE3Dy5QHqvK9ouOiIFeabhWoD+27pd
         FZAw==
X-Forwarded-Encrypted: i=1; AJvYcCXZnv4/XCPeXLxS9FuRlKM9MeaHXv8fiRjW4A94PHYXuLEw1KKlo6XM43LrWSbnX3CWgXwdxpa5Re4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyA6WEtatL4iTNBb7XjFiF5RQdtv+jmew9zlm8S7u7NWs5rEu
	3qHJVsMxRund+BHarQ4AGyC86kj3hW599aydGkVozdloeRnF1XwosViC4rTOAQ==
X-Gm-Gg: ASbGncvxlMiY5hk3Ti4VCs6pCowJRemDCzIL4WZOhGr+PNUJ7RzBYhLV2ZSOEmnnvsE
	58yBUqoYPSSzXbLyxDlt1tBfEYJFcgwrPtLe3RI9yoL3c6Qd02h6A+fzjGBoILh6y0RF8Be+BdN
	XyzW9RqoSX/UVaPeyFq+QIpmeNvzeb1OR6c0FL0wb3cKTumDn2IZOnAkVYN8l375TiosDipsJHA
	hiqO1YNhie86MyGNlTygW+EbE4Y8rRG7pFygOEjJKco1S55WJ/gKjT0FfGitj99v5yohXbu6dnw
	GKom87LvbMl8plS09r3bZ17V6g==
X-Google-Smtp-Source: AGHT+IFK60fImKcu8KHWFzd+l5HoW1YkVhklIWoQZG/RRiDeEw4PlbcJBO+x2yxfQTu3F6kyiZedkQ==
X-Received: by 2002:a05:6a00:21cb:b0:732:2269:a15c with SMTP id d2e1a72fcca58-7322269a4c7mr922940b3a.20.1739260620917;
        Mon, 10 Feb 2025 23:57:00 -0800 (PST)
Received: from thinkpad ([36.255.17.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf19f6sm8594074b3a.110.2025.02.10.23.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 23:57:00 -0800 (PST)
Date: Tue, 11 Feb 2025 13:26:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Tsai Sung-Fu <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250211075654.zxjownqe5guwzdlf@thinkpad>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>

On Tue, Feb 11, 2025 at 03:16:11PM +0800, Tsai Sung-Fu wrote:
> Hi Mani and Bjorn,
> 
> Sorry for the late reply, we just found out some problems in the patch
> we are trying to upstream here, and figuring out it might not be a
> good idea to keep this process going, so I would drop this patch
> submission, and come back once we figure it out a better way.
> 
> BTW, May I ask why upstream chose to flag this driver with
> MSI_FLAG_NO_AFFINITY and remove the function dw_pci_msi_set_affinity
> implementation ?
> 

Because you cannot set affinity for chained MSIs as these MSIs are muxed to
another parent interrupt. Since the IRQ affinity is all about changing which CPU
gets the IRQ, affinity setting is only possible for the MSI parent.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

