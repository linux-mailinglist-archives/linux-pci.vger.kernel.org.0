Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6054E3B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFYME1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:04:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34805 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfFYME1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 08:04:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so12452600lfa.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2019 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dF0IbJavBkDmedpj3yJyJEczStf0zljEZ8y8GfrnLNo=;
        b=hZRADPizKg59OjucPBI3M0TUhnj8/1G1RIWD4zZbMQjcz8KM4CL4S+r66k1z7jRWqY
         I+Qsw9vnUgoKZVK8z74l0ZwEZ5FmjLRHeGGsz2YpjdwS6dSEYMH82ElW4689vbo/7B61
         sanDevh+OlBX3C5KyD8iujyOd0GaUoLg7N5JQMUQnTZeeavqf5yX2ij6+bFa3rBhevya
         rNWGq4ASu/C5OhvTm03GcPSKRhVjdzDfIo4aY4rYi+JYYofnvMvEUp7VUaszHQJhU2A9
         O5VUYsLKjJKuzh4LzmqbVJpqGwIzi0iwVRrHIy4tX84EfC2KAcgbeCoMlE7BLOEHRuNZ
         q/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dF0IbJavBkDmedpj3yJyJEczStf0zljEZ8y8GfrnLNo=;
        b=Ot5PKTvIJ55pRRv5u7U/yXUsat2zzAiORcNx6qD3PgKouF04bpt9mm52Q4QVurGG9L
         oKuCrypDywztALqmnn5n8YgimxJ82bwOw8LfMhkQfjl+/ZaNQPXQeLfyLvtJ69USP08Y
         jJ4E5tJxT7XvAF375frbe3QpV4Eks2h/kliidYQpzvXrLfFUL6jJNlFwEl0p9Fq0bF9K
         gFCX/A82vKomBPQU2nxEGbVLRfYrWP48yHMRzICarU4UnpPaZi6kOq+vdGrnHq46LirA
         o+h6TbvcCbGm48EGOoo9oMcSgsj6esVFwUpEliPBOqLzS20hn0L3hCZ8O9LKRlvcTej4
         D0iw==
X-Gm-Message-State: APjAAAWLwcoMJLP6ZqgHWkQxdE8QdK3LbpvPhE56ZROpm/D15Td1i8R7
        1VUJ4DHa8ROijfTlxuzTuOUtKQ==
X-Google-Smtp-Source: APXvYqwE0jVw8SSrbGCE55bdvMBAD//3OUaYwM0AqC52kAzrBq0+YhNc2p7IsfW9HIfpQvIyWtX8Fw==
X-Received: by 2002:a05:6512:24a:: with SMTP id b10mr77179858lfo.37.1561464265290;
        Tue, 25 Jun 2019 05:04:25 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h4sm2245272ljj.31.2019.06.25.05.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 05:04:24 -0700 (PDT)
Date:   Tue, 25 Jun 2019 04:21:48 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     arm@kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        arnd@arndb.de, linuxarm@huawei.com,
        "xuwei (O)" <xuwei5@huawei.com>,
        John Garry <john.garry@huawei.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rjw@rjwysocki.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhangyi ac <zhangyi.ac@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        jinying@hisilicon.com, huangdaode <huangdaode@hisilicon.com>,
        Tangkunshan <tangkunshan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [GIT PULL] Hisilicon fixes for v5.2
Message-ID: <20190625112148.ckj7sgdgvyeel7vy@localhost>
References: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89ef8f0-d102-7f78-f373-cbcc7faddee3@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 11:23:21AM +0100, Wei Xu wrote:
> Hi ARM-SoC team,
> 
> Please consider to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-fixes-for-5.2
> 
> for you to fetch changes up to 07c811af1c00d7b4212eac86900b023b6405a954:
> 
>   lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration (2019-06-25 09:40:42 +0100)
> 
> ----------------------------------------------------------------
> Hisilicon fixes for v5.2-rc
> 
> - fixed RCU usage in logical PIO
> - Added a function to unregister a logical PIO range in logical PIO
>   to support the fixes in the hisi-lpc driver
> - fixed and optimized hisi-lpc driver to avoid potential use-after-free
>   and driver unbind crash

Merged to fixes, thanks.


-Olof
