Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855E576D87
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiGPLfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 07:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiGPLfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 07:35:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC4C20F41;
        Sat, 16 Jul 2022 04:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A03660C73;
        Sat, 16 Jul 2022 11:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC54C34115;
        Sat, 16 Jul 2022 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657971310;
        bh=1Nv+mrJbMC45A/7YReRl2eFPsTnci26We2C7a/b5Mzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJe1fSMV5+cEBdR7OMYrY9fZdu/PpceJZ5o5CTouutuwbhIwfjx/GsNWZV9Q/F823
         jXarhqth2tqCOg1ix2FLIYe8Xa4QtKzP3nsiFUHot2EgtLts/UpJ+KxGSy+GK1nbMh
         tDMGNI/9q9c7wsR8kw97fKwDrYVc9+I4ljxXII15hZAm05ARyR1szRaPKiMee+19hy
         GNbt8w79Oj3n6XiuW4Z/RUg5UI3JWCKINCdPAvzGjGPLF/yzQXk2jf1efl3jBGCCSD
         sc50r8NcGNPjzFF760LL0fG+C6/lGvXTiUpjM9GYFwKw0UsfTUC9jaPA0qz30TFiTy
         frli5dg1lr9lA==
Received: by pali.im (Postfix)
        id 4079EA52; Sat, 16 Jul 2022 13:35:07 +0200 (CEST)
Date:   Sat, 16 Jul 2022 13:35:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: Add config option for using OF 'reg'
 for PCI domain
Message-ID: <20220716113507.c6loaltpuaj4hrs5@pali>
References: <20220706102148.5060-1-pali@kernel.org>
 <17fb8d12-60f9-09d5-91fa-09d5a5a9a4fd@igalia.com>
 <20220715171132.ujaexzm4ipad7o4f@pali>
 <15432ee0-3a33-0b53-b39b-f8b53a7e4345@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15432ee0-3a33-0b53-b39b-f8b53a7e4345@igalia.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 15 July 2022 15:32:56 Guilherme G. Piccoli wrote:
> On 15/07/2022 14:11, Pali Rohár wrote:
> > [...]
> >>
> >> I found this sentence a bit weird, "in the similar way like it is doing
> >> kernel for other architectures", but other than that:
> > 
> > If you have some idea how to improve commit description, let me know and
> > I can change it.
> > 
> 
> Oh, for example: "in similar way the kernel is doing for other
> architectures". The sentence idea is perfectly fine, it's just that it's
> a bit oddly constructed IMHO heh
> 
> Cheers!

Ou, sorry. English is not my first nor second language.

Michael, should I resend this patch series with Guilherme's suggestion
for changing working in commit description? Or will you adjust it
manually?
