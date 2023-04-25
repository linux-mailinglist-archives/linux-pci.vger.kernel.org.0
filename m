Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167D6EE235
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjDYMuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYMuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 08:50:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F4CC31;
        Tue, 25 Apr 2023 05:50:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4eff055d4d3so2861107e87.3;
        Tue, 25 Apr 2023 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427018; x=1685019018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/L1524bvLGbme17s4CY8OJX5JQNg9iQE5TqvD4jJRHM=;
        b=fd3LWAtf/i5fUf9FB6O1Xo9wu5axOoLTl5lkJsToEzof8l9w2+/+D8xTl4TAcRgyf+
         ZrDKgPHY+lR0zvpYIlsfefc5ngC9eILaKtG+ahzRH7CRQsV4/Hl5Q+/kPAd640qD8yW8
         ZX+EuheGgwtV+hpDWmOoHkQnq8YNCbR5+S6Nf/7jhJtcj3qwxzB3t8d3FmBjofdQjdrs
         Tsnm/M/oR982P7USyj7famfohMQaTx8lg4apzS1UfqJzrv2+0nHozuiWGygAH+hlzzLb
         7c1wds57RXuZUyvHm82RXtetFf9B49IRzdQsM3OFdCu/7R3HtPizlWsQSUsCNMGGN3sA
         jWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427018; x=1685019018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/L1524bvLGbme17s4CY8OJX5JQNg9iQE5TqvD4jJRHM=;
        b=adXtR6s1XS1LfjegAs0W/v8pMjrJKFwsfuFdWURkuT04eqwbw7yxPLDGUQ8zYJELpR
         wkKIG4suydSlihtz34p8rPvobdJmHyg8M++5fSYZiWnuVMKJ7p4MwUmeYXZT8NhVsVZN
         hYC9Cuvetqc3KwdabvhrIgpvJ/pVX8qT+y5A2xoofELR2X3/WH6DRZDs6ToIbyzCLEeX
         dAe7g7LOVMPEV+ndNAkza7hd7GZNkL/6N2Lo+Va4SSIkVH9ZbVc8tl9ye+HFY9iWVjoI
         lalesymhJZbBWyt6vOgCqLFi2nzdWZ107Gp22ok2wpowXbFHGKGLaIBBud16Y3znTRfo
         ZfuA==
X-Gm-Message-State: AAQBX9dd13/p8XOJ5J7QKmt58WX6N6jKb7rPxtv2cRaoJfxvBoBDwi92
        PHEhWd1syN/MDd8vxskP73k=
X-Google-Smtp-Source: AKy350YY9wQuNI4v3sf12Y0macCltjxIdOePjcfXIXLXDdnLo3Rezjlp0bRohimMwvmndI7qSo3mQw==
X-Received: by 2002:ac2:50ca:0:b0:4db:268a:4ec5 with SMTP id h10-20020ac250ca000000b004db268a4ec5mr4357111lfm.52.1682427017910;
        Tue, 25 Apr 2023 05:50:17 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004e7fa99f2b5sm2071064lfo.186.2023.04.25.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 05:50:17 -0700 (PDT)
Date:   Tue, 25 Apr 2023 15:50:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v12 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230425125015.qhhlw5aqnsofq4vb@mobilestation>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230420204129.azbopwklu2yetfrf@mobilestation>
 <20230420204558.4csplhtkz2co4att@mobilestation>
 <TYBPR01MB5341BD8037B4E82C4E5CEBB9D8649@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341BD8037B4E82C4E5CEBB9D8649@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 25, 2023 at 11:33:58AM +0000, Yoshihiro Shimoda wrote:
> Hi Serge,
> 
> > From: Serge Semin, Sent: Friday, April 21, 2023 5:46 AM
> > 
> > On Thu, Apr 20, 2023 at 11:41:32PM +0300, Serge Semin wrote:
> > > Hi Yoshihiro
> > >
> > > On Fri, Apr 14, 2023 at 03:16:03PM +0900, Yoshihiro Shimoda wrote:
> > > > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > > > To support them, modify PCIe DesignWare common codes.
> > >
> > > Thanks for the updates. I'll have a look at the series on the next
> > > week.
> > 
> > Oh, I see there is v13 already submitted. I'll send my comments there
> > then.
> 

> Thank you very much for your support!
> I got a lot of great feedback from Manivannan, and I modified the patches.
> But, should I wait for your review on v13? Or, should I submit v14?

You may re-submit. I'll send my comments to v14 then.
* Please make sure my gmail email is in the to/cc list.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
