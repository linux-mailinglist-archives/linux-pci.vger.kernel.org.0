Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01047256255
	for <lists+linux-pci@lfdr.de>; Fri, 28 Aug 2020 23:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgH1VEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Aug 2020 17:04:30 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:42370 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1VE3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2020 17:04:29 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2020 17:04:29 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id 9FD4A282AC2; Fri, 28 Aug 2020 22:56:28 +0200 (CEST)
Date:   Fri, 28 Aug 2020 22:56:28 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Decode 10-Bit Tag Requester Enable
Message-ID: <mj+md-20200828.205604.86207.nikam@ucw.cz>
References: <1596266480-52789-1-git-send-email-liudongdong3@huawei.com>
 <20200828164931.GA2161257@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828164931.GA2161257@bjorn-Precision-5520>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> And we have a bit of a mess in the names here.  There are a bunch of
> "PCI_EXP_DEV2_*" names that would be "PCI_EXP_DEVCTL2_*" if they
> followed the convention.  You didn't start that trend, so I'm just
> pointing it out in case you or Martin want to clean it up.  When I add
> names I try to use the same name between the Linux kernel source [1]
> and lspci.

Yes, could you please clean it up?

Otherwise it's OK.

					Martin
