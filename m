Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE47A35B89E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 04:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhDLC0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Apr 2021 22:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235857AbhDLC0O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 11 Apr 2021 22:26:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F9FF61220;
        Mon, 12 Apr 2021 02:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618194357;
        bh=ygVQ9Xov8gCh8P3x13TvGNtKzL6vb9tUs8RuMeOGtEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ld1dcr+YotIdgcyxAXQ9c8bmrRo3q7+4fmhv8OlE8yXeUYQwTxu59BiCujaJfs0Sp
         /V0LGxFwF9khr8AdTgWQDjHYSRccnw7Ul03958NbQrQTYOGK/zvrB1n519GJPks6fL
         8dAiu4dmyLOZy68L8oKmQT+Ze/yR7Yi3Do210+OtuH3NbOPO+fprEG7rSFj255Y5nw
         ViOn0NW3sw/VkJk4V7KmdHdituI3LKxemEQlmNt7zdrN3tqjGYKzy/lXQZW4ZCv+h0
         uWLLqhHAA5y4B6hRzAVSYHnNuCOrocAGu5BZnLemIkKats0IF2dJZ2NXNYIVJqL1FX
         BituO7xS61inA==
Date:   Sun, 11 Apr 2021 20:25:55 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210412022555.GA41644@C02WT3WMHTD6>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
 <20210410151709.yb42uloq3aiwcoog@pali>
 <20210410162622.GA23381@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410162622.GA23381@wunner.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 10, 2021 at 06:26:22PM +0200, Lukas Wunner wrote:
> 
> 1.5 sec is definitely too long.  This sounds like a quirk of this
> specific hardware.  Try to find out if the hardware can be configured
> differently to respond quicker.

While 1.5 sec is long, pcie spec's device control 2 register has an option to
be even longer: up to 64 seconds for a config access timeout! I'm not sure of
the reasoning to allow something that high, but I think the operating system
would be not be too happy with that.
