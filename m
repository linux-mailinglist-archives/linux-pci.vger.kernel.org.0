Return-Path: <linux-pci+bounces-27866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1642CAB9DEF
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156581C02055
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42030249EB;
	Fri, 16 May 2025 13:48:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6C282E1;
	Fri, 16 May 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403324; cv=none; b=q4L+EakTWfj6U/CnY0v2bXCILs1o7YeVkB0NP7KkdQMvo8sYYbZh82JN6kG139WZWhAnTNoTfVp/+ZPpbt0v+gpT/YHvsOySVjxTZQSItc2z1ldtn9Pn512DC0tc6HHz15hZ+qFP15ZLJi8tfXCYyfPaPz3arjiKQhrLiNrmQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403324; c=relaxed/simple;
	bh=1seJfpztGifwrs2PlCOfDt1rbHiWcewWmKq+VA0FAF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKhTqY9c1GNVO7WjRwBUKJZwkdURHiJElnoemK/su1epW+HaX5aVBV04rOmZ9waQkkfdZDNRsjXo8FA/tGQHNUm2uWWi/d77FZr5RHnCW4KQyjHD55tlxvY5YYO65U0y+Ehnvu5nra5Drg4yfmcMoIyfHNM9lJNKH5zi1DHom2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2317d94c9cdso19891565ad.2;
        Fri, 16 May 2025 06:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747403322; x=1748008122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GhLr0/qCcOcwsG1cKw2ZSqLBQlNdIjNVQR+oDfOQeX8=;
        b=dnXl3YDC2Y/7auj+H36TRvjtZFVhRkrZOeQH/AKedb3exq+XfaKzBE9hRrIVpgZx97
         1HdLmikBqkmbnE+qa1NOPQvr0zUWBMLUyF26a9V5yRLKLqLDe8wTb8N/Og/wWxXu1GEC
         Dwy5AGNr5DL68lDaYJpTGIY5huw+MUQ6XuRFGYn/GbDnAo0Jtr2MFH/xjmjxb2uYtGGT
         j6L6u/oflUM72m2jFFf0djS3qA7SQLCdEwpSfzO3e0spnLLBWqoF7iV1z98aeVOUi6PL
         /SDSZ/QnmxmwWygtRwC5rvWgwrA2LxnQuVwNdxpqVc0F9JpvZRPqPooKmmpdwkWFdXxa
         JQ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUC9dPdMBQxIIeL/7bjPyS9wpTHFVqfkFHhsJxJN/2JvOQb9G98YY2Ol+ZtRhHqV7xhaY8QVBb1j/wlpaKI@vger.kernel.org, AJvYcCUrllLYHDNUKqZK24+WfJTrWfXvkPNlHpWQ++RSyXeWULwsEk5ybftEbxPZZagZ5P1Sw6uQImidgvQ=@vger.kernel.org, AJvYcCWMdHu/uNFxvSAErvDcwBPmY0vG9XseVoFj2Vx+C08hdyB/a9sIV1fX0wHwF+uX8KK2nk0CYbfX+EEV@vger.kernel.org
X-Gm-Message-State: AOJu0YycJGofgvG/SDMql92fqofnsE2F/jKzmZPFJ5gOqlUQy9CxjhGV
	DIVORAxwKMJraBEIyTh8Fco6ebaIaSZotT+lR+KBLXIlZJDBk/38VxCm6cXtCfcE5g9aSw==
X-Gm-Gg: ASbGncvvJNLxefEYVppf7kT61OBFY4v4QSjNPOk/bXJdDtEUxje8MSJ2l6Axoi0mphv
	HOC8Fdzf1kldYPJZlcCdKAc0mzXlTesIJH3adK2x8KoLlIyTOxloBl5CsYMgKkeP1XRv0fwOCbA
	d1Sgmtu1ek2KuApinL0WOUs4qDP6C4keYG0ytCjtDQ7hqtKBBUyFJK1kNZu9R43A5UY6t7G/a0b
	we6Tp9GT5aeR3R8sPiz1iUySCElg2Ts2z2XgAmFHmBcUttUxyGhguHyybhKs2QUznvVROAFBjwn
	abRFTfjMschcIOgj0cL6dHn+yHwmOvSCthF+BAXs44whH6FrYVHXYC9D00vKBD4xK/y0Xf5W15T
	UPDAxU26lWg==
X-Google-Smtp-Source: AGHT+IEYfD34EnL3n4BF8sR+tYcouluejWmfRuBRsuFM5XUnqVVI85uppxwbmnFyye5xoQ1triIUXQ==
X-Received: by 2002:a17:903:2ecd:b0:22c:2492:b96b with SMTP id d9443c01a7336-231d44e642amr45764445ad.15.1747403321674;
        Fri, 16 May 2025 06:48:41 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4e97537sm14316725ad.115.2025.05.16.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:48:41 -0700 (PDT)
Date: Fri, 16 May 2025 22:48:39 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: phasta@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
Message-ID: <20250516134839.GA3308019@rocinante>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-4-phasta@kernel.org>
 <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
 <e44d880e842440d51c14f38df1d20176694e0d57.camel@mailbox.org>
 <20250516132811.GB2390647@rocinante>
 <2e80298be4bcb6b17f5b38302d6945306928c6b0.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e80298be4bcb6b17f5b38302d6945306928c6b0.camel@mailbox.org>

Hello,

[...]
> > > > Is the "Docu" prefix in thew Subject aligned with the git history
> > > > of this file?
> > > > 
> > > 
> > > Seems its "Documentation: ". Can fix.
> > 
> > Has Andy been sending his review off-list?  Or something is broken on
> > my side...
> 
> Nope, it's on-list. Andy's a veteran ;-)
> 
> https://lore.kernel.org/linux-pci/aCXnPHy5heHCKVd_@smile.fi.intel.com/

Thank you!

I should have checked on lore, too.  Time to move to lei, I suppose...

> > Philipp, if you have a v2 ready, then I would love to pull it, while we
> > await for more reviews, just to get enough soak time and allow for the
> > 0-day and KernelCI to run their usual tests, etc.
> > 
> > Thank you!
> 
> I don't have it ready, but should be trivial to do, since it's not
> fundamental critcism. I'll do my best.

I would be much obliged.

Thank you!

	Krzysztof

