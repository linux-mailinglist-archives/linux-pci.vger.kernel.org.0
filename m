Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C848F77A0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKP07 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 10:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKKP04 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 10:26:56 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94072214E0;
        Mon, 11 Nov 2019 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573486016;
        bh=dO3cAd4W4hUX6czlrK5yCHQgcx7dluw+/36s4f300Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BLOZiqmghW4KGAWqxmEHwczSrvDrmo/2od/qnImY+5rqRXIWgRr0aIFlKu2ECOmX9
         kdXfvQ9pZaSehkRCROlGoe8XE7I8u4WXK1gYiubsl45LVtTzCsNIpftahBwpAMhplm
         u0EzMbEg+q7AUfgvWEp0IGADODm0l7jNd3oMBPkw=
Date:   Tue, 12 Nov 2019 00:26:50 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, helgaas@kernel.org,
        keith.busch@intel.com
Subject: Re: [Query]: PCIe Root Port Error Recovery
Message-ID: <20191111152650.GA10851@redsun51.ssa.fujisawa.hgst.com>
References: <255b77ba-13bd-c7f1-c7ab-d0e6bd398f2c@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <255b77ba-13bd-c7f1-c7ab-d0e6bd398f2c@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 11:31:59AM +0800, Yicong Yang wrote:
> hello,
> 
> I found that the root port itself is not handled in pcie_do_recovery() function
> and I noticed the commit(bfcb79f) in reset_link(), err.c writes:
> "If a Downstream Port (including a Root Port) reports an error, we assume the Port itself is reliable and we need to
> reset its downstream link"
> 
> Is it real that the root port is always reliable and
> How to recover the root ports if it do meet some errors?

It's only that the path to the port is considered accessible, nothing
more. The port managed to send a notification that the CPU received,
so we assume communication goes both ways.
