Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB8026E77A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgIQVhq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgIQVhq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 17:37:46 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF88720725;
        Thu, 17 Sep 2020 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600378666;
        bh=lfE+7NXV2rCh2vNF2xCWV5wyO2bA3VO8Jj9zJUt0k68=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DcsHyQ2iNLWu6925JgU9Rdo4Mbyqo/wjn8j3u27LU6fh5zwYdNFB7Mhz7fxx/S9/V
         R+OX1D/UFkgnazTvvvV0y0yNHrTNDWfsiLhvt/wPDQK0z63XKRVSsFa/NbG8d0ZnuD
         C/u8TmcXQ92EWaE/lZhe72ILDJIM1/S892+EGVXw=
Date:   Thu, 17 Sep 2020 16:37:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Bjorn Helgaas <bjorn@helgaas.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] PCI: Add support for LTR
Message-ID: <20200917213744.GA1739988@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0jk0CpAqvBrjr67M4+UMo9oW2+Z1NVUFAFsinLgPZzrEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 10:06:43PM +0530, Puranjay Mohan wrote:
> On Wed, Sep 16, 2020 at 3:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Aug 25, 2020 at 11:31:31PM +0530, Puranjay Mohan wrote:

> > > +     dev = pci_upstream_bridge(dev);
> > > +     while (dev) {
> > > +             max_snoop_sum += dev->max_snoop_latency;
> > > +             max_nosnoop_sum += dev->max_nosnoop_latency;
> >
> > dev->max_snoop_latency and dev->max_nosnoop_latency are not simple
> > scalars, are they?  Aren't they 3 bits of scale and 10 bits of value?
> > I don't think adding these is as easy as "+=" except in the simple
> > case when the scale is "000", i.e., "use the 10 bits of value as-is".
> >
> > I think we have to decode scale * latency for each device in the path,
> > add all those up, then re-encode using the appropriate scale for the
> > config write below.
>
> I was thinking about it. If we use 2 more variables and store the
> scale and value separately, then It will become easy.
> we can add the values directly but, as you said we can't add the
> scales, I will think about this more.

Adding more things to struct pci_dev consumes that space permanently
even though it's only needed during enumeration.  This LTR init is
only done once per device, so there's no need to speed it up by adding
more variables.

You'll just have to see how it looks when you code it up.
