Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C833621A42
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 18:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiKHRQS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiKHRQJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 12:16:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E459FF9
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 09:15:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44507B81BDE
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 17:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ADDC433D6;
        Tue,  8 Nov 2022 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667927754;
        bh=wRyf14kNFEn854+78KyA7DceGOKdMIJZaXiM/FsMW84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Yyf+dFIQ2HZ9j8F93vks/7uqb4w6JmjJ3uKnISNtRSq1G+tcKkQRLNNNbS4IgzKy2
         Y7O8wcNK8zhKaoDa8TGXac7zmGenVrthufrUtBMd3bQW1tyM10wqKZNOe8AmRTI9lI
         l56Qxjihtf5EVhQPtywTBoOznqqPjFQ6ZMnTzmZH6kcprXKeKPgOF14K7QURkxKEOZ
         Qv7AJXKWgZ/28eL+YTj1FvOgK3U6uN/UEI6wkj69a7PHCcJnxuhzvs5U3AWiJmZo1W
         pvEp0S7+G4twgE9ZBbfVMk88wMlUW9hDa4Da3uSJ0NHqtQsTYsNAdgX4Oi35MrJHOL
         e0nRSfF9LPiEg==
Date:   Tue, 8 Nov 2022 11:15:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [helgaas-pci:pci/enumeration 3/3] drivers/pci/probe.c:909:6:
 warning: variable 'err' is used uninitialized whenever 'if' condition is
 true
Message-ID: <20221108171553.GA479740@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108170619.jmcfvcuggkwjfo7j@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 06:06:19PM +0100, Pali Rohár wrote:
> On Tuesday 08 November 2022 07:08:16 Bjorn Helgaas wrote:
> > Why did the bot tell me the build was *SUCCESSFUL* even though this is
> > clearly a problem?  Here's the "success" message:
> > 
> >   https://lore.kernel.org/all/636a47ad.UocsB2qjv%2FcFWvK2%25lkp@intel.com/
> > 
> > On Tue, Nov 08, 2022 at 03:21:20PM +0800, kernel test robot wrote:
> > 
> > > >> drivers/pci/probe.c:909:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
> > >            if (bus->domain_nr < 0)
> > >                ^~~~~~~~~~~~~~~~~~
> > 
> > I set "err = -EINVAL" here; let me know if you prefer something
> > different.
> 
> Hello! I agree that there is missing err= assignment.
> 
> Instead of -EINVAL you can use also bus->domain_nr as it is negative and
> would contained error code (from ida_alloc() call).

Good idea, I adopted that :)
