Return-Path: <linux-pci+bounces-9779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D752927050
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 09:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AC7B22BA4
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 07:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E601849C6;
	Thu,  4 Jul 2024 07:14:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703113E024;
	Thu,  4 Jul 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077250; cv=none; b=gWe2HtBu8InO/PIdKGH8db2sP6zN8OCEG50BagLLIQWDbOJP26yK4Foby3TBD1FVDDpC45hJomeDdN79M+Ay/KodgRHAI8ac1enJX4eqzr2JuWFhdfA7uwsFnBeUl4WT1Pq99aB86X/pChPJuiboZQEYvZxsqxYhSXZR/f2Of+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077250; c=relaxed/simple;
	bh=tj9yNwlUIOcUFugv9LXKvCjof10V014dJ1Bv2oFdMOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE703y3UuzPER7aDafoisnMxxMDqE9Cidduh3IobBTflI+LpSYEu7pM/Agf+jKfpEciWUsDJPdQktnJ3DJshZR4dpbyxkE2RsKVMjm9E6j7O0/7R772mwgJRrCc7jqVjVzKW22jdx+oxUKKyKylBkBOLN0kQYKpcbIMoRdfHnFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-713fa1aea36so98365a12.1;
        Thu, 04 Jul 2024 00:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720077249; x=1720682049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H74/f8x03FUG3BDt391zaig/HBmXDzV+z27vo8M+/2k=;
        b=LadX0eKU5+AJ7raeSJzSQjGK+mpJ1IN8eNkPmG+TXfI2fZOnuHWa/wRANhgp7EfA9b
         SNpqfGKb5Ia3eKIRBLgqQBGX+PlcnoPJLwRn1IPxi8LcHlrTXaA2utpw4rXfrgMroRDa
         B3wqoA1ycjpTAWiK0gLSz23QZx0AOO1Vg5/skEjxwLvujAoa8C5iFbPGw+Dbya+FUar2
         79NnhCgqI9PUoGooRc/mjM1rEMhh5kvbaR6EbOE0iTH0exn2ldD/UcleEmSYbislT59C
         YrC6rL2qcfHwASHfVnlEe1sCtKoFcfBCEoNoM2gvyPysEUHLn4iy9+VU6CPv1b/N3HfD
         /HOA==
X-Forwarded-Encrypted: i=1; AJvYcCVqcOl90hCFZu7BRiWp0B28JT/aB8/jG7joFWdag04Zx1qnxBZCAsE14MtIvLlzw1e4T27mC+fNEcx2t8MiMkobOk7DMipWyGuh0Z8t7C/l0A+JNMLUU0MrQw0FojaPaOWPew+nPSmQ
X-Gm-Message-State: AOJu0YzLGI8ETJOOcjnXsxAN5cL3xTM7v3ePvkUcxuVGFbiK0scQll5L
	bs8xs3lIcbiAGQCz9HH7q1FJwz5u8ImcVYCt6tQQcyfYNf8ngSg0
X-Google-Smtp-Source: AGHT+IE1qiGN1ScEWjOCXA9MaFnDN6kocxyeCLRtgfWaGTfcne56Ja13NPR8zln6aWuqLklQjEy5IA==
X-Received: by 2002:a05:6a20:7346:b0:1bd:2485:b83c with SMTP id adf61e73a8af0-1c0cc74aa44mr679071637.21.1720077248539;
        Thu, 04 Jul 2024 00:14:08 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa90ab4sm737795a91.52.2024.07.04.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 00:14:08 -0700 (PDT)
Date: Thu, 4 Jul 2024 16:14:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused
 functions
Message-ID: <20240704071406.GA2735079@rocinante>
References: <20240704023227.87039-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704023227.87039-1-jiapeng.chong@linux.alibaba.com>

Hello,

> These functions are defined in the pci_endpoint_test.c file, but not
> called elsewhere, so delete these unused functions.
> 
> drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.

Have you see my question to the first version of this patch?

	Krzysztof

