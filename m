Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310D91B6C38
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 05:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXDzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 23:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgDXDzv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 23:55:51 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6292076C;
        Fri, 24 Apr 2020 03:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587700551;
        bh=M/xcZ70Q6vrTm+3OsghrylM7YDJbkTidI6pxDRceNOI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FAeLqMwNHdMspAlA9+GutiF6BgymNQQMa9jqgR2oTMuce/wWkD7WUDvsepf3ndw9+
         klGdo7FFWZxlCXunEF+Rr0pS7FrTpKhheA8yRkzYvMhPgx/VW1vwvp8jK9uYcKx2Ty
         QJMM5KRkrflMeJPly0lQxjFoidi0QPWisNcTSEvA=
Date:   Thu, 23 Apr 2020 22:55:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [GIT PULL] PCI fixes for v5.7
Message-ID: <20200424035549.GA37906@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424032305.GA32366@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 23, 2020 at 10:23:05PM -0500, Bjorn Helgaas wrote:
> Yeah.  I don't know the history of why we skip PCI_CLASS_NOT_DEFINED.
> I did consider about the fact that we're skipping it, to make it
> easier to debug next time.

I did consider *warning* about ...
