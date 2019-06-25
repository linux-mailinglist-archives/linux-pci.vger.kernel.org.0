Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5A555A8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 19:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbfFYRQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 13:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbfFYRQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 13:16:41 -0400
Received: from localhost (c-67-161-149-27.hsd1.co.comcast.net [67.161.149.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174FE20883;
        Tue, 25 Jun 2019 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561483000;
        bh=efAZOIBCMDXaF/32mIQRuAHKfBu2BquoJ12alRwlJwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IolAeE+BylPP79XIp3wNQ9krprH9IlO+F1X08MevU9/8lIqlpyS+uxqLpoFLlx2pD
         a4Y2963fASY3Qgi7u3Ga6bIcxyfhH94dgHZxEcVT9BPXN+/RqnvCCR2mqTC0sVCtUF
         FamcdySENKzwBrV6LWfJnUPkhy22ez4FaTnv+8eI=
Date:   Tue, 25 Jun 2019 12:16:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Fangjian (Turing)" <f.fangjian@huawei.com>
Cc:     linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Bug report: AER driver deadlock
Message-ID: <20190625171639.GA103694@google.com>
References: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 11:25:44AM +0800, Fangjian (Turing) wrote:
> Hi, We met a deadlock triggered by a NONFATAL AER event during a sysfs
> "sriov_numvfs" operation. Any suggestion to fix such deadlock ?

Here's a bugzilla report for this; please reference it and this email
thread in any patches to fix it:

https://bugzilla.kernel.org/show_bug.cgi?id=203981
