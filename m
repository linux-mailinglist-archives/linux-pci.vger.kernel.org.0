Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09472310C9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgG1RYC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 13:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgG1RYC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 13:24:02 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CD620786;
        Tue, 28 Jul 2020 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595957042;
        bh=J7PlcIY7lyy+tuqnTqFQUHSTkLDFXKdfKJeJk9zzoH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tqZ3lnybFORQuJJbhz7ZifkVZWlBK7MKbeO6NQ2OeU9y4CaauT6MJs/T6t4dNpfIz
         DW4RCHzWuA+XfRvVWDyy4BTTVy7mnZAcTtFe9I8ca2cTKcys1RczXHpuTZ/3YPSHoD
         Au8pUtBWpE9Xrur36ALET1wAsX1oFLjYm8oMkNRw=
Date:   Tue, 28 Jul 2020 12:23:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: vc: Fix kerneldoc
Message-ID: <20200728172359.GA1846504@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728171045.28606-1-krzk@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch looks fine, but can you run "git log --oneline drivers/pci/vc.c"
and match the subject line style?

On Tue, Jul 28, 2020 at 07:10:45PM +0200, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>     drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pci/vc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
> index 5486f8768c86..5fc59ac31145 100644
> --- a/drivers/pci/vc.c
> +++ b/drivers/pci/vc.c
> @@ -172,7 +172,6 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
>   * @dev: device
>   * @pos: starting position of VC capability (VC/VC9/MFVC)
>   * @save_state: buffer for save/restore
> - * @name: for error message
>   * @save: if provided a buffer, this indicates what to do with it
>   *
>   * Walking Virtual Channel config space to size, save, or restore it
> -- 
> 2.17.1
> 
