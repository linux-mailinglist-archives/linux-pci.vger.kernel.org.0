Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED41424A4C7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 19:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSRUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 13:20:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:36258 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSRUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 13:20:12 -0400
IronPort-SDR: qKKIN/Kc5kEQEC4IeXq8O0w++nucQXnfBaQgfEwV7C04wAUMPwcd1jVKUJqpxptXZghEfI/3qa
 WBSdG+OtmdVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="173209235"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="173209235"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 10:20:12 -0700
IronPort-SDR: yLwMDgiIvep4xw0xNoe4nd6iOtncElL1vTq8HlEZ+a5c+uhYBVN+KUPxq2nFfMKRLqz1Tn8RZy
 LAFe2ODt9nMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="400892933"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 19 Aug 2020 10:20:09 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Aug 2020 20:20:08 +0300
Date:   Wed, 19 Aug 2020 20:20:08 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Assume ports without DLL Link Active train links
 in 100 ms
Message-ID: <20200819172008.GO1375436@lahna.fi.intel.com>
References: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
 <1777574256b2f8acacbf1d77ec78862a638b28e0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1777574256b2f8acacbf1d77ec78862a638b28e0.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 12:58:18PM -0400, Lyude Paul wrote:
> On Wed, 2020-08-19 at 16:06 +0300, Mika Westerberg wrote:
> > Kai-Heng Feng reported that it takes a long time (> 1 s) to resume
> > Thunderbolt-connected devices from both runtime suspend and system sleep
> > (s2idle).
> > 
> > This was because some Downstream Ports that support > 5 GT/s do not also
> > support Data Link Layer Link Active reporting.  Per PCIe r5.0 sec 6.6.1:
> > 
> >   With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
> >   software must wait a minimum of 100 ms after Link training completes
> >   before sending a Configuration Request to the device immediately below
> >   that Port. Software can determine when Link training completes by polling
> >   the Data Link Layer Link Active bit or by setting up an associated
> >   interrupt (see Section 6.7.3.3).
> > 
> > Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting, but
> > at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the Intel
> > JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.
> > 
> > Previously we tried to wait for Link training to complete, but since there
> > was no DLL Link Active reporting, all we could do was wait the worst-case
> > 1000 ms, then another 100 ms.
> > 
> > Instead of using the supported speeds to determine whether to wait for Link
> > training, check whether the port supports DLL Link Active reporting.  The
> > Ports in question do not, so we'll wait only the 100 ms required for Ports
> > that support Link speeds <= 5 GT/s.
> > 
> > This of course assumes these Ports always train the Link within 100 ms even
> > if they are operating at > 5 GT/s, which is not required by the spec.
> > 
> > This version adds a special check for devices whose power management is
> > disabled by their driver (->pm_cap is set to zero). This is needed to
> > avoid regression with some NVIDIA GPUs.
> 
> Hm, I'm not entirely sure that the link training delay is specific to laptops
> with ->pm_cap set to 0, I think we should try figuring out if there's any
> laptops that match those characteristics before moving forward with this - I'll
> take a look through the test machines I've got available today

OK, thanks!
