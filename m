Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03B03770BC
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 10:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEHItd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 May 2021 04:49:33 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:56211 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHItc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 May 2021 04:49:32 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 35E0C2800B3D2;
        Sat,  8 May 2021 10:48:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 29AC0DCBB; Sat,  8 May 2021 10:48:30 +0200 (CEST)
Date:   Sat, 8 May 2021 10:48:30 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Noever <andreas.noever@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI: don't power-off apple thunderbolt controller on
 s2idle
Message-ID: <20210508084830.GB18309@wunner.de>
References: <20210506173820.21876-1-Hi-Angel@yandex.ru>
 <20210506214842.GA1436993@bjorn-Precision-5520>
 <20210506220738.GA2150@wunner.de>
 <CAJZ5v0hFEX3doAPbDDix3oGpfCbSkWLgjPzNdvNLXyNRN+uqzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hFEX3doAPbDDix3oGpfCbSkWLgjPzNdvNLXyNRN+uqzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 07, 2021 at 11:51:20AM +0200, Rafael J. Wysocki wrote:
> On Fri, May 7, 2021 at 12:07 AM Lukas Wunner <lukas@wunner.de> wrote:
> > With s2idle, the machine isn't suspended via ACPI, so the AML code
> > which powers the controller off isn't executed.  The dance to prepare
> > the controller for power-off consequently isn't necessary but rather
> > harmful.
> >
> > To get the same power savings as with ACPI suspend, the controller
> > needs to be powered off via runtime suspend.
> 
> I'm not quite sure why runtime PM needs to be involved.
> 
> The controller suspend can happen in the system-wide suspend code path
> directly.

Sorry, my comments were unclear.  What I meant to say is that the
Thunderbolt runtime PM patches allow us to power the Thunderbolt
controller up or down from the OS and we can re-use that code in
the system-wide suspend code path if s2idle is used.

Without s2idle, power to the controller is cut by transitioning
to ACPI S3 or S4, which disables the controller's power rails
without OS involvement.

Thanks,

Lukas
