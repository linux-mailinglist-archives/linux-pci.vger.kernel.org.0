Return-Path: <linux-pci+bounces-7591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308EC8C846B
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611E11C224D5
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57FE2C85D;
	Fri, 17 May 2024 10:03:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6272BD0D
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940227; cv=none; b=V+gAEFIjQLDO36EKkVKxVU6k6YYbsUYxiKMAC8ZTe02dbDiRZ3HBdJth7Tt16+5IUQKUaSURM7QMGhZlrOa6Ijc4aHUY1lkfNmcpzpDfvBCg9rrz2xv/LBjkN5iHt4K4ZTaR8NZPiYzGNLUPPTf7VXHwzhNy4XLogtVmN/7/Ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940227; c=relaxed/simple;
	bh=KTvHkD4t7m7AeWaw3jJ8wF+rE0nZ8h8GT4S/NuIQso0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4xQuVaqQoH1f3DHkHsrzAWLWKa/ryGZKLwpCEaY6BzWzoX4s4Cibw9EOiNwr3oi/WXm1sfh5avXeAjylsGAHhFLASS5D/HeFp7SpygSa8aFIjlpxIsMmDneqEKaG4jq9DagjjXUivQrbE2paXMgmTl9L5jQFlP3gjJ2OmSsS3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f6911d16b4so584551b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 03:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715940225; x=1716545025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwJnP0jzgbtYCYE/TGqvXm+jWtQ0BeP318A4PrkoVEo=;
        b=GqHbcFXmMt9oP92Vk6GvXXOkQT6XbDGybIAD/F4CbstC1ivu6/1vqPu3WxeEtaABRk
         m+JolOLX/yUeTFrtoPQ2b11Hva42GAsXMiF9mCOkFWouUXQ4eHE53V/JstiHRBpnmLYF
         BKjzOo7cKSwc7ebQIgomMaif7RBZGQSyXvvZXGNZIyp+mBZMEvZb+pPj4C3HdNrwc8Hi
         hx6smtB05mUiXZx/pzAAi+L5vQxYPjGPZ5LQiE11yPH854NLId50FKFBgQ85F2ttu40U
         xdyq+GtVBiO92zDniTTvMj5OIe7mw50VsTvklNXBlxPfonkHJj/HxahSjbxzKrADUwYH
         QdCg==
X-Forwarded-Encrypted: i=1; AJvYcCVeCKQ2RA+TwejDs52OwOugJ6yz3SEybTwtXXv56nJXeCHpb/jfbLvsOCcHtKlybjU4KP4VJ7LP0mtZxDvoZ9fvyR64JTQH0k4B
X-Gm-Message-State: AOJu0YzbezkV8DTOtWAe6ofxCDgT1fjBOAqfbjwWhAmWurKzrBxr6vGA
	zhFdz08JwjNeRZiNYyPriLXcKRkzr9zI/vaYz9Jrohak2WD1reix
X-Google-Smtp-Source: AGHT+IFEnocnIxpqMKzPKfYWajwvbdGfdO0iddkAZ29hJ3xisxn+ehmDKHZLmk1oxDsoXb4bJU4PjA==
X-Received: by 2002:a05:6a20:431a:b0:1af:6911:ddf3 with SMTP id adf61e73a8af0-1afde0af0bbmr24122517637.7.1715940225424;
        Fri, 17 May 2024 03:03:45 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f676723725sm4657372b3a.78.2024.05.17.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:03:44 -0700 (PDT)
Date: Fri, 17 May 2024 19:03:42 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: manivannan.sadhasivam@linaro.org, imx@lists.linux.dev, arnd@arndb.de,
	cassel@kernel.org, gregkh@linuxfoundation.org, kishon@kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/1] misc: pci_endpoint_test: Refactor
 dma_set_mask_and_coherent() logic
Message-ID: <20240517100342.GA202520@rocinante>
References: <20240502195903.3191049-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502195903.3191049-1-Frank.Li@nxp.com>

Hello,

> dma_set_mask_and_coherent() should never fail when the mask is >= 32bit,
> unless the architecture has no DMA support. So no need check for the error
> and also no need to set dma_set_mask_and_coherent(32) as a fallback.
> 
> Even if dma_set_mask_and_coherent(48) fails due to the lack of DMA support
> (theoretically), then dma_set_mask_and_coherent(32) will also fail for the
> same reason. So the fallback doesn't make sense.
> 
> Due to the above reasons, let's simplify the code by setting the streaming
> and coherent DMA mask to 48 bits.

Applied to misc, thank you!

[1/1] misc: pci_endpoint_test: Refactor dma_set_mask_and_coherent() logic
      https://git.kernel.org/pci/pci/c/27ea748a3abd

	Krzysztof

