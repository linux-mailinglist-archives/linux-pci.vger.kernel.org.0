Return-Path: <linux-pci+bounces-16985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9134E9D0067
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5686D282C50
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4618EFD4;
	Sat, 16 Nov 2024 18:14:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CA18C008;
	Sat, 16 Nov 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780848; cv=none; b=P+Ix/IvjQn7HXF7JKdcYzdBr/aKsn8JP/NVPB10ogeRFEYhKBVND4M9bTNnCddTifIMVRC2dbMMnQetVIkpw8dphBkRDjO53mLcXaPYB2xAIWKOkggtFaTMMNE2NglnSQNR04B/RswtZcCsenJNkEwEZ5dr3R9rWQ0brizA9KLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780848; c=relaxed/simple;
	bh=wutFM95Qn/SMnTexyHi02FvWZAuVUbPjRsQUsE+e7QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw+pXAF9pI4Cqj95OWqxx11hbws390r3JOeJCUZeFKwXg4UjLJq82zSj2Pa2PiR+A12zY7pWULK8KRXWL8v7nq7x5cdotlMhrWRLH/itBNC0aBf0a3mRsi3GXGnQRsmvQg5AdlXqJzXFY06BCeZmGidfZrB/MxmaySVeA4Jal/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so488248a12.1;
        Sat, 16 Nov 2024 10:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780846; x=1732385646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1e1UW6hqf95jCfFb5aQStBTNaWPrEdtbrOS31Hf7Mg=;
        b=Qs8rCzyPXr5Io/mPlJppzfIbDQH81V3d+Q+tbAgG310/5ZctwRjkTqbkmCwVus6bMa
         9R8hTDAplhDFivCbU7YrMLuyl1CnvolUySwafTTHcXOtiGjviaq6+32nnO5iF/w/nk2b
         gGntVUgRkBrPmx1TqPkptfG072JsX0CxgFolyZKuutH3r4+tLN4NhHW70GuY7ONuuPoz
         Si6d/q+LNdkpVc6LcFQ2jNyRS6JHpQ8HwUGjL3OtLk4bSemFobz+YT8STpuhYXSvBJ6L
         7cBmhi7lOVhLKxkaird+0oNiOkaq0I5CxN//gjmfmeGx02zJicZlRhbcneLN9jQzf3or
         kRoA==
X-Forwarded-Encrypted: i=1; AJvYcCWdxMsPdoJX06H0dW6k3D/LYFOUpBhkeerc2/J3BqZnbniD09w7szzoO+mcqctpOsjqEOA4mA95@vger.kernel.org, AJvYcCXZsxNtoTnBkOtCSt9yEvVw5M1FgE5obuiaS5T08EMqe8SBr8vg0J+AuKfhDMeTBmlzgkcFsikYNr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/+6atZuq1+XZpD90wJXfKwls3B1o40F6l+Mf3xbvdx9X9/KS
	9vcAIedtBeZvtqwYkDcI2IxXl9G+aunGV8VLoFy7kGftwKBbJaEi
X-Google-Smtp-Source: AGHT+IGpXnAC5gH8SSmmG2YEH6w3S1MiYVNR7bx1egZRMoNZgH5tRDPD9rh8ScJOZzeKVJH3coknIA==
X-Received: by 2002:a05:6a20:7f81:b0:1db:e3c7:9975 with SMTP id adf61e73a8af0-1dc90b237e7mr9948246637.15.1731780846417;
        Sat, 16 Nov 2024 10:14:06 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c16c8csm3242592a12.7.2024.11.16.10.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:14:05 -0800 (PST)
Date: Sun, 17 Nov 2024 03:14:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix advertised resizable BAR size again
Message-ID: <20241116181403.GA890334@rocinante>
References: <20241116005950.2480427-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116005950.2480427-2-cassel@kernel.org>

Hello,

On 24-11-16 01:59:51, Niklas Cassel wrote:
> The advertised resizable BAR size was fixed in commit 72e34b8593e0 ("PCI:
> dwc: endpoint: Fix advertised resizable BAR size").
> 
> Commit 867ab111b242 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API
> to handle Link Down event") was included shortly after this, and moved the
> code to another function. When the code was moved, this fix was mistakenly
> lost.
> 
> According to the spec, it is illegal to not have a bit set in
> PCI_REBAR_CAP, and 1 MB is the smallest size allowed.
> 
> Set bit 4 in PCI_REBAR_CAP, so that we actually advertise support for a
> 1 MB BAR size.

Applied to controller/dwc, thank you!

[01/01] PCI: dwc: ep: Fix advertised resizable BAR size regression
        https://git.kernel.org/pci/pci/c/ead24c08af48

	Krzysztof

