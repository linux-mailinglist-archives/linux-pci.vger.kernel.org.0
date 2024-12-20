Return-Path: <linux-pci+bounces-18863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F59F8D8F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 09:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B50164217
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F0E17333D;
	Fri, 20 Dec 2024 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6qhXeXE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF84192B65;
	Fri, 20 Dec 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734681840; cv=none; b=KuyoSIMt3FZ0jwR724NWq1g9g8lF2YHLWa5MLAiCB297UKz4IJZIgD5SzC6E38rZ4JmbZiznLqicQEMokw9EETQABTDX+iJ6CCxq+2YNiiC0h/SIIA/cd0ls0NuH2R9iONA85PaR7ZCqqfJQoc8XdC3YVJfize7HenehVPpIrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734681840; c=relaxed/simple;
	bh=E8GBHoEk/MYRQ1sB+R22tQpnNrP0DQd74EszQhNXBZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXP66U3KCOTOWo9GSiHiwtDo1kPgG+vYHYH76sr5OrEe04M2L5b6ZIfx3VthtuCCYiyOU6cuKHH9nSDo6cPTlA2oNTcb9Kbl7UaOxPepXuct6E3/XSWRmXf1rRbZn8JFFXr+KqyzXZMvHVbKmL0pcERDOPwi42PTYqbUwewn+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6qhXeXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46350C4CECD;
	Fri, 20 Dec 2024 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734681839;
	bh=E8GBHoEk/MYRQ1sB+R22tQpnNrP0DQd74EszQhNXBZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6qhXeXEiEuTYOhC7HpvESDTvlo5uxsYHo8toh3NMMOSWwelNHabfBG+dCd+LrVnp
	 sfmPMWFdTz+DTszzDUQaYWGl+zH93T3v2I+6nv9GPO325lwYyrwntCFH/YZapsnUlr
	 gU0md7HTpathfG+EVX0bWXaRJyw9hWz//tbHgc0k=
Date: Fri, 20 Dec 2024 09:03:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v2] misc: pci_endpoint_test: Fix return resource_size_t from
 pci_resource_len
Message-ID: <2024122035-stimulant-angling-3f42@gregkh>
References: <20241220075253.16791-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220075253.16791-1-18255117159@163.com>

On Fri, Dec 20, 2024 at 03:52:53PM +0800, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> Changing the integer to resource_size_t bar_size resolves this issue.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Changes since v1:
> https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
> 
> - The patch subject and commit message were modified.
> ---

The "changes" part goes below the --- line, as the documentation shows.

Please fix up.

thanks,

greg k-h

