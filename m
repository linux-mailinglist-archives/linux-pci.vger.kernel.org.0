Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0331446934
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 20:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhKETmX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 15:42:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54907 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229918AbhKETmX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Nov 2021 15:42:23 -0400
Received: (qmail 1602171 invoked by uid 1000); 5 Nov 2021 15:39:42 -0400
Date:   Fri, 5 Nov 2021 15:39:42 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     sean.v.kelley@linux.intel.com, bugzilla-daemon@bugzilla.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [Bug 214789] ehci-hcd.c ISR
Message-ID: <20211105193942.GA1601081@rowland.harvard.edu>
References: <bug-214789-208809@https.bugzilla.kernel.org/>
 <bug-214789-208809-L7vPEsR09B@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-214789-208809-L7vPEsR09B@https.bugzilla.kernel.org/>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 05, 2021 at 05:10:05PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=214789
> 
> --- Comment #22 from Scott Arnold (scott.c.arnold@nasa.gov) ---
> Hello,
> This caused problem:
> https://patchwork.kernel.org/project/linux-pci/patch/20200214213313.66622-2-sean.v.kelley@linux.intel.com/
> Scott

This is commit b88bf6c3b6ff ("PCI: Add boot interrupt quirk mechanism 
for Xeon chipsets").

Sean and linux-pci readers, please take a look at this bug report 
(Bugzilla #214789).

Alan Stern
