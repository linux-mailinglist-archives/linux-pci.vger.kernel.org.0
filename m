Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8B40BB9F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Sep 2021 00:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhINWe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbhINWew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 18:34:52 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E216C061787;
        Tue, 14 Sep 2021 15:33:30 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mQGzY-0006y8-8S; Tue, 14 Sep 2021 18:33:28 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id E6B4056008F; Tue, 14 Sep 2021 18:33:27 -0400 (EDT)
Date:   Tue, 14 Sep 2021 18:33:27 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Linux 5.15-rc1
Message-ID: <20210914223327.GA14422@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20210914215543.GA1437800@bjorn-Precision-5520>
 <4f0aa389-439a-750d-a9ac-1b24ae74aacf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0aa389-439a-750d-a9ac-1b24ae74aacf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 15, 2021 at 12:06:33AM +0200, Heiner Kallweit wrote:

 > > What do you think of the following?  (This is a diff from v5.15-rc1.)
 > > 
 > 
 > This looks very good to me.

fwiw, I tested this too, and it still works.

	Dave
