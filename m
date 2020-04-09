Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000E01A380D
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 18:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgDIQaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 12:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgDIQaM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 12:30:12 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B2220768;
        Thu,  9 Apr 2020 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586449813;
        bh=+wKgUY4xPEL2B7OSdu9XtH4IEr/uCzSkIhx5aEsQj0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bPYVfOst2uJUje/mHcpqLriabCtf5itqV5pNIQdxCAIgkiIX4LV0mF4NKF4Ji6yB3
         IUgR49FUvbpl5Od+SN4U3LuF3d+tv3TQn+WNGlrxLhQO3O0uEDjupdcwwOC3HTWGJx
         XNVyBnVYhLMhkotG9nnJVl05BHC2TGWw2k10fnok=
Date:   Thu, 9 Apr 2020 11:30:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200409163010.GA8879@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1oCwx=w3S0ednwM2mJEEidqF3saEKu9OQP=i82y3Az0Aw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 09, 2020 at 04:25:40PM +0100, Luís Mendes wrote:
> Hi Bjorn,
> 
> I've good news. I've found the culprit and it is a pretty simple
> issue, however the good solution is not obvious to me.
> Can you help in finding the best way to patch this issue?
> 
> So first detailing the problem in file setup_bus.c there is this *if
> condition* to ignore resources from classless devices and so
> it is that this Google/Coral Edge TPU is a classless device with class 0xff:
> 
> static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
> {
>     u16 class = dev->class >> 8;
> 
>        pci_info(dev, "%s\n", __func__);
>     /* Don't touch classless devices or host bridges or IOAPICs */
>     if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
>         return;
>    ....
> 
> So the one possible trivial, non generic, attempt that works is to do:
> static void __dev_sort_resources(struct pci_dev *dev, struct list_head *head)
> {
>     u16 class = dev->class >> 8;
> 
>        pci_info(dev, "%s\n", __func__);
>     /* Don't touch classless devices or host bridges or IOAPICs */
>     if ((class == PCI_CLASS_NOT_DEFINED &&  !(dev->vendor == 0x1ac1 &&
> dev->device==0x089a)) || class == PCI_CLASS_BRIDGE_HOST)
>         return;
>    ....
> 
> What is your suggestion to make the solution generic? Create a
> whitelist? Remove this verification? I have no idea... nothing sounds
> good to me...

Good detective work, thanks for chasing this down!

I should have seen that check when adding the debug.  Guess I thought
"sort", hmmm, that just re-orders things without actually changing the
content.  But pdev_sort_resources() in fact *adds* resources to a
list, and if resources aren't on the list, we apparently don't assign
space for them.

In any event, I would first check to see if there's an Edge TPU
firmware update that might set the class code.

If not, we should probably add a quirk to override the class code,
similar to quirk_eisa_bridge(), fixup_rev1_53c810(),
fixup_ti816x_class(), quirk_tw686x_class().

Bjorn
