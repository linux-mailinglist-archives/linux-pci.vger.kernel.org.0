Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49EC8102D05
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSTwH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 14:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726892AbfKSTwH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 14:52:07 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ABA222DC;
        Tue, 19 Nov 2019 19:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574193127;
        bh=Dx/RbVspBQhDjNXYtTuVzSuF1M6po71LUEwjGlynMM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zGFheukLahWwEbQMRW1GKTdM25Vs92hQNlYvYxij4D7WS1Ll8eZWBrz/H7RfwX/RM
         uxjN6vzQHOjKVIohCxdiQMopfhJH83eWGUFSg5t/lLB5y2vV2It2P3DZoaCGTxyCRm
         W1dy168FUcZHAE+phxbct0BTZyzQiHeAigmM+5Kw=
Date:   Tue, 19 Nov 2019 13:52:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/AER: Fix AER/sysfs sriov_numvfs deadlock in
 pcie_do_recovery()
Message-ID: <20191119195205.GA210735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfaaa34-3d3d-ad9a-4e24-4be97e85d216@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 04:57:30PM +0800, Jay Fang wrote:
> On 2019/11/15 6:39, Bjorn Helgaas wrote:
> > On Fri, Sep 06, 2019 at 10:33:58AM +0800, Jay Fang wrote:
> >> A deadlock triggered by a NONFATAL AER event during a sysfs "sriov_numvfs"
> >> operation:
> > 
> > How often does this happen?  Always?  Only when an AER event races
> > with the sysfs write?
> Although not very frequent,the impact is fatal. This bug is very
> necessary to be fixed.

Absolutely; I didn't mean to suggest that we shouldn't fix it.  I only
wanted to know how to prioritize it against other issues.

Bjorn
