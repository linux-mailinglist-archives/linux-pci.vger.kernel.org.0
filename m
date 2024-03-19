Return-Path: <linux-pci+bounces-4915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF728802BE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FCD2838B8
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC28FC11;
	Tue, 19 Mar 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX927gRl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882D1798F
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867235; cv=none; b=RFqvNXPCjFfVkl1yO26eI9M+F2R28K8sPeEoNsCNKeA/woU7oqjaAC7Z+M3Yi380gfqfZ9pUKFm1bGUtHkJlDqEYLAvuZSJdN1YTFxwBK4EVEuBqTK9baKDDS0zVQgMRIxDD58+HNe5xIq50EufLO8cMC1OgPpQhOSqcU2fToVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867235; c=relaxed/simple;
	bh=/rDttatnOTCd8CzleCXbuXtBAuyu2o9G5xtq3LQTeQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+2iawcym2ONO5VVHoD4iYJ0F4Y/Bsgpb6rT4rpm9WvcHPoUjha2wx/WrcyaFV+hBOGycqncMuNeqD0zAW2NWb6Y+pTALrZPMFKTuPLtriWTMQNwEYP+UfsnImajnfiC45wOXhpegTUgb7tOuhZpfzgZSHbCfPlP0NXejDrPvKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX927gRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36631C433C7;
	Tue, 19 Mar 2024 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710867234;
	bh=/rDttatnOTCd8CzleCXbuXtBAuyu2o9G5xtq3LQTeQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KX927gRljBKURM9rQa+wLa0Z6A4oozb22IwCiiH0wbQj7nsD0eSo/friN9fre8aYQ
	 HSbHWKWiPHrktWy5gR8Qjf5NcjkvIQtGq5yQIwqilDcxm9VtPToXCHr90VTH672gXQ
	 Tk8ul1h93abWa/vyLr96FVoM1tPDr6KVXRr5dLSC3ZM8UIVMEfWuoD9bwyDRwUijPn
	 AUvuQ6Ff5L/QOvPBjFpF1gTSlqaydQgdbTZfKQjfiWYuiGWPHwPArsoFkkf2aU2nkz
	 UsUiljlSPqJo0ENZDX35ANhoJaG5NlUEx0X0AtZF8iAdnmu4DtMh1rxuZzOpUXibvU
	 RE2+Y6c2SHiBw==
Date: Tue, 19 Mar 2024 17:53:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <ZfnDHgqJOAVubbke@ryzen>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
 <ZfnAATqpYlssxrT3@ryzen>
 <20240319164826.GF3297@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319164826.GF3297@thinkpad>

On Tue, Mar 19, 2024 at 10:18:26PM +0530, Manivannan Sadhasivam wrote:
> > 
> > I did also see this comment:
> > https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L2785-L2790
> > 
> > Do you think that we need to perform any flushing after the memset(),
> > to ensure that the data written using memcpy_toio() is actually what
> > we expect it to me?
> > 
> 
> The documentation recommends cache flushing only if the normal memory write and
> MMIO access are dependent. But here you are just accessing the MMIO. So no
> explicit ordering or cache flushing is required.

What does dependent mean in this case then?

Since the data that we are writing to the device is the data that was
just written to memory using memset().


Kind regards,
Niklas

