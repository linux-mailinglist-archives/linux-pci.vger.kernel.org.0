Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC45598508
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 16:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245396AbiHRN5S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245432AbiHRN44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C4B6D19
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 06:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ACCA616F7
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCA0C433D6;
        Thu, 18 Aug 2022 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660831013;
        bh=zgFqMD/ASKvLETT7R9/2/Q2gk95wrqDfvKiNO3H+dZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNtZBaK6yDi5Y4hQr+sdB2ir6Zp4mN5Kvkyck4Quqlfbp2XOryap+IqLE3z2HrnNz
         ovs7l8h79urvbVW1fbCRZeadhc6D4QMg33CFfki0u7vox1aP/b3il9evW/zwj8+Ce4
         UGYU4oEOl2MgP2jQ14ehnx3G1TFpATElGLx9YnJsUwbOSm2FzBiQi0zwMIzbrx+acs
         FtoOiS2PWTdibTJmkfQ/42rcLmNkHYsdzVGa/xdT6xjQvqREjmT2HF3mdn0Ayz+pfi
         cT36udsJqUxxL91Lg6fCGHA4aK762vmz3VN/UKyS13bB7EMpZCZ/j5Gw5XSwDg+A/a
         KzodOSflWti7g==
Date:   Thu, 18 Aug 2022 15:56:49 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 00/18] PCI: aardvark controller changes BATCH 5
Message-ID: <20220818155649.647594e2@dellmb>
In-Reply-To: <YvvFDGpcEz8E4SpA@lpieralisi>
References: <20220220193346.23789-1-kabel@kernel.org>
        <YvvFDGpcEz8E4SpA@lpieralisi>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Aug 2022 18:25:48 +0200
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:

> Hi Marek,
> 
> back from a hiatus, just catching up with threads. According to
> patchwork patches {8,14,16} of this series are still to be
> reviewed; may I ask you please an update on the status and we
> will take it from there.

Sent batch 6 :)
