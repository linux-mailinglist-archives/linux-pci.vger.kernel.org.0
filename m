Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C951D7EF6
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgERQoy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbgERQoy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 12:44:54 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9689D20873;
        Mon, 18 May 2020 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820294;
        bh=0Ghw4tGhZ8iBjTWx8JwzAJG+pvvWWvoMpgDoaJooRqY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2kaOpYOOAC46jqLCWqgO31A0A0yZn0GtzM29rEl/+d8JeWCxup8mC9Gv1W116rSVT
         L0D+tFQjjw7ySc3JL3TaEIyLp0ZcCj1tL/3SLQkkVv1c/d3cSkviGdPNxn09TJv02/
         45B5RsUsDbYR6OqB12xr54VIGJsChb9xUGi1poWs=
Date:   Mon, 18 May 2020 11:44:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/3] PCI: Add basic Compute eXpress Link DVSEC decode
Message-ID: <20200518164451.GA935888@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518163523.1225643-1-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 18, 2020 at 09:35:20AM -0700, Sean V Kelley wrote:
> Changes since v1 [1]:
> 
> - Make use pci_info() and FLAG(), as in pcie_init().
> - Wrap new cxl_cap in pci_dev struct within #ifdef PCI_CXL.
> (Bjorn Helgaas)
> 
> - Added functionality for some CXL.mem and CXL.cache helper functions.
> Snoop filter helper functions along with a performance hint as
> well as a toggle for viral self-isolation mode could be implemented.
> However, in the absence of CXL devices with their associated drivers, it
> perhaps makes best sense to be in a holding pattern on this until we have
> something to exercise it with.

Right, until these add functionality we can actually use, e.g.,
drivers that call these new functions, I think we're in a holding
pattern.

Bjorn
