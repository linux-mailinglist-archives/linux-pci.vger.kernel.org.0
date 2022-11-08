Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7871C6211FB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiKHNIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 08:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiKHNIT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 08:08:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC6A468
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 05:08:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FF656156A
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 13:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8153AC433D6;
        Tue,  8 Nov 2022 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667912897;
        bh=TnHjGIm9GrsFJri7zEd33pHFzEgjWgW6lA2JE5peYkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BCgPGsCUGPhsmBhbXNi14VHpiY3L4zl+eDix7+sWRY5RhImQRCKZkf4LMzUhiVwgM
         ueodajhviEfgo+JhRnSa86OA8DDobGcSWwaeTXT49y+T9bY+36OfU6YiD4ozoaIkiV
         V5yhNYWz48GEIFTJpeZ1v14KN98CSn0NJDXp/2hjXWNt/Ex90UbYNW9f1+lCle+IlG
         9k+bq+qi0axVWEKue+2k7XpXOeTUTuBV5NBv9iZ9dAwaDW79f0ejP+IcrbmI30JuCv
         o7TU8woMYny0Vlb6H/3hTbHX6RPgW7GgdoGF2iF4nDMDIQesxsVgtaCQN3QXpd8i90
         5aKRkukD5UQcQ==
Date:   Tue, 8 Nov 2022 07:08:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: Re: [helgaas-pci:pci/enumeration 3/3] drivers/pci/probe.c:909:6:
 warning: variable 'err' is used uninitialized whenever 'if' condition is
 true
Message-ID: <20221108130816.GA464595@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211081120.s8hX7ZW3-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Why did the bot tell me the build was *SUCCESSFUL* even though this is
clearly a problem?  Here's the "success" message:

  https://lore.kernel.org/all/636a47ad.UocsB2qjv%2FcFWvK2%25lkp@intel.com/

On Tue, Nov 08, 2022 at 03:21:20PM +0800, kernel test robot wrote:

> >> drivers/pci/probe.c:909:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if (bus->domain_nr < 0)
>                ^~~~~~~~~~~~~~~~~~

I set "err = -EINVAL" here; let me know if you prefer something
different.
