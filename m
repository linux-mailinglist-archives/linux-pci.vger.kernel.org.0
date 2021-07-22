Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9D43D2C49
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 21:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhGVSYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 14:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229510AbhGVSYI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 14:24:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11E3860EB9;
        Thu, 22 Jul 2021 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626980683;
        bh=ny4Kw/Y6hr1TRBVhzY6yoiWRu0uFNybOiCdYC5QXMwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=grxB1XCJkaUM4lJRjCN8G6Fk31ckCKf6nwhfAx7RCYasTBa/NrpWkrM03BVv4fHnZ
         hbvjxIog+4Nj+316QMwXIhqF9TOSd+rs6tvbjew6MYOuhaf9/rrbzxNPISG/6/LYwj
         1rNj7355h7JFoYVrd9xPt/AxNTfA2f6BgflhFAfeY2eXQzGhq1kxE+PLmx8IoZAvNB
         HgpUvvVkVHmxn6EMtiFKTJTqmf7nd02rhfXCkkpFQy3kei0oEG8azZpzED83ywBqFd
         DAgmSpss77QwdlU3XsOHA/A3a92+NcQcGR4UuVOY9nAM1Fpy4cSpGrsHo3E1QPxDB2
         BZKbs+5YizlcQ==
Date:   Thu, 22 Jul 2021 14:04:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: vmd: Issue vmd domain window reset
Message-ID: <20210722190441.GA327885@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f1b33c-ba82-a0df-cb66-01df04be52cb@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 11:47:06AM -0700, Patel, Nirmal wrote:
> On 7/20/2021 3:42 PM, Bjorn Helgaas wrote:
> > On Tue, Jul 20, 2021 at 01:50:09PM -0700, Nirmal Patel wrote:
> >> In order to properly re-initialize the VMD domain during repetitive driver
> >> attachment or reboot tests, ensure that the VMD root ports are re-initialized
> >> to a blank state that can be re-enumerated appropriately by the PCI core.
> >> This is performed by re-initializing all of the bridge windows to ensure
> >> that PCI core enumeration does not detect potentially invalid bridge windows
> >> and misinterpret them as firmware-assigned windows, when they simply may be
> >> invalid bridge window information from a previous boot.

> >> +static void vmd_domain_reset_windows(struct vmd_dev *vmd)
> >> +{
> >> +	u8 hdr_type;
> >> +	char __iomem *addr;
> >> +	int dev_seq;
> >> +	u8 functions;
> >> +	u8 fn_seq;
> >> +	int max_devs = resource_size(&vmd->resources[0]) * 32;
> >> +
> >> +	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
> >> +		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_VENDOR_ID;
> >> +		if (readw(addr) != PCI_VENDOR_ID_INTEL)
> >> +			continue;
> >> +
> >> +		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_HEADER_TYPE;
> >> +		hdr_type = readb(addr) & PCI_HEADER_TYPE_MASK;
> >> +		if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
> >> +			continue;
> >> +
> >> +		functions = !!(hdr_type & 0x80) ? 8 : 1;
> >> +		for (fn_seq = 0; fn_seq < functions; fn_seq++)
> >> +		{
> >
> > Looks quite parallel to vmd_domain_sbr(), except that here we iterate
> > through functions as well.  Why does vmd_domain_sbr() not need to
> > iterate through functions?
>
> I am not sure if there is VMD hardware with non zero functions.

I'm not sure either ;)  Hopefully you can resolve this one way or the
other.  It would be good to either make them the same or add a comment
about why they are different.  Otherwise it just looks like a possible
bug.
