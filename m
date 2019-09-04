Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F87A7A8A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 07:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfIDFEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 01:04:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42657 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDFEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 01:04:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so10527431pgb.9
        for <linux-pci@vger.kernel.org>; Tue, 03 Sep 2019 22:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lsq82oNvBEQIeF0WKJ+0h4DDWoEVAOmpOmGGWPrimjg=;
        b=sSX9+LYSky7pVINOhuiSGCpzJfa3HJmKQK2ENjGQS8trcc5Ge/BA3AImBjV67Btlly
         kXba3zW5GwwxPfXhf+29/2SxuIHn1gx3Cd8o0O+kEF8wXV0j5ORhJBc3n9a9III/2ZFr
         H5L2KmnULH1LaMxIRXIgMGl8+6walA0wD4LSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsq82oNvBEQIeF0WKJ+0h4DDWoEVAOmpOmGGWPrimjg=;
        b=DmouXN6ugJN6i4waie+pbdU+tjUB0kn4LxliTMFiLoKoA9W66d5xaTzuOgkvpu/tDt
         SLX9MnIlACRJWKwcNQkn6U+lBjkjdnZYQrATkxM7FGAFRKHOmtNXib8YFPR7lIre66XQ
         ee4XedhhQnR1XoDKBFFzQESNkFNo1U1HFsA3lhmLfVe88/LVSCeUBO4HspMSeNxoEbLk
         HJUZcdGbZbzzGyEV+mWSU6NTRJINZCo2o0ZMlRqNCUVE0dXzYlYmmdTG4y/1AVcg6mrx
         ONKKsHVIy/iADu+QYX8b7EfhxPynHNqE8q7Aaa1PXh01nvEQreVnfUQPewAlO4Kko4Vm
         gKQw==
X-Gm-Message-State: APjAAAUW+ST2p+Uzy/4pgBjfF12Kv/beuoChFfFk7vPxU1ZB2lG4uNN0
        YFOCDacDm7HF3jMxK69x3PTYOA==
X-Google-Smtp-Source: APXvYqx8+aLwpBI+yL/JAJGP3WN6LgZfckQim9p28+3ijWVor59if0jY7IKKr1PZPerfiDio+JKCdA==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr3042247pjr.1.1567573461329;
        Tue, 03 Sep 2019 22:04:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b13sm1185776pjz.10.2019.09.03.22.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 22:04:20 -0700 (PDT)
Date:   Wed, 4 Sep 2019 01:04:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] pci: Convert to use built-in RCU list checking
Message-ID: <20190904050419.GA102582@google.com>
References: <20190830231817.76862-1-joel@joelfernandes.org>
 <201909041108.RSjNvfDL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909041108.RSjNvfDL%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 12:06:43PM +0800, kbuild test robot wrote:
> Hi "Joel,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc7 next-20190903]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/pci-Convert-to-use-built-in-RCU-list-checking/20190901-211013
> config: x86_64-rhel-7.6 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 

This error seems bogus. I pulled -next and applied this patch and it builds
fine. I am not sure what is wrong with the 0day tree, and the above 0day link
is also dead.

What's going on with 0day ?!

thanks,

 - Joel

> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/pci/controller/vmd.c: In function 'vmd_irq':
> >> drivers/pci/controller/vmd.c:722:37: error: macro "list_for_each_entry_rcu" passed 4 arguments, but takes just 3
>         srcu_read_lock_held(&irqs->srcu))
>                                         ^
> >> drivers/pci/controller/vmd.c:721:2: error: unknown type name 'list_for_each_entry_rcu'
>      list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node,
>      ^~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/controller/vmd.c:723:28: error: expected ')' before '->' token
>       generic_handle_irq(vmdirq->virq);
>                                ^~
> >> drivers/pci/controller/vmd.c:721:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>      list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node,
>      ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/controller/vmd.c:717:18: warning: unused variable 'vmdirq' [-Wunused-variable]
>      struct vmd_irq *vmdirq;
>                      ^~~~~~
> 
> vim +/list_for_each_entry_rcu +722 drivers/pci/controller/vmd.c
> 
>    713	
>    714	static irqreturn_t vmd_irq(int irq, void *data)
>    715	{
>    716		struct vmd_irq_list *irqs = data;
>    717		struct vmd_irq *vmdirq;
>    718		int idx;
>    719	
>    720		idx = srcu_read_lock(&irqs->srcu);
>  > 721		list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node,
>  > 722					srcu_read_lock_held(&irqs->srcu))
>  > 723			generic_handle_irq(vmdirq->virq);
>    724		srcu_read_unlock(&irqs->srcu, idx);
>    725	
>    726		return IRQ_HANDLED;
>    727	}
>    728	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


