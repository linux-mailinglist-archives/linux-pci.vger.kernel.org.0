Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F9724F76
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 00:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjFFWM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFFWM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 18:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D91717
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 15:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D62962DA3
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 22:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0773C433D2;
        Tue,  6 Jun 2023 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686089575;
        bh=yN3RExtJaGZ1t3aiUV1phJOd2MrmNOmCqEWfCiWwUHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rvr3hDYmc5j0JFWEgUgzfnZAl1/yv1+BUsMGhq0Xk30H1KxPOD9M/wgJ77hugDo4c
         4S5PBlC/M63AKz8Hs6/dc2hRu/XpsWGI9Mv1iCH9+sStEf7NyV86QP5eAZT6sxVmVb
         cqWxobdHWdnKI0teCabG1qk3mI4DIJyaLcQWnYMCim4F7JJ2X0tKjzMwWsFJ89wAKW
         24D2CqCO2zVfTmXDG7j9gO772ToTJB0Q+FeBa43j1BTI/X1MMw+mq6X0MuCIb5xfiB
         W/dOgD1ik6tKIr01BsBRI+XpOCqLoiynNWfyJ0sIErVZVcXjHIhuDkqPcScfh6Fh4A
         js8dSr9Vq8WfQ==
Date:   Tue, 6 Jun 2023 17:12:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Dejean <dam.dejean@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Old Asus doesn't seem to support MSI
Message-ID: <20230606221254.GA1146708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19F46F0C-E9C8-489E-8AA5-2A16E13A6FE9@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 03, 2023 at 05:52:14PM +0200, Damien Dejean wrote:
> Hi linux-pci,
> 
> I recently installed Debian with a 5.10 kernel on an old Asus X73SL
> laptop. To be able to boot and use it properly I needed to use
> pci=nomsi, it seems that neither the GeForce9300M or the atheros
> wifi card (both PCI-E) would work with MSI enabled.
> 
> I’m suspecting now the chipset does not support MSI at all. I’d be
> happy to contribute the quirks to the kernel if it is the case.
> Could you give me some guidelines to verify this hypothesis ? Should
> I check the ACPI table to see if the information is available ? How
> can I check if MSI is supposed to be supported or not ?

Thanks a lot for the report!  Users should never have to use
"pci=nomsi", so it would be good if we can fix this.

Can you collect the complete dmesg log?  Also the output of
"sudo lspci -vv"?  There is a bit in ACPI that tells us if we
can't enable MSI, but we should mention that in the dmesg log
if it's set.

Bjorn
