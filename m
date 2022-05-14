Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE6527035
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 11:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiENJOI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 05:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiENJOH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 05:14:07 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48807B8
        for <linux-pci@vger.kernel.org>; Sat, 14 May 2022 02:14:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CADAF1030F213;
        Sat, 14 May 2022 11:14:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A3A152ED3DC; Sat, 14 May 2022 11:14:00 +0200 (CEST)
Date:   Sat, 14 May 2022 11:14:00 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 06/18] PCI: pciehp: Enable DLLSC interrupt only if
 supported
Message-ID: <20220514091400.GA20725@wunner.de>
References: <20220220193346.23789-1-kabel@kernel.org>
 <20220220193346.23789-7-kabel@kernel.org>
 <20220509034216.GA26780@wunner.de>
 <20220513165729.wuaatfr2drsjwoos@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220513165729.wuaatfr2drsjwoos@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 06:57:29PM +0200, Pali Rohár wrote:
> To answer your questions: Config space of Aardvark Root Port does not
> conform to PCIe base spec. It does not implement DLLLARC, nor DLLSCE and
> lot of other bits. Plus it has Type 0 header (not Type 1). And due to
> these reasons, pci-aardvark.c driver implements "emulation" of the
> Root Port and implements some of the functionality via custom aardvark
> registers. So Root Port would be presented to kernel and also to
> userspace as PCI Bridge device with Type 1 header and with PCIe
> registers required by linux kernel.
> 
> During my testing of kernel hotplug code last year, I figured out that
> kernel was waiting for event which never happened. And so it was needed
> to "fix" kernel to not try to enable DLLSCE because it did nothing.

Could you please reproduce this and add the following on the command line:

  log_buf_len=10M pciehp.pciehp_debug=1 dyndbg="file pciehp* +p"
  ignore_loglevel

Then open a bug at bugzilla.kernel.org, attach full dmesg output
as well as full "lspci -vv" output and send the bugzilla link to me.

(Obviously, revert patches 6 and 7 when trying to reproduce it.)

So a PDC event should be sufficient to bring the slot up or down,
a DLLSC event should not be necessary.  Enabling DLLSC should not
make a difference on a controller which doesn't support it.
I just double-checked the code and I do not see where we'd wait
for a DLLSC event which never comes.

Don't worry, if we come to the conclusion that your proposed fix
is the only solution, I'm fine with it, but at this point I'd
like to get a better understanding what is really going on.
Perhaps there is some other issue in pciehp that this patch
just papers over.  Once you provide the dmesg debug output
I'll be able to analyze that.

Thanks!

Lukas
