Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32523103E16
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfKTPPt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 10:15:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:50323 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfKTPPt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 10:15:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 07:15:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="215831473"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 20 Nov 2019 07:15:43 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Nov 2019 17:15:42 +0200
Date:   Wed, 20 Nov 2019 17:15:42 +0200
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191120151542.GH11621@lahna.fi.intel.com>
References: <20191119214955.GA223696@google.com>
 <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
 <20191120101816.GX11621@lahna.fi.intel.com>
 <CAJZ5v0g4vp1C+zHU5nOVnkGsOjBvLaphK1kK=qAT6b=mK8kpsA@mail.gmail.com>
 <20191120112212.GA11621@lahna.fi.intel.com>
 <20191120115127.GD11621@lahna.fi.intel.com>
 <CACO55tsfNOdtu5SZ-4HzO4Ji6gQtafvZ7Rm19nkPcJAgwUBFMw@mail.gmail.com>
 <CACO55tscD_96jUVts+MTAUsCt-fZx4O5kyhRKoo4mKoC84io8A@mail.gmail.com>
 <20191120120913.GE11621@lahna.fi.intel.com>
 <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 01:11:52PM +0100, Karol Herbst wrote:
> On Wed, Nov 20, 2019 at 1:09 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 12:58:00PM +0100, Karol Herbst wrote:
> > > overall, what I really want to know is, _why_ does it work on windows?
> >
> > So do I ;-)
> >
> > > Or what are we doing differently on Linux so that it doesn't work? If
> > > anybody has any idea on how we could dig into this and figure it out
> > > on this level, this would probably allow us to get closer to the root
> > > cause? no?
> >
> > Have you tried to use the acpi_rev_override parameter in your system and
> > does it have any effect?
> >
> > Also did you try to trace the ACPI _ON/_OFF() methods? I think that
> > should hopefully reveal something.
> >
> 
> I think I did in the past and it seemed to have worked, there is just
> one big issue with this: it's a Dell specific workaround afaik, and
> this issue plagues not just Dell, but we've seen it on HP and Lenovo
> laptops as well, and I've heard about users having the same issues on
> Asus and MSI laptops as well.

Maybe it is not a workaround at all but instead it simply determines
whether the system supports RTD3 or something like that (IIRC Windows 8
started supporting it). Maybe Dell added check for Linux because at that
time Linux did not support it.

In case RTD3 is supported it invokes LKDS() which probably does the L2
or L3 entry and this is for some reason does not work the same way in
Linux than it does with Windows 8+.

I don't remember if this happens only with nouveau or with the
proprietary driver as well but looking at the nouveau runtime PM suspend
hook (assuming I'm looking at the correct code):

static int
nouveau_pmops_runtime_suspend(struct device *dev)
{       
        struct pci_dev *pdev = to_pci_dev(dev);
        struct drm_device *drm_dev = pci_get_drvdata(pdev);
        int ret;

        if (!nouveau_pmops_runtime()) {
                pm_runtime_forbid(dev);
                return -EBUSY;
        }

        nouveau_switcheroo_optimus_dsm();
        ret = nouveau_do_suspend(drm_dev, true);
        pci_save_state(pdev);
        pci_disable_device(pdev);
        pci_ignore_hotplug(pdev);
        pci_set_power_state(pdev, PCI_D3cold);
        drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
        return ret;
}

Normally PCI drivers leave the PCI bus PM things to PCI core but here
the driver does these. So I wonder if it makes any difference if we let
the core handle all that:

static int
nouveau_pmops_runtime_suspend(struct device *dev)
{       
        struct pci_dev *pdev = to_pci_dev(dev);
        struct drm_device *drm_dev = pci_get_drvdata(pdev);
        int ret;

        if (!nouveau_pmops_runtime()) {
                pm_runtime_forbid(dev);
                return -EBUSY;
        }

        nouveau_switcheroo_optimus_dsm();
        ret = nouveau_do_suspend(drm_dev, true);
        pci_ignore_hotplug(pdev);
        drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
        return ret;
}

and similar for the nouveau_pmops_runtime_resume().
