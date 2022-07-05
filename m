Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46250567A11
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiGEWYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 18:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiGEWYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 18:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527513FB6;
        Tue,  5 Jul 2022 15:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06EE861D1B;
        Tue,  5 Jul 2022 22:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27042C341C7;
        Tue,  5 Jul 2022 22:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657059891;
        bh=E1GkFej3+KkSjxyvqG8okUzlbNvB0kZb9mgGz7YplOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Y0YWpwdO1qqCSgHVXYzVyPzmRepdrib0XpQqrpvnlk2Q/1ZmwzEQDS1l3JejLLrnU
         4sSZ6IZRoV4p/Jw5nXKTtkFYNZNnGEqckWDKA9yTwRhoGBXrbxEG9hGCkbb0403+q/
         Ur364iRrxRyxvqg4ZJoEo09AstNUE4lccs+V0XAmdPCPsoEqQ13RRTqjaQMtodyKKb
         Gz1uY4FNNP91V2pB0dD6BQm/64rAXOC1LxAqvAo+zzPz9B92qrFs8nUw/TKzEpwRRb
         3voRnJdKOBNeG7Tvyqqe1SAJEO8OexA8gL0t3BHu2ZfMgsHzXRLvF8UkVfu6pL2YBs
         DjacL9AIb9i5g==
Date:   Tue, 5 Jul 2022 17:24:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
Subject: Re: [PATCH v6 12/12] Documentation: PCI: convert
 endpoint/pci-test-howto.txt to reST
Message-ID: <20220705222449.GA91632@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514144734.19760-13-changbin.du@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 14, 2019 at 10:47:34PM +0800, Changbin Du wrote:
> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> --- a/Documentation/PCI/endpoint/pci-test-howto.txt
> +++ b/Documentation/PCI/endpoint/pci-test-howto.rst

> -1.4 Configuring pci-epf-test Device
> +
> +Configuring pci-epf-test Device
> +-------------------------------

This removed the "1.4" anchor for a subsequent reference:

> +Note that the devices listed here correspond to the value populated in 1.4
> +above::
>  
>  	00:00.0 PCI bridge: Texas Instruments Device 8888 (rev 01)
>  	01:00.0 Unassigned class [ff00]: Texas Instruments Device b500

The text still contains "populated in 1.4 above", but "1.4" doesn't
exist anymore, so it doesn't point to anything.

I don't know the right way to make that reference in reST, but maybe
you do?

Bjorn
