Return-Path: <linux-pci+bounces-9798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A799276A1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F51B21261
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA781AE0BC;
	Thu,  4 Jul 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vR5MwX9E"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5B1AD9C0;
	Thu,  4 Jul 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097893; cv=none; b=daWwdNf1u/7hleMqcBIIzTQ3lt3y9Eph1gelwzZXDzhehYr3lKk4Dz5CURoZagZzreQKu3+QsRF83ahSNhWNj5NOOYg6wUFij/k7P2krvnIQmWnCt6iryVJ+JDSIwXBJmH/iSL4C4vCO6G6uID5DX4bB0XBq+0VJoTHAft34B2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097893; c=relaxed/simple;
	bh=rg5xDkrODwVO/MZ3QstcPmBulCAqtSO23Wy7WfcXZfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhCfPY9DDEUbBOYach08X1BS68QuLACQBCJwd+Bl4FZQe155/BycJohaMjQ9Zn8ioHGZDt2VZukdKoAvFsbuabZVBdtA5TljtJF08UnmcNblK2uIm4PSP3b+ZntZVq5ce+siXXoJ4rnyeTQMcu68ArKsIGJcD/8jliSvEv9HYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vR5MwX9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB808C3277B;
	Thu,  4 Jul 2024 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720097893;
	bh=rg5xDkrODwVO/MZ3QstcPmBulCAqtSO23Wy7WfcXZfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vR5MwX9E40QZ5IW1hso5raNtjg/puTZ2qmaP4aLK037xs39WbAaxSU8KsNBTnTy6m
	 Y2jHjbPtw6FJHvOSxBwWT1yxueRK8ASBWwGUvu1AO3u/TkJ8H9jzd3mR42KyRZ7DOx
	 2w7HvbBGDptGKG8x7uvnTnwfL8gttiz3kCTxhQk8=
Date: Thu, 4 Jul 2024 14:58:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	manivannan.sadhasivam@linaro.org, kishon@kernel.org, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused
 functions
Message-ID: <2024070442-garden-visa-a7d0@gregkh>
References: <20240704023227.87039-1-jiapeng.chong@linux.alibaba.com>
 <20240704071406.GA2735079@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704071406.GA2735079@rocinante>

On Thu, Jul 04, 2024 at 04:14:06PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > These functions are defined in the pci_endpoint_test.c file, but not
> > called elsewhere, so delete these unused functions.
> > 
> > drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> > drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.
> 
> Have you see my question to the first version of this patch?

Yeah, I don't understand this at all, how is this patch even building?

What tree/branch is it made against?

thanks,

greg k-h

