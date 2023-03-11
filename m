Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541586B5975
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 09:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjCKIW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 03:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCKIWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 03:22:25 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA2A20D18
        for <linux-pci@vger.kernel.org>; Sat, 11 Mar 2023 00:22:24 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 363DA280154BA;
        Sat, 11 Mar 2023 09:22:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 21C383E457; Sat, 11 Mar 2023 09:22:20 +0100 (CET)
Date:   Sat, 11 Mar 2023 09:22:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Tushar Dave <tdave@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, linux-pci@vger.kernel.org
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Message-ID: <20230311082220.GA3649@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309175321.GA1151233@bhelgaas>
 <843e2392-9ff0-2286-5f97-659831013c2e@nvidia.com>
 <20230310235306.GA1290793@bhelgaas>
 <4922cec7-ecc1-4971-75af-cdbaeaa6434f@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FAKE_REPLY_C,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 05:45:48PM -0800, Tushar Dave wrote:
> On 3/10/2023 3:53 PM, Bjorn Helgaas wrote:
> > In the log below, pciehp obviously is enabled; should I infer that in
> > the log above, it is not?
> 
> pciehp is enabled all the time. In the log above and below.
> I do not have answer yet why pciehp shows-up only in some tests (due to DPC
> link down/up) and not in others like you noticed in both the logs.

Maybe some of the switch Downstream Ports are hotplug-capable and
some are not?  (Check the Slot Implemented bit in the PCI Express
Capabilities Register as well as the Hot-Plug Capable bit in the
Slot Capabilities Register.)


> > Generally we've avoided handling a device reset as a remove/add event
> > because upper layers can't deal well with that.  But in the log below
> > it looks like pciehp *did* treat the DPC containment as a remove/add,
> > which of course involves configuring the "new" device and its MPS
> > settings.
> 
> yes and that puzzled me why? especially when"Link Down/Up ignored (recovered
> by DPC)". Do we still have race somewhere, I am not sure.

You're seeing the expected behavior.  pciehp ignores DLLSC events
caused by DPC, but then double-checks that DPC recovery succeeded.
If it didn't, it would be a bug not to bring down the slot.
So pciehp does exactly that.  See this code snippet in
pciehp_ignore_dpc_link_change():

	/*
	 * If the link is unexpectedly down after successful recovery,
	 * the corresponding link change may have been ignored above.
	 * Synthesize it to ensure that it is acted on.
	 */
	down_read_nested(&ctrl->reset_lock, ctrl->depth);
	if (!pciehp_check_link_active(ctrl))
		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
	up_read(&ctrl->reset_lock);

So on hotplug-capable ports, pciehp is able to mop up the mess created
by fiddling with the MPS settings behind the kernel's back.

We don't have that option on non-hotplug-capable ports.  If error
recovery fails, we generally let the inaccessible devices remain
in the system and user interaction is necessary to recover, either
through a reboot or by manually removing and rescanning PCI devices
via syfs after reinstating sane MPS settings.


>   - Switch and NVMe MPS are 512B
>   - NVMe config space saved (including MPS=512B)
>   - You change Switch MPS to 128B
>   - NVMe does DMA with payload > 128B
>   - Switch reports Malformed TLP because TLP is larger than its MPS
>   - Recovery resets NVMe, which sets MPS to the default of 128B
>   - nvme_slot_reset() restores NVMe config space (MPS is now 512B)
>   - Subsequent NVMe DMA with payload > 128B repeats cycle

Forgive my ignorance, but if MPS is restored to 512B by nvme_slot_reset(),
shouldn't the communication with the device just work again from that
point on?

Thanks,

Lukas
