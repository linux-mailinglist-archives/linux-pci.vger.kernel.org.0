Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D715695430
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 23:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBMW5a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 17:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMW52 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 17:57:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B06A1DBB9;
        Mon, 13 Feb 2023 14:57:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24ACAB815DE;
        Mon, 13 Feb 2023 22:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84DFC433D2;
        Mon, 13 Feb 2023 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676329044;
        bh=6B74k2/9qoR7D5Y3uyBNWCUwY/n8BT4T+JeDx0KNIXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f3wYtIAg3DxNfUnDnm0X/pWYI0y83wxQTitkXRK6dqcedIMDfdNHPwCF4EEgfTdbU
         KcEx7Lmqm31hk/JKTYTwXE0TjCDOZbX3WpvRAjD91UD1t9tP7aXQgkHKcUHiOLA2i9
         8x+qC919a3RrSzB8/vbepPYd/xekMKpaD0KAzWYOFUnDcwV0wFd00arf3ywQP+M9ja
         UKz0KsEcCyHJSbo3qwVjzxCN5qUnjnICshiBfwztBKADD3+u6nzFa0X/9Knhw6Jqy7
         348KeZdLxIUtDsjIBiR5fkzMmN1yq9lFKal94PtmQZuzclAc1EgD9dcmdNEWIPBBIo
         RNdHpPkyh8Mrw==
Date:   Mon, 13 Feb 2023 16:57:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] kbuild, PCI: generic,versatile: comment out
 MODULE_LICENSE in non-modules
Message-ID: <20230213225723.GA2941414@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210164749.368998-2-nick.alcock@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 04:47:42PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So comment out all uses of MODULE_LICENSE that are not in real modules
> (the license declaration is left in as documentation).

Weird that all the patches are for drivers/pci/, but the cover letter
didn't go to linux-pci@vger.kernel.org.

  - Please drop "kbuild," from the subject; I don't think it's really
    relevant.

  - Please follow the subject line convention for each file.  They're
    mostly there after dropping "kbuild", but do capitalize the
    sentence that follows the prefix.  The prefix should always be
    "PCI/<driver-tag>: "

  - Remove the MODULE_LICENSE instead of commenting it out.

  - I think every file in drivers/pci that needs one already has SPDX.

  - AFAICT, SPDX is the dispositive license and MODULE_LICENSE just
    determines which interfaces are available to the module, so
    dropping MODULE_LICENSE shouldn't be a problem as far as legal
    issues.
