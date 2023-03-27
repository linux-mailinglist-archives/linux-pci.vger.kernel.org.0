Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30BD6CAD06
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 20:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjC0Sbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0Sbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 14:31:46 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 11:31:45 PDT
Received: from mx2.n90.eu (mx.n90.eu [65.21.251.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E26271D;
        Mon, 27 Mar 2023 11:31:45 -0700 (PDT)
Received: by mx2.n90.eu (Postfix, from userid 182)
        id 6277A1027DB45; Mon, 27 Mar 2023 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n90.eu; s=default;
        t=1679940370; bh=OGbOFJayhgRcXq5FMeS6bRDyUolQeucd8waNYOur4j4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=nPD85CB4IjQubR+FqhGXUYhBxV7bbwiHtN9kDpUsMfvJ5VKjUsWV88RDwd2C5oy4/
         9tlJmIwPVi3rnu2uF27A0Xua2/i08lUSZ8Yll0MXwtsw+rld4069lz2IM8kPcwxggO
         phjBZkPfcy0QaShZxkSowFm5huqTrA2RmJl4unv3BE9WpLw5cHrd/vU7l+6slZ5l9/
         p7m9eSvV87wcasXYp44lZW2pwDpGg8ecJrJGUayyE9ySjUesRCJHONIfC7Dbqvhl94
         Nfe8MHZJvedo8D6w1a4cBrMOGJeF/f9TiWznHy5d8o12ZS2UBdgtiZxheA/fa2BBpK
         PygFgKG/87wsA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Received: from spica (unknown [172.20.188.202])
        by mx2.n90.eu (Postfix) with ESMTP id CD5411025BB5A;
        Mon, 27 Mar 2023 18:06:07 +0000 (UTC)
References: <20230327143359.GA2834753@bhelgaas>
 <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.8.14; emacs 30.0.50
From:   Aleksander Trofimowicz <alex@n90.eu>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Date:   Mon, 27 Mar 2023 17:43:18 +0000
In-reply-to: <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
X-Mailer: boring 1.0
Message-ID: <871qlank6o.fsf@n90.eu>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Keith Busch <kbusch@kernel.org> writes:

> On Mon, Mar 27, 2023 at 09:33:59AM -0500, Bjorn Helgaas wrote:
>> Forwarding to NVMe folks, lists for visibility.
>>
>> ----- Forwarded message from bugzilla-daemon@kernel.org -----
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=217251
>> ...
>>
>> Created attachment 304031
>>   --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
>> the tracing of nvme_pci_enable() during re-insertion
>>
>> Hi,
>>
>> There is a JHL7540-based device that may host a NVMe device. After the first
>> insertion a nvme drive is properly discovered and handled by the relevant
>> modules. Once disconnected any further attempts are not successful. The device
>> is visible on a PCI bus, but nvme_pci_enable() ends up calling
>> pci_disable_device() every time; the runtime PM status of the device is
>> "suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
>> device from being power managed ("on" -> /sys/devices/../power/control)
>> combined with device removal and pci rescan changes nothing. A host reboot
>> restores the initial state.
>>
>> I would appreciate any suggestions how to debug it further.
>
> Sounds the same as this report:
>
>   http://lists.infradead.org/pipermail/linux-nvme/2023-March/038259.html
>
> The driver is bailing on the device because we can't read it's status register
> out of the remapped BAR. There's nothing we can do about that from the nvme
> driver level. Memory mapped IO has to work in order to proceed.
>
Thanks. I can confirm it is the same problem:

a) the platform is Intel Alderlake
b) readl(dev->bar + NVME_REG_CSTS) in nvme_pci_enable() fails
c) reading BAR0 via setpci gives 0x00000004

--
at
