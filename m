Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C05ED19A0C8
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 23:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgCaV3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 17:29:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33006 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaV3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 17:29:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so27116159ede.0
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2020 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rJ8JQ0YadyyKLu5bC03COKFAZQq9M0H8Wbt8WVq1wrM=;
        b=Pz3Vrlu4GDz4Qe559wKnjnuvcCw0qcYrdYkPevYyKQg5ncac9uNAPxatk8HASQJcyA
         3EBZ2hkkjObXG0RnTQWOwntRREOAko90lTpnRJ+XBS/RKxkBErxPTVh9HIyxr1DRrBTt
         vBKUFCOoo5mfeo2G34JW6l4MrNGatmzuWdX2aykfanBx8eUbsbs3obrJ6L3c72oTuWD+
         GhfKcSHrjZYkBl6ly+oMxsLakZnN0ASvT0uLTYqKZVliNLZLB2ZmehK2xfGxGedExten
         pg55cnPIJqPxf5UbykDUSVluvXRslrUdQcSsWx7WVuFS33dtHwk/QLJAhURZsPj7KXTf
         jEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rJ8JQ0YadyyKLu5bC03COKFAZQq9M0H8Wbt8WVq1wrM=;
        b=DLCuramLEYOgo3KoZdSupeT//JKxA3vqOwgHuD04Zv1fRvEVjK8f8tuR7AywqIJLLJ
         rmGyuob7qQ+cWqS/n4atJNP0WEbhTFn74t6HspYemf9Yo9KKu743J36Neo6fMmwgsStF
         E00fapTSY+IxV9rpYDRXJ4/cWVTecaJMNBqgoJ6k6/NQKJYNe9KNq+Ivn5sUWzQH1W5Q
         NdRhoWztmC5ACUpCJlGGuPSrP8F9hbMWHEwgrrJ76Jnv/jaYSqKaB500fWp12uaj88oQ
         eQ2uCuEMKAuUp1NufTaOL4hOBwYBqm52Rq9LL+c37+YqFODD9N70nriQLP0c1MtIp9M7
         MHVA==
X-Gm-Message-State: AGi0PuYAAlCK2JbkhABq6KTJwX/C3B2JHqNpuRNndb8kOrREEPz5Xbyw
        qJ9RP6cCvbeInBVMjzkrxbSdf83Xqe+aZvIERJ4=
X-Google-Smtp-Source: APiQypJIquiryuf7NWGREg/3s7Bl0Er/bApt59h77IdKOjGQNzkag33pFFe+CqyI4Io4rer9KjG0TAlakWjt/vygZOU=
X-Received: by 2002:a17:906:190c:: with SMTP id a12mr3232978eje.238.1585690142207;
 Tue, 31 Mar 2020 14:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzXK1pFFEw+FdAyC6=yxkk5cXMJkVxxkxMiHrB6sH7pwGMkFQ@mail.gmail.com>
 <20200330194917.GA72191@google.com>
In-Reply-To: <20200330194917.GA72191@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Tue, 31 Mar 2020 22:28:51 +0100
Message-ID: <CAEzXK1q1ufa1GoL_ZXdqothu_Dub4SAV1KZ_JFcpuF-p0f2Z4w@mail.gmail.com>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on Linux
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your help.

I've removed all other PCIe devices to make the analysis easier.
The dmesg with the traces can be found at:
https://paste.ubuntu.com/p/W3m2VQCYqg/

Didn't find anything new related to BAR0 or BAR2, in the dmesg,
though. Anyway I'm no expert in this, maybe it can give you some
useful information, still.

Kind Regards,
Lu=C3=ADs Mendes

On Mon, Mar 30, 2020 at 8:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Mar 29, 2020 at 11:11:28PM +0100, Lu=C3=ADs Mendes wrote:
> > Hi Nicholas, Bjorn,
> >
> > I was able to make the apex driver work on a X86_64 system with the
> > Coral Edge TPU PCIe device.
> > So, now the PCI enumeration problem is now clearly an ARM and ARM64
> > platform issue. What are the recommended steps for debugging this? I
> > hava a JTAG interface and openOCD supported configuration for it.
>
> Thanks for the work of testing on X86_64.  I don't have any magic
> ideas other than instrumenting the code and slogging through the
> output.  Can you try the patch below and collect the dmesg?  This will
> probably take a few iterations.
>
>
