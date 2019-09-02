Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07BDA503A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 09:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfIBHuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 03:50:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfIBHuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 03:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NLbPkO1nBLjxjJMJLtjjfjvIrKkFYiad08Wtr6KwkSw=; b=QTN11fqUWCWaQ1Qfvv9fmTkeg
        f4Du4MFrH1JeBL/lYO4ZmvejNdqey6NA3y5cyyRlcge584lMTs3yBaKzq33D5bbzOugM4K9b2N1Lo
        m25L2EcK6DZtpdpqBmXVzn7xsRsLu51Ikl+6Xf9MMGg3cy7oF+OcIWJfCEIGH1vF5U6Nmag8Jwh2m
        Av5PwuPKTVGxS8fhTUztEdPofUkT3UYw5jibpCXaJJ6AaHv5BM1wnu7XQ4pfeXkUWsuCIJHB32jYo
        14YZcDEu6aRqCPSkafuqSYr8vyo9rnjOViyAFQhSPj9fQsY8RRe2ddJpXeKtpNQPI9oRC3cPCc9k7
        YoZc6ErOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4h6E-0005zw-La; Mon, 02 Sep 2019 07:50:06 +0000
Date:   Mon, 2 Sep 2019 00:50:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: Use GFP_ATOMIC in resource_alignment_store()
Message-ID: <20190902075006.GB754@infradead.org>
References: <20190831124932.18759-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831124932.18759-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 31, 2019 at 12:49:32PM +0000, YueHaibing wrote:
> When allocating memory, the GFP_KERNEL cannot be used during the
> spin_lock period. It may cause scheduling when holding spin_lock.
> 
> Fixes: f13755318675 ("PCI: Move pci_[get|set]_resource_alignment_param() into their callers")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 484e35349565..0b5fc6736f3f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6148,7 +6148,7 @@ static ssize_t resource_alignment_store(struct bus_type *bus,
>  	spin_lock(&resource_alignment_lock);
>  
>  	kfree(resource_alignment_param);
> -	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
> +	resource_alignment_param = kstrndup(buf, count, GFP_ATOMIC);
>  
>  	spin_unlock(&resource_alignment_lock);

Why not move the allocation outside the lock? Something like this
seems much more sensible:


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 484e35349565..fe205829f676 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6145,14 +6145,16 @@ static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
 static ssize_t resource_alignment_store(struct bus_type *bus,
 					const char *buf, size_t count)
 {
-	spin_lock(&resource_alignment_lock);
+	char *param = kstrndup(buf, count, GFP_KERNEL);
 
-	kfree(resource_alignment_param);
-	resource_alignment_param = kstrndup(buf, count, GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
 
+	spin_lock(&resource_alignment_lock);
+	kfree(resource_alignment_param);
+	resource_alignment_param = param;
 	spin_unlock(&resource_alignment_lock);
-
-	return resource_alignment_param ? count : -ENOMEM;
+	return count;
 }
 
 static BUS_ATTR_RW(resource_alignment);
