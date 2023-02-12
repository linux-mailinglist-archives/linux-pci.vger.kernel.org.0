Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E9693965
	for <lists+linux-pci@lfdr.de>; Sun, 12 Feb 2023 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBLSh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 13:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLSh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 13:37:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B21026F;
        Sun, 12 Feb 2023 10:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1CE9B80D31;
        Sun, 12 Feb 2023 18:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC042C433EF;
        Sun, 12 Feb 2023 18:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676227042;
        bh=lZKQIEO7UGeivhn0TxcsgdRpjPn0tConcYHrlR26cWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMGMzKRRXBU+ePfdud7KxhsZKGxgA3FMJMpTsOl2bCpWU9WXIaszBciS/mAKBWzmt
         pFk40VxZzRjpRKEDwB7JRf05dGe8/z5/QKxKI6t/6DShauKCSQ6i/uUH4nxWKrcWBi
         inrFk4G1EAHmkx+AQ2CkyBRwr3RVhWChB2ggbkWJNRgsFRgvTOL+RKXkW+mPCRqHjQ
         ATuke1lgxtUp9dE+3u0ySSJ6E7z12SBSNWiTfESMeYQ7uiv7i0v5QJPCXfqAyAyGzy
         V2tQzd+WYXOY3G+XanuoZ8par1ufewgtcBo8qKmBOW2F/kPvF4f2pjfclUpvloNjuA
         SdICanzCUxcdQ==
Date:   Sun, 12 Feb 2023 20:37:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Conor Dooley <conor@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
Message-ID: <Y+kx3fb2Lzlg+u5+@unreal>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
 <20230210164749.368998-9-nick.alcock@oracle.com>
 <Y+aMh5e9bWaTphiZ@spud>
 <871qmx1fv5.fsf@esperi.org.uk>
 <Y+akw9VBjg9oZ7QV@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+akw9VBjg9oZ7QV@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 08:10:43PM +0000, Conor Dooley wrote:
> On Fri, Feb 10, 2023 at 07:26:38PM +0000, Nick Alcock wrote:
> > On 10 Feb 2023, Conor Dooley said:
> > > FYI $subject seems wrong, this is a PCI patch AFAICT.

<...>

> > kbuild is present in every patch in the series because this is a
> > kbuild-driven change (the thing it disturbs is part of the build system,
> > the construction of modules.builtin*). This seems to be common practice
> > for kbuild-related treewide changes.
> 
> Okay, I'll take your word for it. It just looked/looks odd to me!

It looks odd to me too. Please add SPDX tag in modules which don't have
it already, instead of commenting code.

Thanks
