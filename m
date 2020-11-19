Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE02B973F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKSQCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 11:02:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgKSQCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 11:02:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id d12so6912861wrr.13;
        Thu, 19 Nov 2020 08:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FqJuuO3oFn6sc/Mabmp5niVjk2ercB6QBinOywxH+ks=;
        b=l5+aqI5yDwJ/ehm5eiYYZkPLj3ODVOJmhoeibWh7pNCreBML5+Y3rsgFk5/bZrNKhJ
         azMWSKdONkVMGlRlyOK2LCRSabCz+c8/9d2XUkh6v3dFwsYzhikpw+0lfSzrFGmEI3Gn
         vTJU1dXIilipjz2OqnqRL0zAdKhyj2AfUcnRel1iKXESgrjmvWbUB+B5lvC3txl5uPqH
         haqt1KyDsYRrh9BFq5INl8KJEi97rY7r7O4XVrYQHN4lhUNkKEYaJ62VDDKuo1vA2Hag
         aCI5nkbGM+6r/QmaE9yiy5zzGebyQ8awo8BKL80fq4xhzP2EfGjwzKY8w0xP27QVC9Ip
         RhRA==
X-Gm-Message-State: AOAM530TbJVlaRDtHjBZ154HDAyQV/9b3oCW0829qquy4XMBpT8sLoBu
        WJbkRMW+NG7tEEsLz/8vtgxeUF7/ZR8SKj827/w=
X-Google-Smtp-Source: ABdhPJyqXkX+sDUCwwrazynaCVBYxhiPLqFOBXd9WLXRmj9HZ2tPiUn4Fzs2uZyXy90b6V2FfuCYDA==
X-Received: by 2002:a5d:518e:: with SMTP id k14mr10966143wrv.253.1605801757038;
        Thu, 19 Nov 2020 08:02:37 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h17sm300396wrp.54.2020.11.19.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:02:36 -0800 (PST)
Date:   Thu, 19 Nov 2020 17:02:35 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Jisheng.Zhang@synaptics.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: fix error return code in dw_pcie_host_init()
Message-ID: <X7aXG6kC5zZWlpqg@rocinante>
References: <20201117064142.32903-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117064142.32903-1-wanghai38@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hai,

Thank you for taking care about this.

On 20-11-17 14:41:42, Wang Hai wrote:

I would have to ask you to capitalise the first letter in the subject
line as it has been done for other patches.  Check Git history to see
what it normally would look like.

> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

The above commit message was taken from the first patch, and might not
be accurate any more.  As now you are passing an error code from the
dma_mapping_error() function rather than just setting the ret variable.

Also, the ret variable might have either undetermined value or some
other value from previous assignment, not necessarily 0 there.

Krzysztof
