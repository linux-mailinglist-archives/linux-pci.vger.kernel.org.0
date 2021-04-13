Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22A735DA32
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 10:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhDMIjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 04:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhDMIjk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 04:39:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2344613AE;
        Tue, 13 Apr 2021 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618303159;
        bh=ItkAoNGP8VQxfvgpcLGmydidw9Yk9P26P+iVUwyLXZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJq/g+fxD+xIXZSH6dR1ZG3oa/RGRhg7nXGsjW8Hs/p3pb4khEtfF7CgcY5BnY9cf
         nnMYeDnw626HtOGoVh0/8FZb51ViSdw4hKqH1rAfztryZAcCf3c8+/Dq1kGKMU6K13
         ITD4owpp9nv+3I7hIqU9Pfn0NHLNodMZuPbkxkYCSp6IPAf5TmMtlZrvAB4VZlUCSz
         ZbIJY3Swnvjf1RUpaq6rwRhCsdyHdg4nEM3fY87k7LzL+UXinuYwzUFpuiOAAMdlQg
         fRbdu6XBuA1P9LGCoCTETFyoaMy87qTlwQ81aKAOY9wQBK/rhA8Nlg+amVTBYcz6nC
         CZKPJh+EpUbcA==
Received: by pali.im (Postfix)
        id 996C9860; Tue, 13 Apr 2021 10:39:16 +0200 (CEST)
Date:   Tue, 13 Apr 2021 10:39:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20210413083916.5wwe6lsl65jix3gc@pali>
References: <20210412124602.25762-1-pali@kernel.org>
 <20210412192740.GA2151026@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412192740.GA2151026@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 12 April 2021 14:27:40 Bjorn Helgaas wrote:
> On Mon, Apr 12, 2021 at 02:46:02PM +0200, Pali Rohár wrote:
> > Define new PCI_EXP_DEVCTL_PAYLOAD_* macros in linux/pci_regs.h header file
> > for Max Payload Size. Macros are defined in the same style as existing
> > macros PCI_EXP_DEVCTL_READRQ_* macros.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  include/uapi/linux/pci_regs.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index e709ae8235e7..8f1b15eea53e 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -504,6 +504,12 @@
> >  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
> >  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
> >  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> > +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00A0 /* 4096 Bytes */
> 
> This is fine if we're going to use them, but we generally don't add
> definitions purely for documentation.
> 
> 5929b8a38ce0 ("PCI: Add defines for PCIe Max_Read_Request_Size") added
> the PCI_EXP_DEVCTL_READRQ_* definitions and we do have a few (very
> few) uses in drivers.

I'm planning to use this constant to fix pci-aardvark.c driver. Aardvark
changes are not ready yet, but I'm preparing them in my git tree
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark
(commit PCI: aardvark: Fix PCIe Max Payload Size setting)

But as this is not change in aardvark driver, I sent it separately and
earlier. As it would be dependency for aardvark changes.

> If we do need to add these, please follow the local use of lower-case
> in the hex bitmasks.  The file is a mixture, but the closest examples
> are lower-case.

Ok, therefore I will change 0x00A0 to 0x00a0.

> >  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
> >  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
> >  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> > -- 
> > 2.20.1
> > 
