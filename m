Return-Path: <linux-pci+bounces-17947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AB79E9924
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E3A18832A7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED701B041F;
	Mon,  9 Dec 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cFwZaRSz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142AF1A23BC
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755109; cv=none; b=S7TGYP6XefYffkg1jsiipZM+42P96DgyF4DIi0gGqCI1bP1Gjr9i6ckvKwlkjawUCLRz0wRQJlPLVCqFw/7DeS1UOfuRUjT1+OGtMZF27TYrUKfW0BCk+RdKFqJg8WA8vUxAAPv5qFb9NJ8kqfZBhqB3weHssv+ZZqzaffHsBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755109; c=relaxed/simple;
	bh=sUSQ6w/uPMnUEc5UhN6lr+X2YALppLKGpxU+TDNIH18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8J/eJFPPPLUIMZNCsn4a3tYa5+5Q60kkGESn5NFiW3MRk3xIedM+LT+Tb32ZDQzZgkuJcED96nkHmmw0Zts8ppXa+IkZOcuWXYMDuMtp+i949NZLLkctY7hP6YGNsusibHgbC2VyvX610QeWgZHgztcrlWocHiGjiyKyfynfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cFwZaRSz; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so3600906a12.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 06:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733755107; x=1734359907; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=;
        b=cFwZaRSzzvmePwobJIIF7PTecRio0H2xJ9gH5KaKSWVqdEuCCkZI7S9UppbDpH1rMC
         jIAvTyEvT8bi2zB9gorwFO6IC3kZt4KcPHz0uVYfY12NsBR9fNPQ1q0t7dPz7IpozXhy
         yrCOTg3PaPo+V16RLWkTgtRxbt9khg/2e671eMMrIE5ESf8EQIoNWS/1EVjU80/IwJFy
         8sJe3AfB2xH70t+lhXYTL5wagmwjGMLx5wF2IG49maY4ySW5k13iEtcnQ7/sjNod+3xS
         GzhJVxKkLGjPo2x8AFcSEFz6vcCo0Q4EsW7J+rT7cfY7zlt30lDlz9xmWJ6d2XuQOyA6
         u2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755107; x=1734359907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5siyX/oBYeJOtEu9jJIH1QIRnp2BFKwx7Ms6hrWYqE=;
        b=e+6MhormE+VdAqPwBmLliiMdye7JXAhbI2VrFxa1VFfUcvQ5sT8EK/nsCdLDgu6xJk
         RAe8DEIW/LeVYXDGuEynwdWkKd+QeXmrfrOx3qgMBjt4iB8MixLHsK0NlpBm3Yx1//US
         Yl7XnlCMdCgM7lB3/JNUPRU13da/W7swTi+MpXW3PFKnVJghQL02NKCj9d2JtYIXbgq4
         hAzbqeDG7mjlH8D+322dWo71Ah/iBsojdEtEJf+5FLSL9erdyTlVe0voP0dffQCXv1eh
         Vw695ZqTFzhzXnGZbpNJU4UNRIkPI0JRmwc+WC07DvgTv6hmaIqx/DlQDi7KRqJFfhaZ
         N2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWkwgrzJAczp330dXQn1HDWGciHXl85/34gN2LcKQz5vZksWXvpZgfP8Ei3DwRl05N8lCC708iddqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrySWzNM/SkGEGoJaxVZs3BYjqrh2gCpS0CD/7/iMieoH9mLjc
	Hf7lcx7IkizvYJABicHrHWee8rfGb2b6tVmfnPrQcDmZuEp0pPU7vyI/5Abkgg==
X-Gm-Gg: ASbGncvL59Hr18xC+ENTwA+ehfBaIL8R4I/F7FiqhufMtKuPXQSL6MEqeyPNbnTW7/z
	y17uNq0QmYQ8huCrS4aRDVe7inub3RhqkYS4hzDwayJVflvpjL0NOWIjewVerXlW6lHltkzMCOM
	gQez1H99mZ34QXAIBuyDAvjLEt3l41axm1YDx5VLIFy4EIMRqTh/Bf7nfSfpWUG2edFOZem8gMv
	UtLn3Wz/TXwxEcJ6mJ8wvyyk+Acgz52I/fjMWqfiKozR4Dez2ixY2+Qe45F
X-Google-Smtp-Source: AGHT+IEjPNjheOz3H9P3KXCwrAQ0y1vhFh9v5UWKuqQE+ayZeQAQXxalmpEVYcnYnJ4nAlOJIgjr+w==
X-Received: by 2002:a05:6a20:d526:b0:1e1:f5a:db33 with SMTP id adf61e73a8af0-1e18712d2a0mr18475477637.36.1733755107284;
        Mon, 09 Dec 2024 06:38:27 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4681b0d5sm2644867a12.24.2024.12.09.06.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:38:26 -0800 (PST)
Date: Mon, 9 Dec 2024 20:08:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209143821.m4dahsaqeydluyf3@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241206014934.GA3081609@bhelgaas>
 <20241209133606.GA18172@lst.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209133606.GA18172@lst.de>

On Mon, Dec 09, 2024 at 02:36:06PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> > Oops, I think I got this part backwards.  The patch uses PCI PM if
> > d3cold_allowed is set, and it's set by default, so it does what you
> > need for the Qualcomm platform *without* user intervention.
> > 
> > But I guess using the flag allows users in other situations to force
> > use of NVMe power management by clearing d3cold_allowed via sysfs.
> > Does that mean some unspecified other platforms might only work
> > correctly with that user intervention?
> 
> Still seems awkward to overload fields like this.
> 
> The istory here is the the NVMe internal power states are significantly
> better for the SSDs.  It avoid shutting down the SSD frequently, which
> creates a lot of extra erase cycles and reduces life time.  It also
> prevents the SSD from performing maintainance operations while the host
> system is idle, which is the perfect time for them.  But the idea of
> putting all periphals into D3 is gaining a lot of ground because it
> makes the platform vendors life a lot simpler at the cost of others.

No, I disagree with the last comment. When the system goes to low power mode
(like S2R/hibernate), it *does* makes a lot of sense to put the devices into
D3Cold to save power. Using NVMe or other endpoint devices internal power states
only matters when the system is idle (which is not S2R/hibernate). This is what
ACPI is doing currently.

Then one might suggest to check the suspend state using
'pm_suspend_target_state' in device drivers and decide to keep the devices in
D3Cold. Unfortunately, it won't work for Qcom platforms as most of them (except
chromebooks) don't have S2R (a.k.a PSCI_SYSTEM_SUSPEND), but only S2Idle.

When it comes to non-Qcom platforms based on devicetree, they also cannot power
down the NVMe device during suspend (as they cannot satisfy existing checks in
nvme_suspend()).

The current reality is that most of the devicetree platforms *do* want to power
down the NVMe during suspend. Only when NVMe is used in an OS like Android, we
might not want to do so (that's something for future, but still a possibility). 

So this is how I ended up using the existing 'd3cold_allowed' attribute as it
allows the devices to be powered down by default and if the OS doesn't want to
do so, it can tweak the attribute from userspace (similar to UFS in Android).

The flexibility of this attribute is that it just acts as a hint for the device
drivers. If the device driver doesn't want to do D3Cold (when used as a wakeup
source etc...) it can still opt out (assuming that the platform would also honor
the wakeup capability of the device).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

