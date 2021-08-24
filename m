Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6CD3F6AF2
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhHXVWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 17:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXVWm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Aug 2021 17:22:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74DC061757
        for <linux-pci@vger.kernel.org>; Tue, 24 Aug 2021 14:21:58 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so41346740otg.11
        for <linux-pci@vger.kernel.org>; Tue, 24 Aug 2021 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtIOJH8PBF1/iH8MyRGz0pTPExah6uG34M1IBP8eNO4=;
        b=IJPW8hx9wZXO1P2lbLZGy2iF7pmxdjBbXoIzRccBZfoFZP+kENipRioMSQe3y0pznI
         MbCrgpQGrn0cXAyP7Ay6ypTEobRSrdg8/KTj+kwwI8+mhZb0D0o7Xf65Cqlp2gxWAYhr
         /a/ymkaN8ZZTrbVjI5jNWIRUop9riRgzPQrryVtnzo5geaPgegMrZKm8aO4mNWVgRN6Y
         8CKrtnKbKbUnLG6kHvxD9yc6xfniM2+6sN/YEMKnNQJEYL7qX4heMAq8r1TKteNIAGjt
         gFPkcI+yg1U628xpQHnqktPX8D/a5mxY0a64s1r9x8BDqbRd/+D3ua4oV3KPS+dOeIT5
         eljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtIOJH8PBF1/iH8MyRGz0pTPExah6uG34M1IBP8eNO4=;
        b=JZ+zUqg10Jx8id+wnPEV4+XG/X1P8zyPGzljdFpXIKu6y0QIQDW2LoeqLrj+fQ9UWb
         zKvA4EUNgtqgGOBBu+VB83eBFTgV5yzljiP6uyCc4UGPwFoX1r5W7eMMMvMU1Ce1n+ko
         vmteT0sWcpYE9vMMLdfQAZgaBYbkheNd+IfDwvNlSEzHTeS5+avEurlkj0EAJYEuQ1dk
         mrC9KCe8sGw/V/CnKiFkqhfwspIi4Ugj5wjzaLX7v3gixqdwlChtEO0NJFAQ1yiPjFs8
         cRAR5jl2BpUieMfti2WksFgIwgeMdseG/ZMP0+rAdYYxfybi7k1cux/UYKF6jKlQ6AAe
         tkDA==
X-Gm-Message-State: AOAM5331WbbcOENq1C6t/w/C84WOLOMCsnenxrqmjWhcY6JOXdB13U2x
        paJKKfqUwMlSDN46ytYAK32OKQ==
X-Google-Smtp-Source: ABdhPJxuJcLxPQAlEmc0AL12sf8aq7NBOiIdeVjFqiE4i9qnJS5dCWKdp2zESJmeK95e0wFsK1TOyA==
X-Received: by 2002:a05:6830:4124:: with SMTP id w36mr25092577ott.72.1629840117620;
        Tue, 24 Aug 2021 14:21:57 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 2sm4692902oto.50.2021.08.24.14.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:21:56 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:23:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <YSVjQgDmatkkCxtn@ripper>
References: <YSVTdedrDSgSYgwm@ripper>
 <20210824202925.GA3491441@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824202925.GA3491441@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 24 Aug 13:29 PDT 2021, Bjorn Helgaas wrote:

> On Tue, Aug 24, 2021 at 01:15:49PM -0700, Bjorn Andersson wrote:
> > On Tue 24 Aug 12:05 PDT 2021, Bjorn Helgaas wrote:
> > 
> > > On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> > > > On the Qualcomm sc8180x platform the bootloader does something related
> > > > to PCI that leaves a pending "msi" interrupt, which with the current
> > > > ordering often fires before init has a chance to enable the clocks that
> > > > are necessary for the interrupt handler to access the hardware.
> > > > 
> > > > Move the host_init() call before the registration of the "msi" interrupt
> > > > handler to ensure the host driver has a chance to enable the clocks.
> > > 
> > > Did you audit other drivers for similar issues?  If they do, we should
> > > fix them all at once.
> > 
> > I only looked at the DesignWware drivers, in an attempt to find any
> > issues the proposed reordering.
> > 
> > The set of bugs causes by drivers registering interrupts before critical
> > resources tends to be rather visible and I don't know if there's much
> > value in speculatively "fixing" drivers.
> > 
> > E.g. a quick look through the drivers I see a similar pattern in
> > pci-tegra.c, but it's unlikely that they have the similar problem in
> > practice and I have no way to validate that a change to the order would
> > have a positive effect - or any side effects.
> > 
> > Or am I misunderstanding your request?
> 
> That is exactly my request.

Okay.

> I'm not sure if the potential issue you
> noticed in pci-tegra.c is similar to the one I mentioned here:
> 
>   https://lore.kernel.org/linux-pci/20210624224040.GA3567297@bjorn-Precision-5520/
> 

As I still have the tegra driver open, I share your concern about the
use of potentially uninitialized variables.

The problem I was concerned about was however the same as in my patch
and the rockchip one, that if the tegra hardware isn't clocked the
pm_runtime_get_sync() (which would turn on power and clock) happens
after setting up the msi chain handler...

> but I am actually in favor of speculatively fixing drivers even though
> they're hard to test.  Code like this tends to get copied to other
> places, and fixing several drivers sometimes exposes opportunities for
> refactoring and sharing code.
> 

Looking through the other cases mentioned in your reply above certainly
gives a feeling that this problem has been inherited from driver to
driver...

I've added a ticket to my backlog to take a deeper look at this.

Regards,
Bjorn
