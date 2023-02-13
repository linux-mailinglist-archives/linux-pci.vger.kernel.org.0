Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E681695090
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjBMTYL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 14:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBMTYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 14:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83DD20069;
        Mon, 13 Feb 2023 11:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C78B6128D;
        Mon, 13 Feb 2023 19:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E535EC433D2;
        Mon, 13 Feb 2023 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676316239;
        bh=CTSdoKNWKzxTWibhjYR8Qm7nmbkyRBxtlTLLuU1/FFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pa1RVCe3GAt898JqU32CzMCwYqHhf1d10eRmGfBfJeq3gqxchYweQo2CMC0o0dtMP
         hgEw4nae9wWqGH6ylurzbyfnly7TLBtJ9a+ttl2+bqKsAQd0AarDsaoXgfbqT3f+Q8
         jdxh2LTeaOGkRCvXAHqBBNG66etha5szFJlWBj7Uxok2l72hsYNke3HQ2MGcytCcjm
         Axe8GY+dF1B1cGxnQtz8qSgjujARGYZ0jxKNEkpADo9zrjVfLWyRC4Hb2RqXH4Wt2h
         aXTOhc48WPSA9CcKRz9+9n3q8JBsWx5l8BmSBmIq+UsEwcB+RqZHFHlRcVH+1OQjYl
         ozC4JJ9JI/xXg==
Date:   Mon, 13 Feb 2023 21:23:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Conor Dooley <conor@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
Message-ID: <Y+qOS9fx9B3Y3gd6@unreal>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
 <20230210164749.368998-9-nick.alcock@oracle.com>
 <Y+aMh5e9bWaTphiZ@spud>
 <871qmx1fv5.fsf@esperi.org.uk>
 <Y+akw9VBjg9oZ7QV@spud>
 <Y+kx3fb2Lzlg+u5+@unreal>
 <87ilg5mq0r.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilg5mq0r.fsf@meer.lwn.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 13, 2023 at 10:30:44AM -0700, Jonathan Corbet wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> > It looks odd to me too. Please add SPDX tag in modules which don't have
> > it already, instead of commenting code.
> 
> So I'm just a bystander here and should probably be ignored, but ...
> 
> From what I can see, Nick is attempting one of those cross-tree cleanups
> that's painful enough to do on its own.  This request is asking him to
> perform a different, unrelated, and potentially fraught cleanup that the
> maintainers of the code in question have not yet managed to get around
> to taking care of.  This will impede an already prolonged process and,
> IMO, unnecessarily so.
> 
> Wouldn't it be better to let this work proceed while making a note
> of the files still needing SPDX tags?

Please see a note from Nick, who said that these tags were already
in-place for most of the files. If it is hard for him, he can skip
adding new tags. However, the proposed solution is to comment code
and leave dead code is not a right solution.

Thanks

> 
> I'll shut up now :)
> 
> Thanks,
> 
> jon
