Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD34C2F5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfFSV2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbfFSV2E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:28:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5E8208CB;
        Wed, 19 Jun 2019 21:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560979683;
        bh=EnbOo+7niy7TMd/jdqZILS6Oxp2WMWijP/ujZlHuINw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D07847EoP6LEXPZjNDzK3KkHJJH7Hsd5X3KS9mZMrOUKDBSdSB6QMbwRmFvHx3+2B
         O9UjBLVytHesxlPYKV4XjrxGISlMBEFCRjXaPk+KpsThhEYOaRREcR0PjHnaoU6rFd
         D+kdd6totGApNkgiMx82BO6U7qC0CDNPB2mnMIds=
Date:   Wed, 19 Jun 2019 16:28:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190619212801.GC143205@google.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618161858.77834-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 07:18:56PM +0300, Mika Westerberg wrote:
> Intel Ice Lake has an integrated Thunderbolt controller which means that
> the PCIe topology is extended directly from the two root ports (RP0 and
> RP1).

A PCIe topology is always extended directly from root ports,
regardless of whether a Thunderbolt controller is integrated, so I
guess I'm missing the point you're making.  It doesn't sound like this
is anything specific to Thunderbolt?

> Power management is handled by ACPI power resources that are
> shared between the root ports, Thunderbolt controller (NHI) and xHCI
> controller.
> 
> The topology with the power resources (marked with []) looks like:
> 
>   Host bridge
>     |
>     +- RP0 ---\
>     +- RP1 ---|--+--> [TBT]
>     +- NHI --/   |
>     |            |
>     |            v
>     +- xHCI --> [D3C]
> 
> Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
> returns either TBT or D3C or both.
> 
> Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> since the TBT power resource is still on when the root ports are runtime
> suspended their dev->current_state is set to D3hot. When NHI is runtime
> suspended TBT is finally turned off but state of the root ports remain
> to be D3hot.
> 
> If the user now runs lspci for instance, the result is all 1's like in
> the below output (07.0 is the first root port, RP0):
> 
> 00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
>     !!! Unknown header type 7f
>     Kernel driver in use: pcieport
> 
> I short the hardware state is not in sync with the software state
> anymore. The exact same thing happens with the PME polling thread which
> ends up bringing the root ports back into D0 after they are runtime
> suspended.

s/I /In /
