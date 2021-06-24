Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55DC3B3617
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhFXSvD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 14:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhFXSvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 14:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624560522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNg9Wq5m1VbMd3O85AU7blSYJl1f6ygn421IFBSPGw4=;
        b=EeSeWpMAJ28kVDu79WY3tBJEuJAmOJDwLaFXGFawglyot9RbBfTYL9fnboNXT0LhzWW0Fi
        CIXcROwIbhMnYdtJYwRIrTxYQk5qZWieMo94yD2wO+2dhsabSf2EinBJz4SRFjGBiOPIgD
        PIq9aRNF6rlSVVAa5fN2tRni5ox76wM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-PKo7gkhwPheQM79qjuQhkg-1; Thu, 24 Jun 2021 14:48:41 -0400
X-MC-Unique: PKo7gkhwPheQM79qjuQhkg-1
Received: by mail-ot1-f72.google.com with SMTP id z60-20020a9d24c20000b029045ef35e4636so4056438ota.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 11:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNg9Wq5m1VbMd3O85AU7blSYJl1f6ygn421IFBSPGw4=;
        b=VF72FTOzWrfdL+NML1fAtqWcoCHXrDuGyDngs80otnliW1/f0LJHOUqNbK0scr4RF/
         lGZWuU4Tct3WHm5QyovPEyWmCNI0c2/XmlHZyrxZlweFFnAB7yhJ1k8ugQwnPAVM9b4K
         VFGNesy1W3AH+xPsSzkZiX4ZTrgCLHeO45LsHF3yELPsEpL5o3DZv+I4E+M66mp8b2lN
         O1ewZwmq/WJO58p6c+zmgr2e1Isy0FB34aNESfzFm6L7WB26nkZBUAEaUgjbDokUAQdX
         41XcT3id5pUwHRlCivSGdmSZ/F1Ik4wWJRuoiE0DPsWJC2PGyxEsfVAwBRLvGMXosTIA
         R1jQ==
X-Gm-Message-State: AOAM530v4e4L1dWYe/g2iPLnKE69HtNMvSCEUbFNcNinnkqbteKp6IT4
        b44cNj1isvJoNXCg4pMOvZx8Jv78jsiKli4q3ZEM4r5RcJ5kOXjX8lYsDzrj28MNwr+oiMCIEYX
        bI6he9/QJVOEkP9DY+9yo
X-Received: by 2002:a4a:9863:: with SMTP id z32mr5585640ooi.37.1624560520523;
        Thu, 24 Jun 2021 11:48:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU0ze/kEarHzCX2HjFxCcEH4B/4H0wuysel+p0dtbgq8Vkn1XmNwRZVrwk4jcuz9r/80IzYQ==
X-Received: by 2002:a4a:9863:: with SMTP id z32mr5585630ooi.37.1624560520315;
        Thu, 24 Jun 2021 11:48:40 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id 26sm799626ooy.46.2021.06.24.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 11:48:39 -0700 (PDT)
Date:   Thu, 24 Jun 2021 12:48:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210624124838.4accc23c.alex.williamson@redhat.com>
In-Reply-To: <20210624161559.GA3532867@bjorn-Precision-5520>
References: <20210624152809.m3glwh6lxckykt33@archlinux>
        <20210624161559.GA3532867@bjorn-Precision-5520>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Jun 2021 11:15:59 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+to Alex]
> 
> On Thu, Jun 24, 2021 at 08:58:09PM +0530, Amey Narkhede wrote:
> > On 21/06/24 07:23AM, Bjorn Helgaas wrote:  
> > > On Tue, Jun 08, 2021 at 11:18:50AM +0530, Amey Narkhede wrote:  
> > > > Currently there is separate function pcie_has_flr() to probe if pcie flr is
> > > > supported by the device which does not match the calling convention
> > > > followed by reset methods which use second function argument to decide
> > > > whether to probe or not.  Add new function pcie_reset_flr() that follows
> > > > the calling convention of reset methods.  
> > >  
> > > > +/**
> > > > + * pcie_reset_flr - initiate a PCIe function level reset
> > > > + * @dev: device to reset
> > > > + * @probe: If set, only check if the device can be reset this way.
> > > > + *
> > > > + * Initiate a function level reset on @dev.
> > > > + */
> > > > +int pcie_reset_flr(struct pci_dev *dev, int probe)
> > > > +{
> > > > +	u32 cap;
> > > > +
> > > > +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > > > +		return -ENOTTY;
> > > > +
> > > > +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > > > +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> > > > +		return -ENOTTY;
> > > > +
> > > > +	if (probe)
> > > > +		return 0;
> > > > +
> > > > +	return pcie_flr(dev);
> > > > +}  
> > >
> > > Tangent: I've been told before, but I can't remember why we need the
> > > "probe" interface.  Since we're looking at this area again, can we add
> > > a comment to clarify this?
> > >
> > > Every time I read this, I wonder why we can't just get rid of the
> > > probe and attempt a reset.  If it fails because it's not supported, we
> > > could just try the next one in the list.  
> > 
> > Part of the reason is to have same calling convention as other reset
> > methods and other reason is devices that run in VMs where various
> > capabilities can be hidden or have quirks for avoiding known troublesome
> > combination of device features as Alex explained here
> > https://lore.kernel.org/linux-pci/20210624151242.ybew2z5rseuusj7v@archlinux/T/#mb67c09a2ce08ce4787652e4c0e7b9e5adf1df57a
> > 
> > On the side note as you suggested earlier to cache flr capability
> > earlier the PCI_EXP_DEVCAP reading code won't be there in next version
> > so its just trivial check(dev->has_flr).  
> 
> Sorry, I didn't make my question clear.  I'm not asking why we're
> adding a "probe" argument to pcie_reset_flr() to make it consistent
> with pci_af_flr(), pci_pm_reset(), pci_parent_bus_reset(), etc.  I
> like making the interfaces consistent.
> 
> What I'm asking here is why the "probe" argument exists for *any* of
> these interfaces and why pci_probe_reset_function() exists.
> 
> This is really more a question for Alex since it's a historical
> question, not anything directly related to your series.  I'm not
> proposing *removing* the "probe" argument; I know it exists for a
> reason because I've asked about it before.  But I forgot the answer,
> which makes me think a hint in the code would be useful.

Heh [1]

That might be what you're recalling, but in that case I was adding
exported symbols that allowed probing bus vs slot reset because the
scope of affected devices is different.  My use case is testing whether
the user owns all the affected devices, so it's really not a
test-by-doing opportunity.

For these single-function scoped resets, as in the reply to [1]
pci_probe_reset_function() isn't exported and the only caller is
internal PCI code to determine whether to create the 'reset' sysfs
attribute.  Sure, as it exists today we could reset the device and test
whether it worked to get that value, that's what vfio-pci does now
before we give the device to the user, but the critical difference is
that in the vfio case we always want to flush any state that might be
leaked to the user and at device init time, doing so only invites
issues.

This series obviously expands the scope of probing, we don't just want
to know that there's at least one method available to us, but precisely
which ones.  It's rather impractical to try to reset a function a half
dozen different ways on boot for the possibility that the admin might
want to manipulate the reset order later.  And oh gosh, if we don't
cache the methods supported and re-test-by-doing when the attribute is
written, let's just not go there.  Thanks,

Alex

[1]https://lore.kernel.org/linux-pci/CAErSpo625CTnxZvy-gmy8VzxT4favF4s=_giU6nGey_N=VwK5A@mail.gmail.com/

