Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4564455D296
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiF0XTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbiF0XSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 19:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093D20BD0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 16:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCB596155E
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 23:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02FCC34115;
        Mon, 27 Jun 2022 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656371892;
        bh=rfQeRLN9z1o923FUl9dNISqlTth88b4HeA/7YNV6gyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kg68D/TcUqGOde/5iF8VLMXjQb5uU+v5M8gaXzd3rh7sndPGEoRdHHjgWSxRqyLUL
         Ev6tw+R5xX+yDtsSRWT7XDOXf0ZKWBjpZF+ebfa+YVglIeNxhbaiDaaPnJal8FEjKu
         jJbD8Op1VvIU4V096a9r9ELIbHlZfjd3/R3Y2BWtCvhEOiOtP1H3EyVACyB/BCoVdB
         DXvpwTj75DFZoQJFQLzgCEsZFHesPo3KpPqf2Vmc/n0K/LtZ/0BjrFuoQPKvz6TRr9
         DBLJS8lqS5IFnyhW7YRklIHq+PgHu+3wSK0nctZ9qbTYyPDvhppOat2c2QOs3fUcIY
         nruCj6soZCy/Q==
Date:   Mon, 27 Jun 2022 18:18:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Message-ID: <20220627231810.GA1790539@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621233257.GA1342369@bhelgaas>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 06:32:59PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2022 at 02:59:02PM -0400, Jim Quinlan wrote:
> > ...
> 
> > The original patchset was and is controversial, as it is basically a
> > square peg that does not fit nicely into a round Linux hole. It took
> > 11 versions of following reviewers' suggestions until it was
> > accepted.  And now it has been reverted, I am wondering if it will
> > ever be let in again or whether I should even try.
> 
> The original patchset [1] may have been controversial, but that's not
> the issue here.  The only thing we need to solve here is to post the
> four patches I reverted with a tiny change to one of them to avoid the
> regression.  I don't think that should be a problem.

I'll be on vacation until July 7 or 8.  Just a heads-up so you know
it's not that I'm ignoring anything you may post in the meantime.

Bjorn

> [1] https://lore.kernel.org/r/20220106160332.2143-1-jim2101024@gmail.com
