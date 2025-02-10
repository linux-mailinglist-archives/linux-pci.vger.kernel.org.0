Return-Path: <linux-pci+bounces-21093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D242A2F38F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0719F16558B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626131C5D7C;
	Mon, 10 Feb 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOVT2n8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0F2580D6;
	Mon, 10 Feb 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205048; cv=none; b=Qc069ibELeA5kr7QMRLLivpaKXMdkDt6zy53a5gUyEPNI9fh6ztMPmdaBD2N4b5X1sSN8KmaesdMAZ4/lw1/Vkkjzvy7YtKGI3WZ3xP3P3CNCm9AyCY0w3WUyfgdq3tMYDBKkBsfuUEjWp4gwg4AEzYKBEA7Cq4jWokv3GVK3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205048; c=relaxed/simple;
	bh=z+1Kq60tzkMsngBcFA1I3F53of+lTcYmSG8z/d3l6Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogAA2TCigawSHsdVLiSI/B59wemvcGj/mbHD7Wf9B6HLnZb2OOrfK6yvs14+hRfgheGebEjvv8ORISNef9GYssS4xkLulDeQMdAJbLgLRC46IHFn2U1d02Ag4EvEeyO1UqlRbCp1D+jYs/VWtwIijY0zOurpzwlHEWlD4KXL53M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOVT2n8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E6AC4CEDF;
	Mon, 10 Feb 2025 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739205047;
	bh=z+1Kq60tzkMsngBcFA1I3F53of+lTcYmSG8z/d3l6Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOVT2n8IUIHT6BoMqW3rMtlZriffRLGo4r9pyBNpQO+CoyWL0bTNGdvV34FwaMxTj
	 8qe+enyeWOQbtYXlar8wl1UEzemKHyZ4avrGbedVatNmVlw6aT8vWFmyEYKI+X+8eX
	 eB7uytdL1rkqEMUWatRzVzJODlLz5dNefzKu6QWpSTcuxg84wd5Qxpj7XVks8YEX6v
	 WjkXvTPZGL8hZP6yAr0nyxO9OZIwhyNdobClOaVIQp0QrpiFhS+il5GDqBVCG8HhUT
	 tZcoxcy6qi3/UOmkD2IgDonuZmfXzUbZNNXg6QDEB6RPGZa3qLH0osWvakOrdLip++
	 YUZ3aehpXW7Tg==
Date: Mon, 10 Feb 2025 17:30:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] misc: pci_endpoint_test: Remove global irq_type
Message-ID: <Z6opssGJ91MVWgRC@ryzen>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-5-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210075812.3900646-5-hayashi.kunihiko@socionext.com>

On Mon, Feb 10, 2025 at 04:58:11PM +0900, Kunihiko Hayashi wrote:
> The global variable "irq_type" preserves the current value of
> ioctl(GET_IRQTYPE), however, it's enough to use test->irq_type.
> Remove the variable, and replace with test->irq_type.

I think the commit message is missing the biggest point.

ioctl(SET_IRQTYPE) sets test->irq_type.
PCITEST_WRITE/PCITEST_READ/PCITEST_COPY all use test->irq_type when
writing the PCI_ENDPOINT_TEST_IRQ_TYPE register in test_reg_bar.

The endpoint function driver (pci-epf-test) will look at
PCI_ENDPOINT_TEST_IRQ_TYPE register in test_reg_bar when determining
which type of IRQ it should raise.

This means that the kernel module parameter is basically useless,
since it is unused if anyone has called ioctl(SET_IRQTYPE).

Both the old pcitest.sh and the new pci_endpoint_test kselftest call
ioctl(SET_IRQTYPE), so in practice the irq_type kernel module parameter
is dead code.


> 
> The ioctl(GET_IRQTYPE) returns an error if test->irq_type has
> IRQ_TYPE_UNDEFINED.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 6a0972e7674f..8d98cd18634d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -100,10 +100,6 @@ static bool no_msi;
>  module_param(no_msi, bool, 0444);
>  MODULE_PARM_DESC(no_msi, "Disable MSI interrupt in pci_endpoint_test");

Considering that you are removing the irq_type kernel module parameter,
it doesn't make sense to keep the no_msi kernel module parameter IMO.

The exact same argument for why we are removing irq_type, can be made for
no_msi.


Kind regards,
Niklas

