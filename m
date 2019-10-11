Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3AD4177
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfJKNiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 09:38:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44622 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfJKNiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 09:38:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id w6so7960090oie.11
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2019 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfg5CgXE5HgHYB2r+rPXd+5qQLpipg3q3f13Xq0zazg=;
        b=bKF7oXJw51gknVl8GlWuCkJNlHCKBEF0dIbpGOIRmXl0ZQZva4QYv6lpw55MAR/VxN
         42c2vN4+2NQDL94glif9Tfq1yVJaRLtcq3FVgRPlxGYsstgrIKaRQbtSr9EQxuSe3v6E
         5OnQ9INYRhEne+E9aAwo6zhhQ6iBHvtpaHQj5fKuC5Ya6Gq7FBSlYIpyLinJQvT7AjMV
         X4oQHHmd6EG7njZYJG1h/pUzW/6hRupoDX74hhLrmDXzSbqJxwj+MqgFKMaWbq9ZGVNs
         pg6kbOnisFcOEX2jL79syNnr5wH6/o8YU6u5jLx3kHBka0mjWluvpqYPewghNbgA7en3
         OxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfg5CgXE5HgHYB2r+rPXd+5qQLpipg3q3f13Xq0zazg=;
        b=ss01x00L739/PuccxTFKB79Xs4fcX4elihQskFwDZJOy/as0hzgqr0ch+cMQtM2OoN
         ZL18G7d86NmR+chNPHzE3k8RzmtXriKX2Gt+ZqPLACRHgcOmsAHTwGGCGxQnqTuisRvX
         bWyJWbaCkv1wS6Imct1cdsGPnyNq2w1CaM3VeU9qD/NQVf/fB6Tl9D65HOppSEsBI2Jz
         oBv1d1jEedQC6UyzQzui2Mawgqs5TWe8ydexIkmWyE7WDopqdfB8N/rEunAIx1zB1Pd4
         CERu18l+XGDfRvaSRoe6DouOUvYyPg6kVHM/864I8s3XaUc8gxktLWk+rQAeKmz5i7nN
         Pgtg==
X-Gm-Message-State: APjAAAXdmjORJV8kWX8TDPPP6sl77vb7Fp6Nvu/Y8raTAXz+qBmjNlLh
        sOdNO0tR8LTSJFu/jISnyp/UHbn62hVA573SKLxtkDQWXu4=
X-Google-Smtp-Source: APXvYqx27P/bh+FmAsrCuq09neA8YqJCxwKDl4Zx8L1C/hLBrpCChPMwVPi3lovVWPWESUgAGnB7wRa5EPsv1hu0Q4E=
X-Received: by 2002:a05:6808:b07:: with SMTP id s7mr11847077oij.162.1570801091104;
 Fri, 11 Oct 2019 06:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V-a8sCjSCgj_WKeEtxRwjF+PM392zeTQ3F3ZwQR=nPavFyXQ@mail.gmail.com>
 <b91c3f6e-cef5-c06d-4282-84c24d616533@ti.com> <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
In-Reply-To: <CA+V-a8tFB=giGvcLNhfTaaQ-R8svXijcoQ_QUdRMX3Hb4Ur95Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 11 Oct 2019 14:37:44 +0100
Message-ID: <CA+V-a8vR+xar-TsTOiBtNfbYuP8Wb_ktuf-i7tOkQ+==rs7Rug@mail.gmail.com>
Subject: Re: [Query] : PCIe - Endpoint Function
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon

On Fri, Oct 11, 2019 at 8:35 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Kishon,
>
> On Thu, Oct 10, 2019 at 12:32 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >
> > Hi Prabhakar,
> >
> > On 10/10/19 4:57 PM, Lad, Prabhakar wrote:
> > > Hello,
> > >
> > > I am currently working on adding pcie-endpoint support for a
> > > controller, this controller doesn't support outbound- inbound address
> > > translations, it has 1-1 mapping between the CPU and PCI addresses,
> > > the current endpoint framework is based on  outbound-inbound
> > > translations, what is the best approach to add this support, or is
> > > there any WIP already for it ?
> >
> > How will the endpoint access host buffer without outbound ATU? I assume the PCI
> > address reserved for endpoint is not the full 32-bit or 64-bit address space?
> > In that case, the endpoint cannot directly access the host buffer (unless the
> > host already knows the address space of the endpoint and gives the endpoint an
> > address in its OB address space).
> >
I lied in my previous mail.

a] The controller needs the cpu_address before starting the link, ie
with the current implementation,the bars physical address in endpoint
are assigned
using dma_alloc_coherent(), but I what I actually want here is the
phys_addr returned by pci_epc_mem_alloc_addr().

b] In the pci_endpoint_test driver, the pci_address sent to the
endpoint driver is again dma_alloc_coherent(), but the address which I
actually want to
send to endpoint is the BAR's assigned regions in the RC.

Cheers,
--Prabhakar
