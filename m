Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723811AFB79
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 16:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDSOng (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 10:43:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60607 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726319AbgDSOnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 10:43:35 -0400
Received: (qmail 31957 invoked by uid 500); 19 Apr 2020 10:43:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2020 10:43:34 -0400
Date:   Sun, 19 Apr 2020 10:43:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
In-Reply-To: <5673945.BT02kTCndr@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004191040400.29527-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:

> Hi,
> 
> This is an update including some fixes and extra patches based on the
> continuation of the discussion [1].

The new code in pm.h and main.c all looks good.  Please add my
Acked-by: or Suggested-by: to the portions of the patches that affect
those files.

It's nice to see that, aside from the documentation, the patches ended
up removing more lines than they added.

Alan Stern

