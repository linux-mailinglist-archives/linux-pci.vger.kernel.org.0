Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A070FBFC
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEXQyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXQyQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 12:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38603BB
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 09:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDDAF6157D
        for <linux-pci@vger.kernel.org>; Wed, 24 May 2023 16:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D74C433EF;
        Wed, 24 May 2023 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684947254;
        bh=YSSilSZtLJBHggM01vQoVJdWZJDgvRW8tNp6gkd3IK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BOiRrIEwMYHm3seP/91hQnub7a1dd9HpwvJOCbdJUvsjuOM873usMTT4+uo+BwFJP
         +yvHoHSzSFVbfk/8VVoew637VXpG7ZxmNWfGI6YUiLE+Pb6HfKIBInapbiGCdZ9R3J
         ZQn5RxoTIvkQG0vVdM6nvCyG/S0ZKtt8Psl4NJK/bqGVaXGpFvH55Wa485hkQYO0h7
         jFLSA+1EAOvaGcRJBpPj45u5UxNOI/DVJcSofFimbhYS2YJzsuobZ+AevPLuOO6ixL
         WQ1oLawA/T5ERxm3WgoSLb+M3jtQV+A3Q5cohxvQ+CqHeJBQdlZPsIc44VjPfV7zpk
         z6zTTUa2AbHdg==
Date:   Wed, 24 May 2023 11:54:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Rongguang Wei <clementwei90@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: pciehp: Simplify Attention Button logging
Message-ID: <ZG5BNPlkacyGgWG6@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524100823.GA23020@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 12:08:23PM +0200, Lukas Wunner wrote:
> On Tue, May 23, 2023 at 10:40:39AM -0500, Bjorn Helgaas wrote:
> > I was trying to make it OFF/ON case parallel to the BLINKING case that
> > only has one ctrl_info(), but I think that makes it a little harder to
> > read in addition to being less efficient.
> > 
> > And the language is definitely confusing.   How about this?
> 
> Perfect, feel free to add my
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> 
> to commit 6d433b9ddfda on pci/hotplug.

Thanks, added!
