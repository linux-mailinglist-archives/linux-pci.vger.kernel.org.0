Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2358D1E4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiHICKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Aug 2022 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiHICHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2022 22:07:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312341A393;
        Mon,  8 Aug 2022 19:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE4BEB80E0F;
        Tue,  9 Aug 2022 02:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7402EC433D6;
        Tue,  9 Aug 2022 02:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660010856;
        bh=8D00+znaxtmslp8WGIL8uG4PgO8P1iCMgzUX8+8KU6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L2LyQUVychSP8SLJFxKTvz/Ys/7tVqVtZWFVZ8nZie+B5YwIDTRbda8bzqDyCnv/G
         sVbKqfr0EsJyMmkM5hAjUooHdyaxqzKSpeiYDbudFpBGFOzF531tW1ki6KBtn3f/7m
         5Tt8Nchd2is8JPlI56Pi6MsgC1yKmZrj7zD8fNcSD8Ky3/Qy+n0oqiRI5uZo34J6bT
         gxVXV9QbSgTFW1kwr+46R/QA6KAj74VYAik2r20DH9auAingou6wH9aNeUb09F8ZaO
         CaZPPfMQOV4JM+9ACRO3eiqjCXIrHOwMVIYqiRIPUX3yeRgt0Wmy+h/bKyeo4cRVk5
         LV4ByMYPyQmPA==
Date:   Mon, 8 Aug 2022 21:07:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 27/32] PCI/P2PDMA: Convert to printbuf
Message-ID: <20220809020734.GA1260912@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b92761a-c166-b84f-8d77-a966d4c0ef9a@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 08, 2022 at 02:42:03PM -0400, Kent Overstreet wrote:
> On 8/8/22 13:51, Bjorn Helgaas wrote:
> > I don't object to the patch, but it would be nice if the commit log
> > hinted at what the advantage is.  I assume it's faster/safer/better in
> > some way, but I have no idea what.
> 
> Printbufs have some additional features over seq_buf but they're not used
> here. The main one you might be interested in is heap allocation: that means
> no need to statically allocate buffers on the stack and no need to calculate
> the buffer size, printbufs will reallocate as necessary.

This doesn't tell me what the advantage of this patch is, since I
don't think *this* patch uses heap allocation.

As far as I can tell, this particular patch doesn't improve safety or
readability, so "convert X to Y even though we don't use any fancy Y
features" is a pointless message.

But if printbufs are better than seq_buf overall, and converting this
gets us closer to the goal of removing seq_buf completely, that's a
perfectly acceptable reason.  Just say that.

> I generally haven't been converting code to use that unless it's obvious
> that we're in a context where it's safe to allocate memory and can deal with
> allocation failures.
> 
> I notice that in calc_map_type_and_dist() you're using xa_store() which can
> fail, but you're not checking for that or returning errors properly :)
> perhaps a fix for that could also switch to using printbuf in
> heap-allocation mode.
> 
> > Also, cpu_show_meltdown() doesn't appear in this patch, so maybe
> > that's relevant to some other patch but not this one?
> 
> Whoops, was copying the commit message from another patch, yeah.n
