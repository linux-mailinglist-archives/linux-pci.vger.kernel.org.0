Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53E1E2A24
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 20:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgEZSfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 14:35:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:38312 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgEZSfC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 14:35:02 -0400
IronPort-SDR: HLgmo8LAcD1WrfC8fnTadiTCz9SptjwJGTBN+2nidyVz/xZLVFH6dcNoUJmTYkL5MfJpOwqgjc
 U5OG73fNRUmg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 11:35:01 -0700
IronPort-SDR: Y+FI5ZVcXxa++6tH2EuB5e/A5meiAUK4eJ01+7jBspT26gqSwzsmUGMfjWsRBeKJNwkIM55H1/
 AZzrs7JRxjpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="291295609"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 11:34:57 -0700
Date:   Tue, 26 May 2020 11:34:57 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Darrel Goeddel <DGoeddel@forcepoint.com>,
        Mark Scott <mscott@forcepoint.com>,
        Romil Sharma <rsharma@forcepoint.com>,
        Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200526183457.GC36356@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
 <20200505061107.GA22974@araj-mobl1.jf.intel.com>
 <20200505080514.01153835@x1.home>
 <20200505145605.GA13690@otc-nc-03>
 <20200505093414.6bae52e0@x1.home>
 <20200526180648.GC35892@otc-nc-03>
 <20200526122654.7ac087b3@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526122654.7ac087b3@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 12:26:54PM -0600, Alex Williamson wrote:
> > > 
> > > I don't think the language in the spec is anything sufficient to handle
> > > RCiEP uniquely.  We've previously rejected kernel command line opt-outs
> > > for ACS, and the extent to which those patches still float around the
> > > user community and are blindly used to separate IOMMU groups are a
> > > testament to the failure of this approach.  Users do not have a basis
> > > for enabling this sort of opt-out.  The benefit is obvious in the IOMMU
> > > grouping, but the risk is entirely unknown.  A kconfig option is even
> > > worse as that means if you consume a downstream kernel, the downstream
> > > maintainers might have decided universally that isolation is less
> > > important than functionality.  
> > 
> > We discussed this internally, and Intel vt-d spec does spell out clearly 
> > in Section 3.16 Root-Complex Peer to Peer Considerations. The spec clearly
> > calls out that all p2p must be done on translated addresses and therefore
> > must go through the IOMMU.
> > 
> > I suppose they should also have some similar platform gauranteed behavior
> > for RCiEP's or MFD's *Must* behave as follows. The language is strict and
> > when IOMMU is enabled in the platform, everything is sent up north to the
> > IOMMU agent.
> > 
> > 3.16 Root-Complex Peer to Peer Considerations
> > When DMA remapping is enabled, peer-to-peer requests through the
> > Root-Complex must be handled
> > as follows:
> > • The input address in the request is translated (through first-level,
> >   second-level or nested translation) to a host physical address (HPA).
> >   The address decoding for peer addresses must be done only on the 
> >   translated HPA. Hardware implementations are free to further limit 
> >   peer-to-peer accesses to specific host physical address regions 
> >   (or to completely disallow peer-forwarding of translated requests).
> > • Since address translation changes the contents (address field) of the PCI
> >   Express Transaction Layer Packet (TLP), for PCI Express peer-to-peer 
> >   requests with ECRC, the Root-Complex hardware must use the new ECRC 
> >   (re-computed with the translated address) if it decides to forward 
> >   the TLP as a peer request.
> > • Root-ports, and multi-function root-complex integrated endpoints, may
> >   support additional peerto-peer control features by supporting PCI Express
> >   Access Control Services (ACS) capability. Refer to ACS capability in 
> >   PCI Express specifications for details.
> 
> That sounds like it might be a reasonable basis for quirking all RCiEPs
> on VT-d platforms if Intel is willing to stand behind it.  Thanks,
> 

Sounds good.. that's what i hear from our platform teams. If there is a
violation it would be a bug in silicon.  
