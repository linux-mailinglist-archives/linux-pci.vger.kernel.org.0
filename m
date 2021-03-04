Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0932CB74
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 05:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhCDElM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 23:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhCDEk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 23:40:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA83C061574
        for <linux-pci@vger.kernel.org>; Wed,  3 Mar 2021 20:40:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso3952198pjk.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Mar 2021 20:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SpcbDVmRqFNq4jiEcFBJPIdb5VQK/AyECyUcyP3VJwQ=;
        b=cgCTgg+yYRnpBZDy0oDzkLb//gOYIdp8+nQx/9ooEMrFvyMJufQ+vlDaVKjijG6aKE
         m7mUqx+drfhvvf/lz0D7NFURHAUlwdQEfD+yY8eU283fW66ya16kbkQ3Fq1ukiaJo4Zz
         gc/uc3DJRJ0JUVpGawj2V1KKBergXel0quuRDi1AcCqf6PuCNRHKjFwSfJp1+L+S8iGe
         OZt1wxiNim1yDBcRCj4ylXS3NefPgrVeNs27bUNHAWXCLk1RV7EgTbX6Iv+o3ERJp1Ms
         W2suK/sMv7TX/g96VC584bFqbUW5DUWJXtB00SHxoNtZ7CtNViujyoPWp26aDJANiteF
         4yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SpcbDVmRqFNq4jiEcFBJPIdb5VQK/AyECyUcyP3VJwQ=;
        b=iKX/o64YJz88eh2cPA6QZDjUxDaTO7vpjE5nLyrSlHLozmVvdoHlX7M+nW56D4mMEo
         ayEJEa+WCP8zz6j7TZGyl6Mue2Z34x8vgjo41zXUBpK9w/G70JW7vCvOXsC0yBdBXUF2
         uDwoiDck+7oSsAZxquaLZiY/nHfZMudXmVnM1hLDtsNqH4K2pk7pdMX7YPKD7iwokd8m
         ZNP1rWteZKm6sKVS/gzY/IH+dppPvPB6P2u1bNVhr6VgshYxYsO5Zf+liAVIte0e4ahS
         QNwiDF+rXahY9SbeUdiy0N7IEjmShn1vJPnBvygaVVFt9oKEXzeFAXzgspYepclRQ4XD
         quLg==
X-Gm-Message-State: AOAM5330cU+1a2OjwC2I0Kp0354+rMaKijBSgB+xPPG+JuDuF4OEg8VV
        AVePlCA+A+r0jMGWILb+rl0=
X-Google-Smtp-Source: ABdhPJwhOKsR/a60si2IPq8i8t4IcatCnyOb2OuEU/EaMDW5qGVaoNv41iz2vgYEhZ492USuhfV92g==
X-Received: by 2002:a17:902:b609:b029:e3:4b8d:994 with SMTP id b9-20020a170902b609b02900e34b8d0994mr2271643pls.44.1614832816621;
        Wed, 03 Mar 2021 20:40:16 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id z16sm24415051pgj.51.2021.03.03.20.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 20:40:16 -0800 (PST)
Date:   Thu, 4 Mar 2021 13:40:13 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] PCI: Take __pci_set_master in do_pci_disable_device
Message-ID: <20210304044013.GA15757@localhost.localdomain>
References: <20210214110637.24750-1-minwoo.im.dev@gmail.com>
 <YCloAA+od1WIo7o3@rocinante>
 <20210215132220.GA32476@localhost.localdomain>
 <YDbXKHB31nz+tKjR@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDbXKHB31nz+tKjR@rocinante>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-24 23:46:00, Krzysztof Wilczyński wrote:
> Hi Minwoo,
> 
> Sorry for a very late reply!
> 
> [...]
> > > You might need to improve the subject a little - it should be brief but
> > > still informative.
> > > 
> > > > __pci_set_mater() has debug log in there so that it would be better to
> > > > take this function.  So take __pci_set_master() function rather than
> > > > open coding it.  This patch didn't move __pci_set_master() to above to
> > > > avoid churns.
> > > [...]
> > > 
> > > It would be __pci_set_master() in the sentence above.  Also, perhaps
> > > "use" would be better than "take".  Generally, this commit message might
> > > need a little improvement to be more clear why are you do doing this.
> > 
> > Sure, if we consolidate bus master enable clear functions to a single
> > one, it would be better to debug and tracing the kernel behaviors.
> > 
> > Let me describe this 'why' to the description.
> 
> Sounds great!  Thank you!
> 
> [...]
> > > You could use pci_clear_master(), which we export and that internally
> > > calls __pci_set_master(), so there would be no need to add any forward
> > > declarations or to move anything around in the file.
> > 
> > Moving delcaration to above might be churn, and I agree with your point.
> 
> I am sure that when it makes sense, then probably folks would not
> object, especially since "churn" can be subjective.
> 
> > > Having said that, there is a difference between do_pci_disable_device()
> > > and how __pci_set_master() works - the latter sets the is_busmaster flag
> > > accordingly on the given device whereas the former does not.  This might
> > > be of some significance - not sure if we should or should not set this,
> > > since the do_pci_disable_device() does not do that (perhaps it's on
> > > purpose or due to some hisoric reasons).
> > 
> > Thanks for pointing out this.  I think the difference about
> > `is_busmaster` flag looks like it should not be cleared in case of power
> > suspend case:
> > 
> > 	# Suspend
> > 	pci_pm_default_suspend()
> > 		pci_disable_enabled_device()
> > 
> > 	# Resume
> > 	pci_pm_reenable_device()
> > 		pci_set_master()  <-- This is based on (is_busmaster)
> > 
> > 
> > Please let me know if I'm missing here, and appreciate pointing that
> > out.  Maybe I can post v2 patch with add an argument of whether
> > `is_busmaster` shoud be set inside of the function or not to
> > __pci_set_master()?
> [...]
> 
> Nothing is ever simple, isn't it? :-)
> 
> We definitely need to make sure that PM can keep relying on the
> is_busmaster flag to restore bus mastering to previous state after the
> device would resume after being suspended.

Yes,

> If we add another boolean argument, then we would need to update the
> __pci_set_master() only in two other places, aside of using it in the
> do_pci_disable_device() function, as per (as of 5.11.1 kernel):

I agree with this approach.  I can try it by adding another bool
argument to decide whether to update the is_busmaster flag or not inside
of the __pci_set_master.

> 
>   File              Line Content
>   drivers/pci/pci.c 4308 __pci_set_master(dev, true);
>   drivers/pci/pci.c 4319 __pci_set_master(dev, false);
> 
> This is not all that terrible, provided that we _really_ do want to
> change this function signature and then add another condition inside.
> 
> What do you think?  If you still like the idea, then send second version
> over with all the other proposed changes.

Let me prepare the next version of this patch. Thanks!

> Krzysztof
