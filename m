Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127DD5EB2F0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 23:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiIZVRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 17:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiIZVRb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 17:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6A2796A7;
        Mon, 26 Sep 2022 14:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D2196144B;
        Mon, 26 Sep 2022 21:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E15C433D7;
        Mon, 26 Sep 2022 21:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664227046;
        bh=6GSn94Blq3J790kWs2lNqt3NgwBFtoPMQx4tbDun8ZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MCEmjgVe9iLcMmSWH6gZxsW71KKhS5j6Z112TuWs/so7f8Sqt0P5WJXl3SDFzUcYr
         PB7fSm717V70sS0jDVtBuBcwvmxrV5ByTbaBtVM8UYcw5inJ6Aayn6oFjK7YmToK1s
         0TnqJsVAiz97k13QORTEENy+nJKd8FhNqgqcAsDxvxrCWm/eZEixH+xGI0R9R814ru
         P0ReoT5JyjgkF6rL7jEez4uR3O6w82WyA50AMxRmdTBuFjGzqJFJ+IkuxImU98vaVQ
         UpjNpFYxFI8ZmQCk6QO+gzYD09/w4loNIcqennjUYPFwC7wwkHUUdwJ42H59YutdnD
         nyjMsCzrdxxrA==
Date:   Mon, 26 Sep 2022 16:17:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     stefan.buehler@tik.uni-stuttgart.de, sean.v.kelley@linux.intel.com,
        bhelgaas@google.com, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, kar.hin.ong@ni.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mingo@redhat.com, sassmann@kpanic.de,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: boot interrupt quirk (also in 4.19.y) breaks serial ports (was:
 [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets)
Message-ID: <20220926211724.GA1625628@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923192030.162412-1-ghalat@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 09:20:30PM +0200, Grzegorz Halat wrote:
> On Wed, Sep 16 2020 at 12:12, Stefan Bühler wrote:
> > this quirk breaks our serial ports PCIe card (i.e. we don't see any
> > output from the connected devices; no idea whether anything we send
> > reaches them):
> 
> I have the same problem, also with a PCI serial adapter from Oxford
> Semiconductor.  I've bisected the kernel and it was introduced in
> b88bf6c3b6ff.  When the system is booted with "pci=noioapicquirk"
> then the PCI card works fine.  The CPU is Intel Xeon E5-2680 v3 @
> 2.50GHz.
> 
> Sean, do you have any news about this issue?

I think Sean has moved on and isn't available to work this issue.

To help whoever *can* work on it, would you mind attaching the
complete dmesg log and "sudo lspci -vv" output for your system?  Then
we can potentially tweak the quirk to not break your system.

Bjorn
