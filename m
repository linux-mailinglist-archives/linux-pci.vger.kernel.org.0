Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D5667976
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbjALPhm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 10:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjALPg5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 10:36:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6916B3DBEA;
        Thu, 12 Jan 2023 07:27:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D266206B;
        Thu, 12 Jan 2023 15:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55010C433D2;
        Thu, 12 Jan 2023 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673537256;
        bh=fS1kwoEtuWcLTAyzGfZlawQt98T9uK8H6KyRyWZYtJs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BXqyGcgh6guKnPATECXsTYXgep4B3lulg8Ygtgcpb5TDnNlo0nlOsCQ1DZE4n6Fsb
         lYy1WsuvlEHVDRrs5b3NabZrCKnLz5NstTgicgG9U+Q6OvuSJgU6O9t9ZFVLXBfZSX
         tvZ3NoK/IH6eVhBw/R7L0pal2wZK7lvAskYuWRKY5whd8oNw09PpJSuQOImtCPSLDA
         mmxZMh2YD3Iw3jXODisI47wRLEzXTi/pGhSK7NT1v2Pzn6LPQWOIbUmbFGs61drlG8
         LHXgP6SD8DLFKgQwydNvLc4RJmlETXsaWOi6fCqF8MLFivXEGMBkgkmEY59pE4vr1O
         nCY6eM7IoL67w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F18375C0AF8; Thu, 12 Jan 2023 07:27:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 07:27:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH rcu 17/27] drivers/pci/controller: Remove "select SRCU"
Message-ID: <20230112152735.GK4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-17-paulmck@kernel.org>
 <Y8AbHEzbVv4ebeXU@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8AbHEzbVv4ebeXU@lpieralisi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 03:37:16PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Jan 04, 2023 at 04:38:03PM -0800, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Krzysztof Wilczyński" <kw@linux.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: <linux-pci@vger.kernel.org>
> > ---
> >  drivers/pci/controller/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> I assume I don't have to pick this up and it will go via
> a separate route upstream, if I am wrong please let me know.

Thank you!

I will apply your ack on my next rebase and send it along into the
upcoming merge window.  If you later decide that you would like to take
it, just let me know, either way works for me.

							Thanx, Paul

> Thanks,
> Lorenzo
> 
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 1569d9a3ada0b..b09cdc59bfd02 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -258,7 +258,7 @@ config PCIE_MEDIATEK_GEN3
> >  	  MediaTek SoCs.
> >  
> >  config VMD
> > -	depends on PCI_MSI && X86_64 && SRCU && !UML
> > +	depends on PCI_MSI && X86_64 && !UML
> >  	tristate "Intel Volume Management Device Driver"
> >  	help
> >  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
