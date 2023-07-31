Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886C176A1A2
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGaT7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGaT7d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 15:59:33 -0400
X-Greylist: delayed 7633 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 12:59:31 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A384219A2;
        Mon, 31 Jul 2023 12:59:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4A1F6300011A4;
        Mon, 31 Jul 2023 21:59:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 22117274439; Mon, 31 Jul 2023 21:59:30 +0200 (CEST)
Date:   Mon, 31 Jul 2023 21:59:30 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, alex.williamson@redhat.com,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        vsethi@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Message-ID: <20230731195930.GA13000@wunner.de>
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 01:32:27AM +0530, Vidya Sagar wrote:
> On 7/31/2023 1:10 AM, Lukas Wunner wrote:
> > On Mon, Jul 31, 2023 at 12:45:19AM +0530, Vidya Sagar wrote:
> > > PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
> > > send upstream messages before they have been assigned a bus number and
> > > such messages have a Requester ID with Bus number set to 00h.
> > > If the Downstream port has ACS Source Validation enabled, these messages
> > > will be detected as ACS violation error.
> > > 
> > > Hence, disable ACS Source Validation in the bridge device during
> > > hot-remove operation and re-enable it after enumeration of the
> > > downstream hierarchy but before binding the respective device drivers.
> > 
> > What are these messages that are sent before assignment of a bus number?
> 
> One example is the DRS (Device Readiness Status) message.

Please mention that in the commit message.


> > What's the user-visible issue that occurs when they're blocked?
> 
> I'm not sure about the issue one can observe when they are blocked, but, we
> have seen one issue when they are not blocked. When an endpoint sends a DRS
> message and an ACS violation is raised for it, the system can trigger DPC
> (Downstream Port Containment) if it is configured to do so for ACS
> violations. Once the DPC is released after handling it, system would go for
> link-up again, which results in root port receiving DRS once again from the
> endpoint and the cycle continues.

As an alternative to disabling ACS, have you explored masking ACS
Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
unmasking them after assignment of a bus number?

That would alleviate concerns that disabling ACS Source Validation
weakens security (because it doesn't have to be disabled in the
first place).

You'd need to clear the ACS Violation Status bit in the Uncorrectable
Error Status Register though after assignment of a bus number,
in addition to unmasking it, because that bit is still set despite
the error being masked.

The kernel affords a generous 60 sec timeout for devices to become
ready (PCIE_RESET_READY_POLL_MS) and is not dependent on DRS messages
coming through, so blocking them with ACS shouldn't cause issues.


> > Doesn't disabling Source Validation introduce a security hole because the
> > device may spoof messages before Source Validation is re-enabled?
> 
> Agree, but this concern is already/has always been  there during boot
> scenario where the link-up happens first and the ACS is enabled at a later
> point and endpoint can spoof messages in between if it wishes so.

The problem is that devices may be removed only logically (via sysfs
"power" attribute or Attention Button) and still remain in the system
physically.  They may spoof messages until they're physically removed
or the hotplug slot is brought up again.


> > PCIe r6.1 sec 6.12.1.1 does indeed point out that the downstream device
> > is *permitted* to send these messages but the Implementation Note
> > does *not* prescribe that Source Validation shall be disabled to let them
> > through.  It merely points out that the messages may be filtered if
> > Source Validation is enabled.
> 
> Could you please elaborate on the filtering part. Do you expect this to be
> implemented in the hardware or software?

By "filtered" I meant that TLPs are blocked by ACS.  Sorry for the
confusing word choice.

Thanks,

Lukas
