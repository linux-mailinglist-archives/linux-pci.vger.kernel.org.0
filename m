Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3E456E2F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 12:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhKSLbi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 06:31:38 -0500
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:46536 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230101AbhKSLbi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 06:31:38 -0500
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 06:31:38 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 4AC86184DB421
        for <linux-pci@vger.kernel.org>; Fri, 19 Nov 2021 11:20:14 +0000 (UTC)
Received: from omf03.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 88046886E7;
        Fri, 19 Nov 2021 11:20:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id D17E79000271;
        Fri, 19 Nov 2021 11:20:06 +0000 (UTC)
Message-ID: <d2df9558ddbc06ac50b7a9aef46445fdf76e7d6b.camel@perches.com>
Subject: Re: [PATCH v1 2/3] x86/quirks: Introduce
 hpet_dev_print_force_hpet_address() helper
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Date:   Fri, 19 Nov 2021 03:20:09 -0800
In-Reply-To: <20211119110017.48510-2-andriy.shevchenko@linux.intel.com>
References: <20211119110017.48510-1-andriy.shevchenko@linux.intel.com>
         <20211119110017.48510-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D17E79000271
X-Spam-Status: No, score=0.10
X-Stat-Signature: 6jk84mbae8ntn175y5s8hws3m8gd345d
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/+W1yEjgVba1zQb7u7nT0SyFnowotqIMM=
X-HE-Tag: 1637320806-965394
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-11-19 at 13:00 +0200, Andy Shevchenko wrote:
> Introduce hpet_dev_print_force_hpet_address() helper to unify printing
> forced HPET address. No functional change intended.

This probably reduces object code by a few bytes of text.

> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
[]
> @@ -68,6 +68,11 @@ static enum {
>  	ATI_FORCE_HPET_RESUME,
>  } force_hpet_resume_type;
>  
> +static void hpet_dev_print_force_hpet_address(struct device *dev)
> +{
> +	dev_printk(KERN_DEBUG, dev, "Force enabled HPET at 0x%lx\n", force_hpet_address);
> +}

And this might be better placed up a few lines immediately after

unsigned long force_hpet_address;

and before

enum {
	...
} force_hpet_resume_type;


