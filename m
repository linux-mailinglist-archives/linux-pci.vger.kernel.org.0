Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12FD489E1F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiAJRM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 12:12:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:45869 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238040AbiAJRM6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 12:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641834778; x=1673370778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifmtXYn73SEXT+bTNG5FPL1SkH5wV8qe2pa7C4w2axE=;
  b=btZstPD4hziRwY62GqkQl3IC1lgYzG4nKBNNMMLRzL95nrpM/2W1qOpB
   kXiRHBIK1iRijv4ZbNyVL0q10zwR/fgJcCDRpFyD9vjvwnggYYUqzwnbG
   V3dgOUril72ljCwZJUe5KRB4sx5KUyJOys8YengWP1apRoEhf3HjIx6XU
   RqIp8bgrRpgAvCdIAsjl0xxwKFQYY8VcM06iLy4CnzXG8F/jGXehKGiW3
   nzJMnW803GtYLNfZ7wvptc0DlMDMaz74Hia6ll33Wqx+hDIGgfrRLRkmi
   NYlb2U+I1UdnRWUvZbCaK3LTmMDxED2JibIDqCt6AR7czsRlHjpzYI7I8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243066789"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243066789"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:11:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="622739388"
Received: from ryanjor-mobl.amr.corp.intel.com (HELO intel.com) ([10.255.36.174])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 09:11:55 -0800
Date:   Mon, 10 Jan 2022 12:11:54 -0500
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Intel-gfx] [PATCH v3 2/3] x86/quirks: Improve line wrap on
 quirk conditions
Message-ID: <Ydxo2jTmb3W7IxDx@intel.com>
References: <20220107210516.907834-1-lucas.demarchi@intel.com>
 <20220107210516.907834-2-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107210516.907834-2-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 01:05:15PM -0800, Lucas De Marchi wrote:
> Remove extra parenthesis and wrap lines so it's easier to read what are
> the conditions being checked. The call to the hook also had an extra
> indentation: remove here to conform to coding style.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  arch/x86/kernel/early-quirks.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index 8b689c2b8cc7..df34963e23bf 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -767,14 +767,12 @@ static int __init check_dev_quirk(int num, int slot, int func)
>  	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
>  
>  	for (i = 0; early_qrk[i].f != NULL; i++) {
> -		if (((early_qrk[i].vendor == PCI_ANY_ID) ||
> -			(early_qrk[i].vendor == vendor)) &&
> -			((early_qrk[i].device == PCI_ANY_ID) ||
> -			(early_qrk[i].device == device)) &&
> -			(!((early_qrk[i].class ^ class) &
> -			    early_qrk[i].class_mask)))
> -				early_qrk[i].f(num, slot, func);
> -
> +		if ((early_qrk[i].vendor == PCI_ANY_ID ||
> +		     early_qrk[i].vendor == vendor) &&
> +		    (early_qrk[i].device == PCI_ANY_ID ||
> +		     early_qrk[i].device == device) &&
> +		    !((early_qrk[i].class ^ class) & early_qrk[i].class_mask))
> +			early_qrk[i].f(num, slot, func);
>  	}
>  
>  	type = read_pci_config_byte(num, slot, func,
> -- 
> 2.34.1
> 
