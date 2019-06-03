Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715DB33B81
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 00:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfFCWke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 18:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfFCWke (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 18:40:34 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DBE26A32;
        Mon,  3 Jun 2019 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559601633;
        bh=4VVHVVBJYOrtfjQmkmfX4km6vna4lr6Ms9TIAd0Y6EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVmbs/zsxjB0l+JVVvUWDeQ857KCgbfN2xMCzG5JWVRitgEAEdAaKwqbzVCPyJTRG
         k/KjK7RbzDxuGCQ3fGSg2oBsyQ8OAmaC29aasEdfWAJrvc8YudmpTNIQ9I0iLFYmaf
         ZnZBErOfUIqgTR/54n8QWeEJV0eUGdRWiuKo8m00=
Date:   Mon, 3 Jun 2019 17:40:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     Andrew Vasquez <andrewv@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Myron Stowe <mstowe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@qlogic.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [EXT] VPD access Blocked by commit
 0d5370d1d85251e5893ab7c90a429464de2e140b
Message-ID: <20190603224029.GC58810@google.com>
References: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com>
 <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
 <CAErSpo45bCV7geSPAwBjy5fdQqzDcX61Ybksk65c=intfTWFZQ@mail.gmail.com>
 <D8764654-E2A0-43B8-97D9-6644F2BC8D0E@marvell.com>
 <20190530205823.GA45696@google.com>
 <DFF05429-6C84-4DBD-B3D0-14A0BD209E38@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFF05429-6C84-4DBD-B3D0-14A0BD209E38@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 03, 2019 at 09:30:50PM +0000, Himanshu Madhani wrote:
> On May 30, 2019, at 1:58 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Thu, May 30, 2019 at 07:33:01PM +0000, Himanshu Madhani wrote:
>>> We are able to successfully read VPD config data using lspci and cat
>>> command

> Missed the request for xxd output. I got access back today for the system 
> and captured it for you
> 
> # cat /sys/class/pci_bus/0000\:13/device/0000\:13\:00.0/vpd  | xxd
> 00000000: 822d 0051 4c6f 6769 6320 3332 4762 2032  .-.QLogic 32Gb 2
> 00000010: 2d70 6f72 7420 4643 2074 6f20 5043 4965  -port FC to PCIe
> 00000020: 2047 656e 3320 7838 2041 6461 7074 6572   Gen3 x8 Adapter
> 00000030: 9039 0050 4e07 514c 4532 3734 3253 4e0d  .9.PN.QLE2742SN.
> 00000040: 4146 4431 3533 3359 3032 3939 3945 430f  AFD1533Y02999EC.
> 00000050: 424b 3332 3130 3430 372d 3035 2030 3356  BK3210407-05 03V
> 00000060: 3906 3031 3031 3839 5256 01a0 78         9.010189RV..x
> 
> PCIe trace also confirmed there are no READ errors. 
> (if you need i can attach .pex file for review)

Thank you!  It would be really excellent to have a report at
https://bugzilla.kernel.org with these details (hex VPD dump, .pex
file, QLogic firmware version info) attached.  Your patch commit log
could then include the bugzilla URL.

If we had this sort of information for Ethan's original patch, we
would have a good start at making a smarter quirk.  But we don't, so I
think all we can assume at this point is that all QLogic firmware
older than your current version is broken and we shouldn't try reading
VPD.

>> If a QLogic firmware update indeed fixed the VPD format, I suggest
>> that you ask the folks responsible for the firmware to identify the
>> specific version where that was fixed and how the OS can figure that
>> out.

> Still waiting on this data. 

Don't hold your breath :)

> Since major OEMs are having issues using adapter to extract VPD data, We 
> would like to get them relief first and then approach this issue with more
> detailed fix if needed. 

I don't think it's a good idea to simply revert 0d5370d1d852.  That
would mean any users that have the same QLogic firmware version Ethan
had would start seeing panics.

But I think you could certainly make a quirk that allows VPD access
for the firmware version you have on your card (or newer), leaving the
original "no VPD at all" behavior for older versions.

Bjorn
