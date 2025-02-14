Return-Path: <linux-pci+bounces-21517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E710A365CB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 19:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE913B0DD1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864C178CC8;
	Fri, 14 Feb 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lM7iVeuz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135123A9
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558317; cv=none; b=F4r1ukY3xu5ewyBcJqBZkSMAySDFhrt1PngOloJqzEsSzUkbQlwuZUzVvDyPdQ/fFZGVg1iY61Q1NX0+n5HzSbMkavcpVXhuRg91GXPpbK4RBtgjuKoJMKv79ZqPt3YcpVYux2JBRBAxjFSYxm5Dif0gJp6J90WggeVoJekojC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558317; c=relaxed/simple;
	bh=ysuEb2g3PQplofx00CxlkTJhCNEsr0pKiHR8pC33G+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deiH75rBOnZyuH3JmrE3ihsWrm5VESJ4pT8nlQUUsvW5VlLtdyXup8gRFJEfyGAjkYQ7VIBpMFwvHuvkIl2pUW7aWWrd9fmEr0arie4M5gHf6r1Ug61Os3/WjBf5SWWXl3SJ5R05Fe284dPoVKYubZKyY4u9+N8lsJV/JpWL2bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lM7iVeuz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso3892309a91.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 10:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739558315; x=1740163115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MW2GBywaUgRS/t3ZNgvxusfrQJx/Qq36YhmvkgvGho=;
        b=lM7iVeuzKJi3fIPEBl4uUlQJg0q/uV4nBLA0zOXc+4X9HWNlhnA7x45z+r805321u3
         mcrxb5HupKH/xtOudWn+256jL1/7rJpOO/EHGLyL6Pv7WJ9DjtBrjAzwJedRvs2KfOZ/
         AtdXGbBH2oc7ziWDYR564kTuVKtbkniq90yVzt1TfBYpgnq0AThgNQowAFsY+HHI2W8x
         VBcwft+ATQplysUKFEreqpvXew390A+UCqTGoTPfXb2eEVcJgOkIPLmDcf0EGCasNpdF
         rezNzsrRZ7nrBG+usskbNvJz7zmc/WlEPtrbWL/58iJfySZSrt6VqqHHSH/BXfUOaVsK
         Yiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739558315; x=1740163115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MW2GBywaUgRS/t3ZNgvxusfrQJx/Qq36YhmvkgvGho=;
        b=ce43K5iFtXEE9MpmNquvMc/wvfpztDMrqr4cJi7TK6HZpKpH6Mwtgieey1snQs1A+O
         FRjdJ6zNoq5pg4OL17915er1VSSlHQBeZPB7QrOPp/5KSoLZGrg9yqO6fIzkX/fPOkAk
         YxQzfZM80NhnR52b7+c2k45jL9LUQSDXCvinf7AXFFMVQfs97/OSUqO/f4gINkVzKUZE
         90TCxbqKhwgMZmgpkQXpYgTHOTEhCunna4GAu5KRLi0dtAoRY90ylEyx7srbt7DSUy3R
         6820r1BtynHUc+R+w6Oa12ENcwfErjutFm8kQrUYmAEsn8vt5gg7ay1IiKFhJ6IhVs+Q
         gVDg==
X-Forwarded-Encrypted: i=1; AJvYcCXs7B+5LZiDo7w6aG9yh35M2/dNCNZq4Y58qSlMId2Li4ws2Dn0oG7i2G8cK7YFjVD3yt6FF8S42Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPA6/i92reiYK1HSGW3QHouiCHxaa8MI46K4dGvbngw6Wz1Ep
	C84gYXtYcAzNKmkuMGDrofhgu1cvvremgh4HhMMoQQoeLIwXhAVPGnD79xEyWg==
X-Gm-Gg: ASbGnctPqC8XTwdfDEMJDbFe9lan+MhreFY2N0qHZyfYBnfQ5XUEZxZSQyYWP/o6mVR
	ymEVFqZDxw6zD+GoiT8tkONMay9WtuP+dQ5/EsTtgKJOubee/R3eVfGA7YWLBSjj7eiIyIKkK4v
	oAalEVPoRGXTPp8lX1sLDwfHf75FatU0TWzKJUapU0mJ8URmQ/g4xhZuqc4z2+3bupQ5sWrmkCb
	6S5dVrtylJVY/gKqjWfuk1OY4cQ2oN6tBM9dmkLlX6ih2lJshkMQPj+UP4JlE5OtTPAeaaaMd7F
	3Y5/ZDoEUl1X1DBs45iC3kzXCvvyMJRzZTmKdTTUKZU0mWPoxc3cRR+V
X-Google-Smtp-Source: AGHT+IGN4MMuhcel28cv500/Eeg1X6Yw/H4IfdoZd9h6RlidMWzXyvkkCJ04AhJNJYoIrg1W2MJxtw==
X-Received: by 2002:a17:90b:3949:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-2fc41153d87mr148637a91.30.1739558315015;
        Fri, 14 Feb 2025 10:38:35 -0800 (PST)
Received: from google.com (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13b91424sm3453052a91.31.2025.02.14.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 10:38:34 -0800 (PST)
Date: Fri, 14 Feb 2025 10:38:30 -0800
From: William McVicker <willmcvicker@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>, Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com, kernel-team@android.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <Z6-Npgtxzc3O_JYQ@google.com>
References: <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
 <Z68JlygEqQBSDWPA@google.com>
 <Z68KYxSniCxdMMAg@hovoldconsulting.com>
 <20250214094255.jmfpkmzwqn5facsy@thinkpad>
 <Z68UpU0nofdUWddW@google.com>
 <20250214133919.vnf3kccxwzjgcgim@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214133919.vnf3kccxwzjgcgim@thinkpad>

Hi Mani and Johan,

On 02/14/2025, Manivannan Sadhasivam wrote:
> On Fri, Feb 14, 2025 at 03:32:13PM +0530, Ajay Agarwal wrote:
> > On Fri, Feb 14, 2025 at 03:12:55PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Feb 14, 2025 at 10:18:27AM +0100, Johan Hovold wrote:
> > > > On Fri, Feb 14, 2025 at 02:45:03PM +0530, Ajay Agarwal wrote:
> > > > 
> > > > > Restarting this discussion for skipping the 1 sec of wait time if a
> > > > > certain platform does not necessarily wish or expect to bring the link
> > > > > up during probe time. I discussed with William and we think that a
> > > > > module parameter can be added which if true, would lead to the skipping
> > > > > of the wait time. By default, this parameter would be false, thereby
> > > > > ensuring that the current behaviour to wait for the link is maintained.
> > > > > 
> > > > > Please let me know if this is worth exploring.
> > > > 
> > > > No, module parameters are a thing of the past (except possibly in vendor
> > > > kernels). The default behaviour should just work.
> > > > 
> > > 
> > > +1
> > > 
> > > Btw, you need to come up with a valid argument for not enabling the link during
> > The argument for the link to not come up during probe is simply that the
> > product does not need the link to be up during probe. The requirement is
> > that the PCIe RC SW structures be prepared for link-up later, when there
> > is a trigger from the userspace or the vendor kernel driver.
> > 
> 
> This is the problem. You are fixing the behavior of the controller driver to
> a single product line and this is not going to work if the same controller is
> used in a different product. Instead you should fix the userspace.
> 

Do you have an alternative suggestion on how to fix this in userspace without
a module parameter? I'd argue that module parameters are very much still used
in the upstream kernel to allow the userspace platform (Android in this case)
to control driver behavior at module load time. Here are some recent examples
I found on lore:

https://lore.kernel.org/all/20250213142412.516309668@linuxfoundation.org/
https://lore.kernel.org/all/20250213180317.3205285-1-coltonlewis@google.com/

By default (without any module parameter set by userspace), the driver would
behave as it does today and spin for 1s on probe waiting for the link to come
up. That will work for both Android and other Linux distros. We are only
proposing the parameter to allow userspace to optimize boot time by skipping
the link up wait time on probe when the userspace knows how to properly handle
this.

<snip>

> Same with DWC controllers as well, probe doesn't fail even if the link did not
> come up. Previously you were trying to avoid the delay while waiting for the
> link up during probe (for which I also asked you to probe the controller driver
> asynchronously to mitigate the delay). Is this the same case still?

Async probing may work, but that is just hiding the problem we are trying to
address -- unnecessarily spinning for 1s on probe. If userspace can handle
bringing up the link later, then IMO it's a valid argument to allow the driver
to skip the 1s delay.

> 
> And what makes me nervous is the fact that you are trying to upstream a change
> for your downstream driver, which is a big no-go.

As you may know, we (Google and Linaro) are actively upstreaming Pixel 6
drivers and will be adding support for the gs101 PCIe driver in the near
future. So this isn't just for a downstream driver running Android.


Thanks,
Will

