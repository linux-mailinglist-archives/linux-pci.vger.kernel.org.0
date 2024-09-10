Return-Path: <linux-pci+bounces-13012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD51974323
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 21:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8851C26494
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318D1A76D2;
	Tue, 10 Sep 2024 19:09:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AB1A76CD;
	Tue, 10 Sep 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995345; cv=none; b=Ez8elz/zYZIGTqX2DnTLmmOZP5FRPMMSu6Anf6HTB0F4y6TaJZGib2vUYJn/UM767orvvo7N5tWaYDqEBEgH+RsgsUJnZ+SNrIodWdbEee5aUXQEB+kdOn4giX60f+if6uQKQIaxN96K+woph6DkjuF0eQN/kgO/MRlvpblJrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995345; c=relaxed/simple;
	bh=W8wTMnQuqBGPgvSwNT0DrlwXeeQbppq+ym/XG4dBfDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1rebYBqH2hbxHGU3s0tTXZQll7knl+AWdnz0iHl4KDD3UF6qvVNlv0/vETZjYGa9fO+/VDo+DDsOZnzskSLoMlpH+UnFN3fRXx2v+E3uUj+i+RmbGvgKi2UtnuGn/TKL9a1nS1TZcI2ui7Ey7jgOAun4LWAzzOSBhbRDjmLQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-717911ef035so4597073b3a.3;
        Tue, 10 Sep 2024 12:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725995343; x=1726600143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0B13YwRmlaW1LgbTA4G5pfYntFaiIOALZ9EjPmoFa0=;
        b=HWfzrmI49wnDqD682abrJFC0EwHIbS9we7kkQqNqGOVaLsdkaEopWt60GgjFLZtKrc
         sJYcFyo4fCV3wz4NzxHPq+8NeG2A6RorQGA8NNJTBrYenHGJodPmvm9ZsPyxUYlgJOSc
         /wQFZvhhFoBC7gAOfV7QW2Iw79ozce6AvS/5+9uMLkjdkkOHc6hxXH6uAa6SH4IV0IsO
         PqpoRwM2a4po9DUqk27VIq+F+wWLgcwdSehWV6NIYn1S3JbK9wgrquzyznzqh//g2vGD
         x/rxrFC7fNRkScqau1lvYNtgttlYDWBoYfzfDJvvdJA+2VF2CaE51jLv8EwIYON32dP3
         EvFw==
X-Forwarded-Encrypted: i=1; AJvYcCXFgB6X30/cBbQbg02pA5C+S9Ps+V5JyFg3/1BdNC4lN4QTMNmWnzBGRi1gkHZ0yA4m1ZuzshXbGHiw/gM=@vger.kernel.org, AJvYcCXeVazDq+1LFMRYoMqdfte/wavzIljdmwCm9A8vDDflQ4xozoUjijvkcv0o/UZKdjb0osL1nmCbFCFg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9B33K/3eHLuJYnJO7tWJrMGr0vaCTEYiO1hd11mqypLGMoYim
	ow6nwHv0KqkKH0h3+SsUlp9EW0NMAXt9lbgXYXIMqZ9QOa7seT2U
X-Google-Smtp-Source: AGHT+IF6UIsMNPzFHnX46S5WXa+yxR5K0nzIys4ygvC5KZV8gpp1njil3a8k5+ugHRobMNspiaFXhA==
X-Received: by 2002:a05:6a00:189a:b0:710:6f54:bcac with SMTP id d2e1a72fcca58-718d5decd4fmr16303738b3a.1.1725995342688;
        Tue, 10 Sep 2024 12:09:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3e5dsm5983903a12.35.2024.09.10.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:09:01 -0700 (PDT)
Date: Wed, 11 Sep 2024 04:08:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240910190859.GA2136712@rocinante>
References: <CA+-6iNxfmeBhHK57pUGtJEbBCuhEi8TQCVFPxPbAutkpJVwksA@mail.gmail.com>
 <20240910175927.GA590299@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910175927.GA590299@bhelgaas>

Hello,

[...]
> > > Will do.
> > 
> > It is not clear to me if you want a new series -- which would be V7 --
> > or you are okay with the current series V6.  If the latter, someone
> > sent in a fixup commit which must be included.
> > Please advise.

Apologies for the confusion.  I though it was obvious that I will go ahead
and fix the code on the branch directly.

> Krzysztof amended this on the branch.  Take a look here and verify
> that it makes sense to you:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-brcmstb.c?h=controller/brcmstb#n752
> 
> If that looks right to you, no need to post a new v7.
> 
> I think Krzysztof also integrated an "int num_inbound_wins" fix; is
> that the one you mean?  If I'm thinking of the right one, you can
> check that at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-brcmstb.c?h=controller/brcmstb#n1034

Let me know if anything else needs doing.  But, if anything, then we need
to be quick about it.

	Krzysztof

