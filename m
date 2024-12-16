Return-Path: <linux-pci+bounces-18533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F539F37B8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 18:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87781161CE9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B22063D1;
	Mon, 16 Dec 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qD98ZbA/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDC7205E31
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370793; cv=none; b=Ve6aNwZh55UxYYhm+kCIeYSjczHPBfqC+N9V33//E8sK4meCnel7zhea/iDQJuMF16z7fugTd7+pFmchdKhwr51f16ymyKCXhsWoP6aLnzfoZIULCXjUSK+Kcc0HmRvJahL3VF1/lGpe2H1QJYvVLmViW7X9pjmi9k39JcpSvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370793; c=relaxed/simple;
	bh=sZagQfOkP/6cpyqYRongDqTCVNDMffmQq9AdjQIl0Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQTjvougKIxDScgukrYSMkGifDWl50UCIZwrSpMumpu0KUtEKsbx1NJCfRg+ym+zdnDYB4VoAOBaWcelKNKtVVAfCGBH/rpAdIPXZnKgUcf4HGkQcNpen7liAG3GiCvX+8qPnpLMtZF9TU3N9/7/fLocR7bN1h1AUSsSInEhJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qD98ZbA/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21619108a6bso32815895ad.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734370791; x=1734975591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=;
        b=qD98ZbA/6vu+pKV6qNjIZVvVVZzrTIk4lryK+JWKBQ3uiuJC95OesT6yunc1FqT1uh
         VvJ8aiTCJFNpfS7KKR0iFPNQ5H/t9cJDin4VZb9jYpatL7K7cRSDSZU9UGVC7fAeTSHv
         lL61WMTevIlvsNJ8rpl8shczhZWO6CokUaPH8xLIrXbi0vpkSyJZbzvLt7TP2Ihvv46m
         p9su6kYaEtVJlvycwkY8LeDfpQ0amuKgavcGOR0NMh2C8zy5Dw1KKl/KRBLMOUuJAQEI
         x8sXmA5O50YKSl5h8hBw4Sxa6tsU5hKJwFF8Qm61eEf1T0qzGYY22eCt90WhHo8IJ5gW
         wPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370791; x=1734975591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtZZYgUYoOwyubJGQdNNWpZEzlkbDlyszV0/xNC2FM0=;
        b=ep6fRE/EAp4KaFhDedi3WL8fp1yKjEU8xoKwqMnTL8t4UuvdB+RLQdYbLYb1NqVKHT
         zZjIwGTL2NOlau2ZRcYjMlYLzkJdwNHOaqqqmrw94MMyp+5q5+iFrIJ5OAdWlpNQ4nUf
         Z6RiZ37gAEJpzfLcYwUZHX1eTkwvPxZuLP24fwPM/VhwjkjlgqA/bCZOfGMdJuWb7kHO
         59ZKfy9/yX1ZjXGMwAPDGsom5ktQtWajD+uAuL5FljxsHLFKxOsu3ep7a3NSS/TjsjE+
         +2C7jnAp+mzGtH7RzNC+YJ+Qvmfu8EAklr4mI51Li2bPZIGb8QISQfXSrY9KUH7VorcA
         8Mdw==
X-Forwarded-Encrypted: i=1; AJvYcCWVHVdpH2xSSkyuMlsZk+Y4tm6LzrPbSGkzJP3f1BVqABcvbdcdNzaYfuBxWI/QET6kasxIG6WGswo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJehczKB60+FP1dewTlulN7u2sp7IL6igicw6c8vWy/tYQc/aE
	5zeKopbxiTp2sfIJkagAT8FECXl+6NOppsyahNtX6CnElccZ0xYQ6EbLnw/+6A==
X-Gm-Gg: ASbGnct4wSeqdtaPuRoqx89Ylbh9rF0rJLZYwp38ziiVkXSkd3KirLuo0xb3xmV67zl
	tGQr6aSIx6mrH7Fcr+UujOt7XSS1xWlET3Pqz0U4RSpZsN6hukLxu/Y74e+VYe0lkCWPl+HybeJ
	9e0rHD7PUo7qwPw0ZAFRRGW6RU6dvsZC9qo19wsKx9GL6uymTCYCxcp4AOADvYdhPNSGJ3xKPm/
	qodBqaJBBy0jDGoW7pA872YMhBfB27IG2y2XbLI26E5+Gt8Ns9lecUKcMHgUXIhu9dU
X-Google-Smtp-Source: AGHT+IFQcMcDVID0W/UMwjtnX+YPifcFR9pDYG5iFdtJCREYhFobz06S5WtCY8l9lvzCnul9WOa+xQ==
X-Received: by 2002:a17:902:d4ca:b0:215:6b4c:89fa with SMTP id d9443c01a7336-2189298266fmr161242345ad.8.1734370791170;
        Mon, 16 Dec 2024 09:39:51 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5f3f1sm44322435ad.209.2024.12.16.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:39:50 -0800 (PST)
Date: Mon, 16 Dec 2024 23:09:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241216173945.s5y4dsyzhi5fo4ey@thinkpad>
References: <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <20241216164830.36lpu6gfnapsdar4@thinkpad>
 <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hxnYere19wXbua6zWEDRDgSPeJgSECugtwfgTP-UN8Bw@mail.gmail.com>

On Mon, Dec 16, 2024 at 06:28:55PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:48 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > > > > We need a PM core API that tells the device drivers when it is safe to powerdown
> > > > > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > > > > applicable to other devices as well.
> > > >
> > > > Maybe I'm misunderstanding things, but I think the important part is
> > > > to indicate when a suspend actually MUST put the device into D3.  Because
> > > > doing that should always be safe, but not always optimal.
> > >
> > > I'm not aware of any cases when a device must be put into D3cold
> > > (which I think is what you mean) during system-wide suspend.
> > >
> > > Suspend-to-idle on x86 doesn't require this, at least not for
> > > correctness.  I don't think any platforms using DT require it either.
> > >
> >
> > On suspend-to-idle, yes D3Cold doesn't make sense,
> 
> Why?
> 

Because there is no requirement to remove power during S2Idle, isn't it?

From Documentation/admin-guide/pm/sleep-states.rst:

'This is a generic, pure software, light-weight variant of system suspend'.

> > but on suspend-to-ram it is pretty much required.
> 
> Well, I know for a fact that on x86 platforms ACPI S3 does not require
> putting devices into D3cold in general.
> 
> Why is it required for NVMe?
> 

But ACPI code currently calls pm_set_suspend_via_firmware() for S3 suspend. And
that causes NVMe to be powered down because of pm_suspend_via_firmware() check.

> > That applies to DT as well.
> 
> Again, why?

On DT systems if firmware supports both S2Idle and S2R, devices can be kept in
low power state during S2Idle and powered down during S2R.

The problem comes if the firmware only supports the former state.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

