Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA634CD99
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhC2KGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhC2KGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 06:06:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C33B961554;
        Mon, 29 Mar 2021 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617012380;
        bh=dp9i7HGEz6oDg8aqbgCRQkx8FB6cKuXGX6UNZL72bPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0Ze7SzYCohtFzxkunLlymuuHOU9crBz379Bh5SKSABrFDjifbK4BmX/3ypThgoCN
         NxVpRUmOfshpJnrtrh/w3fGzYKp/lm4P2vm85eO+kZRItKgrCu8r/lcce7DQJcFukR
         KPfrvGO23Dvor073FYF44Oo7yRkwIhyCw81EPyx0=
Date:   Mon, 29 Mar 2021 12:06:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v8 5/5] FIX driver
Message-ID: <YGGmmfSO/tjYZB9k@kroah.com>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
 <20405596c759cf6cabca83e7a9cd90113fbea557.1617011282.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20405596c759cf6cabca83e7a9cd90113fbea557.1617011282.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 11:51:38AM +0200, Gustavo Pimentel wrote:
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/dw-xdata-pcie.c | 99 +++++++++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 42 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
