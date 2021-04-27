Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49A436C5AE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhD0MAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 08:00:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235391AbhD0MAl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Apr 2021 08:00:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619524797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zx43ULgBMwTj0mmSYV7TpYxKVAjZPN/7jVN4FQEzJA=;
        b=IFMprIKEvsmq1wxwgntBZSpuUmRErNXm3dDpf31FMg+QEv3TSk5g6ee7jUH9usFlsRIa29
        FLV5mRg52VMloev5hNbu/2yQS12KCKSw00Z6Nevwv6tddytNZbZrzhyEjnY9aRo6sv1HKl
        wViVmCFiqIvKWzmRHzVpCkI3M6bgaqk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F3BBB180;
        Tue, 27 Apr 2021 11:59:57 +0000 (UTC)
Message-ID: <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI
 devices
From:   Oliver Neukum <oneukum@suse.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
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
Date:   Tue, 27 Apr 2021 13:59:52 +0200
In-Reply-To: <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
References: <20210424021631.1972022-1-rajatja@google.com>
         <20210424021631.1972022-2-rajatja@google.com>
         <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
         <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
         <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Montag, den 26.04.2021, 13:01 +0000 schrieb David Laight:
> From: Rafael J. Wysocki
> > Sent: 26 April 2021 12:49
> > 
> > On Mon, Apr 26, 2021 at 11:17 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > Am Freitag, den 23.04.2021, 19:16 -0700 schrieb Rajat Jain:
> > > > Export the already available info, to the userspace via the
> > > > device core, so that userspace can implement whatever policies it
> > > > wants to, for external removable devices.
> > > 
> > > Hi,
> > > 
> > > is there a way to tell apart whether a device can undergo regular
> > > surprise removal?
> > 
> > PCI devices located under a removable parent can undergo surprise
> > removal.  The ones on a Thunderbolt chain too.
> > 
> > > Do we want that?
> > 
> > Do you mean surprise removal?  Yes, we do.
> 
> Always been true - think of cardbus (PCI pcmcia) cards with
> PCI bridges to external PCI expansion chassis containing
> additional PCI slots.
> The cardbus card is hot removable.

Hi,

that is true for those options, but not for the style
of PCI hotplug which requires you to push a button and wait
for the blinking light.

	REgards
		Oliver


