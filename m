Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6E34A36B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCZIvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 04:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCZIvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 04:51:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3496C0613B1
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 01:51:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so3920272pjc.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXKllH4DZp+PJmXaj590vznrjlQGXwA3qvbOlc3azSk=;
        b=ltSxYvjpQGcstE6G4k6RSWbKDuooSNtXutRV7H9eO2h9Zv2zjf+ZAzz61K0k44DHGr
         PCxVLcXDNOIzp+TLmyR0OATS79z+AhvwDets+g6U/0pSS/ThoipATd4Nj3EmJWF6reHq
         4FEET9pD965Ozqoc2ODcX5rD3b+RBRHHEzkrHzSpaOnaQ0OTjA5oHbEojmruiPqdxuti
         j6r6Of49aUn6n15klnZ8sVm5ZBvjjL23MFY6rhQp1RYZYNEs1bX1AKWrK02Exblg5oGh
         skemN90BZ8S7UTC7Kj/DVhyvqC5BmzNm829KjUX7Mx4uxUfw38KkLVrWwAPOZrSjX7in
         X1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXKllH4DZp+PJmXaj590vznrjlQGXwA3qvbOlc3azSk=;
        b=fxANaT+qQTdziqInmVT3KSliIHYdidQSgiz5I2fAkjVhYi9LnUrFd9WtRAnJ719P1a
         AJvLQ1eLmAWbHoTxk7c8zWFP3lmIBdjh8dSGHMHBrRxlrv7pmOsf75xHjyRamCLa3Bnw
         2d1MFdc4jPjC9PjtEo5Q7CR2SJZVcWS7Ou5g/3jmxdUUKxXi/duDOZ0nhHxocv2hXsqi
         yWYoN1kvp96QL1Ko4bvGIjf7Z7rWtAFF3UB2AM98CXCA8kyMY9KhWGA4GMvtu2SX/KXu
         2lQXeT6EMCT7A6pJwpbUUixwFUqZs+aNtmr1A8+O8rZ1RHow8Zmdc0GYVkmRbMxsA9hr
         HMqw==
X-Gm-Message-State: AOAM5329mddnlxaX/4QG2P/DhVw0eeltI7GvIZgClb0SEWiCZAhwHXai
        j2XYfCZlnBhF9uJBwbxmARwbTCAkyvaM
X-Google-Smtp-Source: ABdhPJxCuL3UHmza9XEGdjW7AGeUC8CosFdtNqpLLE4aXSjoNz7eqeDAcDhQzrR+o/kgKEtGEWT7mg==
X-Received: by 2002:a17:902:c1c4:b029:e6:7bc9:71fd with SMTP id c4-20020a170902c1c4b02900e67bc971fdmr13788321plc.5.1616748667147;
        Fri, 26 Mar 2021 01:51:07 -0700 (PDT)
Received: from work ([103.77.37.139])
        by smtp.gmail.com with ESMTPSA id o76sm7036325pfg.217.2021.03.26.01.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Mar 2021 01:51:06 -0700 (PDT)
Date:   Fri, 26 Mar 2021 14:21:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 04/11] PCI: dwc: pcie-kirin: add support for Kirin 970
 PCIe controller
Message-ID: <20210326085102.GA25371@work>
References: <cover.1612335031.git.mchehab+huawei@kernel.org>
 <4c9d6581478aa966698758c0420933f5defab4dd.1612335031.git.mchehab+huawei@kernel.org>
 <CAL_JsqK7_hAw4aacHyiqJWE6zSWiMez5695+deaCSHfeWuX-XA@mail.gmail.com>
 <20210326093936.02ba3a03@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326093936.02ba3a03@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 09:39:36AM +0100, Mauro Carvalho Chehab wrote:
> Em Wed, 3 Feb 2021 08:34:21 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Wed, Feb 3, 2021 at 1:02 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > Add support for HiSilicon Kirin 970 (hi3670) SoC PCIe controller, based
> > > on Synopsys DesignWare PCIe controller IP.
> > >
> > > [mchehab+huawei@kernel.org: fix merge conflicts]
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-kirin.c | 723 +++++++++++++++++++++++-
> > >  1 file changed, 707 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> > > index 026fd1e42a55..5925d2b345a8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > > @@ -29,6 +29,7 @@
> > 

[...]

> > This looks like it is almost all phy related. I think it should all be
> > moved to a separate phy driver. Yes, we have some other PCI drivers
> > controlling their phys directly where the phy registers are
> > intermingled with the PCI host registers, but I think those either
> > predate the phy subsystem or are really simple. I also have a dream to
> > move all the phy control to the DWC core code.
> 
> Please notice that this patch was not written by me, but, instead,
> by Mannivannan. So, I can't change it.

Feel free to move the PHY pieces to a separate PHY driver as suggested.
My driver code was merely WIP one and I don't have any objection to
change the patch.

I'd be happy if you add my Co-developed tag to the PCIe driver patch with
the SoB ofc.

> What I can certainly do is to
> write a separate patch at the end of this series moving the Kirin 970
> phy to a separate driver. Would this be accepted?
> 

Ah, please don't do that. I know that you've already followed the same
process for other HiSi drivers but that looks messy IMO.

> Btw, what should be done with the Kirin 960 PHY code that it is
> already embedded on this driver, and whose some of the DT properties
> are for its phy layer? 
> 

You might need to create a PHY driver for both 960 and 970. I don't see
any harm there. But please make sure you test the patches on both boards.

Thanks,
Mani

> Thanks,
> Mauro
