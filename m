Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0075F733F54
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jun 2023 09:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjFQH7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jun 2023 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQH7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2023 03:59:24 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FCE2720;
        Sat, 17 Jun 2023 00:59:22 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3ED7B100D942C;
        Sat, 17 Jun 2023 09:59:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 123051E21DD; Sat, 17 Jun 2023 09:59:20 +0200 (CEST)
Date:   Sat, 17 Jun 2023 09:59:20 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Message-ID: <20230617075920.GA26803@wunner.de>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
 <20230516101001.GA18952@wunner.de>
 <8ab986f2-6aa5-401a-aa21-e8b21f68eaad@amd.com>
 <20230616173140.GA6417@wunner.de>
 <e967608f-ac8a-7a9c-35c5-821b6842653c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e967608f-ac8a-7a9c-35c5-821b6842653c@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 04:30:49PM -0700, Smita Koralahalli wrote:
> On 6/16/2023 10:31 AM, Lukas Wunner wrote:
> > On Mon, May 22, 2023 at 03:23:57PM -0700, Smita Koralahalli wrote:
> > > On 5/16/2023 3:10 AM, Lukas Wunner wrote:
> > > > On Tue, Apr 18, 2023 at 09:05:25PM +0000, Smita Koralahalli wrote:
> > > > > +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> > > > > +{
> > > > > +	u16 status;
> > > > > +
> > > > > +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
> > > > > +
> > > > > +	if (!(status & PCI_ERR_UNC_SURPDN))
> > > > > +		return false;
> > > > > +
> > > > 
> > > > You need an additional check for pdev->is_hotplug_bridge here.
> > > > 
> > > > And you need to read PCI_EXP_SLTCAP and check for PCI_EXP_SLTCAP_HPS.
> > > > 
> > > > Return false if either of them isn't set.
> > > 
> > > Return false, if PCI_EXP_SLTCAP isn't set only correct? PCI_EXP_SLTCAP_HPS
> > > should be disabled if DPC is enabled.
> > > 
> > > Implementation notes in 6.7.6 says that:
> > > "The Hot-Plug Surprise (HPS) mechanism, as indicated by the Hot-Plug
> > > Surprise bit in the Slot Capabilities Register being Set, is deprecated
> > > for use with async hot-plug. DPC is the recommended mechanism for supporting
> > > async hot-plug."
> > > 
> > > Platform FW will disable the SLTCAP_HPS bit at boot time to enable async
> > > hotplug on AMD devices.
> > 
> > Huh, is PCI_EXP_SLTCAP_HPS not set on the hotplug port in question?
> > 
> > If it's not set, why do you get Surprise Down Errors in the first place?
> > 
> > How do you bring down the slot without surprise-removal capability?
> > Via sysfs?
> 
> As per SPEC 6.7.6, "Either Downstream Port Containment (DPC) or the Hot-Plug
> Surprise (HPS) mechanism may be used to support async removal as part of an
> overall async hot-plug architecture".
> 
> Also, the implementation notes below, it conveys that HPS is deprecated and
> DPC is recommended mechanism. More details can be found in Appendix I, I.1
> Async Hot-Plug Initial Configuration:
> ...
> If DPC capability then,
> 	If HPS bit not Set, use DPC
> 	Else attempt to Clear HPS bit (§ Section 6.7.4.4 )
> 		If successful, use DPC
> 		Else use HPS
> ...
> 
> So, this is "likely" a new feature support patch where DPC supports async
> remove. HPS bit will be disabled by BIOS if DPC is chosen as recommended
> mechanism to handle async removal.
> 
> I see the slot is being brought down by PDC or DLLSC event, which is
> triggered alongside DPC.
> 
> pciehp_handle_presence_or_link_change() -> pciehp_disable_slot() ->
> __pciehp_disable_slot() -> remove_board()..
> 
> But I want to clear one thing, are you implying that PDC or DLLSC shouldn't
> be triggered when HPS is disabled?

Sorry, please ignore my advice to check PCI_EXP_SLTCAP_HPS in
dpc_is_surprise_removal().

Instead, only check for pdev->is_hotplug_bridge.  The rationale being
that Surprise Down errors are par for the course on hotplug ports,
but they're an anomaly that must be reported on non-hotplug ports.

PCI_EXP_SLTCAP_HPS has no bearing on pciehp's behavior.  If there's
a hotplug port and hotplug control was granted to the OS, pciehp will
bind to the device.  pciehp will react to any DLLSC and PDC event.

I think the target audience for PCIe r6.1 sec 6.7.6 are hardware
designers and the advice given there is to add DPC capability to
hotplug ports.  That's fine.  It doesn't affect how Linux handles
async removal.

I think the wording in the spec to "use DPC" for async removal is
confusing.  We don't want to duplicate the code for device
de-/re-enumeration and slot bringup / bringdown in the dpc driver.
We just continue letting pciehp do that (and thus retain compatibility
with older, non-DPC-capable hardware).  But we wire up pciehp with
the dpc driver to add DPC-awareness for hotplug.

One part of the equation was to ignore link changes which occur
as a side effect of a DPC event from which we've successfully
recovered.  That was added with commit a97396c6eb13 ("PCI: pciehp:
Ignore Link Down/Up caused by DPC").

The other part of the equation (which you're adding here) is to
ignore Surprise Down errors in the dpc driver which occur as a side
effect of async removal.

I think that makes us compliant with PCIe r6.1 sec 6.7.6, although
we're interpreting "use DPC" (or async removal) somewhat liberally.
Actually I'd prefer the term "pragmatically" instead of "liberally". ;)

We don't want to duplicate code just for the sake of being word-by-word
compliant with the spec.  If it works in the real world, it's fine. :)

Thanks,

Lukas
