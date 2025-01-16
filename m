Return-Path: <linux-pci+bounces-19955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB07A13856
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8C21885CCF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 10:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13271DE2CA;
	Thu, 16 Jan 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5r+47ch"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC641DE2C1;
	Thu, 16 Jan 2025 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024851; cv=none; b=AWJYqum7PCtPl+IH7Puf3bqcjm24LfntzpNpaWMoyvsSwHQ0Gx5zhoeQkBx1KDJPSdR7IjmGrOY4oExK+dbrda55EDpZB9ulW60N8GQ2qNf/s/t9WNRbtMPIA68sdJYi9MsGfTzxvP7+k0rtIew3dvtn3/Nv6oa9s3DNVgA/WKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024851; c=relaxed/simple;
	bh=6y45T4rKxOoS+7HeQ1rW7/9EoYu+mQSV/B+YDmw5YKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5nXgW40ZFzBJEhYi3YfYUWTyQChfbl/bjw/UvX0LqKbU48bVastqF44XwQehRZTtprgyI+m4WvsgQMhzZWVj7KUi8WYEVwbGThU63P2AwDY7B6/FFMHsrPyoY6FigjIGsadBleRKIcQQ2QmDSP/+rXukV5eOrjWe0HHfVVhxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5r+47ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC456C4CED6;
	Thu, 16 Jan 2025 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737024851;
	bh=6y45T4rKxOoS+7HeQ1rW7/9EoYu+mQSV/B+YDmw5YKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5r+47chzHEKGSMm2iMebLZ7u2N7g52Itvh6UeqbjOxr7faHVJupM9RuurP91Y2ar
	 k0QP5ZUYayH4Jf2+g817nW6s0Se93JMAUa89cE9WKexiCU5FjmCUwz9xeGYrnAEjsz
	 L827ByqMgXbEBF3U1tJMAeqpWK7vkqyf+dxr+dqk=
Date: Thu, 16 Jan 2025 11:54:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] misc: pci_endpoint_test: Fix irq_type to
 convey the correct type
Message-ID: <2025011651-stubborn-certified-b22f@gregkh>
References: <20250116024145.2836349-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116024145.2836349-1-hayashi.kunihiko@socionext.com>

On Thu, Jan 16, 2025 at 11:41:45AM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, global "irq_type" and test->irq_type.
> 
> The former is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> In pci_endpoint_test_request_irq(), since this global variable is
> referenced when an error occurs, the unintended error message is
> displayed.
> 
> And the type set in pci_endpoint_test_set_irq() isn't reflected in
> the global "irq_type", so ioctl(PCITEST_GET_IRQTYPE) returns the previous
> type. As a result, the wrong type will be displayed in "pcitest".
> 
> This patch fixes these two issues.
> 
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

