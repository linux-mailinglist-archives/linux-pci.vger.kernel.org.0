Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAA32DEAD
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 01:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCEAyj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 19:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhCEAyj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Mar 2021 19:54:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A80464FD3;
        Fri,  5 Mar 2021 00:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614905679;
        bh=pdbYsCixpnJcpu95KMX8J/+Q5j2dCNDDxk9L65ZPpQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fP362Y3J0TOzuZ2gEgVcQKV+3VGweZ4VFAFmwZCd9kjKimu1h8R+FxcMVoygI5pS0
         W8PQPwbMFk/zjA9Jj4PIwpQZYIBrhJuZWEcyAJjNien5EWLyhON8G9hUuo/hIjseBW
         6YD6QnYrDBo1pfoVp22px2S0UApoPaHSh2JTy+vgsA4Kmit4ON+YYqiUTU131tg/s2
         kpcd1f5DbKdOiH3S0jzEw/snRjhplP/0834dGY5LwSMAixJ7yGN/0fpP6xLLN0wgfs
         fde/oanTUNdB7qKsP9P13K6tykv6Ad1SWvS/U2XaBId9jvR5NLRwTc+cy5B6xLqVck
         06geUALu2a3gg==
Date:   Fri, 5 Mar 2021 09:54:32 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
Message-ID: <20210305005432.GC32558@redsun51.ssa.fujisawa.hgst.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
 <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com>
 <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
 <CAPcyv4gZPc3izOaRBx8sBBM_1YV3F3OMjjZX8Ha0m3PxzJhiCw@mail.gmail.com>
 <23551edc-965c-21dc-0da8-a492c27c362d@intel.com>
 <CAPcyv4jFYtNeA7TdeCBh5v1S=Pw2BGvdv91SMjX0MTj_0VE4DQ@mail.gmail.com>
 <4c2a799f-c4e9-b203-3487-f9c117fba5e7@intel.com>
 <CAPcyv4iHPEtpftGMMqkvKW5_SaLJN5R=kVV8urnqibJ5-Lo=_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iHPEtpftGMMqkvKW5_SaLJN5R=kVV8urnqibJ5-Lo=_A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 04, 2021 at 04:23:01PM -0800, Dan Williams wrote:
> On Thu, Mar 4, 2021 at 3:19 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@intel.com> wrote:
>
> > If the handler is not available due to AER being owned by firmware,
> > then it needs to be fixed. In EDR mode, even if DPC/AER is owned
> > by firmware , OS need to own the recovery part. So I think it
> > needs further investigation to understand why it reports,
> > PCI_ERS_RESULT_NO_AER_DRIVER
> 
> As far as I can see the only way to get PCI_ERS_RESULT_NO_AER_DRIVER
> is when there actually is no handler, or the device io state has set
> to failed. I notice the hotplug handler sets the device io state to
> failed while processing link down. If the device is actually missing a
> handler definition then disconnect seems the right response.

Hypothetically speaking, if a DPC event occurs at the Root Port above a
deep PCIe topology, it only takes one device with no handler to spoil
the recovery for the well behaved drivers lower in the hierarchy. We can
probably handle that better if this scenario actually happens. Not sure
if does happen, but the switchtec driver looks sus.
