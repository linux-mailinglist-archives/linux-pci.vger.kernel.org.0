Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB9377C55
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 08:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEJGhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 02:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhEJGhd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 02:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E7C06175F
        for <linux-pci@vger.kernel.org>; Sun,  9 May 2021 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=52A6frhU+bjPJjiOvpl1ZLQ9T/OGI0DwqKqJnUNEWZI=; b=AH3xQ1CJ7Ysm1TjZiYucSiFA+b
        g3UBHZw+s84KWM2L9RTEA0dB9xlZWkTkHY8w144okDliP7MPqHIWs0WSe7Zq6MwkyTdCmflA1QT52
        ihtrdnoAggBgTvjS/hB1C4PKybvinsqBroqrEWwRLTJ5ihQJNPJqrSagTOoiJsKQq3C1dU+d3Rslf
        0XlkCjs2ZSm5tHWnGP6oDE6E9YxaAaX3qeZOYxCJwkYmT3NrP8uiuo8U0TQHKSfCsKWXwe4Jb+L7o
        hEhq2Fae9k7bDJPwzQ9qeFoouyB3qiDwnBtUIS0T05JA61TW0Jys4xx2kQaI2j6ZdajmPTY7tY3rR
        fsqhh/IA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfzWU-005mCt-NZ; Mon, 10 May 2021 06:36:14 +0000
Date:   Mon, 10 May 2021 07:36:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/VPD: Use unaligned access helpers in pci_vpd_read
Message-ID: <YJjUWulw8vkscdwg@infradead.org>
References: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5719b91c-9f91-0029-0a28-386f1cb29d31@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 08, 2021 at 12:29:15AM +0200, Heiner Kallweit wrote:
> +
> +		if (len == 4)  {
> +			put_unaligned_le32(val, buf);
> +		} else {
> +			cpu_to_le32s(&val);
> +			memcpy(buf, (u8 *)&val + skip, len);

cpu_to_le32s is a horrible API that breaks endianess annotations.

Is the intent of this code to only put 16 bits in?  Why not something
like:

		switch (len) {
		case 4:
			put_unaligned_le32(val, buf);
			break;
		case 2:
			put_unaligned_le16(val, buf + 2);
			break;
		case 1:
			buf[3] = val;
			break;
  		}
