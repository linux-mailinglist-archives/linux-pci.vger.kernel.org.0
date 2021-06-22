Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A93B00F9
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 12:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFVKMr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 06:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhFVKMr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 06:12:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BEBB613AD;
        Tue, 22 Jun 2021 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624356630;
        bh=CAOIKPZnh5iCql18L6jGOIzrPflujJYEKBZxSHgrNk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOGZS/aomrEr+BkOgOrMBRXxSQk6wH5owK1uuThI61Pp3Rxdq2NRHNqwFSTNSyyg4
         qhZDytzMEbUw3p0yas9r4fEUitGyRKnm2MxT4wX3A8c000fCaM1sARyAzzpNQT8tMJ
         RxHoKJmhoWdNBBV4vabh3CaT0Z8JiTP9dkmOIrcI=
Date:   Tue, 22 Jun 2021 12:10:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] PCI: endpoint: Make struct pci_epf_driver::remove return
 void
Message-ID: <YNG3FKD+OUBbsD7e@kroah.com>
References: <20210223090757.57604-1-u.kleine-koenig@pengutronix.de>
 <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a12ff97-a916-d70e-9e5b-b796e9c58288@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 22, 2021 at 03:29:27PM +0530, Kishon Vijay Abraham I wrote:
> 
> 
> On 23/02/21 2:37 pm, Uwe Kleine-König wrote:
> > The driver core ignores the return value of pci_epf_device_remove()
> > (because there is only little it can do when a device disappears) and
> > there are no pci_epf_drivers with a remove callback.
> > 
> > So make it impossible for future drivers to return an unused error code
> > by changing the remove prototype to return void.
> > 
> > The real motivation for this change is the quest to make struct
> > bus_type::remove return void, too.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Fine with this change!
> 
> FWIW:
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
