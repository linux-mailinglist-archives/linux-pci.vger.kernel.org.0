Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB424E3C5
	for <lists+linux-pci@lfdr.de>; Sat, 22 Aug 2020 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHUXJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 19:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31933 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgHUXJQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 19:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598051354;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YoGMG+JRN7O5/b+X45Zcff1GWDQkP/qhBirhYs5JQQ=;
        b=WA+iMid2Z3k7MMR7CsHKhw7187KrFUtZOW2CG8qZhqzbm/xNG/OOufW1dkc9qEdBdEkvID
        5xvkvG6MBsLVMq34NolLmlWVWCO3027aJ/VAHQ4BS5gPyBtp/vlwayIzu0k7z5QD2Oi0mW
        7ajIijguVErCTYPvJHc/LJnLW7gGAkk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-Nx4MPqOjNRS5wXV_D4vgnw-1; Fri, 21 Aug 2020 19:09:12 -0400
X-MC-Unique: Nx4MPqOjNRS5wXV_D4vgnw-1
Received: by mail-qk1-f198.google.com with SMTP id x20so2391982qki.20
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2020 16:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=9YoGMG+JRN7O5/b+X45Zcff1GWDQkP/qhBirhYs5JQQ=;
        b=CKFtR3Zic5f1EQJ6RBDx8UeleF+VQvVM4313bIrEwa285LY1hcjN9KfwoeMx30yhYd
         4Kbs0bi6lawVLLe6ODXSzoGwQjimb+ljnQJGi2OalPa9k1kRgf2xRvvSGCwrPjiTsr7Q
         6iGes5fXaWKaNDWDJHn+nScUHQFXfHr+RxVRIo5yPTiRZnBD904aHy8iMIpAXxbIK4ml
         PWu1I+cIoq5zQAVmuvGcovEw9cBXqdMSXfDAwMg0vG9L138DlI+n6ng2pbL/PhtxV3uw
         iCAmgv7k3hLVyUwo2so0HBWJPNd/htFbGIW1pVnbm4ykjr5amAMCROFNzC8Xf6RRpWS+
         eOxA==
X-Gm-Message-State: AOAM530nXaOUeyq7efQ+24K7xPmi31lYyYlw0hmt7FYsmfww+IldLusx
        hXLJqQBpN5gjQXNlUHPt0qVZCw5wZXwTtFjO/gYKO3OdkszYq+ztteko65oQJ9PBOqTOy1KxnNi
        qcfvS6NPYzb6HscHBKfNb
X-Received: by 2002:a05:620a:4ec:: with SMTP id b12mr5016242qkh.266.1598051351948;
        Fri, 21 Aug 2020 16:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMwqMMblU/OY++naylTH5ERTJmsJmmazeFPjgAOO9Dmr4WUU/vidVrgEnXA3oyb+8F67RUBw==
X-Received: by 2002:a05:620a:4ec:: with SMTP id b12mr5016219qkh.266.1598051351670;
        Fri, 21 Aug 2020 16:09:11 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id r73sm3026726qka.76.2020.08.21.16.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 16:09:10 -0700 (PDT)
Message-ID: <1c01b565beb70e22e3a4babb64910afdfbf08854.camel@redhat.com>
Subject: Re: [PATCH] PCI/PM: Assume ports without DLL Link Active train
 links in 100 ms
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Date:   Fri, 21 Aug 2020 19:09:09 -0400
In-Reply-To: <20200821093224.GN1375436@lahna.fi.intel.com>
References: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
         <20200820081314.l25cjoehbnvbjbrk@wunner.de>
         <825a566040de2eedc81350cc914dd38dcc3ba4ff.camel@redhat.com>
         <20200821093224.GN1375436@lahna.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-08-21 at 12:32 +0300, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Aug 20, 2020 at 11:36:37AM -0400, Lyude Paul wrote:
> > On Thu, 2020-08-20 at 10:13 +0200, Lukas Wunner wrote:
> > > On Wed, Aug 19, 2020 at 04:06:25PM +0300, Mika Westerberg wrote:
> > > > Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting,
> > > > but
> > > > at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the
> > > > Intel
> > > > JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.
> > > [...]
> > > > +	 * Also do the same for devices that have power management
> > > > disabled
> > > > +	 * by their driver and are completely power managed through the
> > > > +	 * root port power resource instead. This is a special case for
> > > > +	 * nouveau.
> > > >  	 */
> > > > -	if (!pci_is_pcie(dev)) {
> > > > +	if (!pci_is_pcie(dev) || !child->pm_cap) {
> > > 
> > > It sounds like the above-mentioned Thunderbolt controllers are broken,
> > > not the Nvidia cards, so to me (as an outside observer) it would seem
> > > more logical that a quirk for the former is needed.  The code comment
> > > suggests that nouveau somehow has a problem, but that doesn't seem to
> > > be the case (IIUC).  Also, it's a little ugly to have references to
> > > specific drivers in PCI core code.
> > > 
> > > Maybe this can be fixed with quirks for the Thunderbolt controllers
> > > which set a flag, and that flag causes the 1000 msec wait to be skipped?
> > 
> > Sorry, some stuff came up yesterday so I didn't get the time to go through
> > my
> > laptops and test them. I do agree with this though - I'd be worried as well
> > that
> > nouveau might not be the only driver out there that needs this kind of delay
> 
> I actually expect that nouveau is the only one because it is doing some
> PM tricks to get the runtime PM working, which is that it leaves the GPU
> device in D0 and puts the parent root port into D3cold. The BIOS ASL
> code has some assumptions there and I think this 1000 ms delay just
> works that around by luck ;-)
> 
> IIRC Bjorn suggested quirking the affected downstream ports when I
> originally sent the patch but I thought we could make this solution more
> generic. Which of course, did not work too well.
> 
> I can look into the quirk solution instead if this is what people
> prefer.

yeah, probably the safest bet IMO.
> 
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

