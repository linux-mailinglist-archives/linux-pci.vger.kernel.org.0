Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF16A9CED
	for <lists+linux-pci@lfdr.de>; Fri,  3 Mar 2023 18:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCCRN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 12:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCCRN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 12:13:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5E14EB6
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 09:13:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23C546182C
        for <linux-pci@vger.kernel.org>; Fri,  3 Mar 2023 17:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59099C433D2;
        Fri,  3 Mar 2023 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677863634;
        bh=r5khmF2m1xgu1sY5kmtTpPrd8CMe4miZ/5PAx+wugtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=baKOodvW4vBGX5pRnEteKhSnGtKy6+HZiYQm7NXvHh3etNbEBdUbhp33CvgjDQ37T
         n6JqqxJ2U5A6b9SnaZppTuuJdODc+0StdOxRMbmv3zv8vM51TN6m05k2ksyqQHAXLV
         yEItcGv4w65OeNU0D3I1tRzZ02JMDIsRuBJCN/csCQX6ev6znf+dH1QuKDwMlWlGxV
         RGCGIXl0xg1iAX3ahtYHuWX3Heo6BUyv/ERSwKb/OSQQJFreSGxHwotEt++c9l/h7w
         8z9skSj/lQVMgi0M6wQiwqdUuREt4TOgeBkmwTqZCP/3D/4A8kaJujpB8SL5U3L/SC
         BlvCODLhGjIIA==
Date:   Fri, 3 Mar 2023 11:13:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     1527030098@qq.com
Cc:     Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org
Subject: Re: [Bug 217080] New: missing kzalloc check in pci_aer_init
Message-ID: <20230303171352.GA538278@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-217080-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 24, 2023 at 06:47:48AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=217080
> ...
> 
> miss a null check at
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/aer.c#L383, and
> it may cause crush at pointer dereference . e.g.
> https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/aer.c#L543

Thanks for the report.  Have you actually observed a crash here?

The stats code was added by:

  12833017e581 ("PCI/AER: Add sysfs attributes for rootport cumulative stats")
  81aa5206f9a7 ("PCI/AER: Add sysfs attributes to provide AER stats and breakdown")
  db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices")

The alloc is in pci_aer_init(), which is called during enumeration:

  pci_device_add
    pci_init_capabilities
      pci_aer_init
	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
    device_add
      device_add_attrs

The dev->aer_stats uses in these functions should be safe because they
test for NULL before dereferencing it:

  pci_dev_aer_stats_incr
  pci_rootport_aer_stats_incr

The uses in these sysfs DEVICE_ATTR_RO macros are a little more
subtle:

  aer_stats_dev_attr
  aer_stats_rootport_attr

They don't test for NULL, but visibility of these attributes is
controlled by aer_stats_attrs_are_visible(), which should only make
the attributes visible when dev->aer_stats is non-NULL.

That .is_visible() function is called inside device_add(), so it
happens after the kzalloc in pci_aer_init().

So I *think* the existing code is safe.  But if you're seeing a crash,
obviously there's something wrong.  If you can cause a crash, can you
provide a little more detail?

Bjorn
