Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEF65E44D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 05:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjAEEBS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 23:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAEEBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 23:01:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC92F79E
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 20:01:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813686136C
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 04:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F25C433F1;
        Thu,  5 Jan 2023 04:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672891275;
        bh=IJReYyaviGZgsdCodKper2P7gyaDqcp5KVzAT2IAGgs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pO0XSbVPN07PIZqUPII3G7P3JzPGnNJLOFSjI0OvaeSxu/gchyNzTRdagHUJt8hZ4
         KXr54Tq094U41saYSdP5jvCWlwxyxTuxCEJmwYkQfcQD29vO/HSltnCgOKfFPxgfeN
         bcBsiQfdl9CXXmVhaOOEpHHyhx2fAPdh0bGsiAqgb2c2sQmZpcPPMOBpIgARuEaCp+
         Yi1wbOPCDlacUw5B8Ix5FfiUx8FopuD0EpLn4GkS6TSdY+D8hq8CpbZbGDcPHIEy+Y
         lGmSJIwpUASH7+Ql+50kZEMRQcQlhB/Z9S4C4kaHQW3ouhCj0xtF+JX7LkwG2t/prT
         MAsd9JRkhAavQ==
Date:   Wed, 4 Jan 2023 22:01:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 2/2] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20230105040114.GA1115282@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5muGHQ=awDckP2Fv6kg_-Mrcpre2ng52yKrTnhpqrVOA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 10:49:53AM +0800, Huacai Chen wrote:
> On Thu, Jan 5, 2023 at 2:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 03, 2023 at 03:34:01PM +0800, Huacai Chen wrote:
> > > cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during shutdown")
> > > causes poweroff/reboot failure on systems with LS7A chipset. We found
> > > that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in do_pci_disable
> > > _device(), it can work well. The hardware engineer says that the root
> > > cause is that CPU is still accessing PCIe devices while poweroff/reboot,
> >
> > Did you ever figure out what these CPU accesses are?  If we call the
> > Root Port .shutdown() method, and later access a downstream device,
> > that seems like a problem in itself.  At least, we should understand
> > exactly *why* we access that downstream device.
>
> Maybe I failed to get the key point, but from my point of view, the
> root cause is clear in previous discussions:
> https://lore.kernel.org/linux-pci/CAAhV-H5uT+wDRkVbW_o1hG2u0rtv6FFABTymL1VdjMMD_UEN+Q@mail.gmail.com/
> https://lore.kernel.org/linux-pci/20220617113708.GA1177054@bhelgaas/
> https://lore.kernel.org/linux-pci/CAAhV-H6raQnXZ4ZZRq19cugew26wXYONctcFO0392gZ00LC6bw@mail.gmail.com/

That's great, but the root cause should be summarized here in the
commit log.

> > To be clear, cc27b735ad3a does not cause the failure.  IIUC, the cause
> > is:
>
> cc27b735ad3a is not a bug, we refer to it just because we observe
> problems after it.

Right.  But you said "cc27b735ad3a ... causes failure," which is not
quite true.  cc27b735ad3a may *expose* an LS7A hardware defect that
previously didn't cause a problem, but I don't want to blame
cc27b735ad3a for that hardware issue.

Bjorn
