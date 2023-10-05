Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBE7BA9A7
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJETAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJETAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 15:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFB90
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 12:00:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1876C433C7;
        Thu,  5 Oct 2023 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696532442;
        bh=BfwEFJO9Cp+Qg3RT5JBj0Ho1WDLu0QrRBMr1npPITHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Tx91dsAN+jAj1c964JGg6+BB2bZylJrLCtI+G7yZUKTvm5+qGoHLi7chuz2pKWFCE
         HK4RORPZWgEK9IlvNYoVxMN0i4Y0gYP0TEdCNAXCzOOyYVo2COkrGaBXv0LXwuVQHI
         un1Yz/wBm4ZFgm/d9zpNCLQZmHuqwSfq/ZNdeLwHdh4s8AG2q+Xm4NzaASRY2yrlPO
         SNAEsygpRHdoB2qnNB1mbGNrpaM7XJFBcbEEc/ohTbcQ5kZIi9fOQxJKsS8Ku4P/8k
         tb8Brr9vVi4/iAFSSf4zArTeAtiIf0WI/XmaX8nKzVdyrZCGE0Nn6W4S7SXctvpJPd
         Sj6PPz2rq1PiQ==
Date:   Thu, 5 Oct 2023 14:00:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kamil Paral <kparal@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
Message-ID: <20231005190040.GA786747@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+cBOTdOVnzbXXPhWhWHDs8=n3A1ixcEg6aDVxjCdsneXySdSA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 05, 2023 at 03:01:56PM +0200, Kamil Paral wrote:
> On Thu, Sep 28, 2023 at 5:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Do we know how suspend/resume works with Windows in this
> > configuration?
> 
> Hello Bjorn. I'm not sure if you're asking in general or about my
> laptop in particular. I don't have Windows installed, so I don't have
> an easy way to test this. There used to be some "evaluation" version
> of Windows that I think I could use to test it, but it would be a
> considerable time investment for me (including backing up my data,
> etc), and I'm currently low on spare time. So at this moment I'm
> unfortunately unable to help with this question.

That's fair, thanks!

Bjorn
