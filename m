Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5521034CD92
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhC2KDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:03:39 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:51067 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231959AbhC2KDU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 06:03:20 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 12TA335d021555;
        Mon, 29 Mar 2021 12:03:03 +0200
Date:   Mon, 29 Mar 2021 12:03:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH v8 5/5] FIX driver
Message-ID: <20210329100303.GA21530@1wt.eu>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
 <20405596c759cf6cabca83e7a9cd90113fbea557.1617011282.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20405596c759cf6cabca83e7a9cd90113fbea557.1617011282.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 11:51:38AM +0200, Gustavo Pimentel wrote:
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Please make an effort, this is in no way an acceptable commit description
for a patch. The subject is already extremely vague "FIX driver" with no
context at all, and there is no description of the intent here. What is
someone supposed to think about the risk of keeping or reverting it if a
bisect section would end on this one ?

Thanks,
Willy
