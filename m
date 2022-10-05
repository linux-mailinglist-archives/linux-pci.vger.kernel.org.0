Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1A5F589B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJEQyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJEQyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 12:54:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A24B9A8
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 09:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D65F8B81E04
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 16:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F1FC433C1;
        Wed,  5 Oct 2022 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664988840;
        bh=02jFrDuiLeHk3JlOJlwhjSQCdDBi6pthdZghCi9Pedg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ON17HedbQHvtnzK55K6iJKdd8RqK8cbKjJtCON72NF79JJwDUMv4wS6Bt4KXa2POk
         PuyQD8Chavw6ohk3LOwG3bKBICwwgME1cEuNOkUdpM/Mn3+t6pp9OvQTR+ILut7Nwq
         WPlyBVPkiD6MAinaj+oRVtA6pfioVHQ9tbFZ3hiYDcTBSdjGI1hqt1AkwLUI4O4uEG
         h9cqe5q8pUBXDK0EO+nuqr7s35R+Sn8fQav2VJDTWQRWH7XmSAl5qjs6MxRxFc5mek
         CEZ8yKqHOf6J2up22ix9b1vQISPKsCFL6sman5MW9k5pJ7rOz9LvDJi1v/LpZZWM4r
         EzXlaY5dtgakw==
Date:   Wed, 5 Oct 2022 11:53:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     veredz72@gmail.com
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Bug 216555] New: Kernel 4.19.135: pci_resource_start,
 pci_resource_len return wrong value
Message-ID: <20221005165358.GA2298432@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216555-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Wed, Oct 05, 2022 at 01:00:58PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216555
>            Summary: Kernel 4.19.135: pci_resource_start, pci_resource_len
>                     return wrong value

> I used 4.19.135(x64) + rootfs (buildroot) to boot an x86 SBC. 
> This SBC is connected via PCIe to a customized PCIe IO card.
> 
> In the kernel module, I used pci_resource_start, pci_resource_len to find
> start, length of 3 BARs. 
> It worked fine. 
> 
> Then I used the same kernel, kernel module on another x86 SBC. 
> In this SBC, pci_resource_start, pci_resource_len returned wrong data. 
> I booted this SBC with Centos 8.2 (4.18) and also with vanilla 4.9.20. 
> It worked fine. 
> 
> Is it possible that 4.19.135 has a BUG ?

It's unlikely that pci_resource_start() and pci_resource_len() are
broken in 4.19.135, but I guess anything is possible.

Can you give any more details about why it seems broken?  Dmesg logs
of a boot that fails and one that works, for instance?

Bjorn
