Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A111419CEA
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 19:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhI0Rfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 13:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238257AbhI0RcH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 13:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C624060E09;
        Mon, 27 Sep 2021 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632763626;
        bh=9PsfFOoHbXlMCe+jPXU3J7wTVsQAY/diJbDdmpSxYeg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HfoZMdRb1zsKazAKlj29yQWb/Jduc99R7KOz1tPzEFjgYKX4FJlKjINrEeSCAuQs0
         sM+n+Nq5SAdgnjQJnq0mT0R/wQ6RAVplvjcEWqHF/er2zbwdQ8xLFherbZ2daMA+jx
         f34YBZQpPNWZcA1tk4sBD5+W8rPyYMFeDOR2S2bVRX9/lL8GFslMawMGIuC4q+AJfF
         XlSXBTiWnwXcXoJZG4ANXL/aP8Vo/+3xwpM/AganCk5JeD3rVSXW8vtYmJOOvjriaR
         +9H9rVi86IoCDsv9Fn4rMH6hyeNsLWGaSKuJf8YZvyilx8HfQZE6hPCjP5GkNjyA5H
         TDelMTw+kohVw==
Date:   Mon, 27 Sep 2021 12:27:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Make use of the helper function
 devm_add_action_or_reset()
Message-ID: <20210927172704.GA658792@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922130009.639-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I like the patch; thanks for doing this for the last instance in
drivers/pci/.

If you repost, remove some words from the subject line, e.g.,

  befa45fb5bdd ("PCI: Use devm_add_action_or_reset()")

Yes, I'm OCD enough to look through the git history for similar
previous commits and make new changes match :)

On Wed, Sep 22, 2021 at 09:00:08PM +0800, Cai Huoqing wrote:
> The helper function devm_add_action_or_reset() will internally
> call devm_add_action(), and if devm_add_action() fails then it will
> execute the action mentioned and return the error code. So
> use devm_add_action_or_reset() instead of devm_add_action()
> to simplify the error handling, reduce the code.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index ed13e81cd691..cd387f235b7f 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -897,11 +897,9 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
>  		goto skip;
>  	}
>  
> -	ret = devm_add_action(dev, mvebu_pcie_port_clk_put, port);
> -	if (ret < 0) {
> -		clk_put(port->clk);
> +	ret = devm_add_action_or_reset(dev, mvebu_pcie_port_clk_put, port);
> +	if (ret < 0)
>  		goto err;
> -	}

Unrelated note: this function does things like this:

  if (...) {
    ret = -ENOMEM;
    goto err;
  }

  ...

  err:
    return ret;

which I think is pointless.  There's no cleanup to be done at "err",
so these places could simply "return -ENOMEM" instead, which is much
easier to read.

And this:

  if (reset_gpio == -EPROBE_DEFER) {
    ret = reset_gpio;
    goto err;
  }

Should say:

  if (reset_gpio == -EPROBE_DEFER)
    return -EPROBE_DEFER;

since we know the value we're returning.

Obviously this would be something for a different patch.

>  	return 1;
>  
> -- 
> 2.25.1
> 
