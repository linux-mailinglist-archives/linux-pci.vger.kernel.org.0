Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE1787934
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 22:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238291AbjHXUVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 16:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbjHXUVU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 16:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C85CE4B;
        Thu, 24 Aug 2023 13:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B9C633EC;
        Thu, 24 Aug 2023 20:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319D6C433C8;
        Thu, 24 Aug 2023 20:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692908477;
        bh=za/xL155tqWhW8dbTQ7zHNUpiREm/tC/+Iht7Gfd5YI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AC3keX6QZ31lZVgtxJmOILROvNpEFoLxAgX1oDaeYbYPN5aNUnUNoAMVJm9se0Lnc
         JMh3WE5fDgZPnQaAdf8bjsFAr3h4AXfdxWzlZn9LhJCe16TJlGY7EahnSKoZ8deDD4
         J/7COWcEpegJrolQELqXrUwaaOJPOkGojSiHq8rA5F0mFwKAJ3m/AR0zM4SxCUXbCM
         E9RsyYss0Ax8bDSfiNv48K8b4xQTH4amtydLWaCUwx3YGPfvEA1V9m3e66zD5hC/ka
         YbX6cQR0KaBuBIbsacGjd2a3c8LUy2uzNQMQrEFkjgMzcjjhl1m1W1KImqPB4c3s3F
         ljQCCCrgmx31Q==
Date:   Thu, 24 Aug 2023 15:21:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 01/12] PCI: mvebu: Remove unused struct mvebu_pcie.busn
Message-ID: <20230824202115.GA543888@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824193913.fp7njruq6zl3pg4d@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 09:39:13PM +0200, Pali Rohár wrote:
> Duplicate of https://lore.kernel.org/linux-pci/20220905192310.22786-5-pali@kernel.org/ ?

Thank you!  Updated with you as author.

> On Thursday 24 August 2023 14:37:01 Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The busn member of struct mvebu_pcie is unused, so drop it.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Cc: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index c931b1b07b1d..60810a1fbfb7 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -87,7 +87,6 @@ struct mvebu_pcie {
> >  	struct resource io;
> >  	struct resource realio;
> >  	struct resource mem;
> > -	struct resource busn;
> >  	int nports;
> >  };
> >  
> > -- 
> > 2.34.1
> > 
