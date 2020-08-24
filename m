Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5568E25043E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 18:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHXQ7u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 12:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHXQ7g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Aug 2020 12:59:36 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159A1204EA;
        Mon, 24 Aug 2020 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598288375;
        bh=YHRGZbO6r7aa++bsMs/Ah4zu2lW82a+88z6QKkNJ26Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T6sMmjNcTYcq7tVSLRTsK/lez0Lv3lSfQflsxIWPn5djjgMTocBjt2FaVa3r+gEI1
         YxiTJVkLjG5AwStVORYCdQXkEAmcQBVWgGKSslUVwYpB12D1K7wR0Lh/bxSLoB05oy
         NfArIGZxEEnNtlDzIcfgzutV9tH7flKvIAebq/gU=
Date:   Mon, 24 Aug 2020 11:59:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] PCI: Add #defines for max payload size options
Message-ID: <20200824165933.GA1852309@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1276C8F286C45A96656A7A87DA560@DM5PR12MB1276.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 04:49:27PM +0000, Gustavo Pimentel wrote:
> On Thu, Aug 20, 2020 at 21:59:42, Bjorn Helgaas <helgaas@kernel.org> 
> wrote:
> 
> > On Thu, Aug 13, 2020 at 04:08:50PM +0200, Gustavo Pimentel wrote:
> > > Add #defines for the max payload size options. No functional change
> > > intended.
> > > 
> > > Cc: Joao Pinto <jpinto@synopsys.com>
> > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index f970141..db625bd 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -503,6 +503,12 @@
> > >  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
> > >  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
> > >  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_128B  0x0000 /* 128 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_256B  0x0020 /* 256 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_512B  0x0040 /* 512 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> > > +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
> > 
> > I would apply this if we actually *used* these anywhere, but I'm not
> > sure it's worth adding them just as documentation.
> 
> Hi Bjorn,
> 
> I'll be using that with a driver that I developed. I didn't send the 
> driver yet, because I'm still waiting for a final validation from a 
> colleague that is on vacation. If you want I can include this patch with 
> the driver patch set.

Yes, please include it with the driver.  Thanks!

Bjorn
