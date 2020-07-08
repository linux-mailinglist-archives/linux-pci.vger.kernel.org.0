Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D74D218B38
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbgGHP3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 11:29:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgGHP3p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jul 2020 11:29:45 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2C2206DF;
        Wed,  8 Jul 2020 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594222185;
        bh=6hC9q30c9xDVnYxxYrDilxDgNczb3ORs+r460OBIP+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EGgrfeI1EHAMtzzo0VWnxrsOGD8etT8bhWKCIpI2OttNouB4ynv9fsWvY8v4yeJjF
         0nrbav2LQGzecA9opJiEg/cBGfSS045Psa5zQqmfVCYoNfOar+GfN0/oyRjS7fce1t
         Z0r+zjLKxcvjOWPo1ICgPjlDi8pp+fzA2ui6rcKE=
Date:   Wed, 8 Jul 2020 10:29:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     wang.yi59@zte.com.cn
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, liao.pingfang@zte.com.cn
Subject: Re: [PATCH] PCI: Replace kmalloc with kzalloc in the comment/message
Message-ID: <20200708152942.GA454574@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007081722099680673@zte.com.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 05:22:09PM +0800, wang.yi59@zte.com.cn wrote:
> Hi Bjorn,
> 
> Thanks for your review and patience on the datails :)
> 
> > On Fri, May 29, 2020 at 09:01:59AM +0800, Yi Wang wrote:
> > > From: Liao Pingfang <liao.pingfang@zte.com.cn>
> > >
> > > Use kzalloc instead of kmalloc in the comment/message according to
> > > the previous kzalloc() call.
> > >
> > > Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> >
> > I would be happy to apply this, but this needs to show a connection
> > between Liao Pingfang and Yi Wang.
> >
> > Ideally this patch would be sent directly by Liao Pingfang.  The
> > sender should at least appear in the Signed-off-by chain.  See
> > Documentation/process/submitting-patches.rst
> 
> According to our company security policy, only a few people have
> access to send email outside of company, so this patch is sent by
> Yi Wang and the author is Liao Pingfang actually.

Please take a look at Documentation/process/submitting-patches.rst.
Specifically, it says:

  Notably, the last Signed-off-by: must always be that of the
  developer submitting the patch.

You are submitting the patch, but you didn't add a Signed-off-by.

Of course, adding your Signed-off-by means you are agreeing to the
"Developer's Certificate of Origin" (also in that file), which tells
me that the patch is licensed correctly and that you have the right to
submit it.

In addition, your signed-off-by means that if there are issues with
the patch, I will look to you (and Liao Pingfang, obviously) to help
resolve them.

So if that is all acceptable to you, just post this again with your
own signed-off-by below Liao Pingfang's.

Bjorn
