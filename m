Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E011A4876AC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 12:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiAGLnj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 06:43:39 -0500
Received: from foss.arm.com ([217.140.110.172]:39870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237668AbiAGLnj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 06:43:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E5DD13D5;
        Fri,  7 Jan 2022 03:43:39 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38413F66F;
        Fri,  7 Jan 2022 03:43:37 -0800 (PST)
Date:   Fri, 7 Jan 2022 11:43:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        Roman Bacik <roman.bacik@broadcom.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc: Set all 24 bits of PCI class code
Message-ID: <20220107114332.GA22419@lpieralisi>
References: <20220105181306.mkratasqg36tjf4e@pali>
 <20220106180026.GA295674@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220106180026.GA295674@bhelgaas>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 06, 2022 at 12:00:26PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 05, 2022 at 07:13:06PM +0100, Pali Rohár wrote:
> > On Wednesday 05 January 2022 09:51:48 Ray Jui wrote:
> > > On 1/5/2022 1:35 AM, Pali Rohár wrote:
> 
> > > 2. I suppose 'PCI_CLASS_BRIDGE_PCI_NORMAL' is defined in some common PCI
> > > header in a separate patch as described in the commit message. Then how
> > > come these patches are not constructed with a patch series?
> > 
> > Yes, PCI_CLASS_BRIDGE_PCI_NORMAL is a new constant for common pci header
> > file defined in patch linked in commit message.
> > https://lore.kernel.org/linux-pci/20211220145140.31898-1-pali@kernel.org/
> > 
> > Originally I included this change in v1 of linked patch in December but
> > I realized that it does not match standard PCI config space (different
> > offset 0x43c vs 0x08 and also different shift 0x8 vs 0x0) and probably
> > there is something either incorrect or really non-standard. So later in
> > December I dropped iproc_pcie_check_link() change in v2 of the linked
> > patch where is introduced PCI_CLASS_BRIDGE_PCI_NORMAL and now sent new
> > change for iproc_pcie_check_link() separately.
> > 
> > Technically, linked patch in commit message is just extracting code into
> > the common macros without any functional changed. But change in this
> > iproc_pcie_check_link() has also functional change as now also lower 8
> > bits of class code are changed. So in my opinion this patch should be
> > really separate of linked patch.
> > 
> > I hope that Lorenzo and Bjorn take patches in correct order...
> 
> If patches are not sent together in a series, you can't assume
> anything about the order they'll be applied in.  Adding a note about
> "this patch depends patch X" helps a little but adds a fair amount of
> friction to the process.

Indeed, more so given that the dependency requires an ACK from other
maintainers - I certainly can't pull this patch as-is.

Lorenzo
