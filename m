Return-Path: <linux-pci+bounces-14874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB32D9A4247
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 17:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67151281002
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED11F4281;
	Fri, 18 Oct 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32MOLCHX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD042746B
	for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265169; cv=none; b=Fskzp2fjcQ+87bn9DwvjVORFZCazBXJ4PJd6fkgSE4k6dqmCwOfntlbF3Olxpjql36cpC2n3Q+Pqh10zYrOE0gA0z48GVfo7hv9zXEezkbKp7gMWPRQXpTPnvSu78JuKg+OUY2iBFfwctoxfXuQ17LA+zSo3HpVByYXn0meHOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265169; c=relaxed/simple;
	bh=3QP4a75kZ4fYaEQ/0l58XBJb75QUbQHHV/dUBhfyyoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8ekQJAIrMVwJ9ob8mGI96f//mwY/imYE8MEae6NU0Zgdx7jzJ8iut6Smn4k0zrTXQPCvu8JzTtPg8Gr9+4sJCnyw3o0LYwgvO9W6VASNJ1t/fb1PnaX4ingJH3/85CBmQVKYdujgNl8ZdJ2SxRrpl7EcF7gBFrP2Stt3y3rmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32MOLCHX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e6cec7227so1805764b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729265167; x=1729869967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QP4a75kZ4fYaEQ/0l58XBJb75QUbQHHV/dUBhfyyoc=;
        b=32MOLCHXLuosSY+dhkIUHXELqReY+bU4sZnwTp+LzmSYdbLx98LmHvXfn4kpCErAof
         4q6CNNo/CFdsQYFrDsp5kaOcTLPMuKR7vkCqEHDob+IBzm0AZD/R8qFYEUywSWztsAUC
         o9TNIe+1XIpYojRwis1mwQTY1Ym3Zvsv8BNHp6Mamgg1FWBwrHvkOEzNUU15oOqkkZGE
         tEcL/XETf2ps1HdgXr+yUEMhuAbxtu9c6DtxZYKco3mQgKIW1tiaLQpg3V0ITEJkDy1b
         YnAIA2RHQ3m890Ymyd3jJn80C/N4ekcg0cjpxhluMF9JEyOg5jpkI/W8dF6eX7mFuJeJ
         vqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265167; x=1729869967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QP4a75kZ4fYaEQ/0l58XBJb75QUbQHHV/dUBhfyyoc=;
        b=MGHWrJVpxM8HTELQ2kJy4lbWrRzRz4EEkCVNs2NpgjaIywwMVOTtSjWIRFvGOtFyRQ
         9X53n8aj6bIchIa7l+HzengEs5wufmh8YlSCAW1As88/LRwV1v0tJe8glyoJyTN2yBOB
         apePV0URq0JuAoip/+vTuwsGXwZQKBfj4H9ckul6rfbSg49IjEGpI4LWq+XhmAhYpRPj
         CILJ0fqVWWHTtHmPCk/+O6XLnzdujVjOBfidn08rOjChX42kr3K9hZ5e2bNqeBtJSyTU
         LsnfuowtIikWnNo7zL1TlQCdsC6B6BnSJtwVA7evCSB1Bzvf3ITBTZhJh3Y642STDlha
         BW4w==
X-Gm-Message-State: AOJu0Yzn9x4WxeDmpOf1xqSUPJHxlMS6JP1s0cOB+rPJsrStOLTmodsi
	dF/p31gI6bygol135ll2eiBEQcC73T5SGmtu+B4cUm9Suwrc2Z1fQxPi5+Q4JA==
X-Google-Smtp-Source: AGHT+IHNfuZEK527IxaZoc5KGcW0lrzlMBKMfzodLQ8gp8Wb9f1XKtzlldt3Zh+zarsvs+z05M6BaA==
X-Received: by 2002:a05:6a00:2ea4:b0:71e:6122:5912 with SMTP id d2e1a72fcca58-71ea313fc01mr4071763b3a.10.1729265166448;
        Fri, 18 Oct 2024 08:26:06 -0700 (PDT)
Received: from google.com (98.81.87.34.bc.googleusercontent.com. [34.87.81.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3312035sm1624943b3a.17.2024.10.18.08.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:26:06 -0700 (PDT)
Date: Fri, 18 Oct 2024 20:55:57 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <ZxJ-BXCuKpp8mqCh@google.com>
References: <20241007032917.872262-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007032917.872262-1-ajayagarwal@google.com>

A gentle reminder for review.

