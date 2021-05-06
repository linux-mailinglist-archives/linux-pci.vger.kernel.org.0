Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F57375C47
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 22:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEFUfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 16:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhEFUfg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 16:35:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1661F600D4;
        Thu,  6 May 2021 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620333277;
        bh=Sqi4Tdpwz7nT0tyQ8mIVThOQmBZysPmzYclltUuxGJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qa82z228AOuGIxGWhBophz2aTHpe6GpORzN78y8e7+tsxCxdYw3XG3yFFI4Svuavj
         GGrBiQsTcV5Kvz9uiFRf3ceKvhK4eYuaWoqNpDt6prlEYnMVoTMiMMf2BhPKVYtH+h
         DhffyZn3EePsCRbUB5cVDVomrGswinMpz9x93uRSSIWmoytZ0olK3VBAicXuukm0Mx
         bV0s6hrE7ZNrGvtYdjlFR+MGyc6R6TJm969hIw7a4aPg2mhV+09VOjYbb2Ss6m6MIz
         VroV1NzcfqMsbVSk6Ghqvyr31cknRwdNYlqbSkRwlp9JNYtp+iG+A48hSrv13MmfH6
         DayJ9gqfIT4sA==
Date:   Thu, 6 May 2021 15:34:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     bhelgaas@google.com, linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pci: convert faraday,ftpci100 to yaml
Message-ID: <20210506203435.GA1432800@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503185228.1518131-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 03, 2021 at 06:52:27PM +0000, Corentin Labbe wrote:
> Converts pci/faraday,ftpci100.txt to yaml.
> Some change are also made:
> - example has wrong interrupts place

I think it's nicer when content changes are in a separate patch from
format conversion patches.  Otherwise it's really hard to see the
content changes in the patch.

Maybe a preliminary patch could fix whatever is actually broken?

Rob suggested a bunch of things that could be dropped.  Maybe those
could be removed in a second preliminary patch before the conversion?
Or maybe the removals are only possible *because* of the conversion?
I'm not a yaml expert.

Bjorn
