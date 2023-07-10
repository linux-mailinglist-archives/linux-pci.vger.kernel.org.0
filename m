Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD56374D1A9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jul 2023 11:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjGJJfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 05:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjGJJeV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 05:34:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE1319BD;
        Mon, 10 Jul 2023 02:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E5D60F08;
        Mon, 10 Jul 2023 09:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CDDC433C9;
        Mon, 10 Jul 2023 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688981608;
        bh=FW512bUwkwbM2sy7ptkYcIAJbw1Ta8o+HZebnXCuO88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=He4q2bK6D80vP+DQ/jaf1J+NOI/0R6OPlkwZ3y5E95rFHLYWZ9awDrai2qkjExRyd
         gJfQGaMaju4ILkuRuF/q6RFu81lAy9sg6tqbvE9yZBdf6lAezqwscANAkLYKT5wAhL
         Q0XjEBW70dHodiRkJCViA/Nfa64qOv3R/WopbvRh/85wr3Y4OP2wa+TKq/l6JlFAng
         yhCReC2ixa98lw64Aph+DrCtVigLbNavv95aXKklejb6LJ1PsRrqiMcwCX/XFnV1LX
         KXW6+OqOVpDcgqnR4ruXx3AfmoUvYw/2Gqrtx9oy9impncy7iK+AGFa0C4lfwpHtcO
         Tv32nRhmEXfuw==
Date:   Mon, 10 Jul 2023 10:33:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        loongson-kernel@lists.loongnix.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v5] PCI: Align pci memory space base address with page
 size
Message-ID: <20230710093323.GB32673@willie-the-truck>
References: <20230619014715.3792883-1-maobibo@loongson.cn>
 <f676d9e0-bb88-283a-5189-f1ae945ee4dd@loongson.cn>
 <bdc6eb71-482d-5dd6-d527-c2f2f68dfb38@loongson.cn>
 <CAAhV-H7_Rjv-ySorjbw0f4OiV4J0-N75fmUNBCmeJbeeydJu4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7_Rjv-ySorjbw0f4OiV4J0-N75fmUNBCmeJbeeydJu4Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 09, 2023 at 05:19:57PM +0800, Huacai Chen wrote:
> On Fri, Jul 7, 2023 at 10:47 AM bibo mao <maobibo@loongson.cn> wrote:
> >
> > Bjourn, Hucai,
> >
> > ping again.
> >
> > The is such issue on only LoongArch system since 16K page size is used.
> >
> > Should we add code in general framework  or in LoongArch specified code
> > in v1?
> Though I still don't know why others have no problems. But it is
> surely a bug on LoongArch. So if Bjorn has no objections, please use
> the old method (just like v1 but you can simply align to page size
> unconditionally).

The initial assertion is that this is a problem for any architecture with
a page-size > 4K, so there's nothing LoongArch-specific about that on paper.

More likely, we've only just come out of the merge window so I suggest a
little patience is probably all that is needed.

Will
