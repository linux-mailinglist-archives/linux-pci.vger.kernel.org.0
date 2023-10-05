Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF37BA11D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjJEOnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjJEOiP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 10:38:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850AD4E361
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514619; x=1728050619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LuM3macVI1qvKuiMhDqeyzM9/w1PNpImMiN+bMazFH8=;
  b=LzeaPVDZm4euICmNFvpLNX3n286Mgod4FEDi2ed5QkA/WBj1hdzqRD4U
   Ip4CNyS46+C9Ajm1LZjW/zuTulbyZmWh8s/8E4yLQib50imxhe58Q++O4
   /hlehLZSyyxJEfPcHXy44INYCeJmAOBlayV66krHBdPUDe8a6NKm2yEua
   wWDcYqr7+nsZRHAvZxrmg05h2bLAUS39V/q0u052UPqJBbz8ypBge8NU+
   yv0Aj/Z+xYk9rpth9R/9KaOWn3WzyoUpyhdE8QGsJXbsijDJQJ1HdXjMJ
   grvzR7DsCXHm8U58hQ3jGoD4Cr4qMy47aJHp4d20SJUaglUE/UCPAMzwr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="380727281"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="380727281"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 02:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="751713060"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="751713060"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2023 02:02:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 524E535A; Thu,  5 Oct 2023 12:02:58 +0300 (EEST)
Date:   Thu, 5 Oct 2023 12:02:58 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>,
        Koba Ko <koba.ko@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ASPM: Add back L1 PM Substate save and restore
Message-ID: <20231005090258.GQ3208943@black.fi.intel.com>
References: <20231002070044.2299644-1-mika.westerberg@linux.intel.com>
 <20231004222324.GA718849@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231004222324.GA718849@bhelgaas>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 04, 2023 at 05:23:24PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 02, 2023 at 10:00:44AM +0300, Mika Westerberg wrote:
> > Commit a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
> > for suspend/resume"") reverted saving and restoring of ASPM L1 Substates
> > due to a regression that caused resume from suspend to fail on certain
> > systems. However, we never added this capability back and this is now
> > causing systems fail to enter low power CPU states, drawing more power
> > from the battery.
> 
> AFAICT, the save (suspend) side is effectively the same in
> 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume") (the change reverted by a7152be79b62) and in this
> patch.  There are minor ordering differences with respect to DPC and
> AER, but I don't think they're relevant.
> 
> > The original revert mentioned that we restore L1 PM substate configuration
> > even though ASPM L1 may already be enabled. This is due the fact that
> > the pci_restore_aspm_l1ss_state() was called before pci_restore_pcie_state().
> > 
> > Try to enable this functionality again following PCIe r6.0.1, sec 5.5.4
> > more closely by:
> > 
> >   1) Do not restore ASPM configuration in pci_restore_pcie_state() but
> >      do that after PCIe capability is restored in pci_restore_aspm_state()
> >      following PCIe r6.0, sec 5.5.4.
> > 
> >   2) ASPM is first enabled on the upstream component and then downstream
> >      (this is already forced by the parent-child ordering of Linux
> >      Device Power Management framework).
> > 
> >   3) Program ASPM L1 PM substate configuration before L1 enables.
> > 
> >   4) Program ASPM L1 PM substate enables last after rest of the fields
> >      in the capability are programmed.
> 
> This patch changes the restore (resume) side.  4ff116d0d5fd restored
> L1SS state followed by LNKCTL.
> 
> This patch instead restores LNKCTL (with ASPM *disabled*) before the
> L1SS state, and then restores the full LNKCTL (including ASPM config).

Right.

> >   5) Add denylist that skips restoring on the ASUS and TUXEDO systems
> >      where these regressions happened, just in case. For the TUXEDO case
> >      we only skip restore if the BIOS is involved in system suspend
> >      (that's forcing "mem_sleep=deep" in the command line). This is to
> >      avoid possible power regression when the default suspend to idle is
> >      used, and at the same time make sure the devices continue working
> >      after resume when the BIOS is involved.
> 
> I looked through the v1, v2, and v3 threads, and I see testing failure
> reports from Thomas (TUXEDO) for v1 and "v1.5" [1].  v1.5 looks
> functionally identical to this v4 except it lacks the TUXEDO denylist
> entry.
> 
> I don't see any actual success reports for either ASUS or TUXEDO.
> 
> Do we have testing reports for these ASUS and TUXEDO systems showing
> that we need this denylist?  I think this patch fixes a real problem
> with L1SS save/restore, and unless proven otherwise, I would assume
> that it fixes ASUS and TUXEDO as well.

The thing with TUXEDO is that on Thomas's system with mem_sleep=deep
this patch (without denylist) breaks the resume as he describes here:

https://bugzilla.kernel.org/show_bug.cgi?id=216877

However, on exact same TUXEDO system with the same firmwares Werner is
not able to reproduce the issue with or without the patch. So I'm not
sure what to do and that's why I added denylist that should take effect
on Thomas' system when mem_sleep=deep is set but also work on the same
system without it.

And since we have the denylist, I decided to add the ASUS there to avoid
accidentally breaking those too.

Let me know if you have any preference what we should do with the TUXEDO
one. I really don't know any better way to keep everyone happy.

> [1] https://lore.kernel.org/linux-pci/20230630104154.GS14638@black.fi.intel.com/
> 
> > Reported-by: Koba Ko <koba.ko@canonical.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217321
> 
> IIUC, Koba's report is on a Dell Inspiron 15 3530.

Right.

> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216877
> 
> These are the original issues reported with 4ff116d0d5fd: 216782 is
> the ASUS UX305FA problem reported by Tasev, and 216877 is the TUXEDO
> problem reported by Thomas.
> 
> So ... I think this patch definitely fixes a problem.  4ff116d0d5fd
> restored L1SS state before LNKCTL on the assumption that ASPM was
> disabled at the point, but I don't think we really know that.
> 
> This patch explicitly disables ASPM before restoring L1SS, which seems
> safer.
> 
> But we just punt on the ASUS and TUXEDO systems, when there's no
> reason we shouldn't be able to restore ASPM config there as well.  And
> unless I missed them, we don't actually have testing reports from
> ASUS, TUXEDO, or Koba's Dell.

Just for the record, the Dell and probably others to the real issue is
that if we don't restore these the CPU can't enter lower power C-states
and that makes suspend to empty the battery much faster than user would
expect. So some solution to this is definitely needed sooner rather than
later.

@Koba, can you provide your tested-by if this solves the issue on the
Dell system?

> I think there's still something we're missing.
> 
> We restore the LTR config before restoring DEVCTL2 (including the LTR
> enable bit) and L1SS state.  I don't think we know the state of ASPM
> and L1SS at that point, do we?  Do you think there could be an issue
> there, too?

AFAICT LTR does not affect until it is explicitly enabled and I don't
think many drivers actually program it (although we have some sort of
API for it at least for Intel LPSS devices).

If you have suggestions, I'm all open. If I understand you would like
this to be done like:

  - Drop the denylist
  - Add back the suspend/restore of L1SS
  - Ask everyone in this thread to try it out

I can do that no problem but I guess that for the TUXEDO one (Thomas')
it probably is going to fail still.
