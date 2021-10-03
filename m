Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B414203E0
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhJCUP6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhJCUP5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Oct 2021 16:15:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95866C0613EC;
        Sun,  3 Oct 2021 13:14:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p13so28411863edw.0;
        Sun, 03 Oct 2021 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RlS0v3/Rhlf3ts75tCU+bjZnRbKsqMQBA94Qzb/r/xs=;
        b=CC+Mi9BoczOtWghdFEfFfYoZU2BCYTjx1L1Gx4pY0rC5I8wQ0dD9OjUbIZy8i+QZP5
         dB0SNXNBXHU+SnV5k4MuEV0KbMuRDSaif1Agy563c2lTweyXn8M9Y4ScUFroldGrMC+0
         5e31UZuiQW3yuGIpMa9vY+nqko+voDN5Co9scrAZfW7OZjSNrRybE1sSnJUpFJHeuRWK
         Sl9WAipKNC3Qw03rotmZ+ugZCx/jU/UyOhvOOY7e7owxT70NlIC/YWc6YU/mwrjl/sKe
         EvYdMYX3x5HNIGQQe9SnQD/0q+PGyW9WN2Djge4GaE1lIX4KTUfKfK1YVezpVl9IwY8B
         JDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RlS0v3/Rhlf3ts75tCU+bjZnRbKsqMQBA94Qzb/r/xs=;
        b=1cxrmepgBfPrzMGEyiPdiESLJ6Spa4oARspRsT4H/fXPqizXuN+RS2D3+vWyFlksmj
         Aqjm//4KSmyRVyxFdsjSaoCAG+uqigklBu3+CFyYZXwW5yPYKUKaQn3206XZ4Bb+VLIj
         SViZns8IK4i/8tsx2RlCaPeNijKLQTDnwuMAo4bg3LsbXUKtClNbKoBvbHpa/9HRb2z0
         U43SPnH6p7wSlfUm8HUm5mlJuyM+OZ4tM85yWNLebc/TnXajOuXSBMJyuT0I1VHS6Kbm
         M7uEp0OOpjfQHO/VF5xxyjgYlsQxrnGOG7QIM0ngzdZj+xvJJogObGpReAJCwGc/XOn7
         /GpQ==
X-Gm-Message-State: AOAM531sHq/cdCJ+BtHrTQSalebD/gcaNvwL4TYAsE9MclmJP+na+oUh
        UC1yeFyB1yzXiqy2OWs/ex6BdWSNNds=
X-Google-Smtp-Source: ABdhPJy+4s6eEX7JvBs7hlLuxUNVhz/OLNv/vWxNn1GCq22LKuedbNlbm+zDWONLDD5iIxbKvHJDsw==
X-Received: by 2002:a50:e009:: with SMTP id e9mr13070257edl.254.1633292048113;
        Sun, 03 Oct 2021 13:14:08 -0700 (PDT)
Received: from ?IPv6:2001:981:6fec:1:c4f3:8ed5:bdee:bf6c? ([2001:981:6fec:1:c4f3:8ed5:bdee:bf6c])
        by smtp.gmail.com with ESMTPSA id u4sm5585605ejc.19.2021.10.03.13.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 13:14:07 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] PCI: PM: Simplify and unify some helper functions
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1800633.tdWV9SEqCh@kreacher> <7312660.EvYhyI6sBW@kreacher>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <fe9b4f36-0b46-f8d7-4a4c-9bdefe1fbd90@gmail.com>
Date:   Sun, 3 Oct 2021 22:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7312660.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Op 29-09-2021 om 20:05 schreef Rafael J. Wysocki:
> Hi All,
> 
> This series is on top of the linux-next branch from linux-pm.git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> 
> which should be included in linux-next.
> 
> Two of the 3 patches in this series, [1-2/3], were included in the "PCI: ACPI:
> Get rid of struct pci_platform_pm_ops and clean up code" series:
> 
>   https://lore.kernel.org/linux-acpi/1800633.tdWV9SEqCh@kreacher/
> 
> and the remaining one, [3/3] is a new version of a problematic patch from that
> series.  The rest of that series is present in the git branch above.
> 
> All of the 3 patches in this set need to be tested in order to verify that
> there are no more issues that need to be addressed in them.
> 
> Ferry, please test!

This is how I tested:
3 patches from 
https://patchwork.kernel.org/project/linux-acpi/patch/2793105.e9J7NaK4W3@kreacher/ 
on top of 5.15.0-rc2 as before
4 patches from v2 in the order of linux-pm.git
then tested without, with 1/3, 1+2/3, 1+2+3/3 on top (with only 3/3 the 
new patch, 1+2/3 taken from v2 as they are unchanged).

In all 4 cases I didn't find any trouble (related to this patch).

Thanks for doing this!

> Thanks!
> 
> 
> 
> 

