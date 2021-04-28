Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECD36D2A6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhD1G5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 02:57:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1G5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 02:57:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619593019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Tsc59MqetNg6ashY2X2omdPgZEqSVZURb8MsEroGqQ=;
        b=ftjvMGNejqEHuMTmVZMGZhaGOvvbuv9KDapKN0EEL32JIcbP0tREQkmv6yhKetZdVQS5em
        /istegquIOtIWaa/P0/6PKQWR7iwnaxApC1VxBE49eOgdKCw5aWG3NL2Sc/I9gJ0g9bz9R
        PHOIsT3Fj8DezC2f/pHWpgbUwnarNKE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A7F1AF38;
        Wed, 28 Apr 2021 06:56:59 +0000 (UTC)
Message-ID: <0601e45130495b152bec04eee4a50e302db4cfd2.camel@suse.com>
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
Date:   Wed, 28 Apr 2021 08:56:52 +0200
In-Reply-To: <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com>
References: <20210424021631.1972022-1-rajatja@google.com>
         <20210424021631.1972022-2-rajatja@google.com>
         <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com>
         <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
         <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
         <21c6b5002c5ad36cd7fe0bb849f5eba12a614bca.camel@suse.com>
         <b5e031652f144ab6accbe553566676c9@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 27.04.2021, 12:59 +0000 schrieb David Laight:
> From: Oliver Neukum
> > Sent: 27 April 2021 13:00

> > that is true for those options, but not for the style
> > of PCI hotplug which requires you to push a button and wait
> > for the blinking light.
> 
> True, I remember some of those PCI hotplug chassis from 25 years ago.
> ISTR we did get the removal events working (SVR4/Unixware) but I
> don't remember the relevant chassis ever being sold.
> In spite of the marketing hype I suspect it was only ever possible
> to remove a completely working board and replace it with an
> exactly equivalent one.
> 
> In any case those chassis are not 'surprise removal'.
> 
> More modern drivers are less likely to crash (and burn?) when
> a PCI read returns ~0u.
> But I suspect an awful lot really don't handle surprise removal
> very well at all.

So you are saying that these systems are so rare that it should be
handled  as special cases if at all?

	Regards
		Oliver


