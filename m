Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1646D2D9684
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 11:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgLNKoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 05:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgLNKoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 05:44:21 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511CC0613CF
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2020 02:43:41 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so14819183wmb.5
        for <linux-pci@vger.kernel.org>; Mon, 14 Dec 2020 02:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPCYc+i9Iy87r57uStW+ARtubvlgXBH6jVAjmF4IhnU=;
        b=brfsj5+b+IqlJui0vPdCHYpYP2bFYzO+1JlWfKz1weffGaprU8OkE8dqZ9gA8Ypm/0
         v6+grN5KbiSQRACrcBWw1asFdDFVqF9nBu3Oa0GUPYv5yBkX67nd1ntfLcAJg0zP6PdE
         xlq10No04/AwJLV6O3ydkHlsjEAP4HvjVzoA+aYzj43B5E2rQHWk/Z7UGIyKRfSzOZGq
         LSBaHiBg/MvYDr977DGjKw/verW1+v2Q4CYL/idPu8LHXXM/r9HzNyp7TPbAOeKFlyOV
         7pCIn4oa/HWqnDFni36IPva5UF+BAQ+YUV6hhDKYRIcADocHuV2u230LRwac34Cs6XGF
         Q/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPCYc+i9Iy87r57uStW+ARtubvlgXBH6jVAjmF4IhnU=;
        b=Ly8gC9Aqqq4HXIoD3lhalJZVmgtzVi1OMpO0bjMoAFdKEyGvFVAp45xxdu50kjvBw4
         TyfzLEOd6XfDoQZlqBhjQVs1kpeQCap43OB2VwyyNMqGYgeDRZ+hVkyEBuKSwNErlQjE
         6IL8XsiAF9UuIiiLpyrpGoIOKxFcx+6Qntd1WERKfA2ktxiV9A0v8WUe55VbB+ugGQzt
         F0IpYfg1fCu0i0fBqbTBrZUmBs2cdM5xGI3tPv+rHa8vwi7ML6+Gap6X5LC72vwdNNWd
         mWwdCJ+TlIFg/jYXdrsCUMjmtOX6gLU0lzP8Pj79FCqWwl0POKtL/M48NOwUw5+LMpl2
         YUAA==
X-Gm-Message-State: AOAM532FRSTBhgzN19gUIoy6B4X/75HP7Lt/LOtDQJG40ZqJuAVxUaLP
        4R12dfVz7f24seO8Lceu7+TaCA==
X-Google-Smtp-Source: ABdhPJyQXVJMnqfLrDR2gjT3sPvs5VM6+4B7QNqCQiLsarQ76jozBbecP92kWQZKTuGAqkMV/ku7Vw==
X-Received: by 2002:a1c:bc57:: with SMTP id m84mr26948837wmf.163.1607942619946;
        Mon, 14 Dec 2020 02:43:39 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id w189sm18608037wmg.31.2020.12.14.02.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:43:39 -0800 (PST)
Date:   Mon, 14 Dec 2020 10:43:37 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Nettleton <jon@solid-run.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linaro Patches <patches@linaro.org>
Subject: Re: [RFC HACK PATCH] PCI: dwc: layerscape: Hack around enumeration
 problems with Honeycomb LX2K
Message-ID: <20201214104337.wbvq2gvj3wi6bvzc@holly.lan>
References: <20201211121507.28166-1-daniel.thompson@linaro.org>
 <CAL_JsqKQxFvkFtph1BZD2LKdZjboxhMTWkZe_AWS-vMD9y0pMw@mail.gmail.com>
 <20201211170558.clfazgoetmery6u3@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211170558.clfazgoetmery6u3@holly.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 05:05:58PM +0000, Daniel Thompson wrote:
> On Fri, Dec 11, 2020 at 08:37:40AM -0600, Rob Herring wrote:
> > On Fri, Dec 11, 2020 at 6:15 AM Daniel Thompson
> > >     BTW I noticed many other pcie-designware drivers take advantage
> > >     of a function called dw_pcie_wait_for_link() in their init paths...
> > >     but my naive attempts to add it to the layerscape driver results
> > >     in non-booting systems so I haven't embarrassed myself by including
> > >     that in the patch!
> > 
> > You need to look at what's pending for v5.11, because I reworked this
> > to be more unified. The ordering of init is also possibly changed. The
> > sequence is now like this:
> > 
> >         dw_pcie_setup_rc(pp);
> >         dw_pcie_msi_init(pp);
> > 
> >         if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
> >                 ret = pci->ops->start_link(pci);
> >                 if (ret)
> >                         goto err_free_msi;
> >         }
> > 
> >         /* Ignore errors, the link may come up later */
> >         dw_pcie_wait_for_link(pci);
> 
> Thanks. That looks likely to fix it since IIUC dw_pcie_wait_for_link()
> will end up waiting somewhat like the double check I added to
> ls_pcie_link_up().
> 
> I'll take a look at let you know.

Yes. These changes have fixed the enumeration problems for me.

I tested pci/next and I cherry picked your patch series onto v5.10 and
both are working well.

Given this fixes a bug for me, do you think there is any scope for me
to whittle down your series into patches for the stable kernels or am
I likely to find too many extra bits being pulled in?


Daniel.
