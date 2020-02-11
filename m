Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0A159053
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgBKNup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 08:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgBKNup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 08:50:45 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D6B620714;
        Tue, 11 Feb 2020 13:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581429044;
        bh=gfQvm1MNbLiBMFu7rg4io2TIXygEky3FEFr8g+hfcnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A4oGJfUD/lQCB+uophX4wCYu2VlxCVJsQ4gelFXa2bh+wg870kCrCpgSOMCYJtHIM
         PLFyFZl3GVIIuSxTmD3ICo7eLI+695O/9IE3U/8fuL4B4ZhbVt7dY5EoMdcN8MhCPM
         VmoNt9A0B070Y3DMr06v2yxc20mQWKmNND5PmUnY=
Date:   Tue, 11 Feb 2020 07:50:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: Re: [RFC][pci/pm] pci config space save restore issues during
 suspend/resume
Message-ID: <20200211135043.GA202987@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADjb_WR1tBHAuP9wZFnx1bJu3ZKAK8BDPMzDwc1-8nX_WVHLvA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 01:57:06PM +0800, Chen Yu wrote:
> Hi,
> We found two issues in the code during suspend:
> 
> 1. Andy Shevchenko found that, the save restore of pci config space
>     might cause potential issue. Current code uses
>     pci_read_config_dword() to read pci config header. However
>     hardware is not obliged to react correctly when trying to read
>     two/three 'adjacent' pci config registers with one dword read.
> 
>     Q1: Should we save/restore the pci config space header according
>     to the PCI spec strictly(pci_read_config_dword() for 32bit,
>     while pci_read_config_word() for 16bits, etc)?

I'm sure you know my first question will be for a spec reference for
this requirement that we read registers with the correct size :)  If
there is such a requirement, then of course we should follow it.

> 2. The pci config space of some problematic devices(or due to firmware
>     bug) might become inaccessible after resumed from S3(suspend to
>     mem) on VM.
> 
>     Q2: Should we do sanity check on pci config space before saving
>     them?  Say, invoke pci_dev_is_present() before suspend, if the
>     pci config space is not sane, bypass the config space saving
>     process, because there's no need to save invalid pci config
>     space.

I'm not in favor of a sanity check, at least not yet.  This sounds
like a problem that has not been debugged yet.  If the device is
broken in some way, maybe a quirk would be appropriate.  Otherwise,
maybe there's some Linux issue in the resume from S3 path that we
should fix.

Bjorn
