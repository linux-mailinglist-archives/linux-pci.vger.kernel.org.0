Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1512D67CE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 20:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390321AbgLJT7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 14:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404336AbgLJT7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 14:59:13 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D462C0613CF
        for <linux-pci@vger.kernel.org>; Thu, 10 Dec 2020 11:58:33 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7E8E223E5D;
        Thu, 10 Dec 2020 20:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607630307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMhg82S0rwUSrDpQiFh0ST2pjTuKrxogeVcd6fb/BYU=;
        b=dnygdpHM2m3GMfxdC9krsKYEPRMHmLSimDuAfuHkp9B+WvhENOP1JGuIC1hgvaWYW8vooR
        cObG9mXNSlEl+RbJyAQXjAEUjMNUxeXXJK+9oWx4GAVScYKHglUMULZJH+oHRC4twGtl11
        /qZ1HdnbCMHzriG18csTWpg2CJ/KS0c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Dec 2020 20:58:20 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>, lorenzo.pieralisi@arm.com,
        kw@linux.com, heiko@sntech.de, benh@kernel.crashing.org,
        shawn.lin@rock-chips.com, paulus@samba.org,
        thomas.petazzoni@bootlin.com, jonnyc@amazon.com,
        toan@os.amperecomputing.com, will@kernel.org, robh@kernel.org,
        f.fainelli@gmail.com, mpe@ellerman.id.au, michal.simek@xilinx.com,
        linux-rockchip@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@intel.com,
        linux-pci@vger.kernel.org, rjui@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, Jonathan.Cameron@huawei.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        sbranden@broadcom.com, wangzhou1@hisilicon.com,
        rrichter@marvell.com, linuxppc-dev@lists.ozlabs.org,
        nsaenzjulienne@suse.de,
        Alexandru Marginean <alexm.osslist@gmail.com>
Subject: Re: [PATCH v6 0/5] PCI: Unify ECAM constants in native PCI Express
 drivers
In-Reply-To: <20201210173809.GA37355@bjorn-Precision-5520>
References: <20201210173809.GA37355@bjorn-Precision-5520>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <194550494fde93c6eb840eabf59bde38@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2020-12-10 18:38, schrieb Bjorn Helgaas:
> On Wed, Dec 09, 2020 at 10:29:04PM +0200, Vladimir Oltean wrote:
>> On Wed, Dec 09, 2020 at 04:40:52PM +0100, Michael Walle wrote:
>> > Hopefully my mail client won't mess up the output that much.
>> 
>> I can reproduce on my LS1028A as well. The following fixes the bug for
>> me. I did not follow the discussion and see if it is helpful for 
>> others.
>> I don't understand how the bug came to be. There might be more to it
>> than what I'm seeing. If it's just what I'm seeing, then the patch was
>> pretty broken to begin with.
> 
> I squashed the fix below into a pci/ecam branch for v5.11, thanks!

FWIW
Tested-by: Michael Walle <michael@walle.cc>

-michael
