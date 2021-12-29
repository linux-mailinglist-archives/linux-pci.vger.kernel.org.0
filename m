Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9838C4815EB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhL2RqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 12:46:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58996 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhL2RqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 12:46:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0598B818A5;
        Wed, 29 Dec 2021 17:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C8C36AE1;
        Wed, 29 Dec 2021 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640799966;
        bh=NmRZzJM7Km/x83/A2i7bH4gxbcS51Gr3Mu4O09ilUmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VxZPR6x4B5BGfCvyFp6FfsQghkScX7nlmRkPQukrWbLjhpfHAmlgTRBsfy50ztm3D
         FS5bfriPXeSt+NS3r0EXvWhPBhA/7a7MIUMzn+YYGVUq6CuuSUA7ZOkwi9iBod13jE
         FJ0JS24eDMlhYzeQxT7tPSREyEsbfpu5ZB6+wf6KQPB/20RZROtsB6aW+UqgBRqv9u
         hSbxo0KIfACoRhosssFdhxLLW/edqymvbR4G42i9cw0p7fdWpKmUv3MSmQCWpPRkrS
         IfqbdYTkLUm8SBfjLilqLxQfVxswBaj3ApBIB35ZkNt2SGOTHb/Ah/DhTZoQL64kEp
         r06hzLAk2FQWg==
Date:   Wed, 29 Dec 2021 11:46:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     slark_xiao@163.com
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Bug 215433] New: data connection lost on Qualcomm SDX55 PCIe
 device
Message-ID: <20211229174605.GA1689297@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215433-41252@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc MHI folks]

On Tue, Dec 28, 2021 at 11:26:02AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215433
> 
>            Summary: data connection lost on Qualcomm SDX55 PCIe device
>     Kernel Version: 5.13.0,5.15.0
> ...

> For Qualcomm based modem devices, with PCIE interface, and mhi driver based on
> kernel 5.13.0, it will lose data connection. Details as below:
> 
>     Phenomenon:
>         1) Can NOT connect to Internet
>         2) /dev/wwan0p1QCDM, /dev/wwan0p2MBIM, /dev/wwan0p3AT NOT response
> 
>     Reproduce steps
>         1) Connect Internet via cellular
>         2) Do speedtest(https://www.speedtest.net/) or download a 1GB file
> (ipv4.download.thinkbroadband.com/1GB.zip)
> 
>     Recovery method
>         Only can be recovered by reboot host
> 
>     Others
>         It can NOT be reproduced in Windows 10/11.

Thanks very much for the report.  I'm not familiar with the mhi
driver, so I added some folks who might be.

Can you please collect the complete dmesg log and output of
"sudo lspci -vv" and attach both to the bugzilla?

Does the network connection work for a while, then stop working?  If
so, is there anything logged in the dmesg log when it stops working?

Do you know of any Linux versions that do not have this problem?  If
it used to work but it got broken, that would help narrow things down.

Thanks,
  Bjorn
