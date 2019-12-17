Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AED0122FD8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 16:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfLQPMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 10:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:53044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbfLQPMu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 10:12:50 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D782146E;
        Tue, 17 Dec 2019 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576595569;
        bh=lXKJlNQ3+DU4bpWWhzdm1tStVSt+54Yjgk12RqnteFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WR/W9yMAR8mCOXtOv0whHOf8AjX7OVRFHK48XZ5INi/1WgFPI4S4YkMikTQn0XkGz
         hklTlzSSMLsEk2l87P5Pfyoi+iS9xBEjzMbJvvpNEAvlP8+1RkMxIlNi2kq2eXWQph
         NvPhMeVV+RF5t2hatovhGAbDphQ7bN0VXnbZAe6Q=
Date:   Tue, 17 Dec 2019 09:12:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Message-ID: <20191217151248.GA165530@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> Hi all,
> 
> Since last time:
> 	Reverse Christmas tree for a couple of variables
> 
> 	Changed while to whilst (sounds more formal, and so that 
> 	grepping for "while" only brings up code)
> 
> 	Made sure they still apply to latest Linux v5.5-rc1
> 
> Kind regards,
> Nicholas
> 
> Nicholas Johnson (4):
>   PCI: Consider alignment of hot-added bridges when distributing
>     available resources
>   PCI: In extend_bridge_window() change available to new_size
>   PCI: Change extend_bridge_window() to set resource size directly
>   PCI: Allow extend_bridge_window() to shrink resource if necessary

I have tentatively applied these to pci/resource for v5.6, but I need
some kind of high-level description for why we want these changes.

The commit logs describe what the code does, and that's good, but we
really need a little more of the *why* and what the user-visible
benefit is.  I know some of this was in earlier postings, but it seems
to have gotten lost along the way.

Bjorn
