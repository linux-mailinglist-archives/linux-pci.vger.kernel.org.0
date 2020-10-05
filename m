Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55036283553
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 14:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJEMD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 08:03:29 -0400
Received: from foss.arm.com ([217.140.110.172]:45410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJEMD3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 08:03:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D7D106F;
        Mon,  5 Oct 2020 05:03:28 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B9D53F70D;
        Mon,  5 Oct 2020 05:03:27 -0700 (PDT)
Date:   Mon, 5 Oct 2020 13:03:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-pci@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@amlogic.com>
Subject: Re: [PATCH] pci: meson: build as module by default
Message-ID: <20201005120322.GA13539@e121166-lin.cambridge.arm.com>
References: <20200918181251.32423-1-khilman@baylibre.com>
 <20200928163440.GA16986@e121166-lin.cambridge.arm.com>
 <7h362wmpco.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7h362wmpco.fsf@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 02, 2020 at 11:53:27AM -0700, Kevin Hilman wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On Fri, Sep 18, 2020 at 11:12:51AM -0700, Kevin Hilman wrote:
> >> Enable pci-meson to build as a module whenever ARCH_MESON is enabled.
> >> 
> >> Cc: Yue Wang <yue.wang@amlogic.com>
> >> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> >> ---
> >> Tested on Khadas VIM3 and Khadas VIM3 using NVMe SSD devices.
> >> 
> >>  drivers/pci/controller/dwc/Kconfig     | 3 ++-
> >>  drivers/pci/controller/dwc/pci-meson.c | 8 +++++++-
> >>  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > Applied to pci/meson, thanks.
> 
> Rob pointed out that the MODULE_LICENCE wasn't the same as the SPDX
> header.  Could you squash the update below before submitting?

Hi Kevin,

done thanks.

Lorenzo
