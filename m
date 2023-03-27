Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D946CA7C8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjC0OeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjC0OeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 10:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7A11B;
        Mon, 27 Mar 2023 07:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E443612E6;
        Mon, 27 Mar 2023 14:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99578C433EF;
        Mon, 27 Mar 2023 14:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679927640;
        bh=tVniDDAOenqVrDXFcessUJ0xDBAw+ON6dKY2idpzqT0=;
        h=Date:From:To:Cc:Subject:From;
        b=eMEKXd2LEibmha39DLEmVCWe4W201u3s/G5893MLKOzKvYiAoo2GLdAhoFcXM0fDx
         XO5zz79KulDjibvm4V112I2ZprQC74ciFABr0w1s6WMsQfWuV8N710T9RCGYN1IMT0
         WshartXEha1AV5YzF1Breu9HaPZJpBcLYOk9IRh4UuYA8BGACox8uy729LM6jB9E42
         ybZsntMnIdxZEjmijiHw2/A1OEAAJApR32VUWR0bHVJ/34BdfV6Aky2sji3c47P9IU
         Ns67oZvby+xpJtJxdgZ1A+jPMfYIhLeX7FJPDTj1yQeViZ9vJUouvj/ZBt8bcBOhmE
         Gpenn2aZenpTA==
Date:   Mon, 27 Mar 2023 09:33:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Aleksander Trofimowicz <alex@n90.eu>, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Message-ID: <20230327143359.GA2834753@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Forwarding to NVMe folks, lists for visibility.

----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=217251
...

Created attachment 304031
  --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
the tracing of nvme_pci_enable() during re-insertion

Hi,

There is a JHL7540-based device that may host a NVMe device. After the first
insertion a nvme drive is properly discovered and handled by the relevant
modules. Once disconnected any further attempts are not successful. The device
is visible on a PCI bus, but nvme_pci_enable() ends up calling
pci_disable_device() every time; the runtime PM status of the device is
"suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
device from being power managed ("on" -> /sys/devices/../power/control)
combined with device removal and pci rescan changes nothing. A host reboot
restores the initial state.

I would appreciate any suggestions how to debug it further.
