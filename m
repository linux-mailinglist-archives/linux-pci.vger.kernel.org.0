Return-Path: <linux-pci+bounces-2063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0838282B202
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 16:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6021F2276B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9EF4CDFE;
	Thu, 11 Jan 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kszKQUJg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F094CE0A
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6daf9d5f111so4048200b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704987815; x=1705592615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emlCTYFoJ7HTQ2zXqmk/2tpC5aAMyfsd8X53K7e0g/Q=;
        b=kszKQUJgnT75KyoKkYIzgLlr/fSEAnCWEyV8ociIm50uGsifW+ujJj2lzdnpS4V2e5
         TpSLduHwaf61tiI9e6TNm8n8SDzuu/RPEY00tW3HDx6GBac1m+bW0v7iOr41LCv6O1K5
         WuIOacooRx/Fc7fujBmRG8HMb8q72AOhh62YBv11g+u8MJ75VOCgTeqfhD8saHFmUBKy
         AZbcARMlegIENZH6Be82PUTqqVNehl/pIWrb9GBz0MHaqKEe2JE+IiZZgX3mQqLjj/6M
         g2KuhRvbHujoQmNwygKjj5hI6B6XD6Ms6lvqFAkpKWC4ND/yAwas1R/Z6ul+BOXs3iOE
         f06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704987815; x=1705592615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emlCTYFoJ7HTQ2zXqmk/2tpC5aAMyfsd8X53K7e0g/Q=;
        b=lACyRrXN83iQadxGapwAYarp6wS0lWq/gDTF54oHndBcE1JiLnlzI/Sy/agtZchoSQ
         zrUp4bN5Ntt8zJ9pmVc7WntglPtX6NgDMP4v2Wvk9d6rwoFtn2o1+9277nldS7x+Nryx
         gMJ85RKTPlJ2VnSF5vD8HryZKwyZrvA8TT0O5nP4SrxfYbKs/b53rWEp7H1luA+8tZ9G
         cnysjTMNPjEpzN6i2ETIc/x5tJhFfYitZyoXQ6P6w2KDSnwcz2joDIG6vrojTETUvjk3
         jbVHd4JiRmVC6h0jba4j5sqlB/jFZAcwScf9++UZWAqf5s6qw+fihd1AyOwSmokEktoe
         Aqmg==
X-Gm-Message-State: AOJu0YxXplTXtDxvgpQCj4JrvVyiZbF335F1MzdapOy80qYsYZnS4z/z
	pH8+lAj0M/x7qPumKGrPqTP48QZPDzsV
X-Google-Smtp-Source: AGHT+IFvJaH4YK0hj1wr5WEnyTQLfJ5o58oJEO/otJH4ybFOLkeh5Ao1CGLtIVFFwC3v7Yp457eJow==
X-Received: by 2002:a05:6a20:1595:b0:19a:5eb0:4389 with SMTP id h21-20020a056a20159500b0019a5eb04389mr27554pzj.31.1704987815222;
        Thu, 11 Jan 2024 07:43:35 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id n8-20020aa78a48000000b006da5e1638b6sm1360917pfa.19.2024.01.11.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 07:43:34 -0800 (PST)
Date: Thu, 11 Jan 2024 21:13:26 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <ZaAMnh8lae_Cxvtm@google.com>
References: <20230706082610.26584-1-johan+linaro@kernel.org>
 <20230706125811.GD4808@thinkpad>
 <ZKgJfG5Mi-e77LQT@hovoldconsulting.com>
 <ZKwwAin4FcCETGq/@google.com>
 <ZKw03xjH5VdL/JHD@google.com>
 <20230710170608.GA346178@rocinante>
 <ZKz8J1jM7zxt3wR7@hovoldconsulting.com>
 <ZK7m0hjQg7H5rANZ@google.com>
 <ZLENgbMe4YVOINRQ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLENgbMe4YVOINRQ@hovoldconsulting.com>

On Fri, Jul 14, 2023 at 10:55:29AM +0200, Johan Hovold wrote:
> On Wed, Jul 12, 2023 at 11:15:54PM +0530, Ajay Agarwal wrote:
> > On Tue, Jul 11, 2023 at 08:52:23AM +0200, Johan Hovold wrote:
> 
> > > All mainline drivers already start the link before that
> > > wait-for-link-up, so the commit in question makes very little sense.
> > > That's why I prefer reverting it, so as to not pollute the git logs
> > > (e.g. for git blame) with misleading justifications.
> 
> > I am developing a PCIe driver which will not have the start_link
> > callback defined. Instead, the link will be coming up much later based
> > on some other trigger. So my driver will not attempt the LTSSM training
> > on probe. So even if the probe is made asynchronous, it will still end
> > up wasting 1 second of time.
> 
> Yeah, I had the suspicion that this was really motivated by some
> out-of-tree driver, which as I'm sure you know, is not a concern for
> mainline.
> 
> Vendor drivers do all sorts of crazy stuff and we don't carry code in
> mainline for the sole benefit of such drivers that have not been
> upstreamed (and likely never will be).
> 
> So again, I think this patch should just be reverted.
> 
> If you want to get something like this in, you can send a follow-on
> patch describing your actual motivation and use case. But as it appears
> to boil down to "I need this for my out-of-tree driver", I suspect such
> a patch would still be rejected.
> 
> Johan

Johan, Mani,
I submitted https://lore.kernel.org/all/20240111152517.1881382-1-ajayagarwal@google.com/
which does not return an error value if the dw_pcie_wait_for_link fails
in probe. Can you please check and provide your comments?

Thanks
Ajay

