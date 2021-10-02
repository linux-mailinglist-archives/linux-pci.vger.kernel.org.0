Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4062A41FCE8
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 17:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhJBQBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 12:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhJBQBm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 12:01:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B56261A58;
        Sat,  2 Oct 2021 15:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633190396;
        bh=r5CLcFytEsB39CQqbUfFqtdEBCKXE6lCh/UIkKS5vUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=q0lLSUECLCtw9NFfFXbo9oK/eQik0rHu3QBF/euvXMVBTqKS7W8xk9n/tfEn2IO7H
         KRwm1m2T04DvF8TqieAt/oTmLZFjG3zdJWaEcVb2lP2ogELtV7nqQ2hdFDaJ1dodvS
         LZk3Uvo5/E7d/q7j9mjAFuKdFd3QX8N17RX7rJiHR+zkpmtne6Pv6Hc18otHEVq/hR
         HIwJkIXOqMCVI4ww9niTJYCqiqFcqDgbxPwObK4qeKXMyP+PegvIYk4qOLAL4010K2
         pOUg8dBkV/H5VXkZrW7W1i43lpIuKlVQOes0/dPuu6K4ZLTLD2R/LwGt65HGQYghUe
         d0AiKdXdq8tNw==
Date:   Sat, 2 Oct 2021 10:59:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-host: Remove unneeded includes
Message-ID: <20211002155953.GA971127@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54bed9a0e6991490ddb2b07e5abfaf40a7a62928.1633090577.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seems overkill to mention "rcar" and "pci" twice in the subject.  We
have so far not distinguished pcie-rcar-host.c and pcie-rcar-ep.c in
subject lines.

If we want to start doing that consistently, maybe we could use "PCI:
rcar-host:" and "PCI: rcar-ep:" as we have done for cadence-ep and
designware-ep.

On Fri, Oct 01, 2021 at 02:16:43PM +0200, Geert Uytterhoeven wrote:
> Remove includes that are not needed, to speed up (re)compilation.
> ...
