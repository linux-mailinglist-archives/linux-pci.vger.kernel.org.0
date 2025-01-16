Return-Path: <linux-pci+bounces-19975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D49A13D2E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 16:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FC03A30C8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4E1F37CE;
	Thu, 16 Jan 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB4M3V9t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D15336E;
	Thu, 16 Jan 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737039854; cv=none; b=CCHSGABgZF7cxBUXi2Qu708ska3T+qpgX2ydxifiZ6rPkykVky7cPyLAZ4i7FaD1jTiJjfMK/nAUdFgo5tnoOy8Wcvu9/AE82YFY/pLn+oO7ArickXqBxkwvjI/ibWCuTr41dCkeZbEzs6pXWiFGqJgSNhR2/aEAN9heF0qZ+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737039854; c=relaxed/simple;
	bh=w1MHbKjB2/ctEbaOXc8wsyvMohS92daiC95r4iBchTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cFmSAdesJ5UJXlDbH24V3KoyTrhUUm5YLm4nqgF2/xVJkA7Az4uXvbSO0EEg2nSqyj76qavcHlqdj2ZWThh7gQnO39znkvSmZDUw9ZmFBLZkPnrPHVVilK6SVv6nHCoe00HIvO9Ub9vJ342yXc1tDj9vr4FEjSSXEZvRoOeJ9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB4M3V9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A3C4CED6;
	Thu, 16 Jan 2025 15:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737039854;
	bh=w1MHbKjB2/ctEbaOXc8wsyvMohS92daiC95r4iBchTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WB4M3V9tI4/JPzRVohwMQEwV2ahG5FFk8F3oRPx8P8/kGLx56JkTAI7wl3pQEH/t6
	 4FmU21+tW1PL0FaJ2IOBjiB6izKlkDRXBI4z/UOXPD4m7cuO1NkA4r2zGJBKtbx//Q
	 3/PuLik69PSt3cQnS6oSZnmpgunuq9COI64MfNWqwNyhLS4AeOEgsBd/RO2GZQ8O8G
	 sG8tx/QVMLdtE15Kfswko3Y0X7Zv/T5gKz79RfJ3gbQ5qfyCqES/E5hdyNnCy2L2DG
	 LU6MLkj46ODtXCMMlbhjEqcSANZn1Ttn6X9zhCHn61jDaqP1t6MzZGjSgVvmwT+UZi
	 sFxzXJBsCqQTw==
Date: Thu, 16 Jan 2025 09:04:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v1] misc: pci_endpoint_test: Fix irq_type to
 convey the correct type
Message-ID: <20250116150412.GA581512@bhelgaas>
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

Apparently this test fails (with an error message) when it shouldn't?
Please include the error message here.

"... since this global variable is referenced ..." is not quite enough
explanation of how this causes a spurious test failure or under what
circumstances the failure occurs.

> And the type set in pci_endpoint_test_set_irq() isn't reflected in
> the global "irq_type", so ioctl(PCITEST_GET_IRQTYPE) returns the previous
> type. As a result, the wrong type will be displayed in "pcitest".

The global "irq_type" seems a little suspect.  Is it possible to run
multiple tests concurrently?  If so, is this usage safe from races?

> This patch fixes these two issues.
> 
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index e73b3078cdb6..854480921470 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -235,7 +235,7 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return true;
>  
>  fail:
> -	switch (irq_type) {
> +	switch (test->irq_type) {
>  	case IRQ_TYPE_INTX:
>  		dev_err(dev, "Failed to request IRQ %d for Legacy\n",
>  			pci_irq_vector(pdev, i));
> @@ -739,6 +739,7 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  	if (!pci_endpoint_test_request_irq(test))
>  		goto err;
>  
> +	irq_type = test->irq_type;
>  	return true;
>  
>  err:
> -- 
> 2.25.1
> 

