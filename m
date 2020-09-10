Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55425263A1E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 04:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgIJCUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 22:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbgIJCSv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 22:18:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CDC06179B;
        Wed,  9 Sep 2020 19:18:34 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n2so4493637oij.1;
        Wed, 09 Sep 2020 19:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOk59Y9agev+P1pRd+FxE/mXDXASrAFWiJH4a1Tl+Zw=;
        b=AZyRw62QIBBWqODqgus8QIlDN9ibQ7DqITmcyT1IhPcNEonrlcxsqhKKDp8Ak7WyJj
         rB/O10IRiA8Hu2uF7zkMR/gTloOBd3ArSRLEnZWOxbM5HvZKROv281KCgRRCK8E1U8+/
         EnH4Ltms45F4lU3oeU3utrA763/BcUK7OM4BsZ0/6i/ra3vl2MTrh/c2zcL8HraOgp8+
         AkKRju51Kr/fWnIRVPtDkLhI9RFc6JnO6fembZvQH8X9Xqs8AZgnj2F6vYzH42q9+IAD
         EIqb+H6j2VTi181/k82+ylN0/UuwaBCLoEMDhT8nqpNkiLTe13hE7lIadoIQG75RsgyB
         d1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOk59Y9agev+P1pRd+FxE/mXDXASrAFWiJH4a1Tl+Zw=;
        b=n0PakEsG9HQ2u9vaMxhzCFsFY5g6p6mpX7jPnY9r8V+j2ti7FRm09v6VxLFh1jN58Y
         vEFYWI9+GAllZ78UtUW/VpoujOsW0uQRmWqlM5U7jRlLo70ad+QZ+WSlsqBarbEQEJrU
         xNFXE+C8U9DdOl9y6JG1Xxkt9bCf/y0S3us3AVcLkYPE1e1hW5cob4mPJSoPSDta4FUv
         9l+tPQRDeFo8nZPrtOgGzw+X2Vru1W9q8qoUqRHs7iHjtWTxTVA6kV8fO1zrElYVaaWd
         2RMHrSvoWHvhd8wX5nSwTr/YwWKyPqWkgMFU6HRPrldsKkQ9pJwVHEcHaGIytz4wIh7t
         fmSg==
X-Gm-Message-State: AOAM533jdegbRjy5i/QMYbMGp/WS8oP2vnjgY4jYQE1nMz+V9F2nK5Gh
        aWlpvI9t1gm/TEjWLT8gwfg0AREqrlbxitMepuP11f01
X-Google-Smtp-Source: ABdhPJwpsA7xA/pdpr3ILoTVp47C6lLv9rrw4dQ9G6VM5XmEXEcVZC0d3lzZK9HRNJmv413CJZyiiSGNfWvBaOMtIX8=
X-Received: by 2002:a05:6808:3d6:: with SMTP id o22mr2296687oie.150.1599704313667;
 Wed, 09 Sep 2020 19:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJCdB=HzNJp36tjD0=-R-cs4+8=xhxAfmR-tZ2DkpcyiugH-g@mail.gmail.com>
 <20200910015950.GA748330@bjorn-Precision-5520>
In-Reply-To: <20200910015950.GA748330@bjorn-Precision-5520>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 10 Sep 2020 10:18:22 +0800
Message-ID: <CAPJCdB=3hjZiC4P3G9T0G5XFnkxRvfpx_+3Qj5AQESAG-kpbEw@mail.gmail.com>
Subject: Re: [PATCH] driver/pci: reduce the single block time in pci_read_config
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>,
        Bin Lai <robinlai@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, 10 Sep 2020 at 09:59, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 10, 2020 at 09:54:02AM +0800, Jiang Biao wrote:
> > Hi,
> >
> > On Thu, 10 Sep 2020 at 09:25, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Mon, Aug 24, 2020 at 01:20:25PM +0800, Jiang Biao wrote:
> > > > From: Jiang Biao <benbjiang@tencent.com>
> > > >
> > > > pci_read_config() could block several ms in kernel space, mainly
> > > > caused by the while loop to call pci_user_read_config_dword().
> > > > Singel pci_user_read_config_dword() loop could consume 130us+,
> > > >               |    pci_user_read_config_dword() {
> > > >               |      _raw_spin_lock_irq() {
> > > > ! 136.698 us  |        native_queued_spin_lock_slowpath();
> > > > ! 137.582 us  |      }
> > > >               |      pci_read() {
> > > >               |        raw_pci_read() {
> > > >               |          pci_conf1_read() {
> > > >   0.230 us    |            _raw_spin_lock_irqsave();
> > > >   0.035 us    |            _raw_spin_unlock_irqrestore();
> > > >   8.476 us    |          }
> > > >   8.790 us    |        }
> > > >   9.091 us    |      }
> > > > ! 147.263 us  |    }
> > > > and dozens of the loop could consume ms+.
> > > >
> > > > If we execute some lspci commands concurrently, ms+ scheduling
> > > > latency could be detected.
> > > >
> > > > Add scheduling chance in the loop to improve the latency.
> > >
> > > Thanks for the patch, this makes a lot of sense.
> > >
> > > Shouldn't we do the same in pci_write_config()?
> > Yes, IMHO, that could be helpful too.
>
> If it's feasible, it would be nice to actually verify that it makes a
> difference.  I know config writes should be faster than reads, but
> they're certainly not as fast as a CPU can pump out data, so there
> must be *some* mechanism that slows the CPU down.
We did catch 5ms+ latency caused by pci_read_config() triggered by
concurrent lspcis, and latency disappeared after this patch.
For pci_write_config path, we have not met the case actually.:)
I'll have some tries to verify that, and would send another patch if verified.

Thx.
Regards,
Jiang
