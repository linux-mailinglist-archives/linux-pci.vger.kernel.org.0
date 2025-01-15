Return-Path: <linux-pci+bounces-19911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4496A12960
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD80A16673C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8E194A54;
	Wed, 15 Jan 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8y5IEhH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E86348;
	Wed, 15 Jan 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960751; cv=none; b=DE37+lu3sIo94IiXkCup8xjBdE3EuUVRFR03GBVQCmtjMw5TdMt3efXVPQNsfLQGu1u6oompcvL27QbUl7ET3jGunggArq7ALFZLqrAWkX1jk3gw22gNDN1p686ZK5122YFPD6RRREmN/hSxZdgnr9pI3NF3zJS71rR5kQ5vmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960751; c=relaxed/simple;
	bh=MQp8qVuFzxiqScfsxIZECCc1h0OecOOxCsf744tyjTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHUMCwUT1JVojZv6bPLJ71h3Fttqnolk5iUxIYfY/x3mmLqXUrre+iSz7/B/A1D06yGyTTnBt+ha6950NcZXv15LIA86CoOs9qpwPRS0LLI26OFdVX1SvVmStdFzPvPQOKqHuPTP92w2T+lBOvFoMeg+eoMvS3t48mzIzUbmdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8y5IEhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F5C4CED1;
	Wed, 15 Jan 2025 17:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736960750;
	bh=MQp8qVuFzxiqScfsxIZECCc1h0OecOOxCsf744tyjTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8y5IEhHC2rPrEo/bOWfmMtqNypORnLJzXaF/IlOm6YvdnFGG187k3NTatJU4tNsU
	 BOW6hmSJ0h4uWVtw8cqVJTKsTuMYP5QFuvA+Ep59+XG+AmLCPpTJswiboeszeuiGT8
	 lhn02GRh4aPKJMB2PzNPSJ/rsc9em4NvnFzTSSstkF9/wIssD+TSshBpBdfMppLi5c
	 1htWtoqZBSuagklvdx6E613vgFZ0sG3vadrMWBZ6T9DpI8NJiNDI4eBeMnZTCQIXKK
	 5HizAV+faLZHnl51M3xTp729BFHmNiokg5yhJ/3W7tdg9EIc2y2kG2HR9RQYvxcvxz
	 yKm2BFiNpO3tw==
Date: Wed, 15 Jan 2025 18:05:45 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Hans Zhang <18255117159@163.com>, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z4fq6XU650iOsFZe@ryzen>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <20250115165842.p7vo24zwjvej2tbc@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115165842.p7vo24zwjvej2tbc@thinkpad>

Hello Hans,

On Wed, Jan 15, 2025 at 10:28:42PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 09, 2025 at 05:45:56PM +0800, Hans Zhang wrote:
> > With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> > 
> > The return value of the `pci_resource_len` interface is not an integer.
> > Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> > overflow.
> > 
> > Change the data type of bar_size from integer to resource_size_t, to fix
> > the above issue.
> > 
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > Suggested-by: Niklas Cassel <cassel@kernel.org>

I intended to stay silent, but considering that Mani gave additional
feedback:

- The Suggested-by tag should be in patch 1/2, not 2/2 :)
  (Patch 2/2 was 100% you.)

- No need to keep the change log all the way back since V1, usually
  people just keep the change log since the last revision.


Kind regards,
Niklas

