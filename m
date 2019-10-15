Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5886D8391
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbfJOWY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 18:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389809AbfJOWY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 18:24:26 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E622064A;
        Tue, 15 Oct 2019 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571178266;
        bh=7wD/sv1cp59b0s917sG2wb/i73fxap9yaREzOUv1GHk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Qa8FOoODC83mp3W205B7mOZ3mQ2bwlNINhhmwHUDDwntGVXNfzz/AN5WbUDcCC4Ss
         K7ureGdXByoli4H0GCReDKB63KkS8Gb6p7soa3E1+BxpwUAvrZ6zXEHlEFnm34z5Oz
         GjQ6H5CK2MmV/SZK0hMThsATz+SIX5hfTCeG9CWU=
Date:   Tue, 15 Oct 2019 17:24:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     gregkh@linuxfoundation.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH v3 1/2] PCI/AER: Add PoisonTLPBlocked to Uncorrectable
 errors
Message-ID: <20191015222421.GA184682@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827222145.32642-1-rajatja@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 03:21:44PM -0700, Rajat Jain wrote:
> The elements in the aer_uncorrectable_error_string[] refer to
> the bit names in Uncorrectable Error status Register in the PCIe spec
> (Sec 7.8.4.2 in PCIe 4.0)
> 
> Add the last error bit in the strings array that was missing.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

I applied this to pci/aer for v5.5, thanks, Rajat!

> ---
> v3: same as v2
> v2: same as v1
> 
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..68060a290291 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -36,7 +36,7 @@
>  #define AER_ERROR_SOURCES_MAX		128
>  
>  #define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
> -#define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
> +#define AER_MAX_TYPEOF_UNCOR_ERRS	27	/* as per PCI_ERR_UNCOR_STATUS*/
>  
>  struct aer_err_source {
>  	unsigned int status;
> @@ -560,6 +560,7 @@ static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
>  	"BlockedTLP",			/* Bit Position 23	*/
>  	"AtomicOpBlocked",		/* Bit Position 24	*/
>  	"TLPBlockedErr",		/* Bit Position 25	*/
> +	"PoisonTLPBlocked",		/* Bit Position 26	*/
>  };
>  
>  static const char *aer_agent_string[] = {
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
