Return-Path: <linux-pci+bounces-11514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0E694C611
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E1128A58E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688F15B542;
	Thu,  8 Aug 2024 20:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVIfNLjD"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565515B541
	for <linux-pci@vger.kernel.org>; Thu,  8 Aug 2024 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150618; cv=none; b=mP1eWO2sjcU2UwViDq+P0nzLuI3B6JoKYaM+wZ+VWmRS/JKi6MkKrlT4CudimiXLUxbz7Si/z4zdbYFnfSJEnfKFUHSfkjFD9xKGiirdKMq8/vcoAxfKFOx8EKuGiNgaGww0c+IPrnU/70XO2i5tw0TelfqGGzf7tYELmnO/uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150618; c=relaxed/simple;
	bh=BsX2d0K1c9Iyqy3iXpPM98RHfwVeEE9Uo37kfylRXkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp8/b15LXjvGnIPsRlPPYdq7n7W/K5ceqjJl4Jc9/eyUNh5THXlJjYN3djN4SsyDfENRLi10JfFUOKZ99S+7/hHxqoG1bMqhZyhbzx9BFx8S0SbBkY3IFl/2daZc9EXd9XdXTDDD31NT7tMxfOVpi74nkmraQUrpYaI6pzBu74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVIfNLjD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723150615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjSNUygXxj1UKmmvy/1DKIe1v5Iq+pAlfR8gntxMDUA=;
	b=BVIfNLjDZvE+5vSGXBDc+ezeyWNELdUxeh9xalzuvCB7t/42KDFIB5Ruy+qJ152Dq7QSKQ
	M5IQ+JxUfkAFzZC0SZajpuhhxkRkP5Ft1/16oZutd1nN/c9GYOK3awNgPlHcxOtbHCsY/d
	TSq4Pek0VlZsFSdzonilKzFumNGc8wI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-gaWpX8oWOXer2InwnelLqg-1; Thu, 08 Aug 2024 16:56:54 -0400
X-MC-Unique: gaWpX8oWOXer2InwnelLqg-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-81fb721b9adso622893241.2
        for <linux-pci@vger.kernel.org>; Thu, 08 Aug 2024 13:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150613; x=1723755413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjSNUygXxj1UKmmvy/1DKIe1v5Iq+pAlfR8gntxMDUA=;
        b=M8SD4mGOLZz756F0LsBGmprfp7uMk3SgD53QZcYIKLqDrNaIK7XlZfJxIWDr4k1mXC
         g4VtUuhakDuyxE7WlaTfCMS+leMQxBCTIFx3DhMwx/FIdB4cR+ZsfpHmHU06hFxUNqt7
         M8HyYtGZrpOY9kZ6uR5lBde0iBqw20uPwvlXGxNk8fsRJ9d4Bxq5lVFH73k1THrzpW0Z
         oBwtKdEPnnfpTmNY8Nug3/O8FgqfpH6f6t4soS1zO3ODcuUo5CAlbBGtnqHw4btg3EEZ
         SMOwrv1CjNChJ5mv6+CGArJE7L7Z50ItTwO8/4QVwu2HKC20x1fp5+2LEoIcY1fEqQE0
         aXMw==
X-Forwarded-Encrypted: i=1; AJvYcCWqASvR0ibKhbks4wSbjkoQ5cDfr5mSqEbmV8jCzHLVw+rT/yibOq+k+GbRFqXNdLvtS846OWZvYTDI0hyNTdWbBl3s4S6NTCxJ
X-Gm-Message-State: AOJu0YxbILOlhJ4FPG8QfSLnEFnQC2LW4MhuMVeNNcTrfUhCyTXwaJOH
	hNi+mbRs6E2lMCGeWNA/WPfeogYvR0jCsMNTIwj3ek8O+/SF0wontzDEV309GQbDXKa7r7ECELf
	fk4cRd/kAE52RdJrZKOsS9v82VHLHaLWq0uhKrhKS4gnLa0mBIFEHhhewdQ==
X-Received: by 2002:a05:6102:6d0:b0:493:badb:74ef with SMTP id ada2fe7eead31-495c5bf9df6mr3267067137.26.1723150613549;
        Thu, 08 Aug 2024 13:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKopPmF6amJedENwp5N1HJwLnev5fnpBwA+0PgZ0higtVR5UqfwM0fCb9gaFks6AjH2VLC/w==
X-Received: by 2002:a05:6102:6d0:b0:493:badb:74ef with SMTP id ada2fe7eead31-495c5bf9df6mr3267048137.26.1723150613092;
        Thu, 08 Aug 2024 13:56:53 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c84074esm69807896d6.80.2024.08.08.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:56:24 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:56:10 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <wr2z74wsqhitisgp4qsfrmuvvhw3cpp3bdzkp5batawv6btfyd@xcyhug7jyfxg>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad>
 <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
 <20240726115609.GF2628@thinkpad>
 <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
 <20240805164519.GF7274@thinkpad>
 <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKxF6yYTWbmU8SRhxemNMwErNViHuk05sLyFjFzssh=Eg@mail.gmail.com>

On Mon, Aug 05, 2024 at 01:05:14PM GMT, Rob Herring wrote:
> On Mon, Aug 5, 2024 at 10:45 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Aug 05, 2024 at 10:01:37AM -0600, Rob Herring wrote:
> > > On Fri, Jul 26, 2024 at 5:56 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Thu, Jul 25, 2024 at 01:50:16PM +0530, Siddharth Vadapalli wrote:
> > > > > On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > > > > > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > > > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > > > > > > >   of_irq_parse_pci: failed with rc=-22
> > > > > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > > > > >
> > > > > > >
> > > > > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > > > > > > if 'map_irq' is set to NULL.
> > > > > > >
> > > > > >
> > > > > > Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx interrupts
> > > > > > are described in DT? Then why are they not supported?
> > > > >
> > > > > No, the INTx interrupts are not described in the DT. It is the pcieport
> > > > > driver that is attempting to setup INTx via "of_irq_parse_and_map_pci()"
> > > > > which is the .map_irq callback. The sequence of execution leading to the
> > > > > error is as follows:
> > > > >
> > > > > pcie_port_probe_service()
> > > > >   pci_device_probe()
> > > > >     pci_assign_irq()
> > > > >       hbrg->map_irq
> > > > >         of_pciof_irq_parse_and_map_pci()
> > > > >         of_irq_parse_pci()
> > > > >           of_irq_parse_raw()
> > > > >             rc = -EINVAL
> > > > >             ...
> > > > >             [DEBUG] OF: of_irq_parse_raw: ipar=/bus@100000/interrupt-controller@1800000, size=3
> > > > >             if (out_irq->args_count != intsize)
> > > > >               goto fail
> > > > >                 return rc
> > > > >
> > > > > The call to of_irq_parse_raw() results in the Interrupt-Parent for the
> > > > > PCIe node in the device-tree being found via of_irq_find_parent(). The
> > > > > Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
> > > > > msi-map = <0x0 &gic_its 0x0 0x10000>;
> > > > > and the parent of GIC_ITS is:
> > > > > gic500: interrupt-controller@1800000
> > > > > which has the following:
> > > > > #interrupt-cells = <3>;
> > > > >
> > > > > The "size=3" portion of the DEBUG print above corresponds to the
> > > > > #interrupt-cells property above. Now, "out_irq->args_count" is set to 1
> > > > > as __assumed__ by of_irq_parse_pci() and mentioned as a comment in that
> > > > > function:
> > > > >       /*
> > > > >        * Ok, we don't, time to have fun. Let's start by building up an
> > > > >        * interrupt spec.  we assume #interrupt-cells is 1, which is standard
> > > > >        * for PCI. If you do different, then don't use that routine.
> > > > >        */
> > > > >
> > > > > In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
> > > > > device-tree node, the following doesn't apply:
> > > > >   dn = pci_device_to_OF_node(pdev);
> > > > > and we skip to the __assumption__ above and proceed as explained in the
> > > > > execution sequence above.
> > > > >
> > > > > If the device-tree nodes for the INTx interrupts were present, the
> > > > > "ipar" sequence to find the interrupt parent would be skipped and we
> > > > > wouldn't end up with the -22 (-EINVAL) error code.
> > > > >
> > > > > I hope this clarifies the relation between the -22 error code and the
> > > > > missing device-tree nodes for INTx.
> > > > >
> > > >
> > > > Thanks for explaining the logic. Still I think the logic is flawed. Because the
> > > > parent (host bridge) doesn't have 'interrupt-map', which means INTx is not
> > > > supported. But parsing one level up to the GIC node and not returning -ENOENT
> > > > doesn't make sense to me.
> > > >
> > > > Rob, what is your opinion on this behavior?
> > >
> > > Not sure I get the question. How should we handle/determine no INTx? I
> > > suppose that's either based on the platform (as this patch did) or by
> >
> > Platform != driver. Here the driver is making the call, but the platform
> > capability should come from DT, no? I don't like the idea of disabling INTx in
> > the driver because, the driver may support multiple SoCs and these capability
> > may differ between them. So the driver will end up just hardcoding the info
> > which is already present in DT :/
> 
> Let me rephrase it to "a decision made within the driver" (vs.
> globally decided). That could be hardcoded (for now) or as match data
> based on compatible.
> 
> > Moreover, the issue I'm seeing is, even if the platform doesn't support INTx (as
> > described by DT in this case), of_irq_parse_pci() doesn't report correct
> > error/log. So of_irq_parse_pci() definitely needs a fixup.
> 
> Possibly. What's correct here?
> 
> There was some rework in 6.11 of the interrupt parsing. So it is
> possible something changed here. There's also this issue still
> pending:
> 
> https://lore.kernel.org/all/2046da39e53a8bbca5166e04dfe56bd5.squirrel@_/
> 
> > > or by
> > > failing to parse the interrupts. The interrupt parsing code is pretty
> > > tricky as it has to deal with some ancient DTs, so I'm a little
> > > hesitant to rely on that failing. Certainly I wouldn't rely on a
> > > specific errno value. The downside to doing that is also if someone
> > > wants interrupts, but has an error in their DT, then all we can do is
> > > print 'INTx not supported' or something. So we couldn't fail probe as
> > > the common code wouldn't be able to distinguish. I suppose we could
> > > just check for 'interrupt-map' present in the host bridge node or not.
> >
> > Yeah, as simple as that. But I don't know if that is globally applicable to
> > all platforms.
> 
> There's a lot of history and the interrupt parsing is fragile due to
> all the "interesting" DT interrupt hierarchies. So while I think it
> would work, that's just a guess. I'm open to trying it and seeing.

Would something like this be what you're imagining? If so I can post a
patch if this patch is a dead end:

    diff --git a/drivers/pci/of.c b/drivers/pci/of.c
    index dacea3fc5128..4e4ecaa95599 100644
    --- a/drivers/pci/of.c
    +++ b/drivers/pci/of.c
    @@ -512,6 +512,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
                            if (ppnode == NULL) {
                                    rc = -EINVAL;
                                    goto err;
    +                       } else if (!of_get_property(ppnode, "interrupt-map", NULL)) {
    +                               /* No interrupt-map on a host bridge means we're done here */
    +                               rc = -ENOENT;
    +                               goto err;
                            }
                    } else {
                            /* We found a P2P bridge, check if it has a node */

I must admit that you being nervous has me being nervous since I'm not all
that familiar with PCI... but if y'all think this is ok then I'm for it.
I'm sure I'm not picturing all the cases here so would appreciate
some scrutiny.

You still end up with warnings, which kind of sucks, since as I
understand it the lack of INTx interrupts on this platform is
*intentional*:

    [    3.342548] pci_bus 0000:00: 2-byte config write to 0000:00:00.0 offset 0x4 may corrupt adjacent RW1C bits
    [    3.346716] pcieport 0000:00:00.0: of_irq_parse_pci: no interrupt-map found, INTx interrupts not available
    [    3.346721] PCI: OF: of_irq_parse_pci: possibly some PCI slots don't have level triggered interrupts capability

You could have a combo of both this patch (to indicate that a specific driver (even further
limited to a match data based on compatible) doesn't support these) as well as
the above diff (to improve the message printed in the situation where a driver
*does* claim to support these interrupts but fails to describe them properly).

Am I barking up the right tree? If so I'll submit a proper patch
independent of this (and depending on your views we can continue with v2
of this patch too, or not).

Thanks,
Andrew


