Return-Path: <linux-pci+bounces-21091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048B2A2F265
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2220164CE9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9B244E99;
	Mon, 10 Feb 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZR77zNc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C235244E8A;
	Mon, 10 Feb 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203316; cv=none; b=Ik58fsKYQM8/B2LXC4MDnP0wPpqOej9Is1053SimzREkCU2r0JXimc5KwymI2hNTFPKewwxP1yr4e4PGUSVUUsqvI4zgvdS8rkZj1MwO1N7b4gtBqblra5mf5k3IfF5Jr4OTmjOUNAyuhUQxgeptloZ9LDtTldjl9WEemQcBBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203316; c=relaxed/simple;
	bh=KgsQFKr9kZXuSxFXBCI+ddBpGxj4Ol0vJGkM0lyg/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlZPkp+YE39NCGQR3Q31wjRNtnJeFgzzLpu0tZmjMKomV7m+vKUEgYyiMl0VC8fcVIfjguO9NkXLbKJ17mo1DjGyfIQ/TtJ5uQ3KEQhuIe6w0sdG3T5qihlNu7FhG7lzPzJEB2ilhLXnRXQLoReT83J+2oWZvdby/zNxPXu8Zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZR77zNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220E7C4CEE5;
	Mon, 10 Feb 2025 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203315;
	bh=KgsQFKr9kZXuSxFXBCI+ddBpGxj4Ol0vJGkM0lyg/QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZR77zNcmbEatn6Nlvm/AtrwdTa9H2zBG4fcD021/7mzvZqFiI9N54xKvCZXB/h3A
	 ZhQfUlRsf2L47MDuw75fl6dh43LQTM1/Qnesrse+kZUK10zdX6ny6NrJyJRFDRwIsU
	 MLAQ+vLyZPxztzLnnTAIo0XiFklB2SGKEZDfPxhdb69xEXMHXP7yiVVwckCzaqglT8
	 PQ29juUMysxLBwo6Ob98bSQB+sBfjHvlDpePGTIyIToGDChfgVkeaPD3dmeys9E2L5
	 PJJnoHP9/wfUHc2CImMyjRq/aMJMp0S9UoWWBoWMxA5RumEAeHOBNl2LwX7Rq9qog+
	 OYqi0QDq1mH7w==
Date: Mon, 10 Feb 2025 17:01:50 +0100
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
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <Z6oi7lH7hhA3uN46@ryzen>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>

On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, "irq_type" as global and test->irq_type.
> 
> The global is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> The type set in this function isn't reflected in the global "irq_type",
> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> As a result, the wrong type will be displayed in "pcitest" as follows:
> 
>     # pcitest -i 0
>     SET IRQ TYPE TO LEGACY:         OKAY
>     # pcitest -I
>     GET IRQ TYPE:           MSI
> 
> Fix this issue by propagating the current type to the global "irq_type".
> 
> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index f13fa32ef91a..6a0972e7674f 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -829,6 +829,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  		return ret;
>  	}
>  
> +	irq_type = test->irq_type;

It feels a bit silly to add this line, when you remove this exact line in
the next patch. Perhaps just drop this patch?


Kind regards,
Niklas

