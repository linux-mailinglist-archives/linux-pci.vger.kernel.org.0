Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF31E667F
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbgE1PpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 11:45:15 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51223 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404587AbgE1PpN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 11:45:13 -0400
Received: from [192.168.0.7] (ip5f5af798.dynamic.kabel-deutschland.de [95.90.247.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 66828206442FF;
        Thu, 28 May 2020 17:45:11 +0200 (CEST)
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@dell.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: AMD Ryzen: pci 0000:00:00.2: can't derive routing for PCI INT A
Message-ID: <8579bd14-e369-1141-917b-204d20cff528@molgen.mpg.de>
Date:   Thu, 28 May 2020 17:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux folks,


On most (if not all) AMD Ryzen systems, including the Dell OptiPlex 
5055, [1][2], Linux prints the warning below:

     $ dmesg --level=warn
     [    0.871377] pci 0000:00:00.2: can't derive routing for PCI INT A
     [    0.871732] pci 0000:00:00.2: PCI INT A: not connected
     [    0.884890]  PPR NX GT IA GA PC GA_vAPIC
     $ more /proc/version
     Linux version 5.4.39.mx64.334 (root@lol.molgen.mpg.de) (gcc version 
7.5.0 (GCC)) #1 SMP Thu May 7 14:27:50 CEST 2020
     pmenzel@donut:~$ dmesg | grep 'DMI:'
     [    0.000000] DMI: Dell Inc. OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 
1.1.20 05/31/2019

The system seems to work fine. What effect might be caused by the 
missing routing information?

I assume this is a firmware issue? Can I patch the ACPI tables to 
provide the correct information?

Should this indeed be an AMD AGESA issue, it be great, if somebody with 
contacts at AMD could be forward this to the appropriate folks.


Kind regards,

Paul


[1]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1804589
[2]: https://bugs.launchpad.net/dell-sputnik/+bug/1881121
