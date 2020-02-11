Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71D4158937
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 05:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBKEtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 23:49:42 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:33757 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgBKEtm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 23:49:42 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 752DA2800BB55;
        Tue, 11 Feb 2020 05:49:40 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 44C58DD1F; Tue, 11 Feb 2020 05:49:40 +0100 (CET)
Date:   Tue, 11 Feb 2020 05:49:40 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200211044940.72z4vcgbgxwbc7po@wunner.de>
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
 <20200211000816.GA89075@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211000816.GA89075@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 06:08:16PM -0600, Bjorn Helgaas wrote:
> used ctrl_info() instead of pci_info() (I would actually like to change
> the whole driver to use pci_info(), but better to be consistent for now)

Most of the ctrl_info() calls prepend "Slot(%s): " to the message.
However that prefix can only be used once pci_hp_initialize() has
been called.

It would probably make sense to change ctrl_info() to always
include the prefix and change those invocations of ctrl_info()
which happen when the slot is not yet or no longer registered,
to pci_info().


> @@ -930,7 +940,7 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
>  		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
>  
> -	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
> +	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
>  		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
> @@ -941,19 +951,10 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
>  		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
> +		ctrl->inband_presence_disabled,
>  		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
>  		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");

I've just reviewed the resulting commits on pci/hotplug once more and
think there's a small issue here:  If ctrl->inband_presence_disabled is 0,
the string will contain ASCII character 0 (end of string) and if it's 1
it will contain ASCII character 1 (start of header).  A possible solution
would be FLAG(ctrl->inband_presence_disabled, 1).

(The real solution would probably to have a printk format for this kind
of thing.)

Thanks,

Lukas
