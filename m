Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8E4C4D84
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiBYSUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 13:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiBYSUj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 13:20:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380691F83EA;
        Fri, 25 Feb 2022 10:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D184461E45;
        Fri, 25 Feb 2022 18:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED835C340E7;
        Fri, 25 Feb 2022 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645813206;
        bh=3pp28Z7LYj0TeOCOwmecu2bPUACxkEVQ3wkBZOO598I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BQc9DcTOi6HSwOn/ET23Hyq6JZAqi0MgedWChGOKvgiN4xFTTvife4hrn12ANPE89
         7hlrTB1An0XU3F12OarfKxgb4nwmJFB8SyK+qlx4LfknLxKYwsV43slCXVzXCxQELI
         WGzhkGLQTagV9G74sN3HEy5qGt4h4gUTY3ssgeWGao2iW7fyQwWtKWQobdinQFkjIC
         c6jo6cMd0oTo5/EeH7yUmTlxh0bdE/Y8IcgcrEFW5LANJMCCYgIwJg4Mo+IcWFJS0G
         hbKewORzsotOyVzsrwKpeKbmP1yMqcLRVm84o5eU1GcRJADlce/pNHxRJuR6L9jfUO
         h3H2m8rcQdgSA==
Date:   Fri, 25 Feb 2022 12:20:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        tiwai@suse.com, perex@perex.cz, alex.bou9@gmail.com,
        mporter@kernel.crashing.org, logang@deltatee.com,
        kurt.schwemmer@microsemi.com, Bjorn Helgaas <bhelgaas@google.com>,
        kw@linux.com, robh@kernel.org, lorenzo.pieralisi@arm.com,
        jonathan.derrick@linux.dev, nirmal.patel@linux.intel.com
Subject: Re: [PATCH] Removed some usages of the deprecated "pci-dma-compat.h"
 KPI
Message-ID: <20220225182004.GA369816@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoG2+9Tp4ZW4tqTVSgp7wukduEFKHiqOXJO-Yn17OwTvn+a+w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 23, 2022 at 01:54:54AM -0800, Yusuf Khan wrote:
> See https://lkml.org/lkml/2022/2/23/11 Before you think of this commit!

Use links to https://lore.kernel.org/r/ whenever you can, instead of
lkml.org, etc.
