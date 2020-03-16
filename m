Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B059187554
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 23:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgCPWGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 18:06:01 -0400
Received: from newsaf.bio.caltech.edu ([131.215.12.41]:36988 "EHLO
        saf.bio.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732716AbgCPWGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 18:06:01 -0400
Received: from apache by saf.bio.caltech.edu with local (Exim 4.92.3)
        (envelope-from <apache@saf.bio.caltech.edu>)
        id 1jDxs0-0005hy-Nh; Mon, 16 Mar 2020 15:06:00 -0700
To:     linux-pci@vger.kernel.org
Subject: Re: lspci shpchp and /sys vs /lib/modules questions
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 15:06:00 -0700
From:   David Mathog <mathog@caltech.edu>
Cc:     mj@ucw.cz
Reply-To: mathog@caltech.edu
Mail-Reply-To: mathog@caltech.edu
In-Reply-To: <50c91fec35004aa29a7553f255214531@saf.bio.caltech.edu>
References: <a3d09c2b013e08d7d0eaa3799a00593f@saf.bio.caltech.edu>
 <50c91fec35004aa29a7553f255214531@saf.bio.caltech.edu>
Message-ID: <4298133c8a3dbc89ac12854dbf786816@saf.bio.caltech.edu>
X-Sender: mathog@caltech.edu
User-Agent: Roundcube Webmail/1.1.12
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-03-16 14:11, David Mathog wrote:
> Things I do not understand:
> 

4. lspci -k:
00:0a.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
         Kernel driver in use: pcieport
         Kernel modules: shpchp

but...

grep -i pcieport /lib/modules/*/modules.builtin
#nothing
grep -i pcieport /lib/modules/*/modules.alias
#nothing

Yet there are reciprocal links here:

ls -al /sys/bus/pci/drivers/pcieport/0000:00:0a.0
lrwxrwxrwx 1 root root 0 Mar 16 14:25 
/sys/bus/pci/drivers/pcieport/0000:00:0a.0 -> 
../../../../devices/pci0000:00/0000:00:0a.0
  ls -al /sys/devices/pci0000:00/0000:00:0a.0/driver
lrwxrwxrwx 1 root root 0 Mar 16 15:03 
/sys/devices/pci0000:00/0000:00:0a.0/driver -> 
../../../bus/pci/drivers/pcieport

Not builtin, not a module, yet still a driver!  Where did it come from?

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
