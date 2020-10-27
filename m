Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E648D29A5D6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgJ0HwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:52:20 -0400
Received: from casper.infradead.org ([90.155.50.34]:33814 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbgJ0HwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 03:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QpSn6rVmBADq+LVc5dj6aNDyf3z8Z/Up4qmHSS7sdMI=; b=fOqq+19m6ngxDbZjFNqTu3mfpi
        cy7dlsYgekZqZwtjptm+G/wCLLIdZ9ldm/nXZjM/5aLDMLgbNdVlIh3Ps/LuQYnT/qrl9XWJuTW3k
        nMXJPZx/yxaRAXftni8G/d/wOBAHblh5AzenfCjUUZBTbBoUkowsBrfw/Uh8iqDodGXxVrEvsDWPE
        43wEiPQM0JX3J3sXBJsm5/KvOaFhW9y8yNDnyklSfpBP5IY2GJTSctdrE8SkNPkvCiVnAGm9kSjb7
        TNdFcaLkYl4MsZZmEi1Jqw8T77Svm6oqiqv6yMYYZyK8F0iTwDJi7i7asgpOfdqA30GAlWJG642mS
        Yq6iSuAg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXJmD-00083C-UD; Tue, 27 Oct 2020 07:52:17 +0000
Date:   Tue, 27 Oct 2020 07:52:17 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, hch@infradead.org
Subject: Re: [PATCH v2] PCI: check also dynamic IDs for duplicate in
 new_id_store()
Message-ID: <20201027075217.GA30879@infradead.org>
References: <20201026035710.593-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026035710.593-1-zhenzhong.duan@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 11:57:10AM +0800, Zhenzhong Duan wrote:
> When a device ID data is writen to /sys/bus/pci/drivers/.../new_id,
> only static ID table is checked for duplicate and multiple dynamic ID
> entries of same kind are allowed to exist in a dynamic linked list.
> 
> Fix it by calling pci_match_device() which checks both dynamic and static
> IDs.
> 
> After fix, it shows below result which is expected.
> 
> echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> echo "1af4:1000" > /sys/bus/pci/drivers/vfio-pci/new_id
> -bash: echo: write error: File exists
> 
> Drop the static specifier and add a prototype to avoid build error.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
