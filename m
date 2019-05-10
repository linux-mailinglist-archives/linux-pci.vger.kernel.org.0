Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6374F1A19A
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2019 18:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfEJQfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 May 2019 12:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfEJQfy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 May 2019 12:35:54 -0400
Received: from localhost (50-81-62-123.client.mchsi.com [50.81.62.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77C9921479;
        Fri, 10 May 2019 16:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557506153;
        bh=k3Ms6Wn4UON0Tqh2UFjVeKLXcaZSVeAREDPXexDcuGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4Jn1JnpqhIgoEiVmeMjiPasn2u2Fw0Om4KatZACO0J2C+339sTKvDUaQ+lquvV54
         Wnwi6nY0vkW3nRTubpeGRSwSkw5fbBfWJIsExrceGZU0AqYVS/7aTx7cDrBpgxr574
         mHut5v+Kv5EsLAa09bjKJnoIDXlSi6T+6FzGjxeU=
Date:   Fri, 10 May 2019 11:35:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hou Zhiqiang <zhiqiang.hou@nxp.com>,
        Karthikeyan M <m.karthikeyan@mobiveil.co.in>
Cc:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH 1/1] PCI: mobiveil: Update maintainers list
Message-ID: <20190510163551.GH235064@google.com>
References: <1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <20190510134811.GG235064@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510134811.GG235064@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 10, 2019 at 08:48:11AM -0500, Bjorn Helgaas wrote:
> On Tue, May 07, 2019 at 07:45:16AM -0400, Subrahmanya Lingappa wrote:
> > Add Karthikeyan M and Z.Q. Hou as new maintainers of Mobiveil controller
> > driver.
> > 
> > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> 
> I'd like to include this ASAP so patches get sent to the right place,
> and I want to make sure we spell the names and email addresses
> correctly.
> 
> Zhiqiang, you consistently use "Hou Zhiqiang <Zhiqiang.Hou@nxp.com>"
> for sign-offs [1] (except for "Z.q. Hou" in email headers).  Can you
> ack that the updated patch below is correct for you?
> 
> Karthikeyan, I don't see any email or commits from you yet, so I'd really
> like your ack along with the canonical name/email address you prefer.
> There is another Karthikeyan already in MAINTAINERS, so hopefully we can
> avoid any confusion.
> 
> [1] git log --format="%an <%ae>" --author=[Zz]hiqiang

I went ahead and applied the patch below for v5.2, but if you want to
tweak the names/addresses, I can update them if you tell me soon.

> commit d260ff8d3353
> Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> Date:   Tue May 7 07:45:16 2019 -0400
> 
>     MAINTAINERS: Add Karthikeyan M and Hou Zhiqiang for Mobiveil PCI
>     
>     Add Karthikeyan M and Hou Zhiqiang as new maintainers of Mobiveil
>     controller driver.
>     
>     Link: https://lore.kernel.org/linux-pci/1557229516-6870-1-git-send-email-l.subrahmanya@mobiveil.co.in
>     Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>     [bhelgaas: update names/email addresses to match usage in git history]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b548..42d7f44cc0e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11880,7 +11880,8 @@ F:	include/linux/switchtec.h
>  F:	drivers/ntb/hw/mscc/
>  
>  PCI DRIVER FOR MOBIVEIL PCIE IP
> -M:	Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> +M:	Karthikeyan M <m.karthikeyan@mobiveil.co.in>
> +M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
