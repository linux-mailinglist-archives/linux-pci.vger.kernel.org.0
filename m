Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23B0B31DE
	for <lists+linux-pci@lfdr.de>; Sun, 15 Sep 2019 21:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfIOTsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 15:48:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfIOTsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Sep 2019 15:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FHC/cyI11fcBqOeULhlqC5WFX/E6SlCRTb0STc8WVhM=; b=BEkK6Kfeut6a+qhG7i4ODVWAR
        kbMiXuIcJLQ/8G9dH3/JsYxxVbnen8YSOTdeys/h4T5nJRov6jRX9PSpzoGyJVcsjGTmDWdCmW0Aq
        5g2V4cSDEFW09vW8eQ5eqCGGp1aRB3jr3cWw76pH1d9unXmgv/q+n7RjfPb1fatL0FYkxcRxlkyHZ
        jgiGSbD8tltjnG/7Sz7wam8QgztI6DOkFDownKXmMWgo3mS6tKU9IZxJC9UAQ/dTv++iSKuK8FlkG
        GLMWrGfBjxc1i4E/fGvTrv4NO8X5z8xQoPk51g6IfdDwnKhqc4hPW4SW9KJaV6pRQg6aSZHltObTi
        Pfd1Umiig==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9aVi-0000N9-05; Sun, 15 Sep 2019 19:48:38 +0000
Subject: Re: pci: endpoint test BUG
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <5d9eda26-fb92-063e-f84d-7dfafe5d6b29@infradead.org>
 <20190915163930.GX1131@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b80bed82-26b3-2ad5-79bc-e3f805e0c6c9@infradead.org>
Date:   Sun, 15 Sep 2019 12:48:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915163930.GX1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/15/19 9:39 AM, Al Viro wrote:
> On Sun, Sep 15, 2019 at 09:34:37AM -0700, Randy Dunlap wrote:
>> Kernel is 5.3-rc8 on x86_64.
>>
>> Loading and removing the pci-epf-test module causes a BUG.
> 
> Ugh...  Could you try to reproduce it on earlier kernels?
> 

Sure... will get back to you.

-- 
~Randy
