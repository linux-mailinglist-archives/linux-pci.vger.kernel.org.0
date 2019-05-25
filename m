Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1592A28F
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2019 05:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEYDY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 23:24:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56674 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEYDY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 23:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=deYuWwVEMDx9F2BngHYcJsyLMkvbKf//OE69QqYwX9Y=; b=I9KkUanwg6WfwkWup0o0Ly/SVM
        Ao/p0qI1tVg/HmlWcLPVGHBbzPuAMDbb3yuQRJ57VeiyxYDI5Yh6rhMliNzK3hkNQyT4/Ct5mv/ez
        KaOoEoyviE4WsMQxc4UiFckxLd+MMZP12HrD9C4MMrbtsO/G8dpu/++Mm1UAGs9aRjL2BsIj/hcnC
        hpjLLfwyJUcCOxGgh43urhrzTuTussOdDRo6XP/oqw8AP+g1KymdcORY6bJtNrsTEy8j6glkJhSGA
        vU2MhWV1/KzgSlHEO6S5vtaTMf+71s7IuWSc/uEK/c3yOFH0TR3fSU+og0uCnhhMHOC1OPcDaXjPi
        Wwy7b+5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUNIE-0001Fb-W2; Sat, 25 May 2019 03:24:23 +0000
Subject: Re: `SATA_AHCI` not selected by default with `make olddefconfig`
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
References: <c2733e6e-2b45-9311-1a90-67c0b814a01b@molgen.mpg.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91d3b405-1da0-fe89-14d3-f45043167822@infradead.org>
Date:   Fri, 24 May 2019 20:24:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c2733e6e-2b45-9311-1a90-67c0b814a01b@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/10/19 6:43 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> There were some PCI Kconfig changes, which seem to cause problems
> with components depending on PCI. With the attached minimal config,
> running `make olddefconfig` on Linux 4.20 and older caused
> `SATA_AHCI` to be selected. But, with Linux 5.0-rc1 it is not
> selected.
> 
> 
> Kind regards,
> 
> Paul

[adding linux-pci for posterity]

Hi Paul,

I guess this is called progress.  Anyway, it's good that you noticed and
reported it.


In 4.20 (and earlier), PCI defaults to y.
As you hint, in 5.x, PCI does not default to y, so Kconfig symbols that
depend on PCI will not be set/enabled by "make olddefconfig", including
SATA_AHCI even though SATA_AHCI is set in your old .config file.


-- 
~Randy
