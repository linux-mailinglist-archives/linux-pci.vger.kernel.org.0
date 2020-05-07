Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A404C1C9571
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEGPvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 11:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEGPve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 11:51:34 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF54A20659;
        Thu,  7 May 2020 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588866694;
        bh=1Q9VbK+JcufVG88INJmlPCjfx0C7wnoXRYXdD54VdV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O+QfpX/C/690T6tqapb1Dd6Z+sXEs6NySD2jiIFxIhM8Z49iD9rw38Bq/MHy20Hei
         Zi3pj6HAmRMao3K0gj1TyLUXXkd7Io3IbAOJDl52KIsXbq5EH9DOMpbDSLtPY5CNwq
         EZYjY5AUJ1K/7Mmfxx7Kq3iTaaq76DdczroJyJBI=
Date:   Thu, 7 May 2020 10:51:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [RFC 1/2] PCI/IOV: Introduce pci_iov_sysfs_link() function
Message-ID: <20200507155132.GA6568@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e62d9d62-528f-ac1a-671f-4da2d2e88641@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 09:48:30AM +0200, Niklas Schnelle wrote:
> On 5/6/20 11:10 PM, Bjorn Helgaas wrote:
> > On Wed, May 06, 2020 at 05:41:38PM +0200, Niklas Schnelle wrote:
> >> currently pci_iov_add_virtfn() scans the SR-IOV bars, adds the VF to the
> >> bus and also creates the sysfs links between the newly added VF and its
> >> parent PF.
> > 
> > s/currently/Currently/
> > s/bars/BARs/
> > 
> >> With pdev->no_vf_scan fencing off the entire pci_iov_add_virtfn() call
> >> s390 as the sole pdev->no_vf_scan user thus ends up missing these sysfs
> >> links which are required for example by QEMU/libvirt.
> >> Instead of duplicating the code introduce a new pci_iov_sysfs_link()
> >> function for establishing sysfs links.
> > 
> > This looks like two paragraphs missing the blank line between.
> > 
> > This whole thing is not "introducing" any new functionality; it's
> > "refactoring" to move existing functionality around and make it
> > callable separately.
> You're right I'll keep it in the subject for easier reference
> if that's okay with you.
> > 
> >> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > 
> > With the fixes above and a few below:
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thank you for the very quick and useful feedback.
> I've incorporated the changes and will resend with the PATCH prefix.
> If/when accepted what tree should the first patch go to?

I'd expect them both to go via the s390 tree so there's no dependency
between the PCI merge and the s390 merge.

> And yes I plan to let the second patch go via the s390 tree.
