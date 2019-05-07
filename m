Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4538B16DA2
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfEGWup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 18:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfEGWuo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 18:50:44 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F12C20825;
        Tue,  7 May 2019 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557269443;
        bh=ofR3gf9a2nJrY32VNWR52pwsavGPKy11KlcaF1ruQMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8HzuDChdiOCMVNfo6MM2W2+skr7rZ7yqDAdrkY5qs9eIMnRp9/T266gImhjkjwOH
         XGyOFGjN0XQBobQTOEpjMAbDqoANwEm/Livn+aRBsNBBgJQ2QxuleZvvEdB/6d3ZOA
         RvQaju98/7G49oPyocYm9tfnBfnN6/JwMtxT5xao=
Date:   Tue, 7 May 2019 17:50:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: Cleanup printk logging
Message-ID: <20190507225040.GF156478@google.com>
References: <1555733026-19609-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555733026-19609-1-git-send-email-mohankumar718@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mohan,

On Sat, Apr 20, 2019 at 07:03:46AM +0300, Mohan Kumar wrote:
> Replace printk with pr_* to avoid checkpatch warnings.

This looks fine, and I applied it to pci/printk with the intent of
putting it in v5.2.  I squashed in some pieces of your second patch,
and I'll respond to that one with the details.

When you post more than one patch in a series, it's nice to include a
cover letter where I can respond to the series as a whole.

> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/pci/pci-acpi.c | 11 ++++-------
>  drivers/pci/quirks.c   |  2 +-
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index e1949f7..3ada026 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -140,8 +140,7 @@ static acpi_status decode_type0_hpx_record(union acpi_object *record,
>  		hpx->t0->enable_perr     = fields[5].integer.value;
>  		break;
>  	default:
> -		printk(KERN_WARNING
> -		       "%s: Type 0 Revision %d record not supported\n",
> +		pr_warn("%s: Type 0 Revision %d record not supported\n",
>  		       __func__, revision);
>  		return AE_ERROR;
>  	}
> @@ -169,8 +168,7 @@ static acpi_status decode_type1_hpx_record(union acpi_object *record,
>  		hpx->t1->tot_max_split = fields[4].integer.value;
>  		break;
>  	default:
> -		printk(KERN_WARNING
> -		       "%s: Type 1 Revision %d record not supported\n",
> +		pr_warn("%s: Type 1 Revision %d record not supported\n",
>  		       __func__, revision);
>  		return AE_ERROR;
>  	}
> @@ -211,8 +209,7 @@ static acpi_status decode_type2_hpx_record(union acpi_object *record,
>  		hpx->t2->sec_unc_err_mask_or   = fields[17].integer.value;
>  		break;
>  	default:
> -		printk(KERN_WARNING
> -		       "%s: Type 2 Revision %d record not supported\n",
> +		pr_warn("%s: Type 2 Revision %d record not supported\n",
>  		       __func__, revision);
>  		return AE_ERROR;
>  	}
> @@ -272,7 +269,7 @@ static acpi_status acpi_run_hpx(acpi_handle handle, struct hotplug_params *hpx)
>  				goto exit;
>  			break;
>  		default:
> -			printk(KERN_ERR "%s: Type %d record not supported\n",
> +			pr_err("%s: Type %d record not supported\n",
>  			       __func__, type);
>  			status = AE_ERROR;
>  			goto exit;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f9cd4d4..06af0c3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2613,7 +2613,7 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
>  	pci_read_config_dword(dev, 0x74, &cfg);
>  
>  	if (cfg & ((1 << 2) | (1 << 15))) {
> -		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
> +		pr_info("Rewriting IRQ routing register on MCP55\n");
>  		cfg &= ~((1 << 2) | (1 << 15));
>  		pci_write_config_dword(dev, 0x74, cfg);
>  	}
> -- 
> 2.7.4
> 
