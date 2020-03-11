Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7454C182390
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 21:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgCKU50 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 16:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCKU50 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 16:57:26 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8862074B;
        Wed, 11 Mar 2020 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583960246;
        bh=CVyhT4H+DX0DacI0aDU2rrDA1x+xhJDNaeUuFIP4nF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VUD0j7nKmjxDZobJiq56bvXzKhaEUR55pEO3DuAZi0+CB7clO/c8gYzXyJhGzGMfD
         2i2JXmVHXbYVZsyl/oLQrSwPZUS0X+Sw0b+i6bl8MNUEsA3rGiEHWjxxPv+FkGhlHT
         WWMJrsOHLXuaNlCYvMAjH928NP0PRisw0hkbNx3k=
Date:   Wed, 11 Mar 2020 15:57:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aman Sharma <amanharitsh123@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] pci: handled return value of platform_get_irq
 correctly
Message-ID: <20200311205723.GA177532@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d12a15f496ca472e100798ac2cd256fbfc1de15d.1583952276.git.amanharitsh123@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Aman,

1) Check your mailer config.  These messages had no "To:" header, so
replying didn't work correctly.  I added "Cc: linux-pci" manually, but
on the mailing lists, the convention is to "reply-all" so everybody
can participate.

2) The cc list is a little bit overboard.
"$ ./scripts/get_maintainer.pl -f drivers/pci/controller/pci-v3-semi.c"
shows Linus W, Lorenzo, Andrew, myself, linux-pci, linux-kernel.
That's plenty.

3) Study "git log drivers/pci" and make your commit subjects and
logs match the convention in capitalization, sentence structure, verb
tense, etc.

4) Every commit must have non-empty log, even if the commit seems
trivial.  The log message should be independent of the subject.  The
subject is like an essay title; the log message is like the essay
body.  The body is separate from the title, not a continuation of it.

5) Function names in subjects and logs have "()" after them.

6) Cite previous similar work, e.g., mention ef75369a5b9a ("PCI:
altera: Fix platform_get_irq() error handling"), which is one of many
similar patches.

7) You mentioned similar issues with platform_get_irq_byname().
Please add patches in this series to fix them as well.

8) You asked about dev_err() usage.  See 6c9050a73469 ("irqchip:
Remove dev_err() usage after platform_get_irq()") and feel free to do
the same here.  If you do, cite that commit in your commit log.

I think the patches themselves look OK, and the series is correctly
structured with a cover letter and patches as responses to the cover.

When you post a revised series, make sure it's labeled "PATCH v2 0/5".

Thanks,
  Bjorn

On Thu, Mar 12, 2020 at 12:49:02AM +0530, Aman Sharma wrote:
> Signed-off-by: Aman Sharma <amanharitsh123@gmail.com>
> ---
>  drivers/pci/controller/pci-v3-semi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
> index bd05221f5a22..a5bf945d2eda 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -777,9 +777,9 @@ static int v3_pci_probe(struct platform_device *pdev)
>  
>  	/* Get and request error IRQ resource */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> +	if (irq < 0) {
>  		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
> -		return -ENODEV;
> +		return irq;
>  	}
>  	ret = devm_request_irq(dev, irq, v3_irq, 0,
>  			"PCIv3 error", v3);
> -- 
> 2.20.1
> 
