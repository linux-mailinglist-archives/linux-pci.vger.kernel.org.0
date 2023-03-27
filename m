Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FFF6CAA67
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjC0QTk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjC0QTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:19:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E61998;
        Mon, 27 Mar 2023 09:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A86BDB816D8;
        Mon, 27 Mar 2023 16:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86974C433D2;
        Mon, 27 Mar 2023 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679933933;
        bh=vdqssHVignhvMODkXP8HH8VTKfr6z1MWWUoqltaO3Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYTRjGZEBBXiXXfAOaZVoPNuFrTNI1Ijd/sAlIcF0ivsxiXPYqC8Jqu9JRZcqbQa/
         8q1zUqogO4GXn5J+uYpXrtpARDsQttsg51Cyq2Am/ED+aZ2jFM95U9BAf7S2/PSd5W
         FWv4JatvJakyZR+8hMV1gyOR9AKV6Y6gPF28KdbkekCmGiJlWJh4on8P+vBRloSmYq
         MYQi7nRznGylJpSv2Lx3aB20I5xsrsErN8MlfzXjho3c23+Y6cbXtLtRzSiTCeQzUD
         zB3BXHVE95K91O+jTp+bzBlp7JtbH19z/kNCW9FQooQ5banU8BuoUYEsvpgNpaFXQX
         MEGWQsr3lD62Q==
Date:   Mon, 27 Mar 2023 10:18:50 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lukas Wunner <lukas@wunner.de>,
        Aleksander Trofimowicz <alex@n90.eu>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 217251] New: pciehp: nvme not
 visible after re-insert to tbt port]
Message-ID: <ZCHB6hXbCOxiZw+n@kbusch-mbp.dhcp.thefacebook.com>
References: <20230327143359.GA2834753@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327143359.GA2834753@bhelgaas>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 27, 2023 at 09:33:59AM -0500, Bjorn Helgaas wrote:
> Forwarding to NVMe folks, lists for visibility.
> 
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=217251
> ...
> 
> Created attachment 304031
>   --> https://bugzilla.kernel.org/attachment.cgi?id=304031&action=edit
> the tracing of nvme_pci_enable() during re-insertion
> 
> Hi,
> 
> There is a JHL7540-based device that may host a NVMe device. After the first
> insertion a nvme drive is properly discovered and handled by the relevant
> modules. Once disconnected any further attempts are not successful. The device
> is visible on a PCI bus, but nvme_pci_enable() ends up calling
> pci_disable_device() every time; the runtime PM status of the device is
> "suspended", the power status of the 04:01.0 PCI bridge is D3. Preventing the
> device from being power managed ("on" -> /sys/devices/../power/control)
> combined with device removal and pci rescan changes nothing. A host reboot
> restores the initial state.
> 
> I would appreciate any suggestions how to debug it further.

Sounds the same as this report:

  http://lists.infradead.org/pipermail/linux-nvme/2023-March/038259.html

The driver is bailing on the device because we can't read it's status register
out of the remapped BAR. There's nothing we can do about that from the nvme
driver level. Memory mapped IO has to work in order to proceed.
