Return-Path: <linux-pci+bounces-12877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7496EABF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 08:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C25B25A0D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154A487A5;
	Fri,  6 Sep 2024 06:34:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCB13D891;
	Fri,  6 Sep 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604493; cv=none; b=slhtmp25Ji8cSVtAvPwZ/Obye8cp53CXHLHrmKVXZWsqIAmXOn3+LO1NSnY1fEcXAZ0wmqHNbQ+B9EcYdsnHKK2alfSKDkYLnpJPWiZs7A+hbKOGzoNNadbYQ8VVkZ9xrz+d7mVG5/y8GLXyBXDpe3o15+23nTgKErQ6Z59H+4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604493; c=relaxed/simple;
	bh=hFeSolhqYvBgWPSEgfmOR2vXwOoJmXvzpoMkzmnragw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=no6hrk5dkCMtBcHedxvNnbBXN8Wrrl17yiraQnT9cfpj3yeirBe5gTiEQNHYmKbRB5MWTqdNIaKfm/kS6x7g7pqJOrQB04g66MpqkziycfQzNY1VmU39MdmEfhmZ5Q4YH7AgYTNQD9t3UTT+EPYLRZPsTlRsIjp3zBs8pa3ct3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2057c6c57b5so9319395ad.1;
        Thu, 05 Sep 2024 23:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725604491; x=1726209291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6H913xAzBM+CNxyEDfRfaCkUDAqYWp0ETBc7vLqc0Ys=;
        b=bd7pF0vuJDQPDzWD17/8Fq+7QsVZWWJLoefOvhF5cZm6NZJ1jtg/B/ZaVH3AzLA5lf
         lPjTFEnq583BitidqdyXPL0JHUOkFbLN4aAkJ21ksLgXza1afanpPZKxaIoqjkptKWUH
         t+M5YN/6377dYsTIcT7Fif2kKfSAkYsg3uEaBb6rBRrARoUwTovSP0/BlhIVGblE0gl5
         nvhtPYYHiQAEVuoYHqau9RxtSee7pJ1VmGgCRPqXiboIlfYuMgfIfNEDH8gGn625gBnP
         7MSocC+t/9WZjVgzdrFNir1OBlztVR07OB/xWWSYKst6NzzUQtZV2Y350jYB/rD9K75V
         6ASA==
X-Forwarded-Encrypted: i=1; AJvYcCWoN7jrAacmjSz+mZ6p0UyRGBKiwDUs4XDSY+sps2PxADyZJ8w8hQNtnJX7mVnlbhcc9yaiqmR50zHl@vger.kernel.org, AJvYcCXShlEgQbmU8XlVhQ8+HN5QaOMyTaALdOUKnKnoJUU6qay37/FPfGekbpakD7/wvipPLg8bDHFPM2x3hFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLbVATIrh5eiKJHgYV03H+zNYoOXr41cNJCVsyiMWuz7bBRwm
	3wY2pgMoD98h8whvuLTMdZdo//IoqMvfnk0x0R4hXWFPyIki8qt+
X-Google-Smtp-Source: AGHT+IHfo+5JJdPUAbYTqAmwvJgTiUZfGmCFr9rP3882IDzODMD5B1+c4Fe+E+38DxXNrGD5Aue9Hw==
X-Received: by 2002:a17:903:283:b0:205:656d:5f46 with SMTP id d9443c01a7336-206b8461b10mr141112235ad.28.1725604491501;
        Thu, 05 Sep 2024 23:34:51 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbda77d5sm4355711a12.71.2024.09.05.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 23:34:50 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:34:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera: Replace TLP_REQ_ID() with macro
 PCI_DEVID()
Message-ID: <20240906063449.GB679795@rocinante>
References: <20240828104202.3683491-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828104202.3683491-1-ruanjinjie@huawei.com>

Hello,

> The TLP_REQ_ID's function is same as current PCI_DEVID()
> macro, replace it.

Applied to controller/altera, thank you!

[1/1] PCI: altera: Replace TLP_REQ_ID() with macro PCI_DEVID()"
      https://git.kernel.org/pci/pci/c/8745aaab60a6

	Krzysztof

