Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92DA5B8B11
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 16:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiINOxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiINOxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 10:53:00 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80427F245;
        Wed, 14 Sep 2022 07:52:57 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id s18so9433086plr.4;
        Wed, 14 Sep 2022 07:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bkBSW6G3fC6jIoGQP+jCt7/KrqqVbXw36+sN6EqlQpY=;
        b=nrS38boUEwVDOuYDymFvUckzZNotaw+hDHRrR3CfeBGd5Sxte7IXXmLICdDn4qRH0V
         dXhCTeLNGFx2KHgblHD9Z1335c2K7VKDVATKBuJjPyZkKZLk+YwDJx8Qy9lQnyeF+cpe
         zYiDuacMNcQbdzHsgWJpX+Q7kRgavuEd+h5pBeCOyIu8Ffg1W/TR1vUz8cZ63CCHc1KM
         0EQzG7HhU6PBwfn5wFRdctZOPDxTQXk8Y72BK0A4VfLiJS7TS0h75B9RuGEThEKa09KK
         UjgGLRDI0KcG3gb9OsEQh/MJ6OO+a3vY4FElHrcwa1IRYVA3ytjrGxeQ/B6QHIXIhE85
         UtLQ==
X-Gm-Message-State: ACrzQf16mxdsypbPl0njRqeJTROrQsXZoLlK5CcOpCVVTWpg4RJTDybJ
        kIiy2BReqOMAhH6JehOKh0g=
X-Google-Smtp-Source: AMsMyM4Ju0Qg4TkKmbRqShHQSEzgemlBp3OYI7LI/3SiNS8kPpacbuYC9vfCslhkFdtWm7E47SCSvw==
X-Received: by 2002:a17:90a:e58a:b0:1e2:fe75:dd5f with SMTP id g10-20020a17090ae58a00b001e2fe75dd5fmr5367880pjz.138.1663167176969;
        Wed, 14 Sep 2022 07:52:56 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id w12-20020a63f50c000000b004296719538esm9801098pgh.40.2022.09.14.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 07:52:56 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:52:52 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, treding@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Message-ID: <YyHqxGw6ADmJUTEv@rocinante>
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas>
 <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
 <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
 <20220914114306.GG16459@workstation>
 <YyHMvBhWgbDtv6V2@rocinante>
 <20220914134539.GI16459@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220914134539.GI16459@workstation>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> > Perhaps it makes sense to make this a dev_dbg() over dev_info(), especially
> > since it appears that this information is of more use to the developer (who
> > most likely has the suitable log level set anyway), and given that there is
> > no way to reliably detect a presence in a slot on some platforms, this
> > might otherwise, add to the other messages that normal users don't pay
> > attention to usually - if this is not to be treated as an error.
> > 
> 
> No, this is clearly not a debug message. As I quoted above, the link up
> can fail due to an issue with PHY also. In that case, user has to see
> the log to debug/report the issue.

Apologies!  I missed that.  Thank you!
 
> So, either dev_info() or dev_err().

So, there is nothing to do here, then.  This stays as dev_err() as per the
change from:

  14c4ad125cf9 ("PCI: dwc: Log link speed and width if it comes up")

That said, perhaps adding a comment explaining why this is an error
might help future reference, as the linked commit didn't justify the
change.  There also will be redundant messages printed, as per:

  https://elixir.bootlin.com/linux/v6.0-rc5/source/drivers/pci/controller/dwc/pcie-fu740.c#L207

Which the linked commit didn't take into account, I suppose.

	Krzysztof
