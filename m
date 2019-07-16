Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8856A10B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 05:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfGPD5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 23:57:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46718 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730768AbfGPD5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 23:57:04 -0400
Received: by mail-io1-f68.google.com with SMTP id i10so37633817iol.13;
        Mon, 15 Jul 2019 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KfHcdPCgcEDLfMOsc7KFNQOiRRZxPYLWWE+31IqsWlU=;
        b=GamSHQ8faAdJqVlUbMk2L9gAsB9lZNBqn+5PH32Tpds8Inkz3EQUCUiM7EkHOICseb
         CuwrwNdmNn/XOClYmmWMLWTHVMLN6UURZlzSunyZLp21yBcGSWd/wYhvpsoDrjbZR6xe
         C+cz36TucSlpDyKAGWYYekLkikHXK7O3NEwRpSkQxKHNcZL3W3RABLo6c/UR1dB2+3Va
         8jbqo9aJMATHNnDIxq5UxAAx7HSsYZ1YWpD5/LEnFBOxs7Q0C59FwcR3hzfJrrg/2UZ2
         nQVgcnSUK1d/Ln8lsi0m6FfivcaNzxM4M0hHOFHhBNw2CgCHXOJuJyuITRCu2xcE3HSD
         yGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfHcdPCgcEDLfMOsc7KFNQOiRRZxPYLWWE+31IqsWlU=;
        b=mli9Acj90Y1ximtL3ioAFgjU5Na1wwOoAqSIvvzw20QFQ/iW4jRSg3NL1RTceCCXGG
         pRN6/agXdJzaIMWN/MFKduuZHmXYB3M7XeknlhyipA9U8VAaJ6/TyTltUOTsj10+vMau
         C01qDmJb8T0yFin2/FsGLslaGmx3pPhd+bdTBkYDz439i53g8p9oe5Lo98EO0YgKjejh
         k71guTgNfIm/GS6kAmMVFo+0ftLV6RlTaHWzZkwTtPa5DMAHJaDECACfMBUJoZ1BQCQ+
         7E8q2TPcanT8IQYRNnqbXQ8Kv4xpikgPxrY2qZr8otljH1MdTgCiTsaR+B46QkteyZvb
         n6NQ==
X-Gm-Message-State: APjAAAXOib9tITen7OzLlXLz5wgpL9mlbhbrS5fxaXn+uRn/+20YnxPw
        PqyNULWvBVkxCklsB9VNfPGpt8Q92OlEfQ==
X-Google-Smtp-Source: APXvYqxmWSq+CgE32z1rA0icy9ZQgYc3idHmSlll/V2xDdKOh5rO34A4ZNPgFU2n0jfKuXodpdmjFQ==
X-Received: by 2002:a02:ce52:: with SMTP id y18mr30792143jar.78.1563249423027;
        Mon, 15 Jul 2019 20:57:03 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id z19sm23935469ioh.12.2019.07.15.20.57.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 20:57:02 -0700 (PDT)
Date:   Mon, 15 Jul 2019 21:57:01 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] PCI: Remove functions not
 called in include/linux/pci.h
Message-ID: <20190716035701.GA57724@JATN>
References: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
 <20190715181312.31403-1-skunberg.kelsey@gmail.com>
 <alpine.DEB.2.21.1907152138120.2564@felia>
 <20190715233717.GA79424@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715233717.GA79424@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 15, 2019 at 06:37:17PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 15, 2019 at 09:42:47PM +0200, Lukas Bulwahn wrote:
> > On Mon, 15 Jul 2019, Kelsey Skunberg wrote:
> > 
> > > Remove the following uncalled functions from include/linux/pci.h:
> > > 
> > >         pci_block_cfg_access()
> > >         pci_block_cfg_access_in_atomic()
> > >         pci_unblock_cfg_access()
> > > 
> > > Functions were added in patch fb51ccbf217c "PCI: Rework config space
> > > blocking services", ...
> 
> > Also note that commits are referred to with this format:
> > 
> > commit <12-character sha prefix> ("<commit message>")
> 
> FWIW, I use this shell alias to generate these references:
> 
>   gsr is aliased to `git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
> 
>   $ gsr fb51ccb
>   fb51ccbf217c ("PCI: Rework config space blocking services")
> 
> Documentation/process/submitting-patches.rst mentions a 12-char (at
> least) SHA-1 but the e21d2170f36 example shows a *20*-char SHA-1,
> which seems excessive to me.
> 
> I personally skip the word "commit" because I figure it's pretty
> obvious what it is, but it's fine either way.
> 
> Bjorn

This is very useful! I definitely like the use of the alias. Thank you!

-Kelsey
