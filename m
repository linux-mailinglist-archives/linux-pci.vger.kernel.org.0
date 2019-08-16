Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E871190310
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHPNbu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 09:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfHPNbu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 09:31:50 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28922086C;
        Fri, 16 Aug 2019 13:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565962309;
        bh=MttKe0yp/T1sDIDthL7yI1Dis6PQYbgmffNkmTOfatI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kn7n9FRwaRPPoxR93SNO+a6ImoR7ukr/jjPj2drzk1PO+MAH4mSmWrIYpr9zCdCMJ
         gBbHLMuNBh6E/dJX8HsEfCwm638l6iPKD43eSe2lvChzbpJG1kUX3j7LoITJvpGgy/
         1b74thu+9+ZXv/oaViO3vx7QPtztw1SHc3QqaPN4=
Date:   Fri, 16 Aug 2019 08:31:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Denis Efremov <efremov@linux.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] x86/PCI: Loop using PCI_STD_NUM_BARS
Message-ID: <20190816133147.GM253360@google.com>
References: <20190816092437.31846-1-efremov@linux.com>
 <20190816092437.31846-4-efremov@linux.com>
 <alpine.DEB.2.21.1908161131400.1873@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908161131400.1873@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 11:32:41AM +0200, Thomas Gleixner wrote:
> On Fri, 16 Aug 2019, Denis Efremov wrote:
> 
> > Refactor loops to use 'i < PCI_STD_NUM_BARS' instead of
> > 'i <= PCI_STD_RESOURCE_END'.
> 
> Please describe the WHY not the WHAT. I can see the WHAT from the patch
> itself, but I can't figure out WHY.

Good point; the WHY is to use idiomatic C style and avoid
the fencepost error of using "i < PCI_STD_RESOURCE_END"
when "i <= PCI_STD_RESOURCE_END" is required, e.g.,
2f686f1d9bee ("PCI: Correct PCI_STD_RESOURCE_END usage")

Denis, can you include something along those lines in the next
version?
