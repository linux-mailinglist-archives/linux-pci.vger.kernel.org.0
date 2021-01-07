Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743D2EEA02
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 00:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbhAGXyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 18:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAGXyd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 18:54:33 -0500
X-Greylist: delayed 698 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jan 2021 15:53:52 PST
Received: from spam.moreofthesa.me.uk (moreofthesa.me.uk [IPv6:2001:8b0:897:1651::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9862BC0612F4
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 15:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moreofthesa.me.uk; s=201708; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+a3oh3wC3I221Ztlf7urGUM58XE28rfJHOe9CwssR00=; b=EUnmdP2WZgqI/FebH6B5R7oFN
        /r7sb4BSqhIRgyXLxBMsn42kArDpHJlLyp9J4cA7B6dZzoBVV/6STdnypuA67ZKfc/4uWPEcOZWHg
        KWgHFfotQ2YG+L1TcIfOHFcPK2nGLsmXTnbBBkNl/r6PZcloIXKh8or9qnV1ozYfyA3VaJmzjfyYZ
        BTkx44vTpXvb4aVdQoM3J1/HOaXSY63t2VGm8jxoldSxu0QFsLeUOSO3rtdqhIvYDbyBn59zwu+Xd
        MNIA/CEBq1TkpfTjL7CsJlXoZzd/Jt3rAYPeGyZY48x4wgswNiVUlSnXqj2iO2HhnKK8o9hnSPOjK
        KItTGW89A==;
Received: from [2001:8b0:897:1650::2]
        by spam.moreofthesa.me.uk with esmtp (Exim 4.92)
        (envelope-from <devspam@moreofthesa.me.uk>)
        id 1kxeun-0008SP-AH; Thu, 07 Jan 2021 23:42:01 +0000
Date:   Thu, 07 Jan 2021 23:31:36 +0000
From:   Darren Salt <devspam@moreofthesa.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <nirmoy.das@amd.com>, <bhelgaas@google.com>,
        <ckoenig.leichtzumerken@gmail.com>, <linux-pci@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <christian.koenig@amd.com>
Subject: Re: [PATCH 2/4] PCI: Add pci_rebar_bytes_to_size()
Message-ID: <58F0BFBCD0%devspam@moreofthesa.me.uk>
In-Reply-To: <20210107211757.GA1391831@bjorn-Precision-5520>
References: <20210107211757.GA1391831@bjorn-Precision-5520>
Mail-Followup-To: <helgaas@kernel.org>, <nirmoy.das@amd.com>,
 <bhelgaas@google.com>, <ckoenig.leichtzumerken@gmail.com>, 
 <linux-pci@vger.kernel.org>, <christian.koenig@amd.com>,
 <devspam@moreofthesa.me.uk>, <dri-devel@lists.freedesktop.org>
User-Agent: Messenger-Pro/2.73.6.4250 (Qt/5.11.3) (Linux-x86_64)
X-No-Archive: no
X-Orwell-Date: Thu, 13187 Dec 1984 23:31:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 2001:8b0:897:1650::2
X-SA-Exim-Mail-From: devspam@moreofthesa.me.uk
X-SA-Exim-Scanned: No (on spam.moreofthesa.me.uk); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I demand that Bjorn Helgaas may or may not have written...

>> +static inline int pci_rebar_bytes_to_size(u64 bytes)
>> +{
>> +	bytes = roundup_pow_of_two(bytes);
>> +	return max(ilog2(bytes), 20) - 20;

> This isn't returning a "size", is it?  It looks like it's returning the
> log2 of the number of MB the BAR will be, i.e., the encoding used by the
> Resizable BAR Control register "BAR Size" field.  Needs a brief comment to
> that effect and/or a different function name.

Given that, it seems to me that pci_rebar_size_to_bytes should be similarly
commented and/or renamed.
