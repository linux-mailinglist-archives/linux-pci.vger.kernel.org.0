Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48545BD3E7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiISRhH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiISRgr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 13:36:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F386A422E3
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 10:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F2A6B81EF3
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 17:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C2AC433D6;
        Mon, 19 Sep 2022 17:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663609003;
        bh=jkG4891B6GGZ69slhjyKEIVhWBcQm0wrOpbVVV9al2I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ewlo5IFi+88Flt1dhLw8XuNbkGXLKNgaWtJC2D9VSc6zsRz4ZYKdziHPscpKaN4ab
         QjyVNbY/FmT61DQlTP03v4eaqZSD1Y+yCghSA26b8qMgwReuQST8H2rC+DRJRG+Jgb
         mH78puWJ/B7CxX3k4fVZoM9TdF6hu7NNlVpNlkg85uKvmMh8w/JAKM7CL2YcXjLhHK
         nQxM/J1veU7fxTHRU2YLggaomJ+v907QRAJ4SyNATa7BT2pCKlPr4qShEyhdvlE6o6
         6rRrAkVq2r574bbKYGoOuhpS7dAE7CSUojWuVIoNhea0ZKdUsLXfQDOz6xPbRnweRj
         2UjVOAvnqy/xw==
Date:   Mon, 19 Sep 2022 12:36:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     Liang He <windhl@126.com>, jgross@suse.com,
        virtualization@lists.linux-foundation.org,
        jailhouse-dev@googlegroups.com, mark.rutland@arm.com,
        jan.kiszka@siemens.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, wangkelin2023@163.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] jailhouse: Hold reference returned from of_find_xxx
 API
Message-ID: <20220919173641.GA1014673@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0069849b-e6c7-5c9b-4b52-5aa6e4a328e4@csail.mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 10:25:31PM -0700, Srivatsa S. Bhat wrote:
> [ Adding author and reviewers of commit 63338a38db95 again ]
> 
> On 9/16/22 2:00 AM, Liang He wrote:
> > In jailhouse_paravirt(), we should hold the reference returned from
> > of_find_compatible_node() which has increased the refcount and then
> > call of_node_put() with it when done.
> > 
> > Fixes: 63338a38db95 ("jailhouse: Provide detection for non-x86 systems")
> > Signed-off-by: Liang He <windhl@126.com>
> > Co-developed-by: Kelin Wang <wangkelin2023@163.com>
> > Signed-off-by: Kelin Wang <wangkelin2023@163.com>
> 
> Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

The message to which you are responding didn't make it to the mailing
list, so it's unlikely that anybody will pick it up.  See the archive:
https://lore.kernel.org/all/0069849b-e6c7-5c9b-4b52-5aa6e4a328e4@csail.mit.edu/

Maybe it was a multipart message or was HTML, which the mailing lists
reject: http://vger.kernel.org/majordomo-info.html

Bjorn
