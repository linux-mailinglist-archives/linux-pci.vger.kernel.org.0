Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D4F1AC8F
	for <lists+linux-pci@lfdr.de>; Sun, 12 May 2019 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfELODQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 May 2019 10:03:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELODP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 May 2019 10:03:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so11737152wrr.13
        for <linux-pci@vger.kernel.org>; Sun, 12 May 2019 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zfzjLuVD+6xxt9wpoY7JOTo4QllwmFNlQrbIdPFDh9Q=;
        b=WMFF7EhqYT8cMep2EuUBPnpIwYOMoo1cbgnppVKY/TN7dBNCVlqYfDlOfQldRCbDka
         nIu9+8IAN0v6nXTL5BQwusiBomTAKLP1DHdi/Q4WPWh6sEM/NfXg+nFXaKtMJKp6kban
         peYUR8ryquglvr22PXbc5ZlFKjbgtKrHKfTQl1ciwPy9mxugJGI/L+rVfK4++YpGrdCd
         Jx9uuqVorqFtuXX+GzRVkEOjTvHseiZDUnJzYMXhGL3JkN+iP8jy9/MhiVrcQWEDzaLG
         d4vBieZaoOKNdeaOvu0a36b/BXVGxK+lXzMpS4+oEKBeNeN07niYxcBgN2DOQv2QTAoR
         gNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zfzjLuVD+6xxt9wpoY7JOTo4QllwmFNlQrbIdPFDh9Q=;
        b=UOSBQrdm3OSzlL3zRAtn/kfSeT1KavM6ol5iLwyoLerlFTdIhp3IRpPt5b/wiv0Qar
         gW9Tjqu3klb3ky9yDGT5CJGMT50eAJFTWm+br1+gZgpHjUoli2snu9Sw/gLV7hXI/6Kk
         3D0gi70fwAYyX1iyFWtFYVki9zTrv7Sx7i519QMCr46X2WXgnE59Bj0i7mCgAfvr0TkR
         Pvw/5cwjVX5id4jhpz0Wyze+vKh+UtLp3YiBLKyxAfzJPFHHbDxZfcpF+nVm6sgE0Aa4
         FMxoU7Gv747DO94REDX63+fmNLP9bdJXCx+mRE444hDCTGeqoBXiK+qHJ+YTfRe8EW/6
         gIoQ==
X-Gm-Message-State: APjAAAW+mf+/hg7/WVjP5x/vxYsui5rffPd/HwixgT8reycUfILLXx4Y
        c4xnEqib1cGGIGE9GASuMkDWXYB2y4w=
X-Google-Smtp-Source: APXvYqwhIPiNqZu+r8LpN4qevCl7hkhQF55zNPrNyuY8Vba6RgfXTfa7dgEqfr1PXGvqZvgQHxaUOQ==
X-Received: by 2002:adf:9042:: with SMTP id h60mr14074109wrh.248.1557669794176;
        Sun, 12 May 2019 07:03:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3? (p200300EA8BD457009C2751D89ED5DAD3.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:9c27:51d8:9ed5:dad3])
        by smtp.googlemail.com with ESMTPSA id s3sm17676366wre.97.2019.05.12.07.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 07:03:13 -0700 (PDT)
Subject: Re: [PATCH RFC v2 3/3] PCI/ASPM: add sysfs attribute for controlling
 ASPM
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
 <773b6a8a-00ac-a275-c80b-d5909ca58f19@gmail.com>
 <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4370c154-7e0b-26ac-4660-bb254cef7425@gmail.com>
Date:   Sun, 12 May 2019 16:03:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d8e271e0-d83f-14f9-00d6-ad63a56d8959@fredlawl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12.05.2019 03:02, Frederick Lawler wrote:
> Evening,
> 
> Heiner Kallweit wrote on 5/11/19 10:33 AM:> +static ssize_t aspm_disable_link_state_show(struct device *dev,
[..]
> 
> Since we're introducing a new sysfs interface, would it be more appropriate to rename the sysfs files to aspm_set_link_state (or something to that effect)?
> 
> The syntax as it stands, means that to enable a state, a double negative must be used:
> 
> echo "-L1.1" > ./aspm_disable_link_state"
> vs
> echo "+L1.1" > ./aspm_set_link_state
> 
> If we avoid the double negative, the documentation about to be written will be more clear and use of the sysfs file will be more intuitive.
> 
In addition to these more formal parts: Can you test the functionality?

> Thanks,
> Frederick Lawler
> 
> 
Heiner
