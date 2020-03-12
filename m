Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B001839DA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 20:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCLTxW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 15:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLTxW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 15:53:22 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1412206E9;
        Thu, 12 Mar 2020 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584042801;
        bh=poV+EblAH9g8FbaAVlYH45IwSThQzxJ75LREtJe1pjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QgYiV9kxEXU13feQOJYWn0rdviqTF3XtmqQUQaWrLmRoAah6vHvrIbzY1dRIuOuA3
         tts/m4bSB+SWhvt8pF+CQ/kujJx1Xxs95MnP1XT2vf8aizcqtr94BrmwhgYsRujROB
         OfqJDJH3oaMh/kHPTIX10EYgoQXdHAGAmsQFdfVc=
Date:   Thu, 12 Mar 2020 14:53:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Austin.Bolen@dell.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200312195319.GA162308@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4b4b4b0-3c56-51a0-4237-dd439fca3150@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrote:
> On 3/11/20 3:23 PM, Bjorn Helgaas wrote:
> > Is any synchronization needed here between the EDR path and the
> > hotplug/enumeration path?
>
> If we want to follow the implementation note step by step (in
> sequence) then we need some synchronization between EDR path and
> enumeration path. But if it's OK to achieve the same end result by
> following steps out of sequence then we don't need to create any
> dependency between EDR and enumeration paths. Currently we follow
> the latter approach.

What would the synchronization look like?

Ideally I think it would be better to follow the order in the
flowchart if it's not too onerous.  That will make the code easier to
understand.  The current situation with this dependency on pciehp and
what it will do leaves a lot of things implicit.

What happens if CONFIG_PCIE_EDR=y but CONFIG_HOTPLUG_PCI_PCIE=n?

IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and
unbinds the drivers and removes the devices.  If that doesn't happen,
and Linux clears the DPC trigger to bring the link back up, will those
drivers try to operate uninitialized devices?

Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?

> For example, consider the case in flow chart where after sending
> success _OST, firmware decides to stop the recovery of the device.
> 
> if we follow the flow chart as is then the steps should be,
> 
> 1. clear the DPC status trigger
> 2. Send success code via _OST, and wait for return from _OST
> 3. if successful return then enumerate the child devices and
> reassign bus numbers.
> 
> In current approach the steps followed are,
> 
> 1. Clear the DPC status trigger.
> 2. Send success code via _OST
> 2. In parallel, LINK UP event path will enumerate the child devices.
> 3. if firmware decides not to recover the device, then LINK DOWN
> event will eventually remove them again.
