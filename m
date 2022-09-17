Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76F5BB80D
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 14:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIQMDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 08:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiIQMDH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 08:03:07 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98BC92ED4C;
        Sat, 17 Sep 2022 05:03:06 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C7A9792009C; Sat, 17 Sep 2022 14:03:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B8C0292009B;
        Sat, 17 Sep 2022 13:03:05 +0100 (BST)
Date:   Sat, 17 Sep 2022 13:03:05 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     Stefan Roese <sr@denx.de>, Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] pci: Work around ASMedia ASM2824 PCIe link training
 failures
Message-ID: <alpine.DEB.2.21.2209061238050.2275@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

 This is v5 of the change to work around a PCIe link training phenomenon 
where a pair of devices both capable of operating at a link speed above 
2.5GT/s seems unable to negotiate the link speed and continues training 
indefinitely with the Link Training bit switching on and off repeatedly 
and the data link layer never reaching the active state.

 This was originally observed in a configuration featuring a downstream 
port of the ASMedia ASM2824 Gen 3 switch wired to the upstream port of the 
Pericom PI7C9X2G304 Gen 2 switch.  However in the course of review I have 
come to the conclusion that similarly to the earlier similar change to 
U-Boot it is indeed expected to be safe to apply this workaround to any 
downstream port that has failed link negotiation provided that:

1. the port is capable of reporting the data link layer link active 
   status (because unlike U-Boot we cannot busy-loop continuously polling 
   the link training bit),

and:

2. we don't attempt to lift the 2.5GT/s speed restriction, imposed as the
   basis of the workaround, for devices not explicitly known to continue 
   working in that case.

It is expected to be safe because the workaround is applied to a failed 
link, that is one that does not (at the time this code is executed) work 
anyway, so trying to bring it up cannot make the situation worse.  So this 
version of the workaround is attempted for all PCIe devices discovered, 
and only the lifting of the 2.5GT/s speed restriction is qualified by the 
vendor:device ID, currently one of the ASMedia ASM2824 device only.

 Broadening the scope of the quirk has in turn made it necessary to make 
some adjustments to code elsewhere and consequently what was originally a 
single patch has now become a small series instead.

 This has been verified with a SiFive HiFive unmatched board, booting with 
or without the workaround activated in U-Boot, which covered both the link 
retraining part of the quirk and the lifting of speed restriction already 
imposed by U-Boot.

 Please see individual change descriptions for further details.

 Questions or comments?  Otherwise please apply.

  Maciej
