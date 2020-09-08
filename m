Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E571126078C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 02:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgIHA3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 20:29:38 -0400
Received: from magic.merlins.org ([209.81.13.136]:35902 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgIHA3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 20:29:38 -0400
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:47940 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1kFRVv-0003xd-Hx by authid <merlins.org> with srv_auth_plain; Mon, 07 Sep 2020 17:29:35 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1kFRVv-0001f8-9O; Mon, 07 Sep 2020 17:29:35 -0700
Date:   Mon, 7 Sep 2020 17:29:35 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [Nouveau] pcieport 0000:00:01.0: PME: Spurious native interrupt
 (nvidia with nouveau and thunderbolt on thinkpad P73)
Message-ID: <20200908002935.GD20064@merlins.org>
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <20191004123947.11087-2-mika.westerberg@linux.intel.com>
 <20200808202202.GA12007@merlins.org>
 <20200906181852.GC13955@merlins.org>
 <CACO55tsodfUGVUjFw9=smFOhp_oXP8zWY_9+vL+iiPZhKJdtyg@mail.gmail.com>
 <20200907205825.GB20064@merlins.org>
 <CACO55ttBXKWTbxERK-aHsYQe_4=eK_WVc2+ebmCbCJJcQpFZrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55ttBXKWTbxERK-aHsYQe_4=eK_WVc2+ebmCbCJJcQpFZrQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 08, 2020 at 01:51:19AM +0200, Karol Herbst wrote:
> oh, I somehow missed that "disp ctor failed" message. I think that
> might explain why things are a bit hanging. From the top of my head I
> am not sure if that's something known or something new. But just in
> case I CCed Lyude and Ben. And I think booting with
> nouveau.debug=disp=trace could already show something relevant.

Thanks.
I've added that to my boot for next time I reboot.

I'm moving some folks to Bcc now, and let's remove the lists other than
nouveau on followups (lkml and pci). I'm just putting a warning here
so that it shows up in other list archives and anyone finding this
later knows that they should look in the nouveau archives for further
updates/resolution.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
