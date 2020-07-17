Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96BA223D30
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgGQNo0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 09:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQNoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 09:44:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6981C061755;
        Fri, 17 Jul 2020 06:44:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so5468811plk.1;
        Fri, 17 Jul 2020 06:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sezc8BEaAsci2qRl6XqFw9UDk0/wq5kFcGC+Dp/OyBQ=;
        b=FVcLwzmoaBr0LiHpbPSSdTiQr7RKnDOCXUurChJ7G8lukDFKJktcOpfMc4sSK6cFnY
         j4Fgw83mnCThVlIYPJFEEL8rXo9jYs8ShspntkEYgw+i7sLY/nQOb7OXS4EeaGs2sy7b
         0+jz5Dcd+49D0Vbr7ynWanMW0wy1W0sDxKuzp3wm/+hon6woOAd+U+2pQ+liNUrCO+QO
         7g9zLnAuaiX89s6KAH+d5scZJXW0F/fnDjZJtVyaott3z2oXZO4QhHf8DJ5a/g8COP6x
         CKjF7O0glH0WNU20PjqRsqGoaFsdFFsGmd3RJtc7wH0SzTSrtJmLdY31C3F783XiFMBv
         M9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sezc8BEaAsci2qRl6XqFw9UDk0/wq5kFcGC+Dp/OyBQ=;
        b=t6v/B+AsXTnOYvs6rEYS70K8X3zIpA5YyjhG3Ah5w3yiM/eMDYayCEpjcdYSt8ZuZv
         B1lLWdnQzqld2fO8XAQM9rXbJnO1Dw9/daU7rG1hyDWwWjrdTW3yuVNMTnq3SX6Vd6hQ
         //mvYHFzZESvwgZfUcFyaHlhEk+ytVGuu3zR2QwigJ78U/7u740USedYhc2O7rvJlWm9
         WleoWhG+B+8RoMiIkQbdvMy2h7cly+Lu+InQcWoJWZJ9oH/53+pILVvROM25ufvGhqQQ
         6XwwybjpWFCOF21DELyS/NJt3N6pLMWuwOMbBOOIhLpyNzhWHvnHBT8Ejxl4KxMrV5Xh
         /MbA==
X-Gm-Message-State: AOAM533QX/8eThVNeT/VR9kDdwCPO5eFYyTH4lNuLS6SQ5tK1131xZuQ
        NmGkcv3rRw6cPOvr/icpE1A=
X-Google-Smtp-Source: ABdhPJxLL8ZoJHEbuhUDQrrje5GwwAu3Dz0dB4NWevRgKQh1dlphcFY7EYaUPDEebY0iFVOhI2TPjw==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr7774857pls.244.1594993465202;
        Fri, 17 Jul 2020 06:44:25 -0700 (PDT)
Received: from localhost ([89.208.244.139])
        by smtp.gmail.com with ESMTPSA id u188sm8028426pfu.26.2020.07.17.06.44.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jul 2020 06:44:24 -0700 (PDT)
Date:   Fri, 17 Jul 2020 21:44:19 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: controller: Remove duplicate error message
Message-ID: <20200717134419.GA24896@nuc8i5>
References: <20200526150954.4729-1-zhengdejin5@gmail.com>
 <1d7703d5c29dc9371ace3645377d0ddd9c89be30.camel@amazon.com>
 <20200527132005.GA7143@nuc8i5>
 <1b54c08f759c101a8db162f4f62c6b6a8a455d3f.camel@amazon.com>
 <CAL_JsqJWKfShzb6r=pXFv03T4L+nmNrCHvt+NkEy5EFuuD1HAA@mail.gmail.com>
 <20200706155847.GA32050@e121166-lin.cambridge.arm.com>
 <20200711074733.GD3112@nuc8i5>
 <20200715164559.GC3432@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715164559.GC3432@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 15, 2020 at 05:45:59PM +0100, Lorenzo Pieralisi wrote:
> On Sat, Jul 11, 2020 at 03:47:33PM +0800, Dejin Zheng wrote:
> > On Mon, Jul 06, 2020 at 04:58:47PM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Jun 02, 2020 at 09:01:13AM -0600, Rob Herring wrote:
> > > 
> > > [...]
> > > 
> > > > > The other 2 error cases as well don't print the resource name as far as
> > > > > I recall (they will at least print the resource start/end).
> > > > 
> > > > Start/end are what are important for why either of these functions
> > > > failed.
> > > > 
> > > > But sure, we could add 'name' here. That's a separate patch IMO.
> > 
> > Hi Lorenzo, Bob and Jonathan:                                                                                                     
> > 
> > Thank you very much for helping me review this patch,
> 
> I merge this patch in pci/misc, thanks.
> 
> > I sent a new patch for print the resource name when the request memory
> > region or remapping of configuration space fails. and it is here:
> > https://patchwork.kernel.org/patch/11657801/
> 
> We will get to it soon.
>
> Lorenzo

Lorenzo, Thanks very much!

Dejin

