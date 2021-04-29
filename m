Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937E236E783
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhD2JEM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 05:04:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240044AbhD2JEK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 05:04:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619687003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFSUvl7s2zdDYPJD+xQRo2Bnr+lexNSci+LEO6W5He8=;
        b=mg1UsGkrLZmlv+D6XG+/HA63O1OSbJeLTZvag6O8WDR5QmzDlgvXKZrGvvmM/UTavO+B8w
        ouN4qPqyDQg7whZdxwdw6cFzlCobEv6Zjz2N6ic8tf0Y1dJwrIvZqn5JFtNGFJL/L0ehFX
        3QPc4oE+e1wPdP/HiH8njEBM/XKdJIc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F126AFA9;
        Thu, 29 Apr 2021 09:03:23 +0000 (UTC)
Message-ID: <5ac7634acbe7569879234ad541879c79918f3e00.camel@suse.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI
 devices
From:   Oliver Neukum <oneukum@suse.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Date:   Thu, 29 Apr 2021 11:03:20 +0200
In-Reply-To: <CAJZ5v0jEbjRSGPdfwvegawin5_N=m-UoP+Wa99EQ-QmkusiBCg@mail.gmail.com>
References: <20210424021631.1972022-1-rajatja@google.com>
         <20210424021631.1972022-2-rajatja@google.com>
         <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
         <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
         <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
         <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
         <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com>
         <0601e45130495b152bec04eee4a50e302db4cfd2.camel@suse.com>
         <CAJZ5v0jEbjRSGPdfwvegawin5_N=m-UoP+Wa99EQ-QmkusiBCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, den 28.04.2021, 14:21 +0200 schrieb Rafael J. Wysocki:

> In principle, in the wake of Thunderbolt every PCI driver handling
> PCIe devices needs to be able to deal with a device that's gone away
> without notice, because in principle any PCIe device can be included
> into a Thunderbolt docking station which may go away as a whole
> without notice.

Yes, but we are dealing with what we export to user space, don't we?

	Regards
		Oliver



