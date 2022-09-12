Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51CA5B5B45
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 15:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiILNgP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiILNgO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 09:36:14 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393E1A3AB;
        Mon, 12 Sep 2022 06:36:12 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C391561EA1934;
        Mon, 12 Sep 2022 15:36:09 +0200 (CEST)
Message-ID: <ae28dabe-d339-b56d-4a8e-ce4291c9b836@molgen.mpg.de>
Date:   Mon, 12 Sep 2022 15:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Dell XPS 13 9360/Dell DA300: USB Type-C: PCIe Bus Error:
 severity=Corrected, type=Data Link Layer, (Receiver ID)
Cc:     linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux folks,


On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, connect a Dell 
DA300 to the only USB Type-C port on the left side (with a network cable 
connect), Linux logs the warnings below:

```
$ cat /proc/version
Linux version 5.19.0-1-amd64 (debian-kernel@lists.debian.org) (gcc-11 
(Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian) 
2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.19.6-1 (2022-09-01)
$ sudo dmesg --level=warn
[…]
[    5.710957] pci 0000:01:00.0: PCIe Bus Error: severity=Corrected, 
type=Data Link Layer, (Receiver ID)
[    5.710959] pci 0000:01:00.0:   device [8086:1576] error 
status/mask=00000080/00002000
[    5.710962] pci 0000:01:00.0:    [ 7] BadDLLP
[    5.715022] hpet_acpi_add: no address or irqs in _CRS
[…]
[   18.895120] ucsi_acpi USBC000:00: UCSI_GET_PDOS returned 0 bytes
[   19.503002] pcieport 0000:01:00.0: PCIe Bus Error: 
severity=Corrected, type=Data Link Layer, (Receiver ID)
[   19.503010] pcieport 0000:01:00.0:   device [8086:1576] error 
status/mask=00000080/00002000
[   19.503020] pcieport 0000:01:00.0:    [ 7] BadDLLP
[…]
```

Is that a hardware problem, or something the Linux kernel can address?

I created the bug report #216474 [1] with the output of `lspci -nn`, 
`lsusb` and `dmesg`.


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=216474
      "Bug 216474 - Dell XPS 13 9360/Dell DA300: USB Type-C: PCIe Bus 
Error: severity=Corrected, type=Data Link Layer, (Receiver ID)"
