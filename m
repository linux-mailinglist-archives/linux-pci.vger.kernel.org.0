Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA57A2970A5
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 15:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369365AbgJWNew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464942AbgJWNeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 09:34:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6B1C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 06:34:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c15so2449468ejs.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ybxYfhP0qOoEv/Z3igcvaiaTXfddpdf7DoEgMqfdT7A=;
        b=bNaAR+OjYmeeEzFzzZBJyzDKMbF4do7AhpOBiv9gsSMgNMqyq5/l4Ywkmo2cc+ESzz
         lH05Ok9PCaR+wHbV3UtzXlRRA8JfrhwHMLbb0Zj4NWXmQ4eNylNbUcFPFq5iZJZ3HE4A
         4A9t44PEBK+fF9Uz9ustwTwn9OxP5fS7OhuPeCnuRonbtMuE6/l3mFYgIYjLd95R3VaS
         dpWDsX5QYk6s/5ms0m/fST6rb3d8AWD5vnd1IhI1k1i/p+mau+CZ/smjsHXHtkBLdSSy
         daqTJeHfA9fXyZGQ5P3D3zhZtf8qMmTy+xx4KaAg3dJBOtHchBp51fOrGZD//kZ/nWsq
         0QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ybxYfhP0qOoEv/Z3igcvaiaTXfddpdf7DoEgMqfdT7A=;
        b=H87tyjev91QdUYNlDPyCaxtzi0XqE03ycnxTVcXR/3A0V+85qf6HOa2jp4BzK2+aGl
         4VCRb9bWRE+rBO+7J+ftwkZPrlC+KnRqTsQD8HB1BoS4PvjFYdzECr/914QfAELKhX+O
         P7lZy67v9pEIMA/Jri0RA0SShw/5QClA7aXDtKrdE5ZFQZpCdGQlwarEJ0e1BHRmKfBZ
         6Sz6tjsqWrccA6n6tOw0PRpxjtGvtCFsdj65IymIH/z4XpFp/siy/ybDuR54doMCi4XE
         aphR5mI1lsKiPnPjKQgYSlwXVjkkIhZRIE640jcwSCX0ebMucsErMuQHHtadJZB0d0N5
         2/CQ==
X-Gm-Message-State: AOAM530iJm4vDLlsUtreVtyR+hQI+EYZ4Z4uclhUVN8FDECDumojmHF5
        5bYI9S59zZyWk8mOVOhV8Rq9Dg==
X-Google-Smtp-Source: ABdhPJyJrpSO/TA1CFzr7cbXy98qv9z9QsL9dllO7dHUBx35a7onv2rOqG2fNwzz8c08kIOaSfCzMQ==
X-Received: by 2002:a17:906:1418:: with SMTP id p24mr1964123ejc.46.1603460084421;
        Fri, 23 Oct 2020 06:34:44 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id q3sm788808edv.17.2020.10.23.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:34:43 -0700 (PDT)
Date:   Fri, 23 Oct 2020 15:34:23 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        linux-pci@vger.kernel.org, "Lu, Baolu" <baolu.lu@intel.com>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [RFC PATCH 0/2] iommu: Avoid unnecessary PRI queue flushes
Message-ID: <20201023133423.GF2265982@myrica>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
 <20201015182211.GA54780@otc-nc-03>
 <20201016075923.GB1309464@myrica>
 <20201017112525.GA47206@otc-nc-03>
 <20201019140824.GA1478235@myrica>
 <20201019211608.GA79633@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019211608.GA79633@otc-nc-03>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 02:16:08PM -0700, Raj, Ashok wrote:
> Hi Jean
> 
> On Mon, Oct 19, 2020 at 04:08:24PM +0200, Jean-Philippe Brucker wrote:
> > On Sat, Oct 17, 2020 at 04:25:25AM -0700, Raj, Ashok wrote:
> > > > For devices that *don't* use a stop marker, the PCIe spec says (10.4.1.2):
> > > > 
> > > >   To stop [using a PASID] without using a Stop Marker Message, the
> > > >   function shall:
> > > >   1. Stop queueing new Page Request Messages for this PASID.
> > > 
> > > The device driver would need to tell stop sending any new PR's.
> > > 
> > > >   2. Finish transmitting any multi-page Page Request Messages for this
> > > >      PASID (i.e. send the Page Request Message with the L bit Set).
> > > >   3. Wait for PRG Response Messages associated any outstanding Page
> > > >      Request Messages for the PASID.
> > > > 
> > > > So they have to flush their PR themselves. And since the device driver
> > > > completes this sequence before calling unbind(), then there shouldn't be
> > > > any oustanding PR for the PASID, and unbind() doesn't need to flush,
> > > > right?
> > > 
> > > I can see how the device can complete #2,3 above. But the device driver
> > > isn't the one managing page-responses right. So in order for the device to
> > > know the above sequence is complete, it would need to get some assist from
> > > IOMMU driver?
> > 
> > No the device driver just waits for the device to indicate that it has
> > completed the sequence. That's what the magic stop-PASID mechanism
> > described by PCIe does. In 6.20.1 "Managing PASID TLP Prefix Usage" it
> > says:
> 
> The goal is we do this when the device is in a messup up state. So we can't
> take for granted the device is properly operating which is why we are going
> to wack the device with a flr().
> 
> The only thing that's supposed to work without a brain freeze is the
> invalidation logic. Spec requires devices to respond to invalidations even when
> they are in the process of flr().
> 
> So when IOMMU does an invalidation wait with a Page-Drain, IOMMU waits till
> the response for that arrives before completing the descriptor. Due to 
> the posted semantics it will ensure any PR's issued and in the fabric are flushed 
> out to memory. 
> 
> I suppose you can wait for the device to vouch for all responses, but that
> is assuming the device is still functioning properly. Given that we use it
> in two places,
> 
> * Reclaiming a PASID - only during a tear down sequence, skipping it
>   doesn't really buy us much.

Yes I was only wondering about normal PASID reclaim operations, in
unbind(). Agreed that for FLR we need to properly clean the queue, though
I do need to do more thinking about this.

Anyway, having a full priq drain in unbind() isn't harmful, just
unnecessary delay in my opinion. I'll drop these patches for now but
thanks for the discussion.

Thanks,
Jean

> * During FLR this can't be skipped anyway due to the above sequence
>   requirement. 
> 
> > 
> > "A Function must have a mechanism to request that it gracefully stop using
> >  a specific PASID. This mechanism is device specific but must satisfy the
> >  following rules:
> >  [...]
> >  * When the stop request mechanism indicates completion, the Function has:
> >    [...]
> >    * Complied with additional rules described in Address Translation
> >      Services (Chapter 10 [10.4.1.2 quoted above]) if Address Translations
> >      or Page Requests were issued on the behalf of this PASID."
> > 
> > So after the device driver initiates this mechanism in the device, the
> > device must be able to indicate completion of the mechanism, which
> > includes completing all in-flight Page Requests. At that point the device
> > driver can call unbind() knowing there is no pending PR for this PASID.
> > 
> 
> Cheers,
> Ashok
