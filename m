Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986A813BD5A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 11:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgAOK0c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 05:26:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgAOK0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 05:26:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A65EAC52;
        Wed, 15 Jan 2020 10:26:31 +0000 (UTC)
Message-ID: <1579083986.15925.31.camel@suse.com>
Subject: system generating an NMI due to 80696f991424d ("PCI: pciehp:
 Tolerate Presence Detect hardwired to zero")
From:   Oliver Neukum <oneukum@suse.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     David Yang <mmyangfl@gmail.com>, Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org
Date:   Wed, 15 Jan 2020 11:26:26 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I got a bug report about some systems generating an NMI and
subsequently crashing bisected down to 80696f991424d.
Apparently these systems do not react well to __pciehp_enable_slot
while no card is present. Restoring the check to __pciehp_enable_slot()
removed in 80696f991424d makes the current kernels work.

What is to be done? Do you want a special case for the affected
systems based on DMI, or should I revert 80696f991424d?

	Regards
		Oliver

