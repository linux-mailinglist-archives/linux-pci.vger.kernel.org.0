Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D198D18232E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgCKUQL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 16:16:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:53016 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgCKUQL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 16:16:11 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 38CAE536;
        Wed, 11 Mar 2020 20:16:10 +0000 (UTC)
Date:   Wed, 11 Mar 2020 14:16:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fix pointers to io-mapping.rst and
 io_ordering.rst files
Message-ID: <20200311141609.40a9da1c@lwn.net>
In-Reply-To: <c0205119db4fef536272cb0a183b6c14c2c8bf4c.1583927470.git.mchehab+huawei@kernel.org>
References: <c0205119db4fef536272cb0a183b6c14c2c8bf4c.1583927470.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Mar 2020 12:51:17 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Those files got moved, but cross-references still point to the
> wrong places.
> 
> Fixes: fcd680727157 ("Documentation: Add io-mapping.rst to driver-api manual")
> Fixes: d1ce350015d8 ("Documentation: Add io_ordering.rst to driver-api manual")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Sigh...applied, thanks, sorry you had to fix these.

jon
