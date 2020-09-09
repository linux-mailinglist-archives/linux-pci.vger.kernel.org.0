Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C626314A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 18:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIIQFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 12:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbgIIQFb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Sep 2020 12:05:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F890221F0;
        Wed,  9 Sep 2020 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599662522;
        bh=7K2eO9jPx1PtH/qWBKEyBPB9rN9mQMh2Ofq/ElKKAOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iIVQ29xVqxgNUylRVXX0xccX137OyWmME3383P325tQavNGASGciGVho0t1XPdtJo
         F3U1v953CNGmcmuLZy2xC37aogH7jCYuqLBfTIjO8UGWI1VNEa2hU+2ZPoxPb42ON2
         NnzsYWhFMTlGDgN67nXKSh5BcioInPjSaomOrcc0=
Date:   Wed, 9 Sep 2020 09:42:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-acpi@vger.kernel.org, tn@semihalf.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, steven.price@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, sudeep.holla@arm.com, guohanjun@huawei.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI/ACPI: Suppress missing MCFG message
Message-ID: <20200909144201.GA705392@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908210359.569294-1-jeremy.linton@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 04:03:59PM -0500, Jeremy Linton wrote:
> MCFG is an optional ACPI table. Given there are machines
> without PCI(e) (or it is hidden) we have been receiving
> queries/complaints about what this message means given
> its being presented as an error.
> 
> Lets reduce the severity, the ACPI table list printed at
> boot will continue to provide another way to detect when
> the table is missing.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied to pci/enumeration with Hanjun's reviewed-by, thanks!

> ---
>  drivers/acpi/pci_mcfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 54b36b7ad47d..c8ef3bb5aa00 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -280,5 +280,5 @@ void __init pci_mmcfg_late_init(void)
>  {
>  	int err = acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
>  	if (err)
> -		pr_err("Failed to parse MCFG (%d)\n", err);
> +		pr_debug("Failed to parse MCFG (%d)\n", err);
>  }
> -- 
> 2.25.4
> 
