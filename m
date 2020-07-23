Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F1822B3F9
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgGWQ4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 12:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQ4Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jul 2020 12:56:24 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 974C520771;
        Thu, 23 Jul 2020 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595523384;
        bh=QzNz5N9knNp0NU8WBehWXu9CFvfAqGqwcIuXq6/RgZE=;
        h=Date:From:To:Cc:Subject:From;
        b=Dr4kmxJU7FCSyvkH5Jjo5hMvRCB9RbiSoER8/L2uX/J3Z4zK1JpxGUeCGttpX21QA
         AdN3bX8v2QpEOF9SwJ5f1MKoe0xahMf4YnPtO/NK1/e4n0557ybScciHCnfX2Z5sLK
         dBocPhQlXJf92ySxZIlNBkezpy/rvMG36wXLH52w=
Date:   Thu, 23 Jul 2020 11:56:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ricky Wu <ricky_wu@realtek.com>, Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Ettle <james@ettle.org.uk>, Len Brown <lenb@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rtsx_pci not restoring ASPM state after suspend/resume
Message-ID: <20200723165622.GA1413555@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

James reported this issue with rtsx_pci; can you guys please take a
look at it?  https://bugzilla.kernel.org/show_bug.cgi?id=208117

There's a lot of good info in the bugzilla already.

Bjorn
