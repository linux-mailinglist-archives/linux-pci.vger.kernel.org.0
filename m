Return-Path: <linux-pci+bounces-19894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57545A12478
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7DC166F8B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52912416B0;
	Wed, 15 Jan 2025 13:11:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F82416AD;
	Wed, 15 Jan 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736946660; cv=none; b=P5PrU76MkVWp/3GSTn37AVM4Ua9n6kH07L2/HXKH/NZSHbeUovBfHDMdJjwa4HbE1xACoVAyffYSVJLmNq0V0CVM6cNwTbGByHnJqfjBC0juCcgzCb0dgB9GFM+dh6Pq1DC2PAG2Rv2PrmWKL+CMZ5bJ9xkxpk7duCEssEumPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736946660; c=relaxed/simple;
	bh=QWqJhQoy+yUFqiRBx05ADwVJXzuBzAl6gXFQysAaiVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ9d4eUCAYtXkDmLwxbea7bHGmF8qnrX9XD4vJchc6HEWWm0ZeGWuLyVD0UMRBX3YlGszyVaOuB4emLv86zPanBTufMl7w80lHsUd0YDwI50FGy8CMJD4Av8hU0LzWEz3HvsrdbiJBusO93VwbTb4chzb81DTr2/hhwBawvYnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efb17478adso11009606a91.1;
        Wed, 15 Jan 2025 05:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736946658; x=1737551458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHZuZatq5TIRdfR7unAxNxIsWdF6a/AalKExx0oBH/k=;
        b=ZTJOR+oLC7P8Ou2ua3fJsUiXGmYmvpo39yCQMp4pJS15n+3coYDrL2oQZFyZCgzOcw
         nBlVQze1wPYG6W+k/t1fyEj7dw3stOAWTQxjx3aAgO53LHZ47ZVs9hoWNzXuN1aRvaLp
         icy9phf2cOlPjL35qdg6m5nSQA8jcaab4uJ0eT8cWGFdVm+gKqNlrKq6+nQhi10FDIXM
         c0EZQGNwch3aP4kAkySnMiBx51yj1pEjN0HEPckmo+ziC8HnGmf4jeEXOHIFiVnrwhT0
         ZtRGYuy7mb2IJFzjdXuFAOapmzW3TTdmfAstgfBf7StktMYT7wZ9aaPQhEgz0RrYGTBy
         9VCg==
X-Forwarded-Encrypted: i=1; AJvYcCVvPGjOWLStL6dW4vjc+EwlQOGQuGjsOEUFJ60BFQD+rldV5eAysgoBz9TypuGtqZUWzBU/S4Bvg0T0@vger.kernel.org, AJvYcCXlOE8EeMkmSAy+UW6kiqEI3b8lK9DjLWXST9IJd0oa68/3DfYx1xBx4eBDTQ6N5F/secDtz5PwCBZ3ACQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TPsVeS4c6cZFKHi/K6+ZnQn1fPxqPcs2YuSrQ9CZM0Ui9GsU
	FrLVHMeLeXKJ4i3v6NGcy02cdup6a5BT67y17hobatVxTk4CSI5u
X-Gm-Gg: ASbGncsgIYl1nl8rOhgOi80alcxWYrQdFS5fSM6rhZSdcaBdqnfIyyH6m8BtgKDluqm
	/0D+wkOaC3QN9sADGCBY9QUcdnT4UP35mJeCAqA5VT9I8xPuE0qlYRDYfajpi18hu1YekK7lcnE
	rI9ZoDtIfiFv/9TI8fOB7isj3dBnhiOZAM+5N6qoWoTyW+BRTb1y/LwUnFbW8pocUQe7sig3KBN
	a3/0Y45S27Xzk6P0fDgKdjuIheSXvYt/c0bUrzlTCwReX9MoIID8HYc86Er5AZ0+vJak5HJVTan
	kw/399LZ1+KxZTU=
X-Google-Smtp-Source: AGHT+IFMmgTHpSa0xnjJFaqenc3CT8FqkgozTqAlkATKLjR40Zz3fByV9gWztcPe6gxxEkYY4WKHgw==
X-Received: by 2002:a05:6a00:2388:b0:72a:a7a4:9c6d with SMTP id d2e1a72fcca58-72d21ff97b1mr48634699b3a.24.1736946658384;
        Wed, 15 Jan 2025 05:10:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658a7esm9363767b3a.106.2025.01.15.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:10:57 -0800 (PST)
Date: Wed, 15 Jan 2025 22:10:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org, frank.li@nxp.com,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20250115131055.GU4176564@rocinante>
References: <20241126073909.4058733-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126073909.4058733-1-hongxing.zhu@nxp.com>

Hello,

> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM state before sending
> PME_TURN_OFF message.
> 
> Only print the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't an error message when no endpoint is
> connected at all.

I applied the same patch from the following series:

  https://lore.kernel.org/linux-pci/20241210081557.163555-1-hongxing.zhu@nxp.com

The above one is still a v4.  Hopefully, there is no issue with using the
other series.  However, if you prefer this version here, then do let me
know, so I can mend things directly on the branch itself.

Thank you!

	Krzysztof

