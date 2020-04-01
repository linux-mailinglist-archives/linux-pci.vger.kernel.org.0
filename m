Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32EE19B8F7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgDAXb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 19:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732503AbgDAXb0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 19:31:26 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18DF4206E9;
        Wed,  1 Apr 2020 23:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585783885;
        bh=KYj6hRtpI6880fQIULrZOKPp07eQ3jK8DAojgtd4OA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rstk2pkoUs8APTsz4dcznapg3hMsWKSDzIcor5TlwEo4iJ8KOsCnXngDVbszkM/SR
         lxI1MobUarNMi+Cy+V2vCRY8+rur8hprXMV9nycL6wCqnVKdLemauKtuLRhb6GtW9/
         IHeWLDaKcpMJArcgjnh4htmnnXQQ6Vei4kq854tg=
Date:   Wed, 1 Apr 2020 18:31:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200401233121.GA152016@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1pZufvY9VcXnjrrDMmiMoURtTaL1+8jGWL7k+yyGhKyDw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 01, 2020 at 10:20:42PM +0100, Luís Mendes wrote:
> Hi Bjorn,
> 
> Here is the dmesg output with the new kernel patch:
> https://paste.ubuntu.com/p/7cv7ZcyrnG/

Thanks.  What happens if you do this:

  # echo 1 > sys/devices/pci0000:00/0000:00:01.0/pci_bus/0000:01/rescan

(I think on v5.6 that file is "bus_rescan" instead of "rescan".
There's a patch queued up to change it.)
