Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A382F1D17
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 19:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfKFSC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 13:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732425AbfKFSC1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 13:02:27 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A977217D7;
        Wed,  6 Nov 2019 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573063347;
        bh=eWKdN8ru6T++piy7iDbmLjWjD6OLLmHmTm3seK6eKO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLQFMsOVvvBS+QhWKEnx3VuSDY58I9xWozUtTQwSZs3o/u4TaYYmN9QuZjVRPNivM
         4Wjn4QxCdaaDwjGsFidFQ1c0PL+gPnNrPsL/ZjHa8E8Iv8WypTaPHjuH0fpUl7dlrV
         Kt1+i4eMhUT3O7eR1cynH3Llzbd0HT4bMfazKYdE=
Date:   Thu, 7 Nov 2019 03:02:20 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: vmd: Reduce VMD vectors using NVMe calculation
Message-ID: <20191106180220.GB29853@redsun51.ssa.fujisawa.hgst.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <1573040408-3831-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573040408-3831-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:40:06AM -0700, Jon Derrick wrote:
> +	max_vectors = min_t(int, vmd->msix_count, num_possible_cpus() + 1);
> +	if (nvec > max_vectors)
> +		return max_vectors;

If vmd's msix vectors beyond num_possible_cpus() are inaccessible, why
not just limit vmd's msix_count the same way?
