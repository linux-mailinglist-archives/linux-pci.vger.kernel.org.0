Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5A8183365
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 15:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCLOmA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 10:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgCLOl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 10:41:59 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFC5206E7;
        Thu, 12 Mar 2020 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584024119;
        bh=rwALx85sL9uxz9h24BYrbFnTq6oyh/cOVDhdniakHzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1XtiEyLN/mnOQ3bewdx1k97d0rs0nBAo4iMJlADMpY54tvJoyAfqZRVkn+pY3Mear
         H3fiV7NixjRk6sHXRrkbfsjJ8wm/5LNnZN+pQJKFaS+gH1B2Iw/0gy43OnwJKu+JXo
         g4f5WXrBhK/85gaNhjO46JDvgsgtlva/prm2iMWw=
Date:   Thu, 12 Mar 2020 09:41:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     paulus@samba.org, mpe@ellerman.id.au, tyreld@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: rpaphp: remove set but not used variable
 'value'
Message-ID: <20200312144157.GA110750@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312143800.GA109542@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 12, 2020 at 09:38:02AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 12, 2020 at 10:04:12PM +0800, Chen Zhou wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> > 
> > drivers/pci/hotplug/rpaphp_core.c: In function is_php_type:
> > drivers/pci/hotplug/rpaphp_core.c:291:16: warning:
> > 	variable value set but not used [-Wunused-but-set-variable]
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> 
> Michael, if you want this:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> If you don't mind, edit the subject to follow the convention, e.g.,
> 
>   PCI: rpaphp: Remove unused variable 'value'
> 
> Apparently simple_strtoul() is deprecated and we're supposed to use
> kstrtoul() instead.  Looks like kstrtoul() might simplify the code a
> little, too, e.g.,
> 
>   if (kstrtoul(drc_type, 0, &value) == 0)
>     return 1;
> 
>   return 0;

I guess there are several other uses of simple_strtoul() in this file.
Not sure if it's worth changing them all, just this one, or just the
patch below as-is.

> > ---
> >  drivers/pci/hotplug/rpaphp_core.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
> > index e408e40..5d871ef 100644
> > --- a/drivers/pci/hotplug/rpaphp_core.c
> > +++ b/drivers/pci/hotplug/rpaphp_core.c
> > @@ -288,11 +288,10 @@ EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
> >  
> >  static int is_php_type(char *drc_type)
> >  {
> > -	unsigned long value;
> >  	char *endptr;
> >  
> >  	/* PCI Hotplug nodes have an integer for drc_type */
> > -	value = simple_strtoul(drc_type, &endptr, 10);
> > +	simple_strtoul(drc_type, &endptr, 10);
> >  	if (endptr == drc_type)
> >  		return 0;
> >  
> > -- 
> > 2.7.4
> > 
