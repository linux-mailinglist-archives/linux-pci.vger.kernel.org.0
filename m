Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A078E2313DC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgG1U2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgG1U2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 16:28:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A80C061794
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 13:28:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a8so15780932edy.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PwWWYXEb9FMT+bO0xiH8pBcK3IEIUOXh6tPKqGjlc68=;
        b=CmbOR1u3Vs0xKqOlbNiv8icLsmtc6m/doHden+kfNsp6UOycLGZYLtJyMnmj0730Ya
         X3fki7MkbhMxAgO19ogWpgr5PTTihxvRR/lNDcViC5fD4v2E5XpoTVZffLW1Gj22UIWK
         i639uMyIbvNJKwVgf2WgnDfi8NF4QWy8EvxJesul9hp2/3W1UW9Rchj3Mj+7ZtZFCWDW
         n3JyJ6ikqkgysIu4TdB5IOTNRO33nqtYoB67eGayJx+1WsNIZh2aGrn1ZCSOaoaXBH+P
         ZLLTeujC9rAOKpKxEpKYRbu6kfJWU7W+VQ9n2f5OJ4kuHEnSYtlm1pBi7GPSTEF+rx4G
         IwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PwWWYXEb9FMT+bO0xiH8pBcK3IEIUOXh6tPKqGjlc68=;
        b=p0OYTXqquxXlBa+PQI0PNPP9YPXELABonwwJD7ii9KiG4P89FqVE++6lqj+mHgL97o
         rSfTSuj1HOZN50PbvZy6GOqqco7bXXycyIlvVS4cuxt9nEfkhImYgIfsPA/Flpv3YB5v
         dMijEQl3+5pBMqjLHZ9ZLs/PMhNJ36W7YS/6lPk5gypvas9CdtHGlGhHvMs3XAHKR3hP
         uJIDk5hdj3/03XB61NgRSBknvfwtqZd3xK4D3sW7BhGEUvcCBXyixWxGi/xYskf7qCh4
         DOT1q1JM2aZ5fJUld1KuXD+IvZ0QPgXJYPIIEuhFwPa/o/pumQq+z/cwm+gF35GEEced
         3KQg==
X-Gm-Message-State: AOAM530+qlpwMyHSkg+JDdU4s1Ty6w7iQhudPS/pJNevzmmNZj/MaDIK
        jwGzGU0WyP7dSyskcGJ7F78t+z9f0Gc=
X-Google-Smtp-Source: ABdhPJwo1EynbZqCndXBIWJKredojcJmkiZ91kobRGlfXDY9Ftj3DdnJ2Ha8gIMMRqKX0M4YKVu7Pg==
X-Received: by 2002:aa7:c545:: with SMTP id s5mr27310074edr.19.1595968093884;
        Tue, 28 Jul 2020 13:28:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:908b:a51b:1175:f3b2? (p200300ea8f235700908ba51b1175f3b2.dip0.t-ipconnect.de. [2003:ea:8f23:5700:908b:a51b:1175:f3b2])
        by smtp.googlemail.com with ESMTPSA id gh24sm5685756ejb.45.2020.07.28.13.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:28:13 -0700 (PDT)
Subject: Re: pci_lost_interrupt still needed?
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20200728202126.GA1859314@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <63322b3a-3fae-2437-8359-e6f32bede850@gmail.com>
Date:   Tue, 28 Jul 2020 22:28:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728202126.GA1859314@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.07.2020 22:21, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2020 at 09:20:34PM +0200, Heiner Kallweit wrote:
>> Seems that pci_lost_interrupt() has no user. Do we still need this function?
>> Same applies for related enum pci_lost_interrupt_reason.
> 
> If there's no user, remove it.  Bonus points if you look up the
> removal of the last use.
> 
It was introduced in 2.6.27, and apparently there never has been a single user.
So I'll submit a patch to remove it.
