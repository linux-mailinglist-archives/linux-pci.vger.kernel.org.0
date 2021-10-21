Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C34435839
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 03:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhJUBao (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 21:30:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhJUBam (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Oct 2021 21:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DB096113D;
        Thu, 21 Oct 2021 01:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634779707;
        bh=zXzVqviu456oLsjo8YgHnuRG56yXJnGa0hkVNOri25c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rpeBmLsZBoUvQBodjY8byNtkpiGhQgb70QT2QZlPyznPRYSO8nIWLqfGpRXWEUfX8
         H5tTPW6iKEaatxMBLoFfk5AviyEy83dm7feYrN3UbqQOKHflEYUiW5T56RsApYhUrZ
         VVsxxI72/M9sWX9D1CbQtWoNh2OjEYY9g9xC3dj/4NPMnb9oFLyQVyveJG1D+9BKVQ
         ITj/buz4k470ST+0bGqaDGnwvyufHyCy5dAGeRI3j4jHB2OKldS2TkCJtemfBwo1JD
         8mjCCe7a6AeJyO7GNGFLpOwxFLsC3WtwZ8Vta0Sw1uhTSBA5PDKdj2eFr0aNkZaiql
         X2D2rPtakt6gQ==
Date:   Wed, 20 Oct 2021 20:28:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 1/8] PCI/AER: Remove ID from aer_agent_string[]
Message-ID: <20211021012826.GA2655655@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b2dae2a6ac340d9d45c28481d746ec1064cd6c.1633453452.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 05, 2021 at 10:48:08PM +0530, Naveen Naidu wrote:
> Currently, we do not print the "id" field in the AER error logs. Yet the
> aer_agent_string[] has the word "id" in it. The AER error log looks
> like:
> 
>   pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> 
> Without the "id" field in the error log, The aer_agent_string[]
> (eg: "Receiver ID") does not make sense. A user reading the
> aer_agent_string[] in the log, might inadvertently look for an "id"
> field and not finding it might lead to confusion.
> 
> Remove the "ID" from the aer_agent_string[].
> 
> The following are sample dummy errors inject via aer-inject.

I like this, and the problem it fixes was my fault because
these "ID" strings should have been removed by 010caed4ccb6.

If it's straightforward enough, it would be nice to have the
aer-inject command line here in the commit log to make it easier
for people to play with this.

> Before
> =======
> 
> In 010caed4ccb6 ("PCI/AER: Decode Error Source Requester ID"),
> the "id" field was removed from the AER error logs, so currently AER
> logs look like:
> 
>   pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03:0
>   pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID) <--- no id field
>   pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
>   pcieport 0000:00:03.0:    [ 6] BadTLP
> 
> After
> ======
> 
>   pcieport 0000:00:03.0: AER: Corrected error received: 0000:00:03.0
>   pcieport 0000:00:03.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver)
>   pcieport 0000:00:03.0:   device [1b36:000c] error status/mask=00000040/0000e000
>   pcieport 0000:00:03.0:    [ 6] BadTLP
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/pcie/aer.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9784fdcf3006..241ff361b43c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -516,10 +516,10 @@ static const char *aer_uncorrectable_error_string[] = {
>  };
>  
>  static const char *aer_agent_string[] = {
> -	"Receiver ID",
> -	"Requester ID",
> -	"Completer ID",
> -	"Transmitter ID"
> +	"Receiver",
> +	"Requester",
> +	"Completer",
> +	"Transmitter"
>  };
>  
>  #define aer_stats_dev_attr(name, stats_array, strings_array,		\
> @@ -703,7 +703,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	const char *level;
>  
>  	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent)\n",
>  			aer_error_severity_string[info->severity]);
>  		goto out;
>  	}
> -- 
> 2.25.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
