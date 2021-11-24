Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFCE45B5B3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 08:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKXHnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 02:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhKXHnd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 02:43:33 -0500
X-Greylist: delayed 159998 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Nov 2021 23:40:24 PST
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12664C061574;
        Tue, 23 Nov 2021 23:40:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 710453FA5E;
        Wed, 24 Nov 2021 07:40:20 +0000 (UTC)
Subject: Re: [PATCH] PCI: apple: Configure link speeds properly
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211122111332.72264-1-marcan@marcan.st>
 <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <8e881b80-614c-dccf-ddaf-895d1acf26c7@marcan.st>
Date:   Wed, 24 Nov 2021 16:40:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+vFbFN+WQhi3dRicW+kaP1Oi9JPSmnAFL7XAc0eCvgrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24/11/2021 11.23, Rob Herring wrote:
>> +#include "../pci.h"
>> +/* Apple PCIe is based on DesignWare IP and shares some registers */
>> +#include "dwc/pcie-designware.h"
> 
> I'm starting to regret this not being part of the DWC driver...

Main issue is the DWC driver seems to have a pretty hard-coded 
assumption of one port per controller, plus does a bunch of stuff 
differently for the higher layers. It seems Apple used the DWC PHY/LTSSM 
bits, then rolled their own upper layer.

>> +/* The offset of the PCIe capabilities structure in bridge config space */
>> +#define PCIE_CAP_BASE          0x70
> 
> This offset is discoverable, so don't hardcode it.

Sure, it just means I have to reinvent the PCI capability lookup wheel 
again. I'd love to use the regular accessors, but the infrastructure 
isn't up to the point where we can do that yet yere. DWC also reinvents 
this wheel, but we can't reuse that code because it pokes these 
registers through a separate reg range, not config space (even though it 
seems like they should be the same thing? I'm not sure what's going on 
in the DWC devices... for the Apple controller it's just the ECAM).

>> +       max_gen = of_pci_get_max_link_speed(port->np);
>> +       if (max_gen < 0) {
>> +               dev_err(port->pcie->dev, "max link speed not specified\n");
> 
> Better to fail than limp along in gen1? Though you don't check the
> return value...
> 
> Usually, the DT property is there to limit the speed when there's a
> board limitation.

The default *setting* is actually Gen4, but without 
PCIE_LINK_WIDTH_SPEED_CONTROL poked it always trains at Gen1. Might make 
more sense to only set the LNKCTL field if max-link-speed is specified, 
and unconditionally poke that bit. That'll get us Gen4 by default (or 
even presumably Gen5 in future controllers, if everything else stays 
compatible).

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
