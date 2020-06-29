Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C750420E91B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 01:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgF2XLN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 19:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgF2XLM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2020 19:11:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081CC061755;
        Mon, 29 Jun 2020 16:11:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so4588315ejx.0;
        Mon, 29 Jun 2020 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyzXXw5rhPzXDzk87PHT4MSvXN0tYVX6d5yDjfIvSWw=;
        b=g9QBDw/5I3cm62saB5Rv1ReXEd57CmvhsgUFDyGJC1G9KOE+qOMvDPGzYK0mNBfIb1
         rJ2ifdAAohVS/9OGMxbmT2jaU2XZXfCfTPdpVWCXk52iccN8bydi69Q2ieGNSoKHlBJT
         i5MPHRBc4GF9Tm+7PMrSyGDihpKAUlQab2ChzOMoOB/9vGhVmf/9vsv0/YRFeVm6fN11
         jCu+ozA8+ZlyoLJO9M2tctS3KgT67Jjag9lZzNDhyZwnilwvdnbSqe2Hs2raf+YDqkcf
         dfVnQAJxgtLbJOyd5+sKgU+0fD/VtJIJSBlxTrhMtwbCeY4DcwNRv4QgWxwWhmS0w2HT
         yH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyzXXw5rhPzXDzk87PHT4MSvXN0tYVX6d5yDjfIvSWw=;
        b=Rm3BT9wWD9XQAwCGCN4qw5P3PNfSziFmfd4gv8FwAgw12VSoWIKLA8M+0zc5WIf0gL
         g+fXsWZI6uiJ9GYNbyFz93yyRsgjphCXiNYnzWM4t1oyObQkMgpOddalzCLFwvyXZDAl
         8dUaRPMjgDZTNd33HYm7b5MGCNyL2tsIGZPoIUAfGsWRrNeaGPglinaPkeTMMewOhj2+
         w5M3n30yRgCp2AdsuEbvR2MvE4oXneiyCZKoJi04B4gP54+DYKXCoUZS48pr4G/kCV0H
         /Zrd5qydCgqsTC5narZLF8//lQH1voZEc5AEXfWFjBkR5ypE+eVEc46JY7Cz1UuwU1d9
         JssQ==
X-Gm-Message-State: AOAM532OQ0T8K2A2PNJRY6f+xMW0JboXRNx3QBct915DUN00PrB/L4sS
        ItPw0grubFh6Ou28Id9YxOc=
X-Google-Smtp-Source: ABdhPJw9/ZehljeUhKBFdyzt45t+rg5pj4fSwo8OI4pal/Z0ajYpGu/4863flF8Husdgc64U5yxhAA==
X-Received: by 2002:a17:906:f752:: with SMTP id jp18mr15783772ejb.538.1593472271409;
        Mon, 29 Jun 2020 16:11:11 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:4c8a:c17d:ea37:16f])
        by smtp.gmail.com with ESMTPSA id gr15sm620939ejb.84.2020.06.29.16.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:11:10 -0700 (PDT)
Date:   Tue, 30 Jun 2020 01:11:09 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: consolidate typing of
 pci_error_handlers::error_detected()
Message-ID: <20200629231109.n7lrmrtn2cj75sb6@ltop.local>
References: <20200628161233.73079-1-luc.vanoostenryck@gmail.com>
 <20200629212928.GA3296753@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629212928.GA3296753@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 04:29:28PM -0500, Bjorn Helgaas wrote:
> On Sun, Jun 28, 2020 at 06:12:33PM +0200, Luc Van Oostenryck wrote:
> > The method struct pci_error_handlers::error_detected() is defined and
> > documented as taking an 'enum pci_channel_state' for the second
> > argument but most drivers use 'pci_channel_state_t' instead.
> > This 'pci_channel_state_t' is not a typedef for the enum but a typedef
> > for a bitwise type in order to have better/stricter typechecking.
> > 
> > So, consolidate everything by using the restricted type in the
> > method's definition, in the documentation and in the drivers not
> > using 'pci_channel_state_t'.
> 
>   $ git grep "\<pci_channel_state\>"
>   Documentation/PCI/pci-error-recovery.rst:	enum pci_channel_state {
>   Documentation/PCI/pci-error-recovery.rst:pci_channel_state value of pci_channel_io_perm_failure.
>   arch/powerpc/kernel/eeh_driver.c:static void eeh_set_channel_state(struct eeh_pe *root, enum pci_channel_state s)
>   drivers/net/ethernet/intel/ice/ice_main.c:ice_pci_err_detected(struct pci_dev *pdev, enum pci_channel_state err)
>   drivers/pci/pci.h:			enum pci_channel_state state,
>   drivers/pci/pcie/err.c:				 enum pci_channel_state state,
>   drivers/pci/pcie/err.c:			enum pci_channel_state state,
> 
> Should these be changed as well?  If not, why not?  Some of them look
> analogous to the ones changed below.

Oh yes, surely. This is in fact a resend of an old patch (Dec 2018)
and it seems that these are more recent. I'll check, update and send
a new version.

-- Luc
