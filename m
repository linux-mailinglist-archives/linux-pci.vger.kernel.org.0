Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830160517B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiJSUok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 16:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJSUoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 16:44:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D24E85B;
        Wed, 19 Oct 2022 13:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 594F2B825C4;
        Wed, 19 Oct 2022 20:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA67C433C1;
        Wed, 19 Oct 2022 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666212272;
        bh=fvYNmDqCOieJ8nOUJEhfhHcZIbATPwHVmIM+LNqE1XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLXab2SmFeTYCWldDosUjs0PV32VfBTpACxzJsYuwmwUwOiThZdSKaH51x36+bbv+
         ViatfcMcUMfnrqD9YDjdE+6IlvMj44TAHuafmypxZj2BvMlE++Xx82fa9zIf5o/zhj
         /xzU5CEnm7l0sSOnFA2R4d4fyaM8runMHxmfJd8AZbNKYA4X/tS5Tro1mrRIFe8cW7
         6z/gfe1UNGuVTbtyyoyqKwEJFCGxia5YNknPgk/8zA94hDu+xXJR9HB2eH1XsFISd2
         mfzp2bEdd/4M60hteSFcai70WIJM7+ZVULv0AY3k1dFhsl65PHhjBNbtMge28/gIAt
         rZrwghTz7s+nA==
Date:   Wed, 19 Oct 2022 14:44:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] PCI/portdrv: Squash into portdrv.c
Message-ID: <Y1BhrGziw+cet9Fm@kbusch-mbp.dhcp.thefacebook.com>
References: <20221019204127.44463-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019204127.44463-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 03:41:24PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The PCIe portdrv is split across portdrv_core.c and portdrv_pci.c, but
> neither is very big and it's a hassle to figure out which to look at.
> 
> Squash them into a single portdrv.c file.  Make functions static and
> non-exported when possible, and move some private things out of portdrv.h.

Looks like a nice cleanup.

Reviewed-by: Keith Busch <kbusch@kernel.org>
