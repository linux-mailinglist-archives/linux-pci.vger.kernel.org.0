Return-Path: <linux-pci+bounces-25215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25207A79CC2
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 09:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18A317327C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC42405E1;
	Thu,  3 Apr 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP+sATvX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9842523F42D;
	Thu,  3 Apr 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664794; cv=none; b=VgzAHVbitmsNwAyiSvboJq6/+NjCNMge084Ac8aTMzSz8TALsnO/6IxNPkMdUMYfEDkWfUaR/BpunC9hTEe6p7rY5C9eJZbju+vwZkFsAGnBCIQB9rgJ5oV2YDWnW4RnxJrrgLdKi94tw0F0on0BXusr1W1MTCJxayqf5rdoNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664794; c=relaxed/simple;
	bh=T0uXIGLNl7BuW49vYLPY28xQSdne7A2PEmLs6GteNXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKarZWPeZpnTenDzcL7S99GwA0SYYGiaGbJXx2wYiaZclHWGfnpQb5jUll+iqmvtJBltevuU/3Vr4jGdvoVECVIo2OEirY2vbd0pUd1Jf7/dOMJbv9ZyBNqK0UQjt+RP0sp0/ZpoKmSmM4ZleXTDPvx0kf0hXlWr4iejzOPEIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP+sATvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CC4C4CEE9;
	Thu,  3 Apr 2025 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743664794;
	bh=T0uXIGLNl7BuW49vYLPY28xQSdne7A2PEmLs6GteNXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NP+sATvXwIKNjNGEG/WhaEmBFBhk07+r1H+YsvHuyhyYRudd+XG903734l4iTSAnS
	 Nvv3BGxykrOtw/rTPsjEHrfAfCi3QcuUmNSIEVN9Rg962+JrhdmmL4oiX5TDC92R1H
	 JHUIrSwfe9S5jhhg7i8TIG1ezAUIMebhJifXzvZ0p85NS/3XwEXkIUpUrn0j6h24Uo
	 VJP8URVZhZwazxNKruuVYJmAc9ck8aN9p87CYXqN9QyYErigQ20s4DYes8j0MI/lFH
	 3kTILynmNz6SxQdcFYVDLpYX1/w/YLxTyvGHenRloSIm3XcJlwpUilYZcvLg0cdBZz
	 0GMxb+6cHrQcw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u0Erl-000000003yS-3BJw;
	Thu, 03 Apr 2025 09:19:58 +0200
Date: Thu, 3 Apr 2025 09:19:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig
 symbols
Message-ID: <Z-42nVkEZeWHdwAm@hovoldconsulting.com>
References: <20250402132634.18065-1-johan+linaro@kernel.org>
 <CAMRc=Mfpm8=q1mkfNfjPtogbh1S9PKU+w_2yMP+oE_Gj7-qemQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfpm8=q1mkfNfjPtogbh1S9PKU+w_2yMP+oE_Gj7-qemQ@mail.gmail.com>

On Thu, Apr 03, 2025 at 09:11:07AM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 2, 2025 at 3:27 PM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The PCI pwrctrl framework was renamed after being merged, but the
> > Kconfig symbols still reflect the old name ("pwrctl" without an "r").
> >
> > This leads to people not knowing how to refer to the framework in
> > writing, inconsistencies in module naming, etc.
> >
> > Let's rename also the Kconfig symbols before this gets any worse.
> >
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> I'm re-adding the tag here as otherwise b4 will only pick it up for
> patch 4/4 on v2 of the series.

I had already added it to the first three patches so it was only
missing on the last one.

Johan

