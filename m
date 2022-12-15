Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E364E194
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiLOTHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 14:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOTHw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 14:07:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00271BA8;
        Thu, 15 Dec 2022 11:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F7B61EEC;
        Thu, 15 Dec 2022 19:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3009C433D2;
        Thu, 15 Dec 2022 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671131271;
        bh=h8JfC6i/Etf/A0VZB4U7ZnSzUI6uc5JDwfPInE3rOBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jtlIaYOmXM+ds2W4lFb+mfeulD0UIf9efRBGRvfLndj+vYr2bd9Sshw/yCD99CfGe
         ZrPbUDKjvgQQOVjhMvZEKDj9tyX0BiGe5jLQVX/t95cbzr+la5aRqOFJyFc9/Qitz1
         F0NX2871cNJ07o9gORiw7DnlwKrodIhGvY/woHV2lcBDjVLM24zEQcYljYuAiMIkD2
         DZxN3DCNLUhP5yixxhRDWYTpSrFi+4SkORE4VMCCnhKtsgEpIkMxxMdnNPPuaXd0xV
         XvgtyqU0hvVX8fxRms5SkdtJOiVSEjf0XkGmPjwbHZQv0k5onB0Eo+Xytdl2v6+bNN
         X7lO3S0lKKl/Q==
Date:   Thu, 15 Dec 2022 13:07:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: switchtec: Remove useless assignments in
 switchtec_dev_read()
Message-ID: <20221215190749.GA132793@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a72082-94ec-4011-1e54-3b278317a44e@deltatee.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 15, 2022 at 11:34:06AM -0700, Logan Gunthorpe wrote:
> On 2022-12-15 11:21, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Some switchtec_dev_read() error cases assign to "rc", then branch to "out".
> > But the code at "out" never uses "rc".  Drop the useless assignments.  No
> > functional change intended.
> 
> Ah, hmm, yes. I think if copy_to_user() fails, the function should
> probably return -EFAULT. So perhaps an unlock and specific return as is
> done in previous conditions in the same function?

Sure, I'll post a v2 that does that.
