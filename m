Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E052F34E851
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhC3NEJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 09:04:09 -0400
Received: from angie.orcam.me.uk ([157.25.102.26]:38172 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhC3NED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 09:04:03 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 619B692009C; Tue, 30 Mar 2021 15:04:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5EC2092009B;
        Tue, 30 Mar 2021 15:04:02 +0200 (CEST)
Date:   Tue, 30 Mar 2021 15:04:02 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Amey Narkhede' <ameynarkhede03@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kabel@kernel.org" <kabel@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "raphael.norwitz@nutanix.com" <raphael.norwitz@nutanix.com>
Subject: RE: How long should be PCIe card in Warm Reset state?
In-Reply-To: <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2103301428030.18977@angie.orcam.me.uk>
References: <20210310110535.zh4pnn4vpmvzwl5q@pali> <20210323161941.gim6msj3ruu3flnf@archlinux> <20210323162747.tscfovntsy7uk5bk@pali> <20210323165749.retjprjgdj7seoan@archlinux> <a8e256ece0334734b1ef568820b95a15@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Mar 2021, David Laight wrote:

> I can't see the value in the (nice bound) copy of the PCI 2.0 spec I have.
> But IIRC it is 100ms (it might just me 500ms).
> While this might seem like ages it can be problematic if targets have
> to load large FPGA images from serial EEPROMs.

 AFAICT it is 100ms for the Conventional Reset before Configuration 
Requests are allowed to be issued in the first place, and then they are 
allowed to fail with the Configuration Request Retry Status (CRS) status 
until the device is ready to respond.  Then it is 1.0s before the Root 
Complex and/or system software is allowed to consider a device broken that 
does not return a Successful Completion status for a valid Configuration 
Request.

 This 1.0s period is analogous to the Trhfa parameter for PCI/PCI-X buses 
(2^25/2^27 bus clocks respectively; I don't know why the PCIe spec quotes 
the latter value as 2^26, contrary to what the original PCI-X spec says, 
but obviously the latter document is what sets the norm), which also has 
to be respected for the respective bus segments in the presence of PCIe to 
PCI/PCI-X bridges.

 For Function-level reset the timeout is 100ms.

 This is specified in sections 6.6.1. "Conventional Reset" and 6.6.2. 
"Function-Level Reset (FLR)" respectively in the copy of PCIe 2.0 base 
spec I have access to; I imagine other versions may have different section 
numbers, but will have them named similarly.

 If I were to implement this stuff, for good measure I'd give it a safety 
margin beyond what the spec requires and use a timeout of say 2-4s while 
actively querying the status of the device.  The values given in the spec 
are only the minimum requirements.

 HTH,

  Maciej
