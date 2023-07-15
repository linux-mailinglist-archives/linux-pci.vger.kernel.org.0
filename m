Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF4754BA9
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 21:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGOTMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jul 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOTMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Jul 2023 15:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F9B3;
        Sat, 15 Jul 2023 12:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A09360BDC;
        Sat, 15 Jul 2023 19:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC2C433C7;
        Sat, 15 Jul 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689448338;
        bh=fvmfkQe7xASbExr7Qwq+ClgfzOJeaaWctwssh0Qdv+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=im7jN0iZ/HRLgRjG+EeJrLdmJvNlRgFDMRvOqZAU0ZPt6OOkF4uZb4DgQCQMr89Ia
         jB06hdxpZ3qR7hA/h/jw/LqAkB2TEeV5+NqmOWRW0VCJjLwMR7rwuojB2+uyFR3Siz
         3AnYrkBRpLPrKH981T/0y/gxKbPsAvmZSfhZXKJ+RKH0PDlrEMCcyH/1UTAr0/0vAI
         MmTaLHSf5XA6AJXtbqZkuSMjdASy9zOAQWMSiL1hXI3fwjpRzkwF83UOmII4+E/Ud+
         OHzMYrrwIrXfyeYD6XqUw1pwrVroR5yLqRuhFuIljO3Znbq3QW8zFExDvZU05YwBKA
         AWNtBdeJlqA7w==
Date:   Sat, 15 Jul 2023 14:12:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>, linux-pci@vger.kernel.org,
        jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        anthony.l.nguyen@intel.com, linux-hardening@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH v2] igc: Ignore AER reset when device
 is suspended
Message-ID: <20230715191216.GA364070@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jm6nsd0.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 01:35:55PM -0700, Vinicius Costa Gomes wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Fri, Jul 14, 2023 at 01:05:41PM +0800, Kai-Heng Feng wrote:
> >> When a system that connects to a Thunderbolt dock equipped with I225,
> >> like HP Thunderbolt Dock G4, I225 stops working after S3 resume:
> >> ...
> >
> >> The issue is that the PTM requests are sending before driver resumes the
> >> device. Since the issue can also be observed on Windows, it's quite
> >> likely a firmware/hardware limitation.
> >
> > Does this mean we didn't disable PTM correctly on suspend?  Or is the
> > device defective and sending PTM requests even though PTM is disabled?
> 
> The way I understand the hardware bug, the device is defective, as you
> said, the device sends PTM messages when "busmastering" is disabled.

Bus Master Enable controls the ability of a Function to issue Memory
and I/O Read/Write Requests (PCIe r6.0, sec 7.5.1.1.3).  PTM uses
Messages, and I don't think they should be affected by Bus Master
Enable.

I also don't understand the I225 connection.  We have these
Uncorrected Non-Fatal errors:

> >> [  606.527931] pcieport 0000:00:1d.0: AER: Multiple Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> >> [  606.528064] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> >> [  606.528068] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> >> [  606.528072] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> >> [  606.528075] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 0a000052 00000000 00000000
> >> [  606.528079] pcieport 0000:00:1d.0: AER:   Error of this Agent is reported first
> >> [  606.528098] pcieport 0000:04:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> >> [  606.528101] pcieport 0000:04:01.0:   device [8086:1136] error status/mask=00300000/00000000
> >> [  606.528105] pcieport 0000:04:01.0:    [20] UnsupReq               (First)
> >> [  606.528107] pcieport 0000:04:01.0:    [21] ACSViol
> >> [  606.528110] pcieport 0000:04:01.0: AER:   TLP Header: 34000000 04000052 00000000 00000000

They are clearly Unsupported Request errors caused by PTM Requests
(decoding at https://bugzilla.kernel.org/show_bug.cgi?id=216850#c9),
but they were logged by 00:1d.0 and 04:01.0.

The hierarchy is this:

  00:1d.0 Root Port to [bus 03-6c]
  03:00.0 Switch Upstream Port to [bus 04-6c]
  04:01.0 Switch Downstream Port to [bus 06-38]
  06:00.0 Switch Upstream Port to [bus 07-38]
  07:04.0 Switch Downstream Port to [bus 38]
  38:00.0 igc I225 NIC

If I225 sent a PTM request when it shouldn't have, i.e., when 07:04.0
didn't have PTM enabled, the error would have been logged by 07:04.0.

The fact that the errors were logged by 00:1d.0 and 04:01.0 means that
they were caused by PTM requests from 03:00.0 and 06:00.0.

Bjorn
